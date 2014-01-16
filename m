From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/7] mmc: sh_mmcif: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Thu, 16 Jan 2014 11:22:29 +0100
Message-ID: <CAPDyKFoA9P8ggVx3EkFUpKotMHdvWO7GWe5QrBi89VkGXS7tEw@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<002201cf11fb$c63ffee0$52bffca0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:59973 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbaAPKWa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 05:22:30 -0500
Received: by mail-qe0-f46.google.com with SMTP id 8so2300809qea.33
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 02:22:30 -0800 (PST)
In-Reply-To: <002201cf11fb$c63ffee0$52bffca0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc <linux-mmc@vger.kernel.org>

On 15 January 2014 15:12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Replaced UHS_DDR50 with MMC_DDR52.
>
> CC: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/sh_mmcif.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 54730f4..656fbba 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -803,12 +803,13 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
>                         break;
>                 }
>                 switch (host->timing) {
> -               case MMC_TIMING_UHS_DDR50:
> +               case MMC_TIMING_MMC_DDR52:

What about UHS SD cards?

Kind regards
Ulf Hansson

>                         /*
>                          * MMC core will only set this timing, if the host
> -                        * advertises the MMC_CAP_UHS_DDR50 capability. MMCIF
> -                        * implementations with this capability, e.g. sh73a0,
> -                        * will have to set it in their platform data.
> +                        * advertises the MMC_CAP_1_8V_DDR/MMC_CAP_1_2V_DDR
> +                        * capability. MMCIF implementations with this
> +                        * capability, e.g. sh73a0, will have to set it
> +                        * in their platform data.
>                          */
>                         tmp |= CMD_SET_DARS;
>                         break;
> --
> 1.7.0.4
>
>
