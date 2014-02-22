From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] mmc: mxcmmc: Convert to SIMPLE_DEV_PM_OPS
Date: Sat, 22 Feb 2014 11:51:52 -0300
Message-ID: <CAOMZO5CKgYfHT5NS3MOmDh7q6PQX7zJx2y11csWNjNded6-bqw@mail.gmail.com>
References: <1393080372-6760-1-git-send-email-shc_work@mail.ru>
	<1393080372-6760-2-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f182.google.com ([209.85.128.182]:45214 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbaBVOvx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2014 09:51:53 -0500
Received: by mail-ve0-f182.google.com with SMTP id jy13so4446284veb.27
        for <linux-mmc@vger.kernel.org>; Sat, 22 Feb 2014 06:51:53 -0800 (PST)
In-Reply-To: <1393080372-6760-2-git-send-email-shc_work@mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>

On Sat, Feb 22, 2014 at 11:46 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/mmc/host/mxcmmc.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 84d630e..86401c0 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -1220,8 +1220,7 @@ static int mxcmci_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int mxcmci_suspend(struct device *dev)

Doesn't this need to be protected by CONFIG_PM_SLEEP?
