Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A149C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJEKUk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJEKUi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D790A75496
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965236; x=1696501236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySqpMmfPU6WHUVl46ZFzM3QA7uwCVmEUc5bGhgxfZPs=;
  b=eFYfWyCb/s7SCxKbA29LMjtfaZSqpd3WluZDxeB1vPinAw3ObtxAFXRr
   qOgC/Zf3jKjEbfiDKCaoPUgUzUOsUfWXbjHB5GwZc12iCXD41Y1el4Bbw
   u3V/nqvkns0qKEivpDKV4blnuCdjke6+KwpccMWBIwIR+saOR65iHQxDv
   2LcVBNqocFZiCYrmCOwV5uLPbxbJXPgHTB54LUMiF+Qz0JgY42FfKDU6u
   SE2y4XLfNbHG3BKvBdQfMPDoqT/Q7EvpQoII2DgtYqmc14nbikTgAMue7
   arQZr7Y/YEDmb/gvU2pZrPPATRnm1dFTK0/XsogeianXxmxmIFsxOB/UI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110462"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110462"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728606008"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728606008"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 11/14] mmc: tmio_mmc_core: Remove local_irq_{save,restore}() around k[un]map_atomic()
Date:   Wed,  5 Oct 2022 13:19:48 +0300
Message-Id: <20221005101951.3165-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A long time ago the kmap_atomic API required a slot to be provided which
risked the possibility that other code might use the same slot at the
same time. Disabling interrupts prevented the possibility of an interrupt
handler doing that. However, that went away with
commit 3e4d3af501cc ("mm: stack based kmap_atomic()").

When the second argument to kmap_atomic was removed by commit 482fce997e14
("mmc: remove the second argument of k[un]map_atomic()"),
local_irq_{save,restore}() should have been removed also.

Remove it now.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c |  5 ++---
 drivers/mmc/host/tmio_mmc.h              |  7 ++-----
 drivers/mmc/host/tmio_mmc_core.c         | 10 ++++------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 99e3426df702..e9cc6c15d229 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -254,12 +254,11 @@ static void renesas_sdhi_sys_dmac_start_dma_tx(struct tmio_mmc_host *host)
 
 	/* The only sg element can be unaligned, use our bounce buffer then */
 	if (!aligned) {
-		unsigned long flags;
-		void *sg_vaddr = tmio_mmc_kmap_atomic(sg, &flags);
+		void *sg_vaddr = tmio_mmc_kmap_atomic(sg);
 
 		sg_init_one(&host->bounce_sg, host->bounce_buf, sg->length);
 		memcpy(host->bounce_buf, sg_vaddr, host->bounce_sg.length);
-		tmio_mmc_kunmap_atomic(sg, &flags, sg_vaddr);
+		tmio_mmc_kunmap_atomic(sg, sg_vaddr);
 		host->sg_ptr = &host->bounce_sg;
 		sg = host->sg_ptr;
 	}
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 501613c74406..22375790b57b 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -204,18 +204,15 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
-static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
-					 unsigned long *flags)
+static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg)
 {
-	local_irq_save(*flags);
 	return kmap_atomic(sg_page(sg)) + sg->offset;
 }
 
 static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
-					  unsigned long *flags, void *virt)
+					  void *virt)
 {
 	kunmap_atomic(virt - sg->offset);
-	local_irq_restore(*flags);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 437048bb8027..6d50c0dd53fe 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -412,7 +412,6 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 	void *sg_virt;
 	unsigned short *buf;
 	unsigned int count;
-	unsigned long flags;
 
 	if (host->dma_on) {
 		pr_err("PIO IRQ in DMA mode!\n");
@@ -422,7 +421,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 		return;
 	}
 
-	sg_virt = tmio_mmc_kmap_atomic(host->sg_ptr, &flags);
+	sg_virt = tmio_mmc_kmap_atomic(host->sg_ptr);
 	buf = (unsigned short *)(sg_virt + host->sg_off);
 
 	count = host->sg_ptr->length - host->sg_off;
@@ -437,7 +436,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 
 	host->sg_off += count;
 
-	tmio_mmc_kunmap_atomic(host->sg_ptr, &flags, sg_virt);
+	tmio_mmc_kunmap_atomic(host->sg_ptr, sg_virt);
 
 	if (host->sg_off == host->sg_ptr->length)
 		tmio_mmc_next_sg(host);
@@ -446,11 +445,10 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 static void tmio_mmc_check_bounce_buffer(struct tmio_mmc_host *host)
 {
 	if (host->sg_ptr == &host->bounce_sg) {
-		unsigned long flags;
-		void *sg_vaddr = tmio_mmc_kmap_atomic(host->sg_orig, &flags);
+		void *sg_vaddr = tmio_mmc_kmap_atomic(host->sg_orig);
 
 		memcpy(sg_vaddr, host->bounce_buf, host->bounce_sg.length);
-		tmio_mmc_kunmap_atomic(host->sg_orig, &flags, sg_vaddr);
+		tmio_mmc_kunmap_atomic(host->sg_orig, sg_vaddr);
 	}
 }
 
-- 
2.25.1

