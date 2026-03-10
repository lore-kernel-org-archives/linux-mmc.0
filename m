Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385E543C049;
	Tue, 10 Mar 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773135106; cv=fail; b=CDYBi7PZJRCDJObMiJiRuzdkYqnoeygq1QsuE1i7zwQrfBFEpARHVKOCGIsUFp9bjXYvglKLmidRz0rJtSFlYGWz7ebBdL7SNx7mUj7VJ1qQvkO+G/PJU7eZd6qDRh11lOEnxLwktUlBftqQ5bAg/5Vtux24AnmfYesFZwULeK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773135106; c=relaxed/simple;
	bh=6c9+gfXstJfCN3SiuWqTENbkBTN2eKZTydTw75pVZ6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=riUlr+JDgZ9k/vxzRKebPzar5qPU3w28oDAtWLeKkqDbt0ImiTqEAyVSEvDLAiHS+br0vJy3H4kSGmfVzUIhWa/NWcuHHRfWUAcoEvXi0FxmD2A+lpZy+kF5sKo1zVxXeaLumG+D3QRfo+HRHfVyPlKDSybaU6EVQCv2eX6C+mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ONaULgCy; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ONaULgCy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2gPClGaru6YAUloMii7jrxT25DH1B3+mXAT2e4J+/TkgubKzugkFTTZlumJfsMLf/RBT4DIktq/lfI2bUv4GzZyLZL1vfeffCmmo+jwr1YB/xm2L+5wEQ2ZIsYQJ7Tk4LE7Gu7QuuTReQ0k/O0qQZP6wMibkKkq+6nsi7dVyhwMCiDgdhsOTAN6qR/lPdsIQSbDluMub56SJKWgIQvVUvAJ6iNfvHwE8XYFc0aCT2N1N+O2Rc5XJBbI+CBMH0sVl5O1Lc/+hOyJUncGK8uLTbzEAc4QQBfeh73GsXtJYqvlbzKN1GB4VfcUi6TFqKIMhOUPSgNscWYoIXI5239t6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6x8NgjGTiIVShZjBGB1QyUIGA7oBsX2C9/kkErWyKE=;
 b=YchfBQIE30GSQ2O1kR5cNBrEZqWTQcupTwQvLbyZQ49yBwGApEcX+zybKbG3gCPk9lnuYnlkOxQT+4EFtd+ZoFrKpHMcXovc2h7+AJnx9yOJf+itSA51Y0XJgj94hiQkvIyqcMN9uXRjoN95R+W54cQFZHGiDF+pvG7+eoW+QFchBNbWuxVqQXj3VGPhqoBZa9bcbVuuow40o/4VyyVyYuQZZiA/ic3gs7jbCTSmAVmXTRVuafmgy9djcpk6mZoZVcZIqVof8nu6rIFocHmL3BxYAOAU8PIRTTc3fLfCpuUSz63BCav/R94kea50I/G51jEoQu9asNdEN15EJryG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6x8NgjGTiIVShZjBGB1QyUIGA7oBsX2C9/kkErWyKE=;
 b=ONaULgCym6S7zak7N6JaD1a7WR0KcbbZp/kSRo2Bzcz8uGT6t+oO3uOmYEMvgXM8wy3TMU/7+UX9eecwhK9HDNn7z/9qeTr3OIyev00J2H5ORvs0p3zr+rfg1fFXKGRNmP+/WNm8+6yR+C5gdiLE9wL33kN3unKUSokrI61TD/C1SD8265b3YZiVPoDAscbu+j8nmNh4BdBMsbYJizXrYvwSF/QiN0Qj/9KYvfznsyoVN5WJO0dZNRy8aYu5JaRCFvtmY4nxfeK3wgyjpchSR5Ud9BIpH0LOgVLZGqFcFlB8lxuqZcMp1h7++rX5NFpD9Fd9rU2IvcCngzBt5YIpXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AMBPR04MB12334.eurprd04.prod.outlook.com (2603:10a6:20b:732::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.22; Tue, 10 Mar
 2026 09:31:42 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:31:37 +0000
Message-ID: <490e6ed4-981e-404d-831d-91f4ed042d9c@oss.nxp.com>
Date: Tue, 10 Mar 2026 11:31:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] irqchip/imx-irqsteer: add NXP S32N79 support
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>,
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
References: <20260309143411.8231-6-ciprianmarian.costea@oss.nxp.com>
 <20260309195652.1788190-1-Frank.Li@nxp.com>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260309195652.1788190-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::12) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AMBPR04MB12334:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3db4f1-a43b-42f7-5dc7-08de7e87d37e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|921020;
