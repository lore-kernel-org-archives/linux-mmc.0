Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A822C43334
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jul 2022 10:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbiGMKyo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jul 2022 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbiGMKyn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2022 06:54:43 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC762FF580
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:54:41 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k1so6452274ilu.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2022 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24vatrNQy4mAwOD26diK3DSgxu+qePazInIA4QqKNZk=;
        b=jfPZqHtoZbCOAxAg1WVYPBaHFTGcLSOGYzT+uhgLdeaz/mz+HHbRWMu5ugQaM3N1/b
         6WPI8XXLnORiaMuhQNWtbu+lIjiHz1915u6o+Quvz8WBxsOHGMRWVgE3i2Dcj8faF/Kh
         L0M21NTtlwbhswZlUuy/Xvje11Bc75+yhKHVTPGIuRzMh+IYHyNarfx9yw39ojFTIpq/
         57RC1cGLmEwFCmo0uFjJiKnHK4CbItqPrfDrPaX5T7q6E2DlG2Ca/fZhzwj3HFJ8lZJO
         cw1I8PUdk8FlDtecDxAIX5dNiFJliz7AeqlrFu7oswhzOrNgXDrS+ciVlsAlVfhsYr/r
         U9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24vatrNQy4mAwOD26diK3DSgxu+qePazInIA4QqKNZk=;
        b=kIsFCJHj1O1ASMCTlnIlTR4wwlNDIBJd9JyyT4/86qqOE31B6K3Y7FfOq4eQnVVTWh
         /OMNv6ik95oy7KCS7YmMkfWHs3iF84al7gx5mXaGiZTSU0u+LXC2s7RXGUJJ3TZrLgOP
         wwNyU2wIKk33B5hZq/2vvwTxxZqUpZXD3zg9/GgY7yKEQD/z75gkOw1fBJFNbttj5Dkb
         aeHGZagysMXxC1ZQoeyahI3V16dSHRNMlsZl9xwxcV87Cym7Moev4EOZHrwYrbSphBZq
         UaFmBXf9vYh6LnyRE9ZjICCiMNTSZ3mhStBBEkaC7U1t9/GngAZa9eA1c0rdamsDGjUt
         83fQ==
X-Gm-Message-State: AJIora/0ixYxueyAJp1ML4yMdHJmBBC7CoXfFlQAsBSy07CbUGSejiK8
        bDc+Qx05B4ju98avoCDYOg1S17VyWuELgIJhimncpg==
X-Google-Smtp-Source: AGRyM1v1QI/iq6qY76yqPD/R27P3k4+BLtKUnZOAwoRG74WvRGL2i+kIVVkgi1EoGXhAzXt3jqv8++rgnPFnESaU8Ls=
X-Received: by 2002:a05:6e02:10d1:b0:2dc:2443:f651 with SMTP id
 s17-20020a056e0210d100b002dc2443f651mr1492776ilj.172.1657709680990; Wed, 13
 Jul 2022 03:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220622051215.34063-1-tony@atomide.com> <CAPDyKFpNBQK3QZk-+5-4YB8=2O3sxwj5-nThd00ayp7FHSjUSA@mail.gmail.com>
 <YrlKjZHJ37PHy9af@atomide.com> <CAPDyKFqxSuuMtmfqwSojPqfHhv4RDLtRQf+JbOGZJkxVhDDAtQ@mail.gmail.com>
 <Ys1msXeqPipP7J5g@atomide.com>
In-Reply-To: <Ys1msXeqPipP7J5g@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jul 2022 12:54:04 +0200
Message-ID: <CAPDyKFrT4hR_HYAsA77ea6j7YMvZ4941aXpN28r_GgF5VLMoEw@mail.gmail.com>
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

On Tue, 12 Jul 2022 at 14:18, Tony Lindgren <tony@atomide.com> wrote:
>
> * Ulf Hansson <ulf.hansson@linaro.org> [220712 09:52]:
> > On Mon, 27 Jun 2022 at 08:13, Tony Lindgren <tony@atomide.com> wrote:
> > >
> > > * Ulf Hansson <ulf.hansson@linaro.org> [220623 12:55]:
> > > > On Wed, 22 Jun 2022 at 07:12, Tony Lindgren <tony@atomide.com> wrote:
> > > > >
> > > > > We need runtime PM enabled early in probe before sdhci_setup_host() for
> > > > > sdhci_omap_set_capabilities(). But on the first runtime resume we must
> > > > > not call sdhci_runtime_resume_host() as sdhci_setup_host() has not been
> > > > > called yet. Let's check for an initialized controller like we already do
> > > > > for context restore to fix a lockdep warning.
> > > >
> > > > Thanks for explaining the background to the problem. However, looking
> > > > a bit closer I am worried that the error path in ->probe() is broken
> > > > too.
> > > >
> > > > It seems in the error path, at the label "err_rpm_put", there is a
> > > > call to pm_runtime_put_autosuspend(). This doesn't really guarantee
> > > > that the ->runtime_suspend() callback will be invoked, which I guess
> > > > is the assumption, don't you think?
> > >
> > > OK I'll check and send a separate patch for that.
> > >
> > > > That said, I wonder if it would not be easier to convert the ->probe()
> > > > function to make use of pm_runtime_get_noresume() and
> > > > pm_runtime_set_active() instead. In this way the ->probe() function
> > > > becomes responsible of turning on/off the resources "manually" that it
> > > > requires to probe (and when it fails to probe), while we can keep the
> > > > ->runtime_suspend|resume() callbacks simpler.
> > > >
> > > > Did that make sense to you?
> > >
> > > Simpler would be better :) We need to call pm_runtime_get_sync() at some
> > > point though to enable the parent device hierarchy.
> >
> > Is there a parent device that has runtime PM enabled?
>
> Yes there is the interconnect target module device as the parent with
> runtime PM enabled. So the sdhci-omap driver needs the parent enabled.

I see, thanks for clarifying!

>
> > In other cases, it should be fine to use pm_runtime_set_active()
> > during ->probe().
>
> Yup, this can't be done here though AFAIK. Something needs to enable
> runtime PM for the parent device to have the sdhci registers accessible.
>
> > > Just calling the
> > > sdhci_omap runtime functions is not enough. And we still need to check
> > > for the valid context too. Also I'm not convinced that calling
> > > pm_runtime_get_sync() on the parent device would do the right thing on
> > > old omap3 devices without bigger changes..
> >
> > I certainly agree. The parent should not be managed directly by the
> > sdhci driver.
>
> OK
>
> > One thing that can be discussed though, is whether
> > pm_runtime_set_active() actually should runtime resume the parent,
> > which would make the behaviour consistent with how suppliers are being
> > treated.
>
> Hmm yeah that's an interesting idea.
>
> > > But maybe you have some better
> > > ideas that I'm not considering.
> >
> > I can try to draft a patch, if that would help? But, let's finalize
> > the discussion above first (apologize for the delay).
>
> OK. Should we apply the $subject patch to fix the splat meanwhile
> though? Seems like what you're suggesting may take some more discussion
> on the mailing lists.

Yep, that seems like a reasonable way forward. I keep you cced if/when
I propose something that can replace it.

So I applied the v2 for fixes and by adding a stable tag, thanks!

Kind regards
Uffe
