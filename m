Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012031.outbound.protection.outlook.com [52.101.66.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0027B10A3E;
	Mon, 23 Sep 2024 06:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727071914; cv=fail; b=CpVoCLdxbPYWPbOlgaKQ8eiGZ2R5I3KS91esnbIkDL6bzDVeLgD+8e6APoaA6DxP3qkwBc2QdAxPB/mZTzj55GWbZt463gyiDx5l8te+M9pkYKVWYuLoPIRADVLHk4wlOyeingVJHzjxnP7BBXlq7F/3UQYlUpDBArlYl0uMbX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727071914; c=relaxed/simple;
	bh=PKI7ibo8yBPnYxckYD9x0nmFMPr2bBJPt4MBfIZzoMk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=crkKCpFScaNqRsRzEfIWIxSStab/85J0Z1qfHy+ZZ3ez1E2PM/Imq1acAWT5HDh8LYN7xITaxLNBk1S8LEqPgmJuCybqmPHP8JzMQg0INgG26j9XRTZr025BxfHtbj8tiEXJDOKf9Uw7MvXvouB9tsOxMT8eGOq7Mx2oGOW1ju4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bGpmQiD7; arc=fail smtp.client-ip=52.101.66.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bGpmQiD7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8/cda7cI2UJzYeEQ8zy+kbekA3cM0gLWYSKdYaCUPRVP71QIRxX/GHXVzQI+a7DeU0Dqg4EHzV1zrggGFZPavLOSYC0JfiJYSOPJGR1o4dcRAMPUQ1+fZzkbCfbnkT+Q1O+mixhMLXaY22s2tsVWnLe1tAr/w1XMvx6oPJXqca7LDFaMrjwBDFBAY2j9IhLxwd3ys4h0Sg9nhOJtMm+X/1RBIFMxp+L7lpKSiLglNAPlZPOwiEVDQGBDTofe5sksHq0WwfUUCCytILPoWKbtTCPw3kfUY3Zk3FClPcOJ7ILRK+J2LqeLC+ZgOf66di9T7mgQz6V7PMS0kIkqB7Lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvyCXaFoyUcBzS6NaTWBH/VFni5UaYSODHpmTgggnLY=;
 b=peuhNapunp3J7NpMP/d+UojZXchnEOFoQX7G8J8IBMNB5EliNFNaZIzcbHFBEPVg3Dt8qMNya3oYPeLXZ4xHJXEZ3qXK3s5ea4mkHkewTNOlwNl5+k6iezT8LyV8nB+6vdrsp+6ksbg1bF6JgffuniVSLY2Y5IFiYOGCH33IUjZKuJbrx1+Poant98KbZ1AYog9rLITipwiMiAqB5C2/LO5Rxmd3lQoqIubO6HJj1Dnk6BhVRdFE+XfHIzFVznDG37SJdmwXU2o2ptHZZX9wE1MbH4NDXcWNv/puevGWQpm/ladY6xPz1mI5ZHJlc0Ot4WLkJx6HzoKQBwKxya2MQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvyCXaFoyUcBzS6NaTWBH/VFni5UaYSODHpmTgggnLY=;
 b=bGpmQiD7Z7G1ShBhivirWC6HBUbNKaMGlVMIv9fOsL6aJXCk4f8HIZ8aQEVjvGCgJsP1wa+UiQfllYUR18vDKIVTe0wAfcZmj94bkIQEaKRgPhTYyGlvf6pG7KMpCF6Kf5auKb3AlWwvZ2rBCuYLEdQOumTd6q8s+T0klDT+LXfJbOyjodvbXeraYhhRYa6DNiI9XVOrh+smsyX24oEX8OAFbFBrY42v8ztoameIX1h/0z/OzrkurxMgHni/uwoYjFE99Lir65s72JBgrBECWutuMW64hPq8t3CWRhLZZbuuh4tVA1SzRUiwyrYm/7Up8DiMGO9zFAEuqTi2Sa1SCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7196.eurprd04.prod.outlook.com (2603:10a6:10:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 06:11:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 06:11:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: haibo.chen@nxp.com,
	adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: enable quirks SDHCI_QUIRK_NO_LED
Date: Mon, 23 Sep 2024 14:20:16 +0800
Message-Id: <20240923062016.1165868-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df71e8d-327f-4519-3fbf-08dcdb969b57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cW4zu2MFj8vssADyFm9pyAE5cwwQsbs/anFNW1xToAayhEvtlCvq9HDwAryE?=
 =?us-ascii?Q?osgsjyObSjuWN7m5p/P5IiTWUMupGL7eTWTQ0poW0gGJpq1rs1j8AXMKsNNk?=
 =?us-ascii?Q?ieRCjmqB5U7FjFpn7soARO78Vghrog7I+hnodpubHOSS3kQHHztmcBhmWwXh?=
 =?us-ascii?Q?mwsCtv89+yTfUBy8ILRa6H0oerZobc3rJVbg97V3WMOFt4Qh2CvdmUa4Ai6w?=
 =?us-ascii?Q?ywOwf8BWWJHLjmrZ45cZP9EiUBBQ2M33QmsOwZYs9PsEmLWHLZPOTLQUaFWI?=
 =?us-ascii?Q?Hmi7GVCwnAzJjsOLAXsi+cCpnKmas2Fl86WzOTUImiSmlmEz0ZCInqzExiRz?=
 =?us-ascii?Q?VJlmbHORm0i96bvP2UyMHr3Z16i1F5Z5l/VXjpUK6x2enW7t+HKP7bOTOO0F?=
 =?us-ascii?Q?mAfWSMHiOMCxmGolDXilLM0ZRKi6Ok7ZQ88cZ0GTdNop/w+0OgU6oLaFDEwu?=
 =?us-ascii?Q?ZbasIe/QoarSG3EVlhIKWzyDSi+MHC76uIsq5yCeepB51eLgmUcmXi8K7rJz?=
 =?us-ascii?Q?VD/+JsNh9dUMVOZg9NbqgMmn5tgUpyYiyczQOHi4Rdc+x9zn/ate/vwenVo0?=
 =?us-ascii?Q?GAfuCwR7bhpkQpGOk5u7HI+1ddrH/lMIQNFZq4O0zcaAl5Z92W+2ZoR5PUT7?=
 =?us-ascii?Q?23/Fh3WYI72H8ComjvjkJmO0ZY7S8FuZPxnyQKuS5TGKoc0/WTNlh3BeeL+r?=
 =?us-ascii?Q?MLqYLjtHyiRr1/oRlfgXibpOonOhJP0zIArgg1GIbhN4zhkfkwCBgLP+DH4z?=
 =?us-ascii?Q?FhsFG948zIbTjxuTMiznZPhB48e6qNEO+SHx5rd8u717f5A0BzGe45tuoG1z?=
 =?us-ascii?Q?isbAWPUSIuwdrjs0OYYIimQPNOoJFu4RxfPZuusxCrCep3nPMs1C/fKORlu2?=
 =?us-ascii?Q?unJ6YiXKG3K2pkklDyUAHAvwy9zvgBxJ0D0Y0fA+cGO6lz0EjlTfpD2wI4nv?=
 =?us-ascii?Q?sm6WH7vASSs1xrnr0Oy/XZUr9XXHRcYs/OUGAK5/6XdnjSQuwgqLy4iu19FB?=
 =?us-ascii?Q?0wCFeODVLfNa8nQ3rQ88y+hgYAJGv5h6rsvytil2du7M9AIToWjVfcEx+Zl9?=
 =?us-ascii?Q?23u+xTM/WuzuyOQj28OS/2/0jNiODEvCdXc6wDIeIVfAJBbmwvzLj/+V/x7C?=
 =?us-ascii?Q?vOoTgi1WnMDf4HdOYHxspW8QCVbzNKTp5wWMF4kAnMN2UD5/t5IIoCepk4KR?=
 =?us-ascii?Q?eO0JtpQem6/96o0k3gbJQzLy5EXh+86kGZg239Gp4PbeDOYGnTqaV0IqgbFy?=
 =?us-ascii?Q?O9KXb4U+tPR+KoYapaCUehqt7Z7bAe1TZXWHN/NZanhrgfkKm/iuAnEfR3RE?=
 =?us-ascii?Q?3Pw97LWxLzahE9WUcTV8t5ChvwW7RQOBxdM/a/8RT6XvOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UlHouuCWyD8u53m78nd3qlpTwjJfduMAoRB+goBTKFxNyagOkLWip8ecvy60?=
 =?us-ascii?Q?KasL5cWZ4noVdHVnqUpgWm+59iijitkR/+t/V4iEYtMy16RaXhBLPd4xkuTk?=
 =?us-ascii?Q?KOg1R6rSMfz2uIXGt+XmHvS1x5/6H7ZwPsJ0xTyx4HQZFrCu8hjuwz835yfz?=
 =?us-ascii?Q?i9e7EXxmJc8/ykbPxso4+gCfY1EcX4AkWSJPYJuR6a5JIlebapzI4+tHK6tt?=
 =?us-ascii?Q?jzvGm5nLxbwGjmeEAiX+RFOPU0hjj3XxEE4NhM0blhuDpdcrZYiNhht/zSCh?=
 =?us-ascii?Q?+qOHwV6weZ9Sw0fMuW8bCDoSyb/f9vw84OAd9R9E36Zxr4ceCTKE4Bl0EkkX?=
 =?us-ascii?Q?WMW8JNeg2VNDvSF0uHTdSlIFng8R9OrSnxyGK7atlRmj562Gt+AcH+ETmrQH?=
 =?us-ascii?Q?EKTmn30M/2aaZLsWopKngI/m3o2a7dfYctg7TLHGT8wkr8B2FGCmPs/VDUt6?=
 =?us-ascii?Q?hqldfBofdjBZLEg5/5KqbryRon5Cgm1BaSyRRhfjs7+1XHd4i7qBxgh0jkk/?=
 =?us-ascii?Q?3r2DPHk/c1qiaH1F/hf0lJPCBG/d+Zq66SF/ChU1xaQvYQGo5DodK46z1+XK?=
 =?us-ascii?Q?xtFHZ4l93T7iZdmwG2qmSw86W8naknr51zofa0NBO/fx4tQpmBmQprf98yjg?=
 =?us-ascii?Q?iXTrVg0QPZF5tLqmJpmzcfURwedHCnGQG4ZRUHmjfE2yX3Z4DBat4B/o692R?=
 =?us-ascii?Q?68LYOpBtImsPkIV4hIg7KYjxiwK78JfMtFCXJNSD06kRfgVdPU1ODuu80Bv+?=
 =?us-ascii?Q?OxWU/W611miGbG56lTuUP7syz1KaY9TJoEJeIuczGytsiNa++qGVmDsbXBfW?=
 =?us-ascii?Q?qMMx+PLMZD7aeDC2Q0umux8cd3XHfXeKBf1CQBj2NbgkL9Tng3orFdSAQXdI?=
 =?us-ascii?Q?kPEC/H1rqRWsd+NibIuNgIoH/bGDucX2pfYx1Cw5uGOYXLjkJoiMu9G6LuYJ?=
 =?us-ascii?Q?weHPvaH40UYr+kd/n1v3JYdlTxjeQWWYb0BRfPQovyIW2iaBgz46wrVi0EJj?=
 =?us-ascii?Q?5y5qqHJtgiqgTX1WPMxmisMdbkatMnnGc3lSH4Sc9bcUy+F9ZiVOWfKFsigO?=
 =?us-ascii?Q?lHhunPmRxXPuNl1yPjrfwYuU9ytDNejmrLWDT0Q2VNRviFdkTjwQRG2qZ1i2?=
 =?us-ascii?Q?POLyUaGJzvP7g4rkBWJtYiOCxTXJtw1JnOXQMXfPUvrcCCpTFp1Zli12OvVP?=
 =?us-ascii?Q?FheWr2NfwJ2DoL9ItHSYwqBOqtk/faZgjWPUggXdhPow/M4La/z8xqBK8NDO?=
 =?us-ascii?Q?+kcUN2uc3AGHZeZIVyNn5VlktC5CkYss+/M8rNCOXgd2ngH5Ecih4+8ALsAm?=
 =?us-ascii?Q?CrakEebaj5FrLuISOyLWU1NFQp6PHMpuey88rpWaQoOmDsHHUR5FYxt6Zytp?=
 =?us-ascii?Q?DPU9IPyPSDI2rCXv3f5Mxp/Fcpw0bPwuClL+Wd7CbnNdTzwkzNd5aM6jZ6hA?=
 =?us-ascii?Q?8MhMy6ZY82nTqmkFFI9dLaslUZjGlLRbJEdAsTOnAUfoAcWDYQEXRgKB0a8P?=
 =?us-ascii?Q?/Du00TC+GexxIeBkVX+EG+E2b4NvEgjB5ukttGl+0DyV49xXB40O/f/9Ipi5?=
 =?us-ascii?Q?rosAtoJoCABegdgelrsB+riTFF44E2QEnboEplrw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df71e8d-327f-4519-3fbf-08dcdb969b57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 06:11:48.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCxlGgiwDdm4sBviPBjztGAcKGBdGHsd90qJ04dyclZZZ38hC0uOp1g5zo3hMuPLjqsOGonn64KQpPqiulP9gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7196

From: Peng Fan <peng.fan@nxp.com>

Enable SDHCI_QUIRK_NO_LED for i.MX7ULP, i.MX8MM, i.MX8QXP and
i.MXRT1050. Even there is LCTL register bit, there is no IOMUX PAD
for it. So there is no sense to enable LED for SDHCI for these SoCs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0..ef3a44f2dff1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -238,6 +238,7 @@ struct esdhc_platform_data {
 
 struct esdhc_soc_data {
 	u32 flags;
+	u32 quirks;
 };
 
 static const struct esdhc_soc_data esdhc_imx25_data = {
@@ -309,10 +310,12 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 static struct esdhc_soc_data usdhc_imxrt1050_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx8qxp_data = {
@@ -321,6 +324,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
 			| ESDHC_FLAG_CLK_RATE_LOST_IN_PM_RUNTIME,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx8mm_data = {
@@ -328,6 +332,7 @@ static struct esdhc_soc_data usdhc_imx8mm_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 struct pltfm_imx_data {
@@ -1687,6 +1692,7 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	imx_data->socdata = device_get_match_data(&pdev->dev);
 
+	host->quirks |= imx_data->socdata->quirks;
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_add_request(&imx_data->pm_qos_req, 0);
 
-- 
2.37.1

