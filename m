Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E4818B47E;
	Mon, 30 Sep 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690159; cv=none; b=KBOT6BPshCPLhvdIsqsAAevPFj/MEmNzmJmoa80luoPuhHb1IsqbJAuuUh49A9KBeDbIrMgpWi008D9VpgoLAr4caRS+8ltYOZS3I2fENqKhxRAd7f/G04RM4Ym/Fx4TuJB2ygnEuu6cKGuTppu/cRCLshSV+JMqDA6sVqvbUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690159; c=relaxed/simple;
	bh=N+lYGR9N7GxV/0gdIJYmJecSRf14UADZAk4S0TeqCRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLMGPVP5FDDp2tDONn8kSLJylE5vonEBNwkAN09dRFUyy60PcYw6HatQOd2ihY/y93FAOIwre9dtcFZ2mtbbxDymlgKs/98pCELRCHtSX8NeCQSXtGfluYvlgdd2wxvnwaNWYxhbrjv4aWBHY1AocqV0K+/rrtJyR//A7wuERFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k2K+zazD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k2K+zazD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690158; x=1759226158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N+lYGR9N7GxV/0gdIJYmJecSRf14UADZAk4S0TeqCRQ=;
  b=k2K+zazDGsGO4L943ztsviN1Xjkp+ddfRknTAwZOpb5evZAVPkHkvL7R
   Np+p2Bn8zZvBuuKLsCdG8HDmLYRDeKlFx80O3iJ5X0E21dRq5+Wug4aSM
   tTWr1al0XhDwJjdH8neL0u1FH1oKrMv52OHhofZPT7EzePdLl+ebpQQW1
   tgfp3LlT2kavhTiy5ECDQNfnWg1jV9HMslJ7Ql0OtqwEjs4rN6DyA9KrE
   Q+h7pnSAsxF7r8R5Pe4Nc+w92p3DeyPrp4yq1RWu87bdroMT82fvaTBmA
   xor+33jNm8uIKSUQd3zsK7nY3LyUpUvT9zgw7YaLbg06U0RDvh2zx7+7X
   g==;
X-CSE-ConnectionGUID: jBRUFo6rTUOCd1OoCerG2A==
X-CSE-MsgGUID: lAl8VZjPSfOf4Owf5TCnlA==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32997911"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:55:28 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:55:27 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 11/20] dt-bindings: mmc: cdns: document Microchip PIC64GX MMC/SDHCI controller
Date: Mon, 30 Sep 2024 10:54:40 +0100
Message-ID: <20240930095449.1813195-12-pierre-henry.moussay@microchip.com>
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

