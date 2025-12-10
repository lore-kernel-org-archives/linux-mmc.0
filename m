Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68123B186
	for <linux-mmc@vger.kernel.org>; Wed, 10 Dec 2025 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765333989; cv=none; b=W9QhoYeJEENCLKy1xSoKalzlB449wfH9K/9gIDu11FCN3L72PVyeBqDICnCO0O5cYeoUN7WZ5tDSFHxToDF/WpVTReOnhxn0w8N7hnGyignhNXFg2H3T9fjyIK3P/xBfv10irOz/rLBSkNAc4T51lC2t5FGr0O+tY5mN6LCO/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765333989; c=relaxed/simple;
	bh=lvGCrLMIqrOsNgYva0rW+i9iOI19h12DKGo9/UCuBBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=Yeejs3ZSvnscyvwQbSlb0owLap7aQycRh9NgrgfmhY4K0VWUAL3kJAh3UIkWAzgiPf7OSun4s277DD81iYD7KcNmax/BYLTN7ZkH7LaurnY4AMzJMxkZ3l6tiU+3fNUsMUzExgH4LYhmCC9bOGXDapAwY8uVgRSfXZ9rd9PM3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=i0nRy9Vw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="i0nRy9Vw"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20251210022623epoutp016f81a46cb0e4d885bf1d42243f6e5d4e~-uYpvv6Vl0287002870epoutp01D
	for <linux-mmc@vger.kernel.org>; Wed, 10 Dec 2025 02:26:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20251210022623epoutp016f81a46cb0e4d885bf1d42243f6e5d4e~-uYpvv6Vl0287002870epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1765333583;
	bh=UG2xoh8S1uOORKKWyEXE8iXZmULsm1Y1Ql6HxJn+NWY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=i0nRy9Vwj7IsigAwxaNe7ndVHWElOEDgeZaR1wPrt/JexSsa8wjfFk7oF0+KuG1uP
	 1PNEeY1G5Rn0lyBRTuFdHhzS179zTFDjjgMbTRpG8RUCYybrwQCJvC8DYY4St6s4Oy
	 OyDsFV9rY2DYExL8OnLzcjbdD/uocPi0cQNSfTL0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251210022622epcas5p214e1f734ac777e3be3bb1173bcd458a2~-uYpjPw0Z0708607086epcas5p2-;
	Wed, 10 Dec 2025 02:26:22 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4dR02k6jkTz2SSKY; Wed, 10 Dec
	2025 02:26:22 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251210022622epcas5p3faca823fc4bf50267e4b660d4776cb1d~-uYpVEBDV0395503955epcas5p3W;
	Wed, 10 Dec 2025 02:26:22 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20251210022622epsmtip2bda414d57f567c6a14c4de0145a87294~-uYpBteqE0686206862epsmtip2a;
	Wed, 10 Dec 2025 02:26:22 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: jh80.chung@samsung.com, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "ping.gao" <ping.gao@samsung.com>
Subject: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
Date: Wed, 10 Dec 2025 10:30:08 +0800
Message-ID: <20251210023008.1198860-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251210022622epcas5p3faca823fc4bf50267e4b660d4776cb1d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20251210022622epcas5p3faca823fc4bf50267e4b660d4776cb1d
References: <CGME20251210022622epcas5p3faca823fc4bf50267e4b660d4776cb1d@epcas5p3.samsung.com>

Use vendor drv function to let other vendor can add some vendor function
before and after request

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 7 ++++++-
 drivers/mmc/host/dw_mmc.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92bbb094..04fb92579509 100644
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
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 
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

