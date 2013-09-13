From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/3] mmc: omap_hsmmc: remove TI specific DT binding for non removable cards
Date: Fri, 13 Sep 2013 15:39:44 +0530
Message-ID: <a62bc46e3672482d8a7c94610c4bdb020d84dfcd.1379066249.git.nsekhar@ti.com>
References: <cover.1379066249.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <cover.1379066249.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Benoit Cousson <bcousson@baylibre.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Device Tree Mailing List <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

Remove the vendor specific "ti,non-removable" DT binding and
support the generic binding "non-removable" instead.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |    5 ++---
 drivers/mmc/host/omap_hsmmc.c                           |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 8c8908a..0d463b8 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -17,7 +17,6 @@ Optional properties:
 ti,dual-volt: boolean, supports dual voltage cards
 <supply-name>-supply: phandle to the regulator device tree node
 "supply-name" examples are "vmmc", "vmmc_aux" etc
-ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
 dmas: List of DMA specifiers with the controller specific format
@@ -38,7 +37,7 @@ Examples:
 		ti,dual-volt;
 		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
-		ti,non-removable;
+		non-removable;
 	};
 
 [generic DMA request binding]
@@ -50,7 +49,7 @@ Examples:
 		ti,dual-volt;
 		bus-width = <4>;
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
-		ti,non-removable;
+		non-removable;
 		dmas = <&edma 24
 			&edma 25>;
 		dma-names = "tx", "rx";
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6ac63df..0cb06ff 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1738,7 +1738,7 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	pdata->slots[0].switch_pin = cd_gpio;
 	pdata->slots[0].gpio_wp = wp_gpio;
 
-	if (of_find_property(np, "ti,non-removable", NULL)) {
+	if (of_find_property(np, "non-removable", NULL)) {
 		pdata->slots[0].nonremovable = true;
 		pdata->slots[0].no_regulator_off_init = true;
 	}
-- 
1.7.10.1

