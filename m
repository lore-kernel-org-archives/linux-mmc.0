From: Jin Qian <jinqian@android.com>
Subject: [PATCHv2 1/1] mmc: core: export emmc revision via sysfs
Date: Wed, 22 Mar 2017 17:18:45 -0700
Message-ID: <20170323001849.20332-1-jinqian@android.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33381 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754791AbdCWAUd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Mar 2017 20:20:33 -0400
Received: by mail-pg0-f52.google.com with SMTP id w20so11803932pgc.0
        for <linux-mmc@vger.kernel.org>; Wed, 22 Mar 2017 17:20:32 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Uri Yanai <uri.yanai@sandisk.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Pratibhasagar V <pratibha@codeaurora.org>, Gwendal Grignou <gwendal@chromium.org>, Dong Aisheng <aisheng.dong@nxp.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jin Qian <jinqian@android.com>

Extend sysfs to access ext_csd revision information.

Signed-off-by: Jin Qian <jinqian@android.com>
---
 drivers/mmc/core/mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7fd722868875..08c62c9bec48 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -779,6 +779,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
+MMC_DEV_ATTR(rev, "0x%x\n", card->ext_csd.rev);
 MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
 MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
 	card->ext_csd.device_life_time_est_typ_a,
@@ -836,6 +837,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_prv.attr,
+	&dev_attr_rev.attr,
 	&dev_attr_pre_eol_info.attr,
 	&dev_attr_life_time.attr,
 	&dev_attr_serial.attr,
-- 
2.12.1.500.gab5fba24ee-goog

