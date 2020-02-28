//////////////////////////////////////////////////////////////////////
// This file is part of Remere's Map Editor
//////////////////////////////////////////////////////////////////////

#include "main.h"

#include "raw_brush.h"
#include "settings.h"
#include "items.h"
#include "basemap.h"

//=============================================================================
// RAW brush

RAWBrush::RAWBrush(uint16_t itemid) :
	Brush()
{
	ItemType& it = g_items[itemid];
	if(it.id == 0)
		itemtype = nullptr;
	else
		itemtype = &it;
}

RAWBrush::~RAWBrush()
{
	////
}

int RAWBrush::getLookID() const
{
	if(itemtype)
		return itemtype->clientID;
	return 0;
}

uint16_t RAWBrush::getItemID() const
{
	return itemtype->id;
}

std::string RAWBrush::getName() const
{
	if(!itemtype)
		return "RAWBrush";

	if(itemtype->hookSouth)
		return i2s(itemtype->id) + " - " + itemtype->name + " (Hook South)";
	else if(itemtype->hookEast)
		return i2s(itemtype->id) + " - " + itemtype->name + " (Hook East)";
	
	return i2s(itemtype->id) + " - " + itemtype->name + itemtype->editorsuffix;
}

void RAWBrush::undraw(BaseMap* map, Tile* tile)
{
	if(tile->ground && tile->ground->getID() == itemtype->id) {
		delete tile->ground;
		tile->ground = nullptr;
	}
	for(ItemVector::iterator iter = tile->items.begin(); iter != tile->items.end();) {
		Item* item = *iter;
		if(item->getID() == itemtype->id) {
			delete item;
			iter = tile->items.erase(iter);
		} else {
			++iter;
		}
	}
}

void RAWBrush::draw(BaseMap* map, Tile* tile, void* parameter)
{
	if(!itemtype) return;

	bool b = parameter? *reinterpret_cast<bool*>(parameter) : false;
	if((g_settings.getInteger(Config::RAW_LIKE_SIMONE) && !b) && itemtype->alwaysOnBottom && itemtype->alwaysOnTopOrder == 2) {
		for(ItemVector::iterator iter = tile->items.begin(); iter != tile->items.end();) {
			Item* item = *iter;
			if(item->getTopOrder() == itemtype->alwaysOnTopOrder) {
				delete item;
				iter = tile->items.erase(iter);
			}
			else
				++iter;
		}
	}
	tile->addItem(Item::Create(itemtype->id));
}
