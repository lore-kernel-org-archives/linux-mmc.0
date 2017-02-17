From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/2] mmc: meson-gx: remove mmc host on device removal
Date: Fri, 17 Feb 2017 11:47:05 -0800
Message-ID: <m2fujc61mu.fsf@baylibre.com>
References: <20170216145222.1577-1-webczat@webczatnet.pl>
        <20170216145222.1577-3-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33175 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755276AbdBQTrI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2017 14:47:08 -0500
Received: by mail-pf0-f181.google.com with SMTP id c73so15650010pfb.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2017 11:47:08 -0800 (PST)
In-Reply-To: <20170216145222.1577-3-webczat@webczatnet.pl> (=?utf-8?Q?=22M?=
 =?utf-8?Q?icha=C5=82?= Zegan"'s
        message of "Thu, 16 Feb 2017 15:52:22 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Zegan <webczat@webczatnet.pl>
Cc: Carlo Caione <carlo@caione.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Micha=C5=82 Zegan <webczat@webczatnet.pl> writes:

> The mmc host was added in meson_mmc_probe, but never removed in meson_mmc=
_remove.
> Fix that by removing the host before deallocating other resources.
>
> Signed-off-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

> ---
>  drivers/mmc/host/meson-gx-mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index d444b6bfa02b..bb83446118a3 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -818,6 +818,8 @@ static int meson_mmc_remove(struct platform_device *p=
dev)
>  	if (WARN_ON(!host))
>  		return 0;
>=20=20
> +	mmc_remove_host(host->mmc);
> +
>  	if (host->bounce_buf)
>  		dma_free_coherent(host->dev, host->bounce_buf_size,
>  				  host->bounce_buf, host->bounce_dma_addr);
