From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] mmc: host: mxcmmc: Simplify a trivial if-return sequence
Date: Sat,  9 May 2015 18:44:50 -0300
Message-ID: <1431207891-21448-2-git-send-email-festevam@gmail.com>
References: <1431207891-21448-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36416 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbbEIVp1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 May 2015 17:45:27 -0400
Received: by qgeb100 with SMTP id b100so51969823qge.3
        for <linux-mmc@vger.kernel.org>; Sat, 09 May 2015 14:45:26 -0700 (PDT)
In-Reply-To: <1431207891-21448-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Simplify a trivial if-return sequence. Possibly combine with a
preceding function call.

The semantic patch that makes this change is available
in scripts/coccinelle/misc/simple_return.cocci.

More information about semantic patching is available at
http://coccinelle.lip6.fr/

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/mxcmmc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 317d709..d110f9e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -605,11 +605,7 @@ static int mxcmci_push(struct mxcmci_host *host, void *_buf, int bytes)
 		mxcmci_writel(host, cpu_to_le32(tmp), MMC_REG_BUFFER_ACCESS);
 	}
 
-	stat = mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
-	if (stat)
-		return stat;
-
-	return 0;
+	return mxcmci_poll_status(host, STATUS_BUF_WRITE_RDY);
 }
 
 static int mxcmci_transfer_data(struct mxcmci_host *host)
-- 
1.9.1

