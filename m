From: Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [RFC 0/2] Add support for Meson MX "SDIO" MMC driver
Date: Wed, 10 May 2017 21:22:10 +0200
Message-ID: <CAFBinCDGBZAAx_61eyu1_XM57fX62Mk03TEiO3uTL+i8dfPyZA@mail.gmail.com>
References: <20170506171857.16492-1-martin.blumenstingl@googlemail.com> <CAPDyKFoYPjB1bjRfFCFT3vuzKgzm6-7L2qgNjxGL392cLDe7uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoYPjB1bjRfFCFT3vuzKgzm6-7L2qgNjxGL392cLDe7uA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Wed, May 10, 2017 at 10:44 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 6 May 2017 at 19:18, Martin Blumenstingl
> <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
>> This is the successor to Carlo Caione's "Add support for Amlogic Meson
>> MMC driver" series (v5) from [0].
>>
>> I would like you to specifically review:
>> - whether I've (ab)used the MMC framework properly (as this is my first
>>   "larger" contribution to an MMC driver)
>
> I take a look soonish.
thank you!

>> - I think I have improved the locking compared to Carlo's version,
>>   however I'd still like feedback on whether this looks sane now or if I
>>   can improve that even further
>>
>> (notable) changes since Carlo's latest version are:
>> - renamed the driver to meson-mx-sdio (Amlogic's reference kernel calls
>>   the driver "aml_sdio" as there is a second MMC controller in these SoCs
>>   which they call the "SDHC controller"). do the same with our driver to
>
> I don't like to renaming drivers, just because there are a reference
> kernel using a different name.
>
> What's is really the difference between controllers? Why do they have
> two variants?
the driver from this thread is for the "SDSC/SDHC/SDXC card and SDIO
interface with 1-bit and 4-bit data bus width supporting spec version
2.x/3.x/4.x DS/HS modes up to UHS-I SDR50" (quote taken from the S805
datasheet: [0])
the "other" controller is an "eMMC and MMC card interface with
1/4/8-bit data bus width supporting spec version 4.4x/4.5x HS200 (up
to 100MHz clock), compatible with standard iNAND interface" (again,
quote taken from the S805 datasheet: [0])

>
> Can they be managed by the same driver?
>
>>   avoid confusion once we add support for the second controller (which uses
>>   a completely different register layout)
>
> Besides that, do they behave differently in some other way?
both drivers/controllers have a totally different register layout - I
don't see any way how they both could be handled by one driver (the
registers for the controllers from this series are not part of the
documentation, but the registers from the 8-bit capable controller
are, see page 76 and following from the S805 datasheet: [0])

>> - add support for the internal "mux" in this MMC controller (which allows
>>   connecting up to three devices to the the controller - at the cost of
>>   performance though since the controller can only process one request at
>>   a time). The driver registers a new device for each sub-node, which is
>>   then fed into the MMC framework to allow per-slot configuration using
>>   devicetree (see the example in the documentation)
>
> Unless there really is deployment for more than one slot on some
> boards/SoCs, I would strongly suggest to *not* implement this.
>
> Simply because of overhead and introduced complexity to the driver.
actually there are lots of devices out there which need to use two slots:
as mentioned above the S805 (Meson8b) SoC has two MMC controllers:
- one which is typically used for the SD card and the SDIO wireless
interface (the driver from this series handles this)
- the other one is typically connects to eMMC flash (as it supports
8-bit bus width - this controller is not related to the driver from
this series)

there are boards out there which use NAND flash instead of eMMC, but
the majority of the consumer devices (based on Amlogic SoCs) out there
uses eMMC flash.
we (unfortunately) have to support the internal mux since there are
three MMC devices (SD card, SDIO wifi and eMMC) but only two
controllers.

I agree with you that it adds extra complexity to the driver. I tried
to keep it as simple as possible - but I think we cannot remove it
(without "losing" access to one MMC devices on most boards)

>> - use the common clock framework internally for managing the MMC clock
>>   (there is a fixed-factor clock in the controller which takes clk81 as
>>    input and divides it's clock by two and a divider clock which takes
>>    the result from the fixed-factor clock as input)
>> - support the regulators provided by the MMC framework
>> - support for GPIO-based card-detection and read-only-detection through
>>   the MMC framework
>> - use of the <linux/bitfield.h> FIELD_PREP and FIELD_GET macros where it
>>   make sense (and thus the code easier to read)
>> - re-worked locking (based on the locking in dw_mmc as that also provides
>>   multiple "MMC slots")
>
> Lots of changes!
>
> Before even start to review (or someone else), you really need to make
> this review-able.
>
> So, please, one change per patch - and make sure to write good
> changelogs. Then I can start to review.
from the mainline tree's perspective this is a new driver:
Carlo (the original author) initially sent this driver for review more
than 14 months ago. unfortunately it was never merged since you
spotted some issues while reviewing that code, see [1].
I would have sent smaller patches for a driver which is already in mainline.

I also wanted to avoid extra complexity for the internal mux if it was
added later on (if we want to avoid breaking devicetree backwards
compatibility then the driver would have to support both: parsing from
the mmc node directly and parsing child "slot" nodes). we won't have
to change the DT bindings when the first version that will be
mainlined already has support for the mux

please let me know if there's anything I can do to make the code
easier to review.

>>
>> tests done so far:
>> - reading an OLD 256MiB SD card (which uses only a 1-bit bus) works fine
>>   (sha1sum of the whole device matches with what I get on my PC's
>>   card-reader)
>> - reading a somewhat more modern class 10 SD card and putting Arch Linux
>>   ARM on it (and using that as root file system)
>> - it successfully detects the RTL8723BS SDIO wifi chip in my device (even
>>   if the SD card is also enabled)
>> - reading a 128MiB file from the SD card while scanning wifi networks on
>>   the RTL8723BS card does not seem to result in any corruption (sha1sum
>>   of the read file seems to match)
>> - read speed of my class 10 SD card: ~15MiB/s
>> - (unfortunately I could NOT test downloading a file over wifi to the SD
>>   card because the RTL8723BS driver refuses to see any wifi networks, but
>>   that might be a problem on the RTL8723BS driver side since I don't get
>>   any error and the driver has just landed a few weeks ago in staging)
>>
>>
>> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/412136.html
>>
>
> [...]
>
> Kind regards
> Uffe


Regards,
Martin


[0] https://dn.odroid.com/S805/Datasheet/S805_Datasheet%20V0.8%2020150126.pdf
[1] https://patchwork.kernel.org/patch/8444841/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
