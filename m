From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v4 0/10] mmc: meson-gx: series with smaller improvements
Date: Fri, 03 Mar 2017 21:33:40 -0800
Message-ID: <7hfuitvc5n.fsf@baylibre.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
        <m2innq12j0.fsf@baylibre.com>
        <d458c13f-f870-6dc4-95f7-e5c867bf6298@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35529 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbdCDFdm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Mar 2017 00:33:42 -0500
Received: by mail-pg0-f54.google.com with SMTP id b129so50436212pgc.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 21:33:41 -0800 (PST)
In-Reply-To: <d458c13f-f870-6dc4-95f7-e5c867bf6298@gmail.com> (Heiner
        Kallweit's message of "Fri, 3 Mar 2017 23:54:02 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Am 03.03.2017 um 22:19 schrieb Kevin Hilman:
>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>=20
>>> New series is limited to smaller refactorings w/o functional changes.
>>=20
>> I'd reviewed this series before, but hadn't actually tested it until
>> today.  I applied this series onto today's linux-next, and tested on
>> meson-gxbb-odroidc2 and the kernel hangs up right after:
>>=20
>>        meson-gx-mmc d0072000.mmc: Got CD GPIO
>>=20
>> with no error message or oops/backtrace etc.
>>=20
>> Could you clarify how you are testing this, on what tree/branch, on what
>> hardware etc.?
>>=20
> I'm testing on Odroid C2 with a self-built uboot based on the latest
> mainline uboot incl. an own eMMC driver which was submitted but is
> not yet applied to mainline uboot.
> The system is running headless with a serial console attached.
> Storage is a 128 GB Hardkernel eMMC card.
>
> I use latest next kernel + the patches to test.
>
> Does your system work w/o the current patch set?

Yes.

> And do you use HS200 or HS400 mode?

I don't remember what kind of card is plugged in, and I'm away from the
board currently.

Since you have a custom uboot, with a custom MMC driver, I suspect that
your uboot is initializing something that the kernel is not, so when a
kernel is used that's not using your uboot, something goes wrong.

Any chance you can try with the vendor uboot from Hardkernel?

I tested on odroid-c2 because someone on the #linux-amlogic IRC channel
(webczat) reported the hang when testing your patches, so I tried to
reproduce and got the same hang.

Until we figure out what the hang is, this series should not be merged.

Kevin

> I also figured out that 200MHz w/o tuning is a little fragile and
> reduced the clock to 60 MHz. This makes no difference in performance
> as the driver currently is very slow anyway (only 10 - 15 MB/s).
> When the clock is too high I see lots of CRC errors on the serial
> console.
>
> This will change with further patches I have in my tree.
> They allow stable HS200/HS400 with quite basic tuning resulting in
> 140 MB/s read performance.
> Stable configuration here is: 180=C2=B0 core clock phase, 0=C2=B0 tx clock
> phase, 180=C2=B0 rx clock phase.
>
>> Also, in the cover letter, it's customary to include a summary of what
>> changed since the previous version(s)
>>=20
>> Kevin
>>=20
>>> Heiner Kallweit (10):
>>>   mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
>>>   mmc: meson-gx: make two functions return void
>>>   mmc: meson-gx: remove unused members irq, ocr_mask from struct meson_=
host
>>>   mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
>>>   mmc: meson-gx: remove member parent_mux from struct meson_host
>>>   mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
>>>   mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
>>>   mmc: meson-gx: improve initial configuration
>>>   mmc: meson-gx: remove member mrq from struct meson_host
>>>   mmc: meson-gx: replace magic timeout numbers with constants
>>>
>>>  drivers/mmc/host/meson-gx-mmc.c | 126 ++++++++++++++++----------------=
--------
>>>  1 file changed, 50 insertions(+), 76 deletions(-)
>>=20
