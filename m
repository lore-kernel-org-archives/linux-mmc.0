From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH 04/12] mmci: allow the card detect status not to be inverted
Date: Tue, 22 Jun 2010 14:47:39 +0530
Message-ID: <1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:33511 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759038Ab0FVJSi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jun 2010 05:18:38 -0400
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, Rabin Vincent <rabin.vincent@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

On some platforms, the GPIO value from the gpio_cd pin doesn't need to
be inverted to get it active high.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c   |    2 +-
 include/linux/amba/mmci.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 65f0e12..7e56726 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -538,7 +538,7 @@ static int mmci_get_cd(struct mmc_host *mmc)
 	else
 		status = gpio_get_value(host->gpio_cd);
 
-	return !status;
+	return !status ^ host->plat->cd_noinvert;
 }
 
 static const struct mmc_host_ops mmci_ops = {
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 7e466fe..f9d1bb5 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -23,6 +23,7 @@
  * whether a card is present in the MMC slot or not
  * @gpio_wp: read this GPIO pin to see if the card is write protected
  * @gpio_cd: read this GPIO pin to detect card insertion
+ * @cd_noinvert: true if the gpio_cd pin value or status are active high
  * @capabilities: the capabilities of the block as implemented in
  * this platform, signify anything MMC_CAP_* from mmc/host.h
  */
@@ -33,6 +34,7 @@ struct mmci_platform_data {
 	unsigned int (*status)(struct device *);
 	int	gpio_wp;
 	int	gpio_cd;
+	bool	cd_noinvert;
 	unsigned long capabilities;
 };
 
-- 
1.7.0

