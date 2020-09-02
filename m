Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DE3C433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 15:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426D220639
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 15:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIBPl3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:41:29 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:48904 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIBNoU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 09:44:20 -0400
Date:   Wed, 2 Sep 2020 09:44:18 -0400
From:   Rich Felker <dalias@libc.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
Message-ID: <20200902134418.GR3265@brightrain.aerifal.cx>
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
 <20200901150654.GB30034@lst.de>
 <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
 <20200901154049.GA376@lst.de>
 <CAPDyKFqDKUG3RC241hv535CLFGEQc4b-vv0e3bexzGkDSY82Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqDKUG3RC241hv535CLFGEQc4b-vv0e3bexzGkDSY82Jg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 02, 2020 at 10:31:47AM +0200, Ulf Hansson wrote:
> On Tue, 1 Sep 2020 at 17:40, Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > > > I still don't think this makes sense, as the dma_mask should always
> > > > be non-NULL here.
> > >
> > > If that is the case, I wonder how the driver could even have worked without DMA.
> > >
> > > Because in the existing code, host->dma_dev gets assigned to
> > > spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> > > usage in the driver.
> > >
> > > What am I missing?
> >
> > Do you know of other non-DMA users?  For SH nommu it probably worked
> 
> I don't know of other non-DMA users. As I said, I wish someone could
> step in and take better care of mmc_spi - as I know it's being used a
> lot.
> 
> > because SH nommu used to provide a DMA implementation that worked
> > fine for streaming maps, but was completely broken for coherent
> > allocation.  And this driver appears to only use the former.
> 
> Alright, so you are saying the DMA support may potentially never have
> been optional to this driver. In any case, I can remove the check in
> $subject patch, as it shouldn't matter.

DMA support was always optional, because even on systems where DMA is
present, it doesn't necessarily mean the SPI controller uses DMA. In
particular, pure bit-banged SPI via GPIOs doesn't have DMA, but has
always worked. See my previous reply to Christoph about host->dma_dev
for my current-best understanding of what's going on here.

> Anyway, let's see what Rich thinks of this. I am curious to see if the
> patch works on his SH boards - as I haven't been able to test it.

I'll rebuild and retest just to confirm, but I already tested a
functionally equivalent patch that just did the #ifdef inline (rather
than moving the logic out to separate functions) and it worked fine.

Rich
