From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add ocr_mask option
Date: Mon, 12 Sep 2016 10:15:05 -0400
Message-ID: <20160912141507.6837-2-chris.brandt@renesas.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:27055 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754160AbcILOVD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Sep 2016 10:21:03 -0400
In-Reply-To: <20160912141507.6837-1-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>

In moving platforms from board files to DT, there still needs to be a way
to set the ocr_mask setting for the tmio driver during probe. Without this
setting, the probe will fail because the supported voltages are not known.

This patch will also traditional platform registration platforms to
migrate to DT.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 5334f24..b033500 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -59,6 +59,7 @@ enum tmio_mmc_dmac_type {
 
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
+	u32	      tmio_ocr_mask;
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
@@ -630,6 +631,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
 
 		mmc_data->flags |= of_data->tmio_flags;
+		mmc_data->ocr_mask = of_data->tmio_ocr_mask;
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
-- 
2.9.2


