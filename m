From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Tue, 1 Nov 2016 13:40:07 +0000
Message-ID: <SG2PR06MB11652157C1DA12165852747C8AA10@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com>
 <20161101084938.GA1576@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161101084938.GA1576@katana>
Content-Language: en-US
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,


> Okay, I have a sketch how to add this feature to R-Car SoCs at a later
> stage. This patch is fine with one minor nit which can be done now or I
> can do it later when I add the R-Car support.
>=20
> > + * Some controllers have a 32-bit wide data port register  */
> > +#define TMIO_MMC_32BIT_DATA_PORT	(1 << 9)
>=20
> Since R-Car Gen3 has 64 bit port, I'd suggest to use
> TMIO_MMC_BIG_DATA_PORT or something. But as I said, I can also do this
> later. So

I don't understand "TMIO_MMC_BIG_DATA_PORT" (How do you know 32-bit?? How d=
o you know 64-bit??)


So......maybe you can change it later and your idea will be more clear to m=
e then.


Thank you,
Chris
