From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 4/4] mmc: sdhci-of-arasan: overwrite enhanced strobe callback
Date: Thu,  3 Mar 2016 10:36:53 +0800
Message-ID: <1456972613-8159-1-git-send-email-shawn.lin@rock-chips.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Currently sdhci-arasan 5.1 can support enhanced strobe function,
but considering the potential requirement in the future for other
version IP, we don't limit it just for "arasan,sdhci-5.1". Add
cap-enhanced-strobe in DT to enable the function if we'r sure our
controller can support it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1e4b5e0..31f3494 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -24,7 +24,9 @@
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
+#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 
+#define VENDOR_ENHANCED_STROBE		BIT(0)
 #define CLK_CTRL_TIMEOUT_SHIFT		16
 #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
 #define CLK_CTRL_TIMEOUT_MIN_EXP	13
@@ -52,6 +54,21 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 	return freq;
 }
 
+static int sdhci_arasan_enhanced_strobe(struct sdhci_host *host, bool enable)
+{
+	u32 vendor;
+
+	vendor = readl(host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
+	if (enable)
+		vendor |= VENDOR_ENHANCED_STROBE;
+	else
+		vendor &= (~VENDOR_ENHANCED_STROBE);
+
+	writel(vendor, host->ioaddr + SDHCI_ARASAN_VENDOR_REGISTER);
+
+	return 0;
+}
+
 static struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -172,6 +189,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	sdhci_get_of_property(pdev);
 	pltfm_host->clk = clk_xin;
 
+	host->mmc_host_ops.prepare_enhanced_strobe =
+					sdhci_arasan_enhanced_strobe;
+
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
 		dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
-- 
2.3.7
