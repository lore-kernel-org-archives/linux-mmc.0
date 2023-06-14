Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E4FEB64DB
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbjFNKdC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 06:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbjFNKcs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 06:32:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E012945
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 03:32:04 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9f25d6690so18231001cf.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 03:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686738723; x=1689330723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk5KTXO8tGRkVKak2dEfcHSu4PyVlCkfKJkrfYPVHyA=;
        b=XvUMgbgt3tZfZoM0Qg4P6ZznuGBCmG+3ewIJiR77hnwu+5apM6jGgR+2Cz35KEU0kh
         EXUzkR14nC90XXe9JYrEE2Q6wtyzFsp6vijbZ78JxmfLIlngyw2XFex2U1Ynwfu5MxaO
         g3RA2tPUyttReMvNN0gUQ54g070Iew+zflhUC4pCBeKpGZ+zhz2Iaheo5HhvB83fm8Mm
         ja9dTROH8FEOp/6tcOepc1mf+A0r3bn8e3EXlE7ZQK5x7KknHnL50Om/qY5yof0hcf8F
         g8E0mPB2bBujtDaSZOxDMzMRe/5Yszqpw7f4XUUuAH3shrLGRC3nRHygY0jXna5h5F8Y
         tEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686738723; x=1689330723;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk5KTXO8tGRkVKak2dEfcHSu4PyVlCkfKJkrfYPVHyA=;
        b=QcJibLLDN9B9nf/bwfIq3ZmCPi0pfjdbXPnYjf9KVQHcA8uUowklYZ6gM3CPktB+Bu
         hTFJFfonvwE2nV5a/kmntJJU1MkKSfXckh1lX2eP8vlhssSYmX/+6PBM/RF4QHYl0wbl
         1kpuYqGIUMP9Sq+ECGF3n+HQXnOlk/ET7g3+ivxvZjed5IjyqlT7LtsW/MTasDk48DCa
         VaG/bezp76U6o1B0Xt2w3amr0xoxm/fWLayP8fORZtH1VdGWZ4Wgm78FDg2AaB0Wc5rM
         syTHmliuyvoBg89U4UuTCR3mHTK3QYWaDrDx00/NoCOtyQBLDRK1Ky42+g1+ozAU1oMz
         72ew==
X-Gm-Message-State: AC+VfDwvYWMLMgA0lcNGFRz9cuoTEba3ueRueYK/tcvgqIbuwsp7m9Z9
        UhTfJ0T2/RlRMKxcsXSdFc6pL7PbMqSu25MgHDiwiA==
X-Google-Smtp-Source: ACHHUZ6WGpvvy5YTbPx2DKWT/5s0zb051L42eJ/xFYh1BZ6zGKLEOUsGaJH18B0DhavSJ889KalaPEaW4whvvpH3dXQ=
X-Received: by 2002:ac8:5ac1:0:b0:3f2:384:9292 with SMTP id
 d1-20020ac85ac1000000b003f203849292mr2153503qtd.34.1686738723505; Wed, 14 Jun
 2023 03:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230613150148.429828-1-yann.gautier@foss.st.com>
In-Reply-To: <20230613150148.429828-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 12:31:27 +0200
Message-ID: <CAPDyKFpOOm-PR5NiggT6NqiXgbz6qGQ46-y26XZNi1S2-B=VYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: set feedback clock when using delay block
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Jun 2023 at 17:02, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> The feedback clock is used only for SDR104 & HS200 modes, and when
> delay block is used (frequency is higher than 50 MHz). The tuning
> procedure is then only required for those modes. Skip the procedure
> for other modes.
> The setting of this feedback clock is done just after enabling delay
> block, and before configuring it.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 60bca78a72b19..953d1be4e379c 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -293,18 +293,8 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
>         clk |= host->clk_reg_add;
>         clk |= ddr;
>
> -       /*
> -        * SDMMC_FBCK is selected when an external Delay Block is needed
> -        * with SDR104 or HS200.
> -        */
> -       if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50) {
> +       if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50)
>                 clk |= MCI_STM32_CLK_BUSSPEED;
> -               if (host->mmc->ios.timing == MMC_TIMING_UHS_SDR104 ||
> -                   host->mmc->ios.timing == MMC_TIMING_MMC_HS200) {
> -                       clk &= ~MCI_STM32_CLK_SEL_MSK;
> -                       clk |= MCI_STM32_CLK_SELFBCK;
> -               }
> -       }
>
>         mmci_write_clkreg(host, clk);
>  }
> @@ -511,10 +501,27 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
>         struct mmci_host *host = mmc_priv(mmc);
>         struct sdmmc_dlyb *dlyb = host->variant_priv;
> +       u32 clk;
> +
> +       if ((host->mmc->ios.timing != MMC_TIMING_UHS_SDR104 &&
> +            host->mmc->ios.timing != MMC_TIMING_MMC_HS200) ||
> +           host->mmc->actual_clock <= 50000000)
> +               return 0;
>
>         if (!dlyb || !dlyb->base)
>                 return -EINVAL;
>
> +       writel_relaxed(DLYB_CR_DEN, dlyb->base + DLYB_CR);
> +
> +       /*
> +        * SDMMC_FBCK is selected when an external Delay Block is needed
> +        * with SDR104 or HS200.
> +        */
> +       clk = host->clk_reg;
> +       clk &= ~MCI_STM32_CLK_SEL_MSK;
> +       clk |= MCI_STM32_CLK_SELFBCK;
> +       mmci_write_clkreg(host, clk);
> +
>         if (sdmmc_dlyb_lng_tuning(host))
>                 return -EINVAL;
>
> --
> 2.25.1
>
