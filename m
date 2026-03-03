Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F9375F72;
	Tue,  3 Mar 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571740; cv=fail; b=bqYHOB+fH05qOPGxfVYkgWeBDBdQS0O2aqIE3FhIouKGLptwLcogUVlNR1UgcmImCFGVCQDOLHj37SNW/tUOhhuu/+M/cYFWzpH+sdyMStQhBRr8Zl/9K1EfNkx+Mr7jQHL/4Q5kVuzavdq8BxLqUbp57ZL/xvKpcXXMZW0HTTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571740; c=relaxed/simple;
	bh=BRzZSVy3syFNpfCXrRsGqXHTZ5s7v3pupCR09UCYJ/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MciXjlDl7xjE7aS9DSlMciWkDtV4TcDM6kCQ62WUi0LFgT7ByTeNFY1rKwkcO1iCNIZI59x9TuGdMKOUU/LfCCbvpFiY7aNtIueXBeV5phKhWK1m6azUFHfFL827mIXtb1cJoVYboaHG6d7JygWfPCHIAnA/X+sRKlWgj+ZOv4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZMcE2f1P; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZMcE2f1P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXwW0IB6kbxWIg5TAjEbqMVRbmzRJslb2WAYUBDBDLN0/wqr98NJOWH6as77STHX63u9dHIsIvpukiO99QwQXEDqiGUsklgRdC2EJPyhAxeM7/jTAg2fKdHw5T5SRayp19EUwbahisUyiPWGp/N5PUio6V1KdY2uxx8cq/9ogbYQ8x6T/+OwuQnSDkFSgt+P7BUqwAPmg3A2PrP82mvYwqQeOlZrmMYu5hbd6rELnZhTOpmW6eyaNOosN2ilpZOEoFJGx1MtkzMjaVINYTirbwt+xrNErgmBmmbruNs1UPrytFWLHfKjZo5uxSDnoV/dBK84nbt++Czh7NvRY1a+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE+o5bzBWt1qTqsoVMFrHlYB9Kh74RiMK9KEgUZextg=;
 b=DAy2uSaF8MvhfYdfBQuRvwmHt++lskEII1gPGeqVe3JAT7Y1oMQNP2MlEvqsvE/r0nLijW7XeZwzG3uMeGQqkM+ii4wWukJE2RwSWuDWetqznbLNoLG5qfx35bYUZs4qBy1xLC13W0FAE9wJ1+TMf6DNg0FSRc7vdIbBgmLe3uPUEsXa1xBFnEoowaZ6Hi9FbsWeuozx9ziZPqmXiHUDVuuorbgNHcGuHnFbsbr6fPgBIzcw7MYSKjpXsMedvOwSuWj7Aq8g7ElqwasS3yDJyoi+jGssbUywubxoIhINEAIKpxMpWrEKix7xKw4lnKfVnNBjJkxlliniIqnSBdfgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE+o5bzBWt1qTqsoVMFrHlYB9Kh74RiMK9KEgUZextg=;
 b=ZMcE2f1PIKC2rdYpqevLEHX/GdACC/ulrNC/TXXLQST10UW9LeeupiFwNZYE9++9bU6yJ2JQKiOXt1LfxoW/Sd9ZbBNq8nIDLFr9hrS+bItlv7QFH7yz0Hr6N6J/wHTOb7C4LDYOIv/85jvoTr74RwSu5M6fLniNJQVwFmGtfflv2eI///0s2Hs9y2ytrYGdCYjjMoTRC2aYSNW6FN6SyfUTm1U1g8MUwN3EWNwJUIxwwUumbxxGPSc1rSV6C5PfQYbR08X9W73q9TtuqunRnXhxlUBka+k6CVPHi97RS5pG+PGWc7gB5pJdSGBiW/dsx5u8Fth3QgsO2jBtDgApAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVUPR04MB12217.eurprd04.prod.outlook.com (2603:10a6:150:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:02:14 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:14 +0000
