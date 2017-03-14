From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: meson-gx: remove mmc host on device removal
Date: Tue, 14 Mar 2017 17:21:32 +0100
Message-ID: <CAPDyKFoi3ZeaM4CkR+B-zK59bD1i0U_QzzcnmsJE14mdee9ipA@mail.gmail.com>
References: <20170218170647.5860-1-webczat@webczatnet.pl> <20170218170647.5860-2-webczat@webczatnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33882 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753138AbdCNQVj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:21:39 -0400
Received: by mail-ua0-f178.google.com with SMTP id f54so168127987uaa.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:21:38 -0700 (PDT)
In-Reply-To: <20170218170647.5860-2-webczat@webczatnet.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Micha=C5=82_Zegan?= <webczat@webczatnet.pl>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-amlogic@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 18 February 2017 at 18:06, Micha=C5=82 Zegan <webczat@webczatnet.pl> wro=
te:
> The mmc host was added in meson_mmc_probe, but never removed in
> meson_mmc_remove.
> Fix that by removing the host before deallocating other resources.
>
> Signed-off-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>
> Tested-by: Micha=C5=82 Zegan <webczat@webczatnet.pl>

Thanks, applied for next!

Kind regards
Uffe

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
>         struct meson_host *host =3D dev_get_drvdata(&pdev->dev);
>
> +       mmc_remove_host(host->mmc);
> +
>         /* disable interrupts */
>         writel(0, host->regs + SD_EMMC_IRQ_EN);
>
> --
> 2.11.0
>
