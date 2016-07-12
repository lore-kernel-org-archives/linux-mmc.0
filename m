From: Bojan Prtvar <prtvar.b@gmail.com>
Subject: [PATCH] mmc: core: Extend sysfs with DSR register
Date: Tue, 12 Jul 2016 14:56:53 +0200
Message-ID: <20160712125722.75541-1-prtvar.b@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Gwendal Grignou <gwendal@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Export DSR register through sysfs same as we did for the CID, CSD and OCR registers.

Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>
---
 Documentation/mmc/mmc-dev-attrs.txt |  1 +
 drivers/mmc/core/mmc.c              | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

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
index 1848334..4363fdc 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -745,6 +745,22 @@ static ssize_t mmc_fwrev_show(struct device *dev,
 
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
@@ -764,6 +780,7 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_raw_rpmb_size_mult.attr,
 	&dev_attr_rel_sectors.attr,
 	&dev_attr_ocr.attr,
+	&dev_attr_dsr.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
-- 
2.8.0.GIT

