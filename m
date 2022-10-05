Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56A5C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJEKUa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJEKU2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:28 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE03A74346
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965225; x=1696501225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTSmrEt2GIdGjZDQKAw02bjSU5MeRqdd+2YUlOEbJCI=;
  b=XWEhrgT2cIYdb3SdywXqWfFvSpqMtjvVPnJ+QQLIOyQ3GACNFkFXzhgd
   CbxWw9t66ejZ58IHe/FxaQRH2dKxgFz2Q1e7ZBibGBdbcSIS7e6cJZ7nB
   jseDgTeibq5eZRww1/9ruHLNsqy2CxWTYzFkB8IfW/+sAXS5Ud0xDAn23
   6SGs3RuYkeERcAuqmE8ARlywgAw/tQpjVFHQqjan0PYSgnY+ggL/vQb64
   WLeVIr04Qe0Dy3X7kU+3yxO3kmYxfyr9tusN8R7h8cPtuo20q7zFEBAqf
   9ImXPSdrrCxyYtoEA2XygGOMKMRgGfcRhMbQ7U1KLBCcKMd/LziHljr+G
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110436"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110436"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605955"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605955"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 06/14] mmc: bcm2835: Replace kmap_atomic() with kmap_local_page()
Date:   Wed,  5 Oct 2022 13:19:43 +0300
Message-Id: <20221005101951.3165-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

kmap_local_page() is equivalent to kmap_atomic() except that it does not
disable page faults or preemption. Where possible kmap_local_page() is
preferred to kmap_atomic() - refer kernel highmem documentation.

In this case, there is no need to disable page faults or preemption, so
replace kmap_atomic() with kmap_local_page(), and, correspondingly,
kunmap_atomic() with kunmap_local().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/bcm2835.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 440773e3ba55..8648f7e63ca1 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1070,7 +1070,7 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 			host->drain_page += host->drain_offset >> PAGE_SHIFT;
 			host->drain_offset &= ~PAGE_MASK;
 		}
-		page = kmap_atomic(host->drain_page);
+		page = kmap_local_page(host->drain_page);
 		buf = page + host->drain_offset;
 
 		while (host->drain_words) {
@@ -1081,7 +1081,7 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 			host->drain_words--;
 		}
 
-		kunmap_atomic(page);
+		kunmap_local(page);
 	}
 
 	bcm2835_finish_data(host);
-- 
2.25.1

