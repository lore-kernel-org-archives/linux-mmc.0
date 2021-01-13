Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AC5C433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D6A233E2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhAML1I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAML1H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:27:07 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BF5C0617BB
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:57 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id w7so559175uap.13
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1P8nvNrhWNN3MmTi4o9dbNyhPJAsjJF2TM9bdEaNv/0=;
        b=MxKhynVhLWCoqAXiucMLZT27vjzLyFvoWjJIN/SHUKtPkcZsukFdB+QWZiH+4/Fko1
         9Ky5zgYKGdHg+qLWs1wqJpz3W1Wv42YtBA8uxrqyUUfDSYf3e87U3grWXW/4AHEG3pty
         EEixzEu/7osioJarr67QvtrAGiFdpG3SM8NfK7E/R+RBqIcRiDo7NNAN2fp5kQJIX+LL
         HOrA+7ydhQ9icxeF0KNGp+qGP6E69yMhnoNsDzzScGG6F/KQyN5y25jgBIO+JKYpZKc2
         jTJ5SueGyd7xnL1xIurjmEqTIvchkjqFzFAsC+U3OBi7qcQcOm9JPqJjR/MvDT7d5UC0
         XX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1P8nvNrhWNN3MmTi4o9dbNyhPJAsjJF2TM9bdEaNv/0=;
        b=ZltPPEBnTkhiYstHted1qXIPzSVdjXG1JujwMAzvRrTaFY+GLTTD+hmSgNFeFcNHA0
         4RlG3DGfDdH8JPHEqXNn53qDXaQIS/k5D2EeEQYyCKBMmJXRcoB5ALxw5bfhv0cStTsA
         +XOQoNN1nmPKJEjDAlztgN2SndmeasmOO0Ju/RFTU59C+YQXLYNIBHsnujSl+Z5gWONP
         p/HpfjcmxTXrM7MROHNh6yhzGpVSLFxanzJJzzsFEWSCTCJCkSZtdHsYYefM7IMHideg
         KXRtewfBgI3GdwBN98AyTqZnBwMBLcF1+EVeJ4gd1GcDmzSDMYB2/JKWGXgfLrpzwxZn
         rdkw==
X-Gm-Message-State: AOAM533yawtX29r5uC6IDApohYK2N+lfWIA7mIj9PChYMx/H4yb/gZS7
        xYRLQefzxv6rUksf1bQk6blGfu3ziyHoJxzvPL2zpqNdt8/QDQ==
X-Google-Smtp-Source: ABdhPJxdH05hXsZ/BTVxqZ2D50ftzxWMCHTCzPiYI8GfOnRnYju+WTFC9l7ag1OdLOqg8zBA4Qooo6XiVf4Q6T1c4fc=
X-Received: by 2002:ab0:78d:: with SMTP id c13mr1289722uaf.129.1610537156300;
 Wed, 13 Jan 2021 03:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20210106085332.5494-1-reniuschengl@gmail.com>
In-Reply-To: <20210106085332.5494-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:20 +0100
Message-ID: <CAPDyKFo=GE2GNuv0=SXfuSSgE-b0iBhXCxqvd=cgspqX6hph2w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add a switch to enable/disable CQHCI support
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 6 Jan 2021 at 09:53, Renius Chen <reniuschengl@gmail.com> wrote:
>
> Add a vendor-specific bit named GLI_9763E_MB_ERP_ON at the bit7 of
> register 888h to decide whether to enhance random R/W performance
> of GL9763E. CQHCI support will be enabled if and only if the bit is
> set and the GLI_9763E_MB_CMQ_OFF bit is not set.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index b85edd62e7f0..c6a107d7c742 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -84,6 +84,7 @@
>  #define   GLI_9763E_VHS_REV_W      0x2
>  #define PCIE_GLI_9763E_MB       0x888
>  #define   GLI_9763E_MB_CMDQ_OFF           BIT(19)
> +#define   GLI_9763E_MB_ERP_ON      BIT(7)
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> @@ -814,7 +815,8 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_MB, &value);
>         if (!(value & GLI_9763E_MB_CMDQ_OFF))
> -               host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +               if (value & GLI_9763E_MB_ERP_ON)
> +                       host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>
>         gli_pcie_enable_msi(slot);
>         host->mmc_host_ops.hs400_enhanced_strobe =
> --
> 2.27.0
>
