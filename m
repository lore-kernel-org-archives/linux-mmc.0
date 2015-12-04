From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] mmc: enable MMC/SD/SDIO device to suspend/resume
 asynchronously
Date: Fri, 4 Dec 2015 21:05:56 +0800
Message-ID: <56618FB4.3020100@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13494 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbbLDNF7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Dec 2015 08:05:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, hdegoede@redhat.com, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, s.hauer@pengutronix.de, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition dependency between devices. This patch
enables MMC/SD/SDIO card and SDIO function devices to suspend/resume
asynchronously. This will take advantage of multicore and improve
system suspend/resume speed. After applying this patch and enabling
all SDIO function's child devices to suspend/resume asynchronously
on ASUS T100TA, the system suspend-to-idle time is reduced from
1645ms to 1108ms, and the system resume time is reduced from 940ms
to 918ms.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 drivers/mmc/core/bus.c      |    2 ++
 drivers/mmc/core/sdio_bus.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 972ff84..4bc48f1 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -349,6 +349,8 @@ int mmc_add_card(struct mmc_card *card)
 
 	card->dev.of_node = mmc_of_find_child_device(card->host, 0);
 
+	device_enable_async_suspend(&card->dev);
+
 	ret = device_add(&card->dev);
 	if (ret)
 		return ret;
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 7e327a6..86f5b32 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -322,6 +322,7 @@ int sdio_add_func(struct sdio_func *func)
 
 	sdio_set_of_node(func);
 	sdio_acpi_set_handle(func);
+	device_enable_async_suspend(&func->dev);
 	ret = device_add(&func->dev);
 	if (ret == 0)
 		sdio_func_set_present(func);
-- 1.7.1

