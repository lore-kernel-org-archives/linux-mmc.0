From: Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH v3 0/5] Armada 38x SDHCI driver improvements
Date: Wed, 21 Oct 2015 13:59:44 +0200
Message-ID: <CAPv3WKe9dqqjL-LCMLtpgm7Xuszor430ZY6VbJKFDshDqrPuJA@mail.gmail.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36389 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbJUL7p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 07:59:45 -0400
Received: by obcqt19 with SMTP id qt19so38549210obc.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2015 04:59:45 -0700 (PDT)
In-Reply-To: <1444926346-29763-1-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, =?UTF-8?Q?Gregory_Cl=C3=A9ment?= <gregory.clement@free-electrons.com>, nadavh@marvell.com, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Grzegorz Jaszczyk <jaz@semihalf.com>, Jisheng Zhang <jszhang@marvell.com>

Hi Ulf,

Do you have any remarks or comments to the series?

Best regards,
Marcin

2015-10-15 18:25 GMT+02:00 Marcin Wojtas <mw@semihalf.com>:
> Hi,
>
> Thank you for reviewing the patches. According to your remarks and some
> new ideas I prepared third patchset. I modified my HW and now I could
> check operation when using all three modes of detection (polling, gpio
> and dat3) - it all seems working fine. Any remarks will be wellcome.
>
> Best regards,
> Marcin
>
> Changes:
> v1 -> v2
> * enable SW polling as card detection
> * in resume function change condition for mbus windows reconfiguration
>
> v2 -> v3
> * remove redundant print after fail of mbus_win_regs obtaining
> * add big comment on possible card detection options in armada-388-gp.dts
> * reconstruct dat3-cd support
>         - use dedicated flag in sdhci_pxa structure instead of checking
>           property in DT
>         - instead of global SDHCI quirk add wrapper for sdhci_set_clock
>           function in order to keep internal clock enabled
>         - prevent using pm_runtime in case of using dat3-cd
> * improve MMC_CARD bit modification - do not check Armada 38x compatible
>   string in pxav3_init_card callback, but use pxa->mbus_win_regs as a flag
>
> Marcin Wojtas (5):
>   mmc: sdhci-pxav3: enable proper resuming on Armada 38x SoC
>   mmc: sdhci-pxav3: enable usage of DAT3 pin as HW card detect
>   ARM: mvebu: set SW polling as SDHCI card detection on A388-GP
>   mmc: sdhci: add init_card callback to sdhci
>   mmc: sdhci-pxav3: enable modifying MMC_CARD bit during card
>     initialization
>
>  .../devicetree/bindings/mmc/sdhci-pxa.txt          |   5 +
>  arch/arm/boot/dts/armada-388-gp.dts                |  15 +-
>  drivers/mmc/host/sdhci-pxav3.c                     | 157 ++++++++++++++++-----
>  drivers/mmc/host/sdhci.c                           |   9 ++
>  drivers/mmc/host/sdhci.h                           |   1 +
>  5 files changed, 149 insertions(+), 38 deletions(-)
>
> --
> 1.8.3.1
>
