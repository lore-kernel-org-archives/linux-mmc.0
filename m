Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F80C433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Oct 2021 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C6960F25
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Oct 2021 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbhJQSCC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 Oct 2021 14:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbhJQSCB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Oct 2021 14:02:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D50C06161C;
        Sun, 17 Oct 2021 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kVRnAY8ZNRFwGyvg/pbJzX1PHJAVk1zoiKn9aVPRPRk=; b=GmnFPhrt/3vSj6LBTQqX2eOrJd
        v8Uwz/qdav1qIv0N1c8ykp1hV5WUpW8Rpc0ysMkyMWj+hey98WKPnp+MMYAnwLl6WN+f3GPTrviSf
        h8n19Tcn+jn/R7ElWoTJ0BFZKSYbWoknOab1SIXw6G7Mr6xcSpBtTY7+2IR0kns+p/eNJFKBgeFEf
        OfpozCReKZ7THH60Jpzt4+Y9W0kFiGxT1E23s+6h3kzM/pKzvbRqLCUYXAFeE9gz4E1VaRNuawm5o
        TaE0sWnGzVpU0OQRxXIA/8qeVL/7y42xE5pCGprMqAl1s9+q9ld+UTTDCQbeGaPQMo3yWsskjl7aZ
        YzqiHw2g==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcARq-00D735-2l; Sun, 17 Oct 2021 17:59:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mmc: winbond: don't build on M68K
Date:   Sun, 17 Oct 2021 10:59:49 -0700
Message-Id: <20211017175949.23838-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Winbond MMC driver fails to build on ARCH=m68k so prevent
that build config. Silences these build errors:

../drivers/mmc/host/wbsd.c: In function 'wbsd_request_end':
../drivers/mmc/host/wbsd.c:212:28: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
  212 |                 dmaflags = claim_dma_lock();
../drivers/mmc/host/wbsd.c:215:17: error: implicit declaration of function 'release_dma_lock'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
  215 |                 release_dma_lock(dmaflags);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211015.orig/drivers/mmc/host/Kconfig
+++ linux-next-20211015/drivers/mmc/host/Kconfig
@@ -508,7 +508,7 @@ config MMC_OMAP_HS
 
 config MMC_WBSD
 	tristate "Winbond W83L51xD SD/MMC Card Interface support"
-	depends on ISA_DMA_API
+	depends on ISA_DMA_API && !M68K
 	help
 	  This selects the Winbond(R) W83L51xD Secure digital and
 	  Multimedia card Interface.
