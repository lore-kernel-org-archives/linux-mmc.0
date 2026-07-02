Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1A3B52FA;
	Thu,  2 Jul 2026 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983247; cv=fail; b=bEDvDeyi9TfpcN839MHBnDrUwxGxZ0RjpbDRXUcK9sqJw2gzIaBXNP1WYEq5rOp0NDEiq2YXd0u7GoEGuVfOgDY0UHmiO8HEWSNQfBLFqDzyzMkCoO3vP40nD0ThyZF7gMinXlE599nTvwilv45LLAPLviq9bbnBx2wxkTZTbN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983247; c=relaxed/simple;
	bh=6ZbewZU9z6WuxufRL33Gl6IvVzMUdt+z1+KetmUkVSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jiXXzBMNTCzXmt51Eho6q6iIXKFNffp4dn4Fen2C94cmSbdOnUGf5AQMWCpKDB+QtqOnht3WvRe+aUdE2JAWXnBoyoKw7UNe2dFZT9vYZacjaOexrPrB/KG3wgxxOUkcxEQU92UWBs5dn9ZBKXO9ZIjPWtYWgNZzKMy3andPbRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=iDXHXCSK; arc=fail smtp.client-ip=40.93.195.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="iDXHXCSK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXpXTrMJOjEHknW+pyQu7ZTmTfvnNzDS3i76LiqBfnxMEGd8E2dYKk4ZZYeW3FWPUiDQaE39HTITNQcfjCFkNLdQlM/ju+68GS09CxlgE63Crr2KgzWaRLGVZ1Eouh4ttxNpaz7+yYaW+pLySbeG473Zb3P3WbnQASLVILMHBsziL/cpa1Stqq7rUBbW3hj+Sr6kh8+VuX/DcoPnNjs+/O8jcqmSSSEgOV6Exos7HVPfz9Vo0Z77uoAYYcDk25qYt5eqNHRmaz/x5Gf2zhrd2lDtcyPUGEMK6TG2tB+ZucuMjm0iKnJyaI87Ce1U2giFQmjltbEBU9eCmly4oF3CTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+lJVApwtga1Mh13KWEr2rP9V1+6kEdfmvnFnQ1usq8=;
 b=MKCBcsSo2bzG+NeVH4gI0FDncMlmpvdNm7K5blF0X1VmwgVKwPjUGwVSdmLPhyN7ujqInhsHhqp9hMcTa2g3eJY1hOPYJKYntCA1M1VmwNPwf2b+ZN15IVf4Zt1i7pyUqCRh6O8Yh+f24wCQZh49LtelDfFasfxiZ0RZV00aynaDtfAKOfNbtExUiENC3O8GHrIBW3H2KcnqXqM12IaJPGIdxhHURrsI+cXSRG96UAfZgevmzopEZka8rc+v6Cb275Qii2pKy82TDvhWkC5fTv06Bek0QTA8StUqMso9PfLhT9QlUBCU/r+cnWwtvR+v9VALD57kDlZquBnZODkmMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+lJVApwtga1Mh13KWEr2rP9V1+6kEdfmvnFnQ1usq8=;
 b=iDXHXCSK4KHpk4iuXNp3W9Ew92GdxrRht9jvxKyfzE5TblajVvLTQ0spj3SVonzMypbCi460M7yXflGq9HnLhWPm3SD6yR8GBVIJJ2GWg2byg9gdQGnxN96aRNG9R5JiX0reyBncljEPMvDgGXDXn2oz3g7Uqjg99aR2A5lyLs4s457HGLgpsj9kLeKqOcqedEuZ3I0zK6Y8pjsnVl6FcZdjpquJHL6jYJ0wJ3/Lj1BykZSmpxqB7m8JlQx/RzsyTgEdIPOenBrExwwniOLJK6uvVGcgFNWHuH06eO/F/AVX+h9GKxcT1mYzOdHUOmzZwFXgpu/F9PthycipxdBa+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH0PR03MB6050.namprd03.prod.outlook.com (2603:10b6:610:bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 09:07:22 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 09:07:22 +0000
Message-ID: <4b2e395e-136a-4600-9d8c-16c444bded08@altera.com>
Date: Thu, 2 Jul 2026 14:37:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] dt-bindings: arm: intel: add Agilex5 SOCDK eMMC
 board variant
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-5-tanmay.kathpalia@altera.com>
 <20260629-venerable-zealous-dinosaur-c7efe0@quoll>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260629-venerable-zealous-dinosaur-c7efe0@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0192.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH0PR03MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6182b9f4-f9aa-4eaf-08ac-08ded8195325
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/BTsTf+8SMir8+QnPaH18KydX957hJgZtOW1dX8tB2J8nvzXAQrWHjBi9IXYm9Gg7Uriu5nAXHm+y2cl/k2w+foje+pc0/2zu5hYIAg+CujXihlLq01Nu0Yz4kcICiZ3zLwxXEFMGQDIZyPQY6Wq5ijFv0rUOEl7p2i8SA4oqN17k1WLEftPm/sDbzjrX9+h3Hrm7F3A4OBfKcGxsmNCeKHqCFUAtrT1gucBwMRvUEPZ4wjXohfw5ezndr4knqLLrATRhQks6Ddqs/brW/HIuwAYtd1GGgMvy8re6nyLjIIwPfFT7H+YHFsbgigcss9/d3P5JlVgyXvRFAV7K8RszdjHynIJo95mVrTv5TyHeBQRFyXNwxqDMaFdqc/yZFoGPdhK2+WiQ4EBFb+HgJZ99d74oD+X33WffypQjHdUvVBsiDKMCnnH0PKGcVwzDsEOX9qu/yc/R2UZNmDCxNQ3Zh/7b5WadxZXF5BsGStoEssu0ByfV1egeaN5UKasshqMhAmTiv0sgANRXWMhFQ9Yezt6oUfzDcRO9kyC0q44GmP7xJHBbuA5sTAB6EowXuEBLaRKTkRKuiEJ6QRyhgodZOR/x4mVM6lHhve3nZTow+yNvgSvyYRApTuVB2UwRPZ3ikuRnh1fmuo7xF/PCJ6oMLS0ybVBmyI1D8ctcC1N8uc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFlOVzU2clllV3JqaFVRNVRHUEdOb1pRT2NhMlRoTEUvSFZLbG9yRm1tQzJv?=
 =?utf-8?B?Y01DK3oycjVPRFE4bkFUWUk0c0RnT1F0Sld3c3dNUkZuUVdtYUNiaGp3akpj?=
 =?utf-8?B?bk03L1BBckZpcXlnSExtekxiMERVWU4yQk5nSWptZTZVblVSRWhJL0lOWVRK?=
 =?utf-8?B?dUJMYmlwR0RHU3RGdWhCT0tsaFVTK0JFTG1QM0ptWHVzT29xcS9McHM4Ry9K?=
 =?utf-8?B?eVpWcjlhQmhXMWpCMzY4RGY0dlczQjArdlBJVi91YWVydlllZWJxL3o2OCtr?=
 =?utf-8?B?MFJ3VjY3Z1JFdHZLMmNrc1JqMmh5emQrTVNYWFluYmFMYXlCZStQa3NaRjA2?=
 =?utf-8?B?UHRNWWhqYitHWUY2WDMxVFM1UVdON1VPM2tBL2hydzJ5UFl0QXM0UUJndjhx?=
 =?utf-8?B?eFA5UkQ5b21OUS9aTjJBOE56N3E0bVliRjNBREJadk9oWVB2dTJMWnp6MHZ0?=
 =?utf-8?B?NTJaQ0Q4SExLUUVLa2loeDVaMmJOei9yYTliOWJzblQ3R2RxRjVqMEVRbU1E?=
 =?utf-8?B?OHEvQkc5QTRRNk5sejdnTW4vS2grb3ZVUUI5dGFIK2VyYzJNNllXNlh0a3VQ?=
 =?utf-8?B?VWVVSHFGUlpRVjFYT1l4TTdOTy9EMXFRdUczNmYwZ0ZqdHI2dUZveFVxZVBk?=
 =?utf-8?B?aXNYb2lPQkxzQjEwUE1UbGhxdXFrdXpidkFoeWNIemFwUk5HbGFMYVk0TXBx?=
 =?utf-8?B?YXUzUzNrTnNxa0ZhenBLelk2eFZ4RlJJMENTS0Y1OENjNWlKYjFiMzExTU54?=
 =?utf-8?B?d254THR3MkZXVGxsckJoVWsyMmI2a2NlRkx6R0ZpUVN4UzZDQTZNL1JUTElh?=
 =?utf-8?B?QnExVEcxaERBRDB3MVVIclc2Z3o3WlVYNzlGMDJSZWpSOGpwQitna1hkckp1?=
 =?utf-8?B?bkZQQ0NzbDFhajZ0Z3lJZFNXdC9ZRmRBT0ZKaVo0ZnBGK2M0QjlkMUVVRG9T?=
 =?utf-8?B?clRBSHVxVEpwUmRiUHEvZGF0amlKNHhSalZwU2JhbnQ2SCtQSHZVdi93NU90?=
 =?utf-8?B?RGUrRFJiOHVtR0RiSzB0YUQ2QW9zWnhuVFdMbndZTEZrWjF4ODRqZk95TTJS?=
 =?utf-8?B?NGxOLzVicHJxUE92Z3lqR3pycU5SWGFGVXVoRUxZZlNEcmR3c1FrdHFrMDll?=
 =?utf-8?B?RFBsUzA1UWZtQmRLektGL3dhUFVlTFZDVUNzQkZqTXdoMWwzNnppajNuQzJa?=
 =?utf-8?B?NkUyNi91RStvYW51QnpNSDErOEd2SjdvYzZhcEVOZEJmSkVCb0pteUhsbUZp?=
 =?utf-8?B?RUhTUFZhYzlrZ2MvWlRZbTR2clRCeWJMelEzQi8xeG00UXNQenRZK3M1Qmtk?=
 =?utf-8?B?bGE0OFVMcVhQcENCTm9kV0ZVK004LzBDMC9abnJmamE0M1pXUmppQmNjRVhF?=
 =?utf-8?B?OFlCUU9uVzhUOWxyRE56ODViamtVWGJQWWY5cWRubThJeTgvNjlvRXRheXk1?=
 =?utf-8?B?Q3cyMElORDZJb2VFMXF6TWt1dmJuUWE2ZG05d0Z2b1UveWJQR3grc0xiT2Y0?=
 =?utf-8?B?bjZUdG9GQ2tuV0RnSW81VlFEMUJPWnQ3aFoycWZtMW5hS0ZZWC9WelpNRHVE?=
 =?utf-8?B?SVdPQndTZnJQZUYvOVAwV3lqRDFxYW14bVV0T0RMb0g4QTExWk5VVlNMempm?=
 =?utf-8?B?SzNSOE1XSldYR2NWTXdoR2JQM2hiNzRXUlFZOVNoUWhDNGt5YXg2TG1ocjQr?=
 =?utf-8?B?QnBvY1MrdDgrL1R2TG4vN3RhZ3hEa3J5UDRSOTMySk5MOVk0dXNtZi8yZ25T?=
 =?utf-8?B?YlVCcjhTNHRwVnR2bURmWkd6R1l6VFVhMmZRdGphKzBpTXdselFIUmRWd1M5?=
 =?utf-8?B?R0Z5eCtkQjlPcSttRHE0VXYxWEgvUXh2WDl5Z1Uvb3N4TGVidmI2VWlRMHIy?=
 =?utf-8?B?VjRXWGhkd3RaOG9mUmltOUxxV3lsTmN1bUV0VHF5Mjl2Z3RaU2hpamRQT1R1?=
 =?utf-8?B?Q0sxb2lsTTFNa243TXdtODFiSlh2cW4xc3ptdStVYU5EMURWY3dhRHY5dkRT?=
 =?utf-8?B?cnZSdEJobFkzNTV0TmhWTm01SEN4VHQvSE0wcUV0R2dUOFNSS0hYZnF2MStP?=
 =?utf-8?B?b2tNL0NmNWZYeHd6b3M2VHZldzRqL3dCTzhtUFA0dUxxM3djRXp3UlRWZjlx?=
 =?utf-8?B?cGVGZElBOEhaU2VNaHlwYkJkSnVUNHhzNVZwUHBuL1U5eGUzTlZVNi8zVkJy?=
 =?utf-8?B?K3hXM3dMTU5rVVk4WHVrTlJpVDFDM3VLb2ZPTjhQaDd6RjNHcXR2NUxCZ2JF?=
 =?utf-8?B?d09CKzk4ZnBBYXA4OXhHbVlMOFVTWklES1Rwa2VKQnpQWC85UjN3SDNXdjNJ?=
 =?utf-8?B?ZUtBeE9kK0QxczN6MlJMV2g1VmVjazBqMzZlcHl2TFJCTG1XNWtQWmRzc25E?=
 =?utf-8?Q?zPtDtIuQ7B/RF26k=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6182b9f4-f9aa-4eaf-08ac-08ded8195325
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:07:22.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sspo+UvDDnr0RTJW8HKXXeBK6h0QDSmsUDO6/0/uhc5PYlQPfsNgNBx58bVh2lHqfNRSPjEwUGNQ7cm/h2PXlY4ZhqHnepst0fyUiYnR2ZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6050


On 6/29/2026 12:36 PM, Krzysztof Kozlowski wrote:
> On Sat, Jun 27, 2026 at 01:14:49PM -0700, Tanmay Kathpalia wrote:
>> Add "intel,socfpga-agilex5-socdk-emmc" compatible string for the
>> Agilex5 SOCDK board variant configured with eMMC storage.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   Documentation/devicetree/bindings/arm/altera.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
>> index 206686f3eebc..f5efcbc381b8 100644
>> --- a/Documentation/devicetree/bindings/arm/altera.yaml
>> +++ b/Documentation/devicetree/bindings/arm/altera.yaml
>> @@ -113,6 +113,7 @@ properties:
>>                 - intel,socfpga-agilex5-socdk-013b
>>                 - intel,socfpga-agilex5-socdk-modular
>>                 - intel,socfpga-agilex5-socdk-nand
>> +              - intel,socfpga-agilex5-socdk-emmc
> Do not break the order of entries.

Ack.
>
>
