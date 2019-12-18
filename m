Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCEBC43603
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA48624683
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 14:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynh8Bijw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfLROCH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:02:07 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32903 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfLROCH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 09:02:07 -0500
Received: by mail-vs1-f66.google.com with SMTP id n27so1450933vsa.0
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 06:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4d3SXXH9twA4RWZYwhTuwFTUWM9um1n6b5uUiGhYlZ0=;
        b=ynh8Bijwpv7Fw2OQY8W4NgCGjwyeYIXTkNK1GfhRUMdomy8pdZOpDsgC0z58kcfbnB
         6mr60Y0MbBGa6hNKzFjyBwDYC1XqI4ooVDJeuVUbj+Bk+ryhjvUeUOsXMSoyrLZV0Nc7
         BH/+clhibXwnbCU598LPuRsPfXrGVh7N5cdlqjM2H9sDj4Rk5sgDB32mpHgI4U9FpRDt
         TaUEwvD/qDhaD9WhDZ6K2qDHRFoMXzZAgrMnUR1F/rDjBnj9ZywvBLnyT0FUS62D6ZSW
         pC1DU6rWVbmPePFH818AVsNdiuswEOctSaaI4lMC499clWuHmeYJuArodtiwqg96Jl9j
         6NEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4d3SXXH9twA4RWZYwhTuwFTUWM9um1n6b5uUiGhYlZ0=;
        b=atUQpDOPm/ks9Zak+5OHsg8WmKd+vsYmg/KceWJdk2N46GDj2iozW5Q5Ovmi/InC6/
         yoB4HLEzwqCVNOVcG7AC3moF7RYTfk0B0HzUcEKhtoUskcoUS6nl2keMaCFhd2qhyJFs
         38jdfZwHzUDgANdN9emiwrKGFrCoe+noxbOAwOCUGTbpEGaw6/kdrOz9s2cjr2H3C5WA
         tN2IwkLXY+5vWqafA2HhtNNiyzBFQ4wJLI37alhqyIpppm5IR1e6VsQ4bycZ2BYVml9K
         ji7BeaJGVowV0FSYE3sp6ripG1F0t3QF/cKbr7SVsoXfUxcQ228+VoXaRPwH/z5cruIS
         ZmMA==
X-Gm-Message-State: APjAAAVb+6+Kjri2uL0ieWQi7NWQNb5igxIeo23qmMcR9+T+cGUKv3ma
        eRYfwe5FqzqTjfSBGey5c/8MGvW4p+omiPOpLs6Mqg==
X-Google-Smtp-Source: APXvYqz5G1hflqfmfEWf8UZwh2iKS9jD3zVptc8gTyTz/WT9SAsWCYB0a3N0NGHBnJMRnw3EMWrAC/yvb61PrkvDSlQ=
X-Received: by 2002:a67:b649:: with SMTP id e9mr1514070vsm.34.1576677725943;
 Wed, 18 Dec 2019 06:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20191217095349.14592-1-adrian.hunter@intel.com>
In-Reply-To: <20191217095349.14592-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:30 +0100
Message-ID: <CAPDyKFqUfWzGDKwqVwuBfNEtSdf-95+1Cg7aD9_xyE+2J_-aAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Workaround broken command queuing on
 Intel GLK
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Dec 2019 at 10:54, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Command queuing has been reported broken on some Lenovo systems based on
> Intel GLK. This is likely a BIOS issue, so disable command queuing for
> Intel GLK if the BIOS vendor string is "LENOVO".
>
> Fixes: 8ee82bda230f ("mmc: sdhci-pci: Add CQHCI support for Intel GLK")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index acefb76b4e15..5091e2c1c0e5 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -27,6 +27,7 @@
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/mmc/sdhci-pci-data.h>
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>
>  #ifdef CONFIG_X86
>  #include <asm/iosf_mbi.h>
> @@ -783,11 +784,18 @@ static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> +static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
> +{
> +       return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
> +              dmi_match(DMI_BIOS_VENDOR, "LENOVO");
> +}
> +
>  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         int ret = byt_emmc_probe_slot(slot);
>
> -       slot->host->mmc->caps2 |= MMC_CAP2_CQE;
> +       if (!glk_broken_cqhci(slot))
> +               slot->host->mmc->caps2 |= MMC_CAP2_CQE;
>
>         if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
>                 slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
> --
> 2.17.1
>
