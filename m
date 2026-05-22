Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826035A3AD;
	Fri, 22 May 2026 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431416; cv=fail; b=DjQMTFeTJk1Q6HgE7UAghN9CYLwyFTPhhKKah432s3opICu5g+eo7PP0/8Gy52+uQ/nR+iJ/m5W2FO6WpURwR4g+7Q4YqkQ+FZe0+xXh5Mbbqi39poeH4voo+FMi3r2C8ldyMvBh23/gitX3SDfRRWy/nKQ24+e08zGLLht5BV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431416; c=relaxed/simple;
	bh=FNAncha1nU/w1WbbMGOZJ5XcRXImHqlp/cdmX2QnAqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NC/tLfeb5w0ipNLo9fkEifaiO2uvDRfoRNoAIjgyDL6ayA+RwIG5/Chn8q/pPCioWhRZ9EU3NGLZ0qk5ModOaEFoHBJa6jdjLoiN3vOt+8uW796o31VjOnK9aJlBdwxB0pXcbS7PCOpVEvUbvF09rvhTq5eXKQyM+kMcQOBNA/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qbE+B9tv; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qbE+B9tv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoK3ZWwD4E1iX0nBo+FpYnkX30hy7xEfEh9vjN410j8RNBaDI9FPIheoFtQKfl3ixSwm0PZqgrD1MTBSfVzRryUK6mYtcl9i9BNhDWYqDthPHYcr3iBoWNC9Nj4gVbGNqV6ziCV5N7qe92Ex0tHgyTUaxaRNPrxnuk1/2ibTNh6hTEYZ1A8SftcsnMLRYIfzhIpIRqX1CV7p2eQppOpEG2D1SVBnmsxQoWD5d9RkJQnPwTh4BnN2IwYlk46CD1Zf9l+mqsc/BMh0YGVGmO2bvroPWvV/HBP/w/SRKSnVDFyRT8BJkqgDEokRAc220Srt4pneMMLxweK1BD5RZsr73A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ98iTepTShIqUdjLp2pTeeMYPCkpxyxIwgYOfP3O0U=;
 b=QAKh/JZbm+ERquVfGZ4sDX9HvJVlI8tBLzPdvu22bB00GPnXODA5kll7ayt9CMJOFTReZRCVMlHD6bud3PWyc/87AAOFy0BEStJ9vmt05vyDMRE9aBe/VVTVN0ArcTWF0nxmQuTopnLnP/7h6TU74ZFspiNNm6XHM4kYkxJkzl7xeFZKyrVJqv6eV8WjE5SPt0d8WP4lyEAeN8rJx+6P4iOkFcN0FeS35h5pC2ADDwcqxOt8l3Y/Q3zKwQle/t4G/3gcFJ3D/9pKFsrKujS1v55ieifMfSYR6s0tCDRpx6LwIEkpp4FKCeqltnb0ooMT4vuEbgFbb1nWjDyw5/svzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ98iTepTShIqUdjLp2pTeeMYPCkpxyxIwgYOfP3O0U=;
 b=qbE+B9tvaUur53ierz8Vbl6RgYMkBhYg4Dg3TDEUs/5en+GOXXJj1OJGU+vsRIH/N5r9A8Hj9/+V8z+h+q0UbmVRJjNJE/jqz3QqnsYN2b1tnLMvLNVGhKH7FWTO0VKtr1Y3NqZRt6fCRG8at340jXMfN2XvStxh5f0enqV/kbbPL8SgNQcvCesGV/4O4eDEmLnpkJ+RS4AUA/ooZTgjJjuBdUYgt6RpScuoSMMTfpOdgIMTcyMM3mRJeeHp1zvTU1isS6hRj0TBIeEolL4SPELNnPFJzWt7ZWtL1n6JblQ6zlgAtDbZ+wr+FdWL1n6Xc0PUX4JYIEVIsuvCWJ3GYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS1PR03MB7918.namprd03.prod.outlook.com (2603:10b6:8:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:30:11 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:30:11 +0000
Message-ID: <5c9587e0-035a-40b1-a61c-e897744b6c5c@altera.com>
Date: Fri, 22 May 2026 12:00:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] arm64: dts: agilex5: add SOCDK eMMC daughter board
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-6-tanmay.kathpalia@altera.com>
 <20260515-grinning-inescapable-butterfly-eba39d@quoll>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260515-grinning-inescapable-butterfly-eba39d@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::19) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS1PR03MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 49331f63-7182-4252-aef3-08deb7cb9307
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|3023799007|4143699003|11063799006|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QbugWWnrlw+jX9lTaAPMT+52kSpb+BXNTyMx4ft4oowL/beDvTZvGYdz68IE9bg9vRSYWMaC2ZCZcf/4exi36qBpct6RnvlwHrhdTONdifAa14n6mIdLyGTVjIj65qQZGlP9JQH9YI8VG20PkJboltr2tYzuyCZIX0a9YVhCitilqTMqvas4cKrDtsyn2I8SwHvhAxLegLKBd0Ccsahw2xC7IUE0RNHtLYos1OR+VX+rk4JkcAil2mkW2Ci+C/Iwu+qW7JxhEsHnYHXcXxoL3RQ87LP2vlBkuLcoT6s0ohy41Ifc2ilcfwnTRKyHK6WxnysSbFvOYlKjxBhXQdQGXwsd9AinJcI4g3cKtRQBHP0EWiUyDqAzWSrRuYT/dqFsh+LXEemnI4gUrTdeZxtdAEF8X0Lw9eVioIJvGhJEph4giP0ZkeqPu6sorfLTX/4DdCaapLdVdKalm48np79gxgLyvd7moAv5Vwu90b0O4bhR7ioCitatF6ODgsPv3jH6AGZsmqlLqg9n8ecAc+cVGisRHuysU2LlIox7g3Tprx3pxyg/S3GR0vZC5vEWLb7JeKGCZfVbQGJq6Q85sjdEBTg/rrvHpBVn3cctvXVh0ux888ZLiSW8aHMgnXRxn/Z7MGr35SNEk99JV3Ohgns1s74yL07DvostlnjED7DtBuue+Tk96jyi3g2slT1ZI3wg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(3023799007)(4143699003)(11063799006)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTI3NzN2NWpmdlVQcUkvdlZIalNyemhiTGROQ0ExSDV2anoyalZkcG51ZVpZ?=
 =?utf-8?B?UmlmZWU3YnVjSjQrR3JZZERCc016UlVVZ3JkN0M0OEYwam5nUmczV1cyYys0?=
 =?utf-8?B?V0haWUExWWl5TWtGUFVYeFdQV1lieTdyWVdid1dmazdqY1dsbUVNOUYybkNQ?=
 =?utf-8?B?NkJmbTRmSWFIQWZLM2NqSzdDZEpibmJVWTdUQ3ppendTOW1SNjBJempOd09j?=
 =?utf-8?B?QUp3RnRBbnZkLy9NMkFHYWF5NWFxU1N4V1paclRNTGorWnZqM1djb2ZTdWk3?=
 =?utf-8?B?b29ON21sVHk5SkZIb2Q0bnBnaEViNll1RUNlMUZqcjZQT3Y1VU9jMUlWZ0w1?=
 =?utf-8?B?Y2tIT0NVU0hucVp5OUQyajRoYjBPQlNiKzdwVXFwRXQ2ME5wUytNbDNiSzVL?=
 =?utf-8?B?SWpSVnpBM2dySk9vbVFLV2NHcUZHTVpzU1ZXZW05YjQ4VWF4eFVHZkVHMmMv?=
 =?utf-8?B?KzhNNjRhWHJKVERoRm5kOWNHR3k5VEtLd3BKanovR3MrRzgrSUlFallZYzV3?=
 =?utf-8?B?cWtkckFLUEpqZE8vUjM2RnF0Z0crdFhUNDQxMWk0LzFlK0JLWUhCT3l3bEh0?=
 =?utf-8?B?U0pVZ3I3K3ZrQlg3a29sYldiZEFqb3dPTTByOHhHTFpYd01IVm1pWGd2NTRK?=
 =?utf-8?B?WDhGbTRkelpHRDgrMElXeGN2TG5iTDRMeHFBZEJYa3FGcmJEKy9NZHRQRlhV?=
 =?utf-8?B?VVJDejdjb2tWRFZLY04rOXhLb25uU0pQdWpYRkFyN1pFcTJrWGJhYmhrVGI5?=
 =?utf-8?B?blY1V3IxTjRUdUxsa0Z4bTBkRjZuWVRka1JwRU5ITTVBMnNIZjQwaWlUajFx?=
 =?utf-8?B?UDQzOWg4WXJ2ZmpkTU0va0VKQkZDaEk5MVFacDZNb3Q1SE5QWk1IWU9yTERS?=
 =?utf-8?B?cTQvKzZDWEFtakVwcHNNUkhzRE1BZTZuWG5WZWVEZGhvMStsRUxpZmRXbXBm?=
 =?utf-8?B?U3duQnh3ciszb0NJYURIZVltNVgzSTkyWDM3RzFiV3MrWjRKVE9MNzN3WkMz?=
 =?utf-8?B?eVhaVXJEc2MwczVqMTIrOXlMQnJIcTIvN0tmMVdKZjlpdFFoM3grUnYwc291?=
 =?utf-8?B?dFhPVVJpQmtHamJKS2tXUXgwVExEZkpzVXB4STdINmQyczBZSnZKbVJtZDhU?=
 =?utf-8?B?YXZJR3g4TGd4aUIybElSOVY0OXlpVkVTaTZyUGRpc0ZoTkIzdU1sYjZOcUNW?=
 =?utf-8?B?UXlIaHNFWllLa2p0WnpqTzYrVExJRC9YaVkrdm1nczJFMUJhQk9SNm9tTlY0?=
 =?utf-8?B?SzZvS01aOFNENUEvMFYvd0QwZGtuUjlHd3JlQUQ1cUJja1JWc2VRRHRGQkRQ?=
 =?utf-8?B?OTB2enVodGR5NlBjWkVIUDR0cE9RTXp1QVFJTTlQcitrQXFVcjFNWDlscEZo?=
 =?utf-8?B?VlR4VDZQNnlDcnpnVW1DM1pXZ0ZWNzQvVjhMYkNFZ3dWaHBDaW5SNy9tVTND?=
 =?utf-8?B?MVJOUnlieGRuRHpKcUlheG15S1N2d3dlUGVUeXZpQ2VGVVRrU09QZkVYL2JL?=
 =?utf-8?B?NzZPZlZReTNjREU0U0dVOS9FNE12d1VpU2tmWjhCTXRKWjE5TTZZVjRlbmpF?=
 =?utf-8?B?YSt0QzhtcEZSSXl1T3ZJT1N0SDNTTzQ2MkJGbHFNUWFnZ1VMRmYvWUt3VzJk?=
 =?utf-8?B?and1WXpqaGZQTjlkK3NSdllVNjh4RW5nYnBialFKbGZsT0FuZHg2YW9MNWVS?=
 =?utf-8?B?bzFOV05rbmlYVzRON3VQT2p5L3p6M1poM3NVV0gvMDAvM2pkdUZtdmY2QXkw?=
 =?utf-8?B?YWJRa3lOL04rb3VQWkFkSklubjJMSXlTUjJuM2grNGZnT0k0SVJ1eVJUYzkz?=
 =?utf-8?B?cDRudXRmN3cxQ1pBSmJCV1JTNHFWYnhXUVNuVWFRbTV0NDRGSU9Nc013b05V?=
 =?utf-8?B?WFYvOVJMandaYWYzMGd4U1k0Zkp3YkVUMHorYm1oN1VPOFBxeVJnZlpyVFYv?=
 =?utf-8?B?ek5hbmFLN0EzNWs1em15Nm1Iay9QOFNZeHFTakRabG9iTFFVOHZyU0xabWJR?=
 =?utf-8?B?SVZySW1MVlhjQzRndVFFampKeG4vQ2NGUDlyMFpURlRtV1RLdUV1T2VGRTVk?=
 =?utf-8?B?Q01oZFhhdXcwUmJqdXp0UGowMURvbkk1WFJGLzJzWmRuN0VZNWhqYjFMRG1s?=
 =?utf-8?B?RlpRY0kreVdMbVBTZ3lvQnRmcFpCaEhUclY3WTZBeS9iM0JHMlZrM1ZtYWF6?=
 =?utf-8?B?eERhd3FMekJ2YkZvcHVXWFpqb3ZlNHdBWlJHOWFFUTJ5N0hJVU9NQXlNZlBu?=
 =?utf-8?B?R2VoalRuMTdSRSs1MVlJNXg1TmkzSzhwbUpDMUVYays0STl3QnZlemdPTE80?=
 =?utf-8?B?ZjBDZERQZ3JiQXZhdXdXdzl2UFVFOGd0MnZDbFJteGdtdUpTVHdjSXhFQ0JV?=
 =?utf-8?Q?fsMI9DySEGCgDTQA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49331f63-7182-4252-aef3-08deb7cb9307
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 06:30:11.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3ltBWC8y3OwXqrI9vEb8oDZlfn4NHCHtxvohqO0+6mgGmSYTTeuRrCSvgWEOoxhdZ7Ux5f5g1Ag2bykEQ6An7V7I1gvNXhrHnvo4zotFs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7918

