From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: MMC flash is very slow since 4.14 - "mmc: Delete bounce buffer
 handling" was the problem
Date: Wed, 3 Jan 2018 15:45:25 +0100
Message-ID: <CACRpkdYbdx=ncW2HaB=GZvR59Htyon=9=1ewzPo9hKdsRq_FhQ@mail.gmail.com>
References: <OF6E8F2076.873BA83E-ONC125820A.002C8518-C125820A.003A70E6@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:46098 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeACOp0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 09:45:26 -0500
Received: by mail-it0-f66.google.com with SMTP id c16so1925738itc.5
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jan 2018 06:45:26 -0800 (PST)
In-Reply-To: <OF6E8F2076.873BA83E-ONC125820A.002C8518-C125820A.003A70E6@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>

On Wed, Jan 3, 2018 at 11:38 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

>> Can you confirm that you see "using PIO" in your dmesg kernel log?
>> Or are you just using "DMA"? (i.e. SDMA, see below)
>
> #dmesg | grep SDHCI
> [    1.302225] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.370016] mmc0: SDHCI controller on 53fb4000.esdhc [53fb4000.esdhc] using DMA
> [    1.450436] mmc1: SDHCI controller on 53fb8000.esdhc [53fb8000.esdhc] using DMA

Aha it is the SDMA on the i.MX that is benefiting from the bounce buffer.
So it is likely collecting a lot of small reads/writes into a bigger buffer and
that is why it becomes (a lot) faster.

>> Can we try the easy solutions first, what about testing something like this?
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
(...)
> Because we are using DMA I don't think that solution will do anything.

No you're right.

>> If you're using SDMA, maybe, just maybe, PIO is actually faster, because
>> it avoids the buffer copying that happens just in order to put things nicely
>> in order for SDMA.
>
> I just did a quick test and commented out the else part in the above code
> snippet to use PIO but after that try the devices doesn't boot anymore.
>
> Did I miss something?

Hm can you try just something like this, making the device fall back
to PIO? (Verify with boot messages...)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
b/drivers/mmc/host/sdhci-esdhc-imx.c
index 85140c9af581..f1d2e2f016f8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1299,7 +1299,7 @@ static int sdhci_esdhc_imx_probe(struct
platform_device *pdev)
                                        esdhc_executing_tuning;

        if (imx_data->socdata->flags & ESDHC_FLAG_ERR004536)
-               host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+               host->quirks |= SDHCI_QUIRK_BROKEN_ADMA |
SDHCI_QUIRK_BROKEN_DMA;

If that doesn't work I guess the device *must* use DMA.

Yours,
Linus Walleij
