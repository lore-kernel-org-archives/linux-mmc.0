From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc: queue: amend buffer swap for non-blocking transfer
Date: Tue, 23 Oct 2012 17:01:46 -0400
Message-ID: <877gqgj41x.fsf@octavius.laptop.org>
References: <00fe01cd9d61$d2f6f180$78e4d480$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55209 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965259Ab2JWVBw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 17:01:52 -0400
In-Reply-To: <00fe01cd9d61$d2f6f180$78e4d480$%jun@samsung.com> (Seungwon
	Jeon's message of "Fri, 28 Sep 2012 19:12:53 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Per Forlin' <per.forlin@linaro.org>

Hi,

On Fri, Sep 28 2012, Seungwon Jeon wrote:
> In case both 'req' and 'mq->mqrq_prev->req' are null, there is no request
> to be processed. That means there is no need to switch buffer.
> Switching buffer is required only after finishing 'issue_fn'.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/card/queue.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e360a97..fadf52e 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -68,6 +68,16 @@ static int mmc_queue_thread(void *d)
>  		if (req || mq->mqrq_prev->req) {
>  			set_current_state(TASK_RUNNING);
>  			mq->issue_fn(mq, req);
> +
> +			/*
> +			 * Current request becomes previous request
> +			 * and vice versa.
> +			 */
> +			mq->mqrq_prev->brq.mrq.data = NULL;
> +			mq->mqrq_prev->req = NULL;
> +			tmp = mq->mqrq_prev;
> +			mq->mqrq_prev = mq->mqrq_cur;
> +			mq->mqrq_cur = tmp;
>  		} else {
>  			if (kthread_should_stop()) {
>  				set_current_state(TASK_RUNNING);
> @@ -77,13 +87,6 @@ static int mmc_queue_thread(void *d)
>  			schedule();
>  			down(&mq->thread_sem);
>  		}
> -
> -		/* Current request becomes previous request and vice versa. */
> -		mq->mqrq_prev->brq.mrq.data = NULL;
> -		mq->mqrq_prev->req = NULL;
> -		tmp = mq->mqrq_prev;
> -		mq->mqrq_prev = mq->mqrq_cur;
> -		mq->mqrq_cur = tmp;
>  	} while (1);
>  	up(&mq->thread_sem);

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
