From: Bojan Prtvar <prtvar.b@gmail.com>
Subject: [PATCH v2] mmc: core: Extend sysfs with DSR register
Date: Tue, 19 Jul 2016 11:16:38 +0200
Message-ID: <20160719091652.124182-1-prtvar.b@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Dong Aisheng <aisheng.dong@nxp.com>, Pratibhasagar V <pratibha@codeaurora.org>, Gwendal Grignou <gwendal@chromium.org>, Weijun Yang <york.yang@csr.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Carlo Caione <carlo@endlessm.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Export DSR register through sysfs same as we did for the CID, CSD and OCR registers.

Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>
---
 v2: Extended to cover SD cards

 Documentation/mmc/mmc-dev-attrs.txt |  1 +
 drivers/mmc/core/mmc.c              | 17 +++++++++++++++++
 drivers/mmc/core/sd.c               | 17 +++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 8163eca..404a0e9 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -29,6 +29,7 @@ All attributes are read-only.
 	raw_rpmb_size_mult	RPMB partition size
 	rel_sectors		Reliable write sector count
 	ocr 			Operation Conditions Register
+	dsr			Driver Stage Register
 
 Note on Erase Size and Preferred Erase Size:
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 403b97b..f2d185c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -767,6 +767,22 @@ static ssize_t mmc_fwrev_show(struct device *dev,
 
 static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
 
+static ssize_t mmc_dsr_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+
+	if (card->csd.dsr_imp && host->dsr_req)
+		return sprintf(buf, "0x%x\n", host->dsr);
+	else
+		/* return default DSR value */
+		return sprintf(buf, "0x%x\n", 0x404);
+}
+
+static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
+
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
@@ -786,6 +802,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_raw_rpmb_size_mult.attr,
 	&dev_attr_rel_sectors.attr,
 	&dev_attr_ocr.attr,
+	&dev_attr_dsr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 3dd0861..0123936 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -678,6 +678,22 @@ MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
 
 
+static ssize_t mmc_dsr_show(struct device *dev,
+                           struct device_attribute *attr,
+                           char *buf)
+{
+       struct mmc_card *card = mmc_dev_to_card(dev);
+       struct mmc_host *host = card->host;
+
+       if (card->csd.dsr_imp && host->dsr_req)
+               return sprintf(buf, "0x%x\n", host->dsr);
+       else
+               /* return default DSR value */
+               return sprintf(buf, "0x%x\n", 0x404);
+}
+
+static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
+
 static struct attribute *sd_std_attrs[] = {
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
@@ -692,6 +708,7 @@ static struct attribute *sd_std_attrs[] = {
 	&dev_attr_oemid.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_ocr.attr,
+	&dev_attr_dsr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(sd_std);
-- 
2.8.0.GIT

