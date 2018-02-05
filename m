From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 01/16] mmc: sdhci-omap: Update 'power_mode' outside sdhci_omap_init_74_clocks
Date: Mon, 5 Feb 2018 18:20:14 +0530
Message-ID: <20180205125029.21570-2-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Kishon Vijay Abraham I <kishon@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Updating 'power_mode' in sdhci_omap_init_74_clocks results in
'power_mode' never updated to MMC_POWER_OFF during card
removal. This results in initialization sequence not sent to the
card during re-insertion.
Fix it here by adding sdhci_omap_set_power_mode to update power_mode.
This function can also be used later to perform operations that
are specific to a power mode (e.g, disable tuning during power off).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-omap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 628bfe9a3d17..96985786cadf 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -244,6 +244,12 @@ static int sdhci_omap_start_signal_voltage_switch(struct mmc_host *mmc,
 	return 0;
 }
 
+static void sdhci_omap_set_power_mode(struct sdhci_omap_host *omap_host,
+				      u8 power_mode)
+{
+	omap_host->power_mode = power_mode;
+}
+
 static void sdhci_omap_set_bus_mode(struct sdhci_omap_host *omap_host,
 				    unsigned int mode)
 {
@@ -273,6 +279,7 @@ static void sdhci_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	sdhci_omap_set_bus_mode(omap_host, ios->bus_mode);
 	sdhci_set_ios(mmc, ios);
+	sdhci_omap_set_power_mode(omap_host, ios->power_mode);
 }
 
 static u16 sdhci_omap_calc_divisor(struct sdhci_pltfm_host *host,
@@ -401,8 +408,6 @@ static void sdhci_omap_init_74_clocks(struct sdhci_host *host, u8 power_mode)
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_STAT, INT_CC_EN);
 
 	enable_irq(host->irq);
-
-	omap_host->power_mode = power_mode;
 }
 
 static struct sdhci_ops sdhci_omap_ops = {
@@ -504,6 +509,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	omap_host->host = host;
 	omap_host->base = host->ioaddr;
 	omap_host->dev = dev;
+	omap_host->power_mode = MMC_POWER_UNDEFINED;
 	host->ioaddr += offset;
 
 	mmc = host->mmc;
-- 
2.11.0
