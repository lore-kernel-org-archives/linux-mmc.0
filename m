From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Thu, 21 Apr 2016 10:02:50 +0200
Message-ID: <CAPDyKFpz2Zha9Uu=r+m89WTXsbrHh5e4AnTcHcpt8Gh6AVd04A@mail.gmail.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com>
	<4790096.kDlyCl48hO@wuerfel>
	<5716A6FF.8070004@caviumnetworks.com>
	<37975265.p6gUi9hTMt@wuerfel>
	<5716BEC7.5000706@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37875 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcDUICw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 04:02:52 -0400
Received: by mail-wm0-f45.google.com with SMTP id n3so118906007wmn.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2016 01:02:51 -0700 (PDT)
In-Reply-To: <5716BEC7.5000706@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Redfearn <matt.redfearn@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On 20 April 2016 at 01:27, David Daney <ddaney@caviumnetworks.com> wrote:
> On 04/19/2016 03:09 PM, Arnd Bergmann wrote:
>>
>> On Tuesday 19 April 2016 14:45:35 David Daney wrote:
>>>
>>> On 04/19/2016 01:46 PM, Arnd Bergmann wrote:
>>>>
>>>> On Thursday 31 March 2016 16:26:53 Matt Redfearn wrote:
>>>>>
>>>>> +struct octeon_mmc_host {
>>>>> +       u64     base;
>>>>> +       u64     ndf_base;
>>>>> +       u64     emm_cfg;
>>>>> +       u64     n_minus_one;  /* OCTEON II workaround location */
>>>>> +       int     last_slot;
>>>>> +
>>>>> +       struct semaphore mmc_serializer;
>>>>
>>>>
>>>> Please don't add any new semaphores to the kernel, use a mutex or
>>>> a completion instead.
>>>
>>>
>>> The last time I checked, a mutex could not be used from interrupt
>>> context.
>>>
>>> Since we are in interrupt context and we really want mutex-like behavior
>>> here, it seems like a semaphore is just the thing we need.

So the question I have is *why* do you have to be in IRQ context when
using the semaphore...

I would rather see that you use a threaded IRQ handler, perhaps in
conjunction with a hard IRQ handler if that is needed.

>>>
>>> I am not sure how completions would be of use, perhaps you could
>>> elaborate.
>>
>>
>> Completions are used when you have one thread waiting for an event,
>> which is often an interrupt: the process calls
>> wait_for_completion(&completion); and the interrupt handler calls
>> complete(&completion);
>>
>> It seems that you are using the semaphore for two reasons here (I
>> only read it briefly so I may be wrong):
>> waiting for the interrupt handler and serializing against another
>> thread. In this case you need both a mutex (to guarantee mutual
>> exclusion) and a completion (to wait for the interrupt handler
>> to finish).
>>
>
> The way the MMC driver works is that the driver's .request() method is
> called to initiate a request.   After .request() is finished, it returns
> back to the kernel so other work can be done.

Correct.

Although to clarify a bit more, the mmc core invokes *all* mmc host
ops callbacks from non-atomic context.

>
> From the interrupt handler, when the request is complete, the interrupt
> handler calls req->done(req); to terminate the whole thing.

It may do that, but it's not the recommended method.

Instead it's better if you can deal with the request processing from a
threaded IRQ handler. When completed, you notify the mmc core via
calling mmc_request_done() which kicks the completion variable (as you
describe).

The are several benefits doing request processing from the a threaded
IRQ handler:
1. The obvious one, IRQs don't have to be disabled longer than actually needed.
2. The threaded IRQ handler is able to use mutexes.

>
>
>   So we have:
>
>   CPU-A                      CPU-B                  CPU-C
>
>   octeon_mmc_request(0)        .                     .
>      down()                    .                     .
>      queue_request(0);         .                     .
>      return;                   .                     .
>   other_useful_work            .                     .
>    .                           .                     .
>    .                           .                     .
>    .                           .                     .
>   octeon_mmc_request(1)        .                     .
>      down() -> blocks          .                     .
>                             octeon_mmc_interrupt()   .
>                                 up() -> unblocks     .
>      down() <-unblocks          req->done(0)         .
>      queue_request(1);          return;              .
>      return;                   .                     .
>   other_useful_work            .                     .
>    .                           .                octeon_mmc_interrupt()
>    .                           .                     up()
>    .                           .                     req->done(1)
>    .                           .                     return;
>    .                           .                     .
>
>
> We don't want to have the thread on CPU-A wait around in an extra mutex or
> completion for the command to finish.  The MMC core already has its own
> request waiting code, but it doesn't handle the concept of a slot. These
> commands can take hundreds or thousands of mS to terminate.  The whole idea
> of the MMC framework is to queue the request and get back to doing other
> work ASAP.
>
> In the case of this octeon_mmc driver we need to serialize the commands
> issued to multiple slots, for this we use the semaphore.  If you don't like
> struct semaphore, we would have to invent a proprietary wait queue mechanism
> that has semantics nearly identical to struct semaphore, and people would
> complain that we are reinventing the semaphore.
>
> It doesn't seem clean to cobble up multiple waiting structures (completion +
> mutex + logic that surely would contain errors) where a single (well
> debugged) struct semaphore does what we want.
>

One more thing to be added; In case you need a hard IRQ handler, you
may have to protect it from getting "spurious" IRQs etc. If not, you
can probably use IRQF_ONESHOT when registering the IRQ handler which
should allow you to use only one mutex.

Below I have tried to give you an idea of how I think it can be done,
when you do need a hard IRQ handler. I am using "host->mrq", as what
is being protected by the spinlock.


In the ->request() callback:
....
mutex_lock()
spin_lock_irqsave()

host->mrq = mrq;

spin_unlock_irqrestore()
...
---------------------

In the hard IRQ handler:
...
spin_lock()

if (!host->mrq)
  return IRQ_HANDLED;
else
  return IRQ_WAKE_THREAD;

spin_unlock()
...
---------------------

In the threaded IRQ handler:
...
spin_lock_irqsave()

mrq = host->mrq;

spin_unlock_irqrestore()
...
process request...
...
when request completed:
...
spin_lock_irqsave()

host->mrq = NULL;

spin_unlock_irqrestore()
mutex_unlock()
...
mmc_request_done()
---------------------

Do you think something along these lines should work for your case?

Kind regards
Uffe
