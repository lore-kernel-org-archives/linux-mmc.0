Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2410C3F2D8
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 16:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D404024654
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 16:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgCDQ2r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:28:47 -0500
Received: from verein.lst.de ([213.95.11.211]:55377 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbgCDQ2r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 4 Mar 2020 11:28:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DCC7668BE1; Wed,  4 Mar 2020 17:28:44 +0100 (CET)
Date:   Wed, 4 Mar 2020 17:28:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Haibo Chen <haibo.chen@nxp.com>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Message-ID: <20200304162844.GA11727@lst.de>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com> <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 04, 2020 at 02:32:42PM +0100, Ulf Hansson wrote:
> + Christoph, Arnd
> 
> On Wed, 19 Feb 2020 at 09:31, <haibo.chen@nxp.com> wrote:
> >
> > From: Haibo Chen <haibo.chen@nxp.com>
> >
> > To make dma_set_max_seg_size() work, need to create dev->dma_parms.
> >
> > Find this issue on i.MX8QM mek board, this platform config the
> > max_segment_size to 65535, but this dma_set_max_seg_size do not
> > actuall work, find sometimes the segment size is 65536, exceed
> > the hardware max segment limitation, trigger ADMA error.
> 
> Sounds like we want something along the lines of this to be tagged for
> stable as well.

It really is not the job of the upper level driver to allocate the
dma params.  This should be done by the bus driver.
