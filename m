From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 5/6] mmc: wbsd: remove CONFIG_MMC_DEBUG from the driver
Date: Wed, 19 Jul 2017 15:55:48 +0800
Message-ID: <1500450949-206953-4-git-send-email-shawn.lin@rock-chips.com>
References: <1500450661-158463-1-git-send-email-shawn.lin@rock-chips.com>
 <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:37105 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752951AbdGSH5P (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Jul 2017 03:57:15 -0400
In-Reply-To: <1500450949-206953-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

wbsd only use this to print some unsupported command.
However the pr_warn should be enough for dynamic log
control and CONFIG_MMC_DEBUG seems bogus here. Remove it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/wbsd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 9668616..546aaf8 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -802,10 +802,8 @@ static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			break;
 
 		default:
-#ifdef CONFIG_MMC_DEBUG
 			pr_warn("%s: Data command %d is not supported by this controller\n",
 				mmc_hostname(host->mmc), cmd->opcode);
-#endif
 			cmd->error = -EINVAL;
 
 			goto done;
-- 
1.9.1


