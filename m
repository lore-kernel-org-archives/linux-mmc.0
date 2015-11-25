From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: mvsdio: delete platform data header
Date: Wed, 25 Nov 2015 17:34:15 +0100
Message-ID: <CAPDyKFq-e9tmkUXqqLdneXp+5SZJ7Cc8fQb-NfmA2Rt8V88EHA@mail.gmail.com>
References: <1448459851-32565-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:32867 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbbKYQeQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 11:34:16 -0500
Received: by ykdv3 with SMTP id v3so61566837ykd.0
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 08:34:15 -0800 (PST)
In-Reply-To: <1448459851-32565-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On 25 November 2015 at 14:57, Linus Walleij <linus.walleij@linaro.org> wrote:
> This platform data struct is only used inside the MVSDIO driver,
> nowhere else in the entire kernel. Move the struct into the
> driver and delete the external header.
>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mvsdio.c                |  7 ++++++-
>  include/linux/platform_data/mmc-mvsdio.h | 18 ------------------
>  2 files changed, 6 insertions(+), 19 deletions(-)
>  delete mode 100644 include/linux/platform_data/mmc-mvsdio.h
>
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index a448498e3af2..18c70380ea93 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -28,7 +28,6 @@
>
>  #include <asm/sizes.h>
>  #include <asm/unaligned.h>
> -#include <linux/platform_data/mmc-mvsdio.h>
>
>  #include "mvsdio.h"
>
> @@ -37,6 +36,12 @@
>  static int maxfreq;
>  static int nodma;
>
> +struct mvsdio_platform_data {
> +       unsigned int clock;
> +       int gpio_card_detect;
> +       int gpio_write_protect;
> +};
> +
>  struct mvsd_host {
>         void __iomem *base;
>         struct mmc_request *mrq;
> diff --git a/include/linux/platform_data/mmc-mvsdio.h b/include/linux/platform_data/mmc-mvsdio.h
> deleted file mode 100644
> index d02704cd3695..000000000000
> --- a/include/linux/platform_data/mmc-mvsdio.h
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -/*
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __MMC_MVSDIO_H
> -#define __MMC_MVSDIO_H
> -
> -#include <linux/mbus.h>
> -
> -struct mvsdio_platform_data {
> -       unsigned int clock;
> -       int gpio_card_detect;
> -       int gpio_write_protect;
> -};
> -
> -#endif
> --
> 2.4.3
>
