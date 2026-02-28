Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418A3451B3
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259629; cv=none; b=qdClNviRel6Hq8zTWC1vXY+1y9REdmcwau27q5PSHMqMGqiRBRwbKSraNf6u7QVTSpLRJGFxQqCeZjOoo1DbYSoEbQEc8/5rfEmgUW3AwJa7zhcV8P++go/4gwLSchUwjYnN0TNys7ZozoKeeu6hXD2/NH820aOHqJvyWSEe5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259629; c=relaxed/simple;
	bh=4V6ap+RTpnsrSNEK1rzXVP+ZZTFVjdidi3oepQXFslE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=qr9x7vlrFb6/O7aWZAPX4Nwu9ibTgtJJ6gUY/6FsfyTUcg1INbVk+NGcRxipEXNMrWTayAyv4KGOkHPjV9fYY1Y6vWJgX+U46k+WfEn0CxrEwgT20o44CxdwgYb3nJpyP+sVpgHZg7icuhefEBPQnr37huzYvYbJI5LwwfMIas4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=buJZIeh3; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="buJZIeh3"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260228062025epoutp0313af8245d3c173383bd68117a0abb540~YVL1vzuUr0219702197epoutp032
	for <linux-mmc@vger.kernel.org>; Sat, 28 Feb 2026 06:20:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260228062025epoutp0313af8245d3c173383bd68117a0abb540~YVL1vzuUr0219702197epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772259626;
	bh=yTucolrMkBlXoqpoca+3rkjS9EKuhQIZMHXPgsJ+zNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buJZIeh320Ji4bl95F3mgtb0xLf/eLoDlU11PGiIx/wJFeBIAt5RW6xhiNQyDGhWD
	 P7oe3o6wVat6hvnSz3pz7aULQaengq6NHf4owLL/BVtPQoufO+J4iSZD+0I9i0Amwl
	 dFWtIYev1el9hqZkWi5fFiadEBwqRKrc29eIcCGU=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260228062025epcas5p150626f458e0e71b5de9e09df76ab567c~YVL1QHhJJ2841428414epcas5p1z;
	Sat, 28 Feb 2026 06:20:25 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fNFRs2wFNz2SSKX; Sat, 28 Feb
	2026 06:20:25 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260228062024epcas5p4a9f901ea58ead972a352cb4546464c1c~YVL01WDDM1136911369epcas5p4s;
	Sat, 28 Feb 2026 06:20:24 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260228062024epsmtip2bbe6147bf3f90b05c5048fbc56986349~YVL0Gi6dg1749217492epsmtip2R;
	Sat, 28 Feb 2026 06:20:24 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: shawn.lin@rock-chips.com, krzk@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kwangwon.min@samsung.com, hy50.seo@samsung.com, Ping Gao
	<ping.gao@samsung.com>
Subject: [PATCH v4 1/3] dt-bindings: mmc: synopsys-dw-mshc: relax clocks
 constraint
Date: Sat, 28 Feb 2026 14:24:55 +0800
Message-ID: <20260228062457.3210099-2-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260228062457.3210099-1-ping.gao@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260228062024epcas5p4a9f901ea58ead972a352cb4546464c1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260228062024epcas5p4a9f901ea58ead972a352cb4546464c1c
References: <20260228062457.3210099-1-ping.gao@samsung.com>
	<CGME20260228062024epcas5p4a9f901ea58ead972a352cb4546464c1c@epcas5p4.samsung.com>

From: Ping Gao <ping.gao@samsung.com>

In some SoC designs (e.g., certain Samsung Exynos platforms), the Bus
Interface Unit (BIU) and Card Interface Unit (CIU) clocks are tied
together or driven by a single clock source. In such hardware
configurations, only one clock entry needs to be described in the
device tree.

Relax the clocks and clock-names constraints to allow a single clock
while maintaining backward compatibility for existing dual-clock
designs.

Signed-off-by: Ping Gao <ping.gao@samsung.com>
---
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index a6292777e376..47dff8d4be27 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -24,16 +24,21 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
+    minItems: 1
     maxItems: 2
     description:
       Handle to "biu" and "ciu" clocks for the
       bus interface unit clock and the card interface unit clock.
 
   clock-names:
-    items:
-      - const: biu
-      - const: ciu
+    minItems: 1
+    maxItems: 2
+    oneOf:
+      - items:
+          - const: biu
+          - const: ciu
+      - items:
+          - const: ciu
 
   iommus:
     maxItems: 1
-- 
2.50.1

