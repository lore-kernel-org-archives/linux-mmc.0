Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5BC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 19:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828BF23E1B
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 19:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394959AbgLKRQ3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 12:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394972AbgLKRQO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 12:16:14 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EFC061793
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 09:15:34 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id y21so3079403uag.2
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 09:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUEgiLmSeI6Q1u1HNVZh1Cnm5uFnZ0d8AVhdmGbuyUU=;
        b=ECZu43wU6hEpbMZX8fA/dHxJuqO3lcX10+RLeEn0tEt3xCAQ7+oLpuN6PqwjoogUlG
         OXNXT4DvyqxtMkdyImXZGKOZQ6polk+7kMOLxZbxD2BDmWqLngo+XoQS9vD/1gLYHQJV
         F2vbXzsOz2DmdZgAd+UrSrOjox8gABBuz8yEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUEgiLmSeI6Q1u1HNVZh1Cnm5uFnZ0d8AVhdmGbuyUU=;
        b=HQQ0ybdiexeWvfRrke8ZXC1xKG3ADxikyewRpkBQVImT69Ek2urcYr3IPqonVvMD9O
         Fb34cAWZ+GzucgLTk+MsB6hB5Qx0JneCM+upAzd8S/nIFI5TXfMfOXU3Rx/RJA+pQqcP
         X1no7xaG+fZT8Zvr+VrEQ2TO/MDvous7FtlYb1NbHKGQRM2ZaZHmp+xVJn77yZ682YBW
         uz2vAMfTdEDWA00exEqsWmNRHLzTlU18vYPnEqdlNXRFzbeu9MfUE4U/PbZIAmQa3vs9
         e9I/n3Bqr8irC5AxIYVf5lububu8k/kSvEmfoqxm5TQtrYKpX9Q9XXzN91Sb1coJmZeq
         42bg==
X-Gm-Message-State: AOAM533JhhlivgEJg83MbbIBtyuZgYfg9Jsksl9/ZMA8JrFY4p6S9JJy
        0C3ZIhw+RCNwaFdvSseDhf8ZGqZ9GnBTKQ==
X-Google-Smtp-Source: ABdhPJzHPDoOAnFkdvCdIz+1/bWFLugXNQYGOYQUgosh/bpeAutFajwU2w3gWOwQlOgiGsQyHdv7Jg==
X-Received: by 2002:ab0:6aa:: with SMTP id g39mr13540368uag.71.1607706933559;
        Fri, 11 Dec 2020 09:15:33 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id l126sm18242vsd.15.2020.12.11.09.15.32
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:15:33 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id p7so5175215vsf.8
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 09:15:32 -0800 (PST)
X-Received: by 2002:a67:bd01:: with SMTP id y1mr7561461vsq.49.1607706931955;
 Fri, 11 Dec 2020 09:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20201210132745.v3.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
 <757616c0-8111-c7db-893b-31931a9d4ed0@intel.com>
In-Reply-To: <757616c0-8111-c7db-893b-31931a9d4ed0@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 11 Dec 2020 09:15:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VKmhqiP=spGm7McRL1tjFCKjXk8V91sKU1PvL7v_85KA@mail.gmail.com>
Message-ID: <CAD=FV=VKmhqiP=spGm7McRL1tjFCKjXk8V91sKU1PvL7v_85KA@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Warn about overclocking SD/MMC
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Dec 10, 2020 at 9:56 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 10/12/20 11:27 pm, Douglas Anderson wrote:
> > As talked about in commit 5e4b7e82d497 ("clk: qcom: gcc-sdm845: Use
> > floor ops for sdcc clks"), most clocks handled by the Qualcomm clock
> > drivers are rounded _up_ by default instead of down.  We should make
> > sure SD/MMC clocks are always rounded down in the clock drivers.
> > Let's add a warning in the Qualcomm SDHCI driver to help catch the
> > problem.
> >
> > This would have saved a bunch of time [1].
> >
> > [1] http://lore.kernel.org/r/20201210102234.1.I096779f219625148900fc984dd0084ed1ba87c7f@changeid
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v3:
> > - Proper printf format code.
> >
> > Changes in v2:
> > - Store rate in unsigned long, not unsigned int.
> > - Reuse the clk_get_rate() in the later print.
> >
> >  drivers/mmc/host/sdhci-msm.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 3451eb325513..50beb407dbe9 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -353,6 +353,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
> >       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> >       struct mmc_ios curr_ios = host->mmc->ios;
> >       struct clk *core_clk = msm_host->bulk_clks[0].clk;
> > +     unsigned long achieved_rate;
> >       int rc;
> >
> >       clock = msm_get_clock_rate_for_bus_mode(host, clock);
> > @@ -363,10 +364,20 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
> >                      curr_ios.timing);
> >               return;
> >       }
> > +
> > +     /*
> > +      * Qualcomm clock drivers by default round clock _up_ if they can't
> > +      * make the requested rate.  This is not good for SD.  Yell if we
> > +      * encounter it.
> > +      */
> > +     achieved_rate = clk_get_rate(core_clk);
> > +     if (achieved_rate > clock)
> > +             pr_warn("%s: Card appears overclocked; req %u Hz, actual %lu Hz\n",
> > +                     mmc_hostname(host->mmc), clock, achieved_rate);
>
> How does a warning help?

The actual fixes are made in the clock drivers, but this seems to be a
common problem in Qualcomm clock drivers.  ...so while this doesn't
actually fix the problem, it hopefully calls enough attention that
someone will know to fix it in the clock driver.


> Also, did you consider setting host->mmc->actual_clock

That makes sense, though I think logically it's a separate change.
I'll add it as patch #2 in the series.  It's not as trivial as I would
have thought.  ;-)

-Doug

>
> > +
> >       msm_host->clk_rate = clock;
> >       pr_debug("%s: Setting clock at rate %lu at timing %d\n",
> > -              mmc_hostname(host->mmc), clk_get_rate(core_clk),
> > -              curr_ios.timing);
> > +              mmc_hostname(host->mmc), achieved_rate, curr_ios.timing);
> >  }
> >
> >  /* Platform specific tuning */
> >
>
