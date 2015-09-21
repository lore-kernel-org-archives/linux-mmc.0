From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH v2] mmc: enable mmc host device to suspend/resume asynchronously
Date: Mon, 21 Sep 2015 14:13:13 +0800
Message-ID: <55FF9FF9.5080601@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55325 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755746AbbIUGNU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Sep 2015 02:13:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linus.walleij@linaro.org, Markus.Niebel@tq-group.com, lars@metafoo.de, s.hauer@pengutronix.de, kristina.martsenko@gmail.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition timing dependency between devices. This
patch enables mmc host device to suspend/resume asynchronously. This
will take advantage of multicore and improve system suspend/resume
speed.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
Changes in v2:
- Amend commit message.

 drivers/mmc/core/host.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index abd933b..8dfc011 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -577,6 +577,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.parent = dev;
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
+	device_enable_async_suspend(&host->class_dev);
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
-- 1.7.1

