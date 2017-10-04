From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: cavium: Depend on GPIO driver
Date: Wed, 4 Oct 2017 10:59:17 +0200
Message-ID: <CAPDyKFo6b74HAOEYKCeNYB=MmFYJgX82LfkzRXV2ExKRJ9zzUg@mail.gmail.com>
References: <1506945761-23482-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:56155 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdJDI7S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2017 04:59:18 -0400
Received: by mail-io0-f170.google.com with SMTP id z187so9910799ioz.12
        for <linux-mmc@vger.kernel.org>; Wed, 04 Oct 2017 01:59:18 -0700 (PDT)
In-Reply-To: <1506945761-23482-1-git-send-email-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>

On 2 October 2017 at 14:02, Jan Glauber <jglauber@cavium.com> wrote:
> Without the ThunderX/OcteonTx GPIO driver the MMC driver
> would not power up any MMC devices. Therefore add a
> dependency to the GPIO driver and remove the unneeded GPIOLIB
> dependency.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8c15637178ff..a47a2f1d8ae4 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -663,7 +663,7 @@ config MMC_CAVIUM_OCTEON
>  config MMC_CAVIUM_THUNDERX
>         tristate "Cavium ThunderX SD/MMC Card Interface support"
>         depends on PCI && 64BIT && (ARM64 || COMPILE_TEST)
> -       depends on GPIOLIB
> +       depends on GPIO_THUNDERX
>         depends on OF_ADDRESS
>         help
>           This selects Cavium ThunderX SD/MMC Card Interface.
> --
> 2.9.0.rc0.21.g7777322
>
