From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Optimize boot time by detecting cards simultaneously
Date: Wed, 16 Dec 2015 10:07:35 +0100
Message-ID: <CAPDyKFpF+rqv1WQ0Hu-YdAM1pdNwKyKjFsAg1BfeEj=kDfH0Ag@mail.gmail.com>
References: <1448982916-21485-1-git-send-email-ulf.hansson@linaro.org>
	<CAPDyKFq3iuDkJgUGFV7Y4jLB37T=6Nkzf56bJ-a2RxHjy4fE=A@mail.gmail.com>
	<5670A0BA.8090402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34832 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932819AbbLPJHg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Dec 2015 04:07:36 -0500
Received: by mail-qk0-f175.google.com with SMTP id u65so34930121qkh.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Dec 2015 01:07:35 -0800 (PST)
In-Reply-To: <5670A0BA.8090402@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 16 December 2015 at 00:22, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 12/15/2015 12:50 AM, Ulf Hansson wrote:
>> On 1 December 2015 at 16:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> The mmc workqueue is an ordered workqueue, allowing only one work to
>>> execute per given time. As this workqueue is used for card detection, the
>>> conseqeunce is that cards will be detected one by one waiting for each
>>> other.
>>>
>>> Moreover, most of the time spent during card initialization is waiting for
>>> the card's internal firmware to be ready. From a CPU perspective this
>>> typically means waiting for a completion variable to be kicked via an
>>> IRQ-handler or waiting for a sleep timer to finish.
>>>
>>> This behaviour of detecting/initializing cards is sub-optimal, especially
>>> for SOCs having several controllers/cards.
>>>
>>> Let's convert to use the system_freezable_wq for the mmc detect works.
>>> This enables several works to be executed simultaneously and thus also
>>> cards to be detected like so.
>>>
>>> Tests on UX500, which holds two eMMC cards and an SD-card (actually also
>>> an SDIO card, currently not detected), shows a significant improved
>>> behaviour due to this change.
>>>
>>> Before this change, both the eMMC cards waited for the SD card to be
>>> initialized as its detect work entered the workqueue first. In some cases,
>>> depending on the characteristic of the SD-card, they got delayed 1-1.5 s.
>>>
>>> Additionally for the second eMMC, it needed to wait for the first eMMC to
>>> be initialized which added another 120-190 ms.
>
> how did you check this? I also want to test with similar environment. :)

To find the improved card detection times, I just used the kernel boot
log and checked the time stamps for when the cards get detected. I ran
the tests ~10 times and picked up some average values.

To notice the improvement you need at least two cards to be inserted
during boot. Perhaps you have a platform with one eMMC and one SD card
slot, you can test.

>
>>>
>>> Converting to the system_freezable_wq, removed these delays and made both
>>> the eMMC cards available far earlier in the boot sequence.
>>>
>>> Selecting the system_freezable_wq, in favour of for example the system_wq,
>>> is because we need card detection mechanism to be disabled once userspace
>>> are frozen during system PM. Currently the mmc core deal with this via PM
>>> notifiers, but following patches may utilize the behaviour of the
>>> system_freezable_wq, to simplify the use of the PM notifiers.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Even-though the lack of reviewers, I have decided to give this a try
>> and pushed it for my next branch.
>>
>> If it isn't clear by the above change-log:
>> A side effect from this change is that mmc block partitions, may end
>> up being given other indexes than they had before. Whether that may
>> cause issues, depends on if the path to the rootfs have been
>> hard-coded or not.
>
> What does "mmc block partitions, may end up being given other indexes than they had before." mean?
> Is it possible to increase the index for partition number?
> If my understanding is right...mmcblk's partition index is not fixed.
> Sometime eMMC should be mmcblk0pX or mmcblk1px..right? hmm...

You have understood correctly. The mmcblk[n], can get different values
for n, depending in which order the cards gets detected.

>
> I need to check more...with other boards and SoC.

Sounds great, thanks for helping out!

Kind regards
Uffe
