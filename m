Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C283803F3;
	Mon,  2 Mar 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478145; cv=none; b=dKvqLFu4lRGWe2vJ/hgr+kQfKOvsNglGe6ItZj8CkSD8JPvvuFQDlpas2Yq9xqCrQ1cMv4Slo7mPONPyeVOnPxYXXZcf5wg8V2FNsQN50tllBv0BT/01xzOWDxga/4XmUBK2g+teOWbuWrFF07t304ICS4ZMaap6FeBqnavafc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478145; c=relaxed/simple;
	bh=4EeKldbEhbIwhqX3ncIFRGN+zPtpZ9ZQZNep9TgDy7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkvEE5oqaez4Xn3l1VooeLslwfmsWx62paqayS0y/nBEX3oBQzSK6xSRABGjfIav/A6j+DVotLgxb2M5/cYJR/VrjFOud1E9QkCsAGidbaq+BWx01Mn/PyxpCNko2T6JvfwU1x0aHn6GexhDcjPJon3c1x7SMlHzihLGPimOEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=KH2H2LAw; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="KH2H2LAw"
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622H2bME1787127;
	Mon, 2 Mar 2026 19:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=uRSPP/B0mJ4fJ
	Nb2nFRNafNM5Dq/DAtqmVJFczBYDho=; b=KH2H2LAwvNeGxQHWB+i0o4rhuXgpi
	4HKqM0ZKLQYYxm1VVSukaz+Hj31LNFQ108YqvdLsBNxcn1gUekAJVqRM9g3NGKXn
	FnPfuwOQVLxDuLvgxSW/gJOjHv7ZvKYOunU7kAqnodObEorBN4H+wwpy5POnfvsr
	+JTC/YvIKCRjmXB85Waze21mUQnDFnyWaY+WsuPFjncjhZzY6yrEVLscl+63rAHc
	f4lub76XVA0TBG1zeCd0YBArY0ZNlzB8EGZgRm64zzkgo/7xmbIaQwd1DrQRkYhI
	26JrjQld0Lx4xkn2cm/toHtQQDfFevr/9TeFdGtEiJhav2OqV14FKhpug==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cnbfe51tp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 19:02:03 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 79DEE81D227;
	Mon,  2 Mar 2026 19:02:02 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 17653821C53;
	Mon,  2 Mar 2026 19:02:02 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: jszhang@kernel.org, nick.hawkins@hpe.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
Date: Mon,  2 Mar 2026 13:01:40 -0600
Message-Id: <20260302190141.1481298-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302190141.1481298-1-nick.hawkins@hpe.com>
References: <20260302190141.1481298-1-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE0OCBTYWx0ZWRfX6PU9t7Kfa7oT
 rIEXA1H2TavJN0u3lB88aDdWnP4PrmoSOL+ZOUJN0hW98UqmCxhccJ+K8J99l/SylcIcxNmxcwX
 0kMMt0Q4VGL10bYBpj5Oltpa02jr0BvKZ/bxve2TeHN+JXgADI42G2gq6dGuBphHudS2/Xwcrze
 i9ANhgFdAFsLoGalTAmMFDGaYppNIrbC76BMTkX2TiK41RmqeTN6J+MWm7C0kbuGDGYi4Oik4iX
 TKs+dxAUnnH6mL5zWy7YgOsEhTmjzI6bZ972fMFm24TrRA8LSeD9dmol0qgQe1tojg/aDEVg9d5
 vKMfn0XDqGhcKsqFI/DMHfOLCeLHwF8h/1ZbioKooT4xblF1onbUz2UiRHmNmO56yOSsDi4ZxKj
 WkWLaNuyx5Uv4JY3wDT+RDtHbd7OS9YL81GvWDWZRAA0med5EGe+HPyd/APNeA1begwiR8jm/Nx
 8T3M73k1+iDL6GOWADw==
X-Authority-Analysis: v=2.4 cv=MqFfKmae c=1 sm=1 tr=0 ts=69a5deab cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=NCWKwCw8Xy9Og0ibBRsL:22 a=MvuuwTCpAAAA:8 a=Un5EUvwKq7LZpnUfPCQA:9
X-Proofpoint-GUID: s2iJS5iVYBma-iiDROwLsazxJEatQmz0
X-Proofpoint-ORIG-GUID: s2iJS5iVYBma-iiDROwLsazxJEatQmz0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_04,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020148

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the 'hpe,gsc-dwcmshc' compatible string for the HPE GSC (ARM64
Cortex-A53) BMC SoC eMMC controller.

The HPE GSC wires an additional 32-bit register, MSHCCS (eMMC
Configuration/Status Register).  This register
controls SCG sync disable (bit 18) for HS200 RX delay-line phase
selection and reflects the current data transfer width (bits 17:16).
A second reg entry is mandatory for this compatible to map MSHCCS.

The HPE GSC eMMC interface only exposes a single 'core' clock (no
bus clock), so clocks/clock-names are constrained to maxItems: 1.

Add an example node showing the two-entry reg layout (SDHCI base at
0xc0100000 and MSHCCS at 0xc0000110).

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 43 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index 7e7c55dc2440..9c326dff589f 100644
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
@@ -33,7 +34,8 @@ properties:
           - eswin,eic7700-dwcmshc
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -87,6 +89,35 @@ required:
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
+        reg:
+          items:
+            - description: SDHCI base registers
+            - description: |
+                MSHCCS register. A 32-bit register that controls SCG sync
+                disable (bit 18) for HS200 RX delay-line phase selection
+                and reflects the current data transfer width (bits 17:16).
+        clocks:
+          maxItems: 1
+          items:
+            - description: core clock
+        clock-names:
+          maxItems: 1
+          items:
+            - const: core
+
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
   - if:
       properties:
         compatible:
@@ -190,5 +221,15 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
     };
+  - |
+    mmc@c0100000 {
+      compatible = "hpe,gsc-dwcmshc";
+      reg = <0xc0100000 0x1000>, <0xc0000110 0x4>;
+      interrupts = <0 17 0x4>;
+      clocks = <&emmcclk>;
+      clock-names = "core";
+      bus-width = <8>;
+      non-removable;
+    };
 
 ...
-- 
2.34.1

