Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3B3D666A;
	Wed, 25 Feb 2026 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033576; cv=fail; b=tjm5LmktpGJEjYpQSZWU/RcVyH5q+dB1tFwfK2VTT7o+WUn/dk6s19qPlagYQe+JBB6y1yW2xb1qUKd3GB1bjCzhfWsy/WG3s2aCBrEkyoMNNisutYCMXX/jBYZ3JBXfJ0LM4G8qvH/mJP9GKb8RiAHq6bm6C6b5ZGJDc7vuoQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033576; c=relaxed/simple;
	bh=z+VErk2daygFi0JPmSpgw+7LbFyQhyigSedUWReSnOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y80SSzvQQ67sBBRMH59k3dp+io7Gr1i3ZTjxb278b7ip4i+3TT5ybndyhQikzZJdTEZwRdCQWDEYjhAnSeFOprbcRLrE5E+riR/W55u0E7vx9t5WazS+CPb4eq8TfHHBcVqF40GlVWBKnwSgAv1E6c6firu5vicC74EGnmfMR3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RbNLbbLJ; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RbNLbbLJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8L7ruKyahSVrhCss2aXnERBEaPc8hcIN0SmpZBeslzQoxFSp92lP4gKRQ6PS38v7dt1K/CdyMA0kOZomto/v6A+GnQXVQ5zboPCEANv+oaYGnPqgkzZWBSxePZbhQg9S6WhcJ96D8PulPUzaSjzT2v/8K5NRjEOf0ef5mZ+ArmjX2MiHSa67iKo2t12ktv2B19wdXx1vwhFYpR9Htcqf4gsch7UZLfNx61BaSPvbtdsegaqCkRhTNn0yI0oPHVKfUPEthObcwSesv8Hn809iscEWTfN1VdrR44BZ8G/68QIueinJIEGhGwcazGMRApcM7l12zxrJaVQ8zlnsO7KKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrUScNIuOhITqyNjLGrBJRZhhSoghbie/at4Ixd/7NE=;
 b=sTKpJqTU7Nk7u0lmmm0yDA8MuOWpil1XJndQG8x2DUJ5Ofx/NhPOAollIy7uZuO+4zEJX968aEMLA2WuiTvTYr4QzwUvsjDvPpXdDaqyrgEdVgLuoBwX7frnwaqdpNA7D5FRbd0Qa6YMfu/05dYjTAxT7wTpgxVTFhMv3d1IZpiYByUmN3vuP9ZJ55448wysaNbfcENStGIFd6XM2ZWfQW0ld19SuFicv/e95QL1OQV7fpzV+S+liYer9oU4ODA9k15iB0SQAaUmOC3gRv4OGnLxppuaL6hxE60NaJFoKK5qeTSQzZdeq2MncCOgSKCsh2QSKviKZC5wynN7R2EyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrUScNIuOhITqyNjLGrBJRZhhSoghbie/at4Ixd/7NE=;
 b=RbNLbbLJ8BWBrX6hfVD86XtnN/pyuCt7lrmqwBtk7DqGUMmOPrfu+e2CRpoZTuI8TpU4+RFl5Na+q8as8o9dztIswNXjsz6t66vAwZcC2qBwwaoZafuyGmQ8e4NrjqSzf2F8sc724U4x0a+NdESPUDSiVtIr/PsXj0ofpriEe+JvdGa424/qNPsr2UeT2uco9ngb5m6f12JQ6apRNLY8IW9oFvs+TndA/euofnHK5ybgJ2qk0mAUzAVmXOP/jmk/BwkuWhg4j0E3HPVisF5FfFnKxxnbJx44gH83EZeDD8nUewafZiVdXCEnJBf2UYqL2uKzCImx5aa8FIBrL4E7VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10847.eurprd04.prod.outlook.com (2603:10a6:150:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:32:48 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:32:48 +0000
Message-ID: <21b4cb34-0a27-43b7-bf0e-eab2b4cf86fb@oss.nxp.com>
Date: Wed, 25 Feb 2026 17:32:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] arm64: dts: freescale: Add minimal support for
 S32N79
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Andra-Teodora Ilie <andra.ilie@nxp.com>,
 Andrei Cherechesu <andrei.cherechesu@nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
 <20260225133858.8026-8-ciprianmarian.costea@oss.nxp.com>
 <aZ8Vitk2Q3ZxwoBB@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <aZ8Vitk2Q3ZxwoBB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0001.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::6) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10847:EE_
