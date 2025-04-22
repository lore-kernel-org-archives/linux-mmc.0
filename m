Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545F276034;
	Tue, 22 Apr 2025 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354677; cv=none; b=FP5u0VHBPhxop4Vk3nYngri7uqcicWBbW4r7DCrZRMRUlyNjlHOhtJ6e836mQxDeiSCg/fquSEdz+rGTf+BVTJRqMhLVnmYkdI7keTRFLJqkhLGVNevC4HK32Ff9517Ur6HAtyb3dn6bm3l6sgzbztvHcvQ4CUBUTmuJKYVR6e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354677; c=relaxed/simple;
	bh=mY9GoG/UUugjJ18v5+GeCwpFlCvI5e4W/WJHx2Hfo2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf4m0AhIGUF4G+31ePgiufEVQk3rsR/Aqfyk9k5YdKkHYu7KpMK/FVnswXGN+nB44oBN86sP2S2h0b5C3h5dgSfo7DVYz6/BJ37O/rs8WnKSAFKiHe6SqIyphJnSidBo5eVUJDnn8kefg0uo0nhAzaNoqNP2nwPiPd3z5V+SbCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=szM4/4v/; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="szM4/4v/"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MKiEZT2103137
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 15:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745354654;
	bh=3W5pH2V1gyiEOmWsKa66R87bP2YeuD/Oj8gx8MCibcM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=szM4/4v/j1ZIuOu0+5pY7dAyAuMOeYqlCp5Ou5bJpAe6KV8UdaljyrKEXgfpoBHYk
	 aElZDnVJ8ihdYrBqjIkk7QisPIowEXYUlFtUju+p7d6OwaOs8thzxvui8+IuOAgV1p
	 M8WF275JXApYJBqOad697h+Gokl9F4OTxpFcPVj0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MKiEra064584
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 15:44:14 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 15:44:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 15:44:13 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MKiDWi061619;
	Tue, 22 Apr 2025 15:44:13 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth
 Menon <nm@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Josua Mayer <josua@solid-run.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Hiago De Franco
	<hialgofranco@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: mmc: sdhci-am654: Add ti,suppress-v1p8-ena
Date: Tue, 22 Apr 2025 15:44:11 -0500
Message-ID: <20250422204413.272679-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422204413.272679-1-jm@ti.com>
References: <20250422204413.272679-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Some Microcenter/Patriot SD cards and Kingston eMMC are failing init
across Sitara K3 boards. Init failure is due to the sequence when
V1P8_SIGNAL_ENA is set. The V1P8_SIGNAL_ENA has a timing component tied
to it where if set, switch to full-cycle timing happens. The failing
cards do not like change to full-cycle timing before changing bus
width, so add flag to sdhci-am654 binding to suppress V1P8_SIGNAL_ENA
before changing bus width. The switch to full-cycle timing should happen
with HIGH_SPEED_ENA after change of bus width.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 676a74695389..0f92bbf8e13b 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
@@ -201,6 +201,11 @@ properties:
       and the controller is required to be forced into Test mode
       to set the TESTCD bit.
 
+  ti,suppress-v1p8-ena:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      When present, V1P8_SIGNAL_ENA shall be suppressed.
+
 required:
   - compatible
   - reg
-- 
2.49.0

