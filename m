From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 1/6] mmc: omap_hsmmc: start using generic non-removable DT binding
Date: Mon, 21 Oct 2013 00:19:54 +0530
Message-ID: <1382294999-18790-2-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
 <1382294999-18790-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1382294999-18790-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, uri.y@variscite.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

add generic "non-removable" binding support for omap_hsmmc.
When ti,non-removable was added, Only OMAP platform that had eMMC was that on
OMAP4 where power to eMMC cannot be switched off without sending CMD5 sleep
command, so no_regulator_off_init was needed to get it detected during boot.
Start using generic non-removable for all removable cards which do not
have such limitation.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    4 +++-
 drivers/mmc/host/omap_hsmmc.c                      |    2 ++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 8c8908a..d15f5b2 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -17,7 +17,9 @@ Optional properties:
 ti,dual-volt: boolean, supports dual voltage cards
 <supply-name>-supply: phandle to the regulator device tree node
 "supply-name" examples are "vmmc", "vmmc_aux" etc
-ti,non-removable: non-removable slot (like eMMC)
+ti,non-removable: non-removable eMMC with always on vccq(vmmc_aux)
+ and configurable vcc(vmmc)
+non-removable: non-removable slot (like eMMC, SDIO)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
 dmas: List of DMA specifiers with the controller specific format
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6ac63df..7d2d929 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1738,6 +1738,8 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	pdata->slots[0].switch_pin = cd_gpio;
 	pdata->slots[0].gpio_wp = wp_gpio;
 
+	if (of_find_property(np, "non-removable", NULL))
+		pdata->slots[0].nonremovable = true;
 	if (of_find_property(np, "ti,non-removable", NULL)) {
 		pdata->slots[0].nonremovable = true;
 		pdata->slots[0].no_regulator_off_init = true;
-- 
1.7.5.4

