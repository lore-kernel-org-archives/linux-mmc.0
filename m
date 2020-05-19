Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E395BC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C257220756
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiKohL+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgESJP4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgESJPz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 05:15:55 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F795C061A0C
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 02:15:55 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e7so5347383vsm.6
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGmfkmnEQ7AXkqu9jnjooqDPpHxF7QVKoI7jxUDGMsg=;
        b=uiKohL+D4LbHgp30H/XaPQq/KGH28ioTcCuD57ZZo1cspCJ6YZHvhPIY12TGSWi6+R
         UuKO1OBBNmIwmT0K5H/MjJK+4hOj4F1a+vOhn9PDRJqx1jPys4dJcZoqqde0lNc+wwzv
         GGUqV6ql0kK26+YBMU7dTI4KSNLjfzqiEY36/48FHc+bs96CZNYhUQnqxw4PtM1vZOQV
         hnY/ReI1bhMcZMWrlSP2Thw9qsxvbZ9jgK1gGdvHMrQWbZTwCmWtkFjNHYn4Yqln878B
         U6YoD4bsyDx1HD1k947oydgJWEL7yKkq+Mjf+H7lVeSL0wvsXYcGSMECV+QnbIt3Kd7H
         MYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGmfkmnEQ7AXkqu9jnjooqDPpHxF7QVKoI7jxUDGMsg=;
        b=of5F+zCpGEW+BT6dWoqS15hvtX0OOUQHn20SxJN57H5zP4WNHsyKhLlJVLAnnSuMt/
         /M8e3t4tle1csbZ/hi2+wyK4DZ/PKA0WhkNla4t5hXRDXdmoTMX4P4R66rTePq/686kc
         Z5oThOIsiK2YTbY2CDZHAD98tIDsgmqfWRj6xgsLFxfihTRkb6YwAYfbTI1AeIf1/Kym
         +3u23QbfAIELDSTujM0hNSSexAP+l54GmzFmXkK7bRDfgkL1GPUBCgk+DhRKsqUkccKS
         chPPdM+V2GC9ily9aHyog2ELHs/H/NxoJkfti1ubMwpu/yf/umt0KUvnCGwnkazgDNXG
         YT6g==
X-Gm-Message-State: AOAM533g3KnWHHYHNPaHbXYGG7i9kTIWCFSR8ZoUsBBv9+ndT1iCAqJZ
        lGmE4itEp5qxMPQN5r8qmWd0W/hA7LHFzWzk/3JrWw==
X-Google-Smtp-Source: ABdhPJz9IklGUN+OS3sv2WYySKcNv/F4K8GKniVrK2P1Kww4IxJwo9f06ao8Bbhj2MbogVKub1QYxrM7CuIABCnLY0c=
X-Received: by 2002:a67:690e:: with SMTP id e14mr7706986vsc.34.1589879754724;
 Tue, 19 May 2020 02:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato> <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
 <20200519084653.GF1094@ninjato> <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 May 2020 11:15:18 +0200
Message-ID: <CAPDyKFr0Pfge4tm5MQmnmjx7Pvjjf16tLr47wYiR-2ys69Ux2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Simon Horman <horms+renesas@verge.net.au>,
        Niklas Soderlund <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 19 May 2020 at 10:53, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Wolfram,
>
> On Tue, May 19, 2020 at 10:46 AM Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > > > Can't we put it before the custom clk_enable()? And then clean up
> > > > further like this to have the main clock only controlled via RPM?
> > >
> > > I understand what you want to achieve, but to allow that to work we
> > > need to consider the below things first.
> > >
> > > 1. If the driver is built with CONFIG_PM unset, then runtime PM
> > > doesn't work and hence the clock won't be managed by a PM domain.
> > > 2. If there is a platform configuration where a PM domain (genpd)
> > > isn't going to be attached, then the clock needs to be managed locally
> > > in the driver.
> >
> > Similar to what Geert responded, for Renesas SDHI both is always true
> > AFAIU. Geert?
>
> For Renesas SDHI, both are always false ;-)
> I.e. CONFIG_PM is always set, genpd is always attached.

OK, thanks for clarifying.

This means dev_pm_domain_start() is needed only for the SDHI renesas
variants. But on the other hand, it doesn't hurt for the others (the
uniphier-sd variant doesn't even use runtime PM as confirmed by
Yamada-san).

I don't have a strong opinion, but it looks like we can either apply
$subject patch as is, or modify it to make dev_pm_domain_start() be
called only for the SDHI renesas variants.

What do you prefer?

Kind regards
Uffe
