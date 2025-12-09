Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586A1E230E
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765262736; cv=none; b=kA6KgYySqYS/n352Uu6EUx/4NBEcmCsepoIOa9l8Dnte4fLgXOSNBU5Uhf/Lga5ALr3tDu/r4xoOfwZVVWQf/V3f9bSPQlnSQ+9wVEgJq031Ok4aVcQ9sg0ERzhMX3XkQpPS6wCQK5ztITdtP04SD4Y4O+cGGBoHNaOEGSjgyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765262736; c=relaxed/simple;
	bh=tM/RH8emnj0dajYwnro6pKWfSY2epz4U0SfN5wy5xzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=hCxK/KOPJADjmR2XYTcWhId4JRO30dUPOiCNujsDXaA1d3yuA0Q74suOn8XrsNxinmbG1D+FWR8ixQ8MxzOrvUSzROaiaOeECulCsxkN13ZSlM/2Vkfrv+xuJ5msTcJvgNsRpfpfgCKsTcVbCeufTHjk69vTZmf6ABUusIOsIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N5hQTAGZ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N5hQTAGZ"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251209064525epoutp028448d69dfc82dbbeaa30626a4a6bad23~-eRiomowi2518825188epoutp02m
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2025 06:45:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251209064525epoutp028448d69dfc82dbbeaa30626a4a6bad23~-eRiomowi2518825188epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765262725;
	bh=l/Jpun7L3VLWtKz82wS32V7DfXju3x6UHL4G4YwT6Ns=;
	h=From:To:Cc:Subject:Date:References:From;
	b=N5hQTAGZfNAXo4GRPXYHWMgRTladYZ0dubciXIRIz6fAuQ3i330Ol7FVBjSegL/uT
	 LMkXqbfM7Hf/GopCxZfIG26rZg0fwPVid4faU8U63EnsQOBPr/v86mIg3YO+iWc12v
	 SWBTx2c6Jwk44WcqrXU0aDkogLUucW5xvUhgYKqo=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251209064525epcas5p28fb2c7767e270819fda9ff45e563fecf~-eRiUQKYY2302023020epcas5p2G;
	Tue,  9 Dec 2025 06:45:25 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4dQTr52pylz6B9mN; Tue,  9 Dec
	2025 06:45:25 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251209064525epcas5p4904259a2a7fb971c077bfa03acce8c79~-eRiBIZca0090200902epcas5p4X;
	Tue,  9 Dec 2025 06:45:25 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251209064524epsmtip2a60793463a9eb5979a8250de4d37b5de~-eRhpGZcu0987609876epsmtip2J;
	Tue,  9 Dec 2025 06:45:24 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "ping.gao" <ping.gao@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
Date: Tue,  9 Dec 2025 14:49:10 +0800
Message-ID: <20251209064910.3643039-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251209064525epcas5p4904259a2a7fb971c077bfa03acce8c79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20251209064525epcas5p4904259a2a7fb971c077bfa03acce8c79
References: <CGME20251209064525epcas5p4904259a2a7fb971c077bfa03acce8c79@epcas5p4.samsung.com>

Use vendor drv function to let other vendor can add some vendor function
before and after request

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 7 ++++++-
 drivers/mmc/host/dw_mmc.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92bbb094..5f1353b7f8d6 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1416,6 +1416,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
 	struct dw_mci *host = slot->host;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 
 	WARN_ON(slot->mrq);
 
@@ -1430,7 +1431,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		mmc_request_done(mmc, mrq);
 		return;
 	}
-
+	if (drv_data && drv_data->pre_request)
+		drv_data->pre_request(host);
 	spin_lock_bh(&host->lock);
 
 	dw_mci_queue_request(host, slot, mrq);
@@ -1897,6 +1899,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 {
 	struct dw_mci_slot *slot;
 	struct mmc_host	*prev_mmc = host->slot->mmc;
+	const struct dw_mci_drv_data *drv_data = host->drv_dat
 
 	WARN_ON(host->cmd || host->data);
 
@@ -1921,6 +1924,8 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 
 	spin_unlock(&host->lock);
 	mmc_request_done(prev_mmc, mrq);
+	if (drv_data && drv_data->post_request_end)
+		drv_data->post_request_end(host);
 	spin_lock(&host->lock);
 }
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 648b4a5641bf..6c258e0865e7 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -618,5 +618,7 @@ struct dw_mci_drv_data {
 					  unsigned int timeout_ns);
 	u32		(*get_drto_clks)(struct dw_mci *host);
 	void		(*hw_reset)(struct dw_mci *host);
+	void		(*pre_request)(struct dw_mci *host);
+	void		(*post_request_end)(struct dw_mci *host);
 };
 #endif /* _DW_MMC_H_ */
-- 
2.50.1

