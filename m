From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 00/16] omap_hsmmc: Add ADMA support and UHS/HS200/DDR support
Date: Thu, 3 Aug 2017 13:22:55 +0200
Message-ID: <CAPDyKFpB6=jF_zZdHJ2BhML8F4qjeoes8kmDqW=DaZDiJu-Dbw@mail.gmail.com>
References: <20170616124544.15046-1-kishon@ti.com> <CAPDyKFo+ORA=OpdikiUZWj3gpx+ssuqbC5MtqiFJneyJhu84dA@mail.gmail.com>
 <fc9c1576-7419-b174-ea42-97ccf4666cee@ti.com> <27776609-2425-9423-3eaa-dc128c4b07f0@ti.com>
 <CAPDyKFp1oenb0Kq-SCf-ezG9p3gY9xUSq6-S_SQ4DpoRiKiOdA@mail.gmail.com> <1a668e7a-49b6-227c-def6-1cf9e21068cd@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1a668e7a-49b6-227c-def6-1cf9e21068cd-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ravikumar Kattekola <rk-l0cyMroinI0@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 3 August 2017 at 12:55, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On 03/08/17 13:40, Ulf Hansson wrote:
>> +Adrian
>>
>> On 20 July 2017 at 15:36, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>>> Hi Ulf,
>>>
>>> On Tuesday 11 July 2017 07:27 PM, Kishon Vijay Abraham I wrote:
>>>> Hi Ulf,
>>>>
>>>> On Tuesday 11 July 2017 06:40 PM, Ulf Hansson wrote:
>>>>> On 16 June 2017 at 14:45, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
>>>>>> This is the final part of the series originally sent as
>>>>>> part of [2].
>>>>>>
>>>>>> This series adds UHS, HS200, DDR mode and ADMA support to
>>>>>> omap_hsmmc driver used to improve the throughput of MMC/SD in dra7
>>>>>> SoCs.
>>>>>>
>>>>>> Changes from [2]:
>>>>>> *) No more updating omap2plus_defconfig or multi_v7_defconfig is
>>>>>>    required, so those patches are removed.
>>>>>> *) Addressed Rob Herring's comment on implementing a function
>>>>>>    instead of having a macro while getting pinctrl state.
>>>>>>
>>>>>> This series is created on top of [3], [4], [5] AND [6]
>>>>>> (i.e after
>>>>>>   ARM: dts: omap3-overo: Remove "vqmmc-supply" property from MMC dt node
>>>>>>   omap_hsmmc: use mmc_regulator_get_supply() to get regulators
>>>>>>   omap*: Fixes/Cleanups for MMC devicetree node
>>>>>>   ARM: dts: Add iodelay data for MMC)
>>>>>>
>>>>>> The functionality implemented in this series was sent before ([1]) but
>>>>>> was never followed up since supporting high speed modes in dra7 required
>>>>>> IODelay values to be configured. With IODelay driver being merged into
>>>>>> kernel, sending it as a fresh series with support for configuring IODelay
>>>>>> values.
>>>>>
>>>>> Is it safe to queue this via mmc tree for 4.14 or is there a
>>>>> dependency I must consider? The above didn't quite tell me that, could
>>>>> you please elaborate.
>>>>
>>>> There is a dependency with https://www.spinics.net/lists/arm-kernel/msg586215.html.
>>>>
>>>> I'll resend the series after all the platform data specific stuff is merged.
>>>>>
>>>>>>
>>>>>> Suggestions of migrating to sdhci driver (from omap_hsmmc driver) is not
>>>>>> addressed since
>>>>>> *) tuning ratio of MMC in dra7 is different from sdhci
>>>>>> *) IOdelay is required for dra7
>>>>>> *) GPIO based card detect is not supported in sdhci
>>>>>
>>>>> Lots of sdhci drivers calls mmc_of_parse(), and uses the mmc slot gpio
>>>>> APIs, so I don't this this is correct statement.
>>>>>
>>>>>> *) Some of the registers don't always have correct values as in sdhci
>>>>>>    (like PSTATE).
>>>>>> Supporting all of these in sdhci will result in adding lot of quirks in
>>>>>> sdhci driver.
>>>>>
>>>>> Is it really that much different? It would be nice if some really took
>>>>> on the challenge of converting omap_hsmmc into an sdhci variant.
>>>>
>>>> Okay. I'll give that a shot and see how far I can get.
>>>
>>> I created a sdhci variant and was able to get it working with high speed mode
>>> in dra7.
>>
>> That's very nice!
>>
>>>
>>> I have a query on sdhci_set_power_noreg() in sdhci.c. sdhci_set_power_noreg
>>> sets SDHCI_POWER_CONTROL based on *vdd* value. However SDHCI_POWER_CONTROL is
>>> for setting bus voltage and need not be based on *vdd*. IMHO
>>> SDHCI_POWER_CONTROL should be set based on "ios->signal_voltage".
>>
>> According to the implementation in sdhci_set_power_noreg(), I
>> understand it as the SDHCI_POWER_CONTROL register actually controls
>> the power to the card (VDD) and the not the I/O voltage level
>> (ios->signal_voltage).
>>
>> However, if I read the SDHCI spec, it seems to be mentioning the "SD
>> bus voltage", which to me is about the I/O voltage level. So either
>> the spec is unclear or the code is wrong. :-)
>>
>> Are you saying that the omap_hsmmc variant is using the
>> SDHCI_POWER_CONTROL to control the I/O voltage level?
>>
>> I am wondering how other variants use it. Perhaps most variants
>> actually have an external regulator and thus calls
>> sdhci_set_power_reg() instead.
>>
>> Looping in Adrian, to see if he has some thoughts on this.
>
> The spec is clear enough.  SDHCI_POWER_CONTROL is set based on the card's OCR.
>
> Signal voltage is defined by "1.8V Signaling Enable" in "Host Control 2
> Register".

Thanks for clarifying this!

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
