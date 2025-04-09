Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42F25A63D;
	Wed,  9 Apr 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185311; cv=fail; b=QkEzooIFqa1lJahyWpo251tvFKl1OpLRIlc/akFzljn/sbFfIaPXMUm3fHUTu+/9Z1w5rWJg1V+ATr73a/CF3hiVrWIp5BB7yMRu2NpWUv0jdbIrSsL95z01tardp9u5ff0rjbZ+mfvWqXnfaiUIMlt9xG7I4nhKa6vWpxjCvJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185311; c=relaxed/simple;
	bh=cAfd8JBNzmKld7OUER2yu5Mxji7k/E+tLK2kyL4e5Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J97sp+w1cLBTURj28pcBaCUM63WN9vH2aFFFAGHlwCrQ+Do5jBSOfm5kpCeZUOthHE/YafnxCbixtQt/+H7yCTnYXDcrXqZf6l0Hl/hpGOb9OAfsms2r9cC7JyHjRLwNlz7PupE3qbfgMeMoiUu+947xRIDxUWqQJnA+fF8HvoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gDegZdMu; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gDegZdMu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNU5+R0TiD4cNIKwu665p39PKsWRAmoW2uQ0qXH1REhi6JYA3zi0tBEf+/rF6BIm8whhthfn8nUd+RvW+PqyoW1R4ST3YozfPTHegcFAp1FVfv3v2EJ628e6SwF+VJMaZRE7FmTabjhSfTyuPvMduxIWUQD7Ank2axsTCiiGK73EQE83TX4mJjF9LC8/8PMvrh+lM7jr/iHvkgG2SotLxPI/JLyCummhwbSwupf/2L+cbeoibxwgOkGMG1JdvchReFZ4Tnj4yCNxpqoCh+GJNo8HCufhWglQ6X0NQYGstQHhM3Lh6lz6HJzQmfirM97Qt4jVd0Ri2hST8LEkvwOz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Egcqn3YDcBoWLwMh59+444cmY20yYat5sZ8U4upwg4A=;
 b=CzFBmViMRDk4MDO10xaCJ7N1pvLFkUO7+9k7HU4xQ0R0fWmUAPxBqkYJRmwcH4W8cxFJ0qeChVziZ8NbDkfaeJtqBzZMSQMKhseVCYRPnvvN9EZjQ16A4SUpPQc1hBOGoFHpn5pAolnUxbwOST4hJaIlWGRBZW6zXQ40UMjcXm0vsugqs5vt3moe18Y6VVpMJvDvG1c3Q0f9LMUiBSCsHpwZmoFrHPmVEFmiQRRS1a07HPAXC1A1C6BSY+wJth1GP95fMfMBHouc4Y+YsHxb4Sg1+WFTDBQ7t3GpjxFCQhN56V+RcBH3DZjVV9NhxO4ZQ5FLQqanD1HFem7FP0Cvnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egcqn3YDcBoWLwMh59+444cmY20yYat5sZ8U4upwg4A=;
 b=gDegZdMugzbDC1ZjBc/PVSI91e+XHy/+EtV8Ai744KHPxqa6fd9/Z496ulo09jk8d6u2vb2ERbnYp5QLQVBc4hN7WhIxFQNmakVDO7MWL4RRb90SO5VxjMaNMsqVkRVM7Kr6YwMQF7VuzvCo8BThMTPpHrmkDM5DN+UFNlelH+f+4lu8GAeBoUCnpWFmGMVlOURfnosA41FZoshSmbysgRehhCs5ZJAFoRZRoU9DG4H5M/0as5UsELdyRBaylIv1QC7XI0Vu1mhp8tHubKcHrixykSe8azngNob+ZnQO8JQDdbixMBg48O+zFpm3pLB6pKI2riZvzf904+1DinVSEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM9PR04MB8196.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 07:55:05 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:55:05 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] mmc: sdhci-esdhc-imx: verify tuning control status after configuration
