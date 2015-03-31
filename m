From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Convert the error field in struct mmc_command|data into an int
Date: Tue, 31 Mar 2015 13:36:29 +0200
Message-ID: <1427801789-23522-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35945 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbCaLge (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Mar 2015 07:36:34 -0400
Received: by lbbug6 with SMTP id ug6so10082538lbb.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2015 04:36:32 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Everybody expects the error field in the struct mmc_command|data to be
and int but it's actually an unsigned int. Let's convert it into an int
to meet the expectations.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/mmc/core.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index 160448f..de722d4e 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -79,7 +79,7 @@ struct mmc_command {
 #define mmc_cmd_type(cmd)	((cmd)->flags & MMC_CMD_MASK)
 
 	unsigned int		retries;	/* max number of retries */
-	unsigned int		error;		/* command error */
+	int			error;		/* command error */
 
 /*
  * Standard errno values are used for errors, but some have specific
@@ -108,7 +108,7 @@ struct mmc_data {
 	unsigned int		timeout_clks;	/* data timeout (in clocks) */
 	unsigned int		blksz;		/* data block size */
 	unsigned int		blocks;		/* number of blocks */
-	unsigned int		error;		/* data error */
+	int			error;		/* data error */
 	unsigned int		flags;
 
 #define MMC_DATA_WRITE	(1 << 8)
-- 
1.9.1

