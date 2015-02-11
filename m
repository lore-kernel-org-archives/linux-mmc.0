From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC] mmc: Do no export the rpmb as a partition
Date: Wed, 11 Feb 2015 17:30:20 +0100
Message-ID: <1423672220-13744-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52701 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594AbbBKQa3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Feb 2015 11:30:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I have here a SK-Hynix eMMC media which is eMMC 5.0 compatible (according to
the manual). I read / write the media and haven't noticed anything odd.
Then I tried to boot using systemd :)
Systemd needs to touch everything and so it tried to read from the rpmb
partition. The results were not good.
The MMC core sends first CMD18 which ends with -110 after a few secs. CMD17
ends with the same error "immediately".
Looking into the "JEDEC STANDARD Embedded Multi-Media Card (eMMC) Electrical
Standard (5.01)" / JESD84-B50.1" I read the following in "6.2.2 Command
restrictions":
|RPMB Partition
|o  Only commands of classes Class0, Class2 and Class4 are admitted. Still usage of any
|   other command than CMD0, CMD6, CMD8, CMD12, CMD13, CMD15 or commands
|   defined in 6.6.25 shall be considered as illegal one.

CMD17 + CMD18 are part of Class 2 (and therefore legal) however the later
enumeration commands excludes CMD17 + 18 from beeing legal.

So my question is basically, is it okay to read from this partition?

Here is output of "dd if=/dev/mmcblk0rpmb of=/dev/null count=1"
Single read only:
[  625.881087] mmc0: starting CMD6 arg 03b30301 flags 0000049d
[  625.888813] mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
[  625.895659] mmc0: starting CMD13 arg 00010000 flags 00000195
[  625.901360] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[  625.908255] mmc0: starting CMD17 arg 00000000 flags 000000b5
[  625.913934] mmc0:     blksz 512 blocks 1 flags 00000200 tsac 150 ms nsac 1000
[  625.921114] mmc0: req done (CMD17): -110: 00000000 00000000 00000000 00000000
[  625.928253] mmc0:     0 bytes transferred: 0
[  625.932547] mmc0: starting CMD13 arg 00010000 flags 00000195
[  625.938228] mmc0: req done (CMD13): 0: 00400900 00000000 00000000 00000000
[  625.945129] mmcblk0rpmb: timed out sending r/w cmd command, card status 0x400900

Multi read:
[   14.257869] mmc0: starting CMD6 arg 03b30301 flags 0000049d
[   14.265570] mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
[   14.272398] mmc0: starting CMD13 arg 00010000 flags 00000195
[   14.278083] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   14.284997] <mmc0: starting CMD23 arg 00000020 flags 00000015>
[   14.290846] mmc0: starting CMD18 arg 00000000 flags 000000b5
[   14.296508] mmc0:     blksz 512 blocks 32 flags 00000200 tsac 150 ms nsac 1000
[   14.303742] mmc0:     CMD12 arg 00000000 flags 00000095
[   19.737209] mmc0: req done <CMD23>: 0: 00000000 00000000 00000000 00000000
[   19.744089] mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
[   19.750964] mmc0:     0 bytes transferred: -110
[   19.755495] mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
[   19.761963] mmc0: starting CMD13 arg 00010000 flags 00000195
[   19.767646] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   19.774558] mmcblk0rpmb: error -110 transferring data, sector 0, nr 32, cmd response 0x900, card status 0xb00

and then, there is this dead mode:
[   44.055345] mmc0: starting CMD6 arg 03b30301 flags 0000049d
[   44.063039] mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
[   44.069849] mmc0: starting CMD13 arg 00010000 flags 00000195
[   44.075559] mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
[   44.082460] mmc0: Card stuck in programming state! __mmc_switch
[   44.088386] blk_update_request: I/O error, dev mmcblk0rpmb, sector 0

mostly the same thing as above except that it dies within CMD13. After that it
does not boot from eMMC and the eMMC looks dead if I boot differently. A few
minutes powerless and everything is back to normal.
At this point I am not sure if access to the rpmb is a problem or a problem at
surface and I should be chasing something else.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mmc/core/mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7466ce098e60..52faf8f4f45f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -512,6 +512,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		/*
 		 * RPMB regions are defined in multiples of 128K.
 		 */
+#if 0
 		card->ext_csd.raw_rpmb_size_mult = ext_csd[EXT_CSD_RPMB_MULT];
 		if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host)) {
 			mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
@@ -519,6 +520,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 				"rpmb", 0, false,
 				MMC_BLK_DATA_AREA_RPMB);
 		}
+#endif
 	}
 
 	card->ext_csd.raw_erased_mem_count = ext_csd[EXT_CSD_ERASED_MEM_CONT];
-- 
2.1.4

