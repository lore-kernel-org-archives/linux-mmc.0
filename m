From: Loic Pallardy <loic.pallardy@stericsson.com>
Subject: [PATCH v1 4/5] mmc: core: Add mmc_set_blockcount feature
Date: Fri, 6 Jul 2012 10:44:03 +0200
Message-ID: <1341564244-6178-5-git-send-email-loic.pallardy@stericsson.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:38825 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751383Ab2GFJmH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jul 2012 05:42:07 -0400
In-Reply-To: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy@stericsson.com>, Alex Macro <alex.macro@stericsson.com>

Provide support for automatically sending Set Block Count
(CMD23) messages. Used at least for RPMB support.

Signed-off-by: Alex Macro <alex.macro@stericsson.com>
Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
---
 drivers/mmc/core/core.c  | 14 ++++++++++++++
 include/linux/mmc/core.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0b6141d..7990e2c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1827,6 +1827,20 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 }
 EXPORT_SYMBOL(mmc_set_blocklen);
 
+int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
+			bool is_rel_write)
+{
+	struct mmc_command cmd = {0};
+
+	cmd.opcode = MMC_SET_BLOCK_COUNT;
+	cmd.arg = blockcount & 0x0000FFFF;
+	if (is_rel_write)
+		cmd.arg |= 1 << 31;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
+	return mmc_wait_for_cmd(card->host, &cmd, 5);
+}
+EXPORT_SYMBOL(mmc_set_blockcount);
+
 static void mmc_hw_reset_for_init(struct mmc_host *host)
 {
 	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 1b431c7..098b7dd 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -166,6 +166,8 @@ extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned int from,
 extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
 
 extern int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen);
+extern int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
+			      bool is_rel_write);
 extern int mmc_hw_reset(struct mmc_host *host);
 extern int mmc_hw_reset_check(struct mmc_host *host);
 extern int mmc_can_reset(struct mmc_card *card);
-- 
1.7.11.1

