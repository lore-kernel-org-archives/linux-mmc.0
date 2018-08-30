From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 12/38] mmc: tegra: Poll for calibration completion
Date: Thu, 30 Aug 2018 18:06:13 +0300
Message-ID: <20180830150639.21048-13-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Implement polling with 10 ms timeout for automatic pad drive strength
calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 11185e96f3c3..56b637c5b594 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -50,6 +51,9 @@
 #define SDHCI_AUTO_CAL_START			BIT(31)
 #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
 
+#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
+#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
@@ -226,13 +230,21 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
-	u32 val;
+	u32 reg;
+	int ret;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
+	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 
-	mdelay(1);
+	usleep_range(1, 2);
+	/* 10 ms timeout */
+	ret = readl_poll_timeout(host->ioaddr + SDHCI_TEGRA_AUTO_CAL_STATUS,
+				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
+				 1000, 10000);
 
-	val = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
-	val |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
-	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	if (ret)
+		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
 
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
-- 
2.18.0
