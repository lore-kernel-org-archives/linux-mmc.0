Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435243A7F6;
	Mon, 10 Aug 2026 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388470; cv=fail; b=OOzHSWuB+mki/aLZMSvpg9R6FnjdLeObT9dsymbOB/Qjwe1aLW9dY6McoWNWr/nFc/4Qx5pJkJDSqZYsSJksx5lDCTW4VlJJvBhg7/Qbun/paAV7FFGC8by11h2KgJAseRZKMyth6mF9Nen9jKx8Ex1+BqVh3+e0/x6RBU4qo9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388470; c=relaxed/simple;
	bh=egeaYmWR7jExubysyjijh+VuIBchPDiAF6VJZ+sSNlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=urPzPEzHsGuRcc4RBEL4rbEun5uecHJrwusIMHioWb3ZmQhGF2oJRIm3JoCqBZoc1O9Ei08GX2skhU0jMCZZG8F55Su4QpIdvfagX2SlgpeYe4QhXfMhz3IoeltWhKYN06U2yd/3JC7+EA6lghxuvuUDL2mJxhcQRlHIOuJSY68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qpQqHVna; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qpQqHVna"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjvlejpdHTcKJn5UKXfLLbbTZJIBcTN2RgaBfZ3NVn/5zwnh9d+eoyy0uxtUb6Lx/09960Hq5pScZFSOpyqDi16eTSmxZkdIgKg4riKRE0NANTMs0fsepUaS8vuY9UU7et9jOSYRI+0eEVIQZsfN1XPORBC6VYNwvFaDa/AmkjFSDLKFZBPqEZeoGtoFo5MhZnkyPozxvEJN05DFFGAoZP4Gy7AnLnBUPqoCbE+nfw+t2Cu+4hjJBFLINfWRNBnXBCuj2b1gJitfm22LYHL3F8ZVcBqOcq7c2/6tnnxkR0YZaKUPonauWsj5SdvCPulFHO6mWrhvsnlkeHzM1icykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uIyqjdUME+03woc2zno+bc/iKnD1P3JhM2scCHxPr4=;
 b=nVQ8nEj4o81rtT+QXYjoAk1gGDGgHXdy0qxWrOLtQ9VQKNhyrucMNSG/Yk54axwC2ZVwvp1ntyqsBLrKzSHYI6eA27qsLUODSwg8HDVETE2oAQ0ftsQuJuffweJSqa5qYVnX3RYR/w1pLoiqFbwjIVjC4xLF1ysqKldrzGnmxtpm9m30t8Gmn8CHCkoEkCgPLnulJb6uhr5RtYpIxoT8xgY/RgFIRVFgWvZZW4XISqNJUpCGY3aOuS9ZQEp5r7KwSsvytCUzzgkc+7Y3+xCAMZZq4hSdhz60XHFFE+4KkOJet3lqpRnJ1GTHrZhoBrH+ol9a/NmoqXQ8HuyTmMkaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uIyqjdUME+03woc2zno+bc/iKnD1P3JhM2scCHxPr4=;
 b=qpQqHVnahTG6iqPga7nXo8RuBsboL32GbzqzL/o2zj1Vz0Y0IiimBHyYkKudLA2KkneaK+AoZ0eTFqMZE7dkORc3/bPpGh4hGKtuiL9VAXntiJmwyx6AKwGE+1ctxOGZLPVIBZbAAEu/+CgGVu1zZhp6UrI2VoFFVoh6rmQPWwXPGyYZEb/RanExLvauoEzBQZ+L4dj6mgMo8YcM4delFZ9FoKuP+LWZriHPgHmH2b+IrfuRBSgMdKjjIc+2cbhZX23bkb7IJV7i3LcTngo0JzylO5+f65uNeouMonzTw0BhrxZqgJLhbPlxoSHZpMRrXFjS+e+lqGJyni9aFna8Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7676.namprd03.prod.outlook.com (2603:10b6:610:237::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:35 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:00:35 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] dt-bindings: mmc: add Cadence SD6HC binding
