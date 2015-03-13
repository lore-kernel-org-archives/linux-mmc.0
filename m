From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: add MMC_CAP_SDIO_IRQ capability
Date: Fri, 13 Mar 2015 11:14:31 +0100
Message-ID: <CAPDyKFpE=eOqJgfF8eA9V5+js0BV7UqzHkid1vxzjW2-jrO8uQ@mail.gmail.com>
References: <1426001796-19231-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:42810 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbCMKOc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 06:14:32 -0400
Received: by qgfi50 with SMTP id i50so24590143qgf.9
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 03:14:31 -0700 (PDT)
In-Reply-To: <1426001796-19231-1-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 10 March 2015 at 16:36, Hans de Goede <hdegoede@redhat.com> wrote:
> When the sunxi mmc-controller code was initially merged MMC_CAP_SDIO_IRQ was
> not added to the host caps because of issues with some sdio wifi modules.
>
> It turns out that these issues have nothing to do with using sdio-irq support,
> they also happen with oob interrupts. Since the hardware supports sdio-irq
> everywhere, and since the one reason to not claim the capability is gone,
> add MMC_CAP_SDIO_IRQ to the default host caps.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e8a4218..94eee54 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1028,7 +1028,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         mmc->f_min              =   400000;
>         mmc->f_max              = 50000000;
>         mmc->caps              |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> -                                 MMC_CAP_ERASE;
> +                                 MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> --
> 2.3.1
>
