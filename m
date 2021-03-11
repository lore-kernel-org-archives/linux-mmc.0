Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341F4C433E6
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF42264FC0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbhCKLuB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhCKLtn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Mar 2021 06:49:43 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFD8C061574
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:49:42 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id j19so507044uax.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Mar 2021 03:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXqg8vgL3gnu/IDGJ8BFXqaOeLb5eaolcYdE67ipBbM=;
        b=ZqM+6G+f/TXtH5dXXDax6oiHd3LF2JqvfGtwN7T1sctJhWpCiG5lI+vXqJSmDxORI/
         DMO6WOUZ2u0zvvk7CiAmNFAh7lIk3tQuZ6sQMPBjaF93S6sMpEL7wZWqUMuMt+MoZBrb
         xi5YWbdefl2EqWu3ypFz+SaVhPrkEMDWNom1EFWxEGs7m0LC+DAwFngH70PWTKacis+L
         AbNzNRCCbogg/Ei7uL3MfsySyBBDn9HlDY9e5U1suoackSsyBPSYweHrLU4U3AH9/cmh
         Ko/4eYAlVqO7J0WXwFFkvfmppaRdA8EvtsgVKqKE0gEWGeLY5qOEWzg9iMtXi4y6JbJ+
         uhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXqg8vgL3gnu/IDGJ8BFXqaOeLb5eaolcYdE67ipBbM=;
        b=Qkleb7tHFoUy3B7UNGoifVVlIVeeMOICF7SPlbb8TC4QktjnM0LgEtp02+3HFOUAgF
         NvFbO8X051QeVrZdYMO5/xdTHiTJe7EZ6gMVkFoWQ/hjhs96u1zIw9C78qzVgISgkxY+
         JsOMm9uaYj1wmOWlvel9NkHHfzj5pr3G1/BWlVjfsJv8dO0K28xCCNnx8PAQI9fHE473
         ESO23cEqUf9swsi/MzINOx5eFJ/hIWu5z2sk8wSFq8+CP74xAIx0ARQyczx2fbCA0qU1
         vv0lPOheaZ9G2RIVUqIDOpd6qejmQXd3831g2SiKMbzhTiIziofKbb9juG1SHUXo/oYW
         PHaA==
X-Gm-Message-State: AOAM533RTgUlLoBBTFwIKjh55SE1jYfuEGPchixOtxyg/Lz3VAV3and9
        a08VIKzLrIvKXIupwmugM8nvzoLq9ybGmE4mD19iAQ==
X-Google-Smtp-Source: ABdhPJwRCEITIrXY4A7xuxCWdT5/HWX0F5raWsn79lSa3I6wONdV/YVQtrSk0arALTCLzXvkvByWZIGBEPiEQ3eq+kg=
X-Received: by 2002:ab0:6f0e:: with SMTP id r14mr3251737uah.15.1615463382129;
 Thu, 11 Mar 2021 03:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20210311181432.6385cd2b@xhacker.debian>
In-Reply-To: <20210311181432.6385cd2b@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 12:49:05 +0100
Message-ID: <CAPDyKFon6knyavDHO_PujQeVwgzE6pcK13zuS9xwHfzbfwd1NQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Avoid comma separated statements
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 11 Mar 2021 at 11:14, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Use semicolons.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 9552708846ca..62799c1d9c0c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -958,7 +958,7 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>                 slot->host->mmc->caps2 |= MMC_CAP2_CQE;
>
>         if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> -               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
> +               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
>                 slot->host->mmc_host_ops.hs400_enhanced_strobe =
>                                                 intel_hs400_enhanced_strobe;
>                 slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> --
> 2.30.2
>
