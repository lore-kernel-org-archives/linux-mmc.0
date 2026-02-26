Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CCB30596F
	for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2026 09:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097223; cv=none; b=MiGKsFrwiNddzlCAIkIYbE7GfS/G0T948EP5w6/Y/pa6e2vwRD0d5KzG7ayz0MY5U6WIxYJasQgO33XYgQwONEW+eMn/qIKEBCynxgPR4lZDPHbwMKdzXDLMUoTc08IQmkIljAyZ5sHSobTXZm/+5dSN0/H9t2b1tfjKgjcUkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097223; c=relaxed/simple;
	bh=Ll1C/k6us6VNV4G+XvSuQrT3k/czbVvKdxB4yjiF6jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MRe2qLaUMyaROCkJm66boo54UmNUh8r/oC1PsGS2Z0+ZHG0Ya63vCN78dB1ChRSoNzpV/9xq5mzbcmAbEpJEjH7C87iqJeJL37yUKVqii5S1aQ6H8gotOjsxssyi79Y4nlIS3XF/ljIv7w1fdXZjQsW+OQo5tgH4pRwb/tXV0VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ftHDagL2; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ftHDagL2"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260226090505epoutp02b665c088ce1930275a807017370ca881~XwJCdxixk0198601986epoutp02H
	for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2026 09:05:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260226090505epoutp02b665c088ce1930275a807017370ca881~XwJCdxixk0198601986epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772096705;
	bh=PZeSZWFesAgEfOfY1Eam39aeSIQJZPf2ZiqvMOXv1vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftHDagL2pNZ07RVKrxfZTZoS/4kGwdLYW4PfNKKvzEtsV+X0NRh8kVgGKs7hmteWT
	 VaDhb5wUQ0s7VyP1QpWL8XNu8PQ3KjnfYUh4SyLx0tE4hyvFYFZB+8yN529xAg0BYV
	 UWaj4uXmmMA0iLqxJdWZsO4zw2/WoMdL8lEnyuPE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260226090505epcas5p1d8fd7593316a7567deff72615749a3eb~XwJCGLO1C0280902809epcas5p18;
	Thu, 26 Feb 2026 09:05:05 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fM5Bn2Hlmz6B9mF; Thu, 26 Feb
	2026 09:05:05 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260226090505epcas5p2c4f159fa29187685275dd950dd69f5cd~XwJB71Xtg1465714657epcas5p23;
	Thu, 26 Feb 2026 09:05:05 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260226090504epsmtip15c749afc4ee9ee5c3a5b0c944563d3a8~XwJBPGh3f0295402954epsmtip1B;
	Thu, 26 Feb 2026 09:05:04 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	robh@kernel.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, hy50.seo@samsung.com, kwangwon.min@samsung.com,
	ping.gao@samsung.com
Subject: [PATCH v3 1/3] mmc: dw_mmc-k3: before set biu_clk rate, check
 biu_clk available or not
Date: Thu, 26 Feb 2026 17:09:58 +0800
Message-ID: <20260226090958.300440-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260226090505epcas5p2c4f159fa29187685275dd950dd69f5cd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

If biu_clk is not available, no need to try to set and get
rate of it, just bail out and print a warning

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc-k3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index ad6aa1aea549..ccb6bfe3e0ce 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -190,6 +190,11 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	int ret;
 	unsigned int clock;
 
+	if (IS_ERR_OR_NULL(host->biu_clk)) {
+		dev_err(host->dev, "biu_clk not available\n");
+		return;
+	}
+
 	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
 
 	ret = clk_set_rate(host->biu_clk, clock);
-- 
2.50.1

