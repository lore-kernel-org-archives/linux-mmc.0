Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C0AC04AA5
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Aug 2022 09:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiHYJxE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbiHYJwe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2022 05:52:34 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4185CABF31
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 02:49:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x10so18896921ljq.4
        for <linux-mmc@vger.kernel.org>; Thu, 25 Aug 2022 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1kMg/2p/VcNDyKRVfg3f4w41z9TXz8csd9rtLeh30yg=;
        b=JPJ4blOvYwitTMl23yXWeycie0bBgeSFYvPKyHK5c+DX/UV3eLOi7ipKWFd7gxSiID
         /niOBRbGue7lXXtpqXVz9K4MC5YZOv28slYAWFSUZHe/+GGkWekd8KCqkcWim0h9C/bH
         VOE5c2x4+8CV5xEbrPnGdWySF3I7otsX6MgXZl7BZ63oqVvmbLeqiIosca1DCN5pNoj6
         Ko6/bOQNX4P5dKOl4Ovas5sEMXZWL1hVgWCTTrYIR23AMZMivV+7ee9XUYKnsTPzRu33
         UX46wgmW2LtAoGwTB32nSmxubTRpMeEokfdKjGb9Cq04TO4zBxwqWLIoIlnujIMjjwvq
         7UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1kMg/2p/VcNDyKRVfg3f4w41z9TXz8csd9rtLeh30yg=;
        b=7aZ+ycF/5YW8p/id/VJIk62lUa2pv104zUPI1lgiG7HYVNG5XHXzuXk8JMniqdLSzA
         bG44gCCdboQbyF9Ay6h5WhatCC8OEX2K9DaqR/sI8bfQm7LLVDYV/2HtQJTgEQwnL9tC
         /IdCVFfGX13m7Ot24mnNi91VTHWPSXF3VFUAkVjAEfs34X7H+JYHjUcRpf2XNRQXsWyK
         lI0k4bYAFc+9jG3P6l6TixwU2ERqJeKR46ODq6q0Q2cyJ/nQ+FQdvGlyJ2QKvAf2Nb8+
         KA/N0fwsU7v3E7iDv0VpR+VTDFquhYUeRCx01alhgcLpL4h8g1CcSUmsQdOypxhJFhYh
         7kYA==
X-Gm-Message-State: ACgBeo193WTolNtHSj2b6Ttz5GO1wMBgTFa2tpelNKh1QEfZWQI0nm6t
        XbS3IJWWg3353EPEKzXA/p0YLSou9VKKsYk/z8OYRQ==
X-Google-Smtp-Source: AA6agR5VFuzVZBBnz6OLJeVypCiPXq+1ADkMDZL2eMmhYiYGO41+tPsO3k2IUM59LGmJN5qCZIaiCFiTYWPyb75F7o8=
X-Received: by 2002:a2e:884c:0:b0:261:ca69:6023 with SMTP id
 z12-20020a2e884c000000b00261ca696023mr788260ljj.300.1661420981618; Thu, 25
 Aug 2022 02:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220823143034.20543-1-wangjianli@cdjrlc.com>
In-Reply-To: <20220823143034.20543-1-wangjianli@cdjrlc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 25 Aug 2022 11:49:05 +0200
Message-ID: <CAPDyKFroJgv=47Q2sAn3cT4rgeu3ntk6euxJ7k-ZQOAMQpeteg@mail.gmail.com>
Subject: Re: [PATCH] mmc/host: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     jh80.chung@samsung.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Aug 2022 at 16:30, wangjianli <wangjianli@cdjrlc.com> wrote:
>
> Delete the redundant word 'the'.

Patches that correct spelling mistakes make sense to me. However, I am
no longer willing to pick one patch per spelling mistake, it's just
silly and I feel like I waste my time.

Instead, I suggest you go through all mmc host drivers and fix *all*
of the spelling mistakes in one single patch. The similar can be done
for the mmc core.

Kind regards
Uffe

>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 581614196a84..7f00d7d7e35e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1363,7 +1363,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>                  * is just about to roll over.
>                  *
>                  * We do this whole thing under spinlock and only if the
> -                * command hasn't already completed (indicating the the irq
> +                * command hasn't already completed (indicating the irq
>                  * already ran so we don't want the timeout).
>                  */
>                 spin_lock_irqsave(&host->irq_lock, irqflags);
> --
> 2.36.1
>
