Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B938423F;
	Thu,  5 Mar 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713519; cv=fail; b=T3qWl6bwqD8/0IstzDSNLbYIyl4OsD7GU+ehOtPqk5/KAxr1e35e1X8MdjZHQLTEheDrzeYsyVcVsMQlO51LSLv3F3oJUYDPBkcgySqnKp3PO1Ai9JWxlb1LW2XtHosn1nHaRSwNtXB5jhLMWDeuiKXW6sSgvYD5IZrSZKoq+3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713519; c=relaxed/simple;
	bh=rKTx4PM/xB029jQjm44WPCoWovEbQAt9G9By+lH+oRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hki8lMc+d5itJ1IYhA0HhIFsFeCkobYm1u2bCLeytApLq3M/JG4EklGY4A8ofl4fu0as7TuPGMe4bpUF77073E/z54sFZsOGPflKtLTIRaY2E8cCGs46NnSaAW/w917XM2In5I+hqJooB/+hW6SxkOoQG5QFyPqvpZyv05I914k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R+/3OENl; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R+/3OENl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8Goh0Obqg+YKb5qTdfIKh8RGpFVZjM+XsN5DkR/mD45wn6OrKkBQ+rCYqJpOlMTaT3SuKXkLLX33aHWtnSbtyKYe647VwTv/2b4OPNKUZ3Y/3C3qE6dOmLjkFvXlNoS1fYS8NUOgF7+MOjyO4OlENIlNCe2X3rRzLkCAtsYrsfOPInezEQZzZlMFAGbMMsUqkPz+1h+yRj6sLopE9KnxxtvF2vYTreOnlJnxmM96EwuyjudNfu70S3j4hXlLiOcDLc01kTPyTCi4zxg81lD7FPLDW4bOZO1zxvLrRG1+gENOzioOoIayn+OOtPI0/cLLXb4ITroZAJtHxDqFdmk8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdCqhLSprSv16AIAZpHDLiDkKsWTiVZnYaLrEdyyRMo=;
 b=gFrWHGaRZqB+HsMqWJgBt4GKPXt45RCFQHtVhUfFxvWpW8h6Nt/+LBgzEETp6jA68H6yhAgiG+9rsiOJqGoSMd1vg4ePlWQWOQbKb7pgbI3jVpeTsJ2OK9iAo24ou6ztfHXmvrIplQvlXR46RmCf7Qz8ANfKjh6PsbQVUK0S+n1mtg76ZeREIfs0DDqkeOKw2DhgrLxM/RCn4obdwh1EgSYETHyI2f4Nj0ViPy+Q/lGezzyA1mf895HWCfrl9FQbGdMieaXoiCGQHCLE9o4sueGY25FiXl6UK0y1vzuKudXbZb7M8tn4ox+0TVWJ/qAPlWq06URkwdRwlS8YkyJrlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdCqhLSprSv16AIAZpHDLiDkKsWTiVZnYaLrEdyyRMo=;
 b=R+/3OENlK4jWPHDqzURl6i06GHhfI1uv5gRHzvQhHBziuGB6PyvTi+rfykFMpVK1kHwk2Js5kircnP7OrjGIrbrMBJ0L2fOMS/IZNaJ0VZAi7RrgryjU1scPRmwhNejZEPXLkUZy7uckaP6Zz4ccL0FN/681f3sJ9Bt0ssReMnj7dU6F49g2TYlYE5jaBjA/R9ybZZ+OLbbLc+4mFyjavy1hFNNCFrqdtu0THhXPlwQgutfrlAlOtSnplDomVZLrAGtgpY4aL+UKsI5f+n3cuCr5XcG4cVKdEMhV14m4wrwkrIjI8nXAX7kg0Oxz7Y7FCi8PkmosoJdpI7YOMN/XNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB12075.eurprd04.prod.outlook.com (2603:10a6:20b:740::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 12:25:15 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 12:25:15 +0000
Message-ID: <aba2401e-e26c-44d1-b321-56cd18f11a37@oss.nxp.com>
Date: Thu, 5 Mar 2026 14:25:11 +0200
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
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <6a481490-28dc-4b62-9782-95a32d0e2857@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::38) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 0fab8a37-37d2-4cb4-c769-08de7ab2416a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	csyu+lA5YplpbqZLbD8p9qkQkX1dYicBo9u/L/HhIXPWTOyK7ttLywyVMVxSsrOPP12L8PUxSpI/KN8L8pyLIRIB1nUSCQ/awby7LDPFoLChaknqj7lltUSLUNY9PbDfkOreud4zxalJm5lgpbXU52c+T0OKXxPgdvDlmJcHhhhH+OorD5tpXdo45CtlRnDLdaW0BsNcqpSFoDKOP4Pa0cd3zq7eLMTWDyFotm076vAQvT5PeYnso3xhgtJX8rYSIqCiux1mWk7UgJUpI2dCS8VwQ374QDRjz3SEHK3siu365nFrvTHK9xjqNqZNbLtIRN80+rypx4fHY9IVZvBxrT8IBTFWG77ISI8ZNv38bXUnw1FkrZSo+F50ehc0X10/hSg5fGP0yyXc228dCjnHdeTMjyplkosYN/Zfp8kYao/8z0HVKzWz2xI8m1SY7lwGPyZHUn7Pi+sHZ6uRK/Igc8Y/K5FzAe1eksxn+261acdG5GTwWwLRnFFUfEUaN896/8XgQLGEG1BJlbYt0qKNc+Ha2KrEX+3tsyLbYF3Zk3eIgkK+lfCmCz7+kAL9u6cbRSqtOsz8FtBGh2vheB4T+v6HXTW+UpFdTpVvjdJlEykB/LnnL9ywBXzyTICChM0YfYOUF8z/cNq1QUIvhDMXZv/pz6LxSyhkMZpiF9E5xc6wcd7jJAM4waNU3j4oRmPcwdGbhldydoK21dwd+YjYGOb1SHxn+70MtXcrUdxZ6pI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHB4K2lyWmo0MjZLTlNFdlVnN1h0K2sweWxqVnY4U1NLaU9IK3VJNFk0bXV5?=
 =?utf-8?B?RElrbTFSVmR1S2daVEtyNEVsZTB6S0R4VjI1VnF0UENxVWFMcUw5M0xMcmtu?=
 =?utf-8?B?VnNIc0lza3ljOVV1R0dEWEZueVQvMzNQQXJ4RVVTbkdIWWZOdnR2USs0QS9S?=
 =?utf-8?B?ZHFrZ29uOWhNbEJycG1xK1JvMkN6eHpBLy8yMXlSWUtLQlZtQUlNeTlUaDVF?=
 =?utf-8?B?SEloV24xbENOZTBKMjdUb1M4VmxxOWpaUHYzZGxwajJSeTQ1OFRKSlI1YTVP?=
 =?utf-8?B?WkNCYVFTRXUrL1VQTGdvSUdlOGt1dXRnSlFLVFRvdXQ5UjljMmprTVFJSlNR?=
 =?utf-8?B?NVdsZWFoL0NnYUtmZDV4RkkwRmZxS09UN3JMR3FqRDNoakpMd1RSODdkVXQ1?=
 =?utf-8?B?b3p4Szk2M3dUVzNDVVJKUW1sOHppMFVOeUpBOUovM0wvajRtS2hsMWhMdWdk?=
 =?utf-8?B?TFdpWXlUQ2VIV25Bd1I2aC9PWWdPVTQvVTNqdlU3NXZPRGEzSzd2WXZtb1ZV?=
 =?utf-8?B?SFlMQlVvMkhSM3dFZmlKb2kyUXBIUG03b2R1bXlLRGh1bUVtNjIvYjREK295?=
 =?utf-8?B?MlhIdGttV2hFU2tsd3lITHVnU1hQVXNsNmliVEVjQUlzNWtKR2U3RnVONTBV?=
 =?utf-8?B?ZGlXT0pOOTExN3RFa3NkT2g5TTM1SHFqTEdldWZBWis3SFFFOFJDU1JBZ2ZZ?=
 =?utf-8?B?NDNOeTA2bzFpdzVZMWIvUnlQMXpIS2RPTUlKT2lZU3ZiNjIySm1FWDh4aysr?=
 =?utf-8?B?ZjdFV05UK2FEczRPbGp0cXRRbXFvSWhnYXRObU9IUFowQVZSMW5xVnRiWXlK?=
 =?utf-8?B?V0c1eGlmOUVKbWt4b0RZUkJLN01zaFpNWFRmZXM4d3lqbVhtcEovd1l2SEhw?=
 =?utf-8?B?b2NGYk8yWTUxM3JhTGc3YWJOSUV5TXV3dytrTHZFZmVZNUtLdVF4S0d5TFla?=
 =?utf-8?B?cGJIOVE2SCtpM3gweUxCYitnWU5ITnpnR1h0TTR3cGRScFNmRkN2SmpiU1hV?=
 =?utf-8?B?bDFjdzdKekFoY2FBd1QyUUo0bzFPWTNWZGlxbWtNeDRaOUxUeTBOYmN1ckJj?=
 =?utf-8?B?YjBEaTNhbXJER0psbWFCMjdJYTc0TUdoc3hYbFFuWmZod0l5ODBQanMrSmZJ?=
 =?utf-8?B?OFV4dUtFcVpIYjFzeEtFa2xoeFUvNDV0SnpmbUlZTVZZS3pIYU10ZXRsaEw2?=
 =?utf-8?B?dVV4TlpOVHhIWEtVUzNXbXU3bzZMaDgxMnRtaXptYlVqMlVDOXlxVnNyNEha?=
 =?utf-8?B?NXkzSE50SzZRSE9IRFlndHVNUCtWc0ljejRKS29pQUFPb0MxRzJrZWVXMjFJ?=
 =?utf-8?B?eUhZc2Q0dll2MktrY09vOUJwR1FJSTFPY3BsMndBMENKT1hCY0hPYVBLajh6?=
 =?utf-8?B?MU1MRUNEQURyZk9rYVpmT3l2TW45ZW15V3dNTmdrWEFUNUxSRGZhVXFlakZm?=
 =?utf-8?B?SmwwTklJdDlRbGJoUlNqVEtvU0twRCtsVmw0ek1CWUQ0d0NhMWk4SSs4TkJk?=
 =?utf-8?B?OXlNd3JkQng4VElKeVpmeDlaOHhZWWFmd1VyT2ZVdVZWZ1pzWWFOOVliY3FR?=
 =?utf-8?B?VmtoYUk4NHQvcHJQQ040WHZsM2FqODJzWmYrNktBTlJzZjNjLzVmRCtiZHdC?=
 =?utf-8?B?QzFZTzlEUk9CV0hSWEdsYWk3dmQvUEVHOForenNndHNaaUpsR2xqTENPQW1L?=
 =?utf-8?B?bHgyWlFzR0lRSUdUa0dlTXFuT3ZqR1ZqZ0c4QUhyK3RaUnZ5cmg4Umh1TitC?=
 =?utf-8?B?TlcraG9uMnhVamU4QTVqTkpyTHNkZW9ZdmtDOVpVTks2RHBCRU0wdkNKemJK?=
 =?utf-8?B?YUROTTljcWpuVndLdUtKTTYra0VURUdTNGxlaVMrMVcvSFIyZXlBd2FKNVFC?=
 =?utf-8?B?aTZPSUFNazFIa1FVMTBqeVZKTEF5YzdmaDkwRm9nQTgrRFRqTld3ODNYOG1V?=
 =?utf-8?B?M2paRnp3Y3lUQVliSnExRjR3RHAxVmVQUUhnMDd6QUhhUjBkSXRTMEFnOHpY?=
 =?utf-8?B?b2hRVlVRWjRPYzRyeWRxWjI1Yk5jL2NnalpvaGtHdzl5N1pmdE5nMnBBWHMy?=
 =?utf-8?B?UVZHMklESTZVcVQ5a3hrYTZKTytVNi82SnVzODBnSHdrVXBzU1BQRzBJSjVa?=
 =?utf-8?B?MHVjUDdvU2RUMVk0Vm55NWNNZUZYVmtiZWtkTzE5R3BSRnJVTngrU0FSNmVL?=
 =?utf-8?B?cmFoa0dXbWwvSFkwV1M3U2dzS0JYbWlxTVdLY3VpMm12UFhSRnZWSGZvT3Zu?=
 =?utf-8?B?V3hRYTlpWTYrZGQrWmk3NlJSeHJyNWgvWEdFNEZidjhmZ3o3RXN2dW1EeVFl?=
 =?utf-8?B?RmlTWkNGdXZWVEYyT0poRkFxMktyUVp6T3BoQW1WZzAzdGFORCtvc20zUzRZ?=
 =?utf-8?Q?09B+MRmh+hIBMhkw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fab8a37-37d2-4cb4-c769-08de7ab2416a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:25:15.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJWBOwQ+UtCFi52CppOmxrpG2KrU7ImchRYoqVDn3q866+4ZO5gmzDFUK/791/VuMA4yi0+0sD+IHHiOB6PWLt8l9kMT9hrZemntYLbMx+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12075

