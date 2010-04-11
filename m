From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH 1/2] [RESEND] s3c6410: Add new quirk in sdhci driver and
	update ADMA descriptor build.
Date: Sun, 11 Apr 2010 17:22:43 +0200
Message-ID: <l2kb2e8f9f71004110822te95806d0ycc0a6a7d80a4af7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57486 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab0DKPXE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Apr 2010 11:23:04 -0400
Received: by bwz19 with SMTP id 19so24381bwz.21
        for <linux-mmc@vger.kernel.org>; Sun, 11 Apr 2010 08:23:03 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, sdhci-devel@lists.ossman.eu
Cc: Thomas Abraham <thomas.ab@samsung.com>, Ben Dooks <ben-linux@fluff.org>, kgene.kim@samsung.com

The s3c6410 sdhci controller does not support the 'End' attribute and
NOP attribute in the same 8-Byte ADMA descriptor. This patch adds a
new quirk to identify sdhci host contollers with such behaviour.
In addition to this, for controllers using the new quirk, the last
entry in the ADMA descritor table is marked with the 'End' attribute
(instead of using a NOP descriptor with 'End' attribute).

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/mmc/host/sdhci.c |   20 +++++++++++++++-----
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9d4fdfa..db5d566 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -496,12 +496,22 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
 		WARN_ON((desc - host->adma_desc) > (128 * 2 + 1) * 4);
 	}

-	/*
-	 * Add a terminating entry.
-	 */
+	if (host->quirks & SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC) {
+		/*
+		* Mark the last descriptor as the terminating descriptor
+		*/
+		if (desc != host->adma_desc) {
+			desc -= 8;
+			desc[0] |= 0x2; /* end */
+		}
+	} else {
+		/*
+		* Add a terminating entry.
+		*/

-	/* nop, end, valid */
-	sdhci_set_adma_desc(desc, 0, 0, 0x3);
+		/* nop, end, valid */
+		sdhci_set_adma_desc(desc, 0, 0, 0x3);
+	}

 	/*
 	 * Resync align buffer as we might have changed it.
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..7ba0006 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -236,6 +236,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
 #define SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK		(1<<24)
+/* Controller cannot support End Attribute in NOP ADMA descriptor */
+#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC		(1<<25)

 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
-- 
1.7.0.4
