From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: cd-gpio: allow NULL context in mmc_cd_gpio_free()
Date: Tue, 24 Apr 2012 17:56:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204241746530.21239@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49917 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab2DXP4c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 11:56:32 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Do not Oops, even if mmc_cd_gpio_free() is mistakenly called on a
driver-cleanup path, even though a previous call to mmc_cd_gpio_request()
failed.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Chris

Unfortunately, as I submitted the final version of the original cd-gpio 
patch http://article.gmane.org/gmane.linux.kernel.mmc/12013 I forgot, that 
I'd already sent a v2 and hadn't incremented the version to v3. And that 
version contained the below fix, that went lost because of the wrong 
version number. So, please, push this incremental fix for 3.4, because 
otherwise some error-paths of the tmio-mmc driver can Oops.

 drivers/mmc/core/cd-gpio.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/cd-gpio.c b/drivers/mmc/core/cd-gpio.c
index 29de31e..56b854d 100644
--- a/drivers/mmc/core/cd-gpio.c
+++ b/drivers/mmc/core/cd-gpio.c
@@ -72,6 +72,9 @@ void mmc_cd_gpio_free(struct mmc_host *host)
 {
 	struct mmc_cd_gpio *cd = host->hotplug.handler_priv;
 
+	if (!cd)
+		return;
+
 	free_irq(host->hotplug.irq, host);
 	gpio_free(cd->gpio);
 	kfree(cd);
-- 
1.7.2.5

