Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E907E345CAE;
	Mon, 13 Jul 2026 04:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917458; cv=fail; b=Qk+Le9TQVV4P/iiPAJqBbI00KVDX8v1xJJ2HiqDo4y4cRSD2ynicwZhyo9B9F7K4FluY0M7T2GJYNHpkFRefmg0CjyO5YytZkLhA/VjMRcnhB2w25XqqT3i+j2/3OjaYdf0j8B/TBDOLUV3rcOJyuYBmr++sc2r3+F9g7/eOnvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917458; c=relaxed/simple;
	bh=uD19VxJ7ii1NONeK7LdMECNxHHhlAnPGsT3KcHGNtu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciwB0ccDHenXCQYFCrNsKv2OluF0Kx93h/ajB3kKaHwmVJz6SzPx8aZaCko2tI+yLLy2y/nxTW98Epg/5yvn2Kl9EuAeRmBvgnEGPuAxMwCwBSZdxTQ8f7XgmN79fBUd9H+Uv8bCpbd+8I83Q5xiKYzhWF3EX08pLppuU7ENokI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jJSeXPiL; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jJSeXPiL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+bn3hyQ71lhhrZS+/QlQsqRT2Zk39Y9vQHjRll2CoTWgCUBKEm5lBTxGnob2kdOIMoM8JpkgWzljiJkzukmh88EDXtyljsURFNUKsnQ7nSAahoAlW10qDJQHsXteFghkguBqyF+tWe2Ex5fhEsrQP6D60AmIU82I1mrXNQ4CPnj3AiX2FCJ9woYwYNtC/yxXjU1v+v1SJip+ofb7sH60j7pwqO/Y5q1o7p2oQArr05l9qDMjjkpZOH7nmCDrSCiAVMN/9Li8J9JgzQOnNQm/eqSD3Sg2S6L2zgKnoZdctzGmRXuNAZwgIVhzfTgwr/IbhLeS1uOdtcFBgxvM1hE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ii0mNK3XfgIizUl+lO7fj3mWabgL59Z/6LNN24u/7g=;
 b=VCrHIHZ73+hEpziZq4iLSd4pl1WIjjfV74AuSS83MI0FlxjBcFLrK63SBz/IF2sVDnzuDu3M5XwUJtTGyUPp1vx43Aqtk4mev1vnKD44XesWU9CN7YMxeeg8XPVo6dQuRf1pmisRWFsnnqvYA7ziqc/xgKpF1rr6FTbxs9prwLkxPj5sMbDBZ9LiMG3nQDdqgfA+s7YluheKmZRxUyzVQcqRTtMjuKejojT1Jy5TKACmlH/xa50ySYQd8pZfH4VWSRXiYPcfKSGWdGzMYdWMdy7sjUfx28mHMFXeZDugz5H90idvyr7pldM3LBMZPVOirKYMIV//cd/jFuXO2qKthQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ii0mNK3XfgIizUl+lO7fj3mWabgL59Z/6LNN24u/7g=;
 b=jJSeXPiLcpBihllrthUEWzx9bNlCCNrvk/lLhVi08DtDAXDc1l2fFWvy7AIljlyUGqVwprxOKWdv9pj+YFkxb6ubk7wy1jbbN39YwhEziT1eWunW6o7F6+FqpbN0+04gtMrEkYwjcTuLXd+hns1xcWPZmxVEXtmP+OuW7rTRKY1tUcVl2GToybCjIqeEsLBMgcyX3PjE9xUL8XNTa/sXJVIVNeGrhJW+z0QfjsCxxVckh5OrRRBbZh0raS5aNwZNsMCZ4F4JHIpOZk+1fT1wPySRSrHftQzInfYmq+cafViEiWuW7XeUr5wKPBlK5yh0CeLfcZOqFw4eDYL9gdVNhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:37:07 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:37:07 +0000
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
Subject: [PATCH v6 7/8] mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
Date: Mon, 13 Jul 2026 12:39:03 +0800
Message-Id: <20260713043904.4144172-8-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0217.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b4::13) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8dfe65-39fe-43a0-c666-08dee0986538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|5023799004|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ccQzb92W9zmyXRKGV8tjVnCTssV5HoeiPD27qkGryZtbb8vWAlXG2kaZ3zoxQfknQTLQj40Wp4j46bE7Y94bn4kncbg6/9mW26dliQ0E5cKr5Nt8iKdGejP/UI1j2SoqPvnofRc4dQLJ8AH6tTMzdSpN9oV33WeVbu3OaRENMgTkSUnPFl7y3UZsquNsKn4D/bdh9FmDnsEewsNlQiN2n+zPk1zvvbhkZkHfFIJQE5obi1/BwSU/t19LXTACe0YJbecDaQVAdPKL/z05/DbJQZDyQYe7wv9pe1VBIeNy/hvtiECn5Dyj+IcPHn6smHoAkeTdaNadBTtBzSjUoajAXkUUIzKfh2tGLF1lcYY436lSge3qJq5BIOrvuAjunKk6tPSmR90f254G1D+y65J7/Xun3C1xJ96Vm3t/XGuJe8du37ShlVO5PdSGXgTtkON5GUOh+JOYRiCFk0pmnl6o4CmLt4bLePKQmHS7KriEAf/Wsc62BRNnhX1b08dzm0sD0g0lIh4W824Sk4UR3C7JTwfXcYw2/sBKzuPvK6z9BB5S1Wj+QL3EkkSrg5DTDBTIxtzU8rW65VhTZdQdSyfgC9RIU6VEadxo0rqhF27ARf9s8tlxBQoN6RbTRMiS+DEZKcynvXPW80vwi0RFOxTuiKknDHDtX9lTH0qS5OpILuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(5023799004)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UAGeWUkYxryv2a1XxWj7tHBXt81JAe1tRQboxb56/uYWzh/JhARY/V5X+ADt?=
 =?us-ascii?Q?FsPxYSooz5uuluOh8yn56WDLX34l4WZiXAXVYU3lw0d68c/VjKUU/ODX5txd?=
 =?us-ascii?Q?NajFyc54xwkd7sbzTqZtUGNZWRqYCtDRxSdjRJ65U08fM2/WgUJUv+aDXQJ3?=
 =?us-ascii?Q?krpdcs/p5pIYXaQfPn/thQGQtfv0fjzOjMvMzYyYPVQZjT939CEvXSwtbgOy?=
 =?us-ascii?Q?25C7Zu2KdIDjYul0IhCKa7NRBVyDMCnUe9N2fDQEgkOgHAG+jyJPYLGWpp+1?=
 =?us-ascii?Q?6Tdko7XPsOqDthx5DH2j+izMCDxaJpY3y4s4Mt+vUottIChrXh3pBliFlu7y?=
 =?us-ascii?Q?fY5oRYswxsl7LtN04HJAWtAgJfg2iaryJABUd9XvSphlcrxKUQQtdRDp7HJw?=
 =?us-ascii?Q?3Z4u24kb9dw35LDZeT9SR+F3CWtae6AUhDvqHQO9XeGCusttZoIcSWapml12?=
 =?us-ascii?Q?dhmH/jXi3v4/+Xoy9aJ9fKDi2xfwzsIF5z7g7oLRsRoi9iq++B+0hRfwpH0T?=
 =?us-ascii?Q?ET2FBikusDwtwks25+30IgqxVlGDrv/HpYGo9RjNe3OUhF+3qT4jr8nNM2ct?=
 =?us-ascii?Q?s+gANDUcGKiURcJDgq6nXpeBvp9iJyVg2rb8UqLH1zl+voLyPXh18R1cmWv6?=
 =?us-ascii?Q?IiJAK/Od+jZGOCUZ+c/vd4pIju/dGxcQR8ZswzrtgVG2ken4CObCbLhS/5Kc?=
 =?us-ascii?Q?ugrhORdymh8CLpCNC68wHXls30RGsGwMN1Qi4pJ8A5WiSb4AO8pjuEfAmF9Y?=
 =?us-ascii?Q?ox6jm8VUQe3H7LVN9LOStAVAF2RWKFZaIZ2tdJl6/X4spBj4OfeQ64k58K1n?=
 =?us-ascii?Q?Rij1JsojkWq4ID7nRQAvsqKVC/JG2O6RvenhvgcRjTtUapl+B5osVo4u73lF?=
 =?us-ascii?Q?JaTHaPp9HU6kZtmmwCQxWR99mn3Gf3OmMu9RQVi4mmdTpKGfe4otgPeBnNr9?=
 =?us-ascii?Q?P3ciU3Htq5z9mF1YwoqNeVwe1qmL4XATB4sIj7lI3j8Hqis51AfdLPP8oqUi?=
 =?us-ascii?Q?yu9xeXQJaPZhBgQ+rS5fk2mK6pjtref7YEdkQm2cAZNEpMmvW0RR8fofu8/F?=
 =?us-ascii?Q?hHMqdvtwH1m3QFmQSYCVJ54bTF5fzfwRyFNyh79RdfFOZ8nvbj8FPZ0eitLQ?=
 =?us-ascii?Q?3DcX6+mm5gNgir4p2jRYN553c+q6RiXZ8laaYMhNlNexdvWm1AZzAAC1pvQ8?=
 =?us-ascii?Q?BA/Ku/6SIiNTUJVVC3t4RvK3tuMIIpcPSkL2XSQXL0Uq2PeoUc3FRUeOqi6g?=
 =?us-ascii?Q?WQ3yOdH/3z2L6t+B2nEJnKXr/UluXp6CnwmutXT7BVTG3uZIZ1P/EloRx3ft?=
 =?us-ascii?Q?HmqX58aCM0dDLQD68eNta1ROet5Uj1r9n1Dzk+EM9dklVVw58gpo5njp+i2j?=
 =?us-ascii?Q?+KrY7tdHXjXK2K3D/ZiV440vOpgeW2KQX4Fa8JeQrSpFls/gyzUjRFuzLtpK?=
 =?us-ascii?Q?D7qr5gaSGFkJIQuh9/cUvJINcs/IEQd+JEDCptJir0nXc/KfBGe3aMxF64rf?=
 =?us-ascii?Q?z8DFGTdOaSZeKa+HHpMa2eQX6xDiz8rzlA+dWU4h9XurJiTrYx51SyNAi4km?=
 =?us-ascii?Q?uyn0sjEoLKCrSVPcqRZjAaAAOaZJ+oVI3oJyYpdPmkqi2KHK1NhSpEwxl1/v?=
 =?us-ascii?Q?kFdqn/hf5EOpXYZj3OhB0XKEQfjaFBrqpWpwS+Q4cPq2zIJSXQSsQFnhFnVk?=
 =?us-ascii?Q?L6CVY8Qh9yJF/KkewdMphBJuB0BzbApAL46J4WRg4cScL1UoUA5w9gMy4fAZ?=
 =?us-ascii?Q?poETrVnTgtTR1FAIni5FlN0UWLHZXe0JlqkmrVubWLj1WbGfTqS5YJaiZEU4?=
X-MS-Exchange-AntiSpam-MessageData-1: dBp/VXMGVD27lg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8dfe65-39fe-43a0-c666-08dee0986538
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:37:07.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KOsnhDv4La/Zsq/fuLDGdYomSdcEJgeMzU1wuR5fMEjM0QeLk7fLG1oPlAI5gwbGLcRTeCeauJ/1nOtS7Q1QhOSl120Bh8rI6WWWjPbhap1vEngZRP2r/FdL+A/T8PM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

Make pinctrl_pm_select_sleep_state() and mmc_gpio_set_cd_wake() failures
non-fatal in the suspend path. These failures only mean slightly higher
power consumption or missing CD wakeup capability, but should not block
system suspend.

Also change the function to always return 0 on the success path instead
of propagating non-fatal warning return values.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
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

