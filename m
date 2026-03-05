Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA519ADB0;
	Thu,  5 Mar 2026 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713158; cv=fail; b=ljPqpkpvErO1+F1UL/YIuu8aAo+Pz1UUOHBZEzOgEjh58sXBb/HmWsR1uPgLwt4Ob2aCj8/dLIylnE2QPerqtPulu/xoiMwW45Lv3kLDw29UYEDvfTuXVr+hUA3OGzHnoOxAEubxlHpYfg6Sfy0bcQHNvg/Q02coBaam417BBZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713158; c=relaxed/simple;
	bh=YTsSTM3Wl2X5bQHke7DS8Yk/GGC/609TRnPICxtUiOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gdrB9TjBkVVus1dowu80l6PMV7Izr6HumPVwx0zctR5D4xtDSRFS9ZSclYJ2V6gbzs0m1YzpLaFu8aGo2t4bfrKQwu66dpBGYuJWTRGXO/GAItQZazFi5hq3H10c+NkizwaRo3+mkRzI9zyFOyYo7HKu+PwQNYfAdJv4qMQMkmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W4J8c4Va; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W4J8c4Va"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLdlii4Bh6d+/J0eOX2UEEJFu+uTUyT4zodMlxqnjsaobYyr2Tcl47QyxNF5hJoRyAtasw7Mfb+2KNiKmFph3iz/WxDFk5NSvrY4D7taTSNaAwGEsPtQ6XsMKcUOBJFRnYJemzg0c+ilh2QH1XT+juKBAXw85FlYgs8uh/9NvoksiAsr/MX5JJeMOVtfabVn2iEV+yWxobjTgkN5QQIg9aKCrv+nnrPRHYEuXvUTSbg/5wxQ8dn9gPfA6mwv1Xa54uQWKQkmwDcLEPpw+u5W3dOVQgZvraSvCPu+HDiCah/meLvfCwQJKaX2eDubvo9ZDRCvKWU6f0eV09j9q9mELA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cih79mWUBLKakx/rcNsNBsZefEDrA86bPVC/19wwkqM=;
 b=ewQ91O/QlABFkn5lOp+uiL0JPinfVjWMeQ8QEJSRP3yGOMqLOhJQmTk0E+FwjPY1qNEY8KPaf66ffcCezHTs6wbieH5KDTO9VBB2eG90MEc7zJnEU1oI5ACgGdldCaIzgAPlsUiXLWTxxE+g9lMtQK/lrmisEa1vEtnzr376ONKB1BbVMJ/t7zLUVLi+V0UcjRDAKN8N0KpbdbYm5uwzUwVYpNDPM9uM43JSKdeAbo3X4MuzeOnCNOofqNPaqOF1RzcMUe5rcMZpeco1VSvj9jCqWSylEY8Yb2Uiy6hobnWsEdu+FuEjEF9O89TpNKs7K8yb/QHDg278DFfYwuQddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cih79mWUBLKakx/rcNsNBsZefEDrA86bPVC/19wwkqM=;
 b=W4J8c4VaI21XI0For3MQuGuM79bsNHQJGnj1mWHeEp6xRub/z+WcwB5ekNxNxBJeZ5kHbvZQiDxbfYQApl/FoiIhxh/tPtmjW3iSfHPT3v4uB1FlxtCdkg/JEhmUrfSb5RiWrcYA4TeGGMYveJzMFfBoMNx5ojEVmxKE89DRCQwz4MK9KTrXwrUEp4Bk5kjAILLAnHOJm/F5OCRo5DINdkJ5fOV0c505fHxxB8tt8ct6SvxR+m8idrRY7mOfsMIieUeOi4i1cTrQA0el0c02wYC32OVXWOV5InsE7qJTyCVaPZdTs8ZriASvfmlsjth05w+kphhJQFGeOBFqCvsjvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI1PR04MB6830.eurprd04.prod.outlook.com (2603:10a6:803:132::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 12:19:09 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 12:19:09 +0000
Message-ID: <cc421189-a7e8-419a-b028-4e55324c55ed@oss.nxp.com>
Date: Thu, 5 Mar 2026 14:19:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB
 board
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <Frank.li@nxp.com>
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
 <20260226-sly-fuzzy-parakeet-ea9fb2@quoll>
 <aaBkBAvW6mvwoLqX@lizhi-Precision-Tower-5810>
 <ec7a65d6-32e2-4b14-9e48-3cd0920b4f2f@kernel.org>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <ec7a65d6-32e2-4b14-9e48-3cd0920b4f2f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0275.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::17) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI1PR04MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 25149ced-345b-49b1-9bd6-08de7ab16722
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|19052099003;
X-Microsoft-Antispam-Message-Info:
	7PN9uyuTdnDhtBsT4Kyu6CnISokLBLiwP3m1V6SGYwunkASDnenkRgJeCMsURuxtQInGFRy3Ga6UE0dkoqsR6qs0ZZe7Fa5+pgRKd1zlWK414+/sVco0oycELH/Gt2BRJF6zCAw6frIKzSuRhcq1zq8LzCDFSj8Ysu8xrInvH+2hTf6ZeNjwYiGOJ+HOnAOStCLxCD2WOn6LK/NUTe8GIcj3n88ygq8a1KMXvoTU3Njr2kvBN2exQQle42OGM7O9iHPPx6ZqFXbkE02IYOY1rXPMmjtbX4hHgKkmXK/ybS1S0SiYg7eD4UBIkV2dhoV27EhPOow8Ta3Zo1YSlgAesdE7enHNXk4hB5m0dCtPxYMtLg8GbI3AuR9W3XqWjPkchj1vxvjGHY+LesfsfWzD0+T0xfUXnFxmOLKWb0F8uj7KS/Cc0qEb0s/4uI3TJXEtX+La79ZOILsc5aRejLrIi0Ck+0pyanyA9WAFo5zqR1G1LrsniWzjjGNnM7wWVVGAAw3BM3AmIwMMSXCngwd3rj/sVDcRn1rtvrYYzzsvzyieNzOSvh19noidbms7XYEUufzqGBT4lERcpxzbRgJgaPxAVkZ3J4TrIn5ZGzp2KNpxPjLzrLwv0HghFekKg4x2kBWW8/2PD4uCmQfRm/zwUA2jsoJku80d8wchJiqvx9YQHmSjD9Dk97NKLGKHfCJsqYfgk+jmReF9pddOclgpQ/cNN9RHjNVnNE5miXrWUB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(19052099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1lnK2tYWWVnRm0vbVlxbkI1MFFmMEgvRE5vZ0UxODY1V3hqWWUvK21Zbjlt?=
 =?utf-8?B?cFJ4c1VJV2I2YlNYckNGKzBZUndTejBTcTFMM1czMXNYNzFrMEI1RFE1K0JE?=
 =?utf-8?B?T04rNzZkU3NqbGdZWVVZTlBuNmw5RnMxamNqeHY3TnBZbDJoREtkWjYyRDdI?=
 =?utf-8?B?TktQZEpiV0hCTVIvZEZyeEVsOGwrK2RtVzl4aUtrRk9zVXVaQ0FlUVowVWVr?=
 =?utf-8?B?L2EzTzJ1L0FON3JGN2JGOFM1clN4SmkwcVBhakx0KzlRSG5xOXRxc0Uyd01K?=
 =?utf-8?B?UzM5SlB3aERTRFluaG9mZU56MHA4c2VYMmV0V3YxVVpOZUtIamdDejVNVnpi?=
 =?utf-8?B?ZDdjM2VnaXNUUjVWNFNlTittamttczBSSTlncmdnUHhDb0czdGgrenBvbXFK?=
 =?utf-8?B?NWhQdDFGYUprUjBuVXIydEt0N1FpRjdOOTZOSHRTTnMyVFM0cERFR0kydERI?=
 =?utf-8?B?bWw3ekpHa2xZbjQzM3BiUWVjeUVOL1lRcjdiNUVxZUU5bUkxb1RJbE5vaW5s?=
 =?utf-8?B?azZpd2ZsaEpEbjlOM0d5U2hScGxDTXdHUmZxcG5nbUc3aEFlZW9udjA4TkUx?=
 =?utf-8?B?WEx6QlBqeEhyZE5CdVYvdE9JQk9iRFpuTHNESDhMSDZrWmlTbUNKeUdmRFg4?=
 =?utf-8?B?RnRJL3VpZEZYU016a1NYMndNWVMvVnNZYmUrTkVZdmtuSWRpTEc2djhWaTR5?=
 =?utf-8?B?UjFQbFpoeVByanQxVUdFRzNmRlVUZ3VmTEJtMWsyYlNWdFB4M2pmN2JGaWhr?=
 =?utf-8?B?Q1U0Rkl4UkQ3aGRkWEx5MWxTYjhMamZxRk5sRWgvdTNqcFo3cEtVOUNkakx6?=
 =?utf-8?B?SHRHMUJqMldmMDBoblFZalppUGlLSW9OVzArMVRQTmdtckNmdXIzRitqclRq?=
 =?utf-8?B?MnRUUWh5UlFhUm1VcGxHMjFPb0lMNmhBbWZPYWtiNDhTOERhUHl1MnNQdUcr?=
 =?utf-8?B?MjIzcDdaYWpHTW9zN3gxZ1BWZldnb1ZQTkFpVjBObjZhRWdqcEIyWkM1ZEdM?=
 =?utf-8?B?dTZBVlpCSEdROHdCMU5BSFFkOWEwLzBGUDYwamtueGMvb2JBV1BrQzNFcVhB?=
 =?utf-8?B?bFg0ZmNmUlkrNTF6a1FkWThzK1ZZZHBSbzRZQklxa1RBVWpBZFMxbG0rdTMy?=
 =?utf-8?B?b0dJMDJuM1p2MmpwRTFjZE1CdzQrak05UDFCRTZWbEpVMi9VZllUT2dyWks5?=
 =?utf-8?B?OTlCdHhJNDdqbHg0MG50LzdyZGc4Q3Y4dDZGZ0JOTWxrRFJ2UkFIWGZjakcz?=
 =?utf-8?B?SjdSUkQyK3kzallzQ2lhalpKMUc5NE4vMW13MXdWbTcwQkYrTVZ2Z0FVTFI0?=
 =?utf-8?B?UHY3d2xodUNuVURnZm1kUWJub3liOFVvaVJZY25wcFpodVQzUTRaUjFja0Na?=
 =?utf-8?B?MmE5eFBxQUNKRG9zTGFJQTdkUnRvRGtMM1Zzc2NVRU9Eb2s3VVNPZzNsOFQ1?=
 =?utf-8?B?NzFQYU1qTkRkZGlMdXpTUUZ6N0RlVU44NENtVFNUTkNLSlAxeTJMUGNUbFZB?=
 =?utf-8?B?RS83b2VFMVRDL0lXUlJ4bER3UFhDM08xdk1Idms5K1pYLzBsVXJIY2pueU94?=
 =?utf-8?B?ZENvcU1ZM2FDM1lKamNIL00wdkNvT0N5aVE2WlA1eE1mVTJMa2ZoeENrdjZ4?=
 =?utf-8?B?ZGo0alRBcUdxczJwWHJVQUhZczhmTUp2Ry9aRG8zdFRvczRvZXltUWlEa1lE?=
 =?utf-8?B?YmZHSTZlQkVJUUdqY3UrbUxBR1YzcTU4SXlKT3VYbE5KejdTZDl0MmxCTWNw?=
 =?utf-8?B?K1lCYzRjamFXTHErdjZHdlQzaHVhc3d6eGJuZkNmQTFpUHBsL0dEL0pGUXZS?=
 =?utf-8?B?SGNqb2lCUldGaUdRRU4yR1QzSGxUMXg3YmJnaWtRNzhzY2RTRk04b2tiaTNM?=
 =?utf-8?B?MUI4LzU4SDNiMjBkUno1bGl6WldkaGRvd3pLYmlSQldLbjVNQWdlcmRXQnlG?=
 =?utf-8?B?OGg0S0RYd3NOUUNneWpPZTJQMjY2NWg3L2dVUnN6RTM5WklIeFJSbEprZjMz?=
 =?utf-8?B?eFJLN2hwdTlhejZmSFArRjdNWjUwOEZZeHU1MU40SkNTTE8zOUZLdDRUUXl3?=
 =?utf-8?B?SXJ2V1RRZHE0cnphSGNqV3liL2RpU3RXYVBnSmUzUmNHWnl1Ni9qRWpHRmJD?=
 =?utf-8?B?Ym9YYkRsT1NuNGxBbHRLc0w4LzJmUmlGVG40N25vS0JjbVBNb0lmZVJuYjBy?=
 =?utf-8?B?TlZ1VGVzMnd5Nm4rSEZzTzlESk55N3llTnRxWGdYbzV4VlpmRVJ2dWxEQUpI?=
 =?utf-8?B?eEhpaFo2QXFBb3JiY2RvcUlmZjZva01VUGtxQUh2a0RVMWNPa0JPSUd1bXll?=
 =?utf-8?B?MFZhcXRvVmVPNGdYTEpQOFpReW03cEVYY29UUnI3bVM2VjlXRWNCSzRwVURm?=
 =?utf-8?Q?b4y4fk2ewfUe6yO4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25149ced-345b-49b1-9bd6-08de7ab16722
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:19:09.3225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5gD7MKxbYIZ6mAaN3ZNVndIF8JWtVwaK8yr5aqKQmE2EMqatlFYJ5VKCk5T1eykt12pyflAbWXKnqRGbsgkchZb4IS5ljQ49KnBxBk97LY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6830

On 2/26/2026 7:00 PM, Krzysztof Kozlowski wrote:
> On 26/02/2026 16:17, Frank Li wrote:
>> On Thu, Feb 26, 2026 at 08:32:16AM +0100, Krzysztof Kozlowski wrote:
>>> On Wed, Feb 25, 2026 at 02:38:54PM +0100, Ciprian Costea wrote:
>>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>
>>>> Add device tree binding documentation for the NXP S32N79 automotive SoC
>>>> and the S32N79 Reference Design Board (S32N79-RDB).
>>>>
>>>> The S32N79 is an automotive-grade SoC featuring eight ARM Cortex-A78AE
>>>> cores organized for high-performance networking and gateway applications
>>>> in vehicles.
>>>>
>>>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> index 5716d701292c..415081423a30 100644
>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> @@ -1827,6 +1827,12 @@ properties:
>>>>                 - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
>>>>             - const: fsl,s32v234
>>>>
>>>> +      - description: S32N79 based Boards
>>>> +        items:
>>>> +          - enum:
>>>> +              - nxp,s32n79-rdb
>>>> +          - const: nxp,s32n79
>>>
>>> I believe these are ordered by fallback, so s32v > s32n.
>>
>> Previous use fsl,s32v234, now use nxp,s32n79, I suggest keep consistent
>> with existing one, use fsl,s32n79
>>
> 
> Ah, I missed that prefix is different! Well, that I don't mind, it's
> your call which prefix you want.
> 
> Best regards,
> Krzysztof

Ah, since they are ordered by fallback, I will keep 'nxp,s32n79*'.
Therefore, I will leave the order as is. S32N79 after S32V234.

Thanks,
Ciprian C

