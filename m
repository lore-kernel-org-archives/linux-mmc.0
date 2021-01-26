Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8033C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FFD2251F
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 14:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391840AbhAZNY4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 08:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391746AbhAZJ4Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2021 04:56:24 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227F0C061573
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:55:44 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id m13so3573803vsr.2
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jan 2021 01:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=arxHqUjVCPMGGo+kdWhr5qA09DPzoA8oDcXRjdjMesU=;
        b=EcShE3WriMxg/Eue+lluAhZy6XFdaiE7q/zIsBoYY7Ag15pVcIAPm2Rt5omAdELLCc
         11mz6CsjnLhyj61t/GIlOHf/TvdxS3gxdXSFfStT0k870nQbJoQ9eSIIYNuucpdWD8/S
         Sw/hzDKeBM6ISYAhYAe2Lw3q1xaBQtNpijQLFlW35bgeheAvsC77lBYtyV4oVcHveh1s
         3mcs8sn6PHPe4ll+5zwuh/wDZZFvTa6fkB1RVZgsUwDAgARuLfkdcz9/RPCFOQ0/UuW7
         /8XScZGzxB7cHdgTdkOiUb9Ll6WPzk2b+hSIWlPzYClk0yitUo36hYJGl2aqUGZPViDE
         uldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=arxHqUjVCPMGGo+kdWhr5qA09DPzoA8oDcXRjdjMesU=;
        b=VR7RsWYoc7JHyc3o7luZ6xL70n5p9MDzRRQfNrYnB5eZmFBGUCRtBPFP1imfFLXZ3k
         Ck6jLNWF9gbiZsU/ISWsCzVPWx1v3BNpek8FHc5MDxeHHWIO2awYdIUpuGVPq8bm6dmU
         SAs5bpKARQ9pZPnCk0D/+A+cgUY26blvqxIXmwdAul3tzuPkNCkISlPDHGkkN+81j8no
         f+3NPPGsB3FQ+yy/ujfTluSiUeFE4wxBkeAVojZ6tnxTTzO9/uqxeIFoeIXe1vTvtRjX
         a6IZEMA1QoGoE+znxDaNYwnbxzu0qGaz+Hlojvqp404gdhACEAZo00rTm1DJPHuUNuLX
         damg==
X-Gm-Message-State: AOAM532R3a3h59KVgRrLrpWW3GB7EqHAvG9eSCM6PGMX/n9EhScci1Gw
        g5ggninwf2pvFPShCk/gRttU82ZJ58AhU9qlj6cgEA==
X-Google-Smtp-Source: ABdhPJz0yZvD2Kri9nEUdn+/MXiaY91SPbRIkAAb7URMZZAOXugfNTa0Bn9xEPlfbJnKhse7FqsZsh1vyYupSyURNt8=
X-Received: by 2002:a05:6102:67b:: with SMTP id z27mr2242407vsf.19.1611654943282;
 Tue, 26 Jan 2021 01:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20210125125050.102605-1-arnd@kernel.org> <f671f5d2-36c4-ded5-c4b9-93c5c57cc9f2@gmail.com>
In-Reply-To: <f671f5d2-36c4-ded5-c4b9-93c5c57cc9f2@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:55:07 +0100
Message-ID: <CAPDyKFoGDHtE8JgLurwuN-W6CmmyBB3GP+7Z-bWqJiWw+TJEaQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: brcmstb: Fix sdhci_pltfm_suspend link error
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Nicolas Schichan <nschichan@freebox.fr>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "# 4.0+" <stable@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 25 Jan 2021 at 18:40, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> +Nicolas,
>
> On 1/25/2021 4:50 AM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > sdhci_pltfm_suspend() is only available when CONFIG_PM_SLEEP
> > support is built into the kernel, which caused a regression
> > in a recent bugfix:
> >
> > ld.lld: error: undefined symbol: sdhci_pltfm_suspend
> >>>> referenced by sdhci-brcmstb.c
> >>>>               mmc/host/sdhci-brcmstb.o:(sdhci_brcmstb_shutdown) in archive drivers/built-in.a
> >
> > Making the call conditional on the symbol fixes the link
> > error.
> >
> > Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
> > Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > It would be helpful if someone could test this to ensure that the
> > driver works correctly even when CONFIG_PM_SLEEP is disabled
>
> Why not create stubs for sdhci_pltfm_suspend() when CONFIG_PM_SLEEP=n? I
> don't think this is going to be a functional issue given that the
> purpose of having the .shutdown() function is to save power if we cannot
> that is fine, too.
> --
> Florian

I would prefer this approach - we shouldn't leave stub functions
unimplemented, which is what looks to me.

I just posted a new patch for this, please have a look and test it.

Kind regards
Uffe
