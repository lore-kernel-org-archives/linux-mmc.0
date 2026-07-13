Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013039.outbound.protection.outlook.com [52.101.72.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915813B5B3;
	Mon, 13 Jul 2026 04:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917395; cv=fail; b=S9//gCTBeuuGlj9PzkGa7ab4olYNgbLNLuj977nzgYkps7br/XQFpuaz0Z1NiXqweHZjInPXQdPW6Dv8AatcpSzQUvwG/OPL8cQuWfN5YWnAUGWPl0LEICrnr9UWqQAlW/Z2J3JH/MIBEVUNcjaLSb8k3q9ZvkT0/kTD2dCsvQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917395; c=relaxed/simple;
	bh=ZUO09b7tKfEkNWM5qiqw5iEY66SIIuj5DsXGQ6bA3u4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nlJ3vMSX1PlZZQSdstL+LH9jcLQ0PxWGiw0SgbAshKDdemc9X6eYo5O30dWLAFHgVBNMv7xrCq8HjnMyV17BmpgFE1BXZ5UGYAQE9oEkha8GAa8Oqn4JT/n6NjsbsggybQjLeUwh9lCopE/pGluj+JSPEFzg8tbHFdsg+zQRNZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bo14MFq6; arc=fail smtp.client-ip=52.101.72.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bo14MFq6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vx5DFrMx6Spzw9TKLw6Ac7HA3RlMMYH6msXo7xHQ7ezytxtwIO6NSVk6WpolZS+9syuZkVDrP32Cmkqrtc5rpRLQhabJQEtQ8eaEaNgOGXCO55aL/av9gUAQQc7ZGz920N71BKWJko14ZyN0QBuzQlBX9eRCj4M6iw7F07JFIsSOOXALRQAwEbZl6rsarcxGd+Lle5nCSmFn5urxTVP20SqIDd/uPLDpycvJz3n0fvRVmh6oBfZXXjdFV4AAlnPsgYURrQY8vLvWeRS3ZZk3ebixgw9Q9ZHkopm2zWfLoha8/hvzCrlqjvemLcil4GkQynJe5m2ygBP1hDJ7BdzDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdLDYkWyWiJ2CTqf35B3bvhbjM7PIcSppgnmNL/kALM=;
 b=kKZ3nfSGAyxSLxok432o+wC+42h+c0BPEPd7LtZBuJHWB7n2TG7w/7+VhE0F597G6Rb22eJEFHxktab7+8kEPgIAeeUPDtrnArLqgxu8MQxGm8gfwi7AWx5qWLTCmqMYlQXdd+y+dUtAY2I0VjSdZDUPRoFyX3ECQSLn73Rxn8h267yA0SNqBCvjuSt2fbrB/U4Mq4hQZJwucaqufWIGm+R4hFgRS0H7UVqb3CAfF9Mywrne1xsf+BVgUN/XwJDXaCijX2IPYa8YQo5Nk8bvoBQP0TbJ2iz6y4MUUShCmgd6Dx8v0kvQzMz9pOvbU+RPeE/IUitZVyQShpCpJ+/4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdLDYkWyWiJ2CTqf35B3bvhbjM7PIcSppgnmNL/kALM=;
 b=bo14MFq6GFjTHtCJimtTsWppRp7oe7ZF+Lr2bCQm9UUNBEX9N9WQ6A/v5RG37vK8T2Ht6YqD5T3REHF6HlWygRBj3pctE8riqbKK3BuYSJaL05yCfL9HnnU+hTiVeDdkm+lgrZ14AAowdVLubiP+6hYIkRd3Ld+DarcVKxszLzYzfIVPh40ASp97fg1fJrungnROesb1E2W9ghPWYX+vzQHGnsUKKk/VnJ+wvQi5wDKT/LdzYnu8ZimHNoSRjW+jx3Z4LgVmDXU8Ii3h6EzbCVMHMiSYTExBbFE24jUekF9PIoFhvdKScBLHHjxH2dn8LwWXMGNGYL372ajR3cIhdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:36:29 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:36:29 +0000
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
Subject: [PATCH v6 1/8] mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check for tuning save/restore
Date: Mon, 13 Jul 2026 12:38:57 +0800
Message-Id: <20260713043904.4144172-2-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1c67a9-3cd4-4189-bb55-08dee0984e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KUDiL6K1OicG5TZMru4oyK2WWrnEDSptJmZ42VLWK8+u0fZgTn47p2r9JnBd4gLrmDtNf2mkSi9LWtdxBIAS+hZP/JfNvCwUGH5kDeFfry3w5vb8m8PAdUoxTB9FznpR//s9z8lf/+2Rm82ZdQYKCIWPfTFnG/QSOKkT23pnvzRb2aPjyUkwg4zJDZvvw0amE/0BXUd6WMIbdSj58SUqmxLVGOJYUUQsNQo5xFIKsBUI6QBNSFAWflk2lff18pyQM1p8+jptLVCg/2hhXBxH8asQJh2h138lmIuLkUsRRrOcoMDP42w12E+REp1mx/rbwRwmsGRTm4k2BA9dBSP+kziODcnflcxi6r2YWX4oSfLONVXEh7hGoGBzi6gl1p19I6sjQHucFASzAxcy0YUSuYcla/8iw/i/blaXD4yMXqs0ZlD9cSwkX9hNYg55QxjzBOYd98KkxZMiiUT8U0wN/JRRdGPAi31zbkkXKpWK5KwRxyLEmsMXit3zeRYyyow0JkuhbtscvQahjwnTy2SOypKBUPWXNyhMRugUAk7lAoG3TFHWid9jLkuNDNuoDxMorJofANGz4PVFon2LO8CnJt0TDZeWRDTsisiR9jMRzOgUitf1By53o/G+WNbXiusV+2hEEKOxmNXjr8eKIcheH+k+3Ut4InZM7B/bJKsxFRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHoqGB5XVGykUCgM/WZrxumHswmvMaC91tIXKkiBIlHC1jxFLYRMBTJ/5wJi?=
 =?us-ascii?Q?9BbBfBDnZYThkxHmEyQb1tbLyqot2UXJOXV5jtbhRUWwb/66SH3oASI22rRO?=
 =?us-ascii?Q?l/TAOwTBzNkpGSp1jR6qhURtnjXJ2ShjdtxLqnr6xNhdDhjETiXxhJohI5hp?=
 =?us-ascii?Q?4C76yACjpRcpW9b8LRV9N9NGyXDQnvuqqZpK6tOQBJ1c/jMRrEBRq2rXvAGR?=
 =?us-ascii?Q?5BiTOQ0DqoMmJrDmzGcJxVG5ucu4ltaruXhly1YFKf4W1YHuOqkDCur6irvI?=
 =?us-ascii?Q?4j4KdSzX41+5T6/0X9tUBF0OaNvuqMRClIyqtBAdE1KlrqtYdBLAcMkUccuS?=
 =?us-ascii?Q?gXtG+7RPDnrwEsgGc2OgmTTf5MIitOK4m38Vl/HR8Y0JUrqaTJkQWxIn9GIi?=
 =?us-ascii?Q?RV3rp+zFxqXXJVLebjniwG6yU1vkLJ332pZod30XqA5wW8lyfaNA/kVbz8tG?=
 =?us-ascii?Q?TFdNczAl32mvEAscsPvOBn0Un4Y6vu1hnjtp/+JfILP0cmG5E9op9tQIXvRn?=
 =?us-ascii?Q?H4XI3ZSC4QSckZgb4wzjmxuHZ+IGI4qYcjdTVVY598EAUdRuYWBpb+2dhkkI?=
 =?us-ascii?Q?NAVbPpNs+j+PB4d8baurB7u9xop5nijG8ZHBu11RLNdAG6QrZPvT8xY10xae?=
 =?us-ascii?Q?vRJL6lhtm9sUyfstNSZO0IvcBmG90EOTOwQfb9e+s628uOZfexvetFzxb9Pb?=
 =?us-ascii?Q?ZbAGUzOu5dbZ6nQXQ3h5qQgb1EaOAzgED7Ewf8hl+vhVyHDA/wujqVX4H3IQ?=
 =?us-ascii?Q?Tn3gw7M7Reg+DCYS+gCR9Rt8y8Bs9/Lh44QQ+sUtxGS4+/3KDNO6Il6m2Q04?=
 =?us-ascii?Q?MjNGk9Gd3fzq4LLzjg/gwjGadh0YxUTk6OlbCX88pq1S1RCP1JlVOg2FfEiT?=
 =?us-ascii?Q?ORVpkGh7SlxcbiWO3aDOGQWUWnb/A0pP+9HW4YxfaHibr5DWZY8Y/Esbc33H?=
 =?us-ascii?Q?Ksg1ycY+dShTvHlPAYyRz+Syy9qkFZHkxUMvdPYwNcid+d0Ya94grF4pmhW9?=
 =?us-ascii?Q?IRsf/Zr5yX02wq91Ro+Oa/vc4u9tC0O8h+sD8ZkIT6l4Vw2xMFJfS6sSejGV?=
 =?us-ascii?Q?RwOfSDvNMWsaWZFhK072Uw1Lz7w2uejMtHsAz6GQKlbBHkVGdOxuXwY6XSz1?=
 =?us-ascii?Q?yYJENHbYQ3U37n7FJeg3OW3riPTfzn8d2tOuGytKbfPi9OyhFYFwVFKpvtuo?=
 =?us-ascii?Q?ud0U+TnxC935ij0MMpLCN65UobDozYqruRR6tR5BSV6sH+7R4VmNR0AVr/r0?=
 =?us-ascii?Q?6KIQ47nll4lU2l1NORtZVbIbnpqJTLWEOPKskjmD6YMmx9m5c9Zx49eukGTc?=
 =?us-ascii?Q?jYGegA/decmfz5g7QPHZGpenHupBzh8Usyvm3q4t/zoMaLvxiy/bK/dGihVs?=
 =?us-ascii?Q?if5jmuC1odmNLzEmruerBiMGgvGn+uEi2Rq8P+f2y8eWFLFzbB2L/KzEOHaB?=
 =?us-ascii?Q?2ckLK/YuXzpgyKBCVmxud+HqA+iq9qx/DY4hwwGuL9nRGdNyshSX4OP5FxDw?=
 =?us-ascii?Q?mdunDo04chBt9pm8zclv4MQG0Q3fKNHTyJmqwcvvnUJDlHVFIyINN4s/x6za?=
 =?us-ascii?Q?Le889WS1tzb23KYZ8CrXxRj/6dkcDKzEv/O3G4MaHccqpE0VBslRcgX1SzHp?=
 =?us-ascii?Q?6v0IrC52cDr9Xzr9sD/lZo4TstAj5YRUCLjZbOUvHiaFgnq9yiWCQAfNqI0j?=
 =?us-ascii?Q?VUNbgOt8685/ThdBjBkdycC79iXwdhG4p+sINMT0kGyLfkuaovn7Mv2/JIf8?=
 =?us-ascii?Q?qIzfog58N5vGkGtqldlSuSBLpMWqioQcCtH5/N+r7rPmSEdZoKp36lG3RZJ2?=
X-MS-Exchange-AntiSpam-MessageData-1: 55bRwmzFhZp9uQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1c67a9-3cd4-4189-bb55-08dee0984e85
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:36:29.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22jorbsHWrMlf/B5NHxVcWqmiC69V/G/EzQfwixZego/YlYImnmmM59FnqmwyE7vWVsGw81AfPGhRE/VUOiHje0PLD1ABkjRQD2fBsAKDH4qbIwU196SubBJZy3H5HvJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

The tuning save/restore during system PM is conditioned on
mmc_card_wake_sdio_irq(), but this check is unrelated to whether
tuning values need to be preserved. The actual requirement is that
the card keeps power during suspend and the controller is a uSDHC.

SDIO devices using out-of-band GPIO wakeup maintain power during
suspend but do not set the SDIO IRQ wake flag. In this case the
tuning delay values are not saved/restored.

Remove the unnecessary mmc_card_wake_sdio_irq() condition from both
the suspend save and resume restore paths.

Fixes: c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 18ecddd6df6f..6526d65538de 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2064,8 +2064,7 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	 * to save the tuning delay value just in case the usdhc
 	 * lost power during system PM.
 	 */
-	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
-	    esdhc_is_usdhc(imx_data))
+	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_save(host);
 
 	if (device_may_wakeup(dev)) {
@@ -2124,8 +2123,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 	 * restore the saved tuning delay value for the device which keep
 	 * power during system PM.
 	 */
-	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
-	    esdhc_is_usdhc(imx_data))
+	if (mmc_card_keep_power(host->mmc) && esdhc_is_usdhc(imx_data))
 		sdhc_esdhc_tuning_restore(host);
 
 	pm_runtime_put_autosuspend(dev);
-- 
2.34.1

