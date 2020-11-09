Return-Path: <SRS0=XCsL=EP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DC8C2D0A3
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Nov 2020 05:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F5B2084C
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Nov 2020 05:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tp5iGDWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgKIFMF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Nov 2020 00:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbgKIFMF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2020 00:12:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514FFC0613D6
        for <linux-mmc@vger.kernel.org>; Sun,  8 Nov 2020 21:12:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id a18so6814830pfl.3
        for <linux-mmc@vger.kernel.org>; Sun, 08 Nov 2020 21:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9NivTOlvjK/Ba6sd1R/nO7+Ag7q8swSruWnqhahAopA=;
        b=tp5iGDWUBJG38ehlRwddPMdGWPeEgd/9hxrOkPBXCZ+SO+iKPWOTmiDH+Cwobq6HPT
         7vViE0zYr9ka9ct70t9K8SnqDWzqSZUNXqheS/mqDinvCmYbULlqw2fzNKKZZaDq/JNb
         SWH5tFz0k2jHt20E9oRMK11Ae5ls9HWwjMDNYTyHI5Kbrg2pXvF7zI87YhubQ1EzyJad
         mYObBw7x8IKnecPqF3HhzwVgvVPOJjAHFuR3lQc5Ja5UpKwpy+OW+jfM2KcYeMFpwo6k
         xonZDBUdvpRiXtq7I+1C2kznYzCUVp0KodvX7o2vRCAs/T26JnMogAFl+HGWAbBD7yH/
         NzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9NivTOlvjK/Ba6sd1R/nO7+Ag7q8swSruWnqhahAopA=;
        b=h1fFSf7JhMeIJuPG8kJOzQWDdwp8ZGcEulSFpe9TA6Gdfua/DBcJjDl7Lr3U2K/sEI
         xKR8zA+UjjT/N6aByFdyJpaGyp5IAApdsAvgfvNTYKWYboj+cXb8QThNUSyMHvaD+OrZ
         OxNojJmgm3igWF+X8Ep+36GEsQE5ml87wJl7Lg48CzKypFO2hkBu80ujG4/vZFfv+wz9
         LtTTbnRCXNiYv4rv6YfrCF676A/4+pDBkM6LWZKdUrCBCCAk81yZNrgptR7J9EFSQ7ly
         CcaHe6m9istMInT++miiYRoY71vrcDd5yXoEWO/nmRrDqNWQ81Kq9sPlTu24ld6usicy
         kp9A==
X-Gm-Message-State: AOAM533eXoOPRHp8YePoi6LLre1x28tnLYs0YHjYeOiz7REscrTdMV1j
        T8E18gq/X/J+uSNlHgUd802+JQ==
X-Google-Smtp-Source: ABdhPJwQdhAu2WnSRc9rOfl6s0FMnSAISb0fkEJE0pdYKUv8rT41JTM2g1xJQDNhC7f/+oC7XdSzGA==
X-Received: by 2002:a17:90a:8086:: with SMTP id c6mr11331387pjn.147.1604898724873;
        Sun, 08 Nov 2020 21:12:04 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id v23sm9687090pfn.141.2020.11.08.21.12.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:12:04 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:42:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201109051202.e4lkosy6kk334akq@vireshk-i7>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <20201109044354.ljd5pomhob6b7u5v@vireshk-i7>
 <713b319e-bb7b-4743-59f0-b9892c3da92d@gmail.com>
 <aba1fcac-74b8-f370-ab45-312975da66e6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aba1fcac-74b8-f370-ab45-312975da66e6@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09-11-20, 08:10, Dmitry Osipenko wrote:
> 09.11.2020 07:47, Dmitry Osipenko пишет:
> > 09.11.2020 07:43, Viresh Kumar пишет:
> >> On 08-11-20, 15:19, Dmitry Osipenko wrote:
> >>> I took a detailed look at the GENPD and tried to implement it. Here is
> >>> what was found:
> >>>
> >>> 1. GENPD framework doesn't aggregate performance requests from the
> >>> attached devices. This means that if deviceA requests performance state
> >>> 10 and then deviceB requests state 3, then framework will set domain's
> >>> state to 3 instead of 10.
> >>
> >> It does. Look at _genpd_reeval_performance_state().
> >>
> > 
> > Thanks, I probably had a bug in the quick prototype and then overlooked
> > that function.
> > 
> 
> If a non-hardware device-tree node is okay to have for the domain, then
> I can try again.
> 
> What I also haven't mentioned is that GENPD adds some extra complexity
> to some drivers (3d, video decoder) because we will need to handle both
> new GENPD and legacy Tegra specific pre-genpd era domains.
> 
> I'm also not exactly sure how the topology of domains should look like
> because Tegra has a power-controller (PMC) which manages power rail of a
> few hardware units. Perhaps it should be
> 
>   device -> PMC domain -> CORE domain
> 
> but not exactly sure for now.

I am also confused on if it should be a domain or regulator, but that
is for Ulf to tell :)

-- 
viresh
