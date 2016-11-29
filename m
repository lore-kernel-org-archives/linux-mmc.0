From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/8] mmc: queue: remove BUG_ON for bounce_sg
Date: Tue, 29 Nov 2016 13:41:32 +0100
Message-ID: <CAPDyKFpeVT=EUeqcRkVQgm4SU7hmVUVzSum0HRR58pbdXTWYtQ@mail.gmail.com>
References: <1478071440-12689-1-git-send-email-shawn.lin@rock-chips.com> <1478071609-12941-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f177.google.com ([209.85.210.177]:36011 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755684AbcK2Mlf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 07:41:35 -0500
Received: by mail-wj0-f177.google.com with SMTP id qp4so144019506wjc.3
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 04:41:34 -0800 (PST)
In-Reply-To: <1478071609-12941-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 2 November 2016 at 08:26, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> bounce_sg for mqrq_cur and mqrq_pre are proper
> allocated when initializing the queue and will not
> be freed before explicitly cleaning the queue. So from
> the code itself it should be quite confident to remove
> this check. If that BUG_ON take effects, it is mostly
> likely the memory is randomly oopsing.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/card/queue.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 8037f73..6c8978a 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -505,8 +505,6 @@ unsigned int mmc_queue_map_sg(struct mmc_queue *mq, struct mmc_queue_req *mqrq)
>                         return blk_rq_map_sg(mq->queue, mqrq->req, mqrq->sg);
>         }
>
> -       BUG_ON(!mqrq->bounce_sg);
> -
>         if (mmc_packed_cmd(cmd_type))
>                 sg_len = mmc_queue_packed_map_sg(mq, mqrq->packed,
>                                                  mqrq->bounce_sg, cmd_type);
> --
> 2.3.7
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
