From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH] mmc: sdio: avoid spurious calls to interrupt handlers
Date: Mon, 16 Apr 2012 10:58:25 +0200
Message-ID: <4F8BDF31.60102@stericsson.com>
References: <alpine.LFD.2.02.1204131639510.16314@xanadu.home>    <ffff015ed637538bd14b61b8507586ed.squirrel@www.codeaurora.org>    <alpine.LFD.2.02.1204150900080.16314@xanadu.home> <b3b6a67b5cebe0d8e90c4bfadec50f69.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:39438 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752593Ab2DPI7I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Apr 2012 04:59:08 -0400
In-Reply-To: <b3b6a67b5cebe0d8e90c4bfadec50f69.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>, Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On 04/15/2012 04:59 PM, Sujit Reddy Thumma wrote:
>
>> On Sun, 15 Apr 2012, Sujit Reddy Thumma wrote:
>>
>>> Hi Nicolas,
>>>
>>>>
>>>> Commit 06e8935feb "optimized SDIO IRQ handling for single irq"
>>>> introduced some spurious calls to SDIO function interrupt handlers,
>>>> such as when the SDIO IRQ thread is started, or the safety check
>>>> performed upon a system resume.  Let's add a flag to perform the
>>>> optimization only when a real interrupt is signaled by the host
>>>> driver and we know there is no point confirming it.
>>>>
>>>
>>> Thanks for putting up formal patch.
>>>
>>>> Reported-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>>> Signed-off-by: Nicolas Pitre<nico@linaro.org>
>>>> Cc: stable@kernel.org
>>>>
>>>> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
>>>> index f573e7f9f7..3d8ceb4084 100644
>>>> --- a/drivers/mmc/core/sdio_irq.c
>>>> +++ b/drivers/mmc/core/sdio_irq.c
>>>> @@ -28,18 +28,20 @@
>>>>
>>>>   #include "sdio_ops.h"
>>>>
>>>> -static int process_sdio_pending_irqs(struct mmc_card *card)
>>>> +static int process_sdio_pending_irqs(struct mmc_host *host)
>>>>   {
>>>> +	struct mmc_card *card = host->card;
>>>>   	int i, ret, count;
>>>>   	unsigned char pending;
>>>>   	struct sdio_func *func;
>>>>
>>>>   	/*
>>>>   	 * Optimization, if there is only 1 function interrupt registered
>>>> -	 * call irq handler directly
>>>> +	 * and we know an IRQ was signaled then call irq handler directly.
>>>> +	 * Otherwise do the full probe.
>>>>   	 */
>>>>   	func = card->sdio_single_irq;
>>>> -	if (func) {
>>>> +	if (func&&  host->sdio_irq_pending) {
>>>>   		func->irq_handler(func);
>>>>   		return 1;
>>>>   	}
>>>> @@ -116,7 +118,8 @@ static int sdio_irq_thread(void *_host)
>>>>   		ret = __mmc_claim_host(host,&host->sdio_irq_thread_abort);
>>>>   		if (ret)
>>>>   			break;
>>>> -		ret = process_sdio_pending_irqs(host->card);
>>>> +		ret = process_sdio_pending_irqs(host);
>>>> +		host->sdio_irq_pending = false;
>>>>   		mmc_release_host(host);
>>>>
>>>>   		/*
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index ee2b0363c0..557aa4cd66 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -323,6 +323,7 @@ struct mmc_host {
>>>>
>>>>   	unsigned int		sdio_irqs;
>>>>   	struct task_struct	*sdio_irq_thread;
>>>> +	bool			sdio_irq_pending;
>>>>   	atomic_t		sdio_irq_thread_abort;
>>>>
>>>>   	mmc_pm_flag_t		pm_flags;	/* requested pm features */
>>>> @@ -378,6 +379,7 @@ extern int mmc_cache_ctrl(struct mmc_host *, u8);
>>>>   static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>>>>   {
>>>>   	host->ops->enable_sdio_irq(host, 0);
>>>> +	host->sdio_irq_pending = true;
>>>>   	wake_up_process(host->sdio_irq_thread);
>>>>   }
>>>
>>> In this case probably we need to add the following:
>>> @@ -946,8 +946,11 @@ static int mmc_sdio_resume(struct mmc_host *host)
>>>                  }
>>>          }
>>>
>>> -       if (!err&&  host->sdio_irqs)
>>> -               mmc_signal_sdio_irq(host);

I think the idea with trying to signal an irq at this state is good and 
should try to be maintained somehow.

Some SDIO devices has a separate GPIO line instead of using the DAT1 
line for SDIO irq. In those cases the GPIO irq is configured as a wakeup 
irq and then the SDIO irq is handled from this point and more important 
after SDIO has been resumed.

Although I realize that the "optimized SDIO IRQ handling for single irq" 
is messing up things here. What you would like to do here is to make 
sure the CCCR register is read before really signaling the irq, even if 
there is only one irq registered. Could we think of a nice way to handle 
that I think I am in favor of keeping the SDIO irq signaling here.

>>> +       if (!err&&  host->sdio_irqs) {
>>> +               host->ops->enable_sdio_irq(host, 0);
>>> +               wake_up_process(host->sdio_irq_thread);
>>> +       }
>>
>> The call to enable_sdio_irq() is probably redundant.  Only
>> wake_up_process() should be sufficient.
>>
>
> True, I was wondering if we really need to wakeup sdio_irq_thread here. If
> there is a pending interrupt is it not the host driver supposed to wake it
> up or do you think it is needed for hosts that don't have CAP_SDIO_IRQ
> set?
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Kind regards
Ulf Hansson
