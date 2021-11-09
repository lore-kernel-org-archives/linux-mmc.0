Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42043C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223B061181
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 11:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245674AbhKILW1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbhKILW0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 06:22:26 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9BC061764
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 03:19:40 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso953476otj.11
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2021 03:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81oSrvuxBM/j7gpiOLY81PcqBRup1M3UbsvvPZ2iPus=;
        b=WHzNM7y8f9g7e8SVkE7MzIw0Sw8i4/Pjgh+2C5ZPjqI+1ZlC49KJuMM5uD/IScW8u0
         2fKiYTzn1/kcpn9Ms1rCUp2/6aVPVUzL86l6Qy5cq7ZaD7DlDbbFHT7TGIxQoYBaHGkr
         XbOmOEKRkTTFulZLwKv+DY3zff/kZ1papnm+IqqcmLC1brP0oxNTC9RGqsOlPqwwINDW
         cvwf7ZwTCTQ+kxkuKPEGGyHh6db+m5+p8wCB2mrlw+ArWBBXA9iGAeYSdf+UvF9Yvput
         5S1365/x1N2xqlQ7ZG98o3YTbxZjtdqBEYNidzvPJhMRZj5+5idyQNXrmv96xPskeNMa
         KodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81oSrvuxBM/j7gpiOLY81PcqBRup1M3UbsvvPZ2iPus=;
        b=fr+vuKkrDLFseewXRAgqd1g635iuw6rBdh91MxgByp3oYhLHQBSeFgdDnZPtXZqtP+
         mIGMfspAErBAFfp6bTW2dDAMLV4RNIJbiU2eN9new3R/sc3uR0V5ut+9v1WwTo0HX12g
         QoABVSL2NlRv6tEDrRHZAG/XZ0ppf4KNF0zlayEGEu78M2R360lnLh2Je07NnnlQSbtZ
         jSlCGrfo/WOA5zNsDYyCy5Na+TR55q8daMsoU7+c9KDk/h/nUeRSFO42UFy0ACpg7eoG
         OdMU5kFm806NYurS5KGbfd9Gozi7uHk2kLJfdGQ3rkPM+4ghoy2JDfVZ46nxvnDitti0
         bJlQ==
X-Gm-Message-State: AOAM530W9lnz6FeztAFpYWWVRenDJsupYEXVqMBCEXD7xUh9cvUrnmZJ
        fui67yyPfsVW41rLB8mSdfNUyWqUvT/EhBlDrFG4OA==
X-Google-Smtp-Source: ABdhPJyXrbdxCuwNMNCc5LJpGYdQCSIpOGS4o6GjsfFSpaYbT77UnJcs4vXQ+/eU67CZtB9O9oj6AttHrPrhOmRMxcw=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr5318661otk.179.1636456779951;
 Tue, 09 Nov 2021 03:19:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1635944413.git.hns@goldelico.com> <90a75a0be2d8e05066765ede1db7a19f9f4d095a.1635944413.git.hns@goldelico.com>
In-Reply-To: <90a75a0be2d8e05066765ede1db7a19f9f4d095a.1635944413.git.hns@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 12:19:28 +0100
Message-ID: <CACRpkdaXtrxny_aVsiBmvy+wm-3n7k=-nMZGaNYvX6GON4vCBA@mail.gmail.com>
Subject: Re: [RFC v3 5/6] mmc: core: transplant ti,wl1251 quirks from to be
 retired omap_hsmmc
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tony Lindgren <tony@atomide.com>,
        Bean Huo <beanhuo@micron.com>, notasas@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Nov 3, 2021 at 2:01 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> The TiWi WL1251 WiFi chip needs special setup of the sdio
> interface before it can be probed.
>
> So far, this is done in omap_hsmmc_init_card() in omap_hsmmc.c
> which makes it useable only if connected to omap devices
> which use the omap_hsmmc. The OpenPandora is the most promient
> example.
>
> There are plans to switch to a newer sdhci-omap driver and
> retire omap_hsmmc. Hence this quirk must be reworked or moved
> somewhere else. Ideally to some location that is not dependent
> on the specific SoC mmc host driver.
>
> This is achieved by the new mmc_fixup_device() option introduced
> by ("mmc: allow to match the device tree to apply quirks") to match
> through device tree compatible string.
>
> This quirk will be called early right after where host->ops->init_card()
> and thus omap_hsmmc_init_card() was previously called.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
