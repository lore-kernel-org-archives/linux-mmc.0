Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8239CC388F7
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F220781
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5vD8gBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgKJMCJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJMCJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 07:02:09 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE09C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:02:09 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id x13so3698869uar.4
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BB248gLnwYNHBpDFiFxGTp4bjWlQGrGUEYTIiTTM4n0=;
        b=P5vD8gBV0YaO/DixjeGeQVJhk1/L7eMwxuCIsiAvig3UdVPXqkCaRmCRSmBw3uAX4Y
         TiX3eM0a9V+RhBtilqf4Wnnczw9k0ycRSuJ0PT/17V3tdFASRmRvb5mjnXyFGt2GMRcU
         3wUcbEjPPtwaGdjoUhagSJVCHsFk7XytzggLfOK7sTDIcg3IWZ7ZSEYNfzcWieSvVwEo
         nu84mT+3rq99HwIQ9n0tQQcZLP0ePsizkZH8OIWg/0Gtq3EvoiWXf4HnHsAY6VFtIOWJ
         Ymn1R6kefWONTGLJ9MlGjDMCpMwRzzDkykIsxs1RUwq4NvMCCcU0tVZFNotf3fUpGC1r
         /8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BB248gLnwYNHBpDFiFxGTp4bjWlQGrGUEYTIiTTM4n0=;
        b=fgDQxiEAc9DKs1TdnZ3yZrMAWHrJxWNJRSznssKBuyTGrKzIWdAg4p2/Crg/ydnGa9
         txMQjsXzfXB24PYV/8/zZb1jQxLyrE9s1PfYQqQmG3hy8AB+kXKtD2F9iK7ZsG3lhzsK
         vMm2V0fYhOJwEuU/l7O0+O6r0+Zssgn6IKENjcamuEio1vGddOKf2d9Rqoha5RKivJdP
         pe1Gsrh8JGLWGjMUiN06t9vAdzB2ZKRwWCyEKR3z6TM+MLhHjXKibp1k+XugLHoYxfF4
         aH/HbVghn2hzrskXrAjKf8i2u5PmhFL2/cBH9m1SPu1X7LS+hg35a2wn7bOOVasqgiKI
         1isg==
X-Gm-Message-State: AOAM532+Hm3xRVVRL0PK6NlrEyAWuGu2rza1Son07eK49QfUzTKp01BD
        /jcbTtEawk2ltIcgMBMsyz/W6vnoF7KFHfFRZZN0JzNmo2VwsA==
X-Google-Smtp-Source: ABdhPJzS1RDqd2sK8B0WYlaSuB2m+KiuGtTjxpj3Qj9cDbq9dYIxpvtRHhvrHm/h3chUT7kfABepWkmNavpPP5hK3b4=
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr9486913uaj.104.1605009728503;
 Tue, 10 Nov 2020 04:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20201106134807.9076-1-adrian.hunter@intel.com>
In-Reply-To: <20201106134807.9076-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 13:01:31 +0100
Message-ID: <CAPDyKFrAZgj04=fToHBo3g+XQH6ABvOTp7=V9r8LLFiKFmNt8A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Prefer SDR25 timing for High Speed mode
 for BYT-based Intel controllers
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Nov 2020 at 14:48, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> A UHS setting of SDR25 can give better results for High Speed mode.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v5.4+
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 23da7f7fe093..9552708846ca 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -665,6 +665,15 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>         }
>  }
>
> +static void sdhci_intel_set_uhs_signaling(struct sdhci_host *host,
> +                                         unsigned int timing)
> +{
> +       /* Set UHS timing to SDR25 for High Speed mode */
> +       if (timing == MMC_TIMING_MMC_HS || timing == MMC_TIMING_SD_HS)
> +               timing = MMC_TIMING_UHS_SDR25;

I don't quite get this. If the mmc core requests high speed mode, you
override this with timing settings corresponding to UHS_SDR25, right?

> +       sdhci_set_uhs_signaling(host, timing);
> +}
> +
>  #define INTEL_HS400_ES_REG 0x78
>  #define INTEL_HS400_ES_BIT BIT(0)
>
> @@ -721,7 +730,7 @@ static const struct sdhci_ops sdhci_intel_byt_ops = {
>         .enable_dma             = sdhci_pci_enable_dma,
>         .set_bus_width          = sdhci_set_bus_width,
>         .reset                  = sdhci_reset,
> -       .set_uhs_signaling      = sdhci_set_uhs_signaling,
> +       .set_uhs_signaling      = sdhci_intel_set_uhs_signaling,
>         .hw_reset               = sdhci_pci_hw_reset,
>  };
>
> @@ -731,7 +740,7 @@ static const struct sdhci_ops sdhci_intel_glk_ops = {
>         .enable_dma             = sdhci_pci_enable_dma,
>         .set_bus_width          = sdhci_set_bus_width,
>         .reset                  = sdhci_cqhci_reset,
> -       .set_uhs_signaling      = sdhci_set_uhs_signaling,
> +       .set_uhs_signaling      = sdhci_intel_set_uhs_signaling,
>         .hw_reset               = sdhci_pci_hw_reset,
>         .irq                    = sdhci_cqhci_irq,
>  };
> --
> 2.17.1
>

Kind regards
Uffe
