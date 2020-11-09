Return-Path: <SRS0=XCsL=EP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F1C2D0A3
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Nov 2020 05:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F8F20853
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Nov 2020 05:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEZAcCQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgKIFAP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Nov 2020 00:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIFAO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2020 00:00:14 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239BC0613D6
        for <linux-mmc@vger.kernel.org>; Sun,  8 Nov 2020 21:00:14 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w11so4138299pll.8
        for <linux-mmc@vger.kernel.org>; Sun, 08 Nov 2020 21:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pqRYwsgE80dyuksaxFD472eZJVu82XkbBKetRcMgwkU=;
        b=jEZAcCQJcoNyrqtopd159IVehbQnFdrCz6Gv6znnBL+oQ9Lbu4SwHrg2soadRKeK2K
         tHih4WST3i/TCcj6zG3NcC99f5l/4cWK9Hfln+BVXXbkrR1PnWTasCM5zfT/TMCZDGt9
         4y9fQy768qLLnTE3MNoBwJpSS+n1y2hy4CEdK5c9TZgDv/CsZCyWoBuiaAscEi6XOXaz
         fFRrm9tIKwCRdg8pkO9cL1mnHke7AsuFQHSxVtVK1lOFWXAcbU0rrIszlYFyBsfjnS5J
         5MYwsJUwjmTVqE/xB66miJ9Smg7Qnite7DZudEoTQOg9GTVBnz2CKxeWfhRk9Fxccles
         G1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pqRYwsgE80dyuksaxFD472eZJVu82XkbBKetRcMgwkU=;
        b=J0SwU2Oj0KuWG5Q4o190B9qiM8UiYaeoDO5C1CmMbfr+gjmArlmE0DsDJWTNhCHe4D
         /Yo9j1ARYlsjO6nOvHoTEAHiwpmg1wjkaHjYMlFW9dO+vXPCyyVuhVx6GsdZgybnAFVm
         x9O4v0h3aSVYRxZHIDQSPlGleDxx1Pl8hyIvguK6ujbt6YUv6BSv02SiO2kG5R7iH89j
         69Rqw3TfrhVuQ6VZ3HMSjksyP5LBCS2A3bNMjUnXeZIvzfDB5OjNF+X7SbmXqUdoTveH
         70iZLLbwKr8GdAApR77g9vNDAJOhA28u4L2A9JQsgXzJp5rUsKxe5Z6+ZqGttN4mztl5
         wNgQ==
X-Gm-Message-State: AOAM532cwlRagsto7mxcIXt+1TUlMeZtN0hPj6Oh2hYPXc4xUKcJqmhL
        bH3mfCykKJiGN7021dK73nHPtw==
X-Google-Smtp-Source: ABdhPJxqVzbXuE7r2OTnlJIGnZcPTN9Z6rBdnUMyX2RPUkOj+pqZMZGHLq2naeoWPtp+jW/061Xf1w==
X-Received: by 2002:a17:902:a612:b029:d6:6ae:4d47 with SMTP id u18-20020a170902a612b02900d606ae4d47mr10993684plq.50.1604898014065;
        Sun, 08 Nov 2020 21:00:14 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id gx24sm3171830pjb.38.2020.11.08.21.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 21:00:12 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:30:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
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
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        driver-dev <devel@driverdev.osuosl.org>,
        linux-pwm@vger.kernel.org,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v1 17/30] mmc: sdhci-tegra: Support OPP and core voltage
 scaling
Message-ID: <20201109050010.g47zojh6wafvwqva@vireshk-i7>
References: <20201104234427.26477-1-digetx@gmail.com>
 <20201104234427.26477-18-digetx@gmail.com>
 <CAOh2x==sy1w7_oEV8=toC6uQnSN44wyOixbP_X0BrMsnm1AUFg@mail.gmail.com>
 <6fa54ce6-d5ae-d04f-7c77-b62c148d92b7@gmail.com>
 <20201106061513.uyys7njcqcdlah67@vireshk-i7>
 <a6926456-8bce-a438-bfaa-be334208f004@gmail.com>
 <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWsp0DWw1yO84e3vzr_YZkqkd+pyPfQQR3J2W6n3wTX4Jw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06-11-20, 21:41, Frank Lee wrote:
> On Fri, Nov 6, 2020 at 9:18 PM Dmitry Osipenko <digetx@gmail.com> wrote:
> >
> > 06.11.2020 09:15, Viresh Kumar пишет:
> > > Setting regulators for count as 0 doesn't sound good to me.
> > >
> > > But, I understand that you don't want to have that if (have_regulator)
> > > check, and it is a fair request. What I will instead do is, allow all
> > > dev_pm_opp_put*() API to start accepting a NULL pointer for the OPP
> > > table and fail silently. And so you won't be required to have this
> > > unwanted check. But you will be required to save the pointer returned
> > > back by dev_pm_opp_set_regulators(), which is the right thing to do
> > > anyways.
> >
> > Perhaps even a better variant could be to add a devm versions of the OPP
> > API functions, then drivers won't need to care about storing the
> > opp_table pointer if it's unused by drivers.
> 
> I think so. The consumer may not be so concerned about the status of
> these OPP tables.
> If the driver needs to manage the release, it needs to add a pointer
> to their driver global structure.
> 
> Maybe it's worth having these devm interfaces for opp.

Sure if there are enough users of this, I am all for it. I was fine
with the patches you sent, just that there were not a lot of users of
it and so I pushed them back. If we find that we have more users of it
now, we can surely get that back.

-- 
viresh
