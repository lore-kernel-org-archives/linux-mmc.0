From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RESEND PATCH v7 2/2] mmc: OCTEON: Add host driver for OCTEON
 MMC controller
Date: Tue, 19 Apr 2016 16:27:03 -0700
Message-ID: <5716BEC7.5000706@caviumnetworks.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <4790096.kDlyCl48hO@wuerfel> <5716A6FF.8070004@caviumnetworks.com> <37975265.p6gUi9hTMt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0068.outbound.protection.outlook.com ([207.46.100.68]:7947
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753117AbcDSX1K (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Apr 2016 19:27:10 -0400
In-Reply-To: <37975265.p6gUi9hTMt@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matt Redfearn <matt.redfearn@imgtec.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>

On 04/19/2016 03:09 PM, Arnd Bergmann wrote:
> On Tuesday 19 April 2016 14:45:35 David Daney wrote:
>> On 04/19/2016 01:46 PM, Arnd Bergmann wrote:
>>> On Thursday 31 March 2016 16:26:53 Matt Redfearn wrote:
>>>> +struct octeon_mmc_host {
>>>> +	u64	base;
>>>> +	u64	ndf_base;
>>>> +	u64	emm_cfg;
>>>> +	u64	n_minus_one;  /* OCTEON II workaround location */
>>>> +	int	last_slot;
>>>> +
>>>> +	struct semaphore mmc_serializer;
>>>
>>> Please don't add any new semaphores to the kernel, use a mutex or
>>> a completion instead.
>>
>> The last time I checked, a mutex could not be used from interrupt context.
>>
>> Since we are in interrupt context and we really want mutex-like behavior
>> here, it seems like a semaphore is just the thing we need.
>>
>> I am not sure how completions would be of use, perhaps you could elaborate.
>
> Completions are used when you have one thread waiting for an event,
> which is often an interrupt: the process calls
> wait_for_completion(&completion); and the interrupt handler calls
> complete(&completion);
>
> It seems that you are using the semaphore for two reasons here (I
> only read it briefly so I may be wrong):
> waiting for the interrupt handler and serializing against another
> thread. In this case you need both a mutex (to guarantee mutual
> exclusion) and a completion (to wait for the interrupt handler
> to finish).
>

The way the MMC driver works is that the driver's .request() method is 
called to initiate a request.   After .request() is finished, it returns 
back to the kernel so other work can be done.

 From the interrupt handler, when the request is complete, the interrupt 
handler calls req->done(req); to terminate the whole thing.


   So we have:

   CPU-A                      CPU-B                  CPU-C

   octeon_mmc_request(0)        .                     .
      down()                    .                     .
      queue_request(0);         .                     .
      return;                   .                     .
   other_useful_work            .                     .
    .                           .                     .
    .                           .                     .
    .                           .                     .
   octeon_mmc_request(1)        .                     .
      down() -> blocks          .                     .
                             octeon_mmc_interrupt()   .
                                 up() -> unblocks     .
      down() <-unblocks          req->done(0)         .
      queue_request(1);          return;              .
      return;                   .                     .
   other_useful_work            .                     .
    .                           .                octeon_mmc_interrupt()
    .                           .                     up()
    .                           .                     req->done(1)
    .                           .                     return;
    .                           .                     .


We don't want to have the thread on CPU-A wait around in an extra mutex 
or completion for the command to finish.  The MMC core already has its 
own request waiting code, but it doesn't handle the concept of a slot. 
These commands can take hundreds or thousands of mS to terminate.  The 
whole idea of the MMC framework is to queue the request and get back to 
doing other work ASAP.

In the case of this octeon_mmc driver we need to serialize the commands 
issued to multiple slots, for this we use the semaphore.  If you don't 
like struct semaphore, we would have to invent a proprietary wait queue 
mechanism that has semantics nearly identical to struct semaphore, and 
people would complain that we are reinventing the semaphore.

It doesn't seem clean to cobble up multiple waiting structures 
(completion + mutex + logic that surely would contain errors) where a 
single (well debugged) struct semaphore does what we want.


David Daney


