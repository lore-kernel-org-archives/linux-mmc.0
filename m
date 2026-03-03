Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70EA3242DF;
	Tue,  3 Mar 2026 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534903; cv=fail; b=lGyEqY/C32EGtgupLUWKUS/Jjd1VdILLMezVKRN35LG7FPe+1e9bM42hj/TlKGE3ukAmT2fXgor92HJwQzNz4QDkxZlR6EueyXZ1byRPMeCTQtGYv2WrqJj3DHyPgSHAmn93vjne9rWBYnb3dFJ5GLPWTWf3gUUrYhnlYuzvD+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534903; c=relaxed/simple;
	bh=NEgY61dHf3JKTkn0dxkOW0IOlEmtlsWHjwjqvcWEknw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNiVq/qOBg9FVT02zgbOgWKBapH0hXcnwvD0prBtsHWv8krAdjnvw86PlGyHV/iPBKxdFIsGSjDiEa0LRg8tJvFJlVOdVb/PECGw/oBETAOvLUNVGS9dhdzrAamhnGJSxZH3Lk5G2aMSC83bYwSGonPIeJ/A24Jgsd9SE9T2fo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QwPAakov; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QwPAakov"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+rR1Hom81ZXM3MqICvxfqoIUqOyKyavQVTU5xch1xWDnacUxckEF9KACzrOBPcPGoqNamB5LW3J9FutyZq3HgSgCxFuPkYdC2/vC1ImKwr+tsr0SFPeEzdc80GmhybqKSQWIh94bWQ2U8kU6HNFF8U4IVFQnV/QPP49xjgDq2F8pUwjlcYgmEbN8dIxTEQBJAi/5eJue/kVF2R8T3o0e5jL58k8pPLnry6j42063ega5oarOxKBOsafgJuB+YFPVsYyNEeQL5zudJ+8ryLPDMas14ZxxJ5oHQ2UDv72oRUaA1v3tGKt/Uy1ejA+OWOfkjNZoZU5c6lrtTVfP+6FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxssZMkmXS3vJdqAGIKB/CW3qxzTsWMPWdWI/4IHTeo=;
 b=QIyzuqDWY2SlctFLcHcn7x2vGag44w60wBBLb7G5yiFGW0pWTwtbOwgsVmkMDyAJWVrMdFzGqEBEQpOTt19+qWgHg5hLlpN7PEAEf/D8X72GGP4jbhubZY6jE55yoVhgFyzw8JqDoMBql9uMDB/9rKJ8So6JTHE/U5WyrhwEPhk8J68TFBr4CaDizCYdejdcVmnRSRpzcrBKt9410rTYpLQReWtTG+fz6RbdToal4X1pJSih1r8Z0bht6mK0A5iVuTf3pQjx70QJKohO918URFBpGtqek09ThalJkNwqzZtlPsmS6MFz1ffudCJ5ocgveDyLhaEihiqzWiAXIxdwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxssZMkmXS3vJdqAGIKB/CW3qxzTsWMPWdWI/4IHTeo=;
 b=QwPAakov5tLPn8ybrvWPWwKM2/9e7JiPfxubwqqy0WixTjX37ITi4WaCt3uQRg5FqV7jvT6H16Yd8HWZcU8qqCebXkLC3VZEFi/wp/PBOMzZa1j9APCmWZRpwpDngRCPn6cYlN41LkXT2txbg6ROMr/tW27CwAWCMCal1bnGqcRy/rTnhQrHtj2mvkO9ZMsEjzIhfLh0NJzeJPRhKJSMWjfgho5FmAFnycLot2MB5o7PMVRju6D2PKOIXd3ETCZ3quowrJn49moBkNGWtY9oSlOY7mK2bIylW/zTZx2vozAbuYU92i0Zs+yneiOHn4fmaeBEFmQkFS5Lr+9VHdIDhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU4PR04MB11926.eurprd04.prod.outlook.com (2603:10a6:10:628::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 10:48:16 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 10:48:15 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] mmc: sdhci-esdhc-imx: add 1-bit bus width support
