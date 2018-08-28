From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v5 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
Date: Tue, 28 Aug 2018 17:53:19 +0800
Message-ID: <20180828175319.7ff35889@xhacker.debian>
References: <20180827162026.3901de27@xhacker.debian>
        <20180827162419.61afe238@xhacker.debian>
        <9739a083-cb2f-1cba-19c1-1c4e0d03eedd@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9739a083-cb2f-1cba-19c1-1c4e0d03eedd@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 28 Aug 2018 10:51:02 +0300 Adrian Hunter wrote:

> On 27/08/18 11:24, Jisheng Zhang wrote:
> > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > the DMA transfer into two so that each one doesn't exceed the boundary.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 41 +++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 1b7cd144fb01..cfbdae8703a1 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -8,21 +8,50 @@
> >   */
> >  
> >  #include <linux/clk.h>
> > +#include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/sizes.h>
> >  
> >  #include "sdhci-pltfm.h"
> >  
> > +#define BOUNDARY_OK(addr, len) \
> > +	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> > +
> >  struct dwcmshc_priv {
> >  	struct clk	*bus_clk;
> >  };
> >  
> > +/*
> > + * If DMA addr spans 128MB boundary, we split the DMA transfer into two
> > + * so that each DMA transfer doesn't exceed the boundary.
> > + */
> > +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> > +				    dma_addr_t addr, int len, unsigned int cmd)
> > +{
> > +	int tmplen, offset;
> > +
> > +	if (likely(!len || BOUNDARY_OK(addr, len))) {
> > +		sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +		return;
> > +	}
> > +
> > +	offset = addr & (SZ_128M - 1);
> > +	tmplen = SZ_128M - offset;
> > +	sdhci_adma_write_desc(host, desc, addr, tmplen, cmd);
> > +
> > +	addr += tmplen;
> > +	len -= tmplen;
> > +	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> > +}
> > +
> >  static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >  	.set_clock		= sdhci_set_clock,
> >  	.set_bus_width		= sdhci_set_bus_width,
> >  	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> >  	.get_max_clock		= sdhci_pltfm_clk_get_max_clock,
> >  	.reset			= sdhci_reset,
> > +	.adma_write_desc	= dwcmshc_adma_write_desc,
> >  };
> >  
> >  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> > @@ -36,12 +65,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >  	struct sdhci_host *host;
> >  	struct dwcmshc_priv *priv;
> >  	int err;
> > +	u32 extra;
> >  
> >  	host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> >  				sizeof(struct dwcmshc_priv));
> >  	if (IS_ERR(host))
> >  		return PTR_ERR(host);
> >  
> > +	/*
> > +	 * The DMA table descriptor count is calculated as the maximum
> > +	 * number of segments times 2, to allow for an alignment
> > +	 * descriptor for each segment, plus 1 for a nop end descriptor,
> > +	 * plus extra number for cross 128M boundary handling.
> > +	 */
> > +	extra = DIV_ROUND_UP(totalram_pages, SZ_128M / PAGE_SIZE);  
> 
> The amount of RAM is not necessarily the same as the highest physical
> address.  I think what you really want is max_pfn or max_possible_pfn

oh, yeah! But these two vars are not exported, I have two solutions:

1. use the dma_get_required_mask(), this is what I did in v6

2. always let extra = SDHCI_MAX_SEGS, although we may waste, but the
waste is small -- at most we waste 128*12 = 1536 Byte.

But it seems solution 1 could do its job ;)

Thanks,
Jisheng

> 
> > +	if (extra > SDHCI_MAX_SEGS)
> > +		extra = SDHCI_MAX_SEGS;
> > +	host->adma_table_cnt += extra;
> > +
> >  	pltfm_host = sdhci_priv(host);
> >  	priv = sdhci_pltfm_priv(pltfm_host);
> >  
> >   
> 
