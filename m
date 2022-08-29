Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D1ECAAD5
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Aug 2022 14:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiH2OWi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Aug 2022 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiH2OWf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2022 10:22:35 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92794EEE
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 07:22:32 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so11388701lfr.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FfW4HGYn26XtUqQ/e7sAaYpbBaUM1Z8Gx46WxwdHwTg=;
        b=PE3nUuZ66F46QT6sv0gfgKmaz3nvEfONqeIADcJmzJlP1LZisqWqOkcfdtK+w3Q8O9
         k2t36IHqbAoaAZFXtDFCiTgP4g1fgS2tGEpPdFrAurQLNz0XEgOXgxlxB4DyzOq+U13M
         /yi49U68SBeKPEg2/y/yyKI5j5FAU1vtJdTvrPeKixTc+bUinQQ4h538arx6aNHU6/w5
         FENzVCe1Bw95uTvMLUP/MmYjAtcal4B1ICmFO/P7NFOsCBzSlk9wOjBl1DVU90Nfo92I
         OBv2tis1n+NYp4EP995PgNVdFQcZ66sL5ydvAJngKdkMM0QDxfsTGw4p/MsWBq5fAdfG
         epgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FfW4HGYn26XtUqQ/e7sAaYpbBaUM1Z8Gx46WxwdHwTg=;
        b=x4SFliGuWVjEvuwowwc9MxI42FnS9YlB4Gu6iW9EDWLL6vzJmX86cLKgxkltkqWEtL
         JauRNpBZu4Hqb6EexzqTa546uxxmo95l4s2ixQPZ75qbr8Wk1WolssglKoECc6LkwKkf
         O+Q6HKAYnLlXDH9mUM3KbH4Vr3D0E77a6/r9OG5FOMlSt9GgYNwROQ9LzdezMQb8mHvk
         MRMv243jKLIiWpqhDWXv1TP8Q6zPWaP+Fh9iRQhjD8e6sFqVZWlQ7LdZR9Gs5Cta4I/F
         yjKGWLYv06TieO+cosKe9gy/vvSgC03Z4FjJQ1YkccxudvONbZ251yP8i1ZrmDOTerZP
         WXVw==
X-Gm-Message-State: ACgBeo1GxHREm+MRVCFxZhvG8ejak4iUb5Hqiv5prs53DSWpPEwkGXJV
        8WyL21fQ/DzCTsVhXLby/rW0xfzhRn0ynaxkjmJSFw==
X-Google-Smtp-Source: AA6agR4i/W/hSJcdm+Gzv+x2zZm/NYYHPnwCT4l8m6WRM2o/xIsCCPqHBjSSqmpco/NdSgEMnVYKyGddaLleAVwK44Y=
X-Received: by 2002:ac2:59cf:0:b0:492:bf97:9a03 with SMTP id
 x15-20020ac259cf000000b00492bf979a03mr7051814lfn.233.1661782950289; Mon, 29
 Aug 2022 07:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
 <CAPDyKFokmJr7e8=gvsYbBbdxceG6kCa57vbYy1tUT_b+B=8P8Q@mail.gmail.com>
 <e970e07d-9bb8-707d-1dc6-09fae2abbfff@baylibre.com> <CAPDyKFqRm=RVn__3HJDk_0bBemudh_y7YEYPZe3W7iJCfP50fg@mail.gmail.com>
 <67f29dfe-a579-125e-cb84-f6b554932b42@baylibre.com>
In-Reply-To: <67f29dfe-a579-125e-cb84-f6b554932b42@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Aug 2022 16:21:54 +0200
Message-ID: <CAPDyKFqqtHUtGshE=JYaLK09P28EeenYAsvnDkROvMHb7i2bDg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: meson-gx: add SDIO interrupt support
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 29 Aug 2022 at 15:29, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 29/08/2022 14:07, Ulf Hansson wrote:
> > On Mon, 29 Aug 2022 at 09:42, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Hi Uffe, Heiner,
> >>
> >> On 26/08/2022 11:16, Ulf Hansson wrote:
> >>> On Thu, 25 Aug 2022 at 21:52, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>>>
> >>>> Add SDIO interrupt support. Successfully tested on a S905X4-based
> >>>> system (V3 register layout) with a BRCM4334 SDIO wifi module
> >>>> (brcmfmac driver).
> >>>>
> >>>> v2:
> >>>> - use new SDIO interrupt API
> >>>> v3:
> >>>> - don't duplicate checking mmc->sdio_irq_pending
> >>>>
> >>>> Heiner Kallweit (2):
> >>>>     mmc: meson: adjust and re-use constant IRQ_EN_MASK
> >>>>     mmc: meson-gx: add SDIO interrupt support
> >>>>
> >>>>    drivers/mmc/host/meson-gx-mmc.c | 84 +++++++++++++++++++++++++--------
> >>>>    1 file changed, 65 insertions(+), 19 deletions(-)
> >>>>
> >>>
> >>> Applied for next, thanks!
> >>
> >> Thanks for applying, but I was off (like many of reviewers) and I would have like
> >> this patchset to be tested on earlier SoCs aswell, or only enabled on S4 for now.
> >
> > To actually make use of the new code, an update to the corresponding
> > DTS files are needed to set the cap-sdio-irq property.
>
> I know but it changed the IRQ handling, let's hope we don't see any regressions.

Right. Let's encourage people to test this!

I noticed that $subject patch sets the CLK_IRQ_SDIO_SLEEP bit, no
matter whether the SDIO IRQs has been enabled. Don't know if that is
intentional and/or could be a problem? Heiner?

[...]

Kind regards
Uffe
