Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F163D6688;
	Fri,  3 Jul 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783075198; cv=fail; b=GFHlpVo0GGiGQ/aKzw7mPWznQLVPXkYXO7Fr5myZtiAIHSRMODw18n1CWmKhmHNTnthOJQtEaNhFYSNw8pBNew/aqM6lDfPkvzzpkOWnqB2s+Bx7FD6cLzIQ5jSjDbXcUjuCfc/yz2xt9t7Lt8kkODViQ+TnAbn/F7lPjbwMuR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783075198; c=relaxed/simple;
	bh=OdVLvfcj+P2fo4xHOqDWn/gKOhE78z4cdDNtfp5ztpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IicVn91MaLrozf7XjDPFeSe3MPEcLPLX9ClVCeVK8zhW6QG3bWPRByAFMMXkHwXcsSmMoeCrrvrR4FME4U+eDSn9hsRjFPaKWfFUA7WMQ3siZ9igCm3mO+uVE7h0/YtCip5cPgaApERtIca1/Aq/er/kj1oi+jV9kiRUGd0EcBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZI2BfrWY; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZI2BfrWY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xx++Ud5eofFR4RMY7zULDn4WYIW3ztcURglFuO7qsnuO6DxO7DNqCpRxb2dM8Fju9I2OAs5EIkgpBAVQVwdoIRxLn3g0ENZflUPUwunLHKwj1yNLUodWF5Vm8v6cbjXSt8fpRwZ88oqc0/T+mi23AzHA3mUA26VOFloGL9+ch1DuLmbsC/6myhG4tPLePe3RsXwYQR9eJnctdLW7JbmMR9Gf+uE4j4k9yN1KyFQRnuN/gXjuozpf2XMbMO9S1fVXwHWuFhbcIA7KBCi1xvQ1jscBnLUMFTOTCBOXDDNxJ5P3EUmiaB5O/DETvnhgBJ50XpM+P0nFssd3MXuXrAJqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UejQv0R1CtKZ70VJ6BgQ6PazfIkY3jv6aOMEkvLkuhc=;
 b=tpB/za5z/FoTT+AWF0CGfI6X5Sl05qVKms4f/ohR/rVoA6WDuPjJzNvKKytYZ/a5s25fCqM6v4fuxkBWGgu8Bw6s0TlfqLb2sTe5nVjQCwzE8K3Y/817xpUf74+/H4TgY+NhK4rxFzBHUwKdmhMs1WPf+WN5/DkLTS2+tbHvSlNNpkgd5jeu68o94NHeh0S3QfVa93GEeqxPSDDumbO29LHa+wMiL6RAHsk60KNEzYCGqyfzeHbBD6okgiGT+LyMaFTQUkGaGF4wuVHbA+6afVdfEuT8frUm8P9+1AIiRrJLLXZCnbcm/rW112nZ+56DUcLqr4jjho9c9avklGDQXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UejQv0R1CtKZ70VJ6BgQ6PazfIkY3jv6aOMEkvLkuhc=;
 b=ZI2BfrWYjGI3BcLX1B8Hz5jP8A8UisVxhmg3PvmyzgQgJvcyPitWkYG76ytaDw/9biOaaD7sSr8D3/Agy/E7HAulUO+VcTC3LQMQ6D9y3Mvn5rz7JSKnbN9/gW7kudOjB1MlrmmydS08Hpr9P6UCHzI5Ng16xi17SRW60f6oYCQX0Lbl6C9xGNOxPY2AlxSEiREUdBWWSMXPcNPWSxbwEJoh30ngdtSjZqjfm/dhEZSn15epsNJL4KRPwoZdkNTf7Pujw651ozcsvzafIs5ONqjmevfaj1LjVWcPH09qODzDzjcQMTy2P57jOWm5Eb2QWFcjLc6CsnTjPev5UwC8Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by AM9PR04MB8667.eurprd04.prod.outlook.com (2603:10a6:20b:43e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 10:39:53 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 10:39:53 +0000
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
Subject: [PATCH v4 3/7] mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
Date: Fri,  3 Jul 2026 18:42:04 +0800
Message-Id: <20260703104208.3426374-4-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0251.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::12) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|AM9PR04MB8667:EE_
X-MS-Office365-Filtering-Correlation-Id: ab381435-49ca-4bd7-8034-08ded8ef6aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|19092799006|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	4G54F8atxOf/od10gV+wEbCWwjkVBjiImhUh+DUV+FhWwyGxNGlntY9WIoW7u6bRSE7+W9wvHyvfyWIs+dN/OSDAGzdaA3h/JyyruBygGO3nfQm7ClaOQvKVEKgCdCCuaZN0SQyq39MyVyl9yi7q1xmVEz3mC8MorV5iePznTIo6p8YOEJbnKGrpa+axnsHh7D24XE676pJuWLU+/dSy69wdbzcDXB71ALrfLngbM8BG15kOMONFCKU/cDg1iOKKJOlZ/91tPpduhnPToh2dorbl+HLN0hxwohd3aw41B0zR4+KzgsibVz+9OjsOStUV7rhMCUUifkvjmniSceIWT1/XNsoY1qZSLN3WF5XqyycNTvENwwrF4+0pjN9uHN9cCZsYDs36NPVhiyN8IFTW/LJz0DdHC0q70BTfBz5ud05VGDyx0RqkpRNzO0+ucq3XsybiVmwoUZwBMLZpMktQCt3EsLYpEswcTLZH/buk6mtVZio73bS3OW6mWhU/flRAj5JoBJJcBV7nSMEhyN3P5BvVGZCDnsiIOuZds4igXDbQbkY0XaW2TwEOntLD1OZmY87zpEXlbGFkGzuBsxNNW9Kq06nSgCcQ5RMKT6VX4uDFZWJo3yeljDFZdlWRL84t4iWEiHhGsKRQGNdTFaMUNLy4V+KycdNKz2N7+gBcDTM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8j8mYX/XOJfPNwfQVeUB6DefmcREhlFytu0230hFMpbHkJJm/g86TCPU5Cc7?=
 =?us-ascii?Q?1xYxpybAzji3v7dGajpa+hbAEpRpDhOpX8A70VJEaDnK7RTu9mFv7NTwBckH?=
 =?us-ascii?Q?MpFu/O6XLWngQadFEfj44dtAWD2c4bCdl9aOZKHr7Nby4qFIOSZGDJEvr4os?=
 =?us-ascii?Q?cQ5pUdKzootx4/jllGvwoMTs5C4kQwzHeLq+b0X3HrUkChf61uERimKf4Nih?=
 =?us-ascii?Q?9OxM3uHiWgJTbadV8eKUYeb3zkC5nel8bFBMJIpNHxr4TmduphRG4fekqCow?=
 =?us-ascii?Q?8wcq4eNqtAKQC7EqZL2kiCtvj9XNeoq9WzRGPsiGsh7wm4IMvNZ1LnUxJ6rS?=
 =?us-ascii?Q?CICwrZb/LyTy9V0rdI0Cd8ZIf5I3c2Y7xlL2FvRLdhh2X8+cC8Vq3oJngx4Z?=
 =?us-ascii?Q?HluHgT5RR8ZyW3KUl3zLR0evDuEnPRw/eDnKq5n80GHshVm7gbPuL5EqJ0Tb?=
 =?us-ascii?Q?CS//0iRB8MN9d+LCu2Ah6ppf3Lg2MXqUr1n72p5F3/MfyIuvm/GzjQ/pF173?=
 =?us-ascii?Q?32HExajrHXM9X1QSgib7tJk87rCGjqhBBEs4rpsloI2ABr39S/j7iB2TIIg4?=
 =?us-ascii?Q?DUFYpnTLhWSjjQOe53mSLgu0AokO6zj5h+MwTMX3Z+T4vTp14T4mx7rlnucL?=
 =?us-ascii?Q?mt1BdLNpB7YwW9ZUhYNwq3kiYTrLyNeqLReakRhko2bCj5qqot1IT1nfc1aZ?=
 =?us-ascii?Q?CHSAC2lKr6yW5FsooV+aHsi7Hh0yTBN1JWRfYE/uz3TkxyHy00+zNn0CTemv?=
 =?us-ascii?Q?aB29gw3P5uGcXL2fgwEYdEG+ZGM5EvYjqc/Wm6JoFmis46IV1dc5TWJnpa00?=
 =?us-ascii?Q?a9AhKLJKFFTZmYLHuVpU3e7y5gZpM5PPlCRU9uAI0GxyIyDxhjKi6sFATA2k?=
 =?us-ascii?Q?vWDX6V2N4fYh4E3n65XSoCuVb5dH88u+7yzPEs9mSavbuMOcOmbeGHWC9z2f?=
 =?us-ascii?Q?dmMhyzhKa0H7Jju8O1mRAQ3tTTKWRvtxfgqGC4jlhsl2s4d6jLFobUdClCcE?=
 =?us-ascii?Q?ggwDvkADb9YLQDSs9A8Z4q/5ndKn5RRA2Tftytu1sT7AF38/ni9LUzu5iGWK?=
 =?us-ascii?Q?2GUBmis+rcawRmJTh6aoUo5BCUxKbHNWGDjNK6u+YYNoO6mLs5RraIo0AT8s?=
 =?us-ascii?Q?ihE4cNe1Lwvc2gP3uSuTqXUvI0e+MG+1s2ZHCKkXmQWT91ZcsRZDdsfe414j?=
 =?us-ascii?Q?LvaGvozwbPJyJVbD3yQuMSf19NjWWG89NYG6NrLaI5tgcQ5oXBMjOIUu0WV2?=
 =?us-ascii?Q?4uN0totm3PYGqbQa5pYwm/c2FeWhh249LK8A86AcEe1adDWpc42pCxedHFw1?=
 =?us-ascii?Q?MI5m/Re73goy9X++2FIvVuTGbnnUMN+0xgkOjeHEh52K7k/z/5+wikNTgSy6?=
 =?us-ascii?Q?bdLUSQOwmfO3FZdlaAbOpgQ6vItV6wYK7e8X7FdWZkb6cQS4mr1yAmHNiZaV?=
 =?us-ascii?Q?6CHoujfDMyj0oWN2Pj/lSmtaVbvojS5Pvcw+1GeHwXIoN7X4jYI9lCb59Dzl?=
 =?us-ascii?Q?zbtDNpQYYECMI6dCk57n7WGVmuCP0rcx+QcFJS16zvuBcUp9TORCyU708wFm?=
 =?us-ascii?Q?kmZaW0YMmSLtDtFxrUoM8TgmhBHY278HjzKvldDbdADiY0aAMrp8FD6GhR3j?=
 =?us-ascii?Q?Uunh2tApNCu/PtctQeaLg3KPLNVtCjzpduYsZdwJJ8qSkH7+H/HgVrxHsE7H?=
 =?us-ascii?Q?mX/nLPFkR30bzUnr7+mJVlCghT4aXg6lyjlQFX2L4dsPMcHK73poceUNTB9h?=
 =?us-ascii?Q?96BB4zGdxB2WaRIMYpcRfpZAM4g54sAGM2DVv48tDihd8Q5UiIPyu+8UN1Ms?=
X-MS-Exchange-AntiSpam-MessageData-1: I0dVL65jTOM8jg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab381435-49ca-4bd7-8034-08ded8ef6aec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:39:53.6847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUS7VzGQybnTZdF9f+HS5wDEpIAvfQMWEwI1ldfExaKJ01lgL0l6JWUDqokBIQXdqF94sD0zpsufANPUkJW43PkqY4PdudYMVTxmL/rWaXneKSAKbCQnBCUD1VFqfrlD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8667

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
index 7230d70e02ae..3b1e63425a19 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2113,6 +2113,12 @@ static int sdhci_esdhc_resume(struct device *dev)
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

