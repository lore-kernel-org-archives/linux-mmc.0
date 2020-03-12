Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8176CC2BB1D
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6060520650
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCLOYz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:24:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:32517 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLOYy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Mar 2020 10:24:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="266348024"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.167])
  by fmsmga004.fm.intel.com with ESMTP; 12 Mar 2020 07:24:52 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Seo@vger.kernel.org, Kyungmin <kyungmin.seo@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Subject: [PATCH RFC 1/3] mmc: core: Try harder if transfer mode switch fails
Date:   Thu, 12 Mar 2020 16:24:03 +0200
Message-Id: <20200312142405.9813-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312142405.9813-1-adrian.hunter@intel.com>
References: <20200312142405.9813-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add extra busy wait and retries if transfer mode switch fails.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc_ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aa0cab190cd8..619088a94688 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -599,6 +599,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		cmd.sanitize_busy = true;
 
 	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	if (err && index == EXT_CSD_HS_TIMING) {
+		/* Try harder for timing changes */
+		__mmc_poll_for_busy(card, timeout_ms, send_status,
+				    retry_crc_err, MMC_BUSY_CMD6);
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+	}
 	if (err)
 		goto out;
 
-- 
2.17.1

