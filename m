Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C3C4320A
	for <linux-mmc@archiver.kernel.org>; Sat, 21 Aug 2021 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853E76125F
	for <linux-mmc@archiver.kernel.org>; Sat, 21 Aug 2021 21:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhHUVNu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 21 Aug 2021 17:13:50 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:30389 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhHUVNu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Aug 2021 17:13:50 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d69 with ME
        id kMD82500A3riaq203MD9DS; Sat, 21 Aug 2021 23:13:09 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Aug 2021 23:13:09 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] memstick: switch from 'pci_' to 'dma_' API
Date:   Sat, 21 Aug 2021 23:13:07 +0200
Message-Id: <f6fe24f2372c8c627a08ace7187bfe60d35788b6.1629580314.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.
It has been compile tested.

No memory allocation in involved in this patch, so no GFP_ tweak is needed.

@@ @@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@ @@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@ @@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@ @@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
---
 drivers/memstick/host/r592.c    |  5 ++---
 drivers/memstick/host/tifm_ms.c | 12 ++++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 615a83782e55..7ed984360349 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -293,7 +293,7 @@ static int r592_transfer_fifo_dma(struct r592_device *dev)
 
 	/* TODO: hidden assumption about nenth beeing always 1 */
 	sg_count = dma_map_sg(&dev->pci_dev->dev, &dev->req->sg, 1, is_write ?
-		PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
+			      DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
 	if (sg_count != 1 || sg_dma_len(&dev->req->sg) < R592_LFIFO_SIZE) {
 		message("problem in dma_map_sg");
@@ -310,8 +310,7 @@ static int r592_transfer_fifo_dma(struct r592_device *dev)
 	}
 
 	dma_unmap_sg(&dev->pci_dev->dev, &dev->req->sg, 1, is_write ?
-		PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
-
+		     DMA_TO_DEVICE : DMA_FROM_DEVICE);
 
 	return dev->dma_error;
 }
diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
index 57145374f6ac..c272453670be 100644
--- a/drivers/memstick/host/tifm_ms.c
+++ b/drivers/memstick/host/tifm_ms.c
@@ -279,8 +279,8 @@ static int tifm_ms_issue_cmd(struct tifm_ms *host)
 	if (host->use_dma) {
 		if (1 != tifm_map_sg(sock, &host->req->sg, 1,
 				     host->req->data_dir == READ
-				     ? PCI_DMA_FROMDEVICE
-				     : PCI_DMA_TODEVICE)) {
+				     ? DMA_FROM_DEVICE
+				     : DMA_TO_DEVICE)) {
 			host->req->error = -ENOMEM;
 			return host->req->error;
 		}
@@ -350,8 +350,8 @@ static void tifm_ms_complete_cmd(struct tifm_ms *host)
 	if (host->use_dma) {
 		tifm_unmap_sg(sock, &host->req->sg, 1,
 			      host->req->data_dir == READ
-			      ? PCI_DMA_FROMDEVICE
-			      : PCI_DMA_TODEVICE);
+			      ? DMA_FROM_DEVICE
+			      : DMA_TO_DEVICE);
 	}
 
 	writel((~TIFM_CTRL_LED) & readl(sock->addr + SOCK_CONTROL),
@@ -607,8 +607,8 @@ static void tifm_ms_remove(struct tifm_dev *sock)
 		if (host->use_dma)
 			tifm_unmap_sg(sock, &host->req->sg, 1,
 				      host->req->data_dir == READ
-				      ? PCI_DMA_TODEVICE
-				      : PCI_DMA_FROMDEVICE);
+				      ? DMA_TO_DEVICE
+				      : DMA_FROM_DEVICE);
 		host->req->error = -ETIME;
 
 		do {
-- 
2.30.2

