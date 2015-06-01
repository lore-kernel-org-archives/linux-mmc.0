From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Attach PM domain prior probing of SDIO func driver
Date: Mon,  1 Jun 2015 12:18:25 +0200
Message-ID: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36707 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbFAKSs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Jun 2015 06:18:48 -0400
Received: by laei3 with SMTP id i3so9906651lae.3
        for <linux-mmc@vger.kernel.org>; Mon, 01 Jun 2015 03:18:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>

Other subsystem buses attach PM domains during probe, but prior calling
the driver's ->probe() method. During the removal phase, detaching the PM
domain will be done after invoking the driver's ->remove() callback.

Convert the SDIO bus to follow this behavior and add error handling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

A similar patch as $subject patch has been posted and discussed earlier.

According to Aaron Lu, who added the initial support for the ACPI PM domain to
the SDIO bus, this change is safe.
http://www.spinics.net/lists/linux-mmc/msg28946.html

---
 drivers/mmc/core/sdio_bus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index bee02e6..7e327a6 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -137,6 +137,10 @@ static int sdio_bus_probe(struct device *dev)
 	if (!id)
 		return -ENODEV;
 
+	ret = dev_pm_domain_attach(dev, false);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+
 	/* Unbound SDIO functions are always suspended.
 	 * During probe, the function is set active and the usage count
 	 * is incremented.  If the driver supports runtime PM,
@@ -166,6 +170,7 @@ static int sdio_bus_probe(struct device *dev)
 disable_runtimepm:
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
+	dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -197,6 +202,8 @@ static int sdio_bus_remove(struct device *dev)
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
 
+	dev_pm_domain_detach(dev, false);
+
 	return ret;
 }
 
@@ -316,10 +323,8 @@ int sdio_add_func(struct sdio_func *func)
 	sdio_set_of_node(func);
 	sdio_acpi_set_handle(func);
 	ret = device_add(&func->dev);
-	if (ret == 0) {
+	if (ret == 0)
 		sdio_func_set_present(func);
-		dev_pm_domain_attach(&func->dev, false);
-	}
 
 	return ret;
 }
@@ -335,7 +340,6 @@ void sdio_remove_func(struct sdio_func *func)
 	if (!sdio_func_present(func))
 		return;
 
-	dev_pm_domain_detach(&func->dev, false);
 	device_del(&func->dev);
 	of_node_put(func->dev.of_node);
 	put_device(&func->dev);
-- 
1.9.1

