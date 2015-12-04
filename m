From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mediatek: change some dev_err to dev_dbg
Date: Fri, 4 Dec 2015 15:56:48 +0100
Message-ID: <CAPDyKFoAhCzwmAi_ru0u-mdxiuvzufGRBUEjEgRc1zBGiLTDgA@mail.gmail.com>
References: <1448971954-398-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36109 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123AbbLDO4t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2015 09:56:49 -0500
Received: by ykdr82 with SMTP id r82so126066937ykd.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2015 06:56:48 -0800 (PST)
In-Reply-To: <1448971954-398-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Daniel Kurtz <djkurtz@chromium.org>

On 1 December 2015 at 13:12, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> there are too many error logs shown when use CMD21/CMD19 to do tune,
> and it will appear at each resume time, print out so many logs to the
> uart console cost too mush time. so change it to dev_dbg.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

This one didn't apply to my next branch. Can you please rebase.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 39568cc..34d23b8 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -972,7 +972,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                 if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->error)) {
>                         data->bytes_xfered = data->blocks * data->blksz;
>                 } else {
> -                       dev_err(host->dev, "interrupt events: %x\n", events);
> +                       dev_dbg(host->dev, "interrupt events: %x\n", events);
>                         msdc_reset_hw(host);
>                         host->error |= REQ_DAT_ERR;
>                         data->bytes_xfered = 0;
> @@ -982,10 +982,10 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                         else if (events & MSDC_INT_DATCRCERR)
>                                 data->error = -EILSEQ;
>
> -                       dev_err(host->dev, "%s: cmd=%d; blocks=%d",
> +                       dev_dbg(host->dev, "%s: cmd=%d; blocks=%d",
>                                 __func__, mrq->cmd->opcode, data->blocks);
> -                       dev_err(host->dev, "data_error=%d xfer_size=%d\n",
> -                                       (int)data->error, data->bytes_xfered);
> +                       dev_dbg(host->dev, "data_error=%d xfer_size=%d\n",
> +                               (int)data->error, data->bytes_xfered);
>                 }
>
>                 msdc_data_xfer_next(host, mrq, data);
> --
> 1.8.1.1.dirty
>
