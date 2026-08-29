Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9F415B68;
	Sat, 29 Aug 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788028988; cv=fail; b=W5vq91TIwrxB9pOmWHYCnNLJLNRf7o3jeGOpTjBAec9WuYi6SVZxGAKJiNmNTHn5hBW/bFAbtPEiWZ0U8abEQMfPHjXaiIi2Bzobj+2nC2hVaD4oCKZkKOkVfw3HZKHcUxhLh7D45PMVPYReulkf26HkUpe0HOtIxF07HtNBplg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788028988; c=relaxed/simple;
	bh=jkcntfpeK261uYcfHbwBzdB5klx5SPZdLBUgWvkrooM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhLPEgsw96onj5RbZ5+ushLpGb+cNrGG789Qf6sKWBiOneOKATM7r7v2mcd0GUm3OWpu8aIEjj0zN68HDqIqZ411SldTfGs8AJ/wcMUGIt/YT0npGgmX3ZohMBygLCWE1XHNnG4vfcLeTg4OMhSL3UaZTu2V9FQMP1LZ9I1PD1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=arkU15Zx; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="arkU15Zx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdsXR6wdN74i9PdfPhv7KsISA9C3ca3/FXPSj5PtKDDsvHO6V6i+tYLMVinkIY9eQ0uYI7Xk5MneyJeAvDG6sUhowzWbKtYDCBLm05vAdkaUFQDnYuM+II113T1kXidv5sjHPtfzszX+Z1Zn0eFY6oe3GggIve7rjNoW+14ProdiuD0sXDBCjnc5YPOVXJgvpM9swHNItjior0ohO2gXpKdxIBawxgTWaZFhRunpuAkU85gWquOdoOgFlHAIr6sIOHxd6Jq1uXar8NIVS+JYr6oTtTKH+J1058UjY9jLnv4WvSTpuD3ItcjzWn0ZU1Pri2DpE8ouDSv/hjKdSgS09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KO7y/XrdZQTI51QsrqEArA24Q94iqn6O/idem2SA7w=;
 b=m1FzQ/3HwKnHbZY2gemKyoTirJOdCpJgOqp3dhFwlJYqQEfJ0Ogk/Ef1M0g+n81yujW3hWd2P4SHESDEE/BrvwEYZ+6DpTHRuiA9P+0ooEDyl6idM9BgCHw7mbpG0JWUjskS7wzH5l+vFX5VlmPycGUG33ba/fDQGMmmVNg8UCcJTT00Q6SQep8PtbOkhSQWIkl/hH23fU0BjyHf1es2K12Usf8FttBEdZAfR51kXyrglZ2hWCjwpu6WIr8gE6zu+PyYFniGOBlrM/bSEOTok8j+tJVMYSROfThvANNQx6J+JQqc4tbBIGE8nLm3Kh8YhP65TOQDCV3F5MnXzXiZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KO7y/XrdZQTI51QsrqEArA24Q94iqn6O/idem2SA7w=;
 b=arkU15ZxG9BI263h17Ebknw+HpbDiNPKY1e0s+YnvojzeHKbYeQ027pHpA0j2fp3lBFjQ3xQe72r7kwrEMmau4LG0AzrCqm4UZ9GGCuBVdTsm5+FGwjllLotuIjdxxLbotgIYaG20TEsarrzypJQwZfI2ZAGDt/SD3+OEgvsZ/x01ct5gwXF6jRubW4lHhiahiWcDihlh/0yNf+NTb3q/8MfJL6dyNsJICTATmmk9bk8Ax4NyrEJdWVuN2QkJB590AGZFMKKa3+cbKpCBx1cqvRuDcUPebfnb5dpAJ9X8jrCPi4OqTfBvaB37irxRiONCAylzGEaY5DVnAVPpe3rUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN2PR03MB4926.namprd03.prod.outlook.com (2603:10b6:208:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 18:43:01 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 18:43:01 +0000
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
Subject: [PATCH v6 1/8] dt-bindings: mmc: add Cadence SD6HC binding
Date: Sat, 29 Aug 2026 11:42:43 -0700
Message-Id: <20260829184252.27644-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
References: <20260829184252.27644-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN2PR03MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: c071e876-ed2c-4967-665b-08df05fd5a44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	bdUPw7dImptFJEwQYFKtKNoXLaAeIlmi/4YKxn7x22fP5jmVP6e6ichIb+5b9c0dhpC7qw74bFLxk02Va1wCcdzCWXznEtROPVlt/IMPJWPoVQZdKyNyNS6it6d17gmPe/u9nExvkFf9RP/3hY+qfXDn1G6QCvCpmcDT3aU6Sw0nX72UbXxxiLh9dp+JiVsI8SvKRTEOLKzeZk4nih5fD3cRLzygWnKzro9BgQdfXL09Obua0cAD8WFyT+vH2JRENRG26Tji6Od8jZ0n08pgVDxvpRriuKpk14Vjm8fWccBLlK2SSagd+zBEtcc0ITVJ1cPyr+6ef4QMmtMKrQcF+PqEtXU1VcVTqEMl6TqvvcNT6yCa8vuBrpllClmxg96KpN1WeaosleJ0PaNny3fO+sr0tihyTqW4uW09tsBTSnxTZQuC3873NYKQN2xClP3E2MxzKUmc0HHBKsfsAxPrquO/1nifgm90Z4m1w4pjE9DET6ujggbvEvAMHDFqxGEFkB4C7p/8/50HM4iA1z/coR5MJD4rgcmYIt0zlBpZKYa6oEMQzouakEhbGVWkV2dxlP71PLBzDV62FlNl4j/sWqPzvl0IsodGOdgaS+YrqlOEWoXYjqEsB1u2rmROKaM1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4DuQB1boK9nWUKs0xq29HhknA8kyCuVv34OEmfkeDEBeQvy8gdbzhNlLUWZ?=
 =?us-ascii?Q?Br4qthpxQRqCdOmeZQwtI9PTZGftZKQfVWZnb7w4zkos0RzO0RHOE0vwSuZb?=
 =?us-ascii?Q?vMtEAJYoJYJY1r9OI9qRCpsKcsGPScOul1/hx8DmTY4ftkx/6+95+CniAk3h?=
 =?us-ascii?Q?A9y5P9n10r+d+CnvYQm61LJLmb7Y1A6DcHu6p/GB9WxNcBueUTmnvi6oLhuV?=
 =?us-ascii?Q?UMeOO/fwpG4+/pv/AeAsijok5hhJI7iV5tkBJVvJQr41WTCghIy06yIgGqh3?=
 =?us-ascii?Q?RCvx+RgSiFHTUwjoPWKYAYT55RLW0c5la7/ym5b+opzyCLYVn0svhpK2s5tT?=
 =?us-ascii?Q?vytOcLggSNtwKI+T4dMEagQCvBqqF2yCK/eGVLO+Em0spGfMKox3TBwQNHzD?=
 =?us-ascii?Q?LxuU8fXDlFHPl2m5y1HUDqyZpmKjQNGf9WVxByzNl+CgfkqiQtbVUuINWXQm?=
 =?us-ascii?Q?51AvmTvdckkwoKfRTu1kzw3ORfBq8bDcsQydxzPKu5ZPwyDydazqDQvHeQFV?=
 =?us-ascii?Q?Fp2/uV/qrwMIHCXDF7TF3Jx1DZrK+Q08iDhtkBs+NMniawfWvd3fBh3M5+NR?=
 =?us-ascii?Q?pOOYcAPNfGkR7rD8Pq8eyQBSWgisg6nFsasgIeq44WY82KMcUjD9OZx6roSb?=
 =?us-ascii?Q?o2z6SJgURMa7zKMI42gMpGtccZzHRM//rtcQSCU6ozWMbwDmuyhvyO/V7Va1?=
 =?us-ascii?Q?5Zy4kY5jknb8ZDAS0wo9DLfUNChLMvsFdRsVJ7VcJakXdhOrZ2dcphnxDrvl?=
 =?us-ascii?Q?7ZdNvSRtOVlAnyNLJI7d1mAF5ic/Nh2xHRIhepMp3A4vBSpVytwxQRk5WJOh?=
 =?us-ascii?Q?8iQl5EBsShwbezC4tANTAsGDIvPl2biZEVThyVF3H5OZ7PcPwXlZkFY0HYix?=
 =?us-ascii?Q?G5E8YaiUYDlWUfcda3w0we816ALSeFyFaq+8G2PlOqWwjYIHhIUhXCzMb10g?=
 =?us-ascii?Q?pNYmkM7HC1Z1f12MkE1BaxvDf7bCNIawTe98PA+hAfw1On3fzzulw2acy1LH?=
 =?us-ascii?Q?Arrj8pJAfs5J3ObG6qzT3of5mivk60ocxm1er9mMCOZ9YgNSP7cnLWAnQneE?=
 =?us-ascii?Q?zzMlArT1HpPc6rcmf2fP+P8DgWX0nflw8mQzSpgPjXZgEWPAeSYQLvMdGhRw?=
 =?us-ascii?Q?z0bmsOEFvYfqMe78TFe+zEb5FCsx+FJcMW8bR3lmKGfwn+beAu0UOZZtF4ls?=
 =?us-ascii?Q?oTvPKzqKzHTVkzZF6oziSb65t+mVjbQfxTEiySCh9TzV9EUrviL9tpbfVavg?=
 =?us-ascii?Q?Hqq2E9FB1UJoci9gmBCaVO6QQRRGK2f35+nx9t+5x+bBgz9h/KIVoHKG4DHI?=
 =?us-ascii?Q?BpS+3OUzfG0jTCdSNWlCTbuALCy+O+b6bpleVcTUGcLo2fYof55HTwJqp67C?=
 =?us-ascii?Q?wR1Vlvbk7ufwtcEECX664NDOoBgjirGOm6dhpY83DftyQXPu8HakFNNUEZKu?=
 =?us-ascii?Q?n8Awwj+9FDjbf6N2vwwM8jYVlvAVtpH7+kBPNmtcU54moYhoxXWW0efSt03k?=
 =?us-ascii?Q?7o0Ov55x7yCjZ689oCLkjSALJRZCszKa5936PN9/cO8TOei1AL11/kzRqbhH?=
 =?us-ascii?Q?7cm4Qj/xqq55XDMidzeVjFZkxn2fWkJTv1/IwMSuQKaoIf66NBc2blmHAOjZ?=
 =?us-ascii?Q?LhTzvXS/SZLO9Wfld32ng+dSKIJ7M0HoMv88Q7HgsmjD3AaVvOzT0cTOwir5?=
 =?us-ascii?Q?VI+K4T2vrnbz9g12TBUD7XGGcgZkD200iBePi6f9YZE1zRRElFu8G9Tu2kkw?=
 =?us-ascii?Q?uaLeSwaHQA57tvg87l1Q85svZyI5+rQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c071e876-ed2c-4967-665b-08df05fd5a44
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 18:43:01.0227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctxIjJYRKEvzDhqbOhbLadSU6MsdFY/o6/JyTbqWaOvSFkBQJlajH1FsvjcIsYl8llnRU4c6l8kV3Z4ykxCC1A9dFztSVaYc1pKl+FDAz50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4926

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

