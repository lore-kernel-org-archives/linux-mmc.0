Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27047362156;
	Wed, 15 Jul 2026 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099811; cv=fail; b=CpkORqkB7Npg0MIJHGBl+1on6AVDjKIuxIZIGfqBqYdEhunfBi9gVPw0w+e+/NsFEydcSLBlCpr10cgoRgdCwcqV3LhY9JVsupNcUPu2/X6ehZkkIEQS78L+9PL3QPIRzBUnyyXHLyrh1ymx1xb5etBXGgh1KeReRtxKTqgr8OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099811; c=relaxed/simple;
	bh=TdDSB0OOlwp7zpja8yOG9kwPv5bqGfpjn5ip+BaJq/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kYsuyJq2HNgFijoPXu/yc5Z1fdAiE/6jqr1C/WaqwYx2JtIkvjVyI5NCXlqSCW5KdFGweRhb0K+i6KZAg+oCp4zTZYIzkNyeV5qSwnMKEWPKNXlQhspyzAfk2O6n9tq8BcL5TvQBqvN9ujM5VIJKY50PUub7joK4nqJxV9dXsWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=rrO3Uv7w; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rrO3Uv7w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUoOcqlxDaqGuvhUqGJn6MxPcE4P9bJ/QuhnJiDEMT/s7F0DLqjYfSNDitgrBg74U9ham32xCDOH8bN6vhYHxcA1r57CgH5b+LIxmg/mdAwqQj3yx4ow8kRZUjqERmzpzE7rjAkpn4/Vyi+NCYtxBZ/BL52piJQzfVbWkrQvmWjv9wq3HHne+Cu3wwKIxPC1VkF1hUbH/cizLLxJ1jT3ZVzzgLf7/1CmZTP5OTNXNX1BAahpvhRiyS5/aBF+HJYA7gxXOs6NOKc9c0tJfJ1mEVkvRe7bAH6q8NuxMvA0ePn6PvzRl+wWhXur4tN3UzV00aeW9Ff0InAdjwnm5YC0oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Z6cjgr6a2AD91mY5jk5k57YvTdBE3AQg9dojPDbHtQ=;
 b=scn70nxBjFj7Ps1hHafdUVliCrdY1Kylfarrx7q2TOboOCkj4du7VBwvJHJeiRf08mLHqP6THdIxZvbvZNSaxAReY4beTzeK2KtCwBgshSwFBt8tmET17BpQzrQGifPcLyLWbRFXJ0xMGiPVPKaGeChaqo2pjIvijwaR3WNTRudJv2y+ibgal0dj/fBuQYU8rwIO9FC0rDkQYiLIyMhyevsHC99iK9+j/YrFfrnwTiGS9Yo5+oacteCUVsJz7z8gCGOlGV+kqMucTBYMvX91GvOHA72vS7RdwzN0Q6KtZHFWdx2BbUvnxYdz/UoWAzfUV+DVf6ny+rkvvZbmVi2PFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z6cjgr6a2AD91mY5jk5k57YvTdBE3AQg9dojPDbHtQ=;
 b=rrO3Uv7wtqIcL/wj25958Mf3yzwrM2HmyEAjYG+8SUiDG7Y2ZcSoRyY24hhxPEwQM1dRXynl/57AZ3BjpxMZWhBnuAo/1dFPKKcG4PfF6ErhEZw7MyGSuqdzyhIJLx4kJfBfsfpRu2OMqTWsAzTj0sS3mRdo4O9tXRZbjtZj4FANhLJcQ0hKOhqDp78shmhy2pEga5E5E3qimZEbztrrB4zipueEAWdeWjXKr53FK3tesZzY2p02nRO/8eRGgzyPWWCKQM2MM1G6UgdaD5SaD+/d/L2C7UWev75gB7AF6nBSli3D2Gz15j2CLn3sYREi8S/0c0vCB0jdWZe8HJEYNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA1PR04MB12197.eurprd04.prod.outlook.com (2603:10a6:102:560::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 07:16:39 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b4c0:6119:2228:2ceb%5]) with mapi id 15.21.0181.016; Wed, 15 Jul 2026
 07:16:39 +0000
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
Subject: [PATCH v7 7/8] mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
Date: Wed, 15 Jul 2026 15:18:17 +0800
Message-Id: <20260715071818.272318-8-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
References: <20260715071818.272318-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0173.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::9) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PA1PR04MB12197:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8ac6bd-4afe-4575-2998-08dee2410371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	STKhmNqCqzJVJoaEqC1GvcgeBaUMElUiXzUALmzQlLZPUYqzr1nXpJ/xUhOAs60mMr0kDBhfKnVUnqwDvnwUksR0yY7NRe7T631bYwWCGygxmuGD8pD6T3iBrUY8q9QGzFKBX6/uTa8AM0C9S9eZIyI/nd6Rm/DZm1oKqEpHpyfPDS5Da4TMCQUMHEZZSHKodMRJBBI2nn7CsxnLahs0PegQvH0WwBR4UjisiSGKBVIrjIatgJ1waCPweM0ewGWeLRryKIXRZyNs0EkrE+Y9ZRYSTOtUNIDbM2skWKdTcLkFlEsK5MXCHrfJdfFZ3Z+uxhEQafuqwpKR9IaKSPC7tzlK/wd/Tey+Eg7N4ZmuR8zUEtUovzxeW1gsgmrvoqB7DYZac2r2RAyvq2NW9WRFp4SmEDd908x2PyCVD7QA28S+ue7qshtQWIMQ2nuIrDbjaIUaCZ244agdNweCHSlVqhQH46JGQU+kxJ6u6GDBiGKaEGpYXl1+N4vDLY45q2FR5f8N6W2WA65Hj034hzZWDc0OD+TNTUUuyXtVwep9XMXyCiphdvxnepshuPwDEtq6ouyFdBbrfdJ23Nzq5v0L1bGg2uOvgi2P5gT6tEc6+rgOzf+Rg0bEmGZ/h9WK7JGty9bORSvj5GKB1D+LDZZv0v35VZ2cv0dLWDWv0oOKM1M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nb+N2FZZObjruN0dw442UQsC7uMtjIlSQKgHJTJfscADqbFEzgL2dcAfkXTm?=
 =?us-ascii?Q?zyXaz3jE0sGkHYmFPK21S5CxuPa1LXuybp+K2scm937eIdqyXH1XIKz9swfu?=
 =?us-ascii?Q?rA8LqxAuqIWbMFIbbC5UE4+Pv1+XmCCvy1IGPLZhH+JsfOtFmVcWDUSZ7EzS?=
 =?us-ascii?Q?opCioZJlOBnSvq08OGEV7ORlfto1ecU5zbr530FYYrJy+1qQUle6IkTmdC6D?=
 =?us-ascii?Q?zFkZQ/Gva5eG9RYFqcTArMMXGF4EgZLSQN4V9D7RXYomsUD+13bF+qA/a/my?=
 =?us-ascii?Q?JCdIxWc494fqTYddnPYmTYiewFw9pBqFpzZb4GEFajfFWMpYXH59QK3Wx4mQ?=
 =?us-ascii?Q?AxK8UEiAJWGo0CNeKoqKlscQbPEEx50kJ+HIwuko81zmu//WXP/wH0rvbINF?=
 =?us-ascii?Q?ZMgtnO0v5CkSRJ2vuxwyEU4QaSOwlnhXEzeCQoDUA/e0nr5yVO2qwKukJ21A?=
 =?us-ascii?Q?LBUlI68yW5HQ/EHAucghQI8dkzgovuChqG8pdF1zXWFeu7TArAzpPG9AF94/?=
 =?us-ascii?Q?JSCxCO2eTRBSJeGvZ7YgSiPlYC/jd6auAuln/vS1v/h08fwd0J47VSakjGyx?=
 =?us-ascii?Q?y2hTPxYXxIPbQKnmVjNY9A2T0QJUTrnaNwcEJ0J5iazvnyfbJnA2IUyOoZVX?=
 =?us-ascii?Q?qRTfJ47/TtBCbE8si6sSqqXky6h5Qrkj4WOHQJciZBYDzGbzzfs3nyw3zC0D?=
 =?us-ascii?Q?AHb3N+sS3B5gULyfUe2iDxEf3NReX0n9dQsp03Iy/+eHal0yufxGCcHuw5+4?=
 =?us-ascii?Q?cAXh6Q15I0PD1iZ5oFEMVtAINCX/T6z4HJ5PAmkBZSfyHedvSJOH+A200of5?=
 =?us-ascii?Q?IR1AvYAPTpf9y1iAeGaZTZ0e0HaOt61VvdgajeMuHaR1Arnt3FKkWeeg5Fej?=
 =?us-ascii?Q?Z0SbTEKwFGX8/gi+IivnDoNHq6WDt/WAx0ZmowEOd4rwW7gRvsN1yREPqLBR?=
 =?us-ascii?Q?BhYPf1/WqSupkxu/dYuy/P7eYeCpbtUSBsqwkU/uUX0C+syovTdcZ9WK+9/Q?=
 =?us-ascii?Q?TWlTy0W8HB/yxI97agRRKMDWTnqQFc07mODgxLNtxelseloKT3P0a8vF23Yf?=
 =?us-ascii?Q?soSJiaFv5Zcsgq+ozhTIhxmxH+rVdnySjlpt28Lak26+MMoOJRbUmY+mR141?=
 =?us-ascii?Q?/xP16h8PHI+9SNKeGmC/0GpRnljAM3zW+jU3sIrjeNZ8aFdGkPO/WgNJDNk/?=
 =?us-ascii?Q?FQVfboi8jKKIoUqskMrMlaTCc5rKrgU5lZ/ASgoLnYO1iCI5MJMyeqgJB04D?=
 =?us-ascii?Q?GvDaLgnqJR7M4dsRZ7hMdcmum6zmBZ+gUfEfWe1sDFhEUdKugRSlP8RjwlBS?=
 =?us-ascii?Q?oKlI662mL1dsc+cimWIovxfv2BMuMHQ9f7GdpRAE0Y32rCoOLHumctYMmagN?=
 =?us-ascii?Q?zfI0KADQOFUothnG2LTNwvoDHtT75+vO69J3HWimxrWybsqPZndflUAeIk/j?=
 =?us-ascii?Q?6cHYqIlFh68qvW7al4gmXmYJHojFmqezJc+W2/tgKWgZEbbQX9HupUqAoqF2?=
 =?us-ascii?Q?YaKaddFL7MAq2+PYuPOTRcOrIC5EgDgLBropexLEMsGYty5xiIEDDF6jahCr?=
 =?us-ascii?Q?UGrVzFJun3BqBa0HjrS4n/ysaR0DECeCoU4tGzbcmLxBDWALvjuKSm5nzgIH?=
 =?us-ascii?Q?7/ekQFD4pP9O1Wr8N5WD7+XAOkDzFKzIVGGPyHEFBUKHuhmY6TKt+d8+5/6z?=
 =?us-ascii?Q?ZDYGtL4tvJvhuVARyECcAp2xS10X0VerGp7g3xmqJun5zGQmZ/UyGAMdOFJD?=
 =?us-ascii?Q?e+6lEAlejynKLF6hJRRBUtvfd7kOfftSIgmUHcL2fURKf1CwRMCT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8ac6bd-4afe-4575-2998-08dee2410371
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:16:39.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VL9Wm1LFbXyNPQSQkr+fHpCG48PRSA4Y37zJWj93E0NFLUjIclw8Aijkgvz9DG6uYQVUbLoi/QW1VxlrajiB0MuVBlBtBaWZsaEGRy6h8ZiOHpeed2EHig9/E4uPxbq+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB12197

