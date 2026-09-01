Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C24A0911;
	Tue,  1 Sep 2026 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288555; cv=fail; b=JrIPfNzqf79djnZ1Z7teQKJLQLnXdz3nFnA9sn+XRbReQG71yCfPha2tYvQ1ji/MPfyijoozJX4bJCkIfMKU91R/+uRYh4gUw9zvQW1Q750WcFQVH0Ax58LWnB9WJD9dxrPBTKVOdnp5lw+SsDoV1jW6BRCH2yW4GBgJwsSbfRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288555; c=relaxed/simple;
	bh=tCMXUeaBrrg4qOo98h3Nt/kqcy52escRntH597ghNvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKPbTqkq5n3GyflqHnY5XcllQifBt4ezVVhGV5u71+EjSPm+D8tv/CbL9pCMEwFr4ornenzmc2bv3T7UdOnTbGylDADmXaAAw8YyZ6bbTUfcenyiemYZJguToLabmxGVb43XS2YUWFfHLFntroc0pZtcsDhi+wUJ33R0tdrgug4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JklDII3+; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JklDII3+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRCjjxXhAqxFVq9STLJeW1EaJAp7fSOIItt/2T7Aj3cBGlSISCNA7M+WNo8k7G93ZXYN6Y28XKopi7/yQ6o9u2NfCqFZOQy06ZVfNb57xZcO+K4m9s9FSEcihgKVL1EzbirgViZaEcQWCmCFqHK+wLqNIlHtIycZfzRBrCIxGt5Qm7Ox3E+sq2n1foN934/xgLao5vG7Ig1V4JJ4BekO/ypbhZELQPZCwYgFaFnuttAGNZlLX18amM5/dmx3zSi4G12ddMZUMQ6/PmRZCE4UL4QmobW0q7oyr5kSTiO6XXV02NXB2luoGfQ1CW/0PDC5df/mBh/yEocEQVNVq3W8og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=nDJW88LaN8s0F14qdnUOP1ispDotUgwcdxrqzXc+CpgypmoJQjIZ9LxcnHypHboiFIDqa13wshZVQcQBlzjfA/klM7aaEYn/H001hXfgdhuTCfF68+RFyzQ+bZM4Ll+oaa/E/jz5F8YFjg4b7Fs9+VG0+SiOG+3Fu/lDM9UulFYLGnj340GpcZCBDSrQOY+ujTbzaKt9E29cmtMGRRoxfF38wZrVZOx0/wZkmC92RssYxMVUDf7wpKgLpysAEyG54BS4LyP6poYi8tKN0jTEIRqwN92PAFETVi4vA+FB32oU/xsgOpH6PqLiVUG+/XMVpSJkzzVtS3pUhHKWdZcQOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfUX3b9ey0mpjfO+P2SmmtmVfGZgHthu2sBydkullEg=;
 b=JklDII3+AlryZiSQxM9QuTv4ZheeSHarXHIRMNAExBvoZhKBCvlr4VqiJM8CJW5uw24LI5ccnIWdPXX7SYxvSFUoOv5jybbhv/XzjX2U1EVkLm6Rd/+VAlspSC2kx6+X82xR7da/xA65AE350NpsuJSrpgwW9ttF6Lbrw4cS5TiwA3lHZjaiAKj25LJqEJpCO3gVcQ1BPPquJdIFqKx/WVdXRhawlPDH78ZcUKFrBCzbWjiKrAf8i2TYpx6jZUV5VjJ2gERCz2QbR8xCJYmY4Ifyjyly/MNgA4xNE2sZH5M1pNN+t5Eu3y4DWGwDnZaeqR3hDk7S9iuuuppcZZTaSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH7PR03MB7338.namprd03.prod.outlook.com (2603:10b6:510:2f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 18:49:05 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 18:49:05 +0000
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
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/9] dt-bindings: arm: altera: add Agilex5 SOCDK eMMC board variant
Date: Tue,  1 Sep 2026 11:48:13 -0700
Message-Id: <20260901184828.15653-5-tanmay.kathpalia@altera.com>
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
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH7PR03MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbfcccc-51f5-450d-f94f-08df0859b2cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	tFV8OmsEd32eW8PcWCiMBFNKLq5IoBn3dEHhc5kdnOOiNIHZyjhNMAptuTUzw+AbYnxew5tary6iT2DIxkMk6dCSVYbJ/Ym0qg4J4LA6Bm/sIdMIQdcDE+xu46Bze5khRaVS+C7IgL82/vJi0RG0Cud13yt07bEJjXgFnJoan6zYGT4SsdUd988jvKt/NgdBTZEB4I+ya+nWhuM3EHyN1DUfEidep78O2ujgCbOu7YGhpVxwP8yHpxz4LDPhn9VAjaBtQXY0mlxZQERnHQREDed1A31saUAuXagrOLPRsfY/e38MtxbeD/7bfoqPQUtNNnoh3AsxAd7BG24PiCWC7kaiPjq6bI1w5uP9SOuGXjqi6BLaUeTkEfqY68WeZgEEDIpalluqA+d5WewFwO3GAXGxwjYDs4wN9dd0njVM6Mhh38ALtDU5cpltUPcaneDGgJxkuaQnLpaCWC9RPvZbw+LLtZGFZ90Kqkkn16T024w0mqTsBTa/21x4eGeAmltYmxHsPiAIudDZsL4lcLD38iI7yEL9zmM7/UxvEJu5Mii6SFQMdhmwdmMBlE9YcfhuSodUN0oC343iLg+82Xl5YQuPnCHU0nZBwv2SuhjYGB/IAS3UznYDMGsAMpPUJ06cF2V6Q8+5JZSkA8n15Yqj5J7SJmfM0VGdq/CnKkGhAr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VjSaeBqehvhScE3bRG86/5+VpeYkjICsyeHZpCWQDtJTNKChhuV6ONWOtrgx?=
 =?us-ascii?Q?zEMd6c9rvEj5xhfzYSd2AU9uiMxWb+B1aRPRijmZGSPk3jihTgOpL2M4oLD4?=
 =?us-ascii?Q?/hoBq6GCK4Z1lyYSjVvRZqqLGdMcHvhFmcLfjJbSzs5vzntJ7+k9PJ8r/CCC?=
 =?us-ascii?Q?MQF9TO6Br9lEn4tgZW2Kfxd3BgTsaJ37DJ355B7cy9TJeFznU28VMMu7D/yX?=
 =?us-ascii?Q?gG4BQbCezQq8vpInRNHBWog1Sb3onF6l5ANlfVw3yYI8HYHXiKzBkAxOOz29?=
 =?us-ascii?Q?LsBIxNyOQdX8TEdZEJeNXR08MurPEm2xZmjBOwZXcUqfetrqVuGzDaxG7Gs6?=
 =?us-ascii?Q?lTWvi3q4exAeDkLJ5WL24rPZ0XRCNPehDoI7mSxelwyDZZGvo6unam1jisct?=
 =?us-ascii?Q?lT80SOLx84ye/sqQ52dGlfhLjMKosGqveBhSURsRCRYn+WStucSx18XlcB6t?=
 =?us-ascii?Q?QIJn7Y0d5ls1pd1M+TGdS/05b5N7qQJ3kWZ/L0hMDLQRM+6cTJ9s8OozeYiu?=
 =?us-ascii?Q?H2vVWrh5smI6XHDd7RIGNkJvHsw0vT/Y/6GVHjmQbzJ+uiAgt/hQF2neGBgo?=
 =?us-ascii?Q?CFHPK43COZ/Xc2ytL9Dv7nh41mGufllTBfkMebyeuVAv14GEc6qY+rdmlvtH?=
 =?us-ascii?Q?JCgVaT2RPB89yjWqqLJFN+Lr+TTc8Tu4DiubiuxU8DIj0jHYT8DCRncgSa87?=
 =?us-ascii?Q?f05Ro0zH/GNDZxOwWOmfGcsPiJyLLyQ9xG1mZxAKWOb7tKos1WJLPKV0S55O?=
 =?us-ascii?Q?8jmf01/LItUY+BIPBITcf/RarjS87GI/G3M68dI44OoxRG0G+UB5NJWc+YC0?=
 =?us-ascii?Q?JwY74fjN+fxAURLSvKfi+Tc25mcnDVRbnVft7wUOdwHQ605JENHScNeO0mss?=
 =?us-ascii?Q?3P0gddH8IxSuHUpCuJ0nF3npm8lH5gcpXRcVHJBkxcxJ7M4nOGFgcGeMAtU6?=
 =?us-ascii?Q?+LrRoBQ4RYhuEdh356FdJXU+72yJCBvAGjI+Nl7bIbQEvov6E9wpv4WcnYj7?=
 =?us-ascii?Q?Ojd2XzfMKg7Wz5UYBR1O27Fp5ikLDTr7NJLEoiL143NGWIORyI1llMWeDfv4?=
 =?us-ascii?Q?+gGUUkQK1bMv4j2BvzZYD3ZoLE7y9zGerREAiZlX/ensh4sn2uDUjteSbOOF?=
 =?us-ascii?Q?PG+ThLz3s5HXDwPFe6c9V6H/GOduZkCgWwV6d8xkfKoqrg44ALG6Dv6imq6+?=
 =?us-ascii?Q?nUEIA0cecNlkSDJ41tEut+DZQ0N09jiltuk3svSjL/fSM6oaw6fKe65P8SVs?=
 =?us-ascii?Q?AwS/1JyLG4tbx9dz5/ORL6cy3Pc0f8fvbQnTQwP/BgYRlcj4PbdBRHqWrUlZ?=
 =?us-ascii?Q?zM1gOC2nhXYUMjyP/ZbgezFLyBrjd/I37EgmG+1GyPj7vQ0+GOqiNYJunbBP?=
 =?us-ascii?Q?sezZXa/CjQ23W2yw1YD+IrTuV1S1Vl4kAh1hoj8BUjTAUJqAJ+pc9KnASiJB?=
 =?us-ascii?Q?qnu0ezMwwMO42RslSZkhTE/1m7Ac1jGiWEsa8S56ofKSiUbmy8DVDvj0u99V?=
 =?us-ascii?Q?egHuCDBSz252Iv1hHfaqO7B6sBSBW3N/Gq1BHiGgWOdCga+izAysBiVdEhIL?=
 =?us-ascii?Q?wLSmxiAeK5Kx2MCnJoWPCLCxTz+0K9fnzm2KyknFRUqHrkM8qfZRnRGpI1LU?=
 =?us-ascii?Q?xb9OKsPwNL711hIKZD2k+XhAlonhnPL3QB6TlkxgYOjl7G1Jy7jJ3DR1ngOK?=
 =?us-ascii?Q?EVgxdGKS3GMXrKa+DS+9CGM8WxBd3EygiTVebATGJju5wcxVjLg9PBUzgSRO?=
 =?us-ascii?Q?g3fmYBQw9fBkbYnZnQy/a5J7tC0/4H8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbfcccc-51f5-450d-f94f-08df0859b2cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 18:49:05.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vd8NPIXGJymolNKbNqJVhF+HS5S0ymBpXK+HU5OpSbsFwwRjhnZ1xGagkNc9anGjw4SBX9kS0VccJr43eiVuVUXopilj43b01Z97nUJ4gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7338

Document the Agilex5 SoCDK with the eMMC daughter card, which uses the
shared HPS SD/eMMC host for onboard eMMC instead of an SD slot.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 0b418d9d60db..ce3a8c1679e5 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -112,6 +112,7 @@ properties:
               - intel,socfpga-agilex5-socdk
               - intel,socfpga-agilex5-socdk-013b
               - intel,socfpga-agilex5-socdk-debug
+              - intel,socfpga-agilex5-socdk-emmc
               - intel,socfpga-agilex5-socdk-modular
               - intel,socfpga-agilex5-socdk-nand
           - const: intel,socfpga-agilex5
-- 
2.43.7

