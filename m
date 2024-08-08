Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46B18EFD6;
	Thu,  8 Aug 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135686; cv=pass; b=J9Og1Idiv8qU7KSfKD1xKgSYn+vbjqe8eWEHcLifg8Z1SN2YmO0jaZ8H0MCgUhgQ2h4Lt+orivyNI9fO6nrffZd6cxwvEQbYXv2RxmcHGgUvXwFEMGIM3tN2ZrxLH2ygxmhxr/5ehB6sDJTLhg+mkBq/LRpl3W3e3Ood14xEDxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135686; c=relaxed/simple;
	bh=LpnD5oFnVGfxOsm1LEqD9nBmSOLlBjDnLhr+FUOptIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1oMpjnS7hnjXuW8GqsOuzpm24ZYYThn2BDUn69ZuRqyUunEqP+NgfC1U+C2oLAokDBd8vVK02rCh+6g2wZk9H4q2PAu761dNFYYIrlbmbao4f51NIPdr6uwU1cNE3Fv3QN8SGyE0KUhXMgB7EIVNRipOFALJ+3vbmSkhn91fqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=eUeXtWIT; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="eUeXtWIT"
ARC-Seal: i=1; a=rsa-sha256; t=1723135668; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YAEl09JnraNSYxohjFcTxTRvx99kVb98TD3T+bzyZEUD6f6BjoLJ80qLd0NpAJSaAxF8es2RBscusazRhaCsDOqV6Qgj0Jl1cMjHv4zRFBGDrtx3awQn1YY1KtRARwMDCnQwIPvP5X8IsW8wJb9K8XEdVkD7BmYcWj/YMehoI80=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723135668; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=u7x3BBVWbQj9O66a03U8di21WFDenCBnzydCXxuHLKw=; 
	b=HVv2DWChYDU18R/iWwpcwuDaBnGQ8lv8txYGMmElAgg0uJ33RmKfJDS4aPiW2McbivTDFBaptyfX0cSqpR8nwBwQpWG4RzGO9Ig85xJVhDeloHNWszlyxE+rYfrDWpLyvZLutCT5CEYMBbjdPN6M346XEEvVj/1MYDOZhT/OK8k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723135668;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=u7x3BBVWbQj9O66a03U8di21WFDenCBnzydCXxuHLKw=;
	b=eUeXtWITwa8zubnC+fOUmdVshnafTbqsiYktGgnqFWbkiUbFuvoubyqsG8igT0pF
	adGgdtfE3QpcdpQeiSQ2GmtJqhKjQ4NTKBsqVMebArRWbSuGbzpOTwMWYsFvboROH+S
	szk+XvptbA8PscLdeRiAa7Lz01VxsMU++fFXF0ys=
Received: by mx.zohomail.com with SMTPS id 1723135665925829.4284392419496;
	Thu, 8 Aug 2024 09:47:45 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: Add support for rk3576 dw-mshc
Date: Thu,  8 Aug 2024 12:47:15 -0400
Message-ID: <20240808164900.81871-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808164900.81871-1-detlev.casanova@collabora.com>
References: <20240808164900.81871-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add the compatible string for rockchip,rk3576-dw-mshc and add support
for the rockchip,v2-tuning flag, a new feature of this core.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index 211cd0b0bc5f3..86c986a7adb23 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -39,6 +39,7 @@ properties:
               - rockchip,rk3368-dw-mshc
               - rockchip,rk3399-dw-mshc
               - rockchip,rk3568-dw-mshc
+              - rockchip,rk3576-dw-mshc
               - rockchip,rk3588-dw-mshc
               - rockchip,rv1108-dw-mshc
               - rockchip,rv1126-dw-mshc
@@ -95,6 +96,12 @@ properties:
       If not specified, the host will do tuning for 360 times,
       namely tuning for each degree.
 
+  rockchip,v2-tuning:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Specify when the v2 tuning is supported. In this case, the hardware
+      inherits pre-stage loader's phase settings.
+
 required:
   - compatible
   - reg
-- 
2.46.0

