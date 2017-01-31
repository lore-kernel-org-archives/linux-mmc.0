From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/9] mmc: meson-gx: fix setting f_min
Date: Tue, 31 Jan 2017 21:57:48 +0100
Message-ID: <476265c8-b7e8-acdb-1964-5663c629caa3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33045 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbdAaVGg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 16:06:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so942384wmv.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 13:06:35 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

Currently f_min is set to 4 MHz whilst the comment states 400 MHz.
I think the itention is to set f_min to 400 kHz.
Change value and comment accordingly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 5eca88bc..da3cce31 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -268,7 +268,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
 	if (f_min != UINT_MAX)
 		f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
 	else
-		f_min = 4000000;  /* default min: 400 MHz */
+		f_min = 400000;  /* default min: 400 kHz */
 	host->mmc->f_min = f_min;
 
 	/* create the mux */
-- 
2.11.0

