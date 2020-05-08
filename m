Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C74C47247
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631A4208DB
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 08:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MFDfKpxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEHIMk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgEHIMj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 04:12:39 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68563C05BD0B
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 01:12:38 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 47so345681uaj.12
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZWwTq3jHgl0vF+73+HcJrJHO5r6wPiuEt3hWYFmGy1s=;
        b=MFDfKpxPwGsj8xTnETNOiIP+xhjHs/bQFbn69qKF1+HzOOwBZFODhnJN2quiwfekXx
         Kys+dq0GQgoVpit/riusVb0+s/xZ85m5lorNpLqOTdA1PEm/OO0liOG2TUWKIvDWXTry
         V8jXdk7ZZYqJy9G6BaSzPi9rzCcnz2cxUoQDKwLTFL2iIhWIrM1cI3v0yUE5W6pGLwOW
         HZruxyg48j0ztKttfSHufyK/4KcfPsiRFNmOkYU7oK+ui/HkQKZkN0x/zTPQ6HDuFk7+
         +WyMfSYgt4y85fBKqLJ35BFKrNbu3ho2tJcPyeXb/DD0G/Rb7DdG1b09SICIJ/rb13rB
         h7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZWwTq3jHgl0vF+73+HcJrJHO5r6wPiuEt3hWYFmGy1s=;
        b=BEvqlWkoIPxhivcv2D2Iq+mdqXcA/EEDyI3ZRaRnYQAA945ABLtNYkSJS8Efd64iwF
         +3KnGInb0TLjiOUCelyIh1vTSXkhvjCdPk9eljpkXLT2wLiAyJFb9SfWiOxAOGRNcmqJ
         1Ww3o7blAXBRw4cGA2cU/4ogHoNzFQ2/2NXl2O33076nMs7QobgYlD/f+39ohWN2ufnb
         2Sc+zfUrY9IX+BvIi3175t64Rxw8zHu+X0JcigZw9HlOKVogMW7afyIgQ2u8cU+QYO/N
         G9Xn7P2TYn2ZQwe81GSn0Nfj3QuGD0KGr3FSjbLCEhzD/1sioaFwgBU9etB5EErHyXXC
         pqzA==
X-Gm-Message-State: AGi0Pua9UesIH5KH4syOplJcYlfKNG0XVbvMo/Oh1bvDzDo+SKDYMB81
        zo+1lT/Sc0dqGg/Cr3wHDAJO5S6Jrz/ZWJmrM9bxkw==
X-Google-Smtp-Source: APiQypK1UlkumqiTdJM/8YlLN6wYa3E2QGBvtJ2jz2DQhm09vLS24dPjTwAN95MP173PKwYSE1aF5bp/sM3ZgZd+E8w=
X-Received: by 2002:ab0:5ca:: with SMTP id e68mr886565uae.19.1588925557511;
 Fri, 08 May 2020 01:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <1588775643-18037-1-git-send-email-vbadigan@codeaurora.org> <1588775643-18037-2-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1588775643-18037-2-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 10:12:01 +0200
Message-ID: <CAPDyKFpon+ojJgj-CZ5rSiPR=EOA-3DBfN=28zkVjNXUVytZzA@mail.gmail.com>
Subject: Re: [PATCH V1 1/2] mmc: core: Check request type before completing
 the request
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 May 2020 at 16:34, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> In the request completion path with CQE, request type is being checked
> after the request is getting completed. This is resulting in returning
> the wrong request type and leading to the IO hang issue.
>
> ASYNC request type is getting returned for DCMD type requests.
> Because of this mismatch, mq->cqe_busy flag is never getting cleared
> and the driver is not invoking blk_mq_hw_run_queue. So requests are not
> getting dispatched to the LLD from the block layer.
>
> All these eventually leading to IO hang issues.
> So, get the request type before completing the request.
>
> Cc: <stable@vger.kernel.org> # v4.19+
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for fixes, and by updating the tags that were provided by
Adrian, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 8499b56..c5367e2 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1370,6 +1370,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>         struct mmc_request *mrq = &mqrq->brq.mrq;
>         struct request_queue *q = req->q;
>         struct mmc_host *host = mq->card->host;
> +       enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
>         unsigned long flags;
>         bool put_card;
>         int err;
> @@ -1399,7 +1400,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>
>         spin_lock_irqsave(&mq->lock, flags);
>
> -       mq->in_flight[mmc_issue_type(mq, req)] -= 1;
> +       mq->in_flight[issue_type] -= 1;
>
>         put_card = (mmc_tot_in_flight(mq) == 0);
>
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
