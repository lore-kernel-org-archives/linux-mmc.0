Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D31C2D0CE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ECC24125
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etkreigy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAULwo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:52:44 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40240 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAULwn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2020 06:52:43 -0500
Received: by mail-vs1-f66.google.com with SMTP id g23so1530203vsr.7
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jan 2020 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wslEMNwq9mkYi5KmSRVHdkMhnarEDM7/UCeuoCyFmFM=;
        b=etkreigycikgaahIhbKpMFZ1SRea6/ukXRwHj81+zanFZJ9teyyKfEFC81rAb77VZa
         95PR8nGnMMS4EmnQs1rm1QnAaSGU1NZUpcS+cweZmF0igOQUZWTmIfp+PaSwrXXksq5W
         7ZMlWxf1FhaWCoMlWoWcLzCARE2la5Kw8HYKjj0X2hL+n9vWUSzUyC3cMkKapRsaSE5J
         jwEiJBL90koutXYcRagdciqW5uCU9gewHDt9LVEZK5bgBkW3IQEYPJfY9fsMhZVz0Trf
         0Jf31TitoSydWS2tX9piasVGlkot+H8xKX1vzSKyuYjpujXAwTfIlCbIF+DgtKWX2XvX
         4nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wslEMNwq9mkYi5KmSRVHdkMhnarEDM7/UCeuoCyFmFM=;
        b=sUKiZa59UQNfeqWAhAHWzdUYC3N9OiKf4RvIlFdbraPjJlIvIXbXaK68S+J5bYE/Dv
         +6JZOypoIwbJK4vnEyIMDRaxd1vLMyTfx6ma6XZgbLaizh7ZGtjGo7XPFAr882EhG5/H
         Axc0zhM7QXwLY/KSndMBSAglpBuRqSiiq9AiXqbL99VEH7HcCO7juxDqcP6thzwMIJdX
         LwuVlRw4pujIjl4LfHmOyc25LY8767CcgPG32DtplUCVroPMMW8Xag1vhGE3L7xVF9nD
         0aCtp0jrcFoXmfSI/cMf94+qODRIA8YL5DXWOSe/SScrAoEc5xaOC3xXCM024YYjPkwO
         djFw==
X-Gm-Message-State: APjAAAVam0FeBwGVjUTlyxvFcqdTjjUnuS0ja/yXG0na1OER44moXg5d
        l23mPc4SKJGWhZvl/FMPUrfOA24iWnES6mmQwEPlfe1K
X-Google-Smtp-Source: APXvYqy+R6N46z0/O5vEymA+2m5tdfZF36+H3VIcbi6VIIkFuJ9OQ8CvTYHfBYakGtfk9dVCuw2DfwvM0pkg+8DyFzQ=
X-Received: by 2002:a67:cc3:: with SMTP id 186mr2492996vsm.200.1579607561717;
 Tue, 21 Jan 2020 03:52:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574073572.git.baolin.wang7@gmail.com> <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
