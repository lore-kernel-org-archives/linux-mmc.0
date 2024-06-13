Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75186142E9D;
	Thu, 13 Jun 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289151; cv=fail; b=Vo7ZHuDrcykA+0QzHQsuPlKa/fzhmWFSt1q2KK2a7YO7aLTAg3OJ+nIS0hZABVVuAq+TWCd+mWc7Pd6a8ubiFWCAJw7rl9GmGPJtSC2Z3RIUDqosH0xY5Mp1o1zcejYAmpJvYK4p/qOhdD4a08SwOsrUbcgAksjIBDdA8u/s0/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289151; c=relaxed/simple;
	bh=TnO3vc9cXocqVZQDqdWHx+IRnQqHEuE7FKWeiDPjO98=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=NODCdDw44eCpI0f/1YnvAjADlGqIYVirZ2KiOBzPA9obSCLvMZusOZgBbQvlSLqgc6PzJvK19LZfl24uNGV69W8vvt2gG+sOakktmf/9ahzdkmViEfmp0ojpN0L4TMbhYw2/Kt8MZIvvbVYUoWx6UAE3VxqOps7ogOh5rigIOEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bh91a7+b; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bh91a7+b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb8uANB7x4UBUOYtfJMBs+fE5i8rRe4/CdTE3mNeaGMOGyylo5TBeG77RgCw3TZCKZX14qrYcJD3IVNRlK1T+jrX/Uc4dUHBAzCew88rEBvMbRRhalfOu81rrx62r3ZzbQdzD1oSkkOHvGYFzqco5NK273ieEupPtUMO4+BtOBDK9Rb68KkOQUivAop0anf56PCAww8ft+g2ceSczJO8NugMkysurflUliTNtk0PY67aYnIy7tv7j6nyn0rQ7S6h0zLb5fm4ypWN9HjgKb/nQa1h7cQHzQ7XRvdBsQeQIxYdHkcC71Q/weC9mETjwyaTH3jhyedmUfdr3ORoNET2iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WLyt7fZpxOL4yPtZr+ZgI5gpGflLys/t8xH7k6tRfA=;
 b=JufLsmBALcQtIyV/yef+nPEcFaV4Fburi0xDdtQO6LAKr+RvZ8C5BNkVuHZXUfH/1x/AZyxJcanIS5EdyAUR7gsbqL3EArdir59iraW+ncunEp0+S2xW4OekCHNMOJAVL1NGqgi8hXTPMLTYtmODJY4s0ifo10PLvxgGHAxt/oiPYFR21PdR4SkMGJd4YDNFoTBW4dJMUGPOUrCz5GbdQoKvHt8mTSD6uVRL4zbZkucOTf2N4w3CVOqmr+0It8PtQaKko+aEAgXJ8ZuUvgEIq+yLN9e33P7Vnrwl8fnAX4VVHIcv3syTyV9pWo5NzVyXwTgaql10Tu2QA86m5hG9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WLyt7fZpxOL4yPtZr+ZgI5gpGflLys/t8xH7k6tRfA=;
 b=Bh91a7+bOPMwOCc7JZjxEixfn1TLaZVyasIfur9i8gsR/MUqw/YANNVkjp2mmsrALAJwkIapYphp9OpywoRdNZ/NEE7qZyRf4PGbZGslOcxq/w+SKs9oe69hMsFQtPsOQLAzO7RZ7zTFv2583hoROWDsAj6K/nosa3nUdcXj+4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 14:32:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 14:32:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 0/3] arm64: dts: convert fsl,esdhc.txt to yaml and fix
 layerscape dts warning
