From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7 v2] mmc: add blk_size_workaround for HW bug
Date: Tue, 2 Sep 2014 11:09:15 +0200
Message-ID: <CAPDyKFrFMCjKHDLYs=fZKuhf8VD-x+prvAok_2Ngn4vGc2x=hA@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87lhq2kcif.wl%kuninori.morimoto.gx@gmail.com>
	<87k35mkcgu.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:44551 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbaIBJJR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 05:09:17 -0400
Received: by mail-lb0-f181.google.com with SMTP id n15so7055924lbi.40
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 02:09:15 -0700 (PDT)
In-Reply-To: <87k35mkcgu.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 2 September 2014 04:01, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current mmc block.c has MMC_CAP2_NO_MULTI_READ flag
> for HW bug workaround, but it should be implemented
> under driver, not framework.
> This patch is prepare for it

I like the idea of this patchset!

Still, historically, we have been using MMC_CAP* to solve these kind
issues. Therefore I think the commit message deserves a better
explanation to why we invent a new host ops function pointer for this
particular case.

>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
>
> - no change
>
>  drivers/mmc/card/block.c |    5 +++++
>  include/linux/mmc/host.h |    4 ++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index ede41f0..e946067 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1402,6 +1402,11 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                 if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
>                     rq_data_dir(req) == READ)
>                         brq->data.blocks = 1;
> +
> +               /* Some controllers needs workaround */

Suggest to rephrase the comment to:
"Some controllers have HW issues while operating in multiple I/O mode."

> +               if (card->host->ops->blk_size_workaround)

Do you mind renaming the new callback to "multi_io_quirk"? I think it
better describes what it's intended for.

> +                       brq->data.blocks = card->host->ops->blk_size_workaround(
> +                               card, req, brq->data.blocks);

We shouldn't pass "req" as an argument, since that is a blkdev
specific struct. It's better to pass MMC_DATA_WRITE|READ as an
unsigned int.

>         }
>
>         if (brq->data.blocks > 1 || do_rel_wr) {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4cbf614..95bd903 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -139,6 +139,10 @@ struct mmc_host_ops {
>         int     (*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
>         void    (*hw_reset)(struct mmc_host *host);
>         void    (*card_event)(struct mmc_host *host);
> +
> +       /* optional callback for mmc block HW bug workaround */

Please update the comment to something like below:

"Optional callback to support controllers with HW issues for multiple I/O.
Returns the number of supported blocks for the request."

> +       int     (*blk_size_workaround)(struct mmc_card *card,
> +                                      struct request *req, int blk_size);
>  };
>
>  struct mmc_card;
> --
> 1.7.9.5
>

Kind regards
Uffe
