From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: MMC flash is very slow since 4.14 - "mmc: Delete bounce buffer
 handling" was the problem
Date: Tue, 2 Jan 2018 23:59:07 +0100
Message-ID: <CACRpkdbsF2pAKZu-PsFG8m96-4JYxvtK1bzutZ6R5OjBF3xkzw@mail.gmail.com>
References: <OF8C6780FA.78E4ECBE-ONC1258209.003268EF-C1258209.003268F0@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:33777 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeABW7I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jan 2018 17:59:08 -0500
Received: by mail-io0-f180.google.com with SMTP id t63so330024iod.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jan 2018 14:59:08 -0800 (PST)
In-Reply-To: <OF8C6780FA.78E4ECBE-ONC1258209.003268EF-C1258209.003268F0@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>

On Tue, Jan 2, 2018 at 10:10 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

> I have a problem with mmc flash on an i.mx 25 architecture.
> Im running it with Linux 4.14.x and the flash is really slow.
> I digged a little bit deeper into this problem and it has nothing to do
> with the driver (sdhci-esdhci-imx.c), because all registers for the SDHCI
> have the same values in a kernel before 4.14 and in the current 4.14 kernel.
>
> I figured out that following commit "mmc: Delete bounce buffer handling"  is
> the problem.

OK my fault then. Let's see if we can figure this out.

It seems I missed that some SDHCI derivatives are lacking
hardware scatter-gather handling, i.e.
 commit 2134a922c6e7 ("sdhci: scatter-gather (ADMA) support")
does not apply to this host.

But this commit by Pierre is from 2008 and then "some old SDHCI
controllers" had broken ADMA. And i.MX25 is from 2009! But then I
found this in the driver:

/*
 * The IP has erratum ERR004536
 * uSDHC: ADMA Length Mismatch Error occurs if the AHB read access is slow,
 * when reading data from the card
 * This flag is also set for i.MX25 and i.MX35 in order to get
 * SDHCI_QUIRK_BROKEN_ADMA, but for different reasons (ADMA capability bits).
 */

(...)
static struct esdhc_soc_data esdhc_imx25_data = {
    .flags = ESDHC_FLAG_ERR004536,
};

static struct esdhc_soc_data esdhc_imx35_data = {
    .flags = ESDHC_FLAG_ERR004536,
};

(...)
    if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
        host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;

So the i.MX25 is especially broken, right... :(
I guess it doesn't help to try to get it working somehow, people must
have already hacked at this? Also SDMA is not applicable I guess?

When SDHCI_QUIRK_BROKEN_ADMA is set, we reach this:

        pr_info("%s: SDHCI controller on %s [%s] using %s\n",
                mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
                (host->flags & SDHCI_USE_ADMA) ?
                (host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
                (host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");

Can you confirm that you see "using PIO" in your dmesg kernel log?
Or are you just using "DMA"? (i.e. SDMA, see below)

Next, remedies.

My suggestion was that what OMAP HSMMC was doing in
commit 0ccd76d4c236 ("omap_hsmmc: Implement scatter-gather emulation")
would be applicable to any such hosts.

I don't understand why an ARM system like this would benefit from bounce
buffers. They don't have especially slow memory access in certain memory
areas or anything like that, for what I know. It should technically be
a slowdown
as it just copies buffers back and forth.

It seems OMAPs also use sg_miter so I guess the speed gains comes from
upping the segment and request sizes? These are currently 512 kB
requests max and max 128 segments.

Can we try the easy solutions first, what about testing something like this?

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9290a3439d5..2b3da32fa27b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -25,6 +25,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/sizes.h>

 #include <linux/leds.h>

@@ -3672,8 +3673,13 @@ int sdhci_setup_host(struct sdhci_host *host)
                        mmc->max_req_size = min(mmc->max_req_size,
                                                max_req_size);
                }
-       } else { /* PIO */
-               mmc->max_segs = SDHCI_MAX_SEGS;
+       } else {
+               /*
+                * This is the PIO case: we can use huge requests and lots of
+                * segments because there are no hardware limitations.
+                */
+               mmc->max_req_size = SZ_4M;
+               mmc->max_segs = 1024;
        }

        /*

Still I'm a bit puzzled. Max segs of 128 and request size 512 K should be
pretty OK. Could it be that you're using SDMA, and since SDMA is just using
1 segment it benefits from the bounce buffer?

If you're using SDMA, maybe, just maybe, PIO is actually faster, because
it avoids the buffer copying that happens just in order to put things nicely
in order for SDMA.

Yours,
Linus Walleij
