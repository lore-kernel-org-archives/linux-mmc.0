Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51E38B7B3;
	Mon,  2 Mar 2026 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772438372; cv=fail; b=akG9CTFaDmLDA0E0FJZ1Z4VAmFj+mbARgeAUDROgBBeMiGxBOwlaFg4xUY7bt+0r/BUwqFrT5bghG9HeW4RUxqw7Ru9ymZ69om1y6dIMhgRuXak1MxeSurWhedS4ttIqpkx/5lSE5/oWUtKb1YoNU0aEj++5l4ZBVEOTf1WEgZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772438372; c=relaxed/simple;
	bh=4eGM+l0k8SSP3Ngh115eACEfolOK3qXxOl3ygOjRmQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o38uSwLijwrguEJ7NcAbV50OB2hzpGFiKnTQCdoRFukuB6F++pWuwUt3yzk9Q+44EHy5arZKjrYWSHMtDRFxTKvT+zAaSoUlKd7LgUpOfAEf7dkHf/LsHyX5nXN7MAJ1CAO9kZhDQzDnE9s5mkGKhxvBwIbr0IbkW8npMHIqIhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=npL7Atww; arc=fail smtp.client-ip=40.107.159.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="npL7Atww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/v9w0XeLTS071Qee84vE3e+BGYgE3d7O+G13H3YJE0ABkHenLDUhcSJ9c1vyC5ynrjEdROcrFtisDXS35fICqbjyw9miXf03f30FIYmKdXT+euPR8lTfza8RmrvKIFz9OKWBAhLHAMY7uZVvgdfPFb/iGZI8TPFBLPmBxGLBU2HLhQIJG9SeTHXxmnC4lyVIFfESzZxgxd+X3MJl+fym/lFES6AmEvlwK9VI0Yf5AyDtRaquXVe0oR6BSZ5fAVJL0TPTBkj6cxyKn+WdAk4mrmWzDM9XAX+WjdkuaYTo83FjTg0KG3zbgwPllwqNPCB8QK6M/8BGY+19/5xZU44qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqhLgZk1nmKzgt0Du9FpCChPqnsLLiu91sbHtKq6ZCA=;
 b=ComKnogpNXJKT786yaYtuSzEGapIZ80tZIacv3phmHIWq/qmojm17jl1xggje0VNOtYCUovHPFJfablEZb3UPHaccn4nd9EUiwu91bXB0fRrZKl0/d1VZI0eWDeNZmSYBb8j+8A3HkroRc8gSznGl6zkOiz5+H12uoVZa3cZNHIy88Jk7bqglaJAju2eTZ2KoNTPWAtrxHVqJjmH8jq/xiDKWQHnL4mw9r8dXRGclvdLt2fp5iYVnQ/z4DUbjBXJToSrQKOF6VLxeIaiAntteFIjNtn2ATKLxl8HQbAjtkCsRk94DAPuvAwh6yItxbT+q4ba3bLKHVLll63trZ/+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqhLgZk1nmKzgt0Du9FpCChPqnsLLiu91sbHtKq6ZCA=;
 b=npL7Atww74K/0RT/Zx6fOGfBwJbKWjrCfuRe96jS/N2tiBnzuE5mZ4gtfTYlGI3zf7tFyQSeVd49ybvn13F8678pvkQMkPDKPkX0Mbd4O9ATXPPb6ivSKGkA18dxl8kf/MZ69Gk1KkCr/ihK5GayjPshvK5BAjH8RtqCEUVHZ1ML9C05N8E0OXhdufFVQAde5lfWvlW9DX7WDsKnDZGJZRog0RncwdEMlxPouaYuoTWdwEANA1xh4kmqGo77QgQlIO1FlhfHasE2C1+7aD9CNGnY/+0qwgRGCgeBojjSlu+ILnMVXIkadG9JWeSa5SXzYxh9cV5mB4wRJLWMpKYmYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA1PR04MB11010.eurprd04.prod.outlook.com (2603:10a6:102:490::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 07:59:25 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%6]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 07:59:25 +0000
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
Subject: [PATCH 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus width validation
Date: Mon,  2 Mar 2026 16:00:56 +0800
Message-Id: <20260302080057.974102-4-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
References: <20260302080057.974102-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0034.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::10) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA1PR04MB11010:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f7f13ab-6e30-4911-68d9-08de78319ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	OBDg0+4WBREiJsBXSqSgqTzkUxdMIuMgM0uA874gzicDpxzDR8jdPN91V/dRrejPWQPCSz7/b8PF1NRzrmZuSQQvDcUtKrR7W7qLjXGygTkRv6mIHUCymhmPKdLrYPTTZNCurvNoClM08DTxu8LwnjbE6rsGq+XjlEVbzeDLyLrG4qsfW9MJd7YSpV8pDaJeFPcmQO36nATR7Z0p/G56sbdf299mF4QEKa1ljan0/RH3yrP8OgoSmezv1gm5TyigmTCbmAvBYm1mYsJmdhsxiFwELxtQvlm4xTlOKnCSdrKIpvAJ+4KmtesHJKOoMAs1N6Dr8eNmxkrZxAG6DGCH09m8XU1JzZi6tJBJKuJA8KxVfz2kNVTTE5OIRfHy4UZWht6LaEpwPHXehNsbjKygCQ5n7ZHmreIapGmLIQtBcArFJihzBiUnIht+kDcnquulDsEYQO5kUeNW7No7ynNYr3LXEdr15ZCvet3MXIy64GSWbzP9xNKWlWY4B4wCS6lftXd1TIEDAkEjYenVK/qyfuLGandxfS10OjhnVJBC/aLQi8cdShxlp0dBC1lpBw29GWNHyCCpcHkiTgO5os0EOOw/MF9YdTPrgXRZnsUrenN70gyNLTOOCSPLrNr5qtb8zJ+Nt2l2M/aA2fcyLix3gPt2Lykn9YdiVbiSOp/iMy+MirSr3mL8vToHLhIFJIvGa02ncQTzNxwHWIbrsODTbJqiN6UmH6EF3P/H6sT2yDBB/zquEQ3za1JYHUXeGp+6L2dnj0F0ZzTXhGolmto5jH30LhFnY8KLb+n5XJKUJV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E2PW35DJrlbM5btgf3fG4xXXuKk4d/LoZBnfwnzAOg8aOtcjDKmo8K/8DuC5?=
 =?us-ascii?Q?/Mr29cZiCS6Td2/KNjRtcqOWQe9Zpr5IGDCIMwK5A9jE2KBmWe0uHl1LcKDz?=
 =?us-ascii?Q?n4GRXK+mFbsn9c/BJ1QMz1antLeQH16T6nt4ppjWCweus5xAFjkKqLe8BDQw?=
 =?us-ascii?Q?mbA7MIMKsDXi6TNoM6lyb3opYvjLERk43GfB9MJb+yFYSyGsh6kVfzccu+if?=
 =?us-ascii?Q?CtwyHXe6WIRQAnPoM46SWGsHa7w4A9j1iYPLlhb0PcnaBKNkO1VwOE6RxO+Q?=
 =?us-ascii?Q?4GTtq9NmjFM+VpIK6k9C0dZNw3O0pWbAoIiK/mxW92XD2NfdENPmnIiahh+R?=
 =?us-ascii?Q?NSN8aCoo0x1KG747iOPHRwJkHw3a9o7yRVzgnmnDmrqcbdPPzrl4s8sT8zIm?=
 =?us-ascii?Q?vFThYgA3AZrsLt1PaGXFU/IeoOkUMx8lpWwGY0bKaDZw3QoYXXfFwLNVL8GN?=
 =?us-ascii?Q?Y530beIaP315eRMhjjF6fmNg59iveaVU4SR6PsFaqt1uVO8nXRCgFof36GeG?=
 =?us-ascii?Q?ZsgscOTmkXWX+QDWh8OpQHsWWWwp5xei/0S6TkJXvIww45qPLnpKVPEPKGzx?=
 =?us-ascii?Q?K9NGXX7GYvAfYoGCItEvgaNBiCz1aMqCnGmVhif1kL7RGz3Mr869/6xvTooe?=
 =?us-ascii?Q?GHxsFU4awMpfiDBNgaVQoKP6s22T70c+375YNIOvFzFY7issZDJnmMc2nP4y?=
 =?us-ascii?Q?72/DJYsL5ir7oCJ4Ez8kZpXqcp4pPG4lE4CdqIEwQIh2Rl7ZYnMW/khBn5ce?=
 =?us-ascii?Q?/98C1AdarBLHqt6e7Ci7azaUm2bL3NAU19GWnQfTNvFXR3ELER6J2nye+qLo?=
 =?us-ascii?Q?fN4HVdlfXOAkL99sg9ukh1xWxgpbmvzFGXJIAHwKJBOpgKVnSw3MgNsVkT5S?=
 =?us-ascii?Q?+xW5mYpxk25bSTvAAw97PUOnciGof3c2n+0RQ6NBVaRfBe4frL2ia4ko3SDk?=
 =?us-ascii?Q?i8aOV40bvYrOjoWthKsF+rtadCCmF/5XLZ0sgZE4YjcDbtzTqI2ZKjRXBU8f?=
 =?us-ascii?Q?XWmg3/0rIlsOhbW42DGLGUGl8ls5bKp7sJB2ULJsKL8HVPeMGDeXhrX1roEX?=
 =?us-ascii?Q?zbyOiN8Vw6nlr99pqFlrJPulm7L+5RZyS9kgDPkSW9O8vXwkwxktDnlwOh2E?=
 =?us-ascii?Q?xKnhNhwKHU3fO/MLoTrGsJjR84MmCc4sAX7j/LGZgc911/OFvjEAQoPsZh8F?=
 =?us-ascii?Q?n50YL0orfS8eceo30rfklbN5W5jLu5hd/3XOZp29Z/mZVt+ZqMNVEkaO1KDm?=
 =?us-ascii?Q?ocn1eY6zXBNdzXK2VztZtwC5DL10GQXPfLyQxXw+Bj/lCbA1cU64aeqEvv/4?=
 =?us-ascii?Q?BAGqG6fr40FOP9npBGOBMAGow51hx+JqFBdHneWuxoVd89PGl3Hqd+EfjzQE?=
 =?us-ascii?Q?v33ArVksckkB3KCPgGp4QTmNTjhhhxbYmRO7JDLsfKa3Di0SCKYc8DVg7ix3?=
 =?us-ascii?Q?bUlzDepoXEzTdWrc7knJYbX78OLOIAGpPQt4FIFov5ZShAez7UxtgIHXjWUV?=
 =?us-ascii?Q?MhV8HqJwlKDgHorD3KDlDZDC05FU74tWT5hrNyf7NikMiWQ3ty/rF2m93l+U?=
 =?us-ascii?Q?60I8BLPf9rFRpZDfNLtmtiVwau/0QHRj0CKviM09iLV4IyNj+H/d66FhImDf?=
 =?us-ascii?Q?yxEkY0HUzopB+DW9wALl/r/cKJ3NpwsHkGuhxmhjmu7+wKzqm2Tp6ulZZ1Ad?=
 =?us-ascii?Q?S8qzS2u2hg4dDQOZaVfQoRfUZK66O+PUe/gYyrt5h8ZBumoexdsXknASGKCd?=
 =?us-ascii?Q?kXMPwWhflg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7f13ab-6e30-4911-68d9-08de78319ecb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:59:25.3652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICgiTkZ6VgtjmdUqbNadWKX3eY/O8IZTdT7oCBNvWo2cZ6JmdbuOWEaRxUVdOPtLxsSUX0Md9osc5tjy4Mg5Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11010

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

