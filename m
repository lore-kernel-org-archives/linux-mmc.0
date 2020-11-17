Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414DEC64E7B
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC888238E6
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 11:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n+iXWsGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgKQLus (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 06:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbgKQLus (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2020 06:50:48 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE03C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:48 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id h26so6401579uan.10
        for <linux-mmc@vger.kernel.org>; Tue, 17 Nov 2020 03:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQ2FxKF9VcUJ7RVuI91cbxrvXJe+qFRMRNJBbqakIdQ=;
        b=n+iXWsGpVuy0l+zYrDdIzxTHX2P8oLbqvabBV2J9XmiNSwyaQenudcEj9aMXm5BoEf
         Rd2Sq37uf//bHwWYYS9jv4WjLh7Lox6BQnOnEvEK/2bK/VfGQt6syNixpt8fsgekc9t+
         khpy1J/c8Hh/P1WBc1blzCuRSBYIXebf/Nf4Wkn74cNyx2lW/NpEIYI7bZbjp5iSk1Sr
         jemlexa9OqAv/DIn7yODxp9okmj7WgS5X8Emx4uf1uvBXd+G5CqxizOc/wF+TXwrxvHa
         sMz/Pxk9xRVB9PxbSil3V1PSxFTHhuCM4fI1Gz2i4ckK7ZFm25aKKib78v6iddRdOTDw
         /mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQ2FxKF9VcUJ7RVuI91cbxrvXJe+qFRMRNJBbqakIdQ=;
        b=iefJfkE5ecof4PM0Xjtly9y57Zd1PWVjT6mbTQ6vCglT5i6QQNLprmU0QAknq4fBOm
         Rb28qkGAH/+LP/TXDBU+jFvV4R4Ds9azl8wDTardXW6BywewMZ9BZxKWAFD89QFkgdD2
         4HjvjCc6dDKkGDC8OLZfTRAUEIZp+sQVbDXxG+Wtfl33vX1uL5HfjLFZsT4xNwJTG7Uz
         KJ0lXeNax+eiranpn7uonhs92prNB086cxRHpBiFDfGaIP0fQSuCNjZ35H6IT6/O8mjG
         UKEIF2gXMBbOipiWYwt3LGI2JKgfibDMUgYUJaDfl+YT9LC9KoTxJ2XweiPXKmYWufrA
         nCYg==
X-Gm-Message-State: AOAM532zpsOtUZSODYpuabAjZtm3JyCchgy6bt27asfvK9zzeFt+iT6Q
        IBkYvB1AZgbTcZEihzYHgBzjsAAS/4gy7kAIldbE5A==
X-Google-Smtp-Source: ABdhPJxcqI7iEEGgp+MQti51HQkMk/R2dE6hav0ktCk6vqHTzCc6fDu2cMwQuEb8nPBIkZZfLrvQTt/0ZRVqaSswLxo=
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr9023521uaj.104.1605613847181;
 Tue, 17 Nov 2020 03:50:47 -0800 (PST)
MIME-Version: 1.0
References: <20201112133656.20317-1-adrian.hunter@intel.com>
In-Reply-To: <20201112133656.20317-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Nov 2020 12:50:10 +0100
Message-ID: <CAPDyKFoTewieCkPdcx35h=+aopyUKuBKao4=QiATzMki5SGO-w@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci: Prefer SDR25 timing for High Speed
 mode for BYT-based Intel controllers
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 12 Nov 2020 at 14:37, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> A UHS setting of SDR25 can give better results for High Speed mode.
> This is because there is no setting corresponding to high speed.  Currently
> SDHCI sets no value, which means zero which is also the setting for SDR12.
> There was an attempt to change this in sdhci.c but it caused problems for
> some drivers, so it was reverted and the change was made to sdhci-brcmstb
> in commit 2fefc7c5f7d16e ("mmc: sdhci-brcmstb: Fix incorrect switch to HS
> mode").  Several other drivers also do this.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v5.4+

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
>
> Changes in V2:
>
>         Expand commit message.
>
>
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
