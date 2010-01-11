From: Johan Kristell <johan.kristell@axis.com>
Subject: [patch] mmc_test: block addressed cards
Date: Mon, 11 Jan 2010 13:32:48 +0100
Message-ID: <4B4B1A70.5060202@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from krynn.se.axis.com ([193.13.178.10]:38920 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0AKNAF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jan 2010 08:00:05 -0500
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o0BCWmPO021247
	for <linux-mmc@vger.kernel.org>; Mon, 11 Jan 2010 13:32:48 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

The tests in mmc_test assumes that all cards are byte addressable.
This patch updates the tests to also work with cards that use block
addresses.

	Signed-off-by: Johan Kristell <johan.kristell@axis.com>
---

--- linux-2.6/drivers/mmc/card/mmc_test.c	2010-01-11 10:57:02.000000000 +0100
+++ linux-2.6-devel/drivers/mmc/card/mmc_test.c	2010-01-11 09:52:42.000000000 +0100
@@ -74,6 +74,9 @@ static void mmc_test_prepare_mrq(struct 
 	}
 
 	mrq->cmd->arg = dev_addr;
+	if (!mmc_card_blockaddr(test->card))
+		mrq->cmd->arg <<= 9;
+
 	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 
 	if (blocks == 1)
@@ -190,7 +193,7 @@ static int __mmc_test_prepare(struct mmc
 	}
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -219,7 +222,7 @@ static int mmc_test_cleanup(struct mmc_t
 	memset(test->buffer, 0, 512);
 
 	for (i = 0;i < BUFFER_SIZE / 512;i++) {
-		ret = mmc_test_buffer_transfer(test, test->buffer, i * 512, 512, 1);
+		ret = mmc_test_buffer_transfer(test, test->buffer, i, 512, 1);
 		if (ret)
 			return ret;
 	}
@@ -426,7 +429,7 @@ static int mmc_test_transfer(struct mmc_
 		for (i = 0;i < sectors;i++) {
 			ret = mmc_test_buffer_transfer(test,
 				test->buffer + i * 512,
-				dev_addr + i * 512, 512, 0);
+				dev_addr + i, 512, 0);
 			if (ret)
 				return ret;
 		}
