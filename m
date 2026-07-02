Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3587A2DC79F;
	Thu,  2 Jul 2026 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982710; cv=fail; b=AJrVoL5O+xAB+xTOlQrf7fN2sqG+xQZEBjM39MyIgIcX2tab0sD04n/+kfskDCe+gUkcS/RQJJMjSqI3xcD2d73POpopS8a0fxjvNAHeXSOCR/cHkME0avTDd4jpgzvX2NWSqASTZBF6jf4BCygZfiqVd5k0OIQL2NBLH0DZ7MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982710; c=relaxed/simple;
	bh=kIbx0Ga1Fy3REHmsMMqQ7VMgZ0W/cexK94vr0hrwmaU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJppMExFwbZNAujzm1ZdPssrpJ/Oj1fiPceKzXI4q8JwnozE72pOzUET9yNUcCUAGooogzpZgH/58HlG/Nn//j5tawy0II1zKzXvASepyiRZvqu4Q+suKk9FNsgygIGP57hUkVNFR7nDwFkhNzVbixKy4r7Z5Sq9XEW6qrWmub8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=FdibQQlx; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="FdibQQlx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaXUS94ibkLIJpHpqVZ66oDw1DV/W8toWnDlw5uVk0HYbt/UrDi34zLKSphVcq0SA3Jo2b5zruYB3ePHy6P4PHnYUlkvY3GchlnuTAZI8FX1yEg1dU5G6WsUoOLciAdFUlz7Adw45YOXs//NM4H+iOYpUyv1CVsSCuKrnPyBI98GkqV+Y6+wA2Gk0e5nJKju+KWqpwTp8Ve6ZdbkIu5RYXeRKqVAlA2AQcs1eHkLAeyguitUhvcr7lSU+Yst7mF8j0Qevl0ec+1rLejeR4ZZ5smrubrrPhF/vwN7XAKupQmTbyQ+2KwAmLNE3QYeX7cR/mqht5A8JzOqaUBAcDk66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyMAxJvHc6B9t3Y2OVGaJTzCJJBjg2LZRjsBIyEI5+E=;
 b=hWAXDL8RxRsHlJngP4J9rSasWemoNR9pVoMu+g7UsEwJM1v/xTEk4UkjJZDBkQJmegh0mxevN8nIYvovLyh2JtDb2GpTuVnPWPrSM4xLvUjgNet35W6uOy2AdyOMvJQqMvB4sY4q1ZaJbqYp+Zbibbru6TJajoKyjsQ6dx+PKfZENBCqgk7GTP8TykjivhaP+l8VVnuy7fjWU3/NxkR47J366tnuBMQMIDa+x1WauYYt5jYzD8m1vrGKLMYR3UgIQF5ksWTLGeiyoSBU89RF5WRxFmFKVnMMPxu/3xtnh2v1beBj8uFWLKRPbLSuQVktmlL3n2zASy5siZA2iDdHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyMAxJvHc6B9t3Y2OVGaJTzCJJBjg2LZRjsBIyEI5+E=;
 b=FdibQQlxJ5sWndDvluNhwFFyv49+UzjbUjQfijAH8/39lHKIsmilH13d4nbqhAI1zi0giOFlwGs2sCGrHjVGJ2gkZr+Z5dda+scDuxwsn8VvByXAhWbMtaAugHFe7VKD7pNSCUiNJVnENwHZZyojGWFYbYP5stQN7+LQIjGtM7gSZ9OkhrilQ/x0Ni4qLrtd53Ucywox/D9v9Z9X54dT83CY48vWvKhmQCwa4D9IfqvscqHMiZ7j04QO9BYsBUQE3WmizFtK6HctiOzXgtUfNn6hXxpdL74TO+SnVxQvtoQtvt8sIoCf7G0Dw/4D63f0UbTNaAK9h6KptabVtTFPWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW4PR03MB6921.namprd03.prod.outlook.com (2603:10b6:303:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:58:19 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 08:58:19 +0000
Message-ID: <6b7251f7-8231-44a6-a4bc-34e61f0e4669@altera.com>
Date: Thu, 2 Jul 2026 14:28:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] dt-bindings: mmc: cdns,sdhci: add SD6HC support
 and PHY properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-3-tanmay.kathpalia@altera.com>
 <20260629-elegant-furry-fossa-1fd2ae@quoll>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260629-elegant-furry-fossa-1fd2ae@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW4PR03MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c999aa-9a3f-4318-e181-08ded8180f7b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|3023799007|4143699003|18002099003|56012099006|11063799006|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	eN3yof7QZBkvbclQb7qoVJejm2fmvgZ9ID3bSwKT/ggDC3y42CuSVm7eAl8tdMt5KuvdNahJGzJbIcl/RW/96OqVexdp5miOJoijKD8qSGf25H9R0mVnQclVpfiYJZ8KRwViLn/iU/IQ89CaUB9IyhaQG5OAEon/qJuaW9OfG0AXGuHgx0Ss2ZuSwV19ESJSvIbiPzAeEFLFDkse/PknKqzoH1CsoF3pGwPqRA+BJ8tCObyJmpzzH3jKtmH2lK6RtNZYm65htSKRfFJo21WMNEDaYS+clFeF4hksLh5Df96uJKqbfnpvlj1UB2tmzBdsUasioTDMKqVjISp48NcNaqlGjg968W+LPwmtnp1R47Sgg/ujBaCSp+IWUb7LQO2rH9F6dc5Z5HaqL4f7Rfyc2IKjq6alBOoGLsaZSV/modWlaVM9o8NyaAlRnJlBOf+M+5LggSuL6WTOmAeu9oPoxfsCO7DyV956HUPweqCY4BZ2Vghp9QaxhS00mWWJ+uBGk5Rqz43Mo1Frf5rqpWxR/GWd27MXoRAoTmL5mbUO9VThf5j4Qs1AWrHEKwynV0qQZmd/DQ+7oQtKlrML7Am6ocF/vNvd+KriJ+ehPNhNiaccAJaWrhGV8LoiODcdc7O2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(3023799007)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk9OT3N3VlFYdXpTYWZCZ1BKWnlxV2Z4MWxFL295Q2RnTmpkNFZCbzZxQVRw?=
 =?utf-8?B?blVkTWdhVllsWG45Y3h1ZmVFNXk1RWc0TTJsN2lpK0NBTXFTSkRacHBSZlp1?=
 =?utf-8?B?Rkp0RW85Y1hobCs3N1k2TWsyWittZUtxSzZpYWE3bGpWRHUxU3Zzd0x0K2JG?=
 =?utf-8?B?Q0xwZjZPTk9aaExSbERBVEtMZFpyKzZPazRJZXV3a2VabTNsNTJIL1FvcnIy?=
 =?utf-8?B?NHFLY2Rmck5sK2owUVhxMW5Zc0daVTI3ejRKR0QrcTl3ZEk5NTg0WmJFWGxu?=
 =?utf-8?B?T05xRHpPNmx0WE5FSXhkdjJSODlSdCtaSEJrcDZoVWVXZVNEZ0UwcHY0RU9n?=
 =?utf-8?B?TDZYNEV1dWtCU1FIaFVYYytBMkowekZOeTRHS3BTOGRkSzVQZzNLQWJYazcw?=
 =?utf-8?B?NVowcWdDekExSGZabXJWbXV2MmRpNnFSKzBNS2x0akY3WVEvdTlyS3VKdWNF?=
 =?utf-8?B?NCsweHg2ZGMyazBGZkZIU0YrNVYwdyt6MHJSakU3ZHdKSGJuTDFscGFsWGNY?=
 =?utf-8?B?WUxGVFNxNDVkQ0dHVFFsemFhY0tmTTNDSWJNRGpwWE5xbEZWeURWYWQyZjI0?=
 =?utf-8?B?K0p3NVNrSzlJT3dHdUtXZkl2aEoyQ2ZjaUhGd0N1UGsvS094cjlGMm9hZ0tE?=
 =?utf-8?B?dUlGRk9TTEJVVjZVNmFHOHpCK3dKUTNuSFdiemsrRUoyeTQ1bFZqa2FZK3dF?=
 =?utf-8?B?c0VmVjhsWFo1RDk4UEdBRzZleEllNEtVMnhkZ3M5a0oyQ0RWUXFaNDYrcEpC?=
 =?utf-8?B?MmxsSHVPbEhRQnYwajhxTEp5anpROUMybDNvdXU3a0NIWURtV0hqSEY5Mkhp?=
 =?utf-8?B?QjV6RWNCbmlhMkxpdHZndzRLM0kzWGpxK2VYZGZ2OXYwLzc2dUpyOWdicWhv?=
 =?utf-8?B?UFZtMXRQTWlNRWR3bnN4eDVVL3p4VTV0eHk4SFA1a0ZYYnhrN1RXamRCejQy?=
 =?utf-8?B?VzdyOFQwT0plR1E5akt2Y0tJcEV3bVNXRFA4RFJlK3NKbkgrUGJOVkFkYUMy?=
 =?utf-8?B?dXoxRkF2NlBNa3NpQ0tEcmc0RGRMTXlVVUhKbFBjMGtPY3JDdHNNRzVtTFJr?=
 =?utf-8?B?OW9YWEYyMXk4SE9TTXFVcjhrQVQ0VXRFcXd4QThER3BMbkNiV3dmY1ZyV3Jy?=
 =?utf-8?B?M1lJbUdmMHlwTFZvQjMzM1BpaDdXYTVkWndYWmVXSDJwdEdHM0t3dlAyOWhT?=
 =?utf-8?B?WERUT28vdEd6eFhHOGRiYlMzRFJiT1VUamE1ZlRNcWtaR3FGN1RUdkZYR05Z?=
 =?utf-8?B?Q2kydkI1eDQzeXhWS3FUTmVvcG9PYStubWxJMzlqWVFPQXNia3ZtejJ4T0cy?=
 =?utf-8?B?ZDV2Z1hxb3BsdlRwdXlmNWFjeURYWTVaWTJNWlMyb05ldnc3OXdFendOTG1z?=
 =?utf-8?B?c3VJZFlaOHBJYjcvZ1dkOUQ4WmtzTGd5MFpJT2RMcy9ORFJBT3RYOW1vVWxG?=
 =?utf-8?B?blhrMWF5akgra1FqQ2tzU0tId3hGdEdsWDlCOVVTL2ZLenFXa3VuaVRuUGRa?=
 =?utf-8?B?cGpkeHBwOU1jcHB5Ukg2WGVJc1ZQMVFTN2U4L1hyS0hUSXJoZXZyNVNXVmY0?=
 =?utf-8?B?cWpTRWUxRmZXekpNdk5kZXI2cVovSmIxRG95NE93Uy9PdVJ5bHFzYXJ6NXhS?=
 =?utf-8?B?a01TNkVIdnR0cHc0azNBT2JDWGFzSnhxMnU1UkIzemZ2cnl3UUVGWC9vVlZN?=
 =?utf-8?B?TktQOFBSWkhZRnJDZGdnSE5KWHdKOFpsRmRhbHliak04WG1TWjArM3pDcktZ?=
 =?utf-8?B?RjFhdHJGOGdwbWp4YjBYcWtGekRvS0xqSTFlQ2JoK2VtaUNwT1RydStEQ1dR?=
 =?utf-8?B?d2xPRW4yM0xtdVNLWW05S1ZEOW5nMFgwQzhxbERvK3BaZlhmT056Rys5NjN5?=
 =?utf-8?B?TWIrTU1zTlA3c0dNWlVNS0pPOUtkbjBYOGZBNkdLczRUb3FiVE9OSit4VUM3?=
 =?utf-8?B?NXFvbzRIdC8yL2FCZzFUYXpmdFZwbU9Oc3VUbDBTT1JCckxOM0VzOWNwOVRw?=
 =?utf-8?B?RFRxVjF4RG1XQ2pSVStvT1VVaVlZclprTmJlS1FpeEJ1U1dmUEV1dWVJL0NP?=
 =?utf-8?B?aTgxeS9obU9hM0psREtwd0hEaml5K0QrQ3FuNW8xZldHeU5POEZ2aGtiRjNF?=
 =?utf-8?B?YzdKMEhTQ0d0OFhQa0dGeFVhc1dKbkI5eXVmbXZ1TTJDS2duZVJWdjVEbXkx?=
 =?utf-8?B?NWhvQkE0RmlLVnE1M3d0cjY3cXJ1UWphNnYwOXVzYzVNZ3E2YSt2a2NuY1RQ?=
 =?utf-8?B?VFJIb3pGa25TVTJWZjRqU1A4K2dBWGl2a2R6K3llSWZMUVp3bnc1THJwbVoz?=
 =?utf-8?B?WTEyVi93QkdkZTlpL3dSL3Btc253SWw5MVBKQjhuOG5wdlo0ZCtxMUYyUzBo?=
 =?utf-8?Q?c0U5wbi+TYPWeHBk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c999aa-9a3f-4318-e181-08ded8180f7b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:58:19.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywbz6908Kzo0P06YMhsPZ3i7gJlg0f0aLbmVe4gnquIVloV+fHNQaDwn7qchGHmnLS0QZRTujp9ZWBJMnyZOkY44CfOjKp4UeYPGZlyzn3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6921

