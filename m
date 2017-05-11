From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC 0/2] Add support for Meson MX "SDIO" MMC driver
Date: Thu, 11 May 2017 22:44:05 +0200
Message-ID: <CAFBinCDocqqo2GNLb2y1XE0ATTEG6TuqO+EZ_-h8=vuTjngr_Q@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com>
 <CAPDyKFoYPjB1bjRfFCFT3vuzKgzm6-7L2qgNjxGL392cLDe7uA@mail.gmail.com>
 <CAFBinCDGBZAAx_61eyu1_XM57fX62Mk03TEiO3uTL+i8dfPyZA@mail.gmail.com> <CAPDyKFoC-cCEY+n2383W+JgDANbBMFbsU5cyB51-kG4kbLNNcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoC-cCEY+n2383W+JgDANbBMFbsU5cyB51-kG4kbLNNcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, May 11, 2017 at 11:39 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 10 May 2017 at 21:22, Martin Blumenstingl
> <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>> Hi Ulf,
>>
>> On Wed, May 10, 2017 at 10:44 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> On 6 May 2017 at 19:18, Martin Blumenstingl
>>> <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>>>> This is the successor to Carlo Caione's "Add support for Amlogic Meson
>>>> MMC driver" series (v5) from [0].
>>>>
>>>> I would like you to specifically review:
>>>> - whether I've (ab)used the MMC framework properly (as this is my first
>>>>   "larger" contribution to an MMC driver)
>>>
>>> I take a look soonish.
>> thank you!
>>
>>>> - I think I have improved the locking compared to Carlo's version,
>>>>   however I'd still like feedback on whether this looks sane now or if I
>>>>   can improve that even further
>>>>
>>>> (notable) changes since Carlo's latest version are:
>>>> - renamed the driver to meson-mx-sdio (Amlogic's reference kernel calls
>>>>   the driver "aml_sdio" as there is a second MMC controller in these SoCs
>>>>   which they call the "SDHC controller"). do the same with our driver to
>>>
>>> I don't like to renaming drivers, just because there are a reference
>>> kernel using a different name.
>>>
>>> What's is really the difference between controllers? Why do they have
>>> two variants?
>> the driver from this thread is for the "SDSC/SDHC/SDXC card and SDIO
>> interface with 1-bit and 4-bit data bus width supporting spec version
>> 2.x/3.x/4.x DS/HS modes up to UHS-I SDR50" (quote taken from the S805
>> datasheet: [0])
>> the "other" controller is an "eMMC and MMC card interface with
>> 1/4/8-bit data bus width supporting spec version 4.4x/4.5x HS200 (up
>> to 100MHz clock), compatible with standard iNAND interface" (again,
>> quote taken from the S805 datasheet: [0])
>>
>>>
>>> Can they be managed by the same driver?
>>>
>>>>   avoid confusion once we add support for the second controller (which uses
>>>>   a completely different register layout)
>>>
>>> Besides that, do they behave differently in some other way?
>> both drivers/controllers have a totally different register layout - I
>> don't see any way how they both could be handled by one driver (the
>> registers for the controllers from this series are not part of the
>> documentation, but the registers from the 8-bit capable controller
>> are, see page 76 and following from the S805 datasheet: [0])
>
> Okay, I am starting to understand. :-)
good to hear that my explanation made (at least some) sense!

> The spec in section 13 describes a controller supporting "MMC/SD/SDIO"
> cards. However, there is yet another controller which @subject series
> implement support for.
> You don't happen to have a public datasheet for this controller as
> well? If not, never mind.
unfortunately the controller from @subject does not show up in any of
the public datasheets, but we have a header file from Amlogic which
documents it just as well as the datasheet (probably) would: [0]

> Then, meson actually have three different MMC/SD/SDIO controllers, the
> one in the S805 spec, the one supported by the recently up-streamed
> meson-gx-mmc.c driver - and the one being supported in this series.
> Right? And all of them are completely separate and non-compatible?
yes, unfortunately it seems that there are three different MMC
controller IP blocks from Amlogic

let me explain this a bit more in detail:
the code-names of the newer (64-bit) SoCs all start with GX (GXBB,
GXL, GXM), so we call these "Meson GX".
the code-names of the older (32-bit) SoCs (at least the ones which are
not too old) all start with Meson X (where X is a number: Meson6,
Meson8, Meson8b and Meson8m2), Amlogic's vendor code sometimes calls
these "MX" (or Meson MX)

the MMC IP blocks in Meson GX SoCs are easy: the same IP block is
embedded three times -> the driver for this is meson-gx-mmc.c (already
upstream)
the MMC IP blocks in Meson MX SoCs are more complicated: 1x 1/4-bit
which will be handled by the driver from @subject (meson-mx-sdio.c)
and 1x 1/4/8-bit for which there is only the vendor driver (plus the
description in the S805 datasheet) available.

so it looks like the older Meson MX SoCs may end up with two different
drivers, while there's a third driver (for a totally different IP
block) for the newer Meson GX SoCs.

[snip]
>>>> - use the common clock framework internally for managing the MMC clock
>>>>   (there is a fixed-factor clock in the controller which takes clk81 as
>>>>    input and divides it's clock by two and a divider clock which takes
>>>>    the result from the fixed-factor clock as input)
>>>> - support the regulators provided by the MMC framework
>>>> - support for GPIO-based card-detection and read-only-detection through
>>>>   the MMC framework
>>>> - use of the <linux/bitfield.h> FIELD_PREP and FIELD_GET macros where it
>>>>   make sense (and thus the code easier to read)
>>>> - re-worked locking (based on the locking in dw_mmc as that also provides
>>>>   multiple "MMC slots")
>>>
>>> Lots of changes!
>>>
>>> Before even start to review (or someone else), you really need to make
>>> this review-able.
>>>
>>> So, please, one change per patch - and make sure to write good
>>> changelogs. Then I can start to review.
>> from the mainline tree's perspective this is a new driver:
>
> Yes, I get it now.
>
> I first thought this series was related to the recently up-streamed
> meson-gx-mmc.c driver. Apologize for my ignorance.
should I put some more context/details in the description (maybe
something like: "this is a new driver/binding because the Meson MX
SoCs use a different IP block than the Meson GX SoCs (the IP block
from the latter is already supported by the meson-gx-mmc driver)"?

>> Carlo (the original author) initially sent this driver for review more
>> than 14 months ago. unfortunately it was never merged since you
>> spotted some issues while reviewing that code, see [1].
>
> Yes, I recall that now.
the 14 month delay was one of the reasons why I decided to re-post it
only after all features were implemented

>> I would have sent smaller patches for a driver which is already in mainline.
>
> Right.
>
>>
>> I also wanted to avoid extra complexity for the internal mux if it was
>> added later on (if we want to avoid breaking devicetree backwards
>> compatibility then the driver would have to support both: parsing from
>> the mmc node directly and parsing child "slot" nodes). we won't have
>> to change the DT bindings when the first version that will be
>> mainlined already has support for the mux
>>
>> please let me know if there's anything I can do to make the code
>> easier to review.
>
> No worries, let me have a look as is!
okay, perfect! just take your time and let me know what needs to be changed.


Regards,
Martin


[0] https://github.com/endlessm/linux-meson/blob/master/arch/arm/mach-meson8/include/mach/sd.h#L231
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
