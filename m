From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 6/6] mmc: sdhci-of-arasan: overwrite enhanced strobe callback
Date: Fri, 29 Apr 2016 10:48:34 +0800
Message-ID: <1461898114-29067-1-git-send-email-shawn.lin@rock-chips.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Currently sdhci-arasan 5.1 can support enhanced strobe function,
and we now limit it just for "arasan,sdhci-5.1". Add
mmc-hs400-enhanced-strobe in DT to enable the function if we'r sure
our controller can support it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/sdhci-of-arasan.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 20b859e..a0e4536 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -25,7 +25,9 @@
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
+#define SDHCI_ARASAN_VENDOR_REGISTER	0x78
 
+#define VENDOR_ENHANCED_STROBE		BIT(0)
 #define CLK_CTRL_TIMEOUT_SHIFT		16
 #define CLK_CTRL_TIMEOUT_MASK		(0xf << CLK_CTRL_TIMEOUT_SHIFT)
 #define CLK_CTRL_TIMEOUT_MIN_EXP	13
@@ -73,6 +75,23 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 		phy_power_on(sdhci_arasan->phy);
 }
 
+static int sdhci_arasan_enhanced_strobe(struct mmc_host *mmc,
+					bool enable)
+{
+	u32 vendor;
+	struct sdhci_host *host = mmc_priv(mmc);
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
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
@@ -239,6 +258,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "phy_power_on err.\n");
 			goto err_phy_power;
 		}
+
+		host->mmc_host_ops.prepare_enhanced_strobe =
+					sdhci_arasan_enhanced_strobe;
 	}
 
 	ret = sdhci_add_host(host);
-- 
2.3.7