Hi Krzysztof,

Thanks for the review.

On 6/29/2026 12:34 PM, Krzysztof Kozlowski wrote:
> On Sat, Jun 27, 2026 at 01:14:47PM -0700, Tanmay Kathpalia wrote:
>> Extend the Cadence SDHCI binding to support the sixth-generation SD6HC
>> controller. Add the cdns,sd6hc compatible string with two named clocks
>> (ciu and biu) and three SD6HC-specific PHY timing properties for iocell
>> input/output delay and delay element size.
>>
>> Add the altr,agilex5-sd6hc compatible string with three named reset
>> lines from the Altera HPS Reset Manager. Introduce per-variant
>> constraints so SD6HC and SD4HC each enforce their own clock, reset, and
>> PHY property requirements independently.
> You just repeated the diff. Instead describe the hardware.

Ack, I'll update the commit message to describe the SD6HC hardware
instead of summarizing the changes.
>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 122 ++++++++++++++++--
>>   1 file changed, 111 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> index 6c7317d13aa6..edd96e1d2bdc 100644
>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>> @@ -4,21 +4,29 @@
>>   $id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>> +title: Cadence SD/SDIO/eMMC Host Controller (SD4HC and SD6HC)
>>   
>>   maintainers:
>>     - Masahiro Yamada <yamada.masahiro@socionext.com>
>> +  - Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>   
>>   properties:
>>     compatible:
>> -    items:
>> -      - enum:
>> -          - amd,pensando-elba-sd4hc
>> -          - microchip,mpfs-sd4hc
>> -          - microchip,pic64gx-sd4hc
>> -          - mobileye,eyeq-sd4hc
>> -          - socionext,uniphier-sd4hc
>> -      - const: cdns,sd4hc
>> +    oneOf:
>> +      - description: Cadence SD4HC controller
> Drop description, you repeat the fallback compatible, so this is obvious.

