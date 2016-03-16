From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: of_mmc_spi: fix unused warning
Date: Wed, 16 Mar 2016 12:38:05 +0100
Message-ID: <CAPDyKFowVCGCB+NzmO4tb4xE6UG-Vwv+gh0xjvFUac_9FBvYZg@mail.gmail.com>
References: <1457393799-121767-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38426 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965880AbcCPLiH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 07:38:07 -0400
Received: by mail-wm0-f54.google.com with SMTP id l68so68048005wml.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 04:38:06 -0700 (PDT)
In-Reply-To: <1457393799-121767-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 8 March 2016 at 00:36, Brian Norris <computersforpeace@gmail.com> wrote:
> drivers/mmc/host/of_mmc_spi.c: In function 'mmc_spi_get_pdata':
> drivers/mmc/host/of_mmc_spi.c:77:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>   int ret = -EINVAL;
>       ^
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
> Compile tested only
>
>  drivers/mmc/host/of_mmc_spi.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 660170cd04d9..85bbebfde02e 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -74,7 +74,6 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>         const u32 *voltage_ranges;
>         int num_ranges;
>         int i;
> -       int ret = -EINVAL;
>
>         if (dev->platform_data || !np)
>                 return dev->platform_data;
> @@ -97,7 +96,6 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>                 mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
>                                                be32_to_cpu(voltage_ranges[j + 1]));
>                 if (!mask) {
> -                       ret = -EINVAL;
>                         dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
>                         goto err_ocr;
>                 }
> --
> 2.7.0.rc3.207.g0ac5344
>
