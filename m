Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2040C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C16C23884
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbhAOMWw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 07:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731558AbhAOMWv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 07:22:51 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23699C0613C1
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 04:22:11 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id 187so937920vsg.4
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgPHHoIcU5C8Hqd6fNCPG4F31nQysHA17qYCmz4l4Lo=;
        b=ea3idq7QyA7eOUtpJjqJfUR71uY1CdN5BjuCyTNfyBML2mnRV56Hf1cZbI5EGUBc+u
         IYFnTQFbEly+dZg3tE73NQznV310fQWQUK2UhKWk4cxE2hP73ek6lK49/QcTioKScmGs
         KjaTDxoV3zdrJha2cPW1uAV6i5FJ/uZlPANU0W/qUip/R0TOpo0o0WoQJbUo68LKJJiU
         zMnsFXWW3C6unQahLL5OQrT74WklEXZVXM0Oa+VOi9jp0YizjnIrhHIWsW5YmXmY9nNl
         2DtzPjCc3XstlgqE+o5gLrAXR68EH0oL8BzKIWm6qHCLzOEKF5uPzRAvTU1HNuoJyU0j
         RGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgPHHoIcU5C8Hqd6fNCPG4F31nQysHA17qYCmz4l4Lo=;
        b=cAgf0W8fKMGfJWwXPUx8DJu49J6c1ye2zD00uH1zosKq/oaEV56q1nlWarFCqOfqj/
         USIM1iqTPPwCper/sCtX4+qEOkKkD4AAfotOIhzjILIAR4HdabCZaquGmo+hTTo8tu+P
         7zZ+wx/imyKV06gqBTbcO4DEuD1bYyCrjvw0jll90QEnAYVwb+RbZ6HE/aAjrEZryWYo
         6CVr8ys6e+qjstLCxBILFaOKDSj3R8G7wnqnlS4EIcPTNf7kPToHFBNCWFSn1Hh6BPxR
         rVR41jr3f+S/04iCpAyRmPGx0rKTOLtjyNUH1DIvEgrKxxtzYXcjtUnf/KI3eiuAra9g
         0y/w==
X-Gm-Message-State: AOAM531Xl2z77gTFxXZ2glf4otADamnQ9Q0pDoQu/k9SGm5vOmp9Poes
        7YDVvxK5SBG9MD0K9D3ttgfjMvO/ZoUj0Lk5rkZ864t9dog34Q==
X-Google-Smtp-Source: ABdhPJwDW0Nte5967IuZVK9MONUkUtWiZ1VQ5MH4/R399PnAaJAV/XX4iOUFjNERmyDXAhqsNEhYlOxY7ITpgswiXMQ=
X-Received: by 2002:a67:70c6:: with SMTP id l189mr9566545vsc.34.1610713330384;
 Fri, 15 Jan 2021 04:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20210115054736.27769-1-reniuschengl@gmail.com>
In-Reply-To: <20210115054736.27769-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 Jan 2021 13:21:33 +0100
Message-ID: <CAPDyKFqH4U+q4jmUyeXgD1ZwPC0BeXv6s=_FdAWV1KHDGfjyaw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of
 GL9763E (v2)
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

On Fri, 15 Jan 2021 at 06:47, Renius Chen <reniuschengl@gmail.com> wrote:
>
> GL9763E enters ASPM L1 state after a very short idle in default,
> even during a burst of request. So the R/W performance of GL9763E
> is low with some platforms, which support ASPM mechanism, due to
> entering ASPM L1 state very frequently in R/W process. Set the L1
> entry delay bits in vendor-specific register to 0x3FF to enlarge
> the idle period to 260us for improving the R/W performance
> of GL9763E.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index c6a107d7c742..fb14f70cb9a0 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -88,6 +88,10 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_CFG2      0x8A4
> +#define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> +#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
> +
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
>
> @@ -792,6 +796,12 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value &= ~GLI_9763E_HS400_SLOW;
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
> +       value &= ~GLI_9763E_CFG2_L1DLY;
> +       /* set ASPM L1 entry delay to 260us */
> +       value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
>         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.27.0
>
