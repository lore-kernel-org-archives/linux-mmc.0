From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read scenarios
Date: Tue, 30 Oct 2012 08:45:27 +0100
Message-ID: <CAFEEs1kX+n=TeuqMfP7tgm1agCMb1BCR23Oen0i=jKFXh3Hopw@mail.gmail.com>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>
	<5088206C.7080101@stericsson.com>
	<50893E88.9000908@codeaurora.org>
	<5089549D.3060507@stericsson.com>
	<CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>
	<508D2F2E.3020006@codeaurora.org>
	<CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:50127 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab2J3Hp2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 03:45:28 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so4404216lag.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Oct 2012 00:45:27 -0700 (PDT)
In-Reply-To: <CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

minor clarification,

On Mon, Oct 29, 2012 at 10:40 PM, Per Forlin <per.lkml@gmail.com> wrote:
> Hi,
>
> I would like to move the focus of my concerns from root cause analysis
> to the actual patch,
> My first reflection is that the patch is relatively complex and some
> of the code looks duplicated.
> Would it be possible to simplify it and re-use  the current execution flow.
>
> Is the following flow feasible?
>
> in mmc_start_req():
> --------------
> if (rqc == NULL && not_resend)
&& request_is_ongoing (in case of resend request is never ongoing

>   wait_for_both_mmc_and_arrival_of_new_req
We should wake up if any of the two events occur.

> else
>   wait_only_for_mmc
>
> if (arrival_of_new_req) {
>    set flag to indicate fetch-new_req
>   return NULL;
> }
> -----------------
>
> in queue.c:
> if (fetch-new_req)
>   don't overwrite previous req.
>

This is somewhat a subset of the your patch. Maybe I'm missing parts
of the complexity.
I haven't figured out why a new mmc_start_data_req() is needed. A new
mechanism for waiting is required.

BR
Per

> BR
> Per
>
>
>
> On Sun, Oct 28, 2012 at 2:12 PM, Konstantin Dorfman
> <kdorfman@codeaurora.org> wrote:
>> Hello,
>>
>> On 10/26/2012 02:07 PM, Venkatraman S wrote:
>>
>>>
>>> Actually there could a lot of reasons why block layer or CFQ would not have
>>> inserted the request into the queue. i.e. you can see a lot of exit paths
>>> where blk_peek_request returns NULL, even though there could be any request
>>> pending in one of the CFQ requests queues.
>>>
>>> Essentially you need to check what makes blk_fetch_request
>>> (cfq_dispatch_requests() ) return NULL when there is an element in
>>> queue, if at all.
>>>
>>
>> This is not important why block layer causes to blk_fetch_request() (or
>> blk_peek_request()) to return NULL to the MMC layer, but what is really
>> important - MMC layer should always be able to fetch the new arrived
>> request ASAP, after block layer notification (mmc_request() ) and this
>> is what my fix goes to implement.
>>
>> And the fix is not changing block layer behavior.
>>
>> Thanks
>>
>> --
>> Konstantin Dorfman,
>> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
>> Inc. is a member of Code Aurora Forum,
>> hosted by The Linux Foundation
