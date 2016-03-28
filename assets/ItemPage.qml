import bb.cascades 1.4


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
            title: "Toggle"
            onTriggered: {
                lis.visible=!lis.visible;
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        
        },
        ActionItem {
            title: "Enable"
            onTriggered: {
                lis.enabled=!lis.enabled
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        }
    ]
    
    ScrollView {
        horizontalAlignment: HorizontalAlignment.Fill
        accessibilityMode: A11yMode.Default
        scrollViewProperties.overScrollEffectMode: OverScrollEffectMode.None
        scrollViewProperties.pinchToZoomEnabled: false
        scrollViewProperties.scrollMode: ScrollMode.Vertical
        Container {
            horizontalAlignment: HorizontalAlignment.Fill
            topPadding: 8.0
            
            ListView {
                id: lis
                visible: false
                enabled: false
                dataModel: XmlDataModel {
                    source: "data.xml"
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
                            minWidth: 720/2
                            maxWidth: 768/2
                            horizontalAlignment: HorizontalAlignment.Fill
                            verticalAlignment: VerticalAlignment.Top
                            background: Color.DarkBlue
                            Label {
                                text: ListItemData.name
                                horizontalAlignment: HorizontalAlignment.Fill
                                textStyle.fontSize: FontSize.XLarge
                                textStyle.color: Color.LightGray
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
                minHeight: 32
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
                topPadding: 16.0
                bottomPadding: 16.0
            }

            Divider {
                bottomMargin: 8.0
                topMargin: 8.0
            }
            Container {
                verticalAlignment: VerticalAlignment.Top
                horizontalAlignment: HorizontalAlignment.Fill
                DateTimePicker {
                
                }
                ProgressIndicator {
                    value: 0.0
                
                }
                Slider {
                
                }
                Divider {
                
                }
                TextField {
                
                }
                RadioGroup {
                    Option {
                        text: "Test 12"
                    }
                    Option {
                        text: "Test 34"
                    }
                    Option {
                        text: "Test 56"
                    }
                }
                Button {
                    color: Color.DarkBlue
                    text: "Button 1 2 3 4 5 6 7 8"
                }
            }
        }
    }
}


