From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Cleanup unused OF nodes while parsing for child nodes
Date: Mon, 30 Mar 2015 11:19:01 +0200
Message-ID: <1427707141-3152-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:36731 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbC3JTI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 05:19:08 -0400
Received: by wgra20 with SMTP id a20so165907379wgr.3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 02:19:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c296bc0..e6b0bdb 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1291,6 +1291,8 @@ struct device_node *mmc_of_find_child_device(struct mmc_host *host,
 	for_each_child_of_node(host->parent->of_node, node) {
 		if (mmc_of_get_func_num(node) == func_num)
 			return node;
+		else
+			of_node_put(node);
 	}
 
 	return NULL;
-- 
1.9.1

