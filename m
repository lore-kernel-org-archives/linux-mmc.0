Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679503C09F8;
	Wed, 15 Jul 2026 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099778; cv=fail; b=WmFSNudOwz6bJ1XjhWYRyBMUtyc3u07Y1vGr7hG/jCkdjC2PJyY3nMWiUuVo2I7Q9IwtzoJyyWZjQLTr8M/HHHBOP8wTmcoXEM8MN27/7rpi99T1iFyi2iyr11QnGM35fJT46zGsgdPq5/jo+xCnLLR2cs4NDVyu+LXrFNBVSQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099778; c=relaxed/simple;
	bh=9G2dR5Rhvrg+LyAi0w307qUCYYn48ap57dmsC0CquHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZxanIZN1edXNzDdiGfx4Ss5zsQIICQuOWSy7QGLmoGgoU/x+8Nbiw05xbRr7gGPQKA9+pJ/ISKYSc3zenVE8ik4BlldT9C02Jcy6VTUxj4iccHnyLIfsbGAa93eTCm51rFN7KTyYTMBRbFeM4/uFtezX4uAnu1eCkI8Kn11p58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RZYcQI1f; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RZYcQI1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRK/txmYpBfgAaXKJHSrVeNhsVeV0ZBM28NlUZclAPLZF8o4arMhrp4IzvFhGIZXoDF78SDPqgfql+4nqBbyJ07NmziVaB2ADH1v4BP5XJk+ngeYMWz5wZAba1Bnzjre8sqG0Rwetm1D5MU/M+6f8svMfa4cyXSoxZ3vKmPkykK6ICTiATZD59G2pfsCCEEKRtLH8HxZX05wBebNotAkEAlp/lMQw/Jg9Pn9futl0dRn5mRyx/iYAigCJ+1jc+NPxOFXiczDF2Qw9HbPt+pWZ/0Q8TCioM7M8n0mcvBIjjBlXtjhx/QCI3pYwkTNndRj28DsnUyrae950M7PefljyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2ZVtpyQJqSMsEQCYYjbkqM6BWerARy+lRcqKZjJ3Vo=;
 b=pQC0z5W3Cpl7DrBPc+EjcSahUAQRQMwXiQmv9Dvbix0yIMB25E76PdkBn8EtrwD2hHXjNept7lTns/BetSrUnNenqUobTGdK7Ofx9+93BNbTcjXznoCy5QP0rbnojNWHXG7mAmHea0JNE2WoUzM8D0JkgMHw3L3HX7+RLVjCFPAc21/cEl177BHfLbuH7ZxEKOK/uPBru9jhbsVgIqXMeCeacNRch4MuU9a7RTVFeNGa7JCUH9wJz8HCYKUUO/HO/vDzufP8Xtwlslr8xTU1gFULUfiYxP/KNA5z2esJ4ySqE5gHI8Ua2nruDldhdqvCdZoRicoj/RujaE1X8Nqw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2ZVtpyQJqSMsEQCYYjbkqM6BWerARy+lRcqKZjJ3Vo=;
 b=RZYcQI1fuEuVmjyiOzrR46xM49aXmzpnIs9JWOmJ7GYzWeY/y1W9fnJh8H2By0QF9/yFhB516H2OB6s8OlITWSd12Gl1eNTiZtm0eY6S6r5DesG9Peu+lrMe9rAUCyB897B9kVtHNVkw6qz4i1E39PpFw2Ft+jFr4xzgnnBMQkuQ7tHJ+f/IRuzXXSzEC8GHdQDljdcpHyZjtIYZuk+SjI2aNdghJ0d7AF1kFSaPFrtK3UPiPoGtO6HgH49lImgRxwLDKiABN/tpA4jLfh/kn6TmsPkZnDyA1KtB8gfKpcKQ1oz0wspLYI4QQI8Qz244OzsYHByCe0x2j2ASoKXLHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:16:11 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb%5]) with mapi id 15.21.0181.016; Wed, 15 Jul 2026
 07:16:11 +0000
