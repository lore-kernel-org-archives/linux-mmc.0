Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A459C433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 14:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04FF2245C
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 14:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387984AbhATOv4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390190AbhATOLo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 09:11:44 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098BC061795
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:38 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id a31so7892650uae.11
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 06:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQpo2/GqCSrtTmISxWObvMSxde4cEDeccm8J4/mCD54=;
        b=lTIxJju2eS/rp0QjBo4fvpCZUn4yw9e3W7e0ZyLUR9HmfbqeoouDNTuc4S3WdM9dGk
         y1epOqS0EEgxV+4dffWYitfyyo3DRt6F0LdBcOGXEAa6KPC3FU/VbXM7ME275IYEXGgp
         XdTzWDnLZsx68Aqq+Sarh4vFxSrArQN0uH4vOkI9uyerMbKmsCQwGwPv6+2G4i8S8f16
         LFg2dHEsu57WQIyD8lLsptAPB9K8nn/c16E0BHU0AH6uweA3IU2xJ1V0SjSQx0ey2NnB
         gEExCq6JPX1VlHGX64YOtDk2esWYs3V5dtFirm3JdRq5xVdkffWCmMSTq5Awf78lkNLw
         nYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQpo2/GqCSrtTmISxWObvMSxde4cEDeccm8J4/mCD54=;
        b=AEl0NI0Otslm7DJynhyGbNh8o4R6WpAaVtUPYVlpDlg3/1dRnhD6Bt6lbUqDoG4dls
         cg/qHdNep/XHxYexCdS1374ak5Pcs1i9rhVb0+2hhkuGZyXKGsvrAKhPURfaFPOKVFGd
         IxWJo2OT2ECpwzpMOK3wHeJW9UcfSvfhV2635xvrMTrIF8Egx8zobqdDONNCNX4J/bIy
         3VpY1o3P25+XJX5YzSFUfG6r8nA9j+XM2iIyvdriJ+QsZHaBtw1dThXXlH4syXhvkPNH
         /NX4rmSXPLCMj5U5B2FDT8SpB3z+nUzODAdDEiaV6NvEmwB5shtgxigSoti5f3byUgR3
         z21A==
X-Gm-Message-State: AOAM533lCiWQpt7Zbat47A0LgTOvgscY1taE/vN0zIHdDLIq8XTpNWgT
        6MsxXD4yMDpI/6OUebE98VeOXa/1qIRQPaUMtGrTJAEtcc6AiQ==
X-Google-Smtp-Source: ABdhPJybCoOrEGS0XDMKG7uX6jLpbNIxEZ8jIL0POQxHlhWHccui2ZyndJkGmmB+OOhQGKOprR2gBnmX9oDRFoa4/bQ=
X-Received: by 2002:a9f:2271:: with SMTP id 104mr6172058uad.15.1611151718095;
 Wed, 20 Jan 2021 06:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20210120000406.1843400-1-jeremy.linton@arm.com> <20210120000406.1843400-2-jeremy.linton@arm.com>
In-Reply-To: <20210120000406.1843400-2-jeremy.linton@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 15:08:00 +0100
Message-ID: <CAPDyKFpLpMU3ec7eV_q8w88oywazLrSo5wyVFZkVrzRqn3bhSQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-iproc: Add ACPI bindings for the rpi
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 20 Jan 2021 at 01:04, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> The RPi4 has an Arasan controller it carries over
> from the RPi3 and a newer eMMC2 controller.
> Because of a couple of quirks, it seems wiser to bind
> these controllers to the same driver that DT is using
> on this platform rather than the generic sdhci_acpi
> driver with PNP0D40.
>
> So, BCM2847 describes the older Arasan and
> BRCME88C describes the newer eMMC2. The older
> Arasan is reusing an existing ACPI _HID used
> by other OSs booting these tables on the RPi.
>
> With this change, Linux is capable of utilizing the
> SD card slot, and the wifi when booted with
> UEFI+ACPI on the rpi4.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied for next (and by updating the commit message according to the
nitpick comment from Florian), thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index c9434b461aab..ddeaf8e1f72f 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -296,9 +296,27 @@ static const struct of_device_id sdhci_iproc_of_match[] = {
>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
>
>  #ifdef CONFIG_ACPI
> +/*
> + * This is a duplicate of bcm2835_(pltfrm_)data without caps quirks
> + * which are provided by the ACPI table.
> + */
> +static const struct sdhci_pltfm_data sdhci_bcm_arasan_data = {
> +       .quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +                 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
> +                 SDHCI_QUIRK_NO_HISPD_BIT,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .ops = &sdhci_iproc_32only_ops,
> +};
> +
> +static const struct sdhci_iproc_data bcm_arasan_data = {
> +       .pdata = &sdhci_bcm_arasan_data,
> +};
> +
>  static const struct acpi_device_id sdhci_iproc_acpi_ids[] = {
>         { .id = "BRCM5871", .driver_data = (kernel_ulong_t)&iproc_cygnus_data },
>         { .id = "BRCM5872", .driver_data = (kernel_ulong_t)&iproc_data },
> +       { .id = "BCM2847",  .driver_data = (kernel_ulong_t)&bcm_arasan_data },
> +       { .id = "BRCME88C", .driver_data = (kernel_ulong_t)&bcm2711_data },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_iproc_acpi_ids);
> --
> 2.26.2
>
