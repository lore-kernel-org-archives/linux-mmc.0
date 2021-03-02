Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9515BC4332D
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBC061606
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbhCCBmv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhCBKj6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:39:58 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A40C061794
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:39:18 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id i27so1993864vkp.9
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WF09PQ21WPf2dOn93uEnZ+9gNN1Yr1nYVt54j/3LMVA=;
        b=sNsG+EXeYlvQRBmN49oVUL3WhpRz0zSEl+Gg/ricE1AfvEhjkyBoTN+qkr6FMdevP6
         VJlGR3oSqZEAggQNomng3pkOsJxnYgtENg2rWX+wPDDVVN5M0hlekGThgke3ddy4P+pJ
         nrffJFvIRjj+jXh2VpXIe38NZ4IMi6ffpy1EsOsQiIyF3mRKTETyA/TQa2BZMnJg302g
         OuyTjSnpGevB0/rBCz+uZSC0N9FHCKF6x9SYuzbppjGGR+ySSzxiuFlufZLxoMgpae+H
         zhg6lY6feqnh4JPZKg+Zex8t6/Xm94U/pOokxoacsOH3riqF0IlvGO0GI/FJLXu15PBC
         Pt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WF09PQ21WPf2dOn93uEnZ+9gNN1Yr1nYVt54j/3LMVA=;
        b=E3A1N68Tl73Amf/XxPPNCQIawWj0Yd8TLfBJi50KbcLFEKQA+kzZyNWSmMmwLXl59a
         WlS5jj629IMck9i/LwCeth5FaDoXfS1Ub91VMu+FchpGTRq7ZSE4WOMp9YtoOlFhcFWJ
         E4VUC1IofDIyaC02Ia9LqAWgKl1bX+0fhBRy+zxgizus3nTxdA/CnEg3lIs7j74der/n
         T9SGji/WCPCZwZ2kanXHkAwh1VcO6MbFBbVT1D+qsjEqsmloYyNUQqUU5qgYSsNjoGcX
         B5yLRGGpnwAla+ZTrH6qsRA90uzjCl3cMk0ea6GckTWCUgjBxzoV36FKdOFmc0R/J0cX
         oHTg==
X-Gm-Message-State: AOAM530aExyZWY1n3712Us9HQxnD1eJQi4iZCF1TrpJtfYGPCejq1Wto
        KpPvUB8rKgE9liiAmHFF5XBXcemNGnkXjxEN0BEi+g==
X-Google-Smtp-Source: ABdhPJxVkINy7HOK1m5ma1Zk+SdXXGCfrtrNZlF55NOTcuSX03rgAIRm7nT6iYaMxQPEbcjn0rtBkFbWIxkR/cJn82U=
X-Received: by 2002:a1f:b408:: with SMTP id d8mr1436895vkf.8.1614681557530;
 Tue, 02 Mar 2021 02:39:17 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4@epcas1p3.samsung.com>
 <20210210045936.7809-1-dh0421.hwang@samsung.com>
In-Reply-To: <20210210045936.7809-1-dh0421.hwang@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:38:40 +0100
Message-ID: <CAPDyKFpQyoNELdh3FrFF++HXKjH_Tn9oaY=PzUXHcE8o=KK-hg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add a power cycle when CMD11 fails
To:     DooHyun Hwang <dh0421.hwang@samsung.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Satya Tangirala <satyat@google.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        junwoo80.lee@samsung.com, jangsub.yi@samsung.com,
        sh043.lee@samsung.com, Chanwoo Lee <cw9316.lee@samsung.com>,
        sh8267.baek@samsung.com, wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 Feb 2021 at 06:12, DooHyun Hwang <dh0421.hwang@samsung.com> wrote:
>
> A power cycle is required if CMD11 fails.
> CMD11 failure should be handled as no response.
>
> If there is a timeout error that means no response to the CMD11,
> do not send the CMD11 again and the power cycle is required.
> Any other errors for CMD11 are the same because CMD11 failed.
>
> On some bad SD Card, CMD11 may fail but the card may have already
> invoked the voltage switch sequence.
> In this case, it is necessary to retry without voltage switching
> after power cycle.
>
> Signed-off-by: DooHyun Hwang <dh0421.hwang@samsung.com>

Applied for next, thanks!

I took the liberty of updating the commit message a bit, to try to
clarify things. Moreover, I have tagged this for stable kernels.

BTW, did you try to force the error to -EAGAIN, to keep retrying for a
couple of times? If so, did it end up with the same kind of errors?

> ---
>  drivers/mmc/core/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 1136b859ddd8..a6674df2a7bb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1207,7 +1207,7 @@ int mmc_set_uhs_voltage(struct mmc_host *host, u32 ocr)
>
>         err = mmc_wait_for_cmd(host, &cmd, 0);
>         if (err)
> -               return err;
> +               goto power_cycle;
>
>         if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
>                 return -EIO;
> --
> 2.29.0
>

Kind regards
Uffe
