Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272EC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJEKUb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJEKU3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE574B80
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965228; x=1696501228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H+qpET7m8KjrmynFemQpw4n7WO+ula0zi+RhEelZiHk=;
  b=el+AKt0g8ElWr1bGdFex+NO+I5Kk7vff4cLCY9ngncBO79SD/dLPST2m
   g+00VRjWb2CNXww4hSyacrkjPcI+0Yf0cIkdV/fX83sDaMldMDI51ymgr
   VUicZZ8/0U7ihxfnKzDtD2lIK9uL4HYFaoWOtrfQVp+cGLAR7IhX1YFCL
   DXbmaKjdg7k1LGSWyr8v7pEULXY51aIv7+ZVJAJpW00l5HdW+z1KjIj2Y
   u8LClPfbcZKmRMzKsmLBuSr65gJLPT4VAWx+czfI0qObJlnPJ3YcI5sJ/
   Vzz4eAUcWJyoWThKUYZDLMZnvNMTR1ezKWLh7P8+g0zL9b6LTImVEPngO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110444"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110444"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605965"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605965"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 07/14] mmc: mmc_test: Remove local_irq_{save,restore}() around sg_copy_{from,to}_buffer()
Date:   Wed,  5 Oct 2022 13:19:44 +0300
Message-Id: <20221005101951.3165-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221005101951.3165-1-adrian.hunter@intel.com>
References: <20221005101951.3165-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

sg_copy_{from,to}_buffer() call sg_copy_buffer() which uses an
sg_mapping_iter with flag SG_MITER_ATOMIC, so then sg_miter_next() uses
kmap_atomic() to map pages.

A long time ago the kmap_atomic API required a slot to be provided which
risked the possibility that other code might use the same slot at the
same time. Disabling interrupts prevented the possibility of an interrupt
handler doing that. However, that went away with
commit 3e4d3af501cc ("mm: stack based kmap_atomic()").

Remove local_irq_{save,restore}() around sg_copy_{from,to}_buffer().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index 8d9bceeff986..6cd6f8a94a71 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -932,7 +932,6 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 	unsigned blocks, unsigned blksz, int write)
 {
 	int ret, i;
-	unsigned long flags;
 
 	if (write) {
 		for (i = 0; i < blocks * blksz; i++)
@@ -940,9 +939,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 	} else {
 		memset(test->scratch, 0, BUFFER_SIZE);
 	}
-	local_irq_save(flags);
 	sg_copy_from_buffer(sg, sg_len, test->scratch, BUFFER_SIZE);
-	local_irq_restore(flags);
 
 	ret = mmc_test_set_blksize(test, blksz);
 	if (ret)
@@ -987,9 +984,7 @@ static int mmc_test_transfer(struct mmc_test_card *test,
 				return RESULT_FAIL;
 		}
 	} else {
-		local_irq_save(flags);
 		sg_copy_to_buffer(sg, sg_len, test->scratch, BUFFER_SIZE);
-		local_irq_restore(flags);
 		for (i = 0; i < blocks * blksz; i++) {
 			if (test->scratch[i] != (u8)i)
 				return RESULT_FAIL;
-- 
2.25.1

