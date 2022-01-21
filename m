Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE52FC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Jan 2022 20:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiAUUii (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:38:38 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:35522 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiAUUih (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jan 2022 15:38:37 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 4DFBD2061795
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] mmc: renesas_sdhi_sys_dmac: use DMA_SLAVE_BUSWIDTH_UNDEFINED
Organization: Open Mobile Platform
Message-ID: <5e22c587-5698-e132-4429-48674a6ddbb7@omp.ru>
Date:   Fri, 21 Jan 2022 23:38:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The 'dma_slave_config::{src|dst}_addr_width' fields have the *enum* type
which isn't isomorphic with the *bool* type, however is used as a boolean
expression. Use the *enum* dma_slave_buswidth's value corresponding to 0
instead.

Found by Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch is against the 'next' branch of Ulf Hansson's 'mmc.git' repo.

drivers/mmc/host/renesas_sdhi_sys_dmac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: mmc/drivers/mmc/host/renesas_sdhi_sys_dmac.c
===================================================================
--- mmc.orig/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ mmc/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -370,7 +370,7 @@ static void renesas_sdhi_sys_dmac_reques
 		cfg.dst_addr = res->start +
 			(CTL_SD_DATA_PORT << host->bus_shift);
 		cfg.dst_addr_width = priv->dma_priv.dma_buswidth;
-		if (!cfg.dst_addr_width)
+		if (cfg.dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
 			cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.src_addr = 0;
 		ret = dmaengine_slave_config(host->chan_tx, &cfg);
@@ -389,7 +389,7 @@ static void renesas_sdhi_sys_dmac_reques
 		cfg.direction = DMA_DEV_TO_MEM;
 		cfg.src_addr = cfg.dst_addr + host->pdata->dma_rx_offset;
 		cfg.src_addr_width = priv->dma_priv.dma_buswidth;
-		if (!cfg.src_addr_width)
+		if (cfg.src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
 			cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		cfg.dst_addr = 0;
 		ret = dmaengine_slave_config(host->chan_rx, &cfg);
