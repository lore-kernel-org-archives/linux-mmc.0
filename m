From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH] MMC: Fix use of uninitialized data in mmc_cmd_app.
Date: Wed, 13 Apr 2011 15:33:12 -0500
Message-ID: <1302726792-4733-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:41209 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758336Ab1DMTyb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2011 15:54:31 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3DJqfGG003815
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 15:52:41 -0400 (EDT)
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com [209.85.160.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3DJqem4003807
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 15:52:40 -0400 (EDT)
Received: by gyb11 with SMTP id 11so396995gyb.15
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 12:54:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>

mmc_cmd_app did not zero out mmc_command on stack.

Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/core/sd_ops.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index 76af349..71fdb07 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -29,6 +29,8 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
 	BUG_ON(!host);
 	BUG_ON(card && (card->host != host));
 
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
 	cmd.opcode = MMC_APP_CMD;
 
 	if (card) {
-- 
1.7.0.4

