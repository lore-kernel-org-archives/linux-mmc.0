From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] mmc: host: sunxi: add support for A64 mmc controller
Date: Sat, 30 Jul 2016 12:29:54 +0200
Message-ID: <c3b3a172-4194-08e4-5ac9-594d77452ff5@redhat.com>
References: <20160730093652.10578-1-icenowy@aosc.xyz>
 <20160730093652.10578-2-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160730093652.10578-2-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Michal Suchanek <hramrach@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 30-07-16 11:36, Icenowy Zheng wrote:
> A64 SoC features a MMC controller which need only the mod clock, and can
> calibrate delay by itself. This patch adds support for the new MMC
> controller IP core.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Cool stuff, thanks for your work on this!

> ---
>  drivers/mmc/host/sunxi-mmc.c | 166 +++++++++++++++++++++++++++++++------------
>  1 file changed, 122 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ee4c21..ac56bcf 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -72,6 +72,14 @@
>  #define SDXC_REG_CHDA	(0x90)
>  #define SDXC_REG_CBDA	(0x94)
>
> +/* New registers introduced in A64 */
> +#define SDXC_REG_A12A		0x058 /* SMC Auto Command 12 Register */
> +#define SDXC_REG_SD_NTSR	0x05C /* SMC New Timing Set Register */
> +#define SDXC_REG_DRV_DL		0x140 /* Drive Delay Control Register */
> +#define SDXC_REG_SAMP_DL_REG	0x144 /* SMC sample delay control */
> +#define SDXC_REG_DS_DL_REG	0x148 /* SMC data strobe delay control */
> +
> +
>  #define mmc_readl(host, reg) \
>  	readl((host)->reg_base + SDXC_##reg)
>  #define mmc_writel(host, reg, value) \
> @@ -217,6 +225,15 @@
>  #define SDXC_CLK_50M_DDR	3
>  #define SDXC_CLK_50M_DDR_8BIT	4
>
> +#define SDXC_2X_TIMING_MODE	BIT(31)
> +
> +#define SDXC_CAL_START		BIT(15)
> +#define SDXC_CAL_DONE		BIT(14)
> +#define SDXC_CAL_DL_SHIFT	8
> +#define SDXC_CAL_DL_SW_EN	BIT(7)
> +#define SDXC_CAL_DL_SW_SHIFT	0
> +#define SDXC_CAL_DL_MASK	0x3f
> +
>  struct sunxi_mmc_clk_delay {
>  	u32 output;
>  	u32 sample;
> @@ -261,6 +278,9 @@ struct sunxi_mmc_host {
>
>  	/* vqmmc */
>  	bool		vqmmc_enabled;
> +
> +	/* does the IP block support autocalibration? */
> +	bool		can_calibrate;
>  };
>
>  static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
> @@ -653,10 +673,66 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  	return 0;
>  }
>
> +static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host,
> +			       struct mmc_ios *ios, int reg_off)
> +{
> +	u32 reg = readl(host->reg_base + reg_off);
> +	u32 delay;
> +
> +	reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
> +	reg &= ~SDXC_CAL_DL_SW_EN;
> +
> +	writel(reg | SDXC_CAL_START, host->reg_base + reg_off);
> +
> +	dev_dbg(mmc_dev(host->mmc), "calibration started\n");
> +
> +	while (!((reg = readl(host->reg_base + reg_off)) & SDXC_CAL_DONE))
> +		cpu_relax();
> +
> +	delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
> +
> +	reg &= ~SDXC_CAL_START;
> +	reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
> +
> +	writel(reg, host->reg_base + reg_off);
> +
> +	dev_dbg(mmc_dev(host->mmc), "calibration ended, res is 0x%x\n", reg);
> +
> +	return 0;
> +}
> +
> +static int sunxi_mmc_determine_delays(struct sunxi_mmc_host *host,
> +				      struct mmc_ios *ios, int rate)
> +{
> +	int index;
> +
> +	if (rate <= 400000) {
> +		index = SDXC_CLK_400K;
> +	} else if (rate <= 25000000) {
> +		index = SDXC_CLK_25M;
> +	} else if (rate <= 52000000) {
> +		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
> +		    ios->timing != MMC_TIMING_MMC_DDR52) {
> +			index = SDXC_CLK_50M;
> +		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
> +			index = SDXC_CLK_50M_DDR_8BIT;
> +		} else {
> +			index = SDXC_CLK_50M_DDR;
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	clk_set_phase(host->clk_sample, host->clk_delays[index].sample);
> +	clk_set_phase(host->clk_output, host->clk_delays[index].output);
> +
> +	return 0;
> +}
> +

The factoring out of this into a function really should be done in
a separate preparation patch, that will also make the patch making
the actual functional changes much easier to read.

Regards,

Hans



>  static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>  				  struct mmc_ios *ios)
>  {
> -	u32 rate, oclk_dly, rval, sclk_dly;
> +	u32 rate, rval;
>  	u32 clock = ios->clock;
>  	int ret;
>
> @@ -692,32 +768,18 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>  	}
>  	mmc_writel(host, REG_CLKCR, rval);
>
> -	/* determine delays */
> -	if (rate <= 400000) {
> -		oclk_dly = host->clk_delays[SDXC_CLK_400K].output;
> -		sclk_dly = host->clk_delays[SDXC_CLK_400K].sample;
> -	} else if (rate <= 25000000) {
> -		oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
> -		sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
> -	} else if (rate <= 52000000) {
> -		if (ios->timing != MMC_TIMING_UHS_DDR50 &&
> -		    ios->timing != MMC_TIMING_MMC_DDR52) {
> -			oclk_dly = host->clk_delays[SDXC_CLK_50M].output;
> -			sclk_dly = host->clk_delays[SDXC_CLK_50M].sample;
> -		} else if (ios->bus_width == MMC_BUS_WIDTH_8) {
> -			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].output;
> -			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR_8BIT].sample;
> -		} else {
> -			oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
> -			sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
> -		}
> +	if (host->can_calibrate) {
> +		ret = sunxi_mmc_calibrate(host, ios, SDXC_REG_SAMP_DL_REG);
> +		if (ret)
> +			return ret;
> +
> +		/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
>  	} else {
> -		return -EINVAL;
> +		ret = sunxi_mmc_determine_delays(host, ios, rate);
> +		if (ret)
> +			return ret;
>  	}
>
> -	clk_set_phase(host->clk_sample, sclk_dly);
> -	clk_set_phase(host->clk_output, oclk_dly);
> -
>  	return sunxi_mmc_oclk_onoff(host, 1);
>  }
>
> @@ -942,6 +1004,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun4i-a10-mmc", },
>  	{ .compatible = "allwinner,sun5i-a13-mmc", },
>  	{ .compatible = "allwinner,sun9i-a80-mmc", },
> +	{ .compatible = "allwinner,sun50i-a64-mmc", },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> @@ -990,6 +1053,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>  	else
>  		host->clk_delays = sunxi_mmc_clk_delays;
>
> +	if (of_device_is_compatible(np, "allwinner,sun50i-a64-mmc"))
> +		host->can_calibrate = true;
> +	else
> +		host->can_calibrate = false;
> +
>  	ret = mmc_regulator_get_supply(host->mmc);
>  	if (ret) {
>  		if (ret != -EPROBE_DEFER)
> @@ -1014,16 +1082,22 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>  		return PTR_ERR(host->clk_mmc);
>  	}
>
> -	host->clk_output = devm_clk_get(&pdev->dev, "output");
> -	if (IS_ERR(host->clk_output)) {
> -		dev_err(&pdev->dev, "Could not get output clock\n");
> -		return PTR_ERR(host->clk_output);
> -	}
> +	/* self-calibrate version of the IP block needs no output/sample */
> +	if (!host->can_calibrate) {
> +		host->clk_output = devm_clk_get(&pdev->dev, "output");
> +		if (IS_ERR(host->clk_output)) {
> +			dev_err(&pdev->dev, "Could not get output clock\n");
> +			return PTR_ERR(host->clk_output);
> +		}
>
> -	host->clk_sample = devm_clk_get(&pdev->dev, "sample");
> -	if (IS_ERR(host->clk_sample)) {
> -		dev_err(&pdev->dev, "Could not get sample clock\n");
> -		return PTR_ERR(host->clk_sample);
> +		host->clk_sample = devm_clk_get(&pdev->dev, "sample");
> +		if (IS_ERR(host->clk_sample)) {
> +			dev_err(&pdev->dev, "Could not get sample clock\n");
> +			return PTR_ERR(host->clk_sample);
> +		}
> +	} else {
> +		host->clk_sample = NULL;
> +		host->clk_output = NULL;
>  	}
>
>  	host->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
> @@ -1042,16 +1116,18 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>  		goto error_disable_clk_ahb;
>  	}
>
> -	ret = clk_prepare_enable(host->clk_output);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Enable output clk err %d\n", ret);
> -		goto error_disable_clk_mmc;
> -	}
> +	if (!host->can_calibrate) {
> +		ret = clk_prepare_enable(host->clk_output);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Enable output clk err %d\n", ret);
> +			goto error_disable_clk_mmc;
> +		}
>
> -	ret = clk_prepare_enable(host->clk_sample);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Enable sample clk err %d\n", ret);
> -		goto error_disable_clk_output;
> +		ret = clk_prepare_enable(host->clk_sample);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Enable sample clk err %d\n", ret);
> +			goto error_disable_clk_output;
> +		}
>  	}
>
>  	if (!IS_ERR(host->reset)) {
> @@ -1078,9 +1154,11 @@ error_assert_reset:
>  	if (!IS_ERR(host->reset))
>  		reset_control_assert(host->reset);
>  error_disable_clk_sample:
> -	clk_disable_unprepare(host->clk_sample);
> +	if (!host->can_calibrate)
> +		clk_disable_unprepare(host->clk_sample);
>  error_disable_clk_output:
> -	clk_disable_unprepare(host->clk_output);
> +	if (!host->can_calibrate)
> +		clk_disable_unprepare(host->clk_output);
>  error_disable_clk_mmc:
>  	clk_disable_unprepare(host->clk_mmc);
>  error_disable_clk_ahb:
>
