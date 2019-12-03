Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EAC43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 07:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C6F20803
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 07:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZtwBEung"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfLCHg1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:36:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfLCHgY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2019 02:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NMl28qnSn9qKUPoyqAd/9lBOFlG131U1Nogq3mGZmTA=; b=ZtwBEungQThfV+tlkI1kFpgIf
        8ckblrcqVs9slqfLiF90wQIRYhOFKOUL9aTGUkSaGRgfHiZCWmSR+Eez/LkIJK7o8UdPgyJTVxiLx
        bU6iLt2t4bxG2sJxEAxgapBiEu3D/owFhXlNXo/nFIGMgH+KjOcGci/XWAMkY9DWGz9NS1TQWRlzZ
        pRAAN/cD3ygodWvKNAmPaHTTaJGIVvNSvK3h9npz/ddK0i+RhmBdXD0qA5DHAUh9c/4ZXULf+ePCi
        9MA0D8vWayOAkSPPxSWTAd0GamqO01m1a4/Ew4B0ip2rVtw5eqEaylPaIarY/uKXZnpxjEW4BIBIH
        +8471Y3DA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic2jN-0000VJ-12; Tue, 03 Dec 2019 07:36:21 +0000
Date:   Mon, 2 Dec 2019 23:36:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, adrian.hunter@intel.com,
        linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Message-ID: <20191203073620.GA360@infradead.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-5-jun.nie@linaro.org>
 <20191202175202.GA6488@infradead.org>
 <CABymUCM09L3TfLsPhLWPkoYXJ6OVGhHvd9_o4FCO07_Z3Y6A8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABymUCM09L3TfLsPhLWPkoYXJ6OVGhHvd9_o4FCO07_Z3Y6A8w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 03, 2019 at 11:29:15AM +0800, Jun Nie wrote:
> Thanks for the reminder! So I need to parse the segment_boundary from
> device tree and use below code to set it, right?
> For the max_segments accounting error, I did not see it so far though I
> believe it is true in theory. Maybe it is due to segment boundary value is
> very large.
>
> +++ b/drivers/mmc/core/queue.c
> @@ -374,6 +374,7 @@ static void mmc_setup_queue(struct mmc_queue *mq,
> struct mmc_card *card)
>                 WARN(!blk_queue_can_use_dma_map_merging(mq->queue,
>                                                         mmc_dev(host)),
>                      "merging was advertised but not possible");
> +       blk_queue_segment_boundary(mq->queue, mmc->segment_boundary);
>         blk_queue_max_segments(mq->queue, mmc_get_max_segments(host));

Yes, I think should do it.  Maybe modulo a check if the low-level
driver actually sets a segment boundary.
