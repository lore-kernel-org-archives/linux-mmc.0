Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AE3C49EA7
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 13:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77728613EA
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 13:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFXNoh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXNog (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 09:44:36 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016FFC061756
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 06:42:17 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id x21so4787168qtq.9
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
        b=UtHXwFYLTrHgPc145mL3C9UB4ey+/nLdjIs7pvzujRNmQ5EAW+afyVO5yMkpxhaiYq
         EaZ0co1eAfBn5+AQMs9Q4Do4a1gFTjywNfS2sa9OFA0yAfKs040r9gAZmmies4dijQrQ
         9P1VJDPAdAgvB5owtJUn6dZ/rn754Mfv82gBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRRpyknNOYu61oOPsy3QfFe0DlnKqFXOFR/ODDvOpRA=;
        b=MxoAMk4i6bAEbmOwOpgM8dyv6lS3/2OOavIbwjZaS+Cr5JNKxKk+EePTgOEazE2WYq
         TDa9MHvRcRq4+EM5cDhSxATqfl1RmvvnEIsiODsvz7TBZ85aqcyHsAZE+vKbdgEpmtez
         8ja/sROaCtFTxL02tLg9Uds80YjSWb5IS71RD4Jnt8PL9FvaqiY9JYxJ7vt9gnjLs8Av
         Gu6sfuusD74T4kvz4owayeZC033rz1iUc9jO2LjUKQ/peHW9shO1zQ8Zd9rBlvdGw60t
         88rOp9SBWYyzrylqS2EM9NpQ90kjXLNKxDkpdngHTOK1m6X3WjNO2/7BcxgBK/7PWJIe
         fD5Q==
X-Gm-Message-State: AOAM530ZPjxErOhv6PXAfW0jxKdKMNLTotVt+JeJpSMXngq2cnwoPJMB
        0meBluYftFO7XKBAzr7sie2FbGiBo9MKyw==
X-Google-Smtp-Source: ABdhPJyQ4ZDGpF2qppnuxUNv2JDRCOpa7cdWi5NJenKZgeWOBeukgLpbPFSFTQQV3e/QLVuuIcEh7A==
X-Received: by 2002:ac8:7609:: with SMTP id t9mr4759185qtq.381.1624542135908;
        Thu, 24 Jun 2021 06:42:15 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id v15sm646062qkp.96.2021.06.24.06.42.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:42:15 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id w21so14442179qkb.9
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 06:42:14 -0700 (PDT)
X-Received: by 2002:a25:6088:: with SMTP id u130mr5223275ybb.257.1624542133615;
 Thu, 24 Jun 2021 06:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.2.Icfe7cbb2cc86a38dde0ee5ba240e0580a0ec9596@changeid> <YNSKdhMACa9LFuVN@kroah.com>
In-Reply-To: <YNSKdhMACa9LFuVN@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Jun 2021 06:42:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Message-ID: <CAD=FV=X1XSFRLfHOtA7Nk1NDqdBWHTOtPhdXVXk-+e_y9a=Rkg@mail.gmail.com>
Subject: Re: [PATCH 2/6] drivers: base: Add bits to struct device to control
 iommu strictness
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
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 6:37 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:44PM -0700, Douglas Anderson wrote:
> > How to control the "strictness" of an IOMMU is a bit of a mess right
> > now. As far as I can tell, right now:
> > * You can set the default to "non-strict" and some devices (right now,
> >   only PCI devices) can request to run in "strict" mode.
> > * You can set the default to "strict" and no devices in the system are
> >   allowed to run as "non-strict".
> >
> > I believe this needs to be improved a bit. Specifically:
> > * We should be able to default to "strict" mode but let devices that
> >   claim to be fairly low risk request that they be run in "non-strict"
> >   mode.
> > * We should allow devices outside of PCIe to request "strict" mode if
> >   the system default is "non-strict".
> >
> > I believe the correct way to do this is two bits in "struct
> > device". One allows a device to force things to "strict" mode and the
> > other allows a device to _request_ "non-strict" mode. The asymmetry
> > here is on purpose. Generally if anything in the system makes a
> > request for strictness of something then we want it strict. Thus
> > drivers can only request (but not force) non-strictness.
> >
> > It's expected that the strictness fields can be filled in by the bus
> > code like in the patch ("PCI: Indicate that we want to force strict
> > DMA for untrusted devices") or by using the new pre_probe concept
> > introduced in the patch ("drivers: base: Add the concept of
> > "pre_probe" to drivers").
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  include/linux/device.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index f1a00040fa53..c1b985e10c47 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -449,6 +449,15 @@ struct dev_links_info {
> >   *           and optionall (if the coherent mask is large enough) also
> >   *           for dma allocations.  This flag is managed by the dma ops
> >   *           instance from ->dma_supported.
> > + * @force_strict_iommu: If set to %true then we should force this device to
> > + *                   iommu.strict regardless of the other defaults in the
> > + *                   system. Only has an effect if an IOMMU is in place.
>
> Why would you ever NOT want to do this?
>
> > + * @request_non_strict_iommu: If set to %true and there are no other known
> > + *                         reasons to make the iommu.strict for this device,
> > + *                         then default to non-strict mode. This implies
> > + *                         some belief that the DMA master for this device
> > + *                         won't abuse the DMA path to compromise the kernel.
> > + *                         Only has an effect if an IOMMU is in place.
>
> This feels in contrast to the previous field you just added, how do they
> both interact?  Would an enum work better?

Right that it never makes sense to set both bits so an enum could work
better, essentially it would be { dont_care, request_non_strict,
force_strict }.

In any case the whole idea of doing this at the device level looks
like it's not the right way to go anyway, so this patch and the
previous pre_probe one are essentially abandoned and I need to send
out a v2 with some different approaches.

-Doug
