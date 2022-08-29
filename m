Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22589ECAAD4
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Aug 2022 12:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiH2MYR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiH2MXv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2022 08:23:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB12A98D1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 05:08:20 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id k18so1419075lji.13
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 05:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qKsvNRH86aHNC8UItEtemRj4TbqiQ2+V87OtP5n+W9U=;
        b=zHPi+7sXaz5JENCfXEQx7Yq5zfDdqNY45Hwj6On/9m+zjWpB2m8QoWkm+ufzkCCCF6
         ZEA3TgJaIgwANSD3EOLByZLh50uz4gHUQFwyoadJsqSurnFETVhnIZTHUUqxHuArYOd3
         pgP2kxhXR2CV0EUjm+Mz7zERQzUYfPbn6XXMBL1l/m7htLHT1Rb02q4ksHGwwSANgg9p
         T+MhFyHldMWegzdUYRFbfG/H5wy5sN3xWbYOqGpEV8kkvRc88PiEukiGFeDz/tWSOtCz
         scAmXLL2Q4K51pG3BBUys8tmbzvrl5fEMHD9dzuzQsl5IY31ZwM0Gzj+Td28LoCkjha6
         tM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qKsvNRH86aHNC8UItEtemRj4TbqiQ2+V87OtP5n+W9U=;
        b=d0+8CWakO41snv0BWQ40UIDeO3or3mJ9kvu8pun1s34S+GTDcC+x08dLj3S79Yf8Sc
         /oBEkcduS+soEJt4rVU80StCboXUyAjwotfWO8/xC0M0msCup2G3l/8UW4nBoim63rEV
         X6nMXh/66Kk/m6l/kxB6pcYPl2IBMZJI9rmmIKh5TMdRl93YCOESjKaNSiy+5oEa1kMs
         gGRV6W9TVKGG2WFPaci5wyD75ei052xcSg3/d+Z+0rYIcINZenDT/QpsfXmyzHeLCuS7
         AOoo/YP2UAIzq63GgDClTWi3tiFykoiMse93VrLcUmnEoacj6bwQkqqEUoPP7OQCcFZZ
         xO1A==
X-Gm-Message-State: ACgBeo0HgTMM6s9mX5VoYuW6uQbGT2mPeAl26Nl47dW4YJfx/W8sd+04
        IVxDwqqAVDQAdlzhaxapRIjuOdJxNFHzIQFRy0zu8g==
X-Google-Smtp-Source: AA6agR58Pd3QqgEFFfCQUNOIxS3mN6JInRUCJqFY4oKIWBp+p0J+d610owS1EoNj+kbjCQKDNsXeZfGpuE2gjrwhsWQ=
X-Received: by 2002:a2e:9799:0:b0:261:e51d:8576 with SMTP id
 y25-20020a2e9799000000b00261e51d8576mr6068713lji.367.1661774891703; Mon, 29
 Aug 2022 05:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
 <CAPDyKFokmJr7e8=gvsYbBbdxceG6kCa57vbYy1tUT_b+B=8P8Q@mail.gmail.com> <e970e07d-9bb8-707d-1dc6-09fae2abbfff@baylibre.com>
In-Reply-To: <e970e07d-9bb8-707d-1dc6-09fae2abbfff@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Aug 2022 14:07:35 +0200
Message-ID: <CAPDyKFqRm=RVn__3HJDk_0bBemudh_y7YEYPZe3W7iJCfP50fg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: meson-gx: add SDIO interrupt support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
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

On Mon, 29 Aug 2022 at 09:42, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Uffe, Heiner,
>
> On 26/08/2022 11:16, Ulf Hansson wrote:
> > On Thu, 25 Aug 2022 at 21:52, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> Add SDIO interrupt support. Successfully tested on a S905X4-based
> >> system (V3 register layout) with a BRCM4334 SDIO wifi module
> >> (brcmfmac driver).
> >>
> >> v2:
> >> - use new SDIO interrupt API
> >> v3:
> >> - don't duplicate checking mmc->sdio_irq_pending
> >>
> >> Heiner Kallweit (2):
> >>    mmc: meson: adjust and re-use constant IRQ_EN_MASK
> >>    mmc: meson-gx: add SDIO interrupt support
> >>
> >>   drivers/mmc/host/meson-gx-mmc.c | 84 +++++++++++++++++++++++++--------
> >>   1 file changed, 65 insertions(+), 19 deletions(-)
> >>
> >
> > Applied for next, thanks!
>
> Thanks for applying, but I was off (like many of reviewers) and I would have like
> this patchset to be tested on earlier SoCs aswell, or only enabled on S4 for now.

To actually make use of the new code, an update to the corresponding
DTS files are needed to set the cap-sdio-irq property.

If that isn't sufficient, I prefer if we make a patch on top of the
$subject series.

Kind regards
Uffe
