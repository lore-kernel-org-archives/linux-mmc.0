Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFABC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJEKUS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJEKUR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA174350
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965216; x=1696501216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dshEQlLbRsGSaVjEQDlJ4AdYvT3o9SuxQZ1XhWcz9Is=;
  b=dknKaMIY79L5LNsbpyPZMH3rKWRSpyxg06LiwFwd08eG6LERisKBQFNL
   3XDjBX425ZvqqH4KDrTRzElOTrumic9+baz7ne7h7+lWt7KB5a86B8OMY
   gMGoiQ3HqG9yy9oBt+ySFfuqT9MYsxl5UvA4SuGVWYZbdEC4wmatkN/NC
   wsuzK4PsWtJgZ/HE5QF4eglkkpZcjaR7TengMRfTMmVmlGuYqUqJbKZPz
   1qEMN1k1WtbyDUTsZbEK5UrHhwQEEW9wwDiIkPM3/4FjW9E8/YJfOADyh
   pmLt8oWaDiKazVQLxSayEaAKgaHJzBc4CxQhHK+HdFXFhqLhh+R9aV8A0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110413"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110413"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605912"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605912"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:13 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 02/14] mmc: sdhci: Remove local_irq_{save,restore}() around sg_miter_{next,stop}()
Date:   Wed,  5 Oct 2022 13:19:39 +0300
Message-Id: <20221005101951.3165-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sg_miter_next() using an sg_mapping_iter with flag SG_MITER_ATOMIC uses
kmap_atomic() to map pages.

A long time ago the kmap_atomic API required a slot to be provided which
risked the possibility that other code might use the same slot at the
same time. Disabling interrupts prevented the possibility of an interrupt
handler doing that. However, that went away with
commit 3e4d3af501cc ("mm: stack based kmap_atomic()").

Remove local_irq_{save,restore}() around sg_miter_{next,stop}().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0ee20f4beebf..31d87ec7d055 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -525,7 +525,6 @@ static inline bool sdhci_has_requests(struct sdhci_host *host)
 
 static void sdhci_read_block_pio(struct sdhci_host *host)
 {
-	unsigned long flags;
 	size_t blksize, len, chunk;
 	u32 scratch;
 	u8 *buf;
@@ -535,8 +534,6 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
 	blksize = host->data->blksz;
 	chunk = 0;
 
-	local_irq_save(flags);
-
 	while (blksize) {
 		BUG_ON(!sg_miter_next(&host->sg_miter));
 
@@ -563,13 +560,10 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
 	}
 
 	sg_miter_stop(&host->sg_miter);
-
-	local_irq_restore(flags);
 }
 
 static void sdhci_write_block_pio(struct sdhci_host *host)
 {
-	unsigned long flags;
 	size_t blksize, len, chunk;
 	u32 scratch;
 	u8 *buf;
@@ -580,8 +574,6 @@ static void sdhci_write_block_pio(struct sdhci_host *host)
 	chunk = 0;
 	scratch = 0;
 
-	local_irq_save(flags);
-
 	while (blksize) {
 		BUG_ON(!sg_miter_next(&host->sg_miter));
 
@@ -608,8 +600,6 @@ static void sdhci_write_block_pio(struct sdhci_host *host)
 	}
 
 	sg_miter_stop(&host->sg_miter);
-
-	local_irq_restore(flags);
 }
 
 static void sdhci_transfer_pio(struct sdhci_host *host)
-- 
2.25.1

