From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [MXS MMC 2/5] Some cleanups for the MMC driver
Date: Wed, 7 Dec 2011 20:01:22 +0800
Message-ID: <20111207120120.GK5550@S2100-06.ap.freescale.net>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <d935557e044d2ebc56b4e70487b519fe722e9017.1323177907.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:41098
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755357Ab1LGLsl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Dec 2011 06:48:41 -0500
Content-Disposition: inline
In-Reply-To: <d935557e044d2ebc56b4e70487b519fe722e9017.1323177907.git.LW@KARO-electronics.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>

I'm fine with this cosmetic patch with the comments below addressed.

On Tue, Dec 06, 2011 at 02:41:27PM +0100, Lothar Wa=DFmann wrote:
>  - Remove bogus parens around numerical arguments in #define's
>  - When defining bit masks, use the #def for the shift count
>    instead of repeating the numbers

This change brings a few 'line over 80 characters' checkpatch warnings.

>  - Remove bogus whitespace in indentation
>  - Remove 'break' at end of switch statement
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  drivers/mmc/host/mxs-mmc.c |   57 +++++++++++++++++++++-------------=
---------
>  1 files changed, 28 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
[...]
> @@ -277,7 +277,7 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, v=
oid *dev_id)
> =20
>  	stat =3D readl(host->base + HW_SSP_CTRL1);
>  	writel(stat & MXS_MMC_IRQ_BITS,
> -	       host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);

This is an intended indentation with 7 spaces.

Regards,
Shawn

> +		host->base + HW_SSP_CTRL1 + MXS_CLR_ADDR);

