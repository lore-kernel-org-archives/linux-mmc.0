Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4B537B024;
	Mon,  9 Mar 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049250; cv=fail; b=bltWLXM6nqSxGY3TSZZpVjCPWkK9HZSjikKgdjeGFw+5TsXK01kR3t7xltmNvLe7niTZ9Q/5NoU2caBjCfLCWrPIhdibUS1fNEKfNh7OEaJEDWh6/csox+KAJOv3J7vaCM/T8PTvFxsgktGPcsBQ4FXzptLmmBkcCRWJH9ZpM08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049250; c=relaxed/simple;
	bh=c+wyYk1ohdFaZgt2bTqW6uug4Yg1203CkOJvoxa4q4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J3QIH+nYd4XbC56MqAnIfWANxP8cF5Teyb4sJXENRc7yVFf2NcXUcmO6a8gLIbr+Q2GraDB3QgEovsJIuUE7o89XA2VooMJg3n91KJJ3zh3rSRINRZfB34JJYaos0gxlOVl6I5RuuHNJM23YFFEPtZgYbB0vPQXCHXmg35uCVFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EdamVQBZ; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EdamVQBZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TFzhkyNgI8Aqq5Th1+1oSqj4pxytLBwFFYUVdXNUM+vYKMMl8Z6XnotQ7VPAUyzRmp0DNx/f0VAjrIqGyxoYBgZaUZo0wZx98AMlSLFZkG+/dXNmZB/IpXEg4rY/TBh8b12RzcEkmeWgWJyQy3rBEAXvkvOSaAZz3FpCQ/23XkL4gWP0AWn5dhgFcB43hxqgEy/e6OixSBiDar2UhQddzj6DEQde3HMPDztlmvphcmTVFu5C9O3Px9uVRqji3BHkur8RcHbWH/BCDXL94/a0QpdVvMopgxOpQSIdgRK4ZAMV9VfWY479DwwR90TM/gYbJnC59Os7ptl9YfHX97mkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tspYllGyrFYTML7EgGOU3zMpF8ylkEU7uj2pM1K1dhs=;
 b=tWo1P4AlyqnRzs5LRKli/lJzBwJaf5l3OzkKfrxF3zfo8VDiLzwRlXQt8DxQVYX8nxSg7E11yBKImX828pJlnZQVmn2S0VUWzQyXFe5ilndVF6BBOPHDu+DjRrkUVSjNmLNlWr+ZdEkDvM20ghn5eJDs9Te5zg2N+SChgjnDMvHO+Z8L7tWA67KUh42AyVNBpLBxWlhn+S8BXM3pBIXazEClO1dtjh9+WOaVGLSIMvUcnnSW8MEhuNCSuAq7KsasrqG079BNzdtw/XiKchajg7Ex8BkBVUVrm1P8bxJOthXtjSYxSf2iYQ3+ai0OYmzfq/pZncIafajGk7QNMMZdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tspYllGyrFYTML7EgGOU3zMpF8ylkEU7uj2pM1K1dhs=;
 b=EdamVQBZSQYCzcKta2mnnVx9KgxjDmr3psyO0HS7XicSbPedRxVCHe62Qta3eUnoc8SMwkLJuIuaAc4fWuHMZc8WLyXGGIKAv5IBN92J9n1+1zW4qpe6IVc8KXe6W6GMeNyxycVUYMNgVxsYpj/iCVh0/16WbPshPIrQAeALrfnjMOSo0Krl0tVtCVBTohj+fROcPsJN1BwjV7rKEdGaFVcqbG7+qs4zU3c7KkFB75PcaODetDttfiNgkGBj9Xji1PdnRyXTQGJopKwzo+LUSHMAGnmBvAPk6y/26quRU5mC2qVYFiS+8Y+mkqxSGJHaSLonH4QAVkGZIv9VaGrZzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8729.eurprd04.prod.outlook.com (2603:10a6:20b:43c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 09:40:44 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 09:40:41 +0000
Message-ID: <b1b61e0c-d2e2-4a4f-963f-5e9e08a01b13@oss.nxp.com>
Date: Mon, 9 Mar 2026 11:40:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] irqchip/imx-irqsteer: add NXP S32N79 support
To: Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Shawn Guo <shawnguo@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Larisa Grigore <larisa.grigore@nxp.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
 <20260306161555.9000-6-ciprianmarian.costea@oss.nxp.com>
 <87jyvls6ek.ffs@tglx>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <87jyvls6ek.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0219.eurprd05.prod.outlook.com
 (2603:10a6:20b:494::24) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efddf22-b295-409d-b02f-08de7dbfed5f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	YEjYrdSzqbIVl/PUxUDMYB73stnE/b09vJ1SZN4xqN6n2+W6ODneM5PChv6aphNZ15jwxeD9+hEBcohDIpyUsGFn3PF7R5z0pLT7mLHrh05YGd6ZAYHmZPR4NsZwAI1Mk6Bb66QMSOPnteXAH1g6MerZAv8lQiP5/kzvt8DxQvVFLf8jgQhQHaSOX650V5EC2llWNPG0pUrQPstZoMQNuPvmIVGcuE83jvsbBsWOhDMsP4Qqug8NsfKpzNx0Y+Mc2OEfQB0E97EKOZx3Y3sSIzY5FtS4+1r92e8PgNFST4qYM8LO20hVtK1ST9Sjp6YfLCVRE26qGBIvniX14QTpsu7vwVOzwNCTQZd3Y5T6S6XvtCYObph5DfzWyVEL+SOhLu+d+wzWckPuSATTN4u/xrmhV00sPD8BKLg3KKHh9T+8AoV5eoAb+e+Y128kUSItCcE/6Vme1x9qtCrXfr+0upVktBK8yDPi9jovDF2cu5znf/Rw765YKzfU1J3s6IVR1BfIPjXgFiL/ezxAoRAs0O1EhnogH10kKRb9own7+n9pqcpd+wpcY+joxv8ivKuT1AGQQXvDMFl8DatcZSfzaf2xULLDAXCWQM0suzs2TYSnSkOL5kxwVIYtmxFXnRWBeXwEjNsmbTcfofOY8u0KGb3aLcFM8Q/W69QvQsOF/a9dxmux+HtrxmIw70qobFg6XEPKSFyR5fknDPuvU9zwfgDoh6445AuP4wm1C3tx0zE0WGyti0PVWmU2jXn+nI4QWiH9JTTv51AFX9xYSAsquYqgnUIMs3Ap+PUhLqxd7zs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXNmQ0s2OWwxS3hkUytVZHpldW1ncVIxMEJoMmVVQUxhUThIS2VzZG9KMHFh?=
 =?utf-8?B?aWN2QVBXUjJNVVpRUVZNMFhUT3cyUUh6cW9iM1NENG1PRlp2VkV6RklJRjNh?=
 =?utf-8?B?UFFQSk1WemJaWDk1YmtEVU9GS2RESVJnbFkxYmROWnAzK3RQOHhmc3NmVGNU?=
 =?utf-8?B?R0xtK1lVaWlVQzRLTWVlMDhkZXgrRlZ4d0FZaC92dldSRGNWTDBQNzFNK0s0?=
 =?utf-8?B?WnEzMlhwNzU5NitBN2pzVzlIWUlISDdTU1ovUTNlaFZFZzFIOUJaR20xSjZr?=
 =?utf-8?B?WHh0STROa3FZeEpnMU9GbnBpWUQ2eUQza0w4RVpmZGVhWTRmM0xBdndxc0tu?=
 =?utf-8?B?c3AvMVVIb2E0eTRVTlVOMTRRSW9ITC83NDhTdHdwYkk1azhyMVRoL2U2WVNm?=
 =?utf-8?B?SXk3SDZqUFVWb1FPUXFaK1pxMkkxdnNFbnFBdnl1VURYV3RCSWVHdzJwdDlV?=
 =?utf-8?B?Rmo4RjNLZ2NpN2NoMy9Ob3MzNDg0Wk1VQm5JMTNzT0JTcmFjSFp3VUEwMmFT?=
 =?utf-8?B?bmJGUFRaR2V3RVlWK09SZXNJd0RZTStHUHAvQTFOaThtV00xcytYaWVMMmJH?=
 =?utf-8?B?SzZ3bDlRTXZYdEpRSXg4bktzOUZ4YzdxWWhONVFJRDVYWFBHNThFUWpJcjNh?=
 =?utf-8?B?a1VCbC9sQ1NmWTIvQzZaQWFUOWtVTDlSRTR3Wm1Xa0dwOUlSYlRXUm9CdUhU?=
 =?utf-8?B?OFc3MXl3bzBkTlNJejB0eVhnSFNwcDhTalJ3c2taQWJDQ3ZwVXA2M3AwdGpB?=
 =?utf-8?B?c1RibU9lOG1ZQmR3VVAzalJGb25FUE1zL01EYnNpeEZCNm82SEtOc1BFY3JN?=
 =?utf-8?B?Y2dEZkFKNU8zdSt6WlRxN3pDZDQ5L0F4Nkw3cC9sTjNLUnk4aHZ2NUp0K3E3?=
 =?utf-8?B?Vm90dmlmYlZEMVc3cVNGZWlRWnhVN3ZFM0ltWmkxbVNDUTBlYlhiOWhlK0pY?=
 =?utf-8?B?SWtCWXEwWklaOW9qVkkzRi9uSFFLMzk0Qml3eWNDOGVpM2tFay9GZEZlSmZa?=
 =?utf-8?B?R3pZa2lIZVgyaTBkRzJUQ0JCbDhkN3EzdGZldU50SDlsajhEbmZvNUhFWkJ4?=
 =?utf-8?B?RnhqdkNXQ0JXM3hTcVBsbmZuWDFBMXg5allGNTNPWDdCRktYY1RHNkR3QmU5?=
 =?utf-8?B?K0t5QTQwN0QxVGN1Y2lLTG5lUnVZR0VOWVo0NGtxTys0N3JieWZ4OTQ0Z29a?=
 =?utf-8?B?Q3V3T24xL0dBU3UyYjdOVzNBWGk3MG45dWxuNFg1RWFtRTJCTFdSbllOdlNh?=
 =?utf-8?B?aCsxZUsxZ0JtTzl3MnA3bm90QTVoWkxnN1h6eE1tMXpnQkhtbTY3dUxnTC81?=
 =?utf-8?B?ZlpOckNWOFdUVDk2eUg4Smp0OG8zNmF2T2M3V2VDTUprZEh0V2xFWkptK2FD?=
 =?utf-8?B?a1ZFT2x1dkdHdlN1WkEwb2VjclUxYmg3QUpLN296dkQ2Q1pTWHBNTElidCtz?=
 =?utf-8?B?YWRyZ2FqbkF5TEJGaTFvd1YrOThZT09xbjN6aE11ZVljVElTZmthTWV4NWxi?=
 =?utf-8?B?S0RMWC9BTjlHWkZ5aVg1RXkwb1ZFWHRyc3F3d3FYcmFtSlE4SmU0R3ljdDZk?=
 =?utf-8?B?VGcvdENsSGRPTlc1YktQRGgwb2liNTFxWUttSjB2VnBsaFE0bVVtMmxSSkpL?=
 =?utf-8?B?MFlTTUhXWURoeTV5WmordVNzMm9pdUJYUzdCK0ovNzBRMGwxMXJPRzBJNDRv?=
 =?utf-8?B?bWNIa3ZIY3k4YjF5U0dMRjdkczZGVnBrSnc4dzBFY1JxUU5iVTdVem5ta0VT?=
 =?utf-8?B?Wm1vSSsxTlMvczNRQmdSSklxeW5XSDVlMUloc2dQVVE4Z0VyUG4reDdFWHFP?=
 =?utf-8?B?ekg0STRIdUhHVkkyYWVvWUo0c09ab29FMUZVS29kTzB3MFV5bFR5bmN5NlR5?=
 =?utf-8?B?NE1IaHR3VzJiQkk4SjA5am9ONTMvdUVpaHFWUCtMOWZFOFZwNk10dHdxUmp0?=
 =?utf-8?B?RXFQWjNMQTFiZ2E4MUltNmFwd0gxcUVaZlA1ZlpML1U4WlhaamVQUlRhWDV2?=
 =?utf-8?B?cTFBc2JtN0ticVQ1RFNFc0V2ckRtT1JmdythNjFCZHNmbkxNbll5anEvQ3Z2?=
 =?utf-8?B?K2VIbnNVcS9uYjc3RXIrZ0VsbW1QanRzT2dPUmwrZkZOUStUckQwNkViWnoy?=
 =?utf-8?B?d1dMSjBiRlNYWVlWanJKVFduYzd4R0xTaHJpR2ZOK0ZJMkExb0N2K0liN3d1?=
 =?utf-8?B?Ukc2R1ZMOUlGWVN3NGJhVityV05vbldXZ0JOSFNjM0V6SnBUSURXbkM2Y0gx?=
 =?utf-8?B?VHBHOTlORm5LbVdtZXQ4T2IyWlYzMElkUE1rQXYxR1M0TXRBK29seGVqbm5y?=
 =?utf-8?B?bWlJMnJWTGxGYlY0cWlyd0Z6MWNZQUxRc0ZGZ01YSHcxaUhsRlRrSnkwSjYz?=
 =?utf-8?Q?ENzTN9zKCRmCK39E=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efddf22-b295-409d-b02f-08de7dbfed5f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:40:41.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzmJSmsgxIR4iHPx8p8w4DfFinpDZti9dL4NNQK9AZllajpMQq9kaV1aLCa96Yt41KXseBKJ+GxCwl1bKQdvxYF9OQDJQ706ruijaYZBsew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8729

