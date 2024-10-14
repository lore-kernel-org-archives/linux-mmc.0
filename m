Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F713EFF3;
	Mon, 14 Oct 2024 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728885646; cv=fail; b=ex0GZbm7/bn4uKqDSHfPU/TGnaWlTD//kOK9i5t5uy3mKaMqwr3VFUhOjHpmJvj8awsFYZYHl1s32EppmFd4CG6T2n8eXygM7UZy9nQvlZ5BZdfU5wZk7zNf/DyvSHKNAs8kMmWnaBr2Np9IZp66FD9eCJ4MeFaeYnsx28Yj960=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728885646; c=relaxed/simple;
	bh=rOOwKzF71V2MHYYPif9n4eDxZEf3Z1fTWh5YQIIjav4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dg8CkCkF2hjD/t1x1OtsW6w236bmjlqlLE9O0AT7TJU46/UP88ymhfhWRi76AS9UhRD55EdXxDNAtz7ODtEeAipM+AAdGAYQNtFNdeqWWifl449Lz7NyaakE/iJz5zWqcnSdsdMXk3LaPtld0x/aW3NIVBUz1weQIGe0Qu5vixM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DrXeqW4y; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DrXeqW4y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9DKM2PAGoc5EH2GdnHRh++0qG33L42K06XGYjHIkL/rp3ktuIxX5abyLCDVx+lbRkjxKOLVxr1ZLtPw3nO+bfE0wtE35z6yMPWaYlAj8VN3Gv/zmSNO7759+RLaQKbnrbo4kfrqyL4BqVx/+DaitZCJzwFgwbAagtBkH2/u+OqXtq1nxQn6nlMrg6Xxoc7BrEUVPpcOgy+JM7VxIE+GKsq9g4l8sKC1StvlG4BPWAAWkJXAAb+D0fkjozhPOLO8LflALzeZ49s3ClltaI1tOXKBOgIQGa8Qcm6uszw7jvPlXqCfzdz7ep6UAu3JgJUmZqUwcQoyZleBKSLiuiUPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEW+ck023C1R0wEnHSWTj2drmMrl5/32Ipeta6xg2yI=;
 b=I3pLm0aunJeFADpFkZOYyWPvPpUss9Ric9fK5PTJdwM6DCjtqVlQmZ0QaDWKnw4LDwxvujKSSlyThZNmPu4sNJE1GQbm0cTUbCGbDhOVBCdJKgY+Nr9C3L9Njo9cACNvWGaOShdp17MpwAn6L8Pbbsou0nhPQqkaoJHAY7ObU+9p+vPRNVyM7oh8eolaykD9BGtJ4zuWj0ad4EKIi77m2h5vb71PP5zzZXkzxwfER3mrUsaZddX9fVIWEcX/Rcw6Dfe/1SdEe30ua9YQm/gV0s2GjHlo9GZvpG3+uqWDJUwe+Uqov6PspIpzvVBE0qbd+cZQionGGSpNqL9OUCMjnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEW+ck023C1R0wEnHSWTj2drmMrl5/32Ipeta6xg2yI=;
 b=DrXeqW4yozTMksFF1jwxVdPOjw2QEiRxybyWmi0SBk2In/IWcJsmwttCQi2rzrxQREuzezLYuhSuyxfGcSpfJ2E80HQvBL7OIhTSxCSf3cEOlXuqx5K08QpCkx24UG63uFmbUN2Xt+wMmbOmwItmC0V/84GTMnyPuNBNNg3CFNYgUVyalDN4RGay1DtIcwp068DLNHzjJrmntVeUfllQlhcRrQUoKj85fe071VF5MCx5GWRY6sWU6BJ0YF71vJ1LEZKxiIFvN3DAeqYb1R3OIC1+3aOyhkymbgcU8ZzTfglVGFcsHIzPWk/MBBzrfip0Zel10+Y9ERmiS+9t56RV0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8224.eurprd04.prod.outlook.com (2603:10a6:102:1cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:00:40 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:00:40 +0000
From: haibo.chen@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org
Cc: imx@lists.linux.dev,
	haibo.chen@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mmc: sdhci-esdhc-imx: do not change to sleep pinctrl state in suspend if enable wakeup
Date: Mon, 14 Oct 2024 14:01:30 +0800
Message-Id: <20241014060130.1162629-5-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014060130.1162629-1-haibo.chen@nxp.com>
References: <20241014060130.1162629-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:4:186::16) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAXPR04MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c41fabc-9305-4897-0918-08dcec158834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aur5Owf93diMl1B6fs2wMDiqVo0+auyMxnjQj4qZkxBRLlx0OftoPXMX2unL?=
 =?us-ascii?Q?qri1ijeDEZscN3sIgnJ4P9ws47SySOXNKc7Tw8970f7X9R8F3g+9SpbgMoM3?=
 =?us-ascii?Q?14KhzY/J7hGq44gfRmnL28F+nQDBTtNjcSJf5b3QHNOAXPI832W8b8drRlCi?=
 =?us-ascii?Q?G1l8gR87KbBzc3QP8+GXDTZpXBt+HPJhZAxAkWUtR3+WjKBJQClVG+Mq3NPV?=
 =?us-ascii?Q?R5isI+aij3nEo4hkADIQiEiUjg2USra8M+UPNeeJb1fiBePXt6+gKvPedaWS?=
 =?us-ascii?Q?hI2ORTSilZWueSwIE2QfRqnhmA3sTfn3RAhrL5D25POe4nr4IDWOfPINUYqa?=
 =?us-ascii?Q?YdRl/rh1kV0VYsg8ebxVi6d52wbpvlKVXjyeVH3anxF3H7FQ8BK5xl8KSNrw?=
 =?us-ascii?Q?BzqRK0nX6lBGBaBPDtznPb6vKQYEowHT4eRl2vXNFaLPOgsj+LYLg8KQXZp9?=
 =?us-ascii?Q?15MOjRqUsigBP4+zjF8a4ZTXZpPN2Qo+BzrYn3H6tUpDQurBkjAMwcFVgCAn?=
 =?us-ascii?Q?cspmEEk0fduW8T3Z7Et9L9JkLt+Tqpx/rw/0HBXJBcWl2WxMethSbuGuT6Dv?=
 =?us-ascii?Q?rF44car+6sghVdagd25R3glh5PeScMGv+BgbykMMmB8n8siiOJTCI9FZucK9?=
 =?us-ascii?Q?0kDDkWpIqRi046Fhco8puY8zNTFX5c10HwRdBDY2BT+Zyq+XFSxW92R/JukY?=
 =?us-ascii?Q?dstQUFuMgEqRWd5t6AJVd4M1JE6l++htLuNDXjc1UltVxP+dykCxLGEKjilh?=
 =?us-ascii?Q?7Sq0dq/dUSaA/CaBiqW1IARu3jq8n80k9F6rZddnYGHr6XeABB1k8W78QiBV?=
 =?us-ascii?Q?8mWJwe2xtZ08pYB/uUJKWOiJ3i/56Y6X+nQ1AjRqHyb7Va3Ak31rUeRuQhQ0?=
 =?us-ascii?Q?5WOe7PAqW0Wn6Hehn6/2noFDiFhqoZ0lpuupyuh1GCvKh7vr86kDBaxFFnGd?=
 =?us-ascii?Q?twCOrDg2wekZmsdiGRmnAtM20JttaIt5JB2H0wnNlm4zAyTnIgSHSBipbN7c?=
 =?us-ascii?Q?h5WohBKKvvRsLZOfun+nh9kgW26TAMn5G69ZcePFtHR4M8Bu4AoTupnIf6Is?=
 =?us-ascii?Q?m0x1Jv8LLxmoWNTIiA3fIoulXD6n6HSPCl1DX+aBW6N+A/sqzExzqUth2Wx9?=
 =?us-ascii?Q?tVFY39Gnux67CyIz5VoqLvktNnUN259mwfN204ZRM9j6O+/X8hzx2I6fbury?=
 =?us-ascii?Q?k66gUxzN6z3KTQ9Oj47z4H16OTeK7KQakoTwwQX36FXH4ywcMgge8SC0jeCs?=
 =?us-ascii?Q?pDpBaGpWM6hLxJcfTCJWFnCtcVJqkgZ7vBkPxDMzSL5UvAceuLvPxvvt32S1?=
 =?us-ascii?Q?8D/SuWGDL20mxxk2gH/hwhvKE4d2dICauEK5MeZQLFDOZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PSG/rGY0w7+oR5llUDC3VTE8odkeM8GeP1+fjaTR9yyyGi2JrPl5fnOHj9u4?=
 =?us-ascii?Q?hfT6Tm9NUWZiQQQnOSBG82B9caSoKH0YoKuuhy2guFYJrsKtJfyvQbw5+0JE?=
 =?us-ascii?Q?OTJexn19k5S0FrBQNiDTd5cfNQ2euQaP8UudWXvkbgb60qlVZd+XI1dn7llG?=
 =?us-ascii?Q?a5nUNRBaMW7x1iuie/GtaeL3ooOF0EnlJdMIOcEVV6wDJ5w/5WG+Rc8e3ruA?=
 =?us-ascii?Q?RO4zh2mA7N8RiOVI8v2c+ZCVSqK2oDtrIioga+Jgx9c6SlpC12sPg7rgj03U?=
 =?us-ascii?Q?ghLEJ2WgYBRTxtSQ4tgILw6IjxikpOL+Mgql/f+D8r5smm2yqvyp+3FVxpEv?=
 =?us-ascii?Q?L3reKCAIvAk8E9yjTZ1KFVi4xIIkRXVhjGF6Oip8shbvCkNYpmIRTo2kYKsX?=
 =?us-ascii?Q?sc9AcDuBXDXGT0WCCkJSfx28ZQWt+5cWUwjt75aYIEgdoWZJMZnXltcaqroP?=
 =?us-ascii?Q?FcJ2cfo+jz2BK79AEKoV5Nqlw45z0xi1s9RzzWvxciVCpwQNp+x75YlY50FA?=
 =?us-ascii?Q?egOCZ5oHyHsvlLTz8kR5Kkhwr6W3PZFkWOhwdtcdaPl1ds8m/FCN21FiFndA?=
 =?us-ascii?Q?5zbQ7Z63AucPZzu3iNh6oJMLUFXE0EO/+i5hYcUcZTMo7DM0iRcZWM1gu2PD?=
 =?us-ascii?Q?gpMIh+XEMomIyVdC267HlZ6TqCvnclq33F1Bxo3mQI16RaAImdUpClIVE4Ic?=
 =?us-ascii?Q?dWrxTHeDNSd3bjBkldsK42iWQfRPe7FYmZTJfx3uDInh/hpKSqR2xoHrL6A+?=
 =?us-ascii?Q?kxuIRgmQ1RfuOsN1iFiRZ6VFpLrnuXo76qxbQBpMevfzrqO6PjpHIjutTlbX?=
 =?us-ascii?Q?6V+hK79O0cCJqfEk4IzZeHeRMhg2Xju2mBUqtvpwUhhEvgT5tTlXXNyeqp0/?=
 =?us-ascii?Q?xoBJ+aXpm+NdtNzaJL16xH+4i8L32WKUtndTG0cJIlvIVYHOmQIBItEP+R3F?=
 =?us-ascii?Q?p910YhV1wSTADGm0f5aEK3CpYOYDtodaM1/mrEJGw1tnsUamctXxcbePB06K?=
 =?us-ascii?Q?HajYHlXVZLRmo+TKD12PXZPVVQ9FoVJRre4m1LE53UnQ+OnhP2qqBxef6dkl?=
 =?us-ascii?Q?iH3FEG9pf8ytDYRdtgghgL+w+jyuItxQnVSRi5SkVVukNpoJM/XRLHT1rUIx?=
 =?us-ascii?Q?nqaJSdDQcUbCfxBpnTyQA8ibaDFoyr/RLTS259HFTvE1MkX+UZ2bvHWhUc4e?=
 =?us-ascii?Q?zIosIc3kbfXMEp/7Ff+H055ga/kjW2rgY9wKqBuYkN+sRRu5AZ1eKaf0AvJd?=
 =?us-ascii?Q?YBDHaHYEgQNrgG4/bm5cSPE70Rz9DkP7pOMM1PRjgB7fQ9BM5wizOfzRhi16?=
 =?us-ascii?Q?QyrLboZ7uhH3iIFPIkSLLg3ayzDVnIkzWe9Te7ITivxFAGowkp0Kv0q1KaH0?=
 =?us-ascii?Q?O2Ppw93hwRRxfi+8bClUrDWKYycl3gGQBTJ3wKZ8wFC/xQJq1tN4X24Tan7S?=
 =?us-ascii?Q?Y4O5GFbkFScJ7fH8Dp92gI0kajyY+0Ec0kw2oyr1YsJouUpWGUubg0YFwqKj?=
 =?us-ascii?Q?XfzRdeWhwJuHYTetQ+bNOofyRQFEB6DlSp4RZCvLumvgrQ52SNC28gpAZ0MS?=
 =?us-ascii?Q?yzQ+PA5u8DAHuuneJhlvgyKgjgdws+0Sur5KWDOp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c41fabc-9305-4897-0918-08dcec158834
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 06:00:40.5857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r875Lh6Zi/vchDxp8itrWhJp+w3WXoEybP1vBuwk08AMJm6DNr7oCDN1A/kMFiP0M8EYVvsKIOGtHQLpkX/pYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8224

