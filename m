Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE7C433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Apr 2022 16:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiDFQ4P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiDFQy6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2022 12:54:58 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F3515A14
        for <linux-mmc@vger.kernel.org>; Wed,  6 Apr 2022 07:56:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p15so4537765lfk.8
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2022 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1g4DIkgIQ8dCKus0HaE4qTWfdDWgb2jBMJ+3Wh0iC4=;
        b=ai3+GSmjRbGF3qX+jyjJvnLqxjt4gFC7fSZ41ZLeBTuYTD5IiIWdA5Yp6wZh7PRTsJ
         F02VnQ1Fr/u5NQ2UZFAVhO37mvqYYa7NzIR1T7X7r2X5sM1szFgoHv7Jg1bYi6z2eTqs
         dXLW7mTzzAfZUZa78P7GPqJw39SCCyVk0efcxB8csiWfYtBEngmbpI+UBD/yxT8k7LUo
         bWaH4b0zeh2Tgb1aSmv/2lzWB2240zfGjEZN7uR62eO6hrFW0Pab/4mqkEYPZZE0C9fs
         so8yqj3MV/twVjjg3oIBfewV2GI6fIerbHkzR3sQiA+zjyCuPqD5zdL1+u8hj8zd7oXO
         gppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1g4DIkgIQ8dCKus0HaE4qTWfdDWgb2jBMJ+3Wh0iC4=;
        b=gf+VldHhuGaTgXFbmz9v+dwjPSkABklkbm3a3ZZeW4yiK2JergBWcDqTXI+xlI2VF/
         XLtau/3tvxWQ5TUTFWVm/NDJo5vt/bFSGIqwjd97+Qi7kxBbMRRh2G4za+yDQ2x9I5OF
         d3WDVy5KZAX8wUnQVVjbXx3jxPjiNY4E/TJ0+573K1L920I0K0YwPMbLY0FXRuYEwsCM
         JntW/1RVCDtIRbT3uRfthwIHon5CsudO9die8eo6roeEszG/J9USeqB+d1wbi8q9FDlJ
         rhx7bZYq9Aa4vZbpchDchceoALLW9kkHisvbgvRlkwpqpH0B/utxF5TKTPsheE7F8GYV
         0c9A==
X-Gm-Message-State: AOAM530wgU3YLzPqiPx7ovIf3w8nMwnaAcB3pTliiJ0iJONPCYB7apx2
        tn783VMRTIEevyRSSTnaWXAiyjLGnbPuTVFf7qV9f3sEDRQ=
X-Google-Smtp-Source: ABdhPJxJM+g1NeKV/O8JA8d9wrO4M5t6y7/Th6Hn206F2El1Hben5kWcjFYFPIdyoddCKLZSk1cGPFoqzT66ows9U1c=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr6568533lfr.233.1649256981107; Wed, 06
 Apr 2022 07:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <eea3b0bd-6091-f005-7189-b5b7868abdb6@omp.ru>
In-Reply-To: <eea3b0bd-6091-f005-7189-b5b7868abdb6@omp.ru>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 6 Apr 2022 16:55:44 +0200
Message-ID: <CAPDyKFrzSjOQQO4QYV9PmgBGH46BVQzWGEEtSd5-SY8Nr7myxw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: block: fix sloppy typing in mmc_blk_ioctl_multi_cmd()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 30 Mar 2022 at 23:09, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> Despite mmc_ioc_multi_cmd::num_of_cmds is a 64-bit field, its maximum
> value is limited to MMC_IOC_MAX_CMDS (only 255); using a 64-bit local
> variable to hold a copy of that field leads to gcc generating ineffective
> loop code: despite the source code using an *int* variable for the loop
> counters,  the 32-bit object code uses 64-bit unsigned counters.  Also,
> gcc has to drop the most significant word of that 64-bit variable when
> calling kcalloc() and assigning to mmc_queue_req::ioc_count anyway.
> Using the *unsigned int* variable instead results in a better code.
>
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.
>
>  drivers/mmc/core/block.c |   16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> Index: mmc/drivers/mmc/core/block.c
> ===================================================================
> --- mmc.orig/drivers/mmc/core/block.c
> +++ mmc/drivers/mmc/core/block.c
> @@ -676,8 +676,9 @@ static int mmc_blk_ioctl_multi_cmd(struc
>         struct mmc_ioc_cmd __user *cmds = user->cmds;
>         struct mmc_card *card;
>         struct mmc_queue *mq;
> -       int i, err = 0, ioc_err = 0;
> +       int err = 0, ioc_err = 0;
>         __u64 num_of_cmds;
> +       unsigned int i, n;
>         struct request *req;
>
>         if (copy_from_user(&num_of_cmds, &user->num_of_cmds,
> @@ -690,15 +691,16 @@ static int mmc_blk_ioctl_multi_cmd(struc
>         if (num_of_cmds > MMC_IOC_MAX_CMDS)
>                 return -EINVAL;
>
> -       idata = kcalloc(num_of_cmds, sizeof(*idata), GFP_KERNEL);
> +       n = num_of_cmds;
> +       idata = kcalloc(n, sizeof(*idata), GFP_KERNEL);
>         if (!idata)
>                 return -ENOMEM;
>
> -       for (i = 0; i < num_of_cmds; i++) {
> +       for (i = 0; i < n; i++) {
>                 idata[i] = mmc_blk_ioctl_copy_from_user(&cmds[i]);
>                 if (IS_ERR(idata[i])) {
>                         err = PTR_ERR(idata[i]);
> -                       num_of_cmds = i;
> +                       n = i;
>                         goto cmd_err;
>                 }
>                 /* This will be NULL on non-RPMB ioctl():s */
> @@ -725,18 +727,18 @@ static int mmc_blk_ioctl_multi_cmd(struc
>         req_to_mmc_queue_req(req)->drv_op =
>                 rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
>         req_to_mmc_queue_req(req)->drv_op_data = idata;
> -       req_to_mmc_queue_req(req)->ioc_count = num_of_cmds;
> +       req_to_mmc_queue_req(req)->ioc_count = n;
>         blk_execute_rq(req, false);
>         ioc_err = req_to_mmc_queue_req(req)->drv_op_result;
>
>         /* copy to user if data and response */
> -       for (i = 0; i < num_of_cmds && !err; i++)
> +       for (i = 0; i < n && !err; i++)
>                 err = mmc_blk_ioctl_copy_to_user(&cmds[i], idata[i]);
>
>         blk_mq_free_request(req);
>
>  cmd_err:
> -       for (i = 0; i < num_of_cmds; i++) {
> +       for (i = 0; i < n; i++) {
>                 kfree(idata[i]->buf);
>                 kfree(idata[i]);
>         }
