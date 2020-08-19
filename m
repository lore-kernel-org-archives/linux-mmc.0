Return-Path: <SRS0=2cKM=B5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB4C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 22:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2B4207DA
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 22:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fVgWpyWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHSW4i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSW4i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Aug 2020 18:56:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79F6C061757
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2020 15:56:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c10so145073edk.6
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2020 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5CdGpPLchV3r1sgquFSI+KPaGqT2I/ptWGolNWVn8h0=;
        b=fVgWpyWBnvCZeCnyxvWxLthiXMssKrJpGhHbOsLDG8gF2pcAr1kvPZnIkXaDxVidFG
         yAsj2bboYpKFVcwnfaPHzJOUr85b6jmeAFk+T4c+lBoakhHoI55pKC3F3RI8ccqqM/gy
         lY81hrsFRW392/+8noNbBepeq7kfY1T1dPxp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5CdGpPLchV3r1sgquFSI+KPaGqT2I/ptWGolNWVn8h0=;
        b=RrTq9ocnNOWhAJcAfoqk7oDK4vKZRHJR9oP2QgP5FB9yRI4HQkk0h5U42Aiksvpov/
         IhtmbmoUkJHNChVTYr6zU5xj101sVuZfjBDPyvWsS90bwScCaW8rGAfQQMIn5lqvHC5G
         YIB8nnMcrsXx3l+lWh0n1E/8E8eToUX/DoPkRC1obLje5owWA1of1/zLITG6BkwQJ8VB
         IKU4Fhr32dChvkE20/v04c1uENmJzfx5TI2V9RTutO6mkwsovpTKqlgtszsJtAgvXIVh
         T/QnzWTmvAfzzSU6Phi2wIZ1mvpXbX73XYTCD8acSfAt5C0r3fra2KyrMtRVZajt7pRp
         QjZg==
X-Gm-Message-State: AOAM531xXHH07NGGhDUpnmP554b6oJfGaF0Bi5dBC9nkJ/nBF3YCegRZ
        pWcnGlnnj2hwugGREPiSsXhAUKJtvjO7JA==
X-Google-Smtp-Source: ABdhPJxGQe+DNYm69Q4PbLNO8ETAeYErVbOqFDfb+fZkYYfjeZrJmT3kUb6Speq24WLWFg85H2P5lg==
X-Received: by 2002:a05:6402:1c85:: with SMTP id cy5mr326148edb.6.1597877795793;
        Wed, 19 Aug 2020 15:56:35 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id j11sm178063ejx.0.2020.08.19.15.56.35
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 15:56:35 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id qc22so377094ejb.4
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2020 15:56:35 -0700 (PDT)
X-Received: by 2002:a17:907:2712:: with SMTP id w18mr507253ejk.473.1597877794459;
 Wed, 19 Aug 2020 15:56:34 -0700 (PDT)
MIME-Version: 1.0
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 19 Aug 2020 16:56:23 -0600
X-Gmail-Original-Message-ID: <CAHQZ30ApB3BEzgLv=EtzB_Kpnsfsr7-s+JcYmyzXN3j7OF80-w@mail.gmail.com>
Message-ID: <CAHQZ30ApB3BEzgLv=EtzB_Kpnsfsr7-s+JcYmyzXN3j7OF80-w@mail.gmail.com>
Subject: HS400 tuning and presets
To:     linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

I noticed some odd things with the MMC/SDHCI code while debugging an
HS400 tuning issue.

1) Is it expected that we never enable SDHCI_CTRL_PRESET_VAL_ENABLE
for an eMMC running at HS200 or HS400?
The flow for enabling HS400 is: Legacy -> HS200 -> Perform Tuning ->
HS -> HS400.
Looking at [sdhci_set_ios](https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci.c;l=2019),
it looks like it's responsible for enabling presets.

    if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
                    ((ios->timing == MMC_TIMING_UHS_SDR12) ||
                     (ios->timing == MMC_TIMING_UHS_SDR25) ||
                     (ios->timing == MMC_TIMING_UHS_SDR50) ||
                     (ios->timing == MMC_TIMING_UHS_SDR104) ||
                     (ios->timing == MMC_TIMING_UHS_DDR50) ||
                     (ios->timing == MMC_TIMING_MMC_DDR52))) {
            u16 preset;

            sdhci_enable_preset_value(host, true);
            preset = sdhci_get_preset_value(host);
            ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
                    >> SDHCI_PRESET_DRV_SHIFT;
    }

MMC_TIMING_MMC_HS200 and MMC_TIMING_MMC_HS400 are missing from the
conditions, so we never enable presets. This means that by default
(only 2 controllers provide select_drive_strength) we use drive
strength B for both the card and the controller.

    int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
                                  int card_drv_type, int *drv_type)
    {
            struct mmc_host *host = card->host;
            int host_drv_type = SD_DRIVER_TYPE_B;

            *drv_type = 0;

            if (!host->ops->select_drive_strength)
                    return 0;
            ...
    }

Here is a trace log showing HS400 initialization: https://0paste.com/79874

2) When performing HS400 tuning we end up enabling presets.
The re-tuning sequence is: HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400

So when we transition to DDR52 the code above enables presets. You can
see this happening in this trace log: https://0paste.com/79875. Look
at timestamp 1926.173800.

This means that the card and controller have the potential to have
mismatching drive strengths. This can be seen at timestamp
1926.175813.The HS200 preset on my controller is configured to A, but
the card would be set up as B (if the controller didn't override
select_drive_strength).

Should we be enabling presets for HS200/HS400 (and potentially
MMC_HS), or should we remove MMC_DDR52 from the condition above?

It looks like 0dafa60eb2506 ("mmc: sdhci: also get preset value and
driver type for MMC_DDR52") was the CL that added MMC_DDR52 to the
condition.

3) How do we ensure that card drive strength and controller drive
strength stay in sync when presets are enabled?
Right now mmc_select_driver_type is only called from
`mmc_select_hs400es` and `mmc_select_hs200`. `mmc_select_driver_type
doesn't currently take the timing into account when making a decision.
Only two devices currently provide the `select_drive_strength`
override, so we are setting the card to drive strength B for most
controllers.

Should we modify mmc_select_drive_strength to take in the target
timing so it can return the correct card drive strength. We could then
add an sdhci_select_drive_strength that queries the preset registers
(if enabled) and returns the target drive strength.

4) Should we be calling `mmc_select_driver_type` from
`mmc_hs400_to_hs200` and `mmc_hs200_to_hs400` during the transitions?
Or do we not care?

Sorry for the long email...
Once I get some guidance, I can send some patches.

Thanks,
Raul
