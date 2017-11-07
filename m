From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: More TMIO MMC variant. What is a preferred name?
Date: Tue, 7 Nov 2017 16:52:29 +0900
Message-ID: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from condef-06.nifty.com ([202.248.20.71]:41241 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756336AbdKGH5S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Nov 2017 02:57:18 -0500
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-06.nifty.com with ESMTP id vA77rLOQ002915
        for <linux-mmc@vger.kernel.org>; Tue, 7 Nov 2017 16:53:21 +0900
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com [209.85.161.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id vA77rAL5025261
        for <linux-mmc@vger.kernel.org>; Tue, 7 Nov 2017 16:53:10 +0900
Received: by mail-yw0-f182.google.com with SMTP id q126so10111176ywq.10
        for <linux-mmc@vger.kernel.org>; Mon, 06 Nov 2017 23:53:10 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram, Simon, and Renesas engineers,


Currently, TMIO and Renesas SDHI share the same MMC core code.
I am planning to upstream one more variant for Socionext SoC family.

First, you may wonder why the tmio_mmc_core is used
for several SoC vendors.

As you may know, the provider of this IP is NOT Toshiba, but Panasonic.
So, the tmio_mmc_core is an unfortunate name.


Here is a short history of this IP.

Panasonic (the company name was Matsushita Electric Industrial at that time)
was one of the main board members of SD Association,
and developed an SD controller LSI.

This one  (MN5774)
https://industrial.panasonic.com/content/data/SC/ds/ds4/MN5774__E_discon.pdf?__hstc=231811840.07430159d50a3c91e72c280a7921bf0d.1506902400089.1506902400090.1506902400091.1&__hssc=231811840.1.1506902400092&__hsfp=1773666937

It was a dedicated controller chip connected to 16-bit bus.

That's why the register map of this IP is 16-bit oriented.
(Of course, the driver can support 32bit SoC bus with bus_shift == 1
or 64bit with bus_shift == 2.)

Besides, the IP was integrated into Panasonic own SoCs,
and also sold to several SoC vendors, including Toshiba, Renesas, and more.

I know Renesas extended this IP by themselves for 64bit bus, HS200,
internal DMAC etc,
but Panasonic still holds the right to sell the original of this IP.

Panasonic split the system LSI business out to Socionext Inc. in 2015.
That is why I want to upstream a new driver sharing the driver core code.
(Rather, the IP in Socionext SoCs is a lineage one)

The above is a history from the HW point of view
I heard from a hardware engineer who was involved in this IP
in Panasonic and Socionext.

Also, the log message of commit b6147490e6aac82fa2f4b9d7fce925d9891ebe8f
completely supports my comments.


>From the SW point of view, tmio_mmc was the first driver
merged in Linux.  Renesas largely expanded it for their SoC port.
Many thanks for big contributions.
In hindsight, the naming is unfortunate, though.


As far as I understood, TMIO is a name of MFD
(driver/mfd/tmio_core.c and its variants)


drivers/mmc/tmio_mmc.c is OK.

drivers/mmc/tmio_mmc_core.c is odd.
TMIO-MMC is just one user of this IP.


If you see  dw_mmc family,  drivers are named
in the form of <IP>-<SoC>.c


I know this is a big churn, but I'd like
to propose renaming like follows in a long run:

tmio_mmc_core.c      ->  mnsd.c              Core code of this IP
tmio_mmc.c           ->  mnsd-tmio.c         For MMC integrated in TMIO MFD
renesas_sdhi_core.c  ->  mnsd-renesas-core.c For Renesas SoCs
(or, mnsd-sdhi-core.c or whatever. please choose any favorite name)
                         mnsd-uniphier.c     For Socionext UniPhier SoCS



I see more strangeness.  Those mmc drivers must include <linux/mfd/tmio.h>,
but TMIO is unrelated to Renesas, Socionext.
We need to fix the interface.


If I can get consensus, I am very happy to
contribute for better organizing this IP variants.


CCing Marek Vasut, a contractor working for Renesas.
He and I are also working on SD card driver in U-Boot.
I want to introduce correct and systematic naming scheme
for a long-run maintainability and applicable to other projects
since Linux has a big influence in OSS.


-- 
Best Regards
Masahiro Yamada
