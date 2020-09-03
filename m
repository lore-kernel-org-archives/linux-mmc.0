Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82722C43461
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50DF8206EF
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8FbPyMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgICOqB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgICOfR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 10:35:17 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C6FC061245
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 07:35:16 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a16so1823283vsp.12
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXLxFi+fNCyjeqFnfAYDTSiQ62DVLQBxSbiw89atuck=;
        b=C8FbPyMoOuaDAUAP3f6Tkl0bV7CbwuPoTySJwTJt/01GpE+KCTnWNnGUtKNKPTCaiQ
         0h840v0TCvEk+7wTUtgVDPJ1KqE9eNc3jxsZYrpi4GMk0FmgnW1ga0OgwW2QJv04wdLp
         /p3Lhr/5FCpe7NCfyVFe4jL0DICEnJBP5lN2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXLxFi+fNCyjeqFnfAYDTSiQ62DVLQBxSbiw89atuck=;
        b=ldA5oLi9YtxXH6leu8XnfdCLanwvOuN1aXnmr7eALc5Y0kTr4D42hRBJW4DGCUjZwk
         lNY16gg9JV488Kfx/IlPPKH+gr6QarWawZdexlV8eEYgmqHafmhuaVe3D8KWUDaV8PSD
         2ZL7J7tk5nm6AHxOuyDPirE9ewcZ+Jl9e7V0uNMfF1f2X7Am7w3fhqSZS+4W+eaWtQt1
         CcdP49Nug7NGNaWLd2FfxxEvylFJbjUFZ/F+Iu/eI5kVFZCBIIYlDk/ih4dAJm/p1GoE
         h6ttABDEouPVWB+brpwxzZgsq7gg5Gba7apGkGZ0xDBHnBIFzhNWrMnNCmj4cjjLD4Cc
         3Tgw==
X-Gm-Message-State: AOAM533RuHMvRc9PtvYjevTKYIG2GRqZN18w8Ge/6HfOdOqK70UXlU2H
        vT3kuNTY2itrXol9SLWMHEdB5OAB1hcBWA==
X-Google-Smtp-Source: ABdhPJxLoM3iHWOmOaSjpOwfeR8bbbFFU1Awfio+fOy0irA9zQEjE0tkxAcVEE0P6Mi/hs33RGcrKg==
X-Received: by 2002:a67:77c5:: with SMTP id s188mr1587772vsc.9.1599143715307;
        Thu, 03 Sep 2020 07:35:15 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id g142sm524362vkg.36.2020.09.03.07.35.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 07:35:14 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id j188so1863378vsd.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 07:35:14 -0700 (PDT)
X-Received: by 2002:a67:e447:: with SMTP id n7mr2033870vsm.53.1599143714032;
 Thu, 03 Sep 2020 07:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200902164303.1.I5e598a25222b4534c0083b61dbfa4e0e76f66171@changeid>
 <CAPDyKFoyKjKhwKGtLMtEyDSeSiBU6wasc=jt6c=sHnhN8jqqjg@mail.gmail.com>
In-Reply-To: <CAPDyKFoyKjKhwKGtLMtEyDSeSiBU6wasc=jt6c=sHnhN8jqqjg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Sep 2020 07:35:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WaWwJnquPy+9aB89-1OwKmYKJv2PpfOkgo94Z6J8uRUg@mail.gmail.com>
Message-ID: <CAD=FV=WaWwJnquPy+9aB89-1OwKmYKJv2PpfOkgo94Z6J8uRUg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Prefer asynchronous probe
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Sep 3, 2020 at 1:10 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 3 Sep 2020 at 01:43, Douglas Anderson <dianders@chromium.org> wrote:
> >
> > Turning on initcall debug on one system showed this:
> >   initcall sdhci_msm_driver_init+0x0/0x28 returned 0 after 34782 usecs
> >
> > The lion's share of this time (~33 ms) was in mmc_power_up().  This
> > shouldn't be terribly surprising since there are a few calls to delay
> > based on "power_delay_ms" and the default delay there is 10 ms.
> >
> > Because we haven't specified that we'd prefer asynchronous probe for
> > this driver then we'll wait for this driver to finish before we start
> > probes for more drivers.  While 33 ms doesn't sound like tons, every
> > little bit counts.
> >
> > There should be little problem with turning on asynchronous probe for
> > this driver.  It's already possible that previous drivers may have
> > turned on asynchronous probe so we might already have other things
> > (that probed before us) probing at the same time we are anyway.  This
> > driver isn't really providing resources (clocks, regulators, etc) that
> > other drivers need to probe and even if it was they should be handling
> > -EPROBE_DEFER.
> >
> > Let's turn this on and get a bit of boot speed back.
>
> Thanks for a very well written commit message!
>
> Indeed, I am sure many mmc host drivers could benefit from a similar
> change. At least regular platform drivers and amba drivers are pretty
> sure to work, but who knows.

Yeah, and many non-mmc drivers can benefit too, which is why I've been
sending several of these patches recently as I optimize boot perf on
the device that's sitting in front of me.  ;-)  I think the idea was
that eventually we'd want the kernel to just turn on async by default
everywhere, but at the time the flag was introduced there were too
many subtle bugs everywhere.  It feels like one way to get to the
point where we'd be confident that this is OK to turn on everywhere is
to just start turning it on in lots of places.  Once enough places
have it on then perhaps that will give folks confidence that it's OK
to turn on by default across the board.

If you'd like, I can post patches to update some other set of MMC host
drivers, either as one giant patch (hard to backport, but not as
spammy) or as a large pile of patches.  I've never played with
coccinelle so I'd probably fall back to doing this by hand.  I could
probably only test on a small handful (I think I have easy access to
dw-mmc-rockchip and sdhci-of-arasan besides the msm one I already
posted), so another option is that I could also just post for those
devices...  ...or we can just hope others will notice and start
posting similar patches themselves after testing.  Let me know what
you'd prefer.  ;-)

-Doug
