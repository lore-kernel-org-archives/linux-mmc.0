From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/2] mmc: quirks: wl1271 is MMC_QUIRK_NONSTD_FUNC_IF
Date: Tue,  5 Apr 2011 17:50:15 +0300
Message-ID: <1302015015-8178-2-git-send-email-ohad@wizery.com>
References: <1302015015-8178-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42444 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab1DEOvI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 10:51:08 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so318856fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 07:51:08 -0700 (PDT)
In-Reply-To: <1302015015-8178-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Tell SDIO core to ignore the standard SDIO function interface
codes indicated by the wl1271. This is required because the
wl1271 erroneously indicates its first function as a standard
Bluetooth SDIO interface, and that drives btsdio mad.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/quirks.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 11118b7..1957398 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -64,6 +64,8 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
 		add_quirk_for_sdio_devices, MMC_QUIRK_BROKEN_CLK_GATING },
 	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING },
+	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		add_quirk, MMC_QUIRK_NONSTD_FUNC_IF },
 	{ 0 }
 };
 
-- 
1.7.1

