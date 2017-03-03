From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v4 0/10] mmc: meson-gx: series with smaller improvements
Date: Fri, 3 Mar 2017 23:54:02 +0100
Message-ID: <d458c13f-f870-6dc4-95f7-e5c867bf6298@gmail.com>
References: <62912f3d-2307-cfff-3c69-c8b8ffaeb474@gmail.com>
 <m2innq12j0.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32827 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdCCWya (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 17:54:30 -0500
Received: by mail-wr0-f194.google.com with SMTP id g10so14873534wrg.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 14:54:15 -0800 (PST)
In-Reply-To: <m2innq12j0.fsf@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 03.03.2017 um 22:19 schrieb Kevin Hilman:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> New series is limited to smaller refactorings w/o functional changes.
> 
> I'd reviewed this series before, but hadn't actually tested it until
> today.  I applied this series onto today's linux-next, and tested on
> meson-gxbb-odroidc2 and the kernel hangs up right after:
> 
>        meson-gx-mmc d0072000.mmc: Got CD GPIO
> 
> with no error message or oops/backtrace etc.
> 
> Could you clarify how you are testing this, on what tree/branch, on what
> hardware etc.?
> 
I'm testing on Odroid C2 with a self-built uboot based on the latest
mainline uboot incl. an own eMMC driver which was submitted but is
not yet applied to mainline uboot.
The system is running headless with a serial console attached.
Storage is a 128 GB Hardkernel eMMC card.

I use latest next kernel + the patches to test.

Does your system work w/o the current patch set?
And do you use HS200 or HS400 mode?

I also figured out that 200MHz w/o tuning is a little fragile and
reduced the clock to 60 MHz. This makes no difference in performance
as the driver currently is very slow anyway (only 10 - 15 MB/s).
When the clock is too high I see lots of CRC errors on the serial
console.

This will change with further patches I have in my tree.
They allow stable HS200/HS400 with quite basic tuning resulting in
140 MB/s read performance.
Stable configuration here is: 180° core clock phase, 0° tx clock
phase, 180° rx clock phase.

> Also, in the cover letter, it's customary to include a summary of what
> changed since the previous version(s)
> 
> Kevin
> 
>> Heiner Kallweit (10):
>>   mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
>>   mmc: meson-gx: make two functions return void
>>   mmc: meson-gx: remove unused members irq, ocr_mask from struct meson_host
>>   mmc: meson-gx: remove unneeded variable in meson_mmc_clk_init
>>   mmc: meson-gx: remove member parent_mux from struct meson_host
>>   mmc: meson-gx: remove unneeded meson_mmc_clk_set in meson_mmc_clk_init
>>   mmc: meson-gx: remove unneeded devm_kstrdup in meson_mmc_clk_init
>>   mmc: meson-gx: improve initial configuration
>>   mmc: meson-gx: remove member mrq from struct meson_host
>>   mmc: meson-gx: replace magic timeout numbers with constants
>>
>>  drivers/mmc/host/meson-gx-mmc.c | 126 ++++++++++++++++------------------------
>>  1 file changed, 50 insertions(+), 76 deletions(-)
> 

