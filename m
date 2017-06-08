From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: meson-gx: work around broken SDIO with certain WiFi
 chips
Date: Thu, 8 Jun 2017 20:43:04 +0200
Message-ID: <dd12ffc8-e2a4-53bd-caa5-83bb7cbcd5e5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35863 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdFHSnR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 14:43:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id d17so3796230wme.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 11:43:16 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

There have been reports about SDIO failing with certain WiFi chips in
descriptor chain mode. SD / eMMC are working fine.

So let's fall back to bounce buffer mode for command SD_IO_RW_EXTENDED.
This was reported to fix this error.

Fixes: 79ed05e329c3 "mmc: meson-gx: add support for descriptor chain mode"
Cc: <stable@vger.kernel.org> # 4.12.x
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 1842ed34..4cdbe3c0 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -210,6 +210,15 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
 	int i;
 	bool use_desc_chain_mode = true;
 
+	/*
+	 * Broken SDIO with AP6335-based WiFi on Khadas VIM Pro has been
+	 * reported. For some strange reason this occurs in descriptor
+	 * chain mode only. So let's fall back to bounce buffer mode
+	 * for command SD_IO_RW_EXTENDED.
+	 */
+	if (mrq->cmd->opcode == SD_IO_RW_EXTENDED)
+		return;
+
 	for_each_sg(data->sg, sg, data->sg_len, i)
 		/* check for 8 byte alignment */
 		if (sg->offset & 7) {
-- 
2.13.0

