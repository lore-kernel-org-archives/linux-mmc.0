From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Mon, 28 Oct 2013 14:47:38 -0700
Message-ID: <b6ced7bb-e8df-4cc1-95a1-df575e37dea7@CO1EHSMHS001.ehs.local>
References: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
 <1587218.cW45zK0ty2@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:54487
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751651Ab3J1Vro convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Oct 2013 17:47:44 -0400
Content-Disposition: inline
In-Reply-To: <1587218.cW45zK0ty2@flatron>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Oct 28, 2013 at 10:16:49PM +0100, Tomasz Figa wrote:
> Hi Soren,
>=20
> On Tuesday 15 of October 2013 12:08:04 Soren Brinkmann wrote:
> > Add a driver for Arasan's SDHCI controller core.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  23 +++
> >  MAINTAINERS                                        |   1 +
> >  drivers/mmc/host/Kconfig                           |  12 ++
> >  drivers/mmc/host/Makefile                          |   1 +
> >  drivers/mmc/host/sdhci-of-arasan.c                 | 224
> > +++++++++++++++++++++ 5 files changed, 261 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/mmc/arasan,sdhci.txt create mode
> > 100644 drivers/mmc/host/sdhci-of-arasan.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt new file m=
ode
> > 100644
> > index 000000000000..20f0fc25e270
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -0,0 +1,23 @@
> > +Device Tree Bindings for the Arasan SDCHI Controller
> > +
> > +  The bindings follow the mmc[1] and the clock bindings[2]. Only
> > deviations are +  documented here.
> > +
> > +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> > +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required Properties:
>=20
> According to the example below, the list of required properties lacks=
=20
> interrupt-related properties.
Well, the interrupt bindings seem to differ between platforms and
architecture and looking at documentation for other sdhci bindings it
seemed to be okay to avoid documenting them in this place.

	S=C3=B6ren


