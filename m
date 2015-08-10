From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: remove the unused blk_setting
Date: Mon, 10 Aug 2015 22:51:18 +0530
Message-ID: <CAGOxZ52eUarEXMCp-s7muk_7dyGrvu7DECZHg0BRn0+xNu-O2A@mail.gmail.com>
References: <1438845806-4486-1-git-send-email-jh80.chung@samsung.com> <1438845806-4486-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34930 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbbHJRV6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2015 13:21:58 -0400
Received: by qgj62 with SMTP id 62so97014115qgj.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Aug 2015 10:21:58 -0700 (PDT)
In-Reply-To: <1438845806-4486-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Jaehoon

On Thu, Aug 6, 2015 at 12:53 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> "blk_setting" doesn't use anywhere.
>
This does not apply cleanly on Ulf's next branch.
Probably this has dependency on https://patchwork.kernel.org/patch/6930201/

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
Anyway, patch looks good so,
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Tested on exynos5800, no functionality changes, so

Tested-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/mmc/host/dw_mmc.c  | 34 +++++++++++++---------------------
>  include/linux/mmc/dw_mmc.h |  1 -
>  2 files changed, 13 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index de88e64..091df65 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2436,28 +2436,20 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>         if (ret)
>                 goto err_host_allocated;
>
> -       if (host->pdata->blk_settings) {
> -               mmc->max_segs = host->pdata->blk_settings->max_segs;
> -               mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
> -               mmc->max_blk_count = host->pdata->blk_settings->max_blk_count;
> -               mmc->max_req_size = host->pdata->blk_settings->max_req_size;
> -               mmc->max_seg_size = host->pdata->blk_settings->max_seg_size;
> +       /* Useful defaults if platform data is unset. */
> +       if (host->use_dma) {
> +               mmc->max_segs = host->ring_size;
> +               mmc->max_blk_size = 65536;
> +               mmc->max_seg_size = 0x1000;
> +               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +               mmc->max_blk_count = mmc->max_req_size / 512;
>         } else {
> -               /* Useful defaults if platform data is unset. */
> -               if (host->use_dma) {
> -                       mmc->max_segs = host->ring_size;
> -                       mmc->max_blk_size = 65536;
> -                       mmc->max_seg_size = 0x1000;
> -                       mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> -                       mmc->max_blk_count = mmc->max_req_size / 512;
> -               } else {
> -                       mmc->max_segs = 64;
> -                       mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
> -                       mmc->max_blk_count = 512;
> -                       mmc->max_req_size = mmc->max_blk_size *
> -                                           mmc->max_blk_count;
> -                       mmc->max_seg_size = mmc->max_req_size;
> -               }
> +               mmc->max_segs = 64;
> +               mmc->max_blk_size = 65536; /* BLKSIZ is 16 bits */
> +               mmc->max_blk_count = 512;
> +               mmc->max_req_size = mmc->max_blk_size *
> +                                   mmc->max_blk_count;
> +               mmc->max_seg_size = mmc->max_req_size;
>         }
>
>         if (dw_mci_get_cd(mmc))
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 5be9767..9c06f2d 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -259,7 +259,6 @@ struct dw_mci_board {
>
>         struct dw_mci_dma_ops *dma_ops;
>         struct dma_pdata *data;
> -       struct block_settings *blk_settings;
>  };
>
>  #endif /* LINUX_MMC_DW_MMC_H */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
