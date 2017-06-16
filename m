From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/16] mmc: host: omap_hsmmc: Separate setting voltage capabilities from bus power
Date: Fri, 16 Jun 2017 18:15:30 +0530
Message-ID: <20170616124544.15046-3-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add a separate function to set the voltage capabilities of the host
controller. Voltage capabilities should be set only once during
controller initialization but bus power can be changed every time there
is a voltage switch and whenever a different card is inserted.
This allows omap_hsmmc_conf_bus_power to be invoked every time there
is a voltage switch.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 48bb06788d9f..c9ea41bb4e3a 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1799,25 +1799,34 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
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
@@ -2124,6 +2133,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc->pm_caps |= mmc_pdata(host)->pm_caps;
 
+	omap_hsmmc_set_capabilities(host);
 	omap_hsmmc_conf_bus_power(host);
 
 	host->rx_chan = dma_request_chan(&pdev->dev, "rx");
-- 
2.11.0
