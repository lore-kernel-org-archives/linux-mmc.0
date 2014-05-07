From: Nick Sanders <nsanders@chromium.org>
Subject: [PATCH] mmc: sdhci: remove mdelay in eMMC tuning
Date: Tue,  6 May 2014 18:52:38 -0700
Message-ID: <1399427558-8478-1-git-send-email-nsanders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41002 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaEGBxO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 May 2014 21:53:14 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so322564pdi.21
        for <linux-mmc@vger.kernel.org>; Tue, 06 May 2014 18:53:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, Doug Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chang-Eun Choi-SSI <cu.choi@ssi.samsung.com>, Nick Sanders <nsanders@chromium.org>

This patch removes an unneccesary 1ms mdelay in the HS200 tuning
loop, called 40 times per retuning. Currently this causes a latency
of >40ms on any emmc accesses triggering wake from runtime PM,
which can occur for a significant portion of reads on a mostly idle system.

The delay is left in place for SD Cards, which use
MMC_SEND_TUNING_BLOCK rather than MMC_SEND_TUNING_BLOCK_HS200.
I'm not able to find evidence that this is required for SD in the
specs I have access to, however this delay has been present from
initial checkin for SD so I have preserved the original behavior for
compatibility.

This has been verified to fix observed glitching on local audio
playback and recording on apps with inbuilt assumptions on storage
latency.

Signed-off-by: Nick Sanders <nsanders@chromium.org>
Reviewed-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index df6d85a..05ffac2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1987,7 +1987,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
 		timeout--;
-		mdelay(1);
+
+		/* eMMC spec does not require a delay between tuning cycles */
+		if (opcode == MMC_SEND_TUNING_BLOCK)
+			mdelay(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
 	/*
-- 
1.9.1.423.g4596e3a