Date: Thu, 13 Jun 2024 10:32:04 -0400
Message-Id: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOQCa2YC/2WN0QrCIBhGX2X81xlu6mpd9R4xhlM3fygdGrYYv
 ns26KrLc+A73wbRBDQRLtUGwSSM6F0BcahAWelmQ1AXhoY2nLY1Jfc4vGRANw8maqtIx2rWSqH
 1qeNQVkswE6578dYXthifPrz3g8S/9teq/1qJE0o01WcpRjYxNV7duhyVf0Cfc/4ABST2DawAA
 AA=
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718289143; l=1878;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TnO3vc9cXocqVZQDqdWHx+IRnQqHEuE7FKWeiDPjO98=;
 b=Lka4fX4X9qIq1mDGePFzY/f0namMqckrc2amCnuXDzrTr+iHVO4aWqruGV/GcUGKaQObLPe9y
 /Mrg/vOZ8xkBVQpm0wjy0vps7ytkeHMfjOqtrOhc2dlZa0L9aQ17eKk
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: e30eb888-0b26-45e2-e128-08dc8bb5a584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEdwOEdtZGhmd2tJUjQvWG9VdEk0azh4OG9jcDZqSVB3ekZadUZIemkwQzhU?=
 =?utf-8?B?aHU0cG1OUTgxOGtvbXVKNUdNVFEwVHVBSzhJL0NHOFVFWjI0dDAxdmVtZFA3?=
 =?utf-8?B?dHNoT0w1WFdHci9IUllQaDY5VGo1MGlYejQ2NnpRV2dHRzFCaG9xNUZqTm5X?=
 =?utf-8?B?ZzY4Zkx0OG9JK00xam83MU5RS1l3eGVibEJCRFFCeTQwTUVDeG5zT1pSZEtG?=
 =?utf-8?B?aUc2bGhHdDBsd0hoWnIrWFNXcUw0M1ZXdmltUThvTDdFajMxYy9abWN6SFBP?=
 =?utf-8?B?enR0ODgwM0VUMkpaK3hWOUU5UUU5akJ3U1B0RDAzNEJnVEJFU1YrYXdORnhW?=
 =?utf-8?B?cXFrYU9JZG04TlNxbmhtazk3M053bmRxTHo3anJ0OVVnMkx1RGFhYit4dWFi?=
 =?utf-8?B?aHVVRjBrRzVOVHRobGZDOHo1RlpKc0g0SURadFNQaDZBcGM4M3Z6SFIzUnZs?=
 =?utf-8?B?Ymdza0hpSW5EeUFSdnJNYURvWXhrcDhUVWdzaCt4ZXNjNjJtVVdFS1Vtc2dS?=
 =?utf-8?B?V2JkOW1nbnF1MXIrc3NYYlh0MEdaYTJpcHZBaVlId3cxajNBcG93Z0RnbktP?=
 =?utf-8?B?ME1YR0lxUEVDZVJOMTFiajBQd2RTWW9BSTR6ay9oaHVvdllNL3oxOVRudGJu?=
 =?utf-8?B?emNZeW1jTDgwd3o3TnM5bVhCR2hMN1RTbGJERzFKQWp2OGVFekhlNkVpU2dY?=
 =?utf-8?B?UzVYMGZobXJtdXFjY2VHQW1zL0NOU2Y1OFo0Vm5NU1RhS1dVa2dGbnBVRVor?=
 =?utf-8?B?eHFWam9OWEFiNGRTVU01dE5UTjcyTjY2VkJnSjBLZHNrMHFIa1N6cnhDOVlk?=
 =?utf-8?B?OTF3aGRnUGVDdWtoSDhiNEJYc2V3YU5zdm4zZUh5VFI0aGIranl1ZnQzbXFT?=
 =?utf-8?B?b05lWVYwblIrOVNvZUUvQzlKOEFTT2NrV0lHYUpyVGlLWWt6ZUxjanYrUDFy?=
 =?utf-8?B?dTJTUDhoWDV5cFV3MmpvcjZYbVlSdFU2YWNDd2lBN1JTdDAvMnVQM2RQd1ZS?=
 =?utf-8?B?QTAxbEdXclRsWnA2ell6bVJIcmtYeVNCM0dYVk5uKytGUXZBUi80dkcwMm9Y?=
 =?utf-8?B?R1RCejBXd1BhSjBTSlVpRUFOcjhRMks5WXVibVpxU0d0VUwvNUpMZFVXVjV6?=
 =?utf-8?B?MXNnMlhMa3FRWVU3WktzdmI4a3h0MERmMEswai85U0hoYy9OOXFwUWtyc3NI?=
 =?utf-8?B?ZHhoMlczZEh6dVMvRlpKMTZoYitiQTdHRktsUndDYThKQS9LMG8rVkZzdjdW?=
 =?utf-8?B?MDIwZmp1VUU2QjhhY2syd0pMTTh0NU5xKy8vMHlDbW5IajhXcjdHcEFjdEdW?=
 =?utf-8?B?a1c5UWx3OXdDc2xDdWRqRFpZeWVNL25odkZHOEY2N25EWTM2bGhlRVo2MkNn?=
 =?utf-8?B?c3I4VjJFVCsxM2RqWkEvMGNhQUdZTXNEV3VWZ3JSZlBTZk5nMEdzTzB4aTlP?=
 =?utf-8?B?QmliVDlOMDY4eTdyRGlHOHo1K3AyUmxuMzl1WkxRbWcwckxCa0NkeVZ0NUJF?=
 =?utf-8?B?ZUMvbW1PQmpXTU84RHNtYWpzZElQeGowaGRkRVF1RTJmRkRZYytLSkVLb2Nl?=
 =?utf-8?B?U2phRjl4c2xuLzRQcURnRGFKODBySlBmbzgyMm5CMjhMV0h0N1BDVHpiODRs?=
 =?utf-8?B?SWgzMk4rUTNEclpNRXpjK0pYUnFqTGtCV2VEM3hCeFVWdVJZc1Zza1F6SmNM?=
 =?utf-8?B?blBuMzhmM3p2Ni92Rk9XenJDNndhaTdNeFlQcmszUDRBNEhSK3JGWE44NnJP?=
 =?utf-8?B?VUdFdzZpWitFNGM3RlBPY2JIS05sMS95Vm1ZeGxUVjRhem1RcnZ2V3l3RUlo?=
 =?utf-8?Q?t/XHA6/lz3TvOVYU2pTRmxn0Pu2IlF5JdpiA8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkFnakJkYUxRcjN5OUNWRUQ4bTNaemQ2VFVTWTlUdU4vVlBBbW1zbGdQMmtq?=
 =?utf-8?B?bVJ1N3orY0lSRDFVU2VmMUtZT0YyZlQ5amlic0JKUmMrUnRLeTd3UkE2dDJl?=
 =?utf-8?B?L1ZtclhtVEZOdHJtbUgxMlc2UDN3VXhCa0dES0M1WVVJSHRBSDVwQ3lHL1k1?=
 =?utf-8?B?MjhaYnpFc0ttbWkwUjN0c2ExeVU4Vm9tSmdrdTB3ZlFpQ1pNRzJpSmRTenI1?=
 =?utf-8?B?VS83Ny9BWmQ2bzJRUXRteWNrb1l4cFM4a2cvVHp3ekVEZldlcWYyYjVQcVJw?=
 =?utf-8?B?VFRzdi9laHhqZkVVME9EcTArZlRuRyt4RTJtblZ5bVE2cWRPSXlKK29hMlhT?=
 =?utf-8?B?TVNEMWxQdU43YWE5UENSUlQvRHdjajBLdERtL1lUYjZYMmFWOS9aWGtGUnNB?=
 =?utf-8?B?aWZrSUpabkM4SENlSEV1QjhETXhyblhYUG85SDd2NTVOckEyUy9LQjlDM1Jw?=
 =?utf-8?B?QzBBc1RkNHFkd3hjbE1MSGNBa3lxNW9vZ21abVZzbHhPUE9rUnkxNXFMVFJo?=
 =?utf-8?B?cmxqOVZ4Nm1PamdiVE9yMlpsM2dodEtlVmNvcno5SWxYSUlpZGwvNzlxQnN3?=
 =?utf-8?B?S0Z5bkR4ajNXTjRnY3hwTkUxTjFYc0FXQnBEOWFjSFdRSS81Qk5weEdvczNh?=
 =?utf-8?B?aUtKWXpudjN4V09KK2tRQmpsbE1TaFJaTFE0bEJsUFk3VFVQMmN5YTZGbk5h?=
 =?utf-8?B?Nnk0WFBDOXF6SjBPZS9DalBpdTN5a3FHU2p1WGYzaWFBa0k1SDIxd2N6QzVr?=
 =?utf-8?B?MEZLME1Pcld0SjVncHRRV044S3R2S1UyREFGd0tYMjRjVXk4QjZBRnEyUjlv?=
 =?utf-8?B?cjBKTWhjUlNhcEhySEo2VGRSVExYbFFqOGFSMEFOTzRnTm9vWkFOSEcrc3hD?=
 =?utf-8?B?ZHU4T1VNbzRYV01Qblk3TUxUVThESEZBUkFMb2psY0xJdnhFU1FFQ2FTRTdy?=
 =?utf-8?B?QTlXbnVzcG5lajNLa0Q4bTNEeXBObUFBSVRtdk13dUdyVVkyTHpCOG9JV2k1?=
 =?utf-8?B?ZjBrTVRUbml6bkdhdFEwN253Rm5VZjg0U0hUVkxuZlcvMVVhd0lDdGhibk5T?=
 =?utf-8?B?enNzdFdkbi9IMldxVWI1MDQ3MDJ4TzdGL24wSFpkOXNmbEZDQ1JVSFVwQTIr?=
 =?utf-8?B?bXVSYTZEU3hwbEhTdVp5MmVhdHpsQWxwUmZoQ1J6eHJzYUtMeG15VllHVytJ?=
 =?utf-8?B?bW1QTnJxdXRMVlZqUDZLQ0lOLzZNek1TZWJBRUlZbG9Jb3BacHRyT3pZT2xS?=
 =?utf-8?B?Q1owRUpHc1ZhVmljZE1qRHgrMG1pSUx2REFaYWxWTUM2UElwSDQwOXV1dGNa?=
 =?utf-8?B?Q0RBYUx1NDFhZU1RcFhyQmxER05BNXVIcXlYVVZyTE1MenRFRnZXZXhXMFFQ?=
 =?utf-8?B?MnFQT1lRbGxjakpPV1lDS0ZmclZ3UWFZd09LWVd2Y1hOSU9CN2laS1V6T0RH?=
 =?utf-8?B?QUphK0RDZllsUTdzSEZCcEJ5UlRtZUhUTitma2VZRUZBZkhvV3lsbWQ0Um1Z?=
 =?utf-8?B?ZklKQTJVWWh2blBkREZyTEVwU1pmNzVXUFN4OHh4TDNkYjB3Y3NzRnA3cHFx?=
 =?utf-8?B?VXFaelc3bFhJbHY1MDVzKzU0b0NaYklXVmcxa0lZejkrKytTdm5OcWFiSTg4?=
 =?utf-8?B?MkJxTXdSa3hORGFpVVFZQkJ3UFlTWHpCMHdIZ2lSRGEzbGVGWFkvRExmOHkv?=
 =?utf-8?B?Q2hwM0dPZ21Gd2JZdkR6UUpJblp2bTJpekZxVlpVTmdHOGxuY3locDRxVm1a?=
 =?utf-8?B?MDRkNTdlV3JFS080TEp3SDBZa0JZV21wTkNZaVlkTlE3d2hSMDBNbFFxc3lM?=
 =?utf-8?B?OERYSUhWYnJIQW1LL0VYNUhsNXJPRDR4c3FPb3Q1b1lWeGt6ZXAwRVphNmdO?=
 =?utf-8?B?ZVFNdlRGOXpPOVJBVWpXUGdzSGpKWVdEc2pNeDJJaUlhODhrQ3A4ajRlcHlK?=
 =?utf-8?B?VjRuWXBGc0NyQlIzVjdDU2UwN2RvV25UbW1VME41MFhhbjVUeFVSTHZMSEZG?=
 =?utf-8?B?YVJqcjJOOGZMQm05S2VSelpvb20xLzNVZFZwZy9UeHhTQzc2UnVjWTBSSC9j?=
 =?utf-8?B?NXVGMnI4bDFZOVV4TWlOM2p0WXU1enRtOE1TTW9jWnppV0NiMDhBcGgvWDY5?=
 =?utf-8?Q?K33f1R7ZR8MORV/vcZ5FmHj5f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30eb888-0b26-45e2-e128-08dc8bb5a584
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:32:26.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wxKsbHoVNcxMRWqkWEPANa/OFOBcXsmreDahucgLf0Z9Rek00SgpE/BBAAC2EIs0RhS6OAJ+FJxUiJAH6om8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Start from v4 because fsl.esdhc.txt to yaml already sent out as v3.

