Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93E366067;
	Thu, 21 May 2026 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385290; cv=fail; b=ZKwFASgxrJK3Bk/51au/L4y8meC3XMbpVime7GQgFKmkgYi1ttfgSnukFATHK+nN4I3CupdvKJOC6TzVOXk8Uqyg1A8rlEFcLonBp+188EXCvOnrIIBV7shBftwxn6aJMyw/bv0v2LAo4pymtCcilrSJNnDv14MALtUAlFPBy+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385290; c=relaxed/simple;
	bh=pQjHgyQ0Jlg1D6prb7a37f25dfc8qAlaj+zJoa0wEb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgDmNqIyoGWwK1zio8BQAh2DGu5ePPRpN10+0MkUNbJBfnVhXVz1dVWodtU7yTuizwGU9vt2ygM9wNKQOuNJvtKY9Jog4AIGZK7LqfXW1JD71b1iIazV84hnnHSslCTyyzzjwWrahSB7/8/y5q+NnJGCZQQA92rSxh/HEAUzwmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cxr81Lzs; arc=fail smtp.client-ip=52.101.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cxr81Lzs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TarUTUS/bHnKTWBFG/x5aqbSTqphLoudVHvx/+f2b4WLaQb0E9n1LfVFE5u18kaKGBbgiipgrO26FusumsC00ILrf8FHEGOHM8VoUsignusLlGQBrvAYmqx6c/mns9kBrJxRObGvIJehE02xB64/1FUzUfll2QUlhtMSscAzF6rCkpXl/Y3lrlXuH2MpR/Ve1Xk4QjtKtVnleQQl+5/59icFz6iip8mqDo1gjBLysa/OwyMVq9eRWjVTw/9v5Ox98yLG3Z6O+Y92iWU/vI1evmz7CE/Wfak23miTKfGeDL7qeS6MHdw9FrZA9UOSU2RxaW89WPdnjrjZS+uVqgZdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JQRHwM+KFAJkX3jmJHFnhLjo5c6O5EX25/PByETUNE=;
 b=JicYcBx17835/pBPGl6j69S/TzTs8mcX6bLzdstWX8qpQKc0RqKKTsJ8/FtrSIHq9QnrSkmovnb5GDYbP32661Zixq6s1Gp2fDoG8Lr28+h/XEQXttHZgJZmWqXzss221R3rq6OyQ9TWoknD6MZFWw0L5X2Xz1IpzkYXiRUj5E6g0rPCneIOTHP2LW00jiIdpHY7r5th1Nj/ylbYVrkgWBHG1+KgZbWHVjn/FaUh9BJDwxXUmdFlCv6I/h/2cgzXEoN/37+d9difHx8/cFIff8erCrS1Wo1RH6y4XKc6J6VtiPo0uqCCM/g3KqLAl4GxWlSFbNehxeJdk/Z526MBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JQRHwM+KFAJkX3jmJHFnhLjo5c6O5EX25/PByETUNE=;
 b=cxr81LzsbgGH/EyZjH3kAabY0NUDK0ppY83ga/h4a7g24ZZGPnB8Ag0DkeSUC2R71Hs9+LSsrMc8McR/XlTD9ILjQ2uW0OjSb6yv3sOayYoP36KSuaa+Qu4aOeRmz2Yv1r6lefe2aXPqDWYS7bPzyuWwUmO4hCLQOhgzJqoJu5RS8cd+BrVru2ZzJtQwPY9+Uti0ncBdVfSVQ3rxOTAwoXCQrb5h80ODIISlZsv7jOUCv8ihodFqAQeTKngy/AVxcrye+2reFl4tWcaABlYFaKJiBg8jY9MapSpxUOA8Gbo7F/taPKdqBxze0KGtB6G1sq7uZym0kFbYCncr9Nsi4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS7PR03MB5608.namprd03.prod.outlook.com (2603:10b6:5:2c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 17:41:25 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:41:25 +0000
Message-ID: <45ef3689-6106-4fff-9f64-cd471c3564fa@altera.com>
Date: Thu, 21 May 2026 23:11:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] mmc: sdhci-cadence: refactor driver structure for
 V6 controller support
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-8-tanmay.kathpalia@altera.com>
 <a02576b9-4068-4686-b59b-71cecd319f39@intel.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <a02576b9-4068-4686-b59b-71cecd319f39@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS7PR03MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: f9046435-b7d8-4502-7074-08deb7602cf7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|4143699003|22082099003|56012099003|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	VUBdE9p7fDs1+Yjv9oQS/BllmzrTN3zitJZkXL4cVQliPXMqJyd5fHnhu3LpjT/HKG4MUUv1aBnLp08vezIrUCw8oEG9vPMnVijNxbY6iz8S0LImCFBOT7tCHn780ijbTrXmG+ZEFJaYOxHadeIPutoHt+o2FPSBwBhSe/hu/JvDSUVesVuuvs6ISBWiZ2Oxak+h7s7EzizeA6M2YrjZBBQre+9RHXgBfJhAlo9e6MCb7KEm+Wpsge9r3DHrBh+jgapnquSgRAsV0aViG/aGEbhyVFISfarqRYSvuaYYAwGHF1z68nvhGWkIAXIvr3hTxnCp12PZ3emzjXlMinOB8eVow1HNWRdfxicFy989pfeAwnjCUmXg9nfxdj97H/hsaoqMApiRUmtUaaVip10WtiwWez5bkJO04GUw+rzv88ezV9K5qLjhBLKz/i9qmiNctOjPQNKfNFLQXVOjlmIUSg0kLFLl/2fc1jNLbCuObZAQ8dNpiSDZvdJ0i0kl5XB0tNMujGXk3S9PNdYg/tpC3Ezq840DlHrOWb2Taaoi0/wJIamQHClrxp0SiYF9M9y2KJIjhDs+qctPrTH7Ucad+RwP331u5cRMGKD+0Q93tDq1ryMG/T4h9d6QpT4NXrcY7reTp0d2Ja1FyWAUY93Zq2s7JZACgLgn6DAjDfR0EcN6M9secP2LK/9NlYEtz4+7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(22082099003)(56012099003)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWdXTlM0NGVQZEx0L3UwM09NUjN2WCtkMjdaSko2NnI3aHNzQ3BaVWdjanRN?=
 =?utf-8?B?VWhBZG5TSEg1NDFzS1FXZ1VqNHZQUThTc3ZkY0NRbnpIT09HNU1FUS9XcnZO?=
 =?utf-8?B?Z1V5V0Y5K1Q5cExBUEs3M0xJSk5SRHFVQ2JWUzFkV3BDcjhYaHRvTTN0dlJZ?=
 =?utf-8?B?dnd2a21BTWV5STdERytqUzBQVmRVOG90MTJZWHNFR0NxNTRpc2pjcndBc25n?=
 =?utf-8?B?MTRGT0FrSmRodzY3OXhFQmptVFR5QXpwRXR5VVA5czIwZkFKWStTbU4vRzF2?=
 =?utf-8?B?ZllpWnl5STMwMmpqU1ppSUJrRG83ZTdxdGJVVVhTU2x6VmhwRGhnOWJLbFor?=
 =?utf-8?B?YWNyejdaWTd3aDE4dDlOTElqYVphNTltTUwzUW9Ra3V4b0xTQWpycmdUUVBs?=
 =?utf-8?B?NVNNSjBVTmF2NThZSmFqUXluUURlWjh5RU9qSmJCdlBiWUFaZmtURFQyV0Qw?=
 =?utf-8?B?ZzVWbkRyS1o3RTV2ZTQrYm9KUTVDVGJLbzFmZWRyZ0RyaFpsY01tNG9TOWRw?=
 =?utf-8?B?SDN6UGYrV0Y0YjRhMG1ab2VwZytGMUF4OVdKNnk1cGFvcUlYSG53dTFPWDR6?=
 =?utf-8?B?dmFQNzVOZEFzM1RXSC9ybWZncExDVDRlTWdJYnU2TGdqV1F6bTVCTE4wcGM5?=
 =?utf-8?B?N1NVSWZ5dFpXSzVjOG9vR0kwZUZXdDFIYyswN0hwcC9tb0t0RXMrY082NDJR?=
 =?utf-8?B?cXZBNHB0T0hzL1h4WDg0ejZvRi9XelN0WGR4MHFxMXNsYmxrSVVnOGd2bXQv?=
 =?utf-8?B?MGZkWENnemdwUXVMNUNXTHVUSnpqVmNxOE5CcGYvUk1KRngzQlphVWsrR2hq?=
 =?utf-8?B?YXZEUXZDaENCbythMHQvSktLRjQ0SlRoL0RKcGVHL1lVNksyYWZaa2lZbnVH?=
 =?utf-8?B?WStUT05QeGJSQW1DcVhOYnhGSTU3N2JQQ1lDcGk0YlFCbWRUKyt3eklSRWd6?=
 =?utf-8?B?L0R6ZXowM3ZNOGRUbmZwaVV6WWZld1R2N24wUDViQ1NzQTJtbzVlNzJCVXNp?=
 =?utf-8?B?emZQS2lUaUdGdVloR3UrNHdxYUozQjhHYzJIM00xRm1qMDU5akNkdmYzYlp2?=
 =?utf-8?B?Q0tEMXhIN2Fjd25YbUhTbzlXTWlhSzlKOWdHRXRwVmhzZjAzZ216OXI2Zzg3?=
 =?utf-8?B?dVNnK1pZMFgycDlQejhwM3hpM0JxQTBQUElzU2ZkUjFWWUltRVFhSEp4Mk5W?=
 =?utf-8?B?dGQyaG04ejNIZ0s5anRRa1l1Q0NMWHpqRVQ0RHRsL0gvMHF1R3lxYmZxTTY3?=
 =?utf-8?B?ZE1RY0U2SW1PSDdjUGRJUlYrSHBHV01vUDVoT2tLNjdQYW05enBKQ3dYeUV1?=
 =?utf-8?B?M1RudmkyK2hDOGNkaHhCN0pMV0N5c1M2cG55Y3RMMnFDMHpBT2pzVFJ2bGhV?=
 =?utf-8?B?a2Z4NGM1L09HZXFVQzNIVTdPVGNtU2ROTXYvNkY0WEg2ZDVRalFqT3ZaTXFt?=
 =?utf-8?B?emRjV1JHU3dsWHRaRVFHTGFmSi9PTVU1SWovRTI5Tm1SeUlGaGVjdEFVS0w2?=
 =?utf-8?B?Y3pObGZzeVdwN2pUcGdRTHdYM3RSMkM3SHNVRkcvYnNIdHRoWWVvcTVLMkUz?=
 =?utf-8?B?M1RySUNMUi9hV3MzZ1ZqK0hid29iS1ZKeEs5OTlvS1ljQU04M1JYVmN4UWpx?=
 =?utf-8?B?NlBTdTRwVnJxZ1h3VS9vT0paMGU4WlVOOEJTcEJnTk5xUEZtTGVIRVBrdDND?=
 =?utf-8?B?TDhKR0lWd1R3cHpNS0RyS3U3SWliTlBzUHlhS2xJUTZxSHVHN0drdjBMZUxB?=
 =?utf-8?B?cTBHaWJLRUltaXM4Z2ttYjFqalN6cmhFY1RrLy8rZVUvaDZqL0M2N2tXK001?=
 =?utf-8?B?Y0xyK3hpSFQwSDhJeFRrekQzSUtWdjl5MXplL3l2UlI4NGhBaWNKWXRwSjZv?=
 =?utf-8?B?VTRzRHlWNjJTSU5ZSnloMWp2dGh1VTJ4V1lXUjFSQ0xXenpKbVdFTFhNQ1BK?=
 =?utf-8?B?TmNua0xrSHQvQW55Qk54WE1rS08rQVpZQVkxQk9kYkM4SU5kUzB2QmFqMzdl?=
 =?utf-8?B?cUFMNkxQWkZJQUJSM3BtaG5TUXFHaXZkMTdnays2MStBd2toUjBzS2VlNzEy?=
 =?utf-8?B?aEFXMFVsVXZ4Ny9Rdmh6dDhqVmc0NlFKQlIzMDNsWTVXQVpTODRhQzh4cEZw?=
 =?utf-8?B?Q01kSC9YUldHSzlER0U3Vnhnb1FmVEJUYUNCQ0c3a1d0Q25oeG15NXczU2pX?=
 =?utf-8?B?WWEyRXdsTk5hZ3BxT2htMHpzYkZmTURDY1pKVVhtVWJ6bnFJYkhwUEEyRmdm?=
 =?utf-8?B?RDVQSkxTenE2UXFlODZ2a2RrMUY4VXoxeFNPa3VsQjdrbTlOUlhpVFp0alJJ?=
 =?utf-8?B?QWRobWxYbFZIRC9zWW5IbUtxKzNESUhXVDF4T0trcUw5TjlIdUhORE9sUm5L?=
 =?utf-8?Q?znJR7A1MtQ5prgf4=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9046435-b7d8-4502-7074-08deb7602cf7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:41:25.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcAkfpquQenbN8HjrAg1WZ0cGgHmSBrhCMWx6bM8YmDr1OoCl9w9+CcDhSVbWA2jQxi9x3suGdvVy2RxkzCwWx0UNmop1scsyyxCjru2ohA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5608