From: Luke Wang <ziniu.wang_1@nxp.com>

Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake() failures
non-fatal in the suspend path. These failures only mean slightly higher
power consumption or missing CD wakeup capability, but should not block
system suspend.

Also change the function to always return 0 on the success path instead
of propagating non-fatal warning return values.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7818f351a58a..290a3172931b 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2083,8 +2083,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	disable_irq(host->irq);
 
 	if (device_may_wakeup(dev)) {
-		ret = sdhci_enable_irq_wakeups(host);
-		if (!ret)
+		if (!sdhci_enable_irq_wakeups(host))
 			dev_warn(dev, "Failed to enable irq wakeup\n");
 	} else {
 		/*
@@ -2095,12 +2094,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
 		 * other function like GPIO function to save power in PM,
 		 * which finally block the SDIO wakeup function.
 		 */
-		ret = pinctrl_pm_select_sleep_state(dev);
-		if (ret)
-			return ret;
+		if (pinctrl_pm_select_sleep_state(dev))
+			dev_warn(dev, "Failed to select sleep pinctrl state\n");
 	}
 
-	ret = mmc_gpio_set_cd_wake(host->mmc, true);
+	if (mmc_gpio_set_cd_wake(host->mmc, true))
+		dev_warn(dev, "Failed to enable cd wake\n");
 
 	/*
 	 * Make sure invoke runtime_suspend to gate off clock.
@@ -2108,7 +2107,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 */
 	pm_runtime_force_suspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
-- 
2.34.1

