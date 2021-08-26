Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A831C432BE
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18E8610A6
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 09:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbhHZJX2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Aug 2021 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhHZJX1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2021 05:23:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3CBC0613C1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Aug 2021 02:22:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o10so5342827lfr.11
        for <linux-mmc@vger.kernel.org>; Thu, 26 Aug 2021 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ln71NXDn7wvph7LBOORUowfvnMpMXm1vamjGgvVaYek=;
        b=MpW00whc4gH76YG1L2S+VOCGyGDkxXj6APkQiAkVq7cx5kM6PnAFO9wqRCovbtX7sX
         nBzQ0Mw6U7mwn3fLlmNoDDSwvKOQmdHyV2rrP2/2vWbi1xQGQ/lNbBUEEgqHO8lM9ANu
         +M7s9tA4d4tvb5YZug/b7/F69tDOgab5mn3t+I4UIehqc+JQSVPGADla+DZzqmBvdikq
         Hu3vnh4i1d5hCGEdqt1ziwfVji/QOZqEA9JXaJW7Om587Q5ncEMMlBf4H695uRAdWTNX
         +NHndArmyt2TX86gJIT2sLnNVOScwskL5k1rGP1amOLhKbGTDJoB0VvBeN84InV8MCDN
         XRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ln71NXDn7wvph7LBOORUowfvnMpMXm1vamjGgvVaYek=;
        b=IH4YNu26Wu8qOSQsm31bmn58qvBpmQSg0Kmid6y2gSyP5FtDkKXC3Ey9yN8tJbUezq
         12K4Dq/0T7QaM56aI7iHNHXvqaAeFr10Ce0evIX0KJgJ6H6pOpZUxrtNMrS1frIVRyCx
         lqwAMFoKv5Ylo2houh2/DmFqdIln9hV8aY2NosmoXyzqGDtTX/Y+9DpLDH3MWDOevIQh
         KnzoGLNDqbIx7qH4mgbNuskCtOluX7pwuPZINDLXjrVZFAosNqADZriGeiy3rIeZSMqB
         Bv3P2uOKCSc5UgcaR+zfoAPoGVlqknikXNgKFI30gQNq0ECOE1yFVocJMg8A6mG48PcS
         JbVg==
X-Gm-Message-State: AOAM532i1jvr9OvD7E1HqMHHVuosCU7CAVNauDWoIUq6/CXD1nkgXTbK
        om0hsIwXfzrnCBV+uddk1LBsQcCWFja0NtFQpiAVUQ==
X-Google-Smtp-Source: ABdhPJyHUPy/Ouf9Ph+Ka143JqGyEYFP5BB2Y1Ua+88WOLVsy4CllZ0Osm1JjtVWdZgl9HksM8p+j0LLtA23vf1IbTc=
X-Received: by 2002:a19:c107:: with SMTP id r7mr1952433lff.29.1629969758761;
 Thu, 26 Aug 2021 02:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
 <1628334401-6577-6-git-send-email-stefan.wahren@i2se.com> <3e8bfa67-e3fe-bcfd-1941-90cae7ed0176@arm.com>
In-Reply-To: <3e8bfa67-e3fe-bcfd-1941-90cae7ed0176@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Aug 2021 11:22:02 +0200
Message-ID: <CAPDyKFpGoMVywNFMskTTYYOvLZMK-1u2+5V_q1uW2H5AZJ_W7Q@mail.gmail.com>
Subject: Re: [PATCH V2 05/10] mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
 on BCM2711
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Aug 2021 at 08:36, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi,
>
>
> On 8/7/21 6:06 AM, Stefan Wahren wrote:
> > From: Nicolas Saenz Julienne <nsaenz@kernel.org>
> >
> > The controller doesn't seem to pick-up on clock changes, so set the
> > SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag to query the clock frequency
> > directly from the clock.
> >
> > Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >   drivers/mmc/host/sdhci-iproc.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> > index 032bf85..e7565c6 100644
> > --- a/drivers/mmc/host/sdhci-iproc.c
> > +++ b/drivers/mmc/host/sdhci-iproc.c
> > @@ -295,7 +295,8 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
> >   };
> >
> >   static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
> > -     .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> > +     .quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
> > +               SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >       .ops = &sdhci_iproc_bcm2711_ops,
> >   };
>
> I just noticed that this got merged to rc7, and it breaks the ACPI based
> rpi's because it causes the 100Mhz max clock to be overridden to the
> return from sdhci_iproc_get_max_clock() which is 0 because there isn't a
> OF/DT based clock device.

Thanks for reporting! I allow Stefan to respond in a day or two,
before I do a revert of it.

Kind regards
Uffe
