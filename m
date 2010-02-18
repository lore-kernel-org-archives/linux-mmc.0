From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: support SDIO cards
Date: Thu, 18 Feb 2010 08:57:48 +0200
Message-ID: <4B7CE4EC.5090403@compulab.co.il>
References: <cover.1265801967.git.david.vrabel@csr.com> <4B73BFD3.8090106@compulab.co.il> <4B73E59F.3020400@csr.com> <4B73ED3C.9010107@compulab.co.il> <4B73F418.6070804@csr.com> <4B73F8B0.100@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:55822 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab0BRG7C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Feb 2010 01:59:02 -0500
In-Reply-To: <4B73F8B0.100@compulab.co.il>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, Mike Rapoport <mike@compulab.co.il>

Mike Rapoport wrote:
> David Vrabel wrote:
>> Mike Rapoport wrote:
>>> I've started to apply the patches one by one and after the first patch
>>> is applied, the SD card works Ok, but libertas fails to initialize with
>>> the following messages:
>>>
>>>> modprobe libertas_sdio
>>> [   82.233489] lib80211: common routines for IEEE802.11 drivers
>>> [   82.833251] cfg80211: Calling CRDA to update world regulatory domain
>>> [   83.327911] libertas_sdio: Libertas SDIO driver
>>> [   83.332489] libertas_sdio: Copyright Pierre Ossman
>>> [   83.348510] libertas_sdio mmc1:0001:1: firmware: requesting
>>> sd8686_helper.bin
>>> [   83.497619] libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
>>> [   83.679229] DMA synchronization event drop occurred with device 47
>> What block size are you using?  It looks like you're using something
>> less than 512. I've checked the spec again and the DMA packet size
>> should be the block size in words (and not the FIFO depth).
> 
> It's quite possible. I haven't dig too much and I really don't know how exactly
> libertas driver sends/receives the data... I'll continue testing and will try to get
> some more meaningful info
> 
>> Also, keep in mind that the buffers for transfers must begin and end on
>> a word boundary.  The OMAP's DMA controller can only transfer whole
>> words to the MMC FIFO.

I've slightly modified your patch "mmc: omap_hsmmc: use packet sync'd DMA" and it
seems to work now, at least with SD card and libertas_sdio:

---
 drivers/mmc/host/omap_hsmmc.c |   23 ++++++++---------------
 1 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4b23225..5408bcb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -114,6 +114,7 @@

 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
+#define OMAP_HSMMC_FIFO_WORDS	(512/4)
 #define DRIVER_NAME		"mmci-omap-hs"

 /* Timeouts for entering power saving states on inactivity, msec */
@@ -884,24 +885,24 @@ static void omap_hsmmc_config_dma_params(struct omap_hsmmc_host *host,
 {
 	int blksz, nblk, dma_ch;

+	blksz = host->data->blksz;
+	nblk = sg_dma_len(sgl) / blksz;
+
 	dma_ch = host->dma_ch;
 	if (data->flags & MMC_DATA_WRITE) {
 		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
+			(host->mapbase + OMAP_HSMMC_DATA), 0, blksz / 4);
 		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
 			sg_dma_address(sgl), 0, 0);
 	} else {
 		omap_set_dma_src_params(dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			(host->mapbase + OMAP_HSMMC_DATA), 0, 0);
+			(host->mapbase + OMAP_HSMMC_DATA), 0, blksz / 4);
 		omap_set_dma_dest_params(dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
 			sg_dma_address(sgl), 0, 0);
 	}

-	blksz = host->data->blksz;
-	nblk = sg_dma_len(sgl) / blksz;
-
 	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
-			blksz / 4, nblk, OMAP_DMA_SYNC_FRAME,
+			blksz / 4, nblk, OMAP_DMA_SYNC_PACKET,
 			omap_hsmmc_get_dma_sync_dev(host, data),
 			!(data->flags & MMC_DATA_WRITE));

@@ -944,17 +945,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *data)
 static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
-	int dma_ch = 0, ret = 0, err = 1, i;
+	int dma_ch = 0, ret = 0, err = 1;
 	struct mmc_data *data = req->data;

-	/* Sanity check: all the SG entries must be aligned by block size. */
-	for (i = 0; i < data->sg_len; i++) {
-		struct scatterlist *sgl;
-
-		sgl = data->sg + i;
-		if (sgl->length % data->blksz)
-			return -EINVAL;
-	}
 	if ((data->blksz % 4) != 0)
 		/* REVISIT: The MMC buffer increments only when MSB is written.
 		 * Return error for blksz which is non multiple of four.
-- 
1.6.4.4



>> David
> 
> 


-- 
Sincerely yours,
Mike.


