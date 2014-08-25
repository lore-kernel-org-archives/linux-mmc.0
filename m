From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Mon, 25 Aug 2014 10:13:28 +0200
Message-ID: <CAPDyKFqp7oEt9ASmdxrgUwbQ8aTZzAuJ7uD1oGN50iuzPzBfVg@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
	<1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com>
	<CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
	<CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Doug Anderson <dianders@google.com>, Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2014 20:27, Sonny Rao <sonnyrao@chromium.org> wrote:
> On Fri, Aug 22, 2014 at 8:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>>> Exynos 5250 and 5420 based boards uses built-in CD# line for card
>>> detection.But unfortunately CD# line is on the same voltage rails
>>> as of I/O voltage rails. When we cut off vqmmc,the consequent card
>>> detection will break in these boards.
>>
>> I am not sure I follow here.
>>
>> Is the card detect mechanism handled internally by the dw_mmc controller?
>
> Yes

Just out of curiosity.

Do you know how the power to the actual dw_mmc controller is handled?
I expect it to be SoC specific and I am guessing power domain
regulators may be involved!?

>
>>
>> I thought HW engineers long time ago realized that this should be done
>> separately on a GPIO line to be able to save power while waiting for a
>> card to be inserted. But that's not case then?
>
> At least in my limited experience, this seems to be common among SoC
> vendors who are using dw_mmc, as we've seen this elsewhere as well and
> after seeing it here we know that we need to ignore the CD pin that's
> routed to dw_mmc and use a separately powered GPIO on the board, but
> still there are probably many SoCs/boards which are doing it this way.
>
>>>
>>> These hosts (obviously) need to keep vqmmc (and thus vmmc) on all the
>>> time, even when the mmc core tells them to power off. However, one
>>> problem is that these cards won't properly handle mmc_power_cycle().
>>> That's needed to handle error cases when trying to switch voltages
>>> (see 0797e5f mmc:core: Fixup signal voltage switch).
>>>
>>> This patch adds a new MMC_POWER_OFF_HARD mode when it's doing a power
>>> cycle.  This mode differs from the normal MMC_POWER_OFF mode in that
>>> the mmc core will promise to power the slot back on before it expects
>>> the host to detect card insertion or removal.
>
> This patch is based off of one that Doug wrote (sent privately to
> Yuvaraj) which just modifies the MMC core, and should be split into
> two patches.
> One that modifies the mmc core and one that implements this in dw_mmc.

I looked at the mmc core parts, it seems like the wrong approach.

I think you shall be able use MMC_CAP_NEEDS_POLL, to handle this
broken card detect mechanism. We even have a DT binding for that,
"broken-cd".

Kind regards
Uffe
