Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33D386C1D;
	Tue,  3 Mar 2026 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534907; cv=fail; b=F7al2ul86DBn1LxpUrgdHxWARjFLQLQloJ5v62/yNwCcN1QA1cIubUn4qWehDR0ldtAxCNKS1neegcS9irIi2BW2xRl/qb5kEGl5el7MY+anfQA+s9qlh9yeeW+yIwd6tr4WsXm2nBOoQWr64SuILvEI9mM7bybJ2YQzURbO4ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534907; c=relaxed/simple;
	bh=4eGM+l0k8SSP3Ngh115eACEfolOK3qXxOl3ygOjRmQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TFUDHhL2lVTVwi64dZ+AonTqEXvQf9ohGlODMRtQx+Pes0m43SsKiLo5kvJxC4ig/a0KmLDOaK8s3MTiFSWSdVTJ5Zcz0fHRRUxBKXbciUGruwQZUcjXPUkN5uMKTljU6I1Xp0GUr6uY3Q/ndqGJTiFVTamGFtxJMKL0rJUxj1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i7d60oKT; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i7d60oKT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBWyJjnPS0Veu+wa2bkT7E3djeRO7Hc7r9TQDCI20d4v4ystEsofFMNVQF1NS8VqCmM29kv3D68gBi6ucqzTMvjWFH0ak28GKhe424SAnw4rPejE1rAY5NgFVHadsa+jhF4DmKdonDSM8hG3+b0Ju07wT9Q43G2AFShZTZv/X3mExX9nJzbfjwDhSWmajattQ13vcZdn/KichoOQl29saktosBZxOHX9r9KXafY80shMxD5XW3wbBWK+512OoA6duAX3eq86fNHOXj0vznhA8b6pKpjY9OW335g4jri+oVFUExfKGqUNWw/Dz4ZnM2lfvD0uyJwjMAfJfRA4j2LAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqhLgZk1nmKzgt0Du9FpCChPqnsLLiu91sbHtKq6ZCA=;
 b=bV02tmPRyQd9NgrqULFY/Fv6Fg4V7E5eRbmjpHI5xxMkd9XxBp3MzdoBNaF/GIZcUzJw512vr1t99XwRfoMVLIBK/W+D6uKypcCP9V+BFVqq4qcrAOwJy0KP/384MgWkSl81S+LTp9xMG+ORGM9weAy19s7+ewLWM5s+BF6qLbIlIuibVP6UBkH77WPxzl/yaKQdxkuhkNaCK4f2LKuRpLB8+ewCoLNuAlel/UhHSKlZIxgON45I2pTTkdez5Kmp7OnQsYilTVAQj7pX/7nzwEnUI9ZlB9D7gzsTMP9cOTy1+nNOgISuILNLJUVO+34VnaIHs1sBU+ZugVEHptYioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqhLgZk1nmKzgt0Du9FpCChPqnsLLiu91sbHtKq6ZCA=;
 b=i7d60oKTKWbNaF7JUWEB9LEOTsqI9MBmpXAHhlwFuB9TDpBaT63KGSvqqqesNbrIC8nguzIsQOnsFyKpiu+qWkwZKvs0PchR+hFD7bQQQTubpQtxG9OAAkUaMx4QYcK+s7nGzZAceAr/N9gpWI1jLnZxv0oD3UjigaejoUVNBEkzDyc3TKwslZcW1dK1+IRLtoMznnG3sOKDVLzlF3FxUSzrQm1q622Hgy/4ln+l9hQG94d2l1fg9qJks5mKU8+WXKr/FTuto0sYyCsABh3Rt7jht9kZqJIRppR08H4wk5ta5fHE474Wxgi+525Snt+Q7eye58iAjfDuJHifykCTUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU4PR04MB11926.eurprd04.prod.outlook.com (2603:10a6:10:628::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 10:48:21 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Tue, 3 Mar 2026
 10:48:19 +0000
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
Subject: [PATCH v2 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
Date: Tue,  3 Mar 2026 18:50:05 +0800
Message-Id: <20260303105006.989339-4-ziniu.wang_1@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06d92596-d7ef-4bac-9858-08de79126210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	wf+uW6KCMENYltS6b/3t5rg8BUuEzQzs/OEGprzCfXL7pvcb/ufaJjcQ+ofVmUOOmI12sQOCoQ+lLAfqrx1Riu6JCELUPUj/BosT7VBLhEt+oBldO4QGwWihvajK0mzk5DvAQsU3ARetIK+VpZ6V1QDryPlJH1wvBs/YD+KCiS2wjyANsIe+jzVfAxHQl2RpCN0D3p1x6LDHATlffek3urVVhuTcMAuLucwUllspFNt9/hPv/FBdl7lEzVF/u1vxCyzL5iZNHKAYhamqrLcxkevkz4BrrAZXgYA5NskCOhDhsGeWq9vUjZTDyK4/GGyhUHNMwQCKGd7K2+QLDT3hWBz9jOfaEGO0l21Ypkz0s4u9HOOUuW8ZWr7YFwRW/jc6tZAmilUxcqXZAp+K18mHBjt1YMZakPR7QXbs3GE5skD1f4ynqaE5GjcSplYDyoTvoysddaUIZbcwQTJIhA8Xp5a6JcepIxOi4F0SRTB9dJ8mmcPp1wOlE1Qnq7Xy6FAc9T5v2s1oTaIY7poRXVEYPXAGysZRMk6YdckCZzn+6QX0MJX7QHTKm5o+AbkDt813E0MfiIoIPeGX/D/LGacVb0G2hp5/ckYq+4DAGc6uYFmevvqj0riSK9aQFHLG01StGbHmHB/gZrlHcp0iIhOICsr5jL446iiJAKK0Uj3B2a4UnUsi+vGhzywsC62zL8XVAUOfA9kYuLc0CrB5jAVdjQFoVJ+MIf+mWupKe9FL8zh7PM1fz/gFKrfyfzFGyCGIcxygV7CefvZHiz28WkYbe/7t3cGd8DKTvCx71Em0D1E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFii9CMezfdl/r6ZJh/QmasVTme0Ve4jOKIABTeVDourf43fX5BcU7VQd3zM?=
 =?us-ascii?Q?7bq3qxvuLKq/5mQoZE+1AdBck0/9+w46qrl2v5Qi1TqSJc6xiQ9w8MD73Irn?=
 =?us-ascii?Q?zv5YSQKMVseopENAP+mVQEGnwzQNZyb5V7bpl5y6GxJu616+7KfTMJoG1hI2?=
 =?us-ascii?Q?LramIgNOimpn1Fi16CTOrM7yIbAUnJ8lcYHDu8sy2q+yKvsbWMPVGgCeMomh?=
 =?us-ascii?Q?/UDVPyJ1koRRPHEw9mR2py71AI0kgH0UKNIUu/s6u/x3rD01i6dupwxwtcJQ?=
 =?us-ascii?Q?Q4XtYsPemY2xeIFF4Ba+xl0K/HaaggnOP2AXK5kklyO2Dsb29Gv8M1ZNEc3q?=
 =?us-ascii?Q?piBED8ab9FxMCWqUUe8cwQsJEOp5OOEwP8FnZmMHdYmQjc9yZUey8UQpoEVk?=
 =?us-ascii?Q?z06bKjfUj2HlQVN5JMsKCU7FBFAURppEGIsdlUUdYnKkNCD7QAOKvNBlaBnS?=
 =?us-ascii?Q?9Bq5Jtx8ET7Ipjm+m+TkHv7zdqZvUctzb8GPyI6aGDAA5nAIOlwPGFmW4F4J?=
 =?us-ascii?Q?mnc2S59GRbZd5wumsaxxarpmi9VZueZPM0BJ24DhMNVs9C94nJJ0iXJPU6zh?=
 =?us-ascii?Q?9vqRp0PNhPMG16bUAjmqtvy36Xq1ypvFcAovkIfLXDEioKFrQeONuLIZZB3n?=
 =?us-ascii?Q?V7M9U1eG+LSipqA9ZmXE6yhee4x7v7pQWyWtdgd53rzh4pf11zFJuH1i+4Z9?=
 =?us-ascii?Q?VZ528RlmoO/9CBSBoTiEmM6I47/1A5n0rA8Ea1k1T6Bg0Km3m4cQc619VsQk?=
 =?us-ascii?Q?5mDCdVt+A4QVTmpvrBRf/3TYkfPc+UxduzROdIwOesfH3pC/VKfZi8z/gWX3?=
 =?us-ascii?Q?pwhIchczDLNRsLaoELiUV5or9P4Rof2ep7GIlRLVwhg3FqfAmIs2HGJ76dr7?=
 =?us-ascii?Q?dHz7NYcgIPN34NrrvztnHf/3YdDFee5868wvZVn/vivDETPi9duHAMOuoGAR?=
 =?us-ascii?Q?s6tERwtWGiSjrzeycN1XSxcE4bG7s/aXpsR/yTw9ygnlejDXGJ8P2xWyy1Sq?=
 =?us-ascii?Q?8z8KMdzWmFLHjfLYlvFelzVwKwxRDk5CzKDRxijvZUxn33pv9LRFgPoxQNpp?=
 =?us-ascii?Q?GmMDCspjhD/rB4/wn1zZfJc4Oy1NpiT0Z4Nn86rzoJLbzlbVYrPQNSjzPW0V?=
 =?us-ascii?Q?s2hMwA9ydsclffU8RvX9hNFkciZHQMHj0lFpJ7BOYa3KBgOog2qTCNrP/kbK?=
 =?us-ascii?Q?jfh3B+0hPp7mGH50nP8K8IU8bucuDZOLrUW/6zer6WJr2ZuNu9GyMu83uxNu?=
 =?us-ascii?Q?yP3usbfbOeweap9Iq6npWFUNQfh2ZdHdhGGCP354qqW24JK5CTNYU81OBuak?=
 =?us-ascii?Q?vxe70IOVL0SeM2q5UsTS5lhyGMTPZQLyJakQZ51jTWCR/aAuiPEetfwLm0b4?=
 =?us-ascii?Q?bnKEby5sRWOD2TjFeWgm0x9tGrLUsQx98e8nd4LhT3BR8UcUO1oveTkRxLGY?=
 =?us-ascii?Q?5fvTR+0PBzsAl2fZAt3frx1YcLebpEmM4rOwxQD38skvOlk10tH0wupLK3EF?=
 =?us-ascii?Q?F6fb/TOhIpFpDzv+IlC7FGnguJcwmqQdsVCETw5c6zYgbWgR4X4WMj7Zems+?=
 =?us-ascii?Q?oT19uPjtu8iwLbH0lzMNuXjFByOG2hnTEMMYIhsTYgjos0/y7O8Nm1SP6UWn?=
 =?us-ascii?Q?8Mg55k45zt9g114lHqbSsLmh+DtW24yOwsw3MWM/dSWe59xAZU0WihMqcJqB?=
 =?us-ascii?Q?QrH+y6gMtPdZ8dBDQnCQhQ3QQZbUdlLzD81lDq9iMEXkTQQJiXZN+Fo0F0Xc?=
 =?us-ascii?Q?gA9rfXzFog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d92596-d7ef-4bac-9858-08de79126210
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 10:48:19.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue6VZ1tMYA7XEtnuL/LnlttOIx9TQa0b4DVabJdaOoRZH2Ig3f3QnXsnQda6VDSBqo/4OaSnamO/TL5+N/BeaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11926

From: Luke Wang <ziniu.wang_1@nxp.com>

mmc_validate_host_caps() already validates that HS400/HS400ES requires
8-bit bus width. Remove the duplicate validation.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index b607d4ffc562..d49069986efc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1833,10 +1833,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	sdhci_get_property(pdev);
 
-	/* HS400/HS400ES require 8 bit bus */
-	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
-		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
-
 	if (mmc_gpio_get_cd(host->mmc) >= 0)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
-- 
2.34.1

