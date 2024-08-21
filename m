Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866D79CD;
	Wed, 21 Aug 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268281; cv=none; b=Uip7kekRpXpQLo2Md84/AUsf91+nzZK7sQTTv3ndJv7RZkqXEdo8AA4pL5UqLmpK418LLP2xa/9jAjGsW1PpDVUfg6NgN0aJiU5o9HT+bA9V5G7P1wfB8KnxLyN3JlZAhY/UcISz7jzJjx4aECrWhrlrg1sR568h9oh9gBWT9gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268281; c=relaxed/simple;
	bh=KEs3+0bFeoFgo4ngrnDTC9HBUMGQLYn4h0Wba1inEyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2LmfMujslcGIZVZ6tzkxxrwXHu/Ky3tC1I7BJTnX6VZy8HCZGeAXHZ9HvY+F8xsgOpeSlrmO0xfNWcfXqz6LeIFj8mA4hF//+hs2GSolpJTVUNOj6JAHSkyHXFqaSVd0WK/wkrnlY7hEtnC/rsOv8nVZxh3z6nOy/VctwNcnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y7gqvTQk; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y7gqvTQk"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LJOZCJ047915;
	Wed, 21 Aug 2024 14:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724268275;
	bh=gPXE+AXFPDgn04Mc9jcQyDyqkHbMxJlaxavoM1Vlb9s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=y7gqvTQkdgqkv/QddBLM1b6Q/nnaPX3V+OVxJRgyqWcLtKdI7ElfqwNPqoTQv6XNU
	 tuTMl+nZbs0vg34j98g74P2vfmBLsZojz1H11pICCJPTPQRrSE1RjMjhnzWV36GUBM
	 W8cydxnInTRXrYKQItfoyW6BswPlWGDWsER8gl/0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LJOZk7112394
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 14:24:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 14:24:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 14:24:36 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LJOZqk057194;
	Wed, 21 Aug 2024 14:24:35 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] mmc: sdhci_am654: Add prints to tuning algorithm
Date: Wed, 21 Aug 2024 14:24:35 -0500
Message-ID: <20240821192435.1619271-3-jm@ti.com>
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

Add debug prints to tuning algorithm for debugging.
Also add error print if we fail tuning.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Change prints to dev_dbg
- Add print for failing itaps
---
 drivers/mmc/host/sdhci_am654.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 612f29fd7dfef..9cac520d5c15c 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -457,11 +457,13 @@ static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
 
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
 
@@ -527,6 +529,7 @@ static int sdhci_am654_do_tuning(struct sdhci_host *host,
 		if (!curr_pass) {
 			fail_window[fail_index].end = itap;
 			fail_window[fail_index].length++;
+			dev_dbg(dev, "Failed itapdly=%d\n", itap);
 		}
 
 		if (curr_pass && !prev_pass)
@@ -562,10 +565,12 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	}
 
 	if (itapdly >= 0) {
+		dev_dbg(dev, "Passed tuning, final itapdly=%d\n", itapdly);
 		sdhci_am654_write_itapdly(sdhci_am654, itapdly, sdhci_am654->itap_del_ena[timing]);
 		/* Save ITAPDLY */
 		sdhci_am654->itap_del_sel[timing] = itapdly;
 	} else {
+		dev_err(dev, "Failed to find itapdly, fail tuning\n");
 		ret = -1;
 	}
 
-- 
2.46.0

