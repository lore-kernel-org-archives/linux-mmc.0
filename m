From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: cavium-octeon: Convert to use module_platform_driver
Date: Tue, 22 Aug 2017 13:15:00 +0200
Message-ID: <CAPDyKFqA8bubRdRn+o4ZshvyEm2168YGCzmNNOs0i0is=4VZXw@mail.gmail.com>
References: <20170819130611.3335-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:38254 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932488AbdHVLPB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:15:01 -0400
Received: by mail-qt0-f180.google.com with SMTP id 57so17424583qtu.5
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:15:01 -0700 (PDT)
In-Reply-To: <20170819130611.3335-1-axel.lin@ingics.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Jan Glauber <jglauber@cavium.com>, David Daney <david.daney@cavium.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 19 August 2017 at 15:06, Axel Lin <axel.lin@ingics.com> wrote:
> Get rid of boilerplate code by using module_platform_driver macro.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/cavium-octeon.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
> index 951d2cd..22aded1 100644
> --- a/drivers/mmc/host/cavium-octeon.c
> +++ b/drivers/mmc/host/cavium-octeon.c
> @@ -342,18 +342,7 @@ static struct platform_driver octeon_mmc_driver = {
>         },
>  };
>
> -static int __init octeon_mmc_init(void)
> -{
> -       return platform_driver_register(&octeon_mmc_driver);
> -}
> -
> -static void __exit octeon_mmc_cleanup(void)
> -{
> -       platform_driver_unregister(&octeon_mmc_driver);
> -}
> -
> -module_init(octeon_mmc_init);
> -module_exit(octeon_mmc_cleanup);
> +module_platform_driver(octeon_mmc_driver);
>
>  MODULE_AUTHOR("Cavium Inc. <support@cavium.com>");
>  MODULE_DESCRIPTION("Low-level driver for Cavium OCTEON MMC/SSD card");
> --
> 2.9.3
>
