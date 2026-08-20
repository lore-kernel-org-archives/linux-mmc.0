Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9436729C;
	Thu, 20 Aug 2026 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252275; cv=fail; b=oT+CNu7jx47QAx2fqCrGHyUwTZ13k3QGWZEcldbDUgTrEsTF0x0f0+vXUmYDuUD+vuy7wqnGB7Lkaar2sQ/yLgHRt8J/U6+irTR4YfWIono2vrVGXpnDYcJOvQA4i6yoTKBLjOC+9wq5dDxG2Rk4CgBh+fBfagv9aIn0FFTZHoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252275; c=relaxed/simple;
	bh=jkcntfpeK261uYcfHbwBzdB5klx5SPZdLBUgWvkrooM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnXkqn3Ir1KSSADocMefv1uRlHVWM3Km0XAm9RDxIZAp6CWGDxOIEc1tyOrXu5qbAzMhKEeYApcbcQLsOJi7ewKToY6dUFIbiHcpuZreVuTi2ZkJoqIBczfnoKPgeTrnOPQyfhhJvLlOKIyr5FP1h+2igDi9iTYWh0drrBc8ahY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZExG+BKN; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZExG+BKN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4PGJO1qoYR7t3H7GDHHTDIe3xnBkjClZbY4iu643STVVRPgY04cLN357tR/mrI0UaL+0s1eZ8iHYnJ8cRpBQpcmAe26JX4DVDDcm77hPG2MpYNdj22zgILqaiCaP33AKC5lVBQRsBJSqXtp26BD5+ZkSVgHfcvM/a2tzKM1GRfsHFesIRXLHeWxVjBQWTvc7YqA9DkmwCjqgUyt0ypD5UFTUljLgatbaYG6zho1kgYfUYA2MMMFoqGNFL5LXxC42rhJTzn+QM7KRWUrzNHu8E1LiINkgqiIsvk+nh7Y4KsigxmNHNiMIGbSmPyZ+CQFWYAta+Y7Z9WNKdzQlBz+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KO7y/XrdZQTI51QsrqEArA24Q94iqn6O/idem2SA7w=;
 b=ynLZEaW6sbuOqCg+CGSDiAlwbK5Wu9vosVA1I+0uOWk0ZQUMwUMfIVO0V1SDDsM3npFQN1nHJIJTGh3ELZzf1x8mIevM6iwLmDWSkhS4n2DJqPDK5YPoQa6AKYZ8mseBIgbNRsHTuKXQCtOXJuIfWFAdy5AFdbS8gpry6EwW1bxV5wYkK47gUV2t37M3SoP1LqUUgaWohxDno3FNRuhXOljsUSpiG7PVmHE4uZUMYMT8DOqKissMp8Qi8pyMapJjfChswfXffN+XbrUHFT6mL5OzYBLA6306BcwP0qXS6Vrc1Y/sDXk4XaJ1/V/ZGMnNvOFrNPf+Zpj0Ym0DdosKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KO7y/XrdZQTI51QsrqEArA24Q94iqn6O/idem2SA7w=;
 b=ZExG+BKN03Q4wn1QxQ+3n117+NmdE3eXZNWlKZpLgwpBNYVQrq4M6L5B/V2v6MRcPG1ObtbWFuy2y/JvnyomXEzhAODmCb3uLTSukDIABFF48p443srzg8283JjY6ZuIHXyAe3NxoUqvvVoLHlCHAUAgcCpXOVZtrVj8EpEDCVBbOY6SwB9DktCJ93W1Xei8/g7fUfGcKXhhx8djKnInQrBgkysPtD2946B+olHtrS6TMoFEzK5xaCC52zLSnQhxq46ZwI6OuQFT0+iLgH7VuYEHaP6JCsqwOzaHsRCSt/C0tZJXw4tATvycr5vcaZtUdx/i26A5BoAvgLSAMkIXkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH3PR03MB7364.namprd03.prod.outlook.com (2603:10b6:610:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 18:57:35 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 18:57:35 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulfh@kernel.org,
	adrian.hunter@intel.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] dt-bindings: mmc: add Cadence SD6HC binding
