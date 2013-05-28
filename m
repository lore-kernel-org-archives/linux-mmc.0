From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] mmc: sdhci-acpi: fix error return code in sdhci_acpi_add_own_cd()
Date: Tue, 28 May 2013 13:26:25 +0800
Message-ID: <CAPgLHd_FWg3egTZxBena+BTgWdZCzqr9AjV1_NpWBGYD3aPz0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f53.google.com ([209.85.214.53]:64514 "EHLO
	mail-bk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab3E1F00 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 May 2013 01:26:26 -0400
Received: by mail-bk0-f53.google.com with SMTP id mx1so3929629bkb.40
        for <linux-mmc@vger.kernel.org>; Mon, 27 May 2013 22:26:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, adrian.hunter@intel.com, rafael.j.wysocki@intel.com, jg1.han@samsung.com, sonic.zhang@analog.com
Cc: yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return a negative error code in the gpio_to_irq() error
handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/mmc/host/sdhci-acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index a51e603..08a85ec 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -189,8 +189,10 @@ static int sdhci_acpi_add_own_cd(struct device *dev, int gpio,
 		goto out;
 
 	irq = gpio_to_irq(gpio);
-	if (irq < 0)
+	if (irq < 0) {
+		err = irq;
 		goto out_free;
+	}
 
 	flags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 	err = devm_request_irq(dev, irq, sdhci_acpi_sd_cd, flags, "sd_cd", mmc);

