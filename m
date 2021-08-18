Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB92C19F33
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 09:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B72610A1
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 09:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhHRJO6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhHRJOz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 05:14:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70ACC0617AE
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 02:14:20 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n5so2194453pjt.4
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tDuCq4cpa/FhfVLg3d4eOXI0t92SH+lRUdr1ZBj+304=;
        b=quAhTr+R/08xh/ignvyvF/El1dD/NQftWfiNTcAu87cJhuBhgI+As0zoEiydqeW6PP
         Ex/zHp4EDoA27CiqypV1XRJjyjppnIr9cuHPeEqT4Jz0u4Gd7rGoODV0vOYF2r+fXVrC
         O9YNeAY5lMNde/fcVIInzFs4EQNgUzhxxcNX6YMHjHSIPhU1rXEQOl9Aq3E25JLQ/9fv
         VxP/TlWw72/n6skEH8miH2qbrmh27V7jR6dmqc1oF+jbwQP/bhXkGIrzGuJgVHwfQUpg
         jLxJj1fuqBdXtzbuG0/ZFv6pjltmBS+1GsQZASCe+7q/ocD5Ye+29smqIZ7DN+BRR4O7
         VT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tDuCq4cpa/FhfVLg3d4eOXI0t92SH+lRUdr1ZBj+304=;
        b=iM982/JotiYz2TSq+csGdRUQmtwA6QPNut4S1DIIr6wIWqAHFm7W1aehEf+dyakmFF
         NkYgp5jcZyo75QuGM9bPoFLmrsxFkDXYbMOxOBPJZDS44pqf1SQdhx/VUxWTXwLpCYi1
         nC65cCvDQYIdArgRdfvkh83CFeFaBqvTb94X4G+gIuRua/B7NBHSUE0xS/ofVTmQgvVE
         xs7Mqh5DPUpya5SujQuUAGHco8S3xCOKW/lnsPRYKgMFcKx7bYG4A0cUP/sJewWii+8s
         An57KTHiNUPs18gnutaX7Vg9Hlfokl7q3ywU4hMJ5746vR28gGBLTvihSWpWwcTFb5UP
         bJBw==
X-Gm-Message-State: AOAM531IAl5nI2EmUCsCpAHQ+0j2EP7iA6PrpqvjlZg4x33m2bnbURhx
        sqqG1+UPA4xRWLeVmQE3NtiywQ==
X-Google-Smtp-Source: ABdhPJz4yEie/eMLpBAmymSzx5jt3Od7muuoKSX0aK0QfqCy9SYA7S2Wvgljmd2wM1mkIsijUEW0lQ==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr8231461pju.203.1629278059957;
        Wed, 18 Aug 2021 02:14:19 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id a8sm1540816pfo.79.2021.08.18.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 02:14:19 -0700 (PDT)
Date:   Wed, 18 Aug 2021 14:44:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
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
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Message-ID: <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
References: <20210818035533.ieqkexltfvvf2p4n@vireshk-i7>
 <5b2a80c1-9743-e633-6257-ede94c8a274c@gmail.com>
 <20210818043131.7klajx6drvvkftoc@vireshk-i7>
 <a2a3c41f-c5e4-ee7e-7d48-03af8bac8863@gmail.com>
 <20210818045307.4brb6cafkh3adjth@vireshk-i7>
 <080469b3-612b-3a34-86e5-7037a64de2fe@gmail.com>
 <20210818055849.ybfajzu75ecpdrbn@vireshk-i7>
 <f1c76f23-086d-ef36-54ea-0511b0ebe0e1@gmail.com>
 <20210818062723.dqamssfkf7lf7cf7@vireshk-i7>
 <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18-08-21, 10:29, Ulf Hansson wrote:
> Me and Dmitry discussed adding a new genpd callback for this. I agreed
> that it seems like a reasonable thing to add, if he insists.
> 
> The intent was to invoke the new callback from __genpd_dev_pm_attach()
> when the device has been attached to its genpd. This allows the
> callback, to invoke clk_get_rate() and then dev_pm_opp_set_rate(), to
> update the vote according to the current state of the HW.

I wouldn't call dev_pm_opp_set_rate() from there, since it means
configure and enable (both) for different resources, clk, regulator,
genpd, etc..

What we need here is just configure. So something like this then:

- genpd->get_performance_state()
  -> dev_pm_opp_get_current_opp() //New API
  -> dev_pm_genpd_set_performance_state(dev, current_opp->pstate);

This can be done just once from probe() then.

> I am not sure if/why that approach seemed insufficient?
> 
> Another option to solve the problem, I think, is simply to patch
> drivers to let them call dev_pm_opp_set_rate() during ->probe(), this
> should synchronize the HW state too.

Dmitry already mentioned that this will make the device start
consuming power, and he doesn't want that, else we need an explicit
disble call as well.

-- 
viresh
