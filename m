Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496F2C433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149EA60FEB
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhEKK6j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhEKK6d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:58:33 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BEFC061761
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:26 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id x17so5646016vsc.0
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEQRKJa7cSEPR3H7obV91/0E5nqv+bxRi8QEuCEiOnY=;
        b=MNxyAal8ydQkOrtj6ANTTQB9MJcc/+ZiIIuBuZlqXtJKMuRxP1XJ1AxBVCZAydYPHP
         TfIV6W1plR2LEVvg8nndLXy2MMH72QLhVKVyz7lyUu32fJZcINlsOi4FJ/l7rPxeT1UY
         pczRs0Meyf/gxCFGRrbS6cfWDbzV4bFbmQeJZ5fxboRWCYkEy0LEOfTx7x1oC+BI3fR3
         pGNRd5Xm9PFWBpz79V8o2nL0DxVwUWYR6fSVkxHNju+uVUG1BGDjvrraK80lAJoGEubA
         bhxQIPGgntK4PgEcQ6xufTJ+6pKyB4iE1Y+PRhsPzJcIdWWX1t55jgCy+Q1bTUt+y99r
         ynRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEQRKJa7cSEPR3H7obV91/0E5nqv+bxRi8QEuCEiOnY=;
        b=XAgKvnEF7p7+FJtcHU0qry7dA9KEmlsCPqlRcJJJoX0sONb543ctrlowksn0T2U5yf
         MsMZoz2quUrKi7T2i95c090P+RBrPaTlCeyTcBxTCE9iTz2OIk7CZoNlKkPBe/mt0e+D
         osH7Xvs/shv1/fWyimMDsfL4zWx0q242f+ZajmfSNxDyObLIPg8mjJKqukILegJIwPH0
         yOcWQPOUHmWqAB5IngPzaMPp+MBk+zgL8smgkl26Lfrs3mRaSVix2JLkIgDeBDfR6414
         eap064BGt483q1pAANh69gis7AOb/phlyk7kgAKYby5w5cgcNIxcK7DltiuxW0JncM36
         xmkA==
X-Gm-Message-State: AOAM531G+7dzLgvb7JP1XqqKRuZN0EtzFVMbUrarXCEuUo8dg50FRpoL
        YJOawraeUNow1KkQGP3T/0meM5qhdZH3m61UtwL36Q==
X-Google-Smtp-Source: ABdhPJy8jF96CF37y9uxnKbpf60ehHZUV00s8557//l4WAOdTfJX4+5BkiKCoH3G5uOzgCysmD446p8DJvtiKuAFhJA=
X-Received: by 2002:a67:f60e:: with SMTP id k14mr25254376vso.48.1620730646016;
 Tue, 11 May 2021 03:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210508020321.1677-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210508020321.1677-1-thunder.leizhen@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:49 +0200
Message-ID: <CAPDyKFpuPw8EKpZKW5eBb1MS2mzhZ06Jn8AvmdaS0CY8S4Av4g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: usdhi6rol0: fix error return code in usdhi6_probe()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        Chris Ball <chris@printf.net>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 8 May 2021 at 04:04, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
>
> Fixes: 75fa9ea6e3c0 ("mmc: add a driver for the Renesas usdhi6rol0 SD/SDIO host controller")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/usdhi6rol0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
> index 615f3d008af1..b9b79b1089a0 100644
> --- a/drivers/mmc/host/usdhi6rol0.c
> +++ b/drivers/mmc/host/usdhi6rol0.c
> @@ -1801,6 +1801,7 @@ static int usdhi6_probe(struct platform_device *pdev)
>
>         version = usdhi6_read(host, USDHI6_VERSION);
>         if ((version & 0xfff) != 0xa0d) {
> +               ret = -EPERM;
>                 dev_err(dev, "Version not recognized %x\n", version);
>                 goto e_clk_off;
>         }
> --
> 2.25.1
>
>
