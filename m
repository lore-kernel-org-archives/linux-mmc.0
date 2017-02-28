From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2] mmc: meson-gx: remove mmc host on device removal
Date: Mon, 27 Feb 2017 19:09:08 -0800
Message-ID: <m2h93f106j.fsf@baylibre.com>
References: <20170218170647.5860-1-webczat@webczatnet.pl>
        <20170218170647.5860-2-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35291 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdB1DTK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2017 22:19:10 -0500
Received: by mail-pg0-f48.google.com with SMTP id b129so52043711pgc.2
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2017 19:17:53 -0800 (PST)
In-Reply-To: <20170218170647.5860-2-webczat@webczatnet.pl> (=?utf-8?Q?=22M?=
 =?utf-8?Q?icha=C5=82?= Zegan"'s
        message of "Sat, 18 Feb 2017 18:06:47 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Zegan <webczat@webczatnet.pl>
Cc: Carlo Caione <carlo@caione.org>, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Micha=C5=82 Zegan <webczat@webczatnet.pl> writes:

> The mmc host was added in meson_mmc_probe, but never removed in
> meson_mmc_remove.
> Fix that by removing the host before deallocating other resources.
>
> Signed-off-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>
> Tested-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>

Acked-by: Kevin Hilman <khilman@baylibre.com>

> ---
> changes since v1:
> rebased on top of patchset at
> https://patchwork.kernel.org/patch/9581057/
> This is in turn based on patchset at
> https://patchwork.kernel.org/patch/9561215/
>
>  drivers/mmc/host/meson-gx-mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-=
mmc.c
> index e759e4c2e4a0..336b6a2e94c6 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -791,6 +791,8 @@ static int meson_mmc_remove(struct platform_device *p=
dev)
>  {
>  	struct meson_host *host =3D dev_get_drvdata(&pdev->dev);
>=20=20
> +	mmc_remove_host(host->mmc);
> +
>  	/* disable interrupts */
>  	writel(0, host->regs + SD_EMMC_IRQ_EN);
