From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 3/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Thu, 28 Apr 2016 13:46:59 +0200
Message-ID: <CAPDyKFpm4qAqCiY6+RGNg53gTjVS4Kq13YbNLEeUUZNjw3GFpQ@mail.gmail.com>
References: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
	<1461245314-6282-4-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFqpvZr3c8Skmc=pnE0m9EQFt=C98P-Vo5TKjONDHtxBaA@mail.gmail.com>
	<5721EDDD.6060902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36940 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbcD1LrB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 07:47:01 -0400
Received: by mail-wm0-f53.google.com with SMTP id a17so60679694wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 04:47:00 -0700 (PDT)
In-Reply-To: <5721EDDD.6060902@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

On 28 April 2016 at 13:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 28/04/16 13:34, Ulf Hansson wrote:
>> On 21 April 2016 at 15:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> The RPMB partition only allows certain commands.  In particular,
>>> the tuning command (CMD21) is not allowed -  refer JEDEC eMMC
>>> standard v5.1 section 6.2.2 Command restrictions.
>>>
>>> To avoid tuning for RPMB, switch to High Speed mode from HS200
>>> or HS400 mode if re-tuning has been enabled.  And switch back
>>> when leaving RPMB.
>>
>> I would rather just disable re-tuning during this period, instead of
>> changing the speed mode.
>> The primary reason to why, is because the latency it would introduce
>> to first switch to HS speed then back to HS200/400.
>
> I wouldn't expect RPMB accesses to be frequent enough for the latency to matter.
>
>>
>> My concern is not the throughput as I expect read/writes request to an
>> RPMB partition is rather small.
>>
>> Of course I realize that we need to take care when disable re-tuning.
>> Perhaps we can solve that by a re-try mechanism if the RPMB request
>> fails, and thus perform the re-tuning as part of the re-try?
>
> The interdependent nature of RPMB commands suggests that re-trying is not
> possible.  It seems to me that you would have to make up a new set of
> commands and start again. i.e. return an error to the user so that they can
> start again.

Ok.

So perhaps returning -EAGAIN could work!?

>
> Another dependency is that we always need to re-tune after host runtime
> suspend, which is why we always hit this problem when RPMB is accessed.  So

Just to make sure I understand correctly; I would imagine you hit the
problem *only* when the RPMB partition was already selected, right?

Because that would then skip the switch command, and you will
therefore try to re-tune after the partition has already been switched
to?

> to avoid errors you would either need to disable runtime PM when the RPMB
> partition is selected (which might be a long time if we don't get an access
> to another partition), or always switch back to the main partition (not sure
> if that would mess up the RPMB command sequence though).

I wouldn't mind that we switch back to the main partition when we have
served an RPMB IOCTL request. Of course not in between every mmc
request, in case of using the MULTI IOCTL.

That would prevent the next regular mmc request on the main partition
to not have to switch partition and thus get decreased latency.

Kind regards
Uffe
