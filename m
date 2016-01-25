From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: mmc_test: mention that '0' runs all tests
Date: Mon, 25 Jan 2016 20:20:04 +0100
Message-ID: <1453749604-2236-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33219 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489AbcAYTUQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jan 2016 14:20:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

I had to use the source to determine what I need to write to 'test' so
that all tests are run. Let's mention this explicitly in 'testlist'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/card/mmc_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 7fc9174d46191a..c032eef45762c1 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2829,6 +2829,7 @@ static int mtf_testlist_show(struct seq_file *sf, void *data)
 
 	mutex_lock(&mmc_test_lock);
 
+	seq_printf(sf, "0:\tRun all tests\n");
 	for (i = 0; i < ARRAY_SIZE(mmc_test_cases); i++)
 		seq_printf(sf, "%d:\t%s\n", i+1, mmc_test_cases[i].name);
 
-- 
2.1.4

