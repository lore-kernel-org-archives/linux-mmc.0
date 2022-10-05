Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF1DC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJEKUg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJEKUf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979E75CE0
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965234; x=1696501234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7+PqZ32NVQdfGHU7azcHYiK2qm51Rx1ValQ6YoVHNkU=;
  b=QotegSY2T09SoLAWV0bqY0JSQPBak9gIwQO6EKAE54BcCaDPLBmhd3uJ
   LRHLpKudN+qVZM47wcXMOfL//jLnvJnEeTyXBgwe4atFaFbBNpCUWrYjD
   ELx9/J2BH5v2TIcT6uxTAFxF1zpJdfDdh6OO/MCTmKEg21Vv7yc9hd7wi
   Xsy55sClyTJeLtw47O9mNE2KClTrNsUECNbX3Lzzi39G1DX7nWwG58875
   ErArkALE1GQIP4b1hFR2SjxV6/+9ulIIJ/dQufXr03YHgR3z6o1KN8ar8
   0L9sXVpS25LppkPujbdKGe1JMNL1HMu2WO2Td4yQi9GBGk22gDOvhvFk4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110456"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110456"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605993"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605993"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 10/14] mmc: tifm_sd: Replace kmap_atomic() with kmap_local_page()
Date:   Wed,  5 Oct 2022 13:19:47 +0300
Message-Id: <20221005101951.3165-11-adrian.hunter@intel.com>
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
 drivers/mmc/host/tifm_sd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index d539f9b48422..b5a2f2f25ad9 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -116,7 +116,7 @@ static void tifm_sd_read_fifo(struct tifm_sd *host, struct page *pg,
 	unsigned char *buf;
 	unsigned int pos = 0, val;
 
-	buf = kmap_atomic(pg) + off;
+	buf = kmap_local_page(pg) + off;
 	if (host->cmd_flags & DATA_CARRY) {
 		buf[pos++] = host->bounce_buf_data[0];
 		host->cmd_flags &= ~DATA_CARRY;
@@ -132,7 +132,7 @@ static void tifm_sd_read_fifo(struct tifm_sd *host, struct page *pg,
 		}
 		buf[pos++] = (val >> 8) & 0xff;
 	}
-	kunmap_atomic(buf - off);
+	kunmap_local(buf - off);
 }
 
 static void tifm_sd_write_fifo(struct tifm_sd *host, struct page *pg,
@@ -142,7 +142,7 @@ static void tifm_sd_write_fifo(struct tifm_sd *host, struct page *pg,
 	unsigned char *buf;
 	unsigned int pos = 0, val;
 
-	buf = kmap_atomic(pg) + off;
+	buf = kmap_local_page(pg) + off;
 	if (host->cmd_flags & DATA_CARRY) {
 		val = host->bounce_buf_data[0] | ((buf[pos++] << 8) & 0xff00);
 		writel(val, sock->addr + SOCK_MMCSD_DATA);
@@ -159,7 +159,7 @@ static void tifm_sd_write_fifo(struct tifm_sd *host, struct page *pg,
 		val |= (buf[pos++] << 8) & 0xff00;
 		writel(val, sock->addr + SOCK_MMCSD_DATA);
 	}
-	kunmap_atomic(buf - off);
+	kunmap_local(buf - off);
 }
 
 static void tifm_sd_transfer_data(struct tifm_sd *host)
@@ -210,13 +210,13 @@ static void tifm_sd_copy_page(struct page *dst, unsigned int dst_off,
 			      struct page *src, unsigned int src_off,
 			      unsigned int count)
 {
-	unsigned char *src_buf = kmap_atomic(src) + src_off;
-	unsigned char *dst_buf = kmap_atomic(dst) + dst_off;
+	unsigned char *src_buf = kmap_local_page(src) + src_off;
+	unsigned char *dst_buf = kmap_local_page(dst) + dst_off;
 
 	memcpy(dst_buf, src_buf, count);
 
-	kunmap_atomic(dst_buf - dst_off);
-	kunmap_atomic(src_buf - src_off);
+	kunmap_local(dst_buf - dst_off);
+	kunmap_local(src_buf - src_off);
 }
 
 static void tifm_sd_bounce_block(struct tifm_sd *host, struct mmc_data *r_data)
-- 
2.25.1

