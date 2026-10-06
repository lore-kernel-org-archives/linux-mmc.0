Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE445563B
	for <linux-mmc@vger.kernel.org>; Tue,  6 Oct 2026 13:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791292746; cv=none; b=loI+2XXTrTiC8spzuFDc1xFB8PMdriIVbNfofle7afdghliIIXz7ot5tjajRyBneql8ZZMN7YVgOivB9ssCWM/MW8bRhxBdNBPH/O7jdkWMjNx5ltwkZfwfpDL+lnWcAv+otQxiYfSP4Ec0myp3lyBkPT28fUfYXmAVZpdBJYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791292746; c=relaxed/simple;
	bh=DRIrSbkbtrBkartjFVq+RFV2/jC6XURTKQFkUBIVp7w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=o0fJLFCM66K+tPkv2G/Q99vxVE86vJ6BThzcBsfp4moTLpt5uhpnMNvngSE4B+itE9yLw3d4EpvwXCrVyOLdFcKITBfLbnF3w+FND/9V5xxQUIZhca6kE1h7apbq5sarxxRD0k5BSh+5Xc/U0bCPrPYzmi9UgUbFSRITNngShPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AjqrfXhZ; arc=none smtp.client-ip=95.215.58.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AjqrfXhZ"
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DRIrSbkbtrBkartjFVq+RFV2/jC6XURTKQFkUBIVp7w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791292741; v=1; x=1791897541;
 b=AjqrfXhZj3cFgdo8TelIuhFI0bfSPdumqJREtUX1+K3qGkaL6qdMxhFmIOOdAhMnF3p1+3lM
 r9C5eR3dBI3CIsCT/MwhuN+VdLiycFTjeYreI2hqRG9p5BFuGtxZVPF6/CJpOZZpaQPYWO/1NtI
 1trzirqTiw4IpuBnOiLQK7R4=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9087b2f6437d9c29;
	Tue, 06 Oct 2026 13:19:00 +0000
X-Mizu-Trace-ID: 9087b2f6437d9c29
X-Migadu-Flow: FLOW_OUT
From: Shawn Lin <shawn.lin@linux.dev>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH] mmc: core: Fix max_dtr passed to SD drive strength selection
Date: Tue,  6 Oct 2026 21:18:46 +0800
Message-Id: <1791292726-31978-1-git-send-email-shawn.lin@linux.dev>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

sd_select_driver_type() passes card->sw_caps.uhs_max_dtr to
mmc_select_drive_strength(), but that field is only assigned later by
sd_set_bus_speed_mode().  A card initialized for the first time thus
gets max_dtr=0, while a re-initialized card (system resume or
hw reset recovery reuse the card struct) gets the stale value from the
previous initialization.

No in-tree driver implementing ->select_drive_strength() (AMD and Intel
SDHCI) actually looks at max_dtr, so there is no functional impact
today.  Still, compute the frequency from the bus speed mode that
sd_update_bus_speed_mode() has already selected, so the core doesn't
hand out a bogus value, and use the same helper in sd_set_bus_speed_mode()
to keep a single mapping.

Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
---

 drivers/mmc/core/sd.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c763efb..5ba4e2d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -417,6 +417,22 @@ int mmc_sd_switch_hs(struct mmc_card *card)
 	return err;
 }
 
+static unsigned int sd_get_bus_speed_dtr(struct mmc_card *card)
+{
+	switch (card->sd_bus_speed) {
+	case UHS_SDR104_BUS_SPEED:
+		return UHS_SDR104_MAX_DTR;
+	case UHS_DDR50_BUS_SPEED:
+		return UHS_DDR50_MAX_DTR;
+	case UHS_SDR50_BUS_SPEED:
+		return UHS_SDR50_MAX_DTR;
+	case UHS_SDR25_BUS_SPEED:
+		return UHS_SDR25_MAX_DTR;
+	default:
+		return UHS_SDR12_MAX_DTR;
+	}
+}
+
 static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 {
 	int card_drv_type, drive_strength, drv_type;
@@ -427,7 +443,7 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	card_drv_type = card->sw_caps.sd3_drv_type | SD_DRIVER_TYPE_B;
 
 	drive_strength = mmc_select_drive_strength(card,
-						   card->sw_caps.uhs_max_dtr,
+						   sd_get_bus_speed_dtr(card),
 						   card_drv_type, &drv_type);
 
 	if (drive_strength) {
@@ -490,28 +506,25 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
 	switch (card->sd_bus_speed) {
 	case UHS_SDR104_BUS_SPEED:
 		timing = MMC_TIMING_UHS_SDR104;
-		card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
 		break;
 	case UHS_DDR50_BUS_SPEED:
 		timing = MMC_TIMING_UHS_DDR50;
-		card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
 		break;
 	case UHS_SDR50_BUS_SPEED:
 		timing = MMC_TIMING_UHS_SDR50;
-		card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
 		break;
 	case UHS_SDR25_BUS_SPEED:
 		timing = MMC_TIMING_UHS_SDR25;
-		card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
 		break;
 	case UHS_SDR12_BUS_SPEED:
 		timing = MMC_TIMING_UHS_SDR12;
-		card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
 		break;
 	default:
 		return 0;
 	}
 
+	card->sw_caps.uhs_max_dtr = sd_get_bus_speed_dtr(card);
+
 	err = mmc_sd_switch(card, SD_SWITCH_SET, 0, card->sd_bus_speed, status);
 	if (err)
 		return err;
-- 
2.7.4

