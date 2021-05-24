Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD5C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 11:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905D361244
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 11:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhEXLod (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 07:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhEXLoa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 07:44:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DDEC061574;
        Mon, 24 May 2021 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P9kzVkpH6K+dRhisEWwKagVuKYKm8ZedPldptcbJ5EU=; b=JMI7yDmehfFgOO6K1lO8bw7rxR
        1jXqcIv4JSaz0HwjVnCJv1HPvIQk0NG4ks1n//hnn9dqPHeKcLSKRwxdqFQYaTCeXEKV6qjEyIx2N
        O8d8JkNaLZTVN5/0JthMbpwxtn7hsbsdBG4cw6IwLo49RD4kECQSZKha7QfSkRoFVQbmUvJ1+zS6B
        uJLYhyNlofZDbmeHpRZ+ltW/w4or3WE8vrkZaIJyJlvCpG0+cacFrDg3axMdRguJA79LGDiZV2gLB
        1hAD9QbIjmBQg4q68YyXWbobccjIoEeSaoG9duiWG6+vm1BOK43J3d6nvp4Bt2ZhA/1ecm6OV2J9F
        TUnCCVFg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ll8yr-002K2i-AJ; Mon, 24 May 2021 11:42:49 +0000
Date:   Mon, 24 May 2021 12:42:45 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] mmc: core: Use ternery for return value in
 mmc_vdd_to_ocrbitnum()
Message-ID: <YKuRNRbsHtoD4LFi@infradead.org>
References: <20210520082837.2129-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520082837.2129-1-zbestahu@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, May 20, 2021 at 04:28:37PM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Just simplify the code.

The original version is way easier to read.
