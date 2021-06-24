Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804BBC49EA6
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 14:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6521C6140B
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 14:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFXOKw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFXOKv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 10:10:51 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA24C061574
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 07:08:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso5660489otu.10
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qA/15TvxyljLeiT6v+8qmN6kWt8A8lTygEXqoXNw+04=;
        b=Rw6WpSNMHTbg23NxwJvuOjaHdtgv0Fj8nxCsBmOYLlr9CLdBH8VOno97w1rjhpK7QS
         fwqIqx9HX6X8tYR/DUbVTec6h1/VI2RngzjSavToO71KaG1mXaNuJKT6sdAS0G2d8VEg
         i8Ybg3BEoJp0gfRJeGyl62WDRO2HONssyTuck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qA/15TvxyljLeiT6v+8qmN6kWt8A8lTygEXqoXNw+04=;
        b=CyXelyrWiM71sZqta6JQWBmgQYPi3InJvXBU4vk2Vj7bGEZbQ7RXRYdnYFhUKRglAB
         TG4M2cEO95XzPZi2jnL0qwgIiLkGB2BDVt+QOOWKsSF+m1dbNie0UDEfKnSc4biWZTSC
         5gYQlbKf07aM9hrHZ/RB4YtOCn7fu/TyklTzWuWArF44KMA4bCkuj4snnIBdqJbjLdTF
         PsjdmhxTFVwVleqb8pwuqPu86F9prvohg6A/pThVRc17iQG1qTK/hUm0OKvbkCbsVZBH
         3cJstDP3gajRS4BB5izYcmSimf6uogEaPvP+mIPCBsbK31rPlUn8rTlcINFv0TtagWAK
         7aQw==
X-Gm-Message-State: AOAM530aJdHrTq1D9ve021rCapWxBQulEKCqGHh6hi/dtqQvLXiTThrl
        7fihCYe2ke8E+I/p+SAKi2kKbIbwMCbSzQ==
X-Google-Smtp-Source: ABdhPJz++Yp+oxl7wgXWrCh37AyCu7lOhbtRCSsm3fZ2y1B78unrcZAh90C91VSernksrQRL9wI/kA==
X-Received: by 2002:a9d:1e4:: with SMTP id e91mr4825753ote.211.1624543711182;
        Thu, 24 Jun 2021 07:08:31 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id k26sm132540ook.0.2021.06.24.07.08.31
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 07:08:31 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so5688410otg.1
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 07:08:31 -0700 (PDT)
X-Received: by 2002:a25:bcb:: with SMTP id 194mr5441792ybl.32.1624543265649;
 Thu, 24 Jun 2021 07:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.6.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid> <YNSL/r+fOz6KMuwI@kroah.com>
In-Reply-To: <YNSL/r+fOz6KMuwI@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Jun 2021 07:00:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VsdYpgzoC9JvDEjBDqVNKmuz-gOs8oceiuYXs8E680XA@mail.gmail.com>
Message-ID: <CAD=FV=VsdYpgzoC9JvDEjBDqVNKmuz-gOs8oceiuYXs8E680XA@mail.gmail.com>
Subject: Re: [PATCH 6/6] mmc: sdhci-msm: Request non-strict IOMMU mode
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Rajat Jain <rajatja@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 6:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:48PM -0700, Douglas Anderson wrote:
> > IOMMUs can be run in "strict" mode or in "non-strict" mode. The
> > quick-summary difference between the two is that in "strict" mode we
> > wait until everything is flushed out when we unmap DMA memory. In
> > "non-strict" we don't.
> >
> > Using the IOMMU in "strict" mode is more secure/safer but slower
> > because we have to sit and wait for flushes while we're unmapping. To
> > explain a bit why "non-strict" mode is unsafe, let's imagine two
> > examples.
> >
> > An example of "non-strict" being insecure when reading from a device:
> > a) Linux driver maps memory for DMA.
> > b) Linux driver starts DMA on the device.
> > c) Device write to RAM subject to bounds checking done by IOMMU.
> > d) Device finishes writing to RAM and signals transfer is finished.
> > e) Linux driver starts unmapping DMA memory but doesn't flush.
>
> Why doesn't it "flush"?

This is just how the pre-existing "iommu.strict=0" command line parameter works.


> > f) Linux driver validates that the data in memory looks sane and that
> >    accessing it won't cause the driver to, for instance, overflow a
> >    buffer.
> > g) Device takes advantage of knowledge of how the Linux driver works
> >    and sneaks in a modification to the data after the validation but
> >    before the IOMMU unmap flush finishes.
> > h) Device has now caused the Linux driver to access memory it
> >    shouldn't.
>
> So you are now saying we need to not trust hardware?  If so, that's a
> massive switch for how the kernel needs to work right?

This is a pre-existing concept in the kernel and is in fact so
prevalent that there are a bunch of inconsistent ways to configure it
(though it's being made better [1])

* On ARM64, default is strict and you can configure it with iommu.strict

* On AMD, default is non-strict and you can configure it with
amd_iommu=fullflush

* On Intel, default is non-strict and you can configure it with
intel_iommu=strict

...also pre-existing is that the kernel has special cases for
"external" PCI devices where it forces them to strict mode even if the
default is non-strict (like on Intel and AMD). I was pointed
specifically at <http://thunderclap.io/> for an example of why this
was important.


> And what driver does f) and allows g) to happen?  That would be a normal
> bug anyway, why not just fix the driver?

This one would be possible to workaround in the driver by copying the
memory somewhere else, but it violates the DMA model. Specifically
step "e)" above is supposed to mean that the driver is now in full
control of the memory, so it should be perfectly justified in assuming
that nobody else is scribbling on it.


> > An example of "non-strict" being insecure when writing to a device:
> > a) Linux driver writes data intended for the device to RAM.
> > b) Linux driver maps memory for DMA.
> > c) Linux driver starts DMA on the device.
> > d) Device reads from RAM subject to bounds checking done by IOMMU.
> > e) Device finishes reading from RAM and signals transfer is finished.
> > f) Linux driver starts unmapping DMA memory but doesn't flush.
>
> Why does it not flush?
>
> What do you mean by "flush"

"flush" means force / wait for the IOMMU unmap to fully take effect.


> > g) Linux driver frees memory and returns it to the pool.
>
> What pool?

The normal Linux memory pool.


> > h) Memory is allocated for another purpose.
>
> Allocated by what?

Someone else that wanted memory.


> We have memory allocators that write over the data when freed, why not
> just use this if you are concerned about this type of issue?
>
> > i) Device takes advantage of the period of time before IOMMU flush to
> >    read memory that it shouldn't have had access to.
>
> What memory would that be?

Depends on who got it. This could be hard to predict unless a
peripheral was trying to exploit a very specific version of Linux
where maybe it was predictable who got the memory next.


> And if you really care about these issues, are you not able to take the
> "hit" for the flush all the time as that is a hardware thing, not a
> software thing.  Why not just always take advantage of that, no driver
> changes needed?

The whole concept of strict vs. non-strict is definitely not new to my
series and I'm mostly just trying to configure it properly.


> And this isn't going to work, again, because the "pre_probe" isn't going
> to be acceptable, sorry.

Right. As discussed in the cover letter, I'm going to try to solve
this in other ways that doesn't involve pre_probe.

[1] https://lore.kernel.org/linux-iommu/1624016058-189713-1-git-send-email-john.garry@huawei.com/T/#m21bc07b9353b3ba85f2a40557645c2bcc13cbb3e

-Doug
