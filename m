From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4 0/10] mmc: meson-gx: series with smaller improvements
Date: Fri, 3 Mar 2017 21:36:03 -0800
Message-ID: <CAOi56cVN_ZAJ8L7tdk1VeTpADukUmZO6rffRnXS8-64PxxtvYQ@mail.gmail.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
 <m2innq12j0.fsf@baylibre.com> <d458c13f-f870-6dc4-95f7-e5c867bf6298@gmail.com>
 <7hfuitvc5n.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:34009 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdCDFgo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 00:36:44 -0500
Received: by mail-oi0-f46.google.com with SMTP id m124so65571098oig.1
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 21:36:04 -0800 (PST)
In-Reply-To: <7hfuitvc5n.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic <linux-amlogic@lists.infradead.org>

On Fri, Mar 3, 2017 at 9:33 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
>
>> Am 03.03.2017 um 22:19 schrieb Kevin Hilman:
>>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>>
>>>> New series is limited to smaller refactorings w/o functional changes.
>>>
>>> I'd reviewed this series before, but hadn't actually tested it until
>>> today.  I applied this series onto today's linux-next, and tested on
>>> meson-gxbb-odroidc2 and the kernel hangs up right after:
>>>
>>>        meson-gx-mmc d0072000.mmc: Got CD GPIO
>>>
>>> with no error message or oops/backtrace etc.
>>>
>>> Could you clarify how you are testing this, on what tree/branch, on what
>>> hardware etc.?
>>>
>> I'm testing on Odroid C2 with a self-built uboot based on the latest
>> mainline uboot incl. an own eMMC driver which was submitted but is
>> not yet applied to mainline uboot.
>> The system is running headless with a serial console attached.
>> Storage is a 128 GB Hardkernel eMMC card.
>>
>> I use latest next kernel + the patches to test.
>>
>> Does your system work w/o the current patch set?
>
> Yes.
>
>> And do you use HS200 or HS400 mode?
>
> I don't remember what kind of card is plugged in, and I'm away from the
> board currently.

>From a boot of linux-next without this series, look like it's detecting HS200:

root@buildroot:/# dmesg |grep -i mmc
[    1.359545] meson-gx-mmc d0074000.mmc: allocated mmc-pwrseq
[    1.632159] meson-gx-mmc d0072000.mmc: Got CD GPIO
[    1.778734] mmc1: new high speed SDHC card at address 1234
[    1.779007] mmcblk1: mmc1:1234 SA08G 7.21 GiB
[    1.784197]  mmcblk1: p1
[    1.925634] mmc0: new HS200 MMC card at address 0001
[    1.925875] mmcblk0: mmc0:0001 SDW16G 14.7 GiB
[    1.929550] mmcblk0boot0: mmc0:0001 SDW16G partition 1 4.00 MiB
[    1.935404] mmcblk0boot1: mmc0:0001 SDW16G partition 2 4.00 MiB
[    1.942428]  mmcblk0: p1 p2

Kevin
