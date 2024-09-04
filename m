Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656917BEA0;
	Wed,  4 Sep 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492318; cv=none; b=A8zviU/SPBCFSx6jXJsDxKx2U6Z+NWJrzzYrqk2IAXkHZ55zjT8ECGNBcG7Awv72fn5S+o6UwICe0jTOyL9gGGUMaQQRaVWlalyO5hSgN1Zk9OWgS5+RwAlQlJAalHoovPcOAGhRBmi+MXvLUiMMUZi5MD997mU7WjbGC6O9RnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492318; c=relaxed/simple;
	bh=yYYCIGnpM/NMzscnnx+CrwBrKqWY15LZ894VNlMEcKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2HBP9CjhZv1FwsDA4rjr+1DiOqi1mJWWjXBp+MTC3ZWaKBcOMGwqhzp49BED/MKuCIaC+vu7WklxustbWApiVOke7axbu6kp6XhFVS/Yz6zCqcDREwS8LCxJTsN9PAf7/9GSPeFMoG1Lzu0RsenioCv2ac8LNKF6r5YWdbbOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k3LZuCP9; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k3LZuCP9"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 484NPD0s105404;
	Wed, 4 Sep 2024 18:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725492313;
	bh=EtBNkbZK1Il0WxEoaJpW+QCHC7RR5Mq2CS41+HO32WA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=k3LZuCP9JbXumWDpMHgN0OlXGj1fkGXnRWBGE/Kp+aGDD3XtLHVNQC7Yz9dKk28Gg
	 2w4y3K/YHT8pqRARv97E5fqNk67qD7T2yjUesBrqqjzE84ui0/8r7Ldz9A0KbIeXrM
	 VMC/u53eoubD7bEa693Mjn7yKAekkifPWJ5+5/Tk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484NPDuc088291;
	Wed, 4 Sep 2024 18:25:13 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 4
 Sep 2024 18:25:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 4 Sep 2024 18:25:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 484NPD9O003973;
	Wed, 4 Sep 2024 18:25:13 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] mmc: sdhci_am654: Add retry tuning
Date: Wed, 4 Sep 2024 18:25:11 -0500
Message-ID: <20240904232512.830778-2-jm@ti.com>
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

Add retry tuning up to 10 times if we fail to find
a failing region or no passing itapdly. This is
necessary since some eMMC has been observed to never
find a failing itapdly on the first couple of tuning
iterations, but eventually does. Keep count of current
tuning iteration using tuning_loop. It has been observed
that the tuning algorithm does not need to loop more
than 10 times before finding a failing itapdly.

Signed-off-by: Judith Mendez <jm@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
Changes since v3:
- Fix compile warnings
---
 drivers/mmc/host/sdhci_am654.c | 47 +++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 64e10f7c9faa3..8eb6ce9f3b173 100644
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
@@ -443,22 +445,23 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 #define ITAPDLY_LENGTH 32
 #define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
 
-static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
+static int sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 			  *fail_window, u8 num_fails, bool circular_buffer)
 {
 	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
 	u8 first_fail_start = 0, last_fail_end = 0;
-	struct device *dev = mmc_dev(host->mmc);
 	struct window pass_window = {0, 0, 0};
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
@@ -494,8 +497,8 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
 }
 
-static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
-					       u32 opcode)
+static int sdhci_am654_do_tuning(struct sdhci_host *host,
+				 u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
@@ -532,13 +535,30 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	if (fail_window[fail_index].length != 0)
 		fail_index++;
 
-	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
-					  sdhci_am654->dll_enable);
+	return sdhci_am654_calculate_itap(host, fail_window, fail_index,
+					 sdhci_am654->dll_enable);
+}
 
-	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
+					       u32 opcode)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	unsigned char timing = host->mmc->ios.timing;
+	int itapdly;
 
+	do {
+		itapdly = sdhci_am654_do_tuning(host, opcode);
+		if (itapdly >= 0)
+			break;
+	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
+
+	if (itapdly < 0)
+		return -1;
+
+	sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
 	/* Save ITAPDLY */
-	sdhci_am654->itap_del_sel[timing] = itap;
+	sdhci_am654->itap_del_sel[timing] = itapdly;
 
 	return 0;
 }
@@ -742,6 +762,9 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
 			   TUNINGFORSDR50_MASK);
 
+	/* Use to re-execute tuning */
+	sdhci_am654->tuning_loop = 0;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		return ret;
-- 
2.46.0

