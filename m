From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: MMC card removal in suspend state
Date: Fri, 06 Aug 2010 01:43:18 +0300
Message-ID: <1281048198.7148.6.camel@maxim-laptop>
References: <621C9491683D48E5992B340E62198CD6@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34450 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932865Ab0HEWnW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 18:43:22 -0400
Received: by fxm14 with SMTP id 14so3352294fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 Aug 2010 15:43:21 -0700 (PDT)
In-Reply-To: <621C9491683D48E5992B340E62198CD6@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: linux-mmc@vger.kernel.org, 'Pierre Ossman' <pierre@ossman.eu>

On Thu, 2010-08-05 at 16:45 -0500, Madhusudhan wrote: 
> Hi,
> 
> Recently, while looking at some stuff I saw the below patch done by Pierre
> which is part of the drivers/mmc/card/queue.c file. I wonder if someone can
> through more light on this to understand where could be a potential deadlock
> without calling mmc_queue_resume.
> 
> Is there a need for the mmc queue to be resumed before calling
> del_gendisk(md->disk) in the card removal path??

Very recently I have seen that memstick core hangs if queue is
suspended, and del_gendisk is called, so that hang is real.
It probably so happens that disk queue is already running at that point
so that users don't hit that hang.

Best regards,
Maxim Levitsky


> 
> Regards,
> Madhu
> 
> commit d2b46f66b4b342be07a4194bd5e82384d07e470d
> Author: Pierre Ossman <drzeus@drzeus.cx>
> Date:   Sat Apr 28 16:52:12 2007 +0200
> 
>     mmc: allow suspended block driver to be removed
> 
>     Make sure we don't deadlock when removing a suspended block
>     queue, something that might happen if the card is removed during
>     suspend.
> 
>     Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> 
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index aa75ac1..2e77963 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -191,6 +191,9 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
>         q->queuedata = NULL;
>         spin_unlock_irqrestore(q->queue_lock, flags);
> 
> +       /* Make sure the queue isn't suspended, as that will deadlock */
> +       mmc_queue_resume(mq);
> +
>         /* Then terminate our worker thread */
>         kthread_stop(mq->thread);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


