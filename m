Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1B3FCB37;
	Mon, 29 Jun 2026 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724683; cv=fail; b=FzuJ7G6oR+VgjMdsBeCWlwfxbAEXOhl9jmIfxPP9m8Bzfg+snx/YoQOA0WTtCmbaIetluaXMrWMCykQ9guxoWcgmeXkq8futF3bfCPJH/wZAJKwdsRta1+yef4LGQYlVZbp1UvGmU3qm8XFBjDlP8KS7YSRTXoCFs88pDbgCphs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724683; c=relaxed/simple;
	bh=SbmnSy9SLBfU/IX/H97K9j/TjIIFqLYC6ZKLnaIUbQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJTdC+A/rF5d2D/aKb7334AkDzYZtMXIzr7Pjvv4bLZBp/U6iwEItUKUfnY+Gj3tSopjOO+6P8eF2RJNNNCv8/eS9L2we9xwbBM3cmgKlK8sFD3L2EfVXlQftYuBvUjXKIwG8Goh70Rt73TemSR1zulF488uHJOjggIN4NiD2cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cqfKqG7i; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cqfKqG7i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/b2DvwyDcvyA7Bev/q+00sT6wowQDkuvSyUfMJvrrevcqYFOYij34tn2pA61Cx8DVuyD98RNy6UINDabUOoKi3Fc2KepYSD4z9gO5E2VZAg9envBsqoDTS3Oy2pHwYY8OIa+4mZsQnteMIgPaSpMLXyZtXcszmsip/Y0wGQqPip0eKhrnc3a2ijoyNT97xW7zbuclzLc4H4P1TbosvJPjrcWKBefsfNKvePysylI0hnshbJfvWIhLBY0h2qT0Zk7alNvAiTRMQpphgdglUdPvQPoz8WSrPMcqayXFE6/vpgaXT6ZxoORnLf0qNbD5vO9+9+eXfqOByAqbqx3xGI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHIEowEwuVSsZuVUAJyQO9z6D1unmgZ8ZMSWIYJWP9M=;
 b=IoH9y0QrHh/nHqfRKpIzx67N2rqnvMIWL4VylFmrbQnh+bLszGZyXITJ6U71yyz0ogQ4YhC3pEzrxlbEmGQP/zgf4OQmkifa6IeYmC3kWEH0TerlLaCo3QQE9CanWvnWKCyixZDIt7ftKCe3KsTELvn7UAswcp97RTs6juT/bE/F3f0iYhRE+s6o/ovYMI/BlLmK8PR74FN4sPhqzfaNpXbuO3zhPtyGwEFn/J7BbkBAiffa1guzDeRlvsUMfT4aZArDx6ORWodOV+On8As5BKwX9+KCE/C65ey0bGnQtxI/FKwNob7HrX7MsMtHmA4B7SZRrk1Yj5RNpefSWhYXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHIEowEwuVSsZuVUAJyQO9z6D1unmgZ8ZMSWIYJWP9M=;
 b=cqfKqG7ikVPOmYJ/mXVdna7diUA23KDzF1oMd1fh+Z2tY6BrOckQZBj2KU5qlzO2QTJcm/r+eOGc6Wv2qMMr7gy8Irvfsfa6qep25ymkzHlXMb7xzzVp2kC0JEO6QAS4CQ/qvwJQdXBjKxvWrZ0xGFxtTQ0PGeTJIcnmpucYHEGuqhrmWvYhZ+WJUfJYTOsBzcHpNxIno682FIBiHAplICCZmtvrdHkgpugQ4CllrplqNuWxsQ5DmNueWHWAhsg7xkyKzA8qLJgogvLF35mGxhaKeEecvv2O1EeJNtEhoNS2JXYGHqmL0JLlSEaxTVwow1OojpecWek0UApmZZBVlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:17:59 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:17:59 +0000
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
Subject: [PATCH v3 6/7] mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
Date: Mon, 29 Jun 2026 17:19:53 +0800
Message-Id: <20260629091954.3227151-7-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
References: <20260629091954.3227151-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0287.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::12) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|DB8PR04MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 889fa363-7f61-4888-ba23-08ded5bf4fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|23010399003|6133799003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VgO9ib8kctNJJjnAvpOpEPy7f4q+dPxVay9QJRHm6W48M3RiPj+yqbVHfEl0kXA/8kFCsFW5R1YZ/5oCWQNIkE4VhZ3zRRhS2bny3rikzVrisnMLyE0TsL2yPrXHRZWw7Nna74N89Xijl4EerP4S93eO89g7FwCBrxGj/QRmUhs0hNAIB1VJ+D5OwT9Zn0jHt17ylO5AZwCFKjIFQt5PsPHsso4K8dV0RX79LtbSjtyM+bjtq3gcjXJQb+JGehYRV/+L1BtWg7M5yS8QOAjCW0foWipw6TP72T6Q14Vey8FKT5yNWVnt3ebCNXaJ5uL0kr3Yi37xQJ/IjLfVekvykyESN6I7zkCVI6W28+Lp/QTgHWUFsxTNpL39kpqBly9u0RGTJK2mhyHJrsz7CwMny3ZdpnrLDW2WkLh73D50bpjhR3NAVOf+q0E8ILw2XncsD1w11XPySEmYxjOA34Z8+pEYqxrV1+nx/7PLkShgZm0LPSOYy7FYzvtF3P/f3rjS9X/DnlzkRES5ZctREtAT2SMY2wHXYBxcvRHzOpAzp6+mJn8QV0sz/MUXa2aV+eCI62FzlGVvZbuKVfzMy4vmjquZVGCE6venLs+h0swz+adEUPQmJ72aAYqzJJtSWv0DGyvjiYUTvt8UPOxaRoT12a3yLstalzS6ey3DMXdNgMQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(23010399003)(6133799003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1YNlo/HYL3krjh9HfG632ai80SlAz8J1deAcOXk+pTJPIGPqe8plwnV6F7fC?=
 =?us-ascii?Q?2DrZX1zHYc4NUHEN+nkdsPXUbTtKKZM/2Stn8IGgOagSten0tr9IBep+BFRQ?=
 =?us-ascii?Q?lYzqBdN9mUjUXdKVsAvGERqDt9rVkKE8UWK6k4XcmLkIpD1nJlbzyj8OQbz7?=
 =?us-ascii?Q?aExf9nj/kPRECXhK7WbqecOHYS1/U1w+m9B9w/R/RECD1oy0nFiw5W47Zcww?=
 =?us-ascii?Q?1oiulm2v7SDtach5Px1HutubtFwcGT81Q2bpaHYtnOAxfkFme6m8Lq5ARRQj?=
 =?us-ascii?Q?zxLjOL8HK/SEPtfH+BiLmkk96PobNdfDKI2hfuXFcKSjeKMWcmz7otklMM81?=
 =?us-ascii?Q?FDOdcXh1K1AZY5P5NXOWSlAbmScYgjswt/Pz1vC8F7WA5fK/fmY+hA6/cAGd?=
 =?us-ascii?Q?7wujHJkhUQYRqT0G5IiB8T7ttj8plzklUj9wAqAtxuzqJIPzB087ejLfqnSA?=
 =?us-ascii?Q?EmMky1QO9JmzNZtZyw2sTlQ8yExK4Fb7DESwvfGHebGuCYJv6l407HW39Elw?=
 =?us-ascii?Q?z/FVT1t66CQenHixmkalu95lcFh0akOJmS/z6tLhsb0HamypMQSIpWsKn7ti?=
 =?us-ascii?Q?sv3IGfGUuPR9me5/cgbXy7F8/64KxUz9Wt379UJftHrjxbIW/gDzP/PFbXky?=
 =?us-ascii?Q?ERy+o41ccUMc3acUbZDnvohEL8NwiODljYfr53uuiWOky11S4jiSf1mYITFe?=
 =?us-ascii?Q?3LXO3ZuRk8/JVkOlatt7XOjaJJ+oEeqUxxZyARC4UeD1GyubCwCpRgcH0ktC?=
 =?us-ascii?Q?0CXqQYq358MmzEFANw7SEVB5MiTj/I1qlAb5p+DwV1hwkruqFTzvnqpK5TSt?=
 =?us-ascii?Q?cNxRiWKqoLDzybY8hHWpB9jGHyx+Og1qlv2UcrXp3gOQq7DRmcoFXw083EtH?=
 =?us-ascii?Q?S8OYklVVuBxWG6onvddZG3mC1M4ml2/cShGCI+15pSbcsP/9seYb23Gigx8q?=
 =?us-ascii?Q?dKujqS6SDZXZ8vq6YF/2BZlPUXDGU/I+wI9iqDF6fiCQyCVs8zmQvfLLHDrr?=
 =?us-ascii?Q?Opz4TDwLqIDa48uB/IKpGXxHVkEx3By4IJvx+py4wIdGGM+ERAA5a4P5wBF9?=
 =?us-ascii?Q?79Jv9876BcOpynCpMtIHC5UAUya90xHt/mSC6On2k720lVZdxQezg6zgbCAc?=
 =?us-ascii?Q?VyomnF7T0WxN0nXmA2/NjmQUFRh0Ly1MFODugu4iV0E7nYThP9gglWOKOSeO?=
 =?us-ascii?Q?586Q5S7G0I8vMR2DgOLgr7tnw32vl8oNaQ3V/sQnbMrYRMPMhxuncAM8jJH4?=
 =?us-ascii?Q?FrEghypNpLM9n1xIZIeXicb8GTDBrc726wFdCKitHKJ1nUxVBPL4mVwOF8oZ?=
 =?us-ascii?Q?NzGNxCNPVBuLrv6Am4cYe8faZphlSM+2OsWuWXDjFa+pxFczO+/kaYQzcrij?=
 =?us-ascii?Q?2s/wHKnQAkuRcPcgT5J3XbBoaTDtlHNbtEOer2ahMHkkMO5cS4GBaNXnV8N7?=
 =?us-ascii?Q?onP9aYTmjCc8b/iTpVcul0a57PvaJT3EreBUYjByb24w228hCzTO1/5VV1+r?=
 =?us-ascii?Q?cTYmbnj/bmj7zTqpvHNJM1li4efIRWsOhy6jo4A40Uki4+zJnow0MkPlAu3W?=
 =?us-ascii?Q?6GDXWLxhTTte/hRlVxv9yDuPLHLHTpH+bwkOpM8bltsxkcVG31IR1/MAWfrH?=
 =?us-ascii?Q?Mdmxj4aiPLMSgfvsQa3Xt96ZUJWA57vcDEZhJLGO/uJbJ4JOCPE1QKC9FCqO?=
 =?us-ascii?Q?Pwo/d23iq5/kX2hnaz5cR1pTXrCEn3fwEodqMzk75Lrf+tYfXrji05PNUIH3?=
 =?us-ascii?Q?WhPax9rND9AL3afokTFKqrJZG93Khacp93YzWefZVie07ic7UK+2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889fa363-7f61-4888-ba23-08ded5bf4fe2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:17:59.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pwz67pY98f4yl0wudSGFHp8dzZc6B0/di/o9i1VqRvBoYPuYedmE5w9mucqShMBEQQivcseJUtM97jSuLvwwqkgaRCAdAJ9GmHHjahKfUGFiWlVCFJzEiT9UtQ17t7/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986

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
index 97ee3f933bda..abee3d7a07a3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2096,10 +2096,12 @@ static int sdhci_esdhc_suspend(struct device *dev)
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
@@ -2107,7 +2109,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 */
 	pm_runtime_force_suspend(dev);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_resume(struct device *dev)
-- 
2.34.1