X-MS-Office365-Filtering-Correlation-Id: 779ad726-82bc-4fd7-6877-08de7483213e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	LopTJrNTYKWEurPsOzSKOIsv7dxjSCfQT9UoaZZlCANIkRnwr+P/1DKOi4AIn/Z0hmOfGXBKrtzDjlbgU0WjGSw1QVz7pm7QkzQb+UuLT7AjQjRh78EjI5HPeewnUXavrCj6Q6QnDBiDwdP9M8RiJRmmJnw2/k6fy4zxxz6QrWczvpBN/Va4kqg9Fq0iJ6P5bEYzC4fJB+vfa6N+eLxpozKVasGja+zKJ6FLRNNEd7aNAin0hoGoaVlf6AjKUNIL565rIi48w8wuDHBU3QNE0sYWdViOGjWC+GeZU20oe8c7SqAVdTWirEltZqQX5OIEpByWFmKFy2puS3O3bH+u4PXt16igEhwyM7rvDIVSpAGolHdnpkQ0mKk07uOiACPmqximiLqH1byQ31LhJR64L15qiPov93XVeOCpHLMqSIAZx4Vq9XkGUHi96XHsgRqWT2wDOxrPh1eihe3NG+We7F9KXiS8EYs9vTKWJvcKmsbwU9JtjpIP2/NdFI9KzD67GCD61KL4/TEGrB7c+NjvVYoyyOS1hRo4W1C17fH69+iKfgabVPHtCsJWVXNAW250o96DREy+emR4FNsk+vsKoTFycUQ5kljX8lP4Ncybj9wOf8nF35qS4l0XN2/bnWrMw1o2BOh5bpwuGvd34ZsI4Fj7lRx4uGHwT+hyaWbIqlZsE7ULTDCX8SPOC3ThImjwymGQBABT3dK+gVsq4S5aVwaxjQpM8DOc5Edpm6JkWVs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3NueXYwNFNyWWhKUUt6ZXhoRXMrU1UvTnh2LzlFazBJNys0NkRUTVg1Zmxs?=
 =?utf-8?B?c3dRVVhqYkhiV2FmbWdKbXBDVUZmVko3Q3cvWmVjcFpJUEZ6QXkvQjdQREpT?=
 =?utf-8?B?WnEwMkNmdHBybndpUjBPUUV3WGgwalUyY204Uk03OG5LaXFXb2Z5NC9xWUl4?=
 =?utf-8?B?Tm5tNTh6ZTNtT04yRjd5MGNibVlvT0s5UzZsM2U3SzNjdzFpK2dUWlNIODhJ?=
 =?utf-8?B?c1BSZWRsOEV6djBPZDkzUnZVcUhiY1BOelFSMmJ6L2VNOVFzOHRSWGhjVmxs?=
 =?utf-8?B?V3I0S3k1aUgvcDYvcmlpQUNlMFBnRjBoK21nMlhCa3VUUTV4dmZVemg1NnUx?=
 =?utf-8?B?aGRLUVZlVm1XSVBTTWpEajBXZ3hzNlRTWVlEbkw1YWhjSFJZejNLcTJrNDdu?=
 =?utf-8?B?a0R4N1FUS2lFREs0QnV5QW9EWnVQRWZXNjRZSFhjNXRaanVlOFlpMFV3MStV?=
 =?utf-8?B?RS9lNkVtNklYSG1kMHNnYVZlQ1RVQTQ4c0ZCbjZKaUpjK3hGZUQ2RnhucExL?=
 =?utf-8?B?VEgvTkEwZzBNTXdDdldqWkxGTnlOcGl6cWZhL2JQK3JvVEVCVnBRM2lmMFhk?=
 =?utf-8?B?UjIvcWRiWDBxN2RteDhkdktGdmlteVhyd1NjMlFBelNIelhoWVV6WkhlejFK?=
 =?utf-8?B?WEF0VnVFZEk4VElrSDZGSXdVR0hsNFNUYU8zZWdJd1YwdzFLbDlZYTdlbDFi?=
 =?utf-8?B?SmlMWFJIb3NRRGgzcG9abVhDa1h3SXlIVzZoQmVCSk0xZmNrN0xzbi81dzRx?=
 =?utf-8?B?cjYydHkxd25jUFU5UWpYQjZoUG1HUEw2OGQ3WE1MalM2dllqczZKZU94OHph?=
 =?utf-8?B?M1FBNmVKZ0NvNmVXeW5KY1NwK0NCRm9TOHUyTjlhdzFackk3OUllNjlpOGIr?=
 =?utf-8?B?THphSC9wN2pCcVNOdkVXdjRzNHlvSk1jYnR3T2tYbWZJM1hOSEk2Lyt5bHcy?=
 =?utf-8?B?dVBWZDVIR3V0Y0ZlRUNWQk5oUUxGSEY1NEV0ZG5BSG90ZFpLajFza3Rkbzkr?=
 =?utf-8?B?OG43Rjd2M0tIRXVCYm1waXRNTFFNblFubTNBVXVPRDQ0RGFXeDhnS09SbHU2?=
 =?utf-8?B?VDVJNzlrdFp6dk1aOWVIREpkYUI0M29KU3p0UFJhbmxCR3RCa2hYbnJQa3dG?=
 =?utf-8?B?Q252bWxlcThrdndrQkY4QkNmQ3Ixd1N5bTNDL2VGWkUyaHMrQ3Z6RTYxY3da?=
 =?utf-8?B?MFF5WmRnMlFhY3VxWVd3NmRTbkh6STNmcVY5U1plYmFMVXFhRkhBUGZGQk1W?=
 =?utf-8?B?VHQ1am41ZkYya1ZrTVJlYmF0N2Q0ajljNDJYRlM4YWR0eWZZVktlNFJYSUN6?=
 =?utf-8?B?S2huSGE1eThsNHAyY1J4bDhHYmYvaVFkajA3V2Jnb0pXSGYyZWxoSlJXRmhD?=
 =?utf-8?B?c2pTa0xLb1NCUWNtSnhyWVc5UUZSSCt4VlFmNEh2d1FHSDlET2RJdW5ray9w?=
 =?utf-8?B?SGc1RzZKVW5ZU3djMGhSK3J6dkErMkpMUCtBZTExRjUvZENOaDVzZVZRS2Nw?=
 =?utf-8?B?L1N4b0RPUXBLK2pLeFdPc2JVQzY3MXpybDQxeDlpS1ZYazIxZ2pXQmI5VEh6?=
 =?utf-8?B?RXVOTWxzUWFyMEFoS09oeUpBS2JMZ003VWZ1bGRRYTdZUmFYTkhObE1YUFpT?=
 =?utf-8?B?SDhSTjBYMVprUnY4QWs2cms2WVdBeGl3aExvWkdoQVVaa1JDMUo1Ny9nSFlX?=
 =?utf-8?B?WHp1MG4yWVBCalF1a1BNWU1SRHl0dDMxRE0vY2JuTzRMcnB6Sm82RjdXNW5P?=
 =?utf-8?B?NlVvU01RTmpBYUZoYzl1K2R6NHlqMjRrM3Rpd1pxblROV1FlNFExQzEyUFlm?=
 =?utf-8?B?RHc0enJOdjU5RU1NZWdkUzhnOEZMTnc3NUFnakF4MDhnNDJZakVwcU5EaTM2?=
 =?utf-8?B?Ti96am5WRzIrUjM5MWM4WmpJTERYSlNmWkxZN0ZrSzJFK21RZENhYk1XQkcv?=
 =?utf-8?B?cFQvcDArblN1M2lXcjhTZDhTTGNGaXhWUUVEVEJiOStaRGlUVk5kSG4zNzRZ?=
 =?utf-8?B?RXY1K0NLaWFBL1ZDVTlXVE05T3kyZlJqS2JoWE1iMUhNb2JFTzNJaTJtVEwy?=
 =?utf-8?B?M005S0o5Vi9Da0Z5bkJTUkcyY05uV1h3M1dFU2RLL3Q4eE5qakdTYUc4aXlX?=
 =?utf-8?B?cll0ODN1a2hqSmIzMEpJbHJsWXRsWmNmOCtKTEtLR09CQzVLRGszYjNXZEpT?=
 =?utf-8?B?NFZ4Yi9BRitFKzlLbG1OcSsxVWNrbStJbmZSelFwWUtSdXBNSFVZU2lhZVUw?=
 =?utf-8?B?T1JIMEdhZWI4MFdOY1BQK2Z2VnJWTmpKcGlzeHp4YXlTVFdsc0NqU2UvNE5s?=
 =?utf-8?B?TjgxTTRFNnZTQ1VzNDdlRm1IR1BIUWkrd2RHcTJkQ0RUNVVLVXNZd3ZyOGJW?=
 =?utf-8?Q?Fa09fu6Ow8D5Jy5k=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779ad726-82bc-4fd7-6877-08de7483213e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:32:48.1717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34JU/YPpysakCZcA2sWZ3DpX9S1kvSvb4HuyUeRB01bCMb35/19yLyLzPYDG5s5QEh6pTKwc9u90wj6QsRxr4b+AR5oXdbR7cCtzNOf9udk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10847

