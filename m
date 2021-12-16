Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C43C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Dec 2021 07:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhLPH61 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Dec 2021 02:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhLPH60 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Dec 2021 02:58:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FECC061574
        for <linux-mmc@vger.kernel.org>; Wed, 15 Dec 2021 23:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=grIzzDO/SyMOLb0KIkcAnpyTgu
        WWv07JVAUsmM4j6nZFj7B/b9PsApHnmAUxoa8hES1cDeAyK+iTtRO+9+gDpGwSpxJmpjpQGxHxPjg
        obE80vVF2H1zEXJVYjQdvGmOqFuNKaf45QIrDbbHtjIGAoHmew5FEyjSML62Id7zk3dBacW1VLor+
        pMKwEw5OsIcxqMiSxTcMobg3JUx4KwLxRlvIz+r+CX1zMgyyrfarwXf/RkxrciJZy+uZxvBfUesyq
        6o2uM/1MGVzwTwbl9ggJ4D6d01bUIbjXJi1hgsdwZafxRVij1ViuVU7NplHDV7KUVkvjF2EUk/hp3
        btNvvG6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxlei-0041ul-6Z; Thu, 16 Dec 2021 07:58:24 +0000
Date:   Wed, 15 Dec 2021 23:58:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Fix blk_status_t handling
Message-ID: <YbrxoP4PPWMin0KL@infradead.org>
References: <20211215011336.194089-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215011336.194089-1-joel@jms.id.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
