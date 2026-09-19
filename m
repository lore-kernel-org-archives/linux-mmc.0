Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CB3FD14F;
	Sat, 19 Sep 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789811112; cv=fail; b=HD9SLQm3z5nDH9tUOa065g/REivvsu+1ognTYZsmlvNCBYAVkTYKwxZ6RhH0GNmi9A5a4iE7fH+t/dNkgRkUPyxTXSZ3rW6NrZI/YNF6NZmZIOW+qs5udSan/KqUARfrwYDmRz+JT6jG4S/PdgSZJa6sK/PCB4+HN9WR9rNYE0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789811112; c=relaxed/simple;
	bh=pqbeVQgdmIegu3AhNQyulWn7f/fpNIxB6SvdinppIuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYIGNJIlYNXCgdx5HndynL0Cpy4/D811BAIgkBnMwLlvEjaabf06azHnIBoScW3zW6iZ5jTxpSNK6BzfP5EjA8X1dGLU45PIsiuhafxQzSByvbGPPdmhdV4rrIKG4l9WyyOwFX2AGQGo23czWEdA7IX0TiG7zbulRrHHfaYS6cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODTLv2gvf2u3XEJkAPfEjA1Anf2d6ftZF6x9bMJPcfbudePrmRFlo7IYwmqH0zcIjRac2Eh1PsMOLEEeeDUGy+DSK5YKOs3con96EGs0x/fA4qlFh64ClpJgtKiz1X+Lu9GrvlZ/IQfo2W2D9P+L8Qm6FpbZQFvJImyzzwCBZ36SThG/80pQ8wKYQAmcFvdop4i+oLbobQ1wZUALNRRrDOFjmZcwMfkaCJ3pgGzuCMzc+7d712954xZNfudvKNYgfzms16sN0azZ3ufG1URdoERHePk6eazgf+otlLINiMYXCSCT/o1hkDEKn9CRs1BWZRjwE8sDz5Bl8MJLYxIIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yd/4saM6D2s+jFmENbOiWpIceYIitRhsilMcmaqyooo=;
 b=c4PLfAJ6GqECkK7u7wrw71J/7EB/Ip6Z4vICfVJd7aBhcFF/wagwXPT6AAJZvoViZfkVKp32wAqxMRLX3hKYxtf3FkchkNUMbcRPeYaig9VCjz25dRbT/DvLNsF/hQINrqxRAYTM5bALCnUAVYKMKD7e6tMiiXxIxUA0DMuRMTNDpdwCNEW0/1/ECrBpF6a09VE653kem29+YVRwXScfs7YUAEM/GEW33KOuxi9CcAUk5YyYtBMgeaqRQes/WknnAi8PXADR0CiJDyiTMaSXOGa5aprtS+vIpRUd0yBCkH+7mCWiYNGrAtuSKkSDttbY7yPt21Muzzifvc/OTSAnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1155.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Sat, 19 Sep
 2026 09:30:00 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::e7d4:256c:b066:850d]) by
 ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn ([fe80::e7d4:256c:b066:850d%4])
 with mapi id 15.21.0428.014; Sat, 19 Sep 2026 09:30:00 +0000
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
Subject: [PATCH v1 1/2] dt-bindings: mmc: snps,dwcmshc-sdhci: Add starfive,jhb100-dwcmshc
Date: Sat, 19 Sep 2026 02:29:49 -0700
Message-Id: <20260919092950.178617-2-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260919092950.178617-1-changhuang.liang@starfivetech.com>
References: <20260919092950.178617-1-changhuang.liang@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0001.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::12) To ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1ac098-e054-4ccb-265d-08df16309387
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|23010399003|1800799024|366016|56012099006|10067099003|3023799007|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HbYeGSoicEXbU0ojLILTlWVQJGWMJi6/sDnUFf4gEqOxFfeZwRayaF+AdeO2sJ8/tI0KRMk+h5/eJHWqFa8shQP16zsWtLdxqvgCCt8L+RsV3x2zgLFDpKEqDIo0NohOfib8Q58FAa+2N4zjZMEcqwAAiIB1UnoJcY0k/q5nzDMaeFTIkLyXzQIEXKnXRWWGOFXCEXKAvS1qkVglk0Ygrh2d+XB0+pFpZK91o0enuG8SWT6XQTfIJ54KCl8y2Z5a3frBja+vxM59WY+3xlqVtb4nmv8+xzw4bPxGPkinkJ+Szvfle+ln1Ke4SSkNqTJczzcc8DlmSzlBHQxP0RLOG8nzgbTdvHj/YuOp9OHAJ0qAuo0O8jCcooDT6aZ59Fbyj8ZNd8VHo4q9he8BUM4/EUecPrH6jDJUoBdEg5B/QluexPTRDwHPDXT/L3Mh3pwzUVLfHwXzSn1Kbq4ddb/4cCXC4XLqRPaMgE+Yfw/2uKmo/TyhRPcaqNVKzRCBMh2FB/OkwhA1qIlZIclf3fQKQYmsik0BDIJyiX2eEBiLTd/QIpCcGFpvjurBXq3lJwRs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(3023799007)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRAF3hLGFjNFFGvBzsAx/r48kSl6Ej5d+KXAqY4+9ZDhd+lJgN/8wDxLy70a?=
 =?us-ascii?Q?7oo8DyS84AuKqYuTIEUE2ROe0gfqwX31P8kWoSTWFhrbrXqmylOwRkz3A+d2?=
 =?us-ascii?Q?zUwgCw+GOxA5uemIzenlSdGeeIxQpwkrm39lT49GiXbNGGaep9TDUKjZnRhA?=
 =?us-ascii?Q?fH4QjcF0aLz4TqLIq4yIAwUSP6ok2Fk22WGDGsgug/eHBwnxaE2QgIN377/+?=
 =?us-ascii?Q?rcm/c70zC0L7EvlDIIcDEeldWHnCJs8tE0sSKLXKieYW3G5wsqalUM2j0oEi?=
 =?us-ascii?Q?XSzIY+pwoZD93bcZEti1USe99UU5F4uAD5OExAQDDzHv0DpzGcIKzloHglMK?=
 =?us-ascii?Q?WhJfYeOzD5Fvv6nEq5ag8GAjm3KnmWyAwibMvqhkh51cUms95Lu6EOltqrAE?=
 =?us-ascii?Q?NLJZkv7WCUYAKtVCGbP5XFdF1gJSm/HxpsIvzDv9Md+pgbLA/9PHVuBRri5i?=
 =?us-ascii?Q?hN0ENmsz761Y19kh6oJ51C+qUEOMPMhIeJclFJpDc8mjMSVmdlwloF52H8wF?=
 =?us-ascii?Q?XGJHvboFKwueLC9T7Jzjr0M/eSuLK1i8+DgMzrbSPVQ6g+tTiO+QPXpw3B4g?=
 =?us-ascii?Q?BStjpP2c3w2JtHjS3a/NTW7w3NY1IuZNthj4mPpwEihXbVbwEhoeEXtyKcmr?=
 =?us-ascii?Q?CboDGicqDX2tSidGj9YeOPGzBk3wliNzQEsoGZwoxzUSrWUdjrpY07QHluBu?=
 =?us-ascii?Q?4lfPLFdIro1DXJJovFbFmRC2hrSVqvG+sUwbUMWoc0ICjT5pcddHID48oB89?=
 =?us-ascii?Q?4ZMYwEh0jV23ATokcm/5BAFUhvpr3hZRM8oqyBeowh6t7vx15pLUb8SNZd/9?=
 =?us-ascii?Q?v9W9ZjvxU/2eT7gpq6pUKJniXX+JLbCDzPD1vJLIPoU4ghsQmkYHw3Nz7dcm?=
 =?us-ascii?Q?zLIRkSovE1syi1904dE7fETYklz36nsCNxOMsNvn4LInVuTLpAdh4p1CybgS?=
 =?us-ascii?Q?l85G8FHu/buFmOzXgBVRSZnji5bw49ZrRC1He+vRJWNM7UsAjIQl3lszuNTY?=
 =?us-ascii?Q?QK50Xx5NeQ8Unl0D5mefU7Ew3pF+2yoNm6c/lNigykoAEXSsTnJvhDG22sym?=
 =?us-ascii?Q?JrApc8BZSdQdrm61GASB7ghLvSdZBqmMamszh/O/DN2jQD6mfX8lwOo5zbe5?=
 =?us-ascii?Q?lZ61iN6I6xiiyvk7AXY7NsY9E9JL/Sq2bOBoxWLj5+6KYCepGxEuqgBpY6SP?=
 =?us-ascii?Q?jSn7NvLLoTZy8EI8rURNIQ2Sg7awUUPFta5hTdgKunTM6qi7+pZ1uvPXbwxp?=
 =?us-ascii?Q?beAaYlvPdpIhQ+FSlcVKLeO9bhbSg/8Zbo4SeZOM6Cul25IbE0iMQvoFAdxf?=
 =?us-ascii?Q?uAps8U5gPdl1RaODGeEldO4J/CGr2m+M8HKrdbjnJhJNkmvUkDo0SNheabvM?=
 =?us-ascii?Q?vJVp5g0IvnUmSwGYAiP35bxONi66WY80h6Sh/ZB54nCLF5a7K2tES1pBNT5Z?=
 =?us-ascii?Q?0R3yCxzux40GgnqoAnYCczgUP2zPDzZp2wpSPHQwIIzXeBHDNif5TByeu8y6?=
 =?us-ascii?Q?dPV3j+VXJn0bn90pG8+F7wi73WEvfrg/MWlf6+O4sPmijf5SGOr+ajYArVsV?=
 =?us-ascii?Q?NIQYzhwWoPJaJ04sdAkxSrh8DwdyfgFkSVQTXpD/ndM8LOq5AytjR8Z1p+qo?=
 =?us-ascii?Q?nMcQKCK6lJaAEGxYKnH8J9LQSN7VRlxVcKkFVDJJT/v6cOVDkCHuyg5v+6Lx?=
 =?us-ascii?Q?2lp9A3wfh/zqo0KpOJcHyJtyx24vEafvGKNQyZHCLs6JSul5ma1A/fpk03fE?=
 =?us-ascii?Q?yUPvPSLsf0/Qv3PMKqZjXXPnoQeEu7nTzCx7gYASANpZn+wVY9hj?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1ac098-e054-4ccb-265d-08df16309387
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 09:30:00.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyvCAit8iMkNNNYr6FSEVnIIPhm8OeANR+YyWo4o2CCGzoDL/244tQmI8765QdbVpr/bcibFtL62W54TloCEiOBHLTs9upC72mFfaDp1lUffVyRGLkyX8jVcXc0sxTBP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1155

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

