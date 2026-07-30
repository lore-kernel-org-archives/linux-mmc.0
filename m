Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011032.outbound.protection.outlook.com [40.93.194.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393CC3F12EC;
	Thu, 30 Jul 2026 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403165; cv=fail; b=TiEVcfqHeFuPxibxIyp8X2KTqKUlv7+vUXnOl0bV0KsysktC+EsUY2UQdk20OCMfJqHa8Yd9Vfx05ioWjp8lfNS6o6iACtC9rb3OEBgTyJjV3fgcrdpd1eIu2wzVb9Q4Ea+N9PrNYwhBAjJG1zAf04ynBK9/NzVAT9Q+8ilF6Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403165; c=relaxed/simple;
	bh=QRMqOBn73br+X9qnTRFl1mQaSH5vlcBiO+xSinP2lVQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rpsOxRhrdFvmWXJIK619OPEghe1Sk0lFj+yg6DSBp87AahN/R34CAWUu2RpJtUJyOAA6h2GE1fk/CG8wk5ycVB8GW+Fj1h/B1DCxbpyHvLWOb2NJFCasmzemWZgVYohEpxWFofLC+yCRyNU6xLkV+4W/eeFrTmHUKL7olgfuWv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g4fiUtJT; arc=fail smtp.client-ip=40.93.194.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g4fiUtJT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTXaXmDPHk9kGf5DpWk3biaUoX0kpX1q4s5xlLtIV/2WM7AXvuHp8DRIKZAtg8vzreOcZVX0RuK/+tut2/E8lJLSwrDFOqtmUnw/kW7hRFLEAXlYPnDXnUs7AZ/uOe2SzpDfJaFdxDN1sW0R8E6H83yUfXgyIEbLBYdWFp8XqoiKF82cfn817tQ2WU5e9SUfu3rcpCTA7mY9UYybkjSM6rpv8BNo6lF/80Z9aeZpw2f3SQg/lj5DRtmEVdHkytLnB6zCXcPv1WfGpz0B/zEaDXCLBba4UKTfelqCovPrTF7hXK8XU0z5gRBy5t1CfBNp3EGu2x8Z0WTbbNaTsd6a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hp64bRER9KJQAJQTaWTa0cnJoD29mRArkBM1VTxPVnU=;
 b=aNZ8sVKozNKvjizJjE57ztwFaRbNfsW8/sbHVdOjhjMb6UZzwFYV3rYp4/DaLsetzdJ7ZbwdKgzMoMdy5z1FNu79WIYS/vgaHc1V++FtX7nk7PnF0Jwa71pxMUJ3FwWcR4QYA8sx+r41GH/6YxYaeBWY1lawTmu08TF4QfBA/mWv0IdCxqXuvCtYlkockWrE7Sg6KdFapFqq1DdXcl0g90CSLGNkzudsmdZf16ZlMq+33Ed5YeqrYLNJPTtAahWTfg0itGfuJN4yiICX9IxiEe4F1QgeomHsbtz1+Rq2NZG2F6ab1dS288ua6JO/8NGwAacyghnetpDa7FR/sBc2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp64bRER9KJQAJQTaWTa0cnJoD29mRArkBM1VTxPVnU=;
 b=g4fiUtJTWxD/TR+7Fp74mxxrwFyffLwhJZxlbWob9JtGwLD2vF6531obJ2s015D7dJZ6d10uTSK+bFgVCi43v/WJmdzo1+re2vYDeoSL9n/OGH2RW9mkEf1NYnObPoniW+c0EfNI1BZpSlTadWVTo0xThh3plTj8z6Qr1yioPxjgBB9P71fCn/2FnD5hXkE0GZIBhNfc6d25Ody2Jn4ogm2Xsejtn8G7DS6oJFho7pD4gqFfObtMSbMvIUSxf3EvvbESGsVL6VtUkPTsZcN//iOJAl/wsh79YzuP4nV8qMb8rL9wUV68rFjDJY45Y/329h1t8BTCF+o+b5U9UJ5F5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.15; Thu, 30 Jul 2026 09:19:18 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 09:19:18 +0000
Message-ID: <aabd0a9c-4c95-40f0-90c6-7dd9a32a237e@nvidia.com>
Date: Thu, 30 Jul 2026 10:19:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mmc: tegra: Add Tegra238 and Tegra264 SDHCI support
To: Prathamesh Shete <pshete@nvidia.com>, ulfh@kernel.org,
 adrian.hunter@intel.com, thierry.reding@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724075700.714261-1-pshete@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260724075700.714261-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7fc50a-f181-48d9-4601-08deee1ba20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MJ0ohTSx14ojQ9VYVKlb5kJFWMqX0ZHUFfXk8ZXfCtVmGQkH5+eobxPyaIGm0vVKbfUMsQn9Fj/SvYfMJT1NBKkQ5J8Q13qX0EhuKyhJBrkCG27h0fAjxb/logJ2YTvhCmF2b0jD+MdVMx1lqNf35Fy98mmgsQr3fQbvWl9zEYDYi2rfWtRZl6ViBDjiU7ZLulN6CEzOa/1FNgxsB6DpRFX6ZaArF2TTlRnb7JXZ1giZmgojOpiGWykfDB260Q/fXTFJt1+DiNAvyjjzTPmaSCSs84M6/z+5LtBTwgpHrUYMEEKJrx/+CqB7bBDfY3zQfNijIspt82e2t/QKrjpTsYg0zi9eVFi4zx8Qq+MKUqemrAKSKItl8hQCg55s9XgWjGI0NZMamXR1E28vCOND7miEDnL2NQ4JtwJDLveDF7/nSY2Fiy4WaJt7qQJe2oJv6RY+j92Jsxk2hi1bcAx/pKiWwVIIIxqebf74aXyDrbP4sxgBmzWAmRp8zxo+Q9fEg9WxfIDEDf8JcRKOB3MTXS8h0JdqsrgcUoaiXqA1+70CtV+tyG88QpOhSXOgg07sTpI2/q69meBwiseAYZkd9lpVaDXHghYRi112YMxMB/h01DhRg7Nhw4iNfNJcOr0RoAMsdRsM2kDN68KpeRV6vnUEWVFO3r8eKMlW2qv6mtY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGFGQjgrUHhBZlRwTC9YNU1URmpjaldKZGNST3ZaT1BMZktwdnVheE14Rysv?=
 =?utf-8?B?Mkc5ZHFoOUlxNHlvdW9WK0dxcUEzbXM1UU9BUHdZYzZkZW9wSHRoMnlwWFd3?=
 =?utf-8?B?ZHZNYks0TlJoVStyZEpmQnIvUWwwTW54SnNxVXoyaU1mVmtSYytRLzZFdnFp?=
 =?utf-8?B?V3BFUEZQeGdoUVRUQjkrQng3MmYwRWtPMXFMOU9zVytWWm55SmxMdkVxVTR6?=
 =?utf-8?B?cWQ2MHZ2VE14YlM0akljZlRsbjNJMG11SE5zR0Fwa3dCUlIxTEN5VXVGR1FQ?=
 =?utf-8?B?TUp1cE5kRTBMSmU0MnMzMFJIK1lkREV5UHl2amQyRUxkMS95YXpNLzc1OVpa?=
 =?utf-8?B?Vml5WXFNNFJrcDFJUTZyWU5JdTlYREhnRGhiS1NvNXBBcFd1aXpVNmpCbkNx?=
 =?utf-8?B?NlJYVTVVTjBHNDl4dGJvYjkvNVVXT0pWQWpLR0ErQUN4eVVsNC92R3VUVzFP?=
 =?utf-8?B?eWd2Y05TczM5UnlrVE5ETCt2Y3Q4ME1iN0VObDlHYUtPRXpVUXlzN2xtRHgx?=
 =?utf-8?B?RU1XL3RjQksxczFkdVNkTXNFRkVUZ1hHQ1FhTlUxeHJycUxTUlp6VHNtQWhM?=
 =?utf-8?B?bHltUEUyTE5VN2JMNWR2ams0RzVjaW9LMk5wQmsrQk1sRnRLdk9BWXMzdS9P?=
 =?utf-8?B?Mk1Rc2trMDJhb0drRUcxL0Y0clNQNzhvekNQOWdjWlZ6M0JGektLTkJLc2o3?=
 =?utf-8?B?a2Y4UFhXeDZIUWhKa1dCRUdyQVJkZWd1ZUZrVUJZeitHUlJnNEpMQVJ1MDNV?=
 =?utf-8?B?a2dDR25wUTBmbWpTOWdCa0FNWlFQK0c5bno0d21SeDE1ZTREbFRkOEhPamMz?=
 =?utf-8?B?WTdMcm5XYVFxcGtqR3dkSXFnMnl3cnhlR0YzaURGOVRPRzY3OEF2L2YrMkpH?=
 =?utf-8?B?SjZuWFVOak9WZmpCYnFlNkxKUjlZSG9NZmg4U2xmVWxqdWs3T2xrV09xZ05z?=
 =?utf-8?B?cXJtQVBjc3haSElmKzZIdXQ1bkU3WEFucmlLaVFJNFhXb2xTbUxxQVVrZHd1?=
 =?utf-8?B?MVlwSkQ0bDhyMzhpNGcweXIvUEU0em9YUVRFS0crRkhjMys0Tmp6VUJhWXR2?=
 =?utf-8?B?cVdLS2x0bHdmT21Ja3Mwc242dFRzMXBMVUI2RlNRRzVaaFU1NlpRK0lWQU1Q?=
 =?utf-8?B?dU1FQ0p4VDhDclhJdU1zemc1STcyTW5JOUp4dWlkNFNHQlJUK0pRdXY5VXRF?=
 =?utf-8?B?Z1lNNmViclFrd0pDT1RVZXBEczBLVDZ4SHNONHFUWFE0NFFxVDA5NWZuMW1V?=
 =?utf-8?B?MzFjc0xMWjIxTndGcmRNcnV5ZXA0Y3hjTndyaWtNank3U0ljZUdRVlU5R1lM?=
 =?utf-8?B?RllSeXJEQmNsVSsxbTBTd3JmV1F2Q1FmVXRDdjA2NndTdGd4QWxyY0JHb0ZW?=
 =?utf-8?B?KzZTSTBVb0g1L3hYK1h3QXR1T2gySjVyTGNJZVViOUdNbnNtNGRnS3RhdHgz?=
 =?utf-8?B?NFFuTDNXL2J2Q2FUdHluZkZrVlIxZnJ4K1U3S1RsLzNHaitDK2VXdFFhQWFI?=
 =?utf-8?B?NXk1S2JrNEJSNlBhZXlnMmN4ZFVKRUlEY1VIUTV6WnpRc3dzaFpYNE0wdFp1?=
 =?utf-8?B?dFlvdkRKSmlOZkt2U0hFY2FRc3l1MGN0YTMzbDlMSG5iUlBMOFdCdkI0VUg5?=
 =?utf-8?B?UUk2RkhFUktnUVppd2ZJbGFKa2xRbnlwenFTTytNcEhYcXkwTkRrWUJJQ0lq?=
 =?utf-8?B?TmtXWnlVZnU2Z0FxZnRQdlRNQ2M2bHJXTlBQeHFyZFg3UWgySk15R1dDd0dp?=
 =?utf-8?B?bkxNdi9EbUFIdlNqTGQ2MkVTb2h3dHJuclYvT0tHNU03OU9rUytQeXNiamdq?=
 =?utf-8?B?OVdzTFVQT3dmOXJ1Ykx2TlYwMWgxR2JoNWcwS1B2eFhWZnErY0gyUFdEdUNw?=
 =?utf-8?B?Sm1KWTUzd1ZPRlpiWXRlZjB2Qkd4N3lrd2tnRFRNTFdycFBtQisrV3RLSmds?=
 =?utf-8?B?LzI2ekVyaWdONmRZbUR0ZDUwL0I0ZXR4VTZlTlBIUGp6alRUbTFhUGhFWmdR?=
 =?utf-8?B?dEJRNmFwRHQrb21xYXhUVERMRi9FRXpNZFZJOExtaFFSMGZtcmNLT1B0RU9U?=
 =?utf-8?B?RlRQV2hldXpxNTk2b0FGQ2d0M0JkZURHVVNtZ3BMb3JDanZqSjFwK1pNUGxN?=
 =?utf-8?B?MUNacFNIVWNOaEszYXFwWktrbXR1amdkbEh3QUxzRStpb01KT1F1UmIremsw?=
 =?utf-8?B?UlJTMHcxaFJvQUJoNDhOVUdJbDB1cE8wT0FORy80d0FhdytiaXluRjdDdkJn?=
 =?utf-8?B?MHhkWVdvNnFHUWlJVDFwN1JmbGw3VktGMmdnVXlCOEJDVE9LSlEvWjhPMytp?=
 =?utf-8?B?MytHRW54akxsSTZkL24xbngyY1hTYkFueVJiRWtkRS9jNGk3NDY0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7fc50a-f181-48d9-4601-08deee1ba20b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 09:19:18.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVYGnlZ2L3V2K1fVAyUAPcgVm4VLZEwxgW3H3FfxCzTdKWKZEK9nL6hrVyutjklB3FaO2o6OnDH3kiHzdx5zQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249


On 24/07/2026 08:56, Prathamesh Shete wrote:
> Add SDHCI support for the Tegra238 and Tegra264 SoCs.
> 
> The series documents the compatible strings and adds the corresponding
> SoC data. It also adds the Tegra264 SDMMC1 device tree node.
> 
> Prathamesh Shete (5):
>    dt-bindings: mmc: tegra: Document Tegra238 SDHCI
>    mmc: sdhci-tegra: Add Tegra238 SoC data
>    dt-bindings: mmc: tegra: Document Tegra264 SDHCI
>    mmc: sdhci-tegra: Add Tegra264 SoC data
>    arm64: tegra: Add Tegra264 SDMMC1 device tree node
> 
>   .../bindings/mmc/nvidia,tegra20-sdhci.yaml    |  6 ++++
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 34 +++++++++++++++++++
>   drivers/mmc/host/sdhci-tegra.c                | 30 ++++++++++++++++
>   3 files changed, 70 insertions(+)
> 

For the series ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

