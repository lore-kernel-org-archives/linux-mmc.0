From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 03/23] mmc: core: fix a comment typo
Date: Sat, 16 Apr 2016 01:29:27 +0800
Message-ID: <1460741387-23815-4-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0090.outbound.protection.outlook.com ([65.55.169.90]:24039
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752640AbcDORhY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 13:37:24 -0400
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, haibo.chen@nxp.com, dongas86@gmail.com

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 62355bd..d220bbd 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -553,7 +553,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 
 		/*
 		 * We are not allowed to issue a status command and the host
-		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
+		 * doesn't support MMC_CAP_WAIT_WHILE_BUSY, then we can only
 		 * rely on waiting for the stated timeout to be sufficient.
 		 */
 		if (!send_status) {
-- 
1.9.1

