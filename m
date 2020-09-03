Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E124DC433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8EDC206EB
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 14:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q+YmVJhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgICOpO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgICOoj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 10:44:39 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2449C061246
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 07:44:38 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id q67so1873748vsd.5
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XR70+EUXVIRU3zQfQqSwfmIgUCJ1T/jLwDVLHaYTwdA=;
        b=q+YmVJhrr3u/P/vNMvD3sirXji3jW45KNikG/MThND5oLQo4pQW2QSRSpsgrg2SE06
         QU8V7NYTyO4FoFdz1mbouIlCT6/21Y1Hi+M8++sF4oCJfenetCOhmLch+K019oNdL22D
         9KuQl536/+Wai/tFatgvxtjabLird/zbZVW12C/iR8IwUDCty1QA/9/Mp1OgctvOVI33
         kIqrcbKwZXW1x2LTgHVGgNfff9vof6HpPLfOyvVLJGDFl91tsZIyiGZo8u9RdQn3CG9J
         eZHvGAOP+iN+EvL6dnCFj0IkT78aQfQ+KBaavUjNF/Bxh3/LZoxYntDNTxbUdorOADY3
         JRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XR70+EUXVIRU3zQfQqSwfmIgUCJ1T/jLwDVLHaYTwdA=;
        b=lCHmuv6bfRdk+LGIXrLkp6c7DsIQq49JCgjqp4N+VwW+xIuhEOPkGXMvI1TsAkATEV
         ITrIiVzhf57nUNN+mExkgWNgin+q4CbLdXjs9G/7Vt5MwlfCFExnqhmAZQ4pbPB3Qelg
         QJ3FETmEDLm556PlppCXWIKqkHLD59BD7iflyH1suW1+LrdP1lVID06NJpVMRLYoL+LY
         PB3Io9JH5pXcF0VIn6riaZiZba2dNmmGaO0LEV6TTfXy54FBdmVWRar3jIWvoPgIZJ5R
         KoP+BnuB4aVryLnf/0azjmBAlYSkLXHDXTqbdkkmOsgWvTo5Ph4f/0yakJfWCDH0JaJi
         ShIQ==
X-Gm-Message-State: AOAM532SSt8ycTvfVsIfPAZcjZJok0uH/rrL8hAap5cAOeysEGBYagmc
        FooYPRgUSesEwSOXTDsAXEWY/OLfXJAhzUWuz9o/Wg==
X-Google-Smtp-Source: ABdhPJz53TmR5rRF/V50sMeRUYI4APGHmXZws5YFjaDRWUVJAeLr3zEflEDUQfV/gVl2WeV7nmD9xv03OA62d2Xvm1w=
X-Received: by 2002:a67:e45:: with SMTP id 66mr2085958vso.191.1599144277973;
 Thu, 03 Sep 2020 07:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200902164303.1.I5e598a25222b4534c0083b61dbfa4e0e76f66171@changeid>
 <CAPDyKFoyKjKhwKGtLMtEyDSeSiBU6wasc=jt6c=sHnhN8jqqjg@mail.gmail.com> <CAD=FV=WaWwJnquPy+9aB89-1OwKmYKJv2PpfOkgo94Z6J8uRUg@mail.gmail.com>
In-Reply-To: <CAD=FV=WaWwJnquPy+9aB89-1OwKmYKJv2PpfOkgo94Z6J8uRUg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 16:44:01 +0200
Message-ID: <CAPDyKFq31bucJhP9hp1HSqh-qM2uNGHgDoyQpmbJf00nEf_T4Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Prefer asynchronous probe
To:     Doug Anderson <dianders@chromium.org>
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

On Thu, 3 Sep 2020 at 16:35, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Sep 3, 2020 at 1:10 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 3 Sep 2020 at 01:43, Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > Turning on initcall debug on one system showed this:
> > >   initcall sdhci_msm_driver_init+0x0/0x28 returned 0 after 34782 usecs
> > >
> > > The lion's share of this time (~33 ms) was in mmc_power_up().  This
> > > shouldn't be terribly surprising since there are a few calls to delay
> > > based on "power_delay_ms" and the default delay there is 10 ms.
> > >
> > > Because we haven't specified that we'd prefer asynchronous probe for
> > > this driver then we'll wait for this driver to finish before we start
> > > probes for more drivers.  While 33 ms doesn't sound like tons, every
> > > little bit counts.
> > >
> > > There should be little problem with turning on asynchronous probe for
> > > this driver.  It's already possible that previous drivers may have
> > > turned on asynchronous probe so we might already have other things
> > > (that probed before us) probing at the same time we are anyway.  This
> > > driver isn't really providing resources (clocks, regulators, etc) that
> > > other drivers need to probe and even if it was they should be handling
> > > -EPROBE_DEFER.
> > >
> > > Let's turn this on and get a bit of boot speed back.
> >
> > Thanks for a very well written commit message!
> >
> > Indeed, I am sure many mmc host drivers could benefit from a similar
> > change. At least regular platform drivers and amba drivers are pretty
> > sure to work, but who knows.
>
> Yeah, and many non-mmc drivers can benefit too, which is why I've been
> sending several of these patches recently as I optimize boot perf on
> the device that's sitting in front of me.  ;-)  I think the idea was
> that eventually we'd want the kernel to just turn on async by default
> everywhere, but at the time the flag was introduced there were too
> many subtle bugs everywhere.  It feels like one way to get to the
> point where we'd be confident that this is OK to turn on everywhere is
> to just start turning it on in lots of places.  Once enough places
> have it on then perhaps that will give folks confidence that it's OK
> to turn on by default across the board.

Yeah, I guess this is the only way forward at this point.

>
> If you'd like, I can post patches to update some other set of MMC host
> drivers, either as one giant patch (hard to backport, but not as
> spammy) or as a large pile of patches.  I've never played with
> coccinelle so I'd probably fall back to doing this by hand.  I could
> probably only test on a small handful (I think I have easy access to
> dw-mmc-rockchip and sdhci-of-arasan besides the msm one I already
> posted), so another option is that I could also just post for those
> devices...  ...or we can just hope others will notice and start
> posting similar patches themselves after testing.  Let me know what
> you'd prefer.  ;-)

Honestly, I don't know. You go ahead with the option you prefer - then
I will have a look. :-)

Don't worry if we break some, as it should be rather easy to fix - as
long as we keep an eye on it.

Kind regards
Uffe
