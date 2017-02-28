From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] mmc: meson-gx: fix error path when driver initialization fails before enabling clocks
Date: Mon, 27 Feb 2017 19:08:29 -0800
Message-ID: <m2lgsr107m.fsf@baylibre.com>
References: <20170218170647.5860-1-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32959 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdB1Dic (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 22:38:32 -0500
Received: by mail-pf0-f170.google.com with SMTP id o64so125695pfb.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2017 19:37:39 -0800 (PST)
In-Reply-To: <20170218170647.5860-1-webczat@webczatnet.pl> (=?utf-8?Q?=22M?=
 =?utf-8?Q?icha=C5=82?= Zegan"'s
        message of "Sat, 18 Feb 2017 18:06:46 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Zegan <webczat@webczatnet.pl>
Cc: Carlo Caione <carlo@caione.org>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Micha=C5=82 Zegan <webczat@webczatnet.pl> writes:

> This patch fixes the case where meson_mmc_probe function fails before
> core_clk is enabled.
> Originally, that would result in a try to disable the core clock, and if
> it was not already enabled, it would result in a kernel warning.
> This issue is similar to the one with div_clk.
> Fix it by introducing another error path used only between successfully
> enabling the core clock, and successfully enabling the div clock.
> That would ensure that core clock is disabled only if it was enabled befo=
re.
>
> Signed-off-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
> applies on top of Heiner's patchset v3
> https://patchwork.kernel.org/patch/9581057/
> That in turn applies on top of https://patchwork.kernel.org/patch/9561215/
>
>  drivers/mmc/host/meson-gx-mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index 336b6a2e94c6..7917a3fe51ad 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -752,7 +752,7 @@ static int meson_mmc_probe(struct platform_device *pd=
ev)
>=20=20
>  	ret =3D meson_mmc_clk_init(host);
>  	if (ret)
> -		goto free_host;
> +		goto err_core_clk;
>=20=20
>  	ret =3D devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
>  					meson_mmc_irq_thread, IRQF_SHARED,
> @@ -781,8 +781,9 @@ static int meson_mmc_probe(struct platform_device *pd=
ev)
>=20=20
>  err_div_clk:
>  	clk_disable_unprepare(host->cfg_div_clk);
> -free_host:
> +err_core_clk:
>  	clk_disable_unprepare(host->core_clk);
> +free_host:
>  	mmc_free_host(mmc);
>  	return ret;
>  }
