From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: [PATCH] mmc: Export host capabilities to debugfs.
Date: Mon, 5 Mar 2018 19:08:44 +0530
Message-ID: <1520257124-27647-1-git-send-email-harish_kandiga@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, avri.altman@wdc.com, andriy.shevchenko@linux.intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, harish_kandiga@mentor.com, Vladimir_Zapolskiy@mentor.com
List-Id: linux-mmc@vger.kernel.org

From: Abbas Raza <Abbas_Raza@mentor.com>

This patch exports the host capabilities to debugfs

Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
[Harish: Added caps2, moved creation to mmc_add_host_debugfs]
Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
---

Changes in v4:
- Moved the creation of nodes to mmc_add_host_debugfs
- Exported caps2
- Renamed host_caps to caps

Changes in v3:
- Removed typecasting of &host->caps to (u32 *)

Changes in v2:
- Changed Author

 drivers/mmc/core/debugfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index c51e0c0..d2275c5 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -243,6 +243,12 @@ void mmc_add_host_debugfs(struct mmc_host *host)
 	if (!debugfs_create_file("ios", S_IRUSR, root, host, &mmc_ios_fops))
 		goto err_node;

+	if (!debugfs_create_x32("caps", S_IRUSR, root, &host->caps))
+		goto err_node;
+
+	if (!debugfs_create_x32("caps2", S_IRUSR, root, &host->caps2))
+		goto err_node;
+
 	if (!debugfs_create_file("clock", S_IRUSR | S_IWUSR, root, host,
 			&mmc_clock_fops))
 		goto err_node;
--
1.9.1
