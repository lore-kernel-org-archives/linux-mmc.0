From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 2/2] mmc: host: sunxi: add support for A64 mmc
 controller
Date: Wed, 03 Aug 2016 08:43:36 +0900
Message-ID: <57A13028.2030506@samsung.com>
References: <20160801151351.51854-1-icenowy@aosc.xyz>
 <CGME20160801151434epcas1p15f57862a238cf493445ed667f37a8a88@epcas1p1.samsung.com>
 <20160801151351.51854-3-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20160801151351.51854-3-icenowy@aosc.xyz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Michal Suchanek <hramrach@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Icenowy,

On 08/02/2016 12:13 AM, Icenowy Zheng wrote:
> A64 SoC features a MMC controller which need only the mod clock, and can
> calibrate delay by itself. This patch adds support for the new MMC
> controller IP core.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
> - Rebased on Hans de Goede's patchset.
> Changes in v3:
> - Tidy up based on Hans de Goede's opinions.
> 
>  drivers/mmc/host/sunxi-mmc.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 2ec91ce..3c26180 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -72,6 +72,13 @@
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
>  #define mmc_readl(host, reg) \
>  	readl((host)->reg_base + SDXC_##reg)
>  #define mmc_writel(host, reg, value) \
> @@ -217,6 +224,15 @@
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
> @@ -232,6 +248,9 @@ struct sunxi_idma_des {
>  struct sunxi_mmc_cfg {
>  	u32 idma_des_size_bits;
>  	const struct sunxi_mmc_clk_delay *clk_delays;
> +
> +	/* does the IP block support autocalibration? */
> +	bool can_calibrate;
>  };
>  
>  struct sunxi_mmc_host {
> @@ -657,6 +676,38 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>  	return 0;
>  }
>  
> +static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host,
> +			       struct mmc_ios *ios, int reg_off)

Where is mmc_ios structure used in this function?
And why passing the reg_off?

> +{
> +	u32 reg = readl(host->reg_base + reg_off);
> +	u32 delay;

delay doesn't need to use u32..
reg_off is only passed with SDXC_REG_SAMP_DL_REG..this function doesn't reuse anywhere.

> +
> +	if (!host->cfg->can_calibrate)
> +		return 0;
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

If never hit this condition, infinite loop? 

> +
> +	delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
> +
> +	reg &= ~SDXC_CAL_START;
> +	reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;

Something is strange. It seems to maintain the  delay value.

reg &= ~(SDXC_CAL_START | (SDXC_CAL_DL_MASK << SDXC_CAL_DL_SHIFT));
reg |= SDXC_CAL_DL_SW_EN; 

is it same thing?

> +
> +	writel(reg, host->reg_base + reg_off);
> +
> +	dev_dbg(mmc_dev(host->mmc), "calibration ended, res is 0x%x\n", reg);

s/res is/reg is ?

> +
> +	/* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
> +	return 0;
> +}
> +
>  static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
>  				   struct mmc_ios *ios, u32 rate)
>  {
> @@ -731,6 +782,10 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>  	if (ret)
>  		return ret;
>  
> +	ret = sunxi_mmc_calibrate(host, ios, SDXC_REG_SAMP_DL_REG);
> +	if (ret)
> +		return ret;

Never enter this condition. sunxi_mmc_calibrate() is always returned 0.


Best Regards,
Jaehoon Chung

> +
>  	return sunxi_mmc_oclk_onoff(host, 1);
>  }
>  
> @@ -982,21 +1037,31 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
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
> @@ -1004,6 +1069,7 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
>  	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
>  	{ .compatible = "allwinner,sun7i-a20-mmc", .data = &sun7i_a20_cfg },
>  	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
> +	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> 
