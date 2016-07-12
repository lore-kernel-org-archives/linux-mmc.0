From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 2/2] mmc: tegra: Only advertise UHS modes if IO regulator is present
Date: Tue, 12 Jul 2016 14:53:37 +0100
Message-ID: <1468331617-22265-2-git-send-email-jonathanh@nvidia.com>
References: <1468331617-22265-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10155 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbcGLNxp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2016 09:53:45 -0400
In-Reply-To: <1468331617-22265-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>

To support UHS modes for Tegra an external regulator must be present
to adjust the IO voltage accordingly. Even if the regulator is not
present but the host supports the UHS modes and the device supports the
UHS modes, then we will attempt to switch to a high-speed mode. Without
an external regulator, Tegra will fail to switch to the high-speed
mode.

It has been found that with some SD cards, that once it has been switch
to operate at a high-speed mode, all subsequent commands issues to the
card will fail and so it will not be possible to switch back to a non
high-speed mode and so the SD card initialisation will fail.

The SDHCI core does not require that the host have an external regulator
when switching to UHS modes and therefore, the Tegra SDHCI host
controller should only advertise the UHS modes as being supported if the
regulator for the IO voltage is present. Fortunately, Tegra has a vendor
specific register which can be used to control which modes are
advertised via the SDHCI_CAPABILITIES register. Hence, if there is no IO
voltage regulator available for the Tegra SDHCI host, then don't
advertise the UHS modes.

Note that if the regulator is not available, we also don't advertise that
the SDHCI is compatible with v3.0 of the SDHCI specification because
this will read the SDHCI_CAPABILITIES_1 register which will enable other
UHS modes.

This fixes commit 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes") which
enables UHS mode without checking if the board can support them.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 49 +++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index bcc0de47fe7e..bd1199825f9f 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -148,28 +148,37 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 		return;
 
 	misc_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
-	/* Erratum: Enable SDHCI spec v3.00 support */
-	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
-		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
-	/* Advertise UHS modes as supported by host */
-	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
-		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
-	else
-		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR50;
-	if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
-		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
-	else
-		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_DDR50;
-	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
-		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
-	else
-		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
-	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
-
 	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+
+	misc_ctrl &= ~(SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300 |
+		       SDHCI_MISC_CTRL_ENABLE_SDR50 |
+		       SDHCI_MISC_CTRL_ENABLE_DDR50 |
+		       SDHCI_MISC_CTRL_ENABLE_SDR104);
+
 	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
-	if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
-		clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
+
+	/*
+	 * If the board does not define a regulator for the SDHCI
+	 * IO voltage, then don't advertise support for UHS modes
+	 * even if the device supports it because the IO voltage
+	 * cannot be configured.
+	 */
+	if (!IS_ERR(host->mmc->supply.vqmmc)) {
+		/* Erratum: Enable SDHCI spec v3.00 support */
+		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
+			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
+		/* Advertise UHS modes as supported by host */
+		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
+			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
+		if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
+			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
+		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
+			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
+		if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
+			clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
+	}
+
+	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
 	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
-- 
2.1.4

