Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9000F8405C
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951853; cv=none; b=oI7plkm+ShCHMRk0c8b8lVfvVUI0BoCTdg91vB0o4WlyMLJknrWQDUtQSAWG03LbWLo/7f8+EK1CyFNn6U3EYeKok47omBwUxf4YG0sL8GSiWKFSu6Erb2SGjvB7VCJU9cV1Lxa21sJ9PEgTwOTIXw06FR8kBbBAoBEvh0rEiac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951853; c=relaxed/simple;
	bh=niiB8n9U32nrT0ZLF6e1Rf4ExrB84qCf97ZsHG4Ruvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ZY6FMDq8oLKT5qiIMrFERaUV4gxkbf0IuGKPLp9V1Kt5HzGz+sbDUMlGF9auKKZNHCtV+kjqnfIZsRmoLANfash4ZZ8gB5/hhu3dLtaDdAER37o4NhU6GOGBEtZ3b63JjTYPezXt5s2Q9OqQpB9/qhDTgsJ05YufO2yRhcWtC1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CtEIquBn; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CtEIquBn"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260213030410epoutp040df6bb89bc6f24ce8d317ec9a0272508~Tr1Mtg2Qs1342013420epoutp04a
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 03:04:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260213030410epoutp040df6bb89bc6f24ce8d317ec9a0272508~Tr1Mtg2Qs1342013420epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770951850;
	bh=eOa5amGEyOzfgJHFBt/2zz94QqG0tzsLr/oL5wjV5GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtEIquBnjRnh+/cgRsO+pYK6IruYH4tcIX8upxJOQ0ueaTaW+JM7LpakCvy4JzWGl
	 fEKQQNTE2LyESR2we6XJOQ/iRqvyj943w+Cuj2a6QFZuHgQlVL0tk2JHRW+5DEAunj
	 2Y6fxqCUVznKqKS0hNgVwi96M4oySCl44ErYHesk=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260213030409epcas5p330a701aa9a5627999137f34721f83dea~Tr1MH2Gx92021620216epcas5p3u;
	Fri, 13 Feb 2026 03:04:09 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fBxpK4JM9z6B9m7; Fri, 13 Feb
	2026 03:04:09 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260213030408epcas5p1c816799f62ff9de2c78511bf821387ca~Tr1LWe2Nu2200222002epcas5p1R;
	Fri, 13 Feb 2026 03:04:08 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260213030408epsmtip2d46242c029bf3f4e458ba63b61f39939~Tr1Kmhjt92034720347epsmtip2j;
	Fri, 13 Feb 2026 03:04:07 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	ping.gao@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: [PATCH v2 2/3] mmc: dw_mmc-k3: before set biu_clk rate, check
 biu_clk available or not
Date: Fri, 13 Feb 2026 11:08:51 +0800
Message-ID: <20260213030851.1134504-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213030408epcas5p1c816799f62ff9de2c78511bf821387ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

if biu_clk not available, shouldn't set_rate or get_rate

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 drivers/mmc/host/dw_mmc-k3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index ad6aa1aea549..9c68e162b373 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -190,6 +190,11 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	int ret;
 	unsigned int clock;
 
+	if (IS_ERR_OR_NULL(host->biu_clk)) {
+		dev_warn(host->dev, "biu_clk not available\n");
+		return;
+	}
+
 	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
 
 	ret = clk_set_rate(host->biu_clk, clock);
-- 
2.50.1

