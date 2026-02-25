Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73238F941;
	Wed, 25 Feb 2026 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012304; cv=fail; b=dzu54OEoWM4X7Ms98t8nUsarvsweYlc/kglP3g2d7YGzLFKdaMZasxjrHyPr5JXdJTEQXLR7wmM1Y29LytTSdyHDOj+qCcK0AYDf7Chgy0r0gugeT3NZQRTrHCzr/4LUwIbQUCw+52Ps9r1geECvZxd16ISuOO8ZRLZSXvcqBfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012304; c=relaxed/simple;
	bh=GhWC3jGVy+luCB2Xvzi7QkZyranvSbZkDqghwUYo7hg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZx10dAEkeAsb6sIgVVXjTJRSENE4/cm67QroM7W2uI8Ii8wp62VXRn4PQiJBF1GhPNsSCmX71PL3UDT8uz56Tq80qJ+VgCJoDQfZJrdBa6PQt+++ge8M+GHg7ZJ+b1B3VFYacWdgyNfYH+fl59OKwH4c7bQ/T+uveHMs2xEefg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=p++pCvQu; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="p++pCvQu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RowqW9286H19LGMO7cfuNBcKditS0RcigeOULRahq+4gzJDFRkVDKFRoYu0WvOqIU9ohVBV9Hbzz3NriTo63AUnQSZYq+7M1X92Q/89xAhqBFOxNlUwm8dCwx102Y/uWlKLid2famE2V0wUV8deZVkgydcblEAJTuJ6SxYmUvgLP57tPGH0afN8Pg2bqhJrznUjqCbt/MHVPv0AMIH1ExzOsEdgcW+SQh42cSLrXAbURJuPY6Bq/7TqFFSV8y0murFtiFbW1PoVctKk/Se3yf3AfsmApGFDk6DU0daGjjPO+vEcqxR+mWQqjIrDr4mZ4Nz+/34PAwZRQx4kxuYRaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8Akx+2GvbufW9FvweuS73QWf9j29lb9ATm2R77Cotc=;
 b=aZ21wgtVDKEFQ9ywUNcKQkXopL/x28a27AYx04fI16Va/SPAuk3R1QwNtZa7fREldlKhJZMH29LBwzB01lGfmtOsGUF0YiY92GWdEn8SvhZ7nyUi13DlyQx1iigsJ4RUeRBzIpstdSYQxrGU4G439lSl0WA6lUmkpsDRmTNJeVqYGE6o/61KJQZFmvX0MsleITU+4HR/PCApH+O3c8Q5QPmCVqbTbVumoUKsF8qiIXiflEjknqDEJ9cmVGP7AaVo+edULKYL6YTJnQYnku8MFE4UL01RQIoUaTS+/RLmlde0ZDpqmKApKZrNj4Qc0sWglaHMr73AURj1yMF+kAwEzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8Akx+2GvbufW9FvweuS73QWf9j29lb9ATm2R77Cotc=;
 b=p++pCvQuZvazcO5/3QTKhIu5yUk6QJD+cRks4bMsgi9+BizlT5h6RKBTAC0alQrzY8gjgYhFb7OGTmocJ36m5ewVk/i2/pVajzl2oRX/hSvWLMEUuOc2Gid9Y7N5HprHa5qKPouKRl0MdbnPLzDymxs9H3AtRMjoiYj6eLuVg/O1SrcCjaG4456QfbzgVnyqFX1Xf0anO/d+2CUOMSjO9z8kAw//DIuvAm8ATgE+pRH3s9MYBA7CdWjzs/Nkxn/9hu6Ufb3itFncnfg9Y8Mpqf0Osv0Kd5BafqMmDnuTKcB0rlTvIu0ril/3DmSekU5PCARKQrl/cclnPcD1waRh0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB8206.eurprd04.prod.outlook.com (2603:10a6:102:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 09:38:17 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:38:17 +0000
