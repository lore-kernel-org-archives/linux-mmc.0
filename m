From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: core: Silence compiler warning in __mmc_switch
Date: Mon, 28 Oct 2013 19:46:09 +0100
Message-ID: <1382985970-14583-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:65024 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757298Ab3J1SqP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Oct 2013 14:46:15 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so4115286obc.30
        for <linux-mmc@vger.kernel.org>; Mon, 28 Oct 2013 11:46:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aae8d8b..e5b5eeb 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -414,7 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	int err;
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
-	u32 status;
+	u32 status = 0;
 	bool ignore_crc = false;
 
 	BUG_ON(!card);
-- 
1.7.9.5

