Return-Path: <SRS0=808J=B6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF91C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 08:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7728A208B3
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 08:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="E3Wi6uyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgHTH77 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:59:59 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:37647 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgHTH76 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 20 Aug 2020 03:59:58 -0400
IronPort-SDR: S6y16wQS5NJBnXulz4btA7UCBh79HkIzZI17Y9xvS1XsOq8EksHElQGsSmNoESO6VlfKANb9kH
 6Lyx+apUEIx4SaKEex+tBg5m2bGPN7nixdgKdPAvAhlIB2qZogpFnhkP7lPPzhf/zaQkgLV7gP
 hIndeArQ+X9Ar2HhI5aNWM7Ky8rB+zppjbpp1Y24aArwLGnwWd5NzGDp/adpBf4ZvdMYgkyKGM
 UyU/+B+AZDx8DJ78A1U/qJUWsXIVr0yTqycJIcSa6e/7DUo8HZLr4B7/uhg/hJ6FVh1yJExKTv
 d1c=
X-IronPort-AV: E=Sophos;i="5.76,332,1592863200"; 
   d="scan'208";a="13534484"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 20 Aug 2020 09:59:55 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 20 Aug 2020 09:59:55 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 20 Aug 2020 09:59:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1597910395; x=1629446395;
  h=from:to:cc:subject:date:message-id;
  bh=HO7u0shBOUMf7ftO844jtABJD5UXzGgbOj7cMvvZQfU=;
  b=E3Wi6uyRiE61bB02/E+JMx4T6X3moZ8NZ8NpyGZXAdzx7Nc62XYLsTJq
   i3/wlEZnjX35SZ0tGhvEoZtvImihUqg+3axPp3FIpgScjFQ/VZrogsOxU
   dyBlw1UrAijX1zdz37F52M6Bfgc4ZJ1YlSd31wPXLAgfLuQDS6b6ypI8k
   xPgxHIrYRepzF1W4xMuu++DaalDexIhXkxyU7xj9Gr29lyYYX1MHIAjrM
   ImCQZ27WJJr4cwHoFwSLC2RTnwgSB4jG4m/wSFvebZHvDRvwJVuyc9q+/
   11VgFrwAc/gBIRQZz5w0Mc0sbv8vFlgrQgXbLqvMz4wil0L6aZ/G9B3sD
   g==;
IronPort-SDR: v5vSJDwBqSysn0qyXQZJu+YCO7/gv7KPTP1yuc6r9oJsXKZGg99x4SNHGtiML3cp6IMrekb9RO
 q1D3ewbDpYKRv8f4BBB8owAzZyBPMj0OojB845wrxCYaM3NjiGWmXqquYCQZzRpLlHTguEMz+3
 7NSzm5Cmj3mYiIYk9dU+L7Zr1LO+rISJyxRLyZVEw06VceCmlW8B2TVi4eKtFyf/bvhrcWoP8X
 ZhuWZTulXsUoZ37ycsfL25Nkr5cascikQZtRjqBdHCVYGa0s9dDkGzcDbuvJyiPDgceQ56bRug
 nYc=
X-IronPort-AV: E=Sophos;i="5.76,332,1592863200"; 
   d="scan'208";a="13534483"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 20 Aug 2020 09:59:55 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 66DAE280065;
        Thu, 20 Aug 2020 09:59:55 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH mmc-next v2] mmc: allow setting slot index via device tree alias
Date:   Thu, 20 Aug 2020 09:59:49 +0200
Message-Id: <20200820075949.19133-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As with GPIO, UART and others, allow specifying the device index via the
aliases node in the device tree.

On embedded devices, there is often a combination of removable (e.g.
SD card) and non-removable MMC devices (e.g. eMMC).
Therefore the index might change depending on

* host of removable device
* removable card present or not

This makes it difficult to hardcode the root device, if it is on the
non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
if SD card is not present at boot, eMMC will be mmcblk0.

All indices defined in the aliases node will be reserved for use by the
respective MMC device, moving the indices of devices that don't have an
alias up into the non-reserved range. If the aliases node is not found,
the driver will act as before.

This is a rebased and slightly cleaned up version of
https://www.spinics.net/lists/linux-mmc/msg26588.html .

