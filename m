From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v3 2/5] mmc: sdhci-pxav3: enable usage of DAT3 pin as HW
 card detect
Date: Fri, 23 Oct 2015 15:43:31 +0200
Message-ID: <CAPv3WKcSohi5b0r_js50T1OPHRq608r9NFjscuXbXDzWQkwOgg@mail.gmail.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
	<1444926346-29763-3-git-send-email-mw@semihalf.com>
	<CAPDyKFqT6tGOKYM_tjnf7k70_1Uu70Vew8PpQW6g9KKzRKBX1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqT6tGOKYM_tjnf7k70_1Uu70Vew8PpQW6g9KKzRKBX1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

2015-10-22 15:29 GMT+02:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 15 October 2015 at 18:25, Marcin Wojtas <mw@semihalf.com> wrote:
>> Marvell Armada 38x SDHCI controller enable using DAT3 pin as a hardware
>> card detection. According to the SD sdandard this signal can be used for
>> this purpose combined with a pull-down resistor, implying inverted (active
>> high) polarization of a card detect. MMC standard does not support this
>> feature and does not operate with such connectivity of DAT3.
>>
>> When using DAT3-based detection Armada 38x SDIO IP expects its internal
>> clock to be always on, which had to be ensured by:
>> - Udating appropriate registers, each time controller is reset. On the
>
> Isn't the reset sequence going to enable the clock again? I though
> reset was used to recover from failures.
>
> To me, it seems odd that you need to deal with this, but of course
> there are lots of odd things with sdhci. :-)
>

Setting clock enable in sdhci_control register is one thing, but this
IP requires also setting other register, which is set to default after
reset and does not get updated automatically.

>>   occasion of adding new register @0x104, register @0x100 name is modified
>>   in order to the be aligned with Armada 38x documentation.
>> - Leaving the clock enabled despite power-down. For this purpose a wrapper
>>   for sdhci_set_clock function is added.
>> - Disabling pm_runtime - during suspend both io_clock and controller's
>>   bus power is switched off, hence it would prevent proper card detection.
>>
>> In addition to the changes above this commit adds a new property to Armada
>> 38x SDHCI node ('dat3-cd') with an according binding documentation update.
>> 'sdhci_pxa' structure is also extended with dedicated flag for checking if
>> DAT3-based detection is in use.
>
> There is an easier way. Just check the new DT binding and if it set,
> execute pm_runtime_forbid() during ->probe(). No more runtime PM
> changes should be needed.
>

I will check it.

> Actually, I wonder if we should make this a new mmc core feature. We
> could via mmc_add_host() check if this DT property is set and then
> invoke the pm_runtime_forbid(). What do you think?
>

I thought about it. dat3 detect is defined by SDIO standard
(https://www.sdcard.org/developers/overview/sdio/sdio_spec/Simplified_SDIO_Card_Spec.pdf,
section 4.6), so it can be enabled as a global feature. Each IP
however would have to handle its own quirks related to it in the
drivers. I don't know if clock_enable should be always set only for
sdhci-pxav3 or for all hosts willing to use dat3 detection -
intuitively it should be a common feature, but I cannot confirm it...

On the other hand I will play with MMC_PM_KEEP_POWER capability, maybe
with this flag mmc subsystem is already able to support dat3 cd and
what has to be done is rather to satisfy sdhci-pxav3 quirks. Anyway, I
cannot find any explicit reference to it.

> One question, for clarity, you don't expect card detect IRQs to be
> treated as wakeups while being system PM suspended, right?

I'll check if enabling MMC_PM_KEEP_POWER is sufficient.

> Please, don't involve "broken-cd" as that has its own rules and purpose.

Indeed, this check is redundant.

Best regards,
Marcin
