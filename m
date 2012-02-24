From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v7] mmc: support BKOPS feature for eMMC
Date: Fri, 24 Feb 2012 17:13:57 +0530
Message-ID: <CAKLKtzfG5iC8vhwk8uequjOqeuVyGB1MavLzwt-p6sPNg9DPkQ@mail.gmail.com>
References: <4F190E26.4040909@samsung.com>
	<4F44F792.2000304@intel.com>
	<4F45A293.6060608@samsung.com>
	<4F46014C.6040303@intel.com>
	<4F474C8D.4020307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34492 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab2BXLn7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2012 06:43:59 -0500
Received: by wgbdt10 with SMTP id dt10so1995208wgb.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Feb 2012 03:43:58 -0800 (PST)
In-Reply-To: <4F474C8D.4020307@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

Hi Jaehoon

Since you are planning to rework this patch, can you consider to
implement the periodic BKOPS level check and triggering BKOPS at level
1 when the queue is idle ?


On 24 February 2012 14:08, Jaehoon Chung <jh80.chung@samsung.com> wrote=
:
> On 02/23/2012 06:05 PM, Adrian Hunter wrote:
>
>> On 23/02/12 04:21, Jaehoon Chung wrote:
>>> On 02/22/2012 11:11 PM, Adrian Hunter wrote:
>>>
>>>> On 20/01/12 08:48, Jaehoon Chung wrote:
>>>>> Enable eMMC background operations (BKOPS) feature.
>>>>>
>>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>>> are required. After all I/O requests are finished, run
>>>>> BKOPS if required. Should read/write operations be requested
>>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>>> and then service the request.
>>>>
>>>> You are leaving bkops running and releasing the host. =A0Won't
>>>> that cause problems for other entry points to mmc services
>>>> e.g. system suspend (cache control, sleep etc), ioctl, sysfs,
>>>> etc
>>>
>>> I see. i will complement for your review.
>>
>> Please cc me.
>
> Sure..
>
>>
>>> Didn't you have the other comment?
>>
>> Well, yes. =A0I also suggest:
>> =A0 =A0 =A0 - don't use host->lock spin lock at all
>> =A0 =A0 =A0 - claim the host in the caller not in
>> =A0 =A0 =A0 mmc_start_bkops()
>>
>> But the main issues are design issues not implementation.
>> i.e.
>> =A0 =A0 =A0 - always run bkops at level 3 before doing any
>> =A0 =A0 =A0 other requests - that requirement should probably
>> =A0 =A0 =A0 be implemented in core rather than the block driver
>
> In core..it's reasonable..i will try that.
>
>> =A0 =A0 =A0 - do not release the host while bkops are running
>
> Right..don't release the host. i will consider.
>
>>
>> And a new one:
>> =A0 =A0 =A0 - how do you know that trim/discard/sanitize will not
>> =A0 =A0 =A0 result in a need for bkops?
>
> Well, i didn't consider that case.
> but i think that need to control them.
>
> Thanks for comments.
>
> Best Regards,
> Jaehoon Chung
>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
