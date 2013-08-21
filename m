From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 1/3] mmc: core: do power-off with resume failure
Date: Wed, 21 Aug 2013 21:42:20 +0900
Message-ID: <002201ce9e6b$e0b32850$a21978f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48311 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3HUMmW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Aug 2013 08:42:22 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRV00FJMSML7AG0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 21 Aug 2013 21:42:21 +0900 (KST)
References: 
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>

Currently there is no mmc_power_off() when resume failed.
Somehow, state from mmc_power_on() will be kept. This change
makes a pair with its use in case of failure.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c  |    3 +++
 drivers/mmc/core/sd.c   |    3 +++
 drivers/mmc/core/sdio.c |    3 +++
 3 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d02012..704a561 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1536,6 +1536,9 @@ static int mmc_resume(struct mmc_host *host)
 	mmc_power_up(host);
 	mmc_select_voltage(host, host->ocr);
 	err = mmc_init_card(host, host->ocr, host->card);
+	if (err)
+		mmc_power_off(host);
+
 	mmc_release_host(host);
 
 	return err;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 176d125..2690ae1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1099,6 +1099,9 @@ static int mmc_sd_resume(struct mmc_host *host)
 	mmc_power_up(host);
 	mmc_select_voltage(host, host->ocr);
 	err = mmc_sd_init_card(host, host->ocr, host->card);
+	if (err)
+		mmc_power_off(host);
+
 	mmc_release_host(host);
 
 	return err;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 80d89cf..8c65669 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1033,6 +1033,9 @@ static int mmc_sdio_resume(struct mmc_host *host)
 		}
 	}
 
+	if (err && !mmc_card_keep_power(host))
+		mmc_power_off(host);
+
 	host->pm_flags &= ~MMC_PM_KEEP_POWER;
 	return err;
 }
-- 
1.7.0.4


