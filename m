Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D10C74A44
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Mar 2023 14:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjCIOAE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjCIN7g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 08:59:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CDDF1840
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 05:56:39 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so2089810pja.5
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678370199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e3FbhTd7SKq5Nq6l66tYdjvxBa3jbZG47YnMgPBOp9M=;
        b=pjLw4fHDOZAVImaaThWQn+eRkVhUq3QsY9N9V/FjyUcna1ZcRc0B4Fu4bRsZuQXohI
         MEcBnVbZ+jFbl4ESHWU7julFgpIVZ3jixTztpd2c7dnTbPkhsl7dlz7l46lIr0FRfDVn
         0yqepLKil+EFrcFcNkOG/VbfQ09kPNr5AKzrn9VlJrUWEY09gUUYdb7oRtDbflirU9LB
         BvFMIeruVyCnV/qbDp2ssBfOY7jLjc8q1vDVamNeB+eFvGCkCwJYAdM7qXLO3/35Nx+b
         ZU7HCd1V0egVUzjzq+G4nJQR3rLBsv0WBTxSQjPWssenoaCpT9uXEuYfuZotExI3vQ8P
         zzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3FbhTd7SKq5Nq6l66tYdjvxBa3jbZG47YnMgPBOp9M=;
        b=XrMoQ40DIVigTesi/kE3hLx/VJXmZu3yVp7chGzH1t2EMeHNE70VcgqEz7smRqGbOp
         +cNmiY0Jofllp8oehG9vkUlK2AfhA1cppw3ogb7G/dY68+x8HvsHWoRPmbkwTnITWhPZ
         cU7zBaS5Udy8iDjLz5JnqDkbt7qvfXgHpE6aQ2OyYoo4TPaURuPZmJMVRwFXnxThAcBx
         oC5YzfdXNKNt+Oz1up8os8SYT9ObcfZKdt8VGjdEp6PMHeQaQyXr50yEIC7Io17sHWB8
         po+IreR7KuRU3y7MrwWn4QIr1+DJ0VYx4i/Ceb80OhuZUUpdR76Me44iDhhTik5TlxNc
         eFEA==
X-Gm-Message-State: AO0yUKUzyWKbInvs4LIEssT0ym7qgVR8G83wrM91P3hbqlzDsvXPCo/6
        zmCP7ml1vSLjML/A8GoWbEnsw0BVwyIbEXP48M5eIQ==
X-Google-Smtp-Source: AK7set+Erg/o6z5g7NHE2Sira6nwaIb6cAHL5jxRLmocnfnD6fomDHWggrFX0FogSL3QL5DazDMjOWoZydnLJbO8h5M=
X-Received: by 2002:a17:90a:2aca:b0:237:5c37:d9ca with SMTP id
 i10-20020a17090a2aca00b002375c37d9camr8194943pjg.4.1678370198666; Thu, 09 Mar
 2023 05:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20230223120450.16858-1-fredaibayhubtech@126.com>
In-Reply-To: <20230223120450.16858-1-fredaibayhubtech@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 14:56:02 +0100
Message-ID: <CAPDyKFpJkRZVXFh7DmvEM7yDvZ3M14f0hkMvzyJp5NPT_a7ogg@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Fix SDR50 mode timing issue
To:     fredaibayhubtech@126.com
Cc:     linux-mmc@vger.kernel.org, linux.kernel@vger.kernel.org,
        shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Adrian (corrected the email)

On Thu, 23 Feb 2023 at 13:05, <fredaibayhubtech@126.com> wrote:
>
> From: Fred <fred.ai@bayhubtech.com>
>
> Change SDR50 mode clock source from DLL output clock to PLL open clock
> 1.HS200 and SDR104 mode select DLL output clock
> 2.SDR50 mode select PLL open clock
>
> Signed-off-by: Fred <fred.ai@bayhubtech.com>

Looks like you posted this to an incorrect email to Adrian, perhaps
re-post to include him.

Kind regards
Uffe

> ---
> Change in V1
> SDR50 mode select PLL open clock as its clock source.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++-------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 98cadff47b2b..620f52ad9667 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -339,22 +339,24 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         reg_val &= ~SDHCI_CLOCK_CARD_EN;
>         sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
>
> -       /* UnLock WP */
> -       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -       scratch_8 &= 0x7f;
> -       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> -
> -       /* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> -       pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> -       reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> -       reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> -       pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +       if ((host->timing == MMC_TIMING_MMC_HS200) ||
> +               (host->timing == MMC_TIMING_UHS_SDR104)) {
> +               /* UnLock WP */
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +               scratch_8 &= 0x7f;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>
> -       /* Lock WP */
> -       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -       scratch_8 |= 0x80;
> -       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +               /* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> +               pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +               reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +               reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> +               pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
>
> +               /* Lock WP */
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +               scratch_8 |= 0x80;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +       }
>         /* Start clk */
>         reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>         reg_val |= SDHCI_CLOCK_CARD_EN;
> --
> 2.37.2
>