On 3/9/2026 11:23 AM, Thomas Gleixner wrote:
> On Fri, Mar 06 2026 at 17:15, Ciprian Costea wrote:
>> +/* SoC does not implement the CHANCTRL register */
>> +#define IRQSTEER_QUIRK_NO_CHANCTRL	BIT(0)
>> +
>> +struct irqsteer_devtype_data {
>> +	u32 quirks;
>> +};
>> +
>>   struct irqsteer_data {
>>   	void __iomem		*regs;
>>   	struct clk		*ipg_clk;
>> @@ -37,8 +44,22 @@ struct irqsteer_data {
>>   	struct irq_domain	*domain;
>>   	u32			*saved_reg;
>>   	struct device		*dev;
>> +	const struct irqsteer_devtype_data *devtype_data;
> 
> The struct was perfectly tabular formatted before....
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers
> 
>>   };
>>   
>> +static const struct irqsteer_devtype_data imx_data = {
>> +	.quirks = 0,
>> +};
>> +
>> +static const struct irqsteer_devtype_data s32n79_data = {
>> +	.quirks = IRQSTEER_QUIRK_NO_CHANCTRL,
>> +};
>> +
>> +static bool irqsteer_has_chanctrl(const struct irqsteer_devtype_data *data)
>> +{
>> +	return !(data->quirks & IRQSTEER_QUIRK_NO_CHANCTRL);
>> +}
>> +
>>   static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
>>   				      unsigned long irqnum)
>>   {
>> @@ -188,6 +209,10 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	data->devtype_data = device_get_match_data(&pdev->dev);
>> +	if (!data->devtype_data)
>> +		return dev_err_probe(&pdev->dev, -ENODEV,
>> +				"failed to match device data\n");
> 
> No point for this line break. You have 100 characters. If you have the
> line break, then this needs curly brackets. See the bracket rules in the
> above linked document.
> 
>>   static const struct of_device_id imx_irqsteer_dt_ids[] = {
>> -	{ .compatible = "fsl,imx-irqsteer", },
>> +	{ .compatible = "fsl,imx-irqsteer", .data = &imx_data },
>> +	{ .compatible = "nxp,s32n79-irqsteer", .data = &s32n79_data },
> 
> Tabular layout please for readability sake.
> 
> Thanks,
> 
>          tglx

Hello Thomas,

Thank you for your review.
I will address these findings in V5.

Best Regards,
Ciprian

