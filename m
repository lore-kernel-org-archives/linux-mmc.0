From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: fix format string warning
Date: Wed, 21 Jan 2015 09:44:22 +0100
Message-ID: <CAPDyKFp+=nS-vWuRpiVjxF49Dz1WZSnwOVMgin0x_dr5etswJQ@mail.gmail.com>
References: <20150120163335.GA5016@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:47755 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbAUIoX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jan 2015 03:44:23 -0500
Received: by mail-qc0-f182.google.com with SMTP id l6so30839855qcy.13
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2015 00:44:23 -0800 (PST)
In-Reply-To: <20150120163335.GA5016@ubuntu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Asaf Vertz <asaf.vertz@tandemg.com>
Cc: Chris Ball <chris@printf.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ben Hutchings <ben@decadent.org.uk>, Joe Perches <joe@perches.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20 January 2015 at 17:33, Asaf Vertz <asaf.vertz@tandemg.com> wrote:
> Fixed the following warning (reported by cppcheck):
> [drivers/mmc/card/block.c:2149]: (warning) %d in format string (no. 1)
> requires 'int' but the argument type is 'unsigned int'.
>
> Signed-off-by: Asaf Vertz <asaf.vertz@tandemg.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4409d79..8e1a60e 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2147,7 +2147,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>          */
>
>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> -                "mmcblk%d%s", md->name_idx, subname ? subname : "");
> +                "mmcblk%u%s", md->name_idx, subname ? subname : "");
>
>         if (mmc_card_mmc(card))
>                 blk_queue_logical_block_size(md->queue.queue,
> --
> 1.7.0.4
>
