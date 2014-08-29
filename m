From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sunxi: Declare ERASE capability
Date: Fri, 29 Aug 2014 13:10:08 +0200
Message-ID: <CAPDyKFrjOEpAcyu-eXVuqKhESYgpMQbdyDrvkcyN0Q4gGNG2OQ@mail.gmail.com>
References: <1408541960-14788-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:63287 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbaH2LKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 07:10:10 -0400
Received: by mail-lb0-f181.google.com with SMTP id n15so2355641lbi.40
        for <linux-mmc@vger.kernel.org>; Fri, 29 Aug 2014 04:10:08 -0700 (PDT)
In-Reply-To: <1408541960-14788-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>

On 20 August 2014 15:39, Chen-Yu Tsai <wens@csie.org> wrote:
> Declare ERASE capability so we can use filesystems with the discard
> option and the fstrim tool.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sunxi-mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 024f67c..7bf5c1c 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -990,7 +990,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>         /* 400kHz ~ 50MHz */
>         mmc->f_min              =   400000;
>         mmc->f_max              = 50000000;
> -       mmc->caps              |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
> +       mmc->caps              |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> +                                 MMC_CAP_ERASE;
>
>         ret = mmc_of_parse(mmc);
>         if (ret)
> --
> 2.1.0
>
