From: Yusuke Goda <goda.yusuke@renesas.com>
Subject: tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support
Date: Mon, 15 Feb 2010 17:08:34 +0900
Message-ID: <4B790102.4050907@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.renesas.com ([202.234.163.13]:55066 "EHLO
	mail04.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755356Ab0BOIJR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2010 03:09:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>

Enable MMC_CAP_MMC_HIGHSPEED support in the tmio_mmc driver if
pdata->cap_highspeed is set.

Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>
---
 drivers/mmc/host/tmio_mmc.c |    2 ++
 include/linux/mfd/tmio.h    |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e22c3fa..a8ca83f 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -550,6 +550,8 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)

 	mmc->ops = &tmio_mmc_ops;
 	mmc->caps = MMC_CAP_4_BIT_DATA;
+	if (pdata->cap_highspeed)
+		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
 	mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 9cb1834..695199a 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -60,6 +60,7 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
  */
 struct tmio_mmc_data {
 	const unsigned int		hclk;
+	int 				cap_highspeed;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-- 
1.6.4.3


