Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE24C433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A1C20BED
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 15:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIAPHV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:07:21 -0400
Received: from verein.lst.de ([213.95.11.211]:53716 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgIAPG5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 11:06:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 103C368B05; Tue,  1 Sep 2020 17:06:55 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:06:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Brown <broonie@kernel.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when
 CONFIG_HAS_DMA is unset
Message-ID: <20200901150654.GB30034@lst.de>
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901150438.228887-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 01, 2020 at 05:04:38PM +0200, Ulf Hansson wrote:
> +#ifdef CONFIG_HAS_DMA
> +static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
> +{
> +	struct spi_device *spi = host->spi;
> +	struct device *dev;
> +
> +	if (!spi->master->dev.parent->dma_mask)
> +		return 0;

I still don't think this makes sense, as the dma_mask should always
be non-NULL here.
