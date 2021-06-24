Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE85C49EA6
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 13:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E45613DC
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 13:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFXNtZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFXNtY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 09:49:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A6DC061574
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 06:47:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id j184so14598226qkd.6
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHDdRelRavgSMuX+Enz3gXsuxhtxhRdSm3eh5ONAu3A=;
        b=k9V9jxYg0dvoRJOriAawKtVtjOqMWqF4nEv7gjAXDwn+RKtFtuzJXvjhWPai9PDksO
         opachs3IPXV3BAnrUPIUooraB3dCYpwC1YtLm2hmz28/g9cYtgytDjOHJjvkT3U+UUsF
         wDEqBrHAus7CYgNQ+GjzRjfRnJPU31pAG3A5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHDdRelRavgSMuX+Enz3gXsuxhtxhRdSm3eh5ONAu3A=;
        b=teqVb9xvZzn6w6aJd9QXC6iH4uMhIddfD0iOC3z7xesAx+SxvYsdDn5LoV3qowAe0W
         eHzFTsZl3/ZK8QNNVSPYMWHnRnEUu0IWtjvNu4YFVvdB9C/ot1NF+EO3em2fLNkLobNo
         ozqZ9OgBfkn3ILdjGvmz4aq+thc1Qzw1Nf6DVQi4WlThqssFefa6ZZASbgKQTyaB2jsj
         lAxdVhyR5M2g1SRdOERL8HhzmOs84QGGXCjTWFknoPrkaqH8t6ZWr6wfwA8uSu7w8aeA
         4Py0YgDQWZGIuQbGBNc8UcKP6EPeEKyJt30Rn+EgP4lzz0SCglxuWL/gghE/OPTAHoIw
         j0hQ==
X-Gm-Message-State: AOAM533pBHR8eezQatrejisV09pOgRFxgdkI8Iigt0KAZmX3yfRvZN1s
        iI/Npieb0kYbidepyMCrxNkPs4wzEgyRTg==
X-Google-Smtp-Source: ABdhPJwIqu70P9Flh/0+tDmQNUr5vxRxTAlHTGwNgQgSHjA5TFferky0g6YpWhG2k9kR90UbPbH/1w==
X-Received: by 2002:a37:7101:: with SMTP id m1mr5667508qkc.183.1624542423608;
        Thu, 24 Jun 2021 06:47:03 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id j13sm2680087qko.9.2021.06.24.06.47.02
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 06:47:02 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id 19so4255705qky.13
        for <linux-mmc@vger.kernel.org>; Thu, 24 Jun 2021 06:47:02 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr5091144ybk.79.1624542421816;
 Thu, 24 Jun 2021 06:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid> <YNSKyu/a8S3Qywbc@kroah.com>
In-Reply-To: <YNSKyu/a8S3Qywbc@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Jun 2021 06:46:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VQEM=Gtzrkd-s_ufzi_Y7b1GPCOVROftmjLDWiMEd0qA@mail.gmail.com>
Message-ID: <CAD=FV=VQEM=Gtzrkd-s_ufzi_Y7b1GPCOVROftmjLDWiMEd0qA@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI: Indicate that we want to force strict DMA for
 untrusted devices
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
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 6:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:52:45PM -0700, Douglas Anderson wrote:
> > At the moment the generic IOMMU framework reaches into the PCIe device
> > to check the "untrusted" state and uses this information to figure out
> > if it should be running the IOMMU in strict or non-strict mode. Let's
> > instead set the new boolean in "struct device" to indicate when we
> > want forced strictness.
> >
> > NOTE: we still continue to set the "untrusted" bit in PCIe since that
> > apparently is used for more than just IOMMU strictness. It probably
> > makes sense for a later patchset to clarify all of the other needs we
> > have for "untrusted" PCIe devices (perhaps add more booleans into the
> > "struct device") so we can fully eliminate the need for the IOMMU
> > framework to reach into a PCIe device.
>
> It feels like the iommu code should not be messing with pci devices at
> all, please don't do this.

I think it's generally agreed that having the IOMMU code reach into
the PCIe code is pretty non-ideal, but that's not something that my
patch series added. The IOMMU code already has special cases to reach
into PCIe devices to decide strictness. I was actually trying to
reduce the amount of it.

> Why does this matter?  Why wouldn't a pci device use "strict" iommu at
> all times?  What happens if it does not?  Why are PCI devices special?

This is something pre-existing in Linux. In my patch series I was
trying to make PCI devices less special and take some of the concepts
from there and expand them, but in a cleaner way. It sounds like in my
v2 I should steer away from this and leave the existing PCI hacks
alone.

-Doug
