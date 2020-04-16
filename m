Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E666C352BE
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 15:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 268EE22241
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jp2zHDuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633392AbgDPPVC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633284AbgDPPVB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 11:21:01 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F35C061A0C
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 08:21:00 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 1so2621854vsl.9
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQLFi9MaLL2nmNEDJgI1po1sqK0yDrrmYzbRTv6Uzug=;
        b=Jp2zHDuq1xGMtJ7LpM7ZSar0MqikjkAJd6KbYVKnCGgEY8V+AaPbfH0KzGn2fCfiue
         uo5oXB31OaDwbxlkGPDsP7ouskEBcuB+b9kCPb6K3tawp8YLOKRlVrk+uRA9U5foCOnl
         A7fQYZvj3q9GBt+xxZulepUE5iWKsXw/TsdH3LFaGtKvK3FXik1og1aIupOfVVftz1rN
         H/0qavSJnHrAWAXT0I/EVrinsNctcrhADYAd/10XZCTH7XTJ+bXcf1qTE1EdykJEMY+1
         r99oyhTnOIwQJQ4Y2c2z31mS+tylYE0Wp18LEzjTziTG2uWyBqhDs4JVVuvL7v0jIjik
         PEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQLFi9MaLL2nmNEDJgI1po1sqK0yDrrmYzbRTv6Uzug=;
        b=Fo6xb+TQCXHcKl9Lp2lAC+CWYKELZK7zrwTYuvCFHftIZ6XtxxhRBSpfhugZJ89Q/X
         /5K2WXHq3Ff4h2gOqrgCqrB4bSIi7mtyY2GVZUv0bl5nNqs24sMOQIQJ7M0Ew1luba0N
         MjG2Q59l8CcRqCbzLyisktFgpZ230IA/BXlwqdioN7s8UI4uCzQnBrT+aKH3o2JJ1iRD
         NmZ4rugd/hNK+DyEch5/jPJOCp6QCT2+tiilNhSjbdFLgSBkmSsofA7grVaS0Xwxuo+G
         h3QFC1sP4Qi9o9G+B1PwtlLZ57WJ14MaOZgWrokHb3quPavRJFnciPEJloVd7XifngQd
         UyVA==
X-Gm-Message-State: AGi0PuYPSlAM3SpHP/blh9GQbmmwuYh3SSMqSxeO1kxAYRomBhoHXq/Q
        2qrF5tQ82HOUxGvIzxe+/NkxtCEqTMH5igARsFk86Q==
X-Google-Smtp-Source: APiQypKelvng6nEDkSadPkm0R9266SRPp0qWA1kTwfViO4zgldtC09pWHiPRdE3fhPQJcFGPRCFF1mwnEke3v/8aUTs=
X-Received: by 2002:a05:6102:72d:: with SMTP id u13mr8883173vsg.35.1587050460084;
 Thu, 16 Apr 2020 08:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200401195722.208157-1-marex@denx.de> <CAPDyKFoDB=d5B-2u_Y0e-XVzPQE46JBUTPwY_b_xzESm3NnjwQ@mail.gmail.com>
 <58d6bc7a-b772-e8cc-6120-b0adeb128070@denx.de> <CAPDyKFrAgLMUqU4oSRX64VoDQMMFZuM3KtUq6SL770XDSc+QbQ@mail.gmail.com>
 <20d299ab-ea7e-be85-7c5b-fd10e21a117d@denx.de>
In-Reply-To: <20d299ab-ea7e-be85-7c5b-fd10e21a117d@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Apr 2020 17:20:24 +0200
Message-ID: <CAPDyKFrOZG0F7jwm_gLTvbJ4odUn7tBcO0k9ZJgvjqp6BaJdow@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: Prepare all code for mmc_set_signal_voltage()
 returning > 0
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Apr 2020 at 16:45, Marek Vasut <marex@denx.de> wrote:
>
> On 4/16/20 2:07 PM, Ulf Hansson wrote:
> > On Thu, 16 Apr 2020 at 12:29, Marek Vasut <marex@denx.de> wrote:
> >>
> >> On 4/15/20 10:40 AM, Ulf Hansson wrote:
> >>> On Wed, 1 Apr 2020 at 21:57, Marek Vasut <marex@denx.de> wrote:
> >>>>
> >>>> Patch all drivers and core code which uses mmc_set_signal_voltage()
> >>>> and prepare it for the fact that mmc_set_signal_voltage() can return
> >>>> a value > 0, which would happen if the signal voltage switch did NOT
> >>>> happen, because the voltage was already set correctly.
> >>>
> >>> I am not sure why you want to change mmc_set_signal_voltage(), can you
> >>> elaborate on that?
> >>>
> >>> I thought we discussed changing mmc_regulator_set_vqmmc(), what am I missing?
> >>
> >> Because mmc_set_signal_voltage() optionally calls
> >> host->ops_>start_signal_voltage_switch() , which can now return value >
> >> 0 , so the rest of the core needs to be patched to cater for that.
> >
> > The issue that you wanted to solve (at least by looking at the
> > original patch) was to understand whether the vqmmc regulator changes
> > voltage level and then take different actions based on that in the
> > mmci host driver.
> >
> > You don't need to change anything related to mmc_set_signal_voltage()
> > to accomplish that, do you? Moreover, I am worried that it may affect
> > the host driver's expectations from when
> > ->start_signal_voltage_switch() may be called.
>
> So, shall I just patch all the sites which use mmc_regulator_set_vqmmc()
> with something like
>
> return mmc_regulator_set_vqmmc();
> becomes
> ret = mmc_regulator_set_vqmmc();
> if (ret > 0)
>         ret = 0;
> return ret;

Yes, something along the lines of that. Or if you think it's better to
make mmc_regulator_set_vqmmc() to pass an out parameter. Whatever you
think looks best, I am fine with whatever.

Kind regards
Uffe
