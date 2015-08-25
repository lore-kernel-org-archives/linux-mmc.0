From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 02/11] mmc: host: omap_hsmmc: separate setting voltage capabilities from bus power
Date: Tue, 25 Aug 2015 14:35:33 +0530
Message-ID: <1440493542-26150-3-git-send-email-kishon@ti.com>
References: <1440493542-26150-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440493542-26150-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Added a separate function to set the voltage capabilities of the host
controller. Voltage capabilities should be set only once during
controller initialization but bus power can be changed every time there
is a voltage switch and whenever a different card is inserted.
This allows omap_hsmmc_conf_bus_power to be invoked every time there
is a voltage switch.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9c13157..fd8cc81 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1821,25 +1821,34 @@ err:
 	return ret;
 }
 
+static void omap_hsmmc_set_capabilities(struct omap_hsmmc_host *host)
+{
+	u32 val;
+
+	val = OMAP_HSMMC_READ(host->base, CAPA);
+
+	/* Only MMC1 supports 3.0V */
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT)
+		val |= (VS30 | VS18);
+	else
+		val |= VS18;
+
+	OMAP_HSMMC_WRITE(host->base, CAPA, val);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
-	u32 hctl, capa, value;
+	u32 hctl, value;
 
 	/* Only MMC1 supports 3.0V */
-	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT)
 		hctl = SDVS30;
-		capa = VS30 | VS18;
-	} else {
+	else
 		hctl = SDVS18;
-		capa = VS18;
-	}
 
 	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
 	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
 
-	value = OMAP_HSMMC_READ(host->base, CAPA);
-	OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
-
 	/* Set SD bus power bit */
 	set_sd_bus_power(host);
 }
@@ -2143,6 +2152,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc->pm_caps |= mmc_pdata(host)->pm_caps;
 
+	omap_hsmmc_set_capabilities(host);
 	omap_hsmmc_conf_bus_power(host);
 
 	if (!pdev->dev.of_node) {
-- 
1.7.9.5
