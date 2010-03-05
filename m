From: akpm@linux-foundation.org
Subject: [patch 095/160] mmc: bfin_sdh: fix unused sg warning on BF51x/BF52x systems
Date: Fri, 05 Mar 2010 13:43:23 -0800
Message-ID: <201003052143.o25LhN3R029745@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54132 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755358Ab0CEVn1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, vapier@gentoo.org, linux-mmc@vger.kernel.org

From: Mike Frysinger <vapier@gentoo.org>

The local sg variable is only used with BF54x code.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/bfin_sdh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/bfin_sdh.c~mmc-bfin_sdh-fix-unused-sg-warning-on-bf51x-bf52x-systems drivers/mmc/host/bfin_sdh.c
--- a/drivers/mmc/host/bfin_sdh.c~mmc-bfin_sdh-fix-unused-sg-warning-on-bf51x-bf52x-systems
+++ a/drivers/mmc/host/bfin_sdh.c
@@ -115,7 +115,6 @@ static int sdh_setup_data(struct sdh_hos
 	unsigned int length;
 	unsigned int data_ctl;
 	unsigned int dma_cfg;
-	struct scatterlist *sg;
 
 	dev_dbg(mmc_dev(host->mmc), "%s enter flags: 0x%x\n", __func__, data->flags);
 	host->data = data;
@@ -151,6 +150,7 @@ static int sdh_setup_data(struct sdh_hos
 #if defined(CONFIG_BF54x)
 	dma_cfg |= DMAFLOW_ARRAY | NDSIZE_5 | RESTART | WDSIZE_32 | DMAEN;
 	{
+		struct scatterlist *sg;
 		int i;
 		for_each_sg(data->sg, sg, host->dma_len, i) {
 			host->sg_cpu[i].start_addr = sg_dma_address(sg);
_
