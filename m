Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AC037E319;
	Mon,  9 Mar 2026 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049395; cv=fail; b=Ah+DcEjhUpU1NOq5y9lQtC90pyd4zNq7L4zPKKo+pbMqW47VToK8fH3UWE1Xbk+c3EHYfOvoDmPfsKPS5SyspSXzJRehdCdTH4Nn655jdN5ilLXIO0YbPtHo3vjKhwVFvu/sfwx2hRj1QCBj6jbrvuXJkWrbr45ElWxmfGksCns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049395; c=relaxed/simple;
	bh=zlQCs1S2gydfpeGD6vGOMsxJ2r8G+K4GNcvlelp07nY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EAl44sxPBANaYloKX2V3akza/qeXywlSQemfEG7nhYNl9zWufWinEavMR8YAKtPFqBtFEKx68Xd4g44opLUh79Q6yNa3vwAPnTJkBfHuDLhRBguiJ5Dex4wD+rOtYtDHB7qBURQxQoZm1y9aQxN/jra04AH8C/Qezxs2bEvNSUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tND3gL+K; arc=fail smtp.client-ip=52.101.83.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tND3gL+K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjYcZ8Fh1+CqlEG+/XGyp8tGiI2XWJUF3rW3uOWwE9mmTOs6GieY15Yvh1DPOh/hEeqG76o126zkyK5ZrSHqmnFzvFcGnLDYNZ9POjBhI8+8T48As/KDCryqYCcFOFgxKiss3vr2EbTLlZo/9RVCX/fa7Ne5jOJeY34DipEGhiSz/lW1nJUHL+wcU8Y7aHMxbwQl1yJYcTj5v511zARO/ee95l+dyO1QtNE8Xuadow1JRplBkMY36xqlGLD+gxv8OFFhV8+Hd/SZqkJ/KGe5icO9Pe5sXgfZuyDEHWiwHHr3jKb37jUVIycxJbF78AsYJ428OeaMBManFDlld9agDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwj5Ko6s6gY5xpLSkyXqOm4jMGA+u9EJI0q9kS7VJAM=;
 b=EPBm0S03hqP0U8W9S7clZahJWMiF7tkNRC35qvedd61pzcz/XlXA/R/t1nv3jFLxzKHt3yUSuDYQyKpod6OPqDhaKn1DpXl5yrCDLjizT3xSDjk/JLqqNc89KStmTWQy7/NktB7nf3f5E1CWPbZplLjsS8cfo3fG5ZRJgo7XEmBbDnP1BRvGnz6FK5Xl1PEgPcOrZ5kaq9cQsGP3Z65NwbbE7kZdHveOskyIR2UW7pr5SsUC9/8BM2UTgfrR/3oCfTOjqBaoJ5CkoYAhVCnoWwrH3fgcVB9lVqZPRsQBfoh4MTjePycc4QIcpS2TtaT6oPCUjnvUALkH4aEqzkpKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwj5Ko6s6gY5xpLSkyXqOm4jMGA+u9EJI0q9kS7VJAM=;
 b=tND3gL+K8XqBlFz28DB606bBdHDtDJt6ZKsRXpKZ9+mHIGrwrLIn98hoBxWdXv2aVeC9HpP1jdLsn65iOEi7bL9BZK1l6K5GKlcceTSStpUwSoMNZS6KRbgu3bwCMw2VLDLxes6E5zvbiJ6poY3qEJqCX+zo86oFRFRPctryjgpcPWAuKPPweYszfd5KUCvN4l3ErfdHDufS8ZFAwQpVckHRWoA3hKj9odsHvZW+E55ivBgaA3lmFzGZFgCU7+Tsq9qzBctK7C0yM7Rth9RbTTxRHK7LN88PwDjULEmQI3LhqhNicCFgkyakyIXBiLIgQGWIQG7nr9kkfjPkKeKqqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI2PR04MB10738.eurprd04.prod.outlook.com (2603:10a6:800:277::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.23; Mon, 9 Mar
 2026 09:42:54 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 09:43:01 +0000
Message-ID: <5136bdf2-b089-41ef-b7c5-21a826982b18@oss.nxp.com>
Date: Mon, 9 Mar 2026 11:43:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] irqchip: add ARCH_S32 dependency to Kconfig
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
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>
References: <20260306161555.9000-1-ciprianmarian.costea@oss.nxp.com>
 <20260306161555.9000-7-ciprianmarian.costea@oss.nxp.com>
 <87h5qps67d.ffs@tglx>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <87h5qps67d.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0032.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI2PR04MB10738:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e621cdf-e686-44db-4334-08de7dc040e1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	M2df8imyhuR0ZiRUR0/O2DOE0QjoDIBDKEW2c4VZlj9sUZM0jrEdnXjEMewxz9PEBAA7bC7pqp6o4JPQZYYgHxPHsO+4QT433BYFNTY/UVhJN1Aq7IdHZmp4MC6JpK55J+ZwJC4eMwLYKbcUT/FTyD+l8I3fsdgda7RGJWM+cjsklzhT8gSdwomQRgftTIVKbQt0B8sdh8Hzv6P6aFzPBhBI/RKaqorStnQuakynWN5LRqHNK0hZglIpZg8HcZvhkuusiK+d+sJDUcAaVhN17gtNEHv2PBtZ4bSglz07EYb9EC01eNt3V+UX76WbfXBJYmjUlhSUWowrIqY9J7bDsAQ99U/Dc+OjqzF5k0Y7ivmHg9AfzhkMpGIn2v3Kb4D2W/A80SZMTJOj2ZMQyj67pCEQZHOFuq2oN5YlBiSEiHf9e0jcJkcVsnSTLo/EwG7WtuoH8QKhyhDniKduiQXrHjo9NYlrGxQ5vG6te27FXuzCO22Lbgdw14lvqNFfZzKaXxtHP/ZPDuKDNhbxNDqKbTihv4MSXIBvcFfonwMFJ7u6p8GNXFEoigWANOkwEmyDB8d1tkPr1+OTtnpSqbhY57oEayBHI4m3BW1PMWHAnL0uI3KApqzlAHHjQ8tQFNGL08mQHFF+qd8Uzf5LnXgTdA2ZR3oYin2PafBg52+QlBiQjyBnPlBV35fNvHPXlEZ8LpedIqMCfET9Z/TzDKI6ltFf3YMkV8CBAEnYB1eGUoSy+kgMSiqCOBfS6X7B45LKj7DCyFuUQxTEgX2XhRg+4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2d5RHlHZi9scDE3NnFFajVRTkVQOEZUTjNIbW05R01TNXZWd0FoWTFxREJx?=
 =?utf-8?B?S1F0RXlhTmpIdjl5S1V3WnZjRUlXZ1NpQVpMbkdOY3NPeWM4L09iSHd4djhx?=
 =?utf-8?B?NjBDdE54bXBkc2dHQUowemxDQkR3bUJabHJFZDh5dVJRYVljZXFSZXYrR2Q1?=
 =?utf-8?B?L0YzeUxscWJzTTVWZ1haRXBnalFFS0IrelJ0VllMbmF5b09lQ011Nm1pV29I?=
 =?utf-8?B?cW1FRktUQ2paV2RkZ3NhY3J3Z1JVQ0t2bGRraTZvNlZoUXpPZDBNRkFEcGJC?=
 =?utf-8?B?dGhHRXhXK2NzcWVKU0c0QlVjdjhPZHFab2pIZ093OGJ3UTJPRlJVek81TTd5?=
 =?utf-8?B?NUJ5ZWpFVWlpTHhoSWNLSGVVdEpNUTJ5aThmSGlWdkRxNmpUTEVUOFl6VUJV?=
 =?utf-8?B?bWcyKzc2bUtqRy8ya3pnNGFaaDExdzFNM2U3UXNsUENUb2xJemVsYXduVlo5?=
 =?utf-8?B?UUFoY044OGlRWWRMYUMwS2RMeGpYYzN2ZjJ0NHBYMWpnSk0zR0hLNDdDcWZH?=
 =?utf-8?B?SzZzOUp6dnk0TitxZ0F1NGF1SzNha3pPVE9QZUx3R1NwdG5ZeGdaSnNxMTJo?=
 =?utf-8?B?cWlYRURab1h3bGVSWWF0dmxSaVkrcUl0UytvQytMdGdnaFNIeGJvNG5sVGN2?=
 =?utf-8?B?a2lDeVZwK3YrUHE5WGxHa3QvaTB0RUFPNHEvcHVrdklmQ0ZPRUk0LzJLdHY4?=
 =?utf-8?B?OFdwK1h2WlkvTklTZ1p5R3l3NVdndENtblptM3NnZnZrcXFUeEprN1p4em1E?=
 =?utf-8?B?Q3JsU2NDNTVRby8rZ0RRUHAwTk81TnFlQ0RiRFRXY0Z1SlVhZnh0eTRUSTc3?=
 =?utf-8?B?WUFhdkZiaWVLNTZqR1FTdHZUV1ZIaDdWa0lKM2UwTElYYXFmZExHQnB0VWRL?=
 =?utf-8?B?SzZsYjg2NnhGQ01UaTNLSXFkZ0wwZFEzTjR0dVJ0U0E2NkZUaGdVZTVsTVR0?=
 =?utf-8?B?WXAySnh6NnhmQlowTStzcjdkamlqVm5KU0p3V25mcUovaXZIamhpSE9rQkZK?=
 =?utf-8?B?Qkx0b3ZKN3dhb1M0b2VFb0U4Zno5WEdCOFNOOUxjYVpscHQrcDJNVGdlb2x2?=
 =?utf-8?B?V0VRZFhtaEdzWndvRlpjaSthY3FKdWJ2N2ttdjhYLzVGRUNlbTFzL041NkZz?=
 =?utf-8?B?bTlVQ1JpTko0a2ZMUkJuK2xaMS9rNnBOMzJaZlRUcDJsUlhNUlJSNXllNmpV?=
 =?utf-8?B?VzIyKy8zYXFsb25zM2tWYWQ2bldxR2J0RENyaS9lSDhIaWs1NDNtK0tzaHVI?=
 =?utf-8?B?bE5oYnhzRFZaazZMVFhFbzNuc0ZVMm1reU8zaUJGYkJiTlE2VGU3MmYzK3NI?=
 =?utf-8?B?MFRZN2daVW5RcnU1dytaVUJoaE56MGpaQmdxZk03K2FheHdFcXFOczFVUnBC?=
 =?utf-8?B?WGFDQkNWNDk2dG5HSlozUDJsbUlSbWtvQzNLUDN0Z3pjeFFNdmFaRUlxTGlv?=
 =?utf-8?B?Nm5uNnFUbGU4c0laUGJPNm5SS0dXOWRydzFNVko5V3VXVzNVK2QyL0NIbHM2?=
 =?utf-8?B?VDdFdG9QQlRRUXRyejVXQ0k4YXI0SE5Ua1E5eHhiRi9OUStXY294QWxVQzM3?=
 =?utf-8?B?eTRacmdrVHZTb3hiSHg1QlpESFdNK0tkTE9rdUM3SzBOcUY0K3BtVzA5TzYr?=
 =?utf-8?B?ZnRlaERVZmZTZ0tPQ21UWmxsa21aQ0hGdXhsd1pqYUsvOE5lSmxUWE5EMDFr?=
 =?utf-8?B?Wld3dUREM1o4S2xsTG9xMXBhZVJIQnZ6VTdOMGtLK2E3VVFwTDI2TWhYTWhQ?=
 =?utf-8?B?MmZnTFpqbVE2TEZ3NXViZ05EZlhwWWYydXZOdkNkZ01Ca0pTMlJTUHBVR1M0?=
 =?utf-8?B?UFVScWVXamFYSUFUZ0NaN0hERCtqZ3pMK2p3RzFkSm9EdHArVWhEQWwxVlRk?=
 =?utf-8?B?aGdncG0xOXROakRqWUdwVDNCVFJPYmFRaC9WZ2tZaGpIRFhLZTBCR09VZStw?=
 =?utf-8?B?c0VpYlJsN2hlOW4zazc2Q0d3REQ1cE1wZHQybm1iNUlrTVdva20zOHdzZUNw?=
 =?utf-8?B?YjFjTzVSOGxLQ01tQVYyNnp1eWdxN3ZvMmo0NEJ2RnBLV0NjNVd5aFBXSVBR?=
 =?utf-8?B?Y0NUeVBFR2dGZnBQVk5xbWhOTHJuK0tjbzUvMU5OZk4yVml3eGxqRnhsREpF?=
 =?utf-8?B?d3hOREV6elNHU0k3ZllqaWI5ZVJiQ0dzWkhhdi9RRVZmTVhRQ241NHBEcytE?=
 =?utf-8?B?K3dwT3QzVUx2cEUwdVFwYVFHdnVvL2Q4V1pJWGZOQzV5TjZla2xPOVZLd0lP?=
 =?utf-8?B?NGJQQllCUHdRWGxoSE5UZGIzTVczZGVHUk5rV1FieW41VUxrbmJhKzRwWjhK?=
 =?utf-8?B?U1RFZk1MZ3ZsRjNyNGY0d21zTUtIeVRYM0dkeWVESnpFaGM2OWRBYXFyODhy?=
 =?utf-8?Q?3wU2FaBOitBf3rM0=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e621cdf-e686-44db-4334-08de7dc040e1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 09:43:01.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7e5I9iHDcOQTDRjUEX/545won0RR5LyK8doTfmIlLKD7BeyIL3pmogKrqG1ST6sYkGqIPMOZ6lDN5mFuYTpCXEVzx0kH+xkHswGO2FPlEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10738

On 3/9/2026 11:27 AM, Thomas Gleixner wrote:
> On Fri, Mar 06 2026 at 17:15, Ciprian Costea wrote:
> 
> That subject line is useless. It says that it adds a random dependency
> to Kconfig, which tells nothing. Subject lines have to be descriptive
> and useful on their own w/o the need to decode them through the actual
> change log.
> 
> Just fold this change into the previous patch which adds the ARCH_S32
> support into the driver.
> 
> Thanks,
> 
>          tglx

Makes sense. Thanks for pointing this out.
Will squash this commit with the irqchip driver changes in V5.

Best Regards,
Ciprian
