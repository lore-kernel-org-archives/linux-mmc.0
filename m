Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644C3346A5;
	Thu,  5 Mar 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713704; cv=fail; b=HnoWr7VaXJmjjqRGcboG7vnOh/JsnICtMxr2QwVKpVXJxkiPr0ivYZ2P3yKluBTkjw/dCGZ+x82x+o4kYh2dUXJsEolzPLntYOGcYG/qlzTDNBUQC7Qutaz1S/XkqmhOECjrTCic0MyTmflf0EjkYel0ecKY6VJYmkZhgWJrCbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713704; c=relaxed/simple;
	bh=pBEJg7p0Gff2sVeU160UCYns7n82o3YJdhHq0tTr+yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tdbVSr0Sde/kbXJbqEyscM4vbNu+wdkai2lcKlI6CK1nBuYR4cXrXGU6hEw6dg2WtFDcAcM6XAS8F6t8tkn+/uwzT8cieB2+x52XmKH1i1U2VEzKYF8+zyW8zYu5rv79u0jtGvrsJsftsjqT4LdCSoJJgPW8dESD70moEtTP5Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=X6SRKmjn; arc=fail smtp.client-ip=52.101.65.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="X6SRKmjn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frAA1Er9vef7TqfJWMi14N/UG54ShkwJze4lyt9ltcoi5ZCswWzGg4YVQDw2ORL1wUqoI286h58FM+lK86w9x26xzAcahvdHc3vsGeVygQd3Lyo7JYh0UbKagLjMfuAZlJyIYynWkdyezsEGskxIu+rpa4iCsQIA044zCRcJocpQZJuxFTj7ZkCYJLBG1T9aIYfGYL9Ecnxy1C/TdhSGONUrYiBXavbXzMXhlm16bgMlQdfYhYgfLIq3xBK7KlSbyBD8uc6uS0EPfJrNz2lxHl5c7Y6wOkCck2FRijPgaaljLp0kwEo/SeNcf7IJnPcuuUgWAufySMaTnbr35qFRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBD/4GeRtN9LHAhgK8KokqKjw9S4WdYcnAqgX4CbHt8=;
 b=VgRVDy+3G2Qxh1xiw2he6AHcZAbyqf4rmS+TiyH41GQqi8rsxUP0l5kBgYOoHkEZcFbi6ydchT6/XO1QkjjEZ8prq0pvBzl1fA9Is0VpcnpbdEynXLg6q+3V3HPOYCZd7vxhAS2YB+LBggMY+TFhjVYLyuiXZJh5Ou9UwiYlzEJp17Qe9O6iagctcusLZZuGpxvGncKKiwODpyiXMnDAiaIcLDk3bDi5e6NZ6LzkciCcgxKYslg8l+u1ox/bh13+OpHwDJEJXUGK7PVFHYID3XK+sC26EwnUXRQ3YtmERYb7/QHGqJiydTR6Wtol3aKBi3fY7aFW2QfI5Bjph1q9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBD/4GeRtN9LHAhgK8KokqKjw9S4WdYcnAqgX4CbHt8=;
 b=X6SRKmjnxztGYifzEXawLK7Bqmm7Ea1s4zldgtCc+xLgbB+Dlpqsvow5pwNl+Uzl82ZgdIJkQtp359ndtO8C22Z0/eJvQknAau4q/8mfq0mAJcIHv5iZX5+EI5aPYQLr8czIhLJS7IgHf+5ilEoHvSB0ZmKintA/79+i39PeFvpkicvp0+xu4knY3E/mkW714tn5lkbjpoOM1Gp7PJArRIpohnQwEV2TkF8u+KzTw2JeP626CqUtNQSl8Y6Cj6EmL5Al2ekWLxN1B/Qvr6tO0UOxnUBxWFQ9l8V1LXxRNsOOWKADBub87vUfskWel1H7EWmVGf+fUDLSxAhy4wa7qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB12075.eurprd04.prod.outlook.com (2603:10a6:20b:740::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 12:28:19 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 12:28:19 +0000
Message-ID: <47ab608b-e0c9-4fe2-bf84-ea5902ccb4dd@oss.nxp.com>
Date: Thu, 5 Mar 2026 14:28:15 +0200
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
X-ClientProxiedBy: FR4P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM0PR04MB12075:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4e114a-ee7f-4ab7-f242-08de7ab2af0f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	XkjRmbE6c8DVYJ8votKIjGdvKUMf5Rs78rmGNAIQ4EKassQPzDcfJtHUqq62S+xwgkEViPcXzcf6zdSGL1QKjU6Xy9nh1tuUAQDvoDuX2CayUnKzNoRP+g8ytNuhPe+9h1oVPOBlyHQPxeinbquCudGj78fHuee1UnzahdasbJZPqnfrWzOuLR+bX+3sjGhGctU41y9D9O/HL/29NOlM64Vq18Q0clE9JR11DNubuTsJicNgHb9e6lEc+weijbykEtZOG5ILcsMnkHFBvigJDXxpxY3s1498Tm920VDfKjwpK6zb8ld7Z7SlHQeCkPSFqW429CyBIndidsa1+j6YZoxluKitK00pENx1nHKHrD3TYy5DaUmKHUTKMbNykwYDlHuqv/dmpPEfrwVSrxt8tzJbiP8TCFLdfT8AmhwwL6Q2SUaTCQCIS4oXilnc/24AcJA+gFmI4pFwGrjqhxFCJ70JFAtJA8qlZGrqQ00axaafD7aerVzdzPIjitEzcgjqcaPp8/pP0d9VEL0eOXoeOSbE5JNZ2lfoau39YmPGVuUy5EPPd3xKUMgmcgpLDZKmD4I36a2oJPTbk0sMpwgshf86CFkxhqCW+v4SgClP1NWWI0Mee3pVcysjtcFVmGkn+Ebt+vnLjTT8gDxBf7dXn1a7LzqyLDmL1HsdmNYy9g6KOaLAeh6nQ5D3vL6bYsmQbAeioxXsCXsrGglbS4OSGRTGNB6AEyh/jiNVll+7ZYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzFIU2F4cVRQZTdaWWk2NzZVMUg1MDErOFg3Yzl2YmJvVWhaNUtXZ3EzSm81?=
 =?utf-8?B?aWEyQi9SUHVZdTMrUlNCeU5Za0xFOVJYMGtpQUV2dlZrSk52b1VwNm85QVFs?=
 =?utf-8?B?cGtWOU5wRUFpMDBDRmRFcGZUMUJQNEJDVW52MHJWdkF2NXFkaFUrbEJRb2NP?=
 =?utf-8?B?MlozWnVDQTJvZGM1UmNsSkJ3eUQ2QzdEUkM2aERHODlHc1FqTUE5b2dOa0ZL?=
 =?utf-8?B?MXVaRmJyV1RRNEMvYUZuMkhhS2lHWnpISndBWWdGSnhqQ2xKekhQaU1tdDE4?=
 =?utf-8?B?ZnNHQ0N2ZUpFRzZmRnNRR1dNRXhyeVEvS0JHdWgxeUZ3Y3hpNHQzc2gyZ0o0?=
 =?utf-8?B?WDZJUE9BWkt3d083YVpGZXNuWDN1b053UDgrcHlsN2hBUFROdW1aL2x5UzdP?=
 =?utf-8?B?bU9aTVQ3WHBtRzRvUk0rbDhZeG9DU3RNWk0xZGZ0dW1pZUovMEZWOTcxdEJt?=
 =?utf-8?B?djF4WXhrK20wRitIYkRLSU53K1hCVWtFNmdQYk4yUC9DTEJkaUtwQ3lLTkl6?=
 =?utf-8?B?ZjdLa2NzNFhSWWVvRU1rMmo4WkkwNjBLR1BGUy8raW14SURKYXliY0RySTJN?=
 =?utf-8?B?bDh1TlpIVlhXOTFWYTlGMi9qd0YzeGgzRjdGQXVTQVBHRytXcEZsMk01UDl2?=
 =?utf-8?B?NEdTSnJJT0hMOTlJNmpLanliZGRsQUk4RUllMlZyTkpBNTZmOSs3bGxhL2w1?=
 =?utf-8?B?KzBZSm5MaHBObFdNSDdPZW1ha21KWG1JOWpuM1FCTW9PVVdyTVEzSm5GWmQ0?=
 =?utf-8?B?Mzh3UGZ0dHpzUnZlOFhRN0VyZ3h3MFRzbzAvclRsRWxVTWN6K3hBbmUvN1A0?=
 =?utf-8?B?NnNEU1hYSEdHZlN0TGFVekhCdzFQRjRUYzhQOVdZT2ZBSTNKdHpPN2toTlNh?=
 =?utf-8?B?WWxmUkpKTDlIZ25hQUVYMHhwU09PTzlWWTE1MVBVbHlUY1grUlZJekFtRThU?=
 =?utf-8?B?bnRkSUhuNDNXT01RWlR0dlFpdkhyUTc0WHFyaGtCYk9hV0xMTm1NdUFlUkxs?=
 =?utf-8?B?aVlWbTVZR3ZyUDdJd295VG8xdUJpSGhoQ3ptcU91ckwzdG1kYWFlbW11aVFX?=
 =?utf-8?B?TjlUTk15Y1JoTEppUjg1SXdYWFJBejkrMHBlbWwzNzdEMXZkQ2VmbEEybGFn?=
 =?utf-8?B?TE5pVHFtZW9qbUZDZEEzTWlaSHRYcmY5SE5YVzBham1QeGhzQU1XNFZFZVdi?=
 =?utf-8?B?d2IwbmZhdXRaTTlHbUx6WWxPRk9ESFNacXdPN21OblFPczZuTlhkWUZRTmoz?=
 =?utf-8?B?UlZJMFVsQjlKVURJaXYwbmtHdmhXY21tQ1ZNMGpseFVreFdMbHNyck90dzRQ?=
 =?utf-8?B?OUZsS1p4UElLR2JnV2lLUkxxUVo0eWZUOVFtWE1uVDhpYWdjWk95bFMzSlQy?=
 =?utf-8?B?a2NjVExEMzBmUURDbmNZYnd2WXZiMlVNdXZER3N6Q09JSktDanVuQnJxZVEx?=
 =?utf-8?B?cXhMQUdMQWtiM2UvcW5XSFZvOUJKQVJHRi9tbXc2SDVvWjJwU00wbEoyVXR5?=
 =?utf-8?B?N3VCUE55Vy85UEtic3hGZ2tLR2lrMEZ1T1VyQkdWcTV1S2t2RjZLd2FPWVFO?=
 =?utf-8?B?VHpwdWdyeGsvQ0cwamZnYml6bEE5d2NwVXNuakkrUzhWbEZYS05WMkZWOEJw?=
 =?utf-8?B?ajUzNWEvTHdCR2p3K1MxVlY4TkNsbUFFMGU0dStjb1pXOGYzYXoyd1J3aXBE?=
 =?utf-8?B?eFh0WmEzOE9QMmM3STZxemtyQm11Y3ZQSng2emtQeklBVkRLZS9Cd1pncTdm?=
 =?utf-8?B?SmMzMmt4eDdKclFnbWxkY1Z2Q1ZUbXpSNVRsUjJHY1piRTRQYkhEZFVHam12?=
 =?utf-8?B?c1RlTk1DdDNIZjN3eEpKcytLT2Y1Tkt1Rk5IcjhTdFUwRWtRZ1JqRVhiN1FK?=
 =?utf-8?B?dnVaVUlRZ2JDY1NtZDVpT2tXT0ZSU0JqSnkzb2QrZjNRU1RJcHBZWG4yaE9R?=
 =?utf-8?B?bzZ3ZFVXRHg1WDFvV0Q5eDc3RHNZQ2hXVnRrOElBQ1Y4UE1WVjNvQkJSRXVS?=
 =?utf-8?B?VFJSUEJpY3pFTmY5YWhOSGNDUHRUWjJ4Z2VLT3dvNi8vUVluQXIvSHY1S3FP?=
 =?utf-8?B?dmoxMFpSQXU4Sk40enBDQmFYR2tFTXhlTmxycS9sNXNwSDUxbkVPVE9DMzJw?=
 =?utf-8?B?ZFJ3MC9jV3dYOFZZUmZBcTVxdm5Rbk9TbWhxMkJ4SGs5b0RnZW84OWhWNzhy?=
 =?utf-8?B?SEZPWTdsVkVjUCtycmo1Z2UzbHJlL0xPMWU5SDkrR3kweUtBbkxTaTNiZjc2?=
 =?utf-8?B?bnRCQkhYL1FNZEFxOGVxaXpwNElDZnpVeHBvUk9qUTBQKytVWGdlakQ2akxU?=
 =?utf-8?B?cWRVbGJqZytrMm1hcmFYSFE5ZUNkcGhuNWZZcmtjU3MzejlVa0R5TkJsQ3dH?=
 =?utf-8?Q?R+W7BJn6c8CIo9aA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4e114a-ee7f-4ab7-f242-08de7ab2af0f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:28:19.5312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7/7scXFbVzlyO02Lfge+HssN1D5XfbYc3S01rMGlAkj4OzQEsju4/BmU4X+igIlRBBaOLG5SC3iGM1KheUQxb35M4+383zhsuugu1lYOaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12075

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
> 

Hello Frank,

Thanks for your review.
I will add s32n79 dtsi in a separate commit in V3.

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

Will update accordingly in V3.

Best regards,
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

