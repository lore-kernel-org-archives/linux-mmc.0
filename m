Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33ADC433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJEKUV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJEKUT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CC73902
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965218; x=1696501218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUs+qYdCmXUrQman2MZrT8uLyoAo4la1YqjYh5vGoY4=;
  b=F3wBl1exW2a07GRkQ2rfQWM+kBfJCxr6FQuIf5t2na37edXtameHaQzN
   d0X3uUZ1oJXrkAQIPWlEMk5MnwoDYHR0bk9AMiyQf/vDNm5mCyjpJQnvD
   ni1yirk3F4VZNgXILl02Dy9zX4uerDy3WmV04pkuViUfiYlTHmDCrAvFp
   dBSIhfryq9JMLfcmJCYUAuqaK6OJykM1GUBN0oHph/jdq0DRmcjowjlyC
   ptsRMUDBL4YJ/FebxwRkcEYPpfTBhD3vAil6/BRJllWxiefIJXJc6X6ps
   2bRPbxd5wO2XloAYo0N9muDmpToyKO/ONf3T9NyWE7Sruuh8DqhSraghT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110416"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110416"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728605916"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728605916"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 03/14] mmc: sdhci: Replace kmap_atomic() with kmap_local_page()
Date:   Wed,  5 Oct 2022 13:19:40 +0300
Message-Id: <20221005101951.3165-4-adrian.hunter@intel.com>
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
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 31d87ec7d055..fb6e9a81f198 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -697,12 +697,12 @@ static int sdhci_pre_dma_transfer(struct sdhci_host *host,
 
 static char *sdhci_kmap_atomic(struct scatterlist *sg)
 {
-	return kmap_atomic(sg_page(sg)) + sg->offset;
+	return kmap_local_page(sg_page(sg)) + sg->offset;
 }
 
 static void sdhci_kunmap_atomic(void *buffer)
 {
-	kunmap_atomic(buffer);
+	kunmap_local(buffer);
 }
 
 void sdhci_adma_write_desc(struct sdhci_host *host, void **desc,
-- 
2.25.1

