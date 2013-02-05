From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v2] mmc: davinci: allow driver to work without DMA resource
Date: Tue, 5 Feb 2013 17:52:24 +0530
Message-ID: <1360066944-14265-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36985 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab3BEMVb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Feb 2013 07:21:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, mporter@ti.com, ido@wizery.com, gregkh@linuxfoundation.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Do not return probe failure with missing DMA resources,
allow driver to work in PIO mode.
Tested on da850-evm by mounting partition followed by
file creation and deletion.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Since v1:
Specified missing DMA resource(RX/TX).

 drivers/mmc/host/davinci_mmc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 2063677..27123f8 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1190,13 +1190,15 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!r)
-		goto out;
-	host->rxdma = r->start;
+		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
+	else
+		host->rxdma = r->start;
 
 	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
 	if (!r)
-		goto out;
-	host->txdma = r->start;
+		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
+	else
+		host->txdma = r->start;
 
 	host->mem_res = mem;
 	host->base = ioremap(mem->start, mem_size);
-- 
1.7.4.1

