From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2 5/8] mmc: sdhci-esdhc-imx: add delay line setting
 support
Date: Fri, 18 Oct 2013 19:41:19 +0800
Message-ID: <20131018114119.GF22289@shlinux2.ap.freescale.net>
References: <1382093661-4074-1-git-send-email-b29396@freescale.com>
 <1382093661-4074-6-git-send-email-b29396@freescale.com>
 <20131018114233.GD6043@S2101-09.ap.freescale.net>
 <20131018113046.GE22289@shlinux2.ap.freescale.net>
 <20131018115754.GF6043@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0187.outbound.messaging.microsoft.com ([213.199.154.187]:49986
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754302Ab3JRL5j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Oct 2013 07:57:39 -0400
Content-Disposition: inline
In-Reply-To: <20131018115754.GF6043@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, wsa@the-dreams.de

On Fri, Oct 18, 2013 at 07:57:56PM +0800, Shawn Guo wrote:
> On Fri, Oct 18, 2013 at 07:30:47PM +0800, Dong Aisheng wrote:
> > On Fri, Oct 18, 2013 at 07:42:35PM +0800, Shawn Guo wrote:
> > > On Fri, Oct 18, 2013 at 06:54:18PM +0800, Dong Aisheng wrote:
> > > > The DLL(Delay Line) is newly added to assist in sampling read data.
> > > > The DLL provides the ability to programmatically select a quantized
> > > > delay (in fractions of the clock period) regardless of on-chip variations
> > > > such as process, voltage and temperature (PVT).
> > > > 
> > > > This patch adds a user interface to set slave delay line via device tree.
> > > > It's usually used in high speed mode like mmc DDR mode when the signal
> > > > quality is not good caused by board design, e.g. the signal path is too long.
> > > > User can manual set delay line to find a suitable data sampling window
> > > > for card to work properly.
> > > > 
> > > > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > > > ---
> > > >  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    5 +++++
> > > >  drivers/mmc/host/sdhci-esdhc-imx.c                 |   18 ++++++++++++++++++
> > > >  include/linux/platform_data/mmc-esdhc-imx.h        |    1 +
> > > >  3 files changed, 24 insertions(+), 0 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > > > index 1dd6225..78a45c5 100644
> > > > --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > > > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > > > @@ -12,6 +12,11 @@ Required properties:
> > > >  Optional properties:
> > > >  - fsl,cd-controller : Indicate to use controller internal card detection
> > > >  - fsl,wp-controller : Indicate to use controller internal write protection
> > > > +- fsl,delay-line : Specify the number of delay cells for override mode.
> > > > +  This is used to set the clock delay for DLL(Delay Line) on override mode
> > > > +  to select a proper data sampling window in case the clock quality is not good
> > > > +  due to signal path is too long on the board.
> > > > +  please refer to DLL chapter in RM for details.
> > > 
> > > It might be better to reword it like:
> > > 
> > > Please refer to eSDHC/uSDHC DLL_CTRL register bit field
> > > DLL_CTRL_SLV_OVERRIDE_VAL in Reference Manual for details.
> > > 
> > 
> > There is a DLL (Delay Line) chapter in the reference manual which
> > has more detailed descriptions on the delay line including override mode.
> > So i think it may be better to point user to the DLL chapter for understanding,
> > then naturally user will refer to register for bit defines later too.
> > Does it make sense?
> 
> Okay.  But "eSDHC/uSDHC chapter, DLL (Delay Line) section" please.
> 

Okay, i'm fine with it.

Regards
Dong Aisheng
> Shawn

