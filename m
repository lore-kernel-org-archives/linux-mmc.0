From: Frank Bormann <fbormann@yahoo.com>
Subject: Inconsistency in MMC EXT_CSD configuration
Date: Wed, 26 Feb 2014 17:54:47 -0500
Message-ID: <530E70B7.70307@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from nm38-vm9.bullet.mail.bf1.yahoo.com ([72.30.239.25]:28491 "EHLO
	nm38-vm9.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751445AbaBZXA2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2014 18:00:28 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>

Hi Everyone,

I seem to have found a bug in the MMC kernel driver, particularly when 
reading/writing configuration to EXT_CSD register 179 (PARTITION_CONFIG). This 
register is being used to switch between the different partitions on a mmc card 
(boot0, boot1, user). The kernel seems to read the EXT_CSD once in 
mmc_init_card() and then keeps a copy of this register's contents in the 
part_config member of struct mmc_card. Whenever it has to switch to a different
mmc partition, it reads the internal copy of that register's contents, modifies 
the bits for PARTITION_ACCESS and then write the result back to the EXT_CSD.
This doesn't take into account any changes that have been made to other 
configuration in that same register (BOOT_PARTITION_ENABLE, BOOT_ACK) from user 
space through mmc-utils.

As a result, configuration made to the PARTITION_CONFIG register through 
mmc-utils, will get reverted whenever the kernel needs to switch to a different 
mmc partition.

I have attached a small patch that solves this problem for me. However, I am not 
sure, if I accounted for all the possible code paths that may change EXT_CSD 
register 179.

The patch is against linux-stable from today.

Any input on this is highly appreciated.

Thanks,
Frank

----

From: Frank Bormann <fbormann@yahoo.com>
Date: Wed, 26 Feb 2014 17:13:43 -0500
Subject: [PATCH] Remember changes to PARTITON_CONFIG [179] EXT_CSD register
  across accesses of multiple partitions (boot0, boot1, user)
  of the same card.

---
  drivers/mmc/card/block.c |   17 +++++++++++++++++
  include/linux/mmc/mmc.h  |   16 ++++++++++++++++
  2 files changed, 33 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 7b5424f..8002583 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -588,6 +588,23 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
  >------>-------}
  >------}
~
+>------if (cmd.opcode == MMC_SWITCH
+>------>-------&& (cmd.arg & MMC_SWITCH_INDEX_MASK) >> MMC_SWITCH_INDEX_SHIFT
+>------>-------== EXT_CSD_PART_CONFIG) {
+>------>-------u8 val = (cmd.arg & MMC_SWITCH_VALUE_MASK) >> 
MMC_SWITCH_VALUE_SHIFT;
+>------>-------switch ((cmd.arg & MMC_SWITCH_MODE_MASK) >> MMC_SWITCH_MODE_SHIFT) {
+>------>-------case MMC_SWITCH_MODE_SET_BITS:
+>------>------->-------card->ext_csd.part_config |= val;
+>------>------->-------break;
+>------>-------case MMC_SWITCH_MODE_CLEAR_BITS:
+>------>------->-------card->ext_csd.part_config &= ~val;
+>------>------->-------break;
+>------>-------case MMC_SWITCH_MODE_WRITE_BYTE:
+>------>------->-------card->ext_csd.part_config = val;
+>------>------->-------break;
+>------>-------}
+>------}
+
  >------if (is_rpmb) {
  >------>-------/*
  >------>------- * Ensure RPMB command has completed by polling CMD13
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 50bcde3..241aa13 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -413,9 +413,25 @@ struct _mmc_csd {
   * MMC_SWITCH access modes
   */
~
+#define MMC_SWITCH_MODE_SHIFT>->-------24
+#define MMC_SWITCH_MODE_MASK>-->-------(0x03<<MMC_SWITCH_MODE_SHIFT)
  #define MMC_SWITCH_MODE_CMD_SET>------->-------0x00>---/* Change the command 
set */
  #define MMC_SWITCH_MODE_SET_BITS>------0x01>---/* Set bits which are 1 in value */
  #define MMC_SWITCH_MODE_CLEAR_BITS>----0x02>---/* Clear bits which are 1 in 
value */
  #define MMC_SWITCH_MODE_WRITE_BYTE>----0x03>---/* Set target to value */
~
+/*
+ * MMC_SWITCH index
+ */
+
+#define MMC_SWITCH_INDEX_SHIFT>>-------16
+#define MMC_SWITCH_INDEX_MASK>->-------(0xFF<<MMC_SWITCH_INDEX_SHIFT)
+
+/*
+ * MMC_SWITCH value
+ */
+
+#define MMC_SWITCH_VALUE_SHIFT>>-------8
+#define MMC_SWITCH_VALUE_MASK>->-------(0xFF<<MMC_SWITCH_VALUE_SHIFT)
+
  #endif /* LINUX_MMC_MMC_H */
--~
1.7.10.4
