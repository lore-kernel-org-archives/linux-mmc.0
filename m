Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68EC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiJEKUP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJEKUO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C472C71BFF
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965213; x=1696501213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzShbDe+0jMVu0dTbKcNM0QEbOfiTZeiXRO22k/SJcM=;
  b=aMkzGiG//S7hIcCPDZ8mpQnCRJIM2N0j0DO/Nlfs4bD8rHqrQ1Gli3N+
   kOHCvqtSJBxZ7Rs6Pl7JjoG1Wyf0HFsioXK/CT5ItHGxLe7cIlSv+TSpX
   gZfsb6oYEE8T9hk0n4SQiG1mAsesoRdaf9tD7Xz1WBJBgX5yOf+Hf3uwC
   Eu573MgMp6oOXZkTElTZmM8NqBbPbmNPkH//b+wfx5Z2nmJyqjQHOm5il
   tSWIx6xKpcxcq0Ywg/ZVr+SHTB8XtGhJRZ+39PjwaTIwdB1lvloPnVMrp
   bbVTlWL2Iq713lCsmt/AJHUib1vqH5CnIBO+8zVK2z3mKn0Iz4TEhGYbD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110410"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:13 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605909"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605909"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 01/14] mmc: sdhci: Remove local_irq_{save,restore}() around k[un]map_atomic()
Date:   Wed,  5 Oct 2022 13:19:38 +0300
Message-Id: <20221005101951.3165-2-adrian.hunter@intel.com>
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
 drivers/mmc/host/sdhci.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fef03de85b99..0ee20f4beebf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -705,16 +705,14 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 	return sg_count;
 }
 
-static char *sdhci_kmap_atomic(struct scatterlist *sg, unsigned long *flags)
+static char *sdhci_kmap_atomic(struct scatterlist *sg)
 {
-	local_irq_save(*flags);
 	return kmap_atomic(sg_page(sg)) + sg->offset;
 }
 
-static void sdhci_kunmap_atomic(void *buffer, unsigned long *flags)
+static void sdhci_kunmap_atomic(void *buffer)
 {
 	kunmap_atomic(buffer);
-	local_irq_restore(*flags);
 }
 
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
@@ -756,7 +754,6 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 	struct mmc_data *data, int sg_count)
 {
 	struct scatterlist *sg;
-	unsigned long flags;
 	dma_addr_t addr, align_addr;
 	void *desc, *align;
 	char *buffer;
@@ -788,9 +785,9 @@ static void sdhci_adma_table_pre(struct sdhci_host *host,
 			 SDHCI_ADMA2_MASK;
 		if (offset) {
 			if (data->flags & MMC_DATA_WRITE) {
-				buffer = sdhci_kmap_atomic(sg, &flags);
+				buffer = sdhci_kmap_atomic(sg);
 				memcpy(align, buffer, offset);
-				sdhci_kunmap_atomic(buffer, &flags);
+				sdhci_kunmap_atomic(buffer);
 			}
 
 			/* tran, valid */
@@ -851,7 +848,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	int i, size;
 	void *align;
 	char *buffer;
-	unsigned long flags;
 
 	if (data->flags & MMC_DATA_READ) {
 		bool has_unaligned = false;
@@ -874,9 +870,9 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 					size = SDHCI_ADMA2_ALIGN -
 					       (sg_dma_address(sg) & SDHCI_ADMA2_MASK);
 
-					buffer = sdhci_kmap_atomic(sg, &flags);
+					buffer = sdhci_kmap_atomic(sg);
 					memcpy(buffer, align, size);
-					sdhci_kunmap_atomic(buffer, &flags);
+					sdhci_kunmap_atomic(buffer);
 
 					align += SDHCI_ADMA2_ALIGN;
 				}
-- 
2.25.1

