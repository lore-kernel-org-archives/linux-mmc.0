Return-Path: <SRS0=Afy4=DF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41278C2D0A8
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032712073A
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xb4qmE+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgI1Keo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgI1Ken (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 06:34:43 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AFFC061755
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:43 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e23so453992vsk.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJ51wOq3NNuRGHW/HzevqRgjJxD2w7qQkV91Bjp5Nz4=;
        b=xb4qmE+g/pCVILBD5P1m0t8IVE14mqFd43QMR8644S34N9EMlVs/OrE0/p90OvRmg0
         BVyJZFqeLa/ZZhQgymlBmhXt5X6qWofl/FyYZ6FMQ6UN/EYvnYPnA1fY/u4Y1wpEWxcd
         ybSm2iKg9VzvWbPahvHMdvGf5vw3jrlEav1tEe7KYXdHEBxVbDFy+hEIRUcJEQsQ6/Ki
         w5NLz4aQGlo1s/NCnPxRzPlB9vzPw/NRGyl+tVZpfCW6za78u6dHJY7hCudnU1OmIby9
         yPYthyBhoI7vumgF2YLR0H65eL061BsECjccxgOScXR3xyAe7yxrtwD/Y6kgU8j2v+/g
         eOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJ51wOq3NNuRGHW/HzevqRgjJxD2w7qQkV91Bjp5Nz4=;
        b=LAMyp4hiMInkdk8nlrzjifb2aaEKpAO1MCNscZruoGNFMhU0Q5CPr3DQqrY2iE+N7J
         v4XH+G7AN8hWRi9/4zX0poKkmlqOSvAzoyq+zepdhy8/hLHSXcOvrlWjVwuZjaBKJjDz
         ABro5NWRDdSbJ/h35Ji6J9R6DUeaUf94QXZsfjZD/o7ZQEKsA8ieAo1zgHcHpQgmx26F
         EvzooPwt94i5N+OFPmIs5PYrbl1ttwTUrYaZjBWil/RBirtK/D7MpvyCe2RUb9iEENib
         Pne4XRQM+B0+/1vM/Pd/NO98oSK2F5e8+4dK7JEST/E4Xs8sr/4JIXofRP1E4jk7MzGX
         jWDw==
X-Gm-Message-State: AOAM531fQTQYxOnC8dPI2t8H+cqj2xvuAHTjBWZhL7mDLr9YJi9kpr5B
        Pm6ygb/z9RKCK/YpXzXUZKVZnEbuoPEnv97OUEik1Q==
X-Google-Smtp-Source: ABdhPJynhvOvVVIeiPlVhosFz0t5/+ZzI0TAwVH+ZLT5F1inRZ7fMgMOu9aYdq6mXC4eAobtCixHkeu9o9iTuALD7PY=
X-Received: by 2002:a67:2e54:: with SMTP id u81mr4828870vsu.55.1601289282947;
 Mon, 28 Sep 2020 03:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200927082304.9232-1-yangbo.lu@nxp.com>
In-Reply-To: <20200927082304.9232-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Sep 2020 12:34:06 +0200
Message-ID: <CAPDyKFo9vnrrJ2KdyCkrrMchYKiR1t0_vkj_BRK5OVTjvRAdmg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: fix reference clock source selection
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 27 Sep 2020 at 10:31, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> The bit ESDHC_PERIPHERAL_CLK_SEL to select using peripheral clock
> or platform clock is not able to be reset by SDHCI_RESET_ALL.
> So driver needs to initialize it as 1 or 0 once, to override the
> different value which may be configured in bootloader.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 3a3340c..0b45eff 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1360,13 +1360,19 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>                 clk_put(clk);
>         }
>
> -       if (esdhc->peripheral_clock) {
> -               esdhc_clock_enable(host, false);
> -               val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> +       esdhc_clock_enable(host, false);
> +       val = sdhci_readl(host, ESDHC_DMA_SYSCTL);
> +       /*
> +        * This bit is not able to be reset by SDHCI_RESET_ALL. Need to
> +        * initialize it as 1 or 0 once, to override the different value
> +        * which may be configured in bootloader.
> +        */
> +       if (esdhc->peripheral_clock)
>                 val |= ESDHC_PERIPHERAL_CLK_SEL;
> -               sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
> -               esdhc_clock_enable(host, true);
> -       }
> +       else
> +               val &= ~ESDHC_PERIPHERAL_CLK_SEL;
> +       sdhci_writel(host, val, ESDHC_DMA_SYSCTL);
> +       esdhc_clock_enable(host, true);
>  }
>
>  static int esdhc_hs400_prepare_ddr(struct mmc_host *mmc)
> --
> 2.7.4
>
