From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 3/3] sdhci-pltfm: Do not print errors in case of an
 extended iomem size
Date: Tue, 16 Mar 2010 21:34:30 +0300
Message-ID: <20100316183430.GC25670@oksana.dev.rtsoft.ru>
References: <20100316183400.GA24191@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100316183400.GA24191@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Vrabel <david.vrabel@csr.com>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>, Pierre Ossman <pierre@ossman.eu>, Ben Dooks <ben@simtec.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Some hosts have an extended SDHCI iomem size, so the driver should
only print errors if the iomem size is less than 0x100.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 217b911..b6ee0d7 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -61,7 +61,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (resource_size(iomem) != 0x100)
+	if (resource_size(iomem) < 0x100)
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");
 
-- 
1.7.0
