From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Optimize boot time by detecting cards simultaneously
Date: Thu, 17 Dec 2015 22:49:34 +0100
Message-ID: <CAPDyKFo6DFOynRpB2mJE5KhAm7SQKd8xK6Ki54Rf5OjGLwwQcA@mail.gmail.com>
References: <1448982916-21485-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFq3iuDkJgUGFV7Y4jLB37T=6Nkzf56bJ-a2RxHjy4fE=A@mail.gmail.com>
	<5670A0BA.8090402@samsung.com>
	<CAPDyKFpF+rqv1WQ0Hu-YdAM1pdNwKyKjFsAg1BfeEj=kDfH0Ag@mail.gmail.com>
	<CAOGqxeWw-qcRNV=4GDbh6znvd6Wh4yOtFcZtua3QuX8ZExGCBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35905 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933136AbbLQVtf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2015 16:49:35 -0500
Received: by mail-yk0-f171.google.com with SMTP id x184so36311317yka.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2015 13:49:35 -0800 (PST)
In-Reply-To: <CAOGqxeWw-qcRNV=4GDbh6znvd6Wh4yOtFcZtua3QuX8ZExGCBw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 17 December 2015 at 20:47, Alan Cooper <alcooperx@gmail.com> wrote:
> On Wed, Dec 16, 2015 at 4:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> To find the improved card detection times, I just used the kernel boot
>> log and checked the time stamps for when the cards get detected. I ran
>> the tests ~10 times and picked up some average values.
>>
>> To notice the improvement you need at least two cards to be inserted
>> during boot. Perhaps you have a platform with one eMMC and one SD card
>> slot, you can test.
>
> I tested the patch on one of our ARM bases SoC's. The SoC has an SD
> card slot on the first controller and an eMMC device on the second
> controller. I found ~100ms improvement on the time it took for the
> rootfs on the eMMC device to be ready for use. Interestingly, I did
> see the SD/eMMC order swap once in 20 tries. This is not an issue for
> us as we already have to use UUID for the eMMC rootfs in case an SD
> card is installed.
>
> Al

Al, thanks for your effort in testing. I assume I can apply a
tested-by tag for that!

BTW, if you want to see an even better improvement, just find a
crappier SD card as I guess you have a quite good one. :-)

Kind regards
Uffe
