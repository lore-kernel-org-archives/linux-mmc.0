From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mmcif: remove some cruft
Date: Wed, 14 Feb 2018 11:38:20 +0100
Message-ID: <CAPDyKFo-MzX1NtqQc_78MWywf4hWrLfyLr2RYm2AZo2uFKKt6w@mail.gmail.com>
References: <20180205132822.14529-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33355 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967230AbeBNKiV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Feb 2018 05:38:21 -0500
Received: by mail-io0-f194.google.com with SMTP id n7so24705106iob.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2018 02:38:21 -0800 (PST)
In-Reply-To: <20180205132822.14529-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 5 February 2018 at 14:28, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The TODO section from 2010 is obsolete. We have DMA and PM meanwhile and
> we always want to handle errors better, if possible. Also DRIVER_VERSION
> is not used anymore these days.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sh_mmcif.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 7bb00c68a7561a..4c2a1f8ddbf324 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -7,13 +7,6 @@
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License.
> - *
> - *
> - * TODO
> - *  1. DMA
> - *  2. Power management
> - *  3. Handle MMC errors better
> - *
>   */
>
>  /*
> @@ -67,7 +60,6 @@
>  #include <linux/module.h>
>
>  #define DRIVER_NAME    "sh_mmcif"
> -#define DRIVER_VERSION "2010-04-28"
>
>  /* CE_CMD_SET */
>  #define CMD_MASK               0x3f000000
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
