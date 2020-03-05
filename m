Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4BCC3F2D7
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 14:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9E720658
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 14:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgCEOp7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:45:59 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49247 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgCEOp7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 09:45:59 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQMdz-1iwReB09Td-00MMi7 for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020
 15:45:58 +0100
Received: by mail-qk1-f176.google.com with SMTP id y126so2080820qke.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2020 06:45:57 -0800 (PST)
X-Gm-Message-State: ANhLgQ02QXwjxS/lF5REGW+3SxwWdlg4YOrsRLG42KOfRf4W4B+L2nrh
        9LYMlZ6IqUzkcEdnqEK7h029Bl9JFifLHgikgjs=
X-Google-Smtp-Source: ADFU+vvnypWqY6M6rPdyF9h6DyIbWhWIxl1j02iH9PXwvdII2iV/a1tRPAuAW1jWDTNhl91PxN+/JKsa6c1JBM0BoRQ=
X-Received: by 2002:a05:620a:74c:: with SMTP id i12mr8522918qki.286.1583419556862;
 Thu, 05 Mar 2020 06:45:56 -0800 (PST)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
 <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
 <20200304162844.GA11727@lst.de> <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
In-Reply-To: <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 Mar 2020 15:45:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1m2oRhSRosJXbuswhY2ePa56o5e1rTd=qZDpj=ZEH6Dg@mail.gmail.com>
Message-ID: <CAK8P3a1m2oRhSRosJXbuswhY2ePa56o5e1rTd=qZDpj=ZEH6Dg@mail.gmail.com>
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
X-Provags-ID: V03:K1:W5QnkBTICtrGtBWyLHQtqBDTYtYn3U7B1b/Nwvi9W8neSb5sg91
 sUFGrK5ahYUvz53HnfIhFjujjo6ZGMrnXXIUbZEPXH3GTqM3xMKOiFCgPP53Uzn7/Vxg6Wk
 PyHnNKp8ZvqeKt0KJ74Lc9ZNO1uVwqJGA2f6UCWKGYrdTFelFrLgNIj1Xux/6I7HgK9MVWQ
 4lRlNN8t0OoSOxfmYTxeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CaNT0hzsUFM=:uEFNrNDyQL9DAfcRzhXD8j
 2tlBZ4qDSb8Dsd7deUTkD5ykyfN/qxHNdXEchLu0bEg0vK4/4etI+kMWzgtBginUZRa/J0y9z
 81H46D1JMM4X2MyRUp9mIRBJmUSugUzmldG7j8Qqum8F0BMz+DGrFFz+3Iv7azejGJfSaQofl
 vS7fJJ7FL97aA0cnRdBNwkocHKDDkauYaZGw9I8fNl4TVJXJZLVvH2w3BPFboHsJm978sOhG9
 IVQPEdJdNFJ9cVyM8thhBwyQtb4CKKce2v2qyo+JsAg/O3mh10ODJRrkiEJzljS23cB4MYf34
 kTH9OflprChEmi+/54L1JLXywaXb8mBP6TX9vaKBdfvc738dYhG6yrT9PKGi+Cz7ZrEDyDfLV
 Kx4/Od1N20DNx04NXexA5VpfsGu4pgMI1hiRyJlucjfkpd9zjGbIAT6bWDPzuPQQfEAUNFHFV
 550YgpDM8M03EEQ/4U5Fm8ad8U2dgqgf/7ANs66PgWojw6HypNOLj0wkSVN2XsgMFouqlJmBf
 b0r8Lkqty4b6dZoNtw49DvVTaGXIuwWBjWC6dG6y5ceFEk7jt+r8OrREuJAbwJxqD7/6J49JH
 f4+p/cIiWpeZ+H31AKKsddJ0LXZrfYJtZrC+zdf4vgJNH7THmbbdPemcwUdFW8zrwXNnck8Q2
 Ewk4Bu/tvch5tvqpOW38aXKx79b0TBC8xLIROriJ687l/ejl3kUCkP4LDbSxguvKIrjZEf2/9
 2RlJB1EB+hVL3Teq8kFdG8Q5o+mL1AjSUvyZh/RKOL9KC0XTXKDR35LGAnKsH8Aw2mXHuBpl4
 GwlAP9rlD8Jd3w5RxEn8r4rqWHjzo0wXa7gHPUYhVQsuabPXrk=
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 5, 2020 at 3:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Mar 4, 2020 at 5:28 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Wed, Mar 04, 2020 at 02:32:42PM +0100, Ulf Hansson wrote:
> > > + Christoph, Arnd

> Today MMC isn't using a bus for the host controllers,
> it is a class device, so I suppose the "real" solution would
> be:
>
> 1. Move MMC hosts to a bus instead of a class named
>    say mmc_bus. If this is OK with the userspace ABI.
>
> 2. Make everything necessary from the struct device
>     inside struct mmc_host (today called "class_device")
>     copied over from the parent and stop referencing
>     the struct device *parent field in struct mmc_host
>     directly for everything and its dog.

I don't think that copying the dma settings is a good solution
here. The software model that we have is that a bus can be a
dma master on its parent, which in turn is a master on
a parent bus, all the way up to the root of the tree. This is
not always the reality, but having an intermediate device
on a fake bus won't make it better.

The natural model is that an mmc host is a device on an
arbitrary dma capable bus (platform, pci, ...), and its
children are mmc devices with bus=&mmc_bus_type.

If that is not already the case, that is where I'd start
changing it to simplify the model.

        Arnd
