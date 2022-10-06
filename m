Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B985C433F5
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Oct 2022 11:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJFLt7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Oct 2022 07:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFLt6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Oct 2022 07:49:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1101412760
        for <linux-mmc@vger.kernel.org>; Thu,  6 Oct 2022 04:49:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 195so1711130pga.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Oct 2022 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OnZpre1fe4k7jZ/K9xnlhZVO9qKp7dPiAt23c+rWMmM=;
        b=paCFS2xZCUvLUB1huClE6sRhJuXH155SJp4YI21E5aR5POLpyBOXU1mEDWCVSDxBsB
         xfRtuKL/qcoweozoBe/3kh89cg7le/IXJPnl69WjT7sH4W0MxfWlxHzBsL7B7C4naY0m
         7KzWbYxqTZoQEQp+fJ4QZd/sf9WU03is2x/zT0JEyno5eUUpenC6Xfyaj2OjHk1WQQRE
         ss78yFs267zTkqIpCVjYPxVqI+sTB1lynZAWWLrF84eabBuGoL8H/TC9zW2/PA+5OwU7
         CUq0npWz5jnx99V03oIwyqHuLui7yuzEK5U54aAnkYbOkwj069uK+MJWypPB+kVIU1Qf
         sVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OnZpre1fe4k7jZ/K9xnlhZVO9qKp7dPiAt23c+rWMmM=;
        b=jMzGtlDmi9e/eRIXOy3ItRBL6m5BAU4cuTAmGwgsBormeVukL4dbgUFEkWegJWbxA9
         Vt2g++Vf+NYjm1W8U1VOgt83dVE6YBYomPkTb50LjGpjDAM5aYtDNFAD20l++GmE0xhy
         XATZCOx3bf4wFTZY/g2E6ixkTxqu8i72XAKmd76szf38fMQ3/QuwTtdkviaxkOGf4rSl
         dPRr0nZQxsAOL3Spk3wEIva6Z1vNlofrXJDc9yc4aprtcSmEI7qafh4xhuAU0BstADm1
         WXhW1z4t3o0UKktV7AleZuuPg/EHIP7JW2QYy02bS+yvX2CJ2jPioBTzLDMKDpE3pkVH
         S6Jg==
X-Gm-Message-State: ACrzQf3WWJr18eSZ/Qic7h+ThD8ARNgO7Jk3dA+9PYgl+78+/Uz/wu1J
        7/Y5z+U3k1NIh5apFJMJzCeC4Np8KznqTasgP4nuSA==
X-Google-Smtp-Source: AMsMyM7Pth7yTTas9qoN6G4DZOwAq2stRcCFIdgoSylzf+V/c/1AdNocJRSuLP8F1ZgnaTnkNmV+dB081JB75EpQyTc=
X-Received: by 2002:a63:e617:0:b0:435:144e:4482 with SMTP id
 g23-20020a63e617000000b00435144e4482mr4315878pgh.434.1665056996606; Thu, 06
 Oct 2022 04:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220928110755.849275-1-biju.das.jz@bp.renesas.com> <Yzsb7SCkNDyCghLg@shikoro>
In-Reply-To: <Yzsb7SCkNDyCghLg@shikoro>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 6 Oct 2022 13:49:19 +0200
Message-ID: <CAPDyKFpkfr9Rtrz6DF1zYxEypTYqyJyRsTyxHToBJu+1AFB+Hg@mail.gmail.com>
Subject: Re: [PATCH v5] mmc: renesas_sdhi: Fix rounding errors
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <chris.paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 3 Oct 2022 at 19:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Wed, Sep 28, 2022 at 12:07:55PM +0100, Biju Das wrote:
> > Due to clk rounding errors on RZ/G2L platforms, it selects a clock source
> > with a lower clock rate compared to a higher one.
> > For eg: The rounding error (533333333 Hz / 4 * 4 = 533333332 Hz < 5333333
> > 33 Hz) selects a clk source of 400 MHz instead of 533.333333 MHz.
> >
> > This patch fixes this issue by adding a margin of (1/1024) higher to
> > the clock rate.
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>
> Can only test on Gen3 currently, but clock settings are the same there.
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Thanks!
>

Can someone tell me, if there is a corresponding fixes tag we could use here?

Or is this just a general bugfix that we should tag for stable?

Kind regards
Uffe
