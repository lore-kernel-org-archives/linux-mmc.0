Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45C3D332F;
	Wed, 25 Feb 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032966; cv=fail; b=LJs2gVdKfLxnvpF9Eg+nskOM1GdLlNgC4tJ6OIr0VCMtrMJxcrDzvpVE1CIWBrk/KxpvJwbGm4seNxJ6jowUabpn8aiD+DuAdcdRgrHoAVjgPKyo8HYUh/p3GVFkGBatQIOHOb1LGIhJP4r84/G/TonyNm2BkqMLIzm3YMXPjJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032966; c=relaxed/simple;
	bh=iBs5XJfJPiTZFZjSr0yYa1aPVso123EvEXqckoAvR5k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ruEXeZuVOMkbQvHe9VPyTdCZKJlilHZjAfVz8qkCLEGOTqTOncsYdF9HPNSFKtYfq1K1PUpFxS09HqIFhOXG0kipPsHOjdxvCsJLEZq0EZhxe5+dTqPJ8JRbC2pHvxTuaeXCaihYNwdgq4rULdBWmpLIJ3uDAkr51yJKThP7SVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XiAnPOA9; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XiAnPOA9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA6/oi5oGiPzLqHhrxuupnW+G4bjn6s8X7Ha/KwEDMVG0R4uob8LywtYnBk8aTRJXmZ4iLXneGa7m28nt1Jy48ySZ7G/Y92TC54jRJQvjwXoyMcLo6t2+hPrJq8s00UI4MGmSHBpJ/QLZsbqWt+hYHaXAuZuLcULFS1yc+KSPjJHDtWCufV+Lnu90XORkoy5rCpewT0aJYqdYs0v/FIA3O5ycbHpq1dkGdj1nOL/aZP1d3bo/jwo2eSXP/OgxHqs9MxeoAptkOPR7QY56yAVLWXjYpcOix+HPvHUsljovRlAfplfQDfpfB0HVjg9lg/2v8hjjTXWAOIwGhcuZkAKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hEjJIoL4A0h/h4k+S2k909iPynmzJOz4bv7GL+yrUc=;
 b=eOXliLU7J7hEHn2dF1ZTcjGCt6XrFW6Av9tnVSa4LPCNMQbeskVia1t9ZJ06+QLcF6Pi3TucruvEMqWXaZTYa/DViRCRNs2pDFO8eWP7/Lq8j7lOm1Cl7d/EyLDCEfwpvLoqPOYup+3OeplJRHBmWFXBytSweuL1ZDjKTi46W/RE/eK8aSM6Jzx2e8uEtkjuz5ovtcEj+u69Xd3zANNDjL/wd9YsNlYp0lpljy4jZIdMoBnigZYGuTgcOi4ZjVm2Z/eQbO/X+o+wdIENUSnD7V9tM4Fw2WMpvUQhOANkQNDPJKR8kvOx6FlqtCQXppe66nRDGiPLcK+vqL4T4CKcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hEjJIoL4A0h/h4k+S2k909iPynmzJOz4bv7GL+yrUc=;
 b=XiAnPOA9n/c2Sfplw7k2fT+j1V257gEa6mzBXq/4S12R74rTE0QhsYfA1/RylDuxcYLaikfdkEQbIqnK1gBkeDYiLeQfKwwrGc54SJFMgVfoN5XA8no0x2ZkPuvIhWCBEfEuuHnDnyJ7GMA0F3dVQzQNlA7VbxM7ccpksLe/aGEWIZg9poMR5knSpWOGFUBgUJpVGMMxB5H4O9j/L3pEyZYl+NKtKxdvL+kw/hz4t8SS3AgdWXXkejGDmC6CGTE17QXvTKGZyqtQF4J5rE/yIXbMqP60Za5KoRcEa1yj5XfO/IwhCkDRljyYCRArRx/dmQ1ssCneuWT7xP2sk6F/Vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB12233.eurprd04.prod.outlook.com (2603:10a6:800:335::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:22:41 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:22:41 +0000
Message-ID: <8902a3d0-df5c-4b40-9de2-be31939899ce@oss.nxp.com>
Date: Wed, 25 Feb 2026 17:22:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB
 board
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
 Larisa Grigore <larisa.grigore@nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
 <20260225133858.8026-4-ciprianmarian.costea@oss.nxp.com>
 <aZ8TXTzYOVaezpCz@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <aZ8TXTzYOVaezpCz@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB12233:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b4dbf1-3736-41e2-3f0f-08de7481b74a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	ic9/n4WhtTA8FJ2B5zk0cH7Gz+xr7ATOGOkI24bi+usQkwem7K6aLe+fc2JLdKWuW2gf4PtNzukiRIn6Nz4yzxt80yaiyiVbR6blSKJYBjc5hKbCrBRVBNsWG4aMFDm+DUNQ4X1InH19LhRc9xlsNBL5NI7n6F9FDc/XXqUqbx4x3uJX4PD80vx86ddCs1bBlNj3DS8RohSo4Hl4L2hBCVJIu2zFXj5nglRGWvLc7OsLomm1sp5v6AIsvcI3sJX5DsIygC32RuVdrus4zlVPZJXzuCNKPyMo9IRf25fo3W2WIyJBFLU/WRAIkrsVm6B50JmE2wfrtbZLGMDG3REewFZYlHji4Jx9z4sDSsjqQ34V3tX3pwLQwM4VzbKB9FgabSpiPirYRuwpnHQ9dRlBcxbcu6uMsrlVtmECthiaV6KAGqPuxUaYSVM30jDyk027k7VXKLy5CM5oUsoGJRvTI4u+XoTkc+rfaZSS8F2kemIBOuWszOa15iTUv9R6X41wIEttpdHn77ma4NHj0ydJdslDgGybP3YHksbqvxwk3nbhhYAaboh12LAAvW3v6LiegeIvhceP48oLFQYpQjI4Aonh6VpfRDbA8MiCHE1hrZX4jmskeesnrFY3Jo9nhV/2WgjmWOyQern6DpYX5tRb70cN85D+IjaRsH5wU/U7wKVdJmUn9n7lksspMRNlQVASOJw91kZpUNqXh+Qi5J3BUMknrmXIDCEZuwn1ZPxDpV8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QktGZnRDbEhhd1FvWTk4WWNidWM2UnFGK2tlZ3AzTTE2YUIxMEJ1RlRzSDlp?=
 =?utf-8?B?L1FQZ2JkMWtRTGFwWENxVmU1MUw4V1Uva2V5YWMraUhwZC9vY1dlSzlwT255?=
 =?utf-8?B?bm5kblFDY1FlbnRTMHJwTUxaV1pUeHN1Zks1a0YzK2x4UzFBaUdoYVR3MGlY?=
 =?utf-8?B?Z2RjdXdzdEVOa0tNSTdoYXpsRmNPUlVQRUIxY3NmdExxQ0Y4eXIySC81OVBW?=
 =?utf-8?B?d2RsZ0FCVkQvTmQzelJyNG9peXFCbVRYSzhVT24xRjJReTlibnF1bzk1a1FY?=
 =?utf-8?B?NDRIMkJyV2tCREJOL0lYcm9jVnlDRG5LNWJPdjltUWJORkt6YkNtbG1wRVdL?=
 =?utf-8?B?K0l3V29KeUJ6NlJPTGVOcEZZOGRUL3lVeWUwdTZheGcyYWNpWFBLWUUvTFZw?=
 =?utf-8?B?ZjdvYkI1RHQ0OHd5OTF6WHA0RU4zWWtQQUdPRWsrWUdxOTlqZ2tDOVVmY0VN?=
 =?utf-8?B?SHYzNjFxanhscFM1QVFoRGFCMGt2UXFibkg5dCtrZ05LbFNVTXdwRlQ4T3J6?=
 =?utf-8?B?NE1rbHJxK0lLNS85N0Y3ODhXWHBVWEgxMXdnK1gvc3k0d20veDRSRUFZNHo0?=
 =?utf-8?B?Rlg5OUZuSStEM0Y0MVA2NzdLV1JiL2V0a1dyZjIyM2RDNDFqYUNjMlE3L2JL?=
 =?utf-8?B?REQ5NFNPOURNTkFEMjlYUGgweVgvVTJjNkZneVFTaXZkRnhoRW5BRVVxN3Zl?=
 =?utf-8?B?ay9YUC8yRVpNOVdnNlR0VWZGZjJkcDY5UWd4WXdFUUZFTGs5ekpCTm1kNHV2?=
 =?utf-8?B?M0F1VTJqR0svZERLOG1ZUnRRVkY3amR2NVYySnNqTjhxaUJGSGw3UUZ5M2pK?=
 =?utf-8?B?ZmxnZzJmWXNxbU1hVGRZeThxcWgrZFpHVWt4MzBwOXR0MEJrYmxwV2VjUVVo?=
 =?utf-8?B?QkhnSFVNYmpIZVIweFI1WW55TVpxNG9maWNjZEFVU0pvNlFiL1pRY1JodjZm?=
 =?utf-8?B?VFlKUGgxSFhRV1JMdjVuWlc4UXBjYzQ3a0xjR3dYb255TlhlVjc4amtLTnZx?=
 =?utf-8?B?QWdMTXdSTlFYZDFxNHdTYzlkNk5VcFRDZVduUERkejdmSjBFMTA5MDlVUmxZ?=
 =?utf-8?B?NE1HWjhGQUIxYUFMVlR1TmVwbGJzNWRIYVUxbi9YaEdHT1BmZ1V2T0NCOFVt?=
 =?utf-8?B?TVY1ZFF3ck9aY1hEKytCTjF0Y2k2K3loeUthZEdTM2tVSDBqbHJLTnQwcU1O?=
 =?utf-8?B?SUZjamhyTGlxb2VnNVhhS0t0L2JnMnZtVllsMEJzck5UOTFjTm9kSzE4M1VQ?=
 =?utf-8?B?Qkd3R1RPdUp6dFRoRGFYaXBYbW1JSkVmT3JsOXR5TGZXUlYvd01Lb2M2cHFY?=
 =?utf-8?B?R3pJYlVMbSt1VHhuTGlUTVN5dk5kaElWTnNQbUZlbWEybnVWV1hyYmlEeXZX?=
 =?utf-8?B?dWVUQ3JBaGdNNC8wYXZYSm5vQ0NtVFNteFRCSExkRTJjZ043NWZmMy9rbEhB?=
 =?utf-8?B?SS8vRXgyVTlIMXV1RFI1NmRTZjBXQWVWM1hCc0JlMzg4bGw1VzJiSFRWdGo3?=
 =?utf-8?B?TE5GWEk3WmY3cmZPcjZKaU9lZ3FvOE02NlZ2d0c5VUQ2M2VFS1lzVGlHeHpR?=
 =?utf-8?B?QklNNUU5cVZITThkeExHQmwxVVB1TmFwY1lBVjBleTZ3QzF5aDdzS0hMd0xm?=
 =?utf-8?B?SmNZYTAvaUpKcUlMOU5Fb2RrRGpHQW1peGlhU054L0tzUGlWOTNyTHdwNWlo?=
 =?utf-8?B?SE1hUmZLZ0R6em5RQnkyTi9uUlB3Qlpqbm5lMkYyQmhxQjYyR21UZktvNzJM?=
 =?utf-8?B?RVgvblBXOU5hcVZwMWRzWjB3M0orLzRTakNsOHZYUll0N3hWSWtBdWVROXhP?=
 =?utf-8?B?VGVIdTNCWWZuR0xIdG11RXpYaDJlVDhzdkNuUlYrN3F1L3hiakNhM1VTVkVP?=
 =?utf-8?B?VW51RS9mTFBxMGRLTUdLd2NTLzR0MGRQb0F0UjlLL1pjUmxFdU1SRUxuK1Rz?=
 =?utf-8?B?Mk5NMVFlak5rOXVERFVZVU1aRUUzL3ZBVTlZU0FSSGt2MGVYd0UzQUY3clJs?=
 =?utf-8?B?djBCMC9qNDJJVkk0b0cwZXV5anZkdWVTZTJ5NU1FYkRtWmlyNmdZZU9tSENG?=
 =?utf-8?B?TFB1eFFXaDhPL0lwZVp1QWoxYWlMMTBwSzVXOHZib05QWi9HVjd5eWgyUTh0?=
 =?utf-8?B?UWxIdXlqRVhYSVpEU1hZWVY0SzJtSXY4MG1zOVhBT0NFcTUvemRDRkhZaCtt?=
 =?utf-8?B?dWZXaXlwcXIycVAvbkM0MFFYbWJxVmVxdHp3MEx5K2xhZUx0dzQ2UHRqRFp4?=
 =?utf-8?B?Y3Q5bXZBemhMZmFNNDVIOU90VGhwakZOeWZ4OHp3Vm82SGwrZ2l0Sk1QZHgz?=
 =?utf-8?B?LzlPc28yVW1GYTFncDM3VVlURmVVN2V1cGhvT1J6WVREY29pU3E4K2tXZzNV?=
 =?utf-8?Q?mQxBmf1SWbxrj5qI=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b4dbf1-3736-41e2-3f0f-08de7481b74a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:22:40.9939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnk7XLfPHzVPVLWp5Z5mqmCL6gboYPCybszViJCpVxMIAmT6KqHdeTufDeibLttsOaY+0C3x8RfqlwrD7+kvyZUQ8V4HpuWQkPYKMIShViA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12233

On 2/25/2026 5:21 PM, Frank Li wrote:
> On Wed, Feb 25, 2026 at 02:38:54PM +0100, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add device tree binding documentation for the NXP S32N79 automotive SoC
>> and the S32N79 Reference Design Board (S32N79-RDB).
>>
>> The S32N79 is an automotive-grade SoC featuring eight ARM Cortex-A78AE
>> cores organized for high-performance networking and gateway applications
>> in vehicles.
>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 5716d701292c..415081423a30 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -1827,6 +1827,12 @@ properties:
>>                 - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
>>             - const: fsl,s32v234
>>
>> +      - description: S32N79 based Boards
>> +        items:
>> +          - enum:
>> +              - nxp,s32n79-rdb
>> +          - const: nxp,s32n79
>> +
> 
> can you put after S32G3 based Boards
> 
> Frank

Sounds good. Will update in V3.

Regards,
Ciprian

> 
>>         - description: Traverse LS1088A based Boards
>>           items:
>>             - enum:
>> --
>> 2.43.0
>>

