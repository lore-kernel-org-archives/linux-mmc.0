From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v5 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Mon, 23 Jan 2017 17:56:41 +0000
Message-ID: <SG2PR06MB1165F465C5802912ED62820C8A720@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170121030604.7672-1-chris.brandt@renesas.com>
 <20170121030604.7672-3-chris.brandt@renesas.com>
 <20170123165523.fnavkx263ifvss4p@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170123165523.fnavkx263ifvss4p@rob-hp-laptop>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hello Rob,


On Monday, January 23, 2017, Rob Herring wrote:
> > --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> > @@ -25,8 +25,32 @@ Required properties:
> >  		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
> >  		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
> >
> > +- clocks: Most controllers only have 1 clock source per channel.
> However, on
> > +	  some variations of this controller, the internal card detection
>=20
> This should be explicit as to which compatible strings have 2 clocks and
> which have 1 clock.

OK. I'll make a list like I did for sh_mmcif:

https://patchwork.kernel.org/patch/9512091/



> > +
> > +Example showing 2 clocks:
> > +	sdhi0: sd@e804e000 {
>=20
> mmc@...

I'm confused. I see that for all SDHI controllers, it either "sd@" or "sdhc=
i@".

$ grep sdhi $(find arch/arm/boot/dts -name "*.dtsi")

$ grep sdhci $(find arch/arm/boot/dts -name "*.dtsi")


Regards,
Chris
