From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 03/10] mmc: tegra: Power on the calibration pad
Date: Tue, 24 Jul 2018 17:34:19 +0300
Message-ID: <1532442865-6391-2-git-send-email-avienamo@nvidia.com>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Automatic pad drive strength calibration is performed on a separate pad
identical to the ones used for driving the actual bus. Power on the
calibration pad during the calibration procedure and power it off
afterwards to save power.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 6008e2f..61067b7 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -209,11 +209,30 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	tegra_host->ddr_signaling = false;
 }
 
+static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
+{
+	u32 reg;
+
+	/*
+	 * Enable or disable the additional I/O pad used by the drive strength
+	 * calibration process.
+	 */
+	reg = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+	if (enable)
+		reg |= SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD;
+	else
+		reg &= ~SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD;
+	sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+	udelay(1);
+}
+
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
 	unsigned timeout = 10;
 	u32 reg;
 
+	tegra_sdhci_configure_cal_pad(host, true);
+
 	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
 	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
@@ -227,6 +246,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 		timeout--;
 	} while (timeout);
 
+	tegra_sdhci_configure_cal_pad(host, false);
+
 	if (timeout == 0)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.7.4
