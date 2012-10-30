From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Tue, 30 Oct 2012 14:19:48 +0200
Message-ID: <508FC5E4.8010906@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>	<5088206C.7080101@stericsson.com>	<50893E88.9000908@codeaurora.org>	<5089549D.3060507@stericsson.com>	<CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>	<508D2F2E.3020006@codeaurora.org> <CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:42929 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab2J3MTx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 08:19:53 -0400
In-Reply-To: <CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello,

On 10/29/2012 11:40 PM, Per Forlin wrote:
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
>   wait_for_both_mmc_and_arrival_of_new_req
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
> BR
> Per

You are talking about using both waiting mechanisms, old (wait on
completion) and new - wait_event_interruptible()? But how done()
callback, called on host controller irq context, will differentiate
which one is relevant for the request?

I think it is better to use single wait point for mmc thread.

Also in future plans to add second reason to wake up mmc thread from
waiting: this is urgent_request - this notification about next-to-fetch
read request, that should be executed out-of-order, using new eMMC HPI
feature (to stop currently running request).

I will publish this patch soon.

Your idea with fetch_new_req flag is good, I'll try to simplify current
patch and lets talk again.

Thanks,
-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
