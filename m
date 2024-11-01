Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6D219CC20;
	Fri,  1 Nov 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461358; cv=fail; b=TaNrgLtDP1+EZ8dtYo1pmJkNAhIQ7ztEGqrBVX9IrT28cFWUueba105LKyN4DJfCXz1iNwztVfpzHliawCj2YIzq40gt2ZTJ3DJL2RLKFjIB4WLlLh/J+/ulbIUUqkLZXdiSuFU5nsuw/FtfvVO7/uO7eyx0HDo8+SbHX41wOvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461358; c=relaxed/simple;
	bh=rO5FwXlCy7KIjxKgMwLB+V1UcfW2yLv5JsImdqWBDrw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KsjlGp+pk8MYIXAvFH67U1XglgLEOo5Yt/QC4v3xjtywP/9uygRxJSmyO2SaETdMZtLlTwW7OIIstk9buuo1pVwBIpnl2iG8OYokF+nJfpP4JNXXQK3SN/gVVFXjiPnGd1fbj6dl48wFqZGhsNP6YzA65xYfyVRWI+38aGMUbJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=oH8IQttb; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="oH8IQttb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eobjx7Uqq0b/NbYs8iNjXev6r8xzOn4HcnuyjAnVGLT1mkDUOutW3cNAN3qJgNgI38Bm3j5hdYn6VVbL5k0GmJvHKlyW985csZ5REusScGhFQF+K6dLH1/irEPwUYPr1ZsBYhX3pe+N8uz1EaL5UA6eqmRGo6gHmvKDZeDfsDLi4DQt8ukKyVkGeXAK3ramEuIdPWzrvOSOfOzztLFAKbswlDyMFUcGpy/Szf/LPAvK5r41FIg7aRkixav3gDee74MlYJbJBySNB2StQBN9Rs6rDuQ79pEawr/7f6BVIO1wMqutaa2rSk2FN9aYojoBDFhX6PJzsYEgLq7EPCje/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvBP7CSrYKKIJZ66d82Bpeh6FY6ZJ6q7LwGPGbdGz6w=;
 b=f+ZraaFWBQg/qxHr/nL4aKcD7w+5ZGveBLOyI9gL3G0euSXl4Yu21HIGKxtRpR5LvTfYsQzDC+1UH2LJ1zZHzV21wpIGqUawEpWGFzGfQ+2u0ccH0020D00KEVTJjBoDlnHxp2wsMEPweVvQXp8/4lE/Kb3ykLs72bUImiyNc3rHEXaFaMmB8dntkZxzt/xXgVAQF3jnCCtWQK7GhLHPxFBqnf0X5Rs3o2klKYV60JAE30dRHxa6gibguqGFneBli/AiLQQz776QONBD0Xj0TbvPqDJmCRMJE+1S9TuTdNOEl2DgJ+DRNKn+YVfrFHX58PS9gTiLGs6JBvmxDOYBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvBP7CSrYKKIJZ66d82Bpeh6FY6ZJ6q7LwGPGbdGz6w=;
 b=oH8IQttbkBs34FxRv3KKKQvC5CTZlhL6GCYacGQ1AJI0sDhqWe2V5iSPGjQcUNRK4x+KlZu+tXeJnYtLtr/RrSEBTi1E31TmoamuEw+vJFnSnajcBU9k9xDRUzcHLa2aBsxa4XrNph+3MsIdrnUSO2VDt9I6oePnYtPES1vqsHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB10519.eurprd04.prod.outlook.com (2603:10a6:150:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 11:42:28 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:42:28 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH v3 0/2] mmc: host: sdhci-esdhc-imx: implement emmc hardware
 reset
Date: Fri, 01 Nov 2024 12:42:24 +0100
Message-Id: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKC+JGcC/3XMQQ7CIBCF4asY1o5hAEvrynsYFxXQTiLFQCU1T
 e8u7cpoXP4ved/EkovkEjtsJhZdpkShLyG3G2a6tr85IFuaCS4UcqGB/AjOewPRJTeARqGtRES
 tDCunR3RXGlfwdC7dURpCfK1+xmX9S2UEBLu33FRa1JVqjyncyUJ89jsTPFu4LD4IyX8IARwus
 q2FlI1stPom5nl+A0MwD1fzAAAA
X-Change-ID: 20241027-imx-emmc-reset-7127d311174c
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, imx@lists.linux.dev, 
 linux-mmc@vger.kernel.org, s32@nxp.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|GVXPR04MB10519:EE_