I'll remove the redundant descriptions.
>
>> +        items:
>> +          - enum:
>> +              - amd,pensando-elba-sd4hc
>> +              - microchip,mpfs-sd4hc
>> +              - microchip,pic64gx-sd4hc
>> +              - mobileye,eyeq-sd4hc
>> +              - socionext,uniphier-sd4hc
>> +          - const: cdns,sd4hc
>> +      - description: Cadence SD6HC controller
> Same here

Ack.

>
>> +        items:
>> +          - enum:
>> +              - altr,agilex5-sd6hc
>> +          - const: cdns,sd6hc
>>   
>>     reg:
>>       minItems: 1
>> @@ -28,10 +36,12 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 2
>>   
>>     resets:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     # PHY DLL input delays:
>>     # They are used to delay the data valid window, and align the window to
>> @@ -115,6 +125,25 @@ properties:
>>       minimum: 0
>>       maximum: 0x7f
>>   
>> +  # SD6HC PHY timing properties:
>> +  cdns,iocell-input-delay:
> Use standard unit suffixes from dtschema. I am pretty sure we have
> picoseconds.

I'll rename these properties to use the standard dtschema unit
suffixes.

>
>> +    description: Input delay across IO cells in picoseconds
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 20000   # 20 ns
>> +
>> +  cdns,iocell-output-delay:
>> +    description: Output delay across IO cells in picoseconds
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 20000   # 20 ns
>> +
>> +  cdns,delay-element:
>> +    description: Delay element size in picoseconds
> None of these are deducible from the compatible? IOW, they differ in
> each board with the same SoC?

