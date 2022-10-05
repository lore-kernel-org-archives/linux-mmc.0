Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8573AC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJEKUn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJEKUm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FBF75FCA
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965241; x=1696501241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRbhPhG0W1B4mhSRGBLSoQqNQatbwceuvJPOUVg7haw=;
  b=OiZoa/QSIKLcVFJUkweKgmQgN5RBdjVJa6HHXwHqM90hlv1bVCOhkvr5
   vrXJpr+V40TS4Raab/IozoA1yuwHuaV7S9qnXOF8yeSiggeG7Ac3kLXag
   fP/Za53sRPDq8UVfzBtgeqpQBNZ8AA/Aq8+PB/AzpbcfRNolyw4FcM/bk
   FPxhkuGCtoB94Pp6q1/2svNQcssYIy4E7jGN7X3wMm+Ou7jdB8X6xfDFT
   ClP+1SyTfWJCr5iozwmynWnl14/zQJP4c3Vg3e8razvehqx4zeS9OxWBJ
   DcQJFCLsZazoArWv+7xhd4vXCESbK4mF4xxM1TaamtJmcpiTfq/T4yXs4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110474"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110474"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728606021"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728606021"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 13/14] mmc: au1xmmc: Replace kmap_atomic() with kmap_local_page()
Date:   Wed,  5 Oct 2022 13:19:50 +0300
Message-Id: <20221005101951.3165-14-adrian.hunter@intel.com>
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
 drivers/mmc/host/au1xmmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index c88b039dc9fb..82dd0ae40305 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -388,7 +388,7 @@ static void au1xmmc_send_pio(struct au1xmmc_host *host)
 
 	/* This is the pointer to the data buffer */
 	sg = &data->sg[host->pio.index];
-	sg_ptr = kmap_atomic(sg_page(sg)) + sg->offset + host->pio.offset;
+	sg_ptr = kmap_local_page(sg_page(sg)) + sg->offset + host->pio.offset;
 
 	/* This is the space left inside the buffer */
 	sg_len = data->sg[host->pio.index].length - host->pio.offset;
@@ -409,7 +409,7 @@ static void au1xmmc_send_pio(struct au1xmmc_host *host)
 		__raw_writel((unsigned long)val, HOST_TXPORT(host));
 		wmb(); /* drain writebuffer */
 	}
-	kunmap_atomic(sg_ptr);
+	kunmap_local(sg_ptr);
 
 	host->pio.len -= count;
 	host->pio.offset += count;
@@ -446,7 +446,7 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 
 	if (host->pio.index < host->dma.len) {
 		sg = &data->sg[host->pio.index];
-		sg_ptr = kmap_atomic(sg_page(sg)) + sg->offset + host->pio.offset;
+		sg_ptr = kmap_local_page(sg_page(sg)) + sg->offset + host->pio.offset;
 
 		/* This is the space left inside the buffer */
 		sg_len = sg_dma_len(&data->sg[host->pio.index]) - host->pio.offset;
@@ -488,7 +488,7 @@ static void au1xmmc_receive_pio(struct au1xmmc_host *host)
 			sg_ptr[count] = (unsigned char)(val & 0xFF);
 	}
 	if (sg_ptr)
-		kunmap_atomic(sg_ptr);
+		kunmap_local(sg_ptr);
 
 	host->pio.len -= count;
 	host->pio.offset += count;
-- 
2.25.1

