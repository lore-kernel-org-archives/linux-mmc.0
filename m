Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03449F129;
	Tue,  1 Sep 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288550; cv=fail; b=X/++WFQ3InkGnrrm33ywWHgGSFHAbrJHtOEYCzxefj3k9aNbVSiy7kMwlnZfSN8kB80I34P39VDoo+5/4aQd5T/WsSJBWMzstviwkYcR/G67fFUsdmIoL/TpmN1Jwdn7VDCjwZ4IG6TXnB97epC5L6YAMgCCMbbnGzVhfedHA3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288550; c=relaxed/simple;
	bh=jkcntfpeK261uYcfHbwBzdB5klx5SPZdLBUgWvkrooM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTgaTyqWxPAVV4g+xveJ81eAYXnn3i148jey1KW28WCBw9wrXoxUQNmJPXnwkqu8bJbSj9QMW/KmqUlv6vjlsnMgHCQP60397zz+xvysMxL8osSwzmyhvKjLGdJG9nDoMXtbFU0vBb2ftQ0bWncr7lkwrA89O3XCdHnqHxBHxg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Z+7aXNJw; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Z+7aXNJw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5x3Hbw9yL4oQ8bVT6/g4nPC+Hnmm7liX9Z73TBljQO7NORQ5zrkAAyPXNJjONqy0XF99wrics9bdi3SeH3iNvhlW817vj9UnM2Yray1CkR5XoKgi2Dm/0fU1/GUyGWCxWGXQ+Mdf+KuDkm8SCNpLNxZQBQ4OgqosgrgzcIUwMGdJIAHTXTVYim3OPpWfNzT3lSC7Rel/Ux5TEbL8ECvA7N0LZgn8LNGmAUTM1Ybuu5ZTJbwSGRUxyE53DRZntYSyPxv+cZrfKPAz0ZFrXrEYZEUVYgcN7c4kugJzCApSezkD0QJl+q20/Pnm/DGfBJs2ouXLiCgDDFtHchPsyFx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KO7y/XrdZQTI51QsrqEArA24Q94iqn6O/idem2SA7w=;
 b=J6FfLJl1nZSgPQ8DKUV0CNcvKm1sSMDD/OwiEhRyFZ6Hvfini9wVpd3VZl9GRNMABOyODo61U3wWqBnw0+/wzs9rrUcnQGOyKYFi1MqheUCtL156jfhzD1LnveUS8xa4Of/7dVMz0eOarbykNEqw3EYk3vuTR5OTg7iGRi4T/nJsCbqy+033Ni//TvuTo2uqqKSw9Dbr9ZZ3nLP3Abj0Wq0sVXmaRI2iUaKTFLqgUEk3HrpJ11CfHTJcFQhKoBCAKvsczCcayqeYy19IWY1/hEMIvpYWLZteuvyTcJmjSlvtjUrpkif+YE5dd6G7lEanOwgaw3hsCfMtOCbTReEOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KO7y/XrdZQTI51QsrqEArA24Q94iqn6O/idem2SA7w=;
 b=Z+7aXNJwzVU2ocGXycyHm08WvkLT3SRSFG8n3WM17ENrzzwU7N1LptvOJEY7xoIG0I/8oDpglCSIgZBwyuhw5j4eSXmrxX2YAck72NFpo+KWsoQv5Om4J2PN/WGbyohyCxFizro4zp1iOEWJ6QOurvejxFubM7rp5orylq0PoWRuiIfXM4Fkm9QOM1ZA1vZWBQe9Jfqy+kpZBU7ZvSvAEL6wdvyZyz1cISgSoRxI39mjL6VOgd2IAURr1I+PJwnK5bGVV8g0eZ1IaX5V7eahwT05AK6KaTMd7sQxOx8ty32lzhB4Iqf46zX9Fc22htEy6OCys8wAmzu1isQkumS0mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA2PR03MB5866.namprd03.prod.outlook.com (2603:10b6:806:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:49:01 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:01 +0000
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
Subject: [PATCH v7 1/9] dt-bindings: mmc: add Cadence SD6HC binding
Date: Tue,  1 Sep 2026 11:48:10 -0700
Message-Id: <20260901184828.15653-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
References: <20260901184828.15653-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA2PR03MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c073577-b321-46d2-86f3-08df0859b06b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|11063799006|56012099006|22082099003|3023799007|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1IVAT37K69NIrT4hXa+gE1hXdbY1iYnWBV8U2OX0B35/4kNskJaXdmiBv5/b9NEsYp0S3YJD1dynIR8UuQeE085Ia5mlj9gsADTENowVKflejF73PIEPTuAxvIBksxYxxI0StnAAXVfxmW3kSTRatyB7hMaUppN5rXdH00Bkxn3zD+TJG0Jpos+zUL5dA3S7q3wknQxInzlXvWd9V4zIk4pK4KQvxMEGlG5ggLiP2HXhMFRnjP2k97RknWfJ8DLS+f3yE3mOGwuqbS3xGCT4+csleyfKyHKWDt4d1V3sQfbngw21krHwP/W24b+7QRZOoK/qtyKLQS8lc4ZiXg2KC0E85w0MxUWTGn9CnB/sJ0H2pFNl/Z0Mp7ohGg+NiTcv/EG5r6kS4PSqeRG4z1V8XTXiu5V2LMaI7rYvQAThkdFRA9ufDhMK/wV5AhRGcOKjGrKEX7yWMEHekHO0UhYzf9Hzg81C2h/EsEzvhtyGSofgFvKi6XhtFNGdsllM17nJPv4YMR6E4/c28mCKP0LJqa1jk4sbgOmRQlWmS1xnWQyA/NB13jwn8kiv9AH4Qch26zQRaf5BQSF01q4e3/KvBnj/5oXh1r+Nfwc86chFm4n5cFenzfnPGaQ9HJIbRwlt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(3023799007)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gl/dvcIQUUPTTT81cLqxtuOVSrUIThN0IysVTA2LPRY+a+Shio20riEdUKkk?=
 =?us-ascii?Q?oh53ewrdSBvY6F2Xjc3Cy4o+1NgdtM/WO4xPr3Qm1mf64+Y1bEGK8LMxfdpt?=
 =?us-ascii?Q?6v1KT2/98Ka68MeuZ4qcruKG301Qzs/pSPNfS+ChXhwAFDVaU6uRsyNz5+mH?=
 =?us-ascii?Q?LT8byucuyxPB85W7bPiZve7yYMVu3OFMImFAluVw+0cnWfLXEdOYS6u+GJ5z?=
 =?us-ascii?Q?kGj+cpoWSq+jGBetdSXxNjXnZ2GCQ/rmhZBzOAN0q+oqNQVmCARUaxhoQQu9?=
 =?us-ascii?Q?wsmEOspwCDCpNV/r1p/W+K1A3/cBTut4B8FFNrDfqyOs+R42lzFaBJFBOPFL?=
 =?us-ascii?Q?NaLY2EHdOP3kEJNmXONvb54e4r65TIKxTiZ6mycKrvWZqiEGJRaUcO0FWUSx?=
 =?us-ascii?Q?qJPKXClAnlBNyccQ2LoU1L/7LXNpz5nhIeL9CRXi9NaRlGibjR3p43X78IGs?=
 =?us-ascii?Q?lS2lLKQr71ilVYC3WQ20wghgl1e44Q/KPwpCYSr72a9e90FDc22uEgAU+WKb?=
 =?us-ascii?Q?PjYzPilk9pQX4nYYhE87WEuTW6k1Q4yo+cecS1x4h5lg0dx4wKDiH4iWJ+PB?=
 =?us-ascii?Q?TvQ2Y2GDKLdru076x9wkHK/SuRcAs/Nk86txgzSA9b/jrMGCc20vh0LcyZij?=
 =?us-ascii?Q?VFpravbGIzuDeDaSN5Px31tEkgiXAo07uY4+jucha9f6r6tkj4PJRTRnlxZ4?=
 =?us-ascii?Q?fJjnZFwZRVAJoXBTx5sXM3MTAgJv+LuhY8bFcVUwHzErJsZalAPc/GwOudz8?=
 =?us-ascii?Q?J5OwLuzGThtUFPbbW2UJ0D8UbLVqGhCFLpn8Bjl/fLP9CILKo36NhEr2c9fk?=
 =?us-ascii?Q?rx2IIpLjXiV6+tJDqzeHc/GSE26jUBO8o4WuKvbltR/IhkBu3tyKDl7jNHKV?=
 =?us-ascii?Q?5bDGZ9cqfVPSO98c/XwSGnu93zvgj5US7Je03IF7PgtKkJRUBMdsDutUo0uU?=
 =?us-ascii?Q?Br9EhmkDCs79uANVAM6RAg21uR4O4+T5LdeTPrXVcGT/KDsLYc7tinr2WuWK?=
 =?us-ascii?Q?7Ibn4oGseYdKke11brHmTSCrc3avYj1mbVXZSrFTBC+uKoZs35pAghfmr4A6?=
 =?us-ascii?Q?rQvRXPj7S3HeSzSUqaiZlZtBLKDjx2Odtorus6ui7k1H88nUTP6Ee281U4+J?=
 =?us-ascii?Q?hhmzzaXpomGwSNUEODd8CBQGyiQ6qH+NNy6u3yO3YPgvIP+D5VaMwhQGir3K?=
 =?us-ascii?Q?rUbTJaDN7i6oaDiK+QwPp60yjTi0Eyp7T8yoKIzQv29UxbOo+yG/zWGjpqbF?=
 =?us-ascii?Q?Pn9DUWRTnf12XML9GBLxNjQIOAqfO04e+5TZEluwCaPgMAznAdqXUonu8cNg?=
 =?us-ascii?Q?hg1XHH1E2vQhZH1VFyJ+qUtETb6GvF82aI5S7kdAjWUeoQoOk5DyiMxfBPB/?=
 =?us-ascii?Q?BPI/HFumbC+kyBxSpFfpGLuNT3PdUB0Pz9goFvXd5EM6+osjx4H+K542wdmW?=
 =?us-ascii?Q?eRPwZj00slq8Y1LWuh/EfVNOzXrT91+eyVSmKUJ0Zgz4WsxuiuLMiS3MZ661?=
 =?us-ascii?Q?zQpHIAzExaoNZ9GSckA5zuupfReESKp42x3YSAe91P3kxQUl9MRuGaSBxX8s?=
 =?us-ascii?Q?Qel3tlFw0ewZX/LQlmwBbdOKoV8D+zR0hEwH2kFteaVCvXzaaTtMDCNw5nVn?=
 =?us-ascii?Q?nvQgqAdyUpA7txxvW33wnxgsc70VR8avyIQeCnIRyqKZhLUv57poi+QxhRmz?=
 =?us-ascii?Q?Je8TJEEnl3d4idpJIxVyUb5n+aI1Vp5qDiL2Azn5qHMXR3/6XYxkpm6KL1PS?=
 =?us-ascii?Q?Yp7ED6xpm26a/S/evRXZpY5u9ZQfZP4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c073577-b321-46d2-86f3-08df0859b06b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:01.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02L+wpdjzilQ5DCHsVDibcYhytbW2tKMFKeSiZ9Xwf29elaEDjMaGi3L1pDbU5ovrizctMBbZWYZ2suoim2nnQOTPe8WjSkPCZDYkhodm14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5866

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

