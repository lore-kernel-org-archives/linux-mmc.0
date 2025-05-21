Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444D25A2C5;
	Wed, 21 May 2025 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826369; cv=fail; b=d80trtDtJfXefMjY6jIICE9VmlSPpo1qgyCYYFUSrFPuK/ZJv9lkxWLC164JqN1qnIYfdFbDe2/AhquTo03Dp6oWgYHply/n4pYPfnsANZlkzfu7kpc2u4pjdcl99ytsEXCWUfWqfCSSCCvsuZiOm4v1CcDJTryTzdZRLkqHjJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826369; c=relaxed/simple;
	bh=Kdoq/LbIKySvsRFgRWOTXgfW9nLMErQ6TxpdUE6SbFI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SOjXpREnVJX45aIJ66KHxducCqlPm4A7quzvYpI2UN39XtzIyQySGD+AN1TPCyt22+clTI8KMhlUC+kFjGazQzg4DXh2Y+yVAZi/FdyJSnx3+DBdr9/ALooagh8J2JI267KrpPZtkqKTxKBOtqttxTHqjZ5keYBIRrh59LpncsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S9ESdQ0+; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S9ESdQ0+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdQVoSGeeaWD5EjHjE5apFBNe/0h5ZI5SVyiS6njN+ccfyBpBvR5ols0hZJcbycop1IN66L1KXgd9qEKHkjhX16tJBft5UJo5SWLh+HIxTxc6/PpJe0wB7yqzISSMPdlpozht7GgvNGDtcDO8p+R/ZCcTV5+ROw+7vQ34DEE8eBhvqdqMPJa2eBinVVG3tCBwK2F1lOWY4Qq5+HnT47BQIqhyzM7NCvN2Zfr+F1G+eKS3HJsXbP0edDRP1/CmxoMSjnPj84fvI6KDKW3jVA7dlVkFyESkCEOce7zNrKNbYnNYDS1q6ZYVYuqcakCq8T3KVXshTimZPit5xebIAF9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=docwtRrkJh2FF47a5H7t9L+ufhsx5WjribxeOoiGRiI=;
 b=G9LL9Cw9lsUVEGVbwHF64jSs2SnNz4AtlRaTPhCRpW8vO6BslDRZNUSC6ohyS3R348vRjKoOSad7s7GgqnCi0GYS2NSkVND2N+13qNilHMBh9/wE28xWDcDMA1fXwaSfL9jr7BFp242EB3zP5EzAXEd1fHTkhfJS8HFdY6jX9iicz4aeigu64oK/iSakerMFUGJmFVFOVkpX4MRVc5TTYQJAVRZZTsKFfp7EHRvfxaUg8fAjgApmhtAg+p88oM2dle+KFljfryKPdIrXDQEsZFdMAFzYwiivZG0XpH/J/5UJP6fx7V8YlMJS9OOU1i5TveVAif7FMuyyraH6t+JoNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=docwtRrkJh2FF47a5H7t9L+ufhsx5WjribxeOoiGRiI=;
 b=S9ESdQ0+AZElpUUy98TrYXlNuciCVPdR+gk3xppSbJ46xAzzWwbcAoGhIOLOCY+cT7ft9vnHtiZB6pmV5jtlTq5GYClCDI0bq4Pj0CMIQJzwbbtyGJYGCtPDKv0RJyV9QFUx3JkILS0+isdwK8DuRmYOcyAevwAfnP+KA4M2Sxz41cdNVexB5YNz5s4MAnFXxJVJZ9nY8AIbHSBn7uv0OxfopBThpiXcp9PT1qh9o8YNtPXhawTNVTYFbcT6NO6EN0L5HHUtIN6w9AFXl3qiZZKaM7K8apGy55CQ9FjaRM3gJQMO8mp+cgNkH5CTltxqZyQ4HVsMSahtgT9bZ/gcLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by GVXPR04MB10048.eurprd04.prod.outlook.com (2603:10a6:150:118::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 11:19:23 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%3]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 11:19:23 +0000
