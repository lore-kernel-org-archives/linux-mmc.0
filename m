From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: mmci: rename some extended flags
Date: Sat,  8 Feb 2014 21:13:28 +0100
Message-ID: <1391890408-10321-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50519 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbaBHUNe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Feb 2014 15:13:34 -0500
Received: by mail-wi0-f178.google.com with SMTP id cc10so1767637wib.5
        for <linux-mmc@vger.kernel.org>; Sat, 08 Feb 2014 12:13:33 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

These four (so far unused) flags are only found in the ST Micro
versions of MMCI, so infix them properly with the _ST_ infix.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 168bc72f7a94..84c0e59b792a 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -38,10 +38,11 @@
 #define MCI_CPSM_INTERRUPT	(1 << 8)
 #define MCI_CPSM_PENDING	(1 << 9)
 #define MCI_CPSM_ENABLE		(1 << 10)
-#define MCI_SDIO_SUSP		(1 << 11)
-#define MCI_ENCMD_COMPL		(1 << 12)
-#define MCI_NIEN		(1 << 13)
-#define MCI_CE_ATACMD		(1 << 14)
+/* Argument flag extenstions in the ST Micro versions */
+#define MCI_ST_SDIO_SUSP	(1 << 11)
+#define MCI_ST_ENCMD_COMPL	(1 << 12)
+#define MCI_ST_NIEN		(1 << 13)
+#define MCI_ST_CE_ATACMD	(1 << 14)
 
 #define MMCIRESPCMD		0x010
 #define MMCIRESPONSE0		0x014
-- 
1.8.5.3