Now only "bit-endian" proptery warning left.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v5:
- squash dts patches to one patch and fix typo.
- move spi-slot-mmc to first patch.
- add Krzysztof Kozlowski review tag for fsl,eshc patch
- Link to v4: https://lore.kernel.org/r/20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com

Change from v3 to v4                                                       
- Add dts warning fixes                                                    
- Add mmc-spi-slot's voltage range fix, (not sure why it apply to          
layserscape's dts file.                                                    
- clock-frequency is not required property                                 
- add dma-conherence: true in binding doc

---
Frank Li (3):
      dt-bindings: mmc: mmc-spi-slot: Change voltage-ranges to uint32-matrix
      dt-bindings: mmc: Convert fsl-esdhc.txt to yaml
      arm64: dts: layerscape: Change node name from 'esdhc' to 'mmc'

 .../devicetree/bindings/mmc/fsl,esdhc.yaml         | 105 +++++++++++++++++++++
 .../devicetree/bindings/mmc/fsl-esdhc.txt          |  52 ----------
 .../devicetree/bindings/mmc/mmc-spi-slot.yaml      |  16 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |   4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |   8 +-
 9 files changed, 124 insertions(+), 69 deletions(-)
---
base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
change-id: 20240610-ls_waring_esdhc-93136a5dd794

Best regards,
---
Frank Li <Frank.Li@nxp.com>

