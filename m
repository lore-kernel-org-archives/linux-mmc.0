From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 3/9] mmc: sdhci-of-esdhc: add support for signal voltage switch
Date: Thu, 2 Mar 2017 17:47:24 +0800
Message-ID: <1488448050-7574-4-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0082.outbound.protection.outlook.com ([104.47.32.82]:28809
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750743AbdCBKEU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Mar 2017 05:04:20 -0500
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

eSDHC supports signal voltage switch from 3.3v to 1.8v by
eSDHC_PROCTL[VOLT_SEL] bit. This bit changes the value of output
signal SDHC_VS, and there must be a control circuit out of eSDHC
to change the signal voltage according to SDHC_VS output signal.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc.h    |  1 +
 drivers/mmc/host/sdhci-of-esdhc.c | 65 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 5343fc0..6869567 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -37,6 +37,7 @@
 
 /* Protocol Control Register */
 #define ESDHC_PROCTL			0x28
+#define ESDHC_VOLT_SEL			0x00000400
 #define ESDHC_CTRL_4BITBUS		(0x1 << 1)
 #define ESDHC_CTRL_8BITBUS		(0x2 << 1)
 #define ESDHC_CTRL_BUSWIDTH_MASK	(0x3 << 1)
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 84865b0..c2619f1 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/sys_soc.h>
@@ -559,6 +560,68 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+/* The SCFG, Supplemental Configuration Unit, provides SoC specific
+ * configuration and status registers for the device. There is a
+ * SDHC IO VSEL control register on SCFG for some platforms. It's
+ * used to support SDHC IO voltage switching.
+ */
+static const struct of_device_id scfg_device_ids[] = {
+	{ .compatible = "fsl,t1040-scfg", },
+	{ .compatible = "fsl,ls1012a-scfg", },
+	{ .compatible = "fsl,ls1046a-scfg", },
+	{}
+};
+
+/* SDHC IO VSEL control register definition */
+#define SCFG_SDHCIOVSELCR	0x408
+#define SDHCIOVSELCR_TGLEN	0x80000000
+#define SDHCIOVSELCR_VSELVAL	0x60000000
+#define SDHCIOVSELCR_SDHC_VS	0x00000001
+
+static int esdhc_signal_voltage_switch(struct sdhci_host *host,
+				       unsigned char signal_voltage)
+{
+	struct device_node *scfg_node;
+	void __iomem *scfg_base = NULL;
+	u32 sdhciovselcr;
+	u32 val;
+
+	val = sdhci_readl(host, ESDHC_PROCTL);
+
+	switch (signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		val &= ~ESDHC_VOLT_SEL;
+		sdhci_writel(host, val, ESDHC_PROCTL);
+		return 0;
+	case MMC_SIGNAL_VOLTAGE_180:
+		scfg_node = of_find_matching_node(NULL, scfg_device_ids);
+		if (scfg_node)
+			scfg_base = of_iomap(scfg_node, 0);
+		if (scfg_base) {
+			sdhciovselcr = SDHCIOVSELCR_TGLEN |
+				       SDHCIOVSELCR_VSELVAL;
+			iowrite32be(sdhciovselcr,
+				scfg_base + SCFG_SDHCIOVSELCR);
+
+			val |= ESDHC_VOLT_SEL;
+			sdhci_writel(host, val, ESDHC_PROCTL);
+			mdelay(5);
+
+			sdhciovselcr = SDHCIOVSELCR_TGLEN |
+				       SDHCIOVSELCR_SDHC_VS;
+			iowrite32be(sdhciovselcr,
+				scfg_base + SCFG_SDHCIOVSELCR);
+			iounmap(scfg_base);
+		} else {
+			val |= ESDHC_VOLT_SEL;
+			sdhci_writel(host, val, ESDHC_PROCTL);
+		}
+		return 0;
+	default:
+		return 0;
+	}
+}
+
 #ifdef CONFIG_PM_SLEEP
 static u32 esdhc_proctl;
 static int esdhc_of_suspend(struct device *dev)
@@ -603,6 +666,7 @@ static const struct sdhci_ops sdhci_esdhc_be_ops = {
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.start_signal_voltage_switch = esdhc_signal_voltage_switch,
 };
 
 static const struct sdhci_ops sdhci_esdhc_le_ops = {
@@ -620,6 +684,7 @@ static const struct sdhci_ops sdhci_esdhc_le_ops = {
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.start_signal_voltage_switch = esdhc_signal_voltage_switch,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_be_pdata = {
-- 
2.1.0.27.g96db324

