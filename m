From: Mark Jackson <mpfj-list-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Subject: Re: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
	resources
Date: Fri, 6 Sep 2013 20:13:07 +0100
Message-ID: <522A2943.4060502@newflow.co.uk>
References: <1377287613-16491-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1377287613-16491-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 23/08/13 20:53, Joel Fernandes wrote:
> HWMOD removal for MMC and Crypto is breaking edma_start as the events are
> being manually triggered due to unused channel list not being clear. Atleast
> breakage has been seen on these peripherals, but it is expected Audio (McASP)
> maybe breaking too.
> 
> This patch fixes the issue, by reading the "dmas" property from the DT node if
> it exists and clearing the bits in the unused channel list so that these channels
> are not manually triggered.
> 
> v2 changes:
> Reduced indendation by returning from if block.
> 
> Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Reported-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Cc: Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
> ---
> Note:
> Patch should go in for -rc cycle as it fixes existing crypto drivers.
> 
>  arch/arm/common/edma.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 39ad030..3867e7e 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -560,14 +560,30 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
>  static int prepare_unused_channel_list(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	int i, ctlr;
> +	int i = 0, ctlr;
> +	u32 dma_chan;
> +	const __be32 *dma_chan_p;
> +	struct property *prop;
> +
> +	if (dev->of_node) {
> +		of_property_for_each_u32(dev->of_node, "dmas", prop,
> +					 dma_chan_p, dma_chan) {
> +			if (i++ & 1) {
> +				ctlr = EDMA_CTLR(dma_chan);
> +				clear_bit(EDMA_CHAN_SLOT(dma_chan),
> +					  edma_cc[ctlr]->edma_unused);
> +			}
> +		}
> +		return;

This should return something here, otherwise we get:-

arch/arm/common/edma.c: In function 'prepare_unused_channel_list':
arch/arm/common/edma.c:577:3: warning: 'return' with no value, in function returning non-void [-Wreturn-type]

Mark J.

> +	}
>  
> -	for (i = 0; i < pdev->num_resources; i++) {
> +	/* For non-OF case */
> +	for (; i < pdev->num_resources; i++) {
>  		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
>  				(int)pdev->resource[i].start >= 0) {
>  			ctlr = EDMA_CTLR(pdev->resource[i].start);
>  			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
> -					edma_cc[ctlr]->edma_unused);
> +				  edma_cc[ctlr]->edma_unused);
>  		}
>  	}