Date: Tue,  3 Mar 2026 18:50:04 +0800
Message-Id: <20260303105006.989339-3-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
References: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DU4PR04MB11926:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dd107e-9014-48fd-155b-08de79125f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	sZEeRUksmhNeaVVpHpH/cw+CK/8v22N5mvJ2+FvSh4oRTKVFqMizeo6LsKxSmB3j2KkPyn1se9SRbRsLDkQMlQtk7bBFMlh7WV0OushQhWuCs8uciprBxPjpNHydm870pd3RA/FrgslUlrnTj8u5vp6iAd1p3wSS6n2vY6HAYG8RCdasqBK7tdLcuWvRQAJmERDUFR77OZIFbdETAkgsErrYe5yRtETh9GifUpH4T0UtUWz4Vn80+6ldXuwR0Frwa412EUDQl5eS6w0Dsfu0ITzVzK0XO+j2IbQph4Qe4mq7er8BWMDG4QxDA6LYxyze1K5A4FdlZXX6VWphVc6V0GVIMSBSIIe3uQWAiSbIYKbgEkR+P5sSKfH9a1uyhlJ7pG7UsbZ5nReY8mJ243fPTll7TH7w0o6NUG6GeFAyp+0qHh9Zq8UXnyhUlf4ayFpAALVZ9RLfTxkluxI9Z2xqq/hBBETxBA5lxKPSWCg/Z+z0IgIS6bMQEYeDKbbKmEdz4nyaP0jfV833i1ZiFld1uoCqpH0KKP5yJu39Ak8CpKCR0xkWSH+ulSLJ9YGSzUMjqE+3cnqtvLORGWquVaHm6KHyVFEImu77Zsj1xVmzNhtPoqCYfuIsuHly8ZM+z1yQagy2jAVRpWiuUf7JhqpyWYXGxRQbcmr6RDQhMN35LAMkfYjktIs1OuH2N//r92NqvW5wFCne5sxkZuLEi3Ydr2pXrRgHk3kUUbC4uI6n6186ZIjxQbfbJ5LJswvvYGVP90SYfkZYx/qCAFU5Kput3iWD0MdBKFdiz0N2iITLZ7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xMjutOYoFLawo/5Vx0sozsxAcDasMywBBxiXnxwkapQnpOiCgcGBGkCssaRL?=
 =?us-ascii?Q?aYjTnM+xQApp+QPNjcX7pXWPttwD55/q9kBbbn3DKLiyBFrvdoiB7AAprG95?=
 =?us-ascii?Q?wms8Ur4OUjJxO81vLgBmEih7xkdtd26xtfykswlzE8zRMV8JZ6qDnceW87bq?=
 =?us-ascii?Q?IC9/zVqO0DWl24saibOmUmGVaM/1n7L3cuWNrmUKHxq6COXaRd1WLlb1YH1e?=
 =?us-ascii?Q?GhMiqRTE1rqFdNu+0aohsOfrlZJjrPr6uVDVkXTdzlkCkJwVetzr/54kDUKY?=
 =?us-ascii?Q?91+LIKAwedGsF7b1hRCt+5pF8m1o50YZnk+vbCO/tIjd6Vin+60gTXydWGVg?=
 =?us-ascii?Q?Je8EaXhliEnO7Q2bx+2SRMYpKDO1j4JmiQiK5J0V5aZ9zBqv0jNIlyi+bPu2?=
 =?us-ascii?Q?msinGuVy6WXIe+dGZTAnj5x/dPIoKk54tMt3F0MI0DkD4HBNDWwQgGcB+fE+?=
 =?us-ascii?Q?raJwega0rejKqZzMsR1JTn4xNTlt1a6CxcjBywMImlGHZNAPrpjsu2MW3uTo?=
 =?us-ascii?Q?1t5E5bmvGLbNlQpAApBRJyb8Hn8JSLP+Yxj6kCyJr42bDoZ12s0NiYN54eWg?=
 =?us-ascii?Q?eGlyms/pLH85WSMoGYJPj2vSSHrtIX9SFC7kekdTxhmUXBtH2C6Oihpcd5RF?=
 =?us-ascii?Q?u3fCFN6LnSkYWP1Rt+9pacBYEuUQjgZ83pthZPKeoyfD1DF8jRTZ79ZvnqQS?=
 =?us-ascii?Q?oojNjvvNxZsNyDcKDMDP2cHqW/uCSPIU3o3Yy5Kg2xdohbB2ZXUeS3VGiFC4?=
 =?us-ascii?Q?xXw0K65suCG7FirY20dpb7qsF391K/GyUYV9MwCSdla8Q/LtJRfWSogER98h?=
 =?us-ascii?Q?dR77zhRJcXzl2AP2ZgUr/IgEWyqYS8Cq+kRCVquHcBFQ3OHhZxWNRA9iy6SW?=
 =?us-ascii?Q?tp4cbiismIGejc5An5nArBmVNUaycN8NB/pYL63LuDB2W15p1RJGc6RZiNKJ?=
 =?us-ascii?Q?3FgIN2lH2urKeCmgVnCyu7KGNIpgfXgurrQshMPLy+F0xfdTeQ5GcTs9xP1g?=
 =?us-ascii?Q?B/23P66FI30h+SFTdLaiZDS7vQ5A880o/MZ7eyF6v5bAWnMCempn/G+vF8H1?=
 =?us-ascii?Q?mmIRbycLIVSrDo1iyrbSSIJDduobea3HVMC6a/teWuQemU2vYGDV+gMZENja?=
 =?us-ascii?Q?RQPWTeqaSeHzl9X9okaZy4Nb211HCzRMd1JgeVTL5R9ysDXY03K6XcrmnTBL?=
 =?us-ascii?Q?ny3VZ7kT694sclwNmypciiqA5SpWwZGPKzxW7fpNqonkvFNc4DS/nYw09H+d?=
 =?us-ascii?Q?aCCoJCfXkbvc241jvCNBtAwbTpKr+nFFeEv58c7Fl70O0TG14ABdxs+3V2JA?=
 =?us-ascii?Q?IQYMoL3P/ciXyYEfeekgoPwOZrbP2KNdqNq1YZNAGzObHtp3iawotpcEfkP3?=
 =?us-ascii?Q?6qzqTDWrUFNhe4+yoAQGis3KrdYV53VyHb8//mvzlyrqmaFqzbrVgTwdPM9y?=
 =?us-ascii?Q?doWY3yAmNVBVHLXPGni4DFBDPFYZVdjt8yXrCnHg3arK20PPdj8Yx3Ssb4/E?=
 =?us-ascii?Q?+8ixq/ryvv0VccQYkhf7vF5NcRjvcg2Qg6ujWQWOL19okLZWGdAncme/1VyY?=
 =?us-ascii?Q?11UCrf0VHc8u6DQ/iva5LC1Cduxb6K9A64G8L5vGyXl76ys3Z3StQYFfRCGu?=
 =?us-ascii?Q?C2gPESHrHmLxesVdls/FrpgL1TUH6gKVyGNNlbDh4X1uYH/kGK77j4fbWqXG?=
 =?us-ascii?Q?ipk/EJjEeNsy9NXnwLaQmqV+ZkoNf02dowtLYL0Qjpe/ORFTkxIJgRO7R1MT?=
 =?us-ascii?Q?zHlathgayQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dd107e-9014-48fd-155b-08de79125f50
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:48:15.2873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLofuDJIpMz8AMKmoKGVNUZUIGp8R0HMjSIe66FbdyS7A6OcTu580z93jsNCj9K8JGGkzk+EivONE48Mt/YGcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11926

From: Luke Wang <ziniu.wang_1@nxp.com>

Add sdhci_get_property() call to parse common SDHCI DT properties,
including "bus-width = <1>" which sets SDHCI_QUIRK_FORCE_1_BIT_DATA
quirk for 1-bit data bus width configuration.

Remove the duplicate "no-1-8-v" property parsing since
sdhci_get_property() already handles it.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 97461e20425d..b607d4ffc562 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1813,8 +1813,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	of_property_read_u32(np, "fsl,strobe-dll-delay-target",
 				&boarddata->strobe_dll_delay_target);
-	if (of_property_read_bool(np, "no-1-8-v"))
-		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
@@ -1833,6 +1831,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	sdhci_get_property(pdev);
+
 	/* HS400/HS400ES require 8 bit bus */
 	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
 		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
-- 
2.34.1

