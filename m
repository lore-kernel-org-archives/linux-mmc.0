Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC583C060F;
	Wed, 15 Jul 2026 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099796; cv=fail; b=kE3RoWW5AvU1OtO7C7fLn52dCQ1/G8FxIB3cIJq1Lhv8nPVFnqlAZLN/ykA/5gLDZ3w9IAWphKxmH8yOCogTXd3FxHWkCfZI8P4WOGo+qQrkqerK5hbFVgkGrpRhG6M+lLlsINt7t7HKRgiWr+uX+O98F7PCjbPqRs397AVAWJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099796; c=relaxed/simple;
	bh=6D360ZFXj/dMrR55quye3gPDIX61DXMPyi4C+kVm3kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pVbE3c+aF5vPiNPxWJaF92a87xY6NxpTlqsYfzbx16bfuf2VBMBlELDSFgSaDbQSz4NfoRQ7cB+p88l0D6E0iyRElfAn7RFno116cN2zrFMCmK7hfphago8uJMD8YMyGEx8+CPh0tOH/o+T6FqMMtd0JcVMJMq1Od6J6VkVPqZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cJhoYcWJ; arc=fail smtp.client-ip=40.107.159.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cJhoYcWJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMiWmTIaraOo5TLzRYxlA9PQQXKudtb4Dj9/POWOynXgCPuCaIOVNfQIlwuxj1Ql2K8fiBFxP1VeSsgdfATm7nXb3+NFgVJ2LXkW2AIw0ADHVZ1Tf/AX9P7uw3ScrMbkLu8y+CAKBIraf+fEJig8DbjOukJJHmBt7CCx923cyouO8KkaOeHKIFt49VvTcFG8hKjsydHqTpymfPaxlHj4DI/Atn0kSmEIGdJCw0nGslpAmitVKhDg96Zes3Zb2bGZ7VZ2HZcteQ086qExWC0rPPrq53817zMXkjsGNLjVqb9/421NkvqfyLexjl8vwNQ6xuOieupAiViRIi4a8z6Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb4wliWSss33+is/53VPhOb4U4CbmsDW9qnzXvvOgbA=;
 b=STbQJAHEELNOXrNZUi+ixwLWTQQW6DTd3hj1hr+mZ2qKxspA2RBD9ZFPPraSApCuXfDWFtLX0MbNMtum/EHuDJr/0d2eLx28XJxoh3C3y5drM6yeWuP7K2T2Fs56E3FZnrCHiB6D1rXuCAeQkgA3acnYw9D0Uy51BQvGy13lEVaF4Ic1XpK1n39Sfsz9f6VQZkf4HQ+oB6q85NM7JTHQFCQR8ciEdQZZmcsvjnUPBff3+l75z+mzChUOwyEn0hrhamJ4rDptT15W6QZwAFcxWVjiZOtVBQM5px06JcHDBb+Sw7zWIlMDMesvm+4rb1m1Sm1RuP/8cZcNF18kRImZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rb4wliWSss33+is/53VPhOb4U4CbmsDW9qnzXvvOgbA=;
 b=cJhoYcWJp1Onp+L6qwdfBdJve62UlANHn3QH4l86BO5uJtZm5w4lyDgftQkTHV42+YqG0pi3UanVDoOI+2BtCeP6AmNxsb3K8ooKwNaGEopdzN+LIirTv7U0VgXlSaqdoFTSt5GZw/igg8yt/BvzlUBDS/wCbkPAXjK6P+ADHYYKc4zmy16Dj/0VCUaEFUmyZgll+OqParwsdTh4Wq1HBzdyzEmJNfvUxwLFIovd3vVGmWDy6xFe8ITbqD49Q/rw0PACj03uwzJITqPyt0zUNQG60uY0iGjxHiAJwihU1fJTvu50OVm3ZCFCAPF+He3SygDdAxsuXgdWsXe052Ii2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:16:27 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb%5]) with mapi id 15.21.0181.016; Wed, 15 Jul 2026
 07:16:25 +0000
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
Subject: [PATCH v7 5/8] mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
Date: Wed, 15 Jul 2026 15:18:15 +0800
Message-Id: <20260715071818.272318-6-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::10) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: 5176c94b-7472-4c53-9de1-08dee240fb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EnMzwa/Gfa/Qk4JHASZ78JhRkUurq0c41T3Z6x6jFuKJiX9rHLvkxzUUoAVZa52IjPdM7Y5rxn8BKbco8+pTWY0iB8qMtf8LeIkqT8yO28/GCRfVkKMtjuxuk1CAfSY38qNAjLnOwZpVLPT6MF4hz/qpZv8leNooElxikf0TLloaCYGytez1g9VTNqcmY+T8ALFf3vfGEzEzBYOIen9GiTES0GrI8IcGenp5OlAAlJuEyLTW9ZYBb2imjpg5ZnH6Oaq5ns+ytXR0IFmwsaDJ53hH4kjjTGGwkMt5yo4W33Xjp91xTiRRKWYkBXvZMM1pY/NLt/TqYWu7Kuamir6JhtxcPopCVxMH4eOkKR1BQjChrJ15jSAGUBCgxbkiKMuO9F+D3+oVaWnu+LhLdjcqYeisrfSVlIaKiiF+jCWttG9nZcZeUlJ8y10VgnAnDDp/kgut/AR3cpvkwLSaPfZSgiQSh8VcUyMKhytjBKAN1jO80cLSDehuHtrE/CS1dhaLMZtMRllcVvZG3DMkl3v/d42Ztp5y+qn+8fD7tJDXWYntcbxTCBcnU36y0QXoGqn7eNI5MXGfRplmi7bmr9YGTkmCar45rCbIQJKc+TqQMAJ2t+ym/PvTa2sE5kKFlDLMoPryUtuGEv05u6/BPrePf8R4j4hYw2/oYpw9pSuZiSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2N9x+PbBtpR35LlcD8eBDqYuYINY/wIAa7+TnuKw/0tW4C18kOBhGmNHtUC?=
 =?us-ascii?Q?vXxh9gUYDkhXiASIeS53mtSvXe2KhxnIhGCq1jSj5w0BvF5CzbaQk9i6ul7f?=
 =?us-ascii?Q?pXv9Fmn88fOk72wcdOOqQPYq/az2smv37a33otzO/n6Mwi/TylV2N9P/vR6k?=
 =?us-ascii?Q?tqdgrq/eYBDt6uDlG6g91n8L1qclAhMyEt4xkfDZygMeH6dCkcs91c8P2K20?=
 =?us-ascii?Q?Dh5Kjr3jwbl3RSxHs5xMbNPO2u8mZ4fyZO4A4GR5mxHYwaCAGAiDPlsiZ1iV?=
 =?us-ascii?Q?4O9fUJ/SEsoAxw6GxSYbYQPXe/OVYvkgfRVCOXQaIRWTcjjXCb/zHUBPgKuY?=
 =?us-ascii?Q?FpElk4NAAMxaZTb8p/g9ylSrYHL6DtZkbf9jn1dHXnDjPpSAjTZc6/ATzZIP?=
 =?us-ascii?Q?/RL0VY31kKJxKcMea4NxwBhd4loEYRb6NvH/HJ8csFjJfkXeGGqOsbUTdo8f?=
 =?us-ascii?Q?ZicLuNzqmhQbspuR1dZAhyFjm3PB1U4jx+jE9JaOOxI1Dm+mhnqCgUZWGwz2?=
 =?us-ascii?Q?Cr04RUqkEtN8BNLxtOISuC5DS0kQDp1rPxm3e0u9YUkfaLGRCljF8DniyG1h?=
 =?us-ascii?Q?ixHL6CzBj9yKixGfNedjVMbM3Ksuy21JGCJfx0+cc1azFR20JhLYwVp/0O29?=
 =?us-ascii?Q?niICbX92zQng8vpDg9TPaLGJzL2lJCqxIZie06XPD1+DBfS1pXXTWX0N3Ru1?=
 =?us-ascii?Q?XpKEZ8wf3iczF3w/nAFBnCSmD4Tva0AE4hY8cKV3wKnZANBenWHzIh96fBLf?=
 =?us-ascii?Q?5sLRnjYKNqN7lhSEpRLPgYznnYijxzd9k4QQPUXZkoRDmZin5QVHPtuAE4Rw?=
 =?us-ascii?Q?smgliLe5O5MQCX/04LT+8y4y1+B3kWJ6Nupkje7fArz3vQD1SEWVIXLI0rAV?=
 =?us-ascii?Q?3jEISb71oP47WbTdTa+WhTGEu+I/r0LxNaqdSpeZM6ujeWudT6AxP1wil8TH?=
 =?us-ascii?Q?q1Vqawqnz+EH1UtokSCO2N50yzsmmX5mCEt9z+9xkkTTD60005/sfFBQGFVD?=
 =?us-ascii?Q?bkGxDhQ8w9Lz3zwIjA7sPqu0Mik2zv5JwtEGEqQb4232gwGH+e/cvkYALIYT?=
 =?us-ascii?Q?/cMv28F+6PJRthYzH6fezWQuFFDpiaYt/9TMTTDz9ZtZy3izZe9ew94JhKNU?=
 =?us-ascii?Q?NfLwza3zbn6Og2ncO3+PtQLLpD9qrQfzipdOHaDlJPcpcEmZ+sQxfmPXLTqM?=
 =?us-ascii?Q?a5euXAjSwjkhC28NdLWw634JLen/3rDzN+lb8o8tBfQC/NYP673yF4W1Ey6I?=
 =?us-ascii?Q?WAm9ILSrUpjbWJwOe//X0KKEGB/bZyFytSzZ/zDTV9I5UVdL8Soyk6daVjeY?=
 =?us-ascii?Q?3+SNt5jq1T6VtLubtsQUiwZ/thGXkQUPz9jycQ2MUfF1tE7lbqjW4zPr6YK7?=
 =?us-ascii?Q?GUJDqiy/QQzTQXxo4zpP7VW8VsZug+7vvHw9fCFai9WNo/V7chZUU7dzKWHZ?=
 =?us-ascii?Q?+XdFVvEZrJmULXKmJO6V2rxtuifW5C4qLi4ny4weZCvmtv0DkUqxnI3r4vi0?=
 =?us-ascii?Q?4bVYRf3YV7ew4GPfJunsCYFU1lgmi4N7vN9SbN7nfN1BNfHQD4Lx6ofHQLvM?=
 =?us-ascii?Q?x2eyciCKI7w2gTRR+e8bJNnmkaa9doMvl6e2OZpkmMhU/lsxdfEgAK4Cbu1k?=
 =?us-ascii?Q?vmLPCZBQHYWptyQQgE+ftV8fzkmVxob6TrSzvmemqStxCZ9zM2lwrWBIPOoB?=
 =?us-ascii?Q?pYP27uuRw6eeXpnTsFWs7d4GX0Oq2w36agyJ3mLMVJbiHGph2HenpJed4oay?=
 =?us-ascii?Q?DrIRb+7mTmq1vqb0zLp4JxgxM57rqNhiPDW9aRIzP6QAITIUdwZJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5176c94b-7472-4c53-9de1-08dee240fb07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:16:25.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxlRXn8/BXJZq9z7DmobEJAzj9duhJ4kMenSvfpp8j0NdOX66QWhbUva1Hm3zkwUdsWpTiO4Ju4x/cHBkiPyQCBCTuchN2HpoOjIyDIqOIiLdXVwqpdd8/iZUGf2Pabx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

