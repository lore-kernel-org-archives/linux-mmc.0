Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72534C433E7
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 16:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597832067C
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 16:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIAQGt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:06:49 -0400
Received: from verein.lst.de ([213.95.11.211]:53903 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731513AbgIAPkx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 11:40:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12DF268B05; Tue,  1 Sep 2020 17:40:50 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:40:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rich Felker <dalias@libc.org>, Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
Message-ID: <20200901154049.GA376@lst.de>
References: <20200901150438.228887-1-ulf.hansson@linaro.org> <20200901150654.GB30034@lst.de> <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > I still don't think this makes sense, as the dma_mask should always
> > be non-NULL here.
> 
> If that is the case, I wonder how the driver could even have worked without DMA.
> 
> Because in the existing code, host->dma_dev gets assigned to
> spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> usage in the driver.
> 
> What am I missing?

Do you know of other non-DMA users?  For SH nommu it probably worked
because SH nommu used to provide a DMA implementation that worked
fine for streaming maps, but was completely broken for coherent
allocation.  And this driver appears to only use the former.
