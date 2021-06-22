Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E9C48BE5
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Jun 2021 19:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91A9561369
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Jun 2021 19:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhFVToe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhFVTod (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2021 15:44:33 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073FC0617A8
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 12:42:14 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id w21so28774347qkb.9
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KbphWW+YCq0HiY8JKMK80s61y/VI/u5uRCvjvuYgRvo=;
        b=B0KKMBDv6mmc1lnaI4uPkAm6cPTmdb7TIXjhicSbGznIFUVv9JjjbjCqNCaOd7EpYM
         pnnEU8sbe0AVpMJXATFzGWXRlVkOSlojtJ9YUkl0HamHxDkd3CMgYIcUaibp/wBrGa39
         arNtBQL0FAKJSiCk0bIOZEIS47O+vz6l2FCAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KbphWW+YCq0HiY8JKMK80s61y/VI/u5uRCvjvuYgRvo=;
        b=XywEf4BNDR0mB4LbfU4LFXhJW/0Eu6tpyukONykXbusvyUQNUJEZs8abC8MR+yRQTA
         aOUXRv6ud3ATRmdiFU5C1/3uN+Ld+aRaLcBj0SpmNWmTMt5JfwxyM3W4KC2AXUwioif1
         MHz4x0oaZkDoUf2GS0crgd1SmZTACkcaSWzewFunncCi9z/qKdboSO3HEDkWH0UNxxPP
         mIQokc4sRWFkLkGbVSBclmnmVOjvdX9lv9snup21bwiOmXkptCNptRQrbQywA0Hj2sBI
         h/SylTne4mGC7P0rgbPMbERZYhhQSIJAXqfEWgaAN/WXCtTMlse4J1EJawn/HcE/h+1t
         ye7g==
X-Gm-Message-State: AOAM530qUpx8W0jhlb2GRW+gJU2O1pb8Yo0vtoiYwMS/64UEw4FYowF6
        V6vReF9KU6ShW5LtxcQeAcm3ioO0ToEsKA==
X-Google-Smtp-Source: ABdhPJx4nFcLw05smYanHzadTq1eFdHvZzXDTZWUDZNLVhg8igKrK3eSaZSZlbWfdV6ILvTwYEeDAA==
X-Received: by 2002:a37:63d5:: with SMTP id x204mr6117590qkb.101.1624390934030;
        Tue, 22 Jun 2021 12:42:14 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id q3sm2165999qkn.15.2021.06.22.12.42.13
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 12:42:13 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id d196so42552565qkg.12
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jun 2021 12:42:13 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr6758869ybk.405.1624390512166;
 Tue, 22 Jun 2021 12:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid> <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
In-Reply-To: <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jun 2021 12:35:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U9WqEKVgX6p1Eaf5hvpXet0e_rqKKS4YRNsDrLW5R5zg@mail.gmail.com>
Message-ID: <CAD=FV=U9WqEKVgX6p1Eaf5hvpXet0e_rqKKS4YRNsDrLW5R5zg@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To:     Rajat Jain <rajatja@google.com>
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
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 22, 2021 at 11:45 AM Rajat Jain <rajatja@google.com> wrote:
>
> On Mon, Jun 21, 2021 at 4:53 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In the patch ("drivers: base: Add bits to struct device to control
> > iommu strictness") we add the ability for devices to tell us about
> > their IOMMU strictness requirements. Let's now take that into account
> > in the IOMMU layer.
> >
> > A few notes here:
> > * Presumably this is always how iommu_get_dma_strict() was intended to
> >   behave. Had this not been the intention then it never would have
> >   taken a domain as a parameter.
> > * The iommu_set_dma_strict() feels awfully non-symmetric now. That
> >   function sets the _default_ strictness globally in the system
> >   whereas iommu_get_dma_strict() returns the value for a given domain
> >   (falling back to the default). Presumably, at least, the fact that
> >   iommu_set_dma_strict() doesn't take a domain makes this obvious.
> >
> > The function iommu_get_dma_strict() should now make it super obvious
> > where strictness comes from and who overides who. Though the function
> > changed a bunch to make the logic clearer, the only two new rules
> > should be:
> > * Devices can force strictness for themselves, overriding the cmdline
> >   "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
> > * Devices can request non-strictness for themselves, assuming there
> >   was no cmdline "iommu.strict=1" or a call to
> >   iommu_set_dma_strict(true).
>
> Along the same lines, I believe a platform (device tree / ACPI) should
> also be able to have a say in this. I assume in your proposal, a
> platform would expose a property in device tree which the device
> driver would need to parse and then use it to set these bits in the
> "struct device"?

Nothing would prevent creating a device tree or ACPI property that
caused either "force-strict" or "request-non-strict" from being set if
everyone agrees that it's a good idea. I wouldn't reject the idea
myself, but I do worry that we'd devolve into the usual bikeshed for
exactly how this should look. I talked about this a bit in my response
to Saravana, but basically:

* If there was some generic property, would we call it "untrusted",
"external", or something else?

* How do you describe "trust" in a generic "objective" way? It's not
really boolean and trying to describe exactly how trustworthy
something should be considered is hard.

* At least for the device tree there's a general requirement that it
describes the hardware and not so much how the software should
configure the hardware. As I understand it there is _some_ leeway here
where it's OK to describe how the hardware was designed for the OS to
configure it, but it's a pretty high bar and a hard sell. In general
the device tree isn't supposed to be used to describe "policy". In
other words: if one OS might decide on one setting and another OS on
another then it doesn't really belong in the device tree.

* In general the kernel is also not really supposed to have policy
hardcoded in either, though it feels like we can get away with having
a good default/sane policy and allowing overriding the policy with
command line parameters (like iommu.strict). In the case where
something has to be configured at bootup there's not many ways to do
better.


tl;dr: I have no plans to try to make an overarching property, but my
patch series does allow subsystems to come up with and easily
implement their own rules as it makes sense. While this might seem
hodgepodge I prefer to see it as "flexible" since I'm not convinced
that we're going to be able to come up with an overarching trust
framework.

-Doug
