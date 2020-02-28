//////////////////////////////////////////////////////////////////////
// This file is part of Remere's Map Editor
//////////////////////////////////////////////////////////////////////

#ifndef _RME_CONTAINER_PROPS_H_
#define _RME_CONTAINER_PROPS_H_

#include "common_windows.h"

class Container;
class ContainerItemButton;

// Right-click popup menu
class ContainerItemPopupMenu : public wxMenu {
public:
	ContainerItemPopupMenu();
	virtual ~ContainerItemPopupMenu();

	void Update(ContainerItemButton* what);
};

// Container Item Button
class ContainerItemButton : public ItemButton
{
	DECLARE_EVENT_TABLE()
	public:
		ContainerItemButton(wxWindow* parent, bool large, int index, const Map* map, Item* item);
		~ContainerItemButton();

		void OnMouseDoubleLeftClick(wxMouseEvent& event);
		void OnMouseRightRelease(wxMouseEvent& event);

		void OnAddItem(wxCommandEvent& event);
		void OnEditItem(wxCommandEvent& event);
		void OnRemoveItem(wxCommandEvent& event);

		ObjectPropertiesWindowBase* getParentContainerWindow();
		Container* getParentContainer();

		void setItem(Item* item);

	private:
		static std::unique_ptr<ContainerItemPopupMenu> popup_menu;

		const Map* edit_map;
		Item* edit_item;

		size_t index;

		friend class ContainerItemPopupMenu;
};

#endif
