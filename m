Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2044.outbound.protection.outlook.com [40.92.103.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6984C62;
	Tue, 18 Jun 2024 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669060; cv=fail; b=NcHsGz++Gzb0lyXoDKWWIMb4OR8rhkUvTJcsgTkYmxAZolJXTgiJJ4fX5UfRSyhsi3G6c/TEm4dTOEiofsIzUKH5QMH8OGLP0gwljzZ2mYGeOqTWmwC5/RlFrYd/PZFS8X6O82QoYLetCG/ladeyIePK6Tf7NrlCT3blK9qwnRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669060; c=relaxed/simple;
	bh=2dcqsb8oibbolJ5MIKdae0OjvYSjR/JfH/YgTnTVpUo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TtLhWqNlFl5jel3o++GmvXvlI9KTmCmvZbMxyPG8lizrMS47YkZUq++y1o57mN3idjD2r6AdFAiKDjZeogUXhZwdhVX58T+7UKgytgRB3goJ/ZiEgIP78D4zqtmTi1xXmbloGpI0n/lwzOd3LnII3kGQxYBBtS4xWt3Luje950w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=InANSOny; arc=fail smtp.client-ip=40.92.103.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="InANSOny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNZAOVjgfWiny/8F8L/dZRaml0f+VSVjsvh5nmcKSyklloq45/a5t5eF4E6TSD7ulc7nrbOiYvVVNygmiwQSzfuLO+lCvuCMCT0zJpyXWoZOA8KYbl22QA2Xt43pbf59068CvwJue/KxE1ETy4yGxPdJ2IPXk5Vguy1ZFLpnEkV9Jv4rRbIrAcdzSN/JDWhhxYWZzuGgIU0pg98G7i/Hm2z8f+kxWL4uuScg1HYwJJ3b79TOaoerzOvSRTM7HyqHkpB/LdZifw4kUq3wcBJi6YNAitoc/nMxIsDzs8j4AU8QuMfQ2Du71X8dFjzZKkNSKyL5VnGs635NTTsllF54cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/EBUoTi5iXWDu0HcnbGN3aZeNIUU5V2BEkoMQYsQkM=;
 b=boDbErSKKnGrqUPv3mRsZXc5zoTk/dy2LRCg7LbGOHHW5HLjtskBEER47ybM3v9s344xvBcDySLgKgjJOnZtei+HlD7CUBrx9HxiQDECpFBhxOdEqZC8XgBtQw/e4cr3o0hEvMKyfnQHBJhAZQ45wxmFSSnGChi2FoculUH77aMDn1c2ZaYhzHjM65qtSoI7kBRczUgJKq6w1u5ghek4vOal2ZPTIr0G4040rYVLaVLuVy77G0kr3ivIYbmeUL1t+cY7yGRigRGgj/JEYcrOOSo92P3ru5pR3nJTaNFbSNpaY8jJMy/xFtJKQvBds/3/C1QDRZbdVqaetgkTDfPrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/EBUoTi5iXWDu0HcnbGN3aZeNIUU5V2BEkoMQYsQkM=;
 b=InANSOnyeT5sxpDokxFiOtqLAYJO6fyNczxeAcrXaLZ/pB6wWgBMyp4kJkfUxutCKiuwlbU/vmBvGg+wz7Tb6PBtPjlsXDNms0hcxI/kokczrMg6j9PNOp+omIZI7CV2i67lKVqWuHSLe1gl9xLDMm3SETeP3bGzQU7FlPF97uJb3Mwh83DXk3gnCe1abhYVBqaexR9aB6hbELtggHCa3z0iU+Q4q0YU9cnckKSga0oecvTrm6+PWuciO3pRJzrH1j/iC0hYhh/tJ25+0Yfdq4wFkN9hE5Tr5wOVQtxF4+uCtWkAmNpgsvHlXIWGoZ1HdU8AtZClw0iFQXvZ8okziA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1497.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 00:04:10 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 00:04:10 +0000
Message-ID:
 <MA0P287MB2822D6EF7DE3C129AD6FF3B5FECE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 18 Jun 2024 08:04:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mmc: sdhci-of-dwcmshc: extract init function for
 rk35xx/th1520
To: Adrian Hunter <adrian.hunter@intel.com>, Chen Wang <unicornxw@gmail.com>,
 aou@eecs.berkeley.edu, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, jszhang@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 tingzhu.wang@sophgo.com
References: <cover.1718241495.git.unicorn_wang@outlook.com>
 <459e341a32128ffbae5acdc77a1c835cbee582e6.1718241495.git.unicorn_wang@outlook.com>
 <9490cba1-1fa3-4a00-bab8-aa4a07a418f5@intel.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <9490cba1-1fa3-4a00-bab8-aa4a07a418f5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [hae/UeTGfWQmA1WyDac68PLmvO5tzwLK]
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <2e25a599-dcfe-4bf7-89cd-0434c260da61@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e78abc4-456c-4a59-41cf-08dc8f2a2cfe
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199025|440099025|3412199022;
X-Microsoft-Antispam-Message-Info:
	vgMOhQqCjJ43spavUqPAKob65+Z5+7gDJrIRdCjQalo++E+7dlVNqcCu4BRnUjKGLv8mg9MYnOB2PeFFPMh1FJ1y6OTGjwOTBYTHcqJlW19oMb6G97SaGuU4KneWogG/jDIfxXsYO9nzdtXCNW8HCgpfgNfWIXVfdd2w0eYy8hh9gbb5fgA/+t7Znp1A4WzfSbNKw6q9Wlnr8lT9+FS/TVS0OuvVyE+zaGdb1BFsTY/nbfpOVLi4vur0Et/a+pU6RpbrWRRBSVbfQ5b2uJ9R7Idp9AAxvcawaIUho+LT7NnT2Sk0DEvqbUagao0fwKaRUCRuE7G1EUMgeb6t+OxjXSHMx0eoXYzC5Dwd8fQXfPp0aaJckeA8CC1IfslZsW9KxEUGPlYFloxJBvehWd79OTmpweafgZ2ZBU/7MyHNKadqZ+D7JuPAApWwEEioylKco+VlLHAKm3ppM19XJZkwklxDbP1100Nn4hibYM338fGUnBvdssfbm9FbySvw6kv5dM3Hd57SGDxTS5oYN4Q8BDCz+56uthghrgYzuzet+LRmBtLkX9ubJ1ovVRwQG/tq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUF1REN3SmR4NE1IZUpITjZhdzhKTVhwNXlNRm1hUldsRE5zQWdNYi9pMGQz?=
 =?utf-8?B?dVpuNzJDb1dOSHdidUh0M1ZzazlwSUNxREVSNm00VUhaL2ZjM0JkK0t1bHJ5?=
 =?utf-8?B?WVZiSXVVLzhPTk9nekxoakdWdmFIanVaRGp3MFF4Z1FTTTVLR1lEYXcvMDZS?=
 =?utf-8?B?QjAvYjFCWVptUEJEekRpdUgxM2prK3p5UGNYeHNmL01WOGtpKzcvdVIySVhm?=
 =?utf-8?B?THhyWWl0SXQ4V0xWcnRJTVlFMkxlaGF2aVFJUW5DRmp0M25iR01NeWIrZ2JS?=
 =?utf-8?B?UzlGV3M4T1Ryckt4RE9sTm5DelRST2J2ait4V1JSeGVYbTFrUGFLUlN6NXY5?=
 =?utf-8?B?OGN1T3ZZYXNJOW0xb3FiM0wyQ1Nhbys0RGJycFd2ZTBxV3QvY0xqRit5NGZ0?=
 =?utf-8?B?a3NWU05IS2tlcXpJQUFDay9qOWZMOGpaQjl4Q1Q0WXJFb3RnZFFNbE93ek5B?=
 =?utf-8?B?YUdYU0FrZnhmalNiQ29oVFhzeVpRQnBVUndpeENuMnVWSjZ0V1lWdkwzcytE?=
 =?utf-8?B?akkxWTZhN1pkdkdpY1ZXSk5zTWRXWVpvME5aSllBMDRmUFJsOVBucm1rWjQ5?=
 =?utf-8?B?aVNCdzNLTlQzZTcxa011UjBLc2NEQ0NrTXlnL0ZNUU85V1RrKzk4NzdSL25Q?=
 =?utf-8?B?OFVPUlNrRlRVanJhbDh2Uy83cUJHM242eURCTXBMMDRXUGx4dTFBd0JUSVU0?=
 =?utf-8?B?aW1DWCtKRjZKdXBYeFJPRFdjRkxLT0dSWEN0a21zWHN3UnZvbzRvbk1SVG1Z?=
 =?utf-8?B?VnZXMFlLVkFrUnZMV1hzRFJ1SmZZNUJJVlV0KzNqZVVSRU16VTFxTHhnd0wz?=
 =?utf-8?B?T1hUZ1VDczFXL1IwNUwwMk50bm5vQ1NaK202Sk1PbTVaTzB4OG9pWVRUZG4x?=
 =?utf-8?B?R1dYKzF1S2JXV1BLRVdTRGU4YitpYVR6dS90Q0M3NWNmQitsV2l2d3Y0R0hK?=
 =?utf-8?B?ZHNGNEsxVDhaUnAxYkJ2WEdmZWxZbkFMVnlGL1d3bnNGWk9BdlNQbjI1ZGMr?=
 =?utf-8?B?bkhPQWpydVhCeDBjeGVvdjdOcXo0VGpzOFdNNlozektzQTJxSmp0NVBGYTRo?=
 =?utf-8?B?bVBvUit2UjdyaGlkNkwrc2hFY1YrclRPZ2NZTktkaWg4aHlkalQ3cEV5dWor?=
 =?utf-8?B?TlhrM1dYbTRyUjY0S3JpZEIyVWFSQjNZWklRWGdjN2RtZGk4T08wd2ZNMGpI?=
 =?utf-8?B?alVLTDI3RG9EM1Fjdk1EeVQxTHpZL01ZTzFkUkpLWkM2eXE1dVJ5eCtMUzBz?=
 =?utf-8?B?UXFrMW5nTmxYcmY1Zm5WUjRCOUdOVXF5SFpYMGtvTFdGaU14VEpOZUNZN3hu?=
 =?utf-8?B?NWxXMG9VT08yK0pHV00wdG1ZNW0vRGIyM09Ca0ZIZi9FdkF6TDJNSy9oa092?=
 =?utf-8?B?RTVSWHdqQlVST3liK3JQWVNQdE42VCtuMDV1T3VZYmZTVnd6ZzF5Z25QNmZa?=
 =?utf-8?B?QytzTmpUa0MwdDdhanl5bitVWjNmVE1ZeGsrSXRCS2t1ZVNnc09RZ3p3V3RP?=
 =?utf-8?B?QWx1TWtKcDNpQUR4Ty92djNrazVGbW5pTXFiZlJnREdROHFrdXhreUwyL1BI?=
 =?utf-8?B?eGI2c0IxTXBqdWg4UDlxdlBkMUJueGRHaURNc3JpMVpVSmw2REVTZXViQU10?=
 =?utf-8?B?dDhuTEpIcFNKR2RtSzl2VXZIN1VRSXhHN3dSQ1BCVkxmUGpjbXdYOGxaUFp0?=
 =?utf-8?Q?ARbzAH6ZBPI1/XKdD8/i?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e78abc4-456c-4a59-41cf-08dc8f2a2cfe
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:04:09.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1497


On 2024/6/14 18:33, Adrian Hunter wrote:
> On 13/06/24 04:43, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
[......]
>>
>>
>>   static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>>   {
>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -1230,46 +1270,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>   	host->mmc_host_ops.execute_tuning = dwcmshc_execute_tuning;
>>   
>>   	if (pltfm_data == &sdhci_dwcmshc_rk35xx_pdata) {
>> -		rk_priv = devm_kzalloc(&pdev->dev, sizeof(struct rk35xx_priv), GFP_KERNEL);
>> -		if (!rk_priv) {
>> -			err = -ENOMEM;
>> -			goto err_clk;
>> -		}
>> -
>> -		if (of_device_is_compatible(pdev->dev.of_node, "rockchip,rk3588-dwcmshc"))
>> -			rk_priv->devtype = DWCMSHC_RK3588;
>> -		else
>> -			rk_priv->devtype = DWCMSHC_RK3568;
>> -
>> -		priv->priv = rk_priv;
>> -
>> -		err = rk35xx_init(host, priv);
>> +		err = rk35xx_init(&pdev->dev, host, priv);
> rk_priv is used further on, but it is not assigned anymore.

You are right. It seems unnecessary to provide this patch separately 
just to extract the init function, and it also violates the principle of 
atomicity of patch modification. I will merge this patch with the next one.

[......]

