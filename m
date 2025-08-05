Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF2524F;
	Tue,  5 Aug 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437801; cv=none; b=kSDavQ9MZF8ZHuimz910FUvFUOsfLsLU8E//azF9WENkXLFMnXPCicZRnZ4ixaMZXtX9knSCHxXvBPOxW/aDzjJhVUecAzfeszSSUPIqenW1tF3b5vVppeDCRxcnLxSmuOPp+HSRkAZ75yssZMG0MwM4v0DN6sklB+d/JoeXTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437801; c=relaxed/simple;
	bh=p2p4vKS5wYDCxNQLe3U+0FgrcL9pSAk87OCo+vsR5pM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3qH1c4kaMdeuTnvHdZnjdvkkOlQbCTby5UvkgURD3jKHJIb+FYlpmXOxpR0sjO5VdQMtEu6rAtL3xPih9Zl3lFmIzwKJuKuMVc3zX/BC97C2GWA/TbmqzZgJlku2Vj/0yCvXJzHivWaaSgx2arUYLT+W8XcfLrqyRyMVwM0pK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bIsXxALN; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bIsXxALN"
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575NnpVa387998;
	Tue, 5 Aug 2025 18:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754437791;
	bh=OWll8aXw8aHwO/nZCoAePnctU5zQKd6s1MSx1yOQJ/c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bIsXxALNZCxgM9MZpL8IVa3U7/riBpqlbzXjh+MAmq05d3w1mVfrqxgkhISs2Jbpr
	 3EuRvOOaRRhgFNMuSPQOFKdhxxXi8keEzUivJFii73yYtpQ0s/twmw1VkR4biyZto3
	 FIrFjpiHRWI+RcVs5FjDmHqJ8NtC/AuUjBwcsqyM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575NnpOp3149163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 18:49:51 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 18:49:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 18:49:50 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575Nno6n2624898;
	Tue, 5 Aug 2025 18:49:50 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: hwinfo: Add second register range for GP_SW
Date: Tue, 5 Aug 2025 18:49:47 -0500
Message-ID: <20250805234950.3781367-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805234950.3781367-1-jm@ti.com>
References: <20250805234950.3781367-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This adds a second register range in ti,k3-socinfo. This register
range can also be used to detect silicon revisions.

AM62px SR1.0, SR1.1, and SR1.2 can only be distinguished with GP_SW
registers, so increase maximum items to 2 for reg property and update
the example.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 .../devicetree/bindings/hwinfo/ti,k3-socinfo.yaml        | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
index dada28b47ea0..3b656fc0cb5a 100644
--- a/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
+++ b/Documentation/devicetree/bindings/hwinfo/ti,k3-socinfo.yaml
@@ -24,7 +24,8 @@ properties:
       - const: ti,am654-chipid
 
   reg:
-    maxItems: 1
+    maxItems: 2
+    minItems: 1
 
 required:
   - compatible
@@ -34,7 +35,9 @@ additionalProperties: false
 
 examples:
   - |
-    chipid@43000014 {
+    chipid@14 {
         compatible = "ti,am654-chipid";
-        reg = <0x43000014 0x4>;
+        reg = <0x43000014 0x4>,
+              <0x43000230 0x10>;
+        bootph-all;
     };
-- 
2.49.0

