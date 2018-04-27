From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 12/14] mmc: sdhci-omap: Add sdhci_omap specific ops for enable_sdio_irq
Date: Fri, 27 Apr 2018 17:17:21 +0530
Message-ID: <20180427114723.2687-13-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add sdhci_omap_enable_sdio_irq to set CTPL and CLKEXTFREE bits in
MMCHS_CON register required to detect asynchronous card interrupt
on DAT[1].

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index b11c846dd8a1..bd5e03d177e0 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -36,6 +36,7 @@
 #define CON_DDR			BIT(19)
 #define CON_CLKEXTFREE		BIT(16)
 #define CON_PADEN		BIT(15)
+#define CON_CTPL		BIT(11)
 #define CON_INIT		BIT(1)
 #define CON_OD			BIT(0)
 
@@ -226,6 +227,23 @@ static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
 	}
 }
 
+static void sdhci_omap_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
+	if (enable)
+		reg |= (CON_CTPL | CON_CLKEXTFREE);
+	else
+		reg &= ~(CON_CTPL | CON_CLKEXTFREE);
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
+
+	sdhci_enable_sdio_irq(mmc, enable);
+}
+
 static inline void sdhci_omap_set_dll(struct sdhci_omap_host *omap_host,
 				      int count)
 {
@@ -962,6 +980,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
 	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
+	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
 
 	ret = sdhci_setup_host(host);
 	if (ret)
-- 
2.17.0
