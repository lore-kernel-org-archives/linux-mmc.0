Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0081865F5;
	Wed,  4 Sep 2024 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492324; cv=none; b=GaOi+Eu3+MNCymwRTXvRL11h/4ZbhUTtrqjCcSlG8m9ZCYpVAlc1jJfymvFvy2pqyMWdoFumq0aiHsSinFjYfjZa9XXhqTjxLvdfV4/sNy3D4rgkIvGInlarHmCuJjdaZQ5mx4OIJ0UDxuIX9fnjOJTy0TH38xgfohd95DRBFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492324; c=relaxed/simple;
	bh=Fi0B3Y0549zjJnrIJat3Yio26WbiKmV5I0o8rKpg7gA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxqXK+Scx9XVPvZzNC18j3CYjCH+BIkHmpZ3aU6e2kOhIv4Fi4E5/xXOfs8qTUkm2//nXmkxN0T8eHkQXaA7zUFv/q1vRHqkomDSeJoyoK9SZ6n1fSZkBoW7D6GIEiZM9gd9J55DDaaTZhFrhi9LeeCgJ2/fiRLr9J7C71Cbv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hN1glBpJ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hN1glBpJ"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 484NPDCk026818;
	Wed, 4 Sep 2024 18:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725492313;
	bh=2cfizvyqwdchamKOXy/vhvCQP6YTFBdTClb2OBdg214=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hN1glBpJiIF4SN9UjF1qY8FZG0XyTWIky/gyOxmqnmMKiohauEal330EPNH75CGRY
	 W/j2TOgR8Kdahf1zgoSwfrnGXiysYeFWRlswMDww2vdMa/C4RhTK7KIh9dZ9dAajLV
	 4uGn3Nl9s18iEfd0PuxUuhCh7jiRDnpK7g0YsmLg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 484NPDVO006185
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Sep 2024 18:25:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 18:25:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 18:25:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484NPD9P003973;
	Wed, 4 Sep 2024 18:25:13 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] mmc: sdhci_am654: Add prints to tuning algorithm
Date: Wed, 4 Sep 2024 18:25:12 -0500
Message-ID: <20240904232512.830778-3-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904232512.830778-1-jm@ti.com>
References: <20240904232512.830778-1-jm@ti.com>
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
Also add error print if we fail tuning.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v3:
- Fix compile warnings
---
 drivers/mmc/host/sdhci_am654.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8eb6ce9f3b173..0aa3c40ea6ed8 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -450,17 +450,20 @@ static int sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 {
 	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
 	u8 first_fail_start = 0, last_fail_end = 0;
+	struct device *dev = mmc_dev(host->mmc);
 	struct window pass_window = {0, 0, 0};
 	int prev_fail_end = -1;
 	u8 i;
 
 	if (!num_fails) {
 		/* Retry tuning */
+		dev_dbg(dev, "No failing region found, retry tuning\n");
 		return -1;
 	}
 
 	if (fail_window->length == ITAPDLY_LENGTH) {
 		/* Retry tuning */
+		dev_dbg(dev, "No passing itapdly, retry tuning\n");
 		return -1;
 	}
 
@@ -504,6 +507,7 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	struct window fail_window[ITAPDLY_LENGTH];
+	struct device *dev = mmc_dev(host->mmc);
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
 	u8 prev_pass = 1;
@@ -524,6 +528,7 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 		if (!curr_pass) {
 			fail_window[fail_index].end = itap;
 			fail_window[fail_index].length++;
+			dev_dbg(dev, "Failed itapdly=%d\n", itap);
 		}
 
 		if (curr_pass && !prev_pass)
@@ -545,6 +550,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
+	struct device *dev = mmc_dev(host->mmc);
 	int itapdly;
 
 	do {
@@ -553,9 +559,12 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 			break;
 	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
 
-	if (itapdly < 0)
+	if (itapdly < 0) {
+		dev_err(dev, "Failed to find itapdly, fail tuning\n");
 		return -1;
+	}
 
+	dev_dbg(dev, "Passed tuning, final itapdly=%d\n", itapdly);
 	sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
 	/* Save ITAPDLY */
 	sdhci_am654->itap_del_sel[timing] = itapdly;
-- 
2.46.0

