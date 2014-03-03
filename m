From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH RESEND] mmc: omap_hsmmc: support more DT properties
Date: Mon,  3 Mar 2014 22:16:16 +0100
Message-ID: <1393881376-10751-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: balajitk@ti.com, chris@printf.net
Cc: linux-mmc@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This should probably be done implicitly through mmc_of_parse(), but that
doesn't play well along with the multi-slot model the hsmmc driver
features. Hence, for now, do it manually. The properties are already
documented in Documentation/devicetree/bindings/mmc/mmc.txt.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Acked-by: Balaji T K <balajitk@ti.com>
---
This is a resend of a patch that was already acked by Balaji T K:

  http://www.spinics.net/lists/linux-mmc/msg25029.html


 drivers/mmc/host/omap_hsmmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2815de6..a5a38cc 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1765,6 +1765,12 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,needs-special-hs-handling", NULL))
 		pdata->slots[0].features |= HSMMC_HAS_HSPE_SUPPORT;
 
+	if (of_find_property(np, "keep-power-in-suspend", NULL))
+		pdata->slots[0].pm_caps |= MMC_PM_KEEP_POWER;
+
+	if (of_find_property(np, "enable-sdio-wakeup", NULL))
+		pdata->slots[0].pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+
 	return pdata;
 }
 #else
-- 
1.8.5.3

