From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: name mmc queue thread by host index
Date: Thu, 30 Sep 2010 23:40:36 +0100
Message-ID: <20100930224036.GA29160@void.printf.net>
References: <AANLkTikNzqe4ppJhGWapSwvXbpqABAjybOevwRds1Ou+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40130 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756775Ab0I3Wkh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Sep 2010 18:40:37 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikNzqe4ppJhGWapSwvXbpqABAjybOevwRds1Ou+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ethan Du <ethan.too@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Ethan,

On Mon, Sep 27, 2010 at 10:22:20AM +0800, Ethan Du wrote:
> Usually there are multiple mmc host controllers, rename mmc queue thread
> by host index, so we can easily identify which controller it belongs to
> 
> Signed-off-by: Ethan Du <ethan.too@gmail.com>
> ---
>  drivers/mmc/card/queue.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e876678..673bbdb 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -211,7 +211,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct
> mmc_card *card, spinlock_t *lock
> 
>  	init_MUTEX(&mq->thread_sem);
> 
> -	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd");
> +	mq->thread = kthread_run(mmc_queue_thread, mq, "mmcqd/%d",
> +		host->index);
>  	if (IS_ERR(mq->thread)) {
>  		ret = PTR_ERR(mq->thread);
>  		goto free_bounce_sg;
> -- 
> 1.5.6.5

Thanks, applied to mmc-next.  (This patch was line-wrapped; please
fix that next time.)

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
