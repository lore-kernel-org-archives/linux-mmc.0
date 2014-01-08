From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/3] mmc: mmc_spi: remove unnecessary spi_set_drvdata()
Date: Wed, 08 Jan 2014 10:51:03 +0900
Message-ID: <000301cf0c14$1666f880$4334e980$%han@samsung.com>
References: <000001cf0c13$dcea0570$96be1050$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41165 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbaAHBvF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jan 2014 20:51:05 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MZ20091L7T3VJ00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 08 Jan 2014 10:51:04 +0900 (KST)
In-reply-to: <000001cf0c13$dcea0570$96be1050$%han@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jiri Kosina' <jkosina@suse.cz>
Cc: trivial@kernel.org, 'Chris Ball' <chris@printf.net>, linux-mmc@vger.kernel.org, 'Sonic Zhang' <sonic.zhang@analog.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/mmc/host/mmc_spi.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 40770a5..4c5e279 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1472,7 +1472,6 @@ fail_glue_init:
 fail_nobuf1:
 	mmc_free_host(mmc);
 	mmc_spi_put_pdata(spi);
-	spi_set_drvdata(spi, NULL);
 
 nomem:
 	kfree(ones);
@@ -1507,7 +1506,6 @@ static int mmc_spi_remove(struct spi_device *spi)
 		spi->max_speed_hz = mmc->f_max;
 		mmc_free_host(mmc);
 		mmc_spi_put_pdata(spi);
-		spi_set_drvdata(spi, NULL);
 	}
 	return 0;
 }
-- 
1.7.10.4


