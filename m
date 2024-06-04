Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2061.outbound.protection.outlook.com [40.107.8.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5AC12B17A;
	Tue,  4 Jun 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512815; cv=fail; b=ItZcn3C468eY13CAQpLevZu5OZKJ+OKs9KdlZIP8PkjdPEMd7lpODpP5XpbkLciObwPMAaOLwNFG1WiNKOzIGt2WLlMYQJKKpmolN+LzDUlptwSR3Y4m9yu3Qd4UW6yz+0hhTjRgOF7+uHUu+raBvZyTlz2EETPS3xjahYMj9xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512815; c=relaxed/simple;
	bh=AwLJFydDRSar8/yMCgBWM15Att3NFrrsyAUHD4zCFeE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cI3oTpeVDHKJFjfjQiPvR0c0LPc/xkI+6R4EAMxzK85MbtzAK6HTOVIgZ2+ody6SaHF1qpVcZxGFIGEzQL1jSsWfO3zhDqTgnWhhtnsOkThB3IIBL1cfIKe1WY6r2QP8iSD+y6CPoXLJvFP0LnHk5zdPFSBY6YIUNsyNS57DqE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OznoapqN; arc=fail smtp.client-ip=40.107.8.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OznoapqN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQsDV9lTSQC+xPo0xV9zoZy4lzOxWLi8D1GbJxtF6SjRR7kWAFwBOwxtK8Q0qQuPjZ7BhYbsd4SMEp10NCBLIWttcriIz5fWIPmokBxPedHc7ngCCPP6iLjoKY5F43nbtK0dX63JIbzfaNUePh3bNB7BrhqdP6fej4x5kBfwJB74jtPjX2fC6MZhHIoOhbgvRRLQkfbhXlmFEKS3b81mWVgPZYck4LMGCSyIF6aHQCKSnVzijzK4DueQYm6pq4+RDezErYPnQUQUrSZoy191Y6z2jh5oLZWx2cF/S2EY7cm78dnPh8OTD11zE9s4ztNzBdqoN/iSXpDHziLlfDvp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YDM7CYNGrgBLyPlaZnHk3P/2X2djuPJw+C2hVfyj1o=;
 b=Dk+TlHs+4iQJ+YbWnzZGU7yqt39VECoxF/HZUXDPkthVgPRdLtJfI55zc2qzCrUeMvrayuOysPIiYZ21s9mj1cKdIBvV+oFc6VF1UN7KvuaF2Fti9fP8b+lZQj1npNJfyfBjLjJLTTCgoJG/9mMq48E2V9SJDERsSWxDkcxKZ92CPd0W7vVydNgaNvswLIhnZIJnRMLRt2wIsFoUOE1XLdosDvDBWQ6V0nVnmX8w+ICSNh4NUOXRecA++ibtbP5ZWoifV1/M5V4rh6tv3099f6UppUZn2A+wKMMqcJ6zuJM+6pwtmXOKEJkNEG2ByiDlqy43HCzIojONrfQXbJW+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YDM7CYNGrgBLyPlaZnHk3P/2X2djuPJw+C2hVfyj1o=;
 b=OznoapqNd07YDfo89EoSZ1Ixl6WbYzroYqyS12qi6AAazk8LZn+x5JjaqY6X+kZ5pwW5krScmdQHzELud3GhYCzCnBEoucPz12DY6aysbejF4rUWS91ZadkHRmm6kSJ9JCN1k9VUGeIXn8fWeH0bTvyML28gHmePjGGmY9huTdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10826.eurprd04.prod.outlook.com (2603:10a6:150:226::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 14:53:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:53:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	ulf.hansson@linaro.org
Subject: [PATCH v2 1/1] dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
Date: Tue,  4 Jun 2024 10:53:08 -0400
Message-Id: <20240604145308.2417017-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:a03:114::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10826:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ad6e5e-c11b-4c16-47b6-08dc84a61739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9QBlvrc1CYzICDTBxn0mnOh1NVki+gIBymSu3KFsbNzJf083sJ6DaEoyd9C4?=
 =?us-ascii?Q?ZHmJVBlHvcfhoCGobVyhPzwWB8zxGvtVD950a2NozOfasrR1lMSujaL4ccB2?=
 =?us-ascii?Q?ngPPlvM9RX2+KAPXDVvGBvmRZiQTjqgU4MlthZpeMHX7thJiaRo32eGMyrQw?=
 =?us-ascii?Q?VMD5UYOvbU6s7ieUXtkxdv9qo1zWjqIgrXTRrJmDoUirPMojcJywDp6YXkzh?=
 =?us-ascii?Q?jNMT1uerzU9CXKaH4u1w7ZRNhz+Y8MqRaTPZ/Y1/VSE+IeDG7E+s/GXVHSV2?=
 =?us-ascii?Q?1XdxdMuq/GMFmLUccMMtwuWn/IVAueMmGMLhKdHPtd48dnqBFyFzRrKbsGJr?=
 =?us-ascii?Q?fnnBKYeCxW2BNDSarkmJdrtHjW43I+r/qTX3sAKwiL3xWDGoFn8jOzBJfD2i?=
 =?us-ascii?Q?wr66KMIT0K305Ia6EqkHPMC8F3AeqavyJiV2K1VtW6bDFTlZXkjXlYCVEos7?=
 =?us-ascii?Q?mEsRp4tYRRliW2cz7Jb7Ocm3eImmKLLShY8bhDrE+By+LSb8mW30w+0YMk/L?=
 =?us-ascii?Q?oqtwZD7Vcdgpao9vn6P6gq59XSHrMFVJ1w4oShVfXQrGUjm063GjqqggS5ST?=
 =?us-ascii?Q?ZZj18+BMtreVXByRm+HYNt6U5gQ42JiT0INXXrE9XI4Cn2XXh8ZZRqyZ0wvR?=
 =?us-ascii?Q?j3gyKzSkpE0aDnp0c4NMLARA3pTvw7r8C5zTBfiU0mEwjHsD7oAQsg4gpTZ9?=
 =?us-ascii?Q?wngj+6oIrTpYGsxbq+iRc5naqsfLXn4xbcJSjQsElaPzXSuGuOgTLNVnBSgr?=
 =?us-ascii?Q?LCvvy/pbiAI5lqakAFDCic0dARwaJLDokS4Vy5oiywTcdlNfDtK19FHnkVkm?=
 =?us-ascii?Q?0gnqahXafFWWV7bG1rQqTipdfulmPG0OWG4wOgXi2saWnziiAG+OFQ/m/Zny?=
 =?us-ascii?Q?jn5Ea8IZ0lyBCOnrljJyIA86jYgN2Pvgm9yO/bRf5B1SEimgrmKFpouqzNzX?=
 =?us-ascii?Q?MjR/tzXPgnS/dMwdw1knhSIySR0010QdgsR0MimYXEnhOl6Q8P2VXQkokr0z?=
 =?us-ascii?Q?ACIPhndTWhAg0D0CH0NRZlmO7KYbT1pj2YZYww9Nk/cbPkGEJfmHDRQZb2KX?=
 =?us-ascii?Q?+zya5ubfay5ua6OZ4rdsKF8pquiHp5z1/V7f3eo5Z06ezyq5enjl7h1DomlS?=
 =?us-ascii?Q?T1XHzNB/VMXSDJ/H8PQx9uPtpy8QOHupeiOecqGZewYnsz/aWHhzmd2HMtN9?=
 =?us-ascii?Q?gSVQUib0ub7qC/ry14Ulff9SrmZ2sqQrXPwntJcJs3OWSyjpmXV/m/IdJFUt?=
 =?us-ascii?Q?UZuR6DDePeBEhL3d+rFomIeIUMTL8U/ev7JkSVhPXgizNaTzpABi91FUnFNN?=
 =?us-ascii?Q?3ftSG+8h72Ml26vfaG9fIAMV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qwRKzh44k0p8Stfbzb6Btwwz2xd4bhlqb/ZdCrTPTjmD6yycIydbgue+/fpt?=
 =?us-ascii?Q?z1ylivgXzD5CVUbZemb+h4u2dHjGrw1Ei1I+8c1I+8cobxZH8zjPH5jhpkRz?=
 =?us-ascii?Q?5Dx41Gp2O0d3ofUNWA86+iz5tmq2OG7jhSrSBw2ig6IywmkdDDSb68IVuhwn?=
 =?us-ascii?Q?Om8RteCNWbEkoXA4iWxWpPJ3DQ09Sp2HgueIc1yTxYXjbJY8+7f4TJnfvVAc?=
 =?us-ascii?Q?r4xH+3tHOMDTZflKVbAquldzSCVWtpLy+b9rWYWxSXwIzGQnMEXn3dWAP0MW?=
 =?us-ascii?Q?gFBGU3JJhJk31blgDLzqM8EZYZKEAJEgNZYov82vlD4SGXlAp90Jtzm6p2sm?=
 =?us-ascii?Q?yHwkB6nDlDr9PlGrnZC5JX93itTZWUKkwBmW61LfwuD7KDdjc4f534CD0YVp?=
 =?us-ascii?Q?5x4IvvFVibhaKEnL59lHeYscfiOzSGUSXxD7WdQMxzM5KxtYNZ+Eb2huW3mj?=
 =?us-ascii?Q?kys7nQBCmIO1zT5B1bAb8ZEFX+hg0oZ0nvkXvp6Li2OBldg5nns0SCy5bPwQ?=
 =?us-ascii?Q?daMKCXE7bCjRVlbnTy+j1KJOL8hMhHmvKS4iiN8DjpE7xM1UNiFLhBmQMIC0?=
 =?us-ascii?Q?WCtj23+8kOqtJLq9RZ6bSauia5ZJqHad0owNQbrAvY0MgGaYskq4uA96uIVj?=
 =?us-ascii?Q?jvs8q3MsmXJTONWtzH/z1wGHmdF4ftES6E6ekoTpaLe/FEWIQeM5/GuRjqI+?=
 =?us-ascii?Q?bKEfB63N/EaYWZ6w3NPd6Lv1ogSiSQaYh2YUZaWqwFdaVfib+hA2voTM64MY?=
 =?us-ascii?Q?DCx1qZX8cMR71JSucEmB76EEUKEcbp1OQIBiUo2FK4ppoSRJW6+r+h+jA0T0?=
 =?us-ascii?Q?F3LM0CJjeFkNarHlFY2lV39Qz7+l8U3mmh1pb7XWKtaA7r4gH4mQN7/yJrB2?=
 =?us-ascii?Q?+VZEyMetFZW1gazo92fKVdjL86ZWx3QDKnO7o3VHe7PnUYIaRLTB/lRVF6/S?=
 =?us-ascii?Q?zr4YNl79WwunQ7yqAcIyaviuzPpmcjxWhgqHhW29vdepjSZUh4tCMXgwC3+z?=
 =?us-ascii?Q?6Ghs2A6OjV3Dm8aa206pngOliILqyS9Zwg5NkGtgyicXtsYN2+CZpAogsfsF?=
 =?us-ascii?Q?EzUqRtNg9G4anWjr29jaJiJ2c69QSmlS0fB6In8PZrMChrmTgvJs1anmRiFR?=
 =?us-ascii?Q?Okn5ZE1fS6Dl19uiYjHk/Z+19fUCZ8rHvxt/Qa4BsZrTuoygj5WjAtaToF48?=
 =?us-ascii?Q?c/cYNLQJMvaWU47/t5ylaDwiuP3TNy9Ph3v+qpRSdFxOz1dg6bA4sSQZvUuL?=
 =?us-ascii?Q?PDfS1zqttQlSmWMu11EofVC5KfXGXWe4+zY3/EPTuXk0U3t170NThKsQWuBG?=
 =?us-ascii?Q?Ov6ml0rt2MyRAylnSGUZ87l+I0KAItX1z5/3iCUFgxg8L3u7oDfAprNs3xdF?=
 =?us-ascii?Q?swtFMN734kZXMnp6aJE3ZJUnoFBXHLj714vVSRw6HzaoKaZCGdxPtUOZ/gnv?=
 =?us-ascii?Q?oM3EhNpINte0gEthsgm1jg8nO4oiUblA5fEsytER0891VDYsetVtNCNZStLs?=
 =?us-ascii?Q?KxQUaD74Ki1LYTobz2NCp8FKbGmFeA/XLxKMlWYBY7wbnKLVcbt+W26g4VcK?=
 =?us-ascii?Q?72T6rHdHc0DI0+WitgJDUWfNV9c89wbFkSwBw9Pp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ad6e5e-c11b-4c16-47b6-08dc84a61739
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 14:53:27.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRY2g77G7tDf+mVuDIYAqRWSL2bAVEpZhz2SNd8XcftgMTQ2A6xhT+90DheAIikkibrxm8VY8wDkBC24Klr8qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10826

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

 .../devicetree/bindings/mmc/fsl,esdhc.yaml    | 99 +++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-esdhc.txt     | 52 ----------
 2 files changed, 99 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-esdhc.txt

diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
new file mode 100644
index 0000000000000..4164fdfb9f8e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
@@ -0,0 +1,99 @@
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

