Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80353C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6121B206D5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590507834;
	bh=PS3TMqEUSnh36RZbQLwQotc4tPzv4y0Bou1R/eGCOvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5YUudZH/SMT/XzQm+or5WZ4VYbUdrrGB62kSx7vU12i8O1NgtNpt5ZEJqjvLX93y
	 HwWaNiw8k9phXahFUfgHRfaGkxZVdqxAw1nXbp47+6zFaqyd7ZcigO12H5tLm1GBQT
	 scwDsaeBKQ/sx5KkAG/XNNwBNMwJSQUst+WcKcis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgEZPnx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 11:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgEZPnx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 11:43:53 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD2F520663;
        Tue, 26 May 2020 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590507832;
        bh=PS3TMqEUSnh36RZbQLwQotc4tPzv4y0Bou1R/eGCOvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xBVMDInj0KiwbSoP7hs4EClaelZrLXhyVoKi/w7zlCqMBo4RH+8gYAZCQlklZZag/
         Jketu+AL6xq2QMkaCPrOlt5XiYUJE11afqtY4hDW91sfjEuauxwLEefHCptf/etODY
         QOKxrfD0rA0n0oPGEoJlA8RppYjVmxS5vaJJ7o40=
Received: by pali.im (Postfix)
        id 127DB16FA; Tue, 26 May 2020 17:43:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 2/2] mmc: core: Export device/vendor ids from Common CIS for SDIO cards
Date:   Tue, 26 May 2020 17:43:34 +0200
Message-Id: <20200526154334.21222-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526154334.21222-1-pali@kernel.org>
References: <20200526154334.21222-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Device/vendor ids from Common CIS (Card Information Structure) may be
different as device/vendor ids from CIS on particular SDIO function.

Export these "main" device/vendor ids for SDIO and SD combo cards at top
level mmc device in sysfs so userspace can do better identification of
connected SDIO and SD combo cards.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/mmc/core/bus.c  |  7 +++++++
 drivers/mmc/core/sd.c   | 26 +++++++++++++++++++++++++-
 drivers/mmc/core/sdio.c | 20 +++++++++++++++++++-
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 103eea7cd..5d4b28b29 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -93,6 +93,13 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 			return retval;
 	}
 
+	if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
+		retval = add_uevent_var(env, "SDIO_ID=%04X:%04X",
+					card->cis.vendor, card->cis.device);
+		if (retval)
+			return retval;
+	}
+
 	if (card->type != MMC_TYPE_SDIO) {
 		retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
 		if (retval)
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 76c7add36..ee1a51ff6 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -707,7 +707,12 @@ static ssize_t mmc_dsr_show(struct device *dev,
 
 static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
 
+MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
+MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
+
 static struct attribute *sd_std_attrs[] = {
+	&dev_attr_vendor.attr,
+	&dev_attr_device.attr,
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
 	&dev_attr_scr.attr,
@@ -726,7 +731,26 @@ static struct attribute *sd_std_attrs[] = {
 	&dev_attr_dsr.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(sd_std);
+
+static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
+				 int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct mmc_card *card = mmc_dev_to_card(dev);
+
+	/* CIS vendor and device ids are available only for Combo cards */
+	if ((attr == &dev_attr_vendor.attr || attr == &dev_attr_device.attr) &&
+	    card->type != MMC_TYPE_SD_COMBO)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group sd_std_group = {
+	.attrs = sd_std_attrs,
+	.is_visible = sd_std_is_visible,
+};
+__ATTRIBUTE_GROUPS(sd_std);
 
 struct device_type sd_type = {
 	.groups = sd_std_groups,
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ebb387aa5..d708e0fbc 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -27,6 +27,24 @@
 #include "sdio_ops.h"
 #include "sdio_cis.h"
 
+MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
+MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
+MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
+MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
+
+static struct attribute *sdio_std_attrs[] = {
+	&dev_attr_vendor.attr,
+	&dev_attr_device.attr,
+	&dev_attr_ocr.attr,
+	&dev_attr_rca.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(sdio_std);
+
+struct device_type sdio_type = {
+	.groups = sdio_std_groups,
+};
+
 static int sdio_read_fbr(struct sdio_func *func)
 {
 	int ret;
@@ -598,7 +616,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Allocate card structure.
 	 */
-	card = mmc_alloc_card(host, NULL);
+	card = mmc_alloc_card(host, &sdio_type);
 	if (IS_ERR(card)) {
 		err = PTR_ERR(card);
 		goto err;
-- 
2.20.1

