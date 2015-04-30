From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 0/9] Add sd/emmc support for stih407 family silicon
Date: Thu, 30 Apr 2015 10:51:43 +0200
Message-ID: <CAPDyKFr4vpTtd5eAzrV6X+hm4Qr70Heb0yD=CF_H-rAtYYHw-w@mail.gmail.com>
References: <1428658831-14308-1-git-send-email-peter.griffin@linaro.org>
	<CAPDyKFouXDCbPB9Ow6vzRdHdWkscDs3fjThCX69mA97fwZ+Lfw@mail.gmail.com>
	<5541E7C5.1000903@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5541E7C5.1000903-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Patrice CHOTARD <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Giuseppe Cavallaro <peppe.cavallaro-qxv4g6HH51o@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 30 April 2015 at 10:28, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org> wrote:
> Hi Ulf,
>
>
> On 04/10/2015 01:06 PM, Ulf Hansson wrote:
>>
>> On 10 April 2015 at 11:40, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>
>>> Hi,
>>>
>>> This series adds sd/emmc support to the sdhci-st.c driver for stih407
>>> family silicon. The changes mainly involve configuring some extra glue
>>> registers in the flashSS which configure the Arasan controller.
>>>
>>> This series also adds support for UHS modes for eMMC. To allow
>>> UHS HS200/SD104 modes to function correctly, due to the
>>> tight timing constriants, support for delay management is also added.
>>> Two types of delay management are supported, static delay management and
>>> dynamic delay management, this delay management is only available
>>> on eMMC pads on stih410 and later silicon.
>>>
>>> This series has been tested with stih410-b2120 revd on eMMC and sd, at
>>> various clock speeds. As part of this testing a bug was also found in the
>>> upstream flexgen clock set_rate implementation (now fixed upstream).
>>>
>>>      max-frequency = 200Mhz
>>>      /dev/mmcblk0p1:
>>>       Timing buffered disk reads: 270 MB in  3.02 seconds =  89.54 MB/sec
>>>
>>>      max-frequency = 100Mhz
>>>      root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
>>>      /dev/mmcblk0p1:
>>>       Timing buffered disk reads: 210 MB in  3.00 seconds =  70.00 MB/sec
>>>
>>>      max-frequency = 50Mhz
>>>      root@debian-armhf:~# hdparm -t /dev/mmcblk0p1
>>>      /dev/mmcblk0p1:
>>>       Timing buffered disk reads: 118 MB in  3.00 seconds =  39.28 MB/sec
>>>
>>> It has also been tested on stih416-b2020 to ensure we have caused no
>>> regressions. Finally the dt documentation has been updated to reflect
>>> the changes in the driver code. Intrestingly it seems we are the first
>>> upstream platform to be using some of the uhs bindings such as
>>> sd-uhs-sdr104.
>>>
>>> Changes since v4:
>>>   - Fixup typo (Pete)
>>>
>>> Changes since v3:
>>>   - Rebased on Ulf's mmc next branch (rc5 based) (Ulf)
>>>
>>> Changes since v2:
>>>   - Some whitespace fixups (Max)
>>>   - if (!ioaddr) suggestion (Max)
>>>   - Add stih418-b2199 suport (Max)
>>>   - Stih410 to STiH410 fixes (Max)
>>>   - rebased on v4.0-rc6 (Pete)
>>>
>>> Changes since v1:
>>>   - Partition the changes into smaller patches to aid review process
>>> (Ulf)
>>>
>>> Peter Griffin (9):
>>>    mmc: sdhci-st: Add macros for register offsets and bitfields for mmcss
>>>      glue regs
>>>    mmc: sdhci-st: Add support for de-asserting reset signal and top regs
>>>      resource
>>>    mmc: sdhci-st: Add delay management functions for top registers
>>>      (eMMC).
>>>    mmc: sdhci-st: Add st_mmcss_cconfig function to configure mmcss glue
>>>      registers.
>>>    mmc: sdhci-st: Add sdhci_st_set_uhs_signaling function.
>>>    mmc: sdhci-st: Update the quirks for this controller.
>>>    mmc: sdhci-st: Update ST SDHCI binding documentation.
>>>    ARM: STi: DT: STiH407: Add dt nodes for sdhci and emmc.
>>>    ARM: STi: DT: STiH418: Add dt nodes for sdhci and emmc.
>>>
>>>   Documentation/devicetree/bindings/mmc/sdhci-st.txt | 100 +++++-
>>>   arch/arm/boot/dts/stih407-family.dtsi              |  30 ++
>>>   arch/arm/boot/dts/stih410-b2120.dts                |  10 +
>>>   arch/arm/boot/dts/stih418-b2199.dts                |  12 +
>>>   arch/arm/boot/dts/stihxxx-b2120.dtsi               |   8 +
>>>   drivers/mmc/host/sdhci-st.c                        | 354
>>> ++++++++++++++++++++-
>>>   6 files changed, 500 insertions(+), 14 deletions(-)
>>>
>>> --
>>> 1.9.1
>>>
>> Thanks! Applied.
>
> Do you confirm you didn't applied the DT patches?
>

Correct. Sorry if that was unclear.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
