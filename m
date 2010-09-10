From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: failure of block read wait for long time
Date: Fri, 10 Sep 2010 17:00:01 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026ED@dbde02.ent.ti.com>
References: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
 <4C4EDD85.5060606@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E417D80@dbde02.ent.ti.com>
 <4C4FED36.3010607@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40152 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab0IJLaQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Sep 2010 07:30:16 -0400
In-Reply-To: <4C4FED36.3010607@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Wednesday, July 28, 2010 2:11 PM
> To: Ghorai, Sukumar
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> 
> ext Ghorai, Sukumar wrote:
> >
> >> -----Original Message-----
> >> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> >> Sent: Tuesday, July 27, 2010 6:52 PM
> >> To: Ghorai, Sukumar
> >> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> >>
> >> Sukumar Ghorai wrote:
> >>>  multi-block read failure retries in single block read one by one. It
> >> continues
> >>>  retry of subsequent blocks, even after failure. Application will not
> be
> >> able
> >>>  to decode the interleave data (even if few single block read success).
> >>>  This patch fixes this problem by returning at the first failure
> instead
> >> of
> >>>  waiting for long duration.
> >> How can you know what sectors are important to the upper layers?
> > [Ghorai]
> > 1. This is obvious either give the complete data to above layer or not.
> And every protocol follows that.
> >
> > 2. And other scenario, say apps request for to read the 128MB data and
> it will take quite long time before returning in failure case.
> >
> > 3. it is quite obvious if the read fail for sector(x) it will fail for
> sector(x+1)
> >
> 
> None of that is exactly true.  However you could change the retry
> from sectors to segments e.g.
> 
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index d545f79..5ed15f6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -321,13 +321,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq,
> struct request *req)
>  	struct mmc_blk_data *md = mq->data;
>  	struct mmc_card *card = md->queue.card;
>  	struct mmc_blk_request brq;
> -	int ret = 1, disable_multi = 0;
> +	int ret = 1, retrying = 0;
> 
>  	mmc_claim_host(card->host);
> 
>  	do {
>  		struct mmc_command cmd;
>  		u32 readcmd, writecmd, status = 0;
> +		unsigned int blocks;
> 
>  		memset(&brq, 0, sizeof(struct mmc_blk_request));
>  		brq.mrq.cmd = &brq.cmd;
> @@ -341,23 +342,26 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq,
> struct request *req)
>  		brq.stop.opcode = MMC_STOP_TRANSMISSION;
>  		brq.stop.arg = 0;
>  		brq.stop.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> -		brq.data.blocks = blk_rq_sectors(req);
> +
> +		/*
> +		 * After a read error, we redo the request one segment at a
> time
> +		 * in order to accurately determine which segments can be read
> +		 * successfully.
> +		 */
> +		if (retrying)
> +			blocks = blk_rq_cur_sectors(req);
> +		else
> +			blocks = blk_rq_sectors(req);
> 
>  		/*
>  		 * The block layer doesn't support all sector count
>  		 * restrictions, so we need to be prepared for too big
>  		 * requests.
>  		 */
> -		if (brq.data.blocks > card->host->max_blk_count)
> -			brq.data.blocks = card->host->max_blk_count;
> +		if (blocks > card->host->max_blk_count)
> +			blocks = card->host->max_blk_count;
> 
> -		/*
> -		 * After a read error, we redo the request one sector at a
> time
> -		 * in order to accurately determine which sectors can be read
> -		 * successfully.
> -		 */
> -		if (disable_multi && brq.data.blocks > 1)
> -			brq.data.blocks = 1;
> +		brq.data.blocks = blocks;
> 
>  		if (brq.data.blocks > 1) {
>  			/* SPI multiblock writes terminate using a special
> @@ -418,11 +422,14 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq,
> struct request *req)
>  		 * programming mode even when things go wrong.
>  		 */
>  		if (brq.cmd.error || brq.data.error || brq.stop.error) {
> -			if (brq.data.blocks > 1 && rq_data_dir(req) == READ) {
> -				/* Redo read one sector at a time */
> -				printk(KERN_WARNING "%s: retrying using single "
> -				       "block read\n", req->rq_disk->disk_name);
> -				disable_multi = 1;
> +			if (!retrying && rq_data_dir(req) == READ &&
> +			    blk_rq_cur_sectors(req) &&
> +			    blk_rq_cur_sectors(req) < blocks) {
> +				/* Redo read one segment at a time */
> +				printk(KERN_WARNING "%s: retrying read one "
> +						    "segment at a time\n",
> +						    req->rq_disk->disk_name);
> +				retrying = 1;
>  				continue;
>  			}
>  			status = get_card_status(card, req);
> @@ -486,12 +493,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq,
> struct request *req)
>  		if (brq.cmd.error || brq.stop.error || brq.data.error) {
>  			if (rq_data_dir(req) == READ) {
>  				/*
> -				 * After an error, we redo I/O one sector at a
> +				 * After an error, we redo I/O one segment at a
>  				 * time, so we only reach here after trying to
> -				 * read a single sector.
> +				 * read a single segment.  Error out the whole
> +				 * segment and continue to the next.
>  				 */
>  				spin_lock_irq(&md->lock);
> -				ret = __blk_end_request(req, -EIO,
> brq.data.blksz);
> +				ret = __blk_end_request(req, -EIO,
> blk_rq_cur_sectors(req) << 9);
>  				spin_unlock_irq(&md->lock);
>  				continue;
>  			}
> 
> 
> >>> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> >>> ---
> >>>  drivers/mmc/card/block.c |    1 -
> >>>  1 files changed, 0 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >>> index cb9fbc8..cfb0827 100644
> >>> --- a/drivers/mmc/card/block.c
> >>> +++ b/drivers/mmc/card/block.c
> >>> @@ -419,7 +419,6 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
> >> struct request *req)
> >>>  				spin_lock_irq(&md->lock);
> >>>  				ret = __blk_end_request(req, -EIO,
> >> brq.data.blksz);
> >>>  				spin_unlock_irq(&md->lock);
> >>> -				continue;
> >>>  			}
> >>>  			goto cmd_err;
> >>>  		}
> >>> --
[Ghorai] Adrian,
Yes this works and reduced the retry by 1/4 (2048 to 512 times for 1MB data read) form the original code;

Initially it was retrying for each page(512 bytes) after multi-block read fail; but this solution is retying for each segment(2048 bytes); 

1. Now say block layrer reading 1MB and failed for the 1st segment. So it will still retry for 1MB/2048-bytes, i.e. 512 times.
2. So do you think any good reason to retry again and again? 
3. And again I mentioned how to inform the blok-layer that which segment having the valid data? 

And I was suggesting for not to retry again if 1st retry (single block) failed.
http://comments.gmane.org/gmane.linux.kernel.mmc/2714

> >>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >
> > Regards,
> > Ghorai
> >

