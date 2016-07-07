From: Bojan Prtvar <prtvar.b@gmail.com>
Subject: [PATCH RFC] mmc: core: Extend sysfs with DSR register
Date: Thu,  7 Jul 2016 10:19:30 +0200
Message-ID: <20160707081930.53884-1-prtvar.b@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34002 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756868AbcGGITl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jul 2016 04:19:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so3671620wmz.1
        for <linux-mmc@vger.kernel.org>; Thu, 07 Jul 2016 01:19:40 -0700 (PDT)
Received: from mcs27.domain.local ([89.216.37.146])
        by smtp.gmail.com with ESMTPSA id dv8sm1882742wjd.49.2016.07.07.01.19.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2016 01:19:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

On embedded platform we have a small diagnostic application which
has to record following emmc registers on every power cycle:
CID, CSD, EXT_CSD, OCR, RCA and DSR. The CID, CSD, EXT_CSD and OCR 
are accessible via ioctl(MMC_IOC_CMD) or through sysfs. The RCA 
should always be 1 on any linux platform. I can't find a better way 
for accessing the DSR then as proposed below.

Regards,
Bojan

User space access to Driver Stage Register (DSR) can be useful
for diagnostics purpose.

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

