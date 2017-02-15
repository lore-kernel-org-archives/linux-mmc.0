From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 12/39] mmc: block: Add Software Command Queuing
Date: Wed, 15 Feb 2017 14:34:27 +0100
Message-ID: <CACRpkdZmVJ9ixeMUZs+t-Je10Ak5iM=t2MJhy=O_MnU6-_Cnag@mail.gmail.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com> <1486731352-8018-13-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35522 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdBONe2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 08:34:28 -0500
Received: by mail-io0-f174.google.com with SMTP id j18so88330701ioe.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 05:34:28 -0800 (PST)
In-Reply-To: <1486731352-8018-13-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On Fri, Feb 10, 2017 at 1:55 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> eMMC Command Queuing is a feature added in version 5.1.  The card maintains
> a queue of up to 32 data transfers.  Commands CMD44/CMD45 are sent to queue
> up transfers in advance, and then one of the transfers is selected to
> "execute" by CMD46/CMD47 at which point data transfer actually begins.
(...)
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Overall this looks nice.

I have of course objections about the things where I just patched
around.

> +static int mmc_swcmdq_await_qsr(struct mmc_queue *mq, struct mmc_card *card,
> +                               bool wait)
(...)
> +       if (card->host->areq) {
> +               /*
> +                * The active request remains in the QSR until completed. Remove
> +                * it so that mq->qsr only contains ones that are ready but not
> +                * executed.
> +                */
> +               mqrq = container_of(card->host->areq, struct mmc_queue_req,
> +                                   areq);
> +               __clear_bit(mqrq->task_id, &mq->qsr);
> +       }

Clever. I see that you might need that task_id field in mqrq for this.
Which is fine: this is the per-request state container and should be used
for all states pertaining to a certain request.

> +       prev = mmc_start_areq(card->host, next, &status);
> +
> +       if (status == MMC_BLK_NEW_REQUEST) {
> +               mq->prepared_areq = next;
> +               return status;
> +       }
> +
> +       mq->prepared_areq = NULL;
> +
> +       if (!prev)
> +               return 0;
> +
> +       mqrq = container_of(prev, struct mmc_queue_req, areq);
> +       brq = &mqrq->brq;
> +       req = mqrq->req;
> +
> +       mmc_queue_bounce_post(mqrq);

So this is duplicating hairy submission semantics that I've tried to get rid of.

> +       switch (status) {
> +       case MMC_BLK_SUCCESS:
> +       case MMC_BLK_PARTIAL:
> +       case MMC_BLK_SUCCESS_ERR:
> +               mmc_blk_reset_success(mq->blkdata, MMC_BLK_SWCMDQ);
> +               ret = blk_end_request(req, 0, brq->data.bytes_xfered);
> +               if (ret) {
> +                       if (!requeuing)
> +                               return __mmc_swcmdq_enqueue(mq, mqrq);
> +                       return 0;
> +               }
> +               break;
> +       case MMC_BLK_NEW_REQUEST:
> +               return status;
> +       default:
> +               if (mqrq->retry_cnt++) {
> +                       blk_end_request_all(req, -EIO);
> +                       break;
> +               }
> +               return status;
> +       }

And this is the successful path where I nowadays try to split the return
path in two in the  last non-RFC patch:
"mmc: queue: issue requests in massive parallel"

It is not good that the command queue code is making a local copy of
the error handling code, but I guess it actually needs to handle
errors in a totally different way?

> +static void __mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *new_req)

For this ans all other functions that got a __prefix all of a sudden: please
try to avoid that and instead come up with a proper new name.

The code is confusing enough as it is and in "my"
subsystems I have tried to cut down on all __prefixed functions in
favor of more exact naming. This is just very painful for the mind.

Yours,
Linus Walleij
