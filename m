From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH mmc-next 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Date: Thu, 26 Jul 2018 11:34:25 +0800
Message-ID: <20180726113425.722240bc@xhacker.debian>
References: <20180725174235.1ca764cf@xhacker.debian>
        <20180725174749.6fc97d4d@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725174749.6fc97d4d@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 25 Jul 2018 17:47:49 +0800 Jisheng Zhang wrote:

> When using DMA, if the DMA addr spans 128MB boundary, we have to split
> the DMA transfer into two so that each one doesn't exceed the boundary.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1b7cd144fb01..01b5cb772554 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -13,16 +13,45 @@
>  
>  #include "sdhci-pltfm.h"
>  
> +#define BOUNDARY_OK(addr, len) \
> +	((addr | (SZ_128M - 1)) == ((addr + len) | (SZ_128M - 1)))

this should be
((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))

> +
>  struct dwcmshc_priv {
>  	struct clk	*bus_clk;
>  };
>  
> +/*
> + * if DMA addr spans 128MB boundary, we split the DMA transfer into two
> + * so that the DMA transfer doesn't exceed the boundary.
> + */
> +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
> +					    void *desc, dma_addr_t addr,
> +					    int len, unsigned int cmd)
> +{
> +	int tmplen, offset;
> +
> +	if (BOUNDARY_OK(addr, len))
> +		return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +
> +	offset = addr & (SZ_128M - 1);
> +	tmplen = SZ_128M - offset;
> +	_sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> +
> +	addr += tmplen;
> +	len -= tmplen;
> +	desc += host->desc_sz;
> +	_sdhci_adma_write_desc(host, desc, addr, len, cmd);
> +
> +	return host->desc_sz * 2;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
>  	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
>  	.reset			= sdhci_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
>  };
>  
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> @@ -36,12 +65,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	struct sdhci_host *host;
>  	struct dwcmshc_priv *priv;
>  	int err;
> +	u32 extra;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
>  				sizeof(struct dwcmshc_priv));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> +	/*
> +	 * The DMA descriptor table number is calculated as the maximum
> +	 * number of segments times 2, to allow for an alignment
> +	 * descriptor for each segment, plus 1 for a nop end descriptor,
> +	 * plus extra number for cross 128M boundary handling.
> +	 */
> +	extra = totalram_pages / (SZ_128M / PAGE_SIZE) + 1;

will use DIV_ROUND_UP instead.

> +	if (extra > SDHCI_MAX_SEGS)
> +		extra = SDHCI_MAX_SEGS;
> +	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
> +
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
>  
