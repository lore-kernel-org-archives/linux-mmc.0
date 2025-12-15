Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0273336EC7;
	Mon, 15 Dec 2025 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834066; cv=none; b=HSbGTYTQQNlJWShxQvKiyDZP46NgWnSlvYK8frvekmPbLX+UWUqLTbA3LNgtDWAfmhPz+IY+PrXch650pSGJZkrqwHUl1eOBMJHVtIfQ9Xnw4Ymv/zsmBhxuRUDk2yoK/JaQWUfjSIqjnYorplmZcvdGVKrnr0uo40C0/nh3ia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834066; c=relaxed/simple;
	bh=r6glPJkGDRnE9QV9s0gHGEsKWDrDjC1sCQkD22i2y8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l9NBTLsafwQ/1JQBYYAaMYiTn1bPl99ffWYK0cK94/8nEwcoiIgi50YW+cl71UIVMX0aNN+nYNLwDPXabnQVzzRQ9G2U99RhyYXC9D/3rQZflVKg/JG6CUKP3dzjaRJ1deKhl078yrZPXACD50Ja40V0VlAsV5w74tBDj26HOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csoQvDWI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csoQvDWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F268C4CEF5;
	Mon, 15 Dec 2025 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765834065;
	bh=r6glPJkGDRnE9QV9s0gHGEsKWDrDjC1sCQkD22i2y8Q=;
	h=From:To:Cc:Subject:Date:From;
	b=csoQvDWI3ZDPGBSuHtp9FdEBk/htR+inuruaN0aSZRRB92WGewLRzoLVisoHSyWsF
	 vsbOVfCx/dpec7vtYK7bFvO/ECr03cXSIhxy9p/dh/6TRIq2A8FZXBzpsJkeYFO4ep
	 X9gXOhXXGUOchXNlscGNc9KgLuvU2+jFyIg3ktZ5vONkWEtjP0bklJqI/YCatWGQKn
	 rpAMCwPayvG1z3uZO1f6g2Ymlm1HNY2PFxuS4FLzs0qpvYsP/VmY6FrIIa367m5fYI
	 CWTmVV9a/V2+58dUE7LT0tW/SPWi3DWeGd39wuY3IN8jvVbblvmraf8R71eqtjTiLw
	 AzEuZ8yhS360g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>
Cc: Ray Jui <ray.jui@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: brcm,iproc-sdhci: Allow "dma-coherent" and "iommus" properties
Date: Mon, 15 Dec 2025 15:27:36 -0600
Message-ID: <20251215212736.3321550-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Broadcom iProc SDHCI controller is DMA coherent and/or behind an IOMMU
on some Broadcom SoCs, so allow the dma-coherent and iommus properties.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
index 2f63f2cdeb71..65bb2f66f8cf 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
@@ -26,9 +26,14 @@ properties:
   reg:
     minItems: 1
 
+  dma-coherent: true
+
   interrupts:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
   clocks:
     maxItems: 1
     description:
-- 
2.51.0

