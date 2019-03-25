From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 03/10] mmc: tegra: update hw tuning process
Date: Mon, 25 Mar 2019 12:38:36 +0200
Message-ID: <09e8eb96-67e4-2069-471a-79bbfe23446a@intel.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
 <1553402727-23130-3-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553402727-23130-3-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 24/03/19 6:45 AM, Sowjanya Komatineni wrote:
> This patch includes below HW tuning related fixes.
>     configures tuning parameters as per Tegra TRM
>     WAR fix for manual tap change
>     HW auto-tuning post process
> 
> As per Tegra TRM, SDR50 mode tuning execution takes upto maximum
> of 256 tuning iterations and SDR104/HS200/HS400 modes tuning
> execution takes upto maximum of 128 tuning iterations.
> 
> This patch programs tuning control register with maximum tuning
> iterations needed based on the timing along with the start tap,
> multiplier, and step size used by the HW tuning.
> 
> Tegra210 has a known issue of glitch on trimmer output when the
> tap value is changed with the trimmer input clock running and the
> WAR is to disable card clock before sending tuning command and
> after sending tuning command wait for 1usec and issue SW reset
> followed by enabling card clock.
> 
> This WAR is applicable when changing tap value manually as well.
> Tegra SDHCI driver has this implemented correctly for manual tap
> change but missing SW reset before enabling card clock during
> sending tuning command.
> 
> Issuing SW reset during tuning command as a part of WAR and is
> applicable in cases where tuning is performed with single step size
> for more iterations. This patch includes this fix.
> 
> HW auto-tuning finds the best largest passing window and sets the
> tap at the middle of the window. With some devices like sandisk
> eMMC driving fast edges and due to high tap to tap delay in the
> Tegra chipset, auto-tuning does not detect falling tap between the
> valid windows resulting in a parital window or a merged window and
> the best tap is set at the signal transition which is actually the
> worst tap location.
> 
> Recommended SW solution is to detect if the best passing window
> picked by the HW tuning is a partial or a merged window based on
> min and max tap delays found from chip characterization across
> PVT and perform tuning correction to pick the best tap.
> 
> This patch has implementation of this post HW tuning process for
> the tegra hosts that support HW tuning through the callback function
> tegra_sdhci_execute_hw_tuning and uses the tuned tap delay.
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-tegra.c | 216 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 215 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 46086dd43bfb..f1aa0591112a 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -66,6 +66,22 @@
>  
>  #define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
>  #define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
> +#define SDHCI_VNDR_TUN_CTRL0_START_TAP_VAL_MASK		0x03fc0000
> +#define SDHCI_VNDR_TUN_CTRL0_START_TAP_VAL_SHIFT	18
> +#define SDHCI_VNDR_TUN_CTRL0_MUL_M_MASK			0x00001fc0
> +#define SDHCI_VNDR_TUN_CTRL0_MUL_M_SHIFT		6
> +#define SDHCI_VNDR_TUN_CTRL0_TUN_ITER_MASK		0x000e000
> +#define SDHCI_VNDR_TUN_CTRL0_TUN_ITER_SHIFT		13
> +#define TRIES_128					2
> +#define TRIES_256					4
> +#define SDHCI_VNDR_TUN_CTRL0_TUN_WORD_SEL_MASK		0x7
> +
> +#define SDHCI_TEGRA_VNDR_TUN_CTRL1_0			0x1c4
> +#define SDHCI_TEGRA_VNDR_TUN_STATUS0			0x1C8
> +#define SDHCI_TEGRA_VNDR_TUN_STATUS1			0x1CC
> +#define SDHCI_TEGRA_VNDR_TUN_STATUS1_TAP_MASK		0xFF
> +#define SDHCI_TEGRA_VNDR_TUN_STATUS1_END_TAP_SHIFT	0x8
> +#define TUNING_WORD_BIT_SIZE				32
>  
>  #define SDHCI_TEGRA_AUTO_CAL_CONFIG			0x1e4
>  #define SDHCI_AUTO_CAL_START				BIT(31)
> @@ -97,6 +113,8 @@
>  struct sdhci_tegra_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	u32 nvquirks;
> +	u8 min_tap_delay;
> +	u8 max_tap_delay;
>  };
>  
>  /* Magic pull up and pull down pad calibration offsets */
> @@ -136,6 +154,8 @@ struct sdhci_tegra {
>  	u32 default_trim;
>  	u32 dqs_trim;
>  	bool enable_hwcq;
> +	unsigned long curr_clk_rate;
> +	u8 tuned_tap_delay;
>  };
>  
>  static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
> @@ -241,6 +261,7 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
>  
>  	if (is_tuning_cmd) {
>  		udelay(1);
> +		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  		tegra_sdhci_configure_card_clk(host, clk_enabled);
>  	}
>  }
> @@ -722,6 +743,7 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  	 */
>  	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
>  	clk_set_rate(pltfm_host->clk, host_clk);
> +	tegra_host->curr_clk_rate = host_clk;
>  	if (tegra_host->ddr_signaling)
>  		host->max_clk = host_clk;
>  	else
> @@ -770,6 +792,159 @@ static void tegra_sdhci_hs400_dll_cal(struct sdhci_host *host)
>  			"HS400 delay line calibration timed out\n");
>  }
>  
> +static void tegra_sdhci_tap_correction(struct sdhci_host *host, u8 thd_up,
> +				       u8 thd_low, u8 fixed_tap)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	u32 val, tun_status;
> +	u8 word, bit, edge1, tap, window;
> +	bool tap_result;
> +	bool start_fail = false;
> +	bool start_pass = false;
> +	bool end_pass = false;
> +	bool first_fail = false;
> +	bool first_pass = false;
> +	u8 start_pass_tap = 0;
> +	u8 end_pass_tap = 0;
> +	u8 first_fail_tap = 0;
> +	u8 first_pass_tap = 0;
> +	u8 total_tuning_words = host->tuning_loop_count / TUNING_WORD_BIT_SIZE;
> +
> +	/*
> +	 * Read auto-tuned results and extract good valid passing window by
> +	 * filtering out un-wanted bubble/partial/merged windows.
> +	 */
> +	for (word = 0; word < total_tuning_words; word++) {
> +		val = sdhci_readl(host, SDHCI_VNDR_TUN_CTRL0_0);
> +		val &= ~SDHCI_VNDR_TUN_CTRL0_TUN_WORD_SEL_MASK;
> +		val |= word;
> +		sdhci_writel(host, val, SDHCI_VNDR_TUN_CTRL0_0);
> +		tun_status = sdhci_readl(host, SDHCI_TEGRA_VNDR_TUN_STATUS0);
> +		bit = 0;
> +		while (bit < TUNING_WORD_BIT_SIZE) {
> +			tap = word * TUNING_WORD_BIT_SIZE + bit;
> +			tap_result = tun_status & (1 << bit);
> +			if (!tap_result && !start_fail) {
> +				start_fail = true;
> +				if (!first_fail) {
> +					first_fail_tap = tap;
> +					first_fail = true;
> +				}
> +
> +			} else if (tap_result && start_fail && !start_pass) {
> +				start_pass_tap = tap;
> +				start_pass = true;
> +				if (!first_pass) {
> +					first_pass_tap = tap;
> +					first_pass = true;
> +				}
> +
> +			} else if (!tap_result && start_fail && start_pass &&
> +				   !end_pass) {
> +				end_pass_tap = tap - 1;
> +				end_pass = true;
> +			} else if (tap_result && start_pass && start_fail &&
> +				   end_pass) {
> +				window = end_pass_tap - start_pass_tap;
> +				/* discard merged window and bubble window */
> +				if (window >= thd_up || window < thd_low) {
> +					start_pass_tap = tap;
> +					end_pass = false;
> +				} else {
> +					/* set tap at middle of valid window */
> +					tap = start_pass_tap + window / 2;
> +					tegra_host->tuned_tap_delay = tap;
> +					return;
> +				}
> +			}
> +
> +			bit++;
> +		}
> +	}
> +
> +	if (!first_fail) {
> +		WARN_ON("no edge detected, continue with hw tuned delay.\n");
> +	} else if (first_pass) {
> +		/* set tap location at fixed tap relative to the first edge */
> +		edge1 = first_fail_tap + (first_pass_tap - first_fail_tap) / 2;
> +		if (edge1 - 1 > fixed_tap)
> +			tegra_host->tuned_tap_delay = edge1 - fixed_tap;
> +		else
> +			tegra_host->tuned_tap_delay = edge1 + fixed_tap;
> +	}
> +}
> +
> +static void tegra_sdhci_post_tuning(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +	u32 avg_tap_dly, val, min_tap_dly, max_tap_dly;
> +	u8 fixed_tap, start_tap, end_tap, window_width;
> +	u8 thdupper, thdlower;
> +	u8 num_iter;
> +	u32 clk_rate_mhz, period_ps, bestcase, worstcase;
> +
> +	/* retain HW tuned tap to use incase if no correction is needed */
> +	val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
> +	tegra_host->tuned_tap_delay = (val & SDHCI_CLOCK_CTRL_TAP_MASK) >>
> +				      SDHCI_CLOCK_CTRL_TAP_SHIFT;
> +	if (soc_data->min_tap_delay && soc_data->max_tap_delay) {
> +		min_tap_dly = soc_data->min_tap_delay;
> +		max_tap_dly = soc_data->max_tap_delay;
> +		clk_rate_mhz = tegra_host->curr_clk_rate / USEC_PER_SEC;
> +		period_ps = USEC_PER_SEC / clk_rate_mhz;
> +		bestcase = period_ps / min_tap_dly;
> +		worstcase = period_ps / max_tap_dly;
> +		/*
> +		 * Upper and Lower bound thresholds used to detect merged and
> +		 * bubble windows
> +		 */
> +		thdupper = (2 * worstcase + bestcase) / 2;
> +		thdlower = worstcase / 4;
> +		/*
> +		 * fixed tap is used when HW tuning result contains single edge
> +		 * and tap is set at fixed tap delay relative to the first edge
> +		 */
> +		avg_tap_dly = (period_ps * 2) / (min_tap_dly + max_tap_dly);
> +		fixed_tap = avg_tap_dly / 2;
> +
> +		val = sdhci_readl(host, SDHCI_TEGRA_VNDR_TUN_STATUS1);
> +		start_tap = val & SDHCI_TEGRA_VNDR_TUN_STATUS1_TAP_MASK;
> +		end_tap = (val >> SDHCI_TEGRA_VNDR_TUN_STATUS1_END_TAP_SHIFT) &
> +			  SDHCI_TEGRA_VNDR_TUN_STATUS1_TAP_MASK;
> +		window_width = end_tap - start_tap;
> +		num_iter = host->tuning_loop_count;
> +		/*
> +		 * partial window includes edges of the tuning range.
> +		 * merged window includes more taps so window width is higher
> +		 * than upper threshold.
> +		 */
> +		if (start_tap == 0 || (end_tap == (num_iter - 1)) ||
> +		    (end_tap == num_iter - 2) || window_width >= thdupper) {
> +			pr_debug("%s: Apply tuning correction\n",
> +				 mmc_hostname(host->mmc));
> +			tegra_sdhci_tap_correction(host, thdupper, thdlower,
> +						   fixed_tap);
> +		}
> +	}
> +
> +	tegra_sdhci_set_tap(host, tegra_host->tuned_tap_delay);
> +}
> +
> +static int tegra_sdhci_execute_hw_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	int err;
> +
> +	err = sdhci_execute_tuning(mmc, opcode);
> +	if (!err && !host->tuning_err)
> +		tegra_sdhci_post_tuning(host);
> +
> +	return err;
> +}
> +
>  static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>  					  unsigned timing)
>  {
> @@ -778,17 +953,22 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>  	bool set_default_tap = false;
>  	bool set_dqs_trim = false;
>  	bool do_hs400_dll_cal = false;
> +	u8 iter = TRIES_256;
> +	u32 val;
>  
>  	tegra_host->ddr_signaling = false;
>  	switch (timing) {
>  	case MMC_TIMING_UHS_SDR50:
> +		break;
>  	case MMC_TIMING_UHS_SDR104:
>  	case MMC_TIMING_MMC_HS200:
>  		/* Don't set default tap on tunable modes. */
> +		iter = TRIES_128;
>  		break;
>  	case MMC_TIMING_MMC_HS400:
>  		set_dqs_trim = true;
>  		do_hs400_dll_cal = true;
> +		iter = TRIES_128;
>  		break;
>  	case MMC_TIMING_MMC_DDR52:
>  	case MMC_TIMING_UHS_DDR50:
> @@ -800,11 +980,25 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>  		break;
>  	}
>  
> +	val = sdhci_readl(host, SDHCI_VNDR_TUN_CTRL0_0);
> +	val &= ~(SDHCI_VNDR_TUN_CTRL0_TUN_ITER_MASK |
> +		 SDHCI_VNDR_TUN_CTRL0_START_TAP_VAL_MASK |
> +		 SDHCI_VNDR_TUN_CTRL0_MUL_M_MASK);
> +	val |= (iter << SDHCI_VNDR_TUN_CTRL0_TUN_ITER_SHIFT |
> +		0 << SDHCI_VNDR_TUN_CTRL0_START_TAP_VAL_SHIFT |
> +		1 << SDHCI_VNDR_TUN_CTRL0_MUL_M_SHIFT);
> +	sdhci_writel(host, val, SDHCI_VNDR_TUN_CTRL0_0);
> +	sdhci_writel(host, 0, SDHCI_TEGRA_VNDR_TUN_CTRL1_0);
> +
> +	host->tuning_loop_count = (iter == TRIES_128) ? 128 : 256;
> +
>  	sdhci_set_uhs_signaling(host, timing);
>  
>  	tegra_sdhci_pad_autocalib(host);
>  
> -	if (set_default_tap)
> +	if (tegra_host->tuned_tap_delay && !set_default_tap)
> +		tegra_sdhci_set_tap(host, tegra_host->tuned_tap_delay);
> +	else
>  		tegra_sdhci_set_tap(host, tegra_host->default_tap);
>  
>  	if (set_dqs_trim)
> @@ -1110,6 +1304,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>  		    NVQUIRK_ENABLE_SDR50 |
>  		    NVQUIRK_ENABLE_SDR104,
> +	.min_tap_delay = 106,
> +	.max_tap_delay = 185,
>  };
>  
>  static const struct sdhci_ops tegra186_sdhci_ops = {
> @@ -1150,9 +1346,23 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>  		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>  		    NVQUIRK_ENABLE_SDR50 |
>  		    NVQUIRK_ENABLE_SDR104,
> +	.min_tap_delay = 84,
> +	.max_tap_delay = 136,
> +};
> +
> +static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
> +	.pdata = &sdhci_tegra186_pdata,
> +	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
> +		    NVQUIRK_HAS_PADCALIB |
> +		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
> +		    NVQUIRK_ENABLE_SDR50 |
> +		    NVQUIRK_ENABLE_SDR104,
> +	.min_tap_delay = 96,
> +	.max_tap_delay = 139,
>  };
>  
>  static const struct of_device_id sdhci_tegra_dt_match[] = {
> +	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
>  	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
>  	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
>  	{ .compatible = "nvidia,tegra124-sdhci", .data = &soc_data_tegra124 },
> @@ -1251,6 +1461,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>  	host->mmc_host_ops.hs400_enhanced_strobe =
>  			tegra_sdhci_hs400_enhanced_strobe;
>  
> +	if (!host->ops->platform_execute_tuning)
> +		host->mmc_host_ops.execute_tuning =
> +				tegra_sdhci_execute_hw_tuning;
> +
>  	rc = mmc_of_parse(host->mmc);
>  	if (rc)
>  		goto err_parse_dt;
> 
