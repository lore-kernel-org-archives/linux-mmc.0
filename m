Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5EDC4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 14:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDEC61163
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 14:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhHSOGE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhHSOGE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 10:06:04 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E9C06175F
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 07:05:27 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id 75so2660556uav.8
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8ppYolHk+6MAlg/iRV3TOW64DDORViSUFtjVS4tPfU=;
        b=pf8lMOnxg/R18hy9RmRXn53gTyaSPBEYPRXidYbCWDeGyj1Q84GnstXRTsE70HIZwL
         rOZaYQbJ0JsuexxwGKTbxTnmUkIeE3lCIDKi4y5M7EdG4KOJ33bce1Ym5TIJ8eyXrlgP
         dbE7l+Rznz9FT+hME0DQqhK7lxhDgOPmbvRDcLaquo7wS/EVnyYYfbE9J5SpPQV1WnQ8
         fXPIAlBPmH1/Wbcsr6ERwHJaV/U7LQTY8nCTXj0WtrNaCQEnZqZy2yVRdVBh7ZdPgr+l
         lQknd5LJKpfGihHNxJOG9NmGE/fM0gVDzrjpqFwZqJoFyhmk+xoMBA6IKCATwNl/L1GC
         MrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8ppYolHk+6MAlg/iRV3TOW64DDORViSUFtjVS4tPfU=;
        b=XgLWpjGLa0LRN2PLTla6KWSlMkpyNxs+HHvXRScbaHKqFrJlXqkpeqJSW4acA3t/Ab
         P9k1OLf4fPkmsB8tNdXg4NiUdW00BXetokHnCgmRB4B9SoHe77davBAipLAswlglMwkn
         9yMivu3Yjjd96q7+h1GKFy2J17T1K0qtGcFjrv7OJ4xrtgt+QSp/dBW8IWMawdlZUalq
         szv30I6BusBy4T4nXEnJsOX09oxqVMPa71ErB1TTHCpjEZR/lyq4F1369lXO+6TdyBpv
         2/vst0t8IKKsZAsF3I9vIODX6znVrUnGS0HXinDLxCRRVMUVVt0/KIgb0wLL6XmV+74T
         VdOQ==
X-Gm-Message-State: AOAM531+czIKTvZkuyes/kRSm3xuAf1PzY6fmFMQnM71IwMxburxEvKo
        St4YhJVP013QmmgFfQi6SnlK+rCcVFVdsq4kL/hLzw==
X-Google-Smtp-Source: ABdhPJy/9RKTdWSvjYHKQ+0uBbarqxq9rsGLaiJcPg/kihysGVgUWTFM+D2WJBPDbj8B50jGA4KtwzpHd41jDaJSEK8=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr11206760uaf.129.1629381926495;
 Thu, 19 Aug 2021 07:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210817012754.8710-1-digetx@gmail.com> <20210817012754.8710-20-digetx@gmail.com>
 <YR5ay6+r0hJsUbhy@orome.fritz.box>
In-Reply-To: <YR5ay6+r0hJsUbhy@orome.fritz.box>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Aug 2021 16:04:50 +0200
Message-ID: <CAPDyKFqr6NYO89io+6EfwrtELhTMps-tpGcAVbmuQ1_NnOD7Ew@mail.gmail.com>
Subject: Re: [PATCH v8 19/34] pwm: tegra: Add runtime PM and OPP support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Aug 2021 at 15:21, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Tue, Aug 17, 2021 at 04:27:39AM +0300, Dmitry Osipenko wrote:
> > The PWM on Tegra belongs to the core power domain and we're going to
> > enable GENPD support for the core domain. Now PWM must be resumed using
> > runtime PM API in order to initialize the PWM power state. The PWM clock
> > rate must be changed using OPP API that will reconfigure the power domain
> > performance state in accordance to the rate. Add runtime PM and OPP
> > support to the PWM driver.
> >
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 104 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 85 insertions(+), 19 deletions(-)
>
> Can this be safely applied independently of the rest of the series, or
> are there any dependencies on earlier patches?

Just to make sure we don't rush something in, I would rather withhold
all runtime PM related patches in the series, until we have agreed on
how to fix the in genpd/opp core parts. Simply, because those may very
well affect the deployments in the drivers.

>
> Thierry

Kind regards
Uffe