From: Frank Li <Frank.Li@nxp.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank Li <frank.li@nxp.com>,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
Date: Tue,  3 Mar 2026 16:01:00 -0500
Message-ID: <20260303210131.2966214-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303105006.989339-4-ziniu.wang_1@nxp.com>
References: <20260303105006.989339-4-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVUPR04MB12217:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f5d3f-50a0-44ea-fd7d-08de79682565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	1Y2Hj/uRugxkkUOKGNlqLdI8yY34zWQKsDSZzlLOzchkjIcfwlaH6D7FIfSPHuoFr+iF1UdZ6dHcfOiDbNcjLK33abZdSuEgnMSdTMc3Xepz2ZC32vzM8BbgxpuXR/9fvKOzXosmcsfDkrMNd8553/o7n9sTz+Xlxcns7wpQOcvuiY0HLMMHAg0mR69RTz0GKciuARufLazNeH65ZxqmcPaOdF98V+s78OUUKwXGpMHqN+iLss+4EDu0j/piH7826d2MiVlneOVWxRz5TSzarME8AP3ENmopyowKeZamxmMSgMjv7IRK2oFnvgfXaGn1MBUttvEyPuahA1jNhUYsRAboRyE2aqj0/16cise/YlkZdr/DrX+oTKNU9pcWiJ/hbQ5hyBDTOFdmVmboCx5O4AZReHzToUMJYsIg6IOGOtkoO0w8lLntUSu9ZXWrwGVetGUVJJXxMRYLBC2Syq9oS6q3qSdEKSOHbe5mPQFfiWTm3z5tYze6Fnnys6qE7N1QJsGv6CNbvqcA62IzlNzGnujb4Noui71PtQvWbxruvPAJhfhLY6MPCmjsbsOvGjJ9xux7gz8UUF1r1h3ggWKFdF6UIGNM4GE/y+A4WUi0REjh8qdowoK+AgW1nGSnUB+hV1u3mvVW3SFDoRLpFqvydDd8jut2M9MNn3Vd608N/kLuhF3RBCczg8zOViMnb5iC4zVT1pbn6sjpnVFgkeW75/fqrCGlRSD2FvuZDyRKJc0dPn5xzyOKbVBbZ+iXxEqV/TFzl0iKqXjZIxzKbnFq6biKa2UD+4ShYdYWykPd4zI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?40HGZT5sm53uPiJdioSf7gOZobk1jaokGTFAAQYa3BVHXaroCCAv3GtCqcGm?=
 =?us-ascii?Q?0j4O7hBSKvHE23GIwgEkF/0Qlqa3w9ZU2Dsb5xU4BwU67pLHk8Nuqi4MILgN?=
 =?us-ascii?Q?+JyR1VkTi4ApQwqjcgupWEeJlRTgF7O2wIvfS1iFLZ/8liwJiJ0p7eVrxN7m?=
 =?us-ascii?Q?3qJ70AyF9ny/N2jEo5yh7bW9B6+25dVNMGLidUguOX55+BB9zlXGYN9G56UC?=
 =?us-ascii?Q?iVDG6kUVKorMgo1hvpvtAgctI9fiQ3tiEayKzi5/sFpQiUNya4aiePbVTEQr?=
 =?us-ascii?Q?o3RvXZLSZ7Jevh2Hemb8g6oNUp8TWmSgzQZGD8g0Bl8ubiLaCbdlLGWUlKuz?=
 =?us-ascii?Q?KEc21fLfVQ6Qm8n5beynKE5T7NHeMtLRbCwTqpQnnWeaKYxbXWEITJre5YME?=
 =?us-ascii?Q?EX7OgYiNrzD+N4EDCJT9r6zBnlaJlEVANr57AIbaWc7O+zW24MORB1coM98P?=
 =?us-ascii?Q?7E3XBHU/HE9l0YwDpdZGPtjgUFlY226oTXVGmiBOuHb1RFA8g6EpxXlUeoFL?=
 =?us-ascii?Q?JPJFsO18WnKVxpV0n9NWXd5PHNtq4WoIvHmeeNZNwbWEp56tHL2TODA1k641?=
 =?us-ascii?Q?7jLTTK4lY6xRAeWlh4hV6Rj9FyhCUT9WpzcnahyDEWN7ejuodrHDbUnYIEBc?=
 =?us-ascii?Q?OB65zftU4pfJsG7W0Putt0oPWFxj7wyUw1S5NE+Mv+xuigqTSfBKBPhud30E?=
 =?us-ascii?Q?GTXiGITfeAEeCrUTysmmKTA/m7lnSEZs56lD8Zaddjhf7HkCAlNqqptDimce?=
 =?us-ascii?Q?Hxll0tF8WFLRyQIZ2m7+RgnWYPjCAE6KJ2nOYcwlSIfHasnvO9Qmziqb7pL5?=
 =?us-ascii?Q?2Th+W9enCr1UVyQ2GdxMZqs8iNDhXEQ4FWReTu2sDZxIqXTz3Z2TwM8pJL+h?=
 =?us-ascii?Q?KMbcTSmoNsWXElpmEQNAeOMPPObqABAFl1kZtoD+ivYLzdU7ji5HCi8kZC3f?=
 =?us-ascii?Q?vBEYZa1pqchTck8rdNAAzy9FEHarbMaSQi/GyveZwTjZggqyMtqpgqD2J8m2?=
 =?us-ascii?Q?JlWGl38G2zKhlUHjbHs7xnZapyVpCvc+aoZVpRvRtGfl7shPtA2fY0YOi87h?=
 =?us-ascii?Q?Bks5EhFWODenpz5ntbcujmhLZB2urFhKNgFAfxwmR9ADjQG/Am0mHJ/jUTjP?=
 =?us-ascii?Q?1Knvut6VI9p/grvhizALaR6h5M0DXDA1J3rF6mY6zS1cBZlVNe+V92aRDvyB?=
 =?us-ascii?Q?0N9aiCvtZyDvKmvW74JDyk+N6yxVttntLzifvihO0UdbtQfgsl5XJlYWHRse?=
 =?us-ascii?Q?Li16heNlsKgJDjnOkPgp4X10BPd52W6m5DcA68ck2QKi6a5Mc75hWVSP5pOb?=
 =?us-ascii?Q?+qquIPbNirXNy9tXRtvsDfy1ti+kpxyyhGkPhhxeWhnCi6k9YNpWzO5JK8Nd?=
 =?us-ascii?Q?YqfFSF+LsUtav7C57rMlBL8wS75hsonwK0qy/DKU2padJtZd77SjON17L29o?=
 =?us-ascii?Q?2Q77sF9lt0V26ZsgxbHflQFJzFIDgK50sXm0iWfX7S3AnBN5726ihlXHHTu+?=
 =?us-ascii?Q?DR0zYF/pQvC0KnoM3dUlibYUvrvxH0ioBwLkz9MX5N1oqB9jEeQzOedipOaI?=
 =?us-ascii?Q?Zi1P1GM60+DV5ktjm0lbIp8KcvW8MIte2ADYTsz5lCyJFLHr15VOFSvnfJja?=
 =?us-ascii?Q?tGoDkQp+rPq43pHeD1zDiCi58AScZRj22vOV/3nO97b/kS0IZ/1Be04YVb8A?=
 =?us-ascii?Q?bP566aea70fw0uv4B0S48XyLazliaqj/ofgQc+8XXXwGlX6IU2vCqW3wrfg2?=
 =?us-ascii?Q?TB9eO1AHAQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f5d3f-50a0-44ea-fd7d-08de79682565
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:14.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNY2x8At/zQU4obTqT2IbAih194cNFMSURbopbKPX3YoSzzjt+w440sl16OngAGim6NCDlWziKExuP09vZIHtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12217

From: Frank Li (AI-BOT) <frank.li@nxp.com>

AI bot review and may be useless.

The patch looks correct. The removal of duplicate validation is justified by
the commit message stating that mmc_validate_host_caps() already performs
this check.

A few observations:

> -	/* HS400/HS400ES require 8 bit bus */
> -	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
> -		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> -

Consider verifying in a follow-up that mmc_validate_host_caps() is indeed
called after sdhci_get_property() in the probe flow, to ensure no window
exists where invalid caps could be exposed to userspace or other subsystems.

The code removal itself is clean with no resource leaks or locking issues in
the deleted section.
