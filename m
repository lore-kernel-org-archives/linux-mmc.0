From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH 1/1]mmc: implemented enhanced area feature for user data
	area
Date: Tue, 26 Oct 2010 18:26:17 +0800
Message-ID: <20101026102617.GA27707@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11503 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647Ab0JZK1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Oct 2010 06:27:07 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Hi,
	This patch implemented enhanced area feature defined in eMMC4.4
	standard.
	I have two understandings about this feature, but not sure about
	that.
	1) the enhanced area relative registers are onetime programmable, so
	driver supposes this feature will be enabled in eMMC manufacture line
	and driver only need to read them out and caclulate the offset/
	size and then export to user.
	2) As eMMC4.4 standard said, "if the partition parameters are sent to
	a device by CMD6 before setting ERASE_GROUP_DEF bit, the slave shows
	SWITCH_ERROR".(Page 31) So once the enhanced area was enabled and
	paremeters were already set, does driver still need to set the
	ERASE_GROUP_DEF bit each time during init card?
	If my understandings were wrong, correct me directly please.
	Thanks.

>From cb53d1b8c8a13a2c3db202f861b632dc5a763f1c Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Tue, 26 Oct 2010 17:56:06 +0800
Subject: [PATCH] mmc: implemented enhanced area feature for user data area

MMC driver can read out the enhanced user data area offset and size
from  ext_csd register, and exports out these values as sysfs interface
for user to use.

In this patch, driver will suppose that the enhanced user data area
feature was enabled in eMMC manufacture line since the relative
registers are onetime programmable.

In this patch, driver didn't set ERASE_GROUP_DEF byte in ext_csd
register.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/mmc.c   |   35 +++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |    3 +++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 995261f..9bb9fac 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -302,6 +302,35 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 	}
 
 	if (card->ext_csd.rev >= 4) {
+		/* Enhanced area feature support
+		 * check whether eMMC card is enabled enhanced area,
+		 * if so, export enhanced area offset and size to
+		 * user by adding sysfs interface
+		 * */
+		if ((ext_csd[160] & 0x2) && (ext_csd[156] & 0x1)) {
+			u8 hc_erase_grp_sz = ext_csd[224];
+			u8 hc_wp_grp_sz = ext_csd[221];
+			/* set a flag to identify whether the enhanced
+			 * user data are enabled
+			 * */
+			card->ext_csd.enh_data_area_en = 1;
+			/* caculate the enhanced data area offset, unit B
+			 * */
+			card->ext_csd.enh_data_area_off =
+				(ext_csd[139] << 24) + (ext_csd[138] << 16) +
+				(ext_csd[137] << 8) + ext_csd[136];
+			if (mmc_card_blockaddr(card))
+				card->ext_csd.enh_data_area_off <<= 9;
+			/* caculate the enhanced data area size, unit KB
+			 * */
+			card->ext_csd.enh_data_area_sz =
+				(ext_csd[142] << 16) + (ext_csd[141] << 8) +
+				ext_csd[140];
+			card->ext_csd.enh_data_area_sz *=
+				(size_t)(hc_erase_grp_sz * hc_wp_grp_sz);
+			card->ext_csd.enh_data_area_sz <<= 9;
+		}
+
 		card->ext_csd.sec_trim_mult =
 			ext_csd[EXT_CSD_SEC_TRIM_MULT];
 		card->ext_csd.sec_erase_mult =
@@ -336,6 +365,9 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
+MMC_DEV_ATTR(enhen, "%d\n", card->ext_csd.enh_data_area_en);
+MMC_DEV_ATTR(enhoff, "0x%llxB\n", card->ext_csd.enh_data_area_off);
+MMC_DEV_ATTR(enhsz, "0x%xKB\n", card->ext_csd.enh_data_area_sz);
 
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
@@ -349,6 +381,9 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_oemid.attr,
 	&dev_attr_serial.attr,
+	&dev_attr_enhen.attr,
+	&dev_attr_enhoff.attr,
+	&dev_attr_enhsz.attr,
 	NULL,
 };
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8ce0827..bf9e718 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -54,6 +54,9 @@ struct mmc_ext_csd {
 	unsigned int		sec_trim_mult;	/* Secure trim multiplier  */
 	unsigned int		sec_erase_mult;	/* Secure erase multiplier */
 	unsigned int		trim_timeout;		/* In milliseconds */
+	unsigned int		enh_data_area_en;
+	loff_t				enh_data_area_off;
+	size_t				enh_data_area_sz;
 };
 
 struct sd_scr {
-- 
1.6.6.1

