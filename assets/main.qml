import bb.cascades 1.4
import bb.data 1.0

NavigationPane {
    id: nav
    Page {
        titleBar: TitleBar {
            title: "HVL"
            selectedOption: Option {
            
            }
            scrollBehavior: TitleBarScrollBehavior.Sticky
            kind: TitleBarKind.Default
            visibility: ChromeVisibility.Visible
        }
        
        actions: [
            ActionItem {
                title: "SQ-1"
                onTriggered: {
                    lisslp.spaceQuota=1
                }
                ActionBar.placement: ActionBarPlacement.OnBar
            
            },
            ActionItem {
                title: "SQ-2"
                onTriggered: {
                    lisslp.spaceQuota=2
                }
                ActionBar.placement: ActionBarPlacement.OnBar
            }
        ]
        
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            focusPolicy: FocusPolicy.Default
            background: Color.DarkCyan
            leftPadding: 8.0
            bottomPadding: 8.0
            topPadding: 8.0
            rightPadding: 8.0
            layoutProperties: StackLayoutProperties {
                spaceQuota: 2
            }
            ListView {
                id: lis
                dataModel: theModel
                onTriggered: {
                    var chosenItem = dataModel.data(indexPath);
                    var contentpage = itemPageDefinition.createObject();

                    nav.push(contentpage);
                }
                attachedObjects: [
                    ListScrollStateHandler {
                        onFirstVisibleItemChanged: {
                            console.debug("FVIC: "+firstVisibleItem[0])
                        }
                    }
                ]
                accessibility.name: "Listing"
                scrollRole: ScrollRole.None
                snapMode: SnapMode.LeadingEdge
                layout: StackListLayout {
                    orientation: LayoutOrientation.LeftToRight
                    headerMode: ListHeaderMode.None
                }
                flickMode: FlickMode.Momentum
                listItemComponents: [
                    ListItemComponent {
                        type: "item"
                        Container {
                            id: imageView
                            minWidth: 720/3
                            maxWidth: 768/3
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Top
                            background: Color.DarkBlue
                            Label {
                                text: ListItemData.title
                                horizontalAlignment: HorizontalAlignment.Fill
                                textStyle.fontSize: FontSize.XLarge
                                textStyle.color: Color.LightGray
                            }
                            ImageView {
                                imageSource: ListItemData.image
                                loadEffect: ImageViewLoadEffect.None
                                verticalAlignment: VerticalAlignment.Fill
                                horizontalAlignment: HorizontalAlignment.Fill
                                scalingMethod: ScalingMethod.AspectFill
                                minWidth: 256
                                maxWidth: imageView.maxWidth
                            }
                            attachedObjects: [
                                LayoutUpdateHandler {
                                    onLayoutFrameChanged: {
                                        imageView.ListItem.view.updateListMaxHeight(layoutFrame.height);
                                    }
                                }
                            ]
                        }
                    }
                ]
                function updateListMaxHeight(height) {
                    console.debug(height)
                    lis.maxHeight = height + 16;
                }
                horizontalAlignment: HorizontalAlignment.Fill
                minHeight: 64
                layoutProperties: StackLayoutProperties {
                    id: lisslp
                    spaceQuota: 1.0
                }
                scrollIndicatorMode: ScrollIndicatorMode.ProportionalBar
                leadingVisual: Button {
                    text: "OK"
                }
                verticalAlignment: VerticalAlignment.Top
                locallyFocused: false
            }
            Divider {
                bottomMargin: 8.0
                topMargin: 8.0
            }
            Container {
                verticalAlignment: VerticalAlignment.Fill
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 4
                }
                Button {
                    color: Color.DarkBlue
                    text: "Button 1 2 3 4 5 6 7 8"
                }
            }
        }
    }
    attachedObjects: [
        ComponentDefinition {
            id: itemPageDefinition
            source: "ItemPage.qml"
        },
        GroupDataModel {
            id: theModel
            grouping: ItemGrouping.None
        }
    ]
    onPopTransitionEnded: {
        page.destroy();
    }
    onCreationCompleted: {
        theModel.insert({"title": "Amiga", "image": "amiga_kb.jpg" })
        theModel.insert({"title": "Atari", "image": "atari.jpg" })
        theModel.insert({"title": "C64", "image": "sidchip.jpg" })
    }
}
