Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7E32C9A
	for <linux-mmc@vger.kernel.org>; Fri, 16 May 2025 07:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747380989; cv=fail; b=Ciud4lNjJrA7VRCqHW6azqVHdKqDh6FEPL2sVlZqY8PhdjjmvcLNGC05rzNvQnp4hh1P+XtboBYOldAUAIpEXOtU+u15e6oPcA4H65GQHT0MbRS0LXge/P/Q7LmTRkKIZQ/t/9i+/wQBRlBzbl/LfcaAIokNhcURTtb6nwFYeFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747380989; c=relaxed/simple;
	bh=TzkLQPMCY7af+ye4c5W1qdjxjfyhOr68/Uw7VY4rzLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sJy+RluzPZqxSBeHgpi4QVb2PXcGdC9clovRE/Lx97P9eDF8869FbcEuunQt+7MEZGRgQOs070gzS8iKPU3V0wJgNqgJM/301F1BtZrMrpeKHjPYeyNsBr6tLAuyuJ0VgYD9DxIx26K1egAx9q4DWPlRmeaVlUrhCPWTOQigxLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DneG7QTp; arc=fail smtp.client-ip=40.107.105.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DneG7QTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfGkMVTo4Wq/3IZA9ePiHH8EZIZHfG+RYjHaKb7+6pYYgcA5XG2MRl5fdRc6aUvL/NyGGX82AdUdbZgfqfHCzRN0PriDSk+OrtkbrEeU52j4hzWt+eQYQoJkx1Lvpg/Q5EUSg4W+MCRo1AO6hZfftTHECNzsrq1N6wdHsDiEyNnHGAVXPPbaHc931Cy5GCyCrZK84/MzIvchY83ztFc61M22HOJWDC8f8Z6JRKhwKUP/l4d8Hz11m3vtHt1iSLSJbQfAB5F4W8I9ClhVvpc2hVXERL41XTIVR28+eF07fHPDYkde6N8VlFHA7hUPezxR4gw731Gw4+GR23cEr3Im6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzkLQPMCY7af+ye4c5W1qdjxjfyhOr68/Uw7VY4rzLY=;
 b=gwFVxnNXWFUhIHKD5zQbmY5L3w2wH7lsEznXibLdMGFmtfaWC5xr3owv2QptSF+I2ByO/wMxSS6WwvHBqD2CM8QaXT/UorjabFuSQ48Jc5oPisx9mQ9p+UhExQsz38jAW93chQNxyhR9COFjDb7+sdTrc0syvT12iwRF9jwOFI+Zu5jR6BMqiCEX0pwFmFWYrtwHpi/+NNY8Z6bg2fZneQP26GgR9AZtvpHmi/rHj/cZwPHAmjbNHXoZmPoTn3QCKD/lgexN2oB26bF5MKjbDNUbBtTRfUj0+TBaCRz4PaWPhfBOXDbQUoFSlXJjnUUrWkCBRYltTJm8mmFRQgl+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzkLQPMCY7af+ye4c5W1qdjxjfyhOr68/Uw7VY4rzLY=;
 b=DneG7QTpFLknAkUNKFbmjfbn1LBopfOs84i/cxUPXRD6FFV0ZyhzxSO5tRmKcE1BjotHouvzfKNipeh0Rv+W0uv0aH5AiNy0nMnaMjVcQN600rpaLAT1hya6ugG2wY2oE5LJdbY7hPlOtEBocLycKpQ7L3FjGoPD0e9ZTkgIqAe7L3qBilOssV4zr4CztP1K/dgVx6oSVws+FZztQj1bYuiFdkngyT3zMnt6qyiUoVFky7pMvHxbuAKhswc6l+UTXPN89ni4yPMDzpoZfq9cTpyt9jbN2/xa+ES4XA6nCg34+h+hi7nFd5YjDTs1fH0dV/sfnqG8VSX1EvUaKyzfWg==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAWPR04MB9886.eurprd04.prod.outlook.com (2603:10a6:102:37f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 07:36:23 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 07:36:22 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, dl-S32 <S32@nxp.com>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: fix few build warnings
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: fix few build warnings
Thread-Index: AQHbxisLNXm7HadvEkKpyrguTo8ZBbPU3JCAgAABS2A=
Date: Fri, 16 May 2025 07:36:22 +0000
Message-ID:
 <DU0PR04MB949692F9FBA9E01C37C777A99093A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250516062423.1408380-1-haibo.chen@nxp.com>
 <2b4f448f-33dc-4940-b7f7-faff0e0a0c3a@intel.com>
In-Reply-To: <2b4f448f-33dc-4940-b7f7-faff0e0a0c3a@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PAWPR04MB9886:EE_
x-ms-office365-filtering-correlation-id: 609e8620-3cef-4c4b-bb68-08dd944c5b4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?N2JsaUl2VGJCUk5HRC9SV3doT1N3S1FNcHdSNjhUdFMyUlFPbmJ0SVJjaEVJ?=
 =?gb2312?B?NjRaSVY2WUJQa1R3WCs4c0dHdytZZEo1WG10QWQvZSsyeGxORHF6ZjBTTmFS?=
 =?gb2312?B?R2NBY3FsRWQ1STJRZTBjMnZkRlRCNUpaUFFwYmhLdEx5MkdYaWljMnVPS2Ra?=
 =?gb2312?B?QjJMNUpNZnNsMURSSzVyNjVXKzFQUzdSQ2pxZEZDY0JWNEljRVZpWGtIT1lD?=
 =?gb2312?B?aTcwWHBTcC9NNWZDT3IxR0crZWdabXdSRy9QbVF2SXRsbGI2OHhDbU9IRWlm?=
 =?gb2312?B?MEp0dFpjOXpIakdqdHFCdE0wL2N1dnlsZTF5T3hYdStuQ2pYN3hLRDl6dDNj?=
 =?gb2312?B?Nng3Y1NCVm81TzAvVS9hYzArc0o2TnZaU3dlZmhSTFZEcDdDUStPTjRHbDdH?=
 =?gb2312?B?STQvRVU5RjlhYkhSZkd3Y3Jhb1RHS1RPdTlUeVA2dVU0SEp1ckl6R3ZTTHM0?=
 =?gb2312?B?aWwxclhrTnp3L3VTaEpMbVY4dnkyS1FEVVhwbTZjeFpldC9qRktoRUszSlJM?=
 =?gb2312?B?R2FEV3FxSkU0c2JYVFJYejNqeHpWVmJiUk1ob1Z1Z09nNmJ0T3FBdVhydm93?=
 =?gb2312?B?M0hNSFl3ekZBS2JyMS84RVovaDg3ZmVMV2VVQWJHTXJnTGh0cDRGQ0c4R0Rn?=
 =?gb2312?B?WThiekljeWY3Y1A4aUhvYk1RQXhjRVd5ZlNNdXdRa0M3Y1Y4Q2Vxa1VsUEs1?=
 =?gb2312?B?ZGk2anRtaHlkbldwQzV6bXdPN0Z3WHFQYWJVUWR0WE9sYnVPSEN6RGtIZDBY?=
 =?gb2312?B?RmZSc3NuTXRUczA2SXdlMHF2Kyt6cVdJbU0reU5IYnBJdDh5cHhLYXhIcXJR?=
 =?gb2312?B?RGROd0hIbkJHQTNzSGlySHJobXdDbzcrRDRyc3JSVFFkcStwUG5DVk83bXRs?=
 =?gb2312?B?S0ZWTG5vL0UyMVZMOCtpVk9wMm1sTDRLaHhMdThxN2lSUWw2cEx6dG9HRW1j?=
 =?gb2312?B?WE5ickFidDdvVkpYS0diQXBXUFpKQWh4RjNpSCtyS1pDVnYwUWhjSi9LaklT?=
 =?gb2312?B?L1JmWElKNkxqVlpFKythTklEeXJEZXFiNDd2WUhQUjZqbWxIQmtZbG4yWDF5?=
 =?gb2312?B?UUVVdEp4UGJPRWI5dXIrdWh3ay9WY1ZseHQxMU1UUTBUaGZXeWplTWVhUUZ5?=
 =?gb2312?B?c2ZsNUhQTC85TXV3aDZaL0VabkJnanRMU2pKTTYxUmlqZkdXN2hRY1NBdC9x?=
 =?gb2312?B?YmlSRlVaK21CcVB5REFIRXJNaXBFV1pXTnV4THp3UXBScnZCK1FGY2FNUFE0?=
 =?gb2312?B?RVNpZWRWUks3Nk5Dc3BlVnhGK1pCNHJnTHoydGZtbWRYNmd1MXRMdk51cnps?=
 =?gb2312?B?cWM5cUdjRDlmZTZHb1RhWE8vRzBKNmc1dG9GQUNEMGNhL1gycHRwVHZteWd0?=
 =?gb2312?B?TWFQRlVzeUtoYWRMditRWTdNcWMvN1dsdURDS1VuUzJyTGdEYVdZZTBWYUcr?=
 =?gb2312?B?cWhDNjFVenRUd2dUclhsZDdISTNMZGRqN0tTWU1velR1U3p6SWhRQ1RrVTRD?=
 =?gb2312?B?d0JUK0NQbEFZbW5yQldjbDZyTnBLOVl0by85YWRVaU9Hd1FUaU56R0U5VkQr?=
 =?gb2312?B?NnZjSjlJK1phUzBpUHVHZ1pvaGxENzgvbUFidjBYWXE3ajg1aFpiNkxucTNl?=
 =?gb2312?B?M2lLVzRBcjdOanIrYTM0emNVY0Z4b2JNTXMxaWxkZW9yZGNKd2l1Vkc4VlZZ?=
 =?gb2312?B?OHAwdDluVklGMUhkNTlWZDNnWlVlUUZVUFBIZ1hhSXhaQTVRbkIyYzF0eFpQ?=
 =?gb2312?B?YVMrL29hUWkvTHpWaFpGSlNJYlYxTUtId00rREZWd2N6eDVWK1lRZXd4QXlj?=
 =?gb2312?B?SGRTOVBETlk4Zm1nZnJaOXI3YmU4d2lpL29wQmdqTlFkZ1BHWUFUTEpLQ2xW?=
 =?gb2312?B?b2twQmNLNUtCL1VobUtBUnJTWjRjVEdtaXNVQjFkMTJudjB4aXRzQ3AyODNn?=
 =?gb2312?Q?4y6ggZNdqCk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eWthOUtkcHllRVRRTjRLZGpQNG9ZMVlyN0xtLzk1QUhnQ20zTVZvTnNqbkFY?=
 =?gb2312?B?Yjg2UDNvQ0p2VzAzL2tEM1RmQ3VQZTVsUHJFVzZRNE5JOW1xOXhlZFlHcmc0?=
 =?gb2312?B?clNvWHRPV3cyZkxObmM4UUU5RTdZMWNYWlVGOXJRWW5FZW1oTWxSRCtFczU1?=
 =?gb2312?B?YmZWeitmdVJyMEVPUThJY1dXUndWMTJrODlNUHl2Mkl4d1duaFdNZlJIV25Z?=
 =?gb2312?B?djJJZFhCVWJNejJrOXlza0FWTEtqVUl2VjBZVTNOdndZNHpwaE82U3kvdkZM?=
 =?gb2312?B?amVVUnBaa2FDZEVKRnRSSUNkL1hZVGNjbzBjK0d3M25WNk10NWlsTUlETVJT?=
 =?gb2312?B?RFB1TjlXNkl0UVB0S0xCbktKakpieElUckMxNUYwR1FteGNrWjg3OVpoRG85?=
 =?gb2312?B?Ym5qTjA2V2l3VDc2aGhoV1pVTkE4K21tNlFxTS9DaXk1bTIvb1Y5WE1wN0lO?=
 =?gb2312?B?Q25aU1Q0WmJzWjZTeFVZZkZoaFRLVTdSUkk0YXU4WUp0dHFjVDMyUkxHcGU5?=
 =?gb2312?B?NTBrN05OOWpRdEVxWThlVWd3T0tGdVJubFJieW0yeXpsTXdOTVExT0p2MkJU?=
 =?gb2312?B?aEVNKzBFMDYxeFhGUFBRU0hUNndoVUl2N3VNVUZGTVNVa1RrSzhzTzQ3OGZU?=
 =?gb2312?B?ZkUwMDAvdlpvR2Zwc3JhYmF5WkdrZkNGS2tBU25nZVhHeTBLeWVrN3FseElv?=
 =?gb2312?B?WXF2MURqWkFaRy85YVNjZVB2K0gxQWU0Zys1TTJzQmlMN0NoMnZnbGZNRWJr?=
 =?gb2312?B?d1lvaXZvdCtVVWVFM2FQbEdkM2ZYTVdsbWMycGEwcW1kQnNPTCtkdzZOdFlV?=
 =?gb2312?B?cmJqUGV5VzhlZFcyUFRlS1pvVFlVaUlOa2x5dmQ4dXhKMC9CVkdGWk56elZF?=
 =?gb2312?B?K21nTzB5YW9RRWszRHR4NFhCRm9UcDVGYVE2aFZNYUhkektBWmF1bjMvL3VV?=
 =?gb2312?B?MkJzOEczMXdLelJUTTluVnFQMXozNklDY0tBSDVVY1o3YWVMc0ZDNlNWT0F4?=
 =?gb2312?B?MmtmelU4QXUxUXJva0lqdjBsZ041ckdoZmdwYWJWblNaZ2lvbnc0cG11aWRJ?=
 =?gb2312?B?SlpKTTFBdUs2WGVMRW90cnFtQ0E4UlFUVEF5aVBTRS85aVNiSkljOU80U0Zp?=
 =?gb2312?B?RTRwbFJLckhIY0k1dEhJMjhEVWlQQ0NCOFU2NmVqNlBmZTl2TDI1azA1R2N5?=
 =?gb2312?B?YnBwK296RE1RMjI3cUJwdnlkK3hYcld4TyszSnRPNU9HdFlHT09BaVQ0a2E0?=
 =?gb2312?B?cTJhMWxJSFBjR3IwRFBBS2I1Zm9XaDFINFRqaE1KTzlhN25PRFcxQVpwR3Uv?=
 =?gb2312?B?cU9lRm4rcHRhaEFOdWNkZW4vYUxwdm5nQVp1WFExUjBkUGtHUjNZbTVIL1pU?=
 =?gb2312?B?WlRBZXlRdHFHY0RXRVZGbzdVNlNmY0hhVlhDbzRocTE1QXNoTXIzYkN0SWtT?=
 =?gb2312?B?V2Z6NWhIdEdHYUNFd2Q5VVZzRi9xdFY5VDlBUGRZZldNY243WW5qV08zWnFB?=
 =?gb2312?B?d1RhQlNNMzZCRCtPWTJPU3BrVjErcDdlNko4VHZBZVJqQmlSMVcvN1FPVlpF?=
 =?gb2312?B?MnY5eTNXN3hUZ21WWjJ6eUhxYWFQQVlYREhTcW5xblIzbEgxdVU1Y1F4T0Qy?=
 =?gb2312?B?SDlLUGtXSmp5NXNmb3l3MkF0TzA1UDZ6eVpOU3Q3Y2w0ajVJdGMxVmF6Sk9m?=
 =?gb2312?B?TkYvV1ZWaEtNZGRNRGFwS2dRZVI2QUpKTVhzM1hSbFVicUZaRmVpc3VoY3B4?=
 =?gb2312?B?d2IrMGw2TW9ETkkrNnR4OVFrVGErMWpyMnprS2lDSDVqQkVzMzBnY3ZtUi9C?=
 =?gb2312?B?YXdmVlYvaVg0UXJlemZoS2Nta0QvelhGWkc0d09kS2NQZlEwY0E1Z1JaSzl6?=
 =?gb2312?B?L2d1MlhOUEZuYkQ1NWE3NmhqS3dQeEhnWXNhUmxxejBta0k0L21WdTl4MFB2?=
 =?gb2312?B?bVJoWnpweGdqaEhCUGZFcFU3VHRkMEN5NVdYRzBmQzJtTjgxV1NqbHRsR0lH?=
 =?gb2312?B?bGswQklIcUtNSUxaTC9zS3FyWHd6RHczQzlHbHoxNkQ0bGd5NkVwWEk1UEpt?=
 =?gb2312?B?bDJMdEcxSTNhWjFkY1F3aVNHY202RUNkWlByUjZiL1V5K0F6RE9PMVpKWDEz?=
 =?gb2312?Q?t+5w=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609e8620-3cef-4c4b-bb68-08dd944c5b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 07:36:22.6230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EKxijd6ZMge/2vM/8uZz4eylMk+4lz8iwaGY42TK5S8tM+t6+d2rXF31sJ0NUegtN6bQ94vz3rxDBNYmoQSDsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9886

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogMjAyNcTqNdTCMTbI1SAxNTozMQ0KPiBUbzog
Qm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsN
Cj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBDYzogc2hhd25ndW9Aa2VybmVsLm9yZzsg
cy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBmZXN0ZXZh
bUBnbWFpbC5jb207IGlteEBsaXN0cy5saW51eC5kZXY7IGRsLVMzMiA8UzMyQG54cC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogc2RoY2ktZXNkaGMtaW14OiBmaXggZmV3IGJ1aWxk
IHdhcm5pbmdzDQo+DQo+IE9uIDE2LzA1LzIwMjUgMDk6MjQsIGhhaWJvLmNoZW5AbnhwLmNvbSB3
cm90ZToNCj4gPiBGcm9tOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4g
PiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jOjE1NjYgc2RoY2lfZXNkaGNfaW14
X2h3aW5pdCgpIHdhcm46DQo+ID4gaW5jb25zaXN0ZW50IGluZGVudGluZw0KPiA+IGRyaXZlcnMv
bW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmM6MTI1MSBlc2RoY19leGVjdXRpbmdfdHVuaW5nKCkg
ZXJyb3I6DQo+IHVuaW5pdGlhbGl6ZWQgc3ltYm9sICd0YXJnZXRfbWluJy4NCj4gPiBkcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jOjEyNTEgZXNkaGNfZXhlY3V0aW5nX3R1bmluZygp
IGVycm9yOg0KPiB1bmluaXRpYWxpemVkIHN5bWJvbCAndGFyZ2V0X21heCcuDQo+ID4NCj4gPiBG
aXhlczogYmU5NTNhZjc5Y2M2ICgibW1jOiBzZGhjaS1lc2RoYy1pbXg6IHdpZGVuIGF1dG8tdHVu
aW5nIHdpbmRvdw0KPiA+IGZvciBzdGFuZGFyZCB0dW5pbmciKQ0KPiA+IEZpeGVzOiA1NDFhOTVl
NjRkNzYgKCJtbWM6IHNkaGNpLWVzZGhjLWlteDogb3B0aW1pemUgdGhlIG1hbnVhbCB0dWluZw0K
PiA+IGxvZ2ljIHRvIGdldCB0aGUgYmVzdCB0aW1pbmciKQ0KPiA+IFJlcG9ydGVkLWJ5OiBrZXJu
ZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiBDbG9zZXM6DQo+ID4gaHR0cHM6Ly9s
b3JlLw0KPiA+ICUyRiZkYXRhPTA1JTdDMDIlN0NoYWliby5jaGVuJTQwbnhwLmNvbSU3Q2Q3ZGRi
YWI2OWRkYzQ3ZmExMDE1DQo+IDA4ZGQ5NDRiDQo+ID4NCj4gOWRlYSU3QzY4NmVhMWQzYmMyYjRj
NmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzg4Mjk3NzQ3NjUxDQo+IDkzMTY3JTcNCj4g
Pg0KPiBDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlP
aUl3TGpBdU1EQXcNCj4gTUNJc0lsQQ0KPiA+DQo+IGlPaUpYYVc0ek1pSXNJa0ZPSWpvaVRXRnBi
Q0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9bg0KPiA4YVNlDQo+ID4gSSUy
Rk9jTWclMkJCUGttZ2ZvVjJxcENXQmNLVkdvcEM1ZGx0TlhEc2pNJTNEJnJlc2VydmVkPTANCj4g
PiAua2VybmVsLm9yZyUyRm9lLWtidWlsZC1hbGwlMkYyMDI1MDUxNjAyMjUuQ3NyNVVTZnEtbGtw
JTQwaW50ZWwuY29tJTJGDQo+ID4NCj4gJmRhdGE9MDUlN0MwMiU3Q2hhaWJvLmNoZW4lNDBueHAu
Y29tJTdDMjY1MzExMmUzNGM5NDY5MWE3NTEwOGRkDQo+IDkzZTM0YTUNCj4gPg0KPiA2JTdDNjg2
ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODgyOTMyNjYxMDExNTMN
Cj4gNzElN0NVbg0KPiA+DQo+IGtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9u
UnlkV1VzSWxZaU9pSXdMakF1TURBd01DSQ0KPiBzSWxBaU9pDQo+ID4NCj4gSlhhVzR6TWlJc0lr
Rk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT0xbTANCj4g
UnNBc1UNCj4gPiB3eExkZTdScENEeDRuSEppQnJiN3BmSnUzZ3JTRkFTVHBiSSUzRCZyZXNlcnZl
ZD0wDQo+DQo+IFBsZWFzZSBqdXN0IHVzZSBhIGRpcmVjdCBsaW5rIHRvIGxvcmUua2VybmVsLm9y
Zy4NCj4gVXNpbmcNCj4gaHR0cHM6Ly9sb3JlLmtlcm4vDQo+IGVsLm9yZyUyRnIlMkYmZGF0YT0w
NSU3QzAyJTdDaGFpYm8uY2hlbiU0MG54cC5jb20lN0NkN2RkYmFiNjlkZGMNCj4gNDdmYTEwMTUw
OGRkOTQ0YjlkZWElN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJQ0K
PiA3QzYzODgyOTc3NDc2NTIyNjE4NSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVV
MWhjR2tpTw0KPiBuUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtG
T0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElDQo+IDNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1DUlA2
WEZYV3FuM0hjTyUyQmNJNGUwT3klMkZ0aVRRbkU5ZnYNCj4geUdnZ0djVml5UHclM0QmcmVzZXJ2
ZWQ9MDxNZXNzYWdlIElEPiBpcyBzaG9ydGVzdC4NCj4gZS5nLg0KPg0KPiBodHRwczovL2xvcmUu
a2Vybi8NCj4gZWwub3JnJTJGciUyRjIwMjUwNTE2MDIyNS5Dc3I1VVNmcS1sa3AlNDBpbnRlbC5j
b20mZGF0YT0wNSU3QzAyJTdDaA0KPiBhaWJvLmNoZW4lNDBueHAuY29tJTdDZDdkZGJhYjY5ZGRj
NDdmYTEwMTUwOGRkOTQ0YjlkZWElN0M2ODZlYTFkDQo+IDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2
MzUlN0MwJTdDMCU3QzYzODgyOTc3NDc2NTI0OTUyOSU3Q1Vua25vdw0KPiBuJTdDVFdGcGJHWnNi
M2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpTw0KPiBp
SlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZz
ZGF0YT1IOGsNCj4gbUE1WDJhaUFhdUdIdlhnQlJFZUZtcnlwWHVCTnV1UWcweCUyQlIlMkJDY2cl
M0QmcmVzZXJ2ZWQ9MA0KDQpUaGFua3MhDQoNCldpbGwgY2hhbmdlIGluIFYyDQoNClJlZ2FyZHMN
CkhhaWJvIENoZW4NCj4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVu
QG54cC5jb20+DQo+DQo+IE90aGVyd2lzZToNCj4NCj4gQWNrZWQtYnk6IEFkcmlhbiBIdW50ZXIg
PGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9o
b3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgOCArKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gPiBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktZXNkaGMtaW14LmMNCj4gPiBpbmRleCBjMDE2MGM2OWEwMjcuLjc0MWRiMTY5ZjQ0ZCAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4g
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiA+IEBAIC0xMjE2LDgg
KzEyMTYsOCBAQCBzdGF0aWMgaW50IGVzZGhjX2V4ZWN1dGluZ190dW5pbmcoc3RydWN0IHNkaGNp
X2hvc3QNCj4gKmhvc3QsIHUzMiBvcGNvZGUpDQo+ID4gICAgIGludCB3aW5fbGVuZ3RoLCB0YXJn
ZXRfbWluLCB0YXJnZXRfbWF4LCB0YXJnZXRfd2luX2xlbmd0aDsNCj4gPiAgICAgdTMyIGNsa190
dW5lX2N0cmxfc3RhdHVzLCB0ZW1wOw0KPiA+DQo+ID4gLSAgIG1pbiA9IEVTREhDX1RVTkVfQ1RS
TF9NSU47DQo+ID4gLSAgIG1heCA9IEVTREhDX1RVTkVfQ1RSTF9NSU47DQo+ID4gKyAgIG1pbiA9
IHRhcmdldF9taW4gPSBFU0RIQ19UVU5FX0NUUkxfTUlOOw0KPiA+ICsgICBtYXggPSB0YXJnZXRf
bWF4ID0gRVNESENfVFVORV9DVFJMX01JTjsNCj4gPiAgICAgdGFyZ2V0X3dpbl9sZW5ndGggPSAw
Ow0KPiA+ICAgICB3aGlsZSAobWF4IDwgRVNESENfVFVORV9DVFJMX01BWCkgew0KPiA+ICAgICAg
ICAgICAgIC8qIGZpbmQgdGhlIG1pbmludW0gZGVsYXkgZmlyc3Qgd2hpY2ggY2FuIHBhc3MgdHVu
aW5nICovIEBAIC0xNTkxLDgNCj4gPiArMTU5MSw4IEBAIHN0YXRpYyB2b2lkIHNkaGNpX2VzZGhj
X2lteF9od2luaXQoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgKiB3aWRlciwgZ2l2ZSBhdXRvIHR1bmluZyBlbm91Z2ggc3BhY2UgdG8gaGFuZGxlIHRo
ZSBzYW1wbGUNCj4gPiAgICAgICAgICAgICAgICAgICAgICAqIHBvaW50IHNoaWZ0IGNhdXNlIGJ5
IHRlbXBlcmF0dXJlIGNoYW5nZS4NCj4gPiAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgIHRtcCAmPSB+RVNESENfVFVOSU5HX1dJTkRPV19NQVNLOw0KPiA+
IC0gICAgICAgICAgICAgICAgICAgIHRtcCB8PSBGSUVMRF9QUkVQKEVTREhDX1RVTklOR19XSU5E
T1dfTUFTSywNCj4gRVNESENfQVVUT19UVU5JTkdfV0lORE9XKTsNCj4gPiArICAgICAgICAgICAg
ICAgICAgIHRtcCAmPSB+RVNESENfVFVOSU5HX1dJTkRPV19NQVNLOw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgdG1wIHw9IEZJRUxEX1BSRVAoRVNESENfVFVOSU5HX1dJTkRPV19NQVNLLA0KPiA+
ICtFU0RIQ19BVVRPX1RVTklOR19XSU5ET1cpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAg
ICAvKiBEaXNhYmxlIHRoZSBDTUQgQ1JDIGNoZWNrIGZvciB0dW5pbmcsIGlmIG5vdCwgbmVlZCB0
bw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICogYWRkIHNvbWUgZGVsYXkgYWZ0ZXIgZXZlcnkg
dHVuaW5nIGNvbW1hbmQsIGJlY2F1c2UNCg0K
