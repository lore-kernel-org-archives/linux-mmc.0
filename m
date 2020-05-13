Return-Path: <SRS0=M0Y2=63=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB49BC2D0FE
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 11:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DEC23126
	for <linux-mmc@archiver.kernel.org>; Wed, 13 May 2020 11:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFf/OB1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgEML7s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 May 2020 07:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732283AbgEML7r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2020 07:59:47 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B9C061A0E
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2020 04:59:47 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z16so5940105uae.11
        for <linux-mmc@vger.kernel.org>; Wed, 13 May 2020 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aKC3e9/aFqEyQsi12nQO5SZTFP347yzWMoN1Uw5P0XQ=;
        b=dFf/OB1LlPqedz0aREfzsOdKso/hLi6bsb9ljL0ID5x7NfxheZ4plN4kDvtTFqBmJj
         ftyzA1yRF1oTq6+Vws4q6Dx3Q4vh7jjFKXqRSBigEBdZs4N+X1HY1KbMfUAWtuj+BMcS
         hCQaECK9o+YX7iZ/aISrMhW5inwFdzFrSCkhkhq7KbIdBW5uScuDf5yqQ9+DyMgYhQu1
         MuZxs62XSeTKguK5HDeSINt/r6yA9PwLigqJQDWxPt13oQ0KmeI6UgydFnsfl/0492Hg
         JxpNHPTjZNhX2ofF86U6ES9rqm5dWwKpE0nBTP2PyJRrxcDzift9UG30X+y2Bm38Mu0M
         cdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aKC3e9/aFqEyQsi12nQO5SZTFP347yzWMoN1Uw5P0XQ=;
        b=Xd7XAxPnEcyEzWk5Ks2isri4yQLtdF7iklCQ5nkBUEP1zsetm2Tlxc37Oiqb1zUYwW
         2AG0oePe73+GJAWgsZowplLecTN7zLxxV92yavLXOmGc42GFykbjcuCR+QKtVt1J/HW2
         nW6ikTp7q7yuN71jKtW5p3znTu2TrTF+44DHamPcSLUZywJF3zWyRMvG0yzgi26Xx6Le
         e/pTeKe3gLHC9mZ+6yvICNB8NeQfta/F0rTFuCecKDKEDbFf2dJO4f4ukqcsAE6Tpkfp
         Gqe+Lz1aqg4oVi7E8/CvUh3BVu5pDEiZeoG6qvPeACOJxEWGAJwgoQVozcwyXGIDGjBR
         OEWw==
X-Gm-Message-State: AGi0PubJ+DChX/Feh2/3g86jkSPeabBWrOiYkFH7ObXkMZFx1raGP5o/
        Qhd5bpzamjQYlOMhL2fJeKL2cuAWahlfv1OJ+lQ/oQ==
X-Google-Smtp-Source: APiQypKquxL983aiOC1tqFBK1O0zfe8L4/l43OGtnDQgDfiBulRzZUqGmA95yyD1TqedEmzM8ovER+L2jUxyHzOwBOo=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr18877138uaa.15.1589371186638;
 Wed, 13 May 2020 04:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200501235907.3978-1-angelo.dureghello@timesys.com>
 <CAPDyKFoLpMTQD+3SnXBNnqVLBMKDf6y=3X+MoPep42SCiQ6+TQ@mail.gmail.com> <bde7080c-298d-c28b-5986-dbabc95985bf@westnet.com.au>
In-Reply-To: <bde7080c-298d-c28b-5986-dbabc95985bf@westnet.com.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 May 2020 13:59:10 +0200
Message-ID: <CAPDyKFqdGGfCurSRG8poO2aCbOmRb9so7-zarKEb1yUnBP=GXA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] m68k: mcf5441x: add support for esdhc mmc controller
To:     Greg Ungerer <gregungerer@westnet.com.au>,
        Angelo Dureghello <angelo.dureghello@timesys.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-m68k@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 May 2020 at 17:09, Greg Ungerer <gregungerer@westnet.com.au> wrote:
>
> Hi Ulf,
>
> On 7/5/20 7:13 pm, Ulf Hansson wrote:
> > + Geert
> >
> > On Sat, 2 May 2020 at 01:54, Angelo Dureghello
> > <angelo.dureghello@timesys.com> wrote:
> >>
> >> Add support for sdhci-edshc mmc controller.
> >>
> >> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> >> ---
> >> Changes for v3:
> >> - removed volatile cast from clk.c
> >> ---
> >>   arch/m68k/coldfire/clk.c                    | 15 ++++++++++
> >>   arch/m68k/coldfire/device.c                 | 33 +++++++++++++++++++--
> >>   arch/m68k/coldfire/m5441x.c                 | 12 +++++++-
> >>   arch/m68k/include/asm/m5441xsim.h           | 19 ++++++++++++
> >>   arch/m68k/include/asm/mcfclk.h              |  2 ++
> >>   include/linux/platform_data/mmc-esdhc-mcf.h | 17 +++++++++++
> >>   6 files changed, 95 insertions(+), 3 deletions(-)
> >>   create mode 100644 include/linux/platform_data/mmc-esdhc-mcf.h
> >
> > Not sure what's the best way to deal with this patch. I looped in
> > Geert to get some input.
> >
> > If it looks okay and the risk is minimal for conflicts, I can carry it
> > via my tree, but then I need an ack from Geert.
>
> I can carry just this patch in the m68knommu git tree it you prefer.
> Should be no conflicts that way. But really if you want to carry it
> with all the others I don't have a problem with that either.

It looks like the new platform data header file is being used by the
mmc patch in 3/3, so it's probably easiest if I take them all via my
mmc tree.

Anyway, I will wait for a v4 from Angelo to address the comments.

[...]

Kind regards
Uffe
