From: Christoph Hellwig <hch@infradead.org>
Subject: bounce limit in mmc?
Date: Mon, 28 Aug 2017 10:48:08 -0700
Message-ID: <20170828174808.GA8384@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbdH1RsJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Aug 2017 13:48:09 -0400
Received: from hch by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1dmO8u-0002FV-Jc
        for linux-mmc@vger.kernel.org; Mon, 28 Aug 2017 17:48:08 +0000
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all, any idea why the mmc driver defaults to bouncing highmem
pages if the device doesn't have a DMA mask?  highmem is defined
different on different architectures or even based on config options,
so it seems like a very odd choice.
