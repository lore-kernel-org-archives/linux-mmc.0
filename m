From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] cmds/read_extcsd: compute in seconds
Date: Thu,  5 Mar 2015 14:19:24 +0100
Message-ID: <1425561565-24806-3-git-send-email-bigeasy@linutronix.de>
References: <1425561565-24806-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49809 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbbCENTc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:19:32 -0500
In-Reply-To: <1425561565-24806-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The value in the register is * 100ms

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mmc_cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 3b35a932378d..8addd35046d7 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -815,6 +815,7 @@ int do_read_extcsd(int nargs, char **argv)
 
 		printf("1st Initialisation Time after programmed sector"
 			" [INI_TIMEOUT_AP: 0x%02x]\n", ext_csd[241]);
+		printf(" i.e. %.1f sec\n", ext_csd[241] * 100 / 1000.0);
 
 		/* A441: reserved [240] */
 		printf("Power class for 52MHz, DDR at 3.6V"
-- 
2.1.4

