Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D7337B9F;
	Mon, 15 Dec 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834080; cv=none; b=hxnlgLO4mrw1dskpqgAdfEL/mJNJs1G8K2sePH1EAoytU1t7QYZdiL4AcbiXx2CyVLpYCkHOINymOQz8pdKyzTFpGOUvKoGdN3rC6nQj7/X9K+uD4PeRe4DNEJbGP/73JY3ZialxTZHKzEQfDX+cYGLGGAK+dUFLGhUsPKCQuNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834080; c=relaxed/simple;
	bh=n5vgBgys/+Y+mTrRSIRDd9uwfaaHxjSoUs4hAura+JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TqfLpeTHyn5GHA1zv72j9mwLUZzIwiJMT6rH5bT6UTgoCZ2zWdzJkx29ONuVR+MtqBnB9U4nm5oZOvK9zKEoBjjeBTa2yz7A3pkMRnjjzzMBwx9Yg2gCDCh4vldJGD1u54TDO/d3JLZrY+Wdtco/Yye1CfefUbwHpKJipaFm3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYvONRxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYvONRxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE68C4CEF5;
	Mon, 15 Dec 2025 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765834079;
	bh=n5vgBgys/+Y+mTrRSIRDd9uwfaaHxjSoUs4hAura+JE=;
	h=From:To:Cc:Subject:Date:From;
	b=pYvONRxpduLtiaekziw8bxTvTcvh4fwmMzcWRIIhbyUHj6JkifN2U6ag4Zjo5tqbj
	 6WwdGnpKbdVZsLC6XAvwwgMWvVu/3zAoAXU3s6jwPDun3ZjHji2zwh9n+KuMVwufaQ
	 GVM1Bp+w4wFi3Ex6eBn8sP+bZ6+q8p9LmmK0RfPlcyRAr1oQe/MnatJBrtHdjBM9xA
	 5EDE9Hg1rRRrXSAxb9f6WkNRk4R4K7OvFc2G6ErN3kLO0H0hpap3hIor9Hv0RuFOrc
	 Yc+CU4cSokyLGQIDrfwOgEU2krQend97AMHXNZLLF1p3RMkv8MKDcQIR9Yoks9q9jO
	 R76gEQTpbj75w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: arasan,sdhci: Allow "dma-coherent" property
Date: Mon, 15 Dec 2025 15:27:50 -0600
Message-ID: <20251215212751.3321878-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arasan SDHCI controller is DMA coherent on the APM merlin SoC, so allow
the dma-coherent property. No reason implementations can't also be coherent
and there's not an SoC specific compatible, so allow it on any platform.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 8e79de97b242..d6b6fa6dcffb 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -121,6 +121,8 @@ properties:
       - const: clk_ahb
       - const: gate
 
+  dma-coherent: true
+
   interrupts:
     minItems: 1
     maxItems: 2
-- 
2.51.0

