Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2098.outbound.protection.partner.outlook.cn [139.219.17.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AEC3D3D1B;
	Wed, 30 Sep 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764405; cv=fail; b=RLW6cRV6baF8Xy3QfAT0fzmwQzacZBojpOl2wR+mQ9N9n7w5/xjBPpKBwDvAHLlyYzzuBUAICXlsmlnnj1wbacKpovBUFsd8Q63+1byvzblzCnDn0LnTTVaQK4LTJoCagm4ngJSHPgsF07FnBgTqbWaINbpiUw7GvCAfrdNh+qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764405; c=relaxed/simple;
	bh=KSOnjp1+ujUPGcFM4qsJiH+ChHVOIZfYBbnUc4zuKO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gebKWplchHxnyH5qdf/3y79okCjZrdsiCReNAvhjRDLk7FJsFxWrFRqHMw1pTBU4dp7ULUxJOIVMAjIYb6k8w8LqKKjqfDgkIMCTGb+IQLKPbiCvQHhkyDto8NNrzx2hOh5aCmMG8FZpVTyPtqywcl1kNlLPJGOlo58vAiolZJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKpfO1llrx+UIZlyKZqm5R6A+mcQ1TRQVX7x4vUiXiI18JkyrJyQ8Z/FJG47m0KoyI6MFkQkrfp0pZ1g9XFRiR1ulvKMbJ3JtV75k1vdOlOEdmIUg8mEQoqPSU+LSjBfrdcwvsaxmN491y07J+YkEEDZjkObW6kUlyoACVOyQKbIb51nMzVt7Wlh4+uUjx2pcBQJ2RCiUUjKpcFwA9JPrH5RH/Ggv6RQcW/D4hyPm/7ffz7po49pRltSoFaNhqYALdVc/mYC7qAn2E9+l8BpQmxghHCoN/hw3oMAhOlwNvSThKdhhycIZouczA4XxYRzMbkobEIEpybDhX0+jElyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l244B2anpN6YzqWU6aUWh6V2Yy3/goN44xzSdZbFXU0=;
 b=VEnCNNtT9ad+cW2WKSNm9qIPy2owQ3mOCqsjfpsMZxSWd9h4/WGw3NTAj8gqTvMzqn3+9vu4+DwEpg9h7qRvSc7cnA3ZLmEuu8qenU/9hEVYpJWQoMc+GGHCextdaY44/zTSHiSNKjSbF9wuPhj1T0dMRk91gi+N6r64BE/db0K/QGnAE1OQ8jxnzibLrf+YMjF2spRnpMAEGqTJbpuPEWVWrakOzWSiWT5CyErIY0GoBV8sWTS4p1DkKe9Icue7XnVNS4lzUbDcj9GL9YjKnKq7GH7piuKbz+jAaVxbx28EHluMosffgnr1LBiKtZe7GA0xFMlHT9Fkulg/k3V0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1138.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 10:33:10 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0451.026; Wed, 30 Sep 2026 10:33:10 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Chen Wang <chen.wang@linux.dev>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Changhuang Liang <changhuang.liang@starfivetech.com>
Subject: [PATCH v2 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: Add starfive,jhb100-dwcmshc
Date: Wed, 30 Sep 2026 03:32:57 -0700
Message-Id: <20260930103258.13375-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
References: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::29) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1138:EE_
X-MS-Office365-Filtering-Correlation-Id: 253df7f3-b411-4225-9aa0-08df1ede393f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|52116014|18002099003|22082099003|38350700014|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	19WX3axjyszFIgr3lEZcoZHDCbKekXva5sgBCtPRvXNSHLN7f7d/5rsKy8VuCnU3r18lDVBxVrTV5c5iM0S9bogb4R1zoG/aZ7f3AVknVbKet5Oc+6gjm+hHMYf2NRyVdKxH4Xnu61O0gKl/tK5EDXJdZdND8v2AeKUrYmljrhxAg4zaeoHngI/E8rR8hssgAdtFma7WdQmjqkfPSUbiMAu6hku/l3/94q29BB/fH6Uj7daNrFLtWS6YcHfVZ2S/gWqJGvO+mY7SK0BuCWMO9jnfD1HELtEPEnhVQpa9094Z0eJAiGwrXTB18SIoTCgdCkbiU8G1sY7XrgVFI59QDGxCfENmRkD9+QOJBRh9z6A1WMAMW3TVxGMAU/RPxbzgTGGyhH74em+/VXUhi1Bw7Y4bGA2+TZSH8IMwDwDonkOLWxv7tYSJdNAjpUv23nlVypur4dLSQ8yZwf97ui8Lry9A58q4ZWqCOlmjFCT9ZZ60yL1NAy6itW+vF/OaswTJJCVPztNlThzWLmr+Y5LpUBuENdOGejisik9y4gKeL4Vf5x19gP5ZT1OE0+gKf+m0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(52116014)(18002099003)(22082099003)(38350700014)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QUewYtiQDNIe88qbLg/ykqoqnw7/h0EwhBQ9bW4ea5ltp+XvThvyyltnHUYM?=
 =?us-ascii?Q?i/IxHsN1ZacUN90SM0GiQc9XHCFFoMAXjkfaeQeFenj7mlyexkK8Lodx7xjG?=
 =?us-ascii?Q?XWhtC7WZU/XGdD1nERmf7vdkvd0W3ibwg7qF2Z7gL1XxYphfOyid/VXiHiKL?=
 =?us-ascii?Q?ljpx7YvhURG9kGjyVni2HCSz0m9xXw4By8aqAlBWid1VJlQjrDWpeuOKDApj?=
 =?us-ascii?Q?YCcZCHrFAYWY/4ZNIxZI94EsSJAr0R7ktMc4KI7tot29V3V1CMZ0Uy1Eo/z2?=
 =?us-ascii?Q?0mPtPZ0Z7nNEDzmEQC1SJ02i4FeawtlDC4rRVHwzySi7vw1q35M62yl0W6JA?=
 =?us-ascii?Q?8P317+3L8e7T+diTfgIsix7MtqGqTEoYRCZitTNb2IBEq+GlYeVeYWy8HeN6?=
 =?us-ascii?Q?KqLEk2vycuUF5IUnzWInGP6Dpm/zugjJrcyFXetzjidZF3gIu4zZwrYyX+3v?=
 =?us-ascii?Q?V0dCw46ImRrmibnVcxlzBmMxPWv5DBtVvaKFTRjJ+W8NqO4JWZ8VCLV3DJPY?=
 =?us-ascii?Q?34FN0d9uW6gO2IQGbdpAkKWEYgLHZfh+xlR6smxU8CdW40UA2hFAMGhpkEw5?=
 =?us-ascii?Q?imFS4TC6AeSyCkgo4V7ILyjqPS8jivusN+uN0k8UyFjbiSKUEYqLz1KS/jms?=
 =?us-ascii?Q?ehSmTHmlW1mK1GlFMcfjx5boJgWkCj1qFdRphpn1EL7+OOZZikVph2NN4LFW?=
 =?us-ascii?Q?+G7PcQ1mPC1R5VBAj41mlJnsEB2/SKAm4CKopUkTKnkbu0dzjK54m7Sd2v3a?=
 =?us-ascii?Q?mE5Khb/H81CVXJH2IpIcRpJlFtcqwsC3i0a+GRLT9pFpejjfXwjqsJEiXaqh?=
 =?us-ascii?Q?uDqEnrMGzw0t+90mNn9wv2gQBflxIgClNI7LC4HRFvV72MdG29TPEhFTPS/2?=
 =?us-ascii?Q?fgkr0QSoSNsJm1z0vOhuagkKVrwq2Oe9LaxPX2tINtGqZ23itzz3+aYwTqXB?=
 =?us-ascii?Q?o3bWXMao7vRNhIuDsNo++ifOMlJyBjMtuKI9ElMTgibnIpp7NmXBjwutDevc?=
 =?us-ascii?Q?bOBg1Ul6e1Dr+JkoEOYAFN6wtbSNcnlpcRrR4S403+iD6GMenNu7540PUhic?=
 =?us-ascii?Q?n8NNUch8A1mK+aeyRRgvYFsG8mCQQSfaitpJfDhQNrzQE4ha8P9okSiULYDN?=
 =?us-ascii?Q?0QJkLNn1Z9jAJpFv8qqNtsIvC9ScEaK6XRkW2+M4lH5uHAGYC9frSVxodBwM?=
 =?us-ascii?Q?Ltz63n2ZB+uyHSBBoDXar30mYOelnVkxGM8N/0I+JZ9MgxkXgbwN4XcWc+I3?=
 =?us-ascii?Q?YW1G2zJ/ceCEty4CW8SXgs/XnCMNZYwoGlhFspctcKOJXPGCQAHEjslTnUSu?=
 =?us-ascii?Q?VYuZ0LJP1lu/o3wV3qmLoZdI/R4rpeOYjelDf757APlApv1AiciHOPFBxm7G?=
 =?us-ascii?Q?s5ARogKxJFatOQcRiFEBaDwbZX2pW/FatkFKLxg618cRfpgRewXZwywslgC2?=
 =?us-ascii?Q?8AsGNZ90mWFtAc/zudw2ql1EwMfcvvjMHY9tVeDAkaUkjiTamj+zwZ/Fpa9j?=
 =?us-ascii?Q?HSvhrxrpN6MMO4UIePO1oBHAJV5NNzJ0ZX4JLHl33D+7RDCegrQELORfrRg9?=
 =?us-ascii?Q?AC3S36n5yWSOys6mPMBerdP3U9wzBivqLYUyX16PjV/61bYDWJtSXP17YJLx?=
 =?us-ascii?Q?oPtsQvb4BIEWcUjiRt1bOY3YZji8abSL4e6YbeqQ7pPueNoS5kjlX5jL5z8W?=
 =?us-ascii?Q?0zMLtI42sHvCs74HhKx1siEIPRgyebR70CgY2SmW0h9defu27HSnqyJT0xAJ?=
 =?us-ascii?Q?U/Ou0YiEc2cWN82Ot4mz9JMTQ33FjRX5hJ1sJrxwJwF+D2SuF3hf?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253df7f3-b411-4225-9aa0-08df1ede393f
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:33:10.3105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfuNT9h4OprybS2hGCaM6BIeg44q0wUEwwqehoV5Htg0bxfIekk+tH50+RcxMXr5MdXs2V25n7M3QCeJOpoAXoBF/vLAtSbyuFlhy3/KHfy31CPvhQ661JG2FMaGSb89
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1138

Add compatible string "starfive,jhb100-dwcmshc" for the StarFive
JHB100 SoC.

The JHB100 controller uses three clocks (core, bus and cclk_tx) and a
single reset, so relax the common resets/reset-names minItems from 4
to 1 and add a dedicated conditional schema for the JHB100 compatible
that constrains the clocks, clock-names, resets, reset-names and the
required starfive,jhb100-per1-syscon property. The property describes
the phandle to the PER1 SYSCON and the offset of the register holding
the upper DMA address bits [35:32] of the eMMC DMA address, used to
extend the default 32-bit DMA capability to 36-bit.

Also rework the existing if/else blocks so that the JHB100 compatible
is excluded from the branch that requires the extra resets, while
keeping the same constraints for the other SoCs.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      | 74 ++++++++++++++++++-
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
index cd823a3ef213..b5cdcc6e8f38 100644
--- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
@@ -32,6 +32,7 @@ properties:
           - sophgo,cv1800b-dwcmshc
           - sophgo,sg2002-dwcmshc
           - sophgo,sg2042-dwcmshc
+          - starfive,jhb100-dwcmshc
           - thead,th1520-dwcmshc
           - eswin,eic7700-dwcmshc
 
@@ -53,11 +54,11 @@ properties:
     maxItems: 1
 
   resets:
-    minItems: 4
+    minItems: 1
     maxItems: 5
 
   reset-names:
-    minItems: 4
+    minItems: 1
     maxItems: 5
 
   canaan,usb-phy:
@@ -98,6 +99,22 @@ properties:
       offset of the MSHCCS register used to configure clock
       synchronisation for HS200 tuning.
 
+  starfive,jhb100-per1-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: Phandle to StarFive JHB100 SoC Peripheral-1 syscon
+                         register block.
+          - description: Offset of the register used to configure the
+                         upper DMA address bits [35:32] of the eMMC DMA
+                         address.
+    description:
+      Phandle to the StarFive JHB100 SoC Peripheral-1 syscon register
+      block, and the offset of the register that holds the upper DMA
+      address bits [35:32] of the eMMC DMA address. This is used to
+      extend the default 32-bit DMA capability of the CMSHC controller
+      up to 36-bit.
+
 required:
   - compatible
   - reg
@@ -167,7 +184,16 @@ allOf:
             - const: core
             - const: bus
             - const: timer
-    else:
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - sophgo,sg2042-dwcmshc
+                - starfive,jhb100-dwcmshc
+    then:
       properties:
         clocks:
           minItems: 1
@@ -205,7 +231,16 @@ allOf:
       required:
         - eswin,hsp-sp-csr
         - eswin,drive-impedance-ohms
-    else:
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - eswin,eic7700-dwcmshc
+                - starfive,jhb100-dwcmshc
+    then:
       properties:
         resets:
           minItems: 5
@@ -228,6 +263,37 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jhb100-dwcmshc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: core clock
+            - description: bus clock
+            - description: card transmit clock
+        clock-names:
+          items:
+            - const: core
+            - const: bus
+            - const: cclk_tx
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: core
+        starfive,jhb100-per1-syscon: true
+      required:
+        - resets
+        - reset-names
+        - starfive,jhb100-per1-syscon
+    else:
+      properties:
+        starfive,jhb100-per1-syscon: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

