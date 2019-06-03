From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 5/9] mmc: sdhci-sprd: Add HS400 enhanced strobe mode
Date: Mon, 3 Jun 2019 15:39:16 +0300
Message-ID: <1d527144-b047-1d81-171d-706e1c67e19b@intel.com>
References: <cover.1558346019.git.baolin.wang@linaro.org>
 <20349e8ebd4c1ec64fb5f8cdd9e094d0c1732855.1558346019.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20349e8ebd4c1ec64fb5f8cdd9e094d0c1732855.1558346019.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc: vincent.guittot@linaro.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20/05/19 1:11 PM, Baolin Wang wrote:
> Add HS400 enhanced strobe mode support for Spreadtrum SD host controller.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index d91281d..edec197 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -41,6 +41,7 @@
>  /* SDHCI_HOST_CONTROL2 */
>  #define  SDHCI_SPRD_CTRL_HS200		0x0005
>  #define  SDHCI_SPRD_CTRL_HS400		0x0006
> +#define  SDHCI_SPRD_CTRL_HS400ES	0x0007
>  
>  /*
>   * According to the standard specification, BIT(3) of SDHCI_SOFTWARE_RESET is
> @@ -132,6 +133,15 @@ static inline void sdhci_sprd_sd_clk_off(struct sdhci_host *host)
>  	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
>  }
>  
> +static inline void sdhci_sprd_sd_clk_on(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	ctrl |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +}
> +
>  static inline void
>  sdhci_sprd_set_dll_invert(struct sdhci_host *host, u32 mask, bool en)
>  {
> @@ -325,6 +335,26 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	sdhci_request(mmc, mrq);
>  }
>  
> +static void sdhci_sprd_hs400_enhanced_strobe(struct mmc_host *mmc,
> +					     struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u16 ctrl_2;
> +
> +	if (!ios->enhanced_strobe)
> +		return;
> +
> +	sdhci_sprd_sd_clk_off(host);
> +
> +	/* Set HS400 enhanced strobe mode */
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +	ctrl_2 |= SDHCI_SPRD_CTRL_HS400ES;
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +	sdhci_sprd_sd_clk_on(host);
> +}
> +
>  static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
>  	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
>  	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
> @@ -346,6 +376,8 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>  	host->dma_mask = DMA_BIT_MASK(64);
>  	pdev->dev.dma_mask = &host->dma_mask;
>  	host->mmc_host_ops.request = sdhci_sprd_request;
> +	host->mmc_host_ops.hs400_enhanced_strobe =
> +		sdhci_sprd_hs400_enhanced_strobe;
>  
>  	host->mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
>  		MMC_CAP_ERASE | MMC_CAP_CMD23;
> 
