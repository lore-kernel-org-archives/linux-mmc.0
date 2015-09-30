From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: fix dead loop of mmc_retune
Date: Wed, 30 Sep 2015 15:03:05 +0200
Message-ID: <CAPDyKFrOtC80QKT6Bczq7dEZ3s3_3LXYcz-5L1sAKVxVMaNNBA@mail.gmail.com>
References: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36268 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbbI3NDH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2015 09:03:07 -0400
Received: by wicgb1 with SMTP id gb1so194248605wic.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2015 06:03:06 -0700 (PDT)
In-Reply-To: <1443605838-5948-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Johan Rudholm <johan.rudholm@axis.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, David Jander <david@protonic.nl>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>

On 30 September 2015 at 11:37, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> When get a CRC error, start the mmc_retune, it will issue CMD19/CMD21
> to do tune, assume there were 10 clock phase need to try, phase 0 to
> phase 6 is ok, phase 7 to phase 9 is NG, we try it from 0 to 9, so
> the last CMD19/CMD21 will get CRC error, host->need_retune was set and
> cause mmc_retune was called, then dead loop of mmc_retune
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks Chaotian!

I have applied this for fixes and added the following tag:

Fixes: bd11e8bd03ca ("mmc: core: Flag re-tuning is needed on CRC errors")

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0520064..a3eb20b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -134,9 +134,11 @@ void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
>         int err = cmd->error;
>
>         /* Flag re-tuning needed on CRC errors */
> -       if (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
> +       if ((cmd->opcode != MMC_SEND_TUNING_BLOCK &&
> +           cmd->opcode != MMC_SEND_TUNING_BLOCK_HS200) &&
> +           (err == -EILSEQ || (mrq->sbc && mrq->sbc->error == -EILSEQ) ||
>             (mrq->data && mrq->data->error == -EILSEQ) ||
> -           (mrq->stop && mrq->stop->error == -EILSEQ))
> +           (mrq->stop && mrq->stop->error == -EILSEQ)))
>                 mmc_retune_needed(host);
>
>         if (err && cmd->retries && mmc_host_is_spi(host)) {
> --
> 1.8.1.1.dirty
>
