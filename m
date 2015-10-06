From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 0/8] Armada 38x SDHCI driver improvements
Date: Tue, 06 Oct 2015 16:43:16 +0200
Message-ID: <87lhbg9hx7.fsf@free-electrons.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52658 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbbJFOnn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 10:43:43 -0400
In-Reply-To: <1444094562-31165-1-git-send-email-mw@semihalf.com> (Marcin
	Wojtas's message of "Tue, 6 Oct 2015 03:22:34 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com

Hi Marcin,
 
 On mar., oct. 06 2015, Marcin Wojtas <mw@semihalf.com> wrote:

> Hi,
>
> This series brings a couple of fixes and improvements to Armada 38x SDHCI
> controller driver. First four patches are fixes, of which three are stable
> CC'ed.
>
> Another two add DAT3-pin based hardware card detection in the driver, what
> should be used by the newest revisions of A388-GP boards.
>
> The last patches enable MMC_CARD bit, using init_card() callback added to
> SDHCI hosts.
>
> Any remarks and comments are welcome.

Thanks for this series, it looks good I have only one or two comments.

I also want to test it, how do you test the resume?
using standby or suspend to ram (by hacking the kernel as currently we
disbaled it) ?

Thanks,

Gregory

>
> Best regards,
> Marcin
>
> Marcin Wojtas (6):
>   mmc: sdhci-pxav3: fix error handling of armada_38x_quirks
>   mmc: sdhci-pxav3: enable proper resuming on Armada 38x SoC
>   mmc: sdhci-pxav3: enable usage of DAT3 pin as HW card detect
>   ARM: mvebu: enable SDHCI card detection using DAT3 pin on A388-GP
>   mmc: sdhci: add init_card callback to sdhci
>   mmc: sdhci-pxav3: enable modifying MMC_CARD bit during card
>     initialization
>
> Nadav Haklai (2):
>   mmc: sdhci-pxav3: remove broken clock base quirk for Armada 38x sdhci
>     driver
>   mmc: sdhci-pxav3: disable clock inversion for HS MMC cards
>
>  .../devicetree/bindings/mmc/sdhci-pxa.txt          |   5 +
>  arch/arm/boot/dts/armada-388-gp.dts                |   3 +-
>  drivers/mmc/host/sdhci-pxav3.c                     | 101 ++++++++++++++++-----
>  drivers/mmc/host/sdhci.c                           |  14 ++-
>  drivers/mmc/host/sdhci.h                           |   4 +
>  5 files changed, 102 insertions(+), 25 deletions(-)
>
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
