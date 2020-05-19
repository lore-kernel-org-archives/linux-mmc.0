Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF88C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B6E207C4
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 09:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRe0odfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgESJV4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgESJVz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 05:21:55 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716A0C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 02:21:55 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id p7so3159293vkf.5
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HofHUjjcgopfgpWTaR2MMYRfiF24EQnvl/1+M82k8E=;
        b=KRe0odfD982d+5WjkWwiXIXctxFzxgW3VVPv/K3deccZ5qI90vFAqpppVZ7vL5QDRe
         oe/jrqRiCxSbLzLCiuBpP0OeOs2fMy43c1wgzvjOvglo1GGdLmoozGLXpeQJCo37d5+Z
         gXCPI/s4X2f5uwZSh64m5u7FYKoOefxIR2bKa+lQ4d6sYrjkBzXn/cs5A8YN2nnIDuw5
         F7BZk0p5eeZhm+UJSeN8V4Vin0gKpxAyPQDJuq4PjCtA3raW7o1/1Ig1VG//YkbZEmPD
         fP0Fu07+hPT+ty324aIkYxdLKx8L+MSSJH6uSzGOTCESc/1sdE8SZGFEVQtQ1ctodNsS
         oXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HofHUjjcgopfgpWTaR2MMYRfiF24EQnvl/1+M82k8E=;
        b=X03RWgc1SL3fStifu6FwUOWP2gduBgze4QrZae0hvH8cJDkfQof3ke/Cm6tNupfMFf
         caUaxybskbDq/09Sw3NPpqMzmT8V/qPkBY+96Yc03oeotLgDaFGEKXyjI4RDL+JME/Qq
         8Qk7lYrllNPRwby9PYFMmGV1opgLeUQo14d//bjX4jXcio6/z4iglrRBJg+Ah7UvPVD2
         5LDfZ/keUWy8c6/n7b9/NZf6I/jrSQUoGQaqNMxhZ9aQ8XbDUgMxAstypSAqVoZ9Xpc8
         IXRALEjP0IEEwvC0moV69AweHjRGVIsfRh6vt6JUy6t7YGqBNiuLVNoEIRGm9sABRZ2X
         BXcw==
X-Gm-Message-State: AOAM532sKmhFBidWWJAsq8yX/ReexL5AIqPClZ/fAzziCOnBMAERKvtL
        qOt4sCQXabXFzd+fgk76fGrhLZtpkCgC05LxA3TBGwYfvbs=
X-Google-Smtp-Source: ABdhPJyQnLpKgMwIrEB05ocxXMvCu+QTOm3uS9q5SKsSaSFqDpCNdNnqfJuv8O8Q+VqnMwKYHuzgUdVcqz4LdhfAQhs=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr14022664vkl.53.1589880114479;
 Tue, 19 May 2020 02:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato> <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
 <20200519084653.GF1094@ninjato> <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
 <CAPDyKFr0Pfge4tm5MQmnmjx7Pvjjf16tLr47wYiR-2ys69Ux2A@mail.gmail.com>
In-Reply-To: <CAPDyKFr0Pfge4tm5MQmnmjx7Pvjjf16tLr47wYiR-2ys69Ux2A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 May 2020 11:21:18 +0200
Message-ID: <CAPDyKFqM6YoS+0YhHaqLqjZYnvQywb9t0OHQ1Lw2T=dAKeWvtA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 11:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 19 May 2020 at 10:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > Hi Wolfram,
> >
> > On Tue, May 19, 2020 at 10:46 AM Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > > > > Can't we put it before the custom clk_enable()? And then clean up
> > > > > further like this to have the main clock only controlled via RPM?
> > > >
> > > > I understand what you want to achieve, but to allow that to work we
> > > > need to consider the below things first.
> > > >
> > > > 1. If the driver is built with CONFIG_PM unset, then runtime PM
> > > > doesn't work and hence the clock won't be managed by a PM domain.
> > > > 2. If there is a platform configuration where a PM domain (genpd)
> > > > isn't going to be attached, then the clock needs to be managed locally
> > > > in the driver.
> > >
> > > Similar to what Geert responded, for Renesas SDHI both is always true
> > > AFAIU. Geert?
> >
> > For Renesas SDHI, both are always false ;-)
> > I.e. CONFIG_PM is always set, genpd is always attached.
>
> OK, thanks for clarifying.
>
> This means dev_pm_domain_start() is needed only for the SDHI renesas
> variants. But on the other hand, it doesn't hurt for the others (the
> uniphier-sd variant doesn't even use runtime PM as confirmed by
> Yamada-san).
>
> I don't have a strong opinion, but it looks like we can either apply
> $subject patch as is, or modify it to make dev_pm_domain_start() be
> called only for the SDHI renesas variants.
>
> What do you prefer?

And no matter what solution, can always drop to manage the "main"
clock from renesas_sdhi_clk_enable|disable() as it's managed by the PM
domain.

Although, then we need to call dev_pm_domain_start() prior
renesas_sdhi_clk_enable() during ->probe()?

Kind regards
Uffe
