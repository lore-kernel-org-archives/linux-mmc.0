From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH 1/2] mmc: arasan: Add driver for Arasan SDHCI
Date: Mon, 28 Oct 2013 17:15:52 -0700
Message-ID: <ff1f2d38-4185-49f0-8b63-b3bd2b4f9a27@CO9EHSMHS024.ehs.local>
References: <1381864085-8806-1-git-send-email-soren.brinkmann@xilinx.com>
 <526EF149.8060304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:43586
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754007Ab3J2AQG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Oct 2013 20:16:06 -0400
Content-Disposition: inline
In-Reply-To: <526EF149.8060304@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Michal Simek <michal.simek@xilinx.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org

On Mon, Oct 28, 2013 at 06:20:41PM -0500, Rob Herring wrote:
> On 10/15/2013 02:08 PM, Soren Brinkmann wrote:
> > Add a driver for Arasan's SDHCI controller core.
> >=20
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  23 +++
> >  MAINTAINERS                                        |   1 +
> >  drivers/mmc/host/Kconfig                           |  12 ++
> >  drivers/mmc/host/Makefile                          |   1 +
> >  drivers/mmc/host/sdhci-of-arasan.c                 | 224 +++++++++=
++++++++++++
> >  5 files changed, 261 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/arasan,sd=
hci.txt
> >  create mode 100644 drivers/mmc/host/sdhci-of-arasan.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt=
 b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > new file mode 100644
> > index 000000000000..20f0fc25e270
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -0,0 +1,23 @@
> > +Device Tree Bindings for the Arasan SDCHI Controller
> > +
> > +  The bindings follow the mmc[1] and the clock bindings[2]. Only d=
eviations are
> > +  documented here.
> > +
> > +  [1] Documentation/devicetree/bindings/mmc/mmc.txt
> > +  [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +
> > +Required Properties:
> > +  - compatible: Compatibility string. Must be 'arasan,sdhci'
>=20
> This string is a bit non-specific. Vendor IP typically has configurab=
le
> options, different revs of IP with fixes/differences, and the
> possibility of integration wierdness or bugs. So it is better to be a=
s
> specific as possible in case the kernel needs to know exactly what
> version of h/w this is.
Okay. The Zynq TRM specifies the version as '8.9A_apr02nd_2010', which =
seems
a little overly specific to me. How does 'arasan,sdhci-8.9a' sound to
you?

	Thanks,
	S=C3=B6ren


