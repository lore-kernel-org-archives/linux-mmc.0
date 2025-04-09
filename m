Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B325C6F6;
	Wed,  9 Apr 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744185314; cv=fail; b=eiLCKJDy7Zo48FtjIond30HLXDpSuFBzFNRhXkXOawQGc/745M446oO1y51LhpmToWZLV0mSDGbyWwgKgt6xQ04EcGVbO+0Cfc+qesdrLH2A3VuMm6rpFYUwZATB18Mj7XU5TVYXSbRAUFoxdwFs8Wow4Rb4z2RGSFZvv2BllIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744185314; c=relaxed/simple;
	bh=QZGnkPuf6SvZ2KfGAGFfbIz+fT3Ju4EZouR+LkcBpQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nV02F4Gst9M5phAt3RM8obQoYrCo3m3yLltyZrU8aod4WlEouyAssvwRPYRwhcLl+SDHKVPAKSM4Tcvzs1dbtHMxWFPWu58UQDNOMSiyZ0EUprzQSlI4UechOtpDsWxKd3zugFuWactf5KYI3Eyi48ZEyhZyTJElcbhCzzFbCCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jXWhqqZN; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jXWhqqZN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS/rsxqdMyCKrARbb7fit2zRUeKCCVPugUS4nuHubji3HWOLYWHvB1wHFnHh034IG16z9yaWJgxkVYK+S1PUKEA8Sbdv0pdWoeD7yI64A+9dkGeuVjWxTawdeejMjZsQ/XkJhZNuW6b5MNR9u2WWjEn+5rfmcv+UZjyyaXJNAOUr+2K/9rgJxnQ4e5U4mfbhTbDBaTyEBDuTa1q7hbDe53iT1JVoDkLjgrONs1OuJ/9jCp8QEAzgcSH9J1tEZwruJI25nIFX55lps2cstCHYgQlWkhRt+LT8ML28OA/SEJE9weRTlziL5nDA0J+R2ZMU5F/+w08PLQwxj3epnx3ymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtTbZdax7gKgfxsZ0IXnSYW7YdGHtlHjCqcFH94yt4s=;
 b=cncvOHLyNqYbNEAvegx+FgkDpf3QeH+GFS7aDgaXXuf/Psl1nDu4AEuzHDDc0dQP/JqK9Kzv2Cav2WwENvPhLcGME84rWmI75b1IQA13fsiPWxBFcctUyIkL3Gc/XXHH4fNaPXNfWqyK5fATRjUpnZZYeugeDQRLBOZzAOXfkkM/SxYW/Prn6cknbAsJ/RBvV2YU6QrBZ0zpifH7Rrtcgq16UpNN/yO/xx2PXLRLsN3dDeWboXFVw2MknPAEv5s8rPecyxyPj5sMUQA8LV7MBchuGqA+Aa+DSCfjX6b/TjVsweJq/rvM0mjY9/ChPbbxh2zmTIhejAKM03w+TBE2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtTbZdax7gKgfxsZ0IXnSYW7YdGHtlHjCqcFH94yt4s=;
 b=jXWhqqZNLJsq1EiwrLSW6hBoW5QIxxpgSOq0nxdIpUuofJS9MzY4XczL7PNun2TnpBSTK3oH1MIGNnGIl9V+8/v4h5IubkSnCBvBBqlvPnqomFdLPfHck9m6KvAlTtmFFKL+Yf0Sv8SZdAmvE6GJ4cqtXpIaalI6ZK/MwEsXywWspoFXMsKge1ETwvUJgUKl6s8UB1UsVRHCn0yovMID4DChWmTUO4tNyB0MEyhbXFS9hTeR8PJsa2LaAjXGOKiPaBPClLl+/fuzrCA6Z5hxjwqxcBmpy0PJSYsDxgVJhEUGePojQAmOpXIUNnPe9qOubOcq7XdZecF1vxjzoFE3FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by AM9PR04MB8196.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Wed, 9 Apr
 2025 07:55:10 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::4db:3dc0:c292:493a%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 07:55:09 +0000
