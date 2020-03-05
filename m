Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADFBC3F2D1
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9042208CD
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCEPWu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:22:50 -0500
Received: from verein.lst.de ([213.95.11.211]:59950 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPWu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 5 Mar 2020 10:22:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5623368B05; Thu,  5 Mar 2020 16:22:46 +0100 (CET)
Date:   Thu, 5 Mar 2020 16:22:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Haibo Chen <haibo.chen@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call
 dma_set_max_seg_size()
Message-ID: <20200305152245.GB4870@lst.de>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com> <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com> <20200304162844.GA11727@lst.de> <CAPDyKFrkwbr1n_Se+gEA3uSH+aEPawN0qLQBjppjg4y_K4-w=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrkwbr1n_Se+gEA3uSH+aEPawN0qLQBjppjg4y_K4-w=w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 05, 2020 at 11:52:04AM +0100, Ulf Hansson wrote:
> > It really is not the job of the upper level driver to allocate the
> > dma params.  This should be done by the bus driver.
> 
> I agree that allocating the dma_parms doesn't belong in the mmc block
> queue layer.
> 
> However, it seems silly that each an every mmc host driver needs to do
> this themselves. So, perhaps we could manage this from
> mmc_alloc_host(), which is a common interface that mmc host drivers
> calls during initialization.

Neither mmc drivers nor the mmc core should allocate dma_params ever.
This should be once in their bus providers.
