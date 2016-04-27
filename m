From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmcif: remove obsolete support for sh7372
Date: Wed, 27 Apr 2016 10:31:20 +0200
Message-ID: <CAPDyKFoPzUs3t00Yhrwdrc6Eeb-rpnh8ONb03vBk5fMAQCs47g@mail.gmail.com>
References: <1461702886-6873-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37246 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbcD0IbW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 04:31:22 -0400
Received: by mail-wm0-f53.google.com with SMTP id a17so5715366wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2016 01:31:21 -0700 (PDT)
In-Reply-To: <1461702886-6873-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On 26 April 2016 at 22:34, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> There is no support for this platform in the kernel anymore. Make the
> Kconfig text more generic, so it won't get stale anymore.
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 04feea8354cba7..f5be219274329d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -676,9 +676,9 @@ config MMC_SH_MMCIF
>         depends on HAS_DMA
>         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>         help
> -         This selects the MMC Host Interface controller (MMCIF).
> +         This selects the MMC Host Interface controller (MMCIF) found in various
> +         Renesas SoCs for SH and ARM architectures.
>
> -         This driver supports MMCIF in sh7724/sh7757/sh7372.
>
>  config MMC_JZ4740
>         tristate "JZ4740 SD/Multimedia Card Interface support"
> --
> 2.7.0
>
