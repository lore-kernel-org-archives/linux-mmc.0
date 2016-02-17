From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 0/5] Tegra SDHCI UHS-I support
Date: Wed, 17 Feb 2016 13:55:26 +0000
Message-ID: <56C47BCE.2090309@nvidia.com>
References: <1450809664-11360-1-git-send-email-dev@lynxeye.de>
 <56C47368.4010304@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2267 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423069AbcBQNzc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2016 08:55:32 -0500
In-Reply-To: <56C47368.4010304@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org


On 17/02/16 13:19, Jon Hunter wrote:
> Hi Lucas,
> 
> On 22/12/15 18:40, Lucas Stach wrote:
>> Hi all,
>>
>> this series implements UHS-I signaling for the Tegra SDHCI host,
>> which mainly means putting a proper tuning sequence in place.
>>
>> I've tested this on Jetson TK1 and got the following speed results,
>> where mmcblk0 is the on-board eMMC and mmcblk1 is a micro SDXC card:
>>
>> Without series applied:
>> hdparm -t /dev/mmcblk0
>>  Timing buffered disk reads:  110 MB in  3.05 seconds =  36.02 MB/sec
>> hdparm -t /dev/mmcblk1
>>  Timing buffered disk reads:   56 MB in  3.01 seconds =  18.63 MB/sec
>>  
>> With series applied:
>> hdparm -t /dev/mmcblk0
>>  Timing buffered disk reads:  236 MB in  3.00 seconds =  78.58 MB/sec
>> hdparm -t /dev/mmcblk1
>>  Timing buffered disk reads:  102 MB in  3.04 seconds =  33.51 MB/sec
>>
>> Tegra 30 does support UHS-I speeds too, but currently has problems
>> when lowering the card voltage, which is needed in order to switch
>> to UHS-I signaling. I have some more patches to fix this, but they
>> need a bit more cleanup, with them applied the gains on Tegra30 are
>> similar to the results above.
>>
>> For now the gains are limited to Tegra124+, with no regressions on
>> Tegra30 and Tegra20.
>>
>> V2 fixes some minor style problems and is rebased on top of mmc/next.
>> This means it enables the same tuning logic on Tegra210 also. I
>> don't have a way to test this myself, so any testing on Tegra210 much
>> appreciated.
> 
> I have recently noticed that on my tegra114-dalmore-a04, SD cards are no
> longer recognised on boot. It appears that the problem started after
> this series was merged.
> 
> On tegra114 I see:
> 
> [    1.777006] mmc0: error -110 whilst initialising SD card
> 
> If I disable the UHS-I changes then it works again (see below). I am
> guessing you don't have a tegra114 board to test on? I have not had time
> to look into this further, but I am not sure if we should disable UHS-I
> on tegra114 for now?

The diff got truncated somewhere along the lines, it should have been:

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 83c4bf7bc16c..bc7a0847e316 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -147,10 +147,16 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	/* Advertise UHS modes as supported by host */
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR50;
+	else
+		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR50;
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
+	else
+		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_DDR50;
 	if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
 		misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
+	else
+		misc_ctrl &= ~SDHCI_MISC_CTRL_ENABLE_SDR104;
 	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 
 	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
@@ -315,6 +321,32 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.write_w    = tegra_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset      = tegra_sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+};
+
+static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
+	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
+		  SDHCI_QUIRK_NO_HISPD_BIT |
+		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+	.ops  = &tegra114_sdhci_ops,
+};
+
+static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
+	.pdata = &sdhci_tegra114_pdata,
+};
+
+static const struct sdhci_ops tegra124_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
+	.read_w     = tegra_sdhci_readw,
+	.write_w    = tegra_sdhci_writew,
+	.write_l    = tegra_sdhci_writel,
+	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = tegra_sdhci_set_bus_width,
 	.reset      = tegra_sdhci_reset,
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
@@ -322,7 +354,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.get_max_clock = tegra_sdhci_get_max_clock,
 };
 
-static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
+static const struct sdhci_pltfm_data sdhci_tegra124_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
@@ -330,11 +362,11 @@ static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-	.ops  = &tegra114_sdhci_ops,
+	.ops  = &tegra124_sdhci_ops,
 };
 
-static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
-	.pdata = &sdhci_tegra114_pdata,
+static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
+	.pdata = &sdhci_tegra124_pdata,
 	.nvquirks = NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_DDR50 |
 		    NVQUIRK_ENABLE_SDR104,
@@ -357,7 +389,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra114 },
+	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
 	{ .compatible = "nvidia,tegra114-sdhci", .data = &soc_data_tegra114 },
 	{ .compatible = "nvidia,tegra30-sdhci", .data = &soc_data_tegra30 },
 	{ .compatible = "nvidia,tegra20-sdhci", .data = &soc_data_tegra20 },

