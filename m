Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B716D9C1;
	Wed, 21 Aug 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268280; cv=none; b=uzZxQar0l3y/FV766VHsaoI0uAaZNAvm5WocPf0r7O9dIx+cWDv+JcWklGnA3WPQ281S0WlBKcUkAC+2nEWzGHVUrxiJk9g5zIgaHyXFvn3uBxNR7BL8saHqaPfVgNm7PoaK5bz4opZ5NgFouQMvNrLlAjaen5Jwd7+KZJmnHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268280; c=relaxed/simple;
	bh=CQFkJvC0AyxW7aZFl1efw1D4AXN727NGctW3ETFe4MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJppgR24mk6CnIcDZpwBTWNNzNdOT+S0YsgRiHkeN0FhQLSAf/4375Gnd1I0kkHbXON1G/jI+GE0ggfS5hCWRVXwmvE59tqWmBg+p4NwWS7OLW0eWPA+S05BbcwpdKX1B9n73Fn1x9qh/B+Dtds0Bm5VM1j4K3fVlEjGq9UVRSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pdhPjz0h; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pdhPjz0h"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LJOZ83047923;
	Wed, 21 Aug 2024 14:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724268276;
	bh=yCgSRHCc8UqDB9CNzygju3tJWSItWGYrjRmSDBtTgf4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pdhPjz0hH6Fg3gipsSDOqYnqGh1kKGbbJ/fIvBAyDdb1oF5lOgKcE9mpMKHVsTLX+
	 CCTVJO72SaEsxWk+DDjuLVSG9iH07fPEFI4PoRVyrJAtXgsF0Bvq+xQbPp6bF93dNJ
	 rSeBvCe/GIMC/oDaPXrzHDhPpdwCEzbq4TsHZDmg=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LJOZOZ121263
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 14:24:35 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 14:24:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 14:24:35 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LJOZqj057194;
	Wed, 21 Aug 2024 14:24:35 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] mmc: sdhci_am654: Add retry tuning
Date: Wed, 21 Aug 2024 14:24:34 -0500
Message-ID: <20240821192435.1619271-2-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821192435.1619271-1-jm@ti.com>
References: <20240821192435.1619271-1-jm@ti.com>
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
necessary since some eMMC has been observed to never
find a failing itapdly on the first couple of tuning
iterations, but eventually does. It has been observed that
the tuning algorithm does not need to loop more than 10
times before finding a failing itapdly.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Change logic in patch 1/2 from using recursive aproach
  to calling a function iteratively for retuning
---
 drivers/mmc/host/sdhci_am654.c | 54 ++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 64e10f7c9faa3..612f29fd7dfef 100644
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
@@ -494,16 +498,18 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
 }
 
-static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
-					       u32 opcode)
+static int sdhci_am654_do_tuning(struct sdhci_host *host,
+				 u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	struct window fail_window[ITAPDLY_LENGTH];
+	struct device *dev = mmc_dev(host->mmc);
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
 	u8 prev_pass = 1;
+	int ret = 0;
 
 	memset(fail_window, 0, sizeof(fail_window));
 
@@ -532,15 +538,38 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	if (fail_window[fail_index].length != 0)
 		fail_index++;
 
-	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
-					  sdhci_am654->dll_enable);
+	ret = sdhci_am654_calculate_itap(host, fail_window, fail_index,
+					 sdhci_am654->dll_enable);
 
-	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+	return ret;
+}
 
-	/* Save ITAPDLY */
-	sdhci_am654->itap_del_sel[timing] = itap;
+static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
+					       u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	unsigned char timing = host->mmc->ios.timing;
+	struct device *dev = mmc_dev(host->mmc);
+	int itapdly;
+	int ret = 0;
 
-	return 0;
+	itapdly = sdhci_am654_do_tuning(host, opcode);
+
+	while (sdhci_am654->tuning_loop < RETRY_TUNING_MAX && itapdly < 0) {
+		sdhci_am654->tuning_loop++;
+		itapdly = sdhci_am654_do_tuning(host, opcode);
+	}
+
+	if (itapdly >= 0) {
+		sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
+		/* Save ITAPDLY */
+		sdhci_am654->itap_del_sel[timing] = itapdly;
+	} else {
+		ret = -1;
+	}
+
+	return ret;
 }
 
 static const struct sdhci_ops sdhci_am654_ops = {
@@ -908,6 +937,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	sdhci_am654->tuning_loop = 0;
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);
-- 
2.46.0

