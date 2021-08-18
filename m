Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DFFC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 13:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5B460F4C
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 13:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhHRN3E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 09:29:04 -0400
Received: from verein.lst.de ([213.95.11.211]:33810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238743AbhHRN2k (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 09:28:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A27EE68AFE; Wed, 18 Aug 2021 15:28:01 +0200 (CEST)
Date:   Wed, 18 Aug 2021 15:28:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kalle Valo <kvalo@codeaurora.org>,
        ath10k@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: imx7: dev->coherent_dma_mask NULL warning
Message-ID: <20210818132800.GA6269@lst.de>
References: <CAOMZO5DEAMMKHwDkXxqWxg6uj_GQjBUQ5jV+4AzxAr2DCrgTVg@mail.gmail.com> <20210818051128.GA8550@lst.de> <CAOMZO5APotsBKPkN6tFDNnK0C7w7pzJ8zTWKUx6P=Rhd9_81mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5APotsBKPkN6tFDNnK0C7w7pzJ8zTWKUx6P=Rhd9_81mQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 18, 2021 at 06:31:19AM -0300, Fabio Estevam wrote:
> Correct, on i.MX7 the ath10k Wifi chip connects via SDIO.
> 
> Is there a way to avoid the WARN_ON_ONCE(!dev->coherent_dma_mask)
> to happen in this case?

The way to avoid it is by stoppind to use dma_alloc_attrs/coherent
on a device that is not DMA capable.
