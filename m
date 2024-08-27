Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010027.outbound.protection.outlook.com [52.101.128.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3112F5B1;
	Tue, 27 Aug 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744095; cv=fail; b=XwdDS/RAXnI47egcViLZYCI4MWI8qPV1Hhwce1hW3ADRFyWGd1Qs6bKvtwUI6h5PXDAJPcAdKop+03ACk2vXqsECh1dGJDBWsjpjFcd+Vixgf+TY756Sp2exmEKsWzSjwNoYjc9MTdEAQLC8JRm4nbTt/potxFckHHkkq33RFPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744095; c=relaxed/simple;
	bh=CatR6yJF9yjGW1nbrhW0FHlxdYQQzsIJNzpjHb5uN1Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGuhxV5SYJF8y02hT/vgTvBIrxy1XLTY/sAG7UbQtzCqJVBzFTJz7sZUChzEswPNVS4VwMxQZ0lyxXSRZfLEpj3jwaYjF3afo9r9G/5AUwF1Gr9c6wDCgSVcYAEbSvDwP8zP0xteElw7D/egPgGMUdej5naUaXzHRH+dhvw5zTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XRoO7kWK; arc=fail smtp.client-ip=52.101.128.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XRoO7kWK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoATgHY9IIsrqQlzqUWFnIk9khyVTf4UgH9xkXqg/aJYhokL4K1+QeTkCXXNtmsM9K2cyUCENnGKfzWFyhc2OobswRFFem5fZ/AvG6oAClzKok9q9KVycWeovS0W3YI+o0X/hb/9xOHg044zDfhfQt39uRr1oXkqNzlXXOBzSvYcYnnRExv+t6yEC15vAyG4nNCgWSBA5enaKJmy+MzVBlQp03ZfJj2ynivuv5ZxorOpcEdEXfwSzuxE1I8SfIWx6pcQsJNLpbEac2Icmv2zWFTEO6uvm/IdTc2sKO1VGR2tGNbj0NDrvaKxkRHQvs67n8m1DtKDW27JWPfNEpQOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ+XYxeMXRYeovd4iwShM7nU+RCgLZqQthYnaofweqc=;
 b=Z2and/EA5oOLTUmVQfgiZv8e3lGplQdeaeLCP9VLbIQiJcp/GKPrmH1JYQCMLcKHMjNcUy4l5FlZdtvdVbhqy4JtmU/Iz6e2WwDJhhoIHluWsvjZ+GTg8QG7hsVSz/WF8qUjSFGBxJeWL5srBvn8K7kd3N/fTP0QdyWmtGO95ih2RROS/UyOcK5S4s0QY6YAt88cscgxa2QlCH3MRCVzi87sTrkRNEU/Xgu4nx85G92fGSgj4cKjEpReqAAwN2u3q+oZL57x6iKY4VJt2lvg4mb3Ug3ImO4tU5GsRiV8AH53hL/fYkSOjTDVMz5H6NtIX4uJMV7Dd9qoC7SuXlVQNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ+XYxeMXRYeovd4iwShM7nU+RCgLZqQthYnaofweqc=;
 b=XRoO7kWKVeYnbOW70GDlUNOzbCPqEn9l0I/dgN3CN1bww2Zn9LZoVrqevU5exzbPESI80KCPWd1BPi91E19iYYaCAS4bJzqLI4ZjDkYvr8aYCYlI1w+dH9G9sT+dUHUKBxoeLvod0iOest1U0JO2M57b6SFlwA+47XBlzGhDS58y/2B5WfMUxmdFPyC01a15FEKVKJ1fbbcDALkDIVTu+lb75RGYc2ycMxbTtXMpdD8KXrGg/Wgc8oTrAA+e+DU4jBFGIzkp9r4/9fgHHRqTYM0HLiKfdRjPV5H89iUDyB8/hu2GBQSz8TgDacdqfkVFWqxLw0KHdSPUKQfxs9skog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by SI6PR06MB7102.apcprd06.prod.outlook.com (2603:1096:4:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:34:51 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:34:51 +0000
From: zhangxirui <xirui.zhang@vivo.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Michal Simek <michal.simek@amd.com>,
	zhangxirui <xirui.zhang@vivo.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/9] mmc: davinci_mmc: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:40 -0600
Message-Id: <20240827074857.2671808-3-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827074857.2671808-1-xirui.zhang@vivo.com>
References: <20240827074857.2671808-1-xirui.zhang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|SI6PR06MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a58f75a-721a-4176-9bd2-08dcc66abc8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqApWg+fTfXseJ9szGQgk2iLgaT8wVoOaJj5a2j2XMyvubCX0YPWK0IslnvO?=
 =?us-ascii?Q?s/LmUKBJeeGZ9DBpQypsr/fxGg2Q1x2k9ZcrdjKyyAy5p7cVoeYNg82I6loI?=
 =?us-ascii?Q?3i3IHf7uOZFpxT6VCLmzvbpNXWOsQ4ShVq8TmY4m7mo4T4jsCDou1T31RnBE?=
 =?us-ascii?Q?15l9fOygdBG52aLQsRuz6xHI1/ju9vizB5K3QxWJvIeL9vEIgl3DPX4mMHY6?=
 =?us-ascii?Q?F4zvYmCWlK2VdraAlGBQqnmM6WDjWCG4jXLPsi69V5Whf571PgIECpOeyFzv?=
 =?us-ascii?Q?3IG98xitQwRUHRo0cZN088eWnQUD884iAm5Xla4wAxiIY4HawfevR1Z0WEpU?=
 =?us-ascii?Q?Xgo0wpOS9jXASqxbwpB9QDuCnIWre44J+juDYzKEHEBh83rwZsu9T7M/lQ/d?=
 =?us-ascii?Q?neL+fl4/6q9Dx9SIXR/RjUxUUy5x/OFmj/iFBmfc+Qdf6D7yAO0g9e6Wsnhy?=
 =?us-ascii?Q?1sgrFzR+GKoBgz7i+UHizRA0SlU1Ym4J3IwQIWYszchZsSyG8LGY1B4lEsSg?=
 =?us-ascii?Q?i8aGyzpFuq0yA3A4lyNNp4CwLtryFJ/8JNyBoSabXcggZy5SpFyuMUcJCECy?=
 =?us-ascii?Q?2ypTSPqDF3Snt8y8L9sB4zC0edWcLwPCnlU9Jw6q5+8lRKzDyegym0Qd7qQj?=
 =?us-ascii?Q?W65u37lVLpdH40qDJr0sXxvqZa63UA953i1U2Oh/wnnoTG9qlHI5kgBeOuOu?=
 =?us-ascii?Q?5dei3v2TUPpp5W/+Jdh+PVWzeMI+agf+xnSPgXoV624cSR4JSInH3EnXLDrj?=
 =?us-ascii?Q?x1Y+YZUQG9hVxjAe9zptaeA2U4aqdhbInySgUoUjqquTqetL4I7i5kIMCHVH?=
 =?us-ascii?Q?WwYm6+4PZ20DUTJC27VZIUxSqWpzPmlxqtXmpuYwTuIbuN/GCMp8xiRXq9Ok?=
 =?us-ascii?Q?sBTFQDcGoPmz5JpAm5ugyYlthE0HbWBpb/1wxgU4GQ6bWWRakQjwljhw9cuW?=
 =?us-ascii?Q?nGO+BVqCF1NfIqL9aSEmBXIJfOlPRmBPAUKBnrTZ6tqSuWiPG9LY11H08UHZ?=
 =?us-ascii?Q?rHXmjLASj4YyoCYAeABkNeVkXHHFvsAptWAqah+OoIKvV08mIz1LKXkh3sNL?=
 =?us-ascii?Q?CRXWMRYpolMWWUD1OKbQ//6kBEosYoNorZBHKlU6qmfqCZ3HmTX+Dbp93iJm?=
 =?us-ascii?Q?c6cRQk+n0/kI9QYCS0OATTah489r3HeZqyBrTqHhEvYpFCLbmHTKVcDx41hr?=
 =?us-ascii?Q?SH/QWQqoAh17g9bRmDmBk9wpdhY+7z2AIQuli5BeMqwkEe5470w/C9M2FzUY?=
 =?us-ascii?Q?C1VJr9iaXPF2g5OHAizPsNTIgMw++eaNg9avFwno5S3XTUrON6wyEY7hsb4h?=
 =?us-ascii?Q?nEFjZzHOHiG6eoaJnCjR5WLqvrEuPl1sahNGzR1EFxMfJO2uLgcdOqNEkoI3?=
 =?us-ascii?Q?5fbKGQ4AzSg03YEWIuS9qO2BwR78PglJ+RJseCAVq/x4RjMvDX0CXj3fpZEr?=
 =?us-ascii?Q?fQ0eQ1z6gAy6opOEafFh57+nA/7SPtkl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nmbKQYW+Vn7EndXQD0zXb/NAqKJvvmgLtB77JsEjuTU6Bk/rdt5PfQLtar7U?=
 =?us-ascii?Q?l7r0mDed9kuIjQfeE1EOmr3U9o8EU2DLMClIQ/JGlZwFve+6MuDApgdrfbB7?=
 =?us-ascii?Q?pNdouD/xxFxkO9zkrxSw5TRg92wGWfSFpmQppqSZcLeTPDRXQk6aoaC5nR9A?=
 =?us-ascii?Q?tgsOMm+U30f/Qe0TLKrhU1iJyiKoFiLfUnfdjWO7hUAQJIxewjRwxGwwChCp?=
 =?us-ascii?Q?YYmNtZLrupmPu2HJsLoCEarr3wQ4OSyh20CcmDYsb+AvE4DUnqy0IksZ+L2E?=
 =?us-ascii?Q?L/xgsVK/Fx2auBlDCIg63zDtvEQ325Bv1/5z99DVfKxJ9ewpMTK6Tg1s0fNi?=
 =?us-ascii?Q?9DZvSWu8eyHS22+ze4s+YPC4alcqeVxX7LU1IuvhMoLmrLlyBhGrj/brOKjy?=
 =?us-ascii?Q?nwdxccSplfXlmaI8XQD4YEPR3Au74IChBURi0fLqi4R664hyKdASmV9JjBE6?=
 =?us-ascii?Q?PmTxu9kKJ36htFijzQWbJ+GHXGEGqXr8iWTqdyTN41yGz/fwb5V2HmymFZpQ?=
 =?us-ascii?Q?uPxejQUkN7tbKz3aOkZPjKdVEtFu9TlGVYwvfNtW7EAmbkoa3poHwkHXQxEr?=
 =?us-ascii?Q?fvOqTu5t1vTFYN/2xRxSzXepV+4SUfPaqb3ed01KKgAhFOIu4nURzUap/Eh+?=
 =?us-ascii?Q?Rp2l2ST0+Zb9u/hZgBiOACROx00G8VEGoFOq3Nf5cPVvB7GTmxLZWVNv65Fi?=
 =?us-ascii?Q?Un4vUm/3ouljZPogMAqjJ2LloCySo9AP/Wx/xUaukP2u6mcRXATkAbZOxYQX?=
 =?us-ascii?Q?8EM2wMUBLEUmHNtsONZLU+2wZehNZcAYQ6UX4+0UbE5pA9fhYF+1AnrLN1SS?=
 =?us-ascii?Q?ZZOKdYa3zaTCPPzDUmFKEgOFJZiMtgYFi/bv7qcnevPxOHKW/eq/b/VMZG3o?=
 =?us-ascii?Q?eCtP+Oa5FZw9pEY2L2U4HpfdkV0+jAEtMdznVd8YaKvcgy5lqvcy5Z+eUyZx?=
 =?us-ascii?Q?1+qnJIt+9P8IZ0IZ6d7jD3Aqv8psPp0bJk4azyEn+LOz7rGJ/Aj5NZYGVNb6?=
 =?us-ascii?Q?bM9ME/aaAcceXmeew+mnnDdv1+LrwX2c63Hps2xfRwvqJZxfudlfLJitPiol?=
 =?us-ascii?Q?IJgKyzWoyNasa3xkMCO5tVHkfunZ23zDtAEJOEI7QodQbRgVcGUmujQ0J8Tz?=
 =?us-ascii?Q?7EHqWufK6VZ6oxoVGmByJKBdIzFYAOmPytVklNzkz8sLYQG/kNWR13kO48wR?=
 =?us-ascii?Q?dJ833fwGJoXXqW0DjK8kHD1Dxq6UGu1hvhz/ygnS3VYE4HCvWZ94AeQkaeEC?=
 =?us-ascii?Q?2vDuwDd5X/JEd2wCraJH3kpPkdprHvcDHsIWpK4ftsKGVwzF4PbzFzgEtnbt?=
 =?us-ascii?Q?GJNDR8dM48fVosd6hdifhDgO9E0oBcPdWFYxmA16no2Sa+MI9cWn1+G41+bJ?=
 =?us-ascii?Q?dKLPccT2ayNloP2RZ5hpn2yogRQKoO/gN/R00pdHct44x4QB1TKgB3B4q96Q?=
 =?us-ascii?Q?t4jNP/dPUMlhvnGJMj0kVbKExseo1nfXEy0HSZEYc09o+s7F4eIUqQg8RRNr?=
 =?us-ascii?Q?AQwcJrLV36OVE9DQMbF3jNXgCcceVgJ1vOJyW5KeDWlQozUaqHnZZDOV+joa?=
 =?us-ascii?Q?bs2cGo6qh2Oa/CY5u05Ryf4sLkzfXIbQVUnaqw7s?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a58f75a-721a-4176-9bd2-08dcc66abc8a
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:34:51.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyHwD8Z5V5pzbNFA41IKGNOW0Fyc63Z61WMutMPqufpTfIebptYcKzEP2DJw+EdYCp/0UASczJMFTET79wnmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7102

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/davinci_mmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9cbde800685d..3e71565285c3 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1218,14 +1218,11 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		goto ioremap_fail;
 	}
 
-	host->clk = devm_clk_get(&pdev->dev, NULL);
+	host->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(host->clk)) {
 		ret = PTR_ERR(host->clk);
 		goto clk_get_fail;
 	}
-	ret = clk_prepare_enable(host->clk);
-	if (ret)
-		goto clk_prepare_enable_fail;
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
@@ -1336,8 +1333,6 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	davinci_release_dma_channels(host);
 parse_fail:
 dma_probe_defer:
-	clk_disable_unprepare(host->clk);
-clk_prepare_enable_fail:
 clk_get_fail:
 ioremap_fail:
 	mmc_free_host(mmc);
@@ -1352,7 +1347,6 @@ static void davinci_mmcsd_remove(struct platform_device *pdev)
 	mmc_remove_host(host->mmc);
 	mmc_davinci_cpufreq_deregister(host);
 	davinci_release_dma_channels(host);
-	clk_disable_unprepare(host->clk);
 	mmc_free_host(host->mmc);
 }
 
-- 
2.25.1

