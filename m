From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/2] mmc: quirks: wl1271 is MMC_QUIRK_DISABLE_CD
Date: Tue,  5 Apr 2011 18:02:26 +0300
Message-ID: <1302015746-8414-2-git-send-email-ohad@wizery.com>
References: <1302015746-8414-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab1DEPDT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 11:03:19 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so328800fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 08:03:18 -0700 (PDT)
In-Reply-To: <1302015746-8414-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

The wl12xx device supports disconnecting the pull-up resistor on
CD/DAT[3] (pin 1) of the card.

Tell SDIO core to disconnect that resistor during card init,
since we don't need it at that point (and anyway all
hosts shall provide pull-up resistors on all data lines DAT[3:0]
as described in section 6 of the SD physical specification).

As a result, this may save some power, but it's also generally healthy
since it prevents both ends from pulling up that pin, which
results in undesirable asymmetric physical bus.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/quirks.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 1957398..a4c42ed 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -66,6 +66,8 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
 		remove_quirk, MMC_QUIRK_BROKEN_CLK_GATING },
 	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
 		add_quirk, MMC_QUIRK_NONSTD_FUNC_IF },
+	{ SDIO_VENDOR_ID_TI, SDIO_DEVICE_ID_TI_WL1271,
+		add_quirk, MMC_QUIRK_DISABLE_CD },
 	{ 0 }
 };
 
-- 
1.7.1

