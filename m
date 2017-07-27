From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix the wrong condition check of getting num-slots
Date: Thu, 27 Jul 2017 16:47:49 +0200
Message-ID: <CAPDyKFokz=gWuvCC29tzUs=d9FhaZvPS7eCnBMHn4NfS8Aczdg@mail.gmail.com>
References: <1500626396-223769-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:38287 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdG0Oru (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:47:50 -0400
Received: by mail-qt0-f179.google.com with SMTP id t37so68540264qtg.5
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:47:50 -0700 (PDT)
In-Reply-To: <1500626396-223769-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 21 July 2017 at 10:39, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> We only need to show the deprecated information if the driver
> is able to get num-slots from DT. Otherwise I was confused by
> the log with:
>
> dwmmc_rockchip fe320000.dwmmc: 'num-slots' was deprecated.
>
> However I actually removed all num-slots from rockchip platforms.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for fixes and added a fixes tag.

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a9dfb26..250dc6e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2957,7 +2957,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>         }
>
>         /* find out number of slots supported */
> -       if (device_property_read_u32(dev, "num-slots", &pdata->num_slots))
> +       if (!device_property_read_u32(dev, "num-slots", &pdata->num_slots))
>                 dev_info(dev, "'num-slots' was deprecated.\n");
>
>         if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
