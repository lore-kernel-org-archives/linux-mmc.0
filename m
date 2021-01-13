Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C79C4332D
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06DEA233E2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbhAML0w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbhAML0w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:26:52 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97243C0617A5
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:44 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id k30so909220vsp.6
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6c0jaVgiPZUTWx3FWeCKRMV7GRdUXOup2JSIVMvzG8=;
        b=gNXTPYsFPMysLFn3dCllIUoARg68sve0A5NvDm0LecEB74K0w3aX0o3Oy8RftNHLmM
         0UHhr2JZv1DbNSXaaFzvQchVhJZ+PU7RnaDayZiD0UTU05stT6yagTaGsCprysBvazRt
         PuZFGBKck3t/OL500aa3m+GgiD84sDgRi4I9wDnmGo93HA8W01dE5Qbg8B6hDWkpCjU7
         hDBKO9XW6xxvcQdQoNjZ4T4H/fV0j0TXXOjJLPvWM7uq6CJ9SU2bnyzw1oQSrR3GyeTD
         EWIFnQGAWZIrYQRt9NCWN/sOSLoaIFhLsHba1ehQPuHjSBRLZT+pSzfdqpTEe079ZS/d
         UYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6c0jaVgiPZUTWx3FWeCKRMV7GRdUXOup2JSIVMvzG8=;
        b=Ti8s5ioGOe6W1hJkCN+Ln6z5soNFVOZnGYaYagLmv8SS8XKcvGmVdzjqzPuDuoSxGO
         4CWp907Mvc+0gVoIF2hg6eEvWUVrY45QNHYQIYVHscR6uCCpNCQtH4me12DpvEeId6+U
         Sai8BxrSiVG/NZQ0xUJ85/xW8J3mIrjIr84gHKLeQQrDuXPjWGaitVqgZ4BxU6UylNMw
         sZb0WAE72tceF5KHdzpHRRx+HCKiK9WAw2OwxITUS4tCxUpXdy6kNcgjp/1w31j5WnXw
         5PWffpfwZuVn48FNTJgUvpBEuAwR8d0x5QHJ35KImKbxfZa+/Zgo9hFpb4EYfHwLvZwD
         ptWQ==
X-Gm-Message-State: AOAM5318TJPhisMY3Vp0ECfYbBtjQmos8Bgozc4YOyVIdIK28R2/QA5X
        hQbX8a7oz4YE7MLPB0ZQOjOfGRfZoehomcRy5avq4Ed8MfKBIw==
X-Google-Smtp-Source: ABdhPJzBZUATGCHxXNENn1oOCawpmSFAUuZxF8+zv4IBBiT0lha9aGQM7yiT0C4pte1egzsVpJXEtDvM8ee8/7wmcJE=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr1456131vsg.48.1610537143857;
 Wed, 13 Jan 2021 03:25:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608714110.git.hns@goldelico.com> <415ea1cb85eedc12f0c2f70da9a1ae3885bdd091.1608714110.git.hns@goldelico.com>
In-Reply-To: <415ea1cb85eedc12f0c2f70da9a1ae3885bdd091.1608714110.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:07 +0100
Message-ID: <CAPDyKFqfUrOy7dKTHE7O4RFpJa9OsPh2XTb3c7b_ukbN55e3cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: remove unused struct component card_detect_irq
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 23 Dec 2020 at 10:05, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> I have not found any user for this struct component.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index a1f92fed2a55b7..b3c636edbb4610 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -152,7 +152,6 @@ struct jz4740_mmc_host {
>         enum jz4740_mmc_version version;
>
>         int irq;
> -       int card_detect_irq;
>
>         void __iomem *base;
>         struct resource *mem_res;
> --
> 2.26.2
>
