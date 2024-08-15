Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E73BA53;
	Thu, 15 Aug 2024 21:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756115; cv=none; b=Fq5X9nSOEOSL3gHy6qBELSxCoDV+F7Xfk5CiR3tD/9sWjwY60iohphOld4cLwLH2YSLNK8FYhtt7SbaHpyL1MQ9B0q3yTu5CKiFnRnLo/b4So9oAZ92ayyLfxr2dfl3Pc91/kN7aRKgJ34NWgTLrZYJhFFSHvvlkfurMz8L52vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756115; c=relaxed/simple;
	bh=GLiguvi+Oc7qhZf5JLKTVp2qI4hQHEY+a2IAsZDCO2Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfgZTBh8yTXdoHM4b8LOmYnJN3zvjcNnoRDhuNlF2fEtc186hAtrBqS/sV7LXM+e4bD7+vI4dqHOaBSBz3hquADQrUbULz4k6IEoxXCG71sHLVaQ/BJCHRi/hDPaIVRkpBNYReywmfJrOEotRjHxwO5QTyjlfQVxuuh7+dHOWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Qa2/50BP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Qa2/50BP"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FKFgqm117132;
	Thu, 15 Aug 2024 15:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723752942;
	bh=YpGC73jsmUszzsJBGs09ehK2XNm+XOZJx7psclHG2co=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Qa2/50BP9eCZCL/UvxXKSvbpxd9Sv5awwHgTdu8n+b9XFil/tNpeZ1j+sEdifoKrA
	 w6GrwDUQoSgbiXOqYGNqoxynJFsoRd2DWXgViYfmbpdLlvNFpZvmoLkErRWetXtjeb
	 2IBP59Gb7nGFPvGGnGvwh0tyFh5+qGz5YtHGGkWU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FKFg9F024293
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 15:15:42 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 15:15:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 15:15:42 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FKFgok018925;
	Thu, 15 Aug 2024 15:15:42 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mmc: sdhci_am654: Add tuning debug prints
Date: Thu, 15 Aug 2024 15:15:42 -0500
Message-ID: <20240815201542.421653-3-jm@ti.com>
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

Add debug prints to tuning algorithm for debugging.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index c3d485bd4d553..a909f8de0eabe 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -457,11 +457,13 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 
 	if (!num_fails) {
 		/* Retry tuning */
+		dev_err(dev, "No failing region found, retry tuning\n");
 		return -1;
 	}
 
 	if (fail_window->length == ITAPDLY_LENGTH) {
 		/* Retry tuning */
+		dev_err(dev, "No passing ITAPDLY, retry tuning\n");
 		return -1;
 	}
 
@@ -505,6 +507,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	struct window fail_window[ITAPDLY_LENGTH];
+	struct device *dev = mmc_dev(host->mmc);
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
 	u8 prev_pass = 1;
@@ -542,12 +545,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	if (ret >= 0) {
 		itap = ret;
+		dev_dbg(dev, "Final ITAPDLY=%d\n", itap);
 		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
 	} else {
 		if (sdhci_am654->tuning_loop < RETRY_TUNING_MAX) {
 			sdhci_am654->tuning_loop++;
 			sdhci_am654_platform_execute_tuning(host, opcode);
 		} else {
+			dev_err(dev, "Failed to find ITAPDLY, fail tuning\n");
 			return -1;
 		}
 	}
-- 
2.46.0