Date: Mon, 10 Aug 2026 12:00:15 -0700
Message-Id: <20260810190025.25045-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
References: <20260810190025.25045-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: f61a4962-30a2-430c-6bf4-08def711a8be
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	MJBcAnyAF7bYPs4GfGilYsxivamb3DhWxvDNDWJx6egfyln7awoS7OZHPwDJyOzM1oiW2IEgWOPH5YxsBhGI9H0RChTy3rAh6Vqi14P+iTVt6Tt6hWdmCAAA0jCyseJjf5ZLRoblH7Gt7pDYV2ZLTGCNuFidu0lrA/ADMTccTBmYRSW6Cw7U+iAkIq6Rq/vDb8P1M96crHozd3fkRqx9cmetpLuNFdSbWOGLmmvrh6dUdxh8Yuqst0Eba+na68/TPsMrcIK6llt0+P8pkzIQZSSx9O2sIPIOUKHG44tIPhmhkVxd24SGQf7S43YiRwIthrDGCbQo3JXcsVN5imW/m+kuhSVLMqR07B5Lvu1O7JkXWtogRFAdXiYSeBaICRUyE3F5vgMJngyFxGJqdVRrjjCKN1McmB8e6ax0/LYqAJDLkOvY80cJzOUisCX7e3MfDb4UH28UFEBypSXAB2Vabl6sWMMIu1qjlkh0ZTuk81gheNd+VDjkesbtWDsLrAQRJqWJ5ZyO+oqyVNL3vC5a/PPU4sEM723Idh4F3Xu9N+MNgGkiO7kxqNeFNLrGvc7DSy7mW677XLHAEmM3GYnxuUdrsEdZq+jgu82PhXJaBbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UQP40mIAr83sfWv1GYUuf3wKLKaoBh5JAIxHCcJPH/V+Kc74TezxrTCTmsTA?=
 =?us-ascii?Q?c7SsbSZeteIak090ON3NSoXymGb9J8xrk9z9UAVfVqf6buyszdbR05hM4W03?=
 =?us-ascii?Q?4dG609936RsHaXEHTfnLrwP9u5qoU8KziptN8GNmFFMaxeMAzAGitl2AQ1/F?=
 =?us-ascii?Q?yinDZNYhqpWYVpNtCfe4fRO8X0aYeAgjeywQubiK633tiqXtymPdG0YDx1xy?=
 =?us-ascii?Q?xmIl0zuL/44oh0Xzy+fWkSmQkV5Ryea5FlIM9P8ubD12GqIVorHsd2n71JBt?=
 =?us-ascii?Q?e3k1UbSxK2dFk+mJfTIlZUwVK0Z3jf9IzOS4NwxisFBofbkOZ/pAJCXV8z6j?=
 =?us-ascii?Q?8lkSEpNm5d776MGUHxwk5zEPWVxFYdI3qy4z6yWMgBeZh2TQ6MH4tjJX1o69?=
 =?us-ascii?Q?Dp0Ufo6iG/Aq9VocsTWpTIJlm5h6FlFtV1+iRsvHAc7ustcpn4dlicN5KLKc?=
 =?us-ascii?Q?V7zssAt9Dim+xQUfVjZwugX2jZZ7a9OGuG7BFbNiixX59DZouh6Er5gqlDof?=
 =?us-ascii?Q?wRkrCn1DuKpRhvu6IpQkznLpSPwtQb8RRVlza48sKaFS1Qp5nWM1T6okyI+2?=
 =?us-ascii?Q?17v6sZ+rTGhhyWBxUot2Xasu6Ur/wQnIoLhuraogeEI/L8l3/7v5TTN1b7eB?=
 =?us-ascii?Q?x+iW0L9ho6+05X9VJSnNxxAGmuXcc4/HGx1+vQPjgb82pCBgr3p2QyqoeB1i?=
 =?us-ascii?Q?CHWuKFDEYMBTeLVOOQFCLn0xNc+cDN70SYWCf3/Zo9ELDw0RKWZ6LcQQ42sL?=
 =?us-ascii?Q?PTJqhaAoSyiEHEZp51zGJXujCE5pEzMRoPeEfLYfZ7Q+ptMT8gPOs7sqgWjL?=
 =?us-ascii?Q?gmkoEknnL4+dgkVwwf4DnpH2eTSQidFLBVgGcaScW2R9mM/uvYUmwsJ0iJxF?=
 =?us-ascii?Q?TUVKjeM29xJKVRYbo4DldMVM7U/lohvsTdYOTVQ32fiI5VAuhJS2C1eQWYBl?=
 =?us-ascii?Q?ID1b7ZjZqGslqwx59v8oDlQluuvNhNladUSCPN/5+bLEX9IbwU6c0DPJuZx/?=
 =?us-ascii?Q?nQTXmUPYBU/DV+QZjbdrUR4B5Yk36VLQoyJ2Mk5rUPVYM5U+XbAY1G1ChgqB?=
 =?us-ascii?Q?wkWQuFR8dbZnmN9DGCZrQd5zRJ/UTOyNnArk+IHt11iAqgJckLz+/Rr3Furu?=
 =?us-ascii?Q?+Ia01j+M9RYm/ZLBp6KZKEKfq1z4VAEEADvANcSI31punoILAAFWxvu8XUcP?=
 =?us-ascii?Q?0ce4MNzHXmLfHNZoaWzHlEGWOpmaJ30AB5YM/bxftzZ7MzeDGDEFWG3PH8g2?=
 =?us-ascii?Q?QCky/3OF4KkYBG9VZH7AooIHR3wOYrAjSyIEdvK1k+bua2B/k4yUJyUYTf1r?=
 =?us-ascii?Q?ElGd3glI+omH6GwmT5Xb9keiPIPPaMDTcLh1I9XS76cpW1Yjz2YGS8DGXQ8Z?=
 =?us-ascii?Q?HWgPIDWP7Hm/iv7gDj8LSXiLRQKAYT/AAYVvAMWRiMML8LbfTHm7g8BZEZ8c?=
 =?us-ascii?Q?OC0ohcSN4JDAR++mcg+sTJmch+bdXLQyeP31/djjvFp5g4dUbnifbJ6AsGDt?=
 =?us-ascii?Q?f0nBNRYl9FsudKAQglF1/wnt8l+izYrVIFdCHDBB/Vx5FjMyE0/PcVyNhIn4?=
 =?us-ascii?Q?HtR/xxOhq9jeNd4/pT2aMyxV50MkPuWvaOCcsnh+HIGDOaxs30tnXBs+SNC1?=
 =?us-ascii?Q?Aohp1y1sY0SnIrmoKoIITBw1HCB1zoSfFSF8sfkxYglKTRMmZEPDyTP8Fipv?=
 =?us-ascii?Q?uog3wKpDkId3Qpy85JzNQH3mECOM8qxX0MiwL8S/UVPi5y9mZP4FI9lNtqsd?=
 =?us-ascii?Q?f/vjygd9fbwYfL0y4aXDbJGxzKH/6aU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f61a4962-30a2-430c-6bf4-08def711a8be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:35.1968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oam8/t7tzZw3mbmimDygC+/VTEt4jLUGrm1wONCFIslIEWYWp/GtgaOQbBufA6IGO/dEkXFY3GejwP1FmKW6d7jAkWFLhEhjyb/mouT5d28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7676

Cadence SD6HC is a sixth-generation SD/SDIO/eMMC host controller with a
dedicated Cadence Combo PHY interface. It uses separate card-interface
(CIU/SDMCLK) and bus-interface (BIU) clock domains.

PHY timing depends on board IO-cell input/output delays and the DLL
delay-element size. On Altera Agilex5, the SDHC, Combo PHY, and SDMMC
OCP bridge are each reset independently through the HPS Reset Manager.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
new file mode 100644
index 000000000000..302b5f90d803
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
@@ -0,0 +1,102 @@
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
+
+  cdns,iocell-output-delay-ps:
+    description:
+      Output delay across the IO cells, used for SD6HC PHY timing calculations.
+    minimum: 0
+    maximum: 20000
+
+  cdns,delay-element-ps:
+    description:
+      DLL delay element size, used for SD6HC PHY timing calculations.
+    minimum: 1
+    maximum: 1000
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

