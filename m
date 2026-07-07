Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7683F824A;
	Tue,  7 Jul 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783422062; cv=fail; b=NfhyAKplzU0twlMhtRBjGSVC1c1I0vnNbzoOO3vKoxdpgXrbl8Z/MG+Nq9A83TibU5fjPIuoHSyeCMcIB+zHUSa+KUOTQ+MjL3gi675eiEuNoPkrY3h4Zd+zESOoRRa2kRBcRhabs8XawJzLdbnDY5cG2dHZJ6F130X2FLpgPXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783422062; c=relaxed/simple;
	bh=j58Ice5CiFeYWcFKbkyH9pm9W2TMlV8d9vXs3zl5yEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIiMT/ODVO3uALWeo8vmR3FFqCq4V4LXnpLtiBgLiqAezKDk0lRwkTVK8FcqqZxpnPpPl4xBBGuw/NRM3fD/dOjjzSFzhOgSwFV7XZxmMXZaN+dUhCkhhhX4O6x7+Ggw9spJsm7HQ8PwGfGxptkhgqzPZWP6HpE7pDsvHvTffAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aZa/FyDh; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aZa/FyDh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmqD84CBaiV+33bkdcqgT+XyRVu2GMB4/CvwIdKjqlf7EFeqLJ4lbWIzl6Mi8ecvh2AjIGn22fcyU4vXfI8ZVQ6srlKwmIsUOiDrxFJZsvWdSMW7NFzSX+kQYk6SSkwMRDjWyp08njV/p+JhFrJ7JODGodcFxf3Z6uXyBZAbMZhhxHdVaLzwmXI84xAUyBMOEEdyzz7yEjS3SmHtxpnXp/yJuDMRitJnk6ZlqxxP0ohzmmJ7U1Zg4nAASNC6hdjYOSWtpQbnfz8dtpYsA/pToEtWa5pLfkmEiBnXis9sd6KzjOQGNwkjwOq1PNerJOPvykBJGmLA3hWogxrapgvAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObgINuwukCUtoGUugDBbMs9lEkfOkTzM2WzhNbfXz44=;
 b=MjxJuTQmLQEWKCjpy+Y2T75+tKNwCFJ9+ETNYYuc+Hh+Uk9txWpGruA1v0HIy+c8vnAvqd5tpLZxw8KW45jRifIn/Tz2dVHqXw9LOQY+WRxrG/b2vizT81F2TAg4uvgfo81pnx+ar8aeWuMPMHuLMam0tRJXTGPolw1jic2I9xFYqbn9STk/WAw9+7Tq9BWhNh08wJyYRIha33BuqOLzIwTmAdDj6l0rtxeX5l1x9mHnQS7p6lCpgXwXPPwTQV1sk82x4XgF7tbjOo3uJ0z35QQ/3oxENEemHl9E910HTumk5nz/0THFB0SfAsW2MDF26awRAIOwJ6qr+FSIehcPbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObgINuwukCUtoGUugDBbMs9lEkfOkTzM2WzhNbfXz44=;
 b=aZa/FyDhyGFzqu+fsrhc2N9EqPZOIK6zoH82s558OMsFbxI6gRj12/wzGiLgsh9++Un41AT6VFXR0v1a0ZcfgpvQRgtgLikL80BdmuQ8IgB2t3BANglYkYg1pNe3i/8uKemUwnqAVohlbn0EP9QObM/qjV9Vqv7Go6CG9OrY2S84F2rHhex7dmh835RWmBX22tm80nJaS0RSXW1Ept2Xepd8DOmsEuK83Yj4sxSQdjptX8VcxT/f1+c2GoKJqYdARIP8YwoZs+Ij6wcQxAebpSCPIcjX2ClvBK73Ewfs86LgwZKbtGJrswjCCQ8IA1K2lY1nI0zin6vruv/jh9rV5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by PA1PR04MB10673.eurprd04.prod.outlook.com (2603:10a6:102:480::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 11:00:56 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 11:00:56 +0000
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
Subject: [PATCH v5 7/8] mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
Date: Tue,  7 Jul 2026 19:03:02 +0800
Message-Id: <20260707110303.3779799-8-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
References: <20260707110303.3779799-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::14) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|PA1PR04MB10673:EE_
X-MS-Office365-Filtering-Correlation-Id: b811d8e3-6075-4c81-e286-08dedc170561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|23010399003|376014|56012099006|5023799004|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	uvpedKQw2W8ecpxSqy2w1Tqpbn9d3AI8dRIf/qTSf9UIxDfE/91yBA/fo12vVm5c0hamdB6IgoYpu8FNgCrq6vSARF6MfX1NNxH4BjpOZY3CzuPo1hCSCisXAuMfGrHnKluJgLJmV0ytvJi0O15dd5Hz19hT1Ki+TFHaY+RkA2JtPACNg/MF6A9Btojz+yqaZEu0uB8InB3tmvu351v0EEYp0O26sAtgUx3kp56s1gGSY429neybMgSqjRQ7WORa6K0aMe2J65zWVqXtZqAD7+4MWiH1YPIByeqemhyZXsGU24XccKJdrhSeO6lE4ANgdHEYWRQxGl9t3Z6z9sJxYCEG+xK0YesZTtbXtpylLbUCal3g2CDGsjyWn3PgR3zP0gcBZsYehv80cOBSBiPTQp+taRANtaw9mfnTHZxkhgqc9AU/q69KMe82zDMGOpp95GB2ITrLVn6FPAyLpFnPx03rGI85R3DmFrjmFkNIrxI2f4Jgo8f+Q7nnLC26E3BIa+jAiRiJBJ7J7cl2IE/Ydls05VLsBeuHmLPpRwMP6L4L59gr4YrJiQ/bhvl23Q4qLT6zUH2v9UN8kbiu4abY2RYSNVnQtWTKqG3DD/KRa+yyZbuGI01RvVirb+4SblRdZOLHHIepIuOruBw1zX6tXaQVEFnL1gnEsSzS1qaEM7E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(23010399003)(376014)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbGyYhhRisl5Dr8RbOoJn3bKXa3yPIU1j9VCZWh2EofmhCAMn0+6pyl0XDm8?=
 =?us-ascii?Q?i3OLDiliqzaYg6OldSC2vwEO7WedlCKqdEBSowvkIpSKHp3+/GoXc2MaBtLX?=
 =?us-ascii?Q?kueV7sxWmEtvljml0NxdLFKt4PuPzcljDasttXtPKTFPFCA2eAUSBvB2PGVK?=
 =?us-ascii?Q?Y5GF/8R72JV/IguFHItKQV8Kpr/Lm2xMD2c85WI09vvhMIYag2xqsyiXnXbw?=
 =?us-ascii?Q?24BQyyfKNU2QVKjv2EF2GJkHuHMpVmbPHGdNPnnRlNN54JYTuZSDteiiIR6i?=
 =?us-ascii?Q?EUTMsJysRuNA2UV1zWpbOD0hkfOPb5JXnlH93DeQc3lISl6ULiJT0SPL99cF?=
 =?us-ascii?Q?ySVFsCLJeyElNWz/qks4bNOy1jzpLrGxXvTtp3irtjiHy7n6Anh3zDAXkqxc?=
 =?us-ascii?Q?77J0nhNE3VakvA05jcQ2wrRRvTR0iAtT5hy2NC7kUK04vLA5d2zRtUXOjoPV?=
 =?us-ascii?Q?Yu7vl17BTooANT5kVmFLVYp7WIkkeSHG79C754EKhGmVAzuz1TBN9wZzKMxi?=
 =?us-ascii?Q?QG/W0I02QP7AKfKrEMKUYu//mFq0mGrD1y+q+5N6/u5VIfSgz9IHNxSIaHnn?=
 =?us-ascii?Q?M84aJggNJWb66UKQYl+q8tKFKQnOpl2rHJBZ2BoY0Cd6YDrKxGgiExQ0KZ4m?=
 =?us-ascii?Q?cqGhLAR330BYip4IVV8iMDz9bZIH1SLZ8B4fsQaKj4FpeHXT6gDAKn7aYRiO?=
 =?us-ascii?Q?kwtM4kLxR+Ooyu/6OySJsRQNWX/3EG34JIJLuy6bZgabqvfWgRI73vE3WQxV?=
 =?us-ascii?Q?n8L8SU1BB4fdN0VzKu603em3OVe63/LuoBU6HJVl4P/hh1BcbmxaLDmnXic2?=
 =?us-ascii?Q?WW1t5AXs7P3CbWMMXxOuNYkJZ6jM7toiq58jouWShX2uxDot/nNT31BDBSU8?=
 =?us-ascii?Q?DCSSwoXGww4MJOdIDLXSy7NmQ71bVoW1cMsT4qELiWJLOza8VwEDDs1FSIG4?=
 =?us-ascii?Q?7mCGmJVcHr6Jj1zhltfk1Q9QdWkTr/E3iyId8jXsRiZkz+krv/a9F/dQeqSF?=
 =?us-ascii?Q?mqZECq8Od5FVdjfyp7Txkpchb6w/4XKiwjLk3vSMDVVQkC3R0ubW3I+t+68n?=
 =?us-ascii?Q?Yc9/++2R3qmFjafUdM2THAv6xIzDLZ47D0ECdGjuJO2G9uQZ2SKAqfs1dXys?=
 =?us-ascii?Q?XQ2yTopdp0PTObB89LnLcikkzGujht38jE2NaSo/LHsFCLisZOHa5z0Fqvyy?=
 =?us-ascii?Q?bNxLiHyo73bYtMe7VkstF2p63K/Nuzr1nrbwUdJKVqh46p9vkfJw1xNFuiic?=
 =?us-ascii?Q?8wWnQHxkhBS2sjolTmtBH4aBK0rPbNU18ksv8p8H8rr+uDBCW3pGoZO4WIra?=
 =?us-ascii?Q?3gMD7P/KzK36RKDYiG7N8Aj80IYsQMRCj8xm0nHQ8ugdPzKOyBiLhu1ja4nQ?=
 =?us-ascii?Q?W5iz+4yV+uKSZ1DeqTvUiYZLfO9UF6q0BC6W3XFHzm+yW2HA5LgBKGfIIUdL?=
 =?us-ascii?Q?XsOqZdJA65PGMzPb9iF/JvZ7fdbDdQtdN7IzQJqNFvHymRNxLDcAs7oRd0U/?=
 =?us-ascii?Q?1U47MAwQqruWneo3z+R28n0x2Gtfe/hFLBtBy1sn5Ok+xvBKcMrD6XZoTjSs?=
 =?us-ascii?Q?9/t9QYAKwE1jXKIe6dIBUtpmMZRcNITWcCVcsH9DrStCvqtp66OfJUr/tqet?=
 =?us-ascii?Q?FJ0PA8R8orhGsIpzj1WNLMpcZopxhQpJfkqUTYjpZUSpzeOMhax17G9/WCyW?=
 =?us-ascii?Q?DOlvR/ZnIgrDmBc3HeTjXn1yS5ggmta6Ky8at4DmWslJ1dojpLFRk4LV4HHD?=
 =?us-ascii?Q?M1oeaF4JUAQsX8ONRN45L6IhADxlRKoIe5R5RNy8oHtmn4lW/dNgefg3wNiI?=
