Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52A15CD4B
	for <linux-mmc@vger.kernel.org>; Wed, 10 Apr 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757960; cv=none; b=ihPDCrk+FfeJ9awc3wBR5ZtBBMEUHpGsYd6wDWBkRPOlNcr9CMQ2XY3f/cA2e+0wizA3V9b05FLcw/093Bf7xFqzOlcoyjZC4W26eFHiyowHwRzqfYfmEJ/DgCTSeCLl84eJdV2dpdngjK324Bu89ls6aWINo3ubI+wAu7PqSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757960; c=relaxed/simple;
	bh=ZjzPv6oCLgl1A0ga41DPf8do2ngSUhwX7c27dENo/qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvIneguWDzC1k61xKhNnaeyw5BxwD1T7Z3Ane2g+DHfdntSYXkqYmlUrGvzDm8wPdVMtSnxrzzyH6+ENedVtCUacDRjRtQiweoVeRwHXWxLGfPsB2XS90EBqL11wccn48C5DovObL2aEHuZU1R06RF85XE64M8j02c5jyEzfD/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaJ-0000RJ-Hp; Wed, 10 Apr 2024 16:05:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaJ-00BVS6-52; Wed, 10 Apr 2024 16:05:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYaJ-00Hb2q-0F;
	Wed, 10 Apr 2024 16:05:55 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] memstick: rtsx_usb_ms: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 16:05:50 +0200
Message-ID:  <80969cc7c08c613753bdf2270304983ed0dcc2a0.1712757795.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZjzPv6oCLgl1A0ga41DPf8do2ngSUhwX7c27dENo/qY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpy/cQ6HEdbvnLyMZ1nr3irRwNmI8b57pyBqo HpptUlVN3CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhacvwAKCRCPgPtYfRL+ TvilCACMNGg0SmkbkjV9TMxTQJ+pjyv/97MDmqgfFM1jjdZb3tVgxp7cS1G8u31vf8xFXIR+CGv 3eUSbGrl7TqOfcuwSzwaFe4Jja7elC5yuWg9n4QnTPNUtUKWYgwpUi8J/HKo58RtehpkhISrY1r aVAwlRFSIoVFvanV3JjMmrg1U9TCjsgdPAO9xv0ewrq9AKuwlIcsD1CgkKr4pDDRbr6j0DEatJ1 v+0vVTq3WIwNJnLifca+bZL7rBBn3fp2MFMua3zK4k0LVjJUdjL8BZw1hbPZH6wEb/WoXdNT6nD AOScDZP5YdJEEb4irqJX8DTG75VbVfn5lGuABs3sPyDVLceM
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
 drivers/memstick/host/rtsx_usb_ms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 29271ad4728a..246876ac713c 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -805,7 +805,7 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
+static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 {
 	struct rtsx_usb_ms *host = platform_get_drvdata(pdev);
 	struct memstick_host *msh = host->msh;
@@ -840,8 +840,6 @@ static int rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 		": Realtek USB Memstick controller has been removed\n");
 	memstick_free_host(msh);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct platform_device_id rtsx_usb_ms_ids[] = {
@@ -855,7 +853,7 @@ MODULE_DEVICE_TABLE(platform, rtsx_usb_ms_ids);
 
 static struct platform_driver rtsx_usb_ms_driver = {
 	.probe		= rtsx_usb_ms_drv_probe,
-	.remove		= rtsx_usb_ms_drv_remove,
+	.remove_new	= rtsx_usb_ms_drv_remove,
 	.id_table       = rtsx_usb_ms_ids,
 	.driver		= {
 		.name	= "rtsx_usb_ms",
-- 
2.43.0

