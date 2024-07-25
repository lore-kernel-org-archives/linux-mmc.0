Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036E199EBE;
	Thu, 25 Jul 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909839; cv=none; b=KV5RPUdifJIfbz0e4DXJENThtRrFyo5u10XkOKg98hdrXvSxrIy23mI4vrOXK5FaijZU2euxfnz3o1KRk1r8VzZY+a3zHz9tv5jGcnz0mBelphHX6ZTE2ck4kqCAzUyfQeO4Cvwt4PNw0LLV88QUOzcPZ7hPOICGJpUOPgvdVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909839; c=relaxed/simple;
	bh=N+lYGR9N7GxV/0gdIJYmJecSRf14UADZAk4S0TeqCRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz25IDYVRdm5f/4THXvgCSY7vCmyMBqPQbyT6UJzDZm7OBa7078TPnJz6rJTcKdtBN45sy4P/M6qgo9kDgFgUajJ5Ivf1fG85kBOUPejMXpJWdzXVOjab0el8in2vBkt8HheFGvIJ6CPd2uagDxXASlBSYfyT8i6J3qYDMdgXEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gtCRw9a7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gtCRw9a7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721909837; x=1753445837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+lYGR9N7GxV/0gdIJYmJecSRf14UADZAk4S0TeqCRQ=;
  b=gtCRw9a7XTA+kEKSOwMq4F0qXIN/6Iyn8NSJqm8v4DKwNZN++8NjiUxg
   DKfYdOpLUdmdUOciIQWb9tBl1AwP+PISaxSQst91/Jzf/PMpoeMTmQygP
   9Dh8Rcsccwg/t2Ti1gB5NbndvAgUaw6XTG4vblKUYdzflnY4clmna2Yln
   CEx06pGsQIoCSfZ6Lcza4jgt7UcKF1OGvd2bL2dEsLdyn1waNN1bxpfiM
   DG5xFoFDVJN3RE3dN/BbM6G/Sq17dkxvPpQtKB+Xb12fJFaEpt5vHTjOC
   CKfp1lGaRX97o8z/u08cYRFx3T4TWZYBcvkijioMrAqqu8C1A7YMM9QPm
   w==;
X-CSE-ConnectionGUID: FjEJXt1iShuJypsmHj+1Bw==
X-CSE-MsgGUID: AwuTO3CBT86BSfO5ZcXImA==
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; 
   d="scan'208";a="29650435"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jul 2024 05:17:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jul 2024 05:16:45 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jul 2024 05:16:43 -0700
From: <pierre-henry.moussay@microchip.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 11/17] dt-bindings: mmc: cdns: document Microchip PIC64GX MMC/SDHCI controller
Date: Thu, 25 Jul 2024 13:16:03 +0100
Message-ID: <20240725121609.13101-12-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX is compatible with cdns,sd4hc without any additional feature

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
---
 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 6c40611405a0..ee3a838f7f06 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -15,6 +15,7 @@ properties:
       - enum:
           - amd,pensando-elba-sd4hc
           - microchip,mpfs-sd4hc
+          - microchip,pic64gx-sd4hc
           - socionext,uniphier-sd4hc
       - const: cdns,sd4hc
 
-- 
2.30.2

