Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9D3E732FD
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 18:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI1SIx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjI1SIx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 14:08:53 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42CA1A2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Sep 2023 11:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695924531; x=1727460531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JcmaiUcVzqtGVrTqzLZmaxFPuVordCCMac9mHZbA36k=;
  b=LpN37Kx+j8Ltu87ZG9FkqNWmuoJoxcZ6Xom3RxRg8mLiKT9OriEp3Kym
   asWZyo7hI0BVMl2+KTG6iXkINURoG+K44uX9YPKy4tzDxY12FiCfmoFJx
   BwwRXwAiSV3rRnRN7vVsvJoz+4+MX5ixQt3XGgC10J2vEn/lM9MrWl81e
   o/CLSLCdgZNkZptMKwWcM0nrNNJHScmC5ig8XVB5LVOTjwUpE2LTWvsa5
   IFyMhbxrqMy44tkNUPIE5NWQYLYuu7Ylvs+YINw1RaPJUtaxEpDckRYC8
   /iFLtfpxJ0q2i+HQixIfm27f6pqzXAMCzcLezE7g4akvbl+rpdbPaWRkh
   w==;
X-CSE-ConnectionGUID: ztYB3QZPQcib+twBFK8YOg==
X-CSE-MsgGUID: EbjhCJ2xTWqFcrEpTxzmXg==
X-IronPort-AV: E=Sophos;i="6.03,184,1694707200"; 
   d="scan'208";a="249714727"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2023 02:08:51 +0800
IronPort-SDR: jdxO5nbyKOixiLSODIhvBiq1PwpVwb+eeGNnSE6QSmIdct3ugEdplxsMNE0RFPcRzovWSpqujg
 f4wMihmQTbxqus6dDmzid5KJ6EZwWU4Wzfih6IBUmIUmTqU6kf0Pc+ZhYXtpTx0xSAbbCBxeAF
 JE27m5GsWgiVPvB7O/zxDaoF0chhE+gJoaPBeptfjqd4dV6GFetxmVog8T/Y7kMY8LtPoLmGdY
 290fJnmbsbCtto1246+eLOL1/bnmbapeQ3BTMXg7aeKoYSCcSw16S3nh1sVBDX+AwMP5zOVQ8u
 FAk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2023 10:21:17 -0700
IronPort-SDR: IU1Np/Qbq7+lCsj0BaY2o+rBgt6Z0K/n7wG9wNcacFYQ1/0fwoZl8QmCmhoLMc0hO18/rqnZRn
 lDdcvPFgUZMFwPIICtyC2AlRObr/MXGiLq9E4g4GZft+BOO5LYsVIODv1fcfQ53xq/invRPSpv
 QXND1ErfTz87UNZBwE+VOiNPY5fY5lriGiMJDzxz6qQqiizdqWuehqh199g0Zbsl+pXbGV6mff
 rPzuWxGIplgZLn+9aaLifOYDypzI+d7X1wV4FyujKjsAOvmjUoY6sGXrju4N4MgoS9+7Cwl5pn
 azw=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2023 11:08:50 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Avri Altman <avri.altman@wdc.com>,
        wanggang26 <wanggang26@xiaomi.com>
Subject: [PATCH v3 4/4] mmc-utils: lsmmc: Fix emmc capacity calculation
Date:   Thu, 28 Sep 2023 21:06:58 +0300
Message-Id: <20230928180658.1795491-5-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928180658.1795491-1-avri.altman@wdc.com>
References: <20230928180658.1795491-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When the device capacity is larger than 2GB, it shouldn't use c_size but
instead it follows a different calculation using the SEC_COUNT field of
the ext-csd[215:212] - see eMMC spec JESD84-B51 paragraph 7.3.12.

This bug was already in lsmmc when it got merged into mmc-utils, hence
the fixes tag.

Fixes: 4af1749d2350 (mmc-utils: Merge the lsmmc tool into mmc-utils)
Signed-off-by: wanggang26 <wanggang26@xiaomi.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lsmmc.c b/lsmmc.c
index c984d9a..9596722 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -1826,6 +1826,9 @@ static void print_mmc_csd_capacity(unsigned int c_size, unsigned int c_size_mult
 	int block_len = 1 << read_bl_len;
 	unsigned long long memory_capacity;
 
+	if (c_size == 0xfff)
+		return;
+
 	printf("\tC_SIZE: 0x%03x\n", c_size);
 	printf("\tC_SIZE_MULT: 0x%01x\n", c_size_mult);
 
-- 
2.42.0

