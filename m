From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Thu, 21 Apr 2016 14:44:08 +0200
Message-ID: <CAPDyKFpM4P8LrAnVB5kRxWrgEfPS7iTtF=YBeKuyvSM=O-KF8w@mail.gmail.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com>
	<5716BEC7.5000706@caviumnetworks.com>
	<CAPDyKFpz2Zha9Uu=r+m89WTXsbrHh5e4AnTcHcpt8Gh6AVd04A@mail.gmail.com>
	<4647014.anjrLICQKc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38474 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbcDUMoK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 08:44:10 -0400
Received: by mail-wm0-f47.google.com with SMTP id u206so130557945wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2016 05:44:09 -0700 (PDT)
In-Reply-To: <4647014.anjrLICQKc@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Daney <ddaney@caviumnetworks.com>, Matt Redfearn <matt.redfearn@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

[...]

>> So the question I have is *why* do you have to be in IRQ context when
>> using the semaphore...
>>
>> I would rather see that you use a threaded IRQ handler, perhaps in
>> conjunction with a hard IRQ handler if that is needed.
>
> That does not solve the problem though: it is not allowed for a mutex
> to be taken in the request function but released in the interrupt,
> both have to be in the same thread.
>
> Using a threaded IRQ handler would help by avoiding the spinlock
> inside of it (it could be replaced with a mutex there), but it
> doesn't solve the problem of serializing between the slots.

My point is, the may not need to be released in the IRQ handler, but
instead in the threaded IRQ handler.

>
>> >>> I am not sure how completions would be of use, perhaps you could
>> >>> elaborate.
>> >>
>> >>
>> >> Completions are used when you have one thread waiting for an event,
>> >> which is often an interrupt: the process calls
>> >> wait_for_completion(&completion); and the interrupt handler calls
>> >> complete(&completion);
>> >>
>> >> It seems that you are using the semaphore for two reasons here (I
>> >> only read it briefly so I may be wrong):
>> >> waiting for the interrupt handler and serializing against another
>> >> thread. In this case you need both a mutex (to guarantee mutual
>> >> exclusion) and a completion (to wait for the interrupt handler
>> >> to finish).
>> >>
>> >
>> > The way the MMC driver works is that the driver's .request() method is
>> > called to initiate a request.   After .request() is finished, it returns
>> > back to the kernel so other work can be done.
>>
>> Correct.
>>
>> Although to clarify a bit more, the mmc core invokes *all* mmc host
>> ops callbacks from non-atomic context.
>
> Oh, so you mean the .request() function must not sleep and cannot
> call mutex_lock() or down() or wait_event()?

No.

*non-atomic* context. :-)

I should probably said thread/process context instead.

[...]

>>
>>
>> In the ->request() callback:
>> ....
>> mutex_lock()
>> spin_lock_irqsave()
>>
>> host->mrq = mrq;
>>
>> spin_unlock_irqrestore()
>> ...
>> ---------------------
>>
>> In the hard IRQ handler:
>> ...
>> spin_lock()
>>
>> if (!host->mrq)
>>   return IRQ_HANDLED;
>> else
>>   return IRQ_WAKE_THREAD;
>>
>> spin_unlock()
>> ...
>> ---------------------
>>
>> In the threaded IRQ handler:
>> ...
>> spin_lock_irqsave()
>>
>> mrq = host->mrq;
>>
>> spin_unlock_irqrestore()
>> ...
>> process request...
>> ...
>> when request completed:
>> ...
>> spin_lock_irqsave()
>>
>> host->mrq = NULL;
>>
>> spin_unlock_irqrestore()
>> mutex_unlock()
>> ...
>> mmc_request_done()
>> ---------------------
>>
>> Do you think something along these lines should work for your case?
>
> This is the case I described above, it is against the rules for mutexes()
> and you will get a lockdep warning if you attempt this.

No.

Considering my comments in this reply, can you please re-think and see
if my solution could make sense?

Kind regards
Uffe
