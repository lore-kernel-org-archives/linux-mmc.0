From: Chris Ball <cjb@laptop.org>
Subject: Re: When bus width detection procedure takes place, kernel cannot lock on correct bus width
Date: Thu, 04 Apr 2013 15:37:20 -0400
Message-ID: <87txnmnl3j.fsf@octavius.laptop.org>
References: <87ip4qdybr.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47230 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764661Ab3DDThZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 15:37:25 -0400
In-Reply-To: <87ip4qdybr.fsf@octavius.laptop.org> (Chris Ball's message of
	"Sun, 17 Mar 2013 08:07:20 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: elad.yi@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@nvidia.com>

From: Philip Rakity <prakity@yahoo.com>
Subject: [PATCH] mmc: core: Fix bit width test failing on old eMMC cards

PARTITION_SUPPORT needs to be set before doing the compare on version
number so the bit width test does not get invalid data.  Before this
patch, a Sandisk iNAND eMMC card would detect 1-bit width although
the hardware supports 4-bit.

Only affects old emmc devices - pre 4.4 devices.

Reported-by: Elad Yi <elad.yi@gmail.com>
Signed-off-by: Philip Rakity <prakity@yahoo.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index d584f7c..0cbd1ef 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -369,13 +369,13 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT];
 	card->ext_csd.raw_trim_mult =
 		ext_csd[EXT_CSD_TRIM_MULT];
+	card->ext_csd.raw_partition_support = ext_csd[EXT_CSD_PARTITION_SUPPORT];
 	if (card->ext_csd.rev >= 4) {
 		/*
 		 * Enhanced area feature support -- check whether the eMMC
 		 * card has the Enhanced area enabled.  If so, export enhanced
 		 * area offset and size to user by adding sysfs interface.
 		 */
-		card->ext_csd.raw_partition_support = ext_csd[EXT_CSD_PARTITION_SUPPORT];
 		if ((ext_csd[EXT_CSD_PARTITION_SUPPORT] & 0x2) &&
 		    (ext_csd[EXT_CSD_PARTITION_ATTRIBUTE] & 0x1)) {
 			hc_erase_grp_sz =
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
