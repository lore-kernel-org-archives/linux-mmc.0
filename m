From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] mmc: host: sunxi: add support for A64 mmc
 controller
Date: Sun, 31 Jul 2016 16:30:29 +0200
Message-ID: <aaeda3c8-1487-cb6c-bfc6-44a63fed5ea2@redhat.com>
References: <20160731110234.3593-1-icenowy@aosc.xyz>
 <20160731110234.3593-3-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160731110234.3593-3-icenowy@aosc.xyz>
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

On 31-07-16 13:02, Icenowy Zheng wrote:
> A64 SoC features a MMC controller which need only the mod clock, and can
> calibrate delay by itself. This patch adds support for the new MMC
> controller IP core.
>
> Based on work by Andre Przywara <andre.przywara@arm.com>.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Looks good, some minor remarks (see comments inline) after those
are addressed this is ready to be merged IMHO.



> ---
>  drivers/mmc/host/sunxi-mmc.c | 106 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 90 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ec91ce..aa2abf3 100644
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

Please drop 1 empty line here.

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
> @@ -232,6 +249,9 @@ struct sunxi_idma_des {
>  struct sunxi_mmc_cfg {
>  	u32 idma_des_size_bits;
>  	const struct sunxi_mmc_clk_delay *clk_delays;
> +

I would not insert an empty line here.

> +	/* does the IP block support autocalibration? */
> +	bool can_calibrate;
>  };
>
>  struct sunxi_mmc_host {
> @@ -657,6 +677,34 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  	return 0;
>  }
>
> +static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host,
> +			       struct mmc_ios *ios, int reg_off)
> +{
> +	u32 reg = readl(host->reg_base + reg_off);
> +	u32 delay;
> +

I would add:

	if (!host->cfg->can_calibrate)
		return 0;

Here; and ...

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

Add:

	/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */

here; and ...

> +
> +	return 0;
> +}
> +
>  static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>  				   struct mmc_ios *ios, u32 rate)
>  {
> @@ -727,9 +775,17 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>  	}
>  	mmc_writel(host, REG_CLKCR, rval);
>
> -	ret = sunxi_mmc_clk_set_phase(host, ios, rate);
> -	if (ret)
> -		return ret;

Keep this as is; and add:

		ret = sunxi_mmc_calibrate(host, ios, SDXC_REG_SAMP_DL_REG);
		if (ret)
			return ret;

Instead of:

> +	if (host->cfg->can_calibrate) {
> +		ret = sunxi_mmc_calibrate(host, ios, SDXC_REG_SAMP_DL_REG);
> +		if (ret)
> +			return ret;
> +
> +		/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
> +	} else {
> +		ret = sunxi_mmc_clk_set_phase(host, ios, rate);
> +		if (ret)
> +			return ret;
> +	}
>
>  	return sunxi_mmc_oclk_onoff(host, 1);
>  }
> @@ -982,21 +1038,31 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
>  static const struct sunxi_mmc_cfg sun4i_a10_cfg = {
>  	.idma_des_size_bits = 13,
>  	.clk_delays = NULL,
> +	.can_calibrate = false,
>  };
>
>  static const struct sunxi_mmc_cfg sun5i_a13_cfg = {
>  	.idma_des_size_bits = 16,
>  	.clk_delays = NULL,
> +	.can_calibrate = false,
>  };
>
>  static const struct sunxi_mmc_cfg sun7i_a20_cfg = {
>  	.idma_des_size_bits = 16,
>  	.clk_delays = sunxi_mmc_clk_delays,
> +	.can_calibrate = false,
>  };
>
>  static const struct sunxi_mmc_cfg sun9i_a80_cfg = {
>  	.idma_des_size_bits = 16,
>  	.clk_delays = sun9i_mmc_clk_delays,
> +	.can_calibrate = false,
> +};
> +
> +static const struct sunxi_mmc_cfg sun50i_a64_cfg = {
> +	.idma_des_size_bits = 16,
> +	.clk_delays = NULL,
> +	.can_calibrate = true,
>  };
>
>  static const struct of_device_id sunxi_mmc_of_match[] = {
> @@ -1004,6 +1070,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
>  	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
>  	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
> +	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);


Not sure why all the below hunks are here, they certainly do not belong
in this patch; and they are not necessary. As I mentioned in the
commit msg of "mmc: sunxi: sun4i / sun5i do not have sample clocks" :

    "Note this patch leaves the clk_prepare_enable() / clk_disable_unprepare()
     calls to the sample clks as-is, without adding checks for them being
     NULL. All the clk_foo calls accept a NULL clk and will return success when
     called with a NULL clk."

So please drop these.

Thanks & Regards,

Hans



> @@ -1071,16 +1138,18 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>  		goto error_disable_clk_ahb;
>  	}
>
> -	ret = clk_prepare_enable(host->clk_output);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Enable output clk err %d\n", ret);
> -		goto error_disable_clk_mmc;
> -	}
> +	if (host->cfg->clk_delays) {
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
> @@ -1107,9 +1176,11 @@ error_assert_reset:
>  	if (!IS_ERR(host->reset))
>  		reset_control_assert(host->reset);
>  error_disable_clk_sample:
> -	clk_disable_unprepare(host->clk_sample);
> +	if (host->cfg->clk_delays)
> +		clk_disable_unprepare(host->clk_sample);
>  error_disable_clk_output:
> -	clk_disable_unprepare(host->clk_output);
> +	if (host->cfg->clk_delays)
> +		clk_disable_unprepare(host->clk_output);
>  error_disable_clk_mmc:
>  	clk_disable_unprepare(host->clk_mmc);
>  error_disable_clk_ahb:
> @@ -1191,8 +1262,11 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
>  	if (!IS_ERR(host->reset))
>  		reset_control_assert(host->reset);
>
> -	clk_disable_unprepare(host->clk_sample);
> -	clk_disable_unprepare(host->clk_output);
> +	if (host->cfg->clk_delays) {
> +		clk_disable_unprepare(host->clk_sample);
> +		clk_disable_unprepare(host->clk_output);
> +	}
> +
>  	clk_disable_unprepare(host->clk_mmc);
>  	clk_disable_unprepare(host->clk_ahb);
>
>
