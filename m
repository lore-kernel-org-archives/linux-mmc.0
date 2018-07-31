From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH mmc-next v2 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA
 boundary limitation
Date: Tue, 31 Jul 2018 11:29:24 +0800
Message-ID: <20180731112924.6a1e8388@xhacker.debian>
References: <20180726151017.4da1e336@xhacker.debian>
        <20180726151424.4bcecf41@xhacker.debian>
        <edaa7605-e0e0-b17a-8403-c3d7d60d7989@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edaa7605-e0e0-b17a-8403-c3d7d60d7989@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Robin,

On Mon, 30 Jul 2018 12:06:08 +0100 Robin Murphy wrote:

> Hi Jisheng,
> 
> On 26/07/18 08:14, Jisheng Zhang wrote:
> > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > the DMA transfer into two so that each one doesn't exceed the boundary.  
> 
> Out of interest, is the driver already setting its segment boundary mask 
> appropriately? This sounds like the exact kind of hardware restriction 
> that dma_parms is intended to describe, which scatterlist-generating 
> code is *supposed* to already respect.

Thanks for the nice input. It may provide an elegant solution for this
limitation. 

To simplify the situation, let's assume no iommu, only swiotlb. And
the DDR is less than 4GB so swiotlb on arm64 doesn't init.

There's no dma range limitation with the HW, the only limitation
is boundary, while dma_capable() doesn't check the boundary mask, so if
we taking this solution, we need to teach dma_capable() about the boundary
mask, I'm not sure whether this is acceptable.

Another problem is swiotlb initialization. When to init swiotlb, we dunno
there's such boundary limitation HW. Is there any elegant solution for
this problem?

Thanks

> 
> Robin.
> 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >   drivers/mmc/host/sdhci-of-dwcmshc.c | 42 +++++++++++++++++++++++++++++
> >   1 file changed, 42 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 1b7cd144fb01..7e189514bc83 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -8,21 +8,51 @@
> >    */
> >   
> >   #include <linux/clk.h>
> > +#include <linux/mm.h>
> >   #include <linux/module.h>
> >   #include <linux/of.h>
> >   
> >   #include "sdhci-pltfm.h"
> >   
> > +#define BOUNDARY_OK(addr, len) \
> > +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> > +
> >   struct dwcmshc_priv {
> >   	struct clk	*bus_clk;
> >   };
> >   
> > +/*
> > + * if DMA addr spans 128MB boundary, we split the DMA transfer into two
> > + * so that the DMA transfer doesn't exceed the boundary.
> > + */
> > +static unsigned int dwcmshc_adma_write_desc(struct sdhci_host *host,
> > +					    void *desc, dma_addr_t addr,
> > +					    int len, unsigned int cmd)
> > +{
> > +	int tmplen, offset;
> > +
> > +	if (BOUNDARY_OK(addr, len) || !len)
> > +		return _sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +
> > +	offset = addr & (SZ_128M - 1);
> > +	tmplen = SZ_128M - offset;
> > +	_sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> > +
> > +	addr += tmplen;
> > +	len -= tmplen;
> > +	desc += host->desc_sz;
> > +	_sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +
> > +	return host->desc_sz * 2;
> > +}
> > +
> >   static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >   	.set_clock		= sdhci_set_clock,
> >   	.set_bus_width		= sdhci_set_bus_width,
> >   	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> >   	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> >   	.reset			= sdhci_reset,
> > +	.adma_write_desc	= dwcmshc_adma_write_desc,
> >   };
> >   
> >   static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> > @@ -36,12 +66,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >   	struct sdhci_host *host;
> >   	struct dwcmshc_priv *priv;
> >   	int err;
> > +	u32 extra;
> >   
> >   	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> >   				sizeof(struct dwcmshc_priv));
> >   	if (IS_ERR(host))
> >   		return PTR_ERR(host);
> >   
> > +	/*
> > +	 * The DMA descriptor table number is calculated as the maximum
> > +	 * number of segments times 2, to allow for an alignment
> > +	 * descriptor for each segment, plus 1 for a nop end descriptor,
> > +	 * plus extra number for cross 128M boundary handling.
> > +	 */
> > +	extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);
> > +	if (extra > SDHCI_MAX_SEGS)
> > +		extra = SDHCI_MAX_SEGS;
> > +	host->adma_table_num = SDHCI_MAX_SEGS * 2 + 1 + extra;
> > +
> >   	pltfm_host = sdhci_priv(host);
> >   	priv = sdhci_pltfm_priv(pltfm_host);
> >   
> >   
