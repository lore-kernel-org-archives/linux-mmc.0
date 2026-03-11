Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046D3E275D;
	Wed, 11 Mar 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773252696; cv=none; b=rmV6J8L8NtvaDyHtMLsc0mEJ6w9Kr5e16NOIR9lYWUymCacHUxofe7ryHMfrR9vkeUAqWInLC5PipUZrW8sBnQk4qnYQB0Ros9wIK07DZVNepwk9akAd6VGDImrss+CRkXWbc94HMuZc74kZiPCjTCq7D93AHjdV+uk5uBzgV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773252696; c=relaxed/simple;
	bh=ZFCWkDjShmTxzAzuf3WMqjgbe0E+1RhwHyjyZvmng5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdZAgxA/EiQzcB+b4xBnx+jbVtJ+HDkngHAhh4K2t5n+waGCPWEajhLJthgT3C+kDUZr1piRGzwiAJBlpKH+WVtKDZRZzmBtcW0xOPvgIYu8Hn91TurXkYuuJUYAKXNWqAi1O8/7q148/M0Xv7cvfb98BhNvY8voCIuaZ9gccBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=ethFetFX; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="ethFetFX"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BGWG5Q3181922;
	Wed, 11 Mar 2026 18:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=trtzqw01eHYaX
	fdnc8eseJw+VgcB7uZ9iXgGEnqQSWY=; b=ethFetFXh2y4ek9vZalB52yvDwhxx
	ptIn6m86+lC5f5dO+VEaqw1zoKJhDuvgS5R9Y+ydCom10+IetPlltB+80bHZ+CCY
	TmY7LsbX3KadsDTPhwvfXvXoIokGnGkDhfxi6RRcYgxLWQ54dhfmNzEnyfjhHTR4
	68gCXIExN+Rk4CX3MFRzzk3BsC3K4L4rD5cCx4aHWpmA7jdVPpDPPGfqdW4fXomR
	oHUt5oIVBB78ukIULLzVzbKEzlGb3XdCJ6euz6iCtIEF6XzfM33fDZa6gfzO5akj
	pPRT0u2TuNaJHnQrgN9U5Xg9lQ3QhF+sUZiX5bAWYWJU7V0Q14g4Gsi+A==
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4cu8ercx6m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 18:11:24 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 184A1D28A;
	Wed, 11 Mar 2026 18:11:24 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id A3A4A8118FF;
	Wed, 11 Mar 2026 18:11:23 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, jszhang@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v3 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
Date: Wed, 11 Mar 2026 13:11:11 -0500
Message-Id: <20260311181112.1700667-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311181112.1700667-1-nick.hawkins@hpe.com>
References: <20260311181112.1700667-1-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: LaCIwzSuRPniJTNpCRQtcU7Ul6GWf_Ub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE1MyBTYWx0ZWRfX1HAceFIx1oN7
 c4qtI6dhzm/JOIX8Jh9UUMLE7tP2p+fvPvDQEt29X2qOLdhbwtZFEfjYu1SscPo3Cm8Caarx4CH
 jfDlf+nVBeUbnd+xnObDJklZQ1mxdp9Wbotnb8pagOFG/WaM/l0ozth4MMjgp011zHdimFwrWsF
 EM/iwicVN7+lfm7j+a3TqmbkinrTpUXO6wJn5UaYymruu6KAkT9dCWX2NiF/Vd9OzpJS7lL4uFE
 EvzuttBfoFhEd8zLWelUd5/tT1pt0wQ50Lhg7VY81/FU70bwGi2TgV+4b6ceM81u2wjPH4bAEgO
 psQfbxs3NCAHFm55kW22ACrnwzelT0vRrGjju3FG/m6Q/roFMgJTuj0C3VgBuWsv8pHuIfqTahu
 arPocTWyOqLPU3V3ac2AIoMPgGbBwJ+qV55jKnMG8tu6K/Hi3Nek/iTPAYWngtJuQQD0T0xX7hm
 ehwnHm1toS5xtMjGSLQ==
X-Authority-Analysis: v=2.4 cv=bdlmkePB c=1 sm=1 tr=0 ts=69b1b04c cx=c_pps
 a=5jkVtQsCUlC8zk5UhkBgHg==:117 a=5jkVtQsCUlC8zk5UhkBgHg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=MvuuwTCpAAAA:8 a=Un5EUvwKq7LZpnUfPCQA:9
X-Proofpoint-GUID: LaCIwzSuRPniJTNpCRQtcU7Ul6GWf_Ub
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110153

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the 'hpe,gsc-dwcmshc' compatible string for the HPE GSC (ARM64
Cortex-A53) BMC SoC eMMC controller.

The HPE GSC requires access to the MSHCCS register in the SoC system
register block to configure SCG sync disable (bit 18) for HS200 RX
delay-line phase selection.  The existing 'hpe,gxp-sysreg' syscon
phandle is required for this compatible to access MSHCCS via regmap.

The HPE GSC eMMC interface only exposes a single 'core' clock (no
bus clock), so clocks/clock-names are constrained to a single item.

Add an example node with the hpe,gxp-sysreg syscon reference.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 7e7c55dc2440..74734d46c70d 100644
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
@@ -87,6 +95,23 @@ required:
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
+          items:
+            - description: core clock
+        clock-names:
+          items:
+            - const: core
+      required:
+        - hpe,gxp-sysreg
+
   - if:
       properties:
         compatible:
@@ -190,5 +215,16 @@ examples:
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

