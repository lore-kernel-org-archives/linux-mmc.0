Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5C18FDD8;
	Mon, 30 Sep 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690163; cv=none; b=Pm6svoVisUB3NoAoC1pPUt8evYdgRZ7cGl3kP2+NOCL1YX6fDKoGqKkZt5CaH6VYLcIGwjmdWySKiNoSCEkYtujVYS4VTv/MM36sh0BhOSP/uOrRN52dIIF1oyn1h1bLOjRDs9SixkZ1t73ep+ZIKxcLTdHO9C9S/H130WUTeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690163; c=relaxed/simple;
	bh=k1rROxh5Gs3jvgvNWAFYwv2z8srcLk7JrVnM044I610=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzKNfaIYVEq/ImPu78a91MxtXUDWCUH3BM1Ac9mIhax7FjrqsT8bVo9Az/WEZTLrT0d4gWkBdnrzFf0QAhDqLqlkYk+SK9+inSwBR1lz51BcITQzM4s2L1+6yqgbkdfnyVEnpH13oIYRuQzYNBnpZ3Zx/jS7gbNuo4f8X6ZQLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wyPvbVjL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wyPvbVjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690161; x=1759226161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k1rROxh5Gs3jvgvNWAFYwv2z8srcLk7JrVnM044I610=;
  b=wyPvbVjLXpeXbqidGKk4z7nMiFuNvJjtiqCKA/seR9RpYwneY3h3e8Z4
   PM8czCiNOJTROAzNd4tcN2U2dSL3SE0oP8YAZ+iXKMlYL/sKiVXFIf5PL
   YOhdErVFSX6dtzrEGq34fQgTA5ftdaX0u8/G7Y57jfrODE31Vqv4DqRvt
   BghpZTIX6uYO2ecJ7b/WVul6lXztpOx5GMk0QGX3vxd1PjsL1CKVlDnO6
   Fv8MLGLp67yWiRYFJiIyTwqg7ekfewgjil+ORHSyit76CMRRZLKVDfYaq
   OY9h0yQHECTXhAQt23JsA0l8QLxlDWa2deGPSb/Q0ef/396BIAHMxDWDr
   w==;
X-CSE-ConnectionGUID: jBRUFo6rTUOCd1OoCerG2A==
X-CSE-MsgGUID: 4xsxqi+NTXiLrcoa+0W+pg==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32997923"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:44 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:42 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 16/20] dt-bindings: mmc: cdns,sdhci: ref sdhci-common.yaml
Date: Mon, 30 Sep 2024 10:54:45 +0100
Message-ID: <20240930095449.1813195-17-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

Since the Cadence sdhci controller is sdhci compatible, the cdns,sdhci.yaml
should ref sdhci-common.yaml to use 'sdhci-caps-mask' property.

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index ee3a838f7f06..0432cc96f7ca 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -121,7 +121,7 @@ required:
   - clocks
 
 allOf:
-  - $ref: mmc-controller.yaml
+  - $ref: sdhci-common.yaml
   - if:
       properties:
         compatible:
-- 
2.30.2

