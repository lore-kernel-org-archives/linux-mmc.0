From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: Re: [PATCH v4 3/3] mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary
 limitation
Date: Mon, 27 Aug 2018 15:39:36 +0800
Message-ID: <20180827153936.7481ae13@xhacker.debian>
References: <20180823180549.78e508db@xhacker.debian>
        <20180823180926.444b34b5@xhacker.debian>
        <6302a5a4-35cf-3d8f-fcac-a15141fcf1d0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6302a5a4-35cf-3d8f-fcac-a15141fcf1d0@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 23 Aug 2018 14:51:26 +0300 Adrian Hunter wrote:

> On 23/08/18 13:09, Jisheng Zhang wrote:
> > When using DMA, if the DMA addr spans 128MB boundary, we have to split
> > the DMA transfer into two so that each one doesn't exceed the boundary.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 39 +++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 1b7cd144fb01..df0a3aeabe19 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -8,21 +8,48 @@
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
> > + * so that the DMA transfer doesn't exceed the boundary.
> > + */
> > +static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> > +				    dma_addr_t addr, int len, unsigned int cmd)
> > +{
> > +	int tmplen, offset;
> > +
> > +	if (likely(!len || BOUNDARY_OK(addr, len)))
> > +		sdhci_adma_write_desc(host, desc, addr, len, cmd);  
> 
> Doesn't this need a return? i.e.
> 
> 		return;

oops, I made a mistake here. Pre v4, there's a return...
Thanks so much.


> 	}
> 
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
> > @@ -36,12 +63,24 @@ static int dwcmshc_probe(struct platform_device *pdev)
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
> You are assuming here that totalram_pages gives you the highest physical
> page number.  Is that true?

Per my understanding, it's true. What I need is the MemTotal/PAGE_SIZE where
Memtotal is from /proc/meminfo. After reading the code, I found this is
totalram_pages as shown in si_meminfo()

> 
> > +	if (extra > SDHCI_MAX_SEGS)
> > +		extra = SDHCI_MAX_SEGS;
> > +	host->adma_table_cnt = SDHCI_MAX_SEGS * 2 + 1 + extra;  
> 
> That should be:
> 
> 	host->adma_table_cnt += extra;

yep, will do in v5

> 
> > +
> >  	pltfm_host = sdhci_priv(host);
> >  	priv = sdhci_pltfm_priv(pltfm_host);
> >  
> >   
> 
