Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5304AC43603
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228036135C
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbhDLHxE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbhDLHxD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:53:03 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F445C061574
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:46 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 33so3940040uaa.7
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvYyxcmuuy8Mf4iqwtPOnrJd7sqJQhBveqGwzWHM2us=;
        b=FskClHSpA1eGLUsuHiI6LnX7OEUf5wbqlhBkpSTyjUtn2HF2pPy0ceC0FUErKI/+RV
         HINipnQVhtE+TQ6Na2NrF0f/E0lzROKZbnfbtd91ADo+Li02q983L7r3yg4zEmm88bpU
         4yMpVKJgyMTxilsbcuWmJ5C4Sv4jPcjeSt+aURZ0QjhlpNbPeAcSSPj4YbQgH/iEQHYX
         4h0ORwLA/i+D5pGuVONA+TBrQN/PENvN4Jymw2QbjrO5ICWPN3Vanpkhu0Ejs96T9JeH
         thCDj6mDZQNq1Je01noeFz0/3Hb5VU7zB1rdZCfV7Bhy+B17GSlAL+Sn/3qMytAhbvmT
         Jcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvYyxcmuuy8Mf4iqwtPOnrJd7sqJQhBveqGwzWHM2us=;
        b=OUSxf9F3RVT3S6TB5GshvxyMXAt20/BVvJeFN6EWjTYv6UqqJuiuULkOVen/CxZhyy
         f5HBd5KGId+1F2FRcaJymE9M0Ft1QxkpgYM4BxA/TfCidzDRiI4VzDVX6jgvtXQwT+KU
         vbdzJQaEEJkqmLLnLANfcNaS3xbckkhp0++GkgJix/1dkXbGoE7lar8axOt3agae8za9
         9rtgu0UVj4CxLZVH1/R2D6UGezoYrbaTaWRx1b9vRcszEbg/fW1dCEiRjx2VeSmcuqlm
         0DFoHRz+1iWyKm/W1zzEIXoR/Bu0F7/YIjfjfrPG3Po+YL21VS39DWobhrfS6L90ryxB
         U+5w==
X-Gm-Message-State: AOAM530PbIUxO9x0yW9NYOb3SbByEpVCMTx04D8oszoysKPBq+xLO2Dw
        m4qjyD4e7wPW6BMlq1pZOhiI6BXQs535HF1JqiGoyw==
X-Google-Smtp-Source: ABdhPJwW4qYtEXTrHqKhePMsRPedaDesFJKTnGzbIJPUkx7LvObMealB+0hKv+r9exLnX9Nt3enrWUR0CLAyCxdAEWM=
X-Received: by 2002:ab0:6f0e:: with SMTP id r14mr18905449uah.15.1618213965308;
 Mon, 12 Apr 2021 00:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210407093816.8863-1-benchuanggli@gmail.com>
In-Reply-To: <20210407093816.8863-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:08 +0200
Message-ID: <CAPDyKFo=tPG77RbEUuyN18qLikr9u5cM0wY__pRko5t=Oh2wvA@mail.gmail.com>
Subject: Re: [RESEND, PATCH] mmc: sdhci-pci-gli: Improve GL9763E L1 entry
 delay to increase battery life
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <Renius.Chen@genesyslogic.com.tw>, SeanHY.Chen@genesyslogic.com.tw,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 7 Apr 2021 at 11:35, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> For GL9763E, although there is the best performance at the maximum delay.
> Change the value to 20us in order to have better power consumption.
> This change may reduce the maximum performance by 10%.
>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4a0f69b97a78..3b0a049d4124 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -90,7 +90,7 @@
>
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x50
>
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -802,8 +802,8 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
>         value &= ~GLI_9763E_CFG2_L1DLY;
> -       /* set ASPM L1 entry delay to 260us */
> -       value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
> +       /* set ASPM L1 entry delay to 20us */
> +       value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, &value);
> --
> 2.30.0
>
