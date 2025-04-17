Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43E263C6C;
	Thu, 17 Apr 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914429; cv=none; b=ATm5eP2S3kAYxnCH2WcagsnaF5y/Rs4B7nL5AQY6EWPJdytslrNUvuKOw0UzXkZRB/cHDl2CCgRTbO56VvTMMAKIgaZvTZNHN8d1chs+taFy96D5djFrL1HehsJgYgMQUJ/fSzrtrgMMnbdATG/2ev2fKSXp2ynwo+URQHCKFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914429; c=relaxed/simple;
	bh=kxO0jmq1J22W3tO6NM7xuzhBeyCuXVIlMZCgAT0+vAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UF5Olc5W1E6alFCV4G9QwQn7ptTSX9WA/VRHWlH4iUHvTx4bhnkIql5G3T1IFMmYeA4q29E0jcgKpyDuYowiCuU12e8llvls/gm3Dsf2rkLAU+ay17U9ji1tiRJ3BBE64GMes3TetZBDFB/kJOLdliHaMsrC78ghLosUbU7UdHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qF+AcnL3; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qF+AcnL3"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HIQqJn776763
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744914412;
	bh=Ohlrv8p/nL5mcOJYJvnHA1762wddtfXr8KDSWobN6+I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qF+AcnL35EJgCRWeBiYxNs7i3gd/q9FqAv0Mc5w013g4x+bimybTDT9Jeq93rFzvq
	 /aXBmpVTQCPfoQbX+25HRsbG6G8Q/tRrk3ON2w2ybW18nz5Y6WolSzlf7O/DxsGlSE
	 tR/L/wpOttshOZEThxuXRmgdN+Z16fIaYoP6yswU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HIQqZE026443
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 13:26:52 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 13:26:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 13:26:51 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HIQqh7078217;
	Thu, 17 Apr 2025 13:26:52 -0500
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Hiago De Franco <hiagofranco@gmail.com>
Subject: [PATCH v2 2/2] dt-bindings: mmc: sdhci-am654: Add ti,suppress-v1p8-ena
Date: Thu, 17 Apr 2025 13:26:52 -0500
Message-ID: <20250417182652.3521104-3-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417182652.3521104-1-jm@ti.com>
References: <20250417182652.3521104-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch documents ti,suppress-v1p8-ena which is a flag
used to suppress V1P8_SIGNAL_ENA in sdhci_am654 driver. This
quirk is necessary to fix fail init issues across various
types of SD cards tested on Sitara K3 SoCs.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
index 676a746953893..0f92bbf8e13b3 100644
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

