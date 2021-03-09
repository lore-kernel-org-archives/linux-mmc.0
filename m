Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26255C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C1F64F73
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 09:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhCIJC2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCIJCZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 04:02:25 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C6C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 01:02:25 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id v66so2812273vkd.10
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 01:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttbhYnpcYgH+K2aR0yPYF1pZO0xLFqtiHlZDPTXZHr8=;
        b=JwQkGJFbRFBE4RKqDRaa/SBVpdmku5mQdesrhbthusJ9zdiWQt2cfX3Nq7SGAicMnB
         ZGzj/177YtoVTBwi/He7KiXlygUlPgv+QuOOVvJsJO7gsRUCK8NnMRhGxxNelI9x+k6H
         cj3MkWd0kwJ9rXCbL+0RGj4QDw5VFidE75jqwNGhkCGbedvr0eO23PKqCixUfKiG3Esf
         0Uk1QyJZgQ5CaZ2X9dJ67rxvPowqUWukmXuqrd/Vf+YhfdAmDIcSKZMFP133BfWnyDc7
         GSmGgPdfJUyJEUpZm+4PepsvdhxVPPvcxnd3Ym/jJ0aH8RHrqhgI+T46u/AbJj1dtepz
         l/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttbhYnpcYgH+K2aR0yPYF1pZO0xLFqtiHlZDPTXZHr8=;
        b=OF+9fRED/ZflIY3Oqm9zFPR8VoUneuzp2tDFBppnJaEV3vnhe/EuN76MJpJpzfdqaD
         3ogruHQXp8QLPKKnzV17O2l1vB4f5e0R7jtfKMjHe84hs35qDo9VSl+fq4tkmpqLAcKJ
         Ew638kKai5P1XOYJvy4gEF6XQFLIirzPH4varEBVpsoeA+5m2FQs5OCAU1wfO+HDIs91
         Yw6iuflCPYZlyi2VZpBIv0TaKwKk2Pcw5moyFvmszkXIKTFkr+OXeG3pn1t0yKlyMIra
         DnYt8uBnmf3OLEk2JTuLU8sVQqmOlIOG0zrCNNn3Zf8VAwDogNcLIDgf3OWdyl0EIlPa
         FjKQ==
X-Gm-Message-State: AOAM531V2I7kORg7VQD4tu68JKlqhQmM2pq1utPQNlLBZcxSVVE4NrZZ
        iCfRqA2BSn2H8dAHRXF2BLOkl/Q0/epZreTI/yAJBpok5R7jyQ==
X-Google-Smtp-Source: ABdhPJzWVV3TxA5+IdemJauTd2/cux0lKLD+rCxyJQk+F5d6yVf82w4zxO3ohq5L9h/aJKkuynWRvnKBB+kmGvWWSGI=
X-Received: by 2002:a1f:2e88:: with SMTP id u130mr15429254vku.15.1615280544288;
 Tue, 09 Mar 2021 01:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20210215003217.GA12240@lupo-laptop>
In-Reply-To: <20210215003217.GA12240@lupo-laptop>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 10:01:47 +0100
Message-ID: <CAPDyKFpfEhkH51r83DmQ=QJ2L3H8SuCAm+5++MymsZenzJeudg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] remove field use_cqe in mmc_queue
To:     Luca Porzio <porzio@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Feb 2021 at 01:33, Luca Porzio <porzio@gmail.com> wrote:
>
> Remove usage of use_cqe parameter in mmc_queue
> and use more appropriate mmc_host->cqe_enabled
>
> Signed-off-by: Luca Porzio <lporzio@micron.com>
> Signed-off-by: Zhan Liu <zliua@micron.com>

