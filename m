Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B450C433E3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FB6206F0
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L9yaogzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHXRFe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgHXRF2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 13:05:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB16C061573
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 10:05:27 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id di22so8719398edb.12
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wTJkIkxbXIgwIl8MHkqn1eCCPoicEFVczFMAdlA9FQY=;
        b=L9yaogzVkIT246BRAwQQXcOloEYovkSMgORBPHnx3ge6CzGQmepCwKSEii6xP6ti/U
         wrY6gioQNUIroWnSgbKDdlSaFMMjUvvdGhQlTf80SvG4bRcGRv7Ijmx6XjGRvkEefAAl
         ixQwS2Pb9Kw/8i2BD321pK+GDPY9mwbrlOBi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wTJkIkxbXIgwIl8MHkqn1eCCPoicEFVczFMAdlA9FQY=;
        b=VdNJlrDMtJfGHfLnFRcP4SSAas4o9nb+khKaO21A5oWX1aYjsSpogz33LhYHCB5JrT
         +gVJHn3FRVYQfVtmkpDRXhy3Tu7jTbviyaUJGzp0e53VBt7XchCTB+tDVzwqK4g5IyX0
         ENlPE6CV8ZGF8/Hb3jU7Js8NYdF5olHwLSjU5aG3I1ElZddGejFapAoqBU45yngBvvH7
         N9AxEy/l9CTS+2v1geflegaI54JXJsIFCBHVspFAgjVSIGY6lanEWPsoFa6CIz50A0tQ
         VYI1WEZnaNuubhqWy2Z0v9IZZEs3ulkWHpD5npi9Ud5q1md3CLMC8P91JplVOT5GA031
         QXQw==
X-Gm-Message-State: AOAM532R09EPu1LXN/S/RRlbbAZQvDsIiD+jGg4kwUG89vuk+V+IESQc
        vJIMGCiil0+n9voU9YXvHokSB5Njoxvfjg==
X-Google-Smtp-Source: ABdhPJyHYtW7y78gDh6ZynKoS8Q3lkeDj0EmFW3YZDRaxxVL5p1DeQk5Q5GC1R+bl/4DZbZ296PGkA==
X-Received: by 2002:a05:6402:17d8:: with SMTP id s24mr5939474edy.61.1598288721629;
        Mon, 24 Aug 2020 10:05:21 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a26sm10493917eju.83.2020.08.24.10.05.20
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 10:05:20 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id c8so5333866edn.8
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 10:05:20 -0700 (PDT)
X-Received: by 2002:a05:6402:2033:: with SMTP id ay19mr6249557edb.361.1598288719552;
 Mon, 24 Aug 2020 10:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30ApB3BEzgLv=EtzB_Kpnsfsr7-s+JcYmyzXN3j7OF80-w@mail.gmail.com>
 <671d418f-f411-ad94-4469-b2f0eb6cd693@intel.com>
In-Reply-To: <671d418f-f411-ad94-4469-b2f0eb6cd693@intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 24 Aug 2020 11:05:08 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CWXWJw50g-wMKRQr0Q6-rcE342O12J=aand9XtFY1CEA@mail.gmail.com>
Message-ID: <CAHQZ30CWXWJw50g-wMKRQr0Q6-rcE342O12J=aand9XtFY1CEA@mail.gmail.com>
Subject: Re: HS400 tuning and presets
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 20, 2020 at 2:56 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 20/08/20 1:56 am, Raul Rangel wrote:
> > I noticed some odd things with the MMC/SDHCI code while debugging an
> > HS400 tuning issue.
> >
> > 1) Is it expected that we never enable SDHCI_CTRL_PRESET_VAL_ENABLE
> > for an eMMC running at HS200 or HS400?
>
> Seems like an oversight.  eMMC transfer modes are not supported by the SDHCI
> specification, and many drivers use SDHCI_QUIRK2_PRESET_VALUE_BROKEN, so it
> looks like it has never been noticeable.
>

Thanks for the confirmation. I'll get a patch sent to fix it.

