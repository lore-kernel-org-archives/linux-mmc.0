Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87831C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5551660FEB
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhEKK6s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhEKK6o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:58:44 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E5C061760
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:37 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id l4so3121274vsa.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/JdLJLNNgKYNFulcjt0TiB1eWs9RFWu6AjeVzq+IhY=;
        b=eM6z8sgQMbnfc8M2ZVTYjjBiUUk1eTbMv7OZBLvUXLup5nTEBZ/lE3EVCC76gnnOje
         cx2Q1WuLVBKw5OTs/7bhAqpbm0LfNtVkA9Ioi1/UMWNxBegNGeMepqoDfJsCDLZO7IbR
         AhM/S4RoBUIy/g/4hhS9fClf37bQ+bDos2sxiZ0q0emPwyqO5RE87l0axhIn6RR+dAlR
         DZTg2sFbxPpELEPwPSW05imK1ayMvzKLtnIoyu3b4zRV09BYrleo0fwHFkgDWsiNWtZ0
         ZzyHff6bj/aMLzR1yvXfHLr3YL6tEIrYP84Br2HRUaFcIbFAfmOELuOfe01RZxK+FAUQ
         pKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/JdLJLNNgKYNFulcjt0TiB1eWs9RFWu6AjeVzq+IhY=;
        b=rzg01qnOSqj2PotCwmLBsbmrjV2bWPj0Xfxji8yRgcxKEF20W3oA8F++IlMRa55ljS
         OvBq+QdeiQwQqjBKgpubYTtblcFMgfIsKX26uRceWJIpVcVHWaXPr7PUZ94hpm0Dz26h
         JMO/6sibSgoyhtraKygMf5u/aya7eyktrbSP7MHrik+5UGAhop/xC1u59wrZwBBRahNh
         kI0TmCcTLSdAyIXi6izcqkIgNrtdU4N0pV8nKCUKFOPc7l9vY5ygRm3wSv9xEMD3Cw8v
         54sCx9h4Dh64+zwdUMYD1S9BHn/cYI/VZDWHDuf8ljou32qh7+UtMULbNLpaVZ9vs5r0
         +3og==
X-Gm-Message-State: AOAM530tNPmhgpW9Fv9swjEBYgT7xXPNWAuZIP52i+UyFkCh5tfvjdRE
        JbntaaZ0T1HTdZ5Y232Pgbh5k6sCJpJjd/aU04wjQw==
X-Google-Smtp-Source: ABdhPJwL3XK2p31fbYeyFsdX2H7pS3bEKTH5nbN54hzhC7nodz955JOTyuC0jGGpqCkbQzKqhcZIiNIjzmWEtxyghYA=
X-Received: by 2002:a67:64c5:: with SMTP id y188mr23398674vsb.19.1620730656739;
 Tue, 11 May 2021 03:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210511061835.5559-1-benchuanggli@gmail.com>
In-Reply-To: <20210511061835.5559-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:59 +0200
Message-ID: <CAPDyKForv+be28L0QC0n1=FB4MEJzT0+OvAEB_7n1h0ejiTfkg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fine tune GL9763E L1 entry delay
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <renius.chen@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        seanhy.chen@genesyslogic.com.tw,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        totti.yan@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 May 2021 at 08:15, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Fine tune the value to 21us in order to improve read/write performance.
>
> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 592d79082f58..73e01c3480a3 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -94,7 +94,7 @@
>
>  #define PCIE_GLI_9763E_CFG2      0x8A4
>  #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
> -#define   GLI_9763E_CFG2_L1DLY_MID 0x50
> +#define   GLI_9763E_CFG2_L1DLY_MID 0x54
>
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
> @@ -842,7 +842,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
>         value &= ~GLI_9763E_CFG2_L1DLY;
> -       /* set ASPM L1 entry delay to 20us */
> +       /* set ASPM L1 entry delay to 21us */
>         value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
>
> --
> 2.31.1
>