This looks like standalone and nice cleanup. So, applied for next (I
took the liberty of updating the commit message), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c |  7 ++++---
>  drivers/mmc/core/queue.c | 11 +++++------
>  drivers/mmc/core/queue.h |  1 -
>  3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b877f62df366..08b3c4c4b9f6 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1933,8 +1933,9 @@ static void mmc_blk_hsq_req_done(struct mmc_request *mrq)
>  void mmc_blk_mq_complete(struct request *req)
>  {
>         struct mmc_queue *mq = req->q->queuedata;
> +       struct mmc_host *host = mq->card->host;
>
> -       if (mq->use_cqe)
> +       if (host->cqe_enabled)
>                 mmc_blk_cqe_complete_rq(mq, req);
>         else if (likely(!blk_should_fake_timeout(req->q)))
>                 mmc_blk_mq_complete_rq(mq, req);
> @@ -2179,7 +2180,7 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *mq,
>
>  static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host)
>  {
> -       if (mq->use_cqe)
> +       if (host->cqe_enabled)
>                 return host->cqe_ops->cqe_wait_for_idle(host);
>
>         return mmc_blk_rw_wait(mq, NULL);
> @@ -2228,7 +2229,7 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>                         break;
>                 case REQ_OP_READ:
>                 case REQ_OP_WRITE:
> -                       if (mq->use_cqe)
> +                       if (host->cqe_enabled)
>                                 ret = mmc_blk_cqe_issue_rw_rq(mq, req);
>                         else
>                                 ret = mmc_blk_mq_issue_rw_rq(mq, req);
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 27d2b8ed9484..d600e0a4a460 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -60,7 +60,7 @@ enum mmc_issue_type mmc_issue_type(struct mmc_queue *mq, struct request *req)
>  {
>         struct mmc_host *host = mq->card->host;
>
> -       if (mq->use_cqe && !host->hsq_enabled)
> +       if (host->cqe_enabled && !host->hsq_enabled)
>                 return mmc_cqe_issue_type(host, req);
>
>         if (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_WRITE)
> @@ -127,7 +127,7 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
>         bool ignore_tout;
>
>         spin_lock_irqsave(&mq->lock, flags);
> -       ignore_tout = mq->recovery_needed || !mq->use_cqe || host->hsq_enabled;
> +       ignore_tout = mq->recovery_needed || !host->cqe_enabled || host->hsq_enabled;
>         spin_unlock_irqrestore(&mq->lock, flags);
>
>         return ignore_tout ? BLK_EH_RESET_TIMER : mmc_cqe_timed_out(req);
> @@ -144,7 +144,7 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>
>         mq->in_recovery = true;
>
> -       if (mq->use_cqe && !host->hsq_enabled)
> +       if (host->cqe_enabled && !host->hsq_enabled)
>                 mmc_blk_cqe_recovery(mq);
>         else
>                 mmc_blk_mq_recovery(mq);
> @@ -315,7 +315,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>         if (get_card)
>                 mmc_get_card(card, &mq->ctx);
>
> -       if (mq->use_cqe) {
> +       if (host->cqe_enabled) {
>                 host->retune_now = host->need_retune && cqe_retune_ok &&
>                                    !host->hold_retune;
>         }
> @@ -430,7 +430,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>         int ret;
>
>         mq->card = card;
> -       mq->use_cqe = host->cqe_enabled;
>
>         spin_lock_init(&mq->lock);
>
> @@ -440,7 +439,7 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card)
>          * The queue depth for CQE must match the hardware because the request
>          * tag is used to index the hardware queue.
>          */
> -       if (mq->use_cqe && !host->hsq_enabled)
> +       if (host->cqe_enabled && !host->hsq_enabled)
>                 mq->tag_set.queue_depth =
>                         min_t(int, card->ext_csd.cmdq_depth, host->cqe_qdepth);
>         else
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 57c59b6cb1b9..3319d8ab57d0 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -82,7 +82,6 @@ struct mmc_queue {
>         unsigned int            cqe_busy;
>  #define MMC_CQE_DCMD_BUSY      BIT(0)
>         bool                    busy;
> -       bool                    use_cqe;
>         bool                    recovery_needed;
>         bool                    in_recovery;
>         bool                    rw_wait;
> --
> 2.17.1
>
