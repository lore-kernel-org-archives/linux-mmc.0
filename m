From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: MMC_SWITCH command doesn't update the ext_csd data structure
Date: Tue, 3 Sep 2013 13:04:43 +0200
Message-ID: <5225C24B.9020705@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:57804 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab3ICLE4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Sep 2013 07:04:56 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

using the MMC_SWITCH command via the ioctl to write registers of the 
EXT_CSD, it looks to us that in this case the internal ext_csd data 
structure isn't updated. Resulting in a mismatch of what the ext_csd 
data structure contains and what's written to the real hardware.

We are using the mmc utils [1] to e.g. enable the bootpart

mmc bootpart enable 1 0 /dev/mmcblk1

This correctly writes to the EXT_CSD structure of the device, but 
doesn't update

card->ext_csd.part_config

Issuing additional MMC_SWITCH commands afterwards use the then (wrong) 
card->ext_csd.part_config. Resulting in a undo of the mmc bootpart enable.

What we think might be necessary here is anything like

--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -542,11 +544,17 @@ static int mmc_blk_ioctl_cmd(struct block_device 
*bdev,
                                         __func__, status, err);
         }

+       if ((cmd.opcode == MMC_SWITCH) && ((cmd.arg >> 24) & 0x3)) {
+               /* In case the IOCTL has modified the EXT_CSD, update 
it, i.e. re-read the EXT_CSD */
+		mmc_update_ext_csd(card->ext_csd);
+       }
+
  cmd_rel_host:
         mmc_release_host(card->host);

?

Opinions?

Best regards

Dirk

[1] https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc-utils.git/

