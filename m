Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F115CC433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA342075B
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 15:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G8e1hSdW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgH1PGX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgH1PGR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 11:06:17 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58259C06121B
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 08:06:17 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g20so465627uap.8
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP81KhbFfFMLjt/9HZBr2wWZSwrB3/aa9mKjEXE/AKE=;
        b=G8e1hSdWLuYEJPV3B0RaF3rvGxxGkCTIF80d31pPr9iF136sww25RkRnSUV+j1AcVv
         H9OJX1KXsDnaVLCtVvW7DPjEh69HZSR8Wupn9bRJ83yTG9C9qa0dn2v0dqy+eonTsPmp
         MohmqV0MA4Mfl9vG7cBkhQAXWLoMyULgQUxkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP81KhbFfFMLjt/9HZBr2wWZSwrB3/aa9mKjEXE/AKE=;
        b=SOVsBT4KFVjGkzxHfj54o6VDTEx0P6F2HVAj/o2no/SBCDChFruy00t0O2mBvP2tA4
         wVTmq9IXf8WKQyt8yIqSqBP0zj34Wf2wHIDLsT0PN+7G5HZxn12o3JTVd6v/sbwzWn7S
         ewOzBlXUUUifLmg2iOKHrVaKg9aRWy2xeP2P6ojmLopC1b8xkwC+5H1hwLR7x8KGJIK7
         2krNDUzqoTmnwZXlS0UYoDnMpZioOEGwywcxAdUw8Mtv6XvMIIxfJiEKSN21j+TamQvA
         L98eP8CpXaZeuWt/OOqMGYMH5Vyz8u5+ljknL17VJb6UMXMr4mCac4CF/W3MTbykUC0g
         phiQ==
X-Gm-Message-State: AOAM530MrBFF3d63s0N1G7VFe4IJnb0ZLe6SDpS/vxBsfJDy1EduAGjI
        B3YRD+kvaqh3i9GVQJ6LLJyPaF5nMmmHXA==
X-Google-Smtp-Source: ABdhPJzwQ4BZCmYR2ZyPSJKNLgKLVQx4OyktMv/5hni3JLVCbVPKxpjJAsJcsR3UkRN2uyeq4geJjg==
X-Received: by 2002:ab0:21cf:: with SMTP id u15mr1377086uan.85.1598627176337;
        Fri, 28 Aug 2020 08:06:16 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id j20sm208558vsg.18.2020.08.28.08.06.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:06:15 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id y3so742842vsn.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 08:06:15 -0700 (PDT)
X-Received: by 2002:a05:6102:10de:: with SMTP id t30mr1312397vsr.13.1598627175058;
 Fri, 28 Aug 2020 08:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598594714.git.viresh.kumar@linaro.org> <1d7c97524b9e1fbc60271d9c246c5461ca8a106c.1598594714.git.viresh.kumar@linaro.org>
 <CAPDyKFpdZhzXQv3hpTzf3UkJDhFqBhgMXCqVfAfE6PejLCxvfg@mail.gmail.com>
In-Reply-To: <CAPDyKFpdZhzXQv3hpTzf3UkJDhFqBhgMXCqVfAfE6PejLCxvfg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 28 Aug 2020 08:06:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UP2ZA_GB8nzrpFNP3VzB6AZtEZaagVO5qggW+8EQ0THQ@mail.gmail.com>
Message-ID: <CAD=FV=UP2ZA_GB8nzrpFNP3VzB6AZtEZaagVO5qggW+8EQ0THQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Aug 28, 2020 at 1:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 28 Aug 2020 at 08:08, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> > find the OPP table with error -ENODEV (i.e. OPP table not present for
> > the device). And we can call dev_pm_opp_of_remove_table()
> > unconditionally here.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Replaced v1 with v2 on my next branch, thanks!

Actually, I don't see it on there yet, but at least the old broken v1
isn't there anymore.  ;-)

I picked v2 and tried it on my sc7180-based device (which does have
OPP tables).  It worked fine.  Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

I looked at the code and it looks right to me.  Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


> Just to be sure, this patch doesn't depend on any changes for the opp
> core that are queued for v5.10?

Running atop mmc-next, I see the check for -ENODEV, so I'm gonna
assume that the required change is there.

$ git grep -A10 'void _dev_pm_opp_find_and_remove_table' -- drivers/opp/core.c
drivers/opp/core.c:void _dev_pm_opp_find_and_remove_table(struct device *dev)
drivers/opp/core.c-{
drivers/opp/core.c-     struct opp_table *opp_table;
drivers/opp/core.c-
drivers/opp/core.c-     /* Check for existing table for 'dev' */
drivers/opp/core.c-     opp_table = _find_opp_table(dev);
drivers/opp/core.c-     if (IS_ERR(opp_table)) {
drivers/opp/core.c-             int error = PTR_ERR(opp_table);
drivers/opp/core.c-
drivers/opp/core.c-             if (error != -ENODEV)
drivers/opp/core.c-                     WARN(1, "%s: opp_table: %d\n",
