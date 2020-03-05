Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B181C3F2D7
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4CE208C3
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWJ4vrjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCEPEL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:04:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34817 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgCEPEL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 10:04:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id z9so4921990lfa.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020 07:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dKRJ4BlNNNuyV5/0qIVtKMq/57qf8d7BGTQkXSA+cxI=;
        b=pWJ4vrjsKQc8DyIXAgP2DMZI+Cme2OR/e5sHdbN4rNTGhGhH4h4J0uZCsm9dFdFMKV
         b36IMRECLYVCUTCG8kpaNFc+NwrK2SJ0fPqiRLai/i0/5eRvVED4Ht6HQHFJpODj/iwz
         9Lka0TWcMrHZ/6tOdt1AGzDHkGSo1Z6yowd+OmkVDAhR21N7+7ylw1rPI2NKqBMvJvpx
         tK8cZGU8TUnQN7NTtyr55ZYDZRJvVbQNLkYjQ00nA3vG9f0pZWCZazVO0cJtcdoqt43c
         PJKlVZJQhsxsj3sFa0jUALcl88xAgpjXOQfXjWa8FtcI4y0mNAc30A2ll56NbHIwCy+t
         XJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dKRJ4BlNNNuyV5/0qIVtKMq/57qf8d7BGTQkXSA+cxI=;
        b=is+5m28HDeRaaKm+VtEKMd5FzPBOB44wQ6s/RbTyOw5GdHZaqactAoQ9vf8G7ayw0e
         BPygfcTPVU+8X1clxGSnroB1k1/7xNeVSaeBx2PgyryAclCzb/CvRT25/WB6iHeEIdKT
         sqHxKOY3k7PYgQtKS5qZ0mZEoK7ZU6Om6grAUnXkpSDnI+AML73/LbD24yQAd1daRp8p
         btNA4tYY4J9BxIp0zPVTF7UoOiQvL6NrWvh2Nk9NA6DRUj4VY04M920FpFTzalwfqogV
         2l/srvoTLVWSiosGEpUN9yC/1i9pVkdWesXDKLKRbQBDGh/ncX4P780+ZZHxp9OFSP7U
         knGA==
X-Gm-Message-State: ANhLgQ0zrKCVJJm6FwhbQZHXsBAnum+0mPxGCjC+wlufZsPhx50A/AQw
        2nbKvfPWLCTrli2nqUJ+yyZ79LBevyF0tNAiWmteWw==
X-Google-Smtp-Source: ADFU+vsy4FqaAXbAtOw2y9vgi5vyFlIsFEtQvbnfGfA8fRtQaxuiz0bmrVTXsZv3/ADwK33wj6BENOVEclzN4UA7fQg=
X-Received: by 2002:ac2:5f50:: with SMTP id 16mr5720820lfz.194.1583420648934;
 Thu, 05 Mar 2020 07:04:08 -0800 (PST)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
 <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
 <20200304162844.GA11727@lst.de> <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
 <CAK8P3a1m2oRhSRosJXbuswhY2ePa56o5e1rTd=qZDpj=ZEH6Dg@mail.gmail.com>
In-Reply-To: <CAK8P3a1m2oRhSRosJXbuswhY2ePa56o5e1rTd=qZDpj=ZEH6Dg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Mar 2020 16:03:57 +0100
Message-ID: <CACRpkdbTVOGTS=Vb-nhPZ-s8uC3m6Ly87-MRuydNJSNY3+gzcw@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 5, 2020 at 3:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 5, 2020 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Mar 4, 2020 at 5:28 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Wed, Mar 04, 2020 at 02:32:42PM +0100, Ulf Hansson wrote:
> > > > + Christoph, Arnd
>
> > Today MMC isn't using a bus for the host controllers,
> > it is a class device, so I suppose the "real" solution would
> > be:
> >
> > 1. Move MMC hosts to a bus instead of a class named
> >    say mmc_bus. If this is OK with the userspace ABI.
> >
> > 2. Make everything necessary from the struct device
> >     inside struct mmc_host (today called "class_device")
> >     copied over from the parent and stop referencing
> >     the struct device *parent field in struct mmc_host
> >     directly for everything and its dog.
>
> I don't think that copying the dma settings is a good solution
> here. The software model that we have is that a bus can be a
> dma master on its parent, which in turn is a master on
> a parent bus, all the way up to the root of the tree. This is
> not always the reality, but having an intermediate device
> on a fake bus won't make it better.

Alas, that is what we have today, because the platform_bus
is pretty much fake.

My initial reasoning was because Greg has expressed that
he thinks the platform_bus is overused and more specific
buses should be used, so I outlined a plan to make
OF not use the platform bus.

(Which is maybe too hard.)

> The natural model is that an mmc host is a device on an
> arbitrary dma capable bus (platform, pci, ...), and its
> children are mmc devices with bus=&mmc_bus_type.
>
> If that is not already the case, that is where I'd start
> changing it to simplify the model.

The current way that the device tree parser uses the
platform bus is that it has no idea about what it is doing
when it comes to DMA, most of the time.

But maybe if we take a step back: can we make the
platform bus aware of what it is doing?

For example we have dma-ranges and similar properties
in the device tree, but subsystems call directly into
drivers/of/address.c to parse these out.

Would it be possible to tag nodes on the device tree
with the appropriate segment size and boundary
somehow also define the mask in the device tree in
a proper way, and have the platform.c parser actually
set this up correctly?

I am not aware that we have anything like this
currently, apart from the dma-ranges all DMA DT
bindings we have seems to pertain to DMA engines.

(I suppose the same apply for ACPI.)

Yours,
Linus Walleij