Date: Thu, 20 Aug 2026 11:57:07 -0700
Message-Id: <20260820185721.22823-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
References: <20260820185721.22823-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH3PR03MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d6761e-477b-4fb1-4180-08defeece5a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	xUMEgWz2kRy6/VWLVwFbM+fvTcB2WM96kOT26xsrNW7IErgJSPpuE/PlEnZIUgxxYDqUN7vk2jFGctzsX1spm3rOxH0nM7fS4dfOYIpDXBqKwj1LQXznRcJnmJ0p+ZHDKE7EPB2S5VmQGN4iz3Za1WTMv8BekNDSUb2ci4iQJB7byeVtuzkAFaw8Lsm7nx8LSauDyo0ulIGE0utMpkTcZcO/p8OpSiZs/Wl6wCBp8+C+8rd0WfU769hCkCdz010/D9upW/G4B2c0/9AOPjISac9IhsS3IKzKcAmnivJ/dhm5vFbD0LOWqGT0tE29jCe2YY8AHSA79AWKTDwpd5+nhae7cmFZjK+wwJCdv5n9SWVU7bVEO/aDHxtNb6oT/ouJeidKBt+m2UCHVKRKCVuoOpOmw+KEnS7tS+ozjsv5J1gTeKmJqooA95mVziKkEkxZlybt1jBCiiAnLzCP3pbz8FXKeEIHG61DaKxCRG/HN45kYGd3ZbKAj1yryo5OMwdMC2JnvyenmtLWyL03hbJuygRjbcK1Coo4pzWGbt+g7CijtxeAJDb6GaqvufuAEo7BzZvcTESysFCLR0QO87zmC4GjFhtPrkCOtiYCMHUXzMcBt0TZORnzQv+GlooIOpJF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L3Z87vwTLewACkgm30LThpk+tyrIDa7rr3fyWwo8YEDtxcNqJ0YT+cbyqrHM?=
 =?us-ascii?Q?2/LilC1UOaqPdt6LOy55gcFpyNjdqkdZpJWOi8aUpVhAJYZLKLakIEiSPeW1?=
 =?us-ascii?Q?eKtqx/kZa8AuXFtCpkTrXKN2Nzpoj8F5Cen+9zuPpGnYu/7DrV8JuDsw4zyB?=
 =?us-ascii?Q?WN1iLrMiIvFNAigwesTQWh7dEVyjfzY3WxnXRLQhwyr8+kdkQJiNq58M9kEY?=
 =?us-ascii?Q?0f2uYwWm/KZUMhekxVxjxlx+uo6OJrmTArur/JF9OpG6ILK+d3AyYcI/WhRs?=
 =?us-ascii?Q?BRlCyQtVK6lmZPSuQKqPzIjxw/ox1ymHsqsmcAAGP37ZzJgaprIJ9Bg38uC1?=
 =?us-ascii?Q?N3NgD8g9uGKCMI2rl7Tqd2lafjZUgMHBN94q/zMlbm6zA4XM+xbjDhrbZv2f?=
 =?us-ascii?Q?YM+ZscSl8AyCxRh5ZjNLubQ36kXT+TJIBqaF41AS8RNG6lr2+ZOtwGtNfmBg?=
 =?us-ascii?Q?Rwe+dCnT5QKLVqvikT6juH9XHlL3sCSkbykQJERft2pc5yLOl8dag3E/E8A7?=
 =?us-ascii?Q?2zzEOIKDGjlAX7BZGq5VoWu77LMyxBfqdbQkXylDQjiyTW13CbNVBKZwQcvq?=
 =?us-ascii?Q?psIWiLFi8H3vYaFi5aqtPHfH1o8pph0MGJ0QvZE0L0/Ofwa+wCnUwaJQWuhE?=
 =?us-ascii?Q?QKM2ourEOcdhQlfH6PpDrQQwqzu506omGfOwk97Uyp2wGv8qn2Zo87qMEBI8?=
 =?us-ascii?Q?bCsEw9iehuEgsSr262rOMF1/1y5sWS/RH/ETsYp6JVdm3tdA0qEese/Acke7?=
 =?us-ascii?Q?aV5PWxD+5HJl/Wu4BwDWy1e2d51O/cCwuzzd5UEciAzVlAzMp5gkfVbdsiCo?=
 =?us-ascii?Q?K5KZB3VxPwgXxVifI3T8/x1fGiXYBEV5Hc27xBGa9s+Pkgd1N0s9VOchVWBn?=
 =?us-ascii?Q?u65o/FS4TTNuwhEsL5gkIiUhqlPujrBauoTfMqbjAfueIuvQ5a0b2/MGDFXl?=
 =?us-ascii?Q?KIZpzzaMEaqQlEnPPMfT0N0k1PBiT9Z7Tnadl8J1P/jB+qL0JiSywwn/A1yv?=
 =?us-ascii?Q?apJ+7GP+61jXp1RGxXd1Ic+DRxF5E2gpVM3DzULlpO1fQQnQ+MzFV6/uzykP?=
 =?us-ascii?Q?MkDQHp17beQorAwmegpUmpPZue5pnWVfyBc3pTaaMv+3LYskZbkV7xh4P4aP?=
 =?us-ascii?Q?Qu6SyZosalR7sHF7yleP9BNGCyKPjyNpOjNo2MUS/vzmmTypmcM4J6d64rju?=
 =?us-ascii?Q?Af/tmAajyLtrHxCAg3cPTaX3zmXbA9pUvmyrD/aOuljgbpjWpVYCx56SwkU3?=
 =?us-ascii?Q?y7PyW+j6jj1OAuykBEialNvi0B/sVy/9Ra+CMr/3Low4OQh6CLkCM0+SCrfj?=
 =?us-ascii?Q?IF9pZN5omizNSjXeVNkoGubBk4BjvKjOvj8X1iJNdKaib/RcCglBgXj2xflW?=
 =?us-ascii?Q?/fcXqBF7ju88OddkZL97gtcL37Oo22SoqTMDl2cAto8pF+GNn7onYctOXcKu?=
 =?us-ascii?Q?3ebnrxcMTAC5sax9YWMYFuZxT+aYSB2lgwzRbIi5BxdoMyvYVAKic5AKWi9I?=
 =?us-ascii?Q?bGduCsNpshNhlkPakfNI/suh6y8fYUD1+UawQCmCOmYebDib7JdvUfpyol4w?=
 =?us-ascii?Q?SGsJqV046zXgO1n3Dgi6pSF9FrwjQyTebvi/SwsvH9aWZ24A9tVjIO9ypa4O?=
 =?us-ascii?Q?ZnxDqvOstnxbvxuL4fN3YLdAX+gi/QUZORlK4vmpxcX2zRFewEkQGkhkogwf?=
 =?us-ascii?Q?yYTqjgFvX3rLz2fSY70dA+lfwt04ApXU6ukmSHz+qmkyxcUGUhKMd1YQM4Ya?=
 =?us-ascii?Q?5hX05Xggvi48af4lzSyQ8joM776XwLs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d6761e-477b-4fb1-4180-08defeece5a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 18:57:35.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcxhzbMhE6mKNMHwJ4YSP241sGSzWGfSiBUMv0K8rkbsfygJTDEUBkL/VRtlcq7tbzm4sJVHCQthQ3lXtAoeF0/eUahoKfB+xqNftvKLvmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7364

