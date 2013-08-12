From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 09/12] dma: edma: Implement multiple linked sets for
	continuity
Date: Mon, 12 Aug 2013 18:56:55 +0000
Message-ID: <52092FF7.7040508@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
	<1375719297-12871-10-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1375719297-12871-10-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
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

On Monday 05 August 2013 04:14 PM, Joel Fernandes wrote:
> Here we implement splitting up of the total MAX number of slots
> available for a channel into 2 cyclically linked sets. Transfer
> completion Interrupts are enabled on both linked sets and respective
> handler recycles them on completion to process the next linked set.
> Both linked sets are cyclically linked to each other to ensure
> continuity of DMA operations. Interrupt handlers execute asynchronously
> to the EDMA events and recycles the linked sets at the right time,
> as a result EDMA is not blocked or dependent on interrupts and DMA
> continues till the end of the SG-lists without any interruption.
> 
> Suggested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/dma/edma.c |  157 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 118 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> index df50a04..70923a2 100644
> --- a/drivers/dma/edma.c
> +++ b/drivers/dma/edma.c
> @@ -48,6 +48,7 @@
>  
>  /* Max of 16 segments per channel to conserve PaRAM slots */
>  #define MAX_NR_SG		16
> +#define MAX_NR_LS		(MAX_NR_SG >> 1)
>  #define EDMA_MAX_SLOTS		(MAX_NR_SG+1)
>  #define EDMA_DESCRIPTORS	16
>  
> @@ -57,6 +58,7 @@ struct edma_desc {
>  	int				absync;
>  	int				pset_nr;
>  	int				total_processed;
> +	int				next_setup_linkset;
>  	struct edmacc_param		pset[0];
>  };
>  
> @@ -140,7 +142,9 @@ static void edma_execute(struct edma_chan *echan)
>  	struct edma_desc *edesc;
>  	struct device *dev = echan->vchan.chan.device->dev;
>  
> -	int i, j, total_left, total_process;
> +	int i, total_left, total_link_set;
> +	int ls_cur_off, ls_next_off, slot_off;
> +	struct edmacc_param tmp_param;
>  
>  	/* If either we processed all psets or we're still not started */
>  	if (!echan->edesc ||
> @@ -159,48 +163,121 @@ static void edma_execute(struct edma_chan *echan)
>  
>  	/* Find out how many left */
>  	total_left = edesc->pset_nr - edesc->total_processed;
> -	total_process = total_left > MAX_NR_SG ? MAX_NR_SG : total_left;
> -
> -
> -	/* Write descriptor PaRAM set(s) */
> -	for (i = 0; i < total_process; i++) {
> -		j = i + edesc->total_processed;
> -		edma_write_slot(echan->slot[i], &edesc->pset[j]);
> -		dev_dbg(echan->vchan.chan.device->dev,
> -			"\n pset[%d]:\n"
> -			"  chnum\t%d\n"
> -			"  slot\t%d\n"
> -			"  opt\t%08x\n"
> -			"  src\t%08x\n"
> -			"  dst\t%08x\n"
> -			"  abcnt\t%08x\n"
> -			"  ccnt\t%08x\n"
> -			"  bidx\t%08x\n"
> -			"  cidx\t%08x\n"
> -			"  lkrld\t%08x\n",
> -			j, echan->ch_num, echan->slot[i],
> -			edesc->pset[j].opt,
> -			edesc->pset[j].src,
> -			edesc->pset[j].dst,
> -			edesc->pset[j].a_b_cnt,
> -			edesc->pset[j].ccnt,
> -			edesc->pset[j].src_dst_bidx,
> -			edesc->pset[j].src_dst_cidx,
> -			edesc->pset[j].link_bcntrld);
> -		/* Link to the previous slot if not the last set */
> -		if (i != (total_process - 1))

> +	total_link_set = total_left > MAX_NR_LS ? MAX_NR_LS : total_left;

The name you gave here sounds like this is defining total number of
linked PaRAM sets. Rather this is actually tracking the number of PaRAM
sets (slots) in current linked set, correct? Then may be just call it
'nslots' or even 'num_slots'? There are just too many variables with
"total" prefix to keep track of in this function!

> +
> +	/* First time, setup 2 cyclically linked sets, each containing half
> +	   the slots allocated for this channel */
> +	if (edesc->total_processed == 0) {

We dont need to check for this case for every DMA_COMPLETE interrupt.
May be move the initial setup to another function called from
edma_issue_pending()?

> +		for (i = 0; i < total_link_set; i++) {
> +			edma_write_slot(echan->slot[i+1], &edesc->pset[i]);
> +
> +			if (i != total_link_set - 1) {
> +				edma_link(echan->slot[i+1], echan->slot[i+2]);
> +				dump_pset(echan, echan->slot[i+1],
> +					  edesc->pset, i);
> +			}
> +		}
> +
> +		edesc->total_processed += total_link_set;
> +
> +		total_left = edesc->pset_nr - edesc->total_processed;
> +
> +		total_link_set = total_left > MAX_NR_LS ?
> +				 MAX_NR_LS : total_left;
> +
> +		if (total_link_set) {
> +			/* Don't setup interrupt for first linked set for cases
> +			   where total pset_nr is strictly within MAX_NR size */

See Documentation/CodingStyle for multi-line commenting style.

> +			if (total_left > total_link_set)
> +				edma_enable_interrupt(echan->slot[i]);
> +
> +			/* Setup link between linked set 0 to set 1 */
>  			edma_link(echan->slot[i], echan->slot[i+1]);
> -		/* Final pset links to the dummy pset */
> -		else
> +
> +			dump_pset(echan, echan->slot[i], edesc->pset, i-1);
> +
> +			/* Write out linked set 1 */
> +			for (; i < total_link_set + MAX_NR_LS; i++) {
> +				edma_write_slot(echan->slot[i+1],
> +						&edesc->pset[i]);
> +
> +				if (i != total_link_set + MAX_NR_LS - 1) {
> +					edma_link(echan->slot[i+1],
> +						  echan->slot[i+2]);
> +					dump_pset(echan, echan->slot[i+1],
> +						  edesc->pset, i);
> +				}
> +			}
> +
> +			edesc->total_processed += total_link_set;
> +			total_left = edesc->pset_nr - edesc->total_processed;

There is way too much duplication of code here mainly because you
decided not to loop twice in the course of setting up the two linked
sets. Can you use a loop instead?

> +
> +			if (total_left)
> +				/* Setup a link from linked set 1 to set 0 */
> +				edma_link(echan->slot[i], echan->slot[1]);

If you have more SGs to service at the end of setting up the two linked
sets, you should stop right there and wait for CPU to recycle the linked
sets. Right now you are setup for re-DMAing old data.

You wont hit this issue in testing because you have setup an interrupt
for LS0 and that will most likely service before LS1 completes but we
cannot rely on that timing.

Just link to dummy at end of LS1 to stall the DMA and wait for the
completion handler to come-in and restart the DMA after recycling LS0.

I haven't reviewed rest of the patch. Lets make sure we have a common
understanding here.

Thanks,
Sekhar
