Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F53F5BDE;
	Tue,  7 Jul 2026 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422048; cv=fail; b=YRbduyAT5PwyCd7n9aQlBu4YXCDSlNneDFF5ge/LZNu2quxJYQ3HzgQmIi9MzgQohLx8DpiuNqXGD47KTJ2RFxBCofo+IC6BVPpAT8krxjWvZX+rjeTIrAQhKu+N4GYxiCqrg6GPgQRtsgyMGsQQnWzUEChLqxBETPg3N0+5FZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422048; c=relaxed/simple;
	bh=TumYMlT6WgIVsx1M0fRcUxD9F2gDaVwIZtm81XMuhn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGGOKMp/Vs+v2AoDxebcS9LVtMCpfTWxBV5y3D8AlXmtWmLHXH+QmqVngMofNsE2410580M/xfvPG8hs5WytQPuGAuKc2rseTOvy8eaWH44oiTKrNCkutkN9OZMMzdh/20/WAlUs+SZC7ACK1yaQSbjCwv+unxADrw9AwL0x2Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o1VFdgyG; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o1VFdgyG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GsBhxdJNFmtb+Lddylctu1xGaPYEqmfK85WAr6fluJ0dd9ToLa+WpYmCh73OV/onMDdcza3QihxG3uE61xa5v+S2yeJlbH74cT7ZqcfPV9G2L3oLXHvS34pMnVFcgVY9w73x6d+8jlLLbzMYf3d7wQryI/NVKxU56Tbr6r0cqPtRCu45BKddz5zYak1P/MxklJc1jcEzXHxyOAIdJuXI5+w7LqNhWRMRkRrx+eG4Nex2e4t6oxBKq1ha3jqzLZafLhe7LgMSL9t/+7KcG39rGy690oUX3ccpU7/j8rZ1/ikhvMVWt3C48Wyl9ltp5lfrSep83/EuMa9Yx2qvAtfYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55+YzZLEUnFYJEqI59kTtYuhrT3z6KAxXnGYyybTfdA=;
 b=nHg7d+TTm6QLHML5WwfFiYWecOruRKOUiioiQDDe0PrKrTMIE+B747n0qQeRw/piTe3PwuyK/UwYY+2HbRpdG8jHsFN+cf7kk+aKhAj4jwhb+bky0qNGhG8ciEDWcsFj+aG5RpDZtpfQqasvTD0LTGfsgZC3IVMVQznfoxAu5Pgf4PYox2z182aHKFWngSLJEzhyNI4VisIJ38Na69J1BwLDxLCQjBDHMDUBD7PVAIDdeWWHMkybZRIrks5/9UmENHdyNw84KqIGh7LFLP94eUZ89gQ0VONz4ionBHJNEVZSZZDry/0yy3ExqYBCy3D4enLgl5a6XKgkTBUOmcSSRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55+YzZLEUnFYJEqI59kTtYuhrT3z6KAxXnGYyybTfdA=;
 b=o1VFdgyGSHPoayjPh6jpYDtHmQa0RCpbKF7dGlGVyE2C5WsLc//8nVsnbv2lLn5olmK2HCKYfKhiRucX+LPD7xjj/z0zK1+PCOH+QirSB4z3+trBBuebzJIIr4kUq3YBqr95KixEg/mAgtm/orcf21Cb7z1/qr4fELPXSZuzetcHukz3jzkxr0F8Rmcs6ZAYyPqZ7r3owAiaISo/NY1iCp1GaOeCXZaLFa/cSJ0Rq1y7oJEVCXrtCELnRIZirR7X+FHNH0ZHY49RMpsTvn0E/prIMUAc7Hy0VPXqrEuMdnp7LMfn/V5qTz7xkzHpcoZbc52IHEPKSLxVLajBRtoKXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by PA1PR04MB10673.eurprd04.prod.outlook.com (2603:10a6:102:480::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:00:41 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:00:41 +0000
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
Subject: [PATCH v5 4/8] mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
Date: Tue,  7 Jul 2026 19:02:59 +0800
Message-Id: <20260707110303.3779799-5-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|PA1PR04MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: 03747e4d-8b27-4447-99bd-08dedc16fc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZeR8/CWThtqVp0U1R+aOaRV87aY3pUjrzaGZfkZW8rmBcOyJD0Yo+Z+V5KbA4KByRQ8ZNKUTX/sRU1u2H6L/fpnBxAaQpibBtZ0tIaQ3FU47sEFCM3u7ekhB23WeUsmfYlxGoL2R1QIf4uH1X1VNj4AIOY9bhSCNumVXjha1y2Gz+OYj4+jVwrNmVKjJu1aGRKb9lKJKTVXafFNyYg6LAa1ezLoOUT/xhum985zXz9xgyJ7TIer82J7ky2+K/pyoecBt17cyEcmfDI7YfRGQsHJ1KkJc03X0GcS98uf6Q2ZV3dxRytpEGOiHyxCmJGj0pFhHRYFBUkBOgwBf/k7LWyUdMclfjKkEf/fylm4jCJVy0AeFea0rJY8wplWO+YISOc31IYdtrfo74SIM/Ez64bIdtpR4ZejWy7wxzKtutWaMvN0+LHfrE8ypdHfgRa3dagUqwduWp3eRR+G4La2fCoaSIkspXJLXI3FkZpk00Y/o+E1hHLuMU0xYNQhIJmse9q71cPP3GmT79rNGiOcKKYG6pS7iQeoRwhXHhVE/LORNgt5l/qHBlBo1fdj70vBCXrtJaeJk50s00WyhYc9Oz2dSZfl/hss5ctOOCpaHg7/4lQ/Yb9p9B2Qh3Hyi/GLJzliGFWUCfr0zq4esj68EMFGGVs26K/IyrPt30gO5cn8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1A68LqrjmpA51eSOdB4nnKrFqXUp0/FvPWZIkHVsikrGXeUXaaDqKKyKqney?=
 =?us-ascii?Q?1UlcjdKDju6EzKJus8M3Kq8o9yGsRd/ZwT0ahVs7n/Fn1Z8OSVhyRZD58CdQ?=
 =?us-ascii?Q?DR1xuWQ2sO/ygJG1BL8RYG5yvy25uRnFeAvT8rYdTCgPbbgf8+TNVoQISi7c?=
 =?us-ascii?Q?nBzk1C+xCm0U9dSvaOKTM3z/iEKpk0UO11FYmDykEfxZQkR9kSC+Z22CZ4Rd?=
 =?us-ascii?Q?LwDswScApcw83CtWXwqDtTYxDyrIJZr2j5rYVtYvCW3ZahgxHSiu7cd7S4Ju?=
 =?us-ascii?Q?q8PzeKfrLER+Cft1pQT7kIKOCX5gDyzO4plI00fh9VKllZxQkM/ly3GVIZeT?=
 =?us-ascii?Q?YJUeoxOvNdNPbdv6LzMsSkLAaCEE8Gj/BFBrCXgnvx5UzOtYyGBLncXy6o3X?=
 =?us-ascii?Q?QcHapgh1gcHQnBrs6i8ApNHnMZyxvsQIMZZfPckInzM1JAPypI3pP+sVZ4eB?=
 =?us-ascii?Q?GMmg+dv+FNHWF0iuulxHJEIENs4PM7DQ2jp+Mt1klhh7Xy+NOpNLpZ2VU9Tl?=
 =?us-ascii?Q?oGWyzHfSUcg2NqeoltCaB0nMrzCNoLiKRab0fkxFM3lTgQ246+wfs4JUdfQr?=
 =?us-ascii?Q?TPXfND2Rox8E4zkHLOsmThjFtDgT6B1PoYnpXQBmYHe8Xkx2P/yynkwUcZFH?=
 =?us-ascii?Q?Oi06+ELOwlt5pmCFF1y/csMoY5cuSI0tPpQMbd8Rf3TOgMtu7gXvgcu/lp8m?=
 =?us-ascii?Q?6/aAdvD7vWCVGem8zb5KeggLYdrWIUhK1UGvXRLNKY4Ix1IZmq/co5ucnPhK?=
 =?us-ascii?Q?f3IDqdcNYCM0PJXvJbCvUUD4SrhVV8KzTNLfSK1zFMS9HkLN7YFECz2uyaxB?=
 =?us-ascii?Q?4tAQildKYJx38FCBFt2P1Qm8DU6hXpxD5TIlPKTQnSiHcTTSM8DbwrVEZsxu?=
 =?us-ascii?Q?LWrh6V8/BULwnCpcyGDu0ZIDrjI64DOsV6y7DttRKK2ZoWHa5BoLPILiuv7D?=
 =?us-ascii?Q?qWAu8uANjpt1FmMZmIOfRWGLaKwo21XuWeVE3qVCtNoR/JxMhrfWKuA/WueC?=
 =?us-ascii?Q?ADgdB4Y32pNXMNpSnX24MCcXNwa71Tj7+jFMp1Zuqb7MUgi29wnvFFvot3CI?=
 =?us-ascii?Q?f0bMkX42Jtme7mHHfWXneSiaYOpTF8v413H6Vu4/ZuP6vDWQt9FOLVBCcHKm?=
 =?us-ascii?Q?6JMk4Lz45DEwyGwJx9f3edB0bnpLUvNkGpIbiJOTBO22NTa6vlyireWL2Xn2?=
 =?us-ascii?Q?feJSiNkQu0SH17LWZz6eD33sya4KFomXOoH/83/DKYsDXptFf7rN0TDtQh73?=
 =?us-ascii?Q?ewP/iGGDqwG+pHl0PCEtT8BJmHDQyZDU2q2QEiucRJaTMQbExtv5x/B/i9wF?=
 =?us-ascii?Q?cPXdhBusw8utGrUItuiI/eAzCsNUpxBOZ1Ebum0BRx9WQFOputSKSiXFNm4K?=
 =?us-ascii?Q?l3iu3OGo9Nm/j6SAjG4DrZA0h5AdjB1GX8ALkcxo1Bk8Ql4BTdivqV1LrtEI?=
 =?us-ascii?Q?ik/vzkKVH+3CPsOwf6g2Jwz6jiyCkttkrYFatm0ozK6TVyj89NyMyiy0GBEX?=
 =?us-ascii?Q?bDyfw4O0S1eikSwoWWEffJgkNo7qCkKjBd84G6m6HA9J92JksmiEyq5dlgII?=
 =?us-ascii?Q?xmS5PML4BbsEiSGaYpMrJQj75uHOdMcTkM4Ehb8Z486QDLazmlraF4nc4igz?=
 =?us-ascii?Q?qAaHcOTsIPds8QOEcs5xHtxNgKTQtaJTGPpf0qgi6Y45C/i2HuGF3lDHRN8x?=
 =?us-ascii?Q?16ArDRjIg4425xwYSTjG8wfDIvSyw9wPiyysYTACN6c6Mp3fSSZOWZTnz59F?=
 =?us-ascii?Q?ZAJi1NhLaMXrh7/asvaD/JB5GCk8RSXbJtLdtv+TUVzQJjD2DrTGHzrBbOpM?=
