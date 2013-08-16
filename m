From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 00/12] edma: Add support for SG lists of any length
Date: Fri, 16 Aug 2013 00:57:34 -0500
Message-ID: <520DBF4E.2060101@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Reply-To: <joelf-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375719297-12871-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Following offline discussions with Sekhar, we discussed some ideas to
change a few things in this patch series to make it fail-safe. As such,
the only changes we are making for v4 will be to not cyclically link
immediately but doing so only once the ISR has finished setup (apart
from other style cleanups).

Any conditions where we are not able to modify the link in time (due to
heavily loaded system) will be detected and reported by the use of
linking to a NULL set.

The new approach will be fast because of no requirement to stall or
wait, and any DMA issues with heavily loaded systems can be detected as
error conditions.

This should architecturally be the final version of the patch series to
add DMA support for SG lists of any length.

Thanks,

-Joel

On 08/05/2013 11:14 AM, Joel Fernandes wrote:
> Here is a more improved approach for DMA support of SG lists of any length
> in the EDMA DMA Engine driver.
> 
> In the previous approach [1] we depended on error interrupts to detect
> missed events and manually retrigger them, however as discussed in [2],
> there are concerns this can be trouble some for high speed peripherals
> which may need a more real-time response from the DMA controller.
> 
> In this approach, we divide the total no of MAX slots per channel, into
> 2 linked sets which are cyclically linked to each other (the cyclic
> link between the 2 sets make sure that the DMA is continuous till the whole
> SG list has exhausted). We then enable completion interrupts on both linked
> sets which results in recyling/preparing respective linked set with the
> next set of SG entries. The interrupt handler executes in parallel while
> the EDMA controller DMA's the next list. This results in no interruption.
> 
> Special handling is done for first linked set (as we set up both linked
> sets initially before starting with the DMA), and last one where the cyclic
> link has to be broken and a link to the Dummy slot has to be created.
> Also we keep track of whether all pending DMA operations have completed
> before we can mark it as complete.
> 
> [1] https://lkml.org/lkml/2013/7/29/312
> [2] https://lkml.org/lkml/2013/7/30/54
> 
> Joel Fernandes (12):
>   dma: edma: Setup parameters to DMA MAX_NR_SG at a time
>   ARM: edma: Don't clear EMR of channel in edma_stop
>   dma: edma: remove limits on number of slots
>   dma: edma: Write out and handle MAX_NR_SG at a given time
>   ARM: edma: Add function to enable interrupt for a PaRAM slot
>   ARM: edma: Add pr_debug in edma_link
>   dma: edma: Add function to dump a PaRAM set from PaRAM
>   dma: edma: Add one more required slot to MAX slots
>   dma: edma: Implement multiple linked sets for continuity
>   dma: edma: Check if MAX_NR_SG is even in prep function
>   dma: edma: Keep tracking of Pending interrupts (pending_acks)
>   dma: edma: Return if nothing left todo in edma_execute
> 
>  arch/arm/common/edma.c             |   18 ++-
>  drivers/dma/edma.c                 |  279 +++++++++++++++++++++++++++++-------
>  include/linux/platform_data/edma.h |    1 +
>  3 files changed, 243 insertions(+), 55 deletions(-)
> 
