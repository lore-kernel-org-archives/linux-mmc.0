From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 6/10] mmc: meson-gx: fix error path in meson_mmc_clk_init / meson_mmc_probe
Date: Mon, 27 Feb 2017 19:06:59 -0800
Message-ID: <m2tw7f10a4.fsf@baylibre.com>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
        <8419d592-1338-d7eb-3a75-342b64897922@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34410 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdB1DH3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 22:07:29 -0500
Received: by mail-pg0-f47.google.com with SMTP id p5so28290810pga.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2017 19:07:02 -0800 (PST)
In-Reply-To: <8419d592-1338-d7eb-3a75-342b64897922@gmail.com> (Heiner
        Kallweit's message of "Sat, 18 Feb 2017 14:19:32 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org, =?utf-8?Q?Micha=C5=82?= Zegan <webczat_200@poczta.onet.pl>

Heiner Kallweit <hkallweit1@gmail.com> writes:

> The condition should be "if (ret)" as the disable/unprepare is
> supposed to be executed if the previous command fails.
> In addition adjust the error path in probe to properly deal
> with the case that cfg_div_clk can be registered successfully
> but enable/prepare fails.
> In this case we shouldn't call clk_disable_unprepare.
>
> Reported-by: Micha=C5=82 Zegan <webczat_200@poczta.onet.pl>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
> v2:
> - extended commit message
> v3:
> - adjust error path in probe
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index 68e76fa8..002e4aac 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -321,7 +321,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>  	host->mmc->f_min =3D clk_round_rate(host->cfg_div_clk, 400000);
>=20=20
>  	ret =3D meson_mmc_clk_set(host, host->mmc->f_min);
> -	if (!ret)
> +	if (ret)
>  		clk_disable_unprepare(host->cfg_div_clk);
>=20=20
>  	return ret;
> @@ -771,7 +771,7 @@ static int meson_mmc_probe(struct platform_device *pd=
ev)
>  					meson_mmc_irq_thread, IRQF_SHARED,
>  					DRIVER_NAME, host);
>  	if (ret)
> -		goto free_host;
> +		goto err_div_clk;
>=20=20
>  	mmc->max_blk_count =3D CMD_CFG_LENGTH_MASK;
>  	mmc->max_req_size =3D mmc->max_blk_count * mmc->max_blk_size;
> @@ -784,7 +784,7 @@ static int meson_mmc_probe(struct platform_device *pd=
ev)
>  	if (host->bounce_buf =3D=3D NULL) {
>  		dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>  		ret =3D -ENOMEM;
> -		goto free_host;
> +		goto err_div_clk;
>  	}
>=20=20
>  	mmc->ops =3D &meson_mmc_ops;
> @@ -792,8 +792,9 @@ static int meson_mmc_probe(struct platform_device *pd=
ev)
>=20=20
>  	return 0;
>=20=20
> -free_host:
> +err_div_clk:
>  	clk_disable_unprepare(host->cfg_div_clk);
> +free_host:
>  	clk_disable_unprepare(host->core_clk);
>  	mmc_free_host(mmc);
>  	return ret;
