From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4 03/15] mmc: sd: add support for driver type selection
Date: Tue, 10 May 2011 23:34:51 -0400
Message-ID: <m3tyd152qs.fsf@pullcord.laptop.org>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-4-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38200 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134Ab1EKDcW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 May 2011 23:32:22 -0400
In-Reply-To: <1304578151-1775-4-git-send-email-arindam.nath@amd.com> (Arindam
	Nath's message of "Thu, 5 May 2011 12:18:59 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

Hi,

On Thu, May 05 2011, Arindam Nath wrote:
> This patch adds support for setting driver strength during UHS-I
> initialization prcedure. Since UHS-I cards set S18A (bit 24) in
> response to ACMD41, we use this as a base for UHS-I initialization.
> We modify the parameter list of mmc_sd_get_cid() so that we can
> save the ROCR from ACMD41 to check whether bit 24 is set.
>
> We decide whether the Host Controller supports A, C, or D driver
> type depending on the Capabilities register. Driver type B is
> suported by default. We then set the appropriate driver type for
> the card using CMD6 mode 1. As per Host Controller spec v3.00, we
> set driver type for the host only if Preset Value Enable in the
> Host Control2 register is not set. SDHCI_HOST_CONTROL has been
> renamed to SDHCI_HOST_CONTROL1 to conform to the spec.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Thanks, pushed to mmc-next for .40 with the trivial changes below:

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 96a3af5..5b7c998 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -540,8 +540,7 @@ struct device_type sd_type = {
 /*
  * Fetch CID from card.
  */
-int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
-	u32 *rocr)
+int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 {
 	int err;
 
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 5106b44..4b34b24 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -5,8 +5,7 @@
 
 extern struct device_type sd_type;
 
-int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
-	u32 *rocr);
+int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
 int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c4a6614..4d0c15b 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -369,9 +369,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		goto err;
 	}
 
-	if (ocr & R4_MEMORY_PRESENT
-	    && mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid,
-	    NULL) == 0) {
+	if ((ocr & R4_MEMORY_PRESENT) &&
+	    mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid, NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||


- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
