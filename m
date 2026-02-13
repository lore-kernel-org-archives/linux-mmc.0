Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823308405C
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951867; cv=none; b=gsoserhx4Low6hm8gDQQacTlIgAlMNBB0g2y3VasCh0erTqjPuYNvVAGWL/IeFsZ5eETt+mD/QrgV92PkJ/7EKhrtP4xFUJDCMHl4C0m8clcEuVBHiNwZrFEFLLaZ/awVW3AECe3NmUsaOLiOeYH8duKHHTYDQZdeNr6Rcc4cCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951867; c=relaxed/simple;
	bh=kVt6UrSWufjy3JcgcBwWWqSrUZ+ir8vIBZW2yfEKGs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=g1gzn/Jsad35n5bjTe+XIytM/BSqSfV31C7G5zf/HSmYWmkk4nuVfhssRKgqim02rWtC/kh6E1IkA749G1TiMVkthHtvpj49VHQlJR022jfm/yX3f7UyHy+oRHzbcz45Fp0DoSjSB3V0BpuoHikNLJ9/gp6AgYnBoPEYjxhg7PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rkmstits; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rkmstits"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260213030423epoutp0373ee7ff14d6280b2d6d7097e9c94b139~Tr1Y0JVyM0569005690epoutp03N
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 03:04:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260213030423epoutp0373ee7ff14d6280b2d6d7097e9c94b139~Tr1Y0JVyM0569005690epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770951863;
	bh=/qg/lU5zUwj3jaAA/r4MmVGp2RVBxZk3sRmGUb9b9Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkmstitsrTAVjgstxLzH+zYd0a836s9/EhiYm2deZySKSZpYKdAfeqmbsj+84YbQg
	 U07Aa8AT2k4e0TgW1bkoWh12N1rkeJsm2M/41tVLc2v/0pxs5P/CEpe3+/xbDf2zrC
	 u8rMphyPAM/Z0/AVy5BTJBE3MHiClHE+XoP4rwlU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260213030422epcas5p1f3a7214515858452500de55bed83ba88~Tr1YX6eia2068120681epcas5p17;
	Fri, 13 Feb 2026 03:04:22 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fBxpZ5PCFz6B9mD; Fri, 13 Feb
	2026 03:04:22 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260213030422epcas5p22bbbba7e6436c630d7e8797896853af1~Tr1X_oH0O0621906219epcas5p2D;
	Fri, 13 Feb 2026 03:04:22 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260213030421epsmtip273d6e492e1769a7f565f81ed7670ca57~Tr1XdwAF82137521375epsmtip2-;
	Fri, 13 Feb 2026 03:04:21 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	ping.gao@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: [PATCH v2 3/3] dt-bindings: mmc: synopsys-dw-mshc: clk is not a
 must of two
Date: Fri, 13 Feb 2026 11:09:05 +0800
Message-ID: <20260213030905.1134519-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213030422epcas5p22bbbba7e6436c630d7e8797896853af1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

mmc biu and ciu clk don't have to be set

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index a6292777e376..e86fd53ed217 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -24,7 +24,6 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
     maxItems: 2
     description:
       Handle to "biu" and "ciu" clocks for the
-- 
2.50.1

