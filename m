From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH] mmc: enable mmc host device to suspend/resume asynchronously
Date: Mon, 03 Aug 2015 20:39:17 +0800
Message-ID: <55BF60F5.8040602@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27546 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753214AbbHCMjV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Aug 2015 08:39:21 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linus.walleij@linaro.org, Markus.Niebel@tq-group.com, lars@metafoo.de, s.hauer@pengutronix.de, kristina.martsenko@gmail.com
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Enable mmc host device to suspend/resume asynchronously.
This can improve system suspend/resume speed.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
 drivers/mmc/core/host.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 99a9c90..85f2bbb 100644
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

