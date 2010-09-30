From: Ethan Du <ethan.too@gmail.com>
Subject: Re: [PATCH] MMC: name mmc queue thread by host index
Date: Thu, 30 Sep 2010 08:22:55 +0800
Message-ID: <AANLkTi=eXgZ8+HbKXH6wE0z9ksDuf+3GXWrbb+1=tBSk@mail.gmail.com>
References: <AANLkTi=4mAFOZAMqg6oFs0ry9X8vxYh9ZU_Wz-Y+q9W6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42615 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab0I3AXA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2010 20:23:00 -0400
Received: by qyk36 with SMTP id 36so1766352qyk.19
        for <linux-mmc@vger.kernel.org>; Wed, 29 Sep 2010 17:22:59 -0700 (PDT)
In-Reply-To: <AANLkTi=4mAFOZAMqg6oFs0ry9X8vxYh9ZU_Wz-Y+q9W6@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

Anyone interested?
It always takes time to identify a problem with several processes all
named mmcqd there

On Sun, Sep 26, 2010 at 4:34 PM, Ethan Du <ethan.too@gmail.com> wrote:
> Usually there are multiple mmc host controllers, rename mmc queue thr=
ead
> =A0=A0=A0 by host index, so we can easily identify which controller i=
t belongs to
>
> Signed-off-by: Ethan <ethan.too@gmail.com>
> ---
> =A0drivers/mmc/card/queue.c |=A0=A0=A0 3 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e876678..673bbdb 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -211,7 +211,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct m=
mc_card
> *card, spinlock_t *lock
>
> =A0=A0=A0=A0 init_MUTEX(&mq->thread_sem);
>
> -=A0=A0=A0 mq->thread =3D kthread_run(mmc_queue_thread, mq, "mmcqd");
> +=A0=A0=A0 mq->thread =3D kthread_run(mmc_queue_thread, mq, "mmcqd/%d=
",
> +=A0=A0=A0 =A0=A0=A0 host->index);
> =A0=A0=A0=A0 if (IS_ERR(mq->thread)) {
> =A0=A0=A0=A0 =A0=A0=A0 ret =3D PTR_ERR(mq->thread);
> =A0=A0=A0=A0 =A0=A0=A0 goto free_bounce_sg;
> --
> 1.5.6.5
>
>