Date: Wed,  9 Apr 2025 15:55:49 +0800
Message-Id: <20250409075550.3413032-6-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM9PR04MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: adafa683-638b-47a0-80ff-08dd773bd751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cq3d7c6LHD6wNcd7WJYHUiWfhtzZv6WlRbfSBQvuE4ipe5VuRyCy13ArqbWo?=
 =?us-ascii?Q?rIX4944x4v/zbqCdEiG9OdWP2ZBfFUoI2MI8dNAO7BenVuzD34dHvMDTMdn2?=
 =?us-ascii?Q?9sdnxiBBQSmBOlkWApAp4jvMmXC8NDcgoPM4oiLVWgPGXrGvhkPwVcAiE40O?=
 =?us-ascii?Q?QXuDFwyMXDulSLe0gk5ulGWL26JwV8wz5cDbDc2a2GnVRyDJuoao78tVLGyx?=
 =?us-ascii?Q?fSGzBuT4yeP3UcHIev1OKlwKF2RwhPb6w0OmahsUo/FharryV7DnbfRJrUXu?=
 =?us-ascii?Q?apwBnDaEEygcQMgDrC8iY88SsUvVsBtq1d7PHvZEk1gNZ7+278NVLLnA7L5S?=
 =?us-ascii?Q?pa/D9oPPa5CAvoJ310MSHen67xZzQHHY6yTzlkiVYb95amnYArdAOfZ8UVFn?=
 =?us-ascii?Q?h63A/9GJuvsqXWjlrKaLIpciasyCoq7DV7FvXTFj7XUErm52QGW2zMogpkWz?=
 =?us-ascii?Q?pUNDoHFeNqSW0RzQs9o/jXhJ2QrNfEBJ7mV/UCyWmZAXtMtrpJjPS167UfMf?=
 =?us-ascii?Q?8rWoXaKR53ZqcQDFdYaNRmIBdFPf/TFxJTWs64qly7x99HOfQahiIAyxgJyW?=
 =?us-ascii?Q?11HDJhHv23+b7A6LH5LQHSl+AH5n5VhVG6hCX5IyyAbGZUtQv5Ncl5zPn4jA?=
 =?us-ascii?Q?SvL+OenIPfF2rkI+qaTaROtxUh0kDVIw5baV+rHYj5aYCme562LF91u7Y/8j?=
 =?us-ascii?Q?bDkF8Hd2Qnz+HFsN4aQp+Fop+InGrbuWWYPesLSgf7u0lSKum/EAF1QL4fTq?=
 =?us-ascii?Q?Fhdjd91k6iWQ0s+Y8j42efCBofN5djygc9HmX6+XOlLKPEDxIixXQswgox1p?=
 =?us-ascii?Q?z0wsYAfkLXIM22Grp1OeFEPtNrq3VBePlFfP88uk5J6CEpHdhcutRrIb+Ybx?=
 =?us-ascii?Q?1fJAJ6LqNmVMocTvdrygg3vGteqH6FYHcuWgr+xvB1zMX+HnQm0DFZTPrgF7?=
 =?us-ascii?Q?/MRODpOti/1PGpAf71+2mb67fGmQwF+wt1/y4KHJ7G+LOTx5FtGbWAssepy6?=
 =?us-ascii?Q?ZGmghRfmoJDxYRunGmVoL2cUHh6dMSuSHFP5++mdpt1aCtXMIOU3/mZV9Xep?=
 =?us-ascii?Q?2TjYx3/wAD6ZZDzFTpl2JOPKFsRzHll7uanPazcCjwTdwwsaUMSON/x/qlDF?=
 =?us-ascii?Q?LjVjEja1awXD6VFEzVzJ31HbnYfh32wH5Fik75tKu0jrzVD1M7mHRA5zpmSw?=
 =?us-ascii?Q?DxhOjyRM/t8ik18qf9sNJR2UK7kSxpMAFE4dq2EaTBrhKjJ1tx6xb4ES+jSj?=
 =?us-ascii?Q?9I1lmuVEmAzbCkrGImxi5vrR5nqd7bZ5Pl91Dl9BUP4KxPGKQcZm5KCjGL7X?=
 =?us-ascii?Q?sSmNMwD86Vy+BAuEzBRlIVF0d0lPPAniWE3SBwGikvrI//LmL7/48wZr1g10?=
 =?us-ascii?Q?CZ9y/Pc5NO84tUUYFa7zhuEfzpxE8BTVfMnfsoX58GE+Og6diDuEEbJOKzSq?=
 =?us-ascii?Q?dMm7fXmW/meisR3pkGNeuzfMqe/XBgOj9LKJPKBiBe9zFtCu8N/pfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S+BQV5g/lSz8kDs3kHfXk97DlJIYNqcGMTj1qN6sg77tXvJMmOllBBDWQKwa?=
 =?us-ascii?Q?Sy0nZ09RTU3hM1v3BlSUFMdnMEnbGMByJS1WZpgMtevGh4xsMA/oqSySzafk?=
 =?us-ascii?Q?dKBioRAveOAGtan4uuQ5fsgQ2RpceXV1/6tNWgzh+VVEoGucAPIBzcc23jgK?=
 =?us-ascii?Q?2FbOApANO17qkKeg3wnB8c3it/ZpMuXqk5UN1rR75wJzk0hTdeiomAsQHzov?=
 =?us-ascii?Q?cFXbY+zaNvjCcbNVMImK3cj8D8+e1y34BWINba4A0iiNlCJXv0E8a9h4RTou?=
 =?us-ascii?Q?2FUeQI/AnybmPsLUrWPFdmu00QdE7XgserLMI511JmoAVY6qScHbn/o+rcsK?=
 =?us-ascii?Q?zuxLRT52VWe6u4Sf17e/1PWV+PG4DQ6oJDXYuHFwHOciTqnZoP4bwyV8jUhj?=
 =?us-ascii?Q?0OT+6IWvuemkgQSqo3lbo6g3bponewRg8tkOHs7udWIErPtnAmGmSbREuWPY?=
 =?us-ascii?Q?ejA4EzE5ie/uk2JxnTmJLlp+VwnYnSEEoDdRDSWy7g5Z4tDLeC4c/ZFMaiSb?=
 =?us-ascii?Q?c5RRoVf5gcP8H5jn6XAFl78xupx34lbHCQpKD5SExhVwM1UZ47gzH3YdfXdW?=
 =?us-ascii?Q?gKHVL5eKe1z4MQrLPAV7xhMKSQAbMYdkD1zpvnje6Bw3tFWX6UY1kX8aTfVE?=
 =?us-ascii?Q?HVNFx4W/3Zjs2kTe57id6a6GpeXQXeJ2OLjrIJbm+RR68g/lZQCWsvvx96r7?=
 =?us-ascii?Q?RLIyC5U9swWCLB7ZN30sOugD/vs1nufUvZ5pPRBhj9iMcEwrBA946BtoUtSE?=
 =?us-ascii?Q?jTadiu9Rs8AXWrkxHY4rDeUmLV/jQQysUc/QDmf2spSlRFvMaUZsxYB/izB8?=
 =?us-ascii?Q?G2pA+uV/hImmhKD1l9dof0Mh3B1jJwaOmCcm1WcaCPlpQYxCbBsyufbL7oEP?=
 =?us-ascii?Q?IgOoMVgRi3P+pVShFuEzbm25OQCMi8yJjLSSP/sq1RI1T5HTKkpdbA2MXsvD?=
 =?us-ascii?Q?zOuPpb4mAVZpZy1LXUn00sImxPh0Mez4dpv790c3RCJDtORQlQYe030YawTt?=
 =?us-ascii?Q?RlAwBerjuGDOcDLztKfihr6iTqvRMCYrRJMEhRXEe0sqrq03dsj8MTeLIl3H?=
 =?us-ascii?Q?Dv3GEOalRPuOWxzYLxfivzPKG4qmL0bj/5kTdm/bln+oSYRZ8ET/u43rxhxk?=
 =?us-ascii?Q?mvPmwSPZf5DQnkrMILAIGkJAmoKy6adg0Z3n2F6T/kG266nGmEZS5/Pd5u6T?=
 =?us-ascii?Q?6az6WmGic/W9TzziqdoITlqMIIRNGu0+Ga6FN9c/pVSXShczk5zvJxnh9vw+?=
 =?us-ascii?Q?KaXdbOXu4cYsWNLrw59BAvSKZFeXc6LQ/YsAcm3BjB39iT8xKurD2Y5AoUhW?=
 =?us-ascii?Q?2ZaDS1MgSc8AGW/3lGHIsAF7i1DkeZaJ8QJ45cwfyMEZkA9y42jzVBPH5Dc7?=
 =?us-ascii?Q?QsDXvbNCnnQX4RWIDjC7rQ2zwI6yE92vjWNDmnBNeV2Eh4VM9XKf1Gj+DZ9D?=
 =?us-ascii?Q?VP1CpRPJsfcpF53OwHFpLNmA6SdekJD7LYstmcWBG0LoVRb+IYA6CjRucyDh?=
 =?us-ascii?Q?1zioaB5J9ItyPESmbDsd7d/KCPdeHV2Efl9IA28eqOfdR9pM4UYHymJ69zEI?=
 =?us-ascii?Q?0Hav4dwH/SXDzrFx3klJaf/jKYjdgseAWkgSzEwf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adafa683-638b-47a0-80ff-08dd773bd751
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:55:05.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cR3svbwyw6IJjz408GQIEvPZHKHiw+Kxz8GiPF7OL9Q6cN5MlUBQVapgDbrDBrEsz9lCAU0Ng/gwl8UNs5Ayvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8196