From: Haibo Chen <haibo.chen@nxp.com>

pinctrl sleep state may config the pin mux to certain function to save
power in system PM. But if usdhc is setting as wakeup source, like
the card interrupt(SDIO) or card insert interrupt, it depends on the
related pin mux configured to usdhc function pad.
e.g. To support card interrupt(SDIO interrupt), it need the pin is
configured as usdhc DATA[1] function pin.

Find the issue on imx93-11x11-evk board, SDIO WiFi in band interrupt
can't wakeup system because the pinctrl sleep state config the DATA[1]
pin as GPIO function.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 4173967022d0..d4bb23c9e866 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1969,9 +1969,19 @@ static int sdhci_esdhc_suspend(struct device *dev)
 			dev_warn(dev, "Failed to enable irq wakeup\n");
 	}
 
-	ret = pinctrl_pm_select_sleep_state(dev);
-	if (ret)
-		return ret;
+	/*
+	 * For the device which works as wakeup source, no need
+	 * to change the pinctrl to sleep state.
+	 * e.g. For SDIO device, the interrupt share with data pin,
+	 * but the pinctrl sleep state may config the data pin to
+	 * other function like GPIO function to save power in PM,
+	 * which finally block the SDIO wakeup function.
+	 */
+	if (!device_may_wakeup(dev) || !host->irq_wake_enabled) {
+		ret = pinctrl_pm_select_sleep_state(dev);
+		if (ret)
+			return ret;
+	}
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, true);
 
-- 
2.34.1