X-MS-Office365-Filtering-Correlation-Id: 029fcba8-39e7-44b7-d156-08dcfa6a4358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDJWQkFQTUc1Q0t1N3dmcG50U0RXTE5wV3JEWEVYdUNQSDFCS2MyWEcwOE9j?=
 =?utf-8?B?dVRzL1haUXBsaWRGUTVMSW9iRHIyb2h2RzlNRjZOZUtKUCtRakpyOXhkWlRt?=
 =?utf-8?B?Q0VNRVhadHl6RGV3bW10WlR2M0hQVXF2cWYxS0JlL2grdHpmOHJBc2xEOHlw?=
 =?utf-8?B?ck1zc3cyR2xVYkZMdXp2clcyaGtiNjNIRHNEemNOZkVhSHFQc2FpRW81QUVa?=
 =?utf-8?B?TEZQWmY4cDV4dnJMUWNOWXpYZVI2b2VrdmxmZzZKZ015VlV2WnQ0U3NPVDUv?=
 =?utf-8?B?c0R0bzFNQlZYaUcxeStTbm9JbzJyTFV4YnJqY1hYNHptVXZKaVdwQVR0WHBl?=
 =?utf-8?B?QlVaNzZlSXdIOWlDZk4wOTI2UWphemJpZGdLQ1BxRDVkanF5aEY4aFhBQkoy?=
 =?utf-8?B?MzVOWVV4SEhIeVN5akRnQXY2c0I3ZSt5MUhVN0luaVRnQytxTHNYRnpSTjJp?=
 =?utf-8?B?VERoVzhjNDhhZVpOTUdyMm4zcHV2NkM2UGpNMm1PT3R2S2FRWXRFb3kwWGlN?=
 =?utf-8?B?SjhYaXZZZHJUVEh5TEd3SlNMSFU0MWhyd20zRVp3ckJ1MnhnRmRhN0oydkhD?=
 =?utf-8?B?ZGkrSmR2UnoyQ1hwU3dQc2NoNnZqY3VaS3RMRnZWOGt4eFdoY0prUk1rZGk2?=
 =?utf-8?B?MjVieFFCNW5sYTlRMWtHUlhPalZjcE5UZlhUdEsweTF3SHBNeWxuVjFRYTFN?=
 =?utf-8?B?Q2JkdS9yWUhuTzNpNGt3UEN5SWM5UytLTHp5TlRQclQ5cmEyUGtpS0d6WDZH?=
 =?utf-8?B?cHZ6Y21NQ1A2UkZpRmVXclhVY3VEcEZpdjZRU2RTRUhrMXozSDVVQXdOQ0VI?=
 =?utf-8?B?RU04YzFhRTZDWTcxbzg3TFZTZkNSQ1QvdlB1RkhMTnI2SkgzbXB2NEFTSnZG?=
 =?utf-8?B?cWRyamRKRzRLdGlQeGt1MjcwMEM2d040NUFQUnJrdHdDZVZQNkVOY2Q0M2Fj?=
 =?utf-8?B?MmpuZ1BGTHNQcW1JVkphQmFIWVdXcWQ5YThCbVBHZTNhalFDT3FWUEQ0cnVS?=
 =?utf-8?B?ZzhaVE9iSWJKSk1LZ1Z0QVcvZEdMaUdsYk56RTVrQlQ2aHQ1NGkzMDVvcDJR?=
 =?utf-8?B?S1kxd3MzaGRBZE81ZTQvZDFQalJzaG01UmhPbDV1U3VRSHl6OWw1cHNpcHVq?=
 =?utf-8?B?a1oxNVhRNG9aUGplZm9qaDhySk90S0pabDhkUU9PTnAvMStGc3JNY0J3cVdG?=
 =?utf-8?B?Z01ZaXB0bVVpRjBXVFlxa043V2d6YzdaN3dJd2FQUkhFemE2RzluOXJ1ZTc1?=
 =?utf-8?B?RkJ1cmthbithN09YL0tIYVkrSjhzakpVZWpJVjZ2UzhXNTBmZEVvUzI2QXFG?=
 =?utf-8?B?WUZZNzNURkwyS0dHSWw2VWZuNlI5ZldEa0YxU0dwK25UZ3Q1K2tEYy9aWTVh?=
 =?utf-8?B?TVBSdnhHMGZha2FNY3RTUUpQNk5ISTJQSnI3RWlzQXE2OGZYRXFKNVRSS3pn?=
 =?utf-8?B?TWJiTCs4R1RKSTdqb0FtekRwNDdOZmJscHc3ejAxQnpBeDNITXNxcHNxS2Vr?=
 =?utf-8?B?eXlXdzNzL0NwUVFYWmR0dHRVbWg0RlpUUDZNZTJDZ1E0L1ZaM2x0VzJrTnNZ?=
 =?utf-8?B?ZEFJNWFkRllXRUg4SUJHRjFNaWIzMitHR1phUVlsQ25IclJlVWtSM3ZuaDln?=
 =?utf-8?B?RVNIUHp3NXY0RkR1b0R5YXcyQzhkWW9yY1FsemdxNUlwS1d1R2pycXdTcjRT?=
 =?utf-8?B?QkZBUmJMZVp0aDB4M055Si9yV0ZEbGYxb1BqRTZGcDhZc0ZWMHVRYkRoSVEw?=
 =?utf-8?B?dXJ1N292NExiVS81VU5MN3QwdVRTUUdjd1hDMFBIenhBQ3FyM0RucS9GYk91?=
 =?utf-8?B?YTFMVXE5TzFtQkFEU0U1eDVaSVgyb0VEUEw2QjF1b1FpLzE4WGIzb2ViOEJB?=
 =?utf-8?Q?IAChvBahQH7yh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVB0RXBOQXA0dTE5QUJPd1VZVEJpTWRNUDFTdVhJSHFTNW5KblRDZUx1MlQv?=
 =?utf-8?B?ay9iVDAzQms4d3lzcyt1U2sxSU5nelIxSGxGVE5HZEJxYmk0MHFBczlSOWVy?=
 =?utf-8?B?cEZ1dlpmWDNsRFd6V2lqYldlNS9BK1p6QlZzcGhLVWRXeWRudkNHc3RVZHMr?=
 =?utf-8?B?MjloNk1VUG55UVZDelpNZzJUSE1Wdk10YmRJcmI1NFJDWmw0SHU1akZRT1F1?=
 =?utf-8?B?R2VIUEtSaUR0dFVTREQ4dWtNbE85SWlIUlNIcEZGR0Noc0xOdGc5SlZ2NG4z?=
 =?utf-8?B?aUZmQmxSa014RFB5ZHBOY1k3VWw0UU9DSndQdXpFVXZqMHdDbTE3WFBGNy9Q?=
 =?utf-8?B?WWd1b2FuNU5HQ0EwY1AvMEM3QlhuMmFtM3pSL3VNWnpONHZMdHJZWm9TdGpV?=
 =?utf-8?B?b0s2QjhTdUdsUHR6K2hyblJHb1duWFhXODJ2QlYyOU11RVN5UUN0dm00MWEx?=
 =?utf-8?B?M2R6TERmOWdDSWljeHYvOGRtejFJYkF2Um5TSkFSQ0k2TzYrcmxkYWJZOVNz?=
 =?utf-8?B?bCt1RWo0bUFIcmRKUFpxYmpmOFZjbnpwNEJNTE5SSGdCY2RPb1FnYm5ydHJr?=
 =?utf-8?B?MDhEa0gvT3JDb2R6QzVxSWgzZDl0RDJiazhzU2FRbVJQR1Y2RllYN0EyVGE4?=
 =?utf-8?B?UG5RdllJYnVmNmtEdHIxWEhBWDlpaWliT081bnZCOWlUdnVVMTJRYUZGUnhU?=
 =?utf-8?B?aHVPU0F5ZGJWOEh3b0hnb2VQaXdBMjQ0UWorekVnV3pha2UydjZTUjhQdWJU?=
 =?utf-8?B?NUMrLzYxcnJ2OG8zNXJRSGZITFpwRDVJaVFSZkhyUTUwdyttZTN4MG5uNVpC?=
 =?utf-8?B?MFgvaEt3ZkgrWks2Zm1iNXRlczhtOHdrRmRlTTBTK2Y4TTlESFlsVFFNRUZ3?=
 =?utf-8?B?M2doZjBTOFI0NEpSNDlIZllJQkxrSndiQTJ0cnJlbCtKUjM1OExrb3RRVjE2?=
 =?utf-8?B?VURRMDZEdmJ2NFVRV1VwaVFONHAxbVlZT1dxU2gwdkl3Q2JWODhrWnQ5V3dJ?=
 =?utf-8?B?TlhrNWtFc3dMUklhZndVNGliNFBzZlZOUkJjVTFpL3RSdDQzemIxekZyZjJ6?=
 =?utf-8?B?QmlaZ3lsYVQyU3hOeldhWlJOT2djUmhzN1UvN2lRSzVSbFJHcU5CMWZKNGw5?=
 =?utf-8?B?a0liQzVSMC9hRHg3elhzK2lqbUlGUC9nTTh2VWdwR21hVFRkNE9IR1dLZWVa?=
 =?utf-8?B?N2s5STJ2YkwyTUU1cU9vWjhDZmNYbEk2ZlBSbWNyd2tNZWJNL2x4VWZDalcv?=
 =?utf-8?B?MDQ0cjJsVEN1L1BFemNRMVg4amh3RGNacytxNXhVY3g1UWxSL0V5OWZvY21E?=
 =?utf-8?B?eGFKd0RrY2xaamRGV3k4bEpOMFRFTkZvQithK0RlVjFDRnR4azdXeUMvTGE5?=
 =?utf-8?B?V3laVkphTHVBNmJCWlVqZXlPQUpmZ1BhRjRyU3JqbmNSTWVSYkVETDh6Y1ZP?=
 =?utf-8?B?SHpDL2hWdVNNT3VQb3ZpK3VHVjR2dFB4SzVMNXRvdTlzY2tOditBRzlKeXhQ?=
 =?utf-8?B?eDhwZWZJb281amJqdHdmZlBtTjFnSlJWbC9NMW1UU1VFcWpab3hFdFBKMFhm?=
 =?utf-8?B?YmQ3ZCs3Y1Nsb2ZhYmt6aXdyUWZndjg4WlFQMWhmL05OWFZ0WFRGbHBxSHdo?=
 =?utf-8?B?MW5TYTlJSEw1dWZZclV1LzFaUGlLZSsybzBza05ZY2RxZldpL0xBa3kwaTdN?=
 =?utf-8?B?QmVMbTN2R0M3cWp0SUV3N3ZNVDRkUG1BOGdlbCsraXZtaGRBUFFqcGsrTDhC?=
 =?utf-8?B?ZHZPd0phaEs0b2Q4WWNYd2JHVWpoV0E4alRSQ2w3QlFIWFBHMjREUWxnb3ZG?=
 =?utf-8?B?SHYwcXp2bXlBc1FWelNNU3BPWFEvUnNGY0U4dHBWRzNCeDBCNXR1RUpHTHpK?=
 =?utf-8?B?WVl2cFNDWjlxdGY2VUwrbnMyeVZXanFiSk1UYng3R3h3aVI2aGl6L2hLNkNn?=
 =?utf-8?B?eVJWMUpOVmtuR0hRY0lJTGlOU1dFV3VHNFdoaGhqRW9ic2ZBV1p1YXJoY29z?=
 =?utf-8?B?M0ZkNHYwenVQVzRMTTdzVHVMbGJ2MklRQzNlc2o4c0hDaWcwSWF6dVhUUDlk?=
 =?utf-8?B?MVBqRDNVNzlTMVhIMnhYVFYzNTZuVXJ1VE1SWkswdXd0SVhqUmxWWjMya1RI?=
 =?utf-8?Q?dZ2MdmtA9DpTwj36OvS9T/qSA?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029fcba8-39e7-44b7-d156-08dcfa6a4358
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:42:28.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ipKh3Ax+Gw13YO8ku5pneFsByUEezj0sXxUbjyR93uWO4W1VcR7GAvbTI9PtW8FZDuB74y7WEishvbtwuy/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10519

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v3:
- reused existing control register definition from sdhci-esdhc.h
  (Reported-by: Bough Chen <haibo.chen@nxp.com>)
- placed both control register mask definitions next to each other
- fixed timeout write register name
- Link to v2: https://lore.kernel.org/r/20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com

Changes in v2:
- replaced udelay with usleep_range
  (Reported-by: Adrian Hunter <adrian.hunter@intel.com>)
- added comments for delay values
  (Reported-by: Peng Fan <peng.fan@nxp.com>)
- delay values based on JEDEC Standard No. 84-B51, 6.15.10 H/W Reset Operation,
  on page 159
  (Thanks to Bough Chen <haibo.chen@nxp.com>)
- added a second patch demonstrating a cosmetic issue revealed by first
  patch - it bothered me during development but is not important
- Link to v1: https://lore.kernel.org/r/20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com

---
Josua Mayer (2):
      mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
      mmc: host: sdhci-esdhc-imx: update esdhc sysctl dtocv bitmask

 drivers/mmc/host/sdhci-esdhc-imx.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241027-imx-emmc-reset-7127d311174c

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

