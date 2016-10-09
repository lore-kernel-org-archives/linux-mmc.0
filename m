From: Alexander Kurz <akurz@blala.de>
Subject: Re: [PATCH] ARM: dts: imx50: imx50-esdhc use imx53-esdhc
Date: Sun, 9 Oct 2016 23:09:28 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1610092241410.19531@blala.de>
References: <1476030890-18274-1-git-send-email-akurz@blala.de> <5eae97cb-7a15-9bcf-f732-6141f99f0990@mleia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vs81.iboxed.net ([185.82.85.146]:44798 "EHLO vs81.iboxed.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbcJIVMd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 9 Oct 2016 17:12:33 -0400
In-Reply-To: <5eae97cb-7a15-9bcf-f732-6141f99f0990@mleia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, linux-mmc@vger.kernel.org



On Sun, 9 Oct 2016, Vladimir Zapolskiy wrote:

> Hi Alexander,
> 
> On 09.10.2016 18:34, Alexander Kurz wrote:
> > According to the reference manuals, both imx50/imx53 SOC seem to share
> > the same eSDHC controller, especially the section on "Multi-block Read"
> > mentioned in commit 361b8482026c ("mmc: sdhci-esdhc-imx: fix multiblock
> > reads on i.MX53") is identical for both SOC.
> > Hence, let imx50 use imx53-esdhc.
> > 
> > Signed-off-by: Alexander Kurz <akurz@blala.de>
> > ---
> >  arch/arm/boot/dts/imx50.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
> > index e245713..769eac7 100644
> > --- a/arch/arm/boot/dts/imx50.dtsi
> > +++ b/arch/arm/boot/dts/imx50.dtsi
> > @@ -99,7 +99,7 @@
> >  				ranges;
> >  
> >  				esdhc1: esdhc@50004000 {
> > -					compatible = "fsl,imx50-esdhc";
> > +					compatible = "fsl,imx50-esdhc", "fsl,imx53-esdhc";
> 
> Instead of this change please add "fsl,imx50-esdhc" compatible to a list found in
> drivers/mmc/host/sdhci-esdhc-imx.c
For me it looks like a typical usecase to be handled via DT.
>From the perspective of the reference manuals it looks like both SOC 
feature exactly the same sdhc hardware.
Extra benefit: projects sharing the linux DT set (e.g. barebox) will
immediately profit from this change.

> 
> Regarding DTS change if the controllers are the same I think it may
> have sense to add "fsl,imx50-esdhc" compatible to imx53.dtsi definitions,
> but not the other way round.
Is there some requirement for ascending numbers?
I guess, i.MX50 just got the smaller number (compared to i.MX51/53) for
marketing reasons (consumer-e-book reader vs "serious" industrial 
applications). Also the mx50 is a younger design compared to the mx51.
The mx50 is an SOC for e-book readers and other battery powered gadgets
(e.g. battery powered wireless hard disk) - it never got the attention 
like the industrial SOC series (mx51/53).

> 
> --
> With best wishes,
> Vladimir
> 

