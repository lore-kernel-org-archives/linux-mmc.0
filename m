Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B4536CDE0;
	Mon,  9 Mar 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090841; cv=none; b=tGfpz4vlgNQfrlgBtnqPksEXzajX1PAyvBs/pggNkNYHk4Bn3XparkSoYkefVvnnIWYRVPjZtvn3V44WiyhLAw7bOTtgO/QJe1wID2RxGevzm4/rQeNR5dOuYRuKJkTuk9FDD/ku++ccccL2X2GvgFk5pFudXq7ibLmRX1KDyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090841; c=relaxed/simple;
	bh=P3TLGOTYmW2JWy5h+bBw/1GVqpV341A6sawleCSd0Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osVANDoHi2OYZf1VYWh7rs1A7J0/lY7w/1t3X9tjMy4ZJ6Ns+pQOTsUrFi+qvgSCarJL7rgh7qXcZNrLj/DQYJZMIPtGRjku2AV0kTasvQvapjrITkomfoI39AxKN2hO/2SrQ0oOOVeZJSt99eQq17CXcJvfS3ROsFcVS4vo3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=keM5vd6I; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="keM5vd6I"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HGXAS3656380;
	Mon, 9 Mar 2026 21:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=Bg+SDkhmklFob
	2w/fKY+k4wXENGM05jE2fQKluTUW1s=; b=keM5vd6I2HAf9bI64il46ipn6SqPI
	zJaagKk7y4gmz0ZcUuP0ZZDftNn9PbXFrBGAMyFPafKnA5EjCVtL3nkPh/UJhZ8O
	I8K1vpW5KFYyOkVMeNSajjQVBTnzJBY1pzPm6XULTg6PL4ZEyb3zpoULae2rhxJ1
	ldKiAmK/JsBLwm5E2Umd7yLomR+jEeCLiA6zNM70KmQb/KNWURT7saY80nCL3X+5
	bP8dSniN1QzGR/r4o5DhMHaO+qIoxxVJsWoKXwnRKurGDnRf7Mvp9W+zwHX9xtB6
	VhthqesGTLNUnyoi/p0EYuJAM+RXySWGD6avCWfFKsP1lYa7Qp+DD06EA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4ct2eyjmuu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 21:13:43 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id BB887808073;
	Mon,  9 Mar 2026 21:13:42 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 507AC805E91;
	Mon,  9 Mar 2026 21:13:42 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: jszhang@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
Date: Mon,  9 Mar 2026 16:13:32 -0500
Message-Id: <20260309211333.977919-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309211333.977919-1-nick.hawkins@hpe.com>
References: <20260309211333.977919-1-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZXNMQ6A2SZFSxMCog8hZZ75ZLL8DQhXF
X-Proofpoint-ORIG-GUID: ZXNMQ6A2SZFSxMCog8hZZ75ZLL8DQhXF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4OCBTYWx0ZWRfXzLr3OImS9XQB
 9dQorw5gJNF7auJ0hWeKgc+8Rg1ukLn5bJf1AyUB/qaDuOmQvPv9CE5uexJ4PCci5MO83Piufug
 GML71FBdu7zfknzQhOqKxvhfhDUFxIObDqUCx1Y+4vGI7FkNqVjketRpPy0LLKkK+E7mMBsiVYH
 mgnqs9umV/55hzZ7NZIDypWHxC47kbeRglo2pPrmJ5gqpEld/ZubBAaN25I/CSBNMk70/cNkuq5
 naU4T3kNSgQV3IDXrt89bTX9XZmpB6FK6ZSukWkB0LcjgG4+lDQufbTHYF8l6zhBsNDbF7WOfBg
 /xxKXCZRDL342Z4WaRKLqo5NmTB0LzsxKEB9oMAzGELOZKpusI3kfiOXw2LTJxeUjrRWXxCDjBn
 6UJT/ZLqYBdoj/thJsiRRb5bsK4G2BxbrM+sICtCVwLYbksPR1fqaflpeIIyAhfIjKXr+/5wIpx
 VSnlfXt3/ODy9Xy3P6w==
X-Authority-Analysis: v=2.4 cv=RO2+3oi+ c=1 sm=1 tr=0 ts=69af3807 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=MvuuwTCpAAAA:8 a=Un5EUvwKq7LZpnUfPCQA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090188

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the 'hpe,gsc-dwcmshc' compatible string for the HPE GSC (ARM64
Cortex-A53) BMC SoC eMMC controller.

The HPE GSC requires access to the MSHCCS register in the SoC system
register block to configure SCG sync disable (bit 18) for HS200 RX
delay-line phase selection.  The existing 'hpe,gxp-sysreg' syscon
phandle is required for this compatible to access MSHCCS via regmap.

The HPE GSC eMMC interface only exposes a single 'core' clock (no
bus clock), so clocks/clock-names are constrained to maxItems: 1.

Add an example node with the hpe,gxp-sysreg syscon reference.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 7e7c55dc2440..2998cc98085f 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -23,6 +23,7 @@ properties:
           - const: sophgo,sg2044-dwcmshc
           - const: sophgo,sg2042-dwcmshc
       - enum:
+          - hpe,gsc-dwcmshc
           - rockchip,rk3568-dwcmshc
           - rockchip,rk3588-dwcmshc
           - snps,dwcmshc-sdhci
@@ -77,6 +78,13 @@ properties:
     description: Specifies the drive impedance in Ohm.
     enum: [33, 40, 50, 66, 100]
 
+  hpe,gxp-sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the HPE GXP SoC system register block (syscon).
+      The driver accesses the MSHCCS register at offset 0x110 within
+      this block to configure clock synchronisation for HS200 tuning.
+
 required:
   - compatible
   - reg
@@ -87,6 +95,25 @@ required:
 allOf:
   - $ref: mmc-controller.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: hpe,gsc-dwcmshc
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+          items:
+            - description: core clock
+        clock-names:
+          maxItems: 1
+          items:
+            - const: core
+      required:
+        - hpe,gxp-sysreg
+
   - if:
       properties:
         compatible:
@@ -190,5 +217,16 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
     };
+  - |
+    mmc@c0100000 {
+      compatible = "hpe,gsc-dwcmshc";
+      reg = <0xc0100000 0x1000>;
+      interrupts = <0 17 0x4>;
+      clocks = <&emmcclk>;
+      clock-names = "core";
+      hpe,gxp-sysreg = <&soc_ctrl>;
+      bus-width = <8>;
+      non-removable;
+    };
 
 ...
-- 
2.34.1

