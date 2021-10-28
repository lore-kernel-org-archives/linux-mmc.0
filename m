Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD73C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 09:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4BC60E8F
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 09:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhJ1Jet (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Oct 2021 05:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhJ1Jer (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2021 05:34:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E067C061745
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 02:32:20 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u5so9571962ljo.8
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H1cBbZ29iBhIzlADanMboqR5PTvmcX6f2VNyLE4w9Tk=;
        b=ZF8RwgiR46eeZoRy7bQm9ex9lg/svajTlowMu+8I/nRfgUrrjWGJSl4sMB22wU7Yzo
         /amQHrUnik25ChBxiQIVRNWRGarvxrwqBWfH5dqMT9GU5jy4sRNGgEF71cLdL2CDAqVT
         qikRVVu61rlTBpGB7b+ixhzqMJF7B15oRsKr15GP84lQO92p4ldyL+uJ9MVUVxMOsFfh
         QWbkYGdti4Q2LauYBohGXpFdBS1pQF4Qfydx8mBSrZU/m9NsxdO93pfcRWqvy1OG/g7W
         IdbctlT1Tu4E6WoZI23e4BP+BHnxdqJXOc1BL2l2bVA0/suNaoegxy8PlicibO70KB7E
         674A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H1cBbZ29iBhIzlADanMboqR5PTvmcX6f2VNyLE4w9Tk=;
        b=zHGvs3docaC+JN+yHTbLXFRSGFOSJn0qD3c8NS9VgQ9gT6Oyof2f6OSuKUvCbq6mpI
         S2lgatP5a0uGCEWT09moMTqlmm9s34yPJF4aSr1vzXRnRHRyC/hdAjkIXBtSkKoTzFMv
         iz1vVmLYVIbDNRFneiad8vNPanDl3XE9piP1NSP6lQRzqkJCBFfwcXijWKQk/odUxznn
         U/yPv5Ay4/soyGOQfrDUYkHfOEvl6vCS4WJqx9s+vWe+GX0LxktSTaa3hqh87x5E6Omn
         8UHq0wosChLG5t0ZJR70FOn5bJ6XcZEy4A1UGdPYmvOv60JHT+q6fH5xv9pZg9CT8gZi
         BGdw==
X-Gm-Message-State: AOAM532S858JsvkW8pXF0L9aB/z05sBvHmarZmA/MHHONHbiHtaxrHSa
        Wxzq/h0xVXnTCZ+egbbNuSh5d7xH48G/tGQKMcSIvQ==
X-Google-Smtp-Source: ABdhPJxJuR23jXNDWfiQxoqWI52YVAi1m5sbex/r8p4Wi8DX0c1r6Ft0KZ8J9L4U+hz7GkJMrE2CJvDkj11pjzajMi0=
X-Received: by 2002:a05:651c:11c4:: with SMTP id z4mr3422469ljo.463.1635413538930;
 Thu, 28 Oct 2021 02:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <8ecc5c79c1dd0627d570ede31e18c860786cacca.1633519499.git.hns@goldelico.com>
 <CAPDyKFp47sAXhM2s5HOqV2wLf-kYRhdqSdzcn7a62ZW23SSPdg@mail.gmail.com>
 <470A96FD-DB24-4C32-BC9F-AE2F617FBF2D@goldelico.com> <2013308.OSlt1BDEiP@pc-42>
In-Reply-To: <2013308.OSlt1BDEiP@pc-42>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 Oct 2021 11:31:42 +0200
Message-ID: <CAPDyKFouhj7V7n-7NSw=9-vLWqPvAmhUuZFVPR5Htw=aCLVZ_Q@mail.gmail.com>
Subject: Re: [RFC] mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <Jerome.Pouiller@silabs.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> > Combining your suggestions we could do roughly:
> >
> > in mmc_sdio_init_card():
> >
> >         if (host->ops->init_card)
> >                 host->ops->init_card(host, card);
> >         else
> >                 mmc_fixup_device(host, sdio_prepare_fixups_methods);
>
> I think I mostly agree, but why you don't call mmc_fixup_device() if
> init_card is defined? (BTW, mmc_fixup_device() takes a card as
> first parameter)

Ack.

>
>
> > Next we need a location for the sdio_prepare_fixups_methods table and functions.
> >
> > For "ti,wl1251" we would then provide the entry in the table and a function doing
> > the setup. But where should these be defined? Likely not in a header file like
> > quirks.h? But there is no quirks.c.
>
> I think you can place your function in drivers/mmc/core/card.h. There are
> already add_quirk(), add_limit_rate_quirk(), add_quirk_mmc(), etc...

FYI: I don't mind adding a quirks.c, if that makes sense.

Kind regards
Uffe
