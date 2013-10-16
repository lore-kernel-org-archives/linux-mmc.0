From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/6] mmc: omap_hsmmc: start using generic non-removable DT binding
Date: Wed, 16 Oct 2013 20:48:22 +0530
Message-ID: <1381936707-10336-2-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59666 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758922Ab3JPPTP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Oct 2013 11:19:15 -0400
In-Reply-To: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, uri.y@variscite.com, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>

From: Sekhar Nori <nsekhar@ti.com>

add generic "non-removable" binding support for omap_hsmmc

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 +-
 drivers/mmc/host/omap_hsmmc.c                      |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 8c8908a..3b95719 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -17,7 +17,7 @@ Optional properties:
 ti,dual-volt: boolean, supports dual voltage cards
 <supply-name>-supply: phandle to the regulator device tree node
 "supply-name" examples are "vmmc", "vmmc_aux" etc
-ti,non-removable: non-removable slot (like eMMC)
+ti,non-removable: non-removable eMMC with always on vccq and configurable vcc
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
 dmas: List of DMA specifiers with the controller specific format
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6ac63df..5992048 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1738,6 +1738,9 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	pdata->slots[0].switch_pin = cd_gpio;
 	pdata->slots[0].gpio_wp = wp_gpio;
 
+	if (of_find_property(np, "non-removable", NULL)) {
+		pdata->slots[0].nonremovable = true;
+	}
 	if (of_find_property(np, "ti,non-removable", NULL)) {
 		pdata->slots[0].nonremovable = true;
 		pdata->slots[0].no_regulator_off_init = true;
-- 
1.7.5.4

