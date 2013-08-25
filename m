From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: fix null pointer use in mmc_blk_remove_req
Date: Sat, 24 Aug 2013 23:22:46 -0400
Message-ID: <87d2p2sbcp.fsf@octavius.laptop.org>
References: <1374671868-606-1-git-send-email-franck.jullien@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43690 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755700Ab3HYDWy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Aug 2013 23:22:54 -0400
In-Reply-To: <1374671868-606-1-git-send-email-franck.jullien@gmail.com>
	(franck jullien's message of "Wed, 24 Jul 2013 15:17:48 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: franck.jullien@gmail.com
Cc: linux-mmc@vger.kernel.org

Hi Franck,

On Wed, Jul 24 2013, franck.jullien@gmail.com wrote:
> From: Franck Jullien <franck.jullien@gmail.com>
>
> A previous commit (fdfa20c1631210d0) reordered the
> shutdown sequence in mmc_blk_remove_req. However,
> mmc_cleanup_queue is now called before we get the
> card pointer and, sadly, mmc_cleanup_queue set
> mq->card to NULL.
>
> This patch moves the card pointer assignment before
> mmc_cleanup_queue.
>
> Signed-off-by: Franck Jullien <franck.jullien@gmail.com>
> ---
>  drivers/mmc/card/block.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index cd0b7f4..f4a0bea 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2191,10 +2191,10 @@ static void mmc_blk_remove_req(struct mmc_blk_data *md)
>  		 * is freeing the queue that stops new requests
>  		 * from being accepted.
>  		 */
> +		card = md->queue.card;
>  		mmc_cleanup_queue(&md->queue);
>  		if (md->flags & MMC_BLK_PACKED_CMD)
>  			mmc_packed_clean(&md->queue);
> -		card = md->queue.card;
>  		if (md->disk->flags & GENHD_FL_UP) {
>  			device_remove_file(disk_to_dev(md->disk), &md->force_ro);
>  			if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&

Thanks for the patch, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
