From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/2] brcmfmac: Prevent re-tuning conflicting with 'wake-up'
Date: Tue, 28 Apr 2015 17:45:41 +0300
Message-ID: <1430232341-8307-3-git-send-email-adrian.hunter@intel.com>
References: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26082 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965984AbbD1Ory (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Apr 2015 10:47:54 -0400
In-Reply-To: <1430232341-8307-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arend van Spriel <arend@broadcom.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

If the device is in a custom sleep state, then re-tuning
will fail. Add calls to sdio_retune_hold_now() and
sdio_retune_release() to prevent re-tuning before the
wake-up command. In the case re-tuning was needed, the
wake-up command might return an error, but the wake-up
is expected still to have happened, and the error is
anyway ignored.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/net/wireless/brcm80211/brcmfmac/sdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
index ab0c898..2ce81fb 100644
--- a/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/sdio.c
@@ -773,11 +773,17 @@ brcmf_sdio_kso_control(struct brcmf_sdio *bus, bool on)
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

