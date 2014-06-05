From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] mmc: mvsdio: avoid compiler warning
Date: Thu,  5 Jun 2014 23:14:39 +0200
Message-ID: <1402002881-1986640-3-git-send-email-arnd@arndb.de>
References: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:64278 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaFEVPF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jun 2014 17:15:05 -0400
In-Reply-To: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>

gcc correctly points out that hw_state can be used uninitially
in the mvsd_setup_data() function. This rearranges the function
to ensure it always contains a proper value.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <chris@printf.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/mvsdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 9377284..6b4c5ad 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -79,11 +79,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		unsigned long t = jiffies + HZ;
 		unsigned int hw_state,  count = 0;
 		do {
+			hw_state = mvsd_read(MVSD_HW_STATE);
 			if (time_after(jiffies, t)) {
 				dev_warn(host->dev, "FIFO_EMPTY bit missing\n");
 				break;
 			}
-			hw_state = mvsd_read(MVSD_HW_STATE);
 			count++;
 		} while (!(hw_state & (1 << 13)));
 		dev_dbg(host->dev, "*** wait for FIFO_EMPTY bit "
-- 
1.8.3.2

