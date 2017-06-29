From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: rtsx_usb_sdmmc: make array 'width' static const
Date: Thu, 29 Jun 2017 19:12:19 +0100
Message-ID: <20170629181219.12837-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41400 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbdF2SMX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jun 2017 14:12:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

array width is on-stack and not modified and should be
made static const.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 12d2fbe9c520..76da1687ab37 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -909,7 +909,7 @@ static int sd_set_bus_width(struct rtsx_usb_sdmmc *host,
 		unsigned char bus_width)
 {
 	int err = 0;
-	u8 width[] = {
+	static const u8 width[] = {
 		[MMC_BUS_WIDTH_1] = SD_BUS_WIDTH_1BIT,
 		[MMC_BUS_WIDTH_4] = SD_BUS_WIDTH_4BIT,
 		[MMC_BUS_WIDTH_8] = SD_BUS_WIDTH_8BIT,
-- 
2.11.0

