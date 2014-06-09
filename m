From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv6 1/2] mmc: dw_mmc: replace "disable-wp" from slot's quirk to
 host's quirk
Date: Mon, 09 Jun 2014 12:34:14 +0900
Message-ID: <1402284855-3968-2-git-send-email-jh80.chung@samsung.com>
References: <1402284855-3968-1-git-send-email-jh80.chung@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:64940 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbaFIDeT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Jun 2014 23:34:19 -0400
In-reply-to: <1402284855-3968-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, tgih.jun@samsung.com, devicetree@vger.kernel.org, =?UTF-8?q?Heiko=20St=FCbner?= <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>

Replaced the "disable-wp" into host's quirks.
(Because the slot-node is removed at dt-file.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
Changelog V6:
	-None
Changelog V5:
	- Modify comment.
Changelog V4:
	- Rename Subject
		"[PATCHv3 2/4] mmc: dw_mmc: use the __mmc_of_parse to parse the slot node"
	- Replace the "disable-wp" into host's quirks, according to remove the slot-node at dt-file.
Changelog V3:
	- Fix typo.
	- Maintained the dw_mci_of_quirks().
Changelog V2:
	- None

 drivers/mmc/host/dw_mmc.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 1ac227c..99fc939 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2006,12 +2006,7 @@ static struct device_node *dw_mci_of_find_slot_node(struct device *dev, u8 slot)
 static struct dw_mci_of_slot_quirks {
 	char *quirk;
 	int id;
-} of_slot_quirks[] = {
-	{
-		.quirk	= "disable-wp",
-		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
-	},
-};
+} of_slot_quirks[] = {};
 
 static int dw_mci_of_get_slot_quirks(struct device *dev, u8 slot)
 {
@@ -2238,6 +2233,9 @@ static struct dw_mci_of_quirks {
 	{
 		.quirk	= "broken-cd",
 		.id	= DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
+	}, {
+		.quirk	= "disable-wp",
+		.id	= DW_MCI_SLOT_QUIRK_NO_WRITE_PROTECT,
 	},
 };
 
-- 
1.7.9.5

