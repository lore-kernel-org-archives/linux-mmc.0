Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144AFC43141
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619D2080F
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 13:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M8Y595qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfLCNEz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:04:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbfLCNEz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2019 08:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=swPLnU+mch3Xmy4l4gNFvfkSplS5ugsR2ljdaAIZq+8=; b=M8Y595qcM8HSiDgNNG6dYczb2
        Pe72oiN1OM/5miwYjnPRYyA5q8yeDzR7UFs4AAMtsVL1+/fNGhCAPTsfr3FCkoCBMoXkYXSI5koN0
        l9XuGn7bW6uVNKxP+tj3igXUgjA4azjLqLFLyjaWfYL2SSHfU5xhN94rai6/14NcUyCimhCYE/TPm
        KFCW8HvCR3TZxuVhLcdawgyxvh7zBmKD4lHI/spONN5RXJgaGiwJCfeqxBKudY/3DErZYB7jGfGBl
        Rnt4mef3hh9g3Puw2CZnD7oQjp4Eji1VNeQYBE38NpQ24rk0lKKgn1YUIaTCsYyVdZiTpUARwOiOF
        q6yFB7t8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ic7rF-00074e-57; Tue, 03 Dec 2019 13:04:49 +0000
Date:   Tue, 3 Dec 2019 05:04:49 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jun Nie <jun.nie@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Message-ID: <20191203130449.GA20607@infradead.org>
References: <20191202144104.5069-1-jun.nie@linaro.org>
 <20191202144104.5069-5-jun.nie@linaro.org>
 <20191203103320.273a7309@xhacker.debian>
 <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
 <20191203165123.4e6f9e28@xhacker.debian>
 <20191203173256.55f527d5@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203173256.55f527d5@xhacker.debian>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 03, 2019 at 09:49:33AM +0000, Jisheng Zhang wrote:
> > can't work. I'm not sure I understand blk_queue_segment_boundary() properly.
> > May Christoph help to clarify?
> 
> what's more, not all scatterlist in mmc are from block layer, for example, 
> __mmc_blk_ioctl_cmd(), mmc_test.c etc..
> 
> How do we ensure the boundary is fine in these cases?

By using block layer passthrough requests (REQ_OP_DRV*).  Otherwise
any other I/O limit imposed by the driver is ignored as well.
