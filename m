From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Optimize boot time by detecting cards
 simultaneously
Date: Fri, 18 Dec 2015 10:28:12 +0900
Message-ID: <5673612C.9050808@samsung.com>
References: <1448982916-21485-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFq3iuDkJgUGFV7Y4jLB37T=6Nkzf56bJ-a2RxHjy4fE=A@mail.gmail.com>
 <5670A0BA.8090402@samsung.com>
 <CAPDyKFpF+rqv1WQ0Hu-YdAM1pdNwKyKjFsAg1BfeEj=kDfH0Ag@mail.gmail.com>
 <CAOGqxeWw-qcRNV=4GDbh6znvd6Wh4yOtFcZtua3QuX8ZExGCBw@mail.gmail.com>
 <CAPDyKFo6DFOynRpB2mJE5KhAm7SQKd8xK6Ki54Rf5OjGLwwQcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51494 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965035AbbLRB2S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 20:28:18 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NZJ00I895F4S480@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 18 Dec 2015 10:28:16 +0900 (KST)
In-reply-to: <CAPDyKFo6DFOynRpB2mJE5KhAm7SQKd8xK6Ki54Rf5OjGLwwQcA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Alan Cooper <alcooperx@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On 12/18/2015 06:49 AM, Ulf Hansson wrote:
> On 17 December 2015 at 20:47, Alan Cooper <alcooperx@gmail.com> wrote:
>> On Wed, Dec 16, 2015 at 4:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> To find the improved card detection times, I just used the kernel boot
>>> log and checked the time stamps for when the cards get detected. I ran
>>> the tests ~10 times and picked up some average values.
>>>
>>> To notice the improvement you need at least two cards to be inserted
>>> during boot. Perhaps you have a platform with one eMMC and one SD card
>>> slot, you can test.
>>
>> I tested the patch on one of our ARM bases SoC's. The SoC has an SD
>> card slot on the first controller and an eMMC device on the second
>> controller. I found ~100ms improvement on the time it took for the
>> rootfs on the eMMC device to be ready for use. Interestingly, I did
>> see the SD/eMMC order swap once in 20 tries. This is not an issue for
>> us as we already have to use UUID for the eMMC rootfs in case an SD
>> card is installed.
>>
>> Al
> 
> Al, thanks for your effort in testing. I assume I can apply a
> tested-by tag for that!
> 
> BTW, if you want to see an even better improvement, just find a
> crappier SD card as I guess you have a quite good one. :-)

I didn't test with this yet..actually, i have tested with only one board(Exynos4412).
There is no the changing index. (Not too much for testing)
but in my experiment, our platform(Tizen) should be produced the problem in SD-card case.
I need to check with SystemFW guys. I will check this..ASAP. 

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

