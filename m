From: <wei_wang@realsil.com.cn>
Subject: [PATCH 3/7] MFD:rtsx: Declare that the DMA address limitation is 32bit explicitly
Date: Mon, 24 Dec 2012 14:03:30 +0800
Message-ID: <af58804b4774b109fbd6022ce7cc8081990b3625.1356319097.git.wei_wang@realsil.com.cn>
References: <cover.1356319097.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:50328 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801Ab2LXGEG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Dec 2012 01:04:06 -0500
In-Reply-To: <cover.1356319097.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, sameo@linux.intel.com
Cc: devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com, bp@alien8.de, Wei WANG <wei_wang@realsil.com.cn>

From: Wei WANG <wei_wang@realsil.com.cn>

Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
---
 drivers/mfd/rtsx_pcr.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index fa2c2bc..2ee6be5 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -1084,6 +1084,10 @@ static int __devinit rtsx_pci_probe(struct pci_dev *pcidev,
 	pci_set_master(pcidev);
 	synchronize_irq(pcr->irq);
 
+	ret = pci_set_dma_mask(pcidev, DMA_BIT_MASK(32));
+	if (ret < 0)
+		goto disable_irq;
+
 	ret = rtsx_pci_init_chip(pcr);
 	if (ret < 0)
 		goto disable_irq;
-- 
1.7.9.5

