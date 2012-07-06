From: Loic Pallardy <loic.pallardy@stericsson.com>
Subject: [PATCH v1 3/5] mmc: core: Extend sysfs to ext_csd parameters for RPMB support
Date: Fri, 6 Jul 2012 10:44:02 +0200
Message-ID: <1341564244-6178-4-git-send-email-loic.pallardy@stericsson.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:44013 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752213Ab2GFJmP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jul 2012 05:42:15 -0400
In-Reply-To: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Loic Pallardy <loic.pallardy@stericsson.com>

Extend current sysfs access to ext_csd rpmb
parameters (RPMB partition size) and rel_sector
information.

Signed-off-by: Loic Pallardy <loic.pallardy@stericsson.com>
---
 Documentation/mmc/mmc-dev-attrs.txt | 7 +++++++
 drivers/mmc/core/mmc.c              | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
index 22ae844..0d98fac 100644
--- a/Documentation/mmc/mmc-dev-attrs.txt
+++ b/Documentation/mmc/mmc-dev-attrs.txt
@@ -25,6 +25,8 @@ All attributes are read-only.
 	serial			Product Serial Number (from CID Register)
 	erase_size		Erase group size
 	preferred_erase_size	Preferred erase size
+	raw_rpmb_size_mult	RPMB partition size
+	rel_sectors		Reliable write sector count
 
 Note on Erase Size and Preferred Erase Size:
 
@@ -65,6 +67,11 @@ Note on Erase Size and Preferred Erase Size:
 
 	"preferred_erase_size" is in bytes.
 
+Note on raw_rpmb_size_mult:
+	"raw_rpmb_size_mult" is a mutliple of 128kB block.
+	RPMB size in byte is calculated by using the following equation:
+	RPMB partition size = 128kB x raw_rpmb_size_mult
+
 SD/MMC/SDIO Clock Gating Attribute
 ==================================
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8a459cb..0f2449c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -615,6 +615,8 @@ MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
 		card->ext_csd.enhanced_area_offset);
 MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
+MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
+MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
 
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
@@ -630,6 +632,8 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_enhanced_area_offset.attr,
 	&dev_attr_enhanced_area_size.attr,
+	&dev_attr_raw_rpmb_size_mult.attr,
+	&dev_attr_rel_sectors.attr,
 	NULL,
 };
 
-- 
1.7.11.1

