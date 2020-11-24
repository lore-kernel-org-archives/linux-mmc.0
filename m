Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D48C71156
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C393E21734
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q33ynexT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbgKXO0J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388959AbgKXO0G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:26:06 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A474EC0613D6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:06 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id k12so6857411uae.13
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXRcCaUVxxZZUV6Y+dq+kpAHIj6NVWm4qzz8hPCcGtI=;
        b=q33ynexT77hBtRMxExxSQZMmEio2u/BJxI4j5bV05HCH+ZLNnNRAn5uWOpOtuhuwjl
         yc/TE1B/ALcoCCNDZFy21QLC+NQg9ZB2/BAcGUEvo6Tn3kc3YjAuY0e9yubGNeKySLXM
         LUSAXa1Odz7SqlpxDIAd8xJrYTwQ6BwVDUqup2a/tk25QNMqF62dBfsTSnSFjqWG/+fU
         vBr4P9FB5UIMx1AQDr6tcStJHeRJP4ek4RVoZDkfJy/kBKDg2ha7QeE9wnJbYzkYkkE7
         NJV+J3Hgz9oa9Y8NUcUFMOtnrCeWsVxZcJAPkp4QxMtUC/d2LYh8QbVNrmUWWG0HcqqQ
         PMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXRcCaUVxxZZUV6Y+dq+kpAHIj6NVWm4qzz8hPCcGtI=;
        b=qyzALNAVx8j0AAeO14piPeChEQYObrCDAKcOMjQaCcsmpflJ3gpRAy8pEWfno6doGu
         ztXSQmLzC98ST7v9CpFCwOr1pWnq9pYP2mbMn44UMA63TjrPugk6yxbDcTKK+/MsYcjJ
         nMckuqQ9FCa8lB3Fuu6KGzd5V0gTfUcXa2f24emPVNkvzOQu1AyBCPk3j/ZK1F4eJNvW
         SxU9J7z7fXk4Hq60GS617WkADNC5+JQimw1IOzZ8opexywlWSBAyAEwxvRivGr4KD/X0
         URlfGW7N5hka0l146/0cAzY6bdcSnVwkqgk61pY0rOqKmeIXi3ajDfaa5m5w0p1M7Wls
         b89w==
X-Gm-Message-State: AOAM533/rBn67EdvBX96KOzJYVKcYIRZLh02oo1Z2mpMsqIrg4eGpuQt
        9th68w7EGBgNlbRo1KeUSNmdzdVvIiUOa8RYPQ6Ulw==
X-Google-Smtp-Source: ABdhPJykEHmmkaxCh9165+vLErp6Sau19MHwoFZE8jE62Tn2fEL8r4K9P8i304LpjLxGwoov/Aa+cOwvPOnZhDXxq+0=
X-Received: by 2002:ab0:60b1:: with SMTP id f17mr2926491uam.104.1606227965906;
 Tue, 24 Nov 2020 06:26:05 -0800 (PST)
MIME-Version: 1.0
References: <20201123053702.6083-1-benchuanggli@gmail.com>
In-Reply-To: <20201123053702.6083-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:29 +0100
Message-ID: <CAPDyKFoLZ31uZZTSkLQBffUb0SERM_pZ52ygWk6QnkOdCVWXhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Reduce power consumption for GL9755
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 Nov 2020 at 06:38, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> For GL9755, reduce power consumption by lowering the LFCLK and disabling
> the DMACLK on low-power.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9887485a4134..f10bdfbfce36 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -97,6 +97,10 @@
>  #define   GLI_9755_WT_EN_ON     0x1
>  #define   GLI_9755_WT_EN_OFF    0x0
>
> +#define PCI_GLI_9755_PECONF   0x44
> +#define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
> +#define   PCI_GLI_9755_DMACLK   BIT(29)
> +
>  #define PCI_GLI_9755_PLL            0x64
>  #define   PCI_GLI_9755_PLL_LDIV       GENMASK(9, 0)
>  #define   PCI_GLI_9755_PLL_PDIV       GENMASK(14, 12)
> @@ -519,6 +523,21 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_enable_clk(host, clk);
>  }
>
> +static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
> +{
> +       struct pci_dev *pdev = slot->chip->pdev;
> +       u32 value;
> +
> +       gl9755_wt_on(pdev);
> +
> +       pci_read_config_dword(pdev, PCI_GLI_9755_PECONF, &value);
> +       value &= ~PCI_GLI_9755_LFCLK;
> +       value &= ~PCI_GLI_9755_DMACLK;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
> +
> +       gl9755_wt_off(pdev);
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host = slot->host;
> @@ -534,6 +553,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host = slot->host;
>
> +       gl9755_hw_setting(slot);
>         gli_pcie_enable_msi(slot);
>         slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>         sdhci_enable_v4_mode(host);
> --
> 2.29.2
>
