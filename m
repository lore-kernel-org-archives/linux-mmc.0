Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE11C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 21:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B15122EBF
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 21:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390489AbgLJVU6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 16:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391716AbgLJVU5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2020 16:20:57 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5B1C0617A6
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 13:20:17 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id b23so3660809vsp.9
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 13:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZsPNOAvTFnun1hxdUG5olOnkQwo5sBEF+e1/v4quww=;
        b=jYty1q9fAhXqrLY26mhEm9pkJfzO5JwKzM4fje3wkEZwQtCclijrvoubG9bJzThLyF
         YZbyHMEwiMIkWkfRGCOpVfFKbvktQMEOtYm3TprWZo8bGaYo6Q49c17SMZ1C9h/lDhJa
         bz03EzZ9KJhNFXQ/xnVf9eCIA55b0QgPg3+JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZsPNOAvTFnun1hxdUG5olOnkQwo5sBEF+e1/v4quww=;
        b=Tj2NbVq9UjM/m6yB/BFdhCl/Ju0ViqDcV2rg4Jq/Gb76XbhoOqQdSR/+slDoHlhgd+
         cL/jO++G3wvt7GI0rlaU6LxAYyoCmZgo/8JTVgtrgyG0wdtFv5B6AKvb6j3/Bl07OaVI
         Zc29U6zlD1+fMjsCRncAZpf9H1PbvTFeRLXNhiARKmttqo6fYiKOe9jxRFwdInkKOOhd
         cJHWn7NY13kQ8H4AZ8+cgGHkyYowxjX5fiFKVOQJ9EbZEGhnzFitPsQ0zE3XPc7qVuVa
         6XfjWRqXq7DuNI6VCoXIIs2n/7bRp1/JG7gbewIMAz/mkw3jpNvX28phCmGW8sWVgdr3
         Pu+g==
X-Gm-Message-State: AOAM5322s3bykw3MjbGBum8VABibmk+uPI+wK3W3NDC4FUqiwLtWLQpL
        rInzEbKpFotgam2wpLYZZyugg6jy1EBYow==
X-Google-Smtp-Source: ABdhPJweP3pECTLvVUHf3+4QQKn59kAmwVd/4GSr5+yJ0MdzJhNVNbBmSX6gzo+KzONGyuOIoNeCUA==
X-Received: by 2002:a67:881:: with SMTP id 123mr10859875vsi.10.1607635216438;
        Thu, 10 Dec 2020 13:20:16 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id w202sm674940vkd.25.2020.12.10.13.20.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 13:20:15 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id 4so2175594uap.8
        for <linux-mmc@vger.kernel.org>; Thu, 10 Dec 2020 13:20:15 -0800 (PST)
X-Received: by 2002:a9f:3dcc:: with SMTP id e12mr10613727uaj.121.1607635214734;
 Thu, 10 Dec 2020 13:20:14 -0800 (PST)
MIME-Version: 1.0
References: <20201210125709.1.Iec3430c7d3c2a29262695edef7b82a14aaa567e5@changeid>
 <160763420585.1580929.9586717907613124743@swboyd.mtv.corp.google.com>
In-Reply-To: <160763420585.1580929.9586717907613124743@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Dec 2020 13:20:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V2E6W_1PtqBy6Fo_Cxp6kygpeitEkaMG5bMRpv7gO53w@mail.gmail.com>
Message-ID: <CAD=FV=V2E6W_1PtqBy6Fo_Cxp6kygpeitEkaMG5bMRpv7gO53w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Warn about overclocking SD/MMC
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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

On Thu, Dec 10, 2020 at 1:03 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-12-10 12:57:25)
> > diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> > index 3451eb325513..dd41f6a4dbfb 100644
> > --- a/drivers/mmc/host/sdhci-msm.c
> > +++ b/drivers/mmc/host/sdhci-msm.c
> > @@ -353,6 +353,7 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
> >         struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> >         struct mmc_ios curr_ios = host->mmc->ios;
> >         struct clk *core_clk = msm_host->bulk_clks[0].clk;
> > +       unsigned int achieved_rate;
>
> unsigned long?

I'm matching the type for the parameter.  ...but I guess you're right
that it's better to match clk_get_rate().

NOTE: I'm _not_ planning to change the parameter because it matches
the type in 'struct mmc_ios' and that feels like a much bigger change
to tweak.


> >         int rc;
> >
> >         clock = msm_get_clock_rate_for_bus_mode(host, clock);
> > @@ -363,6 +364,17 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
> >                        curr_ios.timing);
> >                 return;
> >         }
> > +
> > +       /*
> > +        * Qualcomm clock drivers by default round clock _up_ if they can't
> > +        * make the requested rate.  This is not good for SD.  Yell if we
> > +        * encounter it.
> > +        */
> > +       achieved_rate = clk_get_rate(core_clk);
> > +       if (achieved_rate > clock)
> > +               pr_warn("%s: Card appears overclocked; req %u Hz, actual %d Hz\n",
>
> Can we use dev_warn?

What's here matches other prints including other ones in the same
function and in much of the MMC subsystem.  mmc_hostname() shows
"mmc1"

> dev_warn(mmc_dev(mmc)
> dev_warn(&msm_host->pdev->dev

This show "sdhci_msm 7c4000.sdhci"

I'm going to keep with tradition and keep using mmc_hostname().  In
some parts of this file they use both (a dev_warn that also includes
the mmc_hostname()) but that feels overkill.

> ?
>
> > +                       mmc_hostname(host->mmc), clock, achieved_rate);
> > +
> >         msm_host->clk_rate = clock;
> >         pr_debug("%s: Setting clock at rate %lu at timing %d\n",
> >                  mmc_hostname(host->mmc), clk_get_rate(core_clk),
>
> This could use achieved_rate now.

Sure.

I sent up a real quick v2 since it seemed like these were small fixes
and maybe this was all good otherwise.


-Doug
