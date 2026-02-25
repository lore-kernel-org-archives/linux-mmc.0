Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2C53C1981;
	Wed, 25 Feb 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026759; cv=fail; b=NsSu8Z6xXLW7L/Q6ZXsM9Qe8oNafVOgkpBOy7QcxLGkzKtNfkl32sS+RIkjxvctPGOzv81MnbnsxzqSi8ftEncMyifLwvcZwsseRUHheS3omcF4ItKOhXX/EMUjIhR9J7xexxEY1XgU8jpzhsQXxJ9VYW38PfF1tsR2ddOdGOj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026759; c=relaxed/simple;
	bh=gn509GCWWxpu+1dQX6B9KPbPOW/W3zsPzA3smNthiVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlKuXgWhYug2jwcqyGm1O4bU+rvuzHlS4XDLc3FmSpVtWmYQcpUDhHPGCJ1f1M+JYdryVu4h2RK2kqIgvQZZ0JIm0NpDyFeICkmeritXHHkgI/zsfOMcxjBiR6mcT3B3kLSxljexA+eUstbyvwG4w7yDlsag3XQN1my5NnUWWog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iGdsJxfY; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iGdsJxfY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CojMx+kiyusdIl/JDnS+ZjMUrSqv1t+Fe5uyvbNEyzaLWFlXczQVMUFxuqLLCElu2sPx9ZyQA8zetlYLQF/hr8URGsDkwN15DIhEMW7Rh7YH0ffEAKDIUHruT5L8J2X40F2UM3AKPoTb3q6HsBDzkZxMG53ghZMiNrDt1lUinfRgkThcxM0epHS+q31OatnrGo+xwRiWZ3ltC4vYfDUDbutODTnjGPY6VS7XJCpA6OnRysqp9MHSDr3qHoivK9YxDcPDOHEn46CcOPR3I5nuWPsIuZC9v/ubt4LfpQcIsudqvjS9J3jCMbU6/UdduJ6eyknsy6GMvlczv0IWOxHHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4owklVB/re5Cr3onmb0dPXo49+1+eeWBovNpfsq29ZM=;
 b=sNt80SzHZ3ujzzUbGr/CbMzt/MyGsNy4D540ChU+k+gHgjQBiBSr/ip012Tkn1qkk/5UiexK36rFIil9t4OnJZJJyl5547L9vPEvONgXYSJkssS31iO2YDsGNs4y8XJEJitfeJsn1C2MZm5N0BwsQzXtLFoUXnEyAXDIed4oVUgK6xPl46DMtM/P55VEZ5b7K3MZM3VA5271Zpxlu+JrMeFmqv2oE6rURjyUaSpcl6miJV6kQqk9lFAbc2IoH1FiMA/B/vSWD+O1RVzqZ5zfaokbEHLbmBavuJunJCalSZLW/TZNj9yq3KcIZ38isZ/76xB6BW7i+6nkWNoeZWEc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4owklVB/re5Cr3onmb0dPXo49+1+eeWBovNpfsq29ZM=;
 b=iGdsJxfYafo88Yzw0cGgJv234jxIolhkA5xFIg/a+s6eKoMftbSIvmN5TrRk6UjuOFrw8WFH6TLIb7+f2DvPorZSqn2J+1svLc+AziMCKxoFEpppXJT8fKfHF+ghTkNR80NXbyrsQnp4LzFkW0LGu2GPNJaq6uFEQ/M0EeHbPYsa75ZXIAe1HFn+UKK1wGmwwVzjdq1f0zIRdv2ZWL7iduDHvfZYqnAKvtClcefZx/UDD1dm4bKqoNgjxY1YocpyK79P2HlR9aEL/VB7bsI56iVnEaaTokzlzrKsLOc94JsvwTEMSnjOJRm1pEETkS4yf1e6G7IaSuORdzC+kmSLZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 13:39:06 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 13:39:06 +0000
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
Subject: [PATCH v2 4/7] mmc: sdhci-esdhc-imx: add NXP S32N79 support
Date: Wed, 25 Feb 2026 14:38:55 +0100
Message-ID: <20260225133858.8026-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: 4535dc8f-2175-44fb-1581-08de74733f32
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	kX4sjx2ldv1unuqZxZ24YJQKMJ5ANU9hVv8xC7SCJNy46gLvnh/L5XwYF3ftqpYzdthBGs59FeMe+QL5E0oGzFeu6QsIToNpVnnz1Jv5TVJmxjty4E4JD/Cf9gWLXzZGU6tBCiq8G+F1wFJAdFAuhDbGlFfTWvR9KWBbhifbscHGZRP6wsQnWA02ydnr1bCOq7+8a8xFgno5APFzHn3vIXcaZNQpErvW6/90BZmvirX93ihn8aEUFnIknBjhT5atGfrYtOmuHkranY/t8FJV1lXP90n3Rmcb7uZlwuS8bnlt3TQAVhbDvMXBOwBtVorH4Sfq+fFZKkQmGtXyNwartv3Liv9W885McswQCJv2q4Zt/HthM+nGKRdvCJmtjUtZ4di1TB4tZKuZ8N6A0/rN0hSWiEsAikFF47WEh8BIhLnVg5eVZWtXhlmqGUEnkHBerQu5VEf53nd1KHRN9lguvPqS5ReX7fqwG+cjbpx+/V5WSEzhgocKWU+Y5Atfn0LUykYwXPw7b/mI/SOgeNlVg67juDg4Zk0Dk7cVjyC8le32hBINFUllm67vt4h0fwOW/u0kmBWmyqEgGYmn+HQABZwJrC9kNMXqetmDXeP3yFdHge4HVPllIKQoKbDEh79P2lHZ8NYZ84qKI8vnTBKYYd9KasSjSTOJQF1ee9SHgpJ9zLLD8ocTtjFswklY70UBVIVAPL36K6s0TOlqZUa9vAVeqoSM5zQLNYHArAQ+ndEh74fbuH2matbLD4XupVTf0qNPu4iDvyw8HwtFs29nIg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zzd1ZUZycU9MUFF6Z254RVh5MmF5TTcvajhxRlZ3a20wK05FV0JQL3RSMmk1?=
 =?utf-8?B?WkZmUGN3MzVQOUhXTi9xaW1meTMybU5semFVRTFaYU9qTk9oWXFXeEx4TGdD?=
 =?utf-8?B?UGl0dmVCT1dnSWVWMkpjNWxwRWZ0akNEejR6aUxMMDVjTzBPb2k1ZVBRNGhi?=
 =?utf-8?B?UXRiT3phTTVUdFMya1dLaEVqODdtZU9BWW5rY3J6c2FydDYwa29ZbjIrVGxS?=
 =?utf-8?B?YkJXbUZjN1hleFFYbG1EanVlamJhK2ZvVmcrd1ZXWkNCQUVnVEFGRDYzWmdQ?=
 =?utf-8?B?SUc3YXdKTStDNmRTc2ExNXdCbVE0UnNJV0VtZnBQQjZTYnFERXlLT3NMWnFr?=
 =?utf-8?B?MzQ2UGhlUGJ4cWhablV6cUNzYjRjWWhORFFSd0cwcTgwTVlYSTEyVUZYZzRi?=
 =?utf-8?B?dHhRNEdTU0ZvdFVXK1ltSkhjSXRRNmQxUy9MMmZIa1pLSnhXaG5FQngyT1N0?=
 =?utf-8?B?OFQ5SFVpdXIxV3BpUzNvaS9rVmZsYTFLZzZmUFpnZHpNSnJKSFJ0TDFldWhq?=
 =?utf-8?B?Wm9oUmlhcEIvcm0rRXhSWW9SbjVseTNtcU83K0M1Uk9nR2ZocUptNlZRMG5p?=
 =?utf-8?B?b1YyMjdFamMyeFlYWU04a29Xb3NWeUdKZGZCQW1XNis1dWhkck81WWZQaDNv?=
 =?utf-8?B?MGpsTWFJamRwUEFHdXJON3hLV3hyQmY3N1p3SnhxWllqYjJwMU1GajF2ZS9j?=
 =?utf-8?B?czROMFNMSENnT2dCU2ZLRTVZQ1hOaWcyR3NWR1U5ZzQrK2pWKzlkNlhKZWJ6?=
 =?utf-8?B?cDFkK3h1L1ZUd2tPKy9wc21sOUtQRWtmMDNmUlMvUG5WWW9seU9DTG5yTUgx?=
 =?utf-8?B?RWZhZ2txU3BFdXlQenFiQkJPRzlPUmMrVGpWbGJyTXRQd21Na1Eyczl0OHIx?=
 =?utf-8?B?VEgrUkpiNDBPZEtBLzN1M21USzVqZ3JJNEllNVpKUDVMbTVZMHRvazg4dlpv?=
 =?utf-8?B?WFAzSzVrZjVqNFBKVTkxNHhHQkpNeDZyR0J5NEthTHh4ajNrVk5NWmdYQ3Vh?=
 =?utf-8?B?c0d4MisvY1FtNzJEMG54U3BVOE82MHQxRDdkYWNTMTJBK3lhcmlLREtDeXBS?=
 =?utf-8?B?Ui9WaldKamhwa3FtcnZ5Q2pWMmlCMHhJRzN2VXVGR2l1MjNFY1NUbkx6UXJZ?=
 =?utf-8?B?N0padXVHbStSdFN0Nlk1M2E3Ylc0OExrV290RWlyeVpXNTZkamsxQk1sM3o5?=
 =?utf-8?B?eUk5MHAvQ2VDbXNTbFpybURMd2VpOXpuWkpUdmxjRHU0VGpsN3duZzNZNnpX?=
 =?utf-8?B?djBNSDk5T3hKWXRFS05hYlVTZTdBK2FnTkV3aWs1ZlhUWHE3b0NtMTA4MGRF?=
 =?utf-8?B?YlJGK0l5Rkl4WUp4NDdJcis4UGttcVFaRC9mWi9QZnlocCt0ODJ1WkNFWEZq?=
 =?utf-8?B?MUIya2xnVVF3U1A4NEpDVjg4OXAycnNoUHJIb3d2ZjdzdnlndVAwK0hIeXF4?=
 =?utf-8?B?cUZ3aEJ0NTFpSGlmRDE1ZERhMHBHeHd6b0xjVXF6NHM5azdRRkNyWDliWFlv?=
 =?utf-8?B?RzVBNWJZY3l3YXRUeGltWEhYWjRGSzJjREJXZ1pMWGxFUEtRUHluMGQraDhN?=
 =?utf-8?B?WnJhei92S1NaSGhJMDlWZGJtVWpXTmFsN3RpT1hrbHM1Y2xXYW1vT1pJZ3FI?=
 =?utf-8?B?MEZoL09vaEFpQXoxSk1QbnpNeUlJczdudlJzZW50YjFSNFIrRXpoMWphQW51?=
 =?utf-8?B?bXFRWlhBNkFWdWRoTXdqSFA2RytSSjVzQUZqODhYdmxjN1p2alFkbDJRZWZ3?=
 =?utf-8?B?K2hBTEZnMG5KVHFoVHpQNnlyUEVUd0ZsenNtajkzVmZYRFRFNjNQV2lOd2pV?=
 =?utf-8?B?c3lkS2xjbFVsOFYzSXo1bzFkSHh3clNOUFRkcXI3MzVrMnQ0SzJDTHZYZmhO?=
 =?utf-8?B?RXMybC9KM3g3MEhzeEVucDU3K2JuSjR0b1oyUXIzRXQ1NlB6Z01OcFdSTGxE?=
 =?utf-8?B?YjQ5UjRGVnd1OFR4cTBCVFFzeitDNWp5L2FsY3lOQU9zOW1MS3Y0cTV2ZXll?=
 =?utf-8?B?N210OWxYQ1Q4a0d2UVhTVXVYTkxldDBZd1FlaWdqWkRaU3JqREkyczU2ajhC?=
 =?utf-8?B?UzBFZWYvWllYRnUrN09vcXZUazZySEdob1dzVjZXWFBuaEtXdVJkNjNQMENC?=
 =?utf-8?B?bFJJQlBZTzZVVy9EbmxNQXpBbFlSZGQzeGZSM0s1bmgvcmE3MFdJdXRSdHhH?=
 =?utf-8?B?ejRJSW9iR1RPVktzbUx6UWhjVXN5NVRWY0phc1JDeFVMUWx0cDdGQzVDdEpH?=
 =?utf-8?B?bVVwQVRXVmZpTlNrUUFLOUhGNjBMeWNUVWJLWmJtWld6b3J2Sk5mbWZKZUdL?=
 =?utf-8?B?akxGSkxJbVkvbCt2SWZPWm0xRS9FZHV3NE5yL00rWFlILy9SU2MybUs2Wlpi?=
 =?utf-8?Q?fSnuv5hg41DFVeCM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4535dc8f-2175-44fb-1581-08de74733f32
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:39:06.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8M6NVr91qmZJKYg444w3EIlL7NOopbQ0xp6mCKvNYaUIi/neFna/5S8Ad5figGK+I7BhRSG537PSsW/+XECTMKafGTq/9lOwZBHPZrkIRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add support for the uSDHC controller found in NXP S32N79 automotive SoCs.

The controller is compatible with the existing sdhci-esdhc-imx driver.

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

