Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A6C3F2D7
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 14:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC16220732
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 14:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HTPUACfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgCEOaJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:30:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37188 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCEOaJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 09:30:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id q23so6306347ljm.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020 06:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxUBayx3miFQBUYSiXLDadUCUGMzP0FF1VEQIy6N2lw=;
        b=HTPUACfnW2AkKS6owAIK4ej9CZriQDbH2e6qbsRRcZD7WstthtSvrIllSRCwNF1LHY
         UXx2EJDUABN8TufnjXrPadXZOoTD/GEe5y/NglhU159p72dTstnHnQo4VkxToB8RmrtD
         RBJSvfZkiqEWfHegMjL3jf0LCTatQoJNXmTUhJnY5mndQD12aw1dWEBULRIiCeVVugDs
         wuBS6mSskcHluevrWipymJi5534kUVQarlBbnoovO0bKackq1e/GYUoIxqpBz5OUKQ6x
         LYfM0oLuDqNiPCQKmIB/yU0gCQ7aGrOTRh4I0JisqFhUhEsqe0EKm+y+m5spnAv4+Bjv
         OqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxUBayx3miFQBUYSiXLDadUCUGMzP0FF1VEQIy6N2lw=;
        b=KsMXM27y/bE/hg4vvnpOfGl+donVSgsX/gDc/uV70MkPQMOexcrK5099eVfrr8qA2t
         sOmytZKbGsm9GngcjxouQBhr5dys87o3gGDj3o09lupVuWnJOWkL9BrG8oHxyW64/gdt
         5ZsS87pmvPxd25gAcIiK3PzEWpleqnoPQh2FG3miIhyusTKf/DwSf22Pxv/ZljL/Q7vU
         qzO9+f6rkpeJXrB2bXiphXL90efCWPQW0dnZ3eKQgNBOBpmQcaf6mRSSATyOsaTdSNpE
         r/6Sopjx+dVRgcLZpv2PkfuFsvtKrcLFndS62JPRXkKHUPNA14VQBorVzM1aSXo2Yb1g
         pPbQ==
X-Gm-Message-State: ANhLgQ0CtjzZzJ8e5xUzTGi37++kbWFCJ9yNaLibl2HK3Pz+ZUNjBnm1
        mJJeCxUltAXfgXamyNxvYTkS9plKLkRNBRkNRZQAsA==
X-Google-Smtp-Source: ADFU+vvZWeUGDzUgG0VBJVg9MsfTilSSnj20aq4gDODOEP4a8APKzCkRINB95es+6PvdmtqMglrUJyNXy5nleXH3FcQ=
X-Received: by 2002:a2e:9c8a:: with SMTP id x10mr5632884lji.277.1583418606485;
 Thu, 05 Mar 2020 06:30:06 -0800 (PST)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
 <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
 <20200304162844.GA11727@lst.de>
In-Reply-To: <20200304162844.GA11727@lst.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Mar 2020 15:29:55 +0100
Message-ID: <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
To:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 4, 2020 at 5:28 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Mar 04, 2020 at 02:32:42PM +0100, Ulf Hansson wrote:
> > + Christoph, Arnd
> >
> > On Wed, 19 Feb 2020 at 09:31, <haibo.chen@nxp.com> wrote:
> > >
> > > From: Haibo Chen <haibo.chen@nxp.com>
> > >
> > > To make dma_set_max_seg_size() work, need to create dev->dma_parms.
> > >
> > > Find this issue on i.MX8QM mek board, this platform config the
> > > max_segment_size to 65535, but this dma_set_max_seg_size do not
> > > actuall work, find sometimes the segment size is 65536, exceed
> > > the hardware max segment limitation, trigger ADMA error.
> >
> > Sounds like we want something along the lines of this to be tagged for
> > stable as well.
>
> It really is not the job of the upper level driver to allocate the
> dma params.  This should be done by the bus driver.

I agree. This relates to my reply to Greg K-H recently:
https://lore.kernel.org/lkml/CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com/

The core of the problem is that drivers/of/platform.c is
very simple and has no idea what kind of bus it is populating
with devices from Device Tree. It is just guessing.

For example platform.c contains this:

        dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
        if (!dev->dev.dma_mask)
                dev->dev.dma_mask = &dev->dev.coherent_dma_mask;

And again part of the problem is that the device tree parser
mostly just create struct platform_device's on the platform bus
and has no real idea about any constraints on the bus where
it will eventually end up after the platform device is probed and
a new device on some other bus has been created.

Assuming that most problematic MMC controllers (in this
case) are probed from device tree (which I suspect,
but IIUC ACPI devices have the same problem),
my idea for a solution is to start to modify the platform.c
parser to be able to populate devices on some buses
directly, without using an intermediate platform device.

Today MMC isn't using a bus for the host controllers,
it is a class device, so I suppose the "real" solution would
be:

1. Move MMC hosts to a bus instead of a class named
   say mmc_bus. If this is OK with the userspace ABI.

2. Make everything necessary from the struct device
    inside struct mmc_host (today called "class_device")
    copied over from the parent and stop referencing
    the struct device *parent field in struct mmc_host
    directly for everything and its dog.

3. Make struct mmc_host and mmc_alloc_host() and
    mmc_add_host()
    be created and called directly from the device tree in some
    way (like a plug-in mechanism to of/platform.c)
    without creating a platform_device that just end
    up as the intermediary parent of the actual device
    in mmc_host.

4. Now we are creating the device directly on the right
   bus and so we can start thinking about filling in the
   right dma_params and dma_mask and dma_coherent_mask
   when instantiating the device on the mmc_bus
   rather than in every (platform_device) driver.

This is no trivial task because the kernel has gone down
the platform device for all stuff in the device tree for
a while. (Copy/paste same resoning for ACPI I'm afraid.)

I suppose people were looking for a simple solution to
this problem but I can only see a really complicated
solution.

Yours,
Linus Walleij
