Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BFDC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC261211
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhIWSwQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbhIWSwP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 14:52:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4713C061574
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u18so28788211lfd.12
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7vHKwPnC7hEtXrd03mle93ZP4aba1/3B4SjvXJlTvA=;
        b=SXOiDUOdXGtEgmwNQYs3HY+HWg7YotuRhmoNRze1L/8yzmVJ4HR2hLbn1a86kBqmJs
         EegYy/rd/rqDVbFcwMIRrFf7kHDZ6d+zsWCyJnoqP5X/Wjgkvap0w8lQ2XPuo6bqpB8c
         ZwQPuqo7wPPWrJzNyT4smKYH260KQVwHNsMdRNF3QCnlNe9JeeABLfgqdzU7O/3h/KdY
         XbQV/pRKIInLXM5p6NLScoz0kzLQZpgLH6UJ+6D1NrFdNVPNMTB5ujaDcmEmSaFfNYWw
         NODxcAGCGCovyzf0CPf6I+HAK9hXiupU0TzJ3f9t5vEfOdI/kQJGG4uKS7xlCetslo8M
         I7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7vHKwPnC7hEtXrd03mle93ZP4aba1/3B4SjvXJlTvA=;
        b=2TWxuSXYuJqvCTISf1GpQplAWHfazlFrS3mBAVBvTvTPGV1zRF2/xHDWr5oNUKZuzz
         bZmGSRDD77G5eK/YuXtna9Ge7F55azYIMjXTIAEPSRYxu9c/ac9KQYUXg44ULcqbFlcJ
         j1GtP8M+jGbbasZGCtdrAT/djFkkm1yS4ynKLsXPt5jIl4tSyh/j2H4OXYmuTUpGi7SE
         7UWsRosLzHVWcDw8tlcRbt6r8eabpIqyP9fs4BZD0BXBQcS4unxTADhiBCNROEM6zmf5
         dvu6qAIV6CAm88GtbtGlZcb39wbfAks6Ar4lWRdZ49/yD0Rq+b9if3iPsU4yK7dNKZTm
         +eMw==
X-Gm-Message-State: AOAM530G1n5wsKA748c84i7vs52eC33rerUXZ6lFzey9Rpe6B6pNiknk
        bQ0K8kOwQSscLTfhAo7f+QtKKRMK4fNN5qu2e1vYWyLBBaU=
X-Google-Smtp-Source: ABdhPJzhaxz4DazQpYUhqCWQrdiiBV98vStzxP6Hw/Bb9OPFYQQVjJky9gfAdUdCUhgs1b1k2gQfbPLCj5AaPZWj+bw=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr5535583lfv.358.1632423041943;
 Thu, 23 Sep 2021 11:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210921143359.1738149-1-linus.walleij@linaro.org>
In-Reply-To: <20210921143359.1738149-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:50:04 +0200
Message-ID: <CAPDyKFrDMeuAWjWSBF5s1-cyO_faRMWdcs=YYmnYNaOK1L3xZw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add small comment about reset thread
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Ludovic Barre <ludovic.barre@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Sept 2021 at 16:36, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Put a small comment before assigning IRQ_WAKE_THREAD
> telling us what is going on.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 3765e2f4ad98..c9cacd4d5b22 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1394,6 +1394,10 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>         } else if (host->variant->busy_timeout && busy_resp &&
>                    status & MCI_DATATIMEOUT) {
>                 cmd->error = -ETIMEDOUT;
> +               /*
> +                * This will wake up mmci_irq_thread() which will issue
> +                * a hardware reset of the MMCI block.
> +                */
>                 host->irq_action = IRQ_WAKE_THREAD;
>         } else {
>                 cmd->resp[0] = readl(base + MMCIRESPONSE0);
> --
> 2.31.1
>
