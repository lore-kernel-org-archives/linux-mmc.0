From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Write only 4 bit in case of TIMEOUT_CONTROL
Date: Tue, 16 Jul 2013 08:36:11 +0200
Message-ID: <1373956571-25967-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:26934 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab3GPGgV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2013 02:36:21 -0400
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 0D04FD8019D
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2013 08:36:20 +0200 (CEST)
Received: from localhost (vsgw1.fe.internet.bosch.com [10.4.98.15])
	by vsmta12.fe.internet.bosch.com (Postfix) with SMTP id D93D61B80721
	for <linux-mmc@vger.kernel.org>; Tue, 16 Jul 2013 08:36:19 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>

In case of SDHCI_TIMEOUT_CONTROL write only 4 bits and not the
whole byte to avoid touching other unrelated bits in the i.MX6
SYS_CTRL register. E.g. IPP_RST_N shouldn't be touched accidently.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1dd5ba8..1af3a2a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -362,6 +362,18 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
 
 		esdhc_clrset_le(host, mask, new_val, reg);
 		return;
+	case SDHCI_TIMEOUT_CONTROL:
+		/*
+		 * On i.MX6 the timeout value DTOCV is 4 bit large. Touch only
+		 * these 4 bits (lower nibble of the byte), but not the upper
+		 * nibble of the byte. The upper nibble of the byte contains
+		 * IPP_RST_N which should keep the reset value, i.e. 1, and
+		 * shouldn't be touched here.
+		 */
+		if (is_imx6q_usdhc(imx_data)) {
+			esdhc_clrset_le(host, 0x0f, val, reg);
+			return;
+		}
 	}
 	esdhc_clrset_le(host, 0xff, val, reg);
 
-- 
1.8.2