Message-ID: <7e716cf9-fa73-4d2b-bc2b-9757107ddb6e@oss.nxp.com>
Date: Wed, 25 Feb 2026 11:38:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
 <20260224111533.3194883-3-ciprianmarian.costea@oss.nxp.com>
 <20260224-remote-deliverer-958fcaba8bfa@spud>
 <20260224-splatter-sneak-3ec0e4d1272b@spud>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260224-splatter-sneak-3ec0e4d1272b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 989a722a-48f0-455f-bbb0-08de74519ae3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	ys7ndfRDy+5+3oCvFnqQHZ0+f9e2UKLIyk+YaknZz2/qDDGckhpJOGgP/Jtm3O7TpdsfSm/ZtjaGED3lGBcjSi1Rbf8+W5dHWiYbcu5jmZlQ97HxiUk7IYCyRahvQnJCS0nQdMzhqaYZuZC0m7l8tU/Fx+0bgunDj3Bwrvd5ZXOKxVzyq7NSO4Mzys2+gIeiGMYka0/oY0XbJUlwMZbSpeXU31U3yt5JYvSveaaMqR7gS5YHxtbPuXGpyT7x9Hhm5DzmQtqluelq17sjq2EsadlwKaKH3Kn+TrztjURmHQxnQsgN44CEuIuGaXY3FiJK7T4ByklxqZ04vsxfhI3+5i1sG8l2PedSthvOv80eeaLQIw5HMFn3aogT1eeR9W1F7Q/MpGfsRDbLC6v6t7nspazRjQCDJdoyB6+iX6bBnbUlBysaCyrFRvdUOTgtZnroVN1LjRLz4/+AIK2G7aivm3G6SjxBpaSl46Idp7of5RHEg6AzKcfQ+iOD1NLL7BEjdLmhUGxy39/zF8SDVkc0eRtfzKA2BwgVglA0wEupYhvh1D5qWnZ2s6Qn9wl/F6JBVnQZUx+V/aLov96Ti8Qlv2Z3PUSV1YPVtNWpX6ZpY4oNFNdtrOEfiOvKvzsKSOohbxV+hzaMzdB8hVo78eIXhjUaBq5yUl/nOHKazAC3x9m+JxHCaQEJt7Hch2SWbcWfYz1pB1CTP40o8rhR6H6bJbKSdl2vtMNlgOoAU84LfxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGh6bkRZVmg1NjcwSDFuQU52SDdWRnpSby9ac0Z6YnFIZkIwUkE4dzFVdHZZ?=
 =?utf-8?B?SnMzM3I0VmZ2N0tRRXBEemxUUlV5TUxkVkpCYkthYTc4VWd4L1laWmNpQXh6?=
 =?utf-8?B?bDR6TEV6OG1Xa3YrOXBKRmFLZkE5cGljVjFUaEExZzFpQit5MUxSV1lESnFL?=
 =?utf-8?B?MURBRFZiOHVVbnBDclhwQ2l6OWlqaFF2cnVPZXNycHR2Vkk0M1FWTTlNSGp1?=
 =?utf-8?B?VlpsejkrUDh5T3lHdHE2eFhCdW5qeWgrQkIvcFRrdUZKMXQrUDdQNHJ3WWEw?=
 =?utf-8?B?ZCtqeGZLTk90RXl0b0ZOb0RuQVZ3Rmlvc0NwVUJkQUlrMzVuNlg4NlR6VVlY?=
 =?utf-8?B?NHh0VjRHaXlMV0Z2K0JDNThvbmhQdVh1Q0locmF1dkpzNWZwV1Q5WGlsV1ZN?=
 =?utf-8?B?MjFPVllaWFo2V3dZa0hrYUdhVTYyZWYrOWZpOFVVVXdsSy9KOVBDTVVPMy9z?=
 =?utf-8?B?YlpUWFgvMEljNzRmVHhxbE5ESlVrcUpyT0hWS2M3MUZjK3NQVXFaVnZvb2lP?=
 =?utf-8?B?QUhBbEo1MzY1cDJhci9CV3NGWVE2dStyV0Q3LzBPay9LMGx6WGZCL1lHUXJw?=
 =?utf-8?B?RGEveVVZM1lKby81TS9yMXBtM25ER3h6YW03Ni90V3pBRy9JV0xFSU05RzdN?=
 =?utf-8?B?M0hIbTJGMVZ2Y3V1M0UyeTJIS0pHTEVxZllaUWovWGxtZ1JWanhSL2l0UnBj?=
 =?utf-8?B?a3A1TXRuTXdkYVVTcjRWOWs4YlFzNHZNa3EySzJhVTlRejNaQ09xYlNRQnpw?=
 =?utf-8?B?ZUo4V2N4K0ZyRkMxdndteUNqUjRtSDMvMG51VnMyenY2MFhJNS8vT1d2NjNK?=
 =?utf-8?B?ditBTEFydVFKcnZiNjZSYlFhWWRSZnpHZkIvZW9BYndtZkdGRDQvZk1Ra211?=
 =?utf-8?B?WnoxZ01hZUpXM05ZQ0VhaGE3MkZDcXRiS0JDdjhDSktPell0bi9wcHBhZEs4?=
 =?utf-8?B?SUFnWUVNRzE3cE92L2xiOWtRYnBralJsV1ZrbHlRMkg1ajFHeFRWd3hKVkRv?=
 =?utf-8?B?MWRnMXJ6NS8xTW9udVFQVWViMndrRyt2OWFDcDVzN0VHVUdTQ1R2SlV3QXgy?=
 =?utf-8?B?K3BSWUZwWTlnV3VKdEZyaXVDYW1tN0FvNk5lV3RyYlJXdzlFZkFrNi9SS05L?=
 =?utf-8?B?S0FHWjRVMUZ4djIrWm9Cekw3VnFDMmN6cHVRc3R1WUNFUzhjemphTlpPNkRk?=
 =?utf-8?B?OTQvcG5lRjdEQTVGUHJ3bkJWS29NNmdDOVFNUGdwZitBSDNMZWxDSWlDOC8v?=
 =?utf-8?B?RDF0aGNxU2FrYXhyWEdLeWwxUWdmL1pERmIycnpiT3QvUDRweUZuQUxTdWNt?=
 =?utf-8?B?cWc3UjgvTEU1aWpTRC9GMVVOSUV2VklFSUN1d1Ewd1hKQmdXRzBLNXFFN1FZ?=
 =?utf-8?B?MXlLWk5EM3RKcW5ta3M0YVRmV1NESnhkQStFazFQV3VyUzlRaVV4RjhCMjBZ?=
 =?utf-8?B?ZkNod2djNU1GODFmd0ZSUkVRVlVrNHk0QmlxR0dqbjZkdEU4UERGRXpZZmN4?=
 =?utf-8?B?T2dOb2RiZ01FaHFpTCtjN3laQWQxYWV2cng3MEhHWFNNRkluY1pQbTRudzhl?=
 =?utf-8?B?TlIycVpqeWJOZFdtZEVSaUZvejdYeXlDQ3ZHWWd6T3pjdVROSi8xRGZEc2lv?=
 =?utf-8?B?U3hvMHBINmVQWEZzUzJuQzZJaUNIOFRjR2J3T29QRitkVkJHTkR1eTJ6eWg5?=
 =?utf-8?B?L015R0JVUURvZHFtYWRmU0JhMG5tUFYyTHhrY25Dbk1ra0pFSU9LNUM2QnJL?=
 =?utf-8?B?Z2hmNHpTMDByN1pDRUJyWWRUTUFsZDNQd3gxNTdQOXk1T29sbUpyL1dkbXV0?=
 =?utf-8?B?dUtBWUVKdzNEbXVhR01ZMVFwLzVXV0xuZWpCWFU5d2pJVWpGV3o3TUQ2d2Ro?=
 =?utf-8?B?QnVNblBkQ3psbDdaNWxtVlFHSDkvdjliNkRzaDRENXhUYnJvT1hoK0ozelJJ?=
 =?utf-8?B?WXNqbTNNa3Yxd0pVMkFpazdiNVFMZCtZYXdKRWxpRkhKcGlQcmFuSnYxTVds?=
 =?utf-8?B?YlNsU2hsYWVRTTFwcWNQQmZGcng5OXp0bjRET21vN283UktWYk1LQzBrNXZm?=
 =?utf-8?B?WHduYSt2a0Z0VHdwWkl2TDQvS29lMUNCR045ZjFpSkJNbjdDU1BLRXpjNE55?=
 =?utf-8?B?eEpIZ2R4OG02UVdIVlMyUmppN1lRbEdNRGQvd0JYdG52bHVqVXpLZnlEY0k0?=
 =?utf-8?B?TWp6Ym5IN3FqdnUveEZMWUdZSTBsSnZ6enpHbXhuSU9NUml6SnFUWW5iQ2ND?=
 =?utf-8?B?YVJmS09mZnIybzFsRjVDVlJFMW1vbmlpRGFyTkt0ZnVQVk9wRjl6RC91Mkps?=
 =?utf-8?B?em9iTUhLVlJ6aTJoeitqZ3p0Ums5dGpMRlJNVmE0WkhySUNpT3JxWjVwVGpi?=
 =?utf-8?Q?MH8I0iHn+f7xpJQng6k8VGKglgXodYhy1/Ce6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989a722a-48f0-455f-bbb0-08de74519ae3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:38:17.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U03LsrhQkbCccePdc5JVClLVjMpSXwCrlAcxAx7R1ZEmLcQMlmiSUnx9R55uaSCPYgk2Yf4j61iD/QYRdtt9qjrOUt1wZH63oTvNJ+B4f+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8206

