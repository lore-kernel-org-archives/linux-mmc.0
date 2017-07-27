From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] MMC: Remove HIGHMEM dependency from mmc-spi driver
Date: Thu, 27 Jul 2017 16:48:39 +0200
Message-ID: <CAPDyKFo0J60BQim199+PBSAo2Ftuz9WXP-Mp2nMBsOcq8ZCXAQ@mail.gmail.com>
References: <20170718121915.23303-1-ian@mnementh.co.uk> <20170718121915.23303-2-ian@mnementh.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36508 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbdG0Osk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:48:40 -0400
Received: by mail-qk0-f172.google.com with SMTP id d136so108095682qkg.3
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:48:40 -0700 (PDT)
In-Reply-To: <20170718121915.23303-2-ian@mnementh.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 18 July 2017 at 14:19, Ian Molton <ian@mnementh.co.uk> wrote:
> I cannot see why this is needed. kmap() should be safe in this case.
>
> Signed-off-by: Ian Molton <ian@mnementh.co.uk>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5755b69f2f72..a8980e9e688b 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -494,7 +494,7 @@ config MMC_GOLDFISH
>
>  config MMC_SPI
>         tristate "MMC/SD/SDIO over SPI"
> -       depends on SPI_MASTER && !HIGHMEM && HAS_DMA
> +       depends on SPI_MASTER && HAS_DMA
>         select CRC7
>         select CRC_ITU_T
>         help
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
