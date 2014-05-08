From: Dong Aisheng <b29396@freescale.com>
Subject: Re: Adding esdhc4 eMMC support on mx6sabresd
Date: Thu, 8 May 2014 18:17:32 +0800
Message-ID: <20140508101730.GA28787@shlinux1.ap.freescale.net>
References: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
 <20140508091835.78daafbe@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140508091835.78daafbe@ipc1.ka-ro>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 08, 2014 at 09:18:35AM +0200, Lothar Wa=DFmann wrote:
> Hi,
> =

> Fabio Estevam wrote:
> > Hi Dong,
> > =

> > I have tested the following patch to add support for the emmc port on
> > mx6qsabresd:
> > =

> > --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> > @@ -444,6 +444,21 @@
> >                                 MX6QDL_PAD_SD3_DAT7__SD3_DATA7         =
 0x17059
> >                         >;
> >                 };
> > +
> > +               pinctrl_usdhc4: usdhc4grp {
> > +                       fsl,pins =3D <
> > +                               MX6QDL_PAD_SD4_CMD__SD4_CMD            =
 0x17059
> > +                               MX6QDL_PAD_SD4_CLK__SD4_CLK            =
 0x10059
> > +                               MX6QDL_PAD_SD4_DAT0__SD4_DATA0         =
 0x17059
> > +                               MX6QDL_PAD_SD4_DAT1__SD4_DATA1         =
 0x17059
> > +                               MX6QDL_PAD_SD4_DAT2__SD4_DATA2         =
 0x17059
> > +                               MX6QDL_PAD_SD4_DAT3__SD4_DATA3         =
 0x17059
> > +                               MX6QDL_PAD_SD4_DAT4__SD4_DATA4         =
 0x17059
> > +                               MX6QDL_PAD_SD4_DAT5__SD4_DATA5         =
 0x17059
> > +                               MX6QDL_PAD_SD4_DAT6__SD4_DATA6         =
 0x17059
> > +                               MX6QDL_PAD_SD4_DAT7__SD4_DATA7         =
 0x17059
> [...]
> > =

> > Is there any extra patch I need to apply? I am running linux-next 20140=
506.
> > =

> I'm using the pad settings 0x070b1 for our i.MX6 module with eMMC.
> At least you should probably drop the HYS setting (0x10000), since
> according to my experience the SD interface works much better with
> hysteresis disabled.
> =


I'm not very sure about HYS bit, but it should not be pad setting issue.
This pad setting was tested ok with FSL internal tree.

I just tested an old Chris/mmc-next tree which is 3.14 rc2 with the top com=
mit is b42b9b.
The eMMC works well on SabreSD boards.
But it failed and got the same issue with latest chris/mmc-next tree.
I noticed there's no changes on sdhci-esdhc-imx.c
Probably some other changes breaks this function.

Fabio,
You may bisect it yourself or i will do it later when i'm a bit free.

Shawn,
I remember this patch should have been upstream through your tree long time=
 ago.
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/206446.h=
tml
It seems somehow missed.

Regards
Dong Aisheng

> =

> Lothar Wa=DFmann
> -- =

> ___________________________________________________________
> =

> Ka-Ro electronics GmbH | Pascalstra=DFe 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch=E4ftsf=FChrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> =

> www.karo-electronics.de | info@karo-electronics.de
> ___________________________________________________________
