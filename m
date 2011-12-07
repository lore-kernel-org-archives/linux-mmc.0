From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [MXS MMC 1/5] Fix grammatical error in comment
Date: Wed, 7 Dec 2011 19:00:48 +0800
Message-ID: <20111207110047.GI5550@S2100-06.ap.freescale.net>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323177907.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:3804 "EHLO
	VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab1LGKsG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Dec 2011 05:48:06 -0500
Content-Disposition: inline
In-Reply-To: <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323177907.git.LW@KARO-electronics.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Tue, Dec 06, 2011 at 02:41:26PM +0100, Lothar Wa=DFmann wrote:
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  arch/arm/mach-mxs/clock-mx28.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock=
-mx28.c
> index da6e4aa..fc86b04 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -554,7 +554,7 @@ static struct clk rtc_clk =3D {
>  	.parent =3D &ref_xtal_clk,
>  };
> =20
> -/* usb_clk gate is controlled in DIGCTRL other than CLKCTRL */
> +/* usb_clk gate is controlled in DIGCTRL rather than CLKCTRL */
>  static struct clk usb0_clk =3D {
>  	.enable_reg =3D DIGCTRL_BASE_ADDR,
>  	.enable_shift =3D 2,
> --=20

Acked-by: Shawn Guo <shawn.guo@linaro.org>

--=20
Regards,
Shawn

