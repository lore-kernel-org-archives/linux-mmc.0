Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA311CAF;
	Thu,  5 Mar 2026 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713597; cv=fail; b=EIptY7phAmBdDvJXyFYKCkV5UoBRy/DvN/NKPJmQ3AoiWRnsNVURdRRiVHx11TKxW3/N+F+0HN6KWC7Z6oTe5MQTmt3hOw/SvfLDvxnTDnxVAZBDxkIFyBYtooRK4f17dlJsj4rtC0e8MiqMifPLN/38YCZGLPWI3LnwM+RmaAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713597; c=relaxed/simple;
	bh=7d/q37XDr/w2HcpxNErM0X8MtGFi3oHekv4PmUWGp9M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gPbvUYBK/iJwUuGZ3u03PMoGc+OQ6hq80RBoSoo1pNH7kNdS24/l9jOoSMcKreRqQRYFjcNL8dZ6dpDR081XpAuX2ZIMzryHXv8wBc/sjBTJbIyi6lPgY7gV0mdP6FrI6R7qTbLrmb9JkDv4/2gXVThJkPNxjMxBNtiUAkZRptE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nyhU33Ma; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nyhU33Ma"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guYQU3CZ0rF9V7mcTA8PNU5JRrMwC3cCkx1KjcuPwgjvM09qDtJJNQxrBVuK80xkLvG2Bm5K2MCwpO8RFgkBLWJaPhQrxw43y9bPpmS23GygAjrscXyaFB5wb+1r3Iek7//EVxMTDz7LAl73NpVYKZv9cC0/QdqqdrY2yeT2111vcJ1wZ3RVPQQiE+/C024e0QmkylW4fMgnEGXLU8vqqTRwzRcyYewnrIXnLlWAKYuemOxiq+P1GxWaVX4RXRc56gLYYTWdk61t5Zz3f/1LXdyqJ+kDA6At8FMofD1gFUq9EPFvHww+c0F/9qJRPPOUBMjWccj54FUvD8FucsB0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75T1KZqPzSUoHnbzd1HOW+Mza+XnAKI5P6Bsu6WPEr8=;
 b=hvmogCUbLzACPYC6vTv8GkEtqsNEIm3wp9hHeIzWohqCj1KMdY8x+l36f2vK9WQ0TH6gijK9xaVlAdzgzczqxC3BACU+RarCEHUxKQ83oFu6ZlKQsNnWzVLaduUOH1pFhA4WieQR5TtEwdTn/eWWuWi9IyL+Mx8We0Qs49uLXQ20xrOrwOVRw9pM4lAi4nzSIb96Z9xb4z20TzwvS+El7EPRcZu4QZYgTDMnCk7wkQ419HkA8uW3NMjP1MYhLyuJdkcbj6DCtGmBQOL2+PfjEFQn7yzFgRSSDPh2Z6MtyL9UIIjhDfsjXr44uFXWgeQkXvTvmJXl0uD7RANrqlpSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75T1KZqPzSUoHnbzd1HOW+Mza+XnAKI5P6Bsu6WPEr8=;
 b=nyhU33MabQCbuX98xstUlkfkDfRfpx0AjAr8kkIIXTTW+KnMfnjcJ75iQQ3xM58WV8j6F582ILubjKHVSVDjLuBStChMuTNUHUyDCq0hEzg1+nfoTGxks4vK2sZxsssV3sdpjGD+5Mw8AQJ57jhb+EmkAYzJuVJgJe3Ylg3rfQ2PKH53VBNGTdaJzC59XYTe32tnlICMlrFPg4/fkZmQcqGCmoHiIm4Z3rzJvn1+9uanRyrfOu/BZAKZPmYIzdB1RcRUKHRCkRAOmz8Is1Bf9NGtRzjlCcCllmKQnwKXH93VABCyPP1R+3XEppLtvoThoTNb+AifBzL2AlHaYkA3NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM0PR04MB12075.eurprd04.prod.outlook.com (2603:10a6:20b:740::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 12:26:33 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 12:26:33 +0000
Message-ID: <88041175-a8ed-4630-b80d-f4706b742188@oss.nxp.com>
Date: Thu, 5 Mar 2026 14:26:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] mmc: sdhci-esdhc-imx: add NXP S32N79 support
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
 <20260225133858.8026-5-ciprianmarian.costea@oss.nxp.com>
 <aZ8Uj9DvCAD2lZjM@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <aZ8Uj9DvCAD2lZjM@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::22) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 72ba068d-6992-4df0-6971-08de7ab26f79
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	yxTEdX6iphwADJ3dOHAIATZEUEOiT+f7iJ7dGYDPiUqHUp2+/2pTrR2TV+0h9hjdfjcTmm0G8GrG5zJL9CvbtT5qNkjWm8rF5S6yoaDZAeV0jyLuMotZcbYdRzdykYQDXlIlRD1NNOlYJosd+UqswiYIyI8O1e4KzueD3Hp+cndEWrb6A3/gDdzjQ67+y6hxiYEGeaHdES7YO0/lf09dWpc4oYPr4IjSA0W7HWzeRaBBqSISeK1yyc2vU05H8Dd15BYlQvGDrAcVO3ixmysLrUE/LaxLMQRFVXr4PIvnbtrUlqKM3TUEKXdDGYiAiiCJEUmceNnbAzubA3Uguy0DMjUL1vRKSbwkM768U7DcCXEfdwe3+X0qqQPKjTeVpCQwj8SgDDE5BkY4nHHxPH0BTIdWI3yy2KtyNzDojnMqa/+ia8YtXRjUN8qgSvuuvQZWjON1NB1bxjejQ6F/8R7tnS29BM9uW5v+B1mRfApOaKYClUA7wnWrvcM7iGpmTru87DEnVo5T+wcDh9e+1aLQYa6yj6YMZmrUnGPETLxnRcxKN6WO86oimU1JtaX1/n9aRF1XjetGEVhwi/W0zdDs7PaibOvJInMiifdv88LDtVdZN8aclVcQ4d+UbDELeqUXoa58H95B9uNzsWyJ8v7tqm4JkLQ7uQlRS/7NSzEKvdDLNJKO6gop2F/MFMzFzGLN7XFTUa9SjQv9LtlqiUTiRgyiMKUW2+Ztqk5UCtkciTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnRKM3grZEFVY3gvYjNwa0NLaCt5UE5aWG1pWU4zOVNlMHlEUUJrc3dDNEtz?=
 =?utf-8?B?NzF0RjBXdHZ2VUNYaW1RN2l0RVh6YWFCVlVIR0lYOUJ0QXR6OWRKWmlPNFd5?=
 =?utf-8?B?M1ZDcWxUdXdCZXRYcDEyOHZ0NFVqeW1ENlIwSG5mYjQyVnh4K0xZODBKRDFB?=
 =?utf-8?B?WTRZTzNaeVdtN0xtNElYVExuSHgvaXZQLzJPMFk5K0RhS3FiYzg2Zko4YnNq?=
 =?utf-8?B?QXlSZGtpQUR2NXlaN3AvYnVsVUgrKzhDN21uMXYxMHArSzVTRW5GekE4OEoz?=
 =?utf-8?B?L2ZrTm5lOVhPRHo4V3BOaVVEeWxNOEFsRWRzWHB1UFRZbUVsR0pPdHNIK0Nh?=
 =?utf-8?B?Mm81bDVXRFRrSEp2NmE1WUp0RFpIajhzNDlONGJyRTZuTjhTY1EvMkgzWjcx?=
 =?utf-8?B?RXNTMHB4aE1jS2xYY2N1eVAyK216anZ3NXhJVms2YTJjQXVTL3BpcnErNklV?=
 =?utf-8?B?OUlaMXROL1ZFSkxoL2xYTFBYc3h0cGVQcTd0M002Yk1nZ0hzWWFMU0ZvSXRi?=
 =?utf-8?B?NWN1ZkpJTTkrbG8zVkIwb2VROVpNa3h1R0pFZjJucmN6SWJwUmhaSjBLeXJL?=
 =?utf-8?B?WERLMnFXK3hDdDRIYnMyQzJQTTB0c00rNFdwaEFLNU5QTXozLzh0VU9VSWtx?=
 =?utf-8?B?WW5PdzdoWUFiMlBVdTg0Yk1pYllJRU4zYVFtSnRZQVVUeFFoeHVzUU5SWGtH?=
 =?utf-8?B?d0NTaE8ybkNQVTNXMXR6OW1FU3ZyV01JQ3VQRzZ6V29TbnZKRzJINlZpWGVw?=
 =?utf-8?B?UnRBamJhS2pYTkRTZHVMMXhESXhlaVd2L0NEVThJbmFqbkpRa3p3a3loc2Zx?=
 =?utf-8?B?a25ZdFAvMlVRZEtMd1QxZ2JXSS84MnpaZTZTNSszUFFydGtlL0wzaStWTUxr?=
 =?utf-8?B?QmE3M20xeUtENDRrTkt0ZkNrSnRIdVVZWG1pbzdRUVNPSC9rWVRqM3JYWnFR?=
 =?utf-8?B?T1JudXN1ZFRqdklPL0RXdjB5TkNjSFQ5M3BNWmVqcS9hU0diaHpDSW9XQWVW?=
 =?utf-8?B?aGVtUDVld0lKekFsenJHcUhycE1PV0YzWXJMekZiRVY3OEJGTEFvRnpRbnFH?=
 =?utf-8?B?UDEvYitKK2R4M3p2SFFDQ2ZWczZhTTdwMTRjRS9XMnlPbkVDbGVsSnNOV25s?=
 =?utf-8?B?L2dhN28wdnhhTUtKWExKS0dlaElqa2w2dFErUkozTDR0VkhGa3VBbkhhWDdJ?=
 =?utf-8?B?TDVyQkJBeklXVGt2TWVrYkhJTFhRZnYzYnRmQUhkQm5LTEpjZHEwdjRjaXZu?=
 =?utf-8?B?ZFgxdHM3Vldhcjk5NnNONFNOcnpJR0Y2eXZBaWVZUk54UVF2ODY2TTB1M09N?=
 =?utf-8?B?ZEpVcTg2WXdicDErZXJGSmg4ZEUzNWlUS0UyYlRTYzhZUmtNeldEZmR3SmZT?=
 =?utf-8?B?U3dlWStLS09CTEppZWNqa1E1eEI3Mmo4ZlNUbURkRERYTUVyVHNHSElXVHJD?=
 =?utf-8?B?T0x0TjhzSE1XbEFLdDJ5cFh1N1c4Z2sxUUJseC9QR0Y3SmdIRjFsVmxtQXlJ?=
 =?utf-8?B?ZXJrUTBUZ2Z3WHFTY0lHWGZTNXJ1K0R6aE9vQzY3OFQ0aXdxbUpkOTVJcmJ4?=
 =?utf-8?B?NWwrWjdUT1lHZWlGYmlYZ0xDYXdPNjhET1A2NUMzQ1pNVGJWZWx5T3ZvSmdu?=
 =?utf-8?B?dXBDazlUdXBlVXcxaUZkSFU1eUtPdk91ZHM4R05IdkVibFpRcUtRajgreG1o?=
 =?utf-8?B?dFo3ZG9XK2s1L1MwVHV0THFOMVd0c0k4WjkrYUhDMzVkK2V1ZUdPKzdqMVA1?=
 =?utf-8?B?WHhST0J5eGUwQWpIV2RSUW1SVHlUKzR5aUJBakc2SFZSRytzRHQ5ay9lanVp?=
 =?utf-8?B?MVJPUFFjRmFBVDlCazNobVc0NXNveTlHRjZzR1R2VklwVUZWcGtuUUdNY3ZV?=
 =?utf-8?B?SnNUS2h6c3pqaW4yMitOd2s4dGhwU1ArNmhCc2dEOTNralVTWFhGNnd5K3cz?=
 =?utf-8?B?VEtqZFFZTkl6VUwxSXdFZXlkeTkrV3QzdVUxREVBSFE3YTZQOXQyOUw0amxs?=
 =?utf-8?B?Q2Y0b05RMCtjSnhQV2VpU1pab0tmWnNtYTM4YnY2TDE5M2pQSzdhRVJvbTFS?=
 =?utf-8?B?YTlRODA3WE90NHA3S0tQVndkdExSeU5xUWJ4Zkw3c0NWNktWdWRCT1dOczNs?=
 =?utf-8?B?eitOL2htV01QSzRySk1DeExBOW1NNk45WGgwbFhMcWFOdFV3OWZQdTd0N3pM?=
 =?utf-8?B?YzRjM0tNb1QybDVOcW41VlpVRVorRkZwVlBkWnVJK0hpZWptQmV5SklESEhS?=
 =?utf-8?B?di80TmpwRklFSVZEcjE3K1FkZWN4NzJkYlM2aVFPcUNSKzQ0OWNDKzZ0cmJ6?=
 =?utf-8?B?ait1Y2JUSENYQzRpcFk2ZFNEcmVaU1FRckEzeFJxc2V3bUlJV3BYdmYwRllU?=
 =?utf-8?Q?cJZDYhjt88DKdxo4=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ba068d-6992-4df0-6971-08de7ab26f79
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:26:33.1750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+xVLn8yBJvReBnSfL+ldFmUopG10/x1ppIWnradW8paAJW9EqthJwwcNxIgPTDRoLtNBDQqgSh/XNkzuRcEmYn23o1JqNiwyQO9DTGndyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12075

