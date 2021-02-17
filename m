Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBDDC433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5492A64E4D
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Feb 2021 13:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhBQNkm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 08:40:42 -0500
Received: from verein.lst.de ([213.95.11.211]:45373 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233097AbhBQNkh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Feb 2021 08:40:37 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A4966736F; Wed, 17 Feb 2021 14:39:50 +0100 (CET)
Date:   Wed, 17 Feb 2021 14:39:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH] sdhci: stop poking into swiotlb internals
Message-ID: <20210217133950.GA8306@lst.de>
References: <20210205162346.2847165-1-hch@lst.de> <195d7168-3be0-91ea-1c5b-e850d5c12582@intel.com> <c3e3c2bf-96f9-41d8-9f42-c78bce2dbdc1@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3e3c2bf-96f9-41d8-9f42-c78bce2dbdc1@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Feb 17, 2021 at 01:10:48PM +0100, Jiri Slaby wrote:
> dma_max_mapping_size() should return the same for swiotlb 
> (swiotlb_max_mapping_size()), right?

Yes.