In-Reply-To: <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Jan 2020 12:52:05 +0100
Message-ID: <CAPDyKFpm0p+0zr686u70AMEYz6Ne7X5zb3sBvvjTFHfWuvX0jQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: Add MMC host software queue support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Nov 2019 at 11:43, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> From: Baolin Wang <baolin.wang@linaro.org>
>
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.
>
> Thus this patch introduces MMC software queue interface based on the
> hardware command queue engine's interfaces, which is similar with the
> hardware command queue engine's idea, that can remove the context
> switching. Moreover we set the default queue depth as 32 for software
> queue, which allows more requests to be prepared, merged and inserted
> into IO scheduler to improve performance, but we only allow 2 requests
> in flight, that is enough to let the irq handler always trigger the
> next request without a context switch, as well as avoiding a long latency.
>
> From the fio testing data in cover letter, we can see the software
> queue can improve some performance with 4K block size, increasing
> about 16% for random read, increasing about 90% for random write,
> though no obvious improvement for sequential read and write.
>
> Moreover we can expand the software queue interface to support MMC
> packed request or packed command in future.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mmc/core/block.c   |   61 ++++++++
>  drivers/mmc/core/mmc.c     |   13 +-
>  drivers/mmc/core/queue.c   |   33 ++++-
>  drivers/mmc/host/Kconfig   |    7 +
>  drivers/mmc/host/Makefile  |    1 +
>  drivers/mmc/host/mmc_hsq.c |  344 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/mmc_hsq.h |   30 ++++
>  include/linux/mmc/host.h   |    3 +
>  8 files changed, 482 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/mmc/host/mmc_hsq.c
>  create mode 100644 drivers/mmc/host/mmc_hsq.h
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c71a43..870462c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -168,6 +168,11 @@ struct mmc_rpmb_data {
>
>  static inline int mmc_blk_part_switch(struct mmc_card *card,
>                                       unsigned int part_type);
> +static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
> +                              struct mmc_card *card,
> +                              int disable_multi,
> +                              struct mmc_queue *mq);
> +static void mmc_blk_swq_req_done(struct mmc_request *mrq);

We have debated whether swq ("software queue") is a good name - and
just to confirm, I also don't have a great better suggestion.

However, I do like the name of new host interface though, host
software queue, "hsq". That makes sense to me.

One option, to possibly make the core code more aligned to the hsq
interface, could be to stick with the "hsq" acronym for the core layer
as well.

In other words, the above function (and its new friends introduced in
the series) could be renamed to mmc_blk_hsq_req_done(). What do you
think about that?

