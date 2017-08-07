From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 06/11] mmc: mmc: Enable Command Queuing
Date: Mon, 7 Aug 2017 16:34:09 +0200
Message-ID: <CAPDyKFor5xzCthFb4M=ATxCfnSMe5gBZwWVp6-E=wLWCepuMEQ@mail.gmail.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com> <1500630584-22852-7-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34420 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdHGOeK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 10:34:10 -0400
Received: by mail-qk0-f176.google.com with SMTP id u139so3571086qka.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 07:34:10 -0700 (PDT)
In-Reply-To: <1500630584-22852-7-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Enable the Command Queue if the host controller supports i a command queue

Perhaps clarify the above to:
Enable the eMMC Command Queue if the card supports it and if the host
controller also supports the command queue engine.

> engine. It is not compatible with Packed Commands, so do not enable that
> at the same time.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/mmc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4ffea14b7eb6..2ff0caf92bc8 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1783,6 +1783,20 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 }
>         }
>
> +       /* Enable Command Queue if supported */
> +       card->ext_csd.cmdq_en = false;
> +       if (card->ext_csd.cmdq_support && host->caps2 & MMC_CAP2_CQE) {
> +               err = mmc_cmdq_enable(card);
> +               if (err && err != -EBADMSG)
> +                       goto free_card;
> +               if (err) {
> +                       pr_warn("%s: Enabling CMDQ failed\n",
> +                               mmc_hostname(card->host));
> +                       card->ext_csd.cmdq_support = false;
> +                       card->ext_csd.cmdq_depth = 0;
> +                       err = 0;
> +               }
> +       }
>         /*
>          * In some cases (e.g. RPMB or mmc_test), the Command Queue must be
>          * disabled for a time, so a flag is needed to indicate to re-enable the
> @@ -1796,7 +1810,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          */
>         if (card->ext_csd.max_packed_writes >= 3 &&
>             card->ext_csd.max_packed_reads >= 5 &&
> -           host->caps2 & MMC_CAP2_PACKED_CMD) {
> +           host->caps2 & MMC_CAP2_PACKED_CMD &&

There are currently no host using MMC_CAP2_PACKED_CMD and we have
recently removed the support for it in the mmc block device layer.
It turned out we still have some leftovers. Would you mind folding in
a cleanup patch removing the support for packed command altogether and
adopt this change to it?

I guess adding a comment that CMDQ can't be used together with packed
command is still relevant. Especially if we would consider re-adding
the support for it.

> +           !card->ext_csd.cmdq_en) {
>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                 EXT_CSD_EXP_EVENTS_CTRL,
>                                 EXT_CSD_PACKED_EVENT_EN,
> --
> 1.9.1
>

Kind regards
Uffe
