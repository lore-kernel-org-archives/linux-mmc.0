Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2076.outbound.protection.outlook.com [40.107.241.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECA22301;
	Wed,  5 Jun 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613468; cv=fail; b=VHw/vfMCN3kSnvki0N6Xx/h6JqMG6osiCT+AAaTr36/a1HLs2sltzPXzZjJ3i8Dz0tQMAYK87SX74QJGEz3H/Dj+/a9ZxfZ019tjPOpuhU2j1TWz3hPnS2Ai9rN7X2zhC++FNwPk3ZDHD2UluDfxzz5B8BHIqZfwbZlt3GrPc9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613468; c=relaxed/simple;
	bh=hDIORg8Vjy6dYT1JxMkHUKfuWeFXhQ2EYjxoSQ/fp0o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KPvuISFRBsukJa8K/rgFOpOLdck2lO1uGzfOyApv5uCK4TeGUC4sAu9Hq6gAkGVTAjcnCVX+o8PXlIsVPVElBk1mmcsjaPQWPCVc2rHTwNVLdwD9YyS7DpnWFbcAQ18OTUrmgXUDkEh90kisynWJsHMxIPKQoFmXH8fCMl3nOs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PrQElEw+; arc=fail smtp.client-ip=40.107.241.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PrQElEw+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btEAWIjBC/Muwleufpabco5sl0si+Cg7bHzcZz6RHfs03CC7vTYJTLYsjPgv3Bm5tZ8FWBT+DqMRjVErWHwL1IaBUyo/MW6WerPolOwqVOYIdYQiRlwypGGb27T8RL4j2U18u8lv5c+D81oJ9AxToaTBFFN0qOVtLC3GBo+o0k/1AEgJe2wnhoBQ68XmOczUIa8ya4+btUTNPQlNN6MorwxTzjEY7/jCFnzQmryG9sIELOLtcAyMFW+zvQfFghKxgmSLhbuT9SIVCvHRnEBJGR1mmEZlLQeuyYjf1XjVfdR4/ZxJVlxCkvlWTLGOt2epeq/LEiS4K4yK6G0Gmb/rpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JwuPYpJL+JDb8ARhGq9Lc2R/JDNNaqnoG1wIbuEZ2A=;
 b=hR83l+ZoPJNQMCgOm2XPuIFIWkGaEs0IPJpzcLd6Z5EqymxzuiWrSkDTRDoYRZtYx62si9I2pZW0l5KWFlfq2HhJjPZ9YspjR6dsBFhcFyPT/89Cp4qyXy9p7Du+NLZoB5Zd/6IVpSAe0QUFwl1SrB/6y+SWVkrzghmcwyD9nEaVh7jxw9cS4gDGpEQ9p9556Jpl0BauQ6S7D6cmJh5uTWXULK5740Xl+b8H4ZDKhh9KQM7oykLEE0qK3biw2cWIq05ap4R60EyOgciZYzeJMTWCic4yVwRunGvKSI+gmneti5ExTpdjuwzqDuIPAEhL3TdLxzpb5TE/oGVF80BfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JwuPYpJL+JDb8ARhGq9Lc2R/JDNNaqnoG1wIbuEZ2A=;
 b=PrQElEw+3xP0iZF3h+ceQ7bi5gWBj6RDC/IAMMWX/poGoyrz2wxUK8b0bEiMTMEeiYFTrWPdkkswiicAjrO8dsAP+z1UCaN0xCxb4yInBmimc10LUn/dLpB3Flkcyf+jEA3qChIFoW052X2UNtWqG81clUpucLmgRrSPC2usTQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10749.eurprd04.prod.outlook.com (2603:10a6:150:204::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 18:51:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 18:51:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	ulf.hansson@linaro.org
Subject: [PATCH v3 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Date: Wed,  5 Jun 2024 14:50:46 -0400
Message-Id: <20240605185046.1057877-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:a03:505::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10749:EE_
X-MS-Office365-Filtering-Correlation-Id: 596b7cfe-113f-47ed-ebd9-08dc8590729d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9FPRCVirweehpVJTNvGLD5gbPCbhp824qx4x9tgR9us7lKhTh7oa3Tt+98CM?=
 =?us-ascii?Q?0B6tBG1avDuR8gT9Ml1IIZkdiUkBH8hoir/CUCLER1cawNshOrOM7/lTSnLp?=
 =?us-ascii?Q?M+DOfmUtECnyuR8l7BGVdW2OU2XU5fUphd6B1mvhNi3KV8L7znyLtsz9NKCT?=
 =?us-ascii?Q?T7GQeh8qg1qqP2vEnCdAvPUlU3i4ZICnpPDQKWfk4293MY/Qg560l1zaKTvL?=
 =?us-ascii?Q?DnYm0HOpbd0wHj8fu/OBkK+oDSE79d93Xn/Q2/DTxyU3Pu7eTg73ijWoVv5m?=
 =?us-ascii?Q?OByQkhB76ikzE06iuBeld8APyrlRObXlC7of9kMkhtcIK6c4YbrepwrU+nGe?=
 =?us-ascii?Q?Sf4wKPtIcDCv/8L225xlB0N/mdoGqQhcZJ5fk2+xZyLVkPaT5lNVG7uqPCJZ?=
 =?us-ascii?Q?MsJBKWk9jawiQK49Jm2KyKCNgfvXc1cfpAqKXWtV3E8cUp/IZjVknK6TCnUq?=
 =?us-ascii?Q?ZrijRRp2RG6yHxyyKyANTm/lkR3cdahYzwmvj6axYlcN35z7GEInMZsKq7SM?=
 =?us-ascii?Q?jw6eEjjWPLW39kyXAf7Y4HgUPE6yMJZhQJ4+ziBCojXK+jJ2AM9sBlon1kcY?=
 =?us-ascii?Q?TExFHHmretdEM8i8xDqtED5aa7qcFlS0mv4ei6AF1UoqamDFeX77Mcn7+Q5Q?=
 =?us-ascii?Q?3KHmR0OPzDjkWY13fsKWRf9q5aOBb9SYW3sTDUeFn/tfe7nD0ZXvxhKX+dIG?=
 =?us-ascii?Q?69HaQVX517ZYGK9ouJkNIubKLrc3+fXnLOg0wsujqhznd4zIQXmjN6qrCZMX?=
 =?us-ascii?Q?6m4DxB4KW715wVV61nN6VGgOxuAn9d4ERXLg3W60gqIAmIkm1zXwtPxk0O8P?=
 =?us-ascii?Q?/tFxsdjfs8bLwAh+Sq24/PmFaie+XaPDTTC8ufSagcx0xNsZpuxglwuTn1ja?=
 =?us-ascii?Q?YQ3MI0vZyoZWD/j5rhRkUejHiBWS3AM6+2yuJxGQvOPYyLKr2w8WFLAvf4Vg?=
 =?us-ascii?Q?OLxaYeY2/tE2if6Of1SR/arQet2MXaqUPxWmEWu1ag+lfRK1GkZTw7N+PWcH?=
 =?us-ascii?Q?XH3ALOEbdCDsPdtTbgix3S6464YsGwrg05ZKeZPJM62IbpzSJpHPCxtB3psO?=
 =?us-ascii?Q?gUyUQe6f6BlYhkTK+yKbQwm/KkUlYBkjp6kuSePguSXCq91mIeVSC2Qw4N/Y?=
 =?us-ascii?Q?AvcIFrZ3PUo579CK1BOf8QHGNJvjfvmNJQFLuFCXEk5CQs1oBMS4Vy5bB3n2?=
 =?us-ascii?Q?Z6uIOqOz3/Vqxixwl+tGyUZ+fCBO0ZrNqQRjQS1uwUsLrm3vU11fkSNFHH+p?=
 =?us-ascii?Q?WuSJ8OUwRxvEfEprJDJfdmiNLWFSJIJAv7sir3Ew/8iRdXJtwa3x6cm4/tsc?=
 =?us-ascii?Q?i1s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ea58YeplY0xgHHaT2ch7slKkmHr8+k8c+yNG/TVegpA56HGCdTRzmaPk336Z?=
 =?us-ascii?Q?0Fgp5is3M0Kjnl9M2zphCk1CKkHh5UuX5F63WbAOgCqQwr6D/hYKLb5zTv/8?=
 =?us-ascii?Q?IEjAgP2LV2f4cZFYeYSogIKsjXb9bYB3be+i8N/0gBQaHILJK68tJngYpCHz?=
 =?us-ascii?Q?Mjt2bNcf2BC8oDSGvOBVBSrzCFCRd5+XWiTJfCog2YG4raET5km+0lvD+oRI?=
 =?us-ascii?Q?y+R9PAhdnYbhfJ2RnTmA2mFmtXfN+pBFLBCwMEPDlzdcg7dCpGTDKwft9QpN?=
 =?us-ascii?Q?QeIDPEdyOYKDDsAIWVCXYUYZwz9XcRMkV3OJikR1fqP44ftw0CCigz0ClHHf?=
 =?us-ascii?Q?sNCxI3j6xtOmTf58XjfGE+uhkTXCv7qjJhVfWG59IA+1J7F7aiB++BRTppxu?=
 =?us-ascii?Q?wXEY+tZ2rHOVDwfMjhLWIlY6x+4FmOAUagdJsawhogyDrpHF+8b3MthRBxdl?=
 =?us-ascii?Q?bVeMSotBVW1O6LjH7+PdpRnMyojLPZ6+1PHeqdwpnG07T2Jy9r/+pWE2LWj1?=
 =?us-ascii?Q?BrMScPXbp+3dNmg5TGEfpV8Q5F9VEfKkEXhEaCdib8wKmYpyo2+x2Dn8nhis?=
 =?us-ascii?Q?BjU78TjeIrqE3FWPeSOAumMTOCkE17WIcy7xtcvuXJ7IWCv+XfESKf5TrfIT?=
 =?us-ascii?Q?8lbutOV4XdujDd3h4j7ykY6W9Q6VsZ6XrfAyS2cR3DMGszFHPrjzIaKAJnjZ?=
 =?us-ascii?Q?2SgpwvviuK9/sOUVZT8HeRla61bew0HCmcqscplrpowRsSN/D3grbgQL39uK?=
 =?us-ascii?Q?r05HElcu6TqXn8fy/p2D255u9iZnL6bFgT0+3ebAHlaqXCcUTwDN8jT3oWag?=
 =?us-ascii?Q?dDs1pEIMsYPpW8gJYxueXHsNwYBrb8vDhnzR884/ZPAjDEsly4VPG3LB1sn1?=
 =?us-ascii?Q?aEUFc0Ah4UUfEzR+0IlwtIKkFTUs9VZ7Tx2OPx3LDe7kDLtVeVvbxrJgUDe8?=
 =?us-ascii?Q?YzRpOYE/AzszuCn84+e6hdUcQULbk41zwJ6U6CzL/rKJ8Ev4IjyfEQSTAUey?=
 =?us-ascii?Q?oUBL4hTNBO08JT8Lf6ScwkMUd5BB6tcoNmQIo88MnljmcR4LHm8jt0y1sFGt?=
 =?us-ascii?Q?SUBpzjy2MkwqlnqPGZrBOSXZ6bwcVgLM8JJs5wyzagHWln9d77XTVcw5gdk5?=
 =?us-ascii?Q?phuKAnls/VpCv/akVAUINN7GgnhW/hTxTzl61FQIrUY8opJqKncvjIOt7lvW?=
 =?us-ascii?Q?ynWSLWKS1UuRQamIyD49wYd2zM5vIsIWB/F9eVAcRcIiv543RvQ2XS5lfWEw?=
 =?us-ascii?Q?rV91KZkBtHY38jIYXGbVQ6q7yyLQq0fWw9dKelol5eedhT5nk27tRv6QYudX?=
 =?us-ascii?Q?jbcwKsul5f0l2Bfffh8zPNlKyPAeRmgj1EWVfESbdEdkdIcHkqV9NJyP0FqR?=
 =?us-ascii?Q?1z1dwIVRu17CRo+8/05YYjsYSqC5mSf3RE9HTCFFqqeQO0v7pfw1sa3fiOhC?=
 =?us-ascii?Q?jTTCcszfPNTfOGPQkTA72CKdKJBT9BwfTeH55G3TQw7Heh26Os7G//VJAN3E?=
 =?us-ascii?Q?nf4DobPVfwGw5m13eOF7HuuSSi3EpAwAzK+TUlFdNc3A4KDOq01p+mxnCphg?=
 =?us-ascii?Q?hL0BJ7cy0VZAuA/VUTJatUwSg0qtWXogxW2e19nw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596b7cfe-113f-47ed-ebd9-08dc8590729d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 18:51:02.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikbRjn7jATn5I4LSB1u0PtOZtWctO79CqunReKxcSVcK5R2qDsf5QHw/Ntt/SLv5QKkWoMFmPsfdFl45wwutBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10749

Convert layerscape fsl-esdhc binding doc from txt to yaml format.

Addtional change during convert:
- Deprecate "sdhci,wp-inverted", "sdhci,1-bit-only".
- Add "reg" and "interrupts" property.
- Change example "sdhci@2e000" to "mmc@2e000".
- Compatible string require fsl,<chip>-esdhc followed by fsl,esdhc to match
most existed dts file.
- Set clock-frequency to 100mhz in example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - add minItems and maxItems for voltage-ranges
    
    Change from v1 to v2
    - use filename fsl,esdhc.yaml
    - Add clock-frequency to required
    - change clock-frequency to 100mhz in example
    
    pass dt_binding_check
    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,esdhc.yaml
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
      CHKDT   Documentation/devicetree/bindings
      LINT    Documentation/devicetree/bindings
      DTEX    Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dts
      DTC_CHK Documentation/devicetree/bindings/mmc/fsl-ls-esdhc.example.dtb

 .../devicetree/bindings/mmc/fsl,esdhc.yaml    | 101 ++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-esdhc.txt     |  52 ---------
 2 files changed, 101 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt

diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
new file mode 100644
index 0000000000000..9170456ebf5a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Enhanced Secure Digital Host Controller (eSDHC)
+
+description:
+  The Enhanced Secure Digital Host Controller provides an interface
+  for MMC, SD, and SDIO types of memory cards.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc8536-esdhc
+          - fsl,mpc8378-esdhc
+          - fsl,p2020-esdhc
+          - fsl,p4080-esdhc
+          - fsl,t1040-esdhc
+          - fsl,t4240-esdhc
+          - fsl,ls1012a-esdhc
+          - fsl,ls1028a-esdhc
+          - fsl,ls1088a-esdhc
+          - fsl,ls1043a-esdhc
+          - fsl,ls1046a-esdhc
+          - fsl,ls2080a-esdhc
+      - const: fsl,esdhc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clock-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: specifies eSDHC base clock frequency.
+
+  sdhci,wp-inverted:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that eSDHC controller reports
+      inverted write-protect state; New devices should use the generic
+      "wp-inverted" property.
+
+  sdhci,1-bit-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    deprecated: true
+    description:
+      specifies that a controller can only handle
+      1-bit data transfers. New devices should use the generic
+      "bus-width = <1>" property.
+
+  sdhci,auto-cmd12:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      specifies that a controller can only handle auto CMD12.
+
+  voltage-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: specifies minimum slot voltage (mV).
+        - description: specifies maximum slot voltage (mV).
+    minItems: 1
+    maxItems: 8
+
+  little-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If the host controller is little-endian mode, specify
+      this property. The default endian mode is big-endian.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+allOf:
+  - $ref: sdhci-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@2e000 {
+        compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
+        reg = <0x2e000 0x1000>;
+        interrupts = <42 0x8>;
+        interrupt-parent = <&ipic>;
+        /* Filled in by U-Boot */
+        clock-frequency = <100000000>;
+        voltage-ranges = <3300 3300>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
deleted file mode 100644
index edb8cadb95412..0000000000000
--- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Freescale Enhanced Secure Digital Host Controller (eSDHC)
-
-The Enhanced Secure Digital Host Controller provides an interface
-for MMC, SD, and SDIO types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the sdhci-esdhc driver.
-
-Required properties:
-  - compatible : should be "fsl,esdhc", or "fsl,<chip>-esdhc".
-    Possible compatibles for PowerPC:
-	"fsl,mpc8536-esdhc"
-	"fsl,mpc8378-esdhc"
-	"fsl,p2020-esdhc"
-	"fsl,p4080-esdhc"
-	"fsl,t1040-esdhc"
-	"fsl,t4240-esdhc"
-    Possible compatibles for ARM:
-	"fsl,ls1012a-esdhc"
-	"fsl,ls1028a-esdhc"
-	"fsl,ls1088a-esdhc"
-	"fsl,ls1043a-esdhc"
-	"fsl,ls1046a-esdhc"
-	"fsl,ls2080a-esdhc"
-  - clock-frequency : specifies eSDHC base clock frequency.
-
-Optional properties:
-  - sdhci,wp-inverted : specifies that eSDHC controller reports
-    inverted write-protect state; New devices should use the generic
-    "wp-inverted" property.
-  - sdhci,1-bit-only : specifies that a controller can only handle
-    1-bit data transfers. New devices should use the generic
-    "bus-width = <1>" property.
-  - sdhci,auto-cmd12: specifies that a controller can only handle auto
-    CMD12.
-  - voltage-ranges : two cells are required, first cell specifies minimum
-    slot voltage (mV), second cell specifies maximum slot voltage (mV).
-    Several ranges could be specified.
-  - little-endian : If the host controller is little-endian mode, specify
-    this property. The default endian mode is big-endian.
-
-Example:
-
-sdhci@2e000 {
-	compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
-	reg = <0x2e000 0x1000>;
-	interrupts = <42 0x8>;
-	interrupt-parent = <&ipic>;
-	/* Filled in by U-Boot */
-	clock-frequency = <0>;
-	voltage-ranges = <3300 3300>;
-};
-- 
2.34.1