From: ziniu.wang_1@nxp.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mmc: sdhci-esdhc-imx: switch standard tuning to manual tuning
Date: Wed,  9 Apr 2025 15:55:50 +0800
Message-Id: <20250409075550.3413032-7-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|AM9PR04MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 30df3b85-0d72-4a3b-32c5-08dd773bd9b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qx/5e8akIL8xwIM9Gi1oaz8zawSZCYAQLpvT0vyZQE4HEFOBJgoMhhgH+XOf?=
 =?us-ascii?Q?JfakfrTQKIFQ4Q9nmZAXILuBWZATlqlPKWnvUNm8UchvkPIR5kY8Z0Fg82eh?=
 =?us-ascii?Q?JEKK9RPxajzq1i+e61fqaQIzKxGm5+NkUWspdVMAjSDXr/4O+3M0aJWOZh3A?=
 =?us-ascii?Q?jqfzCoVlBpvrp1ilKQijQkmDGNyZhE3p+aUlX8Tly1on9sD71oDIxBBFAZJ7?=
 =?us-ascii?Q?FjFnSpleUa0O65TDOawM52JVo68RbDLMDaA7I3tbnwmoihpIFuJkhxVswkHr?=
 =?us-ascii?Q?l57AbEkVuP2CHPScvaX8JHmEgs8pjfZbfvlTGvxJk2H8/tAMHXP8BGTnU7cd?=
 =?us-ascii?Q?YrnMHb3xTr09NIYevge+KxVS/82c8Vdb/15OMjKpGiV0OsOm/N5cFSlH/zu2?=
 =?us-ascii?Q?W70G2QnvJGvQU5eRTGfaI2Xum5BVVsQWSqf1lsJZy7TP2L8aE3B5RRhg2VwH?=
 =?us-ascii?Q?JW/Ab3UOZLipMdzaQFjsrunVAuwXWnm2Hw8bdg9iP9ZXGGeKW+rDiV6yTdUu?=
 =?us-ascii?Q?vPRj4a52eeq9Gd8wHJ75soDCQoyY4Id5aqNYC65j4nfdwkMzF4LoQITFuN67?=
 =?us-ascii?Q?UuN6JsslcOEnkwksY07lElc1Ors4h9enF4e/faC7bc578SQD6U8R2NBDHt3W?=
 =?us-ascii?Q?U3M/lbGgAcJILIhQYYkUEx8PENWd2dOwlLwokzZ1No50eUP/Aqs6lnxN1BNf?=
 =?us-ascii?Q?7NY2ltJnP8t3BfuBap9UosvzV/4aEB/ZHy+JGTxyYADtI8AQ8MnywKd7/nX/?=
 =?us-ascii?Q?GnTNw9s4QG/LOYdTmh01Xz0/v3OvJPrtZ1KEjPRK/z0Vk1sryudLUQkb/spE?=
 =?us-ascii?Q?ssNInXQWXpk5bme6vILwPJkofDc9jq/Fsd5aDfDs8qPJyWl5n8b9EwOMgQYF?=
 =?us-ascii?Q?26sczSmjBfXLEg6qKDEA5xNg3Vj0dtgagyFcN74ANFUJ/LvhTw2zU8L9zHS9?=
 =?us-ascii?Q?yYmQl4SwAgJaoqhUhhUvteSua1wZ3UUk8v5hSifjRhV7H3X7ZF5P5KSC/5pk?=
 =?us-ascii?Q?DK21rzGqEluUN7rIm7YTwsjAzNrxVUCPwXFmtD10Yymlas9NRowO2GWP8G9A?=
 =?us-ascii?Q?G1/OrqyDIGkEtq2nv9U+pLOTT17h0tlre0WRp8hlqZxjfLolGdlnJEhjm0KP?=
 =?us-ascii?Q?kG2n5g+g4B38kw+YFBiPUr74R1VmGRJ2gT1oJ0DywO67XGdgfB7uaF8Q4zca?=
 =?us-ascii?Q?mhKWwQw6xb490uFwwKhkX6ZlXUa/GHR6C0tOfZsPy8o5hPRZuEDn3dITj1fS?=
 =?us-ascii?Q?ipnN/zfwF7Uyp4aln/3A+CZjTgVyTkp301BYT8l80vqtn+HeA6SXKjC33nB1?=
 =?us-ascii?Q?fQVJs7g8+G7lPe+dznnGrEuGgBRG8BgZytOk7TnQvZPRM0gwVt5AJZPLDTCX?=
 =?us-ascii?Q?NZt6eslHwF5qNBn6sf6N1MDgQHgb3RrDOlctdE+hYpxepm8DUbHbVKbCHCuJ?=
 =?us-ascii?Q?4vMH1WNMlUTa0SABUTUJiW76S7UwkMQr+NjGK6ytJIH3TeXDkWDWgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NgVhQhojrTaReJQ23WFFcd3Us8M6BT+ozOuoIWKPV1LVNIiqXTqnI7FjAGeW?=
 =?us-ascii?Q?19CkSG5jZaIpsVWlb5b2NGd2d8pNheLumOOfcGMTbLC7nrdc8KAxXGo+fwJD?=
 =?us-ascii?Q?kLJK5UP5gDRD2EcqUPl38yselQAcLtZ3/MLquziov3SH6WhfqcgI3LRsO8V+?=
 =?us-ascii?Q?1CDtK5Twy7SA2QmGTIjg/dCbT2z56YJBA1lpUnlEdJ39FB2ejjeneyfd8hrZ?=
 =?us-ascii?Q?xXjlNSEJaGFPa/ejZ+DKuBJ2HawLxSRZt5pjuc/vbGc4yV68nzlLqanIF5Zt?=
 =?us-ascii?Q?0mwpj7k/MTZS5pyIMlrvwjnVGGrKnNmQEW9CKP5bInsIYQbyd93Wlyix8Yh4?=
 =?us-ascii?Q?kCfxRr3GEj37/fLwsTktQJyEXijSGaio0RDQbvfYFB2vYTJYuWbC8tzBjqDT?=
 =?us-ascii?Q?tKUC49vhc6PTkPRb1Kmaan9Cv4Kc5mQBGt98MFjYw945AGlPgEhkwgtQ6zip?=
 =?us-ascii?Q?0acOYnRyT5dt/BLTtqaHBykarsAitkTLrc81es5doYWUSOud2lrUCmI5AAAC?=
 =?us-ascii?Q?7HT0nl2DfdxWpgBBePYlHvbUfxm/Nb43N9MrWAwDzGJUiVi/19j1/EUefpuH?=
 =?us-ascii?Q?Xf4QuYnbD/unh0DsA3n22vAWs8Hh4SUnIhQ/SiGMJhQyslGK4CTaAH8MSyPl?=
 =?us-ascii?Q?gGsULBUuEYrkC/td23qUOeAEClesc7WpuwaoKwApTaYbHP7f+DfF/LsHMMp2?=
 =?us-ascii?Q?7apUx92JX0ZGmcOnucRPMxbNclorP6x6zAo4H3tFMTz3VCeEIppOFTo4+T29?=
 =?us-ascii?Q?FvfNixTq+knHA6BytYjELz1T4vsG5jsepZ63W1Ykvjlv/OH69ln0ukFwsppi?=
 =?us-ascii?Q?kDKlbVKdIyczA231TXuvorwDxdNltyOh1IdA8H8ieIjs4JN/8gC+c157++rO?=
 =?us-ascii?Q?YT8L43fDHVfeTpp58mSRZFLyTiKY6Cuh2N06SsNc8yIsW+9bc8z7Ea0aYfsR?=
 =?us-ascii?Q?ub+9IpQZdkq65xhO2nwrFKgLtaN2QNvwlZWOh84rTHfG9RMjGYPkQr5AsyVk?=
 =?us-ascii?Q?3TnkASu2X9rWa0lbsAMVM9x2WMLt8ko+Z3NyKn5LxHLVx8L3EWON4oJMvmCR?=
 =?us-ascii?Q?NHz0lnZEKFNJOS3W81PKWvUReSruIsGqRh+KVgsj9uKSWUer24CmDvrfNmXd?=
 =?us-ascii?Q?xvmrMTqiqBmm9UAB8+QRQ79jre3Y7rYav/ek6exAogShJipx/rPQHVlrkm0W?=
 =?us-ascii?Q?P4vlODBKdEbMTWx4bePZYqINv2mMDK8buBZn8ayzqoGsN2KfuYJskH54WzPE?=
 =?us-ascii?Q?2n1KGG3pkRegmbQGxk4QzkKVdfldCBj3EJUNVO8Gb+R4VPzPHEsSVfnTS8x4?=
 =?us-ascii?Q?PvSeNGX1Z+TiWvR3l22LA8euUhYJ3v1+4xwbNM0AhCOFbWr6kbc1xAiC+Nmb?=
 =?us-ascii?Q?YshEttUIe6YfGXiiLKMRr6fGJdjHDhUNKq5SAD6yOHdQPC9/YT2ncMxiX5jF?=
 =?us-ascii?Q?oJHH4wDyph8hkk1kpw9RHI6Tii9haOgTkmnIB0vWr4dl3BA7dEagVQgBVdpj?=
 =?us-ascii?Q?OAb6aQFdQJ5C6nrL6PbXCexzZFjAJW4Ui8Ob0LWh27LA5GUzcAuUyTk1A5rQ?=
 =?us-ascii?Q?3HznlIHb339qkaG2l8BO+xUAD+1yJpZw4G1VBepw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df3b85-0d72-4a3b-32c5-08dd773bd9b1
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:55:09.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqT/92Bxrghx0S1cHp6Zws+qW5516IxUIMmwPkW+6wR8LFu8K8lK7DbzHNJogUJpBB0+dWJ5EXQVXori8AHT2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8196