From: Luke Wang <ziniu.wang_1@nxp.com>

When using WIFI out-of-band wakeup, an "irq xxx: nobody cared" warning
occurs. This happens because the usdhc interrupt is not disabled during
system suspend when device_may_wakeup() returns false.

The sequence of events leading to this issue:
1. System enters suspend without disabling usdhc interrupt
(because device_may_wakeup() returns false for usdhc device)
2. WIFI out-of-band wakeup triggers system resume via GPIO interrupt
3. WIFI sends a Card interrupt before usdhc has fully resumed
4. usdhc is still in runtime suspend state and cannot handle the
interrupt properly
5. The unhandled interrupt triggers "nobody cared" warning

Fix this by unconditionally disabling the usdhc interrupt during suspend
and re-enabling it during resume, regardless of the wakeup capability.
This ensures no interrupts are processed during the suspend/resume
transition.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a54da5757acc..d980dea9cad1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2077,9 +2077,10 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_save(host);
 
+	/* The irqs of imx are not shared. It is safe to disable */
+	disable_irq(host->irq);
+
 	if (device_may_wakeup(dev)) {
-		/* The irqs of imx are not shared. It is safe to disable */
-		disable_irq(host->irq);
 		ret = sdhci_enable_irq_wakeups(host);
 		if (!ret)
 			dev_warn(dev, "Failed to enable irq wakeup\n");
@@ -2130,10 +2131,10 @@ static int sdhci_esdhc_resume(struct device *dev)
 	/* re-initialize hw state in case it's lost in low power mode */
 	sdhci_esdhc_imx_hwinit(host);
 
-	if (host->irq_wake_enabled) {
+	if (host->irq_wake_enabled)
 		sdhci_disable_irq_wakeups(host);
-		enable_irq(host->irq);
-	}
+
+	enable_irq(host->irq);
 
 	/*
 	 * restore the saved tuning delay value for the device which keep
-- 
2.34.1

