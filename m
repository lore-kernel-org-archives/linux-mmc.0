From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Wed, 27 Aug 2014 12:55:09 +0900
Message-ID: <53FD569D.60002@samsung.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
 <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
 <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
 <CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
 <CAD=FV=VQWzhiSU+iULACj+Dp_tDf3SszQ8ELLEGqVEyJJRQy1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47483 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbaH0DzM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Aug 2014 23:55:12 -0400
In-reply-to: <CAD=FV=VQWzhiSU+iULACj+Dp_tDf3SszQ8ELLEGqVEyJJRQy1Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@google.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sonny Rao <sonnyrao@chromium.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, CPGS <cpgs@samsung.com>

Hi.

On 08/26/2014 12:20 AM, Doug Anderson wrote:
> Ulf,
> 
> On Mon, Aug 25, 2014 at 1:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 August 2014 20:27, Sonny Rao <sonnyrao@chromium.org> wrote:
>>> On Fri, Aug 22, 2014 at 8:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>>>> Exynos 5250 and 5420 based boards uses built-in CD# line for card
>>>>> detection.But unfortunately CD# line is on the same voltage rails
>>>>> as of I/O voltage rails. When we cut off vqmmc,the consequent card
>>>>> detection will break in these boards.
>>>>
>>>> I am not sure I follow here.
>>>>
>>>> Is the card detect mechanism handled internally by the dw_mmc controller?
>>>
>>> Yes
>>
>> Just out of curiosity.
>>
>> Do you know how the power to the actual dw_mmc controller is handled?
>> I expect it to be SoC specific and I am guessing power domain
>> regulators may be involved!?
> 
> You can likely read the dw_mmc registers when vqmmc is off.  Is that
> what you're asking?  Certainly if vqmmc is not powered then the lines
> themselves will be useless, won't they?  The "vqmmc" supply goes to
> the "VDDQ_MMC2" pin on 5420.  In my 5420 user manual, I see that
> "clk", "cmd", "cd", "datN", "wp" and "biuvr" pins are all in this same
> voltage (VDDQ_MMC2) domain.  Can you really read a pin without
> powering that part of the SoC?

It's not correct.
At TRM, described as same voltage domain. But CD-pin is used with "always-on" power.
In circuit, CD# pin is disconnected.

> 
> 
>>>> I thought HW engineers long time ago realized that this should be done
>>>> separately on a GPIO line to be able to save power while waiting for a
>>>> card to be inserted. But that's not case then?
>>>
>>> At least in my limited experience, this seems to be common among SoC
>>> vendors who are using dw_mmc, as we've seen this elsewhere as well and
>>> after seeing it here we know that we need to ignore the CD pin that's
>>> routed to dw_mmc and use a separately powered GPIO on the board, but
>>> still there are probably many SoCs/boards which are doing it this way.
>>>
>>>>>
>>>>> These hosts (obviously) need to keep vqmmc (and thus vmmc) on all the
>>>>> time, even when the mmc core tells them to power off. However, one
>>>>> problem is that these cards won't properly handle mmc_power_cycle().
>>>>> That's needed to handle error cases when trying to switch voltages
>>>>> (see 0797e5f mmc:core: Fixup signal voltage switch).
>>>>>
>>>>> This patch adds a new MMC_POWER_OFF_HARD mode when it's doing a power
>>>>> cycle.  This mode differs from the normal MMC_POWER_OFF mode in that
>>>>> the mmc core will promise to power the slot back on before it expects
>>>>> the host to detect card insertion or removal.
>>>
>>> This patch is based off of one that Doug wrote (sent privately to
>>> Yuvaraj) which just modifies the MMC core, and should be split into
>>> two patches.
>>> One that modifies the mmc core and one that implements this in dw_mmc.
>>
>> I looked at the mmc core parts, it seems like the wrong approach.
>>
>> I think you shall be able use MMC_CAP_NEEDS_POLL, to handle this
>> broken card detect mechanism. We even have a DT binding for that,
>> "broken-cd".
> 
> I don't think this is possible, but let me explain why I think so and
> you can correct me.

Exynos series is using the external gpio-cd concept. So it need not to use MMC_CAP_NEEDS_POLL.
Can use the slot-gpio API. In my exynos5 board, it's working fine with the slot-gpio API.

Best Regards,
Jaehoon Chung

> 
> The voltage domain of the "card detect" pin on the SoC is vqmmc,
> right?  That means that you won't be able to read the pin without
> turning on vqmmc.  Even if you could read the pin without turning on
> vqmmc, the pullup on this line is connected to vqmmc too.  ...so if
> vqmmc is off then there's no pulup and you can't use card detect.
> 
> Are you suggesting that we should flip the voltage of vqmmc (and thus
> vmmc to prevent damaging the card) during polling?  That seems ugly.
> 
> 
> One other thing to mention: we didn't find any power savings by
> actually turning off vmmc and vqmmc when there was no card inserted.
> There's no current running through the lines when there is no card
> inserted and apparently everything is efficient enough that there was
> no problem.
> 
> -Doug
> 

