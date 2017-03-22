From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 10/14] mmc: sdhci-xenon: Add SoC PHY PAD voltage
 control
Date: Wed, 22 Mar 2017 16:47:23 +0200
Message-ID: <e5aeca29-1e91-8bc7-9d0e-686179f154cc@intel.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
 <3c21f3f9930373d6e6c28526c2e5b0aa2072daef.1487091464.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <3c21f3f9930373d6e6c28526c2e5b0aa2072daef.1487091464.git-series.gregory.clement@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ziji Hu <huziji@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.c>
List-Id: linux-mmc@vger.kernel.org

On 14/02/17 19:01, Gregory CLEMENT wrote:
> From: Hu Ziji <huziji@marvell.com>
> 
> Some SoCs have PHY PAD outside Xenon IP.
> PHY PAD voltage should match signalling voltage in use.
> 
> Add generic SoC PHY PAD voltage control interface.
> Implement Aramda-3700 SoC PHY PAD voltage control.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 116 +++++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-xenon.c     |   2 +-
>  drivers/mmc/host/sdhci-xenon.h     |   2 +-
>  3 files changed, 119 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index c26ba3a180a0..c3b7e9a21f6b 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -143,6 +143,27 @@ enum phy_type_enum {
>  	NR_PHY_TYPES
>  };
>  
> +enum soc_pad_ctrl_type {
> +	SOC_PAD_SD,
> +	SOC_PAD_FIXED_1_8V,
> +};
> +
> +struct soc_pad_ctrl_table {
> +	const char *soc;
> +	void (*set_soc_pad)(struct sdhci_host *host,
> +			    unsigned char signal_voltage);
> +};

Is soc_pad_ctrl_table used?

