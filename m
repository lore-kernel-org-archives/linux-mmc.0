Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4E115B0F4
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757961; cv=none; b=uVBSBmCm/FgX2lIBFG+hHvOA8aMxdSzGl9cdKZJaeM8kADnr4IjDAKFkStjkHdS9AxjIaqRHZYp4MiWO05Fp5S3hLMJ0rC7cc0gtiB11QuZD/ppsaMuekXmWoDkNRtaIkdHaCtT0z3pD8SZMel7YTEvkkZetE7JRejyE/XqvWTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757961; c=relaxed/simple;
	bh=XI760DIC4FylZDpPbaZopO349gmj/Vp0j2N5bhLPphs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLPZKx+EtwODBPXeMbuUKOU0+5n6uLu3KBzGQuziJGCwHFegwJqVRQHr3EE1Lb6eE6jBqmNcIrsAkjsfM7dyO8tANlpCGMunKvEysGeu+WJluxEPJi94c4fWWFiK+mdwDcTxH1PHMlt/PDRufbTbeytjja3FzXnZJVea7IPSyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaJ-0000R2-BY; Wed, 10 Apr 2024 16:05:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaI-00BVS3-Ux; Wed, 10 Apr 2024 16:05:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaI-00Hb2m-2q;
	Wed, 10 Apr 2024 16:05:54 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/3] memstick: rtsx_pci_ms: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 16:05:49 +0200
Message-ID:  <512d6b6a4d3b8a02cee28635a936340f5f70c65e.1712757795.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712757795.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712757795.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XI760DIC4FylZDpPbaZopO349gmj/Vp0j2N5bhLPphs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpy+n6Jff9g1M4g3mKm7blKpqcpLouhLiEtYR fT2DhU3C/WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhacvgAKCRCPgPtYfRL+ TiOcB/0c1uDyb9XLhJx7XmWXxihH5+gu1gYICvPcPXM0N/s4yOdKFje9Y8uRM4vpdGKKAkmdVIR eN6Niywx/hJDZvdXGcf3fsXaJ1nsybRU7zurUXqJ79WGaBbIpGGpTB7tquFsRIFr8UfpRxJJjQO ggzuWJ+fbb4aStgYYgtgQ7rGYjIuLY67NH05sA9LE7Zt1fPyS1pbIrCa8rMyKAWgr7QShKGz8Dm WWGRFOqApamr/HggJz9Fp57e5HPM3/M04jONwlCs4q655jy94IsynbDlPqfbUgX6NnERlNnJQWG UeYAl3AoYjpP2lmN5FjcnNQPt6KvY6JRoKu/4/ivbZiW+p06
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/memstick/host/rtsx_pci_ms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/rtsx_pci_ms.c b/drivers/memstick/host/rtsx_pci_ms.c
index 7c6dba6de230..980a54513e6c 100644
--- a/drivers/memstick/host/rtsx_pci_ms.c
+++ b/drivers/memstick/host/rtsx_pci_ms.c
@@ -574,7 +574,7 @@ static int rtsx_pci_ms_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rtsx_pci_ms_drv_remove(struct platform_device *pdev)
+static void rtsx_pci_ms_drv_remove(struct platform_device *pdev)
 {
 	struct realtek_pci_ms *host = platform_get_drvdata(pdev);
 	struct rtsx_pcr *pcr;
@@ -610,8 +610,6 @@ static int rtsx_pci_ms_drv_remove(struct platform_device *pdev)
 
 	dev_dbg(&(pdev->dev),
 		": Realtek PCI-E Memstick controller has been removed\n");
-
-	return 0;
 }
 
 static struct platform_device_id rtsx_pci_ms_ids[] = {
@@ -625,7 +623,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_pci_ms_ids);
 
 static struct platform_driver rtsx_pci_ms_driver = {
 	.probe		= rtsx_pci_ms_drv_probe,
-	.remove		= rtsx_pci_ms_drv_remove,
+	.remove_new	= rtsx_pci_ms_drv_remove,
 	.id_table       = rtsx_pci_ms_ids,
 	.suspend	= rtsx_pci_ms_suspend,
 	.resume		= rtsx_pci_ms_resume,
-- 
2.43.0

