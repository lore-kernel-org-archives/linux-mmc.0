From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: add device tree probe
 support
Date: Wed, 6 Jul 2011 09:50:30 -0600
Message-ID: <20110706155030.GA5805@ponder.secretlab.ca>
References: <1309879568-25837-1-git-send-email-shawn.guo@linaro.org>
 <1309879568-25837-4-git-send-email-shawn.guo@linaro.org>
 <CACxGe6sj4yt7o1yohgdgRxx0aBGrCyYxA3qHmV-npCArjNWWUw@mail.gmail.com>
 <20110706154314.GC4034@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55519 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab1GFPue (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 11:50:34 -0400
Received: by gxk21 with SMTP id 21so29154gxk.19
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 08:50:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110706154314.GC4034@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Wed, Jul 06, 2011 at 11:43:15PM +0800, Shawn Guo wrote:
> On Tue, Jul 05, 2011 at 11:54:34AM -0600, Grant Likely wrote:
> > On Tue, Jul 5, 2011 at 9:26 AM, Shawn Guo <shawn.guo@linaro.org> wr=
ote:
> > > The patch adds device tree probe support for sdhci-esdhc-imx driv=
er.
> > >
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > > Cc: Chris Ball <cjb@laptop.org>
> > > Cc: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > > =A0.../devicetree/bindings/mmc/fsl-imx-esdhc.txt =A0 =A0 =A0| =A0=
 40 ++++++++
> > > =A0drivers/mmc/host/sdhci-esdhc-imx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0102 +++++++++++++++++++-
> > > =A02 files changed, 137 insertions(+), 5 deletions(-)
> > > =A0create mode 100644 Documentation/devicetree/bindings/mmc/fsl-i=
mx-esdhc.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.=
txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > > new file mode 100644
> > > index 0000000..351d239
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> > > @@ -0,0 +1,40 @@
> > > +* Freescale Enhanced Secure Digital Host Controller (eSDHC) for =
i.MX
> > > +
> > > +The Enhanced Secure Digital Host Controller on Freescale i.MX fa=
mily
> > > +provides an interface for MMC, SD, and SDIO types of memory card=
s.
> > > +
> > > +Required properties:
> > > +- compatible : Should be "fsl,<chip>-esdhc"
> > > +- reg : Should contain eSDHC registers location and length
> > > +- interrupts : Should contain eSDHC interrupt
> > > +- cd-type : String, card detection (CD) method. =A0Supported val=
ues are:
> > > + =A0 =A0"none" : No CD
> > > + =A0 =A0"controller" : Uses eSDHC controller internal CD signal
> > > + =A0 =A0"gpio" : Uses GPIO pin for CD
> > > + =A0 =A0"permanent" : No CD because card is permanently wired to=
 host
> > > +- wp-type : String, write protection (WP) method. =A0Supported v=
alues are:
> > > + =A0 =A0"none" : No WP
> > > + =A0 =A0"controller" : Uses eSDHC controller internal WP signal
> > > + =A0 =A0"gpio" : Uses GPIO pin for WP
> > > +- gpios : Should specify GPIOs in this order: CD GPIO, WP GPIO, =
if
> > > + =A0properties cd-type and wp-type are "gpio".
> >=20
> > Again, be explicit in your gpios property names.  Create a differen=
t
> > property for each gpio: cd-gpios and wp-gpios.
> >=20
> > As for wp-type and cd-type, I think you can drop them.  Default to
> > internal controller CD and WP pins.  Use gpio if cd-gpios or wp-gpi=
os
> > is present, and define specific properties for the no-wp, no-cd and
> > fixed-card cases.  (can you tell that I'm not a fan of the "*-type"
> > binding for this driver?)  :-)
> >=20
> I would let default be no CD/WP, and define properties for
> controller internal CD/WP and wired case, if you do not see a
> problem with it.

Okay.

g.

