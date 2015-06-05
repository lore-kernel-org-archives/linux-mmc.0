From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V3 8/8] According to SD Physical Layer Specifications: Locked cards respond to (and execute) all commands in the "basic" command class (class 0), ACMD41, CMD16 and "lock card" command class. Thus, the host is allowed to reset, initialize, select, query for status, etc., but not to access data on the card.
Date: Fri, 5 Jun 2015 13:42:27 -0400
Message-ID: <1433526147-25941-9-git-send-email-alcooperx@gmail.com>
References: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:37070 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837AbbFESBZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 14:01:25 -0400
In-Reply-To: <1433526147-25941-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, pgynther@google.com
Cc: Abbas Raza <Abbas_Raza@mentor.com>, Al Cooper <alcooperx@gmail.com>, Chris Ball <cjb@laptop.org>

From: Abbas Raza <Abbas_Raza@mentor.com>

But when a locked card is inserted into system having no key added for
this card, following errors are observed until the card is removed

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
index 5650748..79c8861 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2026,6 +2026,13 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 		/* claim host only for the first request */
 		mmc_get_card(card);
 
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
1.9.0.138.g2de3478

