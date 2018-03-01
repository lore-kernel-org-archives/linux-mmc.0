From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: [PATCH] mmc: Export host capabilities to debugfs.
Date: Thu, 1 Mar 2018 18:47:35 +0530
Message-ID: <1519910255-6296-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, avri.altman@wdc.com, andriy.shevchenko@linux.intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, harish_kandiga@mentor.com
List-Id: linux-mmc@vger.kernel.org

This patch exports the host capabilities to debugfs

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---
 drivers/mmc/core/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c51e0c0..fa2df7f 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
 
 	card->debugfs_root = root;
 
+	if (!debugfs_create_x32("host_caps", S_IRUSR, root, (u32 *)&host->caps))
+		goto err;
+
 	if (!debugfs_create_x32("state", S_IRUSR, root, &card->state))
 		goto err;
 
-- 
1.9.1
