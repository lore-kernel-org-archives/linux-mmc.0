From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH v3] mmc/sdhci-acpi: enable sdhci-acpi device to suspend/resume
 asynchronously
Date: Mon, 16 Nov 2015 14:23:00 +0800
Message-ID: <56497644.9080903@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3123 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbbKPGXE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 16 Nov 2015 01:23:04 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, yunpeng.gao@intel.com, andriy.shevchenko@linux.intel.com, peter.griffin@linaro.org
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Now, PM core supports asynchronous suspend/resume mode for devices
during system suspend/resume, and the power state transition of one
device may be completed in separate kernel thread. PM core ensures
all power state transition timing dependency between devices. This
patch enables sdhci-acpi device to suspend/resume asynchronously.
This will take advantage of multicore and improve system
suspend/resume speed. After enabling the sdhci-acpi devices and all
their child devices to suspend/resume asynchronously on ASUS T100TA,
the system suspend-to-idle time is reduced from 1645ms to 1096ms, and
the system resume time is reduced from 940ms to 908ms.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
Changes in v3:
- Add test result in commit message

 drivers/mmc/host/sdhci-acpi.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f6047fc..3d27f2d 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -388,6 +388,8 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
+	device_enable_async_suspend(dev);
+
 	return 0;
 
 err_free:
-- 1.7.1