On 2/25/2026 5:26 PM, Frank Li wrote:
> On Wed, Feb 25, 2026 at 02:38:55PM +0100, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add support for the uSDHC controller found in NXP S32N79 automotive SoCs.
>>
>> The controller is compatible with the existing sdhci-esdhc-imx driver.
> 
> "compatible" is not exactly,
> 
> Add support for the uSDHC controller found in NXP S32N79 automotive SoCs,
> which reuse the existing sdhci-esdhc-imx driver with slice difference.
> 
> Compared with s32n79, needn't set ESDHC_FLAG_SKIP_CD_WAKE flags because
> ...
> 
> Frank

Thanks for your suggestion. I will add to the description in V3.

Best regards,
Ciprian

>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   drivers/mmc/host/sdhci-esdhc-imx.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index a7a5df673b0f..28288fca87ff 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -321,6 +321,14 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
>>   	.quirks = SDHCI_QUIRK_NO_LED,
>>   };
>>
>> +static struct esdhc_soc_data usdhc_s32n79_data = {
>> +	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>> +			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
>> +			| ESDHC_FLAG_SKIP_ERR004536,
>> +	.quirks = SDHCI_QUIRK_NO_LED,
>> +};
>> +
>>   static struct esdhc_soc_data usdhc_imx7ulp_data = {
>>   	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
>>   			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
>> @@ -408,6 +416,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
>>   	{ .compatible = "fsl,imx95-usdhc", .data = &usdhc_imx95_data, },
>>   	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
>>   	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
>> +	{ .compatible = "nxp,s32n79-usdhc", .data = &usdhc_s32n79_data, },
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
>> --
>> 2.43.0
>>

