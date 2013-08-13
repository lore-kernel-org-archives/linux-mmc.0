From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 01/12] dma: edma: Setup parameters to DMA MAX_NR_SG
	at a time
Date: Mon, 12 Aug 2013 19:05:33 -0500
Message-ID: <5209784D.8080502@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
	<1375719297-12871-2-git-send-email-joelf@ti.com>
	<52088B8B.9040000@ti.com>
Reply-To: <joelf-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <52088B8B.9040000-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Responding to other comments in this post,

On 08/12/2013 02:15 AM, Sekhar Nori wrote:

[..]
>>  	if (unlikely(!echan || !sgl || !sg_len))
>>  		return NULL;
>> @@ -262,8 +262,11 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>>  
>>  	edesc->pset_nr = sg_len;
>>  
>> -	for_each_sg(sgl, sg, sg_len, i) {
>> -		/* Allocate a PaRAM slot, if needed */
>> +	/* Allocate a PaRAM slot, if needed */
>> +
>> +	num_slots_needed = sg_len > MAX_NR_SG ? MAX_NR_SG : sg_len;
> 
> nslots = min(MAX_NR_SG, sg_len);

Changed to this, with the +1

> 
>> +
>> +	for (i = 0; i < num_slots_needed; i++) {
>>  		if (echan->slot[i] < 0) {
>>  			echan->slot[i] =
>>  				edma_alloc_slot(EDMA_CTLR(echan->ch_num),
>> @@ -273,6 +276,10 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>>  				return NULL;
>>  			}
>>  		}
>> +	}
>> +
>> +	/* Configure PaRAM sets for each SG */
>> +	for_each_sg(sgl, sg, sg_len, i) {
>>  
>>  		acnt = dev_width;
>>  
>> @@ -330,6 +337,7 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
>>  		/* Configure A or AB synchronized transfers */
>>  		if (edesc->absync)
>>  			edesc->pset[i].opt |= SYNCDIM;
>> +
> 
> Random extra newline.

Removing..

> 
> The patch as such is fine, but I dont think it makes lot of sense
> standalone. This needs to be merged into the patch where you actually
> handle the entire SG list in batches.

I think it does actually, this patch just takes care of preparing the
param set list correctly and allocating slots. It doesn't the actual DMA
or take part in the algorithm. As a result, the patch can be reused
incase in future the main algorithm is rewritten in a subsequent series.
Further this patch was reused straight from old implementation so it
proved to be useful being a separate patch last time. I also plan to
rewrite just this functionality in the future.

Thanks,

-Joel
