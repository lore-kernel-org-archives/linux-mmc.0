From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v6 1/5] mmc: davinci: allow driver to work without DMA resource
Date: Wed, 20 Mar 2013 17:14:08 +0530
Message-ID: <1363779852-24083-2-git-send-email-prakash.pm@ti.com>
References: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59515 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab3CTLoT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Mar 2013 07:44:19 -0400
In-Reply-To: <1363779852-24083-1-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Do not return probe failure with missing DMA resources,
allow driver to work in PIO mode.
Tested on da850-evm by mounting partition followed by
file creation and deletion.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Tested-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/davinci_mmc.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index f5d46ea..bd848d3 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1191,13 +1191,15 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
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