X-Microsoft-Antispam-Message-Info:
	EXp6Fp3j4yW8L+nmKI4KeCRpQndwzUwiU8MHm01vij5lq3Nn9SLN+tqHVra6xH3lZ6emoNYwSPUjZJdZXheVi8Bknl+4jG/xgLNcVFwtNTCXrZ/tDKv4C/yTRZGDGuczBpREXzbbGOE9ocwBnU8q4i3pOYiISQ4uWPdTX9dM76W3fCYqtYHkF74pX7OEd8kq7tFup9XT484GOJLFXRvBd0kvqB/qk++rEIOYDPYtAdwqabREbZ8nbtfietTBQo/fkMXSn1LrO9HvF3++rd1sRGY19bMuo9emOXJWAihSrykrDGKoq0Qeyc3m0BhCeL+QfD0XeT5pYcnOdnA97lDvqWPAWav3yxkvAI2AD6nBXDtOYYF1Dt9xzMLRPkrZOCWyelqjXxXxBu11JTmmrmYyXOCBbTxnOX9JbwCwhXXii0i0qXZFz0bU8h+Imxmg/dFYIQgit/S9qZGy6qiwydZbCcDkIupEjiYPI/cTGw3yl6g9yxFoBi2UVxrMCI6xCN3QemovXt7PjIIVEWfDKMQc6VwUKcuOT/8GE/uF8g5+xlL9H0v9V6kyGnNA964m4nlgobvYg5wpY4UooLxEUwSHPKm3yrX2l9DNZvFFrEAETfSFZ+7gIzho0ScbqmnAihnFCRqs4a2XeA0h9tXEI4CShDwojrNmxuE/7uufzLZbh2OKBNLm9rUDOcFA1y3YJszuTNk5tbgbb/KM+VfQjdJ1cgPBCn/PbuwFDlnb7USN3BJlosCCCrIJiJ9re9U4chST6ywKC1poqT3/YwTlKD5oCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDhYRWNBdU9WS3JtRFR1SmVwd1JlK3lzem41TlgxYm0wNDNkL3c3end3eGhE?=
 =?utf-8?B?OE9pK0Z0dVYwTS9JVHI3Y25YcnJHZCtrRjA1VW5FSjVOVXc3cEczWXp4a1J2?=
 =?utf-8?B?TXBZV1lSVUYrQ1RJd1h0a1NYZmpUTk42cFp0bmJ2a0Z5akJlZ3FncktGV3lY?=
 =?utf-8?B?REYxcVVIYUp6K2dKcjJTMVV1eHcwbklBbXpnMUNjSXpxK2Jjb1VVV293SlMz?=
 =?utf-8?B?cWNYblpvcTRXTWNPMGZRd2ZmNU15YzNMQ3d1MWtlNkkwTXIzOWJwMkc3MC9i?=
 =?utf-8?B?S3poVXg0ODlsS0dWa29wdDUvLzk4YUoxQ2tQZlRLVnFtOFpLdnNsVTlyTDQ4?=
 =?utf-8?B?aUtUY1IxN0wvaEl1TjR1eE5nRWxybmtqYmtreG42WEJQVmFDR1U4OVV3elZp?=
 =?utf-8?B?eGpuVHoybGZ4WDZTRmdJdFV2eWdhZ1dqSFFoWGZBNGtUMnFDR3lqT1MvaXJX?=
 =?utf-8?B?ZzAxcVRrSHE1a21WR2Ivb0JEN3NwU202MVBndmVVeXU5TFNOcFBWcXpWaDVK?=
 =?utf-8?B?SVcvSlFFSUNZbGZFd3YyUXMzUWdxaWpxNUgxOGZaTkdiby9lbzAwVXFQRGFE?=
 =?utf-8?B?UUhGMUNOTW5ER1B2MTE4eEowUFlhQXViQ2t2aVRZZEUxN1VYbXo3ejZIQ0VO?=
 =?utf-8?B?dlRwZnNLZU5pKzAreTdWUDJnTTZsY3JiQ2d1T2NuNGZ5Z1AzNWZnZ0ZDOXEv?=
 =?utf-8?B?b2NXeHV1M05GYm5Fblg4VkpvTFdnS3NEMDVnZGsxZlRzS093b2FrMDVjTGpH?=
 =?utf-8?B?dU5DWGlVOTNzZVR6My9xVTNuc1V3Wld6TkJyTVlMaHFoZFo1M2tUb2duZTli?=
 =?utf-8?B?MGNKcy9KaGFKWDh5aGt1dlZ1VkZrRFdmTzErelE0TEtWMGxwQk1nMlFKTDdx?=
 =?utf-8?B?WVQ0cENuY2hnemYvUy9aYzV4MlF1cFAwUm1va083WDFIeG1YT1d1cWpRN1h2?=
 =?utf-8?B?QmoyS0pzVlY0b1VibjZneWg0SVdpUDU5NWZuZDFyTW1sRWlTSnZWems0REV5?=
 =?utf-8?B?MmtxdkxIbzZESTI4bU1BQTVjZnhoRTFCUGY0b1MrWDdHbG55bDFjQ01WMzJR?=
 =?utf-8?B?TkRyYXhodXR3Q2M1VjVaNC9ya1AzT3NVUWtOTzhVcE1Ed2NOaWR2eitKalhS?=
 =?utf-8?B?bTQxUlFCa3lmVXpvc3BTWExleHdDT29KNldURm5lQXlFSVJqZE9WMk5YTENl?=
 =?utf-8?B?d3FyV2JkRTJSdndNNy9zNU5RNFVha2Y0UDZPc3ljanZFNlZtdlJnREovMmtt?=
 =?utf-8?B?UUp3MERtMVJDblZXZ3BTOXJzL1JyeXRrcUFYcWJUTENEVW5tcDdEcjVWU2s2?=
 =?utf-8?B?SExocXJMRU9WMmpYS092NUZmL00rMFJ1V0dGZ3BoWTdUUkszL3c0S3dDK3Vj?=
 =?utf-8?B?bzFtQjBSOWR1RjkrYUhaV2JqMi9GazEwZm5EcHRrK1R4NWtXVUxrdTNoQWxY?=
 =?utf-8?B?NGpwbEE1SEFrSlJHQ3EyMzJGUWVveWFJUFg5TkZkbkJKeURKSGExSFM3Z2ZR?=
 =?utf-8?B?cVdrRWFhWTgxdXk5aUVTSVV5Yi9qVTRKUXZ0WEhYSVFybDE0WmY5a0pEOTdJ?=
 =?utf-8?B?a1RXSTQrUmZrUU5QYUt1S0xvWGErQ3NuRWJtWVNNWnE3RHpyNHR2c1lYbmsx?=
 =?utf-8?B?V3lyL3RPYlZLU3NTMmp2bVNRN3BVdVF0UndEeURyL2x6Q0QvSUJ6b0YvZnJC?=
 =?utf-8?B?Wkg4VEd5QmRSd2NSb2NsYXlIcnJ4ak9sYnBYUGhpaEE1U1N0czcraUtwdmZF?=
 =?utf-8?B?MUJCR0pyckhNN2NqNEMwN1BZbGttUVpKNFJGaG5vamgzczd4R1lLTGZKaXlN?=
 =?utf-8?B?QWFnUFgwd3lGWkxvS09FY1BTWEhYSEJrQXc4TVorWFhWSWhXTi9GY0VHTDBR?=
 =?utf-8?B?ZkZaVllkY0tNS1FybVlhTWhoekw1bmYxQW9TV1oyRFkzMDVITldJYWZCZVEy?=
 =?utf-8?B?dWpiSDUrdzJXNmpGVTVmYVFDWG9LcWNoTDNGd0o2Z0Faam1nME5iV3ZrS1dU?=
 =?utf-8?B?aWN1YndaWlJQelhhTFgxK3MzTm5NWTBkZGFOMGRUYzRPL3dkcnhSK05JK2lB?=
 =?utf-8?B?TGdJZDdXOGtWejNNdDBaMi82MG5mUnB4Y0gySTJFakcrSnhDN1VGSnlJbEN3?=
 =?utf-8?B?bHhoQWkvVm9QdE1rZ2pwZ0hzS3FUS3VuQjlyR3k0dXNXODBFdGpEbzZHdS82?=
 =?utf-8?B?ZlkyRERWOTFjN1VHVmdFdS9FZEZPOFE3S1NMOU1NazJPMzhEWG5NaG5pMDFO?=
 =?utf-8?B?MmtIU2NFMXFzKzh6OUw4UzdZQlJyZmZRaEpTSU9pTVNLbVI5YWFKTHZYcm0y?=
 =?utf-8?B?NFhDVllYaDJpcEJlempScjdNdDJlQlZmQ29KcUZqRWpnR2NaWHlCTlpjTmJq?=
 =?utf-8?Q?iDUJ8laGfaW9n+eA=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3db4f1-a43b-42f7-5dc7-08de7e87d37e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:31:37.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrjixQzADBFqvHxHdxbudZ37C0q9r6LK7VtRBNnEZyWWphffMbPElOdd2bb5eyaLMN34psSIRQRx1tx2MZqflm6FZiHYxzSUt1GTjFv3v2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12334

On 3/9/2026 9:56 PM, Frank Li wrote:
> From: Frank Li (AI-BOT) <frank.li@nxp.com>
> 
>> +static const struct irqsteer_devtype_data imx_data = {
>> +	.quirks = 0,
>> +};
> 
> AI: Unnecessary to explicitly set `.quirks = 0` in imx_data; struct will be
> zero-initialized. Remove for brevity.
> 
> Frank

I'll make this small change in V6.

Regards,
Ciprian
