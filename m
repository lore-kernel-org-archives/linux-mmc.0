From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: Convert to use ATTRIBUTE_GROUPS
Date: Mon, 02 Dec 2013 10:37:58 +0800
Message-ID: <1385951878.30717.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:61528 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3LBCiD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Dec 2013 21:38:03 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so17152358pdj.29
        for <linux-mmc@vger.kernel.org>; Sun, 01 Dec 2013 18:38:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Use new ATTRIBUTE_GROUPS macro to declare attribute groups.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/core/mmc.c | 12 ++----------
 drivers/mmc/core/sd.c  | 12 ++----------
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f631f5a..db0f250 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -694,18 +694,10 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_rel_sectors.attr,
 	NULL,
 };
-
-static struct attribute_group mmc_std_attr_group = {
-	.attrs = mmc_std_attrs,
-};
-
-static const struct attribute_group *mmc_attr_groups[] = {
-	&mmc_std_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(mmc_std);
 
 static struct device_type mmc_type = {
-	.groups = mmc_attr_groups,
+	.groups = mmc_std_groups,
 };
 
 /*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f42050..c52cb77 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -700,18 +700,10 @@ static struct attribute *sd_std_attrs[] = {
 	&dev_attr_serial.attr,
 	NULL,
 };
-
-static struct attribute_group sd_std_attr_group = {
-	.attrs = sd_std_attrs,
-};
-
-static const struct attribute_group *sd_attr_groups[] = {
-	&sd_std_attr_group,
-	NULL,
-};
+ATTRIBUTE_GROUPS(sd_std);
 
 struct device_type sd_type = {
-	.groups = sd_attr_groups,
+	.groups = sd_std_groups,
 };
 
 /*
-- 
1.8.1.2



