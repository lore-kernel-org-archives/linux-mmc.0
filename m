Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F09C11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3755761429
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGBNZW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhGBNZW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 09:25:22 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E9C061762
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jul 2021 06:22:49 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id s21so3021245vsq.10
        for <linux-mmc@vger.kernel.org>; Fri, 02 Jul 2021 06:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZ15K3S/1hphrSeMFsXZLHij0/U+9+Yp4xZew5uxF1U=;
        b=gR0Bo2R/we3qBUL2oOcrm/NRqu2zzxDbrYQuDoYWY75MtvJHkEHD1IO40GkzZWIHC3
         dMWQRXgHSd8ftl0IrNfQtye7DGfpySZiIBSyfYVsrEsbEH/HUDW204AfoBynbQ5UuyuC
         ZPslIuHke4dtw5RpbU1Z9uhKe7oR0JrjH5XTp6CgCcJWw/ofZlAJIdav/PDSnwMWi6n4
         OSkqTNSu5WrvxjG2lPE4WYyC+LCNczsGPP8NYpnjBg7uGm9yk4T5N8fMDfRM3lYrNYel
         Bq5uwNjK+xZwYUJCq+qtHZvP9bb4c4k3jOpx6PY8/wB/WFdLbEg4/GEqcsTN5RrARDzA
         wj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZ15K3S/1hphrSeMFsXZLHij0/U+9+Yp4xZew5uxF1U=;
        b=Wlr0Lx/nIY7dooF/vlALMsyxZU+aMmmAfRg6aurmoLD4lQSFf77qH328onLTb2l75S
         s/i38OmTQJmQ5PjTHq8RJZmNtOFIjH9IBMgGByDFljLSe1pQH6VZs3yvl2fIwFRa6yTm
         39JH4m3iyhDz7WrCR5qZGowRCDdsh6y4K/OVdByFG9VZCX+DTgYNDqPRIn4A+goLhmq1
         fIhd9X53ostsdmSD5DahKP3yNX753eaEnfpBnf15wufE+bM8CKcXjcBnUJsrF2iTP6K+
         YM75ZQuGKZE/L0SLc9fign6P2tYVaaIElMPUo5K3gggiLP14LFqAZiPfxMwTx43NT4yl
         8EKg==
X-Gm-Message-State: AOAM533U3rE3AjfD2TCSGCGKFmddC/ZnpCFoQiV4AbEr7A8TnYac+UOz
        xoGvQ0fvs+xSu9hiYzIBeKBwtUq19QC7e65PAsHD/A==
X-Google-Smtp-Source: ABdhPJyLP59DEtJyHgftkz8MDTDVZkaRiJRgske4DXopqT09J5h2lzJ26VEdHAbUMZr38K/w9z3dNfAGIuNLMFJlJHA=
X-Received: by 2002:a67:8783:: with SMTP id j125mr6537816vsd.42.1625232168370;
 Fri, 02 Jul 2021 06:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210624163045.33651-1-alcooperx@gmail.com> <CAPDyKFqwrX64W8t-PYrN-JYTttu6Bsfg40abPOOYFdZqDH0qMw@mail.gmail.com>
 <CAOGqxeUSLpC9+aGnMxEZpMTOvwMrb-3=11EGH48qdZvdioijHQ@mail.gmail.com>
In-Reply-To: <CAOGqxeUSLpC9+aGnMxEZpMTOvwMrb-3=11EGH48qdZvdioijHQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Jul 2021 15:22:11 +0200
Message-ID: <CAPDyKFqzcFkU-tWEMyFLVxBekXuWUMpV-gHCt=1wf-rY=Nz5gQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix warning message when accessing RPMB in
 HS400 mode
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2 Jul 2021 at 14:34, Alan Cooper <alcooperx@gmail.com> wrote:
>
> On Wed, Jun 30, 2021 at 10:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 24 Jun 2021 at 18:31, Al Cooper <alcooperx@gmail.com> wrote:
> > >
> > > When an eMMC device is being run in HS400 mode, any access to the
> > > RPMB device will cause the error message "mmc1: Invalid UHS-I mode
> > > selected". This happens as a result of tuning being disabled before
> > > RPMB access and then re-enabled after the RPMB access is complete.
> > > When tuning is re-enabled, the system has to switch from HS400
> > > to HS200 to do the tuning and then back to HS400. As part of
> > > sequence to switch from HS400 to HS200 the system is temporarily
> > > put into HS mode. When switching to HS mode, sdhci_get_preset_value()
> > > is called and does not have support for HS mode and prints the warning
> > > message and returns the preset for SDR12. The fix is to add support
> > > for MMC and SD HS modes to sdhci_get_preset_value().
> > >
> > > This can be reproduced on any system running eMMC in HS400 mode
> > > (not HS400ES) by using the "mmc" utility to run the following
> > > command: "mmc rpmb read-counter /dev/mmcblk0rpmb".
> > >
> > > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> >
> > I assume we want this for stable kernels, but it would be nice to add
> > a fixes tag as well.
> >
> > Do you know if there is a specific commit that this fixes?
>
> The function sdhci_get_preset_value(), which is missing the HS modes,
> was added in 52983382c74f5 for v3.9. Should I add a fixes tag for that
> commit?

Thanks for checking this! I have amended the patch to add a
fixes/stable tag and applied it for fixes.

Kind regards
Uffe

>
> Thanks
> Al
>
> >
> > Kind regards
> > Uffe
> >
> > > ---
> > >  drivers/mmc/host/sdhci.c | 4 ++++
> > >  drivers/mmc/host/sdhci.h | 1 +
> > >  2 files changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index bf238ade1602..6b39126fbf06 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -1812,6 +1812,10 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
> > >         u16 preset = 0;
> > >
> > >         switch (host->timing) {
> > > +       case MMC_TIMING_MMC_HS:
> > > +       case MMC_TIMING_SD_HS:
> > > +               preset = sdhci_readw(host, SDHCI_PRESET_FOR_HIGH_SPEED);
> > > +               break;
> > >         case MMC_TIMING_UHS_SDR12:
> > >                 preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
> > >                 break;
> > > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > > index 0770c036e2ff..960fed78529e 100644
> > > --- a/drivers/mmc/host/sdhci.h
> > > +++ b/drivers/mmc/host/sdhci.h
> > > @@ -253,6 +253,7 @@
> > >
> > >  /* 60-FB reserved */
> > >
> > > +#define SDHCI_PRESET_FOR_HIGH_SPEED    0x64
> > >  #define SDHCI_PRESET_FOR_SDR12 0x66
> > >  #define SDHCI_PRESET_FOR_SDR25 0x68
> > >  #define SDHCI_PRESET_FOR_SDR50 0x6A
> > >
> > > base-commit: 7426cedc7dad67bf3c71ea6cc29ab7822e1a453f
> > > --
> > > 2.17.1
> > >
