From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 1/2] mmc: core: Fix use of uninitialized data in mmc_send_if_cond.
Date: Wed, 13 Apr 2011 16:32:09 -0400
Message-ID: <1302726730-17324-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:56362 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758515Ab1DMU1k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 16:27:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

mmc_send_if_cond did not zero out mmc_command on stack.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/sd_ops.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 71fdb07..da50849 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -201,6 +201,8 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
 	static const u8 test_pattern = 0xAA;
 	u8 result_pattern;
 
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
 	/*
 	 * To support SD 2.0 cards, we must always invoke SD_SEND_IF_COND
 	 * before SD_APP_OP_COND. This command will harmlessly fail for
-- 
1.7.0.1

