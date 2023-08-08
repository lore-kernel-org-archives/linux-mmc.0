Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F312C001B0
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 17:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjHHRyB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHHRxh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 13:53:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49498B5EBF
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:23:55 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd04558784so814099a34.3
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511826; x=1692116626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s++4blSxMjulxr4WqQlajWQp+reqB47xPJw4qPYyIJs=;
        b=IUQAhvD4RKUXNSV9XcGbGQHJ8hHdkytLCSLvIQ2dcXA142AV4RNVcQXpz8GJjHh7T9
         K6UNaryGbM9RuC2PzG+yDYsD6YvcdFfod2KHrmK6NviSBnhQKp37lNb107z7T+z6CcFg
         3t6sRk9Apcu4QZEU/NTXVBo6pv/hvMqhjCVxdX4Fpu+46aM8s6QGLbzeoQ0T4BHuEd+Y
         3ndIG1irNC/FyhtiVpeWmgDVp5GohlF4xcYHzVBbFBOGgVBXLEK5V2jt1fhIrDA07hic
         5+hCfszuSPc9YD+Oe3X/XTJXgBah3LWTxlhtFb9q9W+MwWBJ0KUNh7t8B/2kYMiExq/P
         eSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511826; x=1692116626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s++4blSxMjulxr4WqQlajWQp+reqB47xPJw4qPYyIJs=;
        b=ZmLfT7n/l4thMqH1Hywfr2rftQRplJdTyfdjWTmEpSNwcP2ggIcyy/APnqk8blfeiG
         lLIf8l/hePREbyvhi1K5Uq8RSGEmAX895r9T3uH7heQnjiUFGCo0lhsLdzZZP3BExGTf
         uFTIHIx1qIiia3Me7A7r5DW2Kn4uLEe251HtAruteD9pms51ROuWo/esApjV4cHfHbZC
         nZM0DSFd+Qx5CaRfDl564wlqGl0aC2QNpuVV2p26pfRy/g3VFBBB9rIhuYlPYpr2deE6
         RNY5pDtszl9YwMqrHLqkoT8fWOytA8XwoBRRHoinLoicjwR5/O/BkCaRlZOnfJrTBB7U
         Ztaw==
X-Gm-Message-State: AOJu0Yzd2B1nVAvesRPz86/UOiQZxeN7XM+3AVE4BakRB1E7SUKp+kYQ
        EzF9rmd9G/AWr2J0g73EsQPgDIC88K7/5Pau4exVBtbHBmGSSBkc
X-Google-Smtp-Source: AGHT+IGGcAj42nyoezAnxw/gRQ5a8aT9hrh74ET1epNHdpkHqryPud6eA2qTIgp9XEhLBjrOsYxl27ezpR/VAqMtR6k=
X-Received: by 2002:a25:6943:0:b0:ce8:42b6:46f9 with SMTP id
 e64-20020a256943000000b00ce842b646f9mr15212913ybc.45.1691491995143; Tue, 08
 Aug 2023 03:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230802023023.1318134-1-yunlong.xing@unisoc.com>
In-Reply-To: <20230802023023.1318134-1-yunlong.xing@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 12:52:39 +0200
Message-ID: <CAPDyKFr1ts4yE3it=+fFsvQaSPTa=R01yobaNVhHfRh4nRicow@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: block: Fix in_flight[issue_type] value error
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     adrian.hunter@intel.com, CLoehle@hyperstone.com,
        brauner@kernel.org, hare@suse.de, asuk4.q@gmail.com,
        avri.altman@wdc.com, beanhuo@micron.com, linus.walleij@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, hongyu.jin@unisoc.com,
        zhiguo.niu@unisoc.com, yunlong.xing23@gmail.com,
        yibin.ding@unisoc.com, dongliang.cui@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Aug 2023 at 04:33, Yunlong Xing <yunlong.xing@unisoc.com> wrote:
>
> From: Yibin Ding <yibin.ding@unisoc.com>
>
> For a completed request, after the mmc_blk_mq_complete_rq(mq, req)
> function is executed, the bitmap_tags corresponding to the
> request will be cleared, that is, the request will be regarded as
> idle. If the request is acquired by a different type of process at
> this time, the issue_type of the request may change. It further
> caused the value of mq->in_flight[issue_type] to be abnormal,
> and a large number of requests could not be sent.
>
> p1:                                           p2:
> mmc_blk_mq_complete_rq
>   blk_mq_free_request
>                                               blk_mq_get_request
>                                                 blk_mq_rq_ctx_init
> mmc_blk_mq_dec_in_flight
>   mmc_issue_type(mq, req)
>
> This strategy can ensure the consistency of issue_type
> before and after executing mmc_blk_mq_complete_rq.
>
> Fixes: 81196976ed94 ("mmc: block: Add blk-mq support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yibin Ding <yibin.ding@unisoc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> changes of v2: Sort local declarations in descending order of
> line length
> ---
>  drivers/mmc/core/block.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..b6f4be25b31b 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2097,14 +2097,14 @@ static void mmc_blk_mq_poll_completion(struct mmc_queue *mq,
>         mmc_blk_urgent_bkops(mq, mqrq);
>  }
>
> -static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, enum mmc_issue_type issue_type)
>  {
>         unsigned long flags;
>         bool put_card;
>
>         spin_lock_irqsave(&mq->lock, flags);
>
> -       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
> +       mq->in_flight[issue_type] -= 1;
>
>         put_card = (mmc_tot_in_flight(mq) == 0);
>
> @@ -2117,6 +2117,7 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue *mq, struct request *req)
>  static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>                                 bool can_sleep)
>  {
> +       enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
>         struct mmc_queue_req *mqrq = req_to_mmc_queue_req(req);
>         struct mmc_request *mrq = &mqrq->brq.mrq;
>         struct mmc_host *host = mq->card->host;
> @@ -2136,7 +2137,7 @@ static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
>                         blk_mq_complete_request(req);
>         }
>
> -       mmc_blk_mq_dec_in_flight(mq, req);
> +       mmc_blk_mq_dec_in_flight(mq, issue_type);
>  }
>
>  void mmc_blk_mq_recovery(struct mmc_queue *mq)
> --
> 2.25.1
>
