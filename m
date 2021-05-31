Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E4C47083
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 10:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9843D611CA
	for <linux-mmc@archiver.kernel.org>; Mon, 31 May 2021 10:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbhEaKS6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 May 2021 06:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhEaKSv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2021 06:18:51 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCD6C061574
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2021 03:17:09 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id f15so5749958vsq.12
        for <linux-mmc@vger.kernel.org>; Mon, 31 May 2021 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ru/1dgQ0vPtNshZal6qIV36byCdQdei5pfU0MIkHoyY=;
        b=UtYirWiSNztm7JRFtfUkA2Bi9y6QA/JrlPTD33m6LKXzF+ghRad8sQhprC1EQ74ooV
         NKzBTNjh2QBxUXqK7pxIrOospXfy/Z5Ly38gkQwYGb5GpiLyvsPWUIySTmKTK9eIWtNu
         mzc/KOj7FG7+DkeuimbFAWCKLusMARfo86xDAhMuytJWRrtk7ZGPUw8L5GgSwm5NeBa0
         qp1vQ3WraHWgKGIqOHf2yc6ihzr1BtwSxGd9zMWtUeXuiSPOpOPuDr5oNYX2XU1+PQwc
         TZElGXuXajebh7ZYBAckPwb6NvVgoDZEIxiOE27DcfMqF5nQ5XbdqLFqOC3GfTqkc98B
         Bq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ru/1dgQ0vPtNshZal6qIV36byCdQdei5pfU0MIkHoyY=;
        b=pHAlS7Kz/183VurboXPkjby8gs/5m7zCJKbKr2tTrgGNct0D88fV9000FVe7PaRGp+
         wzp/ICD/azCm5aB+iGAiJwrbSlnf1aNRxnd5g4z0feDIKQZm9u7DlrrOQO6OWhUI6mMV
         t1bpbWFzvRqB0fXZxRENTZx6uWgAc0ZCSw1qTfAzfltaeDovQOAh0P7e4/TrxI21BOzP
         Tkbo+RXYaRNa0zPwy64p+WSPGm30ijnguhkRjZNeu5KMP5QLNBJbCfZEUeGpPeMsY9Nx
         v0VfAhUxWl0AdAWW+UsgAa+z50wPDzJTGllGHJyRPQVEaIc4VTWiQbowugephh9RaP46
         0ImQ==
X-Gm-Message-State: AOAM532fb/5MPbF/PCBkHI0/MBy+NfEovbGa58W/n3C3r+nnoxyRTdiT
        m5hGIRYvvf/EywuBA4bgLlALEJgIVLPF8weWaP516g==
X-Google-Smtp-Source: ABdhPJx6R16G9BRCLBxjauHicDEvt2bFLGA6WeXhN9Fb5riDpV3jSLdblA8xv3Lf5XpN9Lzs0rQKeBqXfxT/JTH0kyA=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr12940416vsg.34.1622456228772;
 Mon, 31 May 2021 03:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210528112127.71738-1-andriy.shevchenko@linux.intel.com> <20210528112127.71738-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210528112127.71738-2-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 May 2021 12:16:32 +0200
Message-ID: <CAPDyKFr_0w9mK4fWE3YynP0cYZOWuzeHKeVAmrHm068VRnR3bg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: mmc_spi: Imply container_of() to be no-op
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 May 2021 at 13:21, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since we don't use structure field layout randomization
> the manual shuffling can affect some macros, in particular
> container_of() against struct of_mmc_spi, which becomes
> a no-op when pdata member is the first one in the structure.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/of_mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 9d480a05f655..3629550528b6 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -22,8 +22,8 @@
>  MODULE_LICENSE("GPL");
>
>  struct of_mmc_spi {
> -       int detect_irq;
>         struct mmc_spi_platform_data pdata;
> +       int detect_irq;
>  };
>
>  static struct of_mmc_spi *to_of_mmc_spi(struct device *dev)
> --
> 2.30.2
>
