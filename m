From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 02/22] mmc: block: Fix cmd error reset failure path
Date: Tue, 14 Mar 2017 17:22:22 +0100
Message-ID: <CAPDyKFpk7Q9qmEbNTDTd5MOfugeaQ9hdvQNk-uHWo0p7=fcfhQ@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34675 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbdCNQWY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:22:24 -0400
Received: by mail-vk0-f50.google.com with SMTP id r136so54735778vke.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:22:23 -0700 (PDT)
In-Reply-To: <1489408613-26915-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 13 March 2017 at 13:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Commit 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
> assumed the request had not completed, but in one case it had. Fix that.
>
> Fixes: 4e1f780032c5 ("mmc: block: break out mmc_blk_rw_cmd_abort()")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index e59107ca512a..05afefcfb611 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1701,7 +1701,8 @@ static void mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)
>                 case MMC_BLK_CMD_ERR:
>                         req_pending = mmc_blk_rw_cmd_err(md, card, brq, old_req, req_pending);
>                         if (mmc_blk_reset(md, card->host, type)) {
> -                               mmc_blk_rw_cmd_abort(card, old_req);
> +                               if (req_pending)
> +                                       mmc_blk_rw_cmd_abort(card, old_req);
>                                 mmc_blk_rw_try_restart(mq, new_req);
>                                 return;
>                         }
> --
> 1.9.1
>
