From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/4] mmc: queue: append partition subname to queue thread
 name
Date: Fri, 24 Jun 2011 11:44:20 +0900
Message-ID: <4E03FA04.5090001@samsung.com>
References: <1308825629-27375-1-git-send-email-adrian.hunter@intel.com>
 <1308825629-27375-4-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17843 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab1FXCol (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2011 22:44:41 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LN900ICTWXWG7I0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Jun 2011 11:44:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LN900F82WXXA3@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Jun 2011 11:44:21 +0900 (KST)
In-reply-to: <1308825629-27375-4-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Andrei Warkentin <andreiw@motorola.com>

Hi Adrian..

I also found this problem..
So i confused the same mmcdq name.

Thanks for fixed the mmcqd name.

Regards,
Jaehoon Chung

Adrian Hunter wrote:
> For example, an eMMC with 2 boot partitions will have 3 threads.
> The names change from:
> 
>    40 ?        00:00:00 mmcqd/0
>    41 ?        00:00:00 mmcqd/0
>    42 ?        00:00:00 mmcqd/0
> 
> to:
> 
>    40 ?        00:00:00 mmcqd/0
>    41 ?        00:00:00 mmcqd/0boot0
>    42 ?        00:00:00 mmcqd/0boot1
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/card/block.c |    2 +-
>  drivers/mmc/card/queue.c |    8 +++++---
>  drivers/mmc/card/queue.h |    3 ++-
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index d36b7ea..bee2106 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1167,7 +1167,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>  	INIT_LIST_HEAD(&md->part);
>  	md->usage = 1;
>  
> -	ret = mmc_init_queue(&md->queue, card, &md->lock);
> +	ret = mmc_init_queue(&md->queue, card, &md->lock, subname);
>  	if (ret)
>  		goto err_putdisk;
>  
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index c07322c..3e2db1c 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -106,10 +106,12 @@ static void mmc_request(struct request_queue *q)
>   * @mq: mmc queue
>   * @card: mmc card to attach this queue
>   * @lock: queue lock
> + * @subname: partition subname
>   *
>   * Initialise a MMC card request queue.
>   */
> -int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock)
> +int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
> +		   spinlock_t *lock, const char *subname)
>  {
>  	struct mmc_host *host = card->host;
>  	u64 limit = BLK_BOUNCE_HIGH;
> @@ -209,8 +211,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card, spinlock_t *lock
>  
>  	sema_init(&mq->thread_sem, 1);
>  
> -	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d",
> -		host->index);
> +	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d%s",
> +		host->index, subname ? subname : "");
>  
>  	if (IS_ERR(mq->thread)) {
>  		ret = PTR_ERR(mq->thread);
> diff --git a/drivers/mmc/card/queue.h b/drivers/mmc/card/queue.h
> index 64e66e0..6223ef8 100644
> --- a/drivers/mmc/card/queue.h
> +++ b/drivers/mmc/card/queue.h
> @@ -19,7 +19,8 @@ struct mmc_queue {
>  	unsigned int		bounce_sg_len;
>  };
>  
> -extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *);
> +extern int mmc_init_queue(struct mmc_queue *, struct mmc_card *, spinlock_t *,
> +			  const char *);
>  extern void mmc_cleanup_queue(struct mmc_queue *);
>  extern void mmc_queue_suspend(struct mmc_queue *);
>  extern void mmc_queue_resume(struct mmc_queue *);

