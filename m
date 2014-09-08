From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7 v3] mmc: add .multi_io_quirk callback for multi I/O HW bug
Date: Mon, 8 Sep 2014 11:08:10 +0200
Message-ID: <CAPDyKFoOh1+adZ8i_e+WHHk_UuDYYBqesVhAZ=MCt_P60Kv_=Q@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<87a96h78wd.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:47610 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbaIHJIL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Sep 2014 05:08:11 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so14926846qcw.17
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2014 02:08:11 -0700 (PDT)
In-Reply-To: <87a96h78wd.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 3 September 2014 04:08, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Historically, we have been using MMC_CAP* to solve
> some issues, and current mmc block.c has
> MMC_CAP2_NO_MULTI_READ flag for multi I/O HW bug workaround.
> But it should be implemented under driver, not framework.
> This patch is prepare for it
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks! Applied for next.

I took the liberty of improving the commit message and fixed a
checkpatch warning.

Kind regards
Uffe


> ---
> v2 -> v3
>
>  - blk_size_workaround -> multi_io_quirk
>  - fixup comment/explain
>  - use MMC_DATA_READ/WRITE
>
>  drivers/mmc/card/block.c |   10 ++++++++++
>  include/linux/mmc/host.h |    7 +++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index ede41f0..adab903 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1402,6 +1402,16 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                 if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
>                     rq_data_dir(req) == READ)
>                         brq->data.blocks = 1;
> +
> +               /*
> +                * Some controllers have HW issues while operating
> +                * in multiple I/O mode
> +                */
> +               if (card->host->ops->multi_io_quirk)
> +                       brq->data.blocks = card->host->ops->multi_io_quirk(card,
> +                                               (rq_data_dir(req) == READ) ?
> +                                               MMC_DATA_READ : MMC_DATA_WRITE,
> +                                               brq->data.blocks);
>         }
>
>         if (brq->data.blocks > 1 || do_rel_wr) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4cbf614..bfcf673 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -139,6 +139,13 @@ struct mmc_host_ops {
>         int     (*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
>         void    (*hw_reset)(struct mmc_host *host);
>         void    (*card_event)(struct mmc_host *host);
> +
> +       /*
> +        * Optional callback to support controllers with HW issues for multiple I/O.
> +        * Returns the number of supported blocks for the request
> +        */
> +       int     (*multi_io_quirk)(struct mmc_card *card,
> +                                 unsigned int direction, int blk_size);
>  };
>
>  struct mmc_card;
> --
> 1.7.9.5
>