>
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -1569,9 +1574,30 @@ static int mmc_blk_cqe_issue_flush(struct mmc_queue *mq, struct request *req)
>         return mmc_blk_cqe_start_req(mq->card->host, mrq);
>  }
>
> +static int mmc_blk_swq_issue_rw_rq(struct mmc_queue *mq, struct request *req)
> +{
> +       struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       struct mmc_host *host = mq->card->host;
> +       int err;
> +
> +       mmc_blk_rw_rq_prep(mqrq, mq->card, 0, mq);
> +       mqrq->brq.mrq.done = mmc_blk_swq_req_done;
> +       mmc_pre_req(host, &mqrq->brq.mrq);
> +
> +       err = mmc_cqe_start_req(host, &mqrq->brq.mrq);
> +       if (err)
> +               mmc_post_req(host, &mqrq->brq.mrq, err);
> +
> +       return err;
> +}
> +
>  static int mmc_blk_cqe_issue_rw_rq(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
> +       struct mmc_host *host = mq->card->host;
> +
> +       if (host->swq_enabled)

If we switch to use "hsq", this would then be "hsq_enabled".

> +               return mmc_blk_swq_issue_rw_rq(mq, req);
>
>         mmc_blk_data_prep(mq, mqrq, 0, NULL, NULL);
>
> @@ -1957,6 +1983,41 @@ static void mmc_blk_urgent_bkops(struct mmc_queue *mq,
>                 mmc_run_bkops(mq->card);
>  }
>
> +static void mmc_blk_swq_req_done(struct mmc_request *mrq)
> +{
> +       struct mmc_queue_req *mqrq =
> +               container_of(mrq, struct mmc_queue_req, brq.mrq);
> +       struct request *req = mmc_queue_req_to_req(mqrq);
> +       struct request_queue *q = req->q;
> +       struct mmc_queue *mq = q->queuedata;
> +       struct mmc_host *host = mq->card->host;
> +       unsigned long flags;
> +
> +       if (mmc_blk_rq_error(&mqrq->brq) ||
> +           mmc_blk_urgent_bkops_needed(mq, mqrq)) {
> +               spin_lock_irqsave(&mq->lock, flags);
> +               mq->recovery_needed = true;
> +               mq->recovery_req = req;
> +               spin_unlock_irqrestore(&mq->lock, flags);
> +
> +               host->cqe_ops->cqe_recovery_start(host);
> +
> +               schedule_work(&mq->recovery_work);
> +               return;
> +       }
> +
> +       mmc_blk_rw_reset_success(mq, req);
> +
> +       /*
> +        * Block layer timeouts race with completions which means the normal
> +        * completion path cannot be used during recovery.
> +        */
> +       if (mq->in_recovery)
> +               mmc_blk_cqe_complete_rq(mq, req);
> +       else
> +               blk_mq_complete_request(req);
> +}
> +
>  void mmc_blk_mq_complete(struct request *req)
>  {
>         struct mmc_queue *mq = req->q->queuedata;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c880489..8eac1a2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1852,15 +1852,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          */
>         card->reenable_cmdq = card->ext_csd.cmdq_en;
>
> -       if (card->ext_csd.cmdq_en && !host->cqe_enabled) {
> +       if (host->cqe_ops && !host->cqe_enabled) {

The doesn't looks entirely correct to me, as it means enabling the CQE
hardware for hosts with MMC_CAP2_CQE set, but no matter of whether the
eMMC card really supports CMDQ (or if we failed to enabled CMDQ for
the card). More comments below.

>                 err = host->cqe_ops->cqe_enable(host, card);
>                 if (err) {
>                         pr_err("%s: Failed to enable CQE, error %d\n",
>                                 mmc_hostname(host), err);
>                 } else {
>                         host->cqe_enabled = true;
> -                       pr_info("%s: Command Queue Engine enabled\n",
> -                               mmc_hostname(host));
> +
> +                       if (card->ext_csd.cmdq_en) {
> +                               pr_info("%s: Command Queue Engine enabled\n",
> +                                       mmc_hostname(host));
> +                       } else {
> +                               host->swq_enabled = true;
> +                               pr_info("%s: Software Queue enabled\n",
> +                                       mmc_hostname(host));

A few questions around the above code.

1.
Let's assume the host supports MMC_CAP2_CQE, but the eMMC card doesn't
support CMDQ.

In this case, we still want to allow the host to use the software
variant (the hsq) of the interface. In principle that is what the code
above already tries to implement, but then you also need to update the
support in drivers/mmc/host/cqhci.[ch] to support that dynamically.
For example, the ->cqe_enable() callback should check
"card->ext_csd.cmdq_en" and adjust its behavior accordingly, depending
if the flag has been set or not.

2.
I also notice that you are enabling the use of the hsq path, solely
for eMMC cards. I am guessing hsq is beneficial to use for SD cards as
well, don't you think?

Of course, I am fine by enabling that in a step-by-step approach, so
no need to add that as a part of $subject patch. Although, at least
make it a part of the series.

> +                       }
>                 }
>         }
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 9edc086..d9086c1 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -62,7 +62,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_host *host = mq->card->host;
>
> -       if (mq->use_cqe)
> +       if (mq->use_cqe && !host->swq_enabled)
>                 return mmc_cqe_issue_type(host, req);
>
>         if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
> @@ -124,12 +124,14 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
>  {
>         struct request_queue *q = req->q;
>         struct mmc_queue *mq = q->queuedata;
> +       struct mmc_card *card = mq->card;
> +       struct mmc_host *host = card->host;
>         unsigned long flags;
>         int ret;
>
>         spin_lock_irqsave(&mq->lock, flags);
>
> -       if (mq->recovery_needed || !mq->use_cqe)
> +       if (mq->recovery_needed || !mq->use_cqe || host->swq_enabled)
>                 ret = BLK_EH_RESET_TIMER;
>         else
>                 ret = mmc_cqe_timed_out(req);
> @@ -144,12 +146,13 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>         struct mmc_queue *mq = container_of(work, struct mmc_queue,
>                                             recovery_work);
>         struct request_queue *q = mq->queue;
> +       struct mmc_host *host = mq->card->host;
>
>         mmc_get_card(mq->card, &mq->ctx);
>
>         mq->in_recovery = true;
>
> -       if (mq->use_cqe)
> +       if (mq->use_cqe && !host->swq_enabled)
>                 mmc_blk_cqe_recovery(mq);
>         else
>                 mmc_blk_mq_recovery(mq);
> @@ -160,6 +163,9 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>         mq->recovery_needed = false;
>         spin_unlock_irq(&mq->lock);
>
> +       if (host->swq_enabled)
> +               host->cqe_ops->cqe_recovery_finish(host);
> +
>         mmc_put_card(mq->card, &mq->ctx);
>
>         blk_mq_run_hw_queues(q, true);
> @@ -279,6 +285,14 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 }
>                 break;
>         case MMC_ISSUE_ASYNC:
> +               /*
> +                * For MMC host software queue, we only allow 2 requests in
> +                * flight to avoid a long latency.
> +                */
> +               if (host->swq_enabled && mq->in_flight[issue_type] > 2) {
> +                       spin_unlock_irq(&mq->lock);
> +                       return BLK_STS_RESOURCE;
> +               }
>                 break;
>         default:
>                 /*
> @@ -430,11 +444,16 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>          * The queue depth for CQE must match the hardware because the request
>          * tag is used to index the hardware queue.
>          */
> -       if (mq->use_cqe)
> -               mq->tag_set.queue_depth =
> -                       min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
> -       else
> +       if (mq->use_cqe) {
> +               if (host->swq_enabled)
> +                       mq->tag_set.queue_depth = host->cqe_qdepth;

I don't think we need to treat the hsq as special case in regards to
the .queue_depth.

It should be fine to use the default MMC_QUEUE_DEPTH (64), don't you think?

> +               else
> +                       mq->tag_set.queue_depth =
> +                               min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
> +       } else {
>                 mq->tag_set.queue_depth = MMC_QUEUE_DEPTH;
> +       }
> +
>         mq->tag_set.numa_node = NUMA_NO_NODE;
>         mq->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
>         mq->tag_set.nr_hw_queues = 1;
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 49ea02c..efa4019 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -936,6 +936,13 @@ config MMC_CQHCI
>
>           If unsure, say N.
>
> +config MMC_HSQ
> +       tristate "MMC Host Software Queue support"
> +       help
> +         This selects the Software Queue support.
> +
> +         If unsure, say N.
> +
>  config MMC_TOSHIBA_PCI
>         tristate "Toshiba Type A SD/MMC Card Interface Driver"
>         depends on PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 11c4598..c14b439 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -98,6 +98,7 @@ obj-$(CONFIG_MMC_SDHCI_BRCMSTB)               += sdhci-brcmstb.o
>  obj-$(CONFIG_MMC_SDHCI_OMAP)           += sdhci-omap.o
>  obj-$(CONFIG_MMC_SDHCI_SPRD)           += sdhci-sprd.o
>  obj-$(CONFIG_MMC_CQHCI)                        += cqhci.o
> +obj-$(CONFIG_MMC_HSQ)                  += mmc_hsq.o
>
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>         CFLAGS-cb710-mmc        += -DDEBUG
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> new file mode 100644
> index 0000000..f5a4f93
> --- /dev/null
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MMC software queue support based on command queue interfaces
> + *
> + * Copyright (C) 2019 Linaro, Inc.
> + * Author: Baolin Wang <baolin.wang@linaro.org>
> + */
> +
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +
> +#include "mmc_hsq.h"
> +
> +#define HSQ_NUM_SLOTS  32
> +#define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
> +
> +static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
> +{
> +       struct mmc_host *mmc = hsq->mmc;
> +       struct hsq_slot *slot;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&hsq->lock, flags);
> +
> +       /* Make sure we are not already running a request now */
> +       if (hsq->mrq) {
> +               spin_unlock_irqrestore(&hsq->lock, flags);
> +               return;
> +       }
> +
> +       /* Make sure there are remain requests need to pump */
> +       if (!hsq->qcnt || !hsq->enabled) {
> +               spin_unlock_irqrestore(&hsq->lock, flags);
> +               return;
> +       }
> +
> +       slot = &hsq->slot[hsq->next_tag];
> +       hsq->mrq = slot->mrq;
> +       hsq->qcnt--;
> +
> +       spin_unlock_irqrestore(&hsq->lock, flags);
> +
> +       mmc->ops->request(mmc, hsq->mrq);
> +}
> +
> +static void mmc_hsq_update_next_tag(struct mmc_hsq *hsq, int remains)
> +{
> +       struct hsq_slot *slot;
> +       int tag;
> +
> +       /*
> +        * If there are no remain requests in software queue, then set a invalid
> +        * tag.
> +        */
> +       if (!remains) {
> +               hsq->next_tag = HSQ_INVALID_TAG;
> +               return;
> +       }
> +
> +       /*
> +        * Increasing the next tag and check if the corresponding request is
> +        * available, if yes, then we found a candidate request.
> +        */
> +       if (++hsq->next_tag != HSQ_INVALID_TAG) {
> +               slot = &hsq->slot[hsq->next_tag];
> +               if (slot->mrq)
> +                       return;
> +       }
> +
> +       /* Othersie we should iterate all slots to find a available tag. */
> +       for (tag = 0; tag < HSQ_NUM_SLOTS; tag++) {
> +               slot = &hsq->slot[tag];
> +               if (slot->mrq)
> +                       break;
> +       }
> +
> +       if (tag == HSQ_NUM_SLOTS)
> +               tag = HSQ_INVALID_TAG;
> +
> +       hsq->next_tag = tag;
> +}
> +
> +static void mmc_hsq_post_request(struct mmc_hsq *hsq)
> +{
> +       unsigned long flags;
> +       int remains;
> +
> +       spin_lock_irqsave(&hsq->lock, flags);
> +
> +       remains = hsq->qcnt;
> +       hsq->mrq = NULL;
> +
> +       /* Update the next available tag to be queued. */
> +       mmc_hsq_update_next_tag(hsq, remains);
> +
> +       if (hsq->waiting_for_idle && !remains) {
> +               hsq->waiting_for_idle = false;
> +               wake_up(&hsq->wait_queue);
> +       }
> +
> +       /* Do not pump new request in recovery mode. */
> +       if (hsq->recovery_halt) {
> +               spin_unlock_irqrestore(&hsq->lock, flags);
> +               return;
> +       }
> +
> +       spin_unlock_irqrestore(&hsq->lock, flags);
> +
> +        /*
> +         * Try to pump new request to host controller as fast as possible,
> +         * after completing previous request.
> +         */
> +       if (remains > 0)
> +               mmc_hsq_pump_requests(hsq);
> +}
> +
> +/**
> + * mmc_hsq_finalize_request - finalize one request if the request is done
> + * @mmc: the host controller
> + * @mrq: the request need to be finalized
> + *
> + * Return true if we finalized the corresponding request in software queue,
> + * otherwise return false.
> + */
> +bool mmc_hsq_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct mmc_hsq *hsq = mmc->cqe_private;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&hsq->lock, flags);
> +
> +       if (!hsq->enabled || !hsq->mrq || hsq->mrq != mrq) {
> +               spin_unlock_irqrestore(&hsq->lock, flags);
> +               return false;
> +       }
> +
> +       /*
> +        * Clear current completed slot request to make a room for new request.
> +        */
> +       hsq->slot[hsq->next_tag].mrq = NULL;
> +
> +       spin_unlock_irqrestore(&hsq->lock, flags);
> +
> +       mmc_cqe_request_done(mmc, hsq->mrq);
> +
> +       mmc_hsq_post_request(hsq);
> +
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(mmc_hsq_finalize_request);
> +
> +static void mmc_hsq_recovery_start(struct mmc_host *mmc)
> +{
> +       struct mmc_hsq *hsq = mmc->cqe_private;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&hsq->lock, flags);
> +
> +       hsq->recovery_halt = true;
> +
> +       spin_unlock_irqrestore(&hsq->lock, flags);
> +}
> +
> +static void mmc_hsq_recovery_finish(struct mmc_host *mmc)
> +{
> +       struct mmc_hsq *hsq = mmc->cqe_private;
> +       int remains;
> +
> +       spin_lock_irq(&hsq->lock);
> +
> +       hsq->recovery_halt = false;
> +       remains = hsq->qcnt;
> +
> +       spin_unlock_irq(&hsq->lock);
> +
> +       /*
> +        * Try to pump new request if there are request pending in software
> +        * queue after finishing recovery.
> +        */
> +       if (remains > 0)
> +               mmc_hsq_pump_requests(hsq);
> +}
> +
> +static int mmc_hsq_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct mmc_hsq *hsq = mmc->cqe_private;
> +       int tag = mrq->tag;
> +
> +       spin_lock_irq(&hsq->lock);
> +
> +       if (!hsq->enabled) {
> +               spin_unlock_irq(&hsq->lock);
> +               return -ESHUTDOWN;
> +       }
> +
> +       /* Do not queue any new requests in recovery mode. */
> +       if (hsq->recovery_halt) {
> +               spin_unlock_irq(&hsq->lock);
> +               return -EBUSY;
> +       }
> +
> +       hsq->slot[tag].mrq = mrq;
> +
> +       /*
> +        * Set the next tag as current request tag if no available
> +        * next tag.
> +        */
> +       if (hsq->next_tag == HSQ_INVALID_TAG)
> +               hsq->next_tag = tag;
> +
> +       hsq->qcnt++;
> +
> +       spin_unlock_irq(&hsq->lock);
> +
> +       mmc_hsq_pump_requests(hsq);
> +
> +       return 0;
> +}
> +
> +static void mmc_hsq_post_req(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       if (mmc->ops->post_req)
> +               mmc->ops->post_req(mmc, mrq, 0);
> +}
> +
> +static bool mmc_hsq_queue_is_idle(struct mmc_hsq *hsq, int *ret)
> +{
> +       bool is_idle;
> +
> +       spin_lock_irq(&hsq->lock);
> +
> +       is_idle = (!hsq->mrq && !hsq->qcnt) ||
> +               hsq->recovery_halt;
> +
> +       *ret = hsq->recovery_halt ? -EBUSY : 0;
> +       hsq->waiting_for_idle = !is_idle;
> +
> +       spin_unlock_irq(&hsq->lock);
> +
> +       return is_idle;
> +}
> +
> +static int mmc_hsq_wait_for_idle(struct mmc_host *mmc)
> +{
> +       struct mmc_hsq *hsq = mmc->cqe_private;
> +       int ret;
> +
> +       wait_event(hsq->wait_queue,
> +                  mmc_hsq_queue_is_idle(hsq, &ret));
> +
> +       return ret;
> +}
> +
> +static void mmc_hsq_disable(struct mmc_host *mmc)
> +{
> +       struct mmc_hsq *hsq = mmc->cqe_private;
> +       u32 timeout = 500;
> +       int ret;
> +
> +       spin_lock_irq(&hsq->lock);
> +
> +       if (!hsq->enabled) {
> +               spin_unlock_irq(&hsq->lock);
> +               return;
> +       }
> +
> +       spin_unlock_irq(&hsq->lock);
> +
> +       ret = wait_event_timeout(hsq->wait_queue,
> +                                mmc_hsq_queue_is_idle(hsq, &ret),
> +                                msecs_to_jiffies(timeout));
> +       if (ret == 0) {
> +               pr_warn("could not stop mmc software queue\n");
> +               return;
> +       }
> +
> +       spin_lock_irq(&hsq->lock);
> +
> +       hsq->enabled = false;
> +
> +       spin_unlock_irq(&hsq->lock);
> +}
> +
> +static int mmc_hsq_enable(struct mmc_host *mmc, struct mmc_card *card)
> +{
> +       struct mmc_hsq *hsq = mmc->cqe_private;
> +
> +       spin_lock_irq(&hsq->lock);
> +
> +       if (hsq->enabled) {
> +               spin_unlock_irq(&hsq->lock);
> +               return -EBUSY;
> +       }
> +
> +       hsq->enabled = true;
> +
> +       spin_unlock_irq(&hsq->lock);
> +
> +       return 0;
> +}
> +
> +static const struct mmc_cqe_ops mmc_hsq_ops = {
> +       .cqe_enable = mmc_hsq_enable,
> +       .cqe_disable = mmc_hsq_disable,
> +       .cqe_request = mmc_hsq_request,
> +       .cqe_post_req = mmc_hsq_post_req,
> +       .cqe_wait_for_idle = mmc_hsq_wait_for_idle,
> +       .cqe_recovery_start = mmc_hsq_recovery_start,
> +       .cqe_recovery_finish = mmc_hsq_recovery_finish,
> +};
> +
> +int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
> +{
> +       hsq->num_slots = HSQ_NUM_SLOTS;
> +       hsq->next_tag = HSQ_INVALID_TAG;
> +       mmc->cqe_qdepth = HSQ_NUM_SLOTS;
> +
> +       hsq->slot = devm_kcalloc(mmc_dev(mmc), hsq->num_slots,
> +                                sizeof(struct hsq_slot), GFP_KERNEL);
> +       if (!hsq->slot)
> +               return -ENOMEM;
> +
> +       hsq->mmc = mmc;
> +       hsq->mmc->cqe_private = hsq;
> +       mmc->cqe_ops = &mmc_hsq_ops;
> +
> +       spin_lock_init(&hsq->lock);
> +       init_waitqueue_head(&hsq->wait_queue);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_hsq_init);
> +
> +void mmc_hsq_suspend(struct mmc_host *mmc)
> +{
> +       mmc_hsq_disable(mmc);
> +}
> +EXPORT_SYMBOL_GPL(mmc_hsq_suspend);
> +
> +int mmc_hsq_resume(struct mmc_host *mmc)
> +{
> +       return mmc_hsq_enable(mmc, NULL);
> +}
> +EXPORT_SYMBOL_GPL(mmc_hsq_resume);
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> new file mode 100644
> index 0000000..d51beb7
> --- /dev/null
> +++ b/drivers/mmc/host/mmc_hsq.h
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef LINUX_MMC_HSQ_H
> +#define LINUX_MMC_HSQ_H
> +
> +struct hsq_slot {
> +       struct mmc_request *mrq;
> +};
> +
> +struct mmc_hsq {
> +       struct mmc_host *mmc;
> +       struct mmc_request *mrq;
> +       wait_queue_head_t wait_queue;
> +       struct hsq_slot *slot;
> +       spinlock_t lock;
> +
> +       int next_tag;
> +       int num_slots;
> +       int qcnt;
> +
> +       bool enabled;
> +       bool waiting_for_idle;
> +       bool recovery_halt;
> +};
> +
> +int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc);
> +void mmc_hsq_suspend(struct mmc_host *mmc);
> +int mmc_hsq_resume(struct mmc_host *mmc);
> +bool mmc_hsq_finalize_request(struct mmc_host *mmc, struct mmc_request *mrq);
> +
> +#endif
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba70338..3931aa3 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -462,6 +462,9 @@ struct mmc_host {
>         bool                    cqe_enabled;
>         bool                    cqe_on;
>
> +       /* Software Queue support */
> +       bool                    swq_enabled;
> +
>         unsigned long           private[0] ____cacheline_aligned;
>  };
>
> --
> 1.7.9.5
>

Other than the above, this looks indeed very promising! I have no
further comment for the rest of the patches in the series.

And again, apologize for the delays!

Kind regards
Uffe
