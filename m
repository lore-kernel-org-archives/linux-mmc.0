From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Mon, 28 Oct 2013 15:50:36 -0700
Message-ID: <9bba3f23-e6b8-4a9a-93ab-4f89f525a4a2@CO1EHSMHS030.ehs.local>
References: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
 <1587218.cW45zK0ty2@flatron>
 <b6ced7bb-e8df-4cc1-95a1-df575e37dea7@CO1EHSMHS001.ehs.local>
 <1873048.2t2L2zW4W9@flatron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1873048.2t2L2zW4W9@flatron>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 28, 2013 at 11:19:13PM +0100, Tomasz Figa wrote:
> On Monday 28 of October 2013 14:47:38 S=C3=B6ren Brinkmann wrote:
> > On Mon, Oct 28, 2013 at 10:16:49PM +0100, Tomasz Figa wrote:
> > > Hi Soren,
> > >=20
> > > On Tuesday 15 of October 2013 12:08:04 Soren Brinkmann wrote:
> > > > Add a driver for Arasan's SDHCI controller core.
> > > >=20
> > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > ---
> > > >=20
> > > >  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  23 +++
> > > >  MAINTAINERS                                        |   1 +
> > > >  drivers/mmc/host/Kconfig                           |  12 ++
> > > >  drivers/mmc/host/Makefile                          |   1 +
> > > >  drivers/mmc/host/sdhci-of-arasan.c                 | 224
> > > >=20
> > > > +++++++++++++++++++++ 5 files changed, 261 insertions(+)
> > > >=20
> > > >  create mode 100644
> > > >=20
> > > > Documentation/devicetree/bindings/mmc/arasan,sdhci.txt create m=
ode
> > > > 100644 drivers/mmc/host/sdhci-of-arasan.c
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci=
=2Etxt
> > > > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt new fi=
le
> > > > mode
> > > > 100644
> > > > index 000000000000..20f0fc25e270
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > > @@ -0,0 +1,23 @@
> > > > +Device Tree Bindings for the Arasan SDCHI Controller
> > > > +
> > > > +  The bindings follow the mmc[1] and the clock bindings[2]. On=
ly
> > > > deviations are +  documented here.
> > > > +
> > > > +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> > > > +  [2] Documentation/devicetree/bindings/clock/clock-bindings.t=
xt
> > > > +
> > >=20
> > > > +Required Properties:
> > > According to the example below, the list of required properties l=
acks
> > > interrupt-related properties.
> >=20
> > Well, the interrupt bindings seem to differ between platforms and
> > architecture and looking at documentation for other sdhci bindings =
it
> > seemed to be okay to avoid documenting them in this place.
>=20
> Sure, but I believe that this controller always has an interrupt sign=
al,=20
> so at least it should be marked that interrupts need to be specified.
Okay, I'll add these lines:
  - interrupts: Interrupt specifier                                    =
         =20
  - interrupt-parent: Phandle for the interrupt controller that service=
s                                =20
                      interrupts for this device.

	S=C3=B6ren
