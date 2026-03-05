Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013019.outbound.protection.outlook.com [40.107.162.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06B33509E;
	Thu,  5 Mar 2026 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717542; cv=fail; b=ExiFnBA6pjrf5d1pclAumFLLPNheUwgLnn/FLgJpCvQf8ly1h87cKC6BJlIPbL40nSWy6hser8ErU16syS9v2qPbLlpzj7jzGLjS2yK/NIW7jatE1xyh8iP89U4aq523PinMdPCMUPIvJu8/lpeFufW47N2gmGC1OvjA//pa/lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717542; c=relaxed/simple;
	bh=YGWsVXU/CM9j35wlzfk8dGO0QjCu7G6t2k0t/xFc0JA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VC6WgGgaI8tvJHsbGKyP7W5q07w9xC1MglXZiw1/E1Tt+tE7kI2zOEwlkXK4periofVXFdrYICD8fomDEQwehdwPxXU+4errH6HZVs+3nLGkUvJqSXMOXCICbZmU6I7TrJJL7OE738AlA2EoQY/96hCPfG5jrVeeFmMIgUKHFxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iPKXaKfJ; arc=fail smtp.client-ip=40.107.162.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iPKXaKfJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdTyddcTGF3cFPsZDTZX5Nj8ne7Z7OswMPIpVTrmYNxyCZi8Z1ZT/nOqdwLscAQBoGRHhwcY/PcNEE3+2XGQugzWLpbaWUkWJy3Rpq8r0NicGhN1mXBlovgZieCr3IrWGTVIa7P0RKqIlzU8ylyGhyf+hprclkUmTrlAnEtzFPL5C0EG/nX6NHTfn/bHgXDtyfGh6VeV8DnAasCgZThsnPbkpOx9Mbewu+3m0dvXGcm6DCZzjd9rpggJVHBvhP6yFUlAVAJUfh56LfmG03vj5M/ZgbohashW9Cgb8aHCcwWCWAxFpay8RNlDp8EgK+oJjHo6r0dX2wvegUOBac9ASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KybW8tUP6bPQfaZAXV8EZj1GpPXt16l3Eqfqa0qV9WU=;
 b=kuzx+PEHNp9jUmvHcS6R7CCJgNET9PHmwXQTFQ5PZ5qSZMWgPMQImOWO0iyzV16wXsTdTO7uXMZZU6tk12B5hH76Eh7m68jcOqmSp11LQXCz5k5noKc9UNJbSpY3m6GmGunLhsGLo5HfMoVCIUMrU+T7ZFqfRyT1pCAmRvg0qAczX4KjP/OIgdpJzoPWaC1guBTqnQ0TqhTqkmAuyRwVSp1mh5RnJSuzfxVR/GVsWeC7lNAsaL+4ZEx93wUpya8REPPazR8FPkk2taruX92eiZC5nwGffb/EQlHhIhw7bw0Qrz4pLEE4psIHpX6xy3UXIZgBVPt0IW5lZstPn7v1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KybW8tUP6bPQfaZAXV8EZj1GpPXt16l3Eqfqa0qV9WU=;
 b=iPKXaKfJaJz1PKex59jbzEEMGQJNoWBgKUcc0bMQ5zLzVVghF5mEdwDDXpegYSwFYdusPpxK3+b0136G//t1NI4a9W41CM6KWAe7mAeTGlRrPDo550H0g5D8yk1c8LvEb4b08XeLO0/eZB1gQEKmaixWjX4FZ4tZtB6di9I/2rLlIyQPh7TSVhn1U5tqRuTUg5O4UCERADJgmXOZ3w9AOExEGCatoVMlBflRljrsPDwc6zTHKajMbNzcXWBHvEsD2DUhLtMgbk4RXooZ9lCatZ+dRD/zh9ST5wEwcjxYRWS9BFdNwV+Bw/laPl8MOptDLysezwEkODI3QV/Sbj0BtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB8945.eurprd04.prod.outlook.com (2603:10a6:20b:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 13:32:16 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 13:32:16 +0000
Message-ID: <38289782-b49a-463b-be13-6cd70e0e25aa@oss.nxp.com>
Date: Thu, 5 Mar 2026 15:32:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dt-bindings: interrupt-controller: fsl,irqsteer:
 add S32N79 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Larisa Grigore <larisa.grigore@nxp.com>
References: <20260225133858.8026-1-ciprianmarian.costea@oss.nxp.com>
 <20260225133858.8026-2-ciprianmarian.costea@oss.nxp.com>
 <20260226-ingenious-shiny-axolotl-e0e6d2@quoll>
 <e8e258fb-23c0-44d1-bf4d-e2fed92ad90d@oss.nxp.com>
 <6a481490-28dc-4b62-9782-95a32d0e2857@kernel.org>
 <aba2401e-e26c-44d1-b321-56cd18f11a37@oss.nxp.com>
 <e400bb73-3f80-4fcd-91a1-6b9b966c5e2d@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <e400bb73-3f80-4fcd-91a1-6b9b966c5e2d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB8945:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1990fc-ecac-4b70-a038-08de7abb9e29
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	9kOE3AgfGXOs1Z+cZpWAuirMdve4Bs9mjjT0WLOe13OtyMf93uk5BczDWeS5rWusVdQpH7gotxL+PDIWWz8BfAivHdvb8PPw3xko2HEibXADydv+uef/jlytcFmQhCv6yltn1Xu4082M1Si+XWLnBSVF7d2bYJ4N2ZhHLjdCAH4MmBIANhmZyUUylP3DhHNvjs6gjqCV7ZsnjcB9bYOjStZpHID+h8Cuuf3xAmNbRnC3SpWBz9Y6UWJ41p4lz4b2QRzA0JjYW1Vug43/mS9p8+cQmm741uI6JWlE4V0TcUPMxLc1HbYVac8BBJ2KSijMs+WnfnmL/YM/5r3oOv5O8zMePznsCCodGmVNUPFElPPKXA69lJ0hzxoAkpf9LSBkoa2JG65NxLwgqHYLTDc8l8IyiLlt0rBO9m3XmoVzudjeXeGFpbpBigFbNr6LJ6O6Fz7tE+n3vfzZGtzVdZckerqbJUYlIMRSInrOYWDd89Foz4QPX+Qb8moYaq4kCajUzf9+LSO2Zky0i0wi184Dw4jeUpnagLMy4OBfbz2/tRlTRNMwSe9RgfmBTIZLbwMQZcKrLD+460tQRYL83RmtobbLZfn21xuyTXDHfCEC6hsSZBwsQkDtl+t5uw1NLC5fJHiXdh+jLbTR/slha3mZiXijJ/9j/Q9P8GnOHrE9Th4Lk/zkE3mxhiZaN2gmioSsIK6AyT34mOHUEC+hfHKgLSz8s7XUg8kMp20phnNFdy4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDJqT3dCYkE2TTRWUzFTRVVnb214SStHS2JIRU9ROFhuY1k1a05jY1U5THVT?=
 =?utf-8?B?U0I2THB4STY4T2RZTTQ2YVpHVys4bWRmTHkyeTBNZng3UmJzeGt1Yk9YcU9B?=
 =?utf-8?B?cWJVMTZIQ0MvSVU0UkhZSzBpMWtuTnhscDV6K3RMNWtFVStpYTgvbkU0M2I0?=
 =?utf-8?B?OFhJZDBZRXNGdFprbmxhaURxT1Jid3AzTXFoSXIyWHhEdDZyRzNuWEorTGdE?=
 =?utf-8?B?SVNaV0hpQ0Q3U01QTXFicnlwYlY1N0tXR09MeDhXZzJWaldwKy9NQzFxSVNB?=
 =?utf-8?B?RVZ2NmJ2cjFUYnVXbXRURnowUEkxLy9nam1Qc0VFcUNHT3JTMURudEFsWXJG?=
 =?utf-8?B?aldsNXZVQ1NhVVVrM0JmUEZnYjVoRUkzbTJ5V0h2VGorOVZsVG1CSlhiMDVC?=
 =?utf-8?B?dFlTRHBFdTkxeDFjZzFSaWRDZlJFbU00cWMwdjlZczlvTUFDcTBpc25DMmRz?=
 =?utf-8?B?NmNNYXpvMDlmbGlFcElSSXdWQlhQcFNKZGJWeVdBQ0x6ZWRqalJWWExHUldL?=
 =?utf-8?B?dXdma1hwTUhkenZ0cjF6bmg2NjcwUFJ3QVByQ1dhQVNWWHZIdEtOYTNvYjho?=
 =?utf-8?B?SkxDVW9IOFV6Yy9KMml4V1dwczhFRUgyMGcvTDkxWmxIY2RpYjFxL1JkbEor?=
 =?utf-8?B?V0lldldpYnVDb016am1JY1k5MDlldHNDMEVYc1BuMStWZFY1NWFEcDJ1TEZH?=
 =?utf-8?B?ejgweFdteE1wcWdMNS9KcERWUFo4YWJpQThHNWxaQUFiU09McG5GOWs3RzRz?=
 =?utf-8?B?RFJnNFg5V0k3c2ZWMldpTW42TVF5SkZTUUhieVFPWmdNNXdqTW95Y2gxZzNL?=
 =?utf-8?B?WTFqS1l5VDBBMUFkR0RUSmEyWVpRamdrRytwbHIvclBvMHVSRVNVMVJaaGNL?=
 =?utf-8?B?QUd5UTgvTzNFRUR4OStMaFduK0NWZk9JYVRKTXR0TEx4bUhrZE1DMDdSSHF2?=
 =?utf-8?B?VzVtYldVY2swVXhHREpMbVBTdEdEU2JxS2pqempEbUg4a3JPVk1YdXd5dG5K?=
 =?utf-8?B?dlRpUkx1YjZhSEQxL0ZaSlE3c1lxUVBjbWY5VE05Sm8zRE5tUVMzM0lxM01N?=
 =?utf-8?B?cVNQMkY0dlNIQ3QxOWhaT1BIWWFhbGU1RVNtM0ZVMTMzTnd2ZUtmN1NEMG9s?=
 =?utf-8?B?NFMxSWEyRWpLc3RUMm1aaThxRVBxT2JHOXYzdlAyeDdKRnNoVk1nQ1ZkR0li?=
 =?utf-8?B?QzhhOGZVSE9kUk9qbVhNSDNXWmtLL2VMdmxhaGhGL2tnQkpXQ01sYTE4cFdr?=
 =?utf-8?B?RDRMZmVKQWhXOHFlUCs2SnkxNmVoclJEUmMrdGRJME15ZFc4S2dKODZrcGlv?=
 =?utf-8?B?VVdFaUdVNnY3bUpSRjljRVJDSWxUTUNlVytLNmNBS1RkbnNqdU5vWURaT25B?=
 =?utf-8?B?elpGUTBzTGpGUXFPUWRmK3o5TUhGbFR5aDVzQWVTY3BCREVOU2tpMVpJaVBZ?=
 =?utf-8?B?bndDKzNxU3hQanpwOUMxSmdKTm4yeVRaM0ZJQ2lkNzl0MHU1cGlvM1J5dUEx?=
 =?utf-8?B?WXJKSDlIckVBV1Z1aHNWT2xuVVVvWVNpVnNLQmVkbGxUSFdJdWhveUtxRElX?=
 =?utf-8?B?eDIzWkJ2WnNZdTdOS1F5SldHZjhNbEFNYUlJMXd3OVF3RnZOQ0Roam9hQmU1?=
 =?utf-8?B?RlF2VkdQSmE1OXJPVTRHRk9qRmRRZTUycUxoc3lKejJ2Mlh2cnlkTFIrWElN?=
 =?utf-8?B?M3MyNUUwY2VpUU9CeHFKNC9DOENNMFk5U04rYWMzdmwzSnR2TStxaGNQQy93?=
 =?utf-8?B?M0orU2h4cU5pb0lNSFRhRWxVNC94U1dVTlJKeWs4Mll3RXRJOEVKL0dRZDZl?=
 =?utf-8?B?OVN4c3JLa0pWSTNPNmF3RmxjLzl3TEJyaHEwWnJ5WUIzMS9OQjZZc1FwdHpG?=
 =?utf-8?B?OVZwSFJUVTcwYUlia29hT0RoRVJ5Sm1BbHRwZ055MHVzMjFzbDl3V0xJaUpr?=
 =?utf-8?B?dDBVNEI4M0pUQjR2SWVKZDBIUDM5MC9BTzNYZlEyekVKamtJMnBQRkhYNDFC?=
 =?utf-8?B?WTlXamdDUE80MzFOOHBBNFNBRWIyWStobGtGb2VFZWFWYm1KbnBZUWg5ZWVy?=
 =?utf-8?B?TjdZeHViNTR0Sk5IYjhqd205dmVIR2FWRGpYTy9BWVFhVGhXMllpYVhoNmhu?=
 =?utf-8?B?bVF5WUhmYkhKYlVhcmdNTFd0eDhaZnFkWW1FcVVnTHF2c3EzdHJ2N0JYTkdh?=
 =?utf-8?B?eFpHRlFmNlJObXd3a0tGTm82MFdSbUpGUmoraW1mK2pMdVRwTjc4WjVHZDZS?=
 =?utf-8?B?cHVCNHFmM0E0R0VNeWpPd3AzTGdXL1RTbmZ1MTJXaktiZmpLSlh6SUNsamNE?=
 =?utf-8?B?TWxBcWFLNEFTTloxenRTbHo2ejVhdCswUUdwQWZOdGRKaFVrZ0oreUFRTXgv?=
 =?utf-8?Q?rmK7/WcVNNyJvxnM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1990fc-ecac-4b70-a038-08de7abb9e29
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 13:32:16.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQvIJTdgt0UuMnDSMg9aqEpTX02eZEroyNT5cHxQ2+2H25EBF9wq3daSMMNOJPEXskC50yynjHq0r4ZcYPl71fEHxau6GcRfPZ6BkWh4bzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8945

On 3/5/2026 2:39 PM, Krzysztof Kozlowski wrote:
> On 05/03/2026 13:25, Ciprian Marian Costea wrote:
>> On 3/5/2026 2:12 PM, Krzysztof Kozlowski wrote:
>>> On 05/03/2026 13:02, Ciprian Marian Costea wrote:
>>>> On 2/26/2026 9:31 AM, Krzysztof Kozlowski wrote:
>>>>> On Wed, Feb 25, 2026 at 02:38:52PM +0100, Ciprian Costea wrote:
>>>>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>>>
>>>>>> Add compatible string for the interrupt steering controller used in NXP
>>>>>> S32N79 SoC.
>>>>>>
>>>>>> The S32N79 SoC differs from the i.MX version by not implementing the
>>>>>> CHANCTRL register, but otherwise maintains the same programming model and
>>>>>> register layout.
>>>>>>
>>>>>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>>> ---
>>>>>>     .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>>>>> index 5c768c1e159c..caf3e4a1f26f 100644
>>>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>>>>> @@ -22,6 +22,7 @@ properties:
>>>>>>                   - fsl,imx94-irqsteer
>>>>>>                   - fsl,imx95-irqsteer
>>>>>>               - const: fsl,imx-irqsteer
>>>>>> +      - const: nxp,s32n79-irqsteer
>>>>>
>>>>> So that should be part of enum with the first entry.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>
>>>> Hello Krzysztof,
>>>>
>>>> Thanks for your review. Regarding this change, I was thinking since
>>>> S32N79 irqsteer does not implement the 'CHANCTRL' register, it should
>>>> not fallback to 'fsl,imx-irqsteer'. If the driver were to match on the
>>>> fallback compatible, it would attempt to write to the non-existent
>>>> CHANCTRL register.
>>>>
>>>> Am I wrong?
>>>
>>> No clue, I did not say anything about fallbacks.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> Indeed, but your suggestion of moving 'nxp,s32n79-irqsteer' under the
>> enum would fallback on 'fsl,imx-irqsteer'.
>>
>> Am I misunderstanding your suggestion ?
> 
> Open the code. What is the first entry?
> 
> Best regards,
> Krzysztof

Sorry, the enum reference confused me.

Is the following in accordance with your suggestion?

oneOf:
   - enum:
       - fsl,imx-irqsteer
       - nxp,s32n79-irqsteer
   - items:
       - enum:
           ...
       - const: fsl,imx-irqsteer

Best regards,
Ciprian

