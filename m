Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E8C54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Sep 2022 09:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiITJdd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Sep 2022 05:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiITJdX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2022 05:33:23 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2523A2B2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 02:33:22 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id j17-20020a9d7f11000000b0065a20212349so1309520otq.12
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=468b7YXZM+FVMO6sK1R+DTGQf1PKcr35VReLrGuvc6E=;
        b=wEHn1sQmjWjQK3FfM1tuda3K2u4iOSQqEYXuPOyeSuJ1RMJjvU1VKL7lNJtw3dRnME
         98Kryve80/MgEziimWnm8c03loyiCySSwSryXMQo/Bp0LfapllCnfqqZdmHG1h/SAo7L
         Ns/9tkDM1HmiP/99aBcuaeBdY6UcvLSW5qtUlzEvvBW3N9VRN64XrgfR+y7cTrI6JphM
         OEAPQvyC7dIxW/qmXFUyjG51aF2vtDt6DncOI2CVIC2uDWPk/tL4ENtLSGQMpbZiXVSf
         woe3RKiGfsHKsCaFnQVyDT/Lj8jzBG1HYMqTPQyYkEKJO704qBrVZvaEDfm5/HKDKKf7
         417g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=468b7YXZM+FVMO6sK1R+DTGQf1PKcr35VReLrGuvc6E=;
        b=TWHAVzb+28Rg92P8BL0YClG1LS7YwCsiCdKYyne6zZNsOZ5dJGvfPuoxhSR6HkqbNH
         h2Il+gZCjDMY9SKddEcZMsHrTi1uVgsebmg0pcdexdiS/r0jaMc6es/1q3ht8WmFnp+u
         DEGUemUiEVXMyEPyTCi6BnwUJ4rwzE98odtP+2YuScU7b2Om36M80Zfc+W0FJ+a47Kih
         KA+BgNt5uX8jW3TfLm8b+cMAjEtZ5xPyvUVyzvno0wQDVNAKI6bVCm/1LBjqzlQN0+1f
         4oLie1oFVs26AxdUdwH5zo4XpqrPNg3wSC3hYxhQPn4S8VBx+1VlJq38rcC1k29qDLmN
         dZ8A==
X-Gm-Message-State: ACrzQf0s8faE18qRUSUXafkz44GnLNU+HeTDx9z+1wu3FsJGNBGTN+X+
        ByLYeCHIU56x+6053citImuCzq9LtVw/B1ZLcSfO/g==
X-Google-Smtp-Source: AMsMyM5GiNXWursCv1A3l39AwsxGdFYEuthM0g5A7tg4ZM414pddOm2Ufr1zfjoVqPaHvVaxlX/lW8t8wWhA0ZpbRjc=
X-Received: by 2002:a05:6830:3910:b0:63b:2195:31a9 with SMTP id
 br16-20020a056830391000b0063b219531a9mr9958285otb.91.1663666401439; Tue, 20
 Sep 2022 02:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220916090506.10662-1-wenchao.chen666@gmail.com>
In-Reply-To: <20220916090506.10662-1-wenchao.chen666@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Sep 2022 11:32:45 +0200
Message-ID: <CAPDyKFqNJzwizZduMj_ig=aEXAgssQM8AzbYxa_T9XEqNXeWPw@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: Fix data stomping during mmc recovery
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian

On Fri, 16 Sept 2022 at 11:05, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> From: Wenchao Chen <wenchao.chen@unisoc.com>
>
> The block device uses multiple queues to access emmc. There will be up to 3
> requests in the hsq of the host. The current code will check whether there
> is a request doing recovery before entering the queue, but it will not check
> whether there is a request when the lock is issued. The request is in recovery
> mode. If there is a request in recovery, then a read and write request is
> initiated at this time, and the conflict between the request and the recovery
> request will cause the data to be trampled.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Looks like we should consider tagging this for stable kernels too, right?

> ---
>  drivers/mmc/host/mmc_hsq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_hsq.c b/drivers/mmc/host/mmc_hsq.c
> index a5e05ed0fda3..9d35453e7371 100644
> --- a/drivers/mmc/host/mmc_hsq.c
> +++ b/drivers/mmc/host/mmc_hsq.c
> @@ -34,7 +34,7 @@ static void mmc_hsq_pump_requests(struct mmc_hsq *hsq)
>         spin_lock_irqsave(&hsq->lock, flags);
>
>         /* Make sure we are not already running a request now */
> -       if (hsq->mrq) {
> +       if (hsq->mrq || hsq->recovery_halt) {

This still looks a bit odd to me, but I may not fully understand the
code, as it's been a while since I looked at this.

In particular, I wonder why the callers of mmc_hsq_pump_requests()
need to release the spin_lock before they call
mmc_hsq_pump_requests()? Is it because we want to allow some other
code that may be waiting for the spin_lock to be released, to run too?

If that isn't the case, it seems better to let the callers of
mmc_hsq_pump_requests() to keep holding the lock - and thus we can
avoid the additional check(s). In that case, it means the
"recovery_halt" flag has already been checked, for example.

>                 spin_unlock_irqrestore(&hsq->lock, flags);
>                 return;
>         }
> --
> 2.17.1
>

Kind regards
Uffe
