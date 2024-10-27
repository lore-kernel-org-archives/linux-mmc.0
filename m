Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2099.outbound.protection.outlook.com [40.107.249.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12113BADF;
	Sun, 27 Oct 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730040082; cv=fail; b=TD2VgmQjiRA+aHjjl7du83Ymr1WwTTh5VfaM9YTEnib5kegwbfYitPf6Ljo8Bw6sZSKxTrl/udeubZFUmoQb+BbIUgTjNrKL8VKIpXHm+JvaCC8Q4WXSmfJyLfFv976UnGaEdvhUTj4q7U4B0krcoeQN6NTMwBLZJqFUAeY41HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730040082; c=relaxed/simple;
	bh=M5Uuow6FS21HCYbB7Yl2VeSRzs3nfkY7zhGpdfFqc50=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=Y8dN9Od3Ef4XHDpltuw1GCE7NPKUyYdpUJOsb/lwZBue0yLwwdufeGC2/QLmB7uwJDUixZA2AhEDNbL5iaQqu7+blV/VbpbQM0aIK/Ut25inYhjTQg/BpaGKoRnVyPZ/OD60pD4epXd7/untqCQz3OFcjO2FnIlR5tJeB4kXHVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=XGNLriCY; arc=fail smtp.client-ip=40.107.249.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XGNLriCY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q2NHdCZy8uTD35kK8TmufmfDWzHt8JGNfwPin2cvQq2XPO88gbPaEW34/REXFDW46lzqBbpTZ4Lm3RKiMldmr7MBsjyNKIO6at6Ny+zulZfIp5pUvt5WYs9FMu0eAdxmoHM3E71QaP2pSwpwZikvCTafYw1zqPcA+UlJWlBBso+vVgfBr4f/4zZOw7J0Hy95hi4tFb9jgY26ujPAQoN0wv/aMhlfMyn9Hhx3v4OEi22QHL/hHQguaZzHYaO+nB5+DIlY8p9hMICMu2ShTIzs+wJk9lX3/jjjvQe1Iz1M9gUGzRZ5CTwFZoDoAcQ7BoofP7+g69ZGtQRJ+Yj0sMQtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJvzBad7BdbiPp+Q5rmwluJa3grMemuK7fh1H4tocws=;
 b=ojs5wEJk8RnghP0s+jDTDZ65EwOpAKC4qXTrUW+a9sYux01O7wxXaDlT3OvRf0qb+6jz0DMxfUYHiwMuafyxGju0lK4AxrzbRgsS3hIG6ACfa0woYDE/iG//+bv6LCeiNaPz8275G75SORhsB/UJ4K91lCe0lIk7Pr1bk5/E8gYjatoea3NM0E4InFYHBzkbTzHh7UGtd5Q5jCUlwmas0WH/7bpgARNZgyQRFu9fzp+1qTelpH3KVGdxP6VPyA07EuJJuFe76JGKwU4s8CZSdwfwMLlhOaRZDEqMUHwe1KarijtKIuOaniQXf5hq16C+V4pZOBtYA0F7Io/uCxjR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJvzBad7BdbiPp+Q5rmwluJa3grMemuK7fh1H4tocws=;
 b=XGNLriCYupaD11OdiNFvVwHkjCB9wmF9vB0Y/zDjNcCAyZLJrL7MMkYlI/z6Esgh/lxvXesfDuSixpaLs1xH6p0wUPNir2ckHccMwQvp4nYAveLcupdcuOoKvm1m/XVgvqz5FPEGW8uhHa5n5sFsPLCXi6BbkQZZIR8ZD2Zk8Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB8385.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Sun, 27 Oct
 2024 14:41:16 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8093.024; Sun, 27 Oct 2024
 14:41:16 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 27 Oct 2024 15:41:02 +0100
Subject: [PATCH] mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAP1QHmcC/x3MQQqAIBBA0avIrBtwTBC6SrQInWoWWmiEIN09a
 fkW/zconIULTKpB5keKnKmDBgX+WNPOKKEbjDaWtHEosSLH6DFz4RsdGRdGInLWQ4+uzJvUfzg
 v7/sBVNauuGAAAAA=
X-Change-ID: 20241027-imx-emmc-reset-7127d311174c
To: Adrian Hunter <adrian.hunter@intel.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, imx@lists.linux.dev, 
 linux-mmc@vger.kernel.org, s32@nxp.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AS8PR04MB8385:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a991ab4-c15d-4ec3-9005-08dcf695696f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmlGYS9XSGE0UktKc0JPL0ZVZzV2WVRSNkoxZUFTajdRUDVaTWVrb3liL3Jt?=
 =?utf-8?B?aHhSUFZSVm9yNlVkeDUxTDVqOUlrNTNOQWYzdFNwdDBlVERzQjdCNC9BNEho?=
 =?utf-8?B?RGFDWFRMV0JaZmFWbGZ1Y0lRM1hzRk1STnZMTjJOd1JkelIvSW9mQlBtSWpx?=
 =?utf-8?B?MWxsUVp1ZUowK1FoVmNBS3pZQ0o1ZTF2bDI2dlFJWnJLWWt2c2F2TDZ5M0FG?=
 =?utf-8?B?Yy9DVzhDcnJRaHhIOUZFTWJ3RnIwQUlVRmNES3BBZ2x4TytDd2lwaUd5VG5v?=
 =?utf-8?B?M1RTemVmOGQ4Q2xWa0hGbnZlVmhGY2xUYmlORFNxWFNCS1VESGQ5bUgxZW5y?=
 =?utf-8?B?d0tybzNjaDV1a01OUytVYUJGU0F0NytQVVdhREVpbkxZYndFQjhIY3hPSHBu?=
 =?utf-8?B?bWdHN21jc0M5Z3F3SVAyWTFRQndBVEx5WGRmSWpCd0ZxS1drTks3Z3hybjcw?=
 =?utf-8?B?MDhSYUNlMW9Xc3ZScTJJbDB4blhqcUw2SnBNZ0VBL240TW5keS96UWNqZVpO?=
 =?utf-8?B?Z2tUMmhNdjVUU3dwQWhtMmdUV20wZ0h4VW5oTklZWjFPNXlFbDZNZUEwUEJ4?=
 =?utf-8?B?VGZQVEFsdkZhNXNJMTl1N2hIcDNrdlh3QXNEUzZyUHRQcXpVOFoyQWtac0w3?=
 =?utf-8?B?UnVuOUNCKzBGNldDRER1b0NwamZvc3Q3OS9uZHdDcC83YjkrVGtwa0RzdThO?=
 =?utf-8?B?N3F3cDVhT0RyNDM0RFgvSWF1WFNyeFZlTktxU1dmYnQzWUNENWt6V01CVG9F?=
 =?utf-8?B?LzVXdnlxd1JpWTgyTnZ1S0NHUzBINEl2elc3ZjR1ZmVUcDlXcUVkQzBDTGJT?=
 =?utf-8?B?Wk56OTRKZmFIMDIzbmt4WnJXRndZQjNUazBhTURGRGZGVmxtZVZISlBoUUp0?=
 =?utf-8?B?WmNTTEhiaTdTd3pnSHZIaVhhbUpiRkRjV3Z0VTRsMHp5cGpuSzJKd3ZaU0ow?=
 =?utf-8?B?REhNRHc1bHJkQnd2blA3b29nYTF3OGVDbHRnUEVLeTJDTXpkUHNKRnlzd0Vz?=
 =?utf-8?B?YSt0NVdLUGp5S1J1TkpYaHhtWElhT2IzTUlVVmp3eUJ1cEhzelZoZFNHRjRE?=
 =?utf-8?B?U21pN25sUHhIQXFocHQ2U29WVWJpQXIwcjJYMFJqSmdJU0k3d0hQejFmWWxR?=
 =?utf-8?B?cnRoNzJHcWRMRmFLSHJKRWNoOVdRMGhnSUQwUXAvVW1udHFKK2Uyc0dIVnVW?=
 =?utf-8?B?UEFLdVdHMXNHdTg2UkNZNUVCaks1Rm9YZmY2RzR4L1FpQlk3WGRQT251TWRE?=
 =?utf-8?B?ZFhSa1EyYmtIdlQ2Wms1MzRGRXhldmFiR1UxTWJSS09Rb0czWUYwTjhkZ1Q5?=
 =?utf-8?B?MUxlc3lzbW4wcXQ4ekNxNGJqdTdrV2IzNE1EWE5zYzJ0aHZCNCtKYVdySmZK?=
 =?utf-8?B?T3F5YVhQMTYvV1pvU2ROeXJXMnZ1VGd5MDRTY2F3dGFabzBHZkVaUGt5ZWpJ?=
 =?utf-8?B?TVFRcnFQQ05JUHNDQlB3V1hEREd1a2J1TnlISXNodkhHQW9BaHF5b3RSM3dC?=
 =?utf-8?B?QkZUeDhieHUyZzloSFZLRXNxcUlnWHpzY0tFOHorSkJQOFIrRit5NHp1N3dM?=
 =?utf-8?B?Z1ZIQ3lYVUw0UVYxUUNRZDdwcjZHaXNSeEEvK1B4Z0RHUTVESkNXYlFhTVFC?=
 =?utf-8?B?OTkzeFJzKy9KQ0V0RGxOejkvUEQ4Y0RSY2JoL3lwWXhTL21Db3dYRHVENzNX?=
 =?utf-8?B?c0x6YXVFWmY3bno5cm9OV3crUkRPemFaSm1YTEttemQwN21qazZhS3lvS1ZV?=
 =?utf-8?B?UWNFVGZxNEF5Yzl5SkpPMmxkdC9vTDFNeXVMaEdGeFlyYll5MDFzSzcyT3pt?=
 =?utf-8?Q?WWrzw9Ox5rNSulSi5r0MNa2yg3SCzMTDCmkhc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUVNVThKYTArWGhLN0FubDU2bEg1MVJZOU9VblhTamw4UTRkNGlPQTh0UGxG?=
 =?utf-8?B?Vkl3UytMYWV4cU5XaDcrajZNd1RxNlRaV1RzN2pvZHRFZ2xSeXFTZUlRNzdJ?=
 =?utf-8?B?WWx1dG1ZdVFvYmo2cmNvK1JlMnc0S3p0bU94YzFKYzhzaEZiYjk5K0dGOG5o?=
 =?utf-8?B?dHFEL3U3SzN6LzdZRy8rU0poZjY1SmpqdDRHV3ViSTNLL2Y0enRWMmg2alAx?=
 =?utf-8?B?M0c2Vmdycmg1dkF2Snh3MEppVkFCM3V2SHFJYkJEVm1WSWw1MkJwZm9YWXJ2?=
 =?utf-8?B?Z1ZqV1ZYODNkRmdybkRxV1RleG1Ic3NrZlBGOTJUM1RCeUhEYTQrQlVGM3A3?=
 =?utf-8?B?VUIxWHdVb3dETzNMdWtqMDJINFhrc1dtWjdTVnBLYjN6ZW5IaENMWWd5RVFX?=
 =?utf-8?B?aGtpcmVDemRBcHVveU5tTUUya0hOWk42THY0WDI1Qy9iMDd3L2s3dGppQkJy?=
 =?utf-8?B?VVpWYWd1R3k1MWl2OW9QZEpwWjNicnN5QkhTY2RCTzNENW8xeGR6NkowYWlp?=
 =?utf-8?B?ZGFBdnphNVFiMUlzU0RaUFZWMnduWmJzV2VHQUhCU010Z0FkMnhtUWlLQllk?=
 =?utf-8?B?aHNKb0dhUHlXQ2toS3pLL21CeFBEcUZjdzZSTXZGUlpKWjRwV2xxUnUyUTYv?=
 =?utf-8?B?cHNQL2hKUTZtTUpYR21va3BITGVqaTNXbkJzNk4zYTNyV3M4U0tQeTRkQmVz?=
 =?utf-8?B?dDE4QzV1WFhQc2p2WHlSaTlmS09xNHI1dSsxZ3RiKzBRNmhaT29TZk9iMWVp?=
 =?utf-8?B?c3BiMXYyRHcvVUVDanF6L2lVeVRnWlpqWHQxd1JYY1RXSHNGTSs2WGI3ZkJR?=
 =?utf-8?B?SVRQUWxiUGIrWmxBVEwyRDRLYkdYdjQ1NlhwNGY0cUNtcGlUa3VkanBGcHdG?=
 =?utf-8?B?bDc0ckZEUVI0SGsrN0xLWHBUQTBuM0V5ZW5SSitjVXBRL0pyaEN5Y1dMU2Fy?=
 =?utf-8?B?eEN6RmJSRE1MYlZNcTg5TGc3bXpiUFVqdVNQbUx0bmV0OUtOMW5zS1p6WUlO?=
 =?utf-8?B?ZXVLQTRzc2tkVWVJdENPcTh0ZktMeFNSSkhTM0NhQjV4TXRpL1BWTXVocHkz?=
 =?utf-8?B?MEt2bTJHOGpWQ3QrYjU2SzcyKzE1YjdudFBNWWtZOHNiQjVxZVM1RUlTVXRp?=
 =?utf-8?B?Q25UbEtGK0VaYXpjTTlKS2dRblRUemhncE5ldVVuTUUxMEF3SzFPUFVSVCt4?=
 =?utf-8?B?U0VjN2FHdkVGcHFWcWtLOG5ObzhxL0l0YmVMMFlmeU9KbWxWT3UrNnZEaTU4?=
 =?utf-8?B?MXdlVW1XSis1Y0Y4bnZUR042MUJVd2ZaQUpBY3lVNTlITURTeWhmdkszcEpQ?=
 =?utf-8?B?MmdNc0lkcElWbyt0WWpGc1Z4QzdxZ2FJZ3RSN1c0N0dHUzZsM0w5MTFJR2ll?=
 =?utf-8?B?VS9Ta1VOS1pjK2VlUFcydnlBcTlRaDdaZnJreE1UUFQrMjVZOEc3ZzRMNFVa?=
 =?utf-8?B?eUZYVFZlSVcyQzdoQVMvNjJvM0ZFNWswVlh5QnZhYjVFZllpb1FSSkw5S2lM?=
 =?utf-8?B?cDN2OUQxTlVyL2xCVmNVWUZwM2ZxSFNPZjdQakVBejNLK0U0bTJOeGRlT082?=
 =?utf-8?B?em8wNUNtR1ZYcDJvYm90dlg0d3FHUVltdDlnRjUyd2hmK3Bnd3VyWkZ6YXY5?=
 =?utf-8?B?a1pnbUFqQ1ltNUl6ZG01VlRZSE85Uks4TzVwemw3WHdiaEhuaEp4NDBXSVNp?=
 =?utf-8?B?M3p2T2dsbjREK1F2aHBab3dydlRXU2o4cS90VTZoU3N0Z3gwZW0zRlAzMXJp?=
 =?utf-8?B?cUhGdlJUZjl4eE5ibHV6S3NIaUFwQzFZdXgycHowKzJSemhjMEMrcjB4d3Zj?=
 =?utf-8?B?UGlodlNUb2JLM00wNjk4SzMyWEt2SWZKMG1SaFoxUGZ3VGxiK2hGaEN6L3Uy?=
 =?utf-8?B?eHJPT1JnUEZtYXZoaWhUeHlwbTFFdG5vMW1ta3d1OEtVODJYbUxBeW9OQWxB?=
 =?utf-8?B?dCtTMFp4bmNnbXp6YUtkZVRrZGprKzl0MC9WdXp2UkErb3JDTUpVc3NZUzVN?=
 =?utf-8?B?bG9QRXJGMlVTUmhSeStTa2VYS0NIZ0R4aXVob05PZW05N3pzSEFpNHh6QW9D?=
 =?utf-8?B?RS8yMnV5VURqZ0VWRGhQM0Q4OWlQYXUwck5MWWZZWGY5ckZGTUFYVEdQYjZF?=
 =?utf-8?Q?A0JbPLKA14xovEMdhL8gA1aqd?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a991ab4-c15d-4ec3-9005-08dcf695696f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 14:41:16.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+PowfP02mi1rqObxzkV3zcUp/Zxq+OoJzb8IbFUqdQE+sj070RmvFifEFYY6UkzyObegrXijBdCvsrdUX+hxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8385

NXP ESDHC supports control of native emmc reset signal when pinmux is
set accordingly, using uSDHCx_SYS_CTRL register IPP_RST_N bit.
Documentation is available in NXP i.MX6Q Reference Manual.

Implement the hw_reset function in sdhci_ops asserting reset for at
least 10us and waiting an extra 300us after deassertion.
These particular delays were inspired by sunxi-mmc hw_reset function.

Tested on SolidRun i.MX8DXL SoM with a scope, and confirmed that eMMC is
still accessible after boot. eMMC extcsd has RST_N_FUNCTION=0x01, i.e.
reset input enabled, Linux v5.15.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 8f0bc6dca2b0402fd2a0695903cf261a5b4e19dc..ebcfa427cca6cc2791a1701a3515ef6515779aa4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -33,6 +33,8 @@
 #define ESDHC_SYS_CTRL_DTOCV_MASK	0x0f
 #define	ESDHC_CTRL_D3CD			0x08
 #define ESDHC_BURST_LEN_EN_INCR		(1 << 27)
+#define ESDHC_SYS_CTRL			0x2c
+#define ESDHC_SYS_CTRL_IPP_RST_N	BIT(23)
 /* VENDOR SPEC register */
 #define ESDHC_VENDOR_SPEC		0xc0
 #define  ESDHC_VENDOR_SPEC_SDIO_QUIRK	(1 << 1)
@@ -1402,6 +1404,15 @@ static u32 esdhc_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
+static void esdhc_hw_reset(struct sdhci_host *host)
+{
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N, 0, ESDHC_SYS_CTRL);
+	udelay(10);
+	esdhc_clrset_le(host, ESDHC_SYS_CTRL_IPP_RST_N,
+			ESDHC_SYS_CTRL_IPP_RST_N, ESDHC_SYS_CTRL);
+	udelay(300);
+}
+
 static struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl_le,
 	.read_w = esdhc_readw_le,
@@ -1420,6 +1431,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.reset = esdhc_reset,
 	.irq = esdhc_cqhci_irq,
 	.dump_vendor_regs = esdhc_dump_debug_regs,
+	.hw_reset = esdhc_hw_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {

---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20241027-imx-emmc-reset-7127d311174c

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

