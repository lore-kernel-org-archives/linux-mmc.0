Received: from mail03.siengine.com (mail03.siengine.com [43.240.192.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA3B39B970;
	Tue,  2 Jun 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.240.192.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780380009; cv=none; b=l5u0n4wwmZFbK2cl1acTztXKFDGgbZFcUH8RHATTa6c0WBkGLIeU+pm0hJqVEudO61GaSNKF45s/zKrxjED663Kq6gh+bjImDhLOYK44LXb7oMEPRWt7LUpEx+h8P9qQ1CKiRHkjfLvEIdH19X4LEtkYrbLj/y0u0/L7QRljOfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780380009; c=relaxed/simple;
	bh=l5cgRYe2X9duXmHiqIS2NyYbNwskPPDWjLu1rjZXpcg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbD/CBgkQvUuE1P5DS5JPfphHu65zJvUuCye9F3cWeJ9DSBoOztpl1P93+2meRe9SIUv9Sgk1gEkhWtas+Ru4a9R1sD8KqrIelIC2uP0+1OiNqP8tczQLG4sws7dxt/0f5aGehjelU+wVuGGt/viG30DtX/n8mQZmeX3O7lc9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com; spf=pass smtp.mailfrom=siengine.com; arc=none smtp.client-ip=43.240.192.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siengine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siengine.com
Received: from mail03.siengine.com (localhost [127.0.0.2] (may be forged))
	by mail03.siengine.com with ESMTP id 6525xhvl077570;
	Tue, 2 Jun 2026 13:59:43 +0800 (+08)
	(envelope-from lucas.liu@siengine.com)
Received: from dsgsiengine01.siengine.com ([10.8.1.61])
	by mail03.siengine.com with ESMTPS id 6525xFFp077464
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 13:59:15 +0800 (+08)
	(envelope-from lucas.liu@siengine.com)
Received: from SEEXMB05-2019.siengine.com (SEEXMB05-2019.siengine.com [10.8.1.153])
	by dsgsiengine01.siengine.com (SkyGuard) with ESMTPS id 4gV0X501fMz2SsXR;
	Tue,  2 Jun 2026 13:59:17 +0800 (CST)
Received: from SEEXMB03-2019.siengine.com (10.8.1.33) by
 SEEXMB05-2019.siengine.com (10.8.1.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 13:59:15 +0800
Received: from localhost (10.12.6.21) by SEEXMB03-2019.siengine.com
 (10.8.1.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.2.2562.37 via Frontend
 Transport; Tue, 2 Jun 2026 13:59:15 +0800
From: "baozhu.liu" <lucas.liu@siengine.com>
To: <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "baozhu.liu"
	<lucas.liu@siengine.com>
Subject: [PATCH] mmc: Update the value of ios.drv_type at the location where fixed_drv_type is used
Date: Tue, 2 Jun 2026 14:10:01 +0800
Message-ID: <20260602061001.63579-1-lucas.liu@siengine.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-DKIM-Results: [10.8.1.61]; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:mail03.siengine.com 6525xhvl077570

Modify the value of "fixed-emmc-driver-type" in the device tree,
but when checking "cat /sys/kernel/debug/mmc/ios",
it is found that the driver type has not changed.
So, update the value of ios.drv_type at the location
where fixed_drv_type is used.

Signed-off-by: baozhu.liu <lucas.liu@siengine.com>
---
 drivers/mmc/core/mmc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 05444ecf3909..773d496b856a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1361,14 +1361,15 @@ static void mmc_select_driver_type(struct mmc_card *card)
 	card_drv_type = card->ext_csd.raw_driver_strength |
 			mmc_driver_type_mask(0);
 
-	if (fixed_drv_type >= 0)
+	if (fixed_drv_type >= 0) {
 		drive_strength = card_drv_type & mmc_driver_type_mask(fixed_drv_type)
 				 ? fixed_drv_type : 0;
-	else
+		card->host->ios.drv_type = drive_strength;
+	} else {
 		drive_strength = mmc_select_drive_strength(card,
 							   card->ext_csd.hs200_max_dtr,
 							   card_drv_type, &drv_type);
-
+	}
 	card->drive_strength = drive_strength;
 
 	if (fixed_drv_type >= 0 && drive_strength)
-- 
2.34.1

