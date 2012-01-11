From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] mmc: core: UHS sdio card that fails should not exceed 50MHz
Date: Tue, 10 Jan 2012 20:51:05 -0800
Message-ID: <AFCF9DBF-558E-460A-899E-1B34E09A45C2@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:58618 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756739Ab2AKEvL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Jan 2012 23:51:11 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Aaron Lu <Aaron.Lu@amd.com>, Bing Zhao <bzhao@marvell.com>

A UHS sdio card that fails initialization at 1.8v signaling
is not in UHS mode.  We cannot use the speed in the the cis
to reflect the bus speed as this is the maxiumum value and
will not reflect the fact that the host is operating at a
lower (non uhs) bus speed.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
Reviewed-by: Aaron Lu <Aaron.Lu@amd.com>
---
drivers/mmc/core/sdio.c |    7 ++++---
1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b77f770..8b626ad 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -97,10 +97,11 @@ fail:
	return ret;
}

-static int sdio_read_cccr(struct mmc_card *card)
+static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
{
	int ret;
	int cccr_vsn;
+	int uhs = ocr & R4_18V_PRESENT;
	unsigned char data;
	unsigned char speed;

@@ -148,7 +149,7 @@ static int sdio_read_cccr(struct mmc_card *card)
		card->scr.sda_spec3 = 0;
		card->sw_caps.sd3_bus_mode = 0;
		card->sw_caps.sd3_drv_type = 0;
-		if (cccr_vsn >= SDIO_CCCR_REV_3_00) {
+		if (cccr_vsn >= SDIO_CCCR_REV_3_00 && uhs) {
			card->scr.sda_spec3 = 1;
			ret = mmc_io_rw_direct(card, 0, 0,
				SDIO_CCCR_UHS, 0, &data);
@@ -710,7 +711,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
	/*
	 * Read the common registers.
	 */
-	err = sdio_read_cccr(card);
+	err = sdio_read_cccr(card, ocr);
	if (err)
		goto remove;

-- 
1.7.7.3

