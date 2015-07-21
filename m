From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc:Fix refcount leak in the function mmc_queue_resume
 for the semaphone thread_sem
Date: Tue, 21 Jul 2015 12:54:02 +0200
Message-ID: <CAPDyKFpvCFCB5VwaRUvq7X0bkEsxUDQ9GsnbCMSi7MOrAXhgFg@mail.gmail.com>
References: <1436278245-12078-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36514 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbbGUKyE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 06:54:04 -0400
Received: by qkdv3 with SMTP id v3so129809817qkd.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 03:54:03 -0700 (PDT)
In-Reply-To: <1436278245-12078-1-git-send-email-xerofoify@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Mike Snitzer <snitzer@redhat.com>, Yunpeng Gao <yunpeng.gao@intel.com>, Fabian Frederick <fabf@skynet.be>, Joe Perches <joe@perches.com>, Bhuvanesh <bhuvanesh_surachari@mentor.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Rabin Vincent <rabin.vincent@axis.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 7 July 2015 at 16:10, Nicholas Krause <xerofoify@gmail.com> wrote:
> This fixes the unneeded possible freeing of the semaphone lock
> thread_sem as part of the passed mmc_queue structure pointer
> mq to the function mmc_queue_resume by calling up on this lock
> now due to this lock's refcount never being incremented by the
> caller before the call to this particular function by means of
> the function down.

I guess you only looked at the code, but didn't actually notice any bug/hang?

>
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/mmc/card/queue.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index b5a2b14..97a80f6 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -438,8 +438,6 @@ void mmc_queue_resume(struct mmc_queue *mq)
>         if (mq->flags & MMC_QUEUE_SUSPENDED) {
>                 mq->flags &= ~MMC_QUEUE_SUSPENDED;
>
> -               up(&mq->thread_sem);
> -

This should be balanced from mmc_queue_suspend(), so it's likely a bad
idea to remove "up()" here. :-)

>                 spin_lock_irqsave(q->queue_lock, flags);
>                 blk_start_queue(q);
>                 spin_unlock_irqrestore(q->queue_lock, flags);
> --
> 2.1.4
>

Kind regards
Uffe
