Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145F3EDAD6;
	Fri,  6 Mar 2026 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813773; cv=fail; b=EWYUo/1o5eAosqUwEF95d3ax0E27o2MGXKNL2xoRTP4IJVCwZyGct+SbBhqdIbGg68mdn/FqQhhF8Y+WDQGjLMjG9YvjRDNQ/NTTQZMcO/7oDKf3lYN5tvq2N3kwbV2z53jpU07mI30xbPAdlfaUuzecFvT73/CNWOBEguVse9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813773; c=relaxed/simple;
	bh=0xUjpiM+2FKUZlXhaUmwGhiAWOzPFv9nWVLWb/4IekU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mGO77CLs8uJ2iHjIX204CtBUwy/sOaEbKk0Pk1ICG/70vhK8Uggp1nT67GMohQ5CvDxy6qUzfYJSZvavALBPZQd+b+Tez29BbQ5zAgYJ4E0TDFm3f2pyK4Kk4NRmhVs9Jh71KhlcuBnR6a+dMun7s1ms9TQAmQ7ldxrSualxUnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Ui5nNvlt; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Ui5nNvlt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvglRZiwdpxaYtUFSQOIW6DycP4mFYDBflzIlqC6rhdbiU53PJF+4FAyaUwVx5C0vNRtcTD2/au2O4i4vFt5HFha7QFSlYk9h3KbiS4ZHHe0e/Vko5S9w0vLYI1SVTeSj5kIiQcGVtdQsFBshCn9TSII+h779F7gbQXgtmUUlg0hBgEkASJejJo3PeEpybu9V/9Y1+h3OfUG2Zs//HHR/zbttK41uZyiSaVAS3gzk6R+TFjHa5Q7nw1W2LyaTzaPA6K4eKHszkmF2fRmyuuPwEsT7m2sFBXu/7kTgwFDRt/myvXhUVdeW4uQyMHle7NNVJsGGNfy0uXlAJAUvyWI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV0L7LXdTdlB36tY3P3SRD62aNReZbJCDuVsDijEJK4=;
 b=Z0PFQq3QYkRe6WdHkebSlzCStGgva6uNSAlmbaVsMvCLqMiRZAGBmQXwgwZw6DUFSoX+FFq5Wlnxc4SYBh3nto/mr+8JUgODVHbnCOSm1imWDam1kQm7bs1P8ielepNfDCdhorupbygnbN5YGUfmeatC/L46dp6dhDQyeHZ6PV9/LgA+AuVvSurpUXVh1LXQkaF/QlSX6d7MWzfp0GEacg29sJa90p/pAEKj6agKidm5a85mcYV0t3ReLM1w4ewRRE4tkVTX87j8vlWQ6qaONyToUsa5EY4magQH87e5TcBysyLGV14C13cxt4Bfip232htGsaUQI5FNc2W9hg1nXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV0L7LXdTdlB36tY3P3SRD62aNReZbJCDuVsDijEJK4=;
 b=Ui5nNvlticpxepxNJ5VWdHrkkw3kPCfPZ063nu67Poo/hU/nYIEzj/9Es/Pv20sVte6V0dBs3NJjpf87+C46IMnTrGNxp5lGMwoAWRHuHTs19F0okuMyDGaYTftEivMOfFLQZ/ZcVFOoSEkb+/K96xR23mX4Y05vwxUImoJl9WyBWPcs9KSln3XZA6jvlTC7b1BN8kDR8F9ut8AMV7qnRtu9sscFGncG4ixrQv7GHh5Rg7Cs7EKzZBLloC03uUuCyp3j6L2+ZKXiefsogjce6NM72vRtR6cXWYu+d4hV6bsYz0D2PZ9m/AG1W2KZoxXrn7WYkSCGJdCT04WevNqLaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8606.eurprd04.prod.outlook.com (2603:10a6:102:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.19; Fri, 6 Mar
 2026 16:16:04 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 16:16:04 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: [PATCH v4 4/8] mmc: sdhci-esdhc-imx: add NXP S32N79 support
Date: Fri,  6 Mar 2026 17:15:51 +0100
Message-ID: <20260306161555.9000-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0153.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::20) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: bafe6fa1-1f83-4dcf-ecf3-08de7b9baa86
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	/WAGu0c1Gku09BV+fDw4s4cwtH6pwS2VJ18IbDU0l6QMQG9oF1IyhI+zeeu8V7jqWRUkz+MOclGJ/Liq2jYUQh8bwPtMfhMYBhAm59nFTv3hySBB+Pe/a19uDZXpKZiLiePbkKupnkSBGsjDJvPPCbY3c836iaF5wlOB/WS3f/UFTI2TZErTi0udY4/PleKxPSAgJgCRsq+d6i3xv/fInTKxCU4K+o5pDO/JJyHvZquCBwHbpno80CXafhK14y1AhGGTqt9WAEzIsDrucC8wobGH0MR7A6k5xcyjogvhzU2odWOelFfceHaHtUMQ8Ghei1CcvVnG4U4E2MVmMp8I3iILlmoDNLBxLVM/iYrj/TyVT0bdqxI/2KDjbceSlhUpMPRX0TnG3L5Kop3YfCn+JeuelxKYDArRb1G3a0ojpxQrkBc8CgcshW8AIAh2vD09vpgDBM//GLQZEozv37TcHKkus5TJU9Q+HGLkwPSRv7HCVuNR2BRoIYsn2J4oH3JdcEDZxCEAEZPOzo8Spr+2j0CdERKk7OdJwu0uyYkdl+pDcqdg2wWDi3tuCrRVknx5FWyBT1Pc2ZqVYL9AmyEvmIQ7wIZMAuSTHr6ZbkDV9fy7EfzYDRdjR5NkerOzSSb5EJ06l0Ev3LnKhq/jSZYe5MP9srF0fwcVAyhS9e14VXuLnyaLlbQWFUYRVFyqJPoiaEFtJWojZX2fkv9OUl0XJ05yeRXGyhVoj/hbnKZ8Vlmi3ZOits0+j4CQXC4laBOuS1Sax+vlMKCnmCTnf0QSZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0hEbXVLTWE0U2hyOGJCaEpKS2lHSFBPRXR4a1VXU1NieFRYWmg5b0hadTQ0?=
 =?utf-8?B?VGd5V3U2MGttK1FjUEtuNFd5TXFTbVZYbzgwczdycWRjTDJaV3Ezc1QyNE1w?=
 =?utf-8?B?b2VGRXVBQXNqdUZxbTdLbjhLTW9IWmdxM1dlT0x1TnJLSlFDSTFOQUtQQnUz?=
 =?utf-8?B?NXQ2TE4rLzlOYmYxMlpwbEZvVTRTTldoNndBNTZqb3pWVk84N0NKdGZiQ0tM?=
 =?utf-8?B?WGNUcFgrMnZaUDNoUDI3OGlxUUl3cUl1RHhpelZGNXI2Q3gyQUMxSHNzVklE?=
 =?utf-8?B?bHJzZnZzWkp2Szd6cXhPSVZ2VGhRUHpSR0d0eGFpK1lic2pQcUJDZk5BY2gw?=
 =?utf-8?B?ajVhZkpsNzNRaGxmcEpzMFNKS0NWL0VmSWoxeG82M0pLRzFQUFBVbXdVMS9J?=
 =?utf-8?B?VDZITk9tZGJCbko4NGVmdTAvWnQvS3lzT1lhVXA3NDZWSm12OTdtQys4NFFV?=
 =?utf-8?B?ckdMUGVKbCtxMVp5bXp3WEpHZXJlTEh3SldUNUVFdU80MmNFOVRXdUJZeFVi?=
 =?utf-8?B?WEp1Wm9sNzRaYzJXWklWeXNTZy92L05KelliZyszT3pWL1daOEx3QldaTnJZ?=
 =?utf-8?B?NHFUV2I2OXc0dGFFeFpzRUpMbVNVN3V2S2tHdGNWaDBubzFJMmc3Rm9qYzRi?=
 =?utf-8?B?bnh1MC9MMml4c1VkeTVhODIyYmQ3QkRnUTFNYXF3VFkvTnNWNEF1dE5SU0hn?=
 =?utf-8?B?Wlk2bjJvMGxBRk5CRnR5NjVWK1BqTDR2Q0FxY01LT242VFpPajNzZlZUS0g4?=
 =?utf-8?B?bUtzak44L0RQRzl6RjlwZEVQOUMrTHNCcmNoM1FrekxhZ2tGMFM4RmRuUTc0?=
 =?utf-8?B?UWdWbXdWU05QTnZINEJpb3hWVkxBVUxSQWQzRng0dFVOYU5mWURNMnFHeS9i?=
 =?utf-8?B?ZzkwNEp6M0xSWUZ3WTV5angxZWhxNTZKV2hMZTl1LzhCdVBTZHhueWVNYjlJ?=
 =?utf-8?B?VXhLTm44TDJhditsTHA5eDY2ekgvMy9QVzQ0ejlreUVIRjlBSVlnUmYyV1Y5?=
 =?utf-8?B?dXZPekhuKzZuZ21xc3A5QjhRaEh3SWU0YUQxZTJnR0U1MVdwY2ZpVUdESHVC?=
 =?utf-8?B?V1IzbkdaakdnRjBBSCs1Zk03Ynh4Z0dNT2RwOU9TUkJGVXVKUWpRTjZuM3Y2?=
 =?utf-8?B?QnhpUjJmVmVtYktrNGJyOGZqR2U5VnJ0dGttYSs3bHJpUmttVGU5NjdSdVNn?=
 =?utf-8?B?M0RObkZJelBRSE1lS0VBUmFERTd0ejhoRUFjMThSczl5SDU2NWF2VUJKNUdQ?=
 =?utf-8?B?a21SWVY3dXJ1MnNiK0oxbUlCOG9scWpIZ1VIL0dBWlE1NEwyZUg3NThMSmp5?=
 =?utf-8?B?Y0t3T2RuU3BVY1YyK2RTNEJiMU82WWJGbEJ6S09pTVZCc0FqcnNvM1BIT1hX?=
 =?utf-8?B?QWxPUFRZTWk2SnNIdlVJdmExa204SVpPdTVZM29WaW9qYkRnME9XNW92Mzk1?=
 =?utf-8?B?YnBjamtiWTcwS0FsRldJV0RpWmVvYTNMeVo0TWJJbFhvdGJYRkZJekh2TXFF?=
 =?utf-8?B?dGFKYVN5YTd1VUN3Z1pjOHlzMU9WdVAvOE12UXd3cThpaXlhOTRRRS93SGsr?=
 =?utf-8?B?Y2RBZzdhUlN2bkc2bUtlRWRKRkljWEM0ZmhBaXFpQ1RWRTMyY0h3UDZPZ0pB?=
 =?utf-8?B?S00xMmkvdDhnQ1ZXVkh4ZjNQQVEyLzhyelZZdGNZWERJdnA1OVJmbWVzSTlH?=
 =?utf-8?B?VTd2NjFldEFQdWU1VVBuSjVmVmRGeHB1OU8wMlBGYTVsUzRlVzM4c1lwN1hU?=
 =?utf-8?B?dWlLa1dCYjAyK2t0K0ZzZW9tRnJtN0JHVUZkSmlPWnArMXBtNU54cUNTc2xO?=
 =?utf-8?B?Vkg3VDFtUmFCVHFwZlZ5UUlrQUpKa2lzZXY4N1NpeGdXSnR1VVFLWDcxT1Ey?=
 =?utf-8?B?YU1Wb3RxSk1jSjhuUDB5T2V1QWRxMmluZGt0d1Y4dXF1ZllUSHJZbENCa3hO?=
 =?utf-8?B?cnRvOGI0aVo3WW9nbU1yczhGc3NQOVA3cFBWVkZmZkg4bFlGUktVME1jQmlt?=
 =?utf-8?B?WlJ3b3BmajZXK25HMXJzbEpnVnVmSFR1bmpIVWlmK3RTMGpFR1FldDBIdVBT?=
 =?utf-8?B?YllySi8yQ2JzekJ5aU45NzBHMHFKa2p0M1dRQ3RDSXhsLzZCWHlxSTdZMGVJ?=
 =?utf-8?B?WkxURTg0M3JlTlZNemxVYWdXWVpyZVBFaTRONzRwY25IY1F5ZXE0QVdhYkti?=
 =?utf-8?B?Z3NOTmxoL016clBKd3dneFhmQVNxYlZqRGEzbzM4ZEJxWlpIdmZLVzBCN1BQ?=
 =?utf-8?B?WHoyT3dWSHBaZVRLdzFWZ2JtTS9RajM5NjlBREdwOU1MUDhzRzVpMWZQSzJ5?=
 =?utf-8?B?SEpjMi8yQUhhd05zTTdvRU16WnY2L1VNbWVpSTNONmJkRzlXY0NhSThxNlls?=
 =?utf-8?Q?k/Cqjm6RfQ3vOyL8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafe6fa1-1f83-4dcf-ecf3-08de7b9baa86
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:16:04.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXPvODYKEDD4WvvV9uMxLlj6/a54QAwzq8UZbDmAEkCdDPwOQpiWKXqh0OC3//PuvRBNB7SDdKCJrdV0gJP2F3TH1+4CzLDUHZYaA4J3dwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8606

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add support for the uSDHC controller found in NXP S32N79 automotive SoCs,
which reuse the existing sdhci-esdhc-imx driver with slice difference.

Compared with s32g2/s32g3, needn't set ESDHC_FLAG_SKIP_CD_WAKE flag
because s32n79 does not have this limitation.

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673b0f..28288fca87ff 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -321,6 +321,14 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
+static struct esdhc_soc_data usdhc_s32n79_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
+			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
+			| ESDHC_FLAG_SKIP_ERR004536,
+	.quirks = SDHCI_QUIRK_NO_LED,
+};
+
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
@@ -408,6 +416,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx95-usdhc", .data = &usdhc_imx95_data, },
 	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
 	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
+	{ .compatible = "nxp,s32n79-usdhc", .data = &usdhc_s32n79_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
-- 
2.43.0

