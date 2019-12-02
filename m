Return-Path: <SRS0=vSIZ=ZY=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D477C432C0
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64ED520672
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Dec 2019 17:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJfqHQxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfLBRwG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:52:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLBRwF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Dec 2019 12:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=n5690yqsQb4/rQY3OEABFd/2lBj8SsqPI0HGYzVX01g=; b=DJfqHQxkAtsvv0gXLge/gNu8C
        ApgkpszhA2sefhuBwFW2lqxFI+VNHXnjKdXq/KSM9hzHifGp4GYNa2oC52+r8YZzSExlvaVngG4xu
        3s1S5Bf70UlERndLqArryVn3I2sLD8zFPtcSmGrG7hlSN9/yf4m/MlWGOIM7S65m01wt6+zJ+9mqc
        5qOK6pp0hHzUB2fJwVdclSNKrXankTXsics3j72JfyNCMS/xmJ+gLTP8qiT34/WmTLDxo7+kknCk6
        e03kQD21Y8D+uKCDbFwxbyjANXv3x5i5fRPaEzSfAVeH9EUQnH2B51TqiLnQajP8n27BFX1d4CG9E
        zWXI4LPjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibpre-0002yL-Dy; Mon, 02 Dec 2019 17:52:02 +0000
Date:   Mon, 2 Dec 2019 09:52:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Message-ID: <20191202175202.GA6488@infradead.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-5-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202144104.5069-5-jun.nie@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 02, 2019 at 10:41:04PM +0800, Jun Nie wrote:
> DMA memory cannot cross specific boundary for some SDHCI controller,
> such as DesignWare SDHCI controller. Add DMA memory boundary dt
> property and workaround the limitation.

If you use blk_queue_segment_boundary to tell the block layer the
segment boundary restrictions it won't ever send you segments
that don't fit.  With just the workaround in this patch you'll run into
max_segments accounting issues, don't you?
