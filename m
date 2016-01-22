From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: [PATCH 2/2 v2] mmc/sdhci-acpi: enable sdhci-acpi device to
 suspend/resume asynchronously
Date: Fri, 22 Jan 2016 12:35:26 +0800
Message-ID: <56A1B18E.4000108@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37442 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbcAVEfq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Jan 2016 23:35:46 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, michele.curti@gmail.com, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel@vger.kernel.org

This patch enables sdhci-acpi devices to suspend/resume asynchronously.
This will improve system suspend/resume speed. After enabling the
sdhci-acpi devices and all their child devices to suspend/resume
asynchronously on ASUS T100TA, the system suspend-to-idle time is
reduced from 1645ms to 1089ms, and the system resume time is reduced
from 940ms to 908ms.

Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
---
Changes in v2:
- Update commit message

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

