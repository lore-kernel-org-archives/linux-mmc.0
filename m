From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 05/15] mmc: core: Remove unnecessary 'out of memory' message
Date: Tue, 21 Oct 2014 19:19:03 +0200
Message-ID: <1413911953-19012-6-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:33690 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117AbaJURT2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:28 -0400
Received: by mail-la0-f52.google.com with SMTP id hz20so1463684lab.39
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:27 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Rely on the prints handled internally by kmalloc().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 185d114..1ed3d82 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -198,11 +198,8 @@ static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	 * raw block in mmc_card.
 	 */
 	ext_csd = kmalloc(512, GFP_KERNEL);
-	if (!ext_csd) {
-		pr_err("%s: could not allocate a buffer to "
-			"receive the ext_csd.\n", mmc_hostname(card->host));
+	if (!ext_csd)
 		return -ENOMEM;
-	}
 
 	err = mmc_send_ext_csd(card, ext_csd);
 	if (err) {
-- 
1.9.1

