Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC82137775;
	Mon, 26 Aug 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706300; cv=none; b=UjAaGnV78RZx+MCRzfyE194zYsFPYWDuavkSPQiwmtl82BqUGLM7KLN2yH9dUi/PAWHEoKz5fR9oIKLbGSdbNbW0UalnrKBaVjuVo06ziN8Dlcb/3k4qNkmyPAUfCyFNg/czhHx1rU+FtXh2BNOKR60NF2CeJqZWq8rGwoGCd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706300; c=relaxed/simple;
	bh=RkJOPPUr+iLA/t2/ApInRv0JE7/c0ZhgEfGnBKjLL94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7XKCxGUGRctHUG/jeTQdwZrO9sXiPm5bWINkLSLRxde8+nJfpCf1+/87ZFokEQbIFnJ8rzrHz/bs3124JTCOf0BlazpDQvwCveYH2ccGGQpBiOiMHDZDCBz5I5z6SpM8JHJyAH0qPFopzMpWpyyuY58JA0c/LvQHkWD7mX1haM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f50Rl4a/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f50Rl4a/"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QL4tKa023827;
	Mon, 26 Aug 2024 16:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724706295;
	bh=UCmTSqinwUqH5BdS9Q4Gq4nP0L76eLqD81yXdiNljyY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=f50Rl4a/r+rRicLowDTTtsWta6ea+R2YxHQVwSBH+XzJz0kvrpWY+kn+242sdZXs7
	 //g0FwRPxPkti1NUSygIIC/Daax3r8srfCfj8NtSUQ+/0XFewNduAdV36vxoi0PNAl
	 aVkEXRSO9mOtBgRuSrzy/gmBU7b9Ww57IEjEif/Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QL4tLt027356
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 16:04:55 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 16:04:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 16:04:54 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QL4sZV089210;
	Mon, 26 Aug 2024 16:04:54 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] mmc: sdhci_am654: Add retry tuning
Date: Mon, 26 Aug 2024 16:04:53 -0500
Message-ID: <20240826210454.3928033-2-jm@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826210454.3928033-1-jm@ti.com>
References: <20240826210454.3928033-1-jm@ti.com>
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
---
Changes since v2:
- Use do while loop instead of while in patch 1/2
- Move initialization of tuning_loop to sdhci_am654_init
- Separate error path in patch 1/2
---
 drivers/mmc/host/sdhci_am654.c | 46 ++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 64e10f7c9faa3..13da003363e1d 100644
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
@@ -443,7 +445,7 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 #define ITAPDLY_LENGTH 32
 #define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
 
-static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
+static int sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 			  *fail_window, u8 num_fails, bool circular_buffer)
 {
 	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
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
@@ -494,8 +498,8 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
 }
 
-static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
-					       u32 opcode)
+static int sdhci_am654_do_tuning(struct sdhci_host *host,
+				 u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
@@ -532,13 +536,30 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
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
@@ -742,6 +763,9 @@ static int sdhci_am654_init(struct sdhci_host *host)
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

