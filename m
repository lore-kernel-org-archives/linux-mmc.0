From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH 1/2] mmc: enable mmc host device to suspend/resume
 asynchronously
Date: Mon, 28 Dec 2015 23:39:19 +0800
Message-ID: <568157A7.8030607@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40830 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbbL1PjX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Dec 2015 10:39:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, chaotian.jing@mediatek.com, lars@metafoo.de, vbyravarasu@nvidia.com, sergei.shtylyov@cogentembedded.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition dependency between devices. This patch
enables mmc hosts to suspend/resume asynchronously. This will take
advantage of multicore and improve system suspend/resume speed.
After applying this patch and enabling all mmc hosts' child devices
to suspend/resume asynchronously on ASUS T100TA, the system
suspend-to-idle time is reduced from 1645ms to 1107ms, and the
system resume time is reduced from 940ms to 914ms.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 drivers/mmc/core/host.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index da950c4..7222fd7 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -339,6 +339,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	host->class_dev.parent = dev;
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
+	device_enable_async_suspend(&host->class_dev);
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
-- 1.7.1

