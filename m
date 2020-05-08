Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8725C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BEBB207DD
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bt2hFTGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgEHIMp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 04:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgEHIMo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 04:12:44 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E5C05BD09
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 01:12:44 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id c24so345116uap.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qSRHUifjbk+HUdGENBz7hCntYdpN9AnCceyczmR5K8=;
        b=bt2hFTGCydhLSFbkAe8V54kz5sIGzjphQmKjLWusmdrLinuBd/8MNgqUGb3Vcvyfz4
         5WOZZkzGVPztQScyPU4rjZYXRttK+2KB2vksoVsqbrTMEpvDkng2aUcmRdHrY1ckrhfd
         18tHqkEVFkXmU6FCT6zwz0WSiYZibxyL3TCzt8NDe4m4ub1tG28FwJ97Q8hm/N2yGbvc
         19amIqAYR6zjuPLLmi+xx8OtJDQErjZARzor78PKBD9d6sdve/6pYrrTmgAi94mr5oRr
         cr39P91QlCHlnRtJ0z4xHZP1yOOy3J40QslF60sEcdo1WD3f36NVZWUZ/73sT/9BrGrh
         p3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qSRHUifjbk+HUdGENBz7hCntYdpN9AnCceyczmR5K8=;
        b=Zb5cxbXI/yaEE7JkVnICUvpzls/x/o+dQy4h2QSdY8udHJXxWTDHOcK3+TL1/rp4Ez
         1N6FInZByywOhX8cYH1D9u8ZFle86rS9LeKRb0bX0R5O/vrSg7YSM8XZXEtqLpAQRUh9
         z6gQwdSYsnNaWlgycPUIwPAvLmPtYsTmxw9y8wLCHxNTZ/nYKp7pTV0lMm8XCsCpCvVs
         zNFEl5nPi0wxH9BRLyPlJZpyM4Eh0sZFZoyvjOpWZidmJlidR2gUJDq/xXnZURRLAEOU
         oI5YYhSL1+22RP0zURnCc7Dw4F2o1B78HN5ZR8ynrq8dq1IQeRnderx69C8ldqjg6Iza
         ccBQ==
X-Gm-Message-State: AGi0PuaXrcCETnGByPGOXYyfsVCUDi8fMk86ryf6LcbG/idF8zHC4xf8
        /fYy+ZU+yU89PuJbpZdVcvIER7pzR7BqJEKr4y/tGA==
X-Google-Smtp-Source: APiQypKnxqPoiIGzGmHjHQ5icfU4dREH6aBXxiWoN65/pfxFA66QolnDH/zeV4F47VJdX6STgPe/li/OREXUv5IJfW8=
X-Received: by 2002:a9f:26e2:: with SMTP id 89mr950098uay.104.1588925563578;
 Fri, 08 May 2020 01:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <1588775643-18037-3-git-send-email-vbadigan@codeaurora.org> <1588868135-31783-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1588868135-31783-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 10:12:07 +0200
Message-ID: <CAPDyKFr=JEbRace-K1grWbKgn2jBiM5VXbknOj2DjeZDy4e8bQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: Fix recursive locking issue in CQE recovery path
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andreas Koop <andreas.koop@zf.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 7 May 2020 at 18:15, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> From: Sarthak Garg <sartgarg@codeaurora.org>
>
> Consider the following stack trace
>
> -001|raw_spin_lock_irqsave
> -002|mmc_blk_cqe_complete_rq
> -003|__blk_mq_complete_request(inline)
> -003|blk_mq_complete_request(rq)
> -004|mmc_cqe_timed_out(inline)
> -004|mmc_mq_timed_out
>
> mmc_mq_timed_out acquires the queue_lock for the first
> time. The mmc_blk_cqe_complete_rq function also tries to acquire
> the same queue lock resulting in recursive locking where the task
> is spinning for the same lock which it has already acquired leading
> to watchdog bark.
>
> Fix this issue with the lock only for the required critical section.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 1e8e55b67030 ("mmc: block: Add CQE support")
> Suggested-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 25bee3d..b5fd3bc 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -107,7 +107,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>         case MMC_ISSUE_DCMD:
>                 if (host->cqe_ops->cqe_timeout(host, mrq, &recovery_needed)) {
>                         if (recovery_needed)
> -                               __mmc_cqe_recovery_notifier(mq);
> +                               mmc_cqe_recovery_notifier(mrq);
>                         return BLK_EH_RESET_TIMER;
>                 }
>                 /* No timeout (XXX: huh? comment doesn't make much sense) */
> @@ -127,18 +127,13 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
>         struct mmc_card *card = mq->card;
>         struct mmc_host *host = card->host;
>         unsigned long flags;
> -       int ret;
> +       bool ignore_tout;
>
>         spin_lock_irqsave(&mq->lock, flags);
> -
> -       if (mq->recovery_needed || !mq->use_cqe || host->hsq_enabled)
> -               ret = BLK_EH_RESET_TIMER;
> -       else
> -               ret = mmc_cqe_timed_out(req);
> -
> +       ignore_tout = mq->recovery_needed || !mq->use_cqe || host->hsq_enabled;
>         spin_unlock_irqrestore(&mq->lock, flags);
>
> -       return ret;
> +       return ignore_tout ? BLK_EH_RESET_TIMER : mmc_cqe_timed_out(req);
>  }
>
>  static void mmc_mq_recovery_handler(struct work_struct *work)
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
