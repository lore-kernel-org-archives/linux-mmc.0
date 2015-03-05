From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] cmds/read_extcsd: allow mmc 5.0
Date: Thu,  5 Mar 2015 14:19:23 +0100
Message-ID: <1425561565-24806-2-git-send-email-bigeasy@linutronix.de>
References: <1425561565-24806-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49813 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbbCENTk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2015 08:19:40 -0500
In-Reply-To: <1425561565-24806-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Have here a mmc 5.0 card

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mmc_cmds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index cea943f63241..3b35a932378d 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -726,6 +726,9 @@ int do_read_extcsd(int nargs, char **argv)
 	ext_csd_rev = ext_csd[192];
 
 	switch (ext_csd_rev) {
+	case 7:
+		str = "5.0";
+		break;
 	case 6:
 		str = "4.5";
 		break;
-- 
2.1.4

