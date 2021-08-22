Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A87C432BE
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Aug 2021 13:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21466120C
	for <linux-mmc@archiver.kernel.org>; Sun, 22 Aug 2021 13:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhHVNtZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 09:49:25 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:24760 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232518AbhHVNtZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 09:49:25 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d74 with ME
        id kdoe250033riaq203doewr; Sun, 22 Aug 2021 15:48:42 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Aug 2021 15:48:42 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     oakad@yahoo.com, ulf.hansson@linaro.org, brucechang@via.com.tw,
        HaraldWelte@viatech.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mmc: switch from 'pci_' to 'dma_' API
Date:   Sun, 22 Aug 2021 15:48:37 +0200
Message-Id: <b617f284e2ab8b6b48fff150eba1638641646edd.1629640046.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below.

It has been compile tested.


@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
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
 drivers/mmc/host/tifm_sd.c   | 16 ++++++++--------
 drivers/mmc/host/via-sdmmc.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 9fdf7ea06e3f..63917070b1a7 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -669,8 +669,8 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 			if(1 != tifm_map_sg(sock, &host->bounce_buf, 1,
 					    r_data->flags & MMC_DATA_WRITE
-					    ? PCI_DMA_TODEVICE
-					    : PCI_DMA_FROMDEVICE)) {
+					    ? DMA_TO_DEVICE
+					    : DMA_FROM_DEVICE)) {
 				pr_err("%s : scatterlist map failed\n",
 				       dev_name(&sock->dev));
 				mrq->cmd->error = -ENOMEM;
@@ -680,15 +680,15 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 						   r_data->sg_len,
 						   r_data->flags
 						   & MMC_DATA_WRITE
-						   ? PCI_DMA_TODEVICE
-						   : PCI_DMA_FROMDEVICE);
+						   ? DMA_TO_DEVICE
+						   : DMA_FROM_DEVICE);
 			if (host->sg_len < 1) {
 				pr_err("%s : scatterlist map failed\n",
 				       dev_name(&sock->dev));
 				tifm_unmap_sg(sock, &host->bounce_buf, 1,
 					      r_data->flags & MMC_DATA_WRITE
-					      ? PCI_DMA_TODEVICE
-					      : PCI_DMA_FROMDEVICE);
+					      ? DMA_TO_DEVICE
+					      : DMA_FROM_DEVICE);
 				mrq->cmd->error = -ENOMEM;
 				goto err_out;
 			}
@@ -762,10 +762,10 @@ static void tifm_sd_end_cmd(struct tasklet_struct *t)
 		} else {
 			tifm_unmap_sg(sock, &host->bounce_buf, 1,
 				      (r_data->flags & MMC_DATA_WRITE)
-				      ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
+				      ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 			tifm_unmap_sg(sock, r_data->sg, r_data->sg_len,
 				      (r_data->flags & MMC_DATA_WRITE)
-				      ? PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
+				      ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
 		}
 
 		r_data->bytes_xfered = r_data->blocks
diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index c32df5530b94..88662a90ed96 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -491,7 +491,7 @@ static void via_sdc_preparedata(struct via_crdr_mmc_host *host,
 
 	count = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 		((data->flags & MMC_DATA_READ) ?
-		PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE));
+		DMA_FROM_DEVICE : DMA_TO_DEVICE));
 	BUG_ON(count != 1);
 
 	via_set_ddma(host, sg_dma_address(data->sg), sg_dma_len(data->sg),
@@ -638,7 +638,7 @@ static void via_sdc_finish_data(struct via_crdr_mmc_host *host)
 
 	dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
 		((data->flags & MMC_DATA_READ) ?
-		PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE));
+		DMA_FROM_DEVICE : DMA_TO_DEVICE));
 
 	if (data->stop)
 		via_sdc_send_command(host, data->stop);
-- 
2.30.2

