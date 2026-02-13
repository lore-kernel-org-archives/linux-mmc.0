Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C0B19CC14
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770960593; cv=none; b=F7q7shDEoenkLA7XTkQcjAvkdByE3LLhviwCW+8eDFgXpIqXnXZFCJrIn7UOA8/2IdVzlr7Q+pjCNoHXgT5xJmk5eyJbbtRWXZTkBTBns+sfUTjGxWFsZIOKNie+O0ndkCbKe/NZjmn0CDYrypmY3CldUnflqqLbHWYIJiW8RoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770960593; c=relaxed/simple;
	bh=F4tQQkzBrzU9fZ5dYE8kk1gKIKu+hWiJk94DdfzvXeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JamdE0C8m4hJBXyZlvChxFD60E7hayybnhSalIE8Gl0qai27JuRBidi74GT2SkxJgy3EqJ9LPoJlrjCZ7lK2umcPE/2vLiCBRASFHl2L/IFl7q3Wh+TFf6qZRpq+lEXGgDQjY0Cvt3WFp51ZsPn9+xxYLQpkQJmGKeD1zDyw4e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZnnfNKTc; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZnnfNKTc"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260213052950epoutp024f77dc8213804ad9bb7a9780df70e7f2~Tt0Yv95_w1107111071epoutp02G
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 05:29:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260213052950epoutp024f77dc8213804ad9bb7a9780df70e7f2~Tt0Yv95_w1107111071epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770960590;
	bh=NKlEeBlORou6wmvrVXmRL8chQkBnSsA/MrUDnxAkAwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnnfNKTcheO1b86ulFJRmNTnmY+J/Ye5KsNDPdVwEJ9hxVMIzl8SJa3DBsohSWTPs
	 nSPoYIBXngXU7vdwjanuxrJFnc9/xvHucARfduqwjadhJK4SxHFvEqYI//LjBsLV83
	 cyTvpV02rV+QggjEmOIZi9AcUcyFDZlpQkUNfBKs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260213052950epcas5p14e94a890d904bdb87c3a5012fd8ac490~Tt0YYd90l0690906909epcas5p1W;
	Fri, 13 Feb 2026 05:29:50 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4fC12Q0zYBz6B9mJ; Fri, 13 Feb
	2026 05:29:50 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260213052949epcas5p3d0e2840f82700a847e899dc3eeac466c~Tt0X10DAd1071110711epcas5p3S;
	Fri, 13 Feb 2026 05:29:49 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260213052949epsmtip22e1c835a9877129cc795d298c68de6cb~Tt0XTjPIe1200512005epsmtip2O;
	Fri, 13 Feb 2026 05:29:48 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	ping.gao@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: [PATCH v3 2/3] mmc: dw_mmc-k3: before set biu_clk rate, check
 biu_clk available or not
Date: Fri, 13 Feb 2026 13:34:31 +0800
Message-ID: <20260213053431.1337556-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213052949epcas5p3d0e2840f82700a847e899dc3eeac466c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

If biu_clk is not available, no need try to set and get
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

