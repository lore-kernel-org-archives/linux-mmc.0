Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535E2BB13;
	Fri, 24 Jul 2026 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904621; cv=fail; b=FfG4NFntC1n0ibA8QTzuSFUgQ5QyQg47f5sZu3PWYRBGewiiRXRRPuJkjmR2gOJebCif2HC36PoPjJveGBkhs9mePGGPLLJGG5y5Wk4dG2amAjbyCRQE3rhZESLNYhW9hlTps9MNheXfM+kZi1JSkjbuo2VIC/d1t9Vm4A+ifCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904621; c=relaxed/simple;
	bh=DU62ImXH9D3mBb9/uVeFclZg53azEmAdq2orFJ3bcbA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hsPJU9d2PbpgaAn7AhkNNt1goS5fctwyoGikmrU/qlFUfpy5PsjX1QL3DpSIsMSVXCGGm1PdKew1hZWkgDUepkVPbzLTxTwmPetPhYRV38oA/U3ZU8q8HwYqOLFCuqlsNQfQ7WBzn4kLv+glUTig3K6wZZD6d8zZyHAgFO302gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=tL0Glzgz; arc=fail smtp.client-ip=52.101.61.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="tL0Glzgz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiYrLCX7WFxKyLKgGwWBQmDKDiiJs3RxEEbRHp3RPuu/LZBapzu5NOVI3tqr/Rtbgaxve2s9+cVLHU6aguSbZBNlUeEj3CxHKlZHm+HjSnZ+RFlGmCFzM5pkRxUTiFHfm0gh80VcI/3h7RjGLRCShoKDQWNLNifPO9NTxbOjH2Z2BtiGpdDUtTyHxribcXVFvrV071xg+5hUKRRkrZQqNSOPDjVvewMRqREHd1rzuIAVyNIp4A+9uxCXRsPJjnjvHvO+Xf1vAM5bYsjJNaX8vkH0fX/G3TC0vDzrcWTUiEPqCQl+ryU0YYH3djkqJ1upXYnsMGIjed7bPonkjSISmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6UPToKeQSX+lbph+ZWByTUVOJzyf2V/+EERi+pcj+Q=;
 b=qWsDQaEASIrkVeNxI1bhBiSAG1BTdCaitiyD8JcEUlxI3Rpi0iftGLO5XaD8Sp2GR7KjBzPAMaay1olG8+DJs7urKG+8t3NOxNylFjere+5d3RJN6zfJBolgyhWc3aYiAaE/zuax1GeJswAPcgNzj4mOkVai4VG4PomZ4b6PRpOQLwz8Cpst5CmBnBrcUszK1CwTPfQmGUY1GsUjq3PGylauxGtDuCaFr0cwL2yXc7GWY0GwpgyeAGotBebvqEUKgNdg2AtiUlC4pyhfsa/bGjf7p836F0yYEobHUXp7k7B6sfELORvEMV/ICKQLmIHt/Hc0sqsBehvNpxJATQMZvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6UPToKeQSX+lbph+ZWByTUVOJzyf2V/+EERi+pcj+Q=;
 b=tL0GlzgzIC7lCidsdJUWii1A1hiXy3pqDA1uq9SuvJY89rgMQRP4zN4swisBCp2reEvm79XzVLjVQUcT1l+e3Tx0+TvcyBtKWlyEQc9imDOR6SHAoMcp6p41mNclyhpl+3pr62zXf09WZ6usML3fGp/tniYUX67zCc2eVXg2DyuX8ld57yuRjkx6o/ikQy9C1OX8XQwiN0BLhyWbJ4+qC1rLh3mkGhgQyv8TobKeQDOj6RKIkyEtuRDwaMGWailCwNeMP452ybhJ/z9EbUpTVXs2kQk4QPaUbNkOk97I1cvzW5LZ9jWEw3GqeVjSmUAJMhJhX7mSuh7D73QFriZqpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA6PR03MB7904.namprd03.prod.outlook.com (2603:10b6:806:42a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 14:50:16 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:50:15 +0000
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
Subject: [PATCH v3 1/8] dt-bindings: mmc: add Cadence SD6HC binding
Date: Fri, 24 Jul 2026 07:50:00 -0700
Message-Id: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA6PR03MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef2b4fa-bb2c-4a94-429e-08dee992df77
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|3023799007|55112099003;
X-Microsoft-Antispam-Message-Info:
	UAxmhZp7eByPa166vKHSIhnipE/ofUq8nuiVOVL8NwwGYB7kDF5+lP5ZdBbZnHIuBRal44migMkmkylrCgrA3lJVcOSX5K3BSQpTQ/Z2ykbgTqICcZndl81kHvwJ4RpcOjfzYKHtinyirFUxmbzbmbtkYkmVwEAPy9EoiuLNXGX1JKFVsUes/XmHCTyikHUkCObJBg3IBuE7GGE28XuMUHodoDNHfs4JhaKs7tHhwwLL4digjYrokV5AJd6hbnBXTWzYpj8s/7ZL+DhoglaCdXwpyFoqG6WbVvqPpcdXWq9g/XG0LyhcSyvLwQd4HgZZtmcdX1fRw7rwWKkcsZ9+G3qOj7QZPCzjqEDSTZFQZ2v25wSxHS9yFkbkgSwgMJBIJ7b0EOlxx5w24WpEv0gcIrbevkHJm1TzddWBLK2fOdXuIWZ+ug4bVGd4h/T0yMeDE1eLj9EeCrBo7QNRewp1SziwdZtYNUpSaJkCmbGN4ZcMbuNrNItf7jmQMld05psH9Rpy/MHLqRkIlgjUuW8X6H6gSnaT/BEy6xuGTc+8aNYxTfmg6g7ZJSo9YyLkaxjiSpEHtXru3o4wdKgsTXLeG5y7FFix2qZL9Dg5ymIHZngHnIviWneitu4eIegqS3n5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J5s2H9HEeYkN83Y/L5vjpidc6IzQjIx4e3eiXg4n5Yv/hRbd3GVXsvEaQxcA?=
 =?us-ascii?Q?9O/ObVPbrb4pkn9ojrw9HY/NxkB4NO838WZgBqOirXmqWf96U1woDu6avbZ/?=
 =?us-ascii?Q?08t3fXJme0x6QXGM6O69XtfuZlDTgdpdn5Ud0HObzVzgsi1ETUjbemcDRwtm?=
 =?us-ascii?Q?pUu3uYH91qqtHLlIUZomUuI3Tauk1V/hB/BiQOcZxFnwIcIslzQkKCZ9IcON?=
 =?us-ascii?Q?qeexoB7Pd2xF0MRH9tYAeobLBTcCkwll9a0DLL/3ghTJPgtjovD03j1RF9mA?=
 =?us-ascii?Q?XeTM7owhN5KZdd/h0cPeq4pCbq+9SA7VREENa0VgFH2kl2c3ncPEWwpCqEEE?=
 =?us-ascii?Q?mC5mslxEGyIf/EO0XD+3BjwxRRIvKsCBWCeM/4sVb3g4UhgBd9nhct/XLXu6?=
 =?us-ascii?Q?WTfbgQtWLSxVr7+qZk5AFe1SCyur1Cpf6gRjBpxwIfLz97yQmTURmY0WNAzu?=
 =?us-ascii?Q?ZrcSCdKUY6oDdlcIEy0yfDP/7ArsBObWhdGjvS3VGfQN6pJIAgWxVUJX75fZ?=
 =?us-ascii?Q?nWLMh1rHwVZcCYm+RMyat7g9zZOj1SKVgQro1G66EYPOYxPj8uXBRHs6CZmf?=
 =?us-ascii?Q?Qlq95DMZs6XN1f5VGvlPKONlLVehSmB76XIkdKd2OAQsAlPrSeSQ5fvdUWOM?=
 =?us-ascii?Q?naEVEClp4QREqbIbjGN0PYacW6LPrP/iSHmivRo7y6oGyQAvESfoZoHeYiNE?=
 =?us-ascii?Q?PbdBgDnPRnkqyYhgyrY35XHrwsY+JQDGHR3mGZazFMdTb/OBewsD8JcuSvza?=
 =?us-ascii?Q?zh30p4Eb5LxC32bah8S8Y4811zwqIKKTwwadEHm39lGbNY+w+U4+etq16xPj?=
 =?us-ascii?Q?wr/4VYHfFl+ZM4ULq8OjK15LJ3huEhIzrCV9w7isVGDAvQGjYvTudURIq6JP?=
 =?us-ascii?Q?bC1CRdLiYLnSnBTui3bSVj/CqKNE10120QOqdHqJAVj/8+l5RHwaOgICNu8c?=
 =?us-ascii?Q?21qCZDeIGNQkpV3Z79CgH9FkkllrNp+jbSsxDKn3VoHGdKlEgB7Xj21Jix1D?=
 =?us-ascii?Q?jQrMhrhve4+l8ee+edDiXHzLGAr70btXfys8L20JxdXIMjxfPfnzumEIt4h1?=
 =?us-ascii?Q?+BTc0wGt96nVBNADoW9XR64W3+b91+49RtPNXwrbV1H8xMSTm3cO+YONmgr7?=
 =?us-ascii?Q?0F9tn5o3TzrWgc63YnWm1GigXfcO+IAceNipQX+HCq9SEtMKsfgcpf8Ib0+L?=
 =?us-ascii?Q?HgQb8nDC9t/MclW3ct8dcsJp2S+/br8KtBmwYCTgdec1A6gQnXSB92Q3HwnM?=
 =?us-ascii?Q?wsrD01+U307sVDiLv5tu41hK6qLmRuTMordlt2faACaEGHp9HejrRJB12ZBV?=
 =?us-ascii?Q?uI8JxETaz1X9YMfGz/ZLWZ3GoUm0cB0UATd8R8Wqc1YqS/DH5fHNuWLJMoZY?=
 =?us-ascii?Q?7g09VIcTTHpAjt+am3HpDND3RccY6SyAV/nu7UbFDxmVSXjMrUBU18P1ixL6?=
 =?us-ascii?Q?TYgwde2aTetkxeoG/HzXTetMrv0HitAzPBm1QJ4Nj2Zs2PQmxv1vczsDHC3x?=
 =?us-ascii?Q?j2ivWFFQWFMWhc7wStzRxyYqF7qzoKi9TD4yuG0uhdNzAWUZ9szsqArljXFN?=
 =?us-ascii?Q?nIbfbXTJhZ1yo8UOnSwQ/DZcBT7BAJmUJBqj0jISnO696hcHRFwK6xPYaQ9R?=
 =?us-ascii?Q?3w6J2cHwIGfF4JvEcutYNcgfe/xoKqOSh1JHcQFmdjb3Yby+r/AOCDx5peWN?=
 =?us-ascii?Q?WWzpRc9vhc85/fSLlh0vq0jXIOqzvr3gwnR6I1PlJgo6vKkY5D8/PKSySTqi?=
 =?us-ascii?Q?bxlSE1h5zLyqJ8e5ysoBBV9qJ0odqws=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef2b4fa-bb2c-4a94-429e-08dee992df77
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:50:15.8728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wclTgY9ssGpDITptlLWnUAhFU/UAESIFLDegT2mFVf17O9jneOr78Hx1Xzw0gqFBXhF6b3b07iJLHM0P3FTpajmsWjl/ifVPQg1HsL82sj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7904

Cadence SD6HC is a sixth-generation SD/SDIO/eMMC host controller with a
dedicated Cadence Combo PHY interface. It uses separate card-interface
(CIU/SDMCLK) and bus-interface (BIU) clock domains.

PHY timing depends on board IO-cell input/output delays and the DLL
delay-element size. On Altera Agilex5, the SDHC, Combo PHY, and SDMMC
OCP bridge are each reset independently through the HPS Reset Manager.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 .../devicetree/bindings/mmc/cdns,sd6hc.yaml   | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
new file mode 100644
index 000000000000..0586d2e530b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cdns,sd6hc.yaml
@@ -0,0 +1,114 @@
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
+    minItems: 1
+    maxItems: 3
+
+  reset-names:
+    minItems: 1
+    maxItems: 3
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
+
+allOf:
+  - $ref: sdhci-common.yaml#
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

