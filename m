From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: [PATCH] mmc: add ifdef around fault_create_debugfs_attr()
Date: Fri,  6 Nov 2015 13:15:36 +0100
Message-ID: <1446812136-31526-1-git-send-email-adrien+dev@schischi.me>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34767 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161220AbbKFMQR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 07:16:17 -0500
Received: by wikq8 with SMTP id q8so29088733wik.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2015 04:16:15 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, linus.walleij@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Adrien Schildknecht <adrien+dev@schischi.me>

FAIL_MMC_REQUEST can be used without FAULT_INJECTION_DEBUG_FS.
In this case fault_create_debugfs_attr() will always return an error and
lead to the deletion of the whole debugfs directory.

This patch makes sure that FAULT_INJECTION_DEBUG_FS is enabled before
attempting to create the debugfs atttribute.

Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
---
 drivers/mmc/core/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 154aced..13e842c 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -259,11 +259,13 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	if (fail_request)
 		setup_fault_attr(&fail_default_attr, fail_request);
 	host->fail_mmc_request = fail_default_attr;
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 	if (IS_ERR(fault_create_debugfs_attr("fail_mmc_request",
 					     root,
 					     &host->fail_mmc_request)))
 		goto err_node;
 #endif
+#endif
 	return;
 
 err_node:
-- 
2.6.2

