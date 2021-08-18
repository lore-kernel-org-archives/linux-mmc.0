Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA529C4320E
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 09:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBEC61029
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 09:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhHRJmk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhHRJmi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 05:42:38 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE920C061796
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 02:42:03 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id b5so1389585vsq.2
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbdSCU3Rw09uivyYf1YKzhrdNkwTtywFq3z2eNcAoHU=;
        b=kqUWzgUl/yiaXMoS2k9dhVzmvWVdRfo7Fo2KXwGPP2K5ZKcbfq4mKKs9fLOs8fk96x
         ptk/PW2l+MORjgDTGKf9YKJffdNc1pkzifnQ3yMMmSj3Id6or6s1mOH4RD5LiDbhWJRI
         ol1Z3YbHIv6bhJb7wFU0bti68QvEuV9zCxn5x80BVxIEcknLkLqXu0njTtyUvhPQ0gSW
         KzGkOvTBoLGzarTvJDvnT+M4FVW2tzG1L1lXroB9VMemhLKPlypoT4WgQlmDdyLEkHoL
         avQ5B2EbRBekdWSQILEJHijb8G0nZOKWFmqrMWiR04qbuKkEn8DBAAYOVrTAxrrtgcGi
         fUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbdSCU3Rw09uivyYf1YKzhrdNkwTtywFq3z2eNcAoHU=;
        b=TFHy+dfLn0HCSoGmopsyOba+79yOdp6BzeU1z7HqEDarfAv3jVcFqL2Ckxtt+RUzIS
         Qs83Qor7vKmx2QlTqxkNLtkEp4Vk4x5MjD0rqTSlzE/UammOCwunXH1b8sDNIaHXeQ50
         ZxMjcbSAwpBUmatv6+vhtdtQkC9z6aXxh1VZwBKwAHGB0/tqfcYt01cI/jdi4YXLcNHZ
         ghj5Ac32Mhp3pUGqzaFRUx7bQfUfpAGO65uSeJvw1frbMECGq2ebUCJF5M9p3Lv6EJVL
         PnbsLw8vFt/CfBKIai61Y92d8WC3DvLKx1Qx1ahxOlwCT+lG72krMR+jLUZ/YuY8Jzc/
         FAdw==
X-Gm-Message-State: AOAM530GN4ME+1hvoK+WVNEPHKVTbpqAg/SBddhSLx9dqqSLzwW08qAf
        iTWG8pTXzdu1gHSMldmmdnrOMCF2y/HWV5T2UtnRTA==
X-Google-Smtp-Source: ABdhPJz8iEC0DtBNEl/b/C36HfmefejpZ6mYBF4J4rSAfO4RoK/etFf85MFbc+601w1EL4Uj4rk9xHbR9GbyCxpBsGg=
X-Received: by 2002:a67:f6d8:: with SMTP id v24mr6581141vso.48.1629279723051;
 Wed, 18 Aug 2021 02:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210818035533.ieqkexltfvvf2p4n@vireshk-i7> <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
 <20210818043131.7klajx6drvvkftoc@vireshk-i7> <a2a3c41f-c5e4-ee7e-7d48-03af8bac8863@gmail.com>
 <20210818045307.4brb6cafkh3adjth@vireshk-i7> <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
 <20210818055849.ybfajzu75ecpdrbn@vireshk-i7> <f1c76f23-086d-ef36-54ea-0511b0ebe0e1@gmail.com>
 <20210818062723.dqamssfkf7lf7cf7@vireshk-i7> <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
 <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
In-Reply-To: <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Aug 2021 11:41:26 +0200
Message-ID: <CAPDyKFrVxhrWGr2pKduehshpLFd_db2NTPGuD7fSqvuHeyzT4w@mail.gmail.com>
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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

On Wed, 18 Aug 2021 at 11:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-08-21, 10:29, Ulf Hansson wrote:
> > Me and Dmitry discussed adding a new genpd callback for this. I agreed
> > that it seems like a reasonable thing to add, if he insists.
> >
> > The intent was to invoke the new callback from __genpd_dev_pm_attach()
> > when the device has been attached to its genpd. This allows the
> > callback, to invoke clk_get_rate() and then dev_pm_opp_set_rate(), to
> > update the vote according to the current state of the HW.
>
> I wouldn't call dev_pm_opp_set_rate() from there, since it means
> configure and enable (both) for different resources, clk, regulator,
> genpd, etc..

Right, good point!

dev_pm_opp_set_rate() is best called from consumer drivers, as they
need to be in control.

>
> What we need here is just configure. So something like this then:
>
> - genpd->get_performance_state()
>   -> dev_pm_opp_get_current_opp() //New API
>   -> dev_pm_genpd_set_performance_state(dev, current_opp->pstate);
>
> This can be done just once from probe() then.

How would dev_pm_opp_get_current_opp() work? Do you have a suggestion?

>
> > I am not sure if/why that approach seemed insufficient?
> >
> > Another option to solve the problem, I think, is simply to patch
> > drivers to let them call dev_pm_opp_set_rate() during ->probe(), this
> > should synchronize the HW state too.
>
> Dmitry already mentioned that this will make the device start
> consuming power, and he doesn't want that, else we need an explicit
> disble call as well.

I am sure I understand the problem. When a device is getting probed,
it needs to consume power, how else can the corresponding driver
successfully probe it?

>
> --
> viresh

Kind regards
Uffe
