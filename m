From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read scenarios
Date: Tue, 30 Oct 2012 20:57:34 +0100
Message-ID: <CAFEEs1nBmAq4d7sEyQgCRRfrr-g2T79VAd9RbAGAXbQab29XTQ@mail.gmail.com>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>
	<5088206C.7080101@stericsson.com>
	<50893E88.9000908@codeaurora.org>
	<5089549D.3060507@stericsson.com>
	<CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>
	<508D2F2E.3020006@codeaurora.org>
	<CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com>
	<508FC5E4.8010906@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:51559 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab2J3T5f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 15:57:35 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so517368lag.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Oct 2012 12:57:34 -0700 (PDT)
In-Reply-To: <508FC5E4.8010906@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Tue, Oct 30, 2012 at 1:19 PM, Konstantin Dorfman
<kdorfman@codeaurora.org> wrote:
> Hello,
>
> On 10/29/2012 11:40 PM, Per Forlin wrote:
>> Hi,
>>
>> I would like to move the focus of my concerns from root cause analysis
>> to the actual patch,
>> My first reflection is that the patch is relatively complex and some
>> of the code looks duplicated.
>> Would it be possible to simplify it and re-use  the current execution flow.
>>
>> Is the following flow feasible?
>>
>> in mmc_start_req():
>> --------------
>> if (rqc == NULL && not_resend)
>>   wait_for_both_mmc_and_arrival_of_new_req
>> else
>>   wait_only_for_mmc
>>
>> if (arrival_of_new_req) {
>>    set flag to indicate fetch-new_req
>>   return NULL;
>> }
>> -----------------
>>
>> in queue.c:
>> if (fetch-new_req)
>>   don't overwrite previous req.
>>
>> BR
>> Per
>
> You are talking about using both waiting mechanisms, old (wait on
> completion) and new - wait_event_interruptible()? But how done()
> callback, called on host controller irq context, will differentiate
> which one is relevant for the request?
>
> I think it is better to use single wait point for mmc thread.
>
> Also in future plans to add second reason to wake up mmc thread from
> waiting: this is urgent_request - this notification about next-to-fetch
> read request, that should be executed out-of-order, using new eMMC HPI
> feature (to stop currently running request).
>
> I will publish this patch soon.
>
> Your idea with fetch_new_req flag is good, I'll try to simplify current
> patch and lets talk again.
>
I have not thought this through entirely. But it would be nice to add
a new func() in areq to add support for this a new mechanism. If the
func() is NULL the normal flow will be executed. This could be used in
the SDIO case too. At least it should be possible to use only the core
API and it still make sense without a mmc block driver on top.

How to implement this wait function?
There should be one single wait point, I agree.
One could share the mmc completion perhaps through the new func().
This mean both mmc-queue and mmc-host and completes the same
completion.
When waking up from the completion one needs to stop the new
func-wait-point and check if a new request is available. If yes, fetch
a new request and next time don't re-init the completion (this would
overwrite the mmc-host complete value).

Let's talk again when you have a new patch set.

BR
Per

> Thanks,
> --
> Konstantin Dorfman,
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
> Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
