Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F9CC04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175026108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhEXON2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbhEXONO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:13:14 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E08C06138D
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so40837129lfc.9
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m9TQta/QWmtE8jsxsWMQFJ3ws/ti47t8fXgwLG9HD/I=;
        b=yaSVC5r2H4+Jb6XAZ22WZsyVh4uCJhRTrZ7FoI6hDuzWt7hyzIBOUwehOgCl+U9FK4
         VkT3o7ew3hxO5p6dEGNnjHCnzwlKkLYLVTgZ1BCvrgdWy+/zc7Q4nYPWHZ76qOR1gH5A
         RA3sK1LhHcXkPDeYih+aWQaleJq+kbE0uxVYburpXmboR216E8C/lIJTNIEbJKAB0nD8
         QXGEYzJcU+4AnI8nGq2pegagUjRPyR2sK81G1dCnuTXrnRA2V7cnnaafAfoAfwCiPbi1
         5UqddMcOpiKZVlOU6fv9K9VIieiNVCPK2y57EMc5CuHMOuwqW5NFoSHnmooEAnhAZCvr
         RMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9TQta/QWmtE8jsxsWMQFJ3ws/ti47t8fXgwLG9HD/I=;
        b=oc3Z6Zq78QFVp3euYz50ztkQ8PtDbd9JXxFv/j7glADiXwacDfPlclI98PsumAr/UH
         k4g6p1sFu35TpRIJmmqeMd2kVexsvfnoCNGaIk1zrKgOo0LIjlEdPPzX51UCI9wEMhf1
         iM1FjOX4JmJ8bkBAP4Pwz1UDEF62aFA4UAf4I4/+1ZV8pT2mqh95AUlYaYOQsXCek4py
         ghqtrUFfIKKX5cbRzUP0f+MT/OSrPK9G4j4U4TdFklSHUU7SZT0tUwqhXrYpiB6pTqpX
         QsAui0qPXLLxNz8JzOhz+waZ8ad/AdzIdRHi3FntLF51XGEagqjOrR73cb4efHyyJoEm
         C3NA==
X-Gm-Message-State: AOAM532DVmecynCqa4c5wkJnSNNaO9rby9CNphWN11mFE7wga8vCbNK9
        yi3FsuDfUXnLZ+TD4ajCv0agpLEgPaOGVcIL8OU1MQ==
X-Google-Smtp-Source: ABdhPJyca77dNeXLxWCBq81HpNkv55TNmbVC6ws5IelbcnzJpm29Yn+XRdC2MhiwEYc933RD4U6pMLpP1o2D+yaSPbg=
X-Received: by 2002:a05:6512:1150:: with SMTP id m16mr10577037lfg.486.1621865504561;
 Mon, 24 May 2021 07:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210523155914.5200-1-shiv14112001@gmail.com>
In-Reply-To: <20210523155914.5200-1-shiv14112001@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:11:05 +0200
Message-ID: <CAPDyKFptp7cJ1zq8nHCWoY5D+AJ8uzs2MiqnUGdT8d8eq3Rw_Q@mail.gmail.com>
Subject: Re: [PATCH] This commit fixes the Error or Warning about missing or
 incorrect SPDX license headers.
To:     Aviral Gupta <shiv14112001@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Zhan Liu <zliua@micron.com>, Avri Altman <avri.altman@wdc.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Luca Porzio <porzio@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 23 May 2021 at 18:00, Aviral Gupta <shiv14112001@gmail.com> wrote:
>
> By adding missing SPDX-License-Identifier tag line in drivers/mmc/core/block.c this issue is fixed.
>
>
> Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>

Applied for next, by amending the patch prefix, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..266d62f9dbc8 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Block driver for media (i.e., flash cards)
>   *
> --
> 2.25.1
>
