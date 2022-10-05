Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D0C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJEKUp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJEKUo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472B75FC7
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965243; x=1696501243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=onzIt5MASyC6xh3XxFH9+6TRAHiS1pGAm15jvZpeKQk=;
  b=UN6s9sEADO42j888fLQ7wqteLSC+o/Ev08op8shEKL6f4baeMMfjyVOF
   UeYnRlZslmB1dBYH+CvsiuZc1GG9tB5XYJ2oOprANZ0h5N/csWVhFc0lF
   0fENeiLikPFQPsJrLKMJIy0m6YoSkeuEUlUxJdRW09acbxHYQHD6VmhcV
   E7KfkUn1UluZLA9fJKWNYz2471Fnd+Mb6zOK0nfMwAxq9vdYCdxHc0ivO
   /mOjcB+bGoZNnqW3QAWFhSMFURSk9oFXvi/rMqk8VKz0IrMPBrj+G+P7u
   PudyND/IhT7RPgFFwF8GYL4596RjNM2xO0aC0coObz41xZhKciPgsf970
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110479"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110479"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728606027"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728606027"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 14/14] mmc: wbsd: Replace kmap_atomic() with kmap_local_page()
Date:   Wed,  5 Oct 2022 13:19:51 +0300
Message-Id: <20221005101951.3165-15-adrian.hunter@intel.com>
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
 drivers/mmc/host/wbsd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 67ecd342fe5f..2219144c166a 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -267,7 +267,7 @@ static inline int wbsd_next_sg(struct wbsd_host *host)
 
 static inline char *wbsd_map_sg(struct wbsd_host *host)
 {
-	return kmap_atomic(sg_page(host->cur_sg)) + host->cur_sg->offset;
+	return kmap_local_page(sg_page(host->cur_sg)) + host->cur_sg->offset;
 }
 
 static inline void wbsd_sg_to_dma(struct wbsd_host *host, struct mmc_data *data)
@@ -439,7 +439,7 @@ static void wbsd_empty_fifo(struct wbsd_host *host)
 			 * End of scatter list entry?
 			 */
 			if (host->remain == 0) {
-				kunmap_atomic(buffer);
+				kunmap_local(buffer);
 				/*
 				 * Get next entry. Check if last.
 				 */
@@ -451,7 +451,7 @@ static void wbsd_empty_fifo(struct wbsd_host *host)
 			}
 		}
 	}
-	kunmap_atomic(buffer);
+	kunmap_local(buffer);
 
 	/*
 	 * This is a very dirty hack to solve a
@@ -505,7 +505,7 @@ static void wbsd_fill_fifo(struct wbsd_host *host)
 			 * End of scatter list entry?
 			 */
 			if (host->remain == 0) {
-				kunmap_atomic(buffer);
+				kunmap_local(buffer);
 				/*
 				 * Get next entry. Check if last.
 				 */
@@ -517,7 +517,7 @@ static void wbsd_fill_fifo(struct wbsd_host *host)
 			}
 		}
 	}
-	kunmap_atomic(buffer);
+	kunmap_local(buffer);
 
 	/*
 	 * The controller stops sending interrupts for
-- 
2.25.1