From: Luke Wang <ziniu.wang_1@nxp.com>

Enhance manual tuning configuration reliability by adding tuning control
status checks per the i.MX Reference Manual recommendations.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 46da155fe582..fd0ad0ad1519 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -83,6 +83,7 @@
 #define  ESDHC_TUNE_CTRL_STEP		1
 #define  ESDHC_TUNE_CTRL_MIN		0
 #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
+#define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_MASK		GENMASK(30, 16)
 #define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK	GENMASK(30, 24)
 #define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK	GENMASK(14, 8)
 #define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_OUT_MASK	GENMASK(7, 4)
@@ -1208,7 +1209,7 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 {
 	int min, max, avg, ret;
 	int win_length, target_min, target_max, target_win_length;
-	u32 clk_tune_ctrl_status;
+	u32 clk_tune_ctrl_status, temp;
 
 	min = ESDHC_TUNE_CTRL_MIN;
 	max = ESDHC_TUNE_CTRL_MIN;
@@ -1264,6 +1265,13 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 					  ESDHC_AUTO_TUNING_WINDOW);
 
 	writel(clk_tune_ctrl_status, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_TUNE_CTRL_STATUS, temp,
+				 clk_tune_ctrl_status ==
+				 FIELD_GET(ESDHC_TUNE_CTRL_STATUS_TAP_SEL_MASK, temp),
+				 1, 10);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc),
+			 "clock tuning control status not set in 10us\n");
 
 	ret = mmc_send_tuning(host->mmc, opcode, NULL);
 	esdhc_post_tuning(host);
-- 
2.34.1

