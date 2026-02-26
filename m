Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50E392809
	for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2026 09:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096761; cv=none; b=JRQAdIScTWB/ECjShLh6EzksfbQ7MagPkhNJzgPZLRzhuIYdsDgOX73jktfwo6OyUhh0zdsxicyxgooIoAwmSp70hqDTihoetsjn+Nu1Kr97Dyf6ud4BnB/cuM+czaRMVCQBbWTfviK6J/TGFTVExotvyxrYoylH67reZHgN+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096761; c=relaxed/simple;
	bh=aE2vtxJvalYSjSofMR04Km6NVyxGzqLey7HQnLxPN3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=uCkcHJZ1FUwlUldXUzFdok2eVKJCNCtVA8OHg1bWJL5HKX2iFRGS/dOHYfWzpjIgzsnu1+arHBpkzigLV20BQCD2DSi+HUVEH+4kbxKS8wYowwYdYREySrTVeDRI9/Fu4JiYCdgdDG1DCIxbidjDXG5ivDg5kNiDD4pRTo768MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DRJ4uOHU; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DRJ4uOHU"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260226090558epoutp027651d49231669cbb5309de3b11a4fe3c~XwJztFnMj0199201992epoutp02i
	for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2026 09:05:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260226090558epoutp027651d49231669cbb5309de3b11a4fe3c~XwJztFnMj0199201992epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772096758;
	bh=I7ZFQYOB7yx8R4QMFhxffaCSlEpWbjWPfNRbKezJ+x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRJ4uOHUgKfyR4R9Zjt0bSFyjHsNzPdgbqHLmHav4qAQUYWwak5v+boJYoi8b2wE2
	 G2r24IuqdlfzqoWnY+yz19gnXB5vSZEwm81DSvjjb/Ded+86Q6Pbh3KtX2Z67ELj1i
	 yR4b7NO0egxGn7wkEdlJCGTKMnLYXM9/zYlnQXvw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260226090558epcas5p34db3ae29a09e725ebeb5e29d4077b85a~XwJzP0PQG2391023910epcas5p3D;
	Thu, 26 Feb 2026 09:05:58 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fM5Cp0hGRz2SSKg; Thu, 26 Feb
	2026 09:05:58 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260226090557epcas5p417e32bd964f256e22e7005057e1d1092~XwJzDswpU0643906439epcas5p4F;
	Thu, 26 Feb 2026 09:05:57 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20260226090557epsmtip17501757744c424baa60b39ddfbef31ee~XwJyQlV1u0308703087epsmtip1R;
	Thu, 26 Feb 2026 09:05:57 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	robh@kernel.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, hy50.seo@samsung.com, kwangwon.min@samsung.com,
	ping.gao@samsung.com
Subject: [PATCH v3 3/3] dt-bindings: mmc: synopsys-dw-mshc: No need to
 enforce setting two clocks
Date: Thu, 26 Feb 2026 17:10:51 +0800
Message-ID: <20260226091051.300579-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260226090557epcas5p417e32bd964f256e22e7005057e1d1092
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

The driver `dw_mmc.c` now treats the biu clock as optional, so the
binding can be relaxed to allow a single clock.
Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index a6292777e376..7a02fb6f585b 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -24,11 +24,12 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
+    minItems: 1
     maxItems: 2
     description:
       Handle to "biu" and "ciu" clocks for the
       bus interface unit clock and the card interface unit clock.
+      If only one clock is present it must be "ciu" clock.
 
   clock-names:
     items:
-- 
2.50.1

