Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E08419CC14
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770960577; cv=none; b=jRl3iPmQMuh03SaNOHmsjIjKzr+DBgC2KtCB2QpFHYU9QmtfsEL0PeQsurnB6q2SaYlcZ1OYW3spCBsrnz3bckdQikOBvjYqKUmjBNWux/5yrc0TkmGijZK7vpY7oVwgtuAoA4uhTJku76QKsGwVSlo57cPQL/6PBaMJP3H76As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770960577; c=relaxed/simple;
	bh=urohyd3/JIP9sIyD/ax5s0MwSyjNtIpWgl8SnnolAvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=andu4zU/5YCnx8McNd2olfWpR15MF1zMr3Jw4Q5bGqSmWHF7V5xCM8fjPkemb9LRJoZi5L2msL8xSpkNK7w/TlEDyfvRsBWzyDBPywY4C3eSCdNJfOtkYdg2dLt/TzemmfHvSIr97dYlZUgfo8YWkag+zHJgTbBx6RS/uh5M9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YcjIfm5r; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YcjIfm5r"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260213052932epoutp047fd14b912f331c5089fbc30ce1534206~Tt0IU9Kvk2044020440epoutp04h
	for <linux-mmc@vger.kernel.org>; Fri, 13 Feb 2026 05:29:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260213052932epoutp047fd14b912f331c5089fbc30ce1534206~Tt0IU9Kvk2044020440epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770960572;
	bh=4Qr3Fvi1/zLIsMfxawbDmK9+M3gM629LbhgW8VTKITw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YcjIfm5rUCph0f3ldOQCFAvA22K68ZFWll2dtzXb1Qc1JxKz/CqA3x7ZVFXQIcIi+
	 l5soWD9vIXmbsPHf02JfDtdAPuYr753nKEd+VLJIrwgVhQE8bAW72L99nBslLZWrtO
	 8NbyLz9je3NWvqXDDf421EcGTBZWD0tyDQ6NDmPc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260213052932epcas5p27a3359194e1f36eeec705e4def7ebc25~Tt0IHhiIs3104931049epcas5p29;
	Fri, 13 Feb 2026 05:29:32 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fC1244qJtz2SSKg; Fri, 13 Feb
	2026 05:29:32 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260213052931epcas5p22e2dd2b9c88b1ad4333bcbe5a33cf7ce~Tt0HXa4TH3104031040epcas5p2s;
	Fri, 13 Feb 2026 05:29:31 +0000 (GMT)
Received: from hzsscr.. (unknown [109.120.22.104]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260213052931epsmtip234a02928003dbe2b6e77f52e989712ee~Tt0G0Ebaf1256312563epsmtip2B;
	Fri, 13 Feb 2026 05:29:31 +0000 (GMT)
From: "ping.gao" <ping.gao@samsung.com>
To: shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
	jh80.chung@samsung.com, sebastian.reichel@collabora.com,
	ping.gao@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: [PATCH v3 1/3] dt-bindings: mmc: synopsys-dw-mshc: No need to
 enforce setting two clocks
Date: Fri, 13 Feb 2026 13:34:15 +0800
Message-ID: <20260213053415.1337541-1-ping.gao@samsung.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260213052931epcas5p22e2dd2b9c88b1ad4333bcbe5a33cf7ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260123085150epcas5p42f2cc04843ae7657380b2968261246cb
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>

mmc biu_clk don't have to be set

Signed-off-by: ping.gao <ping.gao@samsung.com>
---
 Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
index a6292777e376..6617d644f08d 100644
--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
@@ -24,7 +24,7 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
+    minItems: 1
     maxItems: 2
     description:
       Handle to "biu" and "ciu" clocks for the
-- 
2.50.1

