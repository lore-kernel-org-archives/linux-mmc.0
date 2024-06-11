Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BADB3CF63;
	Tue, 11 Jun 2024 16:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121753; cv=fail; b=sI6B8mfwdFzV0FgS8U+IubObPvXluKWRfSeLB9bF8kDeoPyoVRGY8LjSIAj8q6d+RY/Q1WOyFRZjn0MMcBQR/06pTLP1hhOWgaiHOvAZTk2DiVLkcmi9ovZoSXr12kWSBuEsUp8wlZPFjL/pPzyEscW9yjpS6m9D+evFjhvZCnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121753; c=relaxed/simple;
	bh=hQrQKWmOiEIPrQyDeO67F8w9gGwoWrNJgZyQxOy7iMM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DUwRVSCEjfeLgd1mly7Z1Kn4E7n6jaXtPxN+2ONvIrgH5ktqWWcgD0RDudj7J0m/fyms7deT0PBA3qxr9FDwh2OQS9QpfCPMALLCUVtI9qd88FqjrisAug4Bk6oUH7WOI8aOrBcbR4LCSWEgULhao5/12tED27KbhCWJsC2VzVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eJtGFJTv; arc=fail smtp.client-ip=40.107.105.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eJtGFJTv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6pt4vW8DkIEwWstposOmCejQVeG+6D9DzPVD0Fs7DFB9DrhL2D7AYV98LaMeuoTqS3gY3V/21t99W6/8PS7Ocyp3Z0OZllMkZfB9iM4YoJs5EqWiXUAxdgKf8p+z5IaRwIlyxzwHdBNspTgVOoSnFTvOLl5Rzl3b+mkxaBLNYfROO7A3vhXiDBecn85GwNpMIdO0Pv9Z52iIjDSnGgi/z64d2NxQrZ9yUNFDCFy+DZrozCxL1ZpjDAL50kILnb716HzlHwuYOxLDDzcZtFKbuRY5D6yWQZ9s/3MRT6weuO5EybkqCjbb3+iqlIYub9y6DZg3qNEgR/CeM40RBfGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhB8R1dan+WWROOlNNXtlak7PCtS3swdMz+EeW2zg7o=;
 b=hklllonbBwsgHY6qFDEILZ3eB+X/HuKGSTCjec5eszj7g2lcc8amfghKVGT//6U68FY3edaVwf/r51jw4HuktLQCAx4nFwwhsHziZ0BpHax6imyFtAE4KKZHJ8r6hNFgRWZPdIE62O9j6FiIVYO2MQIEP3ULQzkxQWKpJEa0t07/bTeJ/UEQ6IEhgCwAq+hcNqs0po6A42lHzsakolhmHB8EBNd8MvXF8RoVUjaQYixwn4+dpdL/1CbauCzf3iKx0CtmK/NA0gF6hDdkC20tNZgtg5fgA6j9XS71xfRXgh55onqTUWa9dFgd88g1sZvNDgDSw+uftNtO4RZmBrq11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhB8R1dan+WWROOlNNXtlak7PCtS3swdMz+EeW2zg7o=;
 b=eJtGFJTvPEcjwwU8hdKp85fIFQtH+H6S3U2MAzYhytXv1ElkL+BQmEzFx+owyfVr6x/FZVYWdNQujROO21isJ59mn/NiCQxaTwOJjrBxfb8g7x0viddhrSoHWEEc67ve0qQRPrv6LytpVTs+HuSRrd2z4sG+L873XSNi45o7l/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:47 -0400
