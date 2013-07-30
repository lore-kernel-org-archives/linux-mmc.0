From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: edma: Add function to manually trigger an EDMA
	channel
Date: Tue, 30 Jul 2013 10:48:37 +0530
Message-ID: <51F74CAD.3040604@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
	<1375104595-16018-4-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375104595-16018-4-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
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
Cc: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Santosh Shilimkar <santosh.shilim>
List-Id: linux-mmc@vger.kernel.org

On Monday 29 July 2013 06:59 PM, Joel Fernandes wrote:
> Manual trigger for events missed as a result of splitting a
> scatter gather list and DMA'ing it in batches. Add a helper
> function to trigger a channel incase any such events are missed.
> 
> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/common/edma.c             |   21 +++++++++++++++++++++
>  include/linux/platform_data/edma.h |    2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 3567ba1..10995b2 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1236,6 +1236,27 @@ void edma_resume(unsigned channel)
>  }
>  EXPORT_SYMBOL(edma_resume);
>  
> +int edma_manual_trigger(unsigned channel)

edma_trigger_channel() maybe? Brings consistency with
edma_alloc_channel() edma_free_channel() etc.

> +{
> +	unsigned ctlr;
> +	int j;
> +	unsigned int mask;
> +
> +	ctlr = EDMA_CTLR(channel);
> +	channel = EDMA_CHAN_SLOT(channel);
> +	mask = BIT(channel & 0x1f);
> +
> +	j = channel >> 5;
> +
> +	/* EDMA channels without event association */

May be actually check for no-event association before you trigger in
software? You can do that by looking at unused channel list, no?

> +	edma_shadow0_write_array(ctlr, SH_ESR, j, mask);

edma_shadow0_write_array(ctlr, SH_ESR, channel >> 5, mask) is no less
readable, but I leave it to you.

Thanks,
Sekhar
