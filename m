Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1120C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C5C64E76
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Feb 2021 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhBHMKe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Feb 2021 07:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhBHMIj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Feb 2021 07:08:39 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E42C061794
        for <linux-mmc@vger.kernel.org>; Mon,  8 Feb 2021 04:07:29 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id o31so4594406uae.2
        for <linux-mmc@vger.kernel.org>; Mon, 08 Feb 2021 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nBfHlTUO8xcU/3J/1NVTL8ay5K7+Ykot5u7GvYL+7LM=;
        b=NfLotLBwlQ8o4oLVojx5LDeUFs12Rx+9Btmx4abJJvR5jXzDirjfwJezEiHlU4O+lA
         K9jv6KJrdOR8dU9H28wZWguJW6cLZ019h1jptg2lfhZEvIyb0d+1Cl2zo9H3TaKsLied
         aHhJsVoAroheOrsHOfwMQmsnnroF4nHprJRZFzXc9aYZ5Q0j7EdlkSwrJ+++tZkK97NQ
         PPunqpLLd+MaBspRTwC5j1Zrk/3vqRhudi1DQgDMgMSKtSeHezLNXW7gzt7ta6xgtuTZ
         7CKd5lnUrNXd3U2AEnWQ39Li1C0p1Agurchyvogyf0oX8iEuEkXW4BXUQGDKchjk75u2
         VQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nBfHlTUO8xcU/3J/1NVTL8ay5K7+Ykot5u7GvYL+7LM=;
        b=bDndYDEq9AcPeTA0X0TvIGPR049BPeHsQgou1fL+DQ3z60ETFcHiLk+1H7CJ4ma7/d
         dkZ1UiaqszN0CU5cYgFDNqjfmIsjNAPcukXMHEr6JmkdKSfnatGMyv0+keZ6L/752FO0
         1R6MapZ437yYPE4MBxuwBPV8zOLU9985cBaCW920QpuuEGV12lXvSk/f0Py+p1kMsMja
         Ebkf4rRGvxkv3QbxwDYEZQSeOZhWohCOVnOies/cH186mo71V59hwO3mXnUxYENjRZV8
         Mjou5VjRP/Z8dNegC7GtJ4lgvYoF0EXktwq2l3yFhlmHrdRGAAQ+v8QUCeOPl4UzO0AM
         Xr7Q==
X-Gm-Message-State: AOAM530Gd8Z48KwFgEo/L9ODGsm40kAZGl3kHsU3CIf3LmLF3iHhitEs
        za142n3JCBbhRn05pXZdxhypQjHOULWf+AW3addXQv8VXYWhKQ==
X-Google-Smtp-Source: ABdhPJyveAOXkWIY2Uy+xBZPmCcq2xl4pXwGqlI0/iGJwo+I347AbyooClMRtYeOqEyyV5RIb+XCebmp2TWWJI2gZCQ=
X-Received: by 2002:ab0:3496:: with SMTP id c22mr10132241uar.100.1612786049005;
 Mon, 08 Feb 2021 04:07:29 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210203072341epcas1p186cca2cf8177a31d04f1ede4bb5f1ec7@epcas1p1.samsung.com>
 <20210203072014.30272-1-cw9316.lee@samsung.com>
In-Reply-To: <20210203072014.30272-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Feb 2021 13:06:53 +0100
Message-ID: <CAPDyKFqkCJE5uQAUop6QvnPbCE7yhWBLD1sNFhhP+8SnNmRwGw@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: Remove unused define
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 3 Feb 2021 at 08:23, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> MMC_CQE_QUEUE_FULL is not set and is only cleared.
> Therefore, define is unnecessary.
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

As a next step, we should probably convert the mq->cqe_busy member
into a bool rather than the unsigned int.

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 2 --
>  drivers/mmc/core/queue.h | 1 -
>  2 files changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 002426e3cf76..9f37a8b909e8 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -33,8 +33,6 @@ void mmc_cqe_check_busy(struct mmc_queue *mq)
>  {
>         if ((mq->cqe_busy & MMC_CQE_DCMD_BUSY) && !mmc_cqe_dcmd_busy(mq))
>                 mq->cqe_busy &= ~MMC_CQE_DCMD_BUSY;
> -
> -       mq->cqe_busy &= ~MMC_CQE_QUEUE_FULL;
>  }
>
>  static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index fd11491ced9f..57c59b6cb1b9 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -81,7 +81,6 @@ struct mmc_queue {
>         int                     in_flight[MMC_ISSUE_MAX];
>         unsigned int            cqe_busy;
>  #define MMC_CQE_DCMD_BUSY      BIT(0)
> -#define MMC_CQE_QUEUE_FULL     BIT(1)
>         bool                    busy;
>         bool                    use_cqe;
>         bool                    recovery_needed;
> --
> 2.29.0
>
