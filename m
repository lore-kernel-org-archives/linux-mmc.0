From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v7 1/5] mmc: davinci: allow driver to work without DMA resource
Date: Thu, 28 Mar 2013 18:40:07 +0530
Message-ID: <1364476211-14322-2-git-send-email-prakash.pm@ti.com>
References: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1364476211-14322-1-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, arnd@arndb.de, "Manjunathappa, Prakash" <prakash.pm@ti.com>
List-Id: linux-mmc@vger.kernel.org

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

