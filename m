From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/2] mmc: core: fix error path in mmc_host_alloc
Date: Sat, 28 Jan 2017 09:32:50 +0100
Message-ID: <92cb6f74-a354-d4ab-6e40-1d985526e68f@gmail.com>
References: <dfed7598-7c82-c7d4-1f0b-3c5548adb377@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34228 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdA1Ie1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Jan 2017 03:34:27 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so63284110wmi.1
        for <linux-mmc@vger.kernel.org>; Sat, 28 Jan 2017 00:33:19 -0800 (PST)
In-Reply-To: <dfed7598-7c82-c7d4-1f0b-3c5548adb377@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Properly reverse everything if mmc_gpio_alloc(host) fails.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 0a26c8b6..19c68bf2 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -369,6 +369,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 
 	if (mmc_gpio_alloc(host)) {
 		put_device(&host->class_dev);
+		ida_simple_remove(&mmc_host_ida, host->index);
+		kfree(host);
 		return NULL;
 	}
 
-- 
2.11.0


