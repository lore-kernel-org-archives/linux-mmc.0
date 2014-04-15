From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 4/7] mmc: dw_mmc: exynos: incorporate ciu_div into
 timing property
Date: Tue, 15 Apr 2014 20:03:21 +0900
Message-ID: <001401cf589a$50baa1d0$f22fe570$%jun@samsung.com>
References: <000401cf48e6$f173a680$d45af380$%jun@samsung.com>
 <534B8E63.5010405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <534B8E63.5010405@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

On Mon, April 14, 2014, Jaehoon Chung wrote:
> Hi, Seungwon.
> 
> On 03/26/2014 08:31 PM, Seungwon Jeon wrote:
> > ciu_div may not be common value for all speed mode.
> > So, it needs to be attached to CLKSEL timing.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc-exynos.c |   75 ++++++++++++++++++++++++++------------
> >  drivers/mmc/host/dw_mmc-exynos.h |    1 +
> >  2 files changed, 53 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index bab97e9..39f9114 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -39,6 +39,7 @@ struct dw_mci_exynos_priv_data {
> >  	u8				ciu_div;
> >  	u32				sdr_timing;
> >  	u32				ddr_timing;
> > +	u32				hs200_timing;
> >  	u32				cur_speed;
> >  };
> >
> > @@ -64,6 +65,18 @@ static struct dw_mci_exynos_compatible {
> >  	},
> >  };
> >
> > +static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
> > +{
> > +	struct dw_mci_exynos_priv_data *priv = host->priv;
> > +
> > +	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
> > +		return EXYNOS4412_FIXED_CIU_CLK_DIV;
> > +	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
> > +		return EXYNOS4210_FIXED_CIU_CLK_DIV;
> > +	else
> > +		return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL)) + 1;
> > +}
> > +
> >  static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >  {
> >  	struct dw_mci_exynos_priv_data *priv = host->priv;
> > @@ -77,6 +90,8 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >  			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
> >  	}
> >
> > +	priv->ciu_div = dw_mci_exynos_get_ciu_div(host);
> > +
> >  	return 0;
> >  }
> >
> > @@ -84,7 +99,7 @@ static int dw_mci_exynos_setup_clock(struct dw_mci *host)
> >  {
> >  	struct dw_mci_exynos_priv_data *priv = host->priv;
> >
> > -	host->bus_hz /= (priv->ciu_div + 1);
> > +	host->bus_hz /= priv->ciu_div;
> >
> >  	return 0;
> >  }
> > @@ -151,9 +166,10 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >  	struct dw_mci_exynos_priv_data *priv = host->priv;
> >  	unsigned int wanted = ios->clock;
> >  	unsigned long actual;
> > -	u8 div = priv->ciu_div + 1;
> >
> > -	if (ios->timing == MMC_TIMING_MMC_DDR52) {
> > +	if (ios->timing == MMC_TIMING_MMC_HS200) {
> > +		mci_writel(host, CLKSEL, priv->hs200_timing);
> > +	} else if (ios->timing == MMC_TIMING_MMC_DDR52) {
> >  		mci_writel(host, CLKSEL, priv->ddr_timing);
> >  		/* Should be double rate for DDR mode */
> >  		if (ios->bus_width == MMC_BUS_WIDTH_8)
> > @@ -174,6 +190,7 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >  		wanted = EXYNOS_CCLKIN_MIN;
> >
> >  	if (wanted != priv->cur_speed) {
> > +		u8 div = dw_mci_exynos_get_ciu_div(host);
> >  		int ret = clk_set_rate(host->ciu_clk, wanted * div);
> >  		if (ret)
> >  			dev_warn(host->dev,
> > @@ -186,14 +203,34 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >  	}
> >  }
> >
> > +static int dw_mci_exynos_dt_populate_timing(struct dw_mci *host,
> > +					    unsigned int ctrl_type,
> > +					    const char *propname,
> > +					    u32 *out_values)
> > +{
> > +	struct device_node *np = host->dev->of_node;
> > +	u32 timing[3];
> > +	int ret;
> > +
> > +	ret = of_property_read_u32_array(np, propname, timing, 3);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (ctrl_type == DW_MCI_TYPE_EXYNOS4412 ||
> > +	    ctrl_type == DW_MCI_TYPE_EXYNOS4210)
> > +		timing[2] = 0;
> > +
> > +	*out_values = SDMMC_CLKSEL_TIMING(timing[0], timing[1], timing[2]);
> > +
> > +	return 0;
> > +}
> > +
> > +
> >  static int dw_mci_exynos_parse_dt(struct dw_mci *host)
> >  {
> >  	struct dw_mci_exynos_priv_data *priv;
> >  	struct device_node *np = host->dev->of_node;
> > -	u32 timing[2];
> > -	u32 div = 0;
> > -	int idx;
> > -	int ret;
> > +	int idx, ret;
> >
> >  	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> >  	if (!priv) {
> > @@ -206,29 +243,21 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
> >  			priv->ctrl_type = exynos_compat[idx].ctrl_type;
> >  	}
> >
> > -	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4412)
> > -		priv->ciu_div = EXYNOS4412_FIXED_CIU_CLK_DIV - 1;
> > -	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS4210)
> > -		priv->ciu_div = EXYNOS4210_FIXED_CIU_CLK_DIV - 1;
> > -	else {
> > -		of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
> > -		priv->ciu_div = div;
> > -	}
> Did you remove the property of "ciu-div"?
> I didn't find anywhere it's used, when this is removed.
> Then it needs to remove the properties into device-tree.
> And i want to maintain the property of "ciu-div".

The related patch has been posted with this.
"[PATCH 6/7] ARM: dts: drop dw-mshc-ciu-div property from Exynos"
Please can you check?

Thanks,
Seungwon Jeon
> 
> Best Regards,
> Jaehoon Chung
> 
> > -
> > -	ret = of_property_read_u32_array(np,
> > -			"samsung,dw-mshc-sdr-timing", timing, 2);
> > +	ret = dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
> > +			"samsung,dw-mshc-sdr-timing", &priv->sdr_timing);
> >  	if (ret)
> >  		return ret;
> >
> > -	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
> > -
> > -	ret = of_property_read_u32_array(np,
> > -			"samsung,dw-mshc-ddr-timing", timing, 2);
> > +	ret = dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
> > +			"samsung,dw-mshc-ddr-timing", &priv->ddr_timing);
> >  	if (ret)
> >  		return ret;
> >
> > -	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
> > +	dw_mci_exynos_dt_populate_timing(host, priv->ctrl_type,
> > +			"samsung,dw-mshc-hs200-timing", &priv->hs200_timing);
> > +
> >  	host->priv = priv;
> > +
> >  	return 0;
> >  }
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.h b/drivers/mmc/host/dw_mmc-exynos.h
> > index 2554e2f..2c8c228 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.h
> > +++ b/drivers/mmc/host/dw_mmc-exynos.h
> > @@ -20,6 +20,7 @@
> >  #define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
> >  #define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
> >  #define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
> > +#define SDMMC_CLKSEL_GET_DIV(x)		(((x) >> 24) & 0x7)
> >  #define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
> >  					 SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
> >  					 SDMMC_CLKSEL_CCLK_DIVIDER(z))
> >
