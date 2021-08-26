Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8A9C19F37
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 02:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31DD61100
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 02:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbhHZCzU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 22:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhHZCzT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 22:55:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF9C06179A
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 19:54:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so5549173pjr.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 19:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zY5JqCFiL9ajwRDJE9ra9rr5h/8lLdU1bpaSqHW2cUY=;
        b=zBbl6+vdhsHvJNmzRzPXjUjbZjS1JrIbTs8BWJQyR5yrjQ0NIdbYJbf6GP5pApFCVp
         QwHpr9xoOjbWOHQbf9w84qKF6hnSDYRTcKs92IQ4JEXvC49dJwGf73JNm9e6WL0CaiJ3
         5m6NOPRUdzpMEkdzaTnJgAib8c7/I1cWyzCPMW9eSlXIY9pGdD3717L7Hz3AuL6VwDK4
         N4OzVhpVgELJBvWYnrW5vu5o6L3KYwE3MnqcLvfRQ8BGGYt0siZaxfeUknn6gUpgr0d+
         DOZnGFD+Kfi4FkVDiCh75RoA6R1huFUJmi6KO1t34IILBc+ygQJ2sBcVh+9gAmmY5SNn
         0pYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zY5JqCFiL9ajwRDJE9ra9rr5h/8lLdU1bpaSqHW2cUY=;
        b=lgz7WbNeo5atTNhQz+Wpudn1J0Reqsg5MEaCRfS10y7jOSH1jxnaxP1sBAnCjVIfdQ
         au4lXnpxdXO51PiezHC9KCgtPA7V20HcvXPvoQeN60+RNb5X8KP7rP5X/vkfw1NXHFRr
         s11Puo8a2mt94T+vKS6ciJdwx1bfMXhUaSAJWDy1ImqF4DIG0G8zeCH6JYpS6qNT0/RI
         sl2cbW5PRwumPuB9ds7+K+WIERBJ+fUAdFg6wOcmxIXPHtrv652op2XqIDYUmEZu46Fq
         SYFDB96BR1ZzNKxh/hmr8oS/hnuyPrlbJvw71UMqKwmxcrAiekYul0lK4ho/T4RYknZZ
         HDHg==
X-Gm-Message-State: AOAM530DruRqU3nDlQxMm7GWofKTl7+S6wtcQ18dLMsuVP1xn17zypb/
        UHY8eyP57S44IMHAtN52Oej5uw==
X-Google-Smtp-Source: ABdhPJwJ9pkRHq/CTCcQjTYNpLDk2RhglIYRZ3ZolL1qTMxvdQiuO7bqSMhmqzPibKf11tEWAM5bLQ==
X-Received: by 2002:a17:903:31d6:b0:133:9932:6998 with SMTP id v22-20020a17090331d600b0013399326998mr1459044ple.45.1629946472125;
        Wed, 25 Aug 2021 19:54:32 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id nl9sm7142139pjb.33.2021.08.25.19.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 19:54:31 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:24:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
Message-ID: <20210826025427.exdinwkuavyfcp3f@vireshk-i7>
References: <20210818062723.dqamssfkf7lf7cf7@vireshk-i7>
 <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
 <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
 <CAPDyKFrVxhrWGr2pKduehshpLFd_db2NTPGuD7fSqvuHeyzT4w@mail.gmail.com>
 <f1314a47-9e8b-58e1-7c3f-0afb1ec8e70a@gmail.com>
 <20210819061617.r4kuqxafjstrv3kt@vireshk-i7>
 <CAPDyKFpg8ixT4AEjzVLTwQR7Nn9CctjnLCDS5GwkOrAERquyxw@mail.gmail.com>
 <20210820051843.5mueqpnjbqt3zdzc@vireshk-i7>
 <b887de8c-a40b-a62e-8abf-698e67cdb70c@gmail.com>
 <ed70e422-e0e9-8c2a-7ce6-e39cb6fd8108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed70e422-e0e9-8c2a-7ce6-e39cb6fd8108@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25-08-21, 18:41, Dmitry Osipenko wrote:
> Thinking a bit more about this, I got a nicer variant which actually works in all cases for Tegra.
> 
> Viresh / Ulf, what do you think about this:

This is what I have been suggesting from day 1 :)

https://lore.kernel.org/linux-staging/20210818055849.ybfajzu75ecpdrbn@vireshk-i7/

 "
  And if it is all about just syncing the genpd core, then can the
  genpd core do something like what clk framework does? i.e. allow a
  new optional genpd callback, get_performance_state() (just like
  set_performance_state()), which can be called initially by the core
  to get the performance to something other than zero.
 "

Looks good to me :)

-- 
viresh
