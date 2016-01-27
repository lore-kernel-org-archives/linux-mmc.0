From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: core: pwrseq_simple: remove unused header file
Date: Wed, 27 Jan 2016 15:15:23 +0100
Message-ID: <CAPDyKFop5_HAW1x=mFjZdezqxo71qR-ZSwGeNXP1Jsc_AKxSyA@mail.gmail.com>
References: <1452051250-17163-1-git-send-email-peter.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:35971 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932935AbcA0OPY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 09:15:24 -0500
Received: by mail-yk0-f170.google.com with SMTP id v14so241598343ykd.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 06:15:24 -0800 (PST)
In-Reply-To: <1452051250-17163-1-git-send-email-peter.chen@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 6 January 2016 at 04:34, Peter Chen <peter.chen@freescale.com> wrote:
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/pwrseq_simple.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index d10538b..f42a956 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -12,7 +12,6 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> -#include <linux/of_gpio.h>
>  #include <linux/gpio/consumer.h>
>
>  #include <linux/mmc/host.h>
> --
> 1.9.1
>
