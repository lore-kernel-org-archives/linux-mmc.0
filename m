Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C4145A10;
	Thu, 15 Aug 2024 20:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752948; cv=none; b=oYG+jAbLzl0qZtz5Y51r8hdAlfXMKKzi0ZKJlgt4vBCqJmC3+7sqE1/TgKogaXFIR2K7gXf/NRM33qRBS13sqh6pflpBc4KcK3Xn02fRohNgCC4khWQFYZ43ZOWApHI4mgXtOD6nfWUElPDNyxTxV13c2PtPutnxSRIouSkymHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752948; c=relaxed/simple;
	bh=MlJ5vaPp1eSSvnOrsFlA7F71uknwIDZzl18yJKkjcuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H44PLuzJoHYueqY11YLhLwoYf5lwU3vvPTGQFocRGe0e4U+EGKlQ0Ly0Wb5IzxDYDc+GAABAvvvfjd9CSIM+oGZL4CuG2xFICm8vFoTPiPxT6toCktGZ2UWwYQ44OS/42i4FcrDYZx4iHs5ZZkYKcsFDXRBvotCkbKzxXx3dFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T4euQjqq; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T4euQjqq"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKFgYC128452;
	Thu, 15 Aug 2024 15:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723752942;
	bh=VwSrt8qn75BsiYoomvqXEG6wWWPEUNESxh18F5vlAN4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=T4euQjqqt8Yi3y0silgTy1Whfor3dStbYtrBwDnJwVBa6UM+XKn729FT/dM/SN/33
	 VEtMh3pdJJxb80afHgRbaDLoXT5oekLNjxP8Bnfe8R9okft95cTweeg5erjBWpyMBQ
	 3q6dTbD5eLEguzDRFeCJBpxPEYNunaka8/PlPr+E=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKFgNm113234
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:15:42 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:15:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:15:42 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKFgoj018925;
	Thu, 15 Aug 2024 15:15:42 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mmc: sdhci_am654: Add retry tuning
Date: Thu, 15 Aug 2024 15:15:41 -0500
Message-ID: <20240815201542.421653-2-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815201542.421653-1-jm@ti.com>
References: <20240815201542.421653-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add retry tuning up to 10 times if we fail to find
a failing region or no passing itapdly. This is
necessary since some eMMC's have been observed to never
find a failing itapdly on the first couple of tuning
iterations, but eventually do. It been observed that the
tuning algorithm does not need to loop more than 10 times
before finding a failing itapdly.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 64e10f7c9faa3..c3d485bd4d553 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -86,6 +86,7 @@
 
 #define CLOCK_TOO_SLOW_HZ	50000000
 #define SDHCI_AM654_AUTOSUSPEND_DELAY	-1
+#define RETRY_TUNING_MAX	10
 
 /* Command Queue Host Controller Interface Base address */
 #define SDHCI_AM654_CQE_BASE_ADDR 0x200
@@ -151,6 +152,7 @@ struct sdhci_am654_data {
 	u32 flags;
 	u32 quirks;
 	bool dll_enable;
+	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
@@ -453,12 +455,14 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 	int prev_fail_end = -1;
 	u8 i;
 
-	if (!num_fails)
-		return ITAPDLY_LAST_INDEX >> 1;
+	if (!num_fails) {
+		/* Retry tuning */
+		return -1;
+	}
 
 	if (fail_window->length == ITAPDLY_LENGTH) {
-		dev_err(dev, "No passing ITAPDLY, return 0\n");
-		return 0;
+		/* Retry tuning */
+		return -1;
 	}
 
 	first_fail_start = fail_window->start;
@@ -504,6 +508,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
 	u8 prev_pass = 1;
+	int ret;
 
 	memset(fail_window, 0, sizeof(fail_window));
 
@@ -532,10 +537,20 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	if (fail_window[fail_index].length != 0)
 		fail_index++;
 
-	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
-					  sdhci_am654->dll_enable);
+	ret = sdhci_am654_calculate_itap(host, fail_window, fail_index,
+					 sdhci_am654->dll_enable);
 
-	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+	if (ret >= 0) {
+		itap = ret;
+		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+	} else {
+		if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
+			sdhci_am654->tuning_loop++;
+			sdhci_am654_platform_execute_tuning(host, opcode);
+		} else {
+			return -1;
+		}
+	}
 
 	/* Save ITAPDLY */
 	sdhci_am654->itap_del_sel[timing] = itap;
@@ -908,6 +923,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	sdhci_am654->tuning_loop = 0;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);
-- 
2.46.0

