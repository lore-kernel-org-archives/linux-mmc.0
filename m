Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD53F6C41;
	Tue,  7 Jul 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422049; cv=fail; b=l+dyl7topI1Yb1kGAxG4c+5qWOy5xozjC2ELb3Zkq4x7WnPO+5EgfwDjzzXQllvA3y0YhOfTCJJMRQXZ7WCvSVxvhg9nUc+AqgdiF/MAXgv/AYC5ClK7GoAV/tf45G94RmfyZlayAPa0OBTa/hUD+lLNZXYmoAfzsfilKXqW/6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422049; c=relaxed/simple;
	bh=/idPdpTDLzD9Fy4oIHcINAWPKGDsZDy5+3RZ2nbYcTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKxMT8vv4+7su2yxm89Emq+m9G8NVKV4QW/KyLoS9V/UnfhnBbInGWyDTlaIQMgiALxYu2b9CRhd5b5EXIeL+/YWMGzX8nvaOmpibcPJ1ch7tpJ0aeEGYicxSG3tDfHpAMWe/xX1LyHS0d+9ZZEBO39NnVZ7y2kPxfiGMiO4hbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WInwZKYM; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WInwZKYM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1d+UPdFeFZwtLg4beYPmFLUFVm5TtsCiSaqZkkZL9at0rhFGRgKzvjK08wqVqzv6mFkPDLLfbsN8NvEw/ECfWCaZdV+1ex13CQ9Sn92aHCT+V8aoHaGmCOaXnTn/xgk7w9CnU5TOiwOOICbdB/7G5QPWlpxEU/fCQODnbQ6bUdqB8Ov+3cbMv/In0I4s4nlxqaRTndvkqujARp0IcoBRlsauudoqSM00KcFRseLd75ywKYdbYNfO2m9fRBQgjKWKmF0PP0DoQ1OZaPPSQiNAEeCdLVROb4ndedJLRn/NQdBVcxUMI7jPXtya3N/IQyT01rs7HAPgtf3CtuCpI+dVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvH2OEhEv2g+GkSYTINHghPKZJlwzTs/Gkp7x7ReNBg=;
 b=Jxmv36jE7UVQcr3kJFqU1BqIK6biXnWPAXchZxgtKRQyWbi9m4/x7j3R+JQUQgAm2fLC6g6UmavT9gouZVeUfEp39gKwuQZaF5WUzqEfyGYjsfB9KV/gxh619HLDSSYWeN3ps8vrlcrP3MqXeck9cxpwiyibNuwGe9YDp3lljcmovm27p+2gJ7Cr2fKsC2Z6/Xr6YYCAfhyyQw4RTG1oQF6k2okb5uSaO7H81hmZxh97kgF08gq0guYDj2HnDUe1gApmAGQCZvnHI1L1BBfCxb8gtFHwJlgs46nJoTtT/vrR4x/AywJyAgwg8nqtkso0AUXWTXNyu1e8Dfqw8feT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvH2OEhEv2g+GkSYTINHghPKZJlwzTs/Gkp7x7ReNBg=;
 b=WInwZKYMII+P/1YGtdLeiDiqWtjBXEAL0cRb88A4t7fbec2ZL8+Ms307iPwXTC2vEBCO9KGcfrDv+3W8NaXHtSXchskEGWVl5a0sVEJCVDeuMYWVOXfGZ/JjxaNdG/qD/KSig9DvvOddoe1sajodmdu9Rs//96BHWC8XmDFjmk1GRkfgHoEsZbT9gfnEiRs4XzaF/ay9Vkh/XlxP341npVNyyWMhHK/GfhHvOdjy/331nMM3aSA/SXkWlb3x13Ss72cQElRV0Gu3V1GLEQIy/v89rBTOLvLQ8HUjpvki82HYvcbiDEnFDA6WIkPzDcWQagK+kxfl7roxYt3KptPWpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by PA1PR04MB10673.eurprd04.prod.outlook.com (2603:10a6:102:480::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:00:46 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:00:46 +0000
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
Subject: [PATCH v5 5/8] mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled interrupt
Date: Tue,  7 Jul 2026 19:03:00 +0800
Message-Id: <20260707110303.3779799-6-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|PA1PR04MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1b1c16-d506-4b2a-971d-08dedc16ff30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7fo1sl6Iir+UFdd6Al9cTdS23xgu4ujdfxVfG0b4iqGlpL3ut7ilHJ1zO84ENouJdQ8tgtNYZlSs/T6dMPpTjUk0YbKj99SkKEkrLPAM2OB/WfPQmld6dIQuPXfj0zP8V7NWIUs2CuhQP6UGnz8clv5XuIBZGDHmjGFLTE8M46zpPBFW9I87UT3yiPjtZ3Wx1jcP2en4f4u0hdlDyBTknsI+LsxIHqEhyxVInFOuutY0QPBe9+/eBPmoeChvdnHhhFcnVOHCdY3hs5fzOwf0e/f2o2wccPy8XcnSqXdVl+eqxTrDLy5A1tp74vo4tIyRTyoOCxG3V8nGeq8DMLDi9qsZM6OFNryYxBh9t/MDKx1BpeZML3+3ok9SunHAbhiiy9XJGRxg4Q6D10ODoeY+eGJ+RI1WoUoW73y5lj7Ghfk0TnX0s69XJlEMDhT1UoNUadP7cJMvbejTb7XCYMZsa9cNfGzp21ZOifbCj4vsNWeCeeC1NI8+bnwGlUDtGR/Sm2/N+GcXAE/ECAyDWhT2k6k7txBo9GZUXvXp8rl8FYRtqwsD1BVkq6/AO0lkyXRfUut3VOR73aOjr37ANeb64G4wusdC0TUpxiRVYzDTbUNvGyixkoZ2o0K/Z4nLVQMPUC3Y9YniA5yFMswzBbyiywrxuSUl40Z7ZuBVXMl9wd8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oEbS674bKaNrH+MKf7tOH924dFsp3LSK+gGdJZAEGMxumAu2yZhqMC68CxRU?=
 =?us-ascii?Q?j3/4+HWIeCpbsAQL+vqoevE/gS5WGjIHO44Shbu3BFXPrdmWfXisTLKhmLbx?=
 =?us-ascii?Q?3DFMztXkYs3YFvzmk7gYv7XL9fK612bmTtACkQHeQLqleSHHfHqnznk3U8VN?=
 =?us-ascii?Q?25ihBqgxNOHCgHt6rb5mIR+zaHfH9qNv//hv7Jx5WtN0D9Sxg6tMDRai35/9?=
 =?us-ascii?Q?g0FHV0etLIq1yELnynN5jpIvFeaVkMAn1H7YrQuET6KwVPm1LAH/9XoR58/B?=
 =?us-ascii?Q?zBNOYL689x6J6VQIGaimHaVAypMLqJhvixGMiZcDQTkOkBPDhU7wvCt6NvqM?=
 =?us-ascii?Q?KCEbuDEyPDXh4vUsXX0vt5mxnAqxR6MupwbTKdrnae293QSmP6xLipLV840I?=
 =?us-ascii?Q?9Oa0JtDxkbppJQpH0EHrspsxdgLW+yIAtFXG5xB/6NDiKInZxpzTvm6ur4zl?=
 =?us-ascii?Q?uGqJjaG+ETU//4RpvVySOvJ0aWTqLCSbth55NScbZt7QnDAZgu3/FMnql+7C?=
 =?us-ascii?Q?fMSjue43uF+EsDyxtdmRupOJh1xVAHcN9Ho4G8YTw163TsMkKt9CxYsmDV5Y?=
 =?us-ascii?Q?ovFZ2U1N/0VnJLzakFcfzpqbVhvtEtl/0VmIF0G4r8pzU56xVG5khhP55Bee?=
 =?us-ascii?Q?ksd+INtZlfX+MAE/Zh7kHL6qpsWI5eRzSiWZB0YNI9wP0LHoMukZZDyTGeiA?=
 =?us-ascii?Q?FHuynzS170vjrUC3/hWgGTBJm6+7HjvquUTjfZ95F6F5EU0jqcxkM5sBLxuz?=
 =?us-ascii?Q?eBjfkcdk+E8cPqR54QD08PzEZVj1iI33z89zt+cPL8iYwV68MELddHPB6zqj?=
 =?us-ascii?Q?/LEvTknWn/HjQ4yF+MKJH5ZscyYbObu383vhczT/TLf7/mUxRSWVfPWEunF2?=
 =?us-ascii?Q?CXw2tiGmPCO29at0+kClhzCL21PD98Pn63GFP4jiaDuAHij4rgankG2p7ltr?=
 =?us-ascii?Q?CYMCNJaoyXgY1BoDebS+p+u6nVzR0CeKJ/iImOgLizQcuwHaNYz6WXVfTLok?=
 =?us-ascii?Q?NPsG6gVDZ0bo1e0PW7q+Mv7GG/wCNf6j5X/5HRoSdGHE1g29LaJ7/Mmg8VBz?=
 =?us-ascii?Q?pWI123Liyi3QM1pdr869PYAZ3WUSMJUg4BpmQ+86YZSfsrUZofBOlvprpzTR?=
 =?us-ascii?Q?hn1LEKUoHImKtcfn4M3OxpEl2C2W+hDhVXys6GiqhuyrCfK8m0mrZSr0OEOY?=
 =?us-ascii?Q?6PuDYmiKFkJ+sGm8sxGU48NbvW2wqA7tBH8u73rpkstyqGXPn/5Oq6mQb32P?=
 =?us-ascii?Q?/HvJ0A2xGvvnFmhrtpJzyhCUOb9I5CwOYG6BNympHNg9J2HOwP0QAwrfilGz?=
 =?us-ascii?Q?zFC56lvt6aHFPy2betQ/By4BELHkyCrzTp5MBttUl2Fqb71bqVLGKKQxPWfO?=
 =?us-ascii?Q?AZu2w0B2xWuqbCn0sBTt82oeR7ObmcsLrgxrEtmlZ9r5por9SwKLi6bdpq+u?=
 =?us-ascii?Q?u9g0lTuI0zbASUZyA5X/CBObIg2ZHSuV5ZB71gwP94LzhkYYrDEdFC2zGm/6?=
 =?us-ascii?Q?eWat9QB2rlNAu9GV954Mt+nlP9OtFCdXI4TsCI5OcIG7ejt1qgzi4Tgcy+Bh?=
 =?us-ascii?Q?M7Ny2/ecrE0lFii1u11QXDYvIjYO79jOP57o0wb7poJoz+3PlCGkj6MLTbWk?=
 =?us-ascii?Q?cGSwyvW+AJxPA95/fFTFS0zVOio44brKs1HEUiV20KPfd6w1OcuG2j6rkU6C?=
 =?us-ascii?Q?OKtbl+cSSFogA68s54WKjrhdfHgm/SP7/xO7ZC1C4Jiu+n7Xx1YmUIitsXkN?=
 =?us-ascii?Q?SMFCYJKrRBA+TQBUe33wk3eM6l+FJUWJ+FciTlxjqDJ0Ls8qnhWURxE8fu0+?=
X-MS-Exchange-AntiSpam-MessageData-1: Kq7AE8NSie/cYA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1b1c16-d506-4b2a-971d-08dedc16ff30
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:00:46.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fX3TzjqWedhK7xXDX/uXPL0zwmKSQfvb2sZwCssAZf9JGM2E217FcKMWrv4ttYJD/8wxSt0bnlyXIiGrLh6MlVMtKGX4c6uVqnb6p2qn92EJTPkyv1Q566e7td85SmF7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10673

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