[Re-sending in plain text due to HTML rejection by the mailing list.]

Hi Krzyztof,

Thanks for your feedback.

On 5/15/2026 2:07 PM, Krzysztof Kozlowski wrote:
> On Mon, May 11, 2026 at 01:21:27PM -0700, Tanmay Kathpalia wrote:
>> Add device tree support for the Agilex5 SOCDK board variant with
>> eMMC daughter card.
>>
>> Update the SoC dtsi with a fixed 1.8V regulator for eMMC I/O voltage.
>>
>> Add socfpga_agilex5_socdk_emmc.dts with eMMC controller configured for:
>> - 8-bit bus width
>> - Non-removable eMMC device
>> - High-speed, HS200, and HS400 modes at 1.8V
>> - 200MHz maximum frequency with SDHCI clock base capability override
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   arch/arm64/boot/dts/intel/Makefile            |   1 +
>>   .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |   8 ++
>>   .../dts/intel/socfpga_agilex5_socdk_emmc.dts  | 111 ++++++++++++++++++
>>   3 files changed, 120 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex5_socdk_emmc.dts
>>
>> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
>> index 33fcc55d0cb9..5bbbcfda1f48 100644
>> --- a/arch/arm64/boot/dts/intel/Makefile
>> +++ b/arch/arm64/boot/dts/intel/Makefile
>> @@ -8,5 +8,6 @@ dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_n6000.dtb \
>>   				socfpga_agilex5_socdk_013b.dtb \
>>   				socfpga_agilex5_socdk_modular.dtb \
>>   				socfpga_agilex5_socdk_nand.dtb \
>> +				socfpga_agilex5_socdk_emmc.dtb \
>>   				socfpga_n5x_socdk.dtb
>>   dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
>> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> index 7e080f13166f..feb4ccb317a7 100644
>> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
>> @@ -317,6 +317,14 @@ sd_io_1v8_reg: regulator-1p8v {
>>   					<3300000 0x0>;
>>   		};
>>   
>> +		emmc_io_1v8_reg: regulator-fixed-1p8v {
> How is this property of a SoC? How SoC itself has a fixed regulator for
> EMMC? Really?
>
> Best regards,
> Krzysztof

Apologies, you are absolutely right.

The emmc_io_1v8_reg regulator is a fixed 1.8v rail on the eMMC
daughter card, not a property of the SoC silicon.

In v2 this will be fixed:
emmc_io_1v8_reg will be moved to the root level of
socfpga_agilex5_socdk_emmc.dts where it correctly describes
board-level hardware.

Regards,
Tanmay

