From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: set to MMC_CAP_ERASE by default
Date: Mon, 18 Jul 2016 13:20:39 +0200
Message-ID: <CAPDyKFqZX0wZpS=wnqrCRwcDuw1duNncDg4pu_r2_J_n90SsTg@mail.gmail.com>
References: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:36340 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcGRLUl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2016 07:20:41 -0400
Received: by mail-wm0-f45.google.com with SMTP id f126so99116032wma.1
        for <linux-mmc@vger.kernel.org>; Mon, 18 Jul 2016 04:20:41 -0700 (PDT)
In-Reply-To: <1468547691-4525-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 15 July 2016 at 03:54, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> This flag needs to use the trim/discard/erase commands.
> dwmmc controller enables this flag by default.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

As we are close to the merge window, I picked this up directly instead
of you having to send me a PR.

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 9fab5ed..d16de19 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2604,6 +2604,12 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>         if (host->pdata->caps)
>                 mmc->caps = host->pdata->caps;
>
> +       /*
> +        * Support MMC_CAP_ERASE by default.
> +        * It needs to use trim/discard/erase commands.
> +        */
> +       mmc->caps |= MMC_CAP_ERASE;
> +
>         if (host->pdata->pm_caps)
>                 mmc->pm_caps = host->pdata->pm_caps;
>
> --
> 1.9.1
>
