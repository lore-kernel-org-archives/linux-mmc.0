From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v2] tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support
Date: Tue, 16 Feb 2010 18:57:43 +0900
Message-ID: <aec7e5c31002160157t4bad8803te84b12c65e98a092@mail.gmail.com>
References: <4B7A0450.8000303@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:61113 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814Ab0BPJ5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Feb 2010 04:57:44 -0500
Received: by ywh6 with SMTP id 6so4321937ywh.4
        for <linux-mmc@vger.kernel.org>; Tue, 16 Feb 2010 01:57:43 -0800 (PST)
In-Reply-To: <4B7A0450.8000303@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <goda.yusuke@renesas.com>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, linus.ml.walleij@gmail.com, Ian Molton <ian@mnementh.co.uk>

Goda-san,

[CC Ian]

Thanks for your v2 patch. Let's wait and see what Ian thinks. It's a
quite trivial change though so I would be surprised if he had any
objections.

Cheers,

/ magnus

2010/2/16 Yusuke Goda <goda.yusuke@renesas.com>:
> Enable MMC_CAP_XX support in the tmio_mmc driver if
> pdata->capabilities is set.
>
>
> Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>
> ---
> =A0drivers/mmc/host/tmio_mmc.c | =A0 =A01 +
> =A0include/linux/mfd/tmio.h =A0 =A0| =A0 =A01 +
> =A02 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> index e22c3fa..e2c0cc9 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -550,6 +550,7 @@ static int __devinit tmio_mmc_probe(struct platfo=
rm_device *dev)
>
> =A0 =A0 =A0 =A0mmc->ops =3D &tmio_mmc_ops;
> =A0 =A0 =A0 =A0mmc->caps =3D MMC_CAP_4_BIT_DATA;
> + =A0 =A0 =A0 mmc->caps |=3D pdata->capabilities;
> =A0 =A0 =A0 =A0mmc->f_max =3D pdata->hclk;
> =A0 =A0 =A0 =A0mmc->f_min =3D mmc->f_max / 512;
> =A0 =A0 =A0 =A0mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 9cb1834..37d9414 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -60,6 +60,7 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, int s=
hift, int state);
> =A0*/
> =A0struct tmio_mmc_data {
> =A0 =A0 =A0 =A0const unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0hclk;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 capab=
ilities;
> =A0 =A0 =A0 =A0void (*set_pwr)(struct platform_device *host, int stat=
e);
> =A0 =A0 =A0 =A0void (*set_clk_div)(struct platform_device *host, int =
state);
> =A0};
> --
> 1.6.4.3
>
>
>
>
