Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD228C433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 901FF20797
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 23:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mRUfysYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgICX2z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgICX2v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 19:28:51 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69383C061244
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 16:28:50 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a16so2666191vsp.12
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 16:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zBCZhBygC1UVuyhB28Mkxg6VIAClsA68YLoMi7be6qk=;
        b=mRUfysYmS3NDn5aKWuf1gtB4334+e2ypg80FQGoiH8AAUtyd428dXVDQmMJNlU9aA/
         J3oeET6+toomiPWirNevd0JtqTZEnYWTMIZeeb6+op3mgRtvOiIgZhfTeMuv96i5JMlE
         +wwugTe/+akeQf5UVpePPMPBkPTLlwJ84wltE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBCZhBygC1UVuyhB28Mkxg6VIAClsA68YLoMi7be6qk=;
        b=gpamNIL2zCEBb2Zh/w8MOUqXKdV1cGKBZuOuBSpYDSZqp/CnlljzVWh6qK4DK5Nmys
         MUqwanCXMS69X30wid4fpPAWylv+tXdkGbvXuVVafqxlkutk3rz0WyCIAQ6873CoRM18
         L9jmzUUyHvryO8WKTj/1NAOFd/z+yPDjAddZCKy5eNf1NEsZQb0oj4+N7ficQWa6905Q
         ATZ81Br85G+ih34vrJ0ml00uMHh3nYD8HuZ3RfsJk06MJopNnAjYb63T23owtQFy7UqP
         yRMb6ljSE5aIh2GJCmmPKkO9RDj+jzLDCDZMo+rlYpN/iMea8E3wKG8lRuFUMKhJTBcP
         doDQ==
X-Gm-Message-State: AOAM533JhAW9jHn+qDG2pQnTXI1XClX4UNqYK+PT3/u7TiWKbPg/Qe7r
        Ixo7N5QCHy3TD2GGnvrRS7UvJsZd6hFjxA==
X-Google-Smtp-Source: ABdhPJzkedWd3Pa9VtlyNUVHxBvB7uUlEhygaMPJqzJhUPSzScdLMsjGX9wshfH/r2yUcjMY7Srq6g==
X-Received: by 2002:a67:ea88:: with SMTP id f8mr3251999vso.2.1599175729348;
        Thu, 03 Sep 2020 16:28:49 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 7sm727069vks.48.2020.09.03.16.28.48
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 16:28:48 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id q67so2704015vsd.5
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 16:28:48 -0700 (PDT)
X-Received: by 2002:a67:2203:: with SMTP id i3mr4069456vsi.110.1599175728077;
 Thu, 03 Sep 2020 16:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200902164303.1.I5e598a25222b4534c0083b61dbfa4e0e76f66171@changeid>
 <CAPDyKFoyKjKhwKGtLMtEyDSeSiBU6wasc=jt6c=sHnhN8jqqjg@mail.gmail.com>
 <CAD=FV=WaWwJnquPy+9aB89-1OwKmYKJv2PpfOkgo94Z6J8uRUg@mail.gmail.com> <CAPDyKFq31bucJhP9hp1HSqh-qM2uNGHgDoyQpmbJf00nEf_T4Q@mail.gmail.com>
In-Reply-To: <CAPDyKFq31bucJhP9hp1HSqh-qM2uNGHgDoyQpmbJf00nEf_T4Q@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Sep 2020 16:28:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UK+Ri8MN+Ty4rC-OmDCBLPjiRx8s8d8w35JbuT8z7LjQ@mail.gmail.com>
Message-ID: <CAD=FV=UK+Ri8MN+Ty4rC-OmDCBLPjiRx8s8d8w35JbuT8z7LjQ@mail.gmail.com>
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

On Thu, Sep 3, 2020 at 7:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 3 Sep 2020 at 16:35, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Sep 3, 2020 at 1:10 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 3 Sep 2020 at 01:43, Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > Turning on initcall debug on one system showed this:
> > > >   initcall sdhci_msm_driver_init+0x0/0x28 returned 0 after 34782 usecs
> > > >
> > > > The lion's share of this time (~33 ms) was in mmc_power_up().  This
> > > > shouldn't be terribly surprising since there are a few calls to delay
> > > > based on "power_delay_ms" and the default delay there is 10 ms.
> > > >
> > > > Because we haven't specified that we'd prefer asynchronous probe for
> > > > this driver then we'll wait for this driver to finish before we start
> > > > probes for more drivers.  While 33 ms doesn't sound like tons, every
> > > > little bit counts.
> > > >
> > > > There should be little problem with turning on asynchronous probe for
> > > > this driver.  It's already possible that previous drivers may have
> > > > turned on asynchronous probe so we might already have other things
> > > > (that probed before us) probing at the same time we are anyway.  This
> > > > driver isn't really providing resources (clocks, regulators, etc) that
> > > > other drivers need to probe and even if it was they should be handling
> > > > -EPROBE_DEFER.
> > > >
> > > > Let's turn this on and get a bit of boot speed back.
> > >
> > > Thanks for a very well written commit message!
> > >
> > > Indeed, I am sure many mmc host drivers could benefit from a similar
> > > change. At least regular platform drivers and amba drivers are pretty
> > > sure to work, but who knows.
> >
> > Yeah, and many non-mmc drivers can benefit too, which is why I've been
> > sending several of these patches recently as I optimize boot perf on
> > the device that's sitting in front of me.  ;-)  I think the idea was
> > that eventually we'd want the kernel to just turn on async by default
> > everywhere, but at the time the flag was introduced there were too
> > many subtle bugs everywhere.  It feels like one way to get to the
> > point where we'd be confident that this is OK to turn on everywhere is
> > to just start turning it on in lots of places.  Once enough places
> > have it on then perhaps that will give folks confidence that it's OK
> > to turn on by default across the board.
>
> Yeah, I guess this is the only way forward at this point.
>
> >
> > If you'd like, I can post patches to update some other set of MMC host
> > drivers, either as one giant patch (hard to backport, but not as
> > spammy) or as a large pile of patches.  I've never played with
> > coccinelle so I'd probably fall back to doing this by hand.  I could
> > probably only test on a small handful (I think I have easy access to
> > dw-mmc-rockchip and sdhci-of-arasan besides the msm one I already
> > posted), so another option is that I could also just post for those
> > devices...  ...or we can just hope others will notice and start
> > posting similar patches themselves after testing.  Let me know what
> > you'd prefer.  ;-)
>
> Honestly, I don't know. You go ahead with the option you prefer - then
> I will have a look. :-)
>
> Don't worry if we break some, as it should be rather easy to fix - as
> long as we keep an eye on it.

OK, I probably spent way too much time on it, but here it is in all of
its glory:

https://lore.kernel.org/r/20200903232441.2694866-1-dianders@chromium.org/

-Doug
