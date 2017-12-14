From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/12] mmc: sdhci-omap: Add tuning support
Date: Thu, 14 Dec 2017 18:39:33 +0530
Message-ID: <20171214130941.26666-5-kishon@ti.com>
References: <20171214130941.26666-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:22192 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbdLNNM1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Dec 2017 08:12:27 -0500
In-Reply-To: <20171214130941.26666-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com

MMC tuning procedure is required to support SD card
UHS1-SDR104 mode and EMMC HS200 mode.

SDR104/HS200 DLL Tuning Procedure for AM572x platform is mentioned
in Figure 25-51. SDR104/HS200 DLL Tuning Procedure of
AM572x Sitara Processors Silicon Revision 2.0, 1.1 TRM
(SPRUHZ6I - October 2014–Revised April 2017 [1]).

The tuning function sdhci_omap_execute_tuning() will only be
called by the MMC/SD core if the corresponding speed modes
are supported by the OMAP silicon which is set in the mmc
host "caps" field.

[1] -> http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 130 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8f7239e2edc2..df8a0a472996 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -37,6 +37,13 @@
 #define CON_INIT		BIT(1)
 #define CON_OD			BIT(0)
 
+#define SDHCI_OMAP_DLL		0x0134
+#define DLL_SWT			BIT(20)
+#define DLL_FORCE_SR_C_SHIFT	13
+#define DLL_FORCE_SR_C_MASK	(0x7f << DLL_FORCE_SR_C_SHIFT)
+#define DLL_FORCE_VALUE		BIT(12)
+#define DLL_CALIB		BIT(1)
+
 #define SDHCI_OMAP_CMD		0x20c
 
 #define SDHCI_OMAP_PSTATE	0x0224
@@ -66,12 +73,16 @@
 
 #define SDHCI_OMAP_AC12		0x23c
 #define AC12_V1V8_SIGEN		BIT(19)
+#define AC12_SCLK_SEL		BIT(23)
 
 #define SDHCI_OMAP_CAPA		0x240
 #define CAPA_VS33		BIT(24)
 #define CAPA_VS30		BIT(25)
 #define CAPA_VS18		BIT(26)
 
+#define SDHCI_OMAP_CAPA2	0x0244
+#define CAPA2_TSDR50		BIT(13)
+
 #define SDHCI_OMAP_TIMEOUT	1		/* 1 msec */
 
 #define SYSCTL_CLKD_MAX		0x3FF
@@ -80,6 +91,8 @@
 #define IOV_3V0			3000000		/* 300000 uV */
 #define IOV_3V3			3300000		/* 330000 uV */
 
+#define MAX_PHASE_DELAY		0x7C
+
 struct sdhci_omap_data {
 	u32 offset;
 };
@@ -204,6 +217,120 @@ static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
 	}
 }
 
+static inline void sdhci_omap_set_dll(struct sdhci_omap_host *omap_host,
+				      int count)
+{
+	int i;
+	u32 reg;
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_DLL);
+	reg |= DLL_FORCE_VALUE;
+	reg &= ~DLL_FORCE_SR_C_MASK;
+	reg |= (count << DLL_FORCE_SR_C_SHIFT);
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
+
+	reg |= DLL_CALIB;
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
+	for (i = 0; i < 1000; i++) {
+		reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_DLL);
+		if (reg & DLL_CALIB)
+			break;
+	}
+	reg &= ~DLL_CALIB;
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
+}
+
+static void sdhci_omap_disable_tuning(struct sdhci_omap_host *omap_host)
+{
+	u32 reg;
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_AC12);
+	reg &= ~AC12_SCLK_SEL;
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_AC12, reg);
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_DLL);
+	reg &= ~(DLL_FORCE_VALUE | DLL_SWT);
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
+}
+
+static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	u32 reg;
+	int ret = 0;
+	u8 cur_match, prev_match = 0;
+	u32 phase_delay = 0;
+	u32 start_window = 0, max_window = 0;
+	u32 length = 0, max_len = 0;
+	struct mmc_ios *ios = &mmc->ios;
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host;
+	struct sdhci_omap_host *omap_host;
+	struct device *dev;
+
+	pltfm_host = sdhci_priv(host);
+	omap_host = sdhci_pltfm_priv(pltfm_host);
+	dev = omap_host->dev;
+
+	/* clock tuning is not needed for upto 52MHz */
+	if (ios->clock <= 52000000)
+		return 0;
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CAPA2);
+	if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
+		return 0;
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_DLL);
+	reg |= DLL_SWT;
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_DLL, reg);
+
+	while (phase_delay <= MAX_PHASE_DELAY) {
+		sdhci_omap_set_dll(omap_host, phase_delay);
+
+		cur_match = !mmc_send_tuning(mmc, opcode, NULL);
+		if (cur_match) {
+			if (prev_match) {
+				length++;
+			} else {
+				start_window = phase_delay;
+				length = 1;
+			}
+		}
+
+		if (length > max_len) {
+			max_window = start_window;
+			max_len = length;
+		}
+
+		prev_match = cur_match;
+		phase_delay += 4;
+	}
+
+	if (!max_len) {
+		dev_err(dev, "Unable to find match\n");
+		ret = -EIO;
+		goto tuning_error;
+	}
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_AC12);
+	if (!(reg & AC12_SCLK_SEL)) {
+		ret = -EIO;
+		goto tuning_error;
+	}
+
+	phase_delay = max_window + 4 * (max_len >> 1);
+	sdhci_omap_set_dll(omap_host, phase_delay);
+
+	goto ret;
+
+tuning_error:
+	dev_err(dev, "Tuning failed\n");
+	sdhci_omap_disable_tuning(omap_host);
+
+ret:
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+	return ret;
+}
+
 static int sdhci_omap_card_busy(struct mmc_host *mmc)
 {
 	int i;
@@ -312,6 +439,8 @@ static int sdhci_omap_start_signal_voltage_switch(struct mmc_host *mmc,
 static void sdhci_omap_set_power_mode(struct sdhci_omap_host *omap_host,
 				      u8 power_mode)
 {
+	if (omap_host->bus_mode == MMC_POWER_OFF)
+		sdhci_omap_disable_tuning(omap_host);
 	omap_host->power_mode = power_mode;
 }
 
@@ -648,6 +777,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 					sdhci_omap_start_signal_voltage_switch;
 	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
 	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
+	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 
 	sdhci_read_caps(host);
 	host->caps |= SDHCI_CAN_DO_ADMA2;
-- 
2.11.0

