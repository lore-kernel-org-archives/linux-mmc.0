Return-Path: <SRS0=rVnL=2B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F6BC00454
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A795720836
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 16:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqHvsIBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbfLKQKp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:10:45 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36033 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731208AbfLKQKp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2019 11:10:45 -0500
Received: by mail-vs1-f67.google.com with SMTP id m5so16163221vsj.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Dec 2019 08:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kgF0VJwJaoby2Qr1LSoRI08yHtezON+G5eeh4fnIRrc=;
        b=gqHvsIBLULpFt1CrV8JQNqmX+fJCOrherZuDNq0bjRctmMIPjDngGtH2kiqRyFYVpa
         a45jXETMo1DSdvdVMYg5zLfMwnTO6hvomPKQ7ut/aIWHf84ifkMVmZFFitbuJOVm6qQP
         ldrWFZYCHZoFoP1c6DqUVvPLIIL5uUzKLaLxP3lU5/eiIgXnNohVLz9h83Dvofb33ibB
         ZaSy7BOTxvNUwe60poj3bGD29/xkZudsxk4a1OhMIjAuoLK6JT2Z2vmzNLfD7qOG3sWI
         DnSKfmJ/kda2KPyQaIgd3ruNWrfxVHxbOFSAmoZ9il9SujzqQCGcRs2miQd6/nq5Mdi1
         RxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kgF0VJwJaoby2Qr1LSoRI08yHtezON+G5eeh4fnIRrc=;
        b=Fs/PQhMQDR+G4gvDppDF/pul8QBPKejbzyz/njl2rXWuS5V5MfqHGi3wecT6xZmEnr
         RTvN7pvdkGjAIhNb/kLgudWpI/YSok0fHofd//jYwyHNE5LQXuyJBozZEZKmzsyNA6I5
         Ns/HOb4nzEH4tg0h3KmNR/DDB72K2pshJ6KdrWonEhYEDNI5GzfylREKCZyZqPF3V+nm
         Y2XG8yoj83LN/Jy+eqVXURB4XmyeiosDdBRz9xlB8GYXMuCeJwzdYYqjlSwO6l7u3CvV
         Bal1iSzaQtl1DxJeqNNGXTYNj7uw6Sqf0bySVhPB4Wapo9e7HUDmXfENjbaSfyJeRVCY
         e7dg==
X-Gm-Message-State: APjAAAXqjYicNcfDtfHQqCX2cXYXYVGA8Ois2geLr526dEEtDk1mvp2x
        ZvppsOwc1RvuMabdoJTWRwjX2HU9HiAKFfdaYw7EWQ==
X-Google-Smtp-Source: APXvYqySYRxzOot5/V8md6qQBaCXP7aPmRYFmPocUh6OqZlEtGxOuxcN2QT47MGnRi7aJ+1JdLEpLYg4vmI9+M9lRR4=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr3128024vsf.200.1576080643886;
 Wed, 11 Dec 2019 08:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20191210014011.21987-1-digetx@gmail.com> <CAPDyKFpMe09PNQqinvvidF+wfASx2nuvgf7=Hx5+cGni8pdcRA@mail.gmail.com>
 <28045442-6a1c-1e0b-0dfe-c36fa9de149a@gmail.com>
In-Reply-To: <28045442-6a1c-1e0b-0dfe-c36fa9de149a@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Dec 2019 17:10:07 +0100
Message-ID: <CAPDyKFpWO_McZEoefX1T=SE=RYm_GU3S+LgYZrgJY_SJgv7egA@mail.gmail.com>
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 11 Dec 2019 at 16:46, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Hello Ulf,
>
> 11.12.2019 11:11, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, 10 Dec 2019 at 02:40, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affe=
cted
> >> by a problem where WiFi chip reports CCCR v1.10, while it should v1.20=
.
> >> In a result high-speed mode isn't enabled for the WiFi card and this
> >> results in a malfunctioning SDIO communication.
> >
> > Does that also mean SDIO_SPEED_SHS bit is set when reading SDIO_CCCR_SP=
EED?
>
> Yes, the SDIO_SPEED_SHS bit is set.
>
> >>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed=
: -84
> >>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
> >>
> >> Downstream kernels are overriding card's CCCR info in SDHCI driver to =
fix
> >> the problem, let's do the same in upstream.
> >>
> >> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC drive=
r,
> >> which overrides card's info for the TI wl1251 WiFi.
> >
> > This is a temporary solution and should be replaced by doing the DT
> > parsing during
> >
> > So, yes, let's see if we can use a card quirk instead. That's the first=
 option.
> >
> > A second option is simply to parse the DT subnode for a new DT
> > property during mmc_sdio_init_card(). Along the lines of what we do
> > for the broken-hpi DT binding for eMMC.
>
> Let's try the first option. My understanding is that the problem affects
> only the specific model of the WiFi chip and it's not a board-specific
> problem. I'll add Broadcom driver people to CC for the next version of
> the patch, maybe they'll have something to say.

Okay, sounds reasonable. By looking at your latest attempt for a fix,
I have two minor nitpicks, otherwise it looks good.

The nitpicks:
I suggest to rename MMC_QUIRK_HIGH_SPEED_CARD to MMC_QUIRK_HIGH_SPEED
and mmc_card_need_high_speed_toggle() to mmc_card_quirk_hs().

Kind regards
Uffe
