From: Abbas Raza <abbas_raza@mentor.com>
Subject: [PATCH 1/2] mmc: lock: skip regular block io operations for locked cards
Date: Fri, 20 Dec 2013 05:43:54 +0500
Message-ID: <1387500235-10590-1-git-send-email-abbas_raza@mentor.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:43809 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab3LTAoD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 19:44:03 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Abbas Raza <Abbas_Raza@mentor.com>, Al Cooper <alcooperx@gmail.com>, Chris Ball <cjb@laptop.org>

From: Abbas Raza <Abbas_Raza@mentor.com>

According to SD Physical Layer Specifications:
Locked cards respond to (and execute) all commands in the "basic"
command class (class 0), ACMD41, CMD16 and "lock card" command class.
Thus, the host is allowed to reset, initialize, select, query for status,
etc., but not to access data on the card.

But when a locked card is inserted into system having no key added for
this card, following errors are observed untill the card is removed

[   36.955193] mmc0: card is locked.
[   36.959746] mmc (null): Error, request_key -2
[   36.964622] mmc0: Cannot find matching key
[   36.968765] mmc0: Card unlock failed.
[   36.972717] mmc0: new SDHC card at address 0002
[   36.977747] mmcblk0: mmc0:0002 00000 7.41 GiB
[   36.989596] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   36.999630] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   37.009604] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   37.019574] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   37.029548] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   37.039514] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   37.046729] end_request: I/O error, dev mmcblk0, sector 15556480
[   37.052813] Buffer I/O error on device mmcblk0, logical block 1944560
[   37.062139] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   37.072106] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   37.082072] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
.............
[   46.249273] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   46.259247] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   46.269215] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   46.279183] mmcblk0: timed out sending r/w cmd command, card status 0x2400900
[   46.289151] mmcblk0: timed out sending r/w cmd command, card status 0x2400900

As a workaround, skip all the regular block io operations if the card is locked.
One can unlock the card after system boot by following below steps
1) Add key for this card.
2) Unlock the card using sysfs attribute 'unlock_retry' for this card.

Cc: Al Cooper <alcooperx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
---
 drivers/mmc/card/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index bda7291..ac58224 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1477,6 +1477,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* claim host only for the first request */
 		mmc_claim_host(card->host);
 
+	if (mmc_card_locked(card)) {
+		if (req)
+			blk_end_request_all(req, 0);
+		ret = 0;
+		goto out;
+	}
+
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
 		if (req) {
-- 
1.8.3.2

