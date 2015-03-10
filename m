From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] mmc: sunxi: add MMC_CAP_SDIO_IRQ capability
Date: Tue, 10 Mar 2015 16:36:36 +0100
Message-ID: <1426001796-19231-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753564AbbCJPgu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Mar 2015 11:36:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

When the sunxi mmc-controller code was initially merged MMC_CAP_SDIO_IRQ was
not added to the host caps because of issues with some sdio wifi modules.

It turns out that these issues have nothing to do with using sdio-irq support,
they also happen with oob interrupts. Since the hardware supports sdio-irq
everywhere, and since the one reason to not claim the capability is gone,
add MMC_CAP_SDIO_IRQ to the default host caps.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index e8a4218..94eee54 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1028,7 +1028,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->f_min		=   400000;
 	mmc->f_max		= 50000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				  MMC_CAP_ERASE;
+				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.3.1

