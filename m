From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] mmc: mxs-mmc: Add wp-inverted property
Date: Mon, 21 May 2012 23:17:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205212314070.5421@axis700.grange>
References: <1337634071-8531-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52691 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759094Ab2EUVSL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 May 2012 17:18:11 -0400
In-Reply-To: <1337634071-8531-1-git-send-email-marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@karo-electronics.de>

On Mon, 21 May 2012, Marek Vasut wrote:

> The write-protect GPIO is inverted on some boards. Handle such case.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Lothar Wa=C3=9Fmann <LW@karo-electronics.de>
> ---
>  drivers/mmc/host/mxs-mmc.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 277161d..9bfd08e 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -164,16 +164,23 @@ struct mxs_mmc_host {
>  	spinlock_t			lock;
>  	int				sdio_irq_en;
>  	int				wp_gpio;
> +	int				wp_inverted:1;

I think, many mmc drivers could use such a flag, so, I proposed this

http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg14018.html

and I'm planning to respin that entire patch-series, taking reviews int=
o=20
account. However, that specific patch doesn't depend on anything, so, i=
t=20
can be taken directly. Then drivers would just use the new CAP2 flag,=20
instead of adding similar flags to their private data. Another advantag=
e=20
of having that flag centrally is, that it will enable its use from the=20
slot function helper module

http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg14031.html

which I'll also respin soon.

Thanks
Guennadi

>  };
> =20
>  static int mxs_mmc_get_ro(struct mmc_host *mmc)
>  {
>  	struct mxs_mmc_host *host =3D mmc_priv(mmc);
> +	int ret;
> =20
>  	if (!gpio_is_valid(host->wp_gpio))
>  		return -EINVAL;
> =20
> -	return gpio_get_value(host->wp_gpio);
> +	ret =3D gpio_get_value(host->wp_gpio);
> +
> +	if (host->wp_inverted)
> +		ret =3D !ret;
> +
> +	return ret;
>  }
> =20
>  static int mxs_mmc_get_cd(struct mmc_host *mmc)
> @@ -707,6 +714,7 @@ static int mxs_mmc_probe(struct platform_device *=
pdev)
>  	struct pinctrl *pinctrl;
>  	int ret =3D 0, irq_err, irq_dma;
>  	dma_cap_mask_t mask;
> +	enum of_gpio_flags flags;
> =20
>  	iores =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	dmares =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> @@ -785,7 +793,10 @@ static int mxs_mmc_probe(struct platform_device =
*pdev)
>  			mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>  		else if (bus_width =3D=3D 8)
>  			mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> -		host->wp_gpio =3D of_get_named_gpio(np, "wp-gpios", 0);
> +		host->wp_gpio =3D of_get_named_gpio_flags(np, "wp-gpios", 0,
> +							&flags);
> +		if (flags & OF_GPIO_ACTIVE_LOW)
> +			host->wp_inverted =3D 1;
>  	} else {
>  		if (pdata->flags & SLOTF_8_BIT_CAPABLE)
>  			mmc->caps |=3D MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> --=20
> 1.7.10
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

---
Guennadi Liakhovetski, Ph.D.
=46reelance Open-Source Software Developer
http://www.open-technology.de/