Based-on-patch-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lkml.org/lkml/2020/8/5/194
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: fix missing symbols for modular mmcblock

 drivers/mmc/core/block.c | 13 +++++++++++--
 drivers/mmc/core/core.c  | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/core.h  |  3 +++
 drivers/mmc/core/host.c  | 15 +++++++++++++--
 4 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7896952de1ac..4620afaf0e50 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -38,6 +38,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
 #include <linux/debugfs.h>
+#include <linux/of.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -2260,9 +2261,17 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      int area_type)
 {
 	struct mmc_blk_data *md;
-	int devidx, ret;
+	int rsvidx, devidx = -1, ret;
+
+	rsvidx = mmc_get_reserved_index(card->host);
+	if (rsvidx >= 0)
+		devidx = ida_simple_get(&mmc_blk_ida, rsvidx, rsvidx + 1,
+					GFP_KERNEL);
+	if (devidx < 0)
+		devidx = ida_simple_get(&mmc_blk_ida,
+					mmc_first_nonreserved_index(),
+					max_devices, GFP_KERNEL);
 
-	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
 	if (devidx < 0) {
 		/*
 		 * We get -ENOSPC because there are no more any available
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8ccae6452b9c..5bce281a5faa 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2419,10 +2419,50 @@ void mmc_unregister_pm_notifier(struct mmc_host *host)
 }
 #endif
 
+static int mmc_max_reserved_idx = -1;
+
+/**
+ * mmc_first_nonreserved_index() - get the first index that is not reserved
+ */
+int mmc_first_nonreserved_index(void)
+{
+	return mmc_max_reserved_idx + 1;
+}
+EXPORT_SYMBOL(mmc_first_nonreserved_index);
+
+/**
+ * mmc_get_reserved_index() - get the index reserved for this MMC host
+ *
+ * Returns:
+ *   The index reserved for this host on success,
+ *   negative error if no index is reserved for this host
+ */
+int mmc_get_reserved_index(struct mmc_host *host)
+{
+	return of_alias_get_id(host->parent->of_node, "mmc");
+}
+EXPORT_SYMBOL(mmc_get_reserved_index);
+
+static void __init mmc_of_reserve_idx(void)
+{
+	int max;
+
+	max = of_alias_get_highest_id("mmc");
+	if (max < 0)
+		return;
+
+	mmc_max_reserved_idx = max;
+
+	pr_debug("MMC: reserving %d slots for OF aliases\n",
+		 mmc_max_reserved_idx + 1);
+}
+
 static int __init mmc_init(void)
 {
 	int ret;
 
+	mmc_of_reserve_idx();
+
 	ret = mmc_register_bus();
 	if (ret)
 		return ret;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 575ac0257af2..6aef6cf4e90f 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -79,6 +79,9 @@ int mmc_attach_mmc(struct mmc_host *host);
 int mmc_attach_sd(struct mmc_host *host);
 int mmc_attach_sdio(struct mmc_host *host);
 
+int mmc_first_nonreserved_index(void);
+int mmc_get_reserved_index(struct mmc_host *host);
+
 /* Module parameters */
 extern bool use_spi_crc;
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index ce43f7573d80..386e15afde83 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -387,6 +387,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 {
 	int err;
 	struct mmc_host *host;
+	int alias_id, min_idx, max_idx;
 
 	host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
 	if (!host)
@@ -395,7 +396,18 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	/* scanning will be enabled when we're ready */
 	host->rescan_disable = 1;
 
-	err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
+	host->parent = dev;
+
+	alias_id = mmc_get_reserved_index(host);
+	if (alias_id >= 0) {
+		min_idx = alias_id;
+		max_idx = alias_id + 1;
+	} else {
+		min_idx = mmc_first_nonreserved_index();
+		max_idx = 0;
+	}
+
+	err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
 	if (err < 0) {
 		kfree(host);
 		return NULL;
@@ -406,7 +418,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 	dev_set_name(&host->class_dev, "mmc%d", host->index);
 	host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
 
-	host->parent = dev;
 	host->class_dev.parent = dev;
 	host->class_dev.class = &mmc_host_class;
 	device_initialize(&host->class_dev);
-- 
2.17.1