From: ziniu.wang_1@nxp.com
To: haibo.chen@nxp.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-esdhc-imx: inherit pins_100mhz from pins_200mhz when unconfigured
Date: Wed, 21 May 2025 19:20:42 +0800
Message-Id: <20250521112042.266111-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|GVXPR04MB10048:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb1c269-caf3-4bdb-a58b-08dd9859569c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/X5OcM1ugaOgZfhkD3I9JwOpjZykYSTrod3UrHKMHzAFh55GbnbS98RhhYH?=
 =?us-ascii?Q?JUPOroPWFdTQ36m2jbthaA/BN/JsYgC+adQZ8MN63PkFES29D+PfXzxv9A1I?=
 =?us-ascii?Q?qmGFWdX05Cc2nmWwjYB5dVkBH5gl8mYkk+DYoJoueT1+pdkI7MjXdAc3lu7J?=
 =?us-ascii?Q?7aMaYGxSfL9YxBAwdm8R8aZeeA/2UKxkaFVBylwVvv58c2eI/tUv/Oq4AbRO?=
 =?us-ascii?Q?J66KFOy4MKXx9mK2vhfPumSrKKftrWiTmNlv+baYAFVS0YsS1oj7RHKOP1bW?=
 =?us-ascii?Q?HWTCGFwARgu3JAQadu7LPgo4wjsGGfDzKa8QcJfJSFmZu29MinsOXeTSJQb9?=
 =?us-ascii?Q?quzCcDepnK/nQcTc1yKRw5oZdyDqwC6pCBTwNVND9A3xHU/twrUlWVp0SRbj?=
 =?us-ascii?Q?6UfxUwt9ElDdc5yeFnvisMxqAqoVW1S/3LJaYdmz1++PEchzxqIS36cXDxkI?=
 =?us-ascii?Q?jlqSmW7fkMMSN0xV3wZ25uYmDynOjP1FVD+IoDvwAm2kFoNYC2p7z/RhUx3r?=
 =?us-ascii?Q?bfEBvBwJqE79Rn3YZ2AuK/CWG2hI550LUGwrnsq41tZSgFa8c4SG8A4F1uoo?=
 =?us-ascii?Q?tgXXcEjx4zwNlWTWc9uZwAVNNVGWhs3+Hcy/Xneqki2+p6rmQQ+hdUf4yQcp?=
 =?us-ascii?Q?XbOgwPC0qmBIBTZDIUvS9LNBNS28YKByhSTBdNNz82D17Ujp7XDfbiJEfngi?=
 =?us-ascii?Q?eBNNMTHpcNgeGDoeGs7GQSbUUCLMpENwDXazP4gCrrKtzPCq4u2fJJmAzYtD?=
 =?us-ascii?Q?jQ85/HlGpgwMJNLddYG4v7YvzcDwBJLuvhqxrmmAUS2MzYO76AFclZUXUifM?=
 =?us-ascii?Q?L/tawdet8bW+WgUyCvBCzjkKn8XOwwfgaak9igLVi1Z6N8LUHhdvdFMty3/a?=
 =?us-ascii?Q?qbYoqonz7nJudvLAN09jW36hJpn3aynD4bopqjggd9yrMDI3ZBKFnMwUpBW9?=
 =?us-ascii?Q?J1dhidHwl8+JrDn/fjvoBsf1PLrMoXYRRoCu28bQU3hB2nSLvSAvP3CptS3B?=
 =?us-ascii?Q?LRsqQrb1DxHP8jdKOoYQC55/66RLhxMnjuAhbI0Wgqs2fM4Tqr2h7MKiecvj?=
 =?us-ascii?Q?nZWZcsNXYqA2/BBelXRr+7CNULwivO3DqeULEAK5Zy6wojxzb4E45nW0hnqM?=
 =?us-ascii?Q?+/NloPrJDdzdwb3L3XAqkAmbc4J5rrp1kuv4Wzw7amhk/59Ty0bM6fLiM52I?=
 =?us-ascii?Q?fygTeaxCre84oDwy69vcMFo2f8HOatxKUzkXg+zSHBgS+Dn4Zb2/ke7dl+Id?=
 =?us-ascii?Q?twAziN12rum1naPnpMFHGru+DRqrs0OBpZ2FnR/5G+nCooXRBjzkrfKL0cgS?=
 =?us-ascii?Q?CVjqcDteIv/gTthsTpk4BI05EMWktjQmM3nrrMic/ttSTmwIcfILyghBBByO?=
 =?us-ascii?Q?BPxaQUrMYTA/VWaWahvD0dbYXvfTHM7KLoNc17moPGlWG7jmZKOthit4ntWB?=
 =?us-ascii?Q?vYzmQUKfOiCRiDN4q85x769QcoApmm+nBvGgc3wNXfk/D70pLdJFKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A7JKBziagTv2MGyNO+jHJZAPjJxmX6pkb8jJcGupuK3VqAIGE2pRsTfIHfAK?=
 =?us-ascii?Q?jAU39SGw4a0WWpozmsFGPfA3bIhbj3aIVwed0e/gsuVFBdP6FP4sY11E9R1Y?=
 =?us-ascii?Q?hV98HJJGfOVDir4d3fEBFRjrSxfaniTBBBNhBaDyXmRFxLeqXZrtYhgVCfAY?=
 =?us-ascii?Q?coHE6T2vPOWYTCqcuNUInH8+R1bOr+zcOAzE7KrR4IDyXHA5FAXLEXrXL7wG?=
 =?us-ascii?Q?YgGtwB3i+f6pwYtgqHjfH+5zR8McC5pYvegXmHVAhQdKxVfHl3anWcwKL72/?=
 =?us-ascii?Q?6uVbCzHX3QQMSgJV5HpIKLmEb4ZgwXr9Iy42gn5mzp2pU48mlE1Xqwva7za8?=
 =?us-ascii?Q?EAWKv8k2pk/ge7clqiSe+eJW4C/j74yucKT9hahGbBSrb7TFRrolsfx7nRwL?=
 =?us-ascii?Q?Lbov4VQsScX4E5kiyiI8b4jrUK0JFmjGYF9jLGYjkLFEtTGwcdLk+I6TXDmV?=
 =?us-ascii?Q?I/aDLuh5GEtdit5DfQ4L93w6U7n07KZcoQbBEp8seUMxRiFdQzbDxrn7Onip?=
 =?us-ascii?Q?yDf0Fe32ZrBgvcnXgelx2IKBoKSE86i+d29BPE+H/V0/0+c8kFF5fTlnfji6?=
 =?us-ascii?Q?NSwGcbYQHS7+SOAGonulUAqIFfBoueWt86ia9ncA94C8NqS7CeG0D64EbGd6?=
 =?us-ascii?Q?GXq57PBieP936z3ZsVfWphFWRLoqg9nlZ9JBgJMAcUHgBOcFE7IYa7MFSg7o?=
 =?us-ascii?Q?XH2Iv2MLVU45iaMvNZa6Nf2hhSErpzQaIJtPkIHAXR2Tv7CE7clN/aK+ubaK?=
 =?us-ascii?Q?Mu3bVTlEGzbKKRDZP8Q47d7sfnQlLi2zhPxiaTESrfTnRvwGmLg0+Z8yDTz4?=
 =?us-ascii?Q?yurJrY1KWA8n61W6xc4NGzH3o7DoJTT0vh9OSDRw4cnxv/vcbPosmf/qx86K?=
 =?us-ascii?Q?/OCC3/cHomGU2uAdh4tBmOGMnKGp3bdu5D1oJEF8VgAbMkY5cs+i9KLN73sE?=
 =?us-ascii?Q?W9rc5rD23mZe/RgUBfHqr3Y6hWHp6qjZsdzjU+R5FbGjszNAyXbNHJj4ducD?=
 =?us-ascii?Q?wjnpHL3u9JES4YY4r2nNyhs6AD2iKSpEJmrCBCXyBnCYWwip9fBWUCT+fieL?=
 =?us-ascii?Q?+NEAg+QRMcTIg5jk8JVZVQx9eCtm9RyXCKjYJhi+cxQhZXhDspucZuu9GgZN?=
 =?us-ascii?Q?lMlX7aE3HCe+4xWESfnW7WjWSJ1YYgGjHXo8na/Ixh6LtUdz9QWgPXHscm/L?=
 =?us-ascii?Q?/LDcUZfVfAvKlFNh2Gh3G89b1LC4w+tWber9ynN92T2RzgRBBqONEeWua9NH?=
 =?us-ascii?Q?T7uteBPUzQtf9+iHWxd1ILYvbKDAH9CQY0Hz8vbyQcdfCP63+54JCPsTbPQ7?=
 =?us-ascii?Q?4nxkoqhq1kMmJKkZ5hLlhRwe4FRLkOSghaFbgvE53lo5JGeBCFIL7vL4PTPn?=
 =?us-ascii?Q?GNtW9rILqERq0hOiAlTEVlFoonjKjY5lbko/Mdg8dFHVkDz5XjEVvpONG0ff?=
 =?us-ascii?Q?MdyMZ54hPY1FivPtah6P4KbjVaL0x7DyAbO4Xpj3K8taaWmXtXVGXsJFV2fX?=
 =?us-ascii?Q?b8o8FEm5yMwRJFmfiOgeTunwocvd4xkC4qEnou+ppAOg3lnfaacc056T5Jk7?=
 =?us-ascii?Q?yHumhfjab+EAaFOmJ52wFQ/IhJyymTE0HjQLxG4G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1c269-caf3-4bdb-a58b-08dd9859569c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 11:19:23.3062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNTjCSgN325RpjHkZhv+FjtJvXgwNajqQw98ZtSbJj7A5dHX61u7dpvcTSLp0D9LVLdUluiv5c96DrtSqR3kRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10048

From: Luke Wang <ziniu.wang_1@nxp.com>

On some new i.MX platforms, hardware guidelines recommend using identical
pin configurations for SDR50/DDR50 (100MHz) and SDR104/HS400 (200MHz)
modes. But defining two identical pinctrl for 100MHz and 200MHz in dts
creates redundancy. In this case, omit explicit 100MHz configuration,
driver will inherit 100MHz pinctrl from 200MHz.

Preserves existing behavior if 100MHz is configured but 200MHz not (e.g,
imx8mp-navq.dts usdhc1 supports SDR50/DDR50 but SDR104/HS400 not).

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f206b562a6e3..dfd8be5000c8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1810,6 +1810,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 						ESDHC_PINCTRL_STATE_100MHZ);
 		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
 						ESDHC_PINCTRL_STATE_200MHZ);
+
+		if (IS_ERR_OR_NULL(imx_data->pins_100mhz))
+			imx_data->pins_100mhz = imx_data->pins_200mhz;
 	}
 
 	/* call to generic mmc_of_parse to support additional capabilities */
-- 
2.34.1

