From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/6 v4] mmc: use .multi_io_quirk on tmio_mmc
Date: Tue, 9 Sep 2014 08:23:55 +0100
Message-ID: <20140909072355.GG30307@lee--X1>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
 <87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
 <87ha0h70n1.wl%kuninori.morimoto.gx@gmail.com>
 <878ult6zry.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:44364 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbaIIHYB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 03:24:01 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar1so1575450iec.7
        for <linux-mmc@vger.kernel.org>; Tue, 09 Sep 2014 00:24:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <878ult6zry.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tue, 09 Sep 2014, Kuninori Morimoto wrote:

> Hi Lee
>=20
> I forgot to add you on this patch.
> Can you please check this patch from "mfd" point ?
>=20
> ------------------------------
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Now, tmio_mmc can use .multi_io_quirk callback
> instead of MMC_CAP2_NO_MULTI_READ flags.
> let's use it.
>=20
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
>=20
>  - remove un-needed header
>=20
>  drivers/mmc/host/tmio_mmc_pio.c |   13 +++++++++++++
>  include/linux/mfd/tmio.h        |    3 +++

=46or the MFD changes:
  Acked-by: Lee Jones <lee.jones@linaro.org>

>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_=
mmc_pio.c
> index ba45413..ff5ff0f 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -970,12 +970,25 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc=
)
>  	return ret;
>  }
> =20
> +static int tmio_multi_io_quirk(struct mmc_card *card,
> +			       unsigned int direction, int blk_size)
> +{
> +	struct tmio_mmc_host *host =3D mmc_priv(card->host);
> +	struct tmio_mmc_data *pdata =3D host->pdata;
> +
> +	if (pdata->multi_io_quirk)
> +		return pdata->multi_io_quirk(card, direction, blk_size);
> +
> +	return blk_size;
> +}
> +
>  static const struct mmc_host_ops tmio_mmc_ops =3D {
>  	.request	=3D tmio_mmc_request,
>  	.set_ios	=3D tmio_mmc_set_ios,
>  	.get_ro         =3D tmio_mmc_get_ro,
>  	.get_cd		=3D mmc_gpio_get_cd,
>  	.enable_sdio_irq =3D tmio_mmc_enable_sdio_irq,
> +	.multi_io_quirk	=3D tmio_multi_io_quirk,
>  };
> =20
>  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 90436d5..5738817 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -5,6 +5,7 @@
>  #include <linux/fb.h>
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
> +#include <linux/mmc/card.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> =20
> @@ -142,6 +143,8 @@ struct tmio_mmc_data {
>  	/* clock management callbacks */
>  	int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>  	void (*clk_disable)(struct platform_device *pdev);
> +	int (*multi_io_quirk)(struct mmc_card *card,
> +			      unsigned int direction, int blk_size);
>  };
> =20
>  /*

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
