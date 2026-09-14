sap.ui.define([
  "sap/m/App",
  "sap/m/Page",
  "sap/m/SegmentedButton",
  "sap/m/SegmentedButtonItem",
  "sap/m/VBox",
  "sap/m/Text",
  "sap/ui/core/mvc/XMLView"
], function (App, Page, SegmentedButton, SegmentedButtonItem, VBox, Text, XMLView) {
  "use strict";

  let currentView;

  async function loadXmlView(xmlPath) {
    const response = await fetch(xmlPath);
    if (!response.ok) {
      throw new Error("Impossible de charger " + xmlPath + " (" + response.status + ")");
    }

    const xml = await response.text();
    return sap.ui.xmlview({ viewContent: xml });
  }

  async function showScreen(key, hostBox, infoText) {
    const map = {
      "0100": "../abap2ui5/src/dynpro-0100.view.xml",
      "0200": "../abap2ui5/src/dynpro-0200.view.xml",
      "0300": "../abap2ui5/src/dynpro-0300.view.xml"
    };

    infoText.setText("Chargement ecran " + key + "...");

    try {
      const nextView = await loadXmlView(map[key]);
      if (currentView) {
        hostBox.removeItem(currentView);
        currentView.destroy();
      }

      currentView = nextView;
      hostBox.addItem(currentView);
      infoText.setText("Ecran " + key + " affiche");
    } catch (error) {
      infoText.setText("Erreur: " + error.message);
    }
  }

  sap.ui.getCore().attachInit(function () {
    const infoText = new Text({ text: "Initialisation..." });
    const hostBox = new VBox({ width: "100%" });

    const switcher = new SegmentedButton({
      selectedKey: "0100",
      items: [
        new SegmentedButtonItem({ key: "0100", text: "Ecran 0100" }),
        new SegmentedButtonItem({ key: "0200", text: "Ecran 0200" }),
        new SegmentedButtonItem({ key: "0300", text: "Ecran 0300" })
      ],
      selectionChange: function (event) {
        const key = event.getParameter("item").getKey();
        showScreen(key, hostBox, infoText);
      }
    });

    const shell = new App({
      pages: [
        new Page({
          title: "Test navigateur - ZPUR_REQ",
          content: [switcher, infoText, hostBox]
        })
      ]
    });

    shell.placeAt("content");
    showScreen("0100", hostBox, infoText);
  });
});