Hi Adrian,

Thanks for your feedback. I will fix all of the below in v2.

On 5/19/2026 8:59 PM, Adrian Hunter wrote:
> On 11/05/2026 23:21, Tanmay Kathpalia wrote:
>> Refactor the sdhci-cadence driver in preparation for adding SD6HC
>> (V6 controller) support. Separate PHY parameter handling into a
>> dedicated sdhci_cdns4_phy structure and move PHY initialization
>> logic into a dedicated sdhci_cdns4_phy_probe() function. This
>> allows different controller versions to manage their PHY
>> configurations independently while keeping shared logic in the
>> main driver.
>>
>> Each compatible entry now carries its own driver data, so drop the
>> silent fallback to sdhci_cdns4_drv_data and return an error if
>> platform data is missing.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> A few minor style comments below
>
>> ---
>>   drivers/mmc/host/sdhci-cadence.c | 57 ++++++++++++++++++++++----------
>>   1 file changed, 40 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>> index 47690a52a221..fe3f7c5109fc 100644
>> --- a/drivers/mmc/host/sdhci-cadence.c
>> +++ b/drivers/mmc/host/sdhci-cadence.c
>> @@ -83,6 +83,11 @@ struct sdhci_cdns4_phy_param {
>>   	u8 data;
>>   };
>>   
>> +struct sdhci_cdns4_phy {
>> +	unsigned int nr_phy_params;
>> +	struct sdhci_cdns4_phy_param phy_params[];
>> +};
>> +
>>   struct sdhci_cdns_priv {
>>   	void __iomem *hrs_addr;
>>   	void __iomem *ctl_addr;	/* write control */
>> @@ -90,8 +95,7 @@ struct sdhci_cdns_priv {
>>   	bool enhanced_strobe;
>>   	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>>   	struct reset_control *rst_hw;
>> -	unsigned int nr_phy_params;
>> -	struct sdhci_cdns4_phy_param phy_params[];
>> +	struct sdhci_cdns4_phy *phy;
>>   };
>>   
>>   struct sdhci_cdns4_phy_cfg {
>> @@ -169,9 +173,9 @@ static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
>>   }
>>   
>>   static void sdhci_cdns4_phy_param_parse(struct device_node *np,
>> -					struct sdhci_cdns_priv *priv)
>> +					struct sdhci_cdns4_phy *phy)
>>   {
>> -	struct sdhci_cdns4_phy_param *p = priv->phy_params;
>> +	struct sdhci_cdns4_phy_param *p = phy->phy_params;
>>   	u32 val;
>>   	int ret, i;
>>   
>> @@ -190,10 +194,11 @@ static void sdhci_cdns4_phy_param_parse(struct device_node *np,
>>   static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>>   {
>>   	int ret, i;
>> +	struct sdhci_cdns4_phy *phy = priv->phy;
> Nicer to place locals in reverse order of line length e.g.
>
> +	struct sdhci_cdns4_phy *phy = priv->phy;
> 	int ret, i;
>
>>   
>> -	for (i = 0; i < priv->nr_phy_params; i++) {
>> -		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
>> -						priv->phy_params[i].data);
>> +	for (i = 0; i < phy->nr_phy_params; i++) {
>> +		ret = sdhci_cdns4_write_phy_reg(priv, phy->phy_params[i].addr,
>> +						phy->phy_params[i].data);
>>   		if (ret)
>>   			return ret;
>>   	}
>> @@ -542,6 +547,26 @@ static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
>>   	usleep_range(300, 1000);
>>   }
>>   
>> +static int sdhci_cdns4_phy_probe(struct platform_device *pdev,
>> +				 struct sdhci_cdns_priv *priv)
> Please wrap after 100 columns not 80
>
>> +{
>> +	unsigned int nr_phy_params;
>> +	struct sdhci_cdns4_phy *phy;
>> +	struct device *dev = &pdev->dev;
> Nicer to place locals in reverse order of line length e.g.
>
> +	struct device *dev = &pdev->dev;
> +	struct sdhci_cdns4_phy *phy;
> +	unsigned int nr_phy_params;
>
>> +
>> +	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
>> +	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
>> +			   GFP_KERNEL);
> Please wrap after 100 columns not 80
>
>> +	if (!phy)
>> +		return -ENOMEM;
>> +
>> +	phy->nr_phy_params = nr_phy_params;
>> +	sdhci_cdns4_phy_param_parse(dev->of_node, phy);
>> +	priv->phy = phy;
>> +
>> +	return sdhci_cdns4_phy_init(priv);
>> +}
>> +
>>   static int sdhci_cdns_probe(struct platform_device *pdev)
>>   {
>>   	struct sdhci_host *host;
>> @@ -549,7 +574,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>   	struct sdhci_pltfm_host *pltfm_host;
>>   	struct sdhci_cdns_priv *priv;
>>   	struct clk *clk;
>> -	unsigned int nr_phy_params;
>>   	int ret;
>>   	struct device *dev = &pdev->dev;
>>   	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
>> @@ -560,11 +584,10 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>   
>>   	data = of_device_get_match_data(dev);
>>   	if (!data)
>> -		data = &sdhci_cdns4_drv_data;
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "missing platform driver data\n");
> Please wrap after 100 columns not 80
>
>>   
>> -	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
>> -	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>> -				struct_size(priv, phy_params, nr_phy_params));
>> +	host = sdhci_pltfm_init(pdev, &data->pltfm_data, sizeof(*priv));
>>   	if (IS_ERR(host))
>>   		return PTR_ERR(host);
>>   
>> @@ -572,7 +595,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>   	pltfm_host->clk = clk;
>>   
>>   	priv = sdhci_pltfm_priv(pltfm_host);
>> -	priv->nr_phy_params = nr_phy_params;
>>   	priv->hrs_addr = host->ioaddr;
>>   	priv->enhanced_strobe = false;
>>   	priv->priv_writel = cdns_writel;
>> @@ -593,9 +615,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
>> -
>> -	ret = sdhci_cdns4_phy_init(priv);
>> +	ret = sdhci_cdns4_phy_probe(pdev, priv);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -653,7 +673,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
>>   		.compatible = "mobileye,eyeq-sd4hc",
>>   		.data = &sdhci_eyeq_drv_data,
>>   	},
>> -	{ .compatible = "cdns,sd4hc" },
>> +	{
>> +		.compatible = "cdns,sd4hc",
>> +		.data = &sdhci_cdns4_drv_data,
>> +	},
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
