From: Jin Qian <jinqian@android.com>
Subject: [PATCHv2 1/1] ANDROID: mmc: core: export emmc revision
Date: Thu, 12 Oct 2017 10:43:10 -0700
Message-ID: <20171012174314.34815-1-jinqian@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jin Qian <jinqian@google.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Uri Yanai <uri.yanai@sandisk.com>, Chanho Min <chanho.min@lge.com>, Jungseung Lee <js07.lee@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Jin Qian <jinqian@android.com>
List-Id: linux-mmc@vger.kernel.org

From: Jin Qian <jinqian@google.com>

Expose emmc revision as part of device attributes.

Signed-off-by: Jin Qian <jinqian@android.com>
---
 Documentation/ABI/testing/sysfs-bus-mmc | 4 ++++
 drivers/mmc/core/mmc.c                  | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-mmc

diff --git a/Documentation/ABI/testing/sysfs-bus-mmc b/Documentation/ABI/testing/sysfs-bus-mmc
new file mode 100644
index 000000000000..519f028d19cc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-mmc
@@ -0,0 +1,4 @@
+What:		/sys/bus/mmc/devices/.../rev
+Date:		October 2017
+Contact:	Jin Qian <jinqian@android.com>
+Description:	Extended CSD revision number
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
