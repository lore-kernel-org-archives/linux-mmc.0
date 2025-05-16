Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98019CC3D;
	Fri, 16 May 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381494; cv=fail; b=mlo55h4J832fVcXIP1XmLGgKKAkp7Rr86GYtMTT3pnqj12iwCv3MeEHUgmjuDFdTwBKL2+ZZd0d+KPwWgTadMXLrB0jh5MTsF7W/Rr/e0fEtrs2/p1XPp0PS1RlHGdrACmFZXlqkS7io8ggdtRSg5N3Vh82Qo3Bow+MVIOj8rKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381494; c=relaxed/simple;
	bh=v27mu0U1KAtRdeAvDpk19coqbixHNPe4PnwdHmBV4OA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=n+a1MWmpkmGsF8tmFR74Nl8/FAPdt+M2d7uGnAcx9hItdruxajhCpyvl+fhlWJiEAn65udaxCSJyC47UkIZcr8XeVNvkcc1WtcBK2SpXqVyz0YWS034hiybs45FgTcUME9MF1iPA3qjf3+jWc6xXAbPFoeHL6CYzt8mNvt84dO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eHtLhpK6; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eHtLhpK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGNguVgNJhTgTHT64H6UwZlcjcgnEWAyT3BJnXTm6omdY9vfLahd8G9WDmSwxxqQMYA3daINN8A0oMzXzj0W+nMSB9i9Ml5XOpSnYAj8QJirDH3wMCIkaYcrPv6cvs37TATNOfbXyKrzHDFTjx80bXdLhPBL6IeRmf5L9eNeyYaLzrXnDrF+mC8c2BOJ6SJECnKviOIEWusEgw50A6yM/b+imdr16kSAriCYBbtUnk0G3eQfEV+Gjfm0HFf/0zzX4acnhF33CF5TZhgTHODGNO0umF0tFsB7EcqAmIxf6bBv3WbHvfSHa0gzpmw7r8qBfUGZeIVyFA25x8lu/GHOvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EaNJWrw3YGrDjds+qg2Zx7IO8Mj3V66Yzc6hRnUgDM=;
 b=cUqfhsA9879S4YuCyyA3I7ChezBNmVnf5q81cTHhmCQCqTRYwZx3x2t/bEbwk6brE21bNGelNpMQGVvCty/KRxDIXd2ZafoJ6MosoBW0X28vg2/vNBD3rISUOK/9Ufv0tBePW81SvlD1sLugU2ne0v9nNCsC63R/B+rbCYGDQnUv/IZfcalz8obNovse6GJWLNLfeK0QpiM0Msz56/RdbEZpxLWxwg/xEKj8VePpQSalPnYjliTs2ca6XARXG+xtQz5yhd11gN29WblAl90AbVTILTFTbew4X/2GUhFWCS2JpYIXdzdC/i1im6EFjczirz9goLnM+CdecpLV/76s/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EaNJWrw3YGrDjds+qg2Zx7IO8Mj3V66Yzc6hRnUgDM=;
 b=eHtLhpK6Bk2eDYDO1PR/8Lmcq5PgCi7ivLVVfORJWJcvCmJb2yyqdFflEXQDJezNuQ/PS7DNceW7aaPPFCAZkYnwl2QwobRgzRGBnj+yh6KWw/+qwglqemoi7mVRv6eZqM3OxD/ni+EKaUMm40e4WnD5VHMJkLWKRCGGJ3HJkCYX/YkuKhqlOYrffgFoIa4hyW/VCaS6FOaAwKJXRRj72lhW4yf2uHOAFpwRzGCoCYUiiXKiwkeIIfaB2S3HdCkU8qGU9jX5aawBn2KToSO3ZDiPJ9+aI0B/TWsjbxhAcDoueqecjNpl3eRD7GVnB818YhU3srUEgQED3YL1Fv9YFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PR3PR04MB7401.eurprd04.prod.outlook.com (2603:10a6:102:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 07:44:49 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 07:44:49 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Fri, 16 May 2025 15:46:23 +0800
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: fix few build warnings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-b4-usdhc-v2-1-3fccd02f5602@nxp.com>
X-B4-Tracking: v=1; b=H4sIAE7tJmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDU0Mz3SQT3dLilIxk3aTkFIvk1EQDi9QUMyWg8oKi1LTMCrBR0bG1tQD
 0fbqTWgAAAA==
X-Change-ID: 20250516-b4-usdhc-bcd8cea08ed6
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Luke Wang <ziniu.wang_1@nxp.com>
Cc: imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747381625; l=2291;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=v27mu0U1KAtRdeAvDpk19coqbixHNPe4PnwdHmBV4OA=;
 b=k/14jaSRFOGA+TSAY9ynl+acSFTkJeXCliQidM9mCR0D9COqMfFzCb5wtaHE9kiB1jj3nyRe5
 CF90YI6p35pClJsPavv0+ziIU+oXwZBf5UAU3TdDa6596Vu/6ftylX5
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PR3PR04MB7401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4631c8a8-3fca-4788-4472-08dd944d8900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlMvWEt3Tk1YK2hYNzVrNHJRQ0czZkphRHA5Q01aQ1ZIVElIMEhFUm5SUG10?=
 =?utf-8?B?eWR4a2puUURqS01WOVdiOFV2R0JCbUFvQjVYeXJRVkZNUS9mb2dRSmJlNnFH?=
 =?utf-8?B?NGpQRUFHREo2cnYvbHBGUWdiWVVvU21DWkhuTVRkT05yRU03amJuVWZhSUVX?=
 =?utf-8?B?cmcrOU0wTUNTdG9OZnZ4Nnl0VndBWHUxbVhyTGNTem1lNzhJM3NSSE42TTVj?=
 =?utf-8?B?MWJka1VraFRYYzZ6SmFHNVcwM1dqMUNxUjRWYXhWMlRFMEZFMTd6bmNvZnUv?=
 =?utf-8?B?d3JWRG9JRERQTFEzQU5CZVlhaXMyUWRGcHZLdWx4eldmcER6bHV3SzBJekdR?=
 =?utf-8?B?RHhsYWFhbHd2UzRJMlZ1WW5hTHNpWTZBT2xJOFM0VE9ZVHZuSll5YjFWbGxl?=
 =?utf-8?B?TEdkdVlSNTI1Q21QcWI1WFZ0RThETW1GcUZ5RlpMdFpKMFdaRUpLTFcyU0hk?=
 =?utf-8?B?MDl0UEpvYVRUTi9zSk1DWExoWnJ6N1gwV3dFbE9oWVk3YURpY0ZHeUIrZks1?=
 =?utf-8?B?MjM2eXFkOFBwRWM3N2s5NDdkR09TK1ZZTmhBNVlkVEdGN0dZMTd5QTk4R3Bq?=
 =?utf-8?B?K3djNWZDWWI1MjlycDhQVXphMHc5S2k2TEc1clJkMkt4OGQzS01kbkczRThF?=
 =?utf-8?B?UGJtOWlQN0crUy9iOXJTV0lkdW1zTmNVUzQvem03TDdJdXMwVEdrbEJER1h6?=
 =?utf-8?B?Sm1aZUIrQkQvWHFwL2JZZTJNTXZ5V2hVY0VYNDdOaUhvUEtRZFNZTzllU1F0?=
 =?utf-8?B?WVB3NG1YVjBMSVpxbXJqWTk0SkY1MmJ3SXYvTGpaWjBLTlVKZXdiSEFLWDhR?=
 =?utf-8?B?b29tN1ZNaEVreWhROWxHR3FvNllCUmk2VXVOVVRHeGJSMFcvUUpqb3oxMHhM?=
 =?utf-8?B?Nkl5b2ZGaXdwS1BwTmJPb2JPQjN5eXgwYytwTjM0ZEk3Zm5xV0cwNjBLd2tF?=
 =?utf-8?B?UnY5STRIbjFyMGxzV3FjSWVEMWV4NkI4aW1CZVIyNkpxSUNjTjhlR0l1WlVN?=
 =?utf-8?B?UENyTHBVK2c4V09Vd1RTZFpDUU9sQnEreEt6K2NVcVVnenM3SHcxWjJmclF1?=
 =?utf-8?B?MXR6MDJZU2lPSUlFMHl4akxpaXBwMS9NUUR2NUpyQUlzZXJ0NzNwbmloRHRY?=
 =?utf-8?B?eGVOTHljUGhQeGFSQ1lKM3cvU3hNRmU3Y0w4NTM4NzRtMDNyekxwRm53cEs1?=
 =?utf-8?B?ZXBsTXlTTXBMbGx1dWhOM0R1TlZRdlBZci9BZ3ZkZDNIekd4eDc4TTFWZmQz?=
 =?utf-8?B?RFlpVzBmbXQzZ2JxeUdRTlAzVTVvbHVjVHNWU0NoS1Fla3p4RHRuM3RKQlhs?=
 =?utf-8?B?SzlLQnQ4Tkd3aDJYL1VJVzhnRmdmc0Y1anlUOUlZV0xmbHJsOFZWd0xhNUht?=
 =?utf-8?B?cUVzUGg3dWtDL3dYNHBjWkZ4NkZ5RDBRblV3WjI2dW51QTVod0xUQTMzRjN5?=
 =?utf-8?B?bGR5bjdZeHhXcVYyUTBrdHBmNzVaQmZSREhZZmlWckdXclYvUXdjU1d6ZW5N?=
 =?utf-8?B?VUZ6d1VEVTU2SDI0Zm1EVTBtaGV5OTBxaThya2xSdlc0UXZWdjlUeVNZa2Nv?=
 =?utf-8?B?cGJqNlNDaHBORXhlSWpXY3dlWFZiRTk4cjAwWGhTQjdnc3dCbXp3WnZNMDd1?=
 =?utf-8?B?SlZUODNjMXdncWdMYSt2T0VtUFRkT3A1Y2RTZ2VOdVZKMVcvT3UxblE1Vkoz?=
 =?utf-8?B?SC9uU0JHeE52Vkk1VTdyOXNLVjBWdDJwN3RubE84UGtveVRQQUpqTlpwYzIv?=
 =?utf-8?B?Z2NXazg3cnJTMWNxK0s4QkFOa1VaOFJ6MjlMZmZSV0tkSWVpZ2F6SmkyNW9a?=
 =?utf-8?B?RXd6elpkUEFuTk9HMlR2UGNlaHRtUG1TZ2duRjc1dWNreTl1V3ViV2p3VzNi?=
 =?utf-8?B?d1JtYXNha0grZXhDNUdMRks5SVVHM2o1dHBRb1ByUmJRbDZRRmcrVmVRcC92?=
 =?utf-8?B?WnE4Tm1HeDRpZXpvL2toZ2M1a2xGWS9ld0QveU1nMGU3aG8wZEYzNUs3Nncz?=
 =?utf-8?Q?KN2Du3iXNyDW2hKH4ufhfHyJsHQnBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akUrUHpzQVdVaE9MemRzZzN0bHk4QThObnFpcVVhcDRIQks4d2VGQ0VTNG5o?=
 =?utf-8?B?YlBkL1NxVDgwZDFDS3I5Ri9kMFVtNGthQkRINmpYZWV6MzZ2dm1KcHloSWsv?=
 =?utf-8?B?czNmZUtqdlJqaU94M29DNFpjMlBseHhxRmtob2ZUZ1hIWFpJa0k2M3VXQWlH?=
 =?utf-8?B?dnVIdHR0VnBoS0IxWEZSbWV3cEcxZzExT0o4aTFoWENRYUtJZlBST1NoNW0w?=
 =?utf-8?B?ZXNhamtBam9jbW1BRFFkSml0eEtXRzNkc2N5SGwyOWd1cGxFWldnKzBiZUM1?=
 =?utf-8?B?WGtDQmg3ZEZ0MnVialE0SkxNc3ZKN3o2S3N2T25acTl1aitCazBENDV0TnZG?=
 =?utf-8?B?d1FaS2t1eUEzZEd5MkI1YVJHdmZYQ2xUd0ZxOVNMbXE3WmFkdER5Y3IwcGI1?=
 =?utf-8?B?RXZORHhzT3p5YlhPSTRxT0RseXFud0FYYW93bTRVKzU2QVJzL3B2S3U2U3dw?=
 =?utf-8?B?c2ZxbzNXSnJZTG5QZHpxdHRaWFNTdTZPbHJUUzZpcThOUDJmSjJlWFZGQmtt?=
 =?utf-8?B?NXZsU1owNDErZ3cwcU9oT2VvZE1vZUpPMnVYNU9DanNoTzh2YkROakVXMW5L?=
 =?utf-8?B?Zm5hU25vZ3lFeGFMRnd5dngwWlI5SU9GTmdlRE9lWDFxTi9pNXBVN2ZEa0Qx?=
 =?utf-8?B?RE9ld3JXcWVDMHFPOU8wWk4wbDBuYzh2MmFHWnZpYkRoTVY5M3BLNGhsaGp4?=
 =?utf-8?B?bEQ4cjZETVFER3Bpem90RHNteVp2R3Vkcit3aGU4OWd1RXpUVHpiNjVVNUtu?=
 =?utf-8?B?OVI1enBUblZpMkdWcjg3enBRWUxtQ1daektpaXc2K2p3S2xJSEVMRStGVWdT?=
 =?utf-8?B?dHZUWnF5aXI2Z0RUajg5TkRlMHFIVi9xcWpyb2dDaStTeWN2dEFadFVhamNF?=
 =?utf-8?B?dzVLUW9BOUEvVWNsQ3U3QjloTGIwV0diTE80dHBQcnBkUmpMNlRsdHdwNjlW?=
 =?utf-8?B?WTJLUVNtbFZIODZuNWhEb1RoMkpQcUxjRlZIL2hZK1ZWaHNodG1jeFQ5eFJx?=
 =?utf-8?B?NWhlTGZpZGxmV3lKU1NDUWw0VHVWN0lZTDloV29uTnZDTTczUEtBY2Exa1FE?=
 =?utf-8?B?SHVubHF0VDBoTTJ6YStFUisybmtZQ1VWcjBZaUN1ZXRtbDl4QkxMeTZKTnk0?=
 =?utf-8?B?c1dMZnJ2bGlsV3RJRkFaZ2NNbE1HeGR0VURYQTk5SVdrL1EwRzNRTFIyaEU3?=
 =?utf-8?B?VW54cDBLU0szNHBLbkhYeFVuZm5PMGF5NlJ0M1NVaWxCMUpRMWhNU0hsaVRO?=
 =?utf-8?B?dUQrY3NPUHI4di9veml6ZzlzcEpMQkdTOXAwSnFoeUdRMGlsNGcrUW41TWhM?=
 =?utf-8?B?WnhhNXZOSGlYc1UvakhqanlYdUxtWitWR2d0VEYxL1NsTDNYNTFlYVlWMzdK?=
 =?utf-8?B?b295eUJPRUlaL0RGdTNYWURYYkUvM3EyUHN1NklDVHl0RitYQ0lmNlRkTUV2?=
 =?utf-8?B?TGNXYUxRRjRBdjlNb25laXpzdzQvVlNzdFVrb1o0blVuMHFKbFRoSnhtR1VV?=
 =?utf-8?B?V1RWczZ2Sk1GUWd1bmJ2ZngzblNPOFFuNVhDSmtBR0gxRjUyd0ZiSEhCdm5s?=
 =?utf-8?B?UnhrWGhteUg0R2xjTDY5T2htRmZHVU0yeWxrcjNPdGtWSDFNRGNKYldTOXVZ?=
 =?utf-8?B?ZFBscVVGMmFUbGtnbldyU3R3NmNmdjdrYkxEQTVzenc3aExIZXdEbEswUXB4?=
 =?utf-8?B?YzJ4ZDQ1Wk90d0VTV1Ntd1UwNkp6aHZvNnl4Uk5YUy9DSHZWeXNNOHdjcVB4?=
 =?utf-8?B?eFB6eDB5WmVCSEdiWnEwM1lQUC9MdUdRRHhrS2g3Z2ZxYWU3OXdtUGdWWGdN?=
 =?utf-8?B?dmlTS0d4OGEzYUlSTzRyRWVYYWZWMW1hK1RjWG03cTZUbGFDem5MS1ljRjIw?=
 =?utf-8?B?VGplclhocUUrWHhIeCtlRWdzSGJBNmFDMVdLK1hlMjNEK0lCYTNFZHVZZ05H?=
 =?utf-8?B?UmlQZVhrbjZIc0U0eXc0dllFa1dKSzZKSGdKbVFhbVA0SHArMnlPYURqcUts?=
 =?utf-8?B?a0Y2M0dPa1JRRjRkYzBQQldsemM1RDVVWG5Na2lrMW80SG0wUEVXYlI3V1BD?=
 =?utf-8?B?eHVDZUllYnc3SGxTZEdiNjY3aVFGa240MmdiWjJKbjZZYUNXbCt6aG95dmt5?=
 =?utf-8?Q?QZTaO71cxuIFL0+2hXUonRJ/t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4631c8a8-3fca-4788-4472-08dd944d8900
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 07:44:49.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DuE4+o7QDUG2COMjlcbPFlt+Z2iYIFULB6XxGL8JkOe7SC5JCzuQdQX5wrWFoZpLIlcvgX221PnWyHnUioQvxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7401

drivers/mmc/host/sdhci-esdhc-imx.c:1566 sdhci_esdhc_imx_hwinit() warn: inconsistent indenting
drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_min'.
drivers/mmc/host/sdhci-esdhc-imx.c:1251 esdhc_executing_tuning() error: uninitialized symbol 'target_max'.

Fixes: be953af79cc6 ("mmc: sdhci-esdhc-imx: widen auto-tuning window for standard tuning")
Fixes: 541a95e64d76 ("mmc: sdhci-esdhc-imx: optimize the manual tuing logic to get the best timing")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202505160225.Csr5USfq-lkp@intel.com/
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c0160c69a027826c4099c9bcf82cd4d83f1113fd..741db169f44d9c9c1e5e1dee591b72221fa1e2b9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1216,8 +1216,8 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 	int win_length, target_min, target_max, target_win_length;
 	u32 clk_tune_ctrl_status, temp;
 
-	min = ESDHC_TUNE_CTRL_MIN;
-	max = ESDHC_TUNE_CTRL_MIN;
+	min = target_min = ESDHC_TUNE_CTRL_MIN;
+	max = target_max = ESDHC_TUNE_CTRL_MIN;
 	target_win_length = 0;
 	while (max < ESDHC_TUNE_CTRL_MAX) {
 		/* find the mininum delay first which can pass tuning */
@@ -1591,8 +1591,8 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 			 * wider, give auto tuning enough space to handle the sample
 			 * point shift cause by temperature change.
 			 */
-			 tmp &= ~ESDHC_TUNING_WINDOW_MASK;
-			 tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
+			tmp &= ~ESDHC_TUNING_WINDOW_MASK;
+			tmp |= FIELD_PREP(ESDHC_TUNING_WINDOW_MASK, ESDHC_AUTO_TUNING_WINDOW);
 
 			/* Disable the CMD CRC check for tuning, if not, need to
 			 * add some delay after every tuning command, because

---
base-commit: 484803582c77061b470ac64a634f25f89715be3f
change-id: 20250516-b4-usdhc-bcd8cea08ed6

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>

