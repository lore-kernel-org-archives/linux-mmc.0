From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/6] sh: ecovec: use the CONFIG_MMC_TMIO symbols instead
 of MFD
Date: Sun, 13 Mar 2011 01:18:22 +0900
Message-ID: <AANLkTikjTNVQT7gzhGQy-wKmfTT=BWikAJ+Wo5+-kZvX@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
	<Pine.LNX.4.64.1103110845220.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103110845220.23675@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 11, 2011 at 4:52 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> The CONFIG_MFD_SH_MOBILE_SDHI Kconfig symbol is going to disappear so=
on,
> switch ecovec to using CONFIG_MMC_TMIO(_MODULE).
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0arch/sh/boards/mach-ecovec24/setup.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/ma=
ch-ecovec24/setup.c
> index 52751f0..37ad5dc 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -462,7 +462,7 @@ static struct i2c_board_info ts_i2c_clients =3D {
> =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D IRQ0,
> =A0};
>
> -#ifdef CONFIG_MFD_SH_MOBILE_SDHI
> +#if defined(CONFIG_MMC_TMIO) || defined(CONFIG_MMC_TMIO_MODULE)
> =A0/* SDHI0 */

What's wrong with CONFIG_MMC_SDHI? Too early in the patch series?

I can't really see what the ecovec board has in common with the tmio
mmc implementation. Or did you mean the CONFIG_MMC_TMIO_CORE?

Perhaps this is just a stop-gap solution and it is being fixed in V2 pa=
tch 7/7 ?

Thanks,

/ magnus