On 2/24/2026 7:59 PM, Conor Dooley wrote:
> On Tue, Feb 24, 2026 at 05:58:05PM +0000, Conor Dooley wrote:
>> On Tue, Feb 24, 2026 at 12:15:31PM +0100, Ciprian Costea wrote:
>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>
>>> Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
>>> NXP S32N79 series automotive SoCs.
>>>
>>> The controller is compatible with the existing i.MX uSDHC controllers.
>>>
>>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>> ---
>>>   Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> index b98a84f93277..014b049baeb6 100644
>>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>>> @@ -35,6 +35,7 @@ properties:
>>>             - fsl,imx8mm-usdhc
>>>             - fsl,imxrt1050-usdhc
>>>             - nxp,s32g2-usdhc
>>> +          - nxp,s32n79-usdhc
>>
>> Ditto here, no driver change?
> 
> Actually, this doesn't make sense per the commit message "the
> controller is compatible with the existing...". I'd expect to see a
> fallback compatible permitted in that case.

I can see how my statement mean more that what I've intended.

I've mostly wanted to emphasize that the S32N79 uSDHC controller follows
the same register layout as other i.MX SoCs. But regarding quirks it 
differs from other i.MX uSDHC.

Hence, I will drop this comment from the commit message in V2.

Best Regards,
Ciprian

> 
>>
>>>         - items:
>>>             - const: fsl,imx50-esdhc
>>>             - const: fsl,imx53-esdhc
>>> -- 
>>> 2.43.0
>>>
> 
> 

