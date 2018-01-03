From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: MMC flash is very slow since 4.14 - "mmc: Delete bounce buffer handling" was
 the problem
Date: Wed,  3 Jan 2018 16:32:57 +0100 (CET)
Message-ID: <OF030842CB.F1296E1F-ONC125820A.0053A410-C125820A.005569FE@rittal.de>
References: <CACRpkdYbdx=ncW2HaB=GZvR59Htyon=9=1ewzPo9hKdsRq_FhQ@mail.gmail.com>,
        <OF6E8F2076.873BA83E-ONC125820A.002C8518-C125820A.003A70E6@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:60465 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbeACPc7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 10:32:59 -0500
In-Reply-To: <CACRpkdYbdx=ncW2HaB=GZvR59Htyon=9=1ewzPo9hKdsRq_FhQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>

> Hm can you try just something like this, making the device fall back
> to PIO? (Verify with boot messages...)

I verified the fall back already with my last post. In the bootlog the 
SDHCI controller was explicity using PIO, but then it hangs.
Sorry maybe i wasn't clear enough about that. 

But I tested your idea against the mainline kernel and had the same results.

mmc0: SDHCI controller on 53fb4000.esdhc [53fb4000.esdhc] using PIO
sdhci-esdhc-imx 53fb8000.esdhc: Got CD GPIO
sdhci-esdhc-imx 53fb8000.esdhc: Got WP GPIO
mmc1: SDHCI controller on 53fb8000.esdhc [53fb8000.esdhc] using PIO
random: crng init done


But it hangs while booting. The lines above are the last output on the serial console.

So, for now, I guess the device needs the DMA.

Kinds,
Benjamin Beckmeyer
