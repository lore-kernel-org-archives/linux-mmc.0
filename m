From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: [PATCH] SDHCI: Enable multiblock transfers in sdhci-s3c
Date: Sun, 11 Apr 2010 17:22:47 +0200
Message-ID: <v2qb2e8f9f71004110822l83c55548rbd4dc0279dd3e369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57486 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab0DKPXI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Apr 2010 11:23:08 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so24381bwz.21
        for <linux-mmc@vger.kernel.org>; Sun, 11 Apr 2010 08:23:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, sdhci-devel@lists.ossman.eu
Cc: Ben Dooks <ben-linux@fluff.org>

Wifi over SDIO doesn't correctly work without multiblock, so enable
this. This patch depends on the following patch:

[PATCH] S3C: sdhci: Enable ADMA feature in S3C sdhci controller.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2136794..2c1a618 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -330,9 +330,6 @@ static int __devinit sdhci_s3c_probe(struct
platform_device *pdev)
 	 * support as well. */
 	host->quirks |= SDHCI_QUIRK_BROKEN_DMA;

-	/* PIO currently has problems with multi-block IO */
-	host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
-
 #endif /* CONFIG_MMC_SDHCI_S3C_DMA */

 	/* It seems we do not get an DATA transfer complete on non-busy
-- 
1.7.0.4
