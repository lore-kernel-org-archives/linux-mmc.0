From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx50: imx50-esdhc use imx53-esdhc
Date: Mon, 10 Oct 2016 08:47:07 +0200
Message-ID: <20161010064707.c4vk5kxw5bxgpdgs@pengutronix.de>
References: <1476030890-18274-1-git-send-email-akurz@blala.de>
 <5eae97cb-7a15-9bcf-f732-6141f99f0990@mleia.com>
 <alpine.DEB.2.00.1610092241410.19531@blala.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51454 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751691AbcJJGrM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Oct 2016 02:47:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1610092241410.19531@blala.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Kurz <akurz@blala.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Lucas Stach <l.stach@pengutronix.de>

Hello,

On Sun, Oct 09, 2016 at 11:09:28PM +0200, Alexander Kurz wrote:
> On Sun, 9 Oct 2016, Vladimir Zapolskiy wrote:
> > On 09.10.2016 18:34, Alexander Kurz wrote:
> > > -					compatible = "fsl,imx50-esdhc";
> > > +					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
> > > [...]
> >
> > Regarding DTS change if the controllers are the same I think it may
> > have sense to add "fsl,imx50-esdhc" compatible to imx53.dtsi definitions,
> > but not the other way round.
> Is there some requirement for ascending numbers?

No, usually the older hardware defines the major name[1]. So IMHO the change
under discussion here is fine. Check the output of

	git grep imx27 arch/arm/boot/dts/imx25.dtsi

to get a few samples of a similar case. (i.e. imx25 is newer but got
the smaller number.)

Best regards
Uwe

[1] I'd expect that older might also mean "first supported by a
    binding".

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
