From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/5] mmc: meson-gx: switch irq name to DT node name
Date: Wed, 15 Mar 2017 20:33:43 +0100
Message-ID: <d83833e9-8900-a108-faa9-8b6d58349651@gmail.com>
References: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33872 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdCOTe6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2017 15:34:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so6329873wmg.1
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2017 12:34:56 -0700 (PDT)
In-Reply-To: <f1f8dae2-e976-4d42-99dc-34d08cb3d628@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

So far it wasn't easy to check which interrupt belongs to which SD/eMMC
port (e.g. in /proc/interrupts) because the driver name was used as
description for all ports. Change this to the default which is the
device name (DT node name).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 62597638..f2d4486a 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -758,7 +758,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, meson_mmc_irq,
 					meson_mmc_irq_thread, IRQF_SHARED,
-					DRIVER_NAME, host);
+					NULL, host);
 	if (ret)
 		goto err_div_clk;
 
-- 
2.12.0


