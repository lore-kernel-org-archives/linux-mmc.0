From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdio_cis: fix unknown tuple for CISTPL_SDIO_STD
Date: Wed, 20 Jan 2016 12:47:05 +0100
Message-ID: <CAPDyKFpKaHx+N+mxsQ8BrJwWRSuf49ycr29naJKRP4v77RCPMg@mail.gmail.com>
References: <1453277824-15719-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34811 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbcATLrG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 06:47:06 -0500
Received: by mail-yk0-f173.google.com with SMTP id a85so6293739ykb.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2016 03:47:05 -0800 (PST)
In-Reply-To: <1453277824-15719-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20 January 2016 at 09:17, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> CISTPL_SDIO_STD(0x91) is a known tuple, but sdio_cis didn't define it,
> so we get the warning blow while probing several sdio wifi. Refer to SDIO spec,
> it's no need to parse the tuple, so this patch just make it a known one.
>
> [    4.098980] mmc2: queuing unknown CIS tuple 0x91 (3 bytes)
> [    4.099033] mmc2: new ultra high speed SDR104 SDIO card at address 0001
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for fixes.

I also updated the change-log as it caused some checkpatch warnings.

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/sdio_cis.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index 8e94e55..6f6fc52 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -223,6 +223,7 @@ static const struct cis_tpl cis_tpl_list[] = {
>         {       0x20,   4,      cistpl_manfid           },
>         {       0x21,   2,      /* cistpl_funcid */     },
>         {       0x22,   0,      cistpl_funce            },
> +       {       0x91,   2,      /* cistpl_sdio_std */   },
>  };
>
>  static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
