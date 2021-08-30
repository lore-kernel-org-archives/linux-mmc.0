Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8A6C4320A
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 13:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4CF60F44
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 13:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhH3NpK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhH3NpK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Aug 2021 09:45:10 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328FCC061575
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2021 06:44:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so26042819ljn.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Aug 2021 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOYXhGaqQ6MRJEfF+E0ER+xBLRcBgZV7cWZXRVeFtj4=;
        b=oSzgQNH2PwxCqBTmQ00Scj9XVNl4PjTfZ++xtN2IEitrBIFKHRNOL0Nw67BOqqLDXc
         ActdqjZTwLU+LZHafZglw2/Ka0Otxu1mSTzy+f7Iy3+t336Rl1FhjMz2TVigE0AiEfMe
         sJwAOqAQwp9MrtcdCua2tE/O2fbPeJIJfuZ5yIh6gTpYFU8ZYLHM96NUBCjy6ffwMpVb
         uT2td0pEGA0MAXd9lc/rMbDlvrPemi+GAcO1VH4u67DOlWf4posmy4rjN9xZEewHg12T
         9cfnXrYjqrFceBAQli3kRcG6SJrpB64dhbVykWoa0BUH1uuNw3Xod+WsHj2D6vQZ4dTs
         W+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOYXhGaqQ6MRJEfF+E0ER+xBLRcBgZV7cWZXRVeFtj4=;
        b=LpxN6tYuVvOzj7QiMo708YBLxCNOuP+1mQZ8Xr2mZuLYLnHfFFxJxUQjD3EgcZoRqS
         QKz4V2/bUC8+a+DLN6YZT/AfLv98yRsCeXP5CaDzFT362fyWirt8366Z1vqxFmwAU790
         LhswZOpFJ3TBtPKAKvsrhWa1bOhJl6qD3g0vOLAJhjy2dEbsyuGqG8fZkFtpH+I/hN1s
         kUFIq+QJ+abLyQK6KNsDCoBdz4Ll3uUb/sLVGzJ6wZ4Z9n4LxRf3zrf90s5v76m7kR4/
         eVa3vIEZwuqGU2g0heSKnUjYCpBEXqfQu8DdOuB3/piel6HCUljmAW4dsx6MYetlvj85
         wlRg==
X-Gm-Message-State: AOAM532S2Ma55vS9K+xJvFDYF0dUtIkTdlaHAHEnwDp/NS22nosLiVPd
        gk8r/jYpHgpG3InbkdTCp95ZWzDAq+UszbgmOPOT0w==
X-Google-Smtp-Source: ABdhPJzSbjrfR6nWoj1MvF5PjDjLKW0SfuR+5h1BG6O5DQ4hi8nvSRGwK/6dSx4oy0x4iF+t9nGT3L28hehyyLhGsjQ=
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr20595594ljq.76.1630331054549;
 Mon, 30 Aug 2021 06:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <ccb2dad1-c8c1-9f19-92c4-7faf2b787e6d@foss.st.com>
In-Reply-To: <ccb2dad1-c8c1-9f19-92c4-7faf2b787e6d@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Aug 2021 15:43:38 +0200
Message-ID: <CAPDyKFqMJmJRLNYF=gWvAEH8wtJzrxrZ9KLz62t4XNsD84vr=Q@mail.gmail.com>
Subject: Re: Question about MMC_PM_KEEP_POWER in MMCI driver
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Aug 2021 at 16:34, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> Hi,
>
> In drivers/mmc/host/mmci.c, MMC_PM_KEEP_POWER is unconditionally enabled.
> This prevents correct low-power sequence on STM32MP157C-DK2 board which
> embeds a Wifi chip brcm,bcm4329-fmac (this wifi part has not yet been
> sent upstream).

Exactly why doesn't this work with the STM32MP157C-DK2 board?

>
> This MMC_PM_KEEP_POWER can be taken from DT with the property
> keep-power-in-suspend. This is what is done for other MMC drivers.

The DT property is what should have been used for mmci as well.

>
> I wonder what should be the best solution for this.
>
> 1) Remove MMC_PM_KEEP_POWER from the driver, and modify all SoC device
> tree files embedding a arm,pl18x with adding keep-power-in-suspend;
> property (except stm32mp151.dtsi file).
> This can be easy to do (~10 files to modify). But that could be more
> board dependent, if an SDIO chip is plugged on this MMC IP.
> And the name keep-power-in-suspend can be misleading as it only applies
> to SDIO.
>
> 2) Remove MMC_PM_KEEP_POWER from the driver, and modify board DT files
> with the property. This could be a difficult task to find all those
> boards. And this should be applied only for SDIO configs.
>
> 3) Just modify the driver to apply this capability for all MMCI chips
> but STM32. This could be done in the dedicated file, in
> sdmmc_variant_init() function. But some boards based on STM32MP15 chip
> might want to keep this capability.

I would suggest option 3).

As a matter of fact, we also allow MMC_PM_KEEP_POWER to become set
when parsing the DTB via calling mmc_of_parse(). So just changing the
default value (don't set MMC_PM_KEEP_POWER) for the stm32 variant,
would do the trick I think.

Kind regards
Uffe
