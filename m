From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 6/9] mmc: sdhci-sprd: Enable PHY DLL to make clock stable
Date: Mon, 3 Jun 2019 15:40:58 +0300
Message-ID: <8a792a0c-ed53-56ca-ede8-4a2657158b81@intel.com>
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <270e86bf6b1ce138e40830fb63c9bcf150440426.1558346019.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <270e86bf6b1ce138e40830fb63c9bcf150440426.1558346019.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc: vincent.guittot@linaro.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> For the Spreadtrum SD host controller, when we changed the clock to be
> more than 52M, we should enable the PHY DLL which is used to track the
> clock frequency to make the clock work more stable. Otherwise deviation
> may occur of the higher clock.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   44 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index edec197..e6eda13 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -22,6 +22,13 @@
>  /* SDHCI_ARGUMENT2 register high 16bit */
>  #define SDHCI_SPRD_ARG2_STUFF		GENMASK(31, 16)
>  
> +#define SDHCI_SPRD_REG_32_DLL_CFG	0x200
> +#define  SDHCI_SPRD_DLL_ALL_CPST_EN	(BIT(18) | BIT(24) | BIT(25) | BIT(26) | BIT(27))
> +#define  SDHCI_SPRD_DLL_EN		BIT(21)
> +#define  SDHCI_SPRD_DLL_SEARCH_MODE	BIT(16)
> +#define  SDHCI_SPRD_DLL_INIT_COUNT	0xc00
> +#define  SDHCI_SPRD_DLL_PHASE_INTERNAL	0x3
> +
>  #define SDHCI_SPRD_REG_32_DLL_DLY_OFFSET	0x208
>  #define  SDHCIBSPRD_IT_WR_DLY_INV		BIT(5)
>  #define  SDHCI_SPRD_BIT_CMD_DLY_INV		BIT(13)
> @@ -56,6 +63,7 @@
>  #define SDHCI_SPRD_CLK_MAX_DIV		1023
>  
>  #define SDHCI_SPRD_CLK_DEF_RATE		26000000
> +#define SDHCI_SPRD_PHY_DLL_CLK		52000000
>  
>  struct sdhci_sprd_host {
>  	u32 version;
> @@ -200,9 +208,33 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
>  	}
>  }
>  
> +static void sdhci_sprd_enable_phy_dll(struct sdhci_host *host)
> +{
> +	u32 tmp;
> +
> +	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> +	tmp &= ~(SDHCI_SPRD_DLL_EN | SDHCI_SPRD_DLL_ALL_CPST_EN);
> +	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
> +	/* wait 1ms */
> +	usleep_range(1000, 1250);
> +
> +	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> +	tmp |= SDHCI_SPRD_DLL_ALL_CPST_EN | SDHCI_SPRD_DLL_SEARCH_MODE |
> +		SDHCI_SPRD_DLL_INIT_COUNT | SDHCI_SPRD_DLL_PHASE_INTERNAL;
> +	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
> +	/* wait 1ms */
> +	usleep_range(1000, 1250);
> +
> +	tmp = sdhci_readl(host, SDHCI_SPRD_REG_32_DLL_CFG);
> +	tmp |= SDHCI_SPRD_DLL_EN;
> +	sdhci_writel(host, tmp, SDHCI_SPRD_REG_32_DLL_CFG);
> +	/* wait 1ms */
> +	usleep_range(1000, 1250);
> +}
> +
>  static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
> -	bool en = false;
> +	bool en = false, clk_changed = false;
>  
>  	if (clock == 0) {
>  		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> @@ -214,9 +246,19 @@ static void sdhci_sprd_set_clock(struct sdhci_host *host, unsigned int clock)
>  			en = true;
>  		sdhci_sprd_set_dll_invert(host, SDHCI_SPRD_BIT_CMD_DLY_INV |
>  					  SDHCI_SPRD_BIT_POSRD_DLY_INV, en);
> +		clk_changed = true;
>  	} else {
>  		_sdhci_sprd_set_clock(host, clock);
>  	}
> +
> +	/*
> +	 * According to the Spreadtrum SD host specification, when we changed
> +	 * the clock to be more than 52M, we should enable the PHY DLL which
> +	 * is used to track the clock frequency to make the clock work more
> +	 * stable. Otherwise deviation may occur of the higher clock.
> +	 */
> +	if (clk_changed && clock > SDHCI_SPRD_PHY_DLL_CLK)
> +		sdhci_sprd_enable_phy_dll(host);
>  }
>  
>  static unsigned int sdhci_sprd_get_max_clock(struct sdhci_host *host)
> 