Cadence SD6HC is a sixth-generation SD/SDIO/eMMC host controller with a
dedicated Cadence Combo PHY interface. It uses separate card-interface
(CIU/SDMCLK) and bus-interface (BIU) clock domains.

PHY timing depends on board IO-cell input/output delays and the DLL
delay-element size. On Altera Agilex5, the SDHC, Combo PHY, and SDMMC
OCP bridge are each reset independently through the HPS Reset Manager.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
new file mode 100644
index 000000000000..d5ea2717904b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/cdns,sd6hc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence SD6HC SD/SDIO/eMMC Host Controller
+
+maintainers:
+  - Tanmay Kathpalia <tanmay.kathpalia@altera.com>
+
+description:
+  Cadence SD6HC is a sixth-generation SD/SDIO/eMMC host controller with an
+  interface to a Cadence Combo PHY. The controller has separate card interface
+  and bus interface clock domains.
+
+properties:
+  compatible:
+    items:
+      - const: altr,agilex5-sd6hc
+      - const: cdns,sd6hc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: card interface unit (CIU / SDMCLK) clock
+      - description: bus interface unit (BIU) clock
+
+  clock-names:
+    items:
+      - const: ciu
+      - const: biu
+
+  resets:
+    items:
+      - description: SDHC controller reset
+      - description: Combo PHY reset
+      - description: SDMMC OCP/AXI reset
+
+  reset-names:
+    items:
+      - const: sdhc-reset
+      - const: combophy
+      - const: sdmmc-ocp
+
+  iommus:
+    maxItems: 1
+
+  dma-coherent: true
+
+  cdns,iocell-input-delay-ps:
+    description:
+      Input delay across the IO cells, used for SD6HC PHY timing calculations.
+    minimum: 0
+    maximum: 20000
+    default: 2500
+
+  cdns,iocell-output-delay-ps:
+    description:
+      Output delay across the IO cells, used for SD6HC PHY timing calculations.
+    minimum: 0
+    maximum: 20000
+    default: 2500
+
+  cdns,delay-element-ps:
+    description:
+      DLL delay element size, used for SD6HC PHY timing calculations.
+    minimum: 1
+    maximum: 1000
+    default: 24
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mmc@10808000 {
+        compatible = "altr,agilex5-sd6hc", "cdns,sd6hc";
+        reg = <0x10808000 0x1000>;
+        interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkmgr 0>, <&clkmgr 1>;
+        clock-names = "ciu", "biu";
+        resets = <&rst 0>, <&rst 1>, <&rst 2>;
+        reset-names = "sdhc-reset", "combophy", "sdmmc-ocp";
+        iommus = <&smmu 5>;
+        dma-coherent;
+    };
-- 
2.43.7

