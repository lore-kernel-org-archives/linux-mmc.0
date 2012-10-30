From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v1] mmc: fix async request mechanism for sequential read
 scenarios
Date: Tue, 30 Oct 2012 14:23:13 +0200
Message-ID: <508FC6B1.2090300@codeaurora.org>
References: <f67543901d54b344c8bb401e363e6b80.squirrel@www.codeaurora.org>	<5088206C.7080101@stericsson.com>	<50893E88.9000908@codeaurora.org>	<5089549D.3060507@stericsson.com>	<CAOyx1Lq9D2RN5KmvgxU+Z4W3aNHuyA2D5cdFJhz0sf+WU2ZZ=Q@mail.gmail.com>	<508D2F2E.3020006@codeaurora.org>	<CAFEEs1m6VwDO8N1Tc8J4Q+aXysgxd77+oZr=M7QK7rgycQuEFw@mail.gmail.com> <CAFEEs1kX+n=TeuqMfP7tgm1agCMb1BCR23Oen0i=jKFXh3Hopw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:63203 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab2J3MXQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 08:23:16 -0400
In-Reply-To: <CAFEEs1kX+n=TeuqMfP7tgm1agCMb1BCR23Oen0i=jKFXh3Hopw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Venkatraman S <svenkatr@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10/30/2012 09:45 AM, Per Forlin wrote:
> minor clarification,
> 
> On Mon, Oct 29, 2012 at 10:40 PM, Per Forlin <per.lkml@gmail.com> wrote:

>>
>> Is the following flow feasible?
>>
>> in mmc_start_req():
>> --------------
>> if (rqc == NULL && not_resend)
> && request_is_ongoing (in case of resend request is never ongoing
> 
>>   wait_for_both_mmc_and_arrival_of_new_req
> We should wake up if any of the two events occur.
> 
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
> 
> This is somewhat a subset of the your patch. Maybe I'm missing parts
> of the complexity.
> I haven't figured out why a new mmc_start_data_req() is needed. A new
> mechanism for waiting is required.
You're right, it was no reason to add new function, we can use
mmc_start_req() and just change mechanism for waiting, I will fix this
to minimize changes.

-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