X-MS-Exchange-AntiSpam-MessageData-1: Ud2Gwopw/VU7Zw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b811d8e3-6075-4c81-e286-08dedc170561
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:00:56.6993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTgg/77xM0Lg8rx33I8mqRvDXxGqnQI0Mf8RxnFhZTY+LEqzdqBbYarltrFXV0ZUpJNB/uq28w4vrri9oSHpI8nF08vna/khv2tKqVkoCjS/62gnur7ZU6BORU0vW+5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10673

From: Luke Wang <ziniu.wang_1@nxp.com>

Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake() failures
non-fatal in the suspend path. These failures only mean slightly higher
power consumption or missing CD wakeup capability, but should not block
system suspend.

Also change the function to always return 0 on the success path instead
of propagating non-fatal warning return values.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7818f351a58a..6cb84690fde4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2097,10 +2097,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
 		 */
 		ret = pinctrl_pm_select_sleep_state(dev);
 		if (ret)
-			return ret;
+			dev_warn(dev, "Failed to select sleep pinctrl state\n");
 	}
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, true);
+	if (ret)
+		dev_warn(dev, "Failed to enable cd wake\n");
 
 	/*
 	 * Make sure invoke runtime_suspend to gate off clock.
@@ -2108,7 +2110,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 */
 	pm_runtime_force_suspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
-- 
2.34.1