> +
> +struct soc_pad_ctrl {
> +	/* Register address of SoC PHY PAD ctrl */
> +	void __iomem	*reg;
> +	/* SoC PHY PAD ctrl type */
> +	enum soc_pad_ctrl_type pad_type;
> +	/* SoC specific operation to set SoC PHY PAD */
> +	void (*set_soc_pad)(struct sdhci_host *host,
> +			    unsigned char signal_voltage);
> +};
> +
>  static struct xenon_emmc_phy_regs xenon_emmc_5_0_phy_regs = {
>  	.timing_adj	= XENON_EMMC_5_0_PHY_TIMING_ADJUST,
>  	.func_ctrl	= XENON_EMMC_5_0_PHY_FUNC_CONTROL,
> @@ -176,6 +197,8 @@ struct emmc_phy_params {
>  	u8	nr_tun_times;
>  	/* Divider for calculating Tuning Step */
>  	u8	tun_step_divider;
> +
> +	struct soc_pad_ctrl pad_ctrl;
>  };
>  
>  static int alloc_emmc_phy(struct sdhci_xenon_priv *priv)
> @@ -252,6 +275,45 @@ static int emmc_phy_init(struct sdhci_host *host)
>  	return 0;
>  }
>  
> +#define ARMADA_3700_SOC_PAD_1_8V	0x1
> +#define ARMADA_3700_SOC_PAD_3_3V	0x0
> +
> +static void armada_3700_soc_pad_voltage_set(struct sdhci_host *host,
> +					    unsigned char signal_voltage)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct emmc_phy_params *params = priv->phy_params;
> +
> +	if (params->pad_ctrl.pad_type == SOC_PAD_FIXED_1_8V) {
> +		writel(ARMADA_3700_SOC_PAD_1_8V, params->pad_ctrl.reg);
> +	} else if (params->pad_ctrl.pad_type == SOC_PAD_SD) {
> +		if (signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +			writel(ARMADA_3700_SOC_PAD_1_8V, params->pad_ctrl.reg);
> +		else if (signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> +			writel(ARMADA_3700_SOC_PAD_3_3V, params->pad_ctrl.reg);
> +	}
> +}
> +
> +/*
> + * Set SoC PHY voltage PAD control register,
> + * according to the operation voltage on PAD.
> + * The detailed operation depends on SoC implementation.
> + */
> +static void emmc_phy_set_soc_pad(struct sdhci_host *host,
> +				 unsigned char signal_voltage)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	struct emmc_phy_params *params = priv->phy_params;
> +
> +	if (!params->pad_ctrl.reg)
> +		return;
> +
> +	if (params->pad_ctrl.set_soc_pad)
> +		params->pad_ctrl.set_soc_pad(host, signal_voltage);
> +}
> +
>  /*
>   * Enable eMMC PHY HW DLL
>   * DLL should be enabled and stable before HS200/SDR104 tuning,
> @@ -584,6 +646,51 @@ static void emmc_phy_set(struct sdhci_host *host,
>  	dev_dbg(mmc_dev(host->mmc), "eMMC PHY setting completes\n");
>  }
>  
> +static int get_dt_pad_ctrl_data(struct sdhci_host *host,
> +				struct device_node *np,
> +				struct emmc_phy_params *params)
> +{
> +	int ret = 0;
> +	const char *name;
> +	struct resource iomem;
> +
> +	if (of_device_is_compatible(np, "marvell,armada-3700-sdhci"))
> +		params->pad_ctrl.set_soc_pad = armada_3700_soc_pad_voltage_set;
> +	else
> +		return 0;
> +
> +	if (of_address_to_resource(np, 1, &iomem)) {
> +		dev_err(mmc_dev(host->mmc), "Unable to find SoC PAD ctrl register address for %s\n",
> +			np->name);
> +		return -EINVAL;
> +	}
> +
> +	params->pad_ctrl.reg = devm_ioremap_resource(mmc_dev(host->mmc),
> +						     &iomem);
> +	if (IS_ERR(params->pad_ctrl.reg)) {
> +		dev_err(mmc_dev(host->mmc), "Unable to get SoC PHY PAD ctrl register for %s\n",
> +			np->name);
> +		return PTR_ERR(params->pad_ctrl.reg);
> +	}
> +
> +	ret = of_property_read_string(np, "marvell,pad-type", &name);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc), "Unable to determine SoC PHY PAD ctrl type\n");
> +		return ret;
> +	}
> +	if (!strcmp(name, "sd")) {
> +		params->pad_ctrl.pad_type = SOC_PAD_SD;
> +	} else if (!strcmp(name, "fixed-1-8v")) {
> +		params->pad_ctrl.pad_type = SOC_PAD_FIXED_1_8V;
> +	} else {
> +		dev_err(mmc_dev(host->mmc), "Unsupported SoC PHY PAD ctrl type %s\n",
> +			name);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static int emmc_phy_parse_param_dt(struct sdhci_host *host,
>  				   struct device_node *np,
>  				   struct emmc_phy_params *params)
> @@ -617,7 +724,14 @@ static int emmc_phy_parse_param_dt(struct sdhci_host *host,
>  	else
>  		params->tun_step_divider = XENON_TUNING_STEP_DIVIDER;
>  
> -	return 0;
> +	return get_dt_pad_ctrl_data(host, np, params);
> +}
> +
> +/* Set SoC PHY Voltage PAD */
> +void xenon_soc_pad_ctrl(struct sdhci_host *host,
> +			unsigned char signal_voltage)
> +{
> +	emmc_phy_set_soc_pad(host, signal_voltage);
>  }
>  
>  /*
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 99c18cad6460..f344d9fb0a1b 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -338,6 +338,8 @@ static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>  	 */
>  	enable_xenon_internal_clk(host);
>  
> +	xenon_soc_pad_ctrl(host, ios->signal_voltage);
> +
>  	if (priv->init_card_type == MMC_TYPE_MMC)
>  		return xenon_emmc_signal_voltage_switch(mmc, ios);
>  
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index e87639774bca..57e7cb463413 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -104,4 +104,6 @@ struct sdhci_xenon_priv {
>  int xenon_phy_adj(struct sdhci_host *host, struct mmc_ios *ios);
>  int xenon_phy_parse_dt(struct device_node *np,
>  		       struct sdhci_host *host);
> +void xenon_soc_pad_ctrl(struct sdhci_host *host,
> +			unsigned char signal_voltage);
>  #endif
> 