On 2/25/2026 5:30 PM, Frank Li wrote:
> On Wed, Feb 25, 2026 at 02:38:58PM +0100, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add device tree support for the NXP S32N79 automotive SoC and the S32N79
>> Reference Design Board (RDB) [1].
>>
>> The S32N79 features eight Arm Cortex-A78AE cores organized in four
>> dual-core clusters, with a three-level cache hierarchy (L1/L2 per core,
>> L3 per dual-core cluster) and 32GB of DRAM memory. It includes an SMMUv3
>> for IOMMU functionality.
>>
>> On S32N79 SoC, peripherals are organized into subsystems, such as:
>> - CIS (Coherent Interconnect Subsystem).
>> - COSS (Connectivity Subsystem)
>> - FSS (Foundation Subsystem)
>>
>> This initial support includes basic peripherals:
>> - GICv3, SMMUv3 from CIS Subsystem
>> - PL011 UARTs and IRQ steering controller from COSS Subsystem
>> - uSDHC from FSS Subsystem
>>
>> Clock and Pin multiplexing settings for the chip are managed over SCMI.
>>
>> [1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N
>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
>> Co-developed-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
>> Signed-off-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/Makefile       |   1 +
>>   arch/arm64/boot/dts/freescale/s32n79-rdb.dts |  70 ++++
>>   arch/arm64/boot/dts/freescale/s32n79.dtsi    | 362 +++++++++++++++++++
> 
> chip dtsi need seperate patch.

I will make a separate patch for the '.dtsi' file in V3.

> 
>>   3 files changed, 433 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>>   create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>> index 700bab4d3e60..e79807bf1820 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -501,4 +501,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
>> +dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
>>   dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
>> diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>> new file mode 100644
>> index 000000000000..d13eb3a0666b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
>> @@ -0,0 +1,70 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * Copyright 2026 NXP
>> + *
>> + * NXP S32N79 Reference Design Board (S32N79-RDB)
>> + */
>> +
>> +/dts-v1/;
>> +#include "s32n79.dtsi"
>> +
>> +/ {
>> +	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
>> +	model = "NXP S32N79-RDB";
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		serial1 = &uart5;
>> +		serial2 = &uart6;
>> +		serial3 = &uart7;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	reserved-memory {
>> +		ranges;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +
>> +		scmi_shbuf: shm@93000000 {
> 
> use common node name memory@93000000
> 
> Frank

Ok. I will update accordingly in V3.

Regards,
Ciprian

>> +			compatible = "arm,scmi-shmem";
>> +			reg = <0x0 0x93000000 0x0 0x80>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	memory@80000000 {
>> +		reg = <0x00 0x80000000 0x00 0x80000000>,
>> +			<0x88 0x00000000 0x03 0x40000000>,
>> +			<0xc0 0x00000000 0x03 0x40000000>;
>> +		device_type = "memory";
>> +	};
>> +};
>> +
>> +&irqsteer_coss {
>> +	status = "okay";
>> +};
>> +
>> +&uart0 {
>> +	status = "okay";
>> +};
>> +
>> +&uart5 {
>> +	status = "okay";
>> +};
>> +
>> +&uart6 {
>> +	status = "okay";
>> +};
>> +
>> +&uart7 {
>> +	status = "okay";
>> +};
>> +
>> +&usdhc0 {
>> +	disable-wp;
>> +	no-sdio;
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
>> new file mode 100644
>> index 000000000000..94ab58783fdc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
>> @@ -0,0 +1,362 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * NXP S32N79 SoC
>> + *
>> + * Copyright 2026 NXP
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +/ {
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	cis-bus {
>> +		compatible = "simple-bus";
>> +		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		gic: interrupt-controller@4f200000 {
>> +			compatible = "arm,gic-v3";
>> +			reg = <0x4f200000 0x10000>, /* GIC Dist */
>> +			      <0x4f260000 0x100000>;
>> +			#interrupt-cells = <3>;
>> +			interrupt-controller;
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			/* GICR (RD_base + SGI_base) */
>> +			ranges;
>> +
>> +			its: msi-controller@4f240000 {
>> +				compatible = "arm,gic-v3-its";
>> +				reg = <0x4f240000 0x20000>;
>> +				#msi-cells = <1>;
>> +				msi-controller;
>> +			};
>> +		};
>> +
>> +		smmu: iommu@4fc00000 {
>> +			compatible = "arm,smmu-v3";
>> +			reg = <0x4fc00000 0x200000>;
>> +			interrupt-parent = <&gic>;
>> +			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
>> +				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
>> +				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
>> +				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
>> +			#iommu-cells = <1>;
>> +			dma-coherent;
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>> +	coss-bus {
>> +		compatible = "simple-bus";
>> +		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
>> +			 <0x4e000000 0x0 0x4e000000 0x1000000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		uart0: serial@4a030000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4a030000 0x1000>;
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <264>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			status = "disabled";
>> +		};
>> +
>> +		uart5: serial@4a060000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4a060000 0x1000>;
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <269>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			status = "disabled";
>> +		};
>> +
>> +		uart6: serial@4aa30000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4aa30000 0x1000>;
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <270>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			status = "disabled";
>> +		};
>> +
>> +		uart7: serial@4aa40000 {
>> +			compatible = "arm,pl011", "arm,primecell";
>> +			reg = <0x4aa40000 0x1000>;
>> +			interrupt-parent = <&irqsteer_coss>;
>> +			interrupts = <271>;
>> +			clocks = <&clks 0x9a>, <&clks 0x9a>;
>> +			clock-names = "uartclk", "apb_pclk";
>> +			status = "disabled";
>> +		};
>> +
>> +		irqsteer_coss: interrupt-controller@4ed00000 {
>> +			compatible = "nxp,s32n79-irqsteer";
>> +			reg = <0x4ed00000 0x10000>;
>> +			#interrupt-cells = <1>;
>> +			interrupt-controller;
>> +			interrupt-parent = <&gic>;
>> +			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 0x9a>;
>> +			clock-names = "ipg";
>> +			fsl,channel = <0>;
>> +			fsl,num-irqs = <512>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		cpu-map {
>> +			cluster0 {
>> +				core0 {
>> +					cpu = <&cpu0>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu1>;
>> +				};
>> +			};
>> +
>> +			cluster1 {
>> +				core0 {
>> +					cpu = <&cpu2>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu3>;
>> +				};
>> +			};
>> +
>> +			cluster2 {
>> +				core0 {
>> +					cpu = <&cpu4>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu5>;
>> +				};
>> +			};
>> +
>> +			cluster3 {
>> +				core0 {
>> +					cpu = <&cpu6>;
>> +				};
>> +
>> +				core1 {
>> +					cpu = <&cpu7>;
>> +				};
>> +			};
>> +		};
>> +
>> +		l2_0: l2-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-size = <524288>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_0>;
>> +		};
>> +
>> +		l2_1: l2-cache1 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-size = <524288>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_1>;
>> +		};
>> +
>> +		l2_2: l2-cache2 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-size = <524288>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_2>;
>> +		};
>> +
>> +		l2_3: l2-cache3 {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <512>;
>> +			cache-size = <524288>;
>> +			cache-unified;
>> +			next-level-cache = <&l3_3>;
>> +		};
>> +
>> +		l3_0: l3-cache0 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-size = <1048576>;
>> +			cache-unified;
>> +		};
>> +
>> +		l3_1: l3-cache1 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-size = <1048576>;
>> +			cache-unified;
>> +		};
>> +
>> +		l3_2: l3-cache2 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-size = <1048576>;
>> +			cache-unified;
>> +		};
>> +
>> +		l3_3: l3-cache3 {
>> +			compatible = "cache";
>> +			cache-level = <3>;
>> +			cache-line-size = <64>;
>> +			cache-sets = <1024>;
>> +			cache-size = <1048576>;
>> +			cache-unified;
>> +		};
>> +
>> +		cpu0: cpu@0 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x0>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_0>;
>> +		};
>> +
>> +		cpu1: cpu@100 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x100>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_0>;
>> +		};
>> +
>> +		cpu2: cpu@10000 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x10000>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_1>;
>> +		};
>> +
>> +		cpu3: cpu@10100 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x10100>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_1>;
>> +		};
>> +
>> +		cpu4: cpu@20000 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x20000>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_2>;
>> +		};
>> +
>> +		cpu5: cpu@20100 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x20100>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_2>;
>> +		};
>> +
>> +		cpu6: cpu@30000 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x30000>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_3>;
>> +		};
>> +
>> +		cpu7: cpu@30100 {
>> +			compatible = "arm,cortex-a78ae";
>> +			reg = <0x30100>;
>> +			device_type = "cpu";
>> +			enable-method = "psci";
>> +			next-level-cache = <&l2_3>;
>> +		};
>> +	};
>> +
>> +	firmware {
>> +		psci {
>> +			compatible = "arm,psci-1.0";
>> +			method = "smc";
>> +		};
>> +
>> +		scmi: scmi {
>> +			compatible = "arm,scmi-smc";
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			shmem = <&scmi_shbuf>;
>> +			arm,smc-id = <0xc20000fe>;
>> +			status = "okay";
>> +
>> +			clks: protocol@14 {
>> +				reg = <0x14>;
>> +				#clock-cells = <1>;
>> +			};
>> +		};
>> +	};
>> +
>> +	fss-bus {
>> +		compatible = "simple-bus";
>> +		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +
>> +		usdhc0: mmc@5b490000 {
>> +			compatible = "nxp,s32n79-usdhc";
>> +			reg = <0x5b490000 0x1000>;
>> +			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clks 0x58>, <&clks 0x50>, <&clks 0x5f>;
>> +			clock-names = "ipg", "ahb", "per";
>> +			bus-width = <8>;
>> +			status = "disabled";
>> +		};
>> +	};
>> +
>> +	pmu: pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +	};
>> +
>> +	timer: timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>> +	};
>> +};
>> --
>> 2.43.0
>>

