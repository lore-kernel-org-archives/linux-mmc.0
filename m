From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH] S3C64xx: remove SDHCI_QUIRK_NO_MULTIBLOCK
Date: Wed, 25 Nov 2009 17:08:35 +0100
Message-ID: <b2e8f9f70911250808v36704b4qc5a1cb3ff08cca8a@mail.gmail.com>
References: <b2e8f9f70911200404pca38ab6ycdca740ce81a6847@mail.gmail.com>
	<b2e8f9f70911250755iabbc8a2hd5a0ecec076b13dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54383 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbZKYQIu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2009 11:08:50 -0500
Received: by bwz27 with SMTP id 27so7048568bwz.21
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2009 08:08:55 -0800 (PST)
In-Reply-To: <b2e8f9f70911250755iabbc8a2hd5a0ecec076b13dd@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Sorry, previous version didn't pass checkpatch.pl; here's an updated one.

Regards,
Maurus Cuelenaere



This fixes SDIO as that requires multiblock transfers. This patch depends on the
following patches:

[PATCH] sdhci: Add new quirk in sdhci driver and update ADMA descriptor build.
[PATCH] S3C: sdhci: Enable ADMA feature in S3C sdhci controller.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 drivers/mmc/host/sdhci-s3c.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 0f8ff86..4623876 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -324,9 +324,6 @@ static int __devinit sdhci_s3c_probe(struct
platform_device *pdev)
        * support as well. */
       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;

-       /* PIO currently has problems with multi-block IO */
-       host->quirks |= SDHCI_QUIRK_NO_MULTIBLOCK;
-
 #endif /* CONFIG_MMC_SDHCI_S3C_DMA */

       /* It seems we do not get an DATA transfer complete on non-busy
--
1.6.5.3