From: Luke Wang <ziniu.wang_1@nxp.com>

Current standard tuning has some limitations:

1. Standard tuning only try 40 times to find first pass window, but this
pass window maybe not the best pass window.

2. Sometimes there are two tuning pass windows and the gap between
those two windows may only have one cell. If tuning step > 1, the gap may
just be skipped and host assumes those two windows as a continuous
windows. This will cause a bad delay cell near the gap to be selected.

3. Standard tuning logic need to detect at least one success and failure
to pass the tuning. If all cells in the tuning window pass, the hardware
will not set the SDHCI_CTRL_TUNED_CLK bit, causing tuning failed.

4. Standard tuning logic only check the CRC, do not really compare the data
pattern. If data pins are connected incorrectly, standard will not detect
this kind of issue.

Switch to manual tuning to avoid those limitations

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fd0ad0ad1519..9b66e07ed8e7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -275,35 +275,35 @@ static const struct esdhc_soc_data usdhc_imx6q_data = {
 };
 
 static const struct esdhc_soc_data usdhc_imx6sl_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
 			| ESDHC_FLAG_HS200
 			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
 };
 
 static const struct esdhc_soc_data usdhc_imx6sll_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
 static const struct esdhc_soc_data usdhc_imx6sx_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
 			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
 };
 
 static const struct esdhc_soc_data usdhc_imx6ull_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_ERR010450
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
 
 static const struct esdhc_soc_data usdhc_imx7d_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
@@ -319,7 +319,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
@@ -332,7 +332,7 @@ static struct esdhc_soc_data usdhc_imxrt1050_data = {
 };
 
 static struct esdhc_soc_data usdhc_imx8qxp_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
@@ -341,7 +341,7 @@ static struct esdhc_soc_data usdhc_imx8qxp_data = {
 };
 
 static struct esdhc_soc_data usdhc_imx8mm_data = {
-	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
-- 
2.34.1

