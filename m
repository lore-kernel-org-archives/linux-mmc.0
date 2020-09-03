Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBFDC43461
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9997520C09
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMAZ0Z4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgICIL1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgICILJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:11:09 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA9C061244
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:11:07 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x203so1226632vsc.11
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbOZznoyRPyqU6PnrSaB5jo0mTGED46o3I4A422iJoA=;
        b=EMAZ0Z4psDBBdPWzZh1kA5hCaz9bbeRQRfwZHQuYBTBmdGilyg0EXZgogvYILPoL76
         h5dulTcOt/ZXzHOyGoMB4zF3pXoO67O1F5Rt6FNZ5mM1FBgF9dQmQaiktM6Iwu4r2d0z
         js4rOxGv3zLMN4Z+EDQ/V71B0Z44TVWVM9INqklVTtdDkUr53AwAPlsWfN6DHNhIXb1h
         T+o07G7dZFRhJkItMKMnMDWK916bntLv7TNRWQYUFVTvhkndlqsWvrunk/l9N5VDrbWx
         lQCSM8mOxkal8J1cJUogqa9qSWO0xjcIFoI3HSKEFe5ocieaMjc21BLNP+Az4nU3W0mI
         ULGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbOZznoyRPyqU6PnrSaB5jo0mTGED46o3I4A422iJoA=;
        b=dpBENHsVPm8NrCd3MSYiIVCmzKZx7KLuQmQb+IhyANmh8H8aptjkq8Wtu61EM+HhBx
         O8yX0blq5DFtfUCg1dHTOW9q6Dfrit4zfoURs9AEuZSfgzjdw0KWu6u3ueEPHSlTQCU4
         qhY20zq02NyzgKvfVslsnL86MJWUZNiBC5rZB8DI6rOz4TmIyGRdRUGNa358DxRxZ4S3
         0iiWDy9Z9PQSI/djSmbpBcYscpAUM2wH9/k4V+z1VJUL9Er2/7hiOq2UVsnabhP4ipr2
         hA6zYUPiahP9iqKTS8YYEIyTQF4m5FltHgRsvN/N2cZMuUAoEA+YmK6Lh53EjuQPbv9A
         S1SA==
X-Gm-Message-State: AOAM531GA7WAJv4j841IgwC2CVP0Sg5A6Y6d+B6A1M4tIZHVKjc/RjXd
        trcWikYZiNvfFZateoa0grYqDxwhs2uK+PsGm76qlA==
X-Google-Smtp-Source: ABdhPJy/lUWIwq0MTEX0/xDsUbaBwYL1Hpa6s0IrnU5Lo8CRHnV2xO8ZyqtzzzDZhQHNh1yZqp4fDZRDw4AI0bjjwXY=
X-Received: by 2002:a67:e45:: with SMTP id 66mr854515vso.191.1599120666254;
 Thu, 03 Sep 2020 01:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
 <20200901150654.GB30034@lst.de> <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
 <20200901154049.GA376@lst.de> <CAPDyKFqDKUG3RC241hv535CLFGEQc4b-vv0e3bexzGkDSY82Jg@mail.gmail.com>
 <20200902134418.GR3265@brightrain.aerifal.cx> <CAMuHMdUiPhHtkQfcpMSA6HMvmcFyg__rSGUoHRKQfQf2N5QTYA@mail.gmail.com>
 <20200903004135.GT3265@brightrain.aerifal.cx>
In-Reply-To: <20200903004135.GT3265@brightrain.aerifal.cx>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:30 +0200
Message-ID: <CAPDyKFongKHXianvz0T7spcV8jHff_usagO1xM9-60ya=KW6zg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
To:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Sep 2020 at 02:41, Rich Felker <dalias@libc.org> wrote:
>
> On Wed, Sep 02, 2020 at 05:51:16PM +0200, Geert Uytterhoeven wrote:
> > Hi Rich,
> >
> > On Wed, Sep 2, 2020 at 5:43 PM Rich Felker <dalias@libc.org> wrote:
> > > On Wed, Sep 02, 2020 at 10:31:47AM +0200, Ulf Hansson wrote:
> > > > On Tue, 1 Sep 2020 at 17:40, Christoph Hellwig <hch@lst.de> wrote:
> > > > > On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > > > > > > I still don't think this makes sense, as the dma_mask should always
> > > > > > > be non-NULL here.
> > > > > >
> > > > > > If that is the case, I wonder how the driver could even have worked without DMA.
> > > > > >
> > > > > > Because in the existing code, host->dma_dev gets assigned to
> > > > > > spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> > > > > > usage in the driver.
> > > > > >
> > > > > > What am I missing?
> > > > >
> > > > > Do you know of other non-DMA users?  For SH nommu it probably worked
> > > >
> > > > I don't know of other non-DMA users. As I said, I wish someone could
> > > > step in and take better care of mmc_spi - as I know it's being used a
> > > > lot.
> > > >
> > > > > because SH nommu used to provide a DMA implementation that worked
> > > > > fine for streaming maps, but was completely broken for coherent
> > > > > allocation.  And this driver appears to only use the former.
> > > >
> > > > Alright, so you are saying the DMA support may potentially never have
> > > > been optional to this driver. In any case, I can remove the check in
> > > > $subject patch, as it shouldn't matter.
> > >
> > > DMA support was always optional, because even on systems where DMA is
> > > present, it doesn't necessarily mean the SPI controller uses DMA. In
> > > particular, pure bit-banged SPI via GPIOs doesn't have DMA, but has
> > > always worked. See my previous reply to Christoph about host->dma_dev
> > > for my current-best understanding of what's going on here.
> > >
> > > > Anyway, let's see what Rich thinks of this. I am curious to see if the
> > > > patch works on his SH boards - as I haven't been able to test it.
> > >
> > > I'll rebuild and retest just to confirm, but I already tested a
> > > functionally equivalent patch that just did the #ifdef inline (rather
> > > than moving the logic out to separate functions) and it worked fine.
> >
> > Hence, Tested-by? ;-)
>
> Confirmed that this version of the patch works too. Thus,
>
> Tested-by: Rich Felker <dalias@libc.org>

I have applied the patch for fixes, thanks for testing!

Christoph, when it comes to the check of
"spi->master->dev.parent->dma_mask", I am keeping it for now. I am
simply not sure that all spi masters assign the pointer (even if most
are platform drivers). I think it's better that we remove that check
in a separate patch - to get it tested.

Kind regards
Uffe
