Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7484EC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE5C63214
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Nov 2021 19:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239707AbhKPTFv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbhKPTFv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Nov 2021 14:05:51 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E3CC061764;
        Tue, 16 Nov 2021 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=2WGZyvn737a2uEQ6AKLNeTDudKNTnzVpucGZlKcLu0U=; b=AcIEqnHyH+8YOaXGet5F0f5WBk
        4V9Op8nyNXKFG9qdCoUxOgo4nwIN3N0QZjBaRue1vrBOoNJFp7LNkZcKh60zXdlG+HB/F9Edw3ZuJ
        fPgNdOWdaZon3YLeCkAKqFVUvvu/hdHRLeHCPFfm0tMNv/ATtJSE2lWFBAeaT4Rt/2EexbUAPz9gu
        7ROlwDgYB1duB457NJ9Q1yfsijBNbLsbBXV3Lg+Z+HTmfBDRXP/cbRwp2xsZEcZmRBypDi4huBjSd
        Xubaxesl571LGwqdF6dp4+pRO2+oqLMY88XC01YgqWXJgSqX+s0mq5HF5ZKM7hNrIvYyvL3srwNxb
        lv6OaMFg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mn3jG-00031A-Kn; Tue, 16 Nov 2021 19:02:50 +0000
From:   John Keeping <john@metanate.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Keeping <john@metanate.com>
Subject: [PATCH 1/2] mmc: dw_mmc: extract ctrl_id lookup to a function
Date:   Tue, 16 Nov 2021 19:02:43 +0000
Message-Id: <20211116190244.1417591-2-john@metanate.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211116190244.1417591-1-john@metanate.com>
References: <20211116190244.1417591-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

An upcoming commit will change the logic to use the standard "mmc" stem
for looking up the alias, while keeping the nonstandard "mshc" stem for
backwards compatibility.  In preparation for this, extract a common
function to replace the two places that currently replicate this lookup.

There is no functional change intended here.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/mmc/host/dw_mmc-k3.c |  4 +---
 drivers/mmc/host/dw_mmc.c    | 24 ++++++++++++++++++------
 drivers/mmc/host/dw_mmc.h    |  2 ++
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 0311a37dd4ab..0d82e6f54cca 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -127,9 +127,7 @@ static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
 	if (IS_ERR(priv->reg))
 		priv->reg = NULL;
 
-	priv->ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
-	if (priv->ctrl_id < 0)
-		priv->ctrl_id = 0;
+	priv->ctrl_id = dw_mci_of_alias_get_id(host);
 
 	if (priv->ctrl_id >= TIMING_MODE)
 		return -EINVAL;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1bedef827138..37af1245304b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -105,6 +105,21 @@ struct idmac_desc {
 /* Each descriptor can transfer up to 4KB of data in chained mode */
 #define DW_MCI_DESC_DATA_LENGTH	0x1000
 
+int dw_mci_of_alias_get_id(struct dw_mci *host)
+{
+	int ctrl_id;
+
+	if (WARN_ON(!host->dev->of_node))
+		return 0;
+
+	ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
+
+	if (ctrl_id < 0)
+		ctrl_id = 0;
+
+	return ctrl_id;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 static int dw_mci_req_show(struct seq_file *s, void *v)
 {
@@ -2855,13 +2870,10 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
 	if (host->pdata->pm_caps)
 		mmc->pm_caps = host->pdata->pm_caps;
 
-	if (host->dev->of_node) {
-		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
-		if (ctrl_id < 0)
-			ctrl_id = 0;
-	} else {
+	if (host->dev->of_node)
+		ctrl_id = dw_mci_of_alias_get_id(host);
+	else
 		ctrl_id = to_platform_device(host->dev)->id;
-	}
 
 	if (drv_data && drv_data->caps) {
 		if (ctrl_id >= drv_data->num_caps) {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index ce05d81477d9..9e643d7fe90b 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -508,6 +508,8 @@ extern int dw_mci_runtime_suspend(struct device *device);
 extern int dw_mci_runtime_resume(struct device *device);
 #endif
 
+extern int dw_mci_of_alias_get_id(struct dw_mci *host);
+
 /**
  * struct dw_mci_slot - MMC slot state
  * @mmc: The mmc_host representing this slot.
-- 
2.34.0