These values are board/platform dependent and are provided by
the platform integration rather than being fixed by the controller
compatible.

>
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 1
>> +    maximum: 1000    # 1 ns
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -139,6 +168,77 @@ allOf:
>>           reg:
>>             maxItems: 1
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: cdns,sd6hc
>> +    then:
>> +      description: SD6HC variant - use IO-cell and delay element properties
>> +      properties:
>> +        clocks:
>> +          minItems: 2
>> +          maxItems: 2
>> +        clock-names:
>> +          items:
>> +            - const: ciu
>> +            - const: biu
> There is no property like clock-names. Look at the schema/binding.

Ack, I'll fix this.

>
>> +        dma-coherent: true
>> +        iommus:
>> +          maxItems: 1a
> Do not define properties in conditional block, but top level.

I'll move them to the top level as suggested.

>
>> +        cdns,phy-input-delay-sd-highspeed: false
>> +        cdns,phy-input-delay-legacy: false
>> +        cdns,phy-input-delay-sd-uhs-sdr12: false
>> +        cdns,phy-input-delay-sd-uhs-sdr25: false
>> +        cdns,phy-input-delay-sd-uhs-sdr50: false
>> +        cdns,phy-input-delay-sd-uhs-ddr50: false
>> +        cdns,phy-input-delay-mmc-highspeed: false
>> +        cdns,phy-input-delay-mmc-ddr: false
>> +        cdns,phy-dll-delay-sdclk: false
>> +        cdns,phy-dll-delay-sdclk-hsmmc: false
>> +        cdns,phy-dll-delay-strobe: false
>> +      required:
>> +        - clock-names
> All this clearly suggests you should have own binding file.

Agreed. I'll split the SD6HC support into a separate binding
file and address the above comments in v3.

>