From: ziniu.wang_1@oss.nxp.com
To: adrian.hunter@intel.com,
	ulfh@kernel.org,
	haibo.chen@nxp.com,
	Frank.Li@nxp.com
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/8] mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default state restore
Date: Wed, 15 Jul 2026 15:18:13 +0800
Message-Id: <20260715071818.272318-4-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1483ca36-c72a-40c9-6199-08dee240f2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WoyZmljFjTI9MdlxzIjDfhktA8l3t/70yXnEz9eFq23niqXB2sNSlXvOEws0I1gFZ3pXe1LqBMt7cnKvsMeyjadDAVtjlrBlVO5wbCOHHPKHkRYbgEQpmy3lYkfG5mvNEc5qc4m8TfmyHV166JGOehJHfWs8WsCD2+CnIrJbJUYMUJcrLAiqhUcVGbF/H0ARIHiFRtmZQEFBUEOYsoggtFG/fAJ/W/1laH0KlGxsjcrXR15RJBLf+pmYEPlNQw9UEomQWO8OKtzDKONw0nZJqdxMvOEbOkmBi2mbL/FlYJ9YnZBOYNVEtjIdI9ZHchwDa/W/qRdzCZ8C8LvPYswr0wFJGgZ8sVEqegJZvtigTmJS9qBvKJP9WDLGkdEpHG1LLGNrzwGrlQ+cQjdTY2pBrE8xXuMfVyU/8eDmHhqZDSw6dHO50gZ2XXm8WM7R8FAhZiYZojy9pL+6dit0S/U1RDoKRiPVcCvY2DiUe0syKAWXdWmih4rzXkzeXPnNo7C7r1YfXAJYvPaGuAcTVbNfKqHcICwz2DdrAGK/knyoeExn8q1V+FIiBRSJ0thRYqdTz1526ec9V4jpJShDAB9TMW6adOURqDnPg+kgtqVMz95SQ97h/oWE7BwDoxK45NtNmzxLDm6T3O4+2NIlBICZpj1GTHn/jwpNCTCjSgQCqfI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqQn+LM0iYVzeVVaIJVsvysxrc22IHf+G5tteaLnYuBZ2ZSWgHw2sdXNb0t+?=
 =?us-ascii?Q?tgB/7RQS1GYJ2ciKLMICwoxiECQEVde2dZwUKkys0lrk3/zpCXzPC0Yi0d0y?=
 =?us-ascii?Q?HmhL/X+Lv40mC2uD8hFPLx/JBmG/YuUqXvfSUItIGXTiFVZYOcNB+wXLtn+l?=
 =?us-ascii?Q?mEdPiGE3Tb2tbs8p3dF9vLXO+rNcaT6e/Pz+hiy+xTFQHAB6O9vqiWjJUgDo?=
 =?us-ascii?Q?qlQDWdqMBs/dQg8LPOer2CUduARwJd7Z4/GyTH+8DU8YBI6YZfRf+sa4ICxn?=
 =?us-ascii?Q?oR1IDtifHJRpRv+PT257V95aHHUZ1M8JnhuCYGvZHO4nfFVqdWfczgG1HxJD?=
 =?us-ascii?Q?jMl4p6fImchtYEXuagBrYovF9Jf/QvThJSZtEAc9HivwidQ/qCvk8nslxdhT?=
 =?us-ascii?Q?XNT+wq9VLEfg3/08djfc3oy8EEZR/rfnwf4ChUyVzhXFhoE/8ILjZsjTJprM?=
 =?us-ascii?Q?N00xLj4N5E6tTgJwcqRmi6gUoo8jYX3q5ggXDq0J5Jt3wFKjgkfYB6bdlDcP?=
 =?us-ascii?Q?5LdKQB1cOrVkkEpJbo+2wEYeDJ0X6ZC/jZloNKusjdvMpvFWWsSP0E9wfiVA?=
 =?us-ascii?Q?27nUmYogWcq5g2GQ4zzDMDx07F7Dip30DDV17gEWh6XjPm7lsE4P/haDRwlA?=
 =?us-ascii?Q?VFttBlQO2xAKBDuwSoEkOkBrSGHwjmm81Qeq5bkhciaBH7hyPqt9puCXneQ8?=
 =?us-ascii?Q?J0JgJSbmHx32FrCrjMxlfDOmI/CtkDmGixpl9R5HzrkWaByXKfBjWcCjWyZj?=
 =?us-ascii?Q?oRapZdLi5oCBJhu9Aaijnifh9OSBQrn7o1rvtlxcUareBNuFcoMqcgYSEPE7?=
 =?us-ascii?Q?a0KE5K2mMZ9hJrgA9eB4R1zAXXaydi8A0FzmywpH/Cq6dfuGy/lUMyTpq0ta?=
 =?us-ascii?Q?l0QtHNoFlHRA2lY+83KRAUSfXhhTx082zRvQGs18yfUnLQ4a+fcK/ueumRxo?=
 =?us-ascii?Q?Y33Sdc6SH7GWDg7/RrCv+oh2auz20LrSDf4zpF1dZFxvCf23XgURq/W3Bbwo?=
 =?us-ascii?Q?fDYuLX1koEh/8+2L/+tnBGKY5jgL6MsfLU07sxkab4S03+v35jDTLsuojEVM?=
 =?us-ascii?Q?xI3Lxwoacw2stHhRMOG9je+JFaLLdMe06fmrOhKY4rrFJ2cEGn4NZmPP7diz?=
 =?us-ascii?Q?bX2kRi8i8HfYpreRXe3uBPqsLq3NxALcNUceSNh4OnyY8XHZR7ZkvSfNeUA5?=
 =?us-ascii?Q?RIuYLON+1q67UHp15RZVqU2+SWKHH0wO9drlQ4y69OwCCN45RNSLAZ1gxCiy?=
 =?us-ascii?Q?zXjlrRDBEQ917uG/tavKMX1YizmJW6mh9iYOcXkkC2MuprYMplD6b8xn8c5G?=
 =?us-ascii?Q?xX2U+oLWYGtN6twhEWvwD6ydvqQkKQjTlZUMqqIGbAwqVIk4sLnbosOt9Alu?=
 =?us-ascii?Q?FMms6ElFUvpbGhucIaE5EiB/+SAnWPspT1ZSgK4F0oafbT0bb3bbgszYORFu?=
 =?us-ascii?Q?+jMh7xSBNyAjOtN42nNTtfC0O1gt6Ut06XjlDW1YpGaC/pY2YtvxZMRgg+/v?=
 =?us-ascii?Q?BMLhWyXoOa6kIDY59nEUxGbxnkBqin4LGbxgfnsydFmeRMv2u+pF+35tuLA9?=
 =?us-ascii?Q?KXQT1TYjT6xcYdtXfW7YhjxtxgVRqojGMq4cqTrEeJ/XW+QrN49TbgMouPX5?=
 =?us-ascii?Q?cHrYzDPvCuYYSLkBLCsuUmaYLpshuGgpvGQeR0cm3Oe2fhxdXODvkziwxZTh?=
 =?us-ascii?Q?oAJKE4+9sqRPyyaCxhxhmXdDfkCXrNrq2bsUhlk8RK5jSPt7uEboXMYQxwm4?=
 =?us-ascii?Q?pmF7yPQutjDqRctbRURYOvuYLYncMij4MzMOB6IF2zYdw7UhiQos?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1483ca36-c72a-40c9-6199-08dee240f2f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:16:11.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pm88YXHakxNCDQDoQA1jN/u6ej1Wq2bFnA65bIbDDUviZp8OW0IbgRqhjvfOpNl/Qq5YkNi/+Tqv2CoLp1+iSDy9vGfoSAMXF5S+/2P+sQgWNcxmYd+7jUKddn4u4Oyf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

