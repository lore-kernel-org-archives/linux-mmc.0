From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V8 04/20] mmc: queue: Factor out mmc_queue_alloc_bounce_bufs()
Date: Wed, 30 Nov 2016 09:16:23 +0100
Message-ID: <CAPDyKFpvPykF2Y0x9QhnoKEzo8um0CCheMT_rASf1AT67LAShw@mail.gmail.com>
References: <1480414167-15577-1-git-send-email-adrian.hunter@intel.com> <1480414167-15577-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f180.google.com ([209.85.210.180]:35193 "EHLO
        mail-wj0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751492AbcK3IQ0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 03:16:26 -0500
Received: by mail-wj0-f180.google.com with SMTP id v7so166476052wjy.2
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2016 00:16:25 -0800 (PST)
In-Reply-To: <1480414167-15577-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

On 29 November 2016 at 11:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> In preparation for supporting a queue of requests, factor out
> mmc_queue_alloc_bounce_bufs().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Harjani Ritesh <riteshh@codeaurora.org>
> ---
>  drivers/mmc/card/queue.c | 45 +++++++++++++++++++++++++++------------------
>  1 file changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 010888d8d97c..4497a218c245 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -186,6 +186,31 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>                 queue_flag_set_unlocked(QUEUE_FLAG_SECERASE, q);
>  }
>
> +static bool mmc_queue_alloc_bounce_bufs(struct mmc_queue *mq,
> +                                       unsigned int bouncesz)

This causes a compiler warning about unused function, in case when
CONFIG_MMC_BLOCK_BOUNCE is unset.
No worries, I fixed it and amended the patch.

[...]

Kind regards
Uffe
