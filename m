Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB22C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 09:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiGLJ63 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiGLJ63 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 05:58:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18533AAB04
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 02:58:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d12so13041425lfq.12
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37VTfuLmrmrfifjGIyTRdObjI/MKcJWQ1tpeTXrM7yE=;
        b=UURjb34NTwrnFBr9T0FFPI+3EiJ0S9Jci1LVvi6IinmRpPDwTTTQPpvuA6FgGpsFOv
         vcH2Ec7iBf6xYHsRRyt9C0KVfOPbjVhljQWAItp2WhFF/W4Eq/803HOKP4sl5BMxUaGJ
         gZXzDyhOjLpp+XeP6wXCiyO3u6ixxYDfqVH8d16sECEtJx7yQQku/JW8nIsiC3l4JVJw
         5CA3tn47cIgWcP+O5BQtGdmN2+ErI92vgd+kKCKe0zrdrtTN5dYnW+rf/2+UheLdWGSp
         /xXvrAbgDdp7yWgQx/Ju05a/Zjs2bcSodlXzw1k809jSGkIF1Rb6FkMIMXvdLoWRCufE
         Zs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37VTfuLmrmrfifjGIyTRdObjI/MKcJWQ1tpeTXrM7yE=;
        b=XGkzaJDksloIx2nmKKy4B5OFWRq7MPwQok2ezbJJI0Y75OcA5DIP+FKLBObmcm0N6f
         8vMEFFfNprGs43V2Y3Dr31At/qOAXp2OofIbJALntN8+vqFHEqOIVm11X2GXNMc1QcE6
         y3QcuHty8srxVPnNXzCXd34UsG0rH7PbJJU57wvZM2uU3AiUcrrinzqUxmkzZiGuARNX
         cXVdhXrL9LINFO+4QayM4lr57nXsS6zxf5fn2+92RxpM8gaBtrauW4sZcKtG0961Jpsz
         2wswOK3/Ttu7FylkOGrzscklDtgK1wlDjcm9jE3oZ0hYyQqUMYSk8WnwB+VVqUYRlZJ2
         QB8g==
X-Gm-Message-State: AJIora9UNWXR7NcZcKT9+VSVMB38Dj0+p5Hd5sWqBX+JwAyQ1NiiQSiY
        Nf240DkWOQBIJjNexYEA9AaizBbEG1GmrXxkzzLvWA==
X-Google-Smtp-Source: AGRyM1tF1rH3gCKCxA0w4to0pXkYFZRfaL8jzDdehbvLxjkPzOaPtTNJfkry8AFrEL4erx6bV6uZqFu7tTuU7atW/bU=
X-Received: by 2002:a05:6512:ad6:b0:481:1a75:44c with SMTP id
 n22-20020a0565120ad600b004811a75044cmr14963318lfu.167.1657619906419; Tue, 12
 Jul 2022 02:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220622051215.34063-1-tony@atomide.com> <CAPDyKFpNBQK3QZk-+5-4YB8=2O3sxwj5-nThd00ayp7FHSjUSA@mail.gmail.com>
 <YrlKjZHJ37PHy9af@atomide.com>
In-Reply-To: <YrlKjZHJ37PHy9af@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 11:57:50 +0200
Message-ID: <CAPDyKFqxSuuMtmfqwSojPqfHhv4RDLtRQf+JbOGZJkxVhDDAtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-omap: Fix a lockdep warning for PM
 runtime init
To:     Tony Lindgren <tony@atomide.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Jun 2022 at 08:13, Tony Lindgren <tony@atomide.com> wrote:
>
> * Ulf Hansson <ulf.hansson@linaro.org> [220623 12:55]:
> > On Wed, 22 Jun 2022 at 07:12, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > We need runtime PM enabled early in probe before sdhci_setup_host() for
> > > sdhci_omap_set_capabilities(). But on the first runtime resume we must
> > > not call sdhci_runtime_resume_host() as sdhci_setup_host() has not been
> > > called yet. Let's check for an initialized controller like we already do
> > > for context restore to fix a lockdep warning.
> >
> > Thanks for explaining the background to the problem. However, looking
> > a bit closer I am worried that the error path in ->probe() is broken
> > too.
> >
> > It seems in the error path, at the label "err_rpm_put", there is a
> > call to pm_runtime_put_autosuspend(). This doesn't really guarantee
> > that the ->runtime_suspend() callback will be invoked, which I guess
> > is the assumption, don't you think?
>
> OK I'll check and send a separate patch for that.
>
> > That said, I wonder if it would not be easier to convert the ->probe()
> > function to make use of pm_runtime_get_noresume() and
> > pm_runtime_set_active() instead. In this way the ->probe() function
> > becomes responsible of turning on/off the resources "manually" that it
> > requires to probe (and when it fails to probe), while we can keep the
> > ->runtime_suspend|resume() callbacks simpler.
> >
> > Did that make sense to you?
>
> Simpler would be better :) We need to call pm_runtime_get_sync() at some
> point though to enable the parent device hierarchy.

Is there a parent device that has runtime PM enabled?

In other cases, it should be fine to use pm_runtime_set_active()
during ->probe().

> Just calling the
> sdhci_omap runtime functions is not enough. And we still need to check
> for the valid context too. Also I'm not convinced that calling
> pm_runtime_get_sync() on the parent device would do the right thing on
> old omap3 devices without bigger changes..

I certainly agree. The parent should not be managed directly by the
sdhci driver.

One thing that can be discussed though, is whether
pm_runtime_set_active() actually should runtime resume the parent,
which would make the behaviour consistent with how suppliers are being
treated.

> But maybe you have some better
> ideas that I'm not considering.

I can try to draft a patch, if that would help? But, let's finalize
the discussion above first (apologize for the delay).

Kind regards
Uffe
