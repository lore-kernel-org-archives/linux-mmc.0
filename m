Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2026.outbound.protection.outlook.com [40.92.103.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E142071;
	Mon,  5 Aug 2024 02:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826445; cv=fail; b=j48qc+08XMeBwIpP8r9wTcaKDSdbP8W/rqpb1UEFXKIKpwTiT5zB1R/T2eW7RUjqpDSAS0COoDAqU5APWGML5qOd6HbuXL42nNL3MwCDiQEHkmi662xsDGPFtZJys29LvY2lj5y/ad/E2SV6IP4Q1Q+HcrJNph3Yf6Ww3dLq7WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826445; c=relaxed/simple;
	bh=JlCsl8XFMDB5tIkWs2zjFPMdN5JbxB+exkTDNRYTTd0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E6xRApqHVU5aJSgP8kvtiCYJpd8cif864PAdWr94If/MIlrhx8gwi6vnFgLJO0j5l3qdecgbW+JK5SMBJbsXQBt0zhQd3nM6taC4RnWJ1QqMJ0DZ1IAZlHA0AbgOq5smdLS98eJcfZ8T8+ncZaW4HZnCFRunv2m4+9br85PRIWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ergNx+bt; arc=fail smtp.client-ip=40.92.103.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ergNx+bt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGNNoC1imts+HhYNmSY8VQT2Ir9CH6aLqhJ3MbXHnDA4GUgKuL71WNmZZb2gMT6dFlUvf6jzDqvaKTM514Q1cOuJrCxX8X26MUX9CQzq1fWMIudfw+iUCox/06j+XROfVSDALtNJrr/lDyxlwAIJQJzllcfK4AcAN7r48Ar5DkZ/OcMw49kl0Qhf18a4eHWhArlNzg12BJh2sbwJpfXrtaJ3tMX3MfjP5yDGWxtZ0qFL+wLwfR5lifTJNlvgd0fbRCMD1YbbjJze88x9QWYgSUALesqCCVGBYBb0Fbvx/tsbw78kHt1ttmaeZ1CdyI8zG9/RrYGSN14Wm3bld7puBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHgECP8hWEFZ61d8LTTK4XCLUZID+fssB4xbIjb+ImM=;
 b=S2llFy4xND37duHieviPbn4sBkyHK6b9jHmkUnEqDivi52cFYuTFQKc/shdornJrOLnGNn0M/cQsdrViu2C3+cRg6gDlpLkxFtM+FOdvSVq8o+QpjfCOzFcdUXJC88QFYe35NCu5K9XhKFfQ2wV06UxAa6B44yeWsS3B97DZNWJhXv0JuA5X4OsDvDjIb8l4+iv4dY3hh7PTFD/KJ6qtBhC9DRk7vcTGUJeb8AYuduYB/7wxh3NpHltLJz4b2MWB857g8IyCOmzenYUtQ0QzfEaFv/S9bzSvQmTKFaclemB8ieoVNaQF7R9lTQROdXdjfe1xwkU8JNbkc2IgSYGjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHgECP8hWEFZ61d8LTTK4XCLUZID+fssB4xbIjb+ImM=;
 b=ergNx+btQOm8uyaDhBEU5W2RNTo8YRcf6Pt+4zSo+qLYSFszRHK7OeRl8CyegJVylwHRA0JOZupxhh//4dDNelqG1gdmL6X1bZ8DDuNWVDXg3l+vIuz1XnW2Sbl9ekIZfl4usPuMEre2RqxeC+gnGZ+Z8Ho77gT3/kRawIbIm9jI9J4/bPbC+UTH++lesjWs5pG5ClUgol5+5Yn5LS9lzSQMvvj/Hy6yvvCmaKRBXUVhWAsHQF+Rdvysh0vdCo9fxNSP6dxoc7LLpKIfunEkg1hjTTdX8QynB3hP4puw73qB1Z6r3poCZScE3mlGs62km/RHGEp7v3nX03qJaYe3yg==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1476.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:183::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Mon, 5 Aug
 2024 02:53:50 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 02:53:50 +0000
Message-ID:
 <MA0P287MB28220B7C6CF3DD77D8278A53FEBE2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 5 Aug 2024 10:53:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
To: Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 guoren@kernel.org, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 ulf.hansson@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com
References: <cover.1721377374.git.unicorn_wang@outlook.com>
 <IA1PR20MB49539C30076AB6D14B20BD57BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <IA1PR20MB49539C30076AB6D14B20BD57BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [ElKF3ttqQhrN9VQAjUo394Dh78ifzwiH]
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <69283ee7-508f-40a2-9a5d-858b21ff9c93@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3583e230-8bc1-4006-de06-08dcb4f9d5d1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799003|8060799006|4302099013|440099028|3412199025|56899033|1602099012;
X-Microsoft-Antispam-Message-Info:
	FVhpRT3H5/8oLJiqdURJsfSeTar65EAKz74QPy03RdPSLd0GsCZK63+ovmxr111IYStg3kchkmJMBKQcbeqig8At1v4FgpUMY1GTQ/V19YBPM/kmpwoQ32r/jg0qjp8hTmS3X9FxmQXTTfTzdSlriwYj4h4ubLBhKZ+YX8+3wjY8ZdZmvumyKjAhmwOmHKBMlWRFWfh4gKK5cBILWJKS2RqYAoqed+3UrEN0z4bgg+41C7B2XvMNLSYCQRPpwv4ldFfOHkgmqx+yyXsTJxoa8PTz/SoE/qvLYoklYm6QAQxGtdsg9mCCQsZYM3dUg8bqBGSEzXLUzZdlnSHeDunHbC61qg9kzq4kXWZqWEff7Ch/0XnZkC+13mXbuVPxwqx9DwTzgUrkJvIFT8rB9WHNSUKKRSF7SPNGN4dOsdW6HUjbjaszEoKtpv064YlCq6lyubyAlZF/OIqmhE/y50LRzXNGJ8MAvCGO/xbpnq9O8Got2F+lW40WUCFyeVXMxPipbgCAhM666Gds6DbWF5ylADF5tPP3mTlNX1yfZjKbGgp8ToURxBHThwXC3WN+ERQup+49pGuKOHxLBgPABnX/YI41ZPhyE/xuvPeQS3tmixQA/oIL0TWtmKNEz541ERd5l1iCVpR2Cg3/o8nLpZOgsNJVWUAgwYXgchSofE+we2JxcVHfIVjHIWuyIGHwjSWZicjAWHZZ3ryc85O+IqzVig5eKOrB6/xMVFr//xUrV+IWw08SanallC5blYjyZgf+TdEjN1VgSJVTAkvvpUPUO8yucyCopwtglkuV7i8gBbw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnU2dU51VzJZbjZzd2JFeXh3bXBXTWdvRHJGc242YXdxdHZPdllIdm9JMGJC?=
 =?utf-8?B?c2pIQ3Vxa1FuNDFJU1BxVHBmbXlPSlpjTlBPTXBPM2VSb05hK3ZTNUhjNnM5?=
 =?utf-8?B?S1VidllpRXhKNWFuemVmZkxocWx3STdsUUVmcmdHRTlkKzZWY0Z0c0lYSTM3?=
 =?utf-8?B?WG9INTRobk9kQzZickNYZEYrRXhPNjVwU0FTclVEQnc2bk04THE1Nkk0SHhY?=
 =?utf-8?B?Q1pzRjJXVU5Gd2Y3Z1FGNGpleXpwUW1tODNSVkxXMUtrcU8reDFKUWdzcVMr?=
 =?utf-8?B?ZkF2bzdNd2F5RW8vdGJwR2dLMEtDV1FpeDJ3bVFHNm43TTJYRlk5dEMzMXkw?=
 =?utf-8?B?VE9mYXU2MEN0R1ovdjhBYTY5cVBWcHZ0NWVuQ2FGaFlBK2hCQmdLZFFiUXdS?=
 =?utf-8?B?N3hFczVCb1FKL2lGZFJnaW1HUVhuMVJIRk5hZHE0MHBPTFNCM1ZqeFNTa0hC?=
 =?utf-8?B?V0JMY3Jkbktqc3Y4TDNhSW8zbGtqMTNqOE8wOFNPMy9RYWFYT05UbmlZRFdS?=
 =?utf-8?B?TUduWTNLQ2ZBU2tNK0xOYzdNR3BaZng0TGdaSVlpK3FLS3haWEx4Ym5kS3Zv?=
 =?utf-8?B?NCtyU1hkSjZKdXlMSURqdUtudWRubEI1S3dqdjRVQUk5NmxVbFJNdGFLMlRs?=
 =?utf-8?B?TkN4VE11TkhyYTJYTXJJR1l2YnpobFRIb2pxdUxvQS9sZVp1ZldQNnA3V0hN?=
 =?utf-8?B?TVgrZDBsRkZUS2Jpc1FHTmc5MlFFQzFtNzV1RG1TV2ZYMCtjbUpVWGl4anlT?=
 =?utf-8?B?N0crMkFOM0xDUVNvN2NlK2lZVm5WUVZ1enp5YW8vZlVzb2thZEtFMTlCbDls?=
 =?utf-8?B?OHltaVkxbjFKOWpHRGE4MGRwM2VZeXRsYmRxbHAyR21ydi9odUNqM0xnY0Z0?=
 =?utf-8?B?WUxEcnBEMDJidDZEb011RWtHeSt3N3hSVUpEQ0JwOUNaMis0NHg0dmZOWTNJ?=
 =?utf-8?B?cVU3aWNPVEN4ZkpzMXgrSEJtbWZGYWpMTlFGRFp0YmNOVmFzaFlxRGh4K3Z5?=
 =?utf-8?B?UU9XSU53ZEJGdmF2SUVIRlJsM2FYMUsxMDZGRmd3SlZoMHVINjVVM3RFeUpm?=
 =?utf-8?B?L2huT0NmczVXd0hZdG1Td256L3l1QWpjOUJIMEd3cW5JZUFES25JQzJDMHBz?=
 =?utf-8?B?Q1BIR1hRdXdxQlM0Qzd3TzkxbDc2a0hIRW9JTnpHR2Npd2JlV3pmZmhqTmFy?=
 =?utf-8?B?Qy9WeUJHUGZzbDliTU9BMHJ0SVhSYWh1cjFrZVNER2VjRjRPT2dIdUFyN05y?=
 =?utf-8?B?Q2J6UlI5Z0xHQjQ2VGprWnZDZGk4S25OOEtCK3pKUXBmcS9PNjFSS1VaS2ZB?=
 =?utf-8?B?RUtRWXFScDZ5cU1IdWRjYjFSYTMvalFDTytuMGVBYk9PbUdUZ2hVTExhWVdV?=
 =?utf-8?B?SjhCc0dqaSsxWUNRaDlhOWt4N0d5aVBWeVhVdDNFSml4b0I0bHorbytGMWdn?=
 =?utf-8?B?cDVJeXBReHBobWdhVUo5cjNFc0xZZ21YWTN3bE02ditUeUt1Snc3a0lKK2hX?=
 =?utf-8?B?UEY5ODcxa3NLZUptM3paMzIwSGdkaTRmS1gxMGlPZUhoQXlBUjRremdTa0Rp?=
 =?utf-8?B?V2M2N0ZBRjI3WVJBQkhQN0x3Z0NXZTY5N0QyUSsxTXMxd1gzcU5Hbktpbnlz?=
 =?utf-8?B?aGpVWU0zakE2T2xpTHBoTnJqMUZ3RFJONVgweW9jeFNvcGg5UXZYaHhDZWZz?=
 =?utf-8?Q?hgtjaA66MgVzta6MBucf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3583e230-8bc1-4006-de06-08dcb4f9d5d1
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 02:53:50.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1476


On 2024/7/31 16:00, Inochi Amaoto wrote:
> On Fri, Jul 19, 2024 at 04:44:38PM GMT, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> This patchset is composed of two parts:
>> - one is the improvement of the sdhci-of-dwcmshc framework,
>> - the other is the support for sg2042 based on the improvement of the
>>    framework.
>> The reason for merging the two parts into one patchset is mainly to
>> facilitate review, especially to facilitate viewing why we need to
>> improve the framework and what benefits it will bring to us.
>>
>> When I tried to add a new soc(SG2042) to sdhci-of-dwcmshc, I found
>> that the existing driver code could be optimized to facilitate expansion
>> for the new soc. Patch 1 ~ Patch 5 is for this.
>>
>> Patch 6 ~ 7 are adding support for the mmc controller for Sophgo SG2042.
>> Adding corresponding new compatible strings, and implement
>> custom callbacks for SG2042 based on new framework.
>>
>> Patch 8 is the change for DTS.
>>
>> By the way, although I believe this patch only optimizes the framework
>> of the code and does not change the specific logic, simple verification
>> is certainly better. Since I don't have rk35xx/th1520 related hardware,
>> it would be greatly appreciated if someone could help verify it.
>> Note, the DTS change has dependency on clock changes for SG2042, which
>> has not been merged in master/upstream, so if you want to test this
>> new sdhci-of-dwcmshc driver for other hardware except SG2042, don't
>> pick patch 8.
>>
>> Clocks changes for SG2042 are expected to be in 6.11-rc1 soon, I will
>> do catch up with that when it is relased and provide a new revision,
>> but anyway please feel free review this version and welcome your comments.
>>
>> ---
>>
>> Changes in v5:
>>
>>    The patch series is based on latest 'next' branch of [mmc-git].
>>
>>    - Based on Adrian's suggestion, split the first part of the patch into 5.
>>    - Updated bindings and DTS as per suggestion from Krzysztof, Jisheng and Conor.
>>
>> Changes in v4:
>>
>>    The patch series is based on latest 'next' branch of [mmc-git]. You can simply
>>    review or test the patches at the link [4].
>>
>>    Improved the dirvier code as per comments from Adrian Hunter, drop moving
>>    position and renaming for some helper functions.
>>
>>    Put the sg2042 support as part of this series, improve the bindings and code
>>    as per comments from last review.
>>
>> Changes in v3:
>>    
>>    The patch series is based on latest 'next' branch of [mmc-git]. You can simply
>>    review or test the patches at the link [3].
>>
>>    Improved the dirvier code as per comments from Adrian Hunter.
>>    Define new structure for dwcmshc platform data/ops. In addition, I organized
>>    the code and classified the helper functions.
>>
>>    Since the file changes were relatively large (though the functional logic did
>>    not change much), I split the original patch into four for the convenience of
>>    review.
>>
>> Changes in v2:
>>
>>    Rebased on latest 'next' branch of [mmc-git]. You can simply review or test the
>>    patches at the link [2].
>>
>> Changes in v1:
>>
>>    The patch series is based on v6.9-rc1. You can simply review or test the
>>    patches at the link [1].
>>
>> Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
>> Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
>> Link: https://lore.kernel.org/linux-mmc/cover.1714270290.git.unicorn_wang@outlook.com/ [2]
>> Link: https://lore.kernel.org/linux-mmc/cover.1718241495.git.unicorn_wang@outlook.com/ [3]
>> Link: https://lore.kernel.org/linux-mmc/cover.1718697954.git.unicorn_wang@outlook.com/ [4]
>>
>> ---
>>
>> Chen Wang (8):
>>    mmc: sdhci-of-dwcmshc: add common bulk optional clocks support
>>    mmc: sdhci-of-dwcmshc: move two rk35xx functions
>>    mmc: sdhci-of-dwcmshc: factor out code for th1520_init()
>>    mmc: sdhci-of-dwcmshc: factor out code into dwcmshc_rk35xx_init
>>    mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
>>    dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
>>    mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
>>    riscv: sophgo: dts: add mmc controllers for SG2042 SoC
>>
>>   .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  60 ++-
>>   .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  17 +
>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  28 ++
>>   drivers/mmc/host/sdhci-of-dwcmshc.c           | 459 ++++++++++++------
>>   4 files changed, 391 insertions(+), 173 deletions(-)
>>
>>
>> base-commit: b85e021853976aaebd3788e7e721020570754199
>> -- 
>> 2.34.1
>>
> Work on both Duo and Huashan Pi. Both sd and emmc are fine.
>
> Tested-by: Inochi Amaoto <inochiama@outlook.com>

Thanks a lot.

Regards,

Chen.

