From: Jin Qian <jinqian@android.com>
Subject: [PATCH 1/1] ANDROID: mmc: core: export emmc revision
Date: Wed, 11 Oct 2017 12:23:18 -0700
Message-ID: <20171011192320.160580-1-jinqian@android.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:54374 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdJKT0L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Oct 2017 15:26:11 -0400
Received: by mail-pf0-f172.google.com with SMTP id m28so1738671pfi.11
        for <linux-mmc@vger.kernel.org>; Wed, 11 Oct 2017 12:26:11 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Uri Yanai <uri.yanai@sandisk.com>, Chanho Min <chanho.min@lge.com>, Jungseung Lee <js07.lee@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jin Qian <jinqian@google.com>, Jin Qian <jinqian@android.com>

From: Jin Qian <jinqian@google.com>

Expose emmc revision as part of device attributes.

Signed-off-by: Jin Qian <jinqian@android.com>
---
 drivers/mmc/core/mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 36217ad5e9b1..4aa4cfb2c9e1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -780,6 +780,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
+MMC_DEV_ATTR(rev, "0x%x\n", card->ext_csd.rev);
 MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
 MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
 	card->ext_csd.device_life_time_est_typ_a,
@@ -838,6 +839,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_prv.attr,
+	&dev_attr_rev.attr,
 	&dev_attr_pre_eol_info.attr,
 	&dev_attr_life_time.attr,
 	&dev_attr_serial.attr,
-- 
2.15.0.rc0.271.g36b669edcc-goog

