Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29476382F31;
	Thu,  5 Mar 2026 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772712167; cv=fail; b=j7OgaGkhI2IvSRTHRMsg8qxbUNAOOyKq7YfKRms/v64VKusebIeffBKHZi4R24ca2srAYLmLoJP/qkcLm7byewJS3RdLVovykqbeJg6MF4ktOeOGPqpPNDoXClEIJLDhmR0mlSlj+dgcTyBtAEvjBmMezTd63ct2k9PhqgdIDBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772712167; c=relaxed/simple;
	bh=iMRXqwrWpClDoMck3sbFHtG/aH2uKx818C3bEDY7Xg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PCKwwJ7yVhMdWEvUaaQjKwQzU5NrWB6rEe7YwKm29O0E717Er3xR7PSPb06XKn6fq0ccWpibta3j61KyeTu/ETiVp8SMBqiMItfsHa6McrJ4W6gubixcwuUhKdUBlwfyAYWM4dNoiATER05iX3UVxF2Fmv/cvgUGdVVsoMrrPyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZlTAJwUK; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZlTAJwUK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEc0Zd9d9BdImqUwA5PBExE0RYLYrB3YAaNzyZEx9ZEXh2B4oo9iTHiF91nQc+q9oZm2xc8/sNLL1Qh57FJbnMxsP91IeWc6ViVb1ZUr43/ulnSpl/V95QxRjuUYIlxK5G7O1OGFgZBcPoX3Z6XCZbyfbS3Hk1RK3Oqw45M/b6FevQZ8SHuizYtkpOnMNUUzRDhErqvrv6Cgo9JsR0YpYpsOImJZxVsbvkKgWAoL/6DlDXax6nLTNnfPp2+27pzs91eHl8iAyav2mOnpo3hyG+jv69wTcYx9NbqLLOXGxNtQefiUXOb9195SGz+VD+Qeq7ZnmFX9KJtJtA8l0s2ClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG1TudeQk9ppmQbV1RGH2tlS+6/3G62RQhqqec+58GA=;
 b=LwoRDP+ebetu5EP9caIYubS0X5csR4USWnsza16bvFk1u7gw0YFPhj+O4d2LPKNRuLDGcZG0sKC1D+RxLPkmrzgqYTAdHDq2h1/K0uslIyC2e4pKm5yBCFke8xevn1uO6F9UTm67dwJvlJhtHmj+uM6sIG7vbEyIrpge7PnxpcGj8FDsRJXXmkC3njZonMmCPqfGBstS+USjNrIdTxM1XnREKgeYy3IDHJLIAhsiqstMaL2Nari5jn8MNphy/GT5ITeTMne9e9r5IjtRrTHU0RilUTNYECLoZI7r5MLOsKjD4SrZeRRpz/3k0n8YR3E7nvg2uEeI2BUyLHg6MEV2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG1TudeQk9ppmQbV1RGH2tlS+6/3G62RQhqqec+58GA=;
 b=ZlTAJwUKuza0x9QsRGYBjcoOoGywROEAffhWqzDYlCRxwm+EtKCT7Vv0GDLrw+l22cV6WiQ4QEFZkwfHPB8x/ibhUrsMNMPMPuFpG1IdVcbi5FFsklUJtJ/w0Dmip8rsme/mWsvge1ZWCzKrH8KPgQAW33UUJp46m9t1xYkeBxKUn29FpuM+qC5Cfl9NNpTk3sY2PMZ8FI4fxcX6P5U2BXxiJ+8AZMXK9m/vKxLalGOTSx3xdch8udPETtXttmx7/rPfkxqK05xbCcKqZkR5/jSKhcZlz2TrYA/ivVGkf70W5l4XGihwbLg/Z66Ke5ILuVvU092MEPSz9s53FXaVNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by OSMPR04MB11296.eurprd04.prod.outlook.com (2603:10a6:e10:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 12:02:40 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 12:02:40 +0000
Message-ID: <e8e258fb-23c0-44d1-bf4d-e2fed92ad90d@oss.nxp.com>
Date: Thu, 5 Mar 2026 14:02:35 +0200
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
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260226-ingenious-shiny-axolotl-e0e6d2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:532::16) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|OSMPR04MB11296:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d322077-a8d2-4984-503a-08de7aaf1970
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|19092799006;
X-Microsoft-Antispam-Message-Info:
	eo24E/hRUSN8pYRzX4JrRVkRYotwOR78QRHUeb/fVzimLCTh/7TSltALBxvxg7R1yC1ecb0INTfpLVA4lmF8gAc8fylwTiHcGRoEgrqCpau7u5aoPAwTq/DOydfLuKx7YF/DlhEFrtBDCoLf2XZMBGVNJ2aZHKDWHV3rOjbiogsy+cEk1NGk6+VSp+4Ze5DJHDgVHRPeuys7HjD7nY2pxZnlHSuDVCyf0IVYnIE2rskIT/pH1XEd5OC9uVbyVnjlBBQuKb+wH1vxTEq/avVUQ13KomKXLfyyewvBZOA3lEMCw+kwmyEyG+VLq0Zx5eLNVkKIzr6ZA3YMaSu1IDNZLvuG0OJZTC4gpxn0+CNj4Gm91kbwpqTLyp9o/uJYsfXBWHvRJ3R1TxqJvkmIW8gZ0+DTyr8L+ERl+RzkZmyvMDcf4wVXccQsj1y5Bmtam2BNa5gX+cjqAm5Gu9ImOb1tm4bQEA9iB/9mNme/ov2p1uXK6Oszc0GsxTStWe0iKUR3hNXivpX25+kbbwRiCBYSmARXJp94OJhoT/tsp94Rj68nsbLVDnpJUlAEt2iFzhZm9rj6cxQcjQCQB6V5643c+KxJFc0kZGLg8cKMVYs5b59HgKxqVZxnG+YwX5SVUtcKGqMbh7AA4PnS9jwI1aCnX3SU6HOYEYxnoRQx+ecmCrQh0d5ctX9HVqZDIShBeB4OElqHaFv4SS46V3GvtxfM2rjiq3vpKr7JcdYObIQOR80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEh6aHA5UEh2c3VWMVQvelpvekluSjgrUzQrbDgwYVpkVlBsZU8vdUwyeWNH?=
 =?utf-8?B?aUhmMTJKQmZtaVgzM0NqdnQzVGUrMDkrYjUwcmt6Wmc1ZnpWaE8zL3dGQXlr?=
 =?utf-8?B?K1N2MjRHcHZGMmhwTE43M25jbkgvK3NFL2ltcEQ3RlFyd0FZdm92ZHlHaGpJ?=
 =?utf-8?B?a0tWTzdwdjNrNmZ3Q3Ixa0pwbWhka2pyYmt0V2swbENqYjBoLy9NelZhNHVO?=
 =?utf-8?B?V2pRaFpMSlNYWGJleXlaV2tDSWZYRFdaOHNaMitLSXNOZGhEekxJSW1hN29U?=
 =?utf-8?B?dTdEaUU5SnI0WFcrMC9OMUpYVmhWLzZCbHFuNzdyQlJ5Vk0rZkRsbDcva2ph?=
 =?utf-8?B?UGZaamxIeTBjNzNKNEZtd1NQQ250VGV1TmdDSjQ5eUYraWE5K2Foalc1WGlx?=
 =?utf-8?B?L3k3YVpZSWZ4bTZqZmw5MXNiZ1Y0OTc3V3BpWk1iWlhqZEt4REcwdUlScURB?=
 =?utf-8?B?cUZCb3MrbUsxZk5iRlZZem9yaHZ4U1ZBZ3FER0QzWTk5OGJSbXBocmxOOE5q?=
 =?utf-8?B?bmZLM3pCZnhnQ09hblFQS2p3N3hIc3FxSStpdW0wcEYyZTVjbS8yMTRzUjh6?=
 =?utf-8?B?TjRjZU9nS3drWGc2aTJoeGpVdzNIc1IwclVoTEhRcHkwcCtLN3cyenA2RjJR?=
 =?utf-8?B?dWxIc1p4b3BNeG9aaVVUZGdUMTZ1RzUvVEdRemJOeit4OVQvaVh1ckRwdjVh?=
 =?utf-8?B?Q0x3N2tIMTRlVHc5OFo0WVh3dDJUQ01NdWEyWnczMjZzVER3R0lhRVQvcVJY?=
 =?utf-8?B?eUtGVjJvazBEZG1pZFluTlY2N0pKWk1sU2FBS1gwS3pveWs4U3dyazUrRHRy?=
 =?utf-8?B?dnB6LzBrS3FpdGVmVzVsdkF0TFJ5WGpMdlRvRUJ0UTdYeDlxZUVNajhWOVNK?=
 =?utf-8?B?YVJDRGJyWlRhcUtkeW1IMGdXK2ZIQ1JGd0NwQk9RcmIwVS9NTVBzemVqK2oy?=
 =?utf-8?B?bnpTUjYwR3ZPclo0a3J0dWlXSHRJZ2NUV1VTTGxDc2hTOFdVNkpMbm00a1Rj?=
 =?utf-8?B?bitNd0RlMm9yeE1ZeFhpRHpuSnptUUlIZ01XRUhzNHpBTWNtd1ZRdlhSbWRF?=
 =?utf-8?B?ZWc1UHl6VG1lSFZPNjU3ckEvdFV3dHM0Y1oyZFhUN0ZjOUJweUFrVERWVG53?=
 =?utf-8?B?SGtKbmJHZ2RCM29kcDNIZFZmNlB6RTFVaVVDRng2TS9DNW5XVzJhMERDSGMv?=
 =?utf-8?B?QjljL28vampVSWVRb0U2eGlCczhtSDQ0ZHM1TkcwTU1ZMHYwcUYxQ0RqLzYy?=
 =?utf-8?B?TFNPd2VuT2IyZUxwTnNTOTdkSUNUNEE2c1k5d0VsaGFmeEFKa2pWQXFiZWVW?=
 =?utf-8?B?RW16U3NPZE1pZnZmZHFzR01wSm40bnJ1a0RHSGJneE5CellNcGlnR09KRFB3?=
 =?utf-8?B?UnVNa2FOMFJyZDZLSk16Yklra0tkZjY0MkJwNTVRTnlnd1gyR1dzdGVPb0s1?=
 =?utf-8?B?bHJwckNIMXNSc0JwaS9wVzZPcWJqcERMa1E4YmZPb0NVNXZoU3ZFWUhGRG1L?=
 =?utf-8?B?NXRFSEFMdjZSZGpoQTlUdExEcnFUblNWSTllbHJXS1hZZ1V6VmRzTlpDdnFn?=
 =?utf-8?B?d21adlAyQlZoVlZuWU41eER3RWdEejdKL3J4SkI5ZkI4NWNJaWwzSGViY0F1?=
 =?utf-8?B?VklUVEJLM0JrRHdRSFBGaXZQQVc0NTdpdG9HZWd0NVdQSUhsOFRCK1VHbEU4?=
 =?utf-8?B?cGF5eGhwOHM2QzI5NHV6YUpOaUIrelpiSEY0MzJxREtzNm5wRGJoVUh3ellQ?=
 =?utf-8?B?emNKMDF2eE1tM0xJbGZMOHpuQlk5RlNDajVJWFA2NjNCai8zeVBycGc0S01p?=
 =?utf-8?B?ckJCRkowRVR6WFJSQStKck5odUNsdTBpd3VWZjhiWHM3eHF0Ui9HVlFEUmJD?=
 =?utf-8?B?bWI4cFc1M3VucHYvODloZlY2cGJlY3VMYW1UbGdmLzY2TW9lM2hOTG1ud3Rr?=
 =?utf-8?B?TUFlZm05c0Jxa1dVcjM3U3hDQTZkdm1mYnB4dzNKeWJ6Z0xyVXI0RWY0WnBy?=
 =?utf-8?B?VEpGTG1iSW1MdFdDeFFrVHNiUGFEWXRQQlBmSVFRdlZEQThWWTFBOFl5VTlU?=
 =?utf-8?B?K2lxNWlTTVpoMUh2WVd1OU5lbmFCQTRxTmo0L1RMdkovT2ZYbjF5eEVlTE9S?=
 =?utf-8?B?UlhLa1pwVmVxR1AzbmgrVzgycE4xeFhFVzdaUXZIVm1iRm1CaHdGUEladkw5?=
 =?utf-8?B?cHRVb29TSGdzcUR1Qlp6Z0xNdnpiamVsRSt6ZEF2VDI4TDRCYkdicTI2c2Zx?=
 =?utf-8?B?d0Z3Z0JkeVJQQnJ2R21IazdHTEpNcjNVV01PaTRIS0R0bHkxUDUwamt1VDdP?=
 =?utf-8?B?TUlkUmJrMVZKTXNQQVc5RkFycGtEcmEwdkFLYldYUmxqUzJiU2puNGJINHl0?=
 =?utf-8?Q?SO+lzogZCgks362s=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d322077-a8d2-4984-503a-08de7aaf1970
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:02:40.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvkYPac0qgXMS/CzvOr9sKDw5Y9kt6t1cG9gDrS49iTxdlDYswrRpSa6YINEy3Lm71sVTRGnvKekvRzBsYTU6R6Hc/Hq1+0HehhwZ+/VTgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSMPR04MB11296

On 2/26/2026 9:31 AM, Krzysztof Kozlowski wrote:
> On Wed, Feb 25, 2026 at 02:38:52PM +0100, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add compatible string for the interrupt steering controller used in NXP
>> S32N79 SoC.
>>
>> The S32N79 SoC differs from the i.MX version by not implementing the
>> CHANCTRL register, but otherwise maintains the same programming model and
>> register layout.
>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>> index 5c768c1e159c..caf3e4a1f26f 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>> @@ -22,6 +22,7 @@ properties:
>>                 - fsl,imx94-irqsteer
>>                 - fsl,imx95-irqsteer
>>             - const: fsl,imx-irqsteer
>> +      - const: nxp,s32n79-irqsteer
> 
> So that should be part of enum with the first entry.
> 
> Best regards,
> Krzysztof
> 

Hello Krzysztof,

Thanks for your review. Regarding this change, I was thinking since 
S32N79 irqsteer does not implement the 'CHANCTRL' register, it should 
not fallback to 'fsl,imx-irqsteer'. If the driver were to match on the 
fallback compatible, it would attempt to write to the non-existent 
CHANCTRL register.

Am I wrong?

Best regards,
Ciprian

