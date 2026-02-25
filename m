Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013054.outbound.protection.outlook.com [40.107.159.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3873C196C;
	Wed, 25 Feb 2026 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033299; cv=fail; b=onEo+t+r5u5Ovcxe6KMZNRYBdtVu8Z+hYfCZcA4IPUiQsdsrNRtoiKuUs4XgwQgMbVG2nLrGYHDapxzpgoL0KXd4ntJHpILYh0MKHGEYdHl+pllCGKoldqGTkeFYH/dxplMJH4vb/TC5J+cc5bXuu9zS0utpJD/DXhhIUmfHOfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033299; c=relaxed/simple;
	bh=zzpYJR2s+ZPaT3eWpEKE/CYZrNCATxpdXWbDNbtMtSo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MdMJt466OhSHy75ML50vHyJhazJuXPiR2sU7d+F1oZJI9GUkwxJGt8lGBs9d9NC49ooEOO0b7Guo6QsMcNTAVBW7YclBlqllJL5CZsDXVOd4c3ZRp5sJh/UYdd2F3ZQ2aB9HQ8y/twN5Qnc6eeB2q57JWuDDjKXkIuYBTAfHmtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=PgDerc68; arc=fail smtp.client-ip=40.107.159.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PgDerc68"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h14KBsLnuuk0qNekeIMBGyyPWpi4vE3myXnBDZ+fWmVhOUjC+HnGGF4V8sFE0F4ckbCGEVgsauIMW8cstparBYZWu1ozS1MFAerCaAi5PXB3W6tAXAz23AtFPmh0r2NLqpuBccXRMvaOamZKyAeg1JskL96MT21sH3LdRCp5biWEBpiQAPvWzCI3Bkuf7JOuSZuzJame1wucm6Xm+QHTOUqM5TNMSIiyktbuxHff+ZNSfnq6gLQOgAUnr+zW1f39l9gxGvN4OYnv+OW99IVxFFB0XR8Sj0hColFrgOHKJmAEnj7Y62rlQqXvZ5iSfCOledEM4A1zCb+l0YivFxMe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUcKdKlIjetQQZu+9o3l1RBczJciyKzxR4XSvQ3coPI=;
 b=a0w+6eM4A2oey/uJu/1O8OHHJd4KRW84jWgVlZSbGgHoZ98I8a/0qP4Z5IzjE4+VGX9GfSQScxYdcqT2nUOHp0i2dt5/aQRoFBMkrRI9TNt3OygDp9YH7V8AQQOw7dDq3Eve/FeZpqO3jgre/uHCgMsv2aRD71GgK6cDg6z6iBAAj8Yc6rwS/gMyv+rTHV2xXnRBJy8oIfH/J7nIfQA9NP23T2BJcJHYyjLtUb6UM62U2+dI7HWKMMIqkgcQjIIMmr6zVJAPxex1LjM1EylXYFD+A9wx4WbO2v/D4z3fpZ449Hxzs1+XukVTn+3BFNnikejHEP5aM51wwQv6wSnOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUcKdKlIjetQQZu+9o3l1RBczJciyKzxR4XSvQ3coPI=;
 b=PgDerc68aKAA0nnFmyCNNLECfnHJkBiUM7UcpJ8z6Vpzwf93OtRjIVzV4FRkrQlhFT5EDI5mwkIGzrmR7QjUW8X1jhpUGwyd3CeYWOvrERoUUMzbpn/qIQFZcQlQXzAt6HNAvsL9jK2v1m0USM9/Xx821K6fOLRG0Blj70SZdiVfzuXAK2gWWO+SzW/MgDWxLXBHzhLWHRp+a/PXcCwahjHx/GrpQGOI1tv/H4cVTv5rQUDKzzxJn4RMzoRY+bDQUfFSGVsc8MUfqeRSvl/E9upUEv/Fuj05vnFqJyJ1hPKjSJCwscji76J65+Lx8IhmRQLMgeqBKsqr2WILiaJ7jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10847.eurprd04.prod.outlook.com (2603:10a6:150:20a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 15:28:13 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:28:13 +0000
Message-ID: <89d60ba4-ce75-4766-ba5b-f94cb7f6857c@oss.nxp.com>
Date: Wed, 25 Feb 2026 17:28:09 +0200
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
X-ClientProxiedBy: AS4P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::10) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10847:EE_
X-MS-Office365-Filtering-Correlation-Id: 7facfe43-da73-4f9c-ca3d-08de74827d8c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	MYWSC7FdeIDJndjiJM0k/oOwBQEVhGjf5yj3tLk3E9hRjgaJlXTKBwqCIaI8pJqP9TjLu4s7tLwl3Dp2KCnjvi3VUyD2y8yb+hXAhb9MdjyJ0BrA9nD0Qa0wZ2hrnVkeCX0gqELIRSHifvOagu1LA98nGWe3qxzypY81MXpWEN28WLWn1VIDpiJQ4uahv1niKzPT0aMeDbEIUxDP0bVUUS95ah84DrCwCujrGGA5xq2U9TDvm9FXdfP0TfVq49Q4u0LM/1XO5XrdAi+u1UtaDJt7mDQKE2grQU42kIyj6Ler/Bb6QSnWm8BkfwHmUYXVcUoX4zTNY7jhpZEU8aeUIP2sIdy/ggFKawt6GFsPSH6JbpU09P+kUtqlvq6JDdPnhqDfWZuRezcBZ6jKpkgOITaFuTtWddAU8SKE68awzBgsorMYzqi/TQ/tFKrk0B0BBejWlittHM34DwEu/KjlC9ZEDMUomDXtHAkrQbdLxPArXAcRQ1OjHgtjEvoIc24aTUZyr31enr6MgS/Ow3FE/n8ASiGEfqx2EP4m11ZxBcfhVr3iLMbG9sbCm13X2cwTn5l/Q2A8N0P+xLSijlKn1XDEl5fH7FJFaL3iTPnzzydmDQ9C+2zwHBiWvOp9nBueAD6M1fVGFTuJF3v2yD5hk1QsaXR8n1jtX38OHUjImyKwQODVIvn0rGIGAYMfm5BATsiPSP2g1G4uJ9FrwYhv4Lp35o7UUWGOR+7jXvEuyv8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUtwdWJVN1BhdHBNQnR4eWhCcTR6OG40MFJsVW5UT3V2elo2eDBWc3ZlRTRH?=
 =?utf-8?B?dThZNDNMMURQSWp4aG5jMFFXUlNJNXdVeTlVYUNUdGdHeHNLdmZ5bVRRVmpr?=
 =?utf-8?B?VHV0cTBkUi84NUhNK2NzRFFDMUhvRXNZaDRmYjJhYm9BeTl3WTQ2ekpuTDBE?=
 =?utf-8?B?dTYxR1FuTmFUWjk5cVBWWFU3amhWUnpkWDRCbmJsOWQySHJoMXNOWEpZeEhB?=
 =?utf-8?B?TTdZYkFMTnkvT0dPRXRPOHRzcE1rd3VGMys4N2pUMFJ3cWpBLzlYcEptYVlH?=
 =?utf-8?B?TTVQeEhvM2xPS2VtSTk2MDNxYllhZG9pT2V1eE1PTmJCZm1FbTQwVUdXTmV1?=
 =?utf-8?B?N1ZEZnkrRzhST2FTTFVoS0RHcG02QzZVcjBMemE4Wlltc0tUaGloQWlORVNo?=
 =?utf-8?B?b3ByeXdWektkN2xoNUYvTjUzTXF1LzVmTUE3d05CSURwU3ZWNkZVN3V4MTFY?=
 =?utf-8?B?bVkyazREVHN0WElvSHBsRWlSZVJVMkFCUWFPd3ljTG82bU10UDYvWVVGbU9G?=
 =?utf-8?B?dGdDVUpwYVJObEZ5c3JHMC9Rb2lpamdRRnBocTFrbGxMNUxjWGRHMW12T2xF?=
 =?utf-8?B?TnUyYWZYeHpVanVSZ1RQK2E0SEdSVDQzVk5HRHp2RzVadnRtMEJFZ0tISlZk?=
 =?utf-8?B?OHo3bnlOWS9KQkhwNEtoWENuZThZclpWZzk3cy9LdzVBT0NQSy8wazJPa2Fw?=
 =?utf-8?B?TjJWS3Z5bzNuVzE1N2tEU1BBejUvV0IzKy9EVG4vY3VqdWhCMUR4eWZabm9z?=
 =?utf-8?B?ZmZHY1Z4OXZKNjBGSnl3K05QcHFSNWk1aUVZb2R1Zi9jalNDaHBNQnpkZDM4?=
 =?utf-8?B?MjZwV2phRFljck5wZUM2V3NvbndsdHpOTzVJbUowSDR4TlBwVzR0MjI0a1BQ?=
 =?utf-8?B?R0h1VTRhVk95VnlmRVlhdXZIUVlYbzVtbS9ieG1SdjRnOG0zOTc3UzB2eEFF?=
 =?utf-8?B?emtpbmRyaEY5cHF2QjVhSTFtUGtqOE9ZWE9KcVk0MWd2MXpSMlRiZkFwRE1Q?=
 =?utf-8?B?R1BQdzZ1R3YxSVNOSHBheUNGNlVFTS9EU202akE0VEdoNnlzUFdFM041RDhm?=
 =?utf-8?B?cE5IUXFZRjhZNEp4eWFraDBMMDFjL2V4RitFKzNSMGVuNkdlNzR1eUJtaU5x?=
 =?utf-8?B?QmpMa21ZQnlKSVUzbno1MjNqSmxBbDNPZTJzRDY1bEFPZXlkQXRVbGdORnlO?=
 =?utf-8?B?cnBvTDJJb2Q0MTVFT0N6RkNmdGIrVGVaQklEekFtakxKUlJYZHcxMjJOZXZQ?=
 =?utf-8?B?emkvejIwN0pySTJ0c3pLbW90cDRpU3oyY1NtbHFCVmN2WS9nemVTMFdQRlhl?=
 =?utf-8?B?RnZMVjc4TUNsY3k1Q1d3RkM5aGU0eHJiQjVDZytwUDRKMmlsNDFkR0RmRjR6?=
 =?utf-8?B?cnoyL1UxVGcydWpPRTdqOENjL1FvMjl1ZnJTWXV3ZUR1MWZPdGJ6cng5ZHNM?=
 =?utf-8?B?RlVmYkNlN28yVWhHK1k2YzhUQzdJTEhUejRUa3R3RVovYVVhZGxhN1lNTk9v?=
 =?utf-8?B?ZVdRSXQvL0p6akRnYnQ5NWNvVks2SUd3UUNUMXVWNGgvNFBoWDNuKzZGV25O?=
 =?utf-8?B?ZmVDWUZsR3ZlemFDcmgxRlQwcE1Xbm5KSnhmTGhheTQ2ZGM0WmtIWWVhbW1u?=
 =?utf-8?B?TllvUE56WkRzM0NFeU4rVEQ0VEx0WHZRSGxoMmw2YWE3RmNCSTdNL3RyTGVG?=
 =?utf-8?B?eFVZdlpqWWNodUxIcmJlNWFNamhmSlBYeFpIY3ViTkhoTmxMa0t6dDZTMnRt?=
 =?utf-8?B?bDludmZ6ZmFvN0ZWZmJTK0lPVG8vbEJaazI2UFlBUk5DTmE4K3pOUUpNb0lo?=
 =?utf-8?B?RWNobStOOXNSOHpvNkR5YmJkNTBXc0pjUGdSazZzYktHbVhaMU5EZWIyUmcv?=
 =?utf-8?B?QzVWd2l4NjFmMjdFT3ROaFh0QkFabENFWFJ3UWNJVDBmaUFoVXhETFVZWmRX?=
 =?utf-8?B?amQwTlcvSkZ5Y1JPd1YrNnZ0YUZINFEvVm0rdytnSXV6cnFvVDBUMGJEd0Nr?=
 =?utf-8?B?Rkc5U29IOFNRSWdabWpCVVlvS3JyOXFNVkJCaEhVNFNqTlM2YTZCN0NYbG5L?=
 =?utf-8?B?RjhwN2xMYnoyMFg5bjFCYkt0ZW5yOFZzb0w1RnZzUGFKb2VEd0RpTzRKTVhU?=
 =?utf-8?B?d2UycWE1dGZkWXdtQ2VTVUxIY2k1Mi9sd25mWmxBNnQ3dnFSUE9FTkZVUGJu?=
 =?utf-8?B?RTBwOHVPOGU4MlNLMEdNTzkzVDdBd0RIdUdLcElBQit1aXA5UkFqSUxRekpE?=
 =?utf-8?B?K3hqSkJ6dUFLNVlEeC91MmlYYVpGVWVnQ05JbU4zVkZBVHhaa3FnY3c2MDZE?=
 =?utf-8?B?dTdock5wSVVtcUFxVFhZS1NOU3c4UllXbWMvTlF6amNsdk8va0pUSjVhRHMv?=
 =?utf-8?Q?YHmbkha5p6BZiasw=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7facfe43-da73-4f9c-ca3d-08de74827d8c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:28:13.5517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kP6Z9HVYLfU9uJQsU9R6/D3NAXT0/HW4ESmqq3KJkYXIWLlpP/Vk3J1Pdr2LjAGJgRQn4A/Ywgu0YUAFTcRqmyygbvQRowyCEcq+0A9J9/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10847

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

Makes sense. I will update the commit message accordingly in V3.

Regards,
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

