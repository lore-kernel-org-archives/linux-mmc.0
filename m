Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A0CC6379D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA63206B2
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 11:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WatDSBL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgKXLhg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbgKXLhf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 06:37:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF8DC0613D6;
        Tue, 24 Nov 2020 03:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikFs6W6RIrqT3FutCVCXxvjhSuQBXFHIV/NVbFH43V8=; b=WatDSBL3PWnNbzhkqZCNit+hxQ
        rgUctPs3viclqZ2fAfyGGDLZb4ZhsEXXUUJJ7OxGCjvAoJVVCOrFgS2MHX2dCjJQp9qqEptTXAH6j
        RllhfyaOtPO3vhtWEq4IPenMH4bG8OQiCaygDwrdA/q6/PKHtKCCiU5u+4e3S43uvp7/zWCER8cSg
        UZTrbmuzD8Hyiq9iHxDZrPZBbCijjurcI6Kw4gIP1Vi5imwCXISKNX6V9BCkVXUmKs/WKLBt4M0JX
        zP0ldSWhp34xbB+GJ6HhDfgTpxaxPBvKhbO8WrNMTIBMSa8W5fur3wgpI+Babb1u3+e2edSAO+Imx
        K6ngEM4w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khWdM-0007vU-6g; Tue, 24 Nov 2020 11:37:20 +0000
Date:   Tue, 24 Nov 2020 11:37:20 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     ulf.hansson@linaro.org, keescook@chromium.org, ccross@android.com,
        tony.luck@intel.com, sgoutham@marvell.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        outgoing2/0000-cover-letter.patch@mx0b-0016f401.pphosted.com
Subject: Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on pstore/blk
Message-ID: <20201124113720.GA30440@infradead.org>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123111925.28999-1-bbudiredla@marvell.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Please hold this off for now.  I have a major rewrite of the pstore/blk
interface pending..
