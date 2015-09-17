From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v2, 8/8] mmc: sdhci-of-esdhc: add SDR50 mode support for SD/MMC Legacy Adapter Card
Date: Thu, 17 Sep 2015 13:50:54 +0800
Message-ID: <1442469054-23644-8-git-send-email-yangbo.lu@freescale.com>
References: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0147.outbound.protection.outlook.com ([157.56.111.147]:59928
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753077AbbIQGML (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 02:12:11 -0400
In-Reply-To: <1442469054-23644-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

The eSDHC is not compatible with SD spec well, so we need
to use eSDHC-special code to switch to SDR50 mode.
1. IO signal voltage switching, eSDHC uses SDHC_VS to switch
io voltage and it's needed to configure a global utilities
register SCFG_SDHCIOVSELCR(if it has) and SDHC_VS signal.
2. Before executing tuning procedure, eSDHC should set its own
tuning block.
static const struct sdhci_ops sdhci_esdhc_ops = {
	...
	.set_tuning_block = esdhc_set_tuning_block,
	.signal_voltage_switch = esdhc_signal_voltage_switch,
};

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h    |  2 ++
 drivers/mmc/host/sdhci-of-esdhc.c | 62 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index de9be18..a04b8bb 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -26,6 +26,8 @@
 
 #define ESDHCI_PRESENT_STATE	0x24
 #define ESDHC_CLK_STABLE	0x00000008
+#define ESDHC_DLSL		0x0f000000
+#define ESDHC_CLSL		0x00800000
 
 #define ESDHC_PROCTL		0x28
 #define ESDHC_VOLT_SEL		0x00000400
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 5aabadf..c887b8e 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -19,6 +19,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mmc/host.h>
+#include <linux/of_address.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
 
@@ -39,6 +40,17 @@ static u32 adapter_type;
 static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
+	u32 clsl;
+	u32 dlsl;
+
+	if (reg == SDHCI_PRESENT_STATE) {
+		ret = in_be32(host->ioaddr + reg);
+		clsl = ret & ESDHC_CLSL;
+		dlsl = ret & ESDHC_DLSL;
+		ret &= ~((ESDHC_CLSL << 1) | (ESDHC_DLSL >> 4));
+		ret |= ((clsl << 1) | (dlsl >> 4));
+		return ret;
+	}
 
 	if (reg == SDHCI_CAPABILITIES_1) {
 		ret = in_be32(host->ioaddr + ESDHC_CAPABILITIES_1);
@@ -48,6 +60,15 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
 				host->mmc->caps2 |= MMC_CAP2_HS200;
 			ret &= ~ESDHC_MODE_MASK;
 			break;
+		case ESDHC_ADAPTER_TYPE_2:
+			if (ret & ESDHC_MODE_MASK) {
+				ret &= ~ESDHC_MODE_MASK;
+				/* If it exists UHS-I support, enable SDR50 */
+				host->mmc->caps |= (MMC_CAP_UHS_SDR50 |
+						    MMC_CAP_UHS_SDR25 |
+						    MMC_CAP_UHS_SDR12);
+			}
+			break;
 		default:
 			ret &= ~ESDHC_MODE_MASK;
 		}
@@ -256,11 +277,14 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	int pre_div = 1;
 	int div = 1;
 	u32 temp;
+	int timeout;
 
 	host->mmc->actual_clock = 0;
 
-	if (clock == 0)
+	if (clock == 0) {
+		esdhc_clock_control(host, false);
 		return;
+	}
 
 	/* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
 	temp = esdhc_readw(host, SDHCI_HOST_VERSION);
@@ -298,6 +322,22 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
+	/* Wait max 20 ms */
+	timeout = 20;
+	while (!(sdhci_readl(host, ESDHCI_PRESENT_STATE) & ESDHC_CLK_STABLE)) {
+		if (timeout == 0) {
+			pr_err("%s: Internal clock never stabilised.\n",
+				mmc_hostname(host->mmc));
+			return;
+		}
+		timeout--;
+		mdelay(1);
+	}
+
+	temp |= ESDHC_CLOCK_CRDEN;
+	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
+
 	mdelay(1);
 }
 
@@ -351,9 +391,17 @@ void esdhc_set_tuning_block(struct sdhci_host *host)
 	esdhc_clock_control(host, true);
 }
 
+static const struct of_device_id scfg_device_ids[] = {
+	{ .compatible = "fsl,t1040-scfg", },
+	{}
+};
+
 void esdhc_signal_voltage_switch(struct sdhci_host *host,
 				 unsigned char signal_voltage)
 {
+	struct device_node *scfg_node;
+	void __iomem *scfg_base;
+	u32 scfg_sdhciovselcr;
 	u32 value;
 
 	value = sdhci_readl(host, ESDHC_PROCTL);
@@ -364,6 +412,18 @@ void esdhc_signal_voltage_switch(struct sdhci_host *host,
 		sdhci_writel(host, value, ESDHC_PROCTL);
 		break;
 	case MMC_SIGNAL_VOLTAGE_180:
+		scfg_node = of_find_matching_node(NULL, scfg_device_ids);
+		if (scfg_node) {
+			scfg_base = of_iomap(scfg_node, 0);
+			of_node_put(scfg_node);
+			if (scfg_base) {
+				scfg_sdhciovselcr = 0x408;
+				out_be32(scfg_base + scfg_sdhciovselcr,
+						0x80000001);
+				iounmap(scfg_base);
+			}
+		}
+
 		value |= ESDHC_VOLT_SEL;
 		sdhci_writel(host, value, ESDHC_PROCTL);
 		break;
-- 
2.1.0.27.g96db324

