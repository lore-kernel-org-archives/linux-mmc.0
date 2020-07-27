Return-Path: <SRS0=9Cpo=BG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3244CC433F7
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9192083E
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595857145;
	bh=Ch8foSKe0HJ0Blu8CEHeXIcdrEOxplMElgo0OhRZ1ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iwt82Bfbi2OVrWMaIgc6j8+HihEVT0QAgJrv8IFWa1oThQaWdLFEHgFzzsHYmD3Cn
	 5wQASucNDBYPlWPW23fogKiUGQHaMV74o42o6yl72YbcxW00k2d69oWmPICIEGwPX8
	 APLQXDMzUTHwHFwv6A8x6/jNv0A80+5oZvGOy0PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgG0Ni5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgG0Ni4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Jul 2020 09:38:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB2D2083B;
        Mon, 27 Jul 2020 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595857135;
        bh=Ch8foSKe0HJ0Blu8CEHeXIcdrEOxplMElgo0OhRZ1ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxjlqctLtriqwSUVt8cH1f/HHrHHc+KbWo5gn1UMpZzNqoCSADAoR/MJRCunWW0UX
         h1BSVnl2xA9lAjY3nhSz84bONKAReQ1ZAd87HYkd1b64duP2lrWsFtlnKKiZJe/vLs
         KPDmZTsMR3QZX63LUx8QdkkSEaTwqUW9Nc/foGpg=
Received: by pali.im (Postfix)
        id 8A270C89; Mon, 27 Jul 2020 15:38:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mmc: sdio: Export SDIO revision and info strings to userspace
Date:   Mon, 27 Jul 2020 15:38:37 +0200
Message-Id: <20200727133837.19086-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727133837.19086-1-pali@kernel.org>
References: <20200727133837.19086-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For SDIO functions, SDIO cards and SD COMBO cards are exported revision
number and info strings from CISTPL_VERS_1 structure. Revision number
should indicate compliance of standard and info strings should contain
product information in same format as product information for PCMCIA cards.

Product information for PCMCIA cards should contain following strings in
this order: Manufacturer, Product Name, Lot number, Programming Conditions.

Note that not all SDIO cards export all those info strings in that order as
described in PCMCIA Metaformat Specification.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/mmc/core/bus.c      | 12 ++++++++++++
 drivers/mmc/core/sd.c       | 36 +++++++++++++++++++++++++++++++++---
 drivers/mmc/core/sdio.c     | 24 ++++++++++++++++++++++++
 drivers/mmc/core/sdio_bus.c | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 70207f11a654..c2e70b757dd1 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -68,6 +68,7 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	const char *type;
+	unsigned int i;
 	int retval = 0;
 
 	switch (card->type) {
@@ -98,6 +99,17 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 					card->cis.vendor, card->cis.device);
 		if (retval)
 			return retval;
+
+		retval = add_uevent_var(env, "SDIO_REVISION=%u.%u",
+					card->major_rev, card->minor_rev);
+		if (retval)
+			return retval;
+
+		for (i = 0; i < card->num_info; i++) {
+			retval = add_uevent_var(env, "SDIO_INFO%u=%s", i+1, card->info[i]);
+			if (retval)
+				return retval;
+		}
 	}
 
 	/*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5a2210c25aa7..429ca14fa7e1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -709,10 +709,34 @@ static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
 
 MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
 MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
+MMC_DEV_ATTR(revision, "%u.%u\n", card->major_rev, card->minor_rev);
+
+#define sdio_info_attr(num)									\
+static ssize_t info##num##_show(struct device *dev, struct device_attribute *attr, char *buf)	\
+{												\
+	struct mmc_card *card = mmc_dev_to_card(dev);						\
+												\
+	if (num > card->num_info)								\
+		return -ENODATA;								\
+	if (!card->info[num-1][0])								\
+		return 0;									\
+	return sprintf(buf, "%s\n", card->info[num-1]);						\
+}												\
+static DEVICE_ATTR_RO(info##num)
+
+sdio_info_attr(1);
+sdio_info_attr(2);
+sdio_info_attr(3);
+sdio_info_attr(4);
 
 static struct attribute *sd_std_attrs[] = {
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
+	&dev_attr_revision.attr,
+	&dev_attr_info1.attr,
+	&dev_attr_info2.attr,
+	&dev_attr_info3.attr,
+	&dev_attr_info4.attr,
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
 	&dev_attr_scr.attr,
@@ -738,9 +762,15 @@ static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct mmc_card *card = mmc_dev_to_card(dev);
 
-	/* CIS vendor and device ids are available only for Combo cards */
-	if ((attr == &dev_attr_vendor.attr || attr == &dev_attr_device.attr) &&
-	    card->type != MMC_TYPE_SD_COMBO)
+	/* CIS vendor and device ids, revision and info string are available only for Combo cards */
+	if ((attr == &dev_attr_vendor.attr ||
+	     attr == &dev_attr_device.attr ||
+	     attr == &dev_attr_revision.attr ||
+	     attr == &dev_attr_info1.attr ||
+	     attr == &dev_attr_info2.attr ||
+	     attr == &dev_attr_info3.attr ||
+	     attr == &dev_attr_info4.attr
+	    ) && card->type != MMC_TYPE_SD_COMBO)
 		return 0;
 
 	return attr->mode;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 61ae909730f3..c4a4e67ef0a6 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -29,12 +29,36 @@
 
 MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
 MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
