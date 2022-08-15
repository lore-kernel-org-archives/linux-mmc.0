Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92762C25B0E
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 07:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240876AbiHOHdi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 03:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHOHdh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 03:33:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7FF183AD
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660548817; x=1692084817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1AK1S1BOIw9Q6ZTrhHzTTh8pHFE1UB2y0y7l7SC8mWI=;
  b=XX/v7rSac+DOLjHQSKv3DqTFpc3WFrlg9X9eEd7AApWo2SXS8WChEJHF
   OqeuX+dsyl3ZAA9wSv3k2wjikqZ6z+wB4sl0d6CjOMw+zPCTZ9uVYB0CZ
   7nRiRPaInoN2iLgGaj6Eh9Nz+9bXoCkhhg3MLA5wKDr60xUeL91YCet21
   Bs1+HOo0YsfyYdNjq5iayMhwgt8mWHA2rDfYHg5e9yw77Nz2WZG93f/qj
   lS3jtfJk0bpUc7vYjIUDKRvV9VVI6NzDOQNN1dolvMOhOGxdWCtgpRW1k
   LQcYLLoQ/FlwcdqFRdowvGm33I2BaDQ59fl4OqPNwI6oZf+SE5FyDU7PH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290663301"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="290663301"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:33:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="603108074"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 00:33:35 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Seunghui Lee <sh043.lee@samsung.com>,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Subject: [PATCH 1/2] mmc: sd: Fix 1.8V workaround branch
Date:   Mon, 15 Aug 2022 10:33:20 +0300
Message-Id: <20220815073321.63382-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815073321.63382-1-adrian.hunter@intel.com>
References: <20220815073321.63382-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When introduced, upon success, the 1.8V fixup workaround in
mmc_sd_init_card() would branch to practically the end of the function,
to a label named "done". Unfortunately, perhaps due to the label name,
over time new code has been added that really should have come after
"done" not before it. Move the label to the correct place and rename it
"cont".

Fixes: 045d705dc1fb ("mmc: core: Enable the MMC host software queue for the SD card")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cee4c0b59f43..bc84d7dfc8e1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1498,7 +1498,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 					mmc_remove_card(card);
 				goto retry;
 			}
-			goto done;
+			goto cont;
 		}
 	}
 
@@ -1534,7 +1534,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
 		}
 	}
-
+cont:
 	if (!oldcard) {
 		/* Read/parse the extension registers. */
 		err = sd_read_ext_regs(card);
@@ -1566,7 +1566,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		err = -EINVAL;
 		goto free_card;
 	}
-done:
+
 	host->card = card;
 	return 0;
 
-- 
2.25.1

