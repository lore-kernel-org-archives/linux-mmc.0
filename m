From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/2] brcmfmac: Prevent re-tuning conflicting with 'wake-up'
Date: Thu,  8 Dec 2016 11:56:40 +0200
Message-ID: <1481191000-19305-3-git-send-email-adrian.hunter@intel.com>
References: <1481191000-19305-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8474 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbcLHKBr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Dec 2016 05:01:47 -0500
In-Reply-To: <1481191000-19305-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>

If the device is in a custom sleep state, then re-tuning
will fail. Add calls to sdio_retune_hold_now() and
sdio_retune_release() to prevent re-tuning before the
wake-up command. In the case re-tuning was needed, the
wake-up command might return an error, but the wake-up
is expected still to have happened, and the error is
anyway ignored.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index b892dac70f4b..a69abbb0923a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -684,11 +684,17 @@ static int w_sdreg32(struct brcmf_sdio *bus, u32 regval, u32 reg_offset)
 	brcmf_dbg(TRACE, "Enter: on=%d\n", on);
 
 	wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
+
+	/* Cannot re-tune if device is asleep */
+	if (on)
+		sdio_retune_hold_now(bus->sdiodev->func[1]);
+
 	/* 1st KSO write goes to AOS wake up core if device is asleep  */
 	brcmf_sdiod_regwb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR,
 			  wr_val, &err);
 
 	if (on) {
+		sdio_retune_release(bus->sdiodev->func[1]);
 		/* device WAKEUP through KSO:
 		 * write bit 0 & read back until
 		 * both bits 0 (kso bit) & 1 (dev on status) are set
-- 
1.9.1

