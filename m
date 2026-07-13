Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50D3446C0;
	Mon, 13 Jul 2026 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783917414; cv=fail; b=IublmgserjIdZTH3wixYqC0k+NKjdd1qqgUZf3vyJvmw+TPCqpnZ4oWNvTtRnYIxFu6fV6QOsv/YYBqS+2PNs+Kb5bo/mrj3KqUpmrchiAy+vpDxMU5H0+HuGoFTBmNKkYQBYSr4+ddvaGMofji8wSJoXE6bSWXvnSJx5RW2kFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783917414; c=relaxed/simple;
	bh=TumYMlT6WgIVsx1M0fRcUxD9F2gDaVwIZtm81XMuhn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxIo7JSpvUIOshIdlN6s4hKpTGxHwNHSNIrLARqo+xRokeQqRtwUBEP78Ta6jMribmzqmvFamFE/hwNpLOh16hTogDU77tDMnQrdZiXdmR9TpkdsRNuBpNkV+om4AOZb0ziuMQc7PK/YpIdMS+Ua+ekOa8m8vELIKM8iiamAtQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jj9/xrFY; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jj9/xrFY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUptadSnq6RTWFV81HYXWMjmH4AjGNUcR3owhYvrsF/wcee2AtJZzd8gdlFloD7lBHbgWXNSFV+oUjq1xLQTNyMjrQbMJJ2wwOLGwpmcOuL4wYM8HYNK21L3j9zI+RjwYJrUl21Hf3z/OiyRf6ifvnBehMafymB3n+PVX+xvw6cTj8nEt+Uq1wGqxnuo0kIqXI2VBF8GKfrn3jF4XjIuPPs02zpkT+np3sWNU3zujdkukzf4IE13yxLTpTi6LRGA8lZngU2nu0HRXSxJr0h0vKJ/GjCMESLcxK5okHpE/M71aPBL8NC6YMps87fRqD1Ck4JuIZy45xLYR1ae6TcG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55+YzZLEUnFYJEqI59kTtYuhrT3z6KAxXnGYyybTfdA=;
 b=rxl4BoSjpOwIiK3+hxExrlntDjwFULbpskHpVWFbIZwvPlhBmx9zh5xR9zrpLZ1Hx5wpuIMUDWdLxnx6Y4xYz7KGgjMkJ6OF6yEQWcPd5TpL+QG2d6lkwOBX5jgHawR9KR4Fs1NXaxvtlYFUWGKfITIweYMr2/1jDHUNt2KgmRsuWKCYBbTiZjgQmutqvmL6vadjqX4AQCvJStqOpjwGcnxHpwtZs8CYsAKDjjYMury6WnpuPCLi9asQZO8+ByFxa4lPf49Pw4hNEnsKIFHGy4iPxQknEolX5SxWYJLWER8tnKZFgkm+Foixpl0qTbgcd+hlqFAEIZEpGaombyDEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55+YzZLEUnFYJEqI59kTtYuhrT3z6KAxXnGYyybTfdA=;
 b=jj9/xrFY+AJ05h5nDcvLsNx3aZQf5SpcTg9Oj4b+dkDXOxg72G76ggVBrOBJn9xsf0eIkkzrwX45mqHAaOsBphabHkIadDgN8jv5d+K6zb0ZOQTUyXXx2t8AFtqwMy1L4qcJdFsMEMGI2XbbIFzzo2vrZQVJmpo7Ms2uii00qIAg8kulXhLqCgWPRo8ifuNxwo/DteWaSvKVbW7rFz2Kbcz/LuDKsl3ClF8kXTrW5SepRI9NiyIErhx28WvM0yOLoukEPkB4ADyXRPlREm8NVyX5+rJz2PE0ed30M6/ZPjpak0qofayD5gm/MCRA3YciQYbVli5I1lzc2Y4nuyvrmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com (2603:10a6:10:2f7::6)
 by VI2PR04MB10666.eurprd04.prod.outlook.com (2603:10a6:800:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Mon, 13 Jul
 2026 04:36:46 +0000
Received: from DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05]) by DU2PR04MB9180.eurprd04.prod.outlook.com
 ([fe80::f94c:ce27:1558:fb05%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 04:36:46 +0000
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
Subject: [PATCH v6 4/8] mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on resume
Date: Mon, 13 Jul 2026 12:39:00 +0800
Message-Id: <20260713043904.4144172-5-ziniu.wang_1@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To DU2PR04MB9180.eurprd04.prod.outlook.com
 (2603:10a6:10:2f7::6)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB9180:EE_|VI2PR04MB10666:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6ea000-9aa6-4f1b-50a7-08dee09858e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yL6aeNeCXFjsKeEydF9zSa5/SRhQq4Ma5taz5FfbU9azDJSSD39yFWBDthb0lvosIX/pyexS68ZzKAHdm8WdRBpsLxDz6C381DiOY4nDWCEU+3wTWWCJDsPxhORGRTtL9Ih9bwXLR1R24ZkUKyTlLuXNx6hYmwJ24zuxFp98TJFioHtwY1xJcYFGJ6SxDVPK1OZiaypxVcTuyxdSN+44OlU8nrrImm5EjV8HacGw3MQtOu1EAyolej/PABFJwkbhaqjGKRT05lmA0Ep/SvKP9PFAE1fGjiiH5GWtJTknxQJumEejOgA9jf7ukKSEbPHpcmSu+WBFEzJH+KkYajBWYCTSrOLojwq6nco02IV4zDAXocCXyTdUc4iw369IrK4drsK+hSz5UTqfQiTU04YFzhQ77gLY6tb9XyHkJ1js4SSuIQwYKjCNhR1VqUtdnSLUP/Pfx5bLApf3YxJX7mbv2+ejxrUoisTHkxNcmu7u8aYSZlVP3snRkkz6KfiOa7x6jG9+zssIa9NNYSr0351b32fpjj7/SKDevO9RE6TUQ0elovfKE756xK9FM6et8iUFDxo+ds/glPi/R7EGz6K8qDiWbmiBpskUxsFdc4P0fPxgoYRKPiHuYfCuSl6ckcnaJAJ2ZiJp7+nWftsFsyprTip6FxfjqMS9VkLtJgcyvXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9180.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwAedzdEJOrkiex8yk6h4POyeq1x9VVsuiYISZtp0ge49IqT3LslOl5WhFow?=
 =?us-ascii?Q?QmYpVeS+7CVbwWcn5fGMwTrpHms1RZJ3HhrX/9YBxjKcgod9SgqXLEdevuel?=
 =?us-ascii?Q?KFA/bf5ZVwKs+kRWnyQdo2ViNJyCJEWkQ/FSoRr2ukzq8BSdrr6ywH+fg6Ua?=
 =?us-ascii?Q?ukBUeMHFviWHTXNxWRQbrzVUShVeD0/ZZolaZZRUhLSwipMWpHKY7MgonrWX?=
 =?us-ascii?Q?4Dewh4JuzfYIxueznsUMaRYmDPJ9RFYJTm615gqtiKLtbKmvEf9wVsZtnZKG?=
 =?us-ascii?Q?QG6dRCrVsdwfWGqRLOno8JiibiIcwydjvl/AiZllz5hN5LrYFfaMVJ6iG9iS?=
 =?us-ascii?Q?LfFP4ORhdAexaGXMSOYHv+HHneSlPygWtaqvi7gJKs6NTrQ8AyBx0noozEow?=
 =?us-ascii?Q?0lq6mHNQksXlK0EfhqDbdSTpx0jA+K0Bw4v8OT8ALppY7aO32l6SDuf/aTiR?=
 =?us-ascii?Q?bGek9mjL34ecO9kiJc2tCqqYIIbfUieLOBh2H0LLBufW2Fb4NxgCH5xF5KgS?=
 =?us-ascii?Q?S04Z1quaEkIWWp51huYhw/w3BdbayOrJ4h825O6Edds0RSrhEbEShWUMq1iZ?=
 =?us-ascii?Q?h2armwu5x97TBb9abYj2fCidG74l2KLK0qn8zXUJKGsSAGT6ShzfQYE/8Mki?=
 =?us-ascii?Q?RwH3qkyNQkCHcXENBOvXufuTDImJxuf8SLWXVmpHcIsXM1fz4DzQaTMBYdzY?=
 =?us-ascii?Q?dg2Bi3E/QdtndTgsMYXukYxX81YYNEnrjS4Joaon5GFFuVcrkbDrFTIQ1tMl?=
 =?us-ascii?Q?add8PWlJOd9TaG/PvU5xZVZVNMJzoZLeHtAc+NmKXGTE0k+aP0LCluz2YkbC?=
 =?us-ascii?Q?PGzmeOsVExlXHZBdqYIghf//ByAfidA5IDmWqnAVqj592znuEzf39SEKFI/m?=
 =?us-ascii?Q?eKc+D2nzV6W0KgAMtx5KTlCKZ8bgvdZNNEp4wOlAzLs0h5QH0Rzq+ZnaKiFO?=
 =?us-ascii?Q?wUeKeeTkDXZnVOOHazTGcWXagO7Bg+YzsNdWK27VbnfboWcB488rFeA13J5v?=
 =?us-ascii?Q?b2zLip32mEcGtQCg204iAGQIjO7m9nwGuftbUosM3sLByeKeAi/QVBtPEgGo?=
 =?us-ascii?Q?RJJNb9qQBEiyhoYkON5vG1ltxdEzKWH6/+NOSE7Gdre+tYzaA6qhHzzsIfaA?=
 =?us-ascii?Q?IPZ17EPv9d8uAN3FO9noknh57uHRUeogU6LYYjPZ0izFBLJZpgYZdv8poLiB?=
 =?us-ascii?Q?ZYkjxDEaTynJdwEu6xw1B1NPE5w2+CsLuJNjyNpJJSOBiFxu7O61ci+BY2b0?=
 =?us-ascii?Q?UmgJBcf0h3hQm1fCYtmBhomUcO0BUqiTuku5ULzSh+TWoGxRSs+cy5NfKtta?=
 =?us-ascii?Q?KnBNBEBfK83YmuE8wr4eHmezG6ePd72+84AVYiuM6NqTrSHpGeoGszpDJPf7?=
 =?us-ascii?Q?Jiiq6yfZSPxGddKHW1LhoZBUtNIfE5lXEiUeGr8kFdxeX0jOne939x6rafAa?=
 =?us-ascii?Q?LiEPBPYjy8ab+O2Rmkc3ukNw/7+AEXDm5Qr0FseSBMMU+/p8NlNt/Oqv0QDb?=
 =?us-ascii?Q?3SX6BPtNsjBCe0by6gJoDcVr6ymTILU/4eRu8SYKOWQmMzL8B35ZI8a+TfMp?=
 =?us-ascii?Q?lHbFdgIpC+sSTogcFugbocNbPBeK/3Cs0l/d/aYOcIhk4c1mdv2efMCot1C2?=
 =?us-ascii?Q?TwMZJEF/Ft+HumuAx3sAQugAZP5ftN8orwJAaWLUG5PBs9yopPknt4qX7RM7?=
 =?us-ascii?Q?c6VeIgfUZ611WLAb03+vjSoZUgoSZeReZqiVDrJdvSSZSxv8RuV/r5Pdw5T2?=
 =?us-ascii?Q?r61rOkOGuLHE03ssjj83JeYge48McqZGhND8ctdz1XE8FDrOjPOcM5ucDnZt?=
X-MS-Exchange-AntiSpam-MessageData-1: fE2syiqdGhrIVQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6ea000-9aa6-4f1b-50a7-08dee09858e2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9180.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 04:36:46.5052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QJrXw71TIimGwQjG/mQoxK9X+v96gxaPjwi0Wvits3cpHq7OABzryC0w7+AhnUeJcZt51YaaP3E7zu9yWZ2Qb+vOaW0mVNjuiVv3Y8dySDeCRPQGp5CoorGL57dpIin
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10666

From: Luke Wang <ziniu.wang_1@nxp.com>

SDIO devices such as WiFi may keep power during suspend, so the MMC
core skips full card re-initialization on resume and directly restores
the host controller's ios timing to match the card. For DDR mode,
pm_runtime_force_resume() sets DDR_EN before the pin configuration is
restored from sleep state.

This is related to the SoC IP integration: switching pinctrl setting
(changing alt from GPIO to USDHC) impacts the internal loopback path.
If pinctrl configures the pad to GPIO function, once DDR_EN is set, the
DLL delay will be fixed based on the GPIO function loopback path. When
the pinctrl is later changed to USDHC function, the internal loopback
path changes, making the original fixed sample point no longer suitable
for the current loopback path. This causes persistent read CRC errors on
subsequent data transfers.

SD/eMMC running in DDR mode are unaffected as they are fully
re-initialized from legacy timing after resume.

Fix this by restoring the pinctrl state based on current timing mode
using esdhc_change_pinstate() before pm_runtime_force_resume(). This
ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
is applied before DDR_EN is set. Only restore for non-wakeup devices
since wakeup devices kept their active pin state during suspend.

Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ead4685d621a..a54da5757acc 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2115,6 +2115,12 @@ static int sdhci_esdhc_resume(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int ret;
 
+	if (!device_may_wakeup(dev)) {
+		ret = esdhc_change_pinstate(host, host->timing);
+		if (ret)
+			dev_warn(dev, "Failed to restore pinctrl state\n");
+	}
+
 	pm_runtime_force_resume(dev);
 
 	ret = mmc_gpio_set_cd_wake(host->mmc, false);
-- 
2.34.1