+MMC_DEV_ATTR(revision, "%u.%u\n", card->major_rev, card->minor_rev);
 MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
 MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
 
+#define sdio_info_attr(num)									\
+static ssize_t info##num##_show(struct device *dev, struct device_attribute *attr, char *buf)	\
+{												\
+	struct mmc_card *card = mmc_dev_to_card(dev);						\
+												\
+	if (num > card->num_info)								\
+		return -ENODATA;								\
+	if (!card->info[num-1][0])								\
+		return 0;									\
+	return sprintf(buf, "%s\n", card->info[num-1]);						\
+}												\
+static DEVICE_ATTR_RO(info##num)
+
+sdio_info_attr(1);
+sdio_info_attr(2);
+sdio_info_attr(3);
+sdio_info_attr(4);
+
 static struct attribute *sdio_std_attrs[] = {
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
+	&dev_attr_revision.attr,
+	&dev_attr_info1.attr,
+	&dev_attr_info2.attr,
+	&dev_attr_info3.attr,
+	&dev_attr_info4.attr,
 	&dev_attr_ocr.attr,
 	&dev_attr_rca.attr,
 	NULL,
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2384829c8fb2..3d709029e07c 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -42,12 +42,36 @@ static DEVICE_ATTR_RO(field)
 sdio_config_attr(class, "0x%02x\n", func->class);
 sdio_config_attr(vendor, "0x%04x\n", func->vendor);
 sdio_config_attr(device, "0x%04x\n", func->device);
+sdio_config_attr(revision, "%u.%u\n", func->major_rev, func->minor_rev);
 sdio_config_attr(modalias, "sdio:c%02Xv%04Xd%04X\n", func->class, func->vendor, func->device);
 
+#define sdio_info_attr(num)									\
+static ssize_t info##num##_show(struct device *dev, struct device_attribute *attr, char *buf)	\
+{												\
+	struct sdio_func *func = dev_to_sdio_func(dev);						\
+												\
+	if (num > func->num_info)								\
+		return -ENODATA;								\
+	if (!func->info[num-1][0])								\
+		return 0;									\
+	return sprintf(buf, "%s\n", func->info[num-1]);						\
+}												\
+static DEVICE_ATTR_RO(info##num)
+
+sdio_info_attr(1);
+sdio_info_attr(2);
+sdio_info_attr(3);
+sdio_info_attr(4);
+
 static struct attribute *sdio_dev_attrs[] = {
 	&dev_attr_class.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
+	&dev_attr_revision.attr,
+	&dev_attr_info1.attr,
+	&dev_attr_info2.attr,
+	&dev_attr_info3.attr,
+	&dev_attr_info4.attr,
 	&dev_attr_modalias.attr,
 	NULL,
 };
@@ -98,6 +122,7 @@ static int
 sdio_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
+	unsigned int i;
 
 	if (add_uevent_var(env,
 			"SDIO_CLASS=%02X", func->class))
@@ -107,6 +132,15 @@ sdio_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			"SDIO_ID=%04X:%04X", func->vendor, func->device))
 		return -ENOMEM;
 
+	if (add_uevent_var(env,
+			"SDIO_REVISION=%u.%u", func->major_rev, func->minor_rev))
+		return -ENOMEM;
+
+	for (i = 0; i < func->num_info; i++) {
+		if (add_uevent_var(env, "SDIO_INFO%u=%s", i+1, func->info[i]))
+			return -ENOMEM;
+	}
+
 	if (add_uevent_var(env,
 			"MODALIAS=sdio:c%02Xv%04Xd%04X",
 			func->class, func->vendor, func->device))
-- 
2.20.1