> > The flow for enabling HS400 is: Legacy -> HS200 -> Perform Tuning ->
> > HS -> HS400.
> > Looking at [sdhci_set_ios](https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci.c;l=2019),
> > it looks like it's responsible for enabling presets.
> >
> >     if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&
> >                     ((ios->timing == MMC_TIMING_UHS_SDR12) ||
> >                      (ios->timing == MMC_TIMING_UHS_SDR25) ||
> >                      (ios->timing == MMC_TIMING_UHS_SDR50) ||
> >                      (ios->timing == MMC_TIMING_UHS_SDR104) ||
> >                      (ios->timing == MMC_TIMING_UHS_DDR50) ||
> >                      (ios->timing == MMC_TIMING_MMC_DDR52))) {
> >             u16 preset;
> >
> >             sdhci_enable_preset_value(host, true);
> >             preset = sdhci_get_preset_value(host);
> >             ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
> >                     >> SDHCI_PRESET_DRV_SHIFT;
> >     }
> >
> > MMC_TIMING_MMC_HS200 and MMC_TIMING_MMC_HS400 are missing from the
> > conditions, so we never enable presets. This means that by default
> > (only 2 controllers provide select_drive_strength) we use drive
> > strength B for both the card and the controller.
> >
> >     int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
> >                                   int card_drv_type, int *drv_type)
> >     {
> >             struct mmc_host *host = card->host;
> >             int host_drv_type = SD_DRIVER_TYPE_B;
> >
> >             *drv_type = 0;
> >
> >             if (!host->ops->select_drive_strength)
> >                     return 0;
> >             ...
> >     }
> >
> > Here is a trace log showing HS400 initialization: https://0paste.com/79874
> >
> > 2) When performing HS400 tuning we end up enabling presets.
> > The re-tuning sequence is: HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
> >
> > So when we transition to DDR52 the code above enables presets. You can
> > see this happening in this trace log: https://0paste.com/79875. Look
> > at timestamp 1926.173800.
> >
> > This means that the card and controller have the potential to have
> > mismatching drive strengths. This can be seen at timestamp
> > 1926.175813.The HS200 preset on my controller is configured to A, but
> > the card would be set up as B (if the controller didn't override
> > select_drive_strength).
> >
> > Should we be enabling presets for HS200/HS400 (and potentially
> > MMC_HS), or should we remove MMC_DDR52 from the condition above?
>
> The only things that matter are:
> 1. don't break other drivers
> 2. do make it work for your driver
>
> So we can't universally enable presets for HS200 and HS400, nor remove
> MMC_DDR52, but we can do something to make it work for you.
>

Makes sense. I'll see what direction I want to take.

> >
> > It looks like 0dafa60eb2506 ("mmc: sdhci: also get preset value and
> > driver type for MMC_DDR52") was the CL that added MMC_DDR52 to the
> > condition.
> >
> > 3) How do we ensure that card drive strength and controller drive
> > strength stay in sync when presets are enabled?
>
> Is that your requirement? Which driver is it?

We want to provide a knob for our OEMs so they can choose the best
drive strength for their design. Right now for the AMD controller it's
hard coded to A:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci-acpi.c;l=542

I was hoping to use the SDHCI presets to not introduce a non-standard
convention of passing in the drive strength. I wasn't aware that the
SDHCI driver doesn't use presets for eMMC. So maybe the path of least
resistance is to add an ACPI property that is read by
amd_select_drive_strength. Like `mmc_of_parse` does with
`fixed-emmc-driver-type`. This ensures that both the card and
controller drive strengths are set.

It looks like `host->fixed_drv_type` is only for the card. It doesn't
set the same drive strength on the controller. Is this intentional?

    static void mmc_select_driver_type(struct mmc_card *card)
    {
            int card_drv_type, drive_strength, drv_type = 0;
            int fixed_drv_type = card->host->fixed_drv_type;

            card_drv_type = card->ext_csd.raw_driver_strength |
                            mmc_driver_type_mask(0);

            if (fixed_drv_type >= 0) <--- Never updates drv_type
                    drive_strength = card_drv_type &
mmc_driver_type_mask(fixed_drv_type)
                                     ? fixed_drv_type : 0;
            else
                    drive_strength = mmc_select_drive_strength(card,

card->ext_csd.hs200_max_dtr,

card_drv_type, &drv_type);

            card->drive_strength = drive_strength;

            if (drv_type)
                    mmc_set_driver_type(card->host, drv_type);
    }

>
> > Right now mmc_select_driver_type is only called from
> > `mmc_select_hs400es` and `mmc_select_hs200`. `mmc_select_driver_type
> > doesn't currently take the timing into account when making a decision.
> > Only two devices currently provide the `select_drive_strength`
> > override, so we are setting the card to drive strength B for most
> > controllers.
> >
> > Should we modify mmc_select_drive_strength to take in the target
> > timing so it can return the correct card drive strength. We could then
> > add an sdhci_select_drive_strength that queries the preset registers
> > (if enabled) and returns the target drive strength.
> >
> > 4) Should we be calling `mmc_select_driver_type` from
> > `mmc_hs400_to_hs200` and `mmc_hs200_to_hs400` during the transitions?
>
> The same driver strength continues to be used for HS200 and HS400 i.e.
> card->driver_strength
>
> > Or do we not care?
> >
> > Sorry for the long email...
> > Once I get some guidance, I can send some patches.
>
> Generally people first want to know what problem you are trying to solve.
I was just thinking we need to keep the drive strengths in sync
between controller and card.


Thanks for reading my long email :)