On 3/5/2026 2:12 PM, Krzysztof Kozlowski wrote:
> On 05/03/2026 13:02, Ciprian Marian Costea wrote:
>> On 2/26/2026 9:31 AM, Krzysztof Kozlowski wrote:
>>> On Wed, Feb 25, 2026 at 02:38:52PM +0100, Ciprian Costea wrote:
>>>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>>
>>>> Add compatible string for the interrupt steering controller used in NXP
>>>> S32N79 SoC.
>>>>
>>>> The S32N79 SoC differs from the i.MX version by not implementing the
>>>> CHANCTRL register, but otherwise maintains the same programming model and
>>>> register layout.
>>>>
>>>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>>>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>>> ---
>>>>    .../devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml   | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>>> index 5c768c1e159c..caf3e4a1f26f 100644
>>>> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
>>>> @@ -22,6 +22,7 @@ properties:
>>>>                  - fsl,imx94-irqsteer
>>>>                  - fsl,imx95-irqsteer
>>>>              - const: fsl,imx-irqsteer
>>>> +      - const: nxp,s32n79-irqsteer
>>>
>>> So that should be part of enum with the first entry.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hello Krzysztof,
>>
>> Thanks for your review. Regarding this change, I was thinking since
>> S32N79 irqsteer does not implement the 'CHANCTRL' register, it should
>> not fallback to 'fsl,imx-irqsteer'. If the driver were to match on the
>> fallback compatible, it would attempt to write to the non-existent
>> CHANCTRL register.
>>
>> Am I wrong?
> 
> No clue, I did not say anything about fallbacks.
> 
> Best regards,
> Krzysztof

Indeed, but your suggestion of moving 'nxp,s32n79-irqsteer' under the
enum would fallback on 'fsl,imx-irqsteer'.

Am I misunderstanding your suggestion ?

Best regards,
Ciprian
