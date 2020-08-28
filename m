Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA7C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E394B2086A
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 14:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3SH83Jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1Ovn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgH1Ovg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 10:51:36 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D40C061236
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 07:51:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so1611553ljj.7
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImiWhFwiMiRaDILGK2vYxwtK6H1QbPrDWNEB8Fo5yp0=;
        b=m3SH83JhPp5zysOZ8UGaOASaGvHwyBdy+dMZYhDz9IjeZrOUNDL7DGC2IYkYpae6UT
         FpGAiEisi2hdICi2QBwVlxCRBlQYajQ6kIl3apwv6Zd5zwaMsm+woTJe0VxhXsJCBmVB
         /Krz+up/rlea+pltJEx57NrY0mSwXBmgaoM8eBGVocnnO/EabniaNW7LYGT8om9EynVv
         CIC9WHLTJ4TqH3GGF/DLZDlPvjr7OZ+u5Gmua0OvS7bbxfJ/KVP9l6u2f80iB9oWA4S5
         XcREjqO8mQbwzNglMH6NjTAUpG2SBhzd1ox2KvfQMgaZMf3Rcty3gxm60W7RrjIkgx2T
         DCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImiWhFwiMiRaDILGK2vYxwtK6H1QbPrDWNEB8Fo5yp0=;
        b=UeRbW4YKzPywikUgWku++xwTx03Qsck9cfUq/lcRKjvYm9p0lmXzZjPr0+pb5h/O+3
         JtxcL1dVEsIK8BwcAElfp2U0qAMVs2MrpPSecfcYyRhg+QeyRjk+xS74kc942Yvap9Ih
         /4Z2A+ATCutffFBcYg+4mi2m75ONrvGgiZXliYE/J0oBVV9S4OL+it5c+edBWCKe5BS3
         66iIcLIXdGcDdaB/E2ookxRA92aI/uIbvWSwAd6+o6yenI3cOK8FAtena6M5PYEhGmlR
         Dycmu0sPAXJ7WwXYrcCKVIYYGEnrFix+Z3F3LiCvD6KpLa1iNIMQH8v6S6u/RGL/TDUN
         WeQA==
X-Gm-Message-State: AOAM532BfGkJlUG3kwjzEN5p5bGWuoMaYLoTZjnRUNSqO8Y8wCPJS3ob
        7K8rnVZvTa/mEHGJvfNi9v2DPs/Q/wMHAY40qrjzig==
X-Google-Smtp-Source: ABdhPJz7nqwPZB2YVbmFth99db1dEuQGwLTN+Hy4/7RmCxHXULzHeBqpJLldBTh4ZZ0VSRoDavwoeUh9uKGkK6yVJPw=
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr1026817ljj.144.1598626291535;
 Fri, 28 Aug 2020 07:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200825193536.7332-1-krzk@kernel.org> <CACRpkdb4j2kJvpY23G-os9gTktZW5HT287MsvMZxC=ovgn_9LQ@mail.gmail.com>
 <20200828130837.GA14163@kozik-lap>
In-Reply-To: <20200828130837.GA14163@kozik-lap>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 16:51:20 +0200
Message-ID: <CACRpkdaWAzJQz_Z1zsRbyVQNPO2wUogH8U_mDNV2fSkW22zmtQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] dt-bindings / arm64: Cleanup of i.MX 8 bindings
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 28, 2020 at 3:08 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, Aug 28, 2020 at 02:51:20PM +0200, Linus Walleij wrote:
> > On Tue, Aug 25, 2020 at 9:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > > This is a v3 of cleanup of i.XM 8 bindings and DTSes.
> >
> > If you are going to be working a lot on Freescale SoC code going forward
> > I wouldn't mind if you could add yourself as maintainer for the
> > Freescale pin controller and GPIO at least, I already have high trust
> > in you in general so if the Freescale maintainers also have that I think you
> > should just sign up as maintainer. This makes it easier to do pull requests
> > and things like that.
>
> Thanks for encouragement.  Indeed I am planning to do more work around
> i.MX 8M platforms from NXP/Freescale. However there are already four
> maintainers for Freescale pin controller drivers so I doubt there is
> need for fifth entry :).

I beg to differ. As subsystem maintainer it has happened to me more
than once that the i.MX pin control patches went unreviewed for weeks.
Everyone listed for this driver is a kitchen sink maintainer that get
way too much traffic and things fall over the edge.

> Different question is the GPIO driver which apparently lacks entry in
> Maintainers file.

That's probably just an oversight. Feel free to add it!

Yours,
Linus Walleij
