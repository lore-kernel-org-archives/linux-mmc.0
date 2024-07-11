Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013049.outbound.protection.outlook.com [52.101.67.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA315AD99;
	Thu, 11 Jul 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707994; cv=fail; b=qi34ZQAg0BoMLSZ5K4lVzRAL2XuO/8mG5q6J2qalIN/Z4v4cqOqIyRnnFgxdEEKlbUrJ7iqmtWViWV/vq0NvbFUogXjuEBSXPUMJR/sLoGYcfBMe+9ehv+n3pWlDfxQsctWnnfMR10OQ8hUjuCyOABZuQhlD3/f6sDx9xX3pXrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707994; c=relaxed/simple;
	bh=RXLaPRO2xYJERZNYaoYjO3EhOJDkuppNhSuffU/MMbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pgyFeoEhpfU6Cp3X/TOGI16VCCR1PPj2581LFdaEXnFW/D5//wRqLg+0V+twjadfGCYWVa1hTuUV4c4HyUL8wASO4HxtOdvMH7LqUadk2sUen8vfu3vjZ/gSN2qzJCNlGe3t1/WfsSOlks1rhqvTbIYJI9o7DbCm+IhEMWZh5ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=e2bKA1/X; arc=fail smtp.client-ip=52.101.67.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e2bKA1/X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpfrTkAkFCzoClWjLDD4zR6tSP+IggV1VEb5uivT3FVhtENkctYT+Y83WXJiYobDpy3C3FanoX93YrfNbVqgaphY3bo5Id6UniP78ELMQcFoDbdn2DYkLmyZP6gq+21rfTRZ5i6vO6e7NaHH5viCQ1730umNuizkoXQDMZR4l81HbDDWUwKU/UHM7gGXwE5QT0rv6RTLwgfwQz4oHbb4ke9TgaiC4v6mQvD7sIERLMhd8QBU3P4Y0mhQLO4/AEHBK2zy7Txr9LRD0Oi7BsqkTWssUTpWdmV+wzDmDQt7NIlXnPLI3EO20vkCYM45/bMSVnHn4oyXsj+CAShxVJMDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbEcMPtBFGiPDe6kKrRQEh/4DQvCXkRQ1IuhHojtf/s=;
 b=KMdajaNqcBH0lrn/EkbFh9SAZSnrBZEdZs82ci3BcMb/HdA3BTdbFrph9d5/wUyPlWIcsJ5QAJJRDnq/2Kc254+kJRGvScScOOPWDX5L4H6FNoJEcPW9QNqHwZ9bgW5WKHWXTRQIESFufKhuMeSsVyyGNZJD5nt/FbgbpqfokthefvBLgOaN4gLDgGiXRAqlEQdF4cNPiAg7V7CMUa1cvog4YUoARjOVSsI92o6tx2AzJdEBBi+gxcVybo2H7tBsd0VaZ/yOoInwYODIcohcDW8n/RRzOKcMqFXVaTLv83d54F9G6FlG7smEn1mR5sNL+mZO+/+ztyTpJEzxv6kISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbEcMPtBFGiPDe6kKrRQEh/4DQvCXkRQ1IuhHojtf/s=;
 b=e2bKA1/XvqHsUlNDqsigs0fIFGm06WqBeo59bpjWBW6Mtpi+EiyIMZvOL3axbpzZTs2U+55WutBatTVquIx6A2vyMXYQK7RRFECiwa3+TsoNYxrwJScuyPyjWGbRdesOnscN5O2wuLCEeDEWu/T7kdN9e+aJHLPaYnVSuDkHn1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10745.eurprd04.prod.outlook.com (2603:10a6:102:489::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 14:26:27 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 14:26:27 +0000
Message-ID: <123ce7e1-1981-4a41-a131-168f4f7b5417@oss.nxp.com>
Date: Thu, 11 Jul 2024 17:25:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for
 S32G based platforms
To: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-2-ciprianmarian.costea@oss.nxp.com>
 <6a577d6c-04ad-4c12-bfad-815e811deee3@intel.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <6a577d6c-04ad-4c12-bfad-815e811deee3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0023.eurprd05.prod.outlook.com (2603:10a6:205::36)
 To DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB10745:EE_
X-MS-Office365-Filtering-Correlation-Id: ef384ec4-cc97-4fc2-c368-08dca1b5734c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2xrMXVSRVJiUXRWK3FwOE9GOUFGK3FJK2F6cnk3aEp6Y0RxZ2xUcVFyVWxI?=
 =?utf-8?B?a0hucXZFUWRvRVVKR1IxREVKZkVQL0tDQkl1SlM2NFZXU3RQT0hUQ2kwdjV6?=
 =?utf-8?B?WUJieXdCWmc1TG9FOGkvZzVJdjJvZ3dqeVc4SE1UcncveUkrbGk0cktQeElx?=
 =?utf-8?B?Z0VpSE5JV1J1M3FPYzRKVXoxZlo2NHYzQng4ZE1GdzE1dFBFY3ZOb1ZsbHp1?=
 =?utf-8?B?dFQrL3FXZmY2VVJyeFQxZTV6WC9ydnp0SnpmMzFMdnZ4RG9nVmR1MUpGZ2Qr?=
 =?utf-8?B?Szdjdkk0MWd0MUM3OW12VS9RQjNid1Z6dFV2Ui9PcFFLd0prRlM1MHhYbk9Y?=
 =?utf-8?B?d0xSR2ptaktIeWNxMXpUdlYyWlhyTGpWSzdjR1BKdlhNWWdGRWlGZFpCZnpU?=
 =?utf-8?B?K1lVNHo2cmdweThiNldsMWlPUmtFa0RuazAybVNGYjladXVDM0NTU0sxVCtW?=
 =?utf-8?B?V01xaXpWNXJnd2ZubjRianBpU1V0Q2p0cTZSUWdjL0ovN3VWS2dKZzBpMGla?=
 =?utf-8?B?RytJK1oyZDBoZEM2ODhMYXZFcEwvUkoybTE2TnhWdDc5V2s1MTNkaHdFRHcw?=
 =?utf-8?B?T2g1Z2FXM29nSE8xaEI4ZFArdzNCTjJFeDRac21rOVpWWURvS05JSGl0UnVj?=
 =?utf-8?B?WWlXSzAyOUhKL0RSVHFvME0wVzNyK2QvMGNWWkZpck9FaUkxK051Wmh6SkFs?=
 =?utf-8?B?dmtNOVFDRERXQTQ5NDFCUGhPeFZhZzJOc085RHVIazd1ZVQ2NVFqekdSSUhI?=
 =?utf-8?B?dzBtTG40MHpjWjJxeXpwa3FsUG9sWnNFMDBqQkJobVJYOTQzMlFlMnpGQjB3?=
 =?utf-8?B?Zk5Ib2lRYWdVT3NXNzQ3aUZZVXFhR3FMTndLNm5WQ3lNbUVLZ0p0d01PRnhE?=
 =?utf-8?B?SDJqZWt4bmRxdnRMYTB5WDRhQlR2bm5wQVRwR0RVakxRMUlZWHhxUUJIVTgr?=
 =?utf-8?B?WGxrQzg3OFBSRjB1WEY5QzYzZkx1NW1rL1JTMjV1azhnWG44MmV0QzBMcElw?=
 =?utf-8?B?a2hzODdxOWwrTzRhcldHMFh6MGdyY3U0bnVhQ3c1MjZ1M3lxTVU0WDNyNytE?=
 =?utf-8?B?Wm9KYkVXNTlZRHNJL3RsUHNROXNrS0hBUTNqYTBXWVNuT2JZNlBnWkZucHdK?=
 =?utf-8?B?aEZ3ZGluL0xOVm9rUkM3NGpzRzRlWUtuK3pZWU1ZcjNDbVlBZjZFQ012OU9t?=
 =?utf-8?B?VkNqcm9SZVZnSHRVWVVZaGtacnVUck9oSDhDQzdTYjcvbFlmd05seHd3N0pB?=
 =?utf-8?B?ZXQxM1dWUm0rRUhMMDlacTRWYkRuSTA2UmI0R0VTTFNaaCs3M2s4TU9MdlNV?=
 =?utf-8?B?eWpNbTN5WEZkYWpQWHYzQi9aZnF4UHdNSDNFOHBZM0poTHdvbVBKV1ZJYnJH?=
 =?utf-8?B?V01OV1VQUHptcHUzNGZSNHdJWnRFYWFSc08xTCtwYndBVHNDU2JVdmlUSjhl?=
 =?utf-8?B?cWNqZmpLMlFpV1VFemRTL2c1eFlDMW9wRmxSVldSUlRCZ0tvOEFFU2p5Zmkx?=
 =?utf-8?B?S2dmOGxIeHJxOHFVelFBeUxPUDh2a1ZqWUgrR2VsVk1GVVN2LysxS0UyTUJC?=
 =?utf-8?B?Ly82dkNsR1lKV3BnN24xR3FoZ1hrbjlBbG9GMzcvVDRFaFFWd0FpeUtmZmNY?=
 =?utf-8?B?cFM4R3R4SFBLd3RGVHR5QUZPa1NEQjRSclJhdEloOWNuRVc4eXFLOUd1c01Z?=
 =?utf-8?B?MktscVVkU3dZMy82VUxnUVZ1U1Boc05NUXZOMHBhTno0YytHdmNvOExRZXlH?=
 =?utf-8?B?UHEyeDYrcHVCdDIyZ3NMK09WVk81bWJ4eUxPejBVMnRxeXExNGpBWUtPRmxs?=
 =?utf-8?B?aldod3Rkbmo2bjQ5SS9OQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dE5rQ0dZTEdpTWhIOXJYNmVpbk9WOFJtWWt5YXE3S2xYT3E4UDIyMXRqTFpK?=
 =?utf-8?B?dWJpTWg3OWo5M0JGUzh5ODQyVmg0V2hUbE8yZmozM29Ud1VHNmR4S0tCbUc5?=
 =?utf-8?B?OXhwcEo1SmdIUWY1Y29ObEZaUk9JYUVjK1g0QVhIVk9WT2dKVnBWRVNtdUVJ?=
 =?utf-8?B?bTFuK1NZbXlVZmtlM29PWi9Iald5L0N1SnVrRHlWWjgxSTlLZjNYbW91NjNw?=
 =?utf-8?B?ZTI5akxvL1o3TUZwS3hwQVA1ZWgwTG5NN1FzM2s2cUNwNG1lVW1tZ2JsdktH?=
 =?utf-8?B?bmo0eWhzTUlYODVEbG9teXpaSHdaMVhrVmZwMWx4VE1sV1UvUjlaeXZ4TTZN?=
 =?utf-8?B?dU4rTnpXZ215NWxGWWJ0NW5DcVZpb25EY1c1K0VwTnhnZUFhN09QYTJRN2hX?=
 =?utf-8?B?TkZPU3hyeHd1RGNKM093RWtLZmljUlpkQTFsc3RnN3k1dGFSaFJ1T2ZyN1k2?=
 =?utf-8?B?ZHR5cHZ5bkZUTEx1ZEN1WkxieEZyU1VaVklyRkZBdFUva2hJckhyQzRpWGFw?=
 =?utf-8?B?WnRvQ04yRXVWcnhCRGQ0OTNkMUhyQzVmd0hjRGJUSUJkZXFVZmUxeU91SWYv?=
 =?utf-8?B?TWZray9LZ3BKMHJ0K1JMQSs5TVZ6dDd3dDlwcTdrZDk2dEF0M3liMENiaFpX?=
 =?utf-8?B?STVhUXo4SFBxQVBkKzF4VWVMSytDM3pZck5pSjZrS2g1ZkpyWkJ1T3BTcTZX?=
 =?utf-8?B?bVZ3SS9LYWIzS2xlK0xsRXZ5WlFkczN4QUJxRENEb0FqZXc1M1k2d3pmQUxl?=
 =?utf-8?B?VGljclMrc3VQcXBZN1ZFdklaUW9lb0tHMy9nRUt3UloyS3hJZnFYaU9NY3N6?=
 =?utf-8?B?czhrVDdrcUNFUUFQckJXTlZray9DbUUrZW1PanBwZk1Xek5MbTJheVRFTVFI?=
 =?utf-8?B?aDM2N0dvN1VpUENFNmNsWDN3TWtnM1FQdGQ1eHNkeUh2UWJ3QmNEZXlFQzc5?=
 =?utf-8?B?S1BmbmV4Nmo5YkpDK1NEekVHM3pKS3o4WVh1Nkpkelp5ZEdrYTU2UzBCRi80?=
 =?utf-8?B?OFZoYThhVWg1S3hFS1pFYlByOGtrT2FkYjVySDZ1RzFaUGFkUW95ZkxBQTAw?=
 =?utf-8?B?cWp4N3lWVm1BbitycFFxMmJIWWR6RG9lZzh5OEoyc0MxRmp3cHdKV3ZobGFI?=
 =?utf-8?B?QlFldkQ2ODB5VmNldzFMaytGWDNLMlVRcCt1NDlHYXVQM3VDQ1d3QUpsRDFO?=
 =?utf-8?B?SitxMTJOUFd3R1p0NU9kUGkwMDR3bVpMNkhSS3lucFVrNVFSeXg4OFdaS2ZT?=
 =?utf-8?B?MmtMRE81cTI1YkxzNXhRa2dSRDhmNGw0SHlkWENtV1lJVlphaTNRZG81NTFZ?=
 =?utf-8?B?S1l3cTU5R09uakJJUzJvajlKMVFpZVF3QUdKbU53Qys4M1pmZ0EyRTdncGVB?=
 =?utf-8?B?bHdRKzRYMmFPWk9BVUs1MzN6ODk3b3ViRG9OVk5rTEo2V04zT3MrSFZJcGF4?=
 =?utf-8?B?WG5VNTZZVmovVXVja25sWlo4OFZjalBYWVNjMWNTOHViTEJSU1U5c1NzQWhJ?=
 =?utf-8?B?eEh1UXRVaU1hSW5ydVlBNlB3UFF3WEVCaXlzSzNuWmcrN3BaWHdlTXdDNDRn?=
 =?utf-8?B?RXdsM29peHI3VnRMdmlLMzZDdWQ2WmlwM0E2K3FCVkRacGx3REI1L2ZKWXRT?=
 =?utf-8?B?T3RZNllrS1dLbG5GWWtReHl3WkdxVk9Jc05yUXY1YTdmSGExQ3Z3M3lZOHlP?=
 =?utf-8?B?Zi9NUmtGU1VEaGhFR0d6Z2gzTnIxRytjSXJuaGNlTnhzaXdBd1Y2c1ZhNlFB?=
 =?utf-8?B?d01Sa3ZzdkptSEpXN0ZRR2hnUDZEQWVFU1hiYjJnVU5Iekx5QWpXeVN0WnRF?=
 =?utf-8?B?RkJCS1NFcmR6aDJXS2FWSzVXU0VUTVlmUjZDY2liMVZ2UGZTanVzOWlHVmVS?=
 =?utf-8?B?d1dRNTdVRm5pMjJGcVo3QUVvYko3OWVEZWo1ekhVcjFOOWxKcVNYMEZSOEV3?=
 =?utf-8?B?R2g5d0JTcU9ENjN2c1p6WHNYS3p0L2R0VkJCZXpOS2twdU9SQSsybXgzaHpC?=
 =?utf-8?B?OE1Rb2NSQWt0ZDBNZnFTbjAvcS8rQVdqN2JQNEd3QVFCOVFITkNtVXU3b0N5?=
 =?utf-8?B?aGxycXlYYzlzdWk4RHRmUHBsbXJxZ24yWDZ1VlVPc1NENGh6ZFdEb2UrN09a?=
 =?utf-8?B?OWNrVDhaUHV0ZU4rYmZjTGV5TVQ0VnpFR2tXU0pWSjZDalhib0xwWXB0Q1Vk?=
 =?utf-8?Q?tpn03vdKsuEA+eBKyNFIaTk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef384ec4-cc97-4fc2-c368-08dca1b5734c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:26:27.8850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSc9Nr2fg7duv39/8CyG8t8lInR468euLTWQTzieIstjCjC5lphBYLKYFNWXxGW8OpXpY4STfrvWUebZ83RCyd+vVFS6cRs5CyL80CYEW34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10745

On 7/10/2024 3:34 PM, Adrian Hunter wrote:
> On 8/07/24 15:10, Ciprian Costea wrote:
>> In case of S32G based platforms, GPIO CD used for card detect
>> wake mechanism is not available.
>>
>> For this scenario the newly introduced flag
>> 'ESDHC_FLAG_SKIP_CD_WAKE' is used.
>>
>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Should have:
> 
>   - put the patch set version number (v2) in the subject e.g.
>     [PATCH v2 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms
> 
>   - added Haibo Chen's Reviewed-by tag
> 
> Anyway:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Hello Adrian,

Sorry for bothering you with this question, but should I send a new 
patchset adding the new version or what is the process after this step ? 
For example, should I send this patchset again with V3 adding all the 
ACKs & Reviewed-by tags to each commit from the patchset ?

Best Regards,
Ciprian

> 
>> ---
>>   drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 40a6e2f8145a..21d984a77be8 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -201,6 +201,9 @@
>>   /* ERR004536 is not applicable for the IP  */
>>   #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
>>   
>> +/* The IP does not have GPIO CD wake capabilities */
>> +#define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
>> +
>>   enum wp_types {
>>   	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
>>   	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
>> @@ -298,7 +301,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>>   	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>>   			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>>   			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>> -			| ESDHC_FLAG_SKIP_ERR004536,
>> +			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
>>   };
>>   
>>   static struct esdhc_soc_data usdhc_imx7ulp_data = {
>> @@ -1726,7 +1729,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>   		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
>>   
>>   		/* GPIO CD can be set as a wakeup source */
>> -		host->mmc->caps |= MMC_CAP_CD_WAKE;
>> +		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
>> +			host->mmc->caps |= MMC_CAP_CD_WAKE;
>>   
>>   		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
>>   			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
> 

