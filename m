Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BED33E347;
	Sat, 27 Jun 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782591336; cv=fail; b=T5LRHKEQrJ1HC0brxopr3gMZHnwxFGW/aGThQu+crpFEsNqQkkq6citI1nS3KvXbqrRyZA5cYaAqs6eMCaqNu+XtGCEgO0Nm3QcDxnv0Qf/Avsf3DsFCrZXg8Qv06Y8s6GUkLkp4so5f1WNZCw+Pt8fGtxY6rFT3ucSUOX0uEtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782591336; c=relaxed/simple;
	bh=mXhmXhtcNiCcteta/SXWBLdqW8V2QA6w5VO7xBwWE1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UR0ggoNI+qo/GeDoxn6LZnAkdNNCKDg+zkrFIHKv4Q7/DYBOolFN/3lC2FYP9Vp9D/YcffImQtdhY8bhJayIIem6nPUhOMROxBfLhWhL0j0zkNKgIo4F5e7PYQyYbfoQXNwMFE8P091+xPYM6WlZebk9kG83f6eBcAzQhOsp5jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ZH+mhles; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ZH+mhles"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZU2QQYEPb7+60vKGeeXk4prmC44rV1YGguCx1dumoF/aueHxMzcJQiI2/ynYAUA4K4VfFxy4AdauFIS/PB+/xkFPXeekwoi0fiatifXUsRjA7cbvwTjioJg4C6VafoeNREMCAk9NgLBpNB9Ioji/9hNx2HNkk+PIYJCqOCRvUVnNbaqXo3N6+0NAVg3x6xx/mkEMJi0jVlQZkKOj5ft+b9gNmIm2kdTKXTHV8P4LZ5I4xxNcHUzSDpWShSlfm4Tv9aQS61eOY6CdVSw/3NsrRbuuAnqknSd7bh+Kfzjg77ex2C4+znL0puMsezCaewyUS5lLSZcDUWFoW/F7EysrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rUyzTU/GotMaCDc1lzUP+SiWTJIhf13BJhW8mjVisM=;
 b=U1vCiBhBWqNJZXD3Mh+ZUx1snRnCkKmOisS4bZc/ZXuKBy9egbOEuTdzdLEJDBFCG0OWQz2sagsLA62IhJYfLGrx8/9whyBhH0l0f/YZAD2MupPsxaPwjKdrKsmAu373gSP2DLbAk3Wm0MXBZAzoSEZU353IeHVNzNjSwlajAzUkk8iYzNQO8Pga0LbsPhVH4i/gl5kDjdhf/wqDJOdiAHfADhjG8sDw8xH0V0jhmTZLKzXc2J1jRse0ZwPlJLPYzUgwPj4IaZYlf4Kfeu2+sbSrAAV0EsoFcZRbbxn8LdqlxPxA4JepTUPMzLVmtFOOneIVQBrt2ZZDjb3LJx1BCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rUyzTU/GotMaCDc1lzUP+SiWTJIhf13BJhW8mjVisM=;
 b=ZH+mhlesjnk8Ot4KabqEpE1Ci8N8miBIBVfmhiWM1bVkQlii7V47T3kmL/UFlvCXU+QlYnptCMwqDi4SmnQxnXHiHHPzoM5U/r3Q4eaVXoJBCZHtJxzf0tfGKuDNKk0BqI6SPYi23EwH9gvd9lAm/OeK2VkFrC0Q31yJg21glsmr3PxfZwy1cOS3rmcVho4kW9LomG2gXwUUsqxUYaJJ5iBQXKivwjQyvKJbZRltCAEj37bbd3YLf1wECTQ5AK6KrubMAe1/3ddXkfAC48YjE+ibiuzbhT9xSC6MYPiCP/C2gicRUV3gw+7dqlaodDDVnU4MfM7SDBObtfBQUHaXnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5837.namprd03.prod.outlook.com (2603:10b6:a03:2df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 20:15:28 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 20:15:28 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: mmc: cdns,sdhci: add SD6HC support and PHY properties
Date: Sat, 27 Jun 2026 13:14:47 -0700
Message-ID: <20260627201457.12318-3-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfe7326-e5a9-435c-cb3d-08ded488d490
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|3023799007|11063799006|6133799003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	Pg3wPER3+hMe7w3w89CNA3oW+CTOtv3KYHcuj9I6qDkqtbVaW07p5O4kJa8g2VwjOYnVEHmy7ri01YnpjjxO/DkxCyx7317efInYMHjFWmfXS4w4z6XxNWjfyGIZ0rOMF1ojJUDzzsb4SdA3i5ziXLsbrT1d5JztCVT28slBUHMSkjzvBEnHJ68Ps6qvDpKanE1H/CpMdU26pCn3PSO6/QgOYzFtzhPwKQb8c1cLLXY7vds0a+SYRlilbXNT6V7laOAlIYvWEy/grlWKDYPSBLBaf5563ynKISJueQfRN/CAR7gwAe1ks8j2yMMMwNLaefZ+z7pZqwEFl9SloscYddLyTJHcV0UwhXXoW2CMAfqgSBBXK4se/LGlDxHqjMhhWH9aAMn0K1DmAOIm2a0ddnAsS7D4MayJAupHoMrPOoS4x+hPAXgiOPZvQqsDWrpEYGv+xv/b8wt8SfBuVctjI1FrA0EkeLcYQTJqfp9U7fcBWZ1g/38tW2hEmJf8Z8PHMJBLUgjFiJvK4DqVrSsVSus6poVCjSg1fLOvn5nqTll2QQ7wuYIOUiA+0TkClEZpIsVLyPjAr5En7eS8Mck/WSC2v/nxvHLnJI3NoBsTZHfWbzbac04Fak9MjOm9v4UY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XpOYmPdeQSHBhyPzZYMnxfDoT4oYMBHley5xbXul4CFHinGRd1M1oaeXZMH8?=
 =?us-ascii?Q?/Kpz6oVFaDr1R3P7X5DELvNcBaLzeYQGmbLeIawfQ87vuuTIOcalh8mTZkgC?=
 =?us-ascii?Q?FqPRcY4f59lYQBrmr8d5mT6G4IItOw/3dugoR13zLI2G/xI8h51jfT+2Q0N9?=
 =?us-ascii?Q?5sjgJKiHGS8SHOc2oN/0zN7xYdR2XsklTMPWJf7n8RVxlBDgSMSWajg5x4Jn?=
 =?us-ascii?Q?L8YYXBA0hQqR6cJtvllUv9kUV9qVvmzebQvzPNXbg4iMQcfFlB7tvy2n/6Wj?=
 =?us-ascii?Q?e6XBYyxfcgqCJelb5bIArvj5WD6iWoDaytGn9C8PStZzddyCWqU2VzE0w+Ue?=
 =?us-ascii?Q?n5Yuk2AVTX4FrbYQSJSZg1OsGuany+N3e+d2KoB3Sg42XiYKe4YSLXFnBrkm?=
 =?us-ascii?Q?XMVDipDjfpj8+yGLwkt9Bi1QXDEdQAXqRu34mDdBrZIDuDHFFV8cuz4e6gzW?=
 =?us-ascii?Q?ywX/Kpx8pIUK0mJocqpJyXLcmhpjs9jenEkBkcSLSSjD6WvlPf+ryoUu9Qyw?=
 =?us-ascii?Q?Ue2UhhID3VXlS58pL9L5V0ovEwvOEGNkWXdw8cUF4XUlyVl+3raVgHbpRui8?=
 =?us-ascii?Q?ht2bTN51p1ZDpusSdDb8BmLC23yCy/Up4JsiJtRfLI+H2x7xpDhL62LptUAP?=
 =?us-ascii?Q?KurJPEi2H98Akyl8HvIIpJYcNA6Se/4CD1xclZFT/20winWDPl8lmEO+cb+j?=
 =?us-ascii?Q?KASiTlorRaJtH8cD2gTt2ZD6GAx+/6nu+UEQswzlX+j+SoJwKIOjjbEdG2iz?=
 =?us-ascii?Q?RUfSZK/iXfLX825OD0dA8RwqXXRGbe5kz8PoxAGpNzwFC0jd/B/jWN/Xtafu?=
 =?us-ascii?Q?xRSHbWAm+K7mGoob0Zfw0JxisqdpupcVx6iOhGjLjIUlVMXndz1NmPjhg9+N?=
 =?us-ascii?Q?Xlz93iaaLTZHAtqVajal1Ddv5e6bN1uBd6xhMpDoqzVEfzKhy4vVm02eJ1ns?=
 =?us-ascii?Q?pSK5kV6RCVjlKDfJbrPH2yHvCvNG6d6bqBUsPempsbZLbYk3Yj5dYQbfmc/f?=
 =?us-ascii?Q?u0r0VwAj+acKgaHWpoySNx3XCx4KJrQq8kpW1Ere+9H02Vp24oDywW9+vOZP?=
 =?us-ascii?Q?O86rup55vlewiDF7Xa3F1T2xyPqEKDkE0Vp7Tgk6ja801Mm3z1Izj1NnHPFG?=
 =?us-ascii?Q?E5rTY8x1TOIJJ8WJ2ENKby1ZdmCvcpVysnzVpFR82qsU5SIhaAGuQrvg19Wg?=
 =?us-ascii?Q?d92E7MSZ6NtJs9DiQ9sBWu+Fwf38jb/rOZyIiahXmX+a2mPHVsI87LxLpxwy?=
 =?us-ascii?Q?mk6MSlhdy/k+ycgaFDZFvDqBEYBs1XoUGRmzgMP1NQJzneERD0Duy3j0vX0E?=
 =?us-ascii?Q?FLyVyGRc/DbEATrNpaNtdSQTwFJ8TD3csj2IdEFlBo9kCT7jA2xC0KZeGmP0?=
 =?us-ascii?Q?DNLhHXaNX3rsCxMCTB+ViKBBKp3SqBLrC8r0wtJRHHX+6mxJTW2TE6XW/DGI?=
 =?us-ascii?Q?mbKsRRi5WTL/qTed9HkkylKykBK0YSdOjzT0bqZ4piY9IrukoFbUPjovddyR?=
 =?us-ascii?Q?EyI7FciB2vLwux3wDCtu727UJ9ilPbe4s2Jyd3RZha2CwioFVj2RFGEdIQAi?=
 =?us-ascii?Q?sCLybL9nlT0kNv4Na1VvsIPgdScVF4IKjRn6yzxQ/BIYgpMgjIXspceKAnbl?=
 =?us-ascii?Q?/CNXFGsgDBm07pezyAwKfd/uwc3cUaOYiy+EoonXdxKLeoKK3cXGiuNFbgW6?=
 =?us-ascii?Q?6dM5E9fD/fySLB3r3W2NZLmT4PWoClqilsYGIQ569N1kWKW6Z1UcnRu5lJOJ?=
 =?us-ascii?Q?m/8N/+FBlPadKwD9zOWAsIaYXOKsyYI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfe7326-e5a9-435c-cb3d-08ded488d490
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 20:15:28.1140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8HwGGMPyscxxVHHQogYCE5bLC9HyyshlN/FBTl0ZpkP260G2X/uknn/CrK6E4Kga7NemuPl/NamtEdyFHXgddcZtcWpEeM2K2bFHgqtkpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5837

Extend the Cadence SDHCI binding to support the sixth-generation SD6HC
controller. Add the cdns,sd6hc compatible string with two named clocks
(ciu and biu) and three SD6HC-specific PHY timing properties for iocell
input/output delay and delay element size.

Add the altr,agilex5-sd6hc compatible string with three named reset
lines from the Altera HPS Reset Manager. Introduce per-variant
constraints so SD6HC and SD4HC each enforce their own clock, reset, and
PHY property requirements independently.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 122 ++++++++++++++++--
 1 file changed, 111 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
index 6c7317d13aa6..edd96e1d2bdc 100644
--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -4,21 +4,29 @@
 $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
+title: Cadence SD/SDIO/eMMC Host Controller (SD4HC and SD6HC)
 
 maintainers:
   - Masahiro Yamada <yamada.masahiro@socionext.com>
+  - Tanmay Kathpalia <tanmay.kathpalia@altera.com>
 
 properties:
   compatible:
-    items:
-      - enum:
-          - amd,pensando-elba-sd4hc
-          - microchip,mpfs-sd4hc
-          - microchip,pic64gx-sd4hc
-          - mobileye,eyeq-sd4hc
-          - socionext,uniphier-sd4hc
-      - const: cdns,sd4hc
+    oneOf:
+      - description: Cadence SD4HC controller
+        items:
+          - enum:
+              - amd,pensando-elba-sd4hc
+              - microchip,mpfs-sd4hc
+              - microchip,pic64gx-sd4hc
+              - mobileye,eyeq-sd4hc
+              - socionext,uniphier-sd4hc
+          - const: cdns,sd4hc
+      - description: Cadence SD6HC controller
+        items:
+          - enum:
+              - altr,agilex5-sd6hc
+          - const: cdns,sd6hc
 
   reg:
     minItems: 1
@@ -28,10 +36,12 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   # PHY DLL input delays:
   # They are used to delay the data valid window, and align the window to
@@ -115,6 +125,25 @@ properties:
     minimum: 0
     maximum: 0x7f
 
+  # SD6HC PHY timing properties:
+  cdns,iocell-input-delay:
+    description: Input delay across IO cells in picoseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 20000   # 20 ns
+
+  cdns,iocell-output-delay:
+    description: Output delay across IO cells in picoseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 20000   # 20 ns
+
+  cdns,delay-element:
+    description: Delay element size in picoseconds
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 1000    # 1 ns
+
 required:
   - compatible
   - reg
@@ -139,6 +168,77 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cdns,sd6hc
+    then:
+      description: SD6HC variant - use IO-cell and delay element properties
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: ciu
+            - const: biu
+        dma-coherent: true
+        iommus:
+          maxItems: 1
+        cdns,phy-input-delay-sd-highspeed: false
+        cdns,phy-input-delay-legacy: false
+        cdns,phy-input-delay-sd-uhs-sdr12: false
+        cdns,phy-input-delay-sd-uhs-sdr25: false
+        cdns,phy-input-delay-sd-uhs-sdr50: false
+        cdns,phy-input-delay-sd-uhs-ddr50: false
+        cdns,phy-input-delay-mmc-highspeed: false
+        cdns,phy-input-delay-mmc-ddr: false
+        cdns,phy-dll-delay-sdclk: false
+        cdns,phy-dll-delay-sdclk-hsmmc: false
+        cdns,phy-dll-delay-strobe: false
+      required:
+        - clock-names
+
+  # The Cadence SD6HC IP has per-clock-domain reset inputs, but the specific
+  # reset lines exposed here ("sdhc-reset", "combophy", "sdmmc-ocp") are
+  # provided by the Altera HPS Reset Manager and reflect the Agilex5 SoC
+  # integration.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: altr,agilex5-sd6hc
+    then:
+      properties:
+        resets:
+          minItems: 3
+          maxItems: 3
+        reset-names:
+          items:
+            - const: sdhc-reset
+            - const: combophy
+            - const: sdmmc-ocp
+      required:
+        - resets
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: cdns,sd4hc
+    then:
+      description: SD4HC variant - use legacy DLL delay properties
+      properties:
+        clocks:
+          maxItems: 1
+        resets:
+          maxItems: 1
+        cdns,iocell-input-delay: false
+        cdns,iocell-output-delay: false
+        cdns,delay-element: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.7

