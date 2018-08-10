From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 4/8] mmc: tegra: Implement HS400 delay line calibration
Date: Fri, 10 Aug 2018 21:14:01 +0300
Message-ID: <1533924845-1466-5-git-send-email-avienamo@nvidia.com>
References: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924845-1466-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Implement HS400 specific delay line calibration procedure. This is a
Tegra specific procedure and has to be performed regardless whether
enhanced strobe or HS400 tuning is used.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index c0bb0f0..0ae82d3 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -56,6 +56,12 @@
 #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
 #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
 
+#define SDHCI_TEGRA_VENDOR_DLLCAL_CFG			0x1b0
+#define SDHCI_TEGRA_DLLCAL_CALIBRATE			BIT(31)
+
+#define SDHCI_TEGRA_VENDOR_DLLCAL_STA			0x1bc
+#define SDHCI_TEGRA_DLLCAL_STA_ACTIVE			BIT(31)
+
 #define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
 #define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
 
@@ -587,6 +593,24 @@ static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 trim)
 	sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
 }
 
+static void tegra_sdhci_hs400_dll_cal(struct sdhci_host *host)
+{
+	u32 reg;
+	int err;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
+	reg |= SDHCI_TEGRA_DLLCAL_CALIBRATE;
+	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
+
+	/* 1 ms sleep, 5 ms timeout */
+	err = readl_poll_timeout(host->ioaddr + SDHCI_TEGRA_VENDOR_DLLCAL_STA,
+				 reg, !(reg & SDHCI_TEGRA_DLLCAL_STA_ACTIVE),
+				 1000, 5000);
+	if (err)
+		dev_err(mmc_dev(host->mmc),
+			"HS400 delay line calibration timed out\n");
+}
+
 static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 					  unsigned timing)
 {
@@ -594,6 +618,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	bool set_default_tap = false;
 	bool set_dqs_trim = false;
+	bool do_hs400_dll_cal = false;
 
 	switch (timing) {
 	case MMC_TIMING_UHS_SDR50:
@@ -603,6 +628,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 		break;
 	case MMC_TIMING_MMC_HS400:
 		set_dqs_trim = true;
+		do_hs400_dll_cal = true;
 		break;
 	case MMC_TIMING_MMC_DDR52:
 	case MMC_TIMING_UHS_DDR50:
@@ -623,6 +649,9 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 
 	if (set_dqs_trim)
 		tegra_sdhci_set_dqs_trim(host, tegra_host->dqs_trim);
+
+	if (do_hs400_dll_cal)
+		tegra_sdhci_hs400_dll_cal(host);
 }
 
 static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
-- 
2.7.4
