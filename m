From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: add the message for deprecating supports-highspeed
Date: Wed, 5 Nov 2014 14:06:59 +0100
Message-ID: <CAPDyKFqjBr-MbZLJrxPbxYcKWyoeZ7-Nf0yRnGxYQ2awL8+mbQ@mail.gmail.com>
References: <1415089855-18366-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:64993 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaKENHA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 08:07:00 -0500
Received: by mail-qc0-f179.google.com with SMTP id o8so470668qcw.10
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 05:06:59 -0800 (PST)
In-Reply-To: <1415089855-18366-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>

On 4 November 2014 09:30, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Recommend to use "mmc-cap-highspeed" or "sd-cap-highspeed" instead of
> "supports-highspeed".
> Although "supports-highspeed" supports, devloper can use
> "mmc-cap-highspeed" or "sd-cap-highspeed" through this message.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

This one has checkpatch warnings. Please send an updated version.

Kind regards
Uffe

> ---
>  drivers/mmc/host/dw_mmc.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index bb46b1b..7075d33 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2434,8 +2434,11 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>                         return ERR_PTR(ret);
>         }
>
> -       if (of_find_property(np, "supports-highspeed", NULL))
> +       if (of_find_property(np, "supports-highspeed", NULL)) {
> +               dev_warn(dev, "supports-highspeed is deprecated. "
> +                               "Use cap-mmc-highspeed or cap-sd-highspeed.\n");
>                 pdata->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> +       }
>
>         return pdata;
>  }
> --
> 1.7.9.5
>
