From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] mmc: sdhci-iproc: suppress spurious interrupt with Multiblock read
Date: Thu, 18 May 2017 22:27:40 +0530
Message-ID: <1495126660-25044-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33794 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934072AbdERQ6B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 May 2017 12:58:01 -0400
Received: by mail-wr0-f179.google.com with SMTP id l9so40262049wre.1
        for <linux-mmc@vger.kernel.org>; Thu, 18 May 2017 09:58:00 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, rjui@broadcom.com, sbranden@broadcom.com, jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>

The stingray SDHCI hardware supports ACMD12 and automatically
issues after multi block transfer completed.

If ACMD12 in SDHCI is disabled, spurious tx done interrupts are seen
on multi block read command with below error message:

Got data interrupt 0x00000002 even though no data
operation was in progress.

This patch uses SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 to enable
ACM12 support in SDHCI hardware and suppress spurious interrupt.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 3275d49..61666d2 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -187,7 +187,8 @@ static const struct sdhci_iproc_data iproc_cygnus_data = {
 };
 
 static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
 	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
 	.ops = &sdhci_iproc_ops,
 };
-- 
2.7.4

