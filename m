From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: MMC flash is very slow since 4.14 - "mmc: Delete bounce buffer handling" was
 the problem
Date: Wed,  3 Jan 2018 11:38:20 +0100 (CET)
Message-ID: <OF6E8F2076.873BA83E-ONC125820A.002C8518-C125820A.003A70E6@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:49932 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeACKiX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 05:38:23 -0500
In-Reply-To: 
References: 
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>

First of all, thanks for your replies.

To Uffe

> Thanks for reporting!
> 
> Could you perhaps post some performance measurements done "before" and
> "after". A guess a simple "dd" test is sufficient, just to get an idea
> in what range the regression is about?

I did some time measurements with a 4.14.11 kernel without the bounce buffer 
patch and mainline. 


KERNEL without bounce buffer patch

#time dd if=/dev/zero of=test bs=1M count=1 
real	0m0.358s
user	0m0.002s
sys	0m0.129s

#time dd if=/dev/zero of=test bs=1M count=4
real	0m3.718s
user	0m0.000s
sys	0m0.389s

#time dd if=/dev/zero of=test bs=1M count=8
real	0m4.383s
user	0m0.000s
sys	0m0.753s

#time dd if=/dev/zero of=test bs=1M count=16
real	0m9.635s
user	0m0.011s
sys	0m1.455s

#time dd if=/dev/zero of=test bs=1M count=32
real	0m18.861s
user	0m0.002s
sys	0m2.927s


KERNEL MAINLINE

#time dd if=/dev/zero of=test bs=1M count=1
real	0m1.228s
user	0m0.000s
sys	0m0.127s

#time dd if=/dev/zero of=test bs=1M count=4
real	0m4.415s
user	0m0.000s
sys	0m0.387s

#time dd if=/dev/zero of=test bs=1M count=8
real	0m15.349s
user	0m0.000s
sys	0m0.784s

#time dd if=/dev/zero of=test bs=1M count=16
real	0m32.002s
user	0m0.018s
sys	0m1.507s

#time dd if=/dev/zero of=test bs=1M count=32
real	1m5.444s
user	0m0.000s
sys	0m2.975s


To Linus

> Can you confirm that you see "using PIO" in your dmesg kernel log?
> Or are you just using "DMA"? (i.e. SDMA, see below)

#dmesg | grep SDHCI
[    1.302225] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.370016] mmc0: SDHCI controller on 53fb4000.esdhc [53fb4000.esdhc] using DMA
[    1.450436] mmc1: SDHCI controller on 53fb8000.esdhc [53fb8000.esdhc] using DMA


> Can we try the easy solutions first, what about testing something like this?
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e9290a3439d5..2b3da32fa27b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -25,6 +25,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> +#include <linux/sizes.h>
> 
>  #include <linux/leds.h>
> 
> @@ -3672,8 +3673,13 @@ int sdhci_setup_host(struct sdhci_host *host)
>                         mmc->max_req_size = min(mmc->max_req_size,
>                                                 max_req_size);
>                 }
> -       } else { /* PIO */
> -               mmc->max_segs = SDHCI_MAX_SEGS;
> +       } else {
> +               /*
> +                * This is the PIO case: we can use huge requests and lots of
> +                * segments because there are no hardware limitations.
> +                */
> +               mmc->max_req_size = SZ_4M;
> +               mmc->max_segs = 1024;
>         }
> 
>         /*

Because we are using DMA I don't think that solution will do anything. 

I've had a look in sdhci.c:

	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
		host->flags |= SDHCI_USE_SDMA;
	else if (!(host->caps & SDHCI_CAN_DO_SDMA))
		DBG("Controller doesn't have SDMA capability\n");
	else
		host->flags |= SDHCI_USE_SDMA;

SDHCI_QUIRK_FORCE_DMA and SDHCI_CAN_DO_SDMA is not set in the driver. 
Are these options will be set anywhere in sdhci core? 
I grepped for SDHCI_CAN_DO_SDMA but it's just files which are not relevant 
to our problem. 

> If you're using SDMA, maybe, just maybe, PIO is actually faster, because
> it avoids the buffer copying that happens just in order to put things nicely
> in order for SDMA.

I just did a quick test and commented out the else part in the above code 
snippet to use PIO but after that try the devices doesn't boot anymore. 

Did I miss something?
