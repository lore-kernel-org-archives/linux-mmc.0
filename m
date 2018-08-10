From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 23/40] mmc: tegra: Configure default trim value on reset
Date: Fri, 10 Aug 2018 21:08:25 +0300
Message-ID: <1533924522-1037-24-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Program the outbound sampling trim value in tegra_sdhci_reset(). Unlike
the outbound tap value this does not depend on the signaling mode and
needs to be only programmed once.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 208a269..7f1b0b4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -37,6 +37,8 @@
 #define SDHCI_TEGRA_VENDOR_CLOCK_CTRL			0x100
 #define SDHCI_CLOCK_CTRL_TAP_MASK			0x00ff0000
 #define SDHCI_CLOCK_CTRL_TAP_SHIFT			16
+#define SDHCI_CLOCK_CTRL_TRIM_MASK			0x1f000000
+#define SDHCI_CLOCK_CTRL_TRIM_SHIFT			24
 #define SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE		BIT(5)
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
@@ -287,7 +289,8 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 		       SDHCI_MISC_CTRL_ENABLE_DDR50 |
 		       SDHCI_MISC_CTRL_ENABLE_SDR104);
 
-	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
+	clk_ctrl &= ~(SDHCI_CLOCK_CTRL_TRIM_MASK |
+		      SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE);
 
 	if (tegra_sdhci_is_pad_and_regulator_valid(host)) {
 		/* Erratum: Enable SDHCI spec v3.00 support */
@@ -304,6 +307,8 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 			clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
 	}
 
+	clk_ctrl |= tegra_host->default_trim << SDHCI_CLOCK_CTRL_TRIM_SHIFT;
+
 	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
-- 
2.7.4
