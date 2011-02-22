From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: Re: [PATCH 5/5] arm: mach-mx3: use IMX_GPIO_NR instead of hard-coded
	values
Date: Tue, 22 Feb 2011 14:30:02 +0100
Message-ID: <19811.47706.277301.848103@ipc1.ka-ro>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	<1298379500-27590-6-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:55067 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab1BVNaN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2011 08:30:13 -0500
In-Reply-To: <1298379500-27590-6-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>, linux-arm-kernel@lists.infradead.org

Hi,

> The latter are error-prone because the bank number is one less than o=
ne
> would read in the documentation.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Eric B=C3=A9nard <eric@eukrea.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c |    4 ++--
>  arch/arm/mach-mx3/mach-cpuimx35.c            |    2 +-
>  arch/arm/mach-mx3/mach-pcm043.c              |   10 +++++-----
>  3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/=
mach-mx3/eukrea_mbimxsd-baseboard.c
> index 14a5ffc..8076147 100644
> --- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> +++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
> @@ -165,8 +165,8 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] =3D {
>  	MX35_PAD_SD1_DATA3__ESDHC1_DAT3,
>  };
> =20
> -#define GPIO_LED1	(2 * 32 + 29)
> -#define GPIO_SWITCH1	(2 * 32 + 25)
> +#define GPIO_LED1	IMX_GPIO_NR(3, 29)
> +#define GPIO_SWITCH1	IMX_GPIO_NR(3, 25)
>  #define GPIO_LCDPWR	(4)
> =20
While you are at it you could also remove the nonsensical () around
the bare number.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
