From: Robin van der Gracht <robin@protonic.nl>
Subject: [PATCH] mmc: core: Fixed bug in one erase-group budget TRIM
Date: Tue,  4 Aug 2015 08:58:33 +0200
Message-ID: <1438671513-16218-1-git-send-email-robin@protonic.nl>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:4109 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbbHDH0p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Aug 2015 03:26:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: david@protonic.nl, linux-mmc@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>

When requesting a trim for several bytes, everything up to the next
erase-group is erased. This causes data corruption.

Signed-off-by: Robin van der Gracht <robin@protonic.nl>
---
 drivers/mmc/core/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 083cade..57edb2a 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2227,9 +2227,8 @@ int mmc_erase(struct mmc_card *card, unsigned int from, unsigned int nr,
 	 * and call mmc_do_erase() twice if necessary. This special case is
 	 * identified by the card->eg_boundary flag.
 	 */
-	if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) &&
-	    (from % card->erase_size)) {
-		rem = card->erase_size - (from % card->erase_size);
+	rem = card->erase_size - (from % card->erase_size);
+	if ((arg & MMC_TRIM_ARGS) && (card->eg_boundary) && (nr > rem)) {
 		err = mmc_do_erase(card, from, from + rem - 1, arg);
 		from += rem;
 		if ((err) || (to <= from))
-- 
2.1.4

