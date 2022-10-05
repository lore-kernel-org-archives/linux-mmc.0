Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF3BC4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 10:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJEKUk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 06:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJEKUj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 06:20:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9A75FD2
        for <linux-mmc@vger.kernel.org>; Wed,  5 Oct 2022 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664965239; x=1696501239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DBouPXkn19648vXl5QGVnrLRPK2p8QLNiXR5Fea/A5c=;
  b=JQozLggQHCpYhObA939S4aE3zlaY1ofRHZsdHuGLrId2qvDRm2kcd9n2
   mkcwC4WxOoOf3L9xmpA2c5KK7uwkF+4f2vKqODAF4Rr+iuAols/Khd1rR
   a2jFHbZtxoUrbK3CYNme55AHat+ye7ALqMnAstEoYPDBvPBPq6LRsGg7w
   7utDXwtCUDkZhueVH2LLezXB9Z+P6y7jLrd7grIhkOOpqgdV2AhEodRBl
   07mmcI8NYjv7nHG2+yFp2cNBUmhxpq0TJVtw7/07sInsljM1NO+x0Rseo
   +WdPzT7E3gxLI7SjmLG9voBVh/Yi+Iy7hYL6gHNVMsbOI5bSypqjrSdPJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="304110470"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="304110470"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:38 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="728606018"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="728606018"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.192])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 03:20:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Dubov <oakad@yahoo.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 12/14] mmc: tmio_mmc_core: Replace kmap_atomic() with kmap_local_page()
Date:   Wed,  5 Oct 2022 13:19:49 +0300
Message-Id: <20221005101951.3165-13-adrian.hunter@intel.com>
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
 drivers/mmc/host/tmio_mmc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 22375790b57b..e36ff80108e6 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -206,13 +206,13 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg)
 {
-	return kmap_atomic(sg_page(sg)) + sg->offset;
+	return kmap_local_page(sg_page(sg)) + sg->offset;
 }
 
 static inline void tmio_mmc_kunmap_atomic(struct scatterlist *sg,
 					  void *virt)
 {
-	kunmap_atomic(virt - sg->offset);
+	kunmap_local(virt - sg->offset);
 }
 
 #ifdef CONFIG_PM
-- 
2.25.1

