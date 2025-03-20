Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA722AE76;
	Thu, 20 Mar 2025 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742506575; cv=none; b=Uy7PJTIOArYJZElR7bHBr9oY/hnZB3aHG+DT8jKdaGVhYoiIabRmfKPuRLgdQa+33Pq3hCJAUDYsOh+mxqoO1/pkKyLWVDHMN2D+0mlw9GvcnO5uR5kU8Yc1UlvUPfNPh0Vjy9OWWN663qNwAOcRqzMEi9/gQJTY5ryGsXG1+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742506575; c=relaxed/simple;
	bh=w7+2idG48iwt6RdM0BdjXyWR2kOyypN3ae3K6dy6cJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mm1G7zsY5HUNqjaExkChq9qB2uzlSZy0+bp1lrbTee0cDhjm3NR72VZ8x7+n41+UmiaUwoCs9sVF039+AWWlIt56UeO4axus0MTIbtv6hb06hmIYStu8gsa7pra1eaDIZNYc6pcCBxLDPI6k9TyGm2JHrbzf2cUGgcvENx6HFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEfeDncB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEfeDncB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07ADC4CEE3;
	Thu, 20 Mar 2025 21:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742506574;
	bh=w7+2idG48iwt6RdM0BdjXyWR2kOyypN3ae3K6dy6cJY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QEfeDncBOHJb2l7jM1Bq5CztiODqjtqd9sjuPZb1epRHlO5qa8oHRIfoWGT/JN+WP
	 ReVV4wOeQDY3B1p/RewwHtMHCGj1etQS4o+kSiGME3qi//Ur+j9yjv+RP323HOZAca
	 vrbC6UMzFDoEQU+w5Xyx6A2N3bZ8jimBsWjtFU84e8ZG7XeW+0E+6noGWPwE80ET+S
	 uKw+CxzqB3IBuUlccPqr0gvsdddrraAnldS0+lbf5cF69HADE2piJApdJuhPaTdL5r
	 xJIpuojWzzjXxF2OC/CE3OtFVcQwZCUElRUKJV7U/P38p9/ekB7KG/NsCiaJBBnzLW
	 7DXCqqFslRlUw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 20 Mar 2025 16:35:48 -0500
Subject: [PATCH 3/3] dt-bindings: mmc: marvell,xenon-sdhci: Drop requiring
 2 clocks
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-dt-marvell-mmc-v1-3-e51002ea0238@kernel.org>
References: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
In-Reply-To: <20250320-dt-marvell-mmc-v1-0-e51002ea0238@kernel.org>
To: Hu Ziji <huziji@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

The "axi" clock is optional on at least the "marvell,armada-ap806-sdhci"
variant. Not sure what's correct here, so just drop the constraint.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index e7df7a2a0331..ee2ddef36369 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -169,26 +169,6 @@ allOf:
 
         marvell,pad-type: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - marvell,armada-cp110-sdhci
-              - marvell,armada-ap807-sdhci
-              - marvell,armada-ap806-sdhci
-
-    then:
-      properties:
-        clocks:
-          minItems: 2
-
-        clock-names:
-          items:
-            - const: core
-            - const: axi
-
-
 required:
   - compatible
   - reg

-- 
2.47.2

