Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02398C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJEKU0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiJEKUW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B708E74346
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965220; x=1696501220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTDJ3Rp1axDNGeX58oy3aTlApK2zSpIdoA06Z3aTles=;
  b=IU/RzBjNlFZ/0qOr6gp1/jgHzT7+ARey+u5JxuMxzUuB2Myt1DWMAg0g
   iuFwBt98f4c7nt2LGUsjcpuhEgealKDxEGl8X+q5HVqIqRe4aQcINDT8A
   ygs6eEEU8vl7BzDgbd1U9aRqZJEMZdk0jF40Z+9/l5QiQxJZfU+6BhW26
   rimyyrkF0jvQ0qvtgqQt4DDOO0N4Z7uLaanglQEUjokjXNFxUWW7Pj/ba
   zLCzvQjQ1QDSlJYlR/QDQY0xUbSSxijqLTPvgWQ6bFaOggriMkFHtJ7Z5
   vj/+PqkD/sXnEOuKvkHAstCgjmddrM0nQFWYv5IJ4VP9gw+HOIsuOLKKA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110421"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:20 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605935"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605935"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 04/14] mmc: bcm2835: Remove local_irq_{save,restore}() around k[un]map_atomic()
Date:   Wed,  5 Oct 2022 13:19:41 +0300
Message-Id: <20221005101951.3165-5-adrian.hunter@intel.com>
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

Unfortunately, that unnecessary pattern of code has been copied since
and persists in bcm2385.c.

Remove it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/bcm2835.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 641ab4f42125..49acbfa87ab8 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1068,7 +1068,6 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 	}
 
 	if (host->drain_words) {
-		unsigned long flags;
 		void *page;
 		u32 *buf;
 
@@ -1076,7 +1075,6 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 			host->drain_page += host->drain_offset >> PAGE_SHIFT;
 			host->drain_offset &= ~PAGE_MASK;
 		}
-		local_irq_save(flags);
 		page = kmap_atomic(host->drain_page);
 		buf = page + host->drain_offset;
 
@@ -1089,7 +1087,6 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 		}
 
 		kunmap_atomic(page);
-		local_irq_restore(flags);
 	}
 
 	bcm2835_finish_data(host);
-- 
2.25.1