Subject: [PATCH v4 2/8] dt-bindings: mmc: mmc-spi-slot: Change
 voltage-ranges to uint32-matrix
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-2-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121738; l=1478;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hQrQKWmOiEIPrQyDeO67F8w9gGwoWrNJgZyQxOy7iMM=;
 b=2gpilG4li/I5k8cRN5/p60ceoPvBPzRmiPfoakLqoPKy38SONXWj+Nki0mKcc6e50GVPmgucU
 UITzlGPnrw3B5bpDTNFLec5Nh5eDVub4BnLD1BRTU+NTzmTIU0bdo6t
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: e7fa11c3-4ca3-45f8-99cf-08dc8a2fe440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDlzMEEvVUFlQkhPNlpCK3RaaHg2elpGY1VGd2lnMUtFL2cxdm4rNFVoaFJx?=
 =?utf-8?B?VnFScE9GMnpVNmk2N1ZkeFZITGJXUnlCOG4zTEREejN1bXV2QmI4N2RMQTZG?=
 =?utf-8?B?ODhHck1CY1NYVHpwZFhkMHYrNUd4OGd2QzVveVlnQVVEOFhGMjZTNldyMVB3?=
 =?utf-8?B?cTVrc1l2Z0RFS3g2ZGlYU0tSaDkzNHZGcGk3SkpaMlBtcEpUVThwd0loUXI3?=
 =?utf-8?B?NC8raHo3TkFWZEI5akNvTDBvK2xOTzUxSzBWd2s2Zm1PZjQ5K215UkN0bmdt?=
 =?utf-8?B?VHV2Yk9GQUxUNHcwRjR5ZUhWS3JCb0ZMTUhYR2MzdUxTK0FLak5obTgwa2lN?=
 =?utf-8?B?UHJreU1FZ2kwNU4xV1NyVmoxZTBWU01GTFA1R1N6N0NSalpac1dlTVBDeHZQ?=
 =?utf-8?B?YzRPNytnZjBFaWVQSEZWck5nSWFxZmJXS0VDVTNhWVNTUFNKSk02UVNhZHRp?=
 =?utf-8?B?dmk5UkdNUWJLWW9weExKSXVvbWdnd1R6UUZLUU1MajR3NEVOZWtxWnY1TnZL?=
 =?utf-8?B?RnZvODZWV1dlSC9QRWZBWkdzdHdnVHgvclIzZXIxdUtxRkhpd3Y4UDBIZ294?=
 =?utf-8?B?M3NCRFlEZ25TRkpOaVBmUU1pTVNQMmNyK0VHOUhYMlhhL0N3SXV2dXBObXZV?=
 =?utf-8?B?Y2lhRllYTE4xRGg4RkZ2MGEySlorZUJUTnM2eEVkUzNLbEVIbkxlLzlhelNR?=
 =?utf-8?B?Y2tSVFJFeWtXOGgzaEdGRUI1ODg4Smc3bnRsdkNBdE5SUm4ydzNacjZTalZD?=
 =?utf-8?B?RzVmSnpBa1JzUnFtWWJOOWFtQVNlRmJqckNvZkVBUjNQamxCV1NVbWs5Qmg5?=
 =?utf-8?B?L1VJZ0EvTjJyMVlLVy9DdUsveWYzNkZPYS9JWVFkdC9xVnZkajdLMU9xc3VG?=
 =?utf-8?B?WlA2ZDVWNFVWZGZLN2pkbWlZZlF6ZjhyY1NLYlZRSXpWUlUwRXVaN2xsbUNV?=
 =?utf-8?B?TnExeGVFcXkxYXNpN01McHpqUlBqRWU4eVpiL1NKVndsbmM3cEYvYnpQdVFj?=
 =?utf-8?B?bEJKUGtQbFNsNXBUNmU2ditFWmtJUmFac0ZpUlNJOWc5c1VPanlhRDdqSm9N?=
 =?utf-8?B?cklKd2paNURpQkt1T0JBYTJiR0x5VVJGNmYxYlhMRmt6ZzNtZUJZQm1wdlI0?=
 =?utf-8?B?NzNZbTBxN2ZiRkVrbFNWZFpWQUJDYzBWcmQ0VDh4Sll5bkxvWmFJVFhxMWJs?=
 =?utf-8?B?OHJ0eVYzVzFIRjJGRGI2SUdVSXFTcVArcHdld2NPbmFvMG9FanNzSWpkeUc4?=
 =?utf-8?B?cUVHV0dqQlhIRC8yci8rTE95RHhGdDliTTFRNjBISDJ6eGYvV2lIbEJ2MVB0?=
 =?utf-8?B?WlVJNkRpRE9DL0dMQ0dxTUtmNnVQcDJ4S21MaGtYdnBFMXIrNzIxYTV2dkFx?=
 =?utf-8?B?VzdUWVBoclBNR09CWktldVFhVmFFOHVLVmE1aVRMVnZzaTlSUTZGQzlEYkVj?=
 =?utf-8?B?SWNZVXYwbEV6cFpQaEM3dGs4QWhiOW5JNnVvUE1qNnZJWWNaaFlYSU1NOHlM?=
 =?utf-8?B?UFYvLzRSOGZVcGJ2aFJFUXFWbm5jWUxXVmFPMmE2cWJuK1Zta3AxNThFNUxo?=
 =?utf-8?B?N2tQYjBSbWFSakpHOFJ2cFdoTFFlNVB0aG5Pb2E1TmM5Z2dmcUcyUFlCTkJi?=
 =?utf-8?B?REpldGNWNFJCN0RZYU9rdzJUWEhyTmZXT1h2QXNzUk84aUNEdkwzeXBSZmlM?=
 =?utf-8?B?K3p4VzBnMWNGSXNpY0xic3ArMnhnMzJMazBrSkRjSVZGNG5rZC9NYU1LbUt3?=
 =?utf-8?B?UGt5YktVOXJJVkE5VThTUXZSV011VlQrdndnVkd1YmxiazhGNVZuSHN3MzJi?=
 =?utf-8?Q?9wvHidCsGobOI9qHk9c8WYBXv0MVZn+h57sgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzJNUE1hQXZlOG1XWTZKMmNNQXhZbTI2bTMwL0dLMHN1Vlh1ekJxV0ZXOCtX?=
 =?utf-8?B?WHovL0NuWEdic0xJUG5MVU9xTzhQVUo3S201OVI2NU01ekpHckhsWmJaMzU4?=
 =?utf-8?B?c2QwRjQ3OEVYVjlldDNnQ3dzYlNScytoOStkSWtxaWV6SGRaa1RpZlBlMkFY?=
 =?utf-8?B?cHpiOU4vWURzbFVFcnhoZ2toRW1weFU5N1Y1Szkza08vanZBQTM4U0Zza0pw?=
 =?utf-8?B?dnFsUTEyVDBiV09Da1Y5ZldHTm9makcrNW4rVXZXMXlNR0w3VzlZQ3owQk80?=
 =?utf-8?B?YndXOVdnWUxGUnVlNXhkTURHUjNDTDhQQVNjT0dicHlJUndzUUdPNld5RFFX?=
 =?utf-8?B?Ylp0d2ljQ0JOWllXRm5lQlNRMzN4TjVuVzNSS2NZeG9GU1Z2aDN3YWtPa0lS?=
 =?utf-8?B?aXJ4VnppYTg5ZVlUTDhvei9iT3F1aWsvYnI5VW4xS3pycS9TOVk5Vy9HZHJ6?=
 =?utf-8?B?UjJZdnJxcnowdS9CekRQNmZiMi96cjA3eE1WLzN4RFdvbm9XcDhKSXlUcGQ2?=
 =?utf-8?B?VVY5ZmtvbnVqaC9SRE5DVGwvVDNJV3dXV0NRNTl4OTh5djdNSXd6WlVjZmhB?=
 =?utf-8?B?YklUNlEzK3FidGlLYnNoZ3hiZG15Nk9IR1RxdVFrWFNOb2FxTERPS2dJQ1Fn?=
 =?utf-8?B?b3RUeExQbk9KdkF2VVpXMmh2bjJ1QitWMmwzRTVPL3Jyak15SnUyNGZFS0FS?=
 =?utf-8?B?OFRtSFJ5TjRGSEhpeEwvcnMybE8zUEtuWWxZQzhEdUZveGY2aC90aXBoc29m?=
 =?utf-8?B?YUx0UUxINndHdGk5RWdoK09iWTB3V0s4dGpyYTd2NDd6Z3A0WElPZVNDRFpi?=
 =?utf-8?B?WTN5MzF6c0srQWswMUwyRGx2NkhzZ1pzVzVxMFpBZWxEb0xvVThJMHh1aHk3?=
 =?utf-8?B?VGdDby9DL3dINSs0MlM1MGVDL0g2T1FQVmwzbktqZWJYVzQ2REtSY0F0eXJm?=
 =?utf-8?B?NFp1ZGR4bVppTzJaSEZPU1ZxSW0wWnYvMGVkak0xcVFZam00cWd1WlJPU0Qz?=
 =?utf-8?B?VmZWUFc4dkp0b29RV29Od2VOYkpEcDV2RG5ZVEVqazNHdEwxTFJsOXZVWE5v?=
 =?utf-8?B?a1dQRmhlamwrSWp5Q01iS2xXb0J5SDlZWEFWTDVJUTQ0ZGNKSWw0UFFCQ1VY?=
 =?utf-8?B?aWpQUDNJOGVwck5oQmhubmJJZ21EZGUxVzhFbkoycFI1UWQzYzJ1eEw0a01a?=
 =?utf-8?B?QjRCZzViTWNWT2Q5aDY1RHppRlY3Z2FOR01hZlMxME8vRFFnc3hyUEZrU1Bi?=
 =?utf-8?B?MHBuczB0NG01NHE2MERXN2FLVm5EbGhPRjE1QldEbVVsa2lWcjVtQXp2TVpy?=
 =?utf-8?B?amp3NC9lZXZDQ2ladXQybEFmUUtzMGJ6UmowdlhJSmp3L01RaFhBaXgwZ2tU?=
 =?utf-8?B?VjU4QlR3ZVZkZUQyalZHbkNwWXlSVWJTbTA1ZkowTkV4WXFjV3RyN2JuUzNP?=
 =?utf-8?B?V3FBbDRSUDlYbDVJNWgxZ0RSSFJOWXN1c1IwNFd3ZGxXVTZ1eUk2QWVsQjRD?=
 =?utf-8?B?dVBibXFDbUl5Z2tkQnVmUDFRZkNRVURJK05rejIxenpJT0hsTDMyM3BzMUZt?=
 =?utf-8?B?WHVBakJZQndJL2Nxd2swRW9ZUGJRSnJ4NHBiUTFrelZtTWczdlJRQVowb3A0?=
 =?utf-8?B?UGJBMXlvSkZWMGlKaUxFSzA3NWZoSXJaKytmRVVSZEp4SFZsMFpuSnVCMVBB?=
 =?utf-8?B?NmZEVk5HSlRGelpIeXRRUDd4T2tUQmtwOThoU3dnUk5wRzVUZHA4TVZDaHBB?=
 =?utf-8?B?MXV0bi9pdEtEZGRia0NQdklJYitZRnNYYTUwVzJIOHFSeExMODIvYUl5REpq?=
 =?utf-8?B?d3FQWlBNL1dYei9XMU9wZ0tRcFNTd1FhUWc0aEEzRDJTTXhSVFdjK0VSM1BK?=
 =?utf-8?B?NEFJK1dyZytsZmJITFpPMElZNWhNRUtFMXFIYi90MmZLSzVsRFlucG5kNmE1?=
 =?utf-8?B?WkNVTTBOaHpzeVluWk5TbFV1MGZOV2JSL2FNajZ1dWFmYUZOZ3FPSjY4WWNV?=
 =?utf-8?B?MTErUTdxREx0OENZQ2h6RWc3V3YrNkZrZm1VK3RDeUVMSFRuNHgyTDNON1N2?=
 =?utf-8?B?a0NUbVV4NzJiaG5LRlowOG1ubXp6ZG96RzdDdlhJalNhSWVvckYvbEZGL1Ru?=
 =?utf-8?Q?O+fLYpgV9AUBd26zXFbzz5Y7v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fa11c3-4ca3-45f8-99cf-08dc8a2fe440
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:27.8321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDRwNs102ArRNQt4Cf+3um/pllzBXDGCRmAjj+SQMOOTn7xMuWYQ6dW9/70QrQJPPd1whRhLDJ96wbmIVWeUaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

According to common mmc core, voltages-ranges should be matrix.

Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Not sure why it impact other mmc yaml's voltage-ranges.
---
 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
index 36acc40c7d181..05815b837219d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
@@ -27,17 +27,20 @@ properties:
     maxItems: 1
 
   voltage-ranges:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
     description: |
       Two cells are required, first cell specifies minimum slot voltage (mV),
       second cell specifies maximum slot voltage (mV).
     items:
-      - description: |
-          value for minimum slot voltage in mV
-        default: 3200
-      - description: |
-          value for maximum slot voltage in mV
-        default: 3400
+      items:
+        - description: |
+            value for minimum slot voltage in mV
+          default: 3200
+        - description: |
+            value for maximum slot voltage in mV
+          default: 3400
+    minItems: 1
+    maxItems: 8
 
   gpios:
     description: |

-- 
2.34.1

