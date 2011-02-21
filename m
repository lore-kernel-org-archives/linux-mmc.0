From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH 5/5] mmc: sdhci: add quirk
 SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Mon, 21 Feb 2011 10:18:30 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
 <20110221100439.GE2616@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:4787 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BUKUA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 05:20:00 -0500
In-Reply-To: <20110221100439.GE2616@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Zhao Richard-B20223 <B20223@freescale.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>

Hi Wolfsang:
See my comments marked by Richard Zhu below.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Monday, February 21, 2011 6:05 PM
> To: Zhao Richard-B20223
> Cc: linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de; linux-
> mmc@vger.kernel.org; cjb@laptop.org; avorontsov@ru.mvista.com;
> eric@eukrea.com; linuxzsc@gmail.com; Zhu Richard-R65037; Zhu Richard-
> R65037
> Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
> SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
>
> On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> > Fix no INT in MULTI-BLK IO.
> >
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 9b82910..2eeb03e 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -113,7 +113,10 @@ static int esdhc_pltfm_init(struct sdhci_host
> *host, struct sdhci_pltfm_data *pd
> >     clk_enable(clk);
> >     pltfm_host->clk = clk;
> >
> > -   if (cpu_is_mx35() || cpu_is_mx51())
> > +   if (cpu_is_mx53())
> > +           host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
>
> Have you tried it doing it via IO-accessors?
Richard Zhu: This quirk is used to fix a mechanism problem in the MMC CMDs execution procedure.
It would be very abrupt and ugly, if the IO-accessors are added into these original procedures.
So one quirk is used here, and used to fix two different case.
One is multi-blk read in SDIO mode, the other is the Mult-blk read/write in mass storage mode.

>
> > +   if (cpu_is_mx35() || cpu_is_mx51() || cpu_is_mx53())
>
> Maybe we should use !cpu_is_mx25 for simplicity?
Richard Zhu: Accepted.
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |

