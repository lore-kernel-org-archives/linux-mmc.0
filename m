From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 05/12] mmc: core: Handle card shutdown from mmc_bus
Date: Mon, 10 Jun 2013 17:03:40 +0200
Message-ID: <1370876627-13439-6-git-send-email-ulf.hansson@stericsson.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:33224 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753604Ab3FJPEU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:20 -0400
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Considering shutdown of the card, the responsibility to initate this
sequence shall be driven from the mmc_bus.

This patch enables the mmc_bus to handle this sequence properly. A new
.shutdown callback is added in the mmc_driver struct which is used to
shutdown the blk device.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/card/block.c    |   15 +++++++++++++--
 drivers/mmc/card/mmc_test.c |    5 +++++
 drivers/mmc/core/bus.c      |    9 +++++++++
 include/linux/mmc/card.h    |    1 +
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c900d28..d91507f 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2400,8 +2400,7 @@ static void mmc_blk_remove(struct mmc_card *card)
 	mmc_set_drvdata(card, NULL);
 }
 
-#ifdef CONFIG_PM
-static int mmc_blk_suspend(struct mmc_card *card)
+static int _mmc_blk_suspend(struct mmc_card *card)
 {
 	struct mmc_blk_data *part_md;
 	struct mmc_blk_data *md = mmc_get_drvdata(card);
@@ -2416,6 +2415,17 @@ static int mmc_blk_suspend(struct mmc_card *card)
 	return 0;
 }
 
+static void mmc_blk_shutdown(struct mmc_card *card)
+{
+	_mmc_blk_suspend(card);
+}
+
+#ifdef CONFIG_PM
+static int mmc_blk_suspend(struct mmc_card *card)
+{
+	return _mmc_blk_suspend(card);
+}
+
 static int mmc_blk_resume(struct mmc_card *card)
 {
 	struct mmc_blk_data *part_md;
@@ -2448,6 +2458,7 @@ static struct mmc_driver mmc_driver = {
 	.remove		= mmc_blk_remove,
 	.suspend	= mmc_blk_suspend,
 	.resume		= mmc_blk_resume,
+	.shutdown	= mmc_blk_shutdown,
 };
 
 static int __init mmc_blk_init(void)
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 759714e..a69df52 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -3025,12 +3025,17 @@ static void mmc_test_remove(struct mmc_card *card)
 	mmc_test_free_dbgfs_file(card);
 }
 
+static void mmc_test_shutdown(struct mmc_card *card)
+{
+}
+
 static struct mmc_driver mmc_driver = {
 	.drv		= {
 		.name	= "mmc_test",
 	},
 	.probe		= mmc_test_probe,
 	.remove		= mmc_test_remove,
+	.shutdown	= mmc_test_shutdown,
 };
 
 static int __init mmc_test_init(void)
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 3b7ca8a..219bf4b 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -122,6 +122,14 @@ static int mmc_bus_remove(struct device *dev)
 	return 0;
 }
 
+static void mmc_bus_shutdown(struct device *dev)
+{
+	struct mmc_driver *drv = to_mmc_driver(dev->driver);
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	drv->shutdown(card);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int mmc_bus_suspend(struct device *dev)
 {
@@ -205,6 +213,7 @@ static struct bus_type mmc_bus_type = {
 	.uevent		= mmc_bus_uevent,
 	.probe		= mmc_bus_probe,
 	.remove		= mmc_bus_remove,
+	.shutdown	= mmc_bus_shutdown,
 	.pm		= &mmc_bus_pm_ops,
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6a98f32..842de3e 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -520,6 +520,7 @@ struct mmc_driver {
 	void (*remove)(struct mmc_card *);
 	int (*suspend)(struct mmc_card *);
 	int (*resume)(struct mmc_card *);
+	void (*shutdown)(struct mmc_card *);
 };
 
 extern int mmc_register_driver(struct mmc_driver *);
-- 
1.7.10

