From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/12] mmc: sdhci-omap: Add card_busy host ops
Date: Thu, 14 Dec 2017 18:39:31 +0530
Message-ID: <20171214130941.26666-3-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

card_busy ops is used by mmc core in
  1) mmc_set_uhs_voltage to verify voltage switch
  2) __mmc_start_request/mmc_poll_for_busy to check the card busy status

While only DAT0 can be used to check the card busy status (in '2' above),
CMD and DAT[0..3] is used to verify voltage switch (in '1' above).

The voltage switching sequence for AM572x platform is mentioned
in Figure 25-48. eMMC/SD/SDIO Power Switching Procedure of
AM572x Sitara Processors Silicon Revision 2.0, 1.1 TRM
(SPRUHZ6I - October 2014–Revised April 2017 [1]).

Add card_busy host ops in sdhci_omap that checks for both CMD and
DAT[0..3]. card_busy here returns true if one of CMD and DAT[0..3] is
low though during voltage switch sequence all of CMD and DAT[0..3] has
to be low (however haven't observed a case where some DAT lines are low
and some are high).

In the voltage switching sequence, CLKEXTFREE bit in MMCHS_CON
should also be set after switching to 1.8v which is also taken
care in the card_busy ops.

[1] -> http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 96985786cadf..defe4eac020d 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -31,11 +31,20 @@
 #define SDHCI_OMAP_CON		0x12c
 #define CON_DW8			BIT(5)
 #define CON_DMA_MASTER		BIT(20)
+#define CON_CLKEXTFREE		BIT(16)
+#define CON_PADEN		BIT(15)
 #define CON_INIT		BIT(1)
 #define CON_OD			BIT(0)
 
 #define SDHCI_OMAP_CMD		0x20c
 
+#define SDHCI_OMAP_PSTATE	0x0224
+#define PSTATE_CLEV             BIT(24)
+#define PSTATE_DLEV_SHIFT	20
+#define PSTATE_DLEV_DAT(x)	(1 << (PSTATE_DLEV_SHIFT + (x)))
+#define PSTATE_DLEV		(PSTATE_DLEV_DAT(0) | PSTATE_DLEV_DAT(1) | \
+					PSTATE_DLEV_DAT(2) | PSTATE_DLEV_DAT(3))
+
 #define SDHCI_OMAP_HCTL		0x228
 #define HCTL_SDBP		BIT(8)
 #define HCTL_SDVS_SHIFT		9
@@ -191,6 +200,58 @@ static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
 	}
 }
 
+static int sdhci_omap_card_busy(struct mmc_host *mmc)
+{
+	int i;
+	u32 reg, ac12;
+	int ret = true;
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_omap_host *omap_host;
+	u32 ier = host->ier;
+
+	pltfm_host = sdhci_priv(host);
+	omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
+	ac12 = sdhci_omap_readl(omap_host, SDHCI_OMAP_AC12);
+	reg &= ~CON_CLKEXTFREE;
+	if (ac12 & AC12_V1V8_SIGEN)
+		reg |= CON_CLKEXTFREE;
+	reg |= CON_PADEN;
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
+
+	disable_irq(host->irq);
+	ier |= SDHCI_INT_CARD_INT;
+	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
+
+	for (i = 0; i < 5; i++) {
+		/*
+		 * Delay is required for PSTATE to correctly reflect
+		 * DLEV/CLEV values after PADEM is set.
+		 */
+		usleep_range(100, 200);
+		reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_PSTATE);
+		if ((reg & PSTATE_CLEV) &&
+		    ((reg & PSTATE_DLEV) == PSTATE_DLEV)) {
+			ret = false;
+			goto ret;
+		}
+	}
+
+ret:
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
+	reg &= ~(CON_CLKEXTFREE | CON_PADEN);
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
+
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+	enable_irq(host->irq);
+
+	return ret;
+}
+
 static int sdhci_omap_start_signal_voltage_switch(struct mmc_host *mmc,
 						  struct mmc_ios *ios)
 {
@@ -562,6 +623,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_omap_start_signal_voltage_switch;
 	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
+	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
 
 	sdhci_read_caps(host);
 	host->caps |= SDHCI_CAN_DO_ADMA2;
-- 
2.11.0
