From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: Adding esdhc4 eMMC support on mx6sabresd
Date: Thu, 8 May 2014 09:18:35 +0200
Message-ID: <20140508091835.78daafbe@ipc1.ka-ro>
References: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:55096 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbaEHHUW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 03:20:22 -0400
In-Reply-To: <CAOMZO5CJEoe_fGLH-Uu9uVwNdWPp940k3WGAkjzkCiGmjAPAXA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@freescale.com>

Hi,

=46abio Estevam wrote:
> Hi Dong,
>=20
> I have tested the following patch to add support for the emmc port on
> mx6qsabresd:
>=20
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -444,6 +444,21 @@
>                                 MX6QDL_PAD_SD3_DAT7__SD3_DATA7       =
   0x17059
>                         >;
>                 };
> +
> +               pinctrl_usdhc4: usdhc4grp {
> +                       fsl,pins =3D <
> +                               MX6QDL_PAD_SD4_CMD__SD4_CMD          =
   0x17059
> +                               MX6QDL_PAD_SD4_CLK__SD4_CLK          =
   0x10059
> +                               MX6QDL_PAD_SD4_DAT0__SD4_DATA0       =
   0x17059
> +                               MX6QDL_PAD_SD4_DAT1__SD4_DATA1       =
   0x17059
> +                               MX6QDL_PAD_SD4_DAT2__SD4_DATA2       =
   0x17059
> +                               MX6QDL_PAD_SD4_DAT3__SD4_DATA3       =
   0x17059
> +                               MX6QDL_PAD_SD4_DAT4__SD4_DATA4       =
   0x17059
> +                               MX6QDL_PAD_SD4_DAT5__SD4_DATA5       =
   0x17059
> +                               MX6QDL_PAD_SD4_DAT6__SD4_DATA6       =
   0x17059
> +                               MX6QDL_PAD_SD4_DAT7__SD4_DATA7       =
   0x17059
[...]
>=20
> Is there any extra patch I need to apply? I am running linux-next 201=
40506.
>=20
I'm using the pad settings 0x070b1 for our i.MX6 module with eMMC.
At least you should probably drop the HYS setting (0x10000), since
according to my experience the SD interface works much better with
hysteresis disabled.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
