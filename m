From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: fix mojibake in module metadata
Date: Wed, 29 Nov 2017 11:03:57 +0100
Message-ID: <CAPDyKFqWJeZ4e7BYj3gWCiKen2jaU-+DQzpNjCgsN3Atbxs+YA@mail.gmail.com>
References: <20171128034455.10344-1-kilobyte@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36015 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbdK2KD6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 05:03:58 -0500
Received: by mail-it0-f68.google.com with SMTP id d16so3459128itj.1
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2017 02:03:58 -0800 (PST)
In-Reply-To: <20171128034455.10344-1-kilobyte@angband.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 28 November 2017 at 04:44, Adam Borowski <kilobyte@angband.pl> wrote:
> It had an U+FFFD: not a corrupted character but a literal well-formed
> replacement marker.
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index cc98355dbdb9..8fef5c17696e 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -3,7 +3,7 @@
>   * (C) Copyright 2007-2011 Reuuimlla Technology Co., Ltd.
>   * (C) Copyright 2007-2011 Aaron Maoye <leafy.myeh@reuuimllatech.com>
>   * (C) Copyright 2013-2014 O2S GmbH <www.o2s.ch>
> - * (C) Copyright 2013-2014 David Lanzend=EF=BF=BDrfer <david.lanzendoerf=
er@o2s.ch>
> + * (C) Copyright 2013-2014 David Lanzend=C3=B6rfer <david.lanzendoerfer@=
o2s.ch>
>   * (C) Copyright 2013-2014 Hans de Goede <hdegoede@redhat.com>
>   * (C) Copyright 2017 Sootech SA
>   *
> @@ -1393,5 +1393,5 @@ module_platform_driver(sunxi_mmc_driver);
>
>  MODULE_DESCRIPTION("Allwinner's SD/MMC Card Controller Driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_AUTHOR("David Lanzend=EF=BF=BDrfer <david.lanzendoerfer@o2s.ch>")=
;
> +MODULE_AUTHOR("David Lanzend=C3=B6rfer <david.lanzendoerfer@o2s.ch>");
>  MODULE_ALIAS("platform:sunxi-mmc");
> --
> 2.15.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
