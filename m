Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F43C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006BB61246
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhHXO6S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbhHXO6R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:58:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB76C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z2so46200559lft.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYunF8tEYq+2ajwHU1FHWc2rL4BPeRKMk17xOmv7jeM=;
        b=BIwK6SNM6DPrcqf+N9QuLMTruAnh4xX+CpguIfdVPQNwfBwgBQ6+RRiisOeE/C12As
         iHaZgZ3Uouh3szimZQYrFmeq/WuIzoOdYgdQV0kjvmqUWCjbtRAcR3MpT9nitq2ybh8W
         W+AX8Ur2L4DhlwwEEijeEixoP7pFQWdR9D8Iwv5cgmrnYVJPR9+7/QzqCcfQ3DTZNKTQ
         J7bGereC1JJivZi3HcJYmDd1rHWhWEmyKsY/WITd0T7xe/oLGEYfp7ib2MJMbEe745iQ
         uSH+uqV2nusQhgOct5bpRuef0askYX7FUuWiRUCkQ7ruf5QExaUnbXQ/Mo5+HOSk+i4h
         Ss2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYunF8tEYq+2ajwHU1FHWc2rL4BPeRKMk17xOmv7jeM=;
        b=aDHOMwQnY5PzS5+8id+S6sdXpoJwpwgM2Cw+ukPfWOR9O+fx9M5exyE+3WrG0f6KNt
         GUkW241l/S0msm3iFrpCeH9r4ruxDc+IRfb6UH26SB4zZUuZZgSWEXijuhoAYFYycpU5
         ksHT0RP1BJmRFzfF7WDJKgV42WeVV4FQprBUklhrzcWMbCu7H8yzqsIbAqoHQMbn4F0i
         GE+UgZ9sKY7DPvK27O9tCpv2bJWnAGJVcR+0Bam/glrCGYFi7e65h0tQybKp94MYrNjl
         717O93glTBZQUFqvVOtu2lSMV3++T0kqHSqkswkuzheeGq5MK9UFc4TOhToeV+EArhT1
         APFw==
X-Gm-Message-State: AOAM533koNQgbfu+lc8PUMcFeBaSowrLsfzzhGieNCkmw6DYHR7o8ZQv
        1CVcN13veFkP3oT2ccOAVOXAP5d+ynO3vW0ZuSZkbA==
X-Google-Smtp-Source: ABdhPJy/9AxT4PfKoQm9orjvcsk1a58rdl2kOO6oRHNjI5kKiQrXt2jbBKaIpB2xmW4/51w8K7m8+nJZgnDJ/6/s4c8=
X-Received: by 2002:a05:6512:e99:: with SMTP id bi25mr3314856lfb.486.1629817051781;
 Tue, 24 Aug 2021 07:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210824074651epcas1p3b6965040fa6a4660a31192f96125c374@epcas1p3.samsung.com>
 <20210824073934.19727-1-cw9316.lee@samsung.com>
In-Reply-To: <20210824073934.19727-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:55 +0200
Message-ID: <CAPDyKFpRLvsY79srmmi-2nS4ACR37QK+KqUmtvPL00raRG-dcg@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: Match the data type of max_segments
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Luca Porzio <porzio@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>,
        Seunghui Lee <sh043.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 24 Aug 2021 at 09:46, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> Each function has a different data type for max_segments,
> Modify to match unsigned short(host->max_segs).
> * unsigned short          max_segs;       /* see blk_queue_max_segments */
>
> 1) Return type : unsigned int
> static unsigned int mmc_get_max_segments(struct mmc_host *host)
> {
>        return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
>                                          host->max_segs;
> }
>
> 2) Parameter type : int
>  mmc_alloc_sg(mmc_get_max_segments(host), gfp);
>    -> static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
>
> 3) Parameter type : unsigned short
>  blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));
>    -> void blk_queue_max_segments(struct request_queue *q,
>                                         unsigned short max_segments)
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index cc3261777637..48304bcf963c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -163,7 +163,7 @@ static void mmc_mq_recovery_handler(struct work_struct *work)
>         blk_mq_run_hw_queues(q, true);
>  }
>
> -static struct scatterlist *mmc_alloc_sg(int sg_len, gfp_t gfp)
> +static struct scatterlist *mmc_alloc_sg(unsigned short sg_len, gfp_t gfp)
>  {
>         struct scatterlist *sg;
>
> @@ -193,7 +193,7 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>                 blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
>
> -static unsigned int mmc_get_max_segments(struct mmc_host *host)
> +static unsigned short mmc_get_max_segments(struct mmc_host *host)
>  {
>         return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
>                                          host->max_segs;
> --
> 2.29.0
>
