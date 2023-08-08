Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A20C41513
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 18:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbjHHSyl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbjHHSyX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 14:54:23 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C619F
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 10:12:19 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-79a0b4c6314so30600241.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 10:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691514739; x=1692119539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=czs5FLmho01QLwa901GjqRSik4ONk7iijh3u8NKJArY=;
        b=Tszi8OX4rRdsp4A6asHMeLj9vjUu/Flr7SlbxG76hqYPRmysticJkt6cBmcWxn6Dko
         XxNXyppFtjorr4A0tW2kN7lp5bYWDs6UY8taainmgL6VKDlVpPsn+AOxY+iUqc2PIRLD
         OOq0z3mZMq+nQ+bwJrUOELCD7B1LB3K+habq9QqE8zexo1OdILV/IqrSzLN1Oy/0LJEb
         DQyRBpmJJs8TFMoflPm3SOqFfLLbV/r1doJ1dFMCshtOdh0sSCiz6WJN2LQ3idsYNERq
         hHlpcjjOprRgfiFXlUptQYOO0jTYjNuVadMMTHSniIlDdz+ktUxse+1aaZlHI4MZHZ3p
         dcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514739; x=1692119539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czs5FLmho01QLwa901GjqRSik4ONk7iijh3u8NKJArY=;
        b=Nvxqdbkwf7HE6S623PjSEaM/x9JfX30qoBjYMmSoKtfIMdzv2T0vOvD5kFrv4xcjkp
         ODOSiHSbcuydlIXddRo3UdXmGvdAxi2ynHyc8z9YMsYQ82infuOMGbVdA2iXwDXwEX89
         ifBfvwdLaPdsUlHAwpRs0x+yRWr3cbhfr9HRrN5vuskJaI2PnNaHINIccwzhyVREDlEX
         vvxpQPeVThV+tNT4OaVPpSiz0Z5PlYsMIwYwYWbNFTV0dZ4Ynm4mIRBulLf3b7uK94s8
         PsklkxNgZptHrQySyjnPY6QfNvN6TLq2fe2ND5P52yr2iVqzELV0/3CGBLBNAezE/xun
         KKqA==
X-Gm-Message-State: AOJu0YyW38ubRszL0rNOmt+C0cvRpebv/+7FWraL2k+LtvGxig7Db4tB
        ZwQke6f1yt3AdnTixnFvrv/xn7IiIDO7SkDY7BV9/0Qz1sH1ONdw8HE=
X-Google-Smtp-Source: AGHT+IHmsYhhTMQA8QWVnEJgqgdgilOlaBxIemkx0xK04YjnhMHfG6KL7pFK7r+wL4NOpFmKd9ZI1l5xuVudgAueyCI=
X-Received: by 2002:a25:e0cd:0:b0:d4d:fea4:fb5b with SMTP id
 x196-20020a25e0cd000000b00d4dfea4fb5bmr7659878ybg.31.1691486896076; Tue, 08
 Aug 2023 02:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230803054544.22007-1-wenchao.chen@unisoc.com>
In-Reply-To: <20230803054544.22007-1-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 11:27:40 +0200
Message-ID: <CAPDyKFrb_nH7w8Wjz3oxJ6Vj30W4-U=k2ST8O7aib_kSHBjsFw@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: replace immediate with hsq->depth
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com,
        chunyan.zhang@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Aug 2023 at 07:46, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> Hsq is similar to cqe, using hsq->depth to represent
> the maximum processing capacity of hsq. We can adjust
> hsq->depth according to the actual situation.

Sorry, but I don't quite follow here.

Are you planning to update the host->hsq_depth dynamically from somewhere?

Kind regards
Uffe

>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/queue.c   | 6 +-----
>  drivers/mmc/host/mmc_hsq.c | 1 +
>  drivers/mmc/host/mmc_hsq.h | 7 +++++++
>  include/linux/mmc/host.h   | 1 +
>  4 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index b396e3900717..a0a2412f62a7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -260,11 +260,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 }
>                 break;
>         case MMC_ISSUE_ASYNC:
> -               /*
> -                * For MMC host software queue, we only allow 2 requests in
> -                * flight to avoid a long latency.
> -                */
> -               if (host->hsq_enabled && mq->in_flight[issue_type] > 2) {
> +               if (host->hsq_enabled && mq->in_flight[issue_type] > host->hsq_depth) {
>                         spin_unlock_irq(&mq->lock);
>                         return BLK_STS_RESOURCE;
>                 }
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index 424dc7b07858..7b3952721c17 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -337,6 +337,7 @@ int mmc_hsq_init(struct mmc_hsq *hsq, struct mmc_host *mmc)
>         hsq->mmc = mmc;
>         hsq->mmc->cqe_private = hsq;
>         mmc->cqe_ops = &mmc_hsq_ops;
> +       mmc->hsq_depth = HSQ_MAX_DEPTH;
>
>         for (i = 0; i < HSQ_NUM_SLOTS; i++)
>                 hsq->tag_slot[i] = HSQ_INVALID_TAG;
> diff --git a/drivers/mmc/host/mmc_hsq.h b/drivers/mmc/host/mmc_hsq.h
> index 1808024fc6c5..795f6b9421d7 100644
> --- a/drivers/mmc/host/mmc_hsq.h
> +++ b/drivers/mmc/host/mmc_hsq.h
> @@ -5,6 +5,13 @@
>  #define HSQ_NUM_SLOTS  64
>  #define HSQ_INVALID_TAG        HSQ_NUM_SLOTS
>
> +/*
> + * For MMC host software queue, we usually allow 2 requests in
> + * flight to avoid a long latency. But we can adjust hsq->depth
> + * according to the actual situation.
> + */
> +#define HSQ_MAX_DEPTH  2
> +
>  struct hsq_slot {
>         struct mmc_request *mrq;
>  };
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 461d1543893b..1fd8b1dd8698 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -520,6 +520,7 @@ struct mmc_host {
>
>         /* Host Software Queue support */
>         bool                    hsq_enabled;
> +       int                     hsq_depth;
>
>         u32                     err_stats[MMC_ERR_MAX];
>         unsigned long           private[] ____cacheline_aligned;
> --
> 2.17.1
>
