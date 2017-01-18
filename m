From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v2 1/3] mmc: sh_mobile_sdhi: add support for 2 clocks
Date: Wed, 18 Jan 2017 14:53:35 +0000
Message-ID: <SG2PR06MB116502E2943B5A23E56F65A58A7F0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170117195940.25092-1-chris.brandt@renesas.com>
 <20170117195940.25092-2-chris.brandt@renesas.com>
 <20170117203017.r3g43scvrkwpe6kt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170117203017.r3g43scvrkwpe6kt@ninjato>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Tuesday, January 17, 2017, Wolfram Sang wrote:
> Hi Chris,
>=20
> > +	struct clk *clk2;
>=20
> I'd vote for 'clk_cd' since we are explicitly requesting that clock for i=
t.
>=20
> > +	ret =3D clk_prepare_enable(priv->clk2);
> > +	if (ret < 0)
> > +		return ret;
>=20
> You need to disable clk when failing.
>=20
> Regards,
>=20
>    Wolfram


Thanks for the feedback. I will make those changes.

Chris