From: Luke Wang <ziniu.wang_1@nxp.com>

esdhc_change_pinstate() checks for pins_100mhz and pins_200mhz at the
top of the function and returns -EINVAL if either is not defined. This
prevents the default case from ever being reached, which means devices
with a sleep pinctrl state but without high-speed pin states (100mhz/
200mhz) can never restore their default pin configuration.

Move the IS_ERR checks for pins_100mhz and pins_200mhz into their
respective switch cases.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7230d70e02ae..ead4685d621a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1326,19 +1326,21 @@ static int esdhc_change_pinstate(struct sdhci_host *host,
 
 	dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
 
-	if (IS_ERR(imx_data->pinctrl) ||
-		IS_ERR(imx_data->pins_100mhz) ||
-		IS_ERR(imx_data->pins_200mhz))
+	if (IS_ERR(imx_data->pinctrl))
 		return -EINVAL;
 
 	switch (uhs) {
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_DDR50:
+		if (IS_ERR(imx_data->pins_100mhz))
+			return -EINVAL;
 		pinctrl = imx_data->pins_100mhz;
 		break;
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
 	case MMC_TIMING_MMC_HS400:
+		if (IS_ERR(imx_data->pins_200mhz))
+			return -EINVAL;
 		pinctrl = imx_data->pins_200mhz;
 		break;
 	default:
-- 
2.34.1

