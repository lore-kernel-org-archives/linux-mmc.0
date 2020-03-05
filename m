Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D853BC3F2D1
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DD82146E
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEPbc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:31:32 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:55251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgCEPbc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 10:31:32 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mo7if-1jhIHh2rCF-00pexY for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020
 16:31:30 +0100
Received: by mail-qt1-f181.google.com with SMTP id x21so4357894qto.13
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020 07:31:30 -0800 (PST)
X-Gm-Message-State: ANhLgQ2UDogsF5tMGhvlGlVIfFUmrG42r4TyGP9U2o+ihlGF5WRZ8tt8
        FeiA0FFqcwVTiZ23vT5jg919Np6IbUvtcMEReEc=
X-Google-Smtp-Source: ADFU+vu8yh0iuyej0hWsS7IxuMqCOObNew/gnxRffa2pD8XAFlsOiVQ34VXi66oLyttvRmaTkAGepUvB/cpF8EwK/Eo=
X-Received: by 2002:ac8:3719:: with SMTP id o25mr7824458qtb.7.1583422289545;
 Thu, 05 Mar 2020 07:31:29 -0800 (PST)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
 <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
 <20200304162844.GA11727@lst.de> <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
 <CAK8P3a1m2oRhSRosJXbuswhY2ePa56o5e1rTd=qZDpj=ZEH6Dg@mail.gmail.com> <CACRpkdbTVOGTS=Vb-nhPZ-s8uC3m6Ly87-MRuydNJSNY3+gzcw@mail.gmail.com>
In-Reply-To: <CACRpkdbTVOGTS=Vb-nhPZ-s8uC3m6Ly87-MRuydNJSNY3+gzcw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Mar 2020 16:31:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2FRZw4SpJbGSJvBqijVSN0xENZw=+086U-eDkvG24TYA@mail.gmail.com>
Message-ID: <CAK8P3a2FRZw4SpJbGSJvBqijVSN0xENZw=+086U-eDkvG24TYA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vshMShe6IQcKUYiBD4fesYMGyDcCVF0dGim5T84JWf99oR7Afab
 vv+cliORDP+kY6ruyHGaVGphH17xu85zSN7m/127BCGth976y/tX88ekAZ7LVDax4iid2yU
 j/7qarOP0mAHN6s1wKkcJlOwKGKeJ2tvmPErxnY4FgJNkFvOuMcDixa0h2tGea39Ekn9XWp
 Cjh9gHQFPSt2LLz+x9Fjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fblR11r7KLw=:yevnHj2+HpqWeH69CRixg4
 cSRLQPRZki3vj+uU5fJL/4sKSgQ5kAVgxJ4Q1FzBwxzw0mYclakuTT6ce73BFGXdfP2qMcFtI
 Y2ZCG2llVS5DjrSY8dK3w+wP8TxpNKgcHjiLqqwTeBhOcT42LRtImRx7s9wDkenWylX7mvKXQ
 1yA+fdCdtvqPSP3JF3oeLvM/pHSXbfEshQ6EnhNQMl5OmqfzeJTn4yvWYX5dUtd48vbx1THH+
 FOzsJqdqkrh4duKdRbY4qO4DVZIBq8/j+QdrnAAG+4YSdjx2EUl2zOtzCGh5UH+cnlBtDZEKj
 PC87jPdX4GZTX2cHaPIvDJ6psnIKXnPSefM4y6Z1XYwB9DbEeQL2mCwgltPzId+WzsUywiTu7
 /fNthOsiDpmDiWqWq6huT2tgOct8RzFwExEi+W3YOkisPlfRku0OFyhBecxXvfWrjdMNxR26y
 yQ5Vu8AoT4DHzCXYD70TYjRWC5zBEod09e5HRYZ45sWTEpcHdSa92AdQLz6p3YLseiFVDDNyA
 BVRJkYchhRJZOy8X2hputTWO9q+M3pOA43aEFN/+XhPUTNv9Kin1F81waR4zNt8ZR37rqOOxQ
 YwUnhA12if2Mn/E1P3m6PVDdiQ4/TyKdWDD3mPBzfJaTlTn5uF1d1nIOuONLP6xZkrFv7FE8J
 qwnCJICgjtkl0tgyoEk9CTvXyoCoavQftFF9erwofAYQCxgZXXfo+YrU5blixJgkYSaetG5Er
 4DSR5eNwE9M/d/b72kvh9PiBq6P4Enx/8Tf0OxlnolOCmP6EZpInT7kyfu23qVX32XWfu+BPl
 whSMsMPepK6jkoSCXtiM7iwT/NYJAd/wMP5euS0yYzqmI1P4gk=
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 5, 2020 at 4:04 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Mar 5, 2020 at 3:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Mar 5, 2020 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> > > On Wed, Mar 4, 2020 at 5:28 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > On Wed, Mar 04, 2020 at 02:32:42PM +0100, Ulf Hansson wrote:
> > > > > + Christoph, Arnd
> >
> > > Today MMC isn't using a bus for the host controllers,
> > > it is a class device, so I suppose the "real" solution would
> > > be:
> > >
> > > 1. Move MMC hosts to a bus instead of a class named
> > >    say mmc_bus. If this is OK with the userspace ABI.
> > >
> > > 2. Make everything necessary from the struct device
> > >     inside struct mmc_host (today called "class_device")
> > >     copied over from the parent and stop referencing
> > >     the struct device *parent field in struct mmc_host
> > >     directly for everything and its dog.
> >
> > I don't think that copying the dma settings is a good solution
> > here. The software model that we have is that a bus can be a
> > dma master on its parent, which in turn is a master on
> > a parent bus, all the way up to the root of the tree. This is
> > not always the reality, but having an intermediate device
> > on a fake bus won't make it better.
>
> Alas, that is what we have today, because the platform_bus
> is pretty much fake.

Note the difference between a fake bus instance and a fake bus
type: the problem in certain drivers is making up a bus instance
for internal abstractions, and this causes problems with managing
DMA.

The 'platform_bus' bus_type being fake is a completely
unrelated problem, this is mostly an artifact of not being
able to model the actual buses because we don't even
know if something is an AXI or AHB bus or something else
in many cases, so we fall back to using platform_bus for
anything device that has mmio, dma, interrupts etc
but doesn't have a discoverable bus type already.

> My initial reasoning was because Greg has expressed that
> he thinks the platform_bus is overused and more specific
> buses should be used, so I outlined a plan to make
> OF not use the platform bus.
>
> (Which is maybe too hard.)

Traditionally we had a separate bus type for devices
probed from DT, but turned out to be a huge hassle because
of all the drivers that were also probed from board files
then needed to register two separate device_driver
structures.


      Arnd
