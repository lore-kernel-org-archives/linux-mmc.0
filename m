Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77431C433E7
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 04:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F23220848
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 04:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgH1EYZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 00:24:25 -0400
Received: from verein.lst.de ([213.95.11.211]:40822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgH1EYZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 28 Aug 2020 00:24:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D4C3468BEB; Fri, 28 Aug 2020 06:24:22 +0200 (CEST)
Date:   Fri, 28 Aug 2020 06:24:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-ID: <20200828042422.GA29734@lst.de>
References: <20200714121856.955680-1-hch@lst.de> <20200714121856.955680-10-hch@lst.de> <20200828020045.GT3265@brightrain.aerifal.cx> <20200828021152.GU3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828021152.GU3265@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 27, 2020 at 10:11:53PM -0400, Rich Felker wrote:
> > This change broke SD card support on J2 because MMC_SPI spuriously
> > depends on HAS_DMA. It looks like it can be fixed just by removing
> > that dependency from drivers/mmc/host/Kconfig.
> 
> It can't. mmp_spi_probe fails with ENOMEM, probably due to trying to
> do some DMA setup thing that's not going to be needed if the
> underlying SPI device doesn't support/use DMA.

Adding the linux-mmc and linux-spi lists, as that seems pretty odd.
