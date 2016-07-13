From: Bojan Prtvar <prtvar.b@gmail.com>
Subject: [PATCH] mmc: sd: Extend sysfs with OCR register
Date: Wed, 13 Jul 2016 23:22:20 +0200
Message-ID: <20160713212225.106498-1-prtvar.b@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33605 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbcGMVWv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2016 17:22:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Weijun Yang <york.yang@csr.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Lin <shawn.lin@rock-chips.com>, Carlo Caione <carlo@endlessm.com>, linux-kernel@vger.kernel.org

We already exported OCR for mmc cards. Let's export it
for sd cards as well.

Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>
---
 drivers/mmc/core/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index b95bd24..3dd0861 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -675,6 +675,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
+MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
 
 
 static struct attribute *sd_std_attrs[] = {
@@ -690,6 +691,7 @@ static struct attribute *sd_std_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_serial.attr,
+	&dev_attr_ocr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(sd_std);
-- 
2.8.0.GIT

