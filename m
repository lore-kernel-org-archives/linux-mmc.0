From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 01/22] mmc: block: Fix is_waiting_last_req set incorrectly
Date: Tue, 14 Mar 2017 17:22:15 +0100
Message-ID: <CAPDyKFoAMei=B-9OFx0cKFrt2hjg6mg9o52P6XpB=uch=ad1RQ@mail.gmail.com>
References: <1489408613-26915-1-git-send-email-adrian.hunter@intel.com> <1489408613-26915-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:34167 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbdCNQWW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2017 12:22:22 -0400
Received: by mail-ua0-f172.google.com with SMTP id f54so168140455uaa.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2017 09:22:21 -0700 (PDT)
In-Reply-To: <1489408613-26915-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 13 March 2017 at 13:36, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Commit 15520111500c ("mmc: core: Further fix thread wake-up") allowed a
> queue to release the host with is_waiting_last_req set to true. A queue
> waiting to claim the host will not reset it, which can result in the
> queue getting stuck in a loop.
>
> Fixes: 15520111500c ("mmc: core: Further fix thread wake-up")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v4.10+

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 1621fa08e206..e59107ca512a 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1817,6 +1817,7 @@ void mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
>                 mmc_blk_issue_flush(mq, req);
>         } else {
>                 mmc_blk_issue_rw_rq(mq, req);
> +               card->host->context_info.is_waiting_last_req = false;
>         }
>
>  out:
> --
> 1.9.1
>
