Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA2DC3F2CD
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1957D2073D
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCEPXj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:23:39 -0500
Received: from verein.lst.de ([213.95.11.211]:59959 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgCEPXj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Mar 2020 10:23:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4764968B05; Thu,  5 Mar 2020 16:23:37 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:23:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Message-ID: <20200305152337.GC4870@lst.de>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com> <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com> <20200304162844.GA11727@lst.de> <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 05, 2020 at 03:29:55PM +0100, Linus Walleij wrote:
> I agree. This relates to my reply to Greg K-H recently:
> https://lore.kernel.org/lkml/CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com/
> 
> The core of the problem is that drivers/of/platform.c is
> very simple and has no idea what kind of bus it is populating
> with devices from Device Tree. It is just guessing.
> 
> For example platform.c contains this:
> 
>         dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>         if (!dev->dev.dma_mask)
>                 dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> 
> And again part of the problem is that the device tree parser
> mostly just create struct platform_device's on the platform bus
> and has no real idea about any constraints on the bus where
> it will eventually end up after the platform device is probed and
> a new device on some other bus has been created.

the plaform device code should allocate the dma_params for every
device.  It should not set any limits in that, that is up to the
host drivers.
