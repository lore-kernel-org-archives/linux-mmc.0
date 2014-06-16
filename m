From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: moxart: Remove unneeded version.h inclusion
Date: Mon, 16 Jun 2014 11:30:18 +0200
Message-ID: <CAPDyKFo8gHfa+Wf309EmU3FJ-H-mvzBQXVKU4NzYmgcpcr4=tg@mail.gmail.com>
References: <1400731605-1261-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50705 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816AbaFPJaT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 05:30:19 -0400
Received: by mail-qc0-f174.google.com with SMTP id x13so7384786qcv.33
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 02:30:18 -0700 (PDT)
In-Reply-To: <1400731605-1261-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Jonas Jensen <jonas.jensen@gmail.com>

On 22 May 2014 06:06, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> version.h inclusion is not needed as suggested by versioncheck.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/moxart-mmc.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 74924a04026e..b4b1efbf6c16 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -13,7 +13,6 @@
>   * warranty of any kind, whether express or implied.
>   */
>
> -#include <linux/version.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> --
> 1.7.9.5
>
