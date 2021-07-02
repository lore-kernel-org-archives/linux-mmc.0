Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556D5C11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 12:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E9F613D2
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 12:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhGBMhF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhGBMhE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2021 08:37:04 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18EBC0613DD;
        Fri,  2 Jul 2021 05:34:25 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id i13so9573453ilu.4;
        Fri, 02 Jul 2021 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgKtcyeiy8EN/ZB2UkGxHv/hs6NpszraEHFim7BARfA=;
        b=HebwOk1mxXfT2pL9Oq0eqEi4AEFu12hA0hN+krojgMl7MViI2o0gSELwVMRrgz8rIF
         E0sH65Kg6sCDza6AS2FIW4LxQzeX36aCXxgARn6UXjuiKdhnGpsonOcgg4T1MW5AGfZ4
         8u6TUh0NY8zW5I3rr1KuqXUk1j70b+yRQY3WRW3t/NM6u2XHs8POGVYYCOPfd4ORC/y3
         vXYhQNgSiC5rkDPEdfbc4i7hIjVRKFUvbL6p+oVpzrycFF3NF094+ffkLQyfxivd17nQ
         VPNKQpwfg1MLcDr3Xs8BZ9sgRTCN+lZEEyjppiJp/PAvywe2sHGjV7Zg0EiUnvwpXlVQ
         vfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgKtcyeiy8EN/ZB2UkGxHv/hs6NpszraEHFim7BARfA=;
        b=B51JDFCcB+NsL2x0tp09LGrC55Djd2lrG4+LclxtTsGI6jVeVhtO73wVrn4Jkbef+l
         8z1WblRO4TU1UJnX/z51hsjBck30QSJZqQe1785UUk52MjQ0IBWirkQ5KcyLhbPf6Xa2
         6962fzzHmPeFTuM9e/Cqiu4EURg02wqR/a82+M/OiY1xebfYUh008/wFO1jB60YTVg0d
         736LIzCeo+/x56YVXtZpDnZ7QMwQ1ETrh/5TOM7At9ssx19TmBC78PflpVAIGs6I4MhT
         +CPQ2gleTEUbX/EcBYwlHIjbmrhh7G5qHB1ygXJibaesYxIrnzupsS3oU1YuV5WmBnqT
         CnnA==
X-Gm-Message-State: AOAM532fFL5bRHu6+eU56ZH+dszXaQWgWVz+NPMGi7D0ikNYE6YXcmdc
        pojQaDtVbUjJBOySRdF3y1RhoRLPOe6XZ/z7lBWlv5mK3KTTEg==
X-Google-Smtp-Source: ABdhPJyMKGDbzvDVc9VsROLvgaU9RDUJpKR210sQzIBmRHGTIzm6YtVqvumYsvbko+32KKF9H+gShAM3DlZ56KCKEf8=
X-Received: by 2002:a92:1e08:: with SMTP id e8mr83309ile.10.1625229265263;
 Fri, 02 Jul 2021 05:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210624163045.33651-1-alcooperx@gmail.com> <CAPDyKFqwrX64W8t-PYrN-JYTttu6Bsfg40abPOOYFdZqDH0qMw@mail.gmail.com>
In-Reply-To: <CAPDyKFqwrX64W8t-PYrN-JYTttu6Bsfg40abPOOYFdZqDH0qMw@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Fri, 2 Jul 2021 08:33:48 -0400
Message-ID: <CAOGqxeUSLpC9+aGnMxEZpMTOvwMrb-3=11EGH48qdZvdioijHQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix warning message when accessing RPMB in
 HS400 mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 30, 2021 at 10:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 24 Jun 2021 at 18:31, Al Cooper <alcooperx@gmail.com> wrote:
> >
> > When an eMMC device is being run in HS400 mode, any access to the
> > RPMB device will cause the error message "mmc1: Invalid UHS-I mode
> > selected". This happens as a result of tuning being disabled before
> > RPMB access and then re-enabled after the RPMB access is complete.
> > When tuning is re-enabled, the system has to switch from HS400
> > to HS200 to do the tuning and then back to HS400. As part of
> > sequence to switch from HS400 to HS200 the system is temporarily
> > put into HS mode. When switching to HS mode, sdhci_get_preset_value()
> > is called and does not have support for HS mode and prints the warning
> > message and returns the preset for SDR12. The fix is to add support
> > for MMC and SD HS modes to sdhci_get_preset_value().
> >
> > This can be reproduced on any system running eMMC in HS400 mode
> > (not HS400ES) by using the "mmc" utility to run the following
> > command: "mmc rpmb read-counter /dev/mmcblk0rpmb".
> >
> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
>
> I assume we want this for stable kernels, but it would be nice to add
> a fixes tag as well.
>
> Do you know if there is a specific commit that this fixes?

The function sdhci_get_preset_value(), which is missing the HS modes,
was added in 52983382c74f5 for v3.9. Should I add a fixes tag for that
commit?

Thanks
Al

>
> Kind regards
> Uffe
>
> > ---
> >  drivers/mmc/host/sdhci.c | 4 ++++
> >  drivers/mmc/host/sdhci.h | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index bf238ade1602..6b39126fbf06 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1812,6 +1812,10 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
> >         u16 preset = 0;
> >
> >         switch (host->timing) {
> > +       case MMC_TIMING_MMC_HS:
> > +       case MMC_TIMING_SD_HS:
> > +               preset = sdhci_readw(host, SDHCI_PRESET_FOR_HIGH_SPEED);
> > +               break;
> >         case MMC_TIMING_UHS_SDR12:
> >                 preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
> >                 break;
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index 0770c036e2ff..960fed78529e 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -253,6 +253,7 @@
> >
> >  /* 60-FB reserved */
> >
> > +#define SDHCI_PRESET_FOR_HIGH_SPEED    0x64
> >  #define SDHCI_PRESET_FOR_SDR12 0x66
> >  #define SDHCI_PRESET_FOR_SDR25 0x68
> >  #define SDHCI_PRESET_FOR_SDR50 0x6A
> >
> > base-commit: 7426cedc7dad67bf3c71ea6cc29ab7822e1a453f
> > --
> > 2.17.1
> >
