Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3340DC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 11:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180C3613CE
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 11:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbhI2LTi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:19:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:9145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245664AbhI2LTi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 29 Sep 2021 07:19:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="204405388"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="204405388"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 04:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="479227112"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 29 Sep 2021 04:17:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D73B03DA; Wed, 29 Sep 2021 14:18:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 2/2] mmc: slot-gpio: Update default label when no con_id provided
Date:   Wed, 29 Sep 2021 14:17:57 +0300
Message-Id: <20210929111757.52625-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210929111757.52625-1-andriy.shevchenko@linux.intel.com>
References: <20210929111757.52625-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Currently default label of GPIO is assigned to the device name,
when no con_id provided. Instead, let's update it to reflect
what it's about (use already prepared template).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mmc/core/slot-gpio.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index e365d328f43c..dd2a4b6ab6ad 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -178,6 +178,10 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
+	/* Update default label if no con_id provided */
+	if (!con_id)
+		gpiod_set_consumer_name(desc, ctx->cd_label);
+
 	if (debounce) {
 		ret = gpiod_set_debounce(desc, debounce);
 		if (ret < 0)
@@ -226,6 +230,10 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 	if (IS_ERR(desc))
 		return PTR_ERR(desc);
 
+	/* Update default label if no con_id provided */
+	if (!con_id)
+		gpiod_set_consumer_name(desc, ctx->ro_label);
+
 	if (debounce) {
 		ret = gpiod_set_debounce(desc, debounce);
 		if (ret < 0)
-- 
2.33.0

