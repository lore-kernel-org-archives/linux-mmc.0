Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10E2C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 20:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCLU2R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjCLU2P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 16:28:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4982916AC3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:28:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r15so13702306edq.11
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678652892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn7rGXP9a+n4kykSAVJ38yeOYG47jZ8DOqSys/GUHm0=;
        b=CVBQzqYCNAPyWk09GzvdecOwLxuztTqPOpWt9vR0lxNEZOJ7DGfOxpQFlI/Hwhy+lA
         Plfq05uMvlHZowrfjd+DhJzRwqNNKb/qYgyy9pSkwmNqNCO/6iMvE/x0eRMAy6VSlHyF
         9wTmFptJL+fSKaDCnZmpDB5HlZymIDrEHwa3d5/ndQD7uFaW4Ljc3AuPhFmbKxwR4Fqp
         oKG3HuIt3noDNUBpTHbKJI7F1WT4bFAReS120gX3np6V5KBoLyncarspZ+BpibEAkst5
         9R2A8MTLZp/DtNFQBmy5t6PMMe9iNSTwFNo+pEZMqeEoaLtGBZqAueuDArkHb2Qcv6fj
         ursg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn7rGXP9a+n4kykSAVJ38yeOYG47jZ8DOqSys/GUHm0=;
        b=rhguHGBM9LsfUVKpqeL2+bRx77C/5g3tZUBaRi+CS6WKGYTeKf5B2TVp7bXxpp1FkR
         a6WAfixhJFD7fioxJfC1fRh8Co/QfYnb8wgB3E4HrIooFm8LoK5w66NbonswX9aAsBPd
         h+reUtff6oHI4v0mOZQ8yjCrQ9jHUWMr1l5aFTSeOxVIagfk7G2Ix+Xk4+scF9RO2BSp
         EBDjQgkz1+jJNR8NdT8a2Vq800Nh+T8vIWTjBVq9cRB9gSVM+1NJ54uIizj6UPzLScbx
         Rshi0ROie/hJA0gg4qlGu/8MetXEbvLnN9bulJsDyYkQJLiuxmsJZv3m9hKI03drbl/I
         t5+Q==
X-Gm-Message-State: AO0yUKX+o1dplAmgMGAlJ8DQag2x+5WynJHtCRD8X68P7zHpHSjNiwIy
        WfLRbBCFEmVgS2IXHCxq85v+5YzodiJuh7Fq+dw=
X-Google-Smtp-Source: AK7set/6hHg0Nod0N6Qs9t9pD9PM6JVRFdHySE+N5trzgl0H0qKarMmaqrd7tgVoASSuASpnIIGevY6z3n4EQlR1SiY=
X-Received: by 2002:a50:d758:0:b0:4bd:ce43:9ee8 with SMTP id
 i24-20020a50d758000000b004bdce439ee8mr17766701edj.6.1678652891770; Sun, 12
 Mar 2023 13:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com> <71586432-360f-9b92-17f6-b05a8a971bc2@gmail.com>
In-Reply-To: <71586432-360f-9b92-17f6-b05a8a971bc2@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Mar 2023 21:28:00 +0100
Message-ID: <CAFBinCCJSn2LoK1MvEeQ0SUqEzczbWbSXT7ueb4yM9vO-a7eQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: add helpers mmc_regulator_enable/disable_vqmmc
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Mar 11, 2023 at 11:41=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
>
> There's a number of drivers (e.g. dw_mmc, meson-gx, mmci, sunxi) using
> the same mechanism and a private flag vqmmc_enabled to deal with
> enabling/disabling the vqmmc regulator.
>
> Move this to the core and create new helpers mmc_regulator_enable_vqmmc
> and mmc_regulator_disable_vqmmc.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
