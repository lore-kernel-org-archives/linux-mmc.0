From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1 linux-next] mmc: queue: use swap() in mmc_queue_thread()
Date: Mon, 15 Jun 2015 11:54:32 +0200
Message-ID: <CAPDyKFqqBk-j80T3DZSoeT6o=+E+2ze62EPnQji9B5s+5bkdsQ@mail.gmail.com>
References: <1433953854-23343-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34082 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbbFOJyd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2015 05:54:33 -0400
Received: by qgf75 with SMTP id 75so24864961qgf.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 02:54:32 -0700 (PDT)
In-Reply-To: <1433953854-23343-1-git-send-email-fabf@skynet.be>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc <linux-mmc@vger.kernel.org>

On 10 June 2015 at 18:30, Fabian Frederick <fabf@skynet.be> wrote:
> Use kernel.h macro definition.
>
> Thanks to Julia Lawall for Coccinelle scripting support.
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Thanks, applied.

Kind regards
Uffe

> ---
>  drivers/mmc/card/queue.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 8efa368..d34e09b 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -56,7 +56,6 @@ static int mmc_queue_thread(void *d)
>         down(&mq->thread_sem);
>         do {
>                 struct request *req = NULL;
> -               struct mmc_queue_req *tmp;
>                 unsigned int cmd_flags = 0;
>
>                 spin_lock_irq(q->queue_lock);
> @@ -86,9 +85,7 @@ static int mmc_queue_thread(void *d)
>
>                         mq->mqrq_prev->brq.mrq.data = NULL;
>                         mq->mqrq_prev->req = NULL;
> -                       tmp = mq->mqrq_prev;
> -                       mq->mqrq_prev = mq->mqrq_cur;
> -                       mq->mqrq_cur = tmp;
> +                       swap(mq->mqrq_prev, mq->mqrq_cur);
>                 } else {
>                         if (kthread_should_stop()) {
>                                 set_current_state(TASK_RUNNING);
> --
> 2.4.2
>
