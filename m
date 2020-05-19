Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE7AC433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261CD206C3
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 08:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgESIxl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 04:53:41 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37804 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgESIxl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 04:53:41 -0400
Received: by mail-oi1-f193.google.com with SMTP id r25so11654492oij.4
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2020 01:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWQXhRdONAAogUFxUjMpFFf6Xbn4JGAEAR/Jd3w9XZM=;
        b=dmzHxtIWaK4Bf0aOhB2cf0P6pAYTwNQpy1K2mFGJwyHFMe9MQC7ez+2CPK8pEV2g2o
         E0CW1GLH+A79vC6VBxBVS+V+RYiqB3GQQmSE0M24TiY6zYC/rE5vkqfwEZXMgWZNVLKW
         V4Vg7t3Oilxaq/ls91rPbv1/Gjjoozl3XxugK60n6r27pm8fcCQDocVTudQpFMbQyniT
         lsgpNCYV5g9mxMGaA7qa8h0hQY3IiujkNS+0hKN8rCnV8emuJOP09pNHgadk9m34ivFF
         qzklTD2tPb43yk9jT9QaqgCW3UzJmAr6/dqpzcD7rThvgwqFRIpv8EauWE8hz8KIAZ0T
         Nx3A==
X-Gm-Message-State: AOAM532upyKsU66GTwKkSWxnQO3YkQpE94vLDXvY9RBL0IKaf/2DzwjQ
        FoWwripmkO5gEKPlKbs+DTZSUiGTTl8liyb6FpA=
X-Google-Smtp-Source: ABdhPJyYnzaVcQCLDc3Tj0GBzrRpk9cOC+IxI/ofSd6UNuCsXDu7SzT3cTbmP7X0JEznxMd5JYE/3+IvTGw7Eh4XTeg=
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr2438069oic.54.1589878419817;
 Tue, 19 May 2020 01:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200515140459.15273-1-ulf.hansson@linaro.org>
 <20200518202200.GC5109@ninjato> <CAPDyKFpCdD=B08aVhbTM9VjYGNNvNiE-A_fTF2XdHppGbVh6Bw@mail.gmail.com>
 <20200519084653.GF1094@ninjato>
In-Reply-To: <20200519084653.GF1094@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 May 2020 10:53:28 +0200
Message-ID: <CAMuHMdXVj_A20S+69Yr9nvL5mWsDTi=BuHNcsy-qNwmfb5S46Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: tmio: Make sure the PM domain is 'started' while probing
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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

Hi Wolfram,

On Tue, May 19, 2020 at 10:46 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > Can't we put it before the custom clk_enable()? And then clean up
> > > further like this to have the main clock only controlled via RPM?
> >
> > I understand what you want to achieve, but to allow that to work we
> > need to consider the below things first.
> >
> > 1. If the driver is built with CONFIG_PM unset, then runtime PM
> > doesn't work and hence the clock won't be managed by a PM domain.
> > 2. If there is a platform configuration where a PM domain (genpd)
> > isn't going to be attached, then the clock needs to be managed locally
> > in the driver.
>
> Similar to what Geert responded, for Renesas SDHI both is always true
> AFAIU. Geert?

For Renesas SDHI, both are always false ;-)
I.e. CONFIG_PM is always set, genpd is always attached.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
