Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC5C433E1
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C17061A0D
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 10:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbhCXKVv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbhCXKVX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Mar 2021 06:21:23 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB346C061763
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:22 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id z68so11032701vsb.10
        for <linux-mmc@vger.kernel.org>; Wed, 24 Mar 2021 03:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UpDin0c3jd0tV9ZS+Jk9HbNq8Kg4pMfbI5Df0iBkMWg=;
        b=Zvl31gMQDO3Rl/BuUQ62KRy4BQ369RgoDpWJ+yQjwOcR4JekPSSP+KdqwqTsrtOFjr
         Z5KfpHN4RXziTs+JVeNhQO6w6eyFD8JjSpt/HHDkWlibDGJd9lwXl1jE59LmdXfFFpmw
         6YwiCeR+fWa7Fs8UgnurWTPhHBhzrtIaRnqQDnQy9r6MawjtUQjfjUFE70bAw3S1aG2o
         fpbwof5rvbY+HRALkvfwZmMQGF4auBPeosu0F9hYtlo72McvXkODc/j3EwpEZ0irdkY3
         OAANMfb+axmhHOWIhW1O5I2YtkodnRsfXdNUt3io+W0l85sQfgSFU5OYNt0H29tWQufi
         Se8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UpDin0c3jd0tV9ZS+Jk9HbNq8Kg4pMfbI5Df0iBkMWg=;
        b=pFT152ltgkc3kVqunpcUOf4CR987krWfz4jLMr2tMGUtpIZIX6rM9Cft9OTk4/wgob
         rHjZctHycdqEIEqxeVYYtY6RegvrLUxNe1dkcRQP4Pmpmi35iNTm3fVQrPfAkRBjGGO3
         EhxokYGCnYzExRw67WZYKDfaB5qCiNy6LvVw0JByj5Hxz2ToeM8rbMV7WafIVLtXGHVy
         FlJVxP901ygk4YVx2FW17eLNG+vTUszze0K8XEvY8kVPC+Qbb7Cd/ejVSfgzsJOxKRN9
         j1zR29gzJdecJvcD2CxCTu3b0NMb3kTNtWPwSHtKp6102EuHhwRuWnp/40JYLoKkO2HP
         LdtA==
X-Gm-Message-State: AOAM531FjkHfCpbVuc4ynTpSesYMYvzZTQ/hJOqgQCjYXB6y2XIxFabK
        ndG1SVt0HEUqIPnObrFZ9GoWCYrMrJoIvznTEasM1g==
X-Google-Smtp-Source: ABdhPJz91kVyF2pV11YGBiaCPfw6fMbBggR+6yLhKqOv9dP5o6ljERTI+Z30jCdTxVJ+HWddjtkgY5id3zb1PXrXMec=
X-Received: by 2002:a67:2a85:: with SMTP id q127mr978249vsq.19.1616581282148;
 Wed, 24 Mar 2021 03:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210322055356.24923-1-adrian.hunter@intel.com>
In-Reply-To: <20210322055356.24923-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Mar 2021 11:20:45 +0100
Message-ID: <CAPDyKFo5fdYY4W5PBzst-vu0ohfK5m5Rvbpr3ie4tWGSOi3rXA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Add PCI IDs for Intel LKF
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2021 at 06:53, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Add PCI IDs for Intel LKF eMMC and SD card host controllers.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 2 ++
>  drivers/mmc/host/sdhci-pci.h      | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 62799c1d9c0c..b3caa174effe 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1903,6 +1903,8 @@ static const struct pci_device_id pci_ids[] = {
>         SDHCI_PCI_DEVICE(INTEL, CMLH_SD,   intel_byt_sd),
>         SDHCI_PCI_DEVICE(INTEL, JSL_EMMC,  intel_glk_emmc),
>         SDHCI_PCI_DEVICE(INTEL, JSL_SD,    intel_byt_sd),
> +       SDHCI_PCI_DEVICE(INTEL, LKF_EMMC,  intel_glk_emmc),
> +       SDHCI_PCI_DEVICE(INTEL, LKF_SD,    intel_byt_sd),
>         SDHCI_PCI_DEVICE(O2, 8120,     o2),
>         SDHCI_PCI_DEVICE(O2, 8220,     o2),
>         SDHCI_PCI_DEVICE(O2, 8221,     o2),
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index d0ed232af0eb..8f90c4163bb5 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -57,6 +57,8 @@
>  #define PCI_DEVICE_ID_INTEL_CMLH_SD    0x06f5
>  #define PCI_DEVICE_ID_INTEL_JSL_EMMC   0x4dc4
>  #define PCI_DEVICE_ID_INTEL_JSL_SD     0x4df8
> +#define PCI_DEVICE_ID_INTEL_LKF_EMMC   0x98c4
> +#define PCI_DEVICE_ID_INTEL_LKF_SD     0x98f8
>
>  #define PCI_DEVICE_ID_SYSKONNECT_8000  0x8000
>  #define PCI_DEVICE_ID_VIA_95D0         0x95d0
> --
> 2.17.1
>
