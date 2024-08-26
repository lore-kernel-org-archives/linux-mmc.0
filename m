Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954DA881E;
	Mon, 26 Aug 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706299; cv=none; b=OOpwGUMw2qbU13/dSNHzVKhMRiK5MYqeHIy1/E4VOaWjpIkT9bvkRLB+7CpWCIe0DBj2WSGVmn2ICTgc7ZhOwe3pjQ6oQwKPtD4nniGS+EKNoTGOs6iiJIsjAfoArQG/CBQDY5dcG8Wv0ycIlXtRSSImmeUZlKiVuHDr5dZ96uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706299; c=relaxed/simple;
	bh=JkhJFKFIkm79UbFh96wQZUTAoNWKn4eTgKW9tzvn/98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdKit1ZIH2ZQkAg3hS3xz3EUWwuJUiSxejkrUjZiyy0QNwlpNWzFbC51/UX/8r7TB5mwcAiDsrNt7Lyn+EBMzzC/t0ThxUwGXeR2AdhAfbRR5LAI1DidfxxPewLMX3t0WsW2goFF9zEBRac6oulNsehJn6NlEhwudJInL6y6gn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tRIHOkcO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tRIHOkcO"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QL4tgR123216;
	Mon, 26 Aug 2024 16:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724706295;
	bh=aTMH6CJkz+UkcfHV2rNhCeL5bfIeJkBghWir786/2Gg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tRIHOkcOhfw0nZvGmeExEBssUurZa6XNtbwoxOZPUiLk7J2w/UArIJUvPYOiiwM49
	 eCHj/8b5izzf1+ZG/Nax/iZfQwHaZ8eYzcIJQPmHJwvRuZspdpH+6nn8u6rNlrukRN
	 iJAFQ9SGzoEcaOcT81CsWLJm4lcMcI3LVnrU64iQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QL4tI9051938
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 16:04:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 16:04:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 16:04:54 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QL4sZW089210;
	Mon, 26 Aug 2024 16:04:54 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] mmc: sdhci_am654: Add prints to tuning algorithm
Date: Mon, 26 Aug 2024 16:04:54 -0500
Message-ID: <20240826210454.3928033-3-jm@ti.com>
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

Add debug prints to tuning algorithm for debugging.
Also add error print if we fail tuning.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- Move struct *dev = mmc_dev() to patch 2/2
---
 drivers/mmc/host/sdhci_am654.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 13da003363e1d..0aa3c40ea6ed8 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -457,11 +457,13 @@ static int sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 
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
 
@@ -505,6 +507,7 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	struct window fail_window[ITAPDLY_LENGTH];
+	struct device *dev = mmc_dev(host->mmc);
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
 	u8 prev_pass = 1;
@@ -525,6 +528,7 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 		if (!curr_pass) {
 			fail_window[fail_index].end = itap;
 			fail_window[fail_index].length++;
+			dev_dbg(dev, "Failed itapdly=%d\n", itap);
 		}
 
 		if (curr_pass && !prev_pass)
@@ -546,6 +550,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
+	struct device *dev = mmc_dev(host->mmc);
 	int itapdly;
 
 	do {
@@ -554,9 +559,12 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
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

