Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010032.outbound.protection.outlook.com [52.101.69.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCE3B7B84;
	Fri,  6 Mar 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809925; cv=fail; b=iv47g8xxzci9e3AUJtStywSRc6l1qlFUCOYXKqMhzT/OHQvsRFQK+lqiJrctJUzEh9hsxKCrbhqTctnD8BgelA5BNML0HmMB5zJNSvUVQBWGNhh2LaSAQkZl6mGES1/MxxiKQoD/9YIsU21nA1HXDu+oZuOtWFTYfXXEN4LG6C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809925; c=relaxed/simple;
	bh=0xUjpiM+2FKUZlXhaUmwGhiAWOzPFv9nWVLWb/4IekU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HskdTY1pyUHLvOGYPn5Zzx9KM4OzY2k1zQgETL7tsN1t9Tj0s2ahNtQwJnG2mnOdNI1Gch0zZEprH/N24sWcdPqF6mofT6cMd4T8Pl2wHsrBKiadBcVO6eHBziyTaYe1OT0qB7qdy6tnp6atuWsIOC5P+B75A5qoKJ6TStIVTi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Fmws/Rzu; arc=fail smtp.client-ip=52.101.69.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fmws/Rzu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itmGixrbxNLHA0nQvRDpIycpouhy/DLyVFbYtcaEDo1t2mWNH8egurkZDsk3OQsSCDV7GJc4chlomiOYusSzZZQMyw0Bdd4iRdaFQtGKVs2leyxOow+Ln4pQLMXmeLvp0PlGtj5qzJhWxfqwTwWKnQJ9sHFxtKJY42cjcMVMFHqn53uLKkp99HRzfLlC6QtRHAQFn06d+2PFlRt2kcfm2kJzKXp2p1ZMkxivfNo2N/Y0MVvFicnhemqOryrbwF2PGaBvkwxzkQN8xTGzvae12Kz5OcwhdkpN6SI4yLd6+JdKYbiSvivZsTprA3KpO/jslLN+lqsTF+Kq18yUM29/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV0L7LXdTdlB36tY3P3SRD62aNReZbJCDuVsDijEJK4=;
 b=k3d8iJqLYeW9tYtGawdWWKnOLWiyO/LASph7UeUzPTaVAJSR041ZbYSA3AD7uup+1uNCtZiKVojuvnkv0mqrKbY95uTFzL/6bu746yz8XoWnACXYehJKefS3OxwVeO20OraV6+KrwPzKgBCHaMgA0NBDifrZQFI1AzbGbLrugTxxPFmUsnaat9GtRXrHy29Qaz6mkRRHsLncj3YnSRwiC/7kdIALAIj4BMgYTaMzt36iFQFdyaOTqrKupFL9QhijqLC55rNMCuKEeYyt2SeBS5ZlhFFNtpxia+4fGH7m4YNM8WcRSZ756Yqb1ObZiQeoxqIewIs5Hi8zaU2NN02m5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV0L7LXdTdlB36tY3P3SRD62aNReZbJCDuVsDijEJK4=;
 b=Fmws/RzunQx4Dmv9yUspc0D1IjzegP/mh/RXRGqR2B0HR8V1KQKQWDhXMSiMUmPBqjtApF16bLg8NWGNQpVTx2LOU9Mbc0/2N4RqtMokJl1w+UVmNx/cIONbIXCluo8K7A4K8VUDg/v/AlQS/LOak80NSUO342jFEXLbnJkI9OBADEf6Cr3sDrR2ivGsJEB2gkoj4wtT3gWrW/8kAiPeuMk3IfQWhIGuwL9T/JIENqZAdvqCe8AuxMRfoSF0T9wdUhwJOPlgns2ntEk/Kt9RX3qIsaPsCFqbqMKjD8+KzJ0gEnZ01SsRA42/C38ADZBcYwiLwkq4uGutbnyRqlSWeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DU4PR04MB11908.eurprd04.prod.outlook.com (2603:10a6:10:61c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 15:11:56 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Fri, 6 Mar 2026
 15:11:56 +0000
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
Subject: [PATCH v3 4/8] mmc: sdhci-esdhc-imx: add NXP S32N79 support
Date: Fri,  6 Mar 2026 16:11:43 +0100
Message-ID: <20260306151147.24446-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
References: <20260306151147.24446-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::9) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DU4PR04MB11908:EE_
X-MS-Office365-Filtering-Correlation-Id: 276417d3-4a93-4369-0d0c-08de7b92b4db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	9GFe9PoGPRLJQ9raf5qcBt6lSYaFyahLgsQNA91wIM+LAJuE9xwvMYMeVosnlmuVziwIAgz6d7xeWC2aFM1odiU3t94nisYgOvAxKBkHm9oKkXU2OmGRd7BLyUSJN7GrJJd2tW3otL56b7xxZYMCzgAPldRTskBA//8Pf3v1p88tAoAE9hHBjDD3585M6L9r4YqLvAdeH9osHMQIH4ppOUTN2LiD3wzUZfqlQ6XcxOJe7EaTzYa0nK4liY1w8AwpAVZBwFsjROJVDTlWB8j/In+L+LBPZL6l5a8MFHowCr8KF5htN11qHIxT6wGlGxZ6Hy/gFRqQ/gsMyH14g2nTjcChmZz9Oc7r7ZEdHgGYic3t/DCVJj42F9QPxYdJHDz65p9+cQHMp2P+D1yY9kCJ4UnhoJWyEVedMAFNb3x87WEWl6vlR/VN2qv3WIAsqRzWZYCBqrVKyfUXOrCkMKU3zII6RAjMw438te2WDevq2yK2HeBkL0e9u3RD9mCIpAnJze4bkH+LtXnU/5QWK+VB482SKiNfGlKkyPGPRjHzWH7dyvLAffqS9Z3qyzaCbDe+MRBOtQLu1JN8gW+HLL3A4KiXaK4sYa4re/SuiInxt6hK5Evhvz26c4dxQKNVSREqlXDGkp9f7MnsJc1A22KHAAGd7LlXatXeVkmEdnVkyS2PgYPCyMQcQFcWL1WgFt0X4woXOPiv7k9caspzwhqVM09/+ytqvvEZFiutQHY69x7CtbW67nLwpwyMz9vj/BJUwjLtUAq7nmjbft/Avcj0/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3pzRXlERVpCM2VXVUgyNWtBK0dGZDQwR2R0aEVSQlMyMXh1bTYwR3grOUZz?=
 =?utf-8?B?TjJiM0xGb3JSMElIeER4Y3ZNN1VNN21HOGY5L1VuYVBZcEM2OTg2SGdwejNo?=
 =?utf-8?B?c0tWOUd6ODV0VTJQaHMwVGFqT3k5VFpUTDhYZWNsTFRFQklEOXRuaDB2ZThV?=
 =?utf-8?B?YVpNcEppSzdIZCtsOFZTM1BYUnBBN2ZJLzY3ek01bkxrcFYxV3hyVXpuUGhS?=
 =?utf-8?B?cWZyOVliWGZzV0M3aDJkZmd3dVA3bkZ1SlB4bkhKU0JOZ3RoT1pWSUhvVjVv?=
 =?utf-8?B?Q1ZBa2luQXhvV1pIWExLK0hqWlUzV1p5K0tqeWNBenZnR1UyRzc3Z2FnMU95?=
 =?utf-8?B?UEtOUzU1MUxXeVpkc2g2bTFnRVgxeHZZUS9NMGRXamp3NDh3SkxyV3puM2V0?=
 =?utf-8?B?Ykhra1NqVzN4dnFuQno0NDVuMTFjRTNMMmlOc21qRlJ5MmhjVjJveWpLRmxE?=
 =?utf-8?B?SHVYcEF5MlZLUUxFcm5SV3JsQXBydjc1eW80RkJQWndUU2lkendWWDFZRXUr?=
 =?utf-8?B?TXJYZzBZTlp3VENwbi9JSHlqT3FQb2NZamwySGVFY1NUNHh1UnRkMXpaTWZj?=
 =?utf-8?B?ci9NNENHdXZTTHkxajVnNnhIVEpyVFd6bHdzdWQ5Y2t5bEg4UDFOUVFieHBX?=
 =?utf-8?B?ZVR0ak4yMnliblV5bExrTXFuMW5sMWZoM0pTVVF6YzNRTmZaeFRhK2FpL0RW?=
 =?utf-8?B?ZDBCUDNheUVmUjJDYytuZzlTZDFmMTE5cmxVZHJ1ek44RkRNTDVGRzlMOHlV?=
 =?utf-8?B?dmgzZDdoY1dEdzB6Ly95cSt5dzA0Sk4xR3JJbmVqNWRHYUFwUTV5M1JuY3FD?=
 =?utf-8?B?TlhUM2RlNjlhNjhWamV2YjdQUHFhV3ZxS1NuZ1IvdTZZSzdLZlI0dWZGWlNS?=
 =?utf-8?B?Wkd5dGRmWkkydFp4bzdyT1NTdEVOZU1PWDExT25oK3RzT0pwcG9mSWFYTVdD?=
 =?utf-8?B?MjRkbFZQaVFtaURJTzhqeFJWb2F3Yzhtc1hEa3JoN2J3U3dWMnladGE0bVFz?=
 =?utf-8?B?Y1pKNWpHQS9mMndyYUxvN0dBb2VWd2hFTjVlZlQ3SVAzbUg3eE9VME5zaTRx?=
 =?utf-8?B?MjJLeU1KYk5LZ2MrQlNRMnoyTVUyeWliaW1TMHZKNXZrcXdXRGVLTTFGTCtG?=
 =?utf-8?B?aGlLVUd2Tkc4RnB6V1F1YVFaSG5hZTl1Uy9MUnZNa3RyWEpOVlBKMytGSnNr?=
 =?utf-8?B?OXNFWHJZbTBjcVhaV3FjUGs4Y2NLb0lVY1dqNFcveXA0WUlqbVpwRldpdkJE?=
 =?utf-8?B?bnZoSlpMT0Q3WUZSQ2pocVoveGUyU1JhelcxczRoYlphNWJSdnpMLytTQktj?=
 =?utf-8?B?djIyUVhFdWQvNUNJOG1KandaN0JnRXpUelFTY2RuZ25HYkwxN3lIc1lWU2Vk?=
 =?utf-8?B?c0VxRHl3MEVIdDFMSlArU3FEaHB4RE44QlpTVkdXV2ZMSUFzUXc3MEZmWlZX?=
 =?utf-8?B?Q2d6MEFuRXZuM0FHUmoxRjdxOHZYUEh2bTkrWHh2TnBOUEUxMkhaSUltNG1M?=
 =?utf-8?B?WEFwUTBacFVHbk1sRzVQNm54TDFTVGx4d0FkNXYwU05LLzlEaU5JRnBITkI4?=
 =?utf-8?B?VUV2MVF1dzBzVlFxL05acGo0dEJ6Q3gxK0lTdnpEN1BiTXc0YS9wQlNRNEhZ?=
 =?utf-8?B?SFdrUURQUTdPQUNkem5LZmxNN1pDeTB3bXcxLzlsS2s5TnF1K0h1Z1gvalFS?=
 =?utf-8?B?UHUrVmNrWmJmK2JJN2ZSU3JoMFdpREs2QkVsbm9seGZzb0dSb2Q1dWZyaG5v?=
 =?utf-8?B?U1VwZEhnVmlWV2FSM1N4RUVrekQxTzlUT1NPMDQrUWZITWxTRkQ2bWRrR3Vh?=
 =?utf-8?B?a1EwUjdXaXV4OGxvdHpBUGRCS3hBSzN2aUxtcUVzbGgrYURwYVF5bG5UTlBu?=
 =?utf-8?B?eTFVVWxJM0kxVUVVVjZHb0tzNFFlWFFkZXNrQys1N3JLbHFJU0s0QlZoV3Nl?=
 =?utf-8?B?anp4R29PK3V3VXdtZmQ2UDhWbmpnaTNLdm42MmU2Zll5eXdCOWZERG5PVk9s?=
 =?utf-8?B?dW9NcTRHTHRaMU9jZitnRnlrbnpzMThJdGF2aTdnZVJpM0IyUVRnTm5hR2dn?=
 =?utf-8?B?NitPbTEwcTV0ckdhcTRlLysxelpHR0FIa3RXcGdhVlBvWUliaW53cnJvbHFL?=
 =?utf-8?B?a0RlZGlSSkR5UUMxSUtGTkpTNG9SeWtTSFRKMHlURmp0aFpPVmJQN3V4WXpU?=
 =?utf-8?B?bmJ4Y3RmcE1VcnI4ZUJmK04vOFhLVmw1ZzRtd0JxVDBQVkJ1MnBQQ05EWHpF?=
 =?utf-8?B?Zkl0Y1E2RGRZVk9GTWFqOEFCNUgyZStqZEo1TlFqTHB4L3BaeCtiKzdrOEw0?=
 =?utf-8?B?ciswc1BJS2QvWTgwZXltNEhYcmw0Y3dnU3NVOVJPUEZqUFZjUmhxVS9teGtX?=
 =?utf-8?Q?H/vIAnBpTfcHnrYA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276417d3-4a93-4369-0d0c-08de7b92b4db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:11:56.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLjEBW8kfkCyLx4FvwkoLp9IkSqMfOr7z+aeEnbA5v30BkBGapYskKpDJWF9/L5S0T2+nlAii9kf1uiX4lxFkRfXlsxQSLxaQNgThZ7i76Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11908

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

