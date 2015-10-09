From: Hongtao Wu <wuht06@gmail.com>
Subject: Re: [RFC PATCH v3 1/3] mmc: sprd: Add MMC host driver for Spreadtrum SoC
Date: Fri, 9 Oct 2015 21:23:16 +0800
Message-ID: <CAG_R4_VRht=7VQYNCBDmYt31zSBp-=_wKJM+pTQZUZV8hdTuGQ@mail.gmail.com>
References: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
	<1439571353-30165-2-git-send-email-wuht06@gmail.com>
	<CAPDyKFp=XH+Vo_diRyhrMuB+v1rmTmxo3Lid3Wc-u1ohqNisKw@mail.gmail.com>
	<CAG_R4_VTXCV4NVMOwv-9F56-_pVsK0hU4go79ZhV3OFxwcF0mA@mail.gmail.com>
	<CAPDyKFo3xp3wU3XW3kMV7Xz7DFgkxts3CArthYY7-CyWk8cjXw@mail.gmail.com>
	<CAG_R4_X3kQj5xSA5KLyu75aqusPNXj0H4Xqx+m+5Sg5cZ15bBg@mail.gmail.com>
	<CAPDyKFp2o=RAnizGrWgt080kYqWkBabh6NsCR11q3SPVCfaBAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34562 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbbJINXR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 09:23:17 -0400
In-Reply-To: <CAPDyKFp2o=RAnizGrWgt080kYqWkBabh6NsCR11q3SPVCfaBAw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, "Orson.Zhai@spreadtrum.com" <Orson.Zhai@spreadtrum.com>, "Chunyan.Zhang@spreadtrum.com" <Chunyan.Zhang@spreadtrum.com>, "Jason.Wu@spreadtrum.com" <Jason.Wu@spreadtrum.com>, Russell King <rmk+kernel@arm.linux.org.uk>

On Thu, Oct 8, 2015 at 9:54 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>> Thanks for clarifying!
>>>
>>> You have some differences towards the "standard" sdhci variant, but
>>> that doesn't mean you should go off and implement a new driver from
>>> scratch, instead you should create a new sdhci variant and re-use code
>>> from the generic sdhci driver.
>>>
>>> The current problem with such approach, is that the sdhci driver isn't
>>> designed as a library but instead a driver consisting of too many
>>> quirks and callbacks. While you start to adopt your driver towards
>>> sdhci, you will need to add yet another bunch of new quirks and
>>> callbacks to suite your hw.
>>>
>>> Now, as the number of callbacks and quirks continues to increase I
>>> will sooner or later give up maintaining it, as each line of code will
>>> depend on a quirk. So, we need to start turning sdhci into a library
>>> *right now*! Russell King, has pointed out this several times as well,
>>> but unfortunate I haven't yet seen anyone willing to help out in this
>>> field.
>>>
>>> I would of course be very happy if you would like to have a look at
>>> that, but I realize it's a difficult task, So, unless you are happy
>>> with taking on such a challenge, I suggest you go for an intermediate
>>> step, which thus means convert your driver to a sdhci variant driver
>>> and add the quirks/callbacks you need to suite your hw.
>>>
>>> [...]
>>>
>>> Kind regards
>>> Uffe
>>
>> Thanks for kindly suggestion!
>> I think it's a good idea to turn sdhci into a library. But for me it's
>> too difficult to
>> take on such a challenge. However, I will try my best to support you to do
>> it.
>
> Yes, I totally understand and thanks for your support.
>
>>
>> As you suggested, I will consider converting our eMMC host driver to a
>> sdhci variant driver. However, our controller has some features, which
>> differentiate it from standard sd host controller. For example, our controller
>> doesn't have such functions as follows: tuning or re-tuning, Power Control
>> Register, PIO or ADMA transfer mode, UHS-II and so on. So, if we use sdchi
>> variant driver right now, I think it has a litter redundancy.
>
> I realize that, but I would very much appreciate if you give it try -
> I think it should be doable.
>
> Of course, you will need to change the "sdhci core" to suite your
> needs and normally people do that via adding callbacks and quirks.
> Perhaps you can keep my request in mind of turning sdhci into a
> library and thus limit the number of added quirks and callbacks...
>
>>
>> Now our sdio team are discussing improving  our eMMC host controller, we are
>> making it more standardized. But you know, changing a IP block is a long
>> process. Maybe it will take us about one or two years. So what do you think
>> if we use ourself eMMC host driver right now, and convert it when our new host
>> controller is ready.
>>
>
> Well, that won't help the current HW so I would encourage you to do
> the "sdhci variant" work anyway. Likely it will also benefit you when
> you try to upstream the next variant of the driver to cope with your
> new HW.
>
> Kind regards
> Uffe


Thanks for your quick reply.
We will use the "standard" sdhci variant to cope with our new HW as you
suggest. Maybe it will take us a long time, but we will try to do it.
