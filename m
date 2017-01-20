From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v4 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 20 Jan 2017 22:35:14 +0000
Message-ID: <SG2PR06MB1165035F107F504185B525658A710@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170120194332.1683-1-chris.brandt@renesas.com>
 <20170120194332.1683-3-chris.brandt@renesas.com>
 <20170120213901.GC1438@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170120213901.GC1438@katana>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Wolfram,

Ulf's request was for more info, but it wasn't clear if he wanted more
info in the commit logs or in the files themselves.


On Friday, January 20, 2017, Wolfram Sang wrote:
> > +- clocks: Most controllers only have 1 clock source per channel.
> However, on
> > +	  some variations of this controller, the internal card detection
> > +	  logic that exists in this controller is sectioned off to be run by
> a
> > +	  separate second clock source to allow the main core clock to be
> turned
> > +	  off to save power. Unfortunately, the existing driver architecture
> > +	  does not support such a separation of clocks.
> > +	  Additionally, it is prohibited to supply a clock to the core but
> not
> > +	  to the card detect circuit. That leaves you with if separate
> clocks
> > +	  are presented, you must treat them both as 1.
> > +	  If 2 clocks are specified by the hardware, you must name them as
> > +	  "core" and "cd".
> > +	  If the controller only has 1 clock, naming is not required.
>=20
> I know we are not perfect in this area, but DT binding should be OS
> agnostic and should refrain from specifying Linux internals.
>=20
> So, I'd think the comments about driver architecture should be put into
> the driver, not into the bindings.


It sounds like your suggestion is to just put the HW description in
the DT bindings, but move the dirty details into the driver.

Keep in DT:

+- clocks: Most controllers only have 1 clock source per channel. However, =
on
+	  some variations of this controller, the internal card detection
+	  logic that exists in this controller is sectioned off to be run by a
+	  separate second clock source to allow the main core clock to be turned
+	  off to save power.
+	  If 2 clocks are specified by the hardware, you must name them as
+	  "core" and "cd".
+	  If the controller only has 1 clock, naming is not required.



Move somewhere in the driver (maybe where the 2nd clock is detected):

+	  Unfortunately, the existing driver architecture
+	  does not support such a separation of clocks.
+	  Additionally, it is prohibited to supply a clock to the core but not
+	  to the card detect circuit. That leaves you with if separate clocks
+	  are presented, you must treat them both as 1.


Is this what you were thinking?


Thank you,
Chris
