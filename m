From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: core: Fix CMD6 timeout issue
Date: Thu, 12 Jan 2017 11:58:33 +0100
Message-ID: <CAPDyKFrYGz2zHZu2iNd09QxcBP5X4nvmYa85uAa7VtZjaH+USQ@mail.gmail.com>
References: <1483433397-11756-1-git-send-email-yong.mao@mediatek.com> <1483433397-11756-2-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:35349 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdALK6i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 05:58:38 -0500
Received: by mail-wj0-f179.google.com with SMTP id i20so9194440wjn.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 02:58:37 -0800 (PST)
In-Reply-To: <1483433397-11756-2-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

-trimmed cc list

On 3 January 2017 at 09:49, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> When initializing EMMC, after switch to HS400,
> it will issue CMD6 to change ext_csd,
> if first CMD6 got CRC error,
> the repeat CMD6 may get timeout,
> that's because card is not back to transfer state immediately.
>
> For resolving this issue, it need check if card is busy
> before sending repeat CMD6.
>
> Not only CMD6 here has this issue, but also other R1B CMD has
> the same issue.

Is this change still something you want to discuss? Or the issue is resolved by:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1308640.html

Kind regards
Uffe

>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/core.c |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1076b9d..8674dbb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -566,6 +566,25 @@ void mmc_wait_for_req_done(struct mmc_host *host, struct mmc_request *mrq)
>
>                 mmc_retune_recheck(host);
>
> +               /*
> +                * If a R1B CMD such as CMD6 occur CRC error,
> +                * it will retry 3 times here.
> +                * But before retrying, it must ensure card is in
> +                * transfer state.
> +                * Otherwise, the next retried CMD will got TMO error.
> +                */
> +               if (mmc_resp_type(cmd) == MMC_RSP_R1B && host->ops->card_busy) {
> +                       int tries = 500; /* Wait aprox 500ms at maximum */
> +
> +                       while (host->ops->card_busy(host) && --tries)
> +                               mmc_delay(1);
> +
> +                       if (tries == 0) {
> +                               cmd->error = -EBUSY;
> +                               break;
> +                       }
> +               }
> +
>                 pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
>                          mmc_hostname(host), cmd->opcode, cmd->error);
>                 cmd->retries--;
> --
> 1.7.9.5
>
