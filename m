From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Support HS400 Enhanced Strobe feature
Date: Mon, 28 Aug 2017 13:50:10 +0300
Message-ID: <03f8adfa-3de9-f104-de74-079190303d64@intel.com>
References: <1503512102-30968-1-git-send-email-zjwu@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16227 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdH1K4s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 28 Aug 2017 06:56:48 -0400
In-Reply-To: <1503512102-30968-1-git-send-email-zjwu@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhoujie Wu <zjwu@marvell.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: zmxu@marvell.com, jszhang@marvell.com, nadavh@marvell.com, xigu@marvell.com, dingwei@marvell.com, kostap@marvell.com, hannah@marvell.com, hongd@marvell.com, dougj@marvell.com, ygao@marvell.com, liuw@marvell.com, gregory.clement@free-electrons.com, thomas.petazzoni@free-electrons.com

On 23/08/17 21:15, Zhoujie Wu wrote:
> From: Hu Ziji <huziji@marvell.com>
> 
> Support HS400 Enhanced Strobe feature in Xenon.
> 
> Enable Enhanced Strobe together with Data Strobe.
> Disable Enhanced Strobe when eMMC is not in HS400 mode.
> 
> Signed-off-by: Hu Ziji <huziji@marvell.com>
> Signed-off-by: Zhoujie Wu <zjwu@marvell.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 34 ++++++++++++++++++++++++++++------
>  drivers/mmc/host/sdhci-xenon.h     |  1 +
>  2 files changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index f7e26b0..ec87943 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -409,17 +409,30 @@ static int xenon_emmc_phy_config_tuning(struct sdhci_host *host)
>  	return 0;
>  }
>  
> -static void xenon_emmc_phy_disable_data_strobe(struct sdhci_host *host)
> +static void xenon_emmc_phy_disable_strobe(struct sdhci_host *host)
>  {
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>  	u32 reg;
>  
> -	/* Disable SDHC Data Strobe */
> +	/* Disable both SDHC Data Strobe and Enhanced Strobe */
>  	reg = sdhci_readl(host, XENON_SLOT_EMMC_CTRL);
> -	reg &= ~XENON_ENABLE_DATA_STROBE;
> +	reg &= ~(XENON_ENABLE_DATA_STROBE | XENON_ENABLE_RESP_STROBE);
>  	sdhci_writel(host, reg, XENON_SLOT_EMMC_CTRL);
> +
> +	/* Clear Strobe line Pull down or Pull up */
> +	if (priv->phy_type == EMMC_5_0_PHY) {
> +		reg = sdhci_readl(host, XENON_EMMC_5_0_PHY_PAD_CONTROL);
> +		reg &= ~(XENON_EMMC5_FC_QSP_PD | XENON_EMMC5_FC_QSP_PU);
> +		sdhci_writel(host, reg, XENON_EMMC_5_0_PHY_PAD_CONTROL);
> +	} else {
> +		reg = sdhci_readl(host, XENON_EMMC_PHY_PAD_CONTROL1);
> +		reg &= ~(XENON_EMMC5_1_FC_QSP_PD | XENON_EMMC5_1_FC_QSP_PU);
> +		sdhci_writel(host, reg, XENON_EMMC_PHY_PAD_CONTROL1);
> +	}
>  }
>  
> -/* Set HS400 Data Strobe */
> +/* Set HS400 Data Strobe and Enhanced Strobe */
>  static void xenon_emmc_phy_strobe_delay_adj(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -439,6 +452,15 @@ static void xenon_emmc_phy_strobe_delay_adj(struct sdhci_host *host)
>  	/* Enable SDHC Data Strobe */
>  	reg = sdhci_readl(host, XENON_SLOT_EMMC_CTRL);
>  	reg |= XENON_ENABLE_DATA_STROBE;
> +	/*
> +	 * Enable SDHC Enhanced Strobe if supported
> +	 * Xenon Enhanced Strobe should be enabled only when
> +	 * 1. card is in HS400 mode and
> +	 * 2. SDCLK is higher than 52MHz
> +	 * 3. DLL is enabled
> +	 */
> +	if (host->mmc->ios.enhanced_strobe)
> +		reg |= XENON_ENABLE_RESP_STROBE;
>  	sdhci_writel(host, reg, XENON_SLOT_EMMC_CTRL);
>  
>  	/* Set Data Strobe Pull down */
> @@ -615,7 +637,7 @@ static void xenon_emmc_phy_set(struct sdhci_host *host,
>  		sdhci_writel(host, phy_regs->logic_timing_val,
>  			     phy_regs->logic_timing_adj);
>  	else
> -		xenon_emmc_phy_disable_data_strobe(host);
> +		xenon_emmc_phy_disable_strobe(host);
>  
>  phy_init:
>  	xenon_emmc_phy_init(host);
> @@ -705,7 +727,7 @@ void xenon_soc_pad_ctrl(struct sdhci_host *host,
>  
>  /*
>   * Setting PHY when card is working in High Speed Mode.
> - * HS400 set data strobe line.
> + * HS400 set Data Strobe and Enhanced Strobe if it is supported.
>   * HS200/SDR104 set tuning config to prepare for tuning.
>   */
>  static int xenon_hs_delay_adj(struct sdhci_host *host)
> diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
> index 73debb4..01937f1 100644
> --- a/drivers/mmc/host/sdhci-xenon.h
> +++ b/drivers/mmc/host/sdhci-xenon.h
> @@ -33,6 +33,7 @@
>  #define XENON_TUNING_STEP_DIVIDER		BIT(6)
>  
>  #define XENON_SLOT_EMMC_CTRL			0x0130
> +#define XENON_ENABLE_RESP_STROBE		BIT(25)
>  #define XENON_ENABLE_DATA_STROBE		BIT(24)
>  
>  #define XENON_SLOT_RETUNING_REQ_CTRL		0x0144
> 

