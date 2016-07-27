From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: avoid unused function warnings
Date: Wed, 27 Jul 2016 09:30:04 +0200
Message-ID: <4495455.SxyUtqbGIN@wuerfel>
References: <20160726123246.879426-1-arnd@arndb.de> <19008164.GYnbEcydYS@wuerfel> <CAPDyKFrQuqCV_7LLm=ueJkj0wa9SCtoaGEJnivoXQ4hfrv-1OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:56685 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbcG0HaW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 03:30:22 -0400
In-Reply-To: <CAPDyKFrQuqCV_7LLm=ueJkj0wa9SCtoaGEJnivoXQ4hfrv-1OA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, July 27, 2016 12:48:23 AM CEST Ulf Hansson wrote:
> On 26 July 2016 at 22:56, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday, July 26, 2016 10:18:53 PM CEST Ulf Hansson wrote:
> >> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> >> > index 2bb326bbc34a..593e34053c4b 100644
> >> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> >> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> >> > @@ -1293,13 +1293,12 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
> >> >         return 0;
> >> >  }
> >> >
> >> > -#ifdef CONFIG_PM
> >> > -static int sdhci_esdhc_suspend(struct device *dev)
> >> > +static int __maybe_unused sdhci_esdhc_suspend(struct device *dev)
> >>
> >> Instead of using __maybe_unused, I prefer to change above "#ifdef
> >> CONFIG_PMf" to "#ifdef CONFIG_PM_SLEEP".
> >> I do realize that the runtime PM callbacks still requires #ifdef
> >> CONFIG_PM, so yes that's requires an extra "ifdef".
> >>
> >> Sure, it's more a matter of taste (and micro optimizations).
> >
> > I was hoping that we could eventually do a mass-conversion to
> > __maybe_unused, as everybody seems to get the #ifdef wrong.
> >
> > Any specific reason for your preference?
> 
> Only that this is how I get used to do it - and that it becomes a bit
> more clear what is needed to support the various PM configurations.
> 
> If you still insist on the "maybe_unused" option, that's okay as well.

I only have a mild preference for __maybe_unused because it's harder
to get wrong. I have sent dozens of bugfixes for drivers that have
incorrect #ifdef, and I'd prefer not having to send that many in the
future, so I try to convert them to __maybe_unused whenever a problem
shows up to slowly change the coding style in the kernel.

Build time coverage is another point here, but that is also what caused
problems in my patch since the declarations were hidden (I assume not
intentionally).

	Arnd
