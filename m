Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE48C2B9F4
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Jun 2021 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1BC6128C
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Jun 2021 17:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhFVREZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Jun 2021 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFVREY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2021 13:04:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22AFC061756
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 10:02:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q64so34958837qke.7
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZLfOF3k/f6yL2AQLJ+h2J00Oz5HjAD+vwU2S+DCH90=;
        b=gd1QJ+p0JA8dyVAsY4WKjdqQGTpnW4p+P5TOHPu1jd4FeLJ/H6Qvzbn6gyTv7wJVI6
         36wOQR0QS6Ab0J7LxCWnPEzDaKyFhbkR0dyQHikgrWT9HmTn5M8DAb0Bs2e0HWcalTrm
         dzu+DKJGfjkl52u/OhJeVIwWeXfqiKtJLOnOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZLfOF3k/f6yL2AQLJ+h2J00Oz5HjAD+vwU2S+DCH90=;
        b=AgbQsPTYihnEM8SnKkhRCjpXufXeq9XN2gkj0Nx8XnkSlc61gQV+qPJlysChNeaZCd
         apyrhl8nyMIvXahyWqHuNDEkzZJ67MdJLQ6a83xh9EKOEaCfMMU54v/0A6ZWP04dBMYv
         e+tQMPi6hQoSXjeWNuIGou3KF0PlMIFIdWLsJm7JOrgR3jJIYqPDeXRB1x/JM4vK1K4y
         lZMsnm/MxYOdYMeMjv6hfNH0cuMVwzvO+6fnIatv0nF+umCtBU2bSHEd7LXoGwT4veu8
         W7makiiqvJz2+D8UfLSNMvF0K1YC2/N1KwHdHUjHOS+snpEnzZdaO14ssy3T8aVhubzv
         EQ8A==
X-Gm-Message-State: AOAM532YmsOLU6qkVkgoYELqriVwHSR7+9QVdOFEC6JMzhPqoxrF++l0
        guysWI0nhi48/EJ1xtsuf7zrK0kb6GIDXA==
X-Google-Smtp-Source: ABdhPJz7awJZejiImBJ11EZXnglZjUUwXDSQ/MwY34jUyy3TgC8rLUy6IVemZG+x99ts8mTHuDxGqg==
X-Received: by 2002:a37:a3ce:: with SMTP id m197mr5359887qke.77.1624381325895;
        Tue, 22 Jun 2021 10:02:05 -0700 (PDT)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com. [209.85.222.182])
        by smtp.gmail.com with ESMTPSA id j65sm14041181qkd.17.2021.06.22.10.02.04
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 10:02:04 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id c138so41316099qkg.5
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 10:02:04 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr6308972ybb.257.1624381323248;
 Tue, 22 Jun 2021 10:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
 <a86c2f9c-f66a-3a12-cf80-6e3fc6dafda4@linux.intel.com> <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
In-Reply-To: <CAD=FV=XpYkUqGNcumJ0NvoXqbSkBaV5ZadUnpsKTMPx7tSjGig@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 10:01:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xi8Qai5sKwuT4-4B=K5i7f4BWQfp9+TxR1x3VSt7dkGA@mail.gmail.com>
Message-ID: <CAD=FV=Xi8Qai5sKwuT4-4B=K5i7f4BWQfp9+TxR1x3VSt7dkGA@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        linux-pci@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Rajat Jain <rajatja@google.com>,
        Sonny Rao <sonnyrao@chromium.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 9:53 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jun 21, 2021 at 7:05 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> >
> > On 6/22/21 7:52 AM, Douglas Anderson wrote:
> > > @@ -1519,7 +1542,8 @@ static int iommu_get_def_domain_type(struct device *dev)
> > >
> > >   static int iommu_group_alloc_default_domain(struct bus_type *bus,
> > >                                           struct iommu_group *group,
> > > -                                         unsigned int type)
> > > +                                         unsigned int type,
> > > +                                         struct device *dev)
> > >   {
> > >       struct iommu_domain *dom;
> > >
> > > @@ -1534,6 +1558,12 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
> > >       if (!dom)
> > >               return -ENOMEM;
> > >
> > > +     /* Save the strictness requests from the device */
> > > +     if (dev && type == IOMMU_DOMAIN_DMA) {
> > > +             dom->request_non_strict = dev->request_non_strict_iommu;
> > > +             dom->force_strict = dev->force_strict_iommu;
> > > +     }
> > > +
> >
> > An iommu default domain might be used by multiple devices which might
> > have different "strict" attributions. Then who could override who?
>
> My gut instinct would be that if multiple devices were part of a given
> domain that it would be combined like this:
>
> 1. Any device that requests strict makes the domain strict force strict.
>
> 2. To request non-strict all of the devices in the domain would have
> to request non-strict.
>
> To do that I'd have to change my patchset obviously, but I don't think
> it should be hard. We can just keep a count of devices and a count of
> the strict vs. non-strict requests? If there are no other blockers
> I'll try to do that in my v2.

One issue, I guess, is that we might need to transition a non-strict
domain to become strict. Is that possible? We'd end up with an extra
"flush queue" that we didn't need to allocate, but are there other
problems?

Actually, in general would it be possible to transition between strict
and non-strict at runtime as long as we called
init_iova_flush_queue()? Maybe that's a better solution than all
this--we just boot in strict mode and can just transition to
non-strict mode after-the-fact?


-Doug
