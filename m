From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2] mmc: core: add the warning message when card didn't support
 HPI
Date: Mon, 12 Mar 2012 08:57:27 +0900
Message-ID: <4F5D3BE7.3080601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43149 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab2CKX53 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Mar 2012 19:57:29 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0Q004UAVVLN2B0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 Mar 2012 08:57:27 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0Q00G3JVVRHU20@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 12 Mar 2012 08:57:27 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Though card didn't support HPI,someone could use the send_hpi_cmd().
Then maybe didn't work fine.
Because card->ext_csd.hpi_cmd didn't set.
So if card didn't support hpi, return the waring message.

And CMD12's flags is MMC_RSP_R1B.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Changelog v2:
	- Fixed typo and removed the flags variable.

 drivers/mmc/core/mmc_ops.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 4d41fa9..30f45be 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -553,18 +553,22 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
 {
 	struct mmc_command cmd = {0};
 	unsigned int opcode;
-	unsigned int flags;
 	int err;
 
+	if (!card->ext_csd.hpi) {
+		pr_warning("%s: Card didn't support HPI command\n",
+				mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
 	opcode = card->ext_csd.hpi_cmd;
 	if (opcode == MMC_STOP_TRANSMISSION)
-		flags = MMC_RSP_R1 | MMC_CMD_AC;
+		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
 	else if (opcode == MMC_SEND_STATUS)
-		flags = MMC_RSP_R1 | MMC_CMD_AC;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
 
 	cmd.opcode = opcode;
 	cmd.arg = card->rca << 16 | 1;
-	cmd.flags = flags;
 	cmd.cmd_timeout_ms = card->ext_csd.out_of_int_time;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, 0);
-- 
1.7.4.1
