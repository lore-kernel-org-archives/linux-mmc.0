From: Angelo Dureghello <angelo@sysam.it>
Subject: Fwd: [PATCH] mmc: davinci_mmc: add warnings for edma failures
Date: Thu, 27 Nov 2014 10:50:22 +0100
Message-ID: <5476F3DE.4040300@sysam.it>
References: <546FD21C.7010208@sysam.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sysam.it ([5.39.81.93]:38027 "EHLO mail.sysam.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbaK0JvM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Nov 2014 04:51:12 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sysam.it (Postfix) with ESMTP id 163BB416ED
	for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 10:52:03 +0100 (CET)
Received: from mail.sysam.it ([127.0.0.1])
	by localhost (sysam.it [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJBG5t-qXcmE for <linux-mmc@vger.kernel.org>;
	Thu, 27 Nov 2014 10:51:17 +0100 (CET)
In-Reply-To: <546FD21C.7010208@sysam.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dear all,

would like some feedback / comment to this patch.

Even a NACK is good if you find it nonsense or un-useful, just
to close the loop.

Regards
angelo


-------- Original Message --------
Message-ID: <546FD21C.7010208@sysam.it>
Date: Sat, 22 Nov 2014 01:00:28 +0100
From: Angelo Dureghello <angelo@sysam.it>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 
Icedove/24.5.0
MIME-Version: 1.0
To: linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: davinci_mmc: add warnings for edma failures
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add warnings in case the edma engine driver fails to allocate slots or
channels requested from the davinci_mmc driver.

Some ti-davinci based boards (i.e. board-da850-evm.c) are asking for
some reserved chans / slots at board init stage. Later, the mmc driver
results in a silent locked state.

Signed-off-by: Angelo Dureghello <angelo <at> sysam.it>

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 5d4c5e0..65d4990 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -439,8 +439,8 @@ static int mmc_davinci_send_dma_request(struct
mmc_davinci_host *host,
                                 DMA_MEM_TO_DEV,
                                 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
                 if (!desc) {
-                       dev_dbg(mmc_dev(host->mmc),
-                               "failed to allocate DMA TX descriptor");
+                       WARN(1, KERN_WARNING
+                               "failed to allocate DMA TX descriptor\n");
                         ret = -1;
                         goto out;
                 }
@@ -461,8 +461,8 @@ static int mmc_davinci_send_dma_request(struct
mmc_davinci_host *host,
                                 DMA_DEV_TO_MEM,
                                 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
                 if (!desc) {
-                       dev_dbg(mmc_dev(host->mmc),
-                               "failed to allocate DMA RX descriptor");
+                       WARN(1, KERN_WARNING
+                               "failed to allocate DMA RX descriptor\n");
                         ret = -1;
                         goto out;
                 }



