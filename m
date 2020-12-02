Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800F8C83012
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 16:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3324B21D42
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 16:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgLBQBJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 11:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgLBQBI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2020 11:01:08 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCF9C0613D6
        for <linux-mmc@vger.kernel.org>; Wed,  2 Dec 2020 08:00:28 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v22so4452612edt.9
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1d9v9FbmrBLfRTd9F4a7mgdLXbSqWogwPCBXl7Mzc/E=;
        b=cMVqAU1juZXBXpExYQanZKHwWr7HaCYrQPV5M4kfl1N5tD3R03ZARLtLI5Aq6DRAya
         qigzgDQWETI47kuEkAJU7AZkbHS0GCp8Xn3vY9MmzKL/lVUtm2cUNOYMU3/2o0DjA7Yn
         9akAMUIxm2DjcYd3Lcxdj55/iRaTqHG/Py19c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1d9v9FbmrBLfRTd9F4a7mgdLXbSqWogwPCBXl7Mzc/E=;
        b=ZgcS6bYG+MCKga9ppFtcTKe/oWWHu8t12PuzUugb3mvAW/YkYtKhPw6r7iAABL636W
         h96iJBbIb3NN0qzmlirsp9xMQ9zdLpX06hvarAuKE4zhCXOHp2FXb5mWniGjE4wp6tV7
         LlOJFKPul/7RBjcqjhToFNDTJOBHLb6+gek2uKOiTrXmDs9ir4WYHoKBfV9B7yAjyGDY
         g74U6PHBTRtS6JBv6kGwARjDYDhFgKNmfK7wIm0cJ0VHaUf/xUNg1F2nplSQgQjyBseB
         bNH8BDXRmrK4Dt7Nhb720AlDuL52+PeLEdUqpTSuA/PUDJ3ZZUzQ/mn4C0t2f3fjWLNs
         /wIQ==
X-Gm-Message-State: AOAM532lU2D6sSufMwjbnqG5zz1NjpVm7sE7lVWtTuSs8mSbp6nsx+ni
        pqXp6njCZBFcdQV+5ACL5Q3lpBoVYLZkTg==
X-Google-Smtp-Source: ABdhPJyFttGrgdN/nKiu36Lw4dcCpdxovvDr2/ubNZfbuBMCjLZpfRP3Vwtv1ejW9oCu0b3HfsX8aQ==
X-Received: by 2002:a50:99cb:: with SMTP id n11mr554188edb.362.1606924826538;
        Wed, 02 Dec 2020 08:00:26 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id h23sm204128ejg.37.2020.12.02.08.00.25
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 08:00:25 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id v22so4452473edt.9
        for <linux-mmc@vger.kernel.org>; Wed, 02 Dec 2020 08:00:25 -0800 (PST)
X-Received: by 2002:aa7:ce94:: with SMTP id y20mr513212edv.361.1606924824683;
 Wed, 02 Dec 2020 08:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20201027084612.528301-1-victording@google.com> <CAPDyKFo=jA84Zr9AM7sXR_VxpGsi9n-aGJJMRcY7uFBcRWrf4g@mail.gmail.com>
In-Reply-To: <CAPDyKFo=jA84Zr9AM7sXR_VxpGsi9n-aGJJMRcY7uFBcRWrf4g@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 2 Dec 2020 09:00:13 -0700
X-Gmail-Original-Message-ID: <CAHQZ30DNK6aWy_XTtOAv9J39qdyvp57HZG=jk3d99fuOsbf4eg@mail.gmail.com>
Message-ID: <CAHQZ30DNK6aWy_XTtOAv9J39qdyvp57HZG=jk3d99fuOsbf4eg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400
 driver strength
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Victor Ding <victording@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks Victor and Ulf!

On Tue, Oct 27, 2020 at 7:42 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 27 Oct 2020 at 09:46, Victor Ding <victording@google.com> wrote:
> >
> > From: Raul E Rangel <rrangel@chromium.org>
> >
> > This change will allow platform designers better control over signal
> > integrity by allowing them to tune the HS200 and HS400 driver strengths.
> >
> > The driver strength was previously hard coded to A to solve boot
> > problems with certain platforms. This driver strength does not
> > universally apply to all platforms so we need a knob to adjust it.
> >
> > All older platforms currently have the SDR104 preset hard coded to A in
> > the firmware. This means that switching from the hard coded value in
> > the kernel to reading the SDR104 preset is a no-op for these platforms.
> > Newer platforms will have properly set presets. So this change will
> > support both new and old platforms.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > Signed-off-by: Victor Ding <victording@google.com>
>
> Applied for next, thanks!
>
> Note that I amended the patch to fix the white-space issue, as pointed
> out by Adrian.
>
> Kind regards
> Uffe
>
>
> >
> > ---
> >
> > Changes in v2:
> > By Victor Ding <victording@google.com>
> >  - Rebased the patch by using FIELD_GET for preset value bit masks.
> >  - (No functional changes).
> >
> > The original patch was developed by Raul E Rangel.
> > https://patchwork.kernel.org/project/linux-mmc/patch/20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid/
> >
> >  drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 36 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> > index 54205e3be9e8..225cb34cf1b9 100644
> > --- a/drivers/mmc/host/sdhci-acpi.c
> > +++ b/drivers/mmc/host/sdhci-acpi.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (c) 2012, Intel Corporation.
> >   */
> >
> > +#include <linux/bitfield.h>
> >  #include <linux/init.h>
> >  #include <linux/export.h>
> >  #include <linux/module.h>
> > @@ -545,10 +546,42 @@ struct amd_sdhci_host {
> >
> >  static int amd_select_drive_strength(struct mmc_card *card,
> >                                      unsigned int max_dtr, int host_drv,
> > -                                    int card_drv, int *drv_type)
> > +                                    int card_drv, int *host_driver_strength)
> >  {
> > -       *drv_type = MMC_SET_DRIVER_TYPE_A;
> > -       return MMC_SET_DRIVER_TYPE_A;
> > +       struct sdhci_host *host = mmc_priv(card->host);
> > +       u16 preset, preset_driver_strength;
> > +
> > +       /*
> > +        * This method is only called by mmc_select_hs200 so we only need to
> > +        * read from the HS200 (SDR104) preset register.
> > +        *
> > +        * Firmware that has "invalid/default" presets return a driver strength
> > +        * of A. This matches the previously hard coded value.
> > +        */
> > +       preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
> > +       preset_driver_strength = FIELD_GET(SDHCI_PRESET_DRV_MASK, preset);
> > +
> > +       /*
> > +        * We want the controller driver strength to match the card's driver
> > +        * strength so they have similar rise/fall times.
> > +        *
> > +        * The controller driver strength set by this method is sticky for all
> > +        * timings after this method is called. This unfortunately means that
> > +        * while HS400 tuning is in progress we end up with mismatched driver
> > +        * strengths between the controller and the card. HS400 tuning requires
> > +        * switching from HS400->DDR52->HS->HS200->HS400. So the driver mismatch
> > +        * happens while in DDR52 and HS modes. This has not been observed to
> > +        * cause problems. Enabling presets would fix this issue.
> > +        */
> > +       *host_driver_strength = preset_driver_strength;
> > +
> > +       /*
> > +        * The resulting card driver strength is only set when switching the
> > +        * card's timing to HS200 or HS400. The card will use the default driver
> > +        * strength (B) for any other mode.
> > +        */
> > +       return preset_driver_strength;
> > +
> >  }
> >
> >  static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
> > --
> > 2.29.0.rc2.309.g374f81d7ae-goog
> >
