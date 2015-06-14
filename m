From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] mmc: sh_mmcif: Fix suspend process
Date: Mon, 15 Jun 2015 02:20:43 +0900
Message-ID: <1434302443-30905-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:34084 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbFNRVP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Jun 2015 13:21:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

The clock should be enable when SDHI registers are accessed.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on mmc-next branch of Ulf Hansson's mmc tree.

* Perhaps this relates to the need to enhance clock management

 drivers/mmc/host/sh_mmcif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5a1fdd4..ad9ffea 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1632,7 +1632,9 @@ static int sh_mmcif_suspend(struct device *dev)
 {
 	struct sh_mmcif_host *host = dev_get_drvdata(dev);
 
+	pm_runtime_get_sync(dev);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
+	pm_runtime_put(dev);
 
 	return 0;
 }
-- 
1.9.1

