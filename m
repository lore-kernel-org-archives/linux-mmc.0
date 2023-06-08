Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B999C7EE23
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Jun 2023 14:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbjFHOrW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Jun 2023 10:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjFHOrV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2023 10:47:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD82273A
        for <linux-mmc@vger.kernel.org>; Thu,  8 Jun 2023 07:47:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bad05c6b389so795261276.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2023 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686235639; x=1688827639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QLYBwih5DTEcFLBWhSDsv7D2FCsxcsxo7Fzak3TXy78=;
        b=uuuFlpDOoclmRMQ1Ov1i0DGRJzTtpeL1MiaHV0PeCzbM4UxFvSi5mH3z0qS0YJYfug
         rYib4QERHSUL1rvt4YMfY/wB84v3seRd4Mj3FRMDdTlLs7wf8HkeLdATdbmJcQucmwN6
         Dwjn5YEs33nkkLI/udAdsYZwVch1B37jYftUOvI2Gb7Ala7HrmAsYVskdDdMbk9C19x2
         u4REk0AIjETnzJ6zF64zm84TwpRnFE7Z/HmBBH+44vt/iHANkO67DAigV+yQ5VZTlMzw
         2NCQaQKCL8IfYgmhAHv0v33rlYS89r/GdF1wZdv0s534lvT9799wj5Fzu0A/gK3Dy/Il
         mzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686235639; x=1688827639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLYBwih5DTEcFLBWhSDsv7D2FCsxcsxo7Fzak3TXy78=;
        b=N6kEQ9fY3N0p3E0XlgN3Uj/MBaBh4g911CInaYOkzHEDiyG8WtKoiq61pLC23Ano2o
         fSk+65VCOd1Te2F27cO6zeMhHCUFHR25tyRqw27rlBhmV1Jd6A2HeuGmphHMUcDVtqmM
         ddasG9wmNUiRYwvCMPBzNjZhzPXbhIWTP7Cgam9PYnru4gjCzJ9cthTcGThK+9MJ+7ht
         YdiwnWog7TJjZLxGoMfELWdD2q7tihxSJVTyGMUHZ8/QvcPbh5M0x1U3jZAEuShgKrgp
         9eorFDLBet1viohGohSAOCW8vWjHl6wUH3KYAiR/hVChrEGFBTxM0addl6PmLRUL/HWy
         HaAw==
X-Gm-Message-State: AC+VfDxFWzgIL7RNWXLLUnLlsmvUjQ7H6ek9PIDsbJ7GumaKgn6ZY0GA
        GwFmS0/Kf8Dg9EyN4iVXOOpVOXvg5xAlCY1gGdGLzA==
X-Google-Smtp-Source: ACHHUZ73DSF1HDc5FNbav/CLP1ldtyZFJsKCxCqv8zpJlxz1ybIs2kwCKhMtREDlGqBcgzupgkYL9yQpmGkj8c3m8i4=
X-Received: by 2002:a0d:d802:0:b0:568:97bf:5b99 with SMTP id
 a2-20020a0dd802000000b0056897bf5b99mr10654505ywe.8.1686235639321; Thu, 08 Jun
 2023 07:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230518082035.335112-1-haibo.chen@nxp.com>
In-Reply-To: <20230518082035.335112-1-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 16:46:43 +0200
Message-ID: <CAPDyKFru7O=WYFOsHLMGguQLiFmKg4JyT1ksdUNM152K2+u0_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: enable IPG clock before
 register access during suspend/resume
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 May 2023 at 10:17, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> During suspend/resume, need to access usdhc register, so need
> to enable IPG clock to avoid bus error.
>
> Find this issue when a card slot do not insert a card, so when
> system suspend, sdhci_esdhc_runtime_resume() will not be called
> before sdhci_esdhc_suspend(), so will meet system hung or bus err
> once access usdhc register.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
> The first thing I do is try to merge the sdhci_esdhc_suspend() into
> current sdhci_esdhc_runtime_suspend(), but find some obstacles:
> 1, sdhci_esdhc_imx_hwinit() is called in original sdhci_esdhc_resume(),
>    it will clear the DLL config, which after remove to sdhci_esdhc_runtime_resume,
>    will finally impact the DDR50 timing.
> 2, if merge, everytime after sdhci_esdhc_runtime_resume, will do re-tuning,
>    this is unnecessary for the normal runtime PM case without power lost.
> 3, the CD gpio wakeup. Seems strange to enable the CD gpio wakeup in
>    sdhci_esdhc_runtime_suspend().
>
> So, finally I drop this merge method, and directly add change in the original
> sdhci_esdhc_suspend()/sdhci_esdhc_resume().

Looks like you need some differentiation between runtime
suspend/resume and system suspend/resume. One way to deal with this is
to set some driver flags during system suspend and then monitor those
flags at runtime resume - and then act accordingly.

There are a couple of sdhci drivers that do this, like sdhci-xenon.c
and sdhci-of-at91.c. Those drivers don't seems to need the
sdhci_suspend|resume_host(). Maybe that pattern can help to fix this
too?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index eebf94604a7f..4cf42a028bb9 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1836,6 +1836,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
>         struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>         int ret;
>
> +       pm_runtime_get_sync(dev);
> +
>         if (host->mmc->caps2 & MMC_CAP2_CQE) {
>                 ret = cqhci_suspend(host->mmc);
>                 if (ret)
> @@ -1855,6 +1857,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       pm_runtime_force_suspend(dev);
> +
>         ret = pinctrl_pm_select_sleep_state(dev);
>         if (ret)
>                 return ret;
> @@ -1873,6 +1877,8 @@ static int sdhci_esdhc_resume(struct device *dev)
>         if (ret)
>                 return ret;
>
> +       pm_runtime_force_resume(dev);
> +
>         /* re-initialize hw state in case it's lost in low power mode */
>         sdhci_esdhc_imx_hwinit(host);
>
> @@ -1886,6 +1892,8 @@ static int sdhci_esdhc_resume(struct device *dev)
>         if (!ret)
>                 ret = mmc_gpio_set_cd_wake(host->mmc, false);
>
> +       pm_runtime_put_autosuspend(dev);
> +
>         return ret;
>  }
>  #endif
> --
> 2.34.1
>
