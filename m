From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 02/15] mmc: sunxi: Return error on mmc_regulator_set_ocr() fail in .set_ios op
Date: Thu, 21 Jan 2016 13:26:29 +0800
Message-ID: <1453354002-28366-3-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:54844 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbcAUFdj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 00:33:39 -0500
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com

Let .set_ios() fail if mmc_regulator_set_ocr() fails to enable and set a
proper voltage for vmmc.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cce5ca540857..790f01662b4e 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -711,7 +711,10 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_UP:
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+		host->ferror = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
+						     ios->vdd);
+		if (host->ferror)
+			return;
 
 		host->ferror = sunxi_mmc_init_host(mmc);
 		if (host->ferror)
-- 
2.7.0.rc3

