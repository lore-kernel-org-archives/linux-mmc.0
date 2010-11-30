From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] mmcoops with panic/oops
Date: Tue, 30 Nov 2010 14:51:41 -0800
Message-ID: <20101130145141.d01f277f.akpm@linux-foundation.org>
References: <4CF4B8E5.9070604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48314 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751727Ab0K3WwW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 17:52:22 -0500
In-Reply-To: <4CF4B8E5.9070604@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>

On Tue, 30 Nov 2010 17:42:13 +0900
Jaehoon Chung <jh80.chung@samsung.com> wrote:

> This patch is mmcoops.
> 
> When Kernel panic or oops, write panic log to circular buffer in eMMC.
> then after reset, we can see the log in MMC.
> 
> So we need change mmc_wait_for_req().
> because if we used schedule(), we can find atomic schedule warning.
> That is not our needs log. so i used delay.
> i want to know how about __mmc_wait_for_req()
> 
> If any question, let me know.
> 
> ...
>  
>  /**
> - *	mmc_wait_for_req - start a request and wait for completion
> + *	__mmc_wait_for_req - start a request and wait for completion
>   *	@host: MMC host to start command
>   *	@mrq: MMC request to start
> + *	@panic: kernel panic/oops or not
>   *
>   *	Start a new MMC custom command request for a host, and wait
>   *	for the command to complete. Does not attempt to parse the
>   *	response.
>   */
> -void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
> +void __mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq,
> +		int panic)
>  {
> -	DECLARE_COMPLETION_ONSTACK(complete);
> +	if (panic) {
> +		DECLARE_WAITQUEUE(wait, current);
> +
> +		mmc_start_request(host, mrq);
> +
> +		spin_lock_irq(&host->wq.lock);
> +		init_waitqueue_head(&host->wq);
> +
> +		add_wait_queue_exclusive(&host->wq, &wait);
> +		set_current_state(TASK_UNINTERRUPTIBLE);
>  
> -	mrq->done_data = &complete;
> -	mrq->done = mmc_wait_done;
> +		mdelay(10);
> +		spin_unlock_irq(&host->wq.lock);
> +	} else {
> +		DECLARE_COMPLETION_ONSTACK(complete);
> +
> +		mrq->done_data = &complete;
> +		mrq->done = mmc_wait_done;
> +
> +		mmc_start_request(host, mrq);
> +
> +		wait_for_completion(&complete);
> +	}
> +}

This approach seems somewhat OK - it will only do the busy-wait in the
"panic=1" case, so existing callers shouldn't be affected.  (`panic'
could have had type `bool', btw).

That being said, the code is odd/wrong.

void __mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq,
		int panic)
{
	if (panic) {
		DECLARE_WAITQUEUE(wait, current);

		mmc_start_request(host, mrq);

		spin_lock_irq(&host->wq.lock);
		init_waitqueue_head(&host->wq);

		add_wait_queue_exclusive(&host->wq, &wait);
		set_current_state(TASK_UNINTERRUPTIBLE);

		mdelay(10);
		spin_unlock_irq(&host->wq.lock);
	} else {

Surely the waitqueue is unneeded and the missing remove_wait_queue() is a
bug and the set_current_state() is a bug and the spin_lock_irq()
appears to be unneeded.  afaict you want this:

void __mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq,
		int panic)
{
	if (panic) {
		mmc_start_request(host, mrq);
		mdelay(10);
	} else {


However it is pretty bad to just delay 10 milliseconds and then assume
that the request has completed.  Would it not be better to poll for the
IRQ completion, or to poll some hardware flag?

(We can't poll for IRQ completion if the caller has disabled IRQs, but
if the caller has disabled IRQs then the use of spin_lock_irq() instead
of spin_lock_irqsave() is yet another bug!)