X-MS-Exchange-AntiSpam-MessageData-1: tKgP65q9l7ovXA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03747e4d-8b27-4447-99bd-08dedc16fc27
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:00:41.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKqBa/oSubUdV+CAwEhuBYz8Y7meLK+5RQqaehx0Gel3tUT7wSci1OUptGQ22YsKcVDSzSqvY0VAgIIOVwpCjgtRKgjJJK1+qD/+zqYJfrZOWnNpqiSg//baTJlL3sDE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10673

From: Luke Wang <ziniu.wang_1@nxp.com>

SDIO devices such as WiFi may keep power during suspend, so the MMC
core skips full card re-initialization on resume and directly restores
the host controller's ios timing to match the card. For DDR mode,
pm_runtime_force_resume() sets DDR_EN before the pin configuration is
restored from sleep state.

This is related to the SoC IP integration: switching pinctrl setting
(changing alt from GPIO to USDHC) impacts the internal loopback path.
If pinctrl configures the pad to GPIO function, once DDR_EN is set, the
DLL delay will be fixed based on the GPIO function loopback path. When
the pinctrl is later changed to USDHC function, the internal loopback
path changes, making the original fixed sample point no longer suitable
for the current loopback path. This causes persistent read CRC errors on
subsequent data transfers.

SD/eMMC running in DDR mode are unaffected as they are fully
re-initialized from legacy timing after resume.

Fix this by restoring the pinctrl state based on current timing mode
using esdhc_change_pinstate() before pm_runtime_force_resume(). This
ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
is applied before DDR_EN is set. Only restore for non-wakeup devices
since wakeup devices kept their active pin state during suspend.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ead4685d621a..a54da5757acc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2115,6 +2115,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	if (!device_may_wakeup(dev)) {
+		ret = esdhc_change_pinstate(host, host->timing);
+		if (ret)
+			dev_warn(dev, "Failed to restore pinctrl state\n");
+	}
+
 	pm_runtime_force_resume(dev);
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
-- 
2.34.1

