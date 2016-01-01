From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 4/7] mmc: sh_mmcif: use to_delayed_work
Date: Fri,  1 Jan 2016 22:59:09 +0800
Message-ID: <580d73236305b902cbd6fe7b7880d3e6a6d3a382.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m50-132.163.com ([123.125.50.132]:48031 "EHLO m50-132.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbcAAPAH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Jan 2016 10:00:07 -0500
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
In-Reply-To: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
References: <643e31066f3378b9521dd9cd8c569ccfcf185d61.1451659910.git.geliangtang@163.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Use to_delayed_work() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 1ca8a13..e0c076a 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1395,7 +1395,7 @@ static irqreturn_t sh_mmcif_intr(int irq, void *dev_id)
 
 static void sh_mmcif_timeout_work(struct work_struct *work)
 {
-	struct delayed_work *d = container_of(work, struct delayed_work, work);
+	struct delayed_work *d = to_delayed_work(work);
 	struct sh_mmcif_host *host = container_of(d, struct sh_mmcif_host, timeout_work);
 	struct mmc_request *mrq = host->mrq;
 	struct device *dev = sh_mmcif_host_to_dev(host);
-- 
2.5.0


