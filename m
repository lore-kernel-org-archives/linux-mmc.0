Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09641BA72;
	Thu, 24 Sep 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239757; cv=fail; b=Bo1Q6/BOFs81WUzgVAT0xFv6dytKyqudU6SLs/pTlo2SgvqY5/EPyOJlDL4NUdpixkOtBDpz3O3XDP9DnFWXrta77Ix4yok5crGqj92XEUUBHw1BtooaWU3gBzDry9KJXvPcA3mD46wznHnaE/qPCcaW5KXnTUHrzgsIVROd404=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239757; c=relaxed/simple;
	bh=f3r66GZ9RhTQJVBinN6Jj+fqZ7zhh/XKwuCX9UdrXqY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pH8u1nRvmt1A8gUBLcivhBXGveaKlIM3S72ZkJHsYxgpkgaVjy7aq5GGLU3M1hE9l9JV7d8S8ECT2yrEpHqRc2jS+RtN3Q23aPG7arFPel8R28FWZaNwuNQ5OSp/q7dcxKyHxvUMW/xMN8FslL04Ml6k6du5W3JF0i/PeEiKf7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=WVCCW9bZ; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="WVCCW9bZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/5tMZXWTuuDAvpxZX5t5DjfmOIoh5C5IBFpPw4+zo/dAQM4FCIEQWkk5prj8hAO/CtY2uYwixMz7JabINJh+paWhP1JT9Kgj1MLA1mKTgiIy2Tm9ij17YExxFYfy4ZdVg80dI7bynHN0QDV5q3H9bU37iQJzh8U06PRaJzpWgSnqjiDlwp0lMOoYCj8Qy+zK3CdnkkfdIq5Brcb9w4vhZzs8o/iO9jiBt98bjpxBUZLuznwP3nDxJkR8lkk3LZQx8d4Tt9mbicIS8fICocZk2rQO6X8RzOF1Dmv2+hRImZVFfhbdM/maP9bML9MXWFAm9yoY7SObVKp2csFDnDlZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xD3mVj788pXFV9u+iTeDDRaqBPmzpXcL8avKvENK/5k=;
 b=GzkAQRrEouakUzl1r3xI9UsH/tYRPYptvOeP+4UMgahoLNhB87yVtVkDQjRC6chDwuv83bizmp0ofwo1Y7Y4in/hn+PlDNPyiank34NuX7uj3wVJ6MWplSYh8zhwdEhkjDV5HDKfVoFUO9M1BBzUBg5KrFCfyjuoRbg3HHAFo1PfHUEO51np5hkVvGEOzI6Fevs6inrJEQi3XEEb54EG+iWajjas+10SRIpKy7xbiW3O6EAOKKevJzOn5inb9Sx7yORalJPk21PL73kAKkfhgC501OkaMxmhmv9uRZRWCChSSl6UCKkg16IpmjnoTOOW/VUpAcX+AOYOE7sc9Ekhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xD3mVj788pXFV9u+iTeDDRaqBPmzpXcL8avKvENK/5k=;
 b=WVCCW9bZNU6yDEwkjaidQg52CEoHGxlzhm86uNStF5R5SsiA+GABoZo8S0yjZbJjGo/0KMWULxSWTfXLovuwwa9yJVhYefaYurt2a6mEfhzBvwgRZfZWlFj49gSduVbuzAfOjQk72sVsY0TbPjxoN4lSK9unI21J/OwkQhRwlI6uNA4gC5l0to5AO0Zm2yMKNS6fBXqtYHifW+0oV/KLr8VLTfuPmzL/Vb/QXpyfDMHmh9LNS6ZlVE/3WLlJ/xY1DZ3xZc4oU2Vu0ERv50wksZcKXrTolm3I+jHb2J1PR5FyWTNdV5Amk+XeQMXrB7K2CpHt29O93IVSIK1JZTdLQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DM4PR03MB6096.namprd03.prod.outlook.com (2603:10b6:5:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:49:12 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:49:12 +0000
Message-ID: <aa327f2c-5db9-413c-a846-4d74cffd4a53@altera.com>
Date: Thu, 24 Sep 2026 14:19:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: add PHY settle delay after
 tuning DLL re-lock
To: tze.yee.ng@altera.com, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::16) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DM4PR03MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: ac73b5a6-9611-497f-9758-08df1a18b3cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|4143699003|11063799006|56012099006|10067099003|18002099003|55112099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	VgLe7CDSWBL9wOTvA18LauN8OLP8g4TRx4BTQ4ZBGYet9hq+069dvLKZFx4WepL/IioS8mwceO2ChUmnty/qxuVreEq87k1jV2Kw/QD+BVEAIu43KYII25VhfgyGrrZh7OwAV9LKsDmhM8GRWezOrATbtd4eLwe5Nxhhbp01jqEbRyxpFRMuxScEPIBhpqFhNpFKhB+IqAmSZ4HCTCaEmPcf38FO+/4xNM4cWfDqQZpZz3/V+/kdqDiKw1dvWGMbFQzUbrvnJ7OGYQjylpNrR6/d+IEF11WLVr0sA25PSTQBFM3eQNGbLigPJzJhppDxeSNrsGcaqALF7bIdETEqHNacZKEFMl0jjDWKS4RxmbBZGa8y/Z0KkSMp63rCfb1TtSuYvkB0pj9y8yRuSSWGhTJnt/Ip5acbVYKAnCDJNAfi9yRbK+inuGr3DjO0pzWUUUZy1RtCdfEvWnVgA4Tm8E4xqAuKu0VnA3lduJT/UYgMUvn8GDTeEEw226gGdlbx0kxieOBRYtPQ596zVpyC2z9onnL+mZuPlcC1zJZ7mO1amTwzlB05WrVVTLrW0dohQi7juNUZeKXS4uD0o91dGLcaHTqfsh9XQUNSThJOTmAW0/945EfBnVdsl8DFhjqELV/kd4tAYe5Pk0Yf56j/YTBeZrLnpUt4csDQ+OP0eyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(55112099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnZhamM1SnpNQmIwQW1FK2RNVzB0cFMvWWE4YXlsMzJpM2gwTHNwU20vTlVr?=
 =?utf-8?B?MVViellHcHpTaU9MZk1hdGp3UjY1NjRWYXdma2tRbm9KalFZZVgrQktZM3A2?=
 =?utf-8?B?ejlEYzdiaVA3WWlLNlV0WStMdGszWng5L09LcXJYTUdjaC9tek5qRTZ2VHhy?=
 =?utf-8?B?Z3JXUHZUNUJocnAvbngzMy83Z2d0SWxaeW1EZVp4WkhFL1p0ZFZkaWl2anAz?=
 =?utf-8?B?RGx1VkZneTM1Rm5udTBRUXlERkJJeE1sQkpPZm41d3c4Tzg1TGdQSkdBQktM?=
 =?utf-8?B?dkluVmJselNqR2hhbWV1T0M1WUsxMWZxQ0VJTmtoVVNtcHlUV1FVeEpoeFZR?=
 =?utf-8?B?MHdXQlYwVHR5YUxmdmxHbUdFbE9nWVRQN0JEUk1QRmttY0ZtYTh6R2tBU3JG?=
 =?utf-8?B?anB2a09uMk05VFdVOFFZdXpJaksrY2crU0xsY0pmZUMxUTBoZEc2eDhBanJL?=
 =?utf-8?B?WDUzTmxNMHVWbFFNK1lyWVlmR3doTzFCc24yUjN0N24xVVZKZiswLzVzRTd3?=
 =?utf-8?B?TmRCNzBKMFAra1hiY0VIK0hrU24zQlRVOW5GZ0k3SWVtemlGVUt0cE1JZG54?=
 =?utf-8?B?ZjUyUmxBcnArRXVhQ3VVaUNjRjkyeXpxOGl1MlpXMVA5YlR2dDFPYXZWcmsy?=
 =?utf-8?B?dkpWbG1WbTRCczV0VmhTbE90K1BDYnkzclczMXM1TytPVWw1Qit0M2swSEtp?=
 =?utf-8?B?bEgwcVYwczhXZmFuc2tMNVBRUlBlYkdzKytUdFhEeUNJRTdDdHYwU0tTYTlL?=
 =?utf-8?B?QVE0dGkzNUZHVEsvUEpGT1cwM09iNWQzWWdIOXpkRWFBZWRMdElCVnpsS1g0?=
 =?utf-8?B?WEc4aGNiSTAzRmx6aGthZTVGZXVydDRycCt0S2lVbHIyOEFOeGFtN2lpTmRV?=
 =?utf-8?B?RTVXQUNCSVRhaG5pbHVJdnFGdmpKam96WUx0aUQyb05Rb1poNjFnSE9QRXRa?=
 =?utf-8?B?SkJpZFh4dGE0OTRBZnhrZmJXQUdHWG5OVHhyNXZSdC8xL29EOWRhYWs5a0tx?=
 =?utf-8?B?R0hrbHlhWGxVVkExTTl5MXhxbU5qRjQvNjdRdGhibG9ZNnhOZlZnODJ1YnZ1?=
 =?utf-8?B?R2NkMVZnMHZJeWtaRWpFdVJ5b0xoMndOY0VFbzVseGtVWjlZU0o0RWorYmxo?=
 =?utf-8?B?eFQ3WjI0RC9pSU9kcjE1UUhPSWZiYzRTbDY2OFJ6ZXVROWswQkRKb21WS1Vi?=
 =?utf-8?B?U0lIb081cld5MFFGUzNQcHZTb0FETE1Wem1wZnpPZkk3NnhZUWhRZktEa0pU?=
 =?utf-8?B?SVl6TFVmMlI4eTFkUHlKQ3ZKY3NreVJjc1YxSWJQT1NKRzZwWVFSTjNDUTJB?=
 =?utf-8?B?SlI1U3VXK3lOdkN5a295Uy80OU1YNGlINlFmZ3VVZHhxN3VGdkJNSnNvTnBJ?=
 =?utf-8?B?Wi8vVVZwWEUydmRvUGdUcGFhdjdLdmhwTCsxdkt4UnhPaGJVZWpZNEZWY2ZX?=
 =?utf-8?B?SzZaTHJ3Y3RWWlFEc0MwWnViLzhkOFVFNEhzMVhNSDNGWmZxbHM5ZEt1Sitn?=
 =?utf-8?B?NnhyczdUZ0xTbVF0Z1ZpZXYrWlUyOEhyM0l2K0hsWWhRSC9IQ1FFSEswZnlL?=
 =?utf-8?B?RlMxMXJsYzZlbDBCZkRjV1IyWnhqZExJd20yVXUvMGhyRkZHSks4eHBPRis0?=
 =?utf-8?B?dlB4RS9pZzJiVGc1VFcwNVJ0aW5wL0VoV1FjOTZTNWJSS2FEZklocXlDM1Jq?=
 =?utf-8?B?dVF1ODVHOHFxMFVVVmpRTUNkZFYwMUZqdGUvQUlqSVNMUXBxTDBiZldPaXVX?=
 =?utf-8?B?SnFhSDB0NmJkY2tBVkNselZIL21GdzRoYVdWYnF5TEJFRUFqVitLOUM2aVgv?=
 =?utf-8?B?Q3cxckJXeUFxeVVWb29YaXo1RnA2VEQxY29LWDgvQXpFNzVyMWZMeDQ2N0NV?=
 =?utf-8?B?cTNjOS9VT3l6emtIdFRRM2FsTE9yMWdBOHNGSnhWVGNZc29Oc3k4cjdxeUFJ?=
 =?utf-8?B?MEJ0Qy9BZk5paEdOZHZ6L0hzd2ZVYktGRWpMQ0plZTkyUXpWZXhjb1hSMDNa?=
 =?utf-8?B?VVFXVHJCVUtHV1JwOG04MFhnZFhHemllN0IrTTNDeWZGMFBHTTRRaks2amcy?=
 =?utf-8?B?N1VHWlY1TnVKNE9yUzFtWjJaNlJ6YUJnVUUvZHBtTmFUYmtHc2t0ZnlWUUpB?=
 =?utf-8?B?WUVlV3U2QmJzKzNZejBzSjRKMEZldTRpL2ZXQUxsQllFZFBPZ0w1Si8rb2c5?=
 =?utf-8?B?WEQ3QTRYazFXa1RFSEkyOGR5aHA0UXZ6cEpraVVQNi9jSUJJb1dzVEx0RUdW?=
 =?utf-8?B?bG5oTHAwVG9zcGZuaDlRNFR6S01nelhmTStWOFI2c1Rnc3ZRQjZxTThid3RC?=
 =?utf-8?B?SnVoNnR6ZU9UUUVneVh1T3BYdTFIbmpHblcySm9kNDF6UTcvWHllMzRWRmRX?=
 =?utf-8?Q?JgHLhphehYKAFQaQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac73b5a6-9611-497f-9758-08df1a18b3cc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:49:12.3261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 576awPjugvHvX2qnaeJCPw3N8RVrUhg9NhmwcNjjRZPB6vali7dawljoGcFmtMlj7FsbWD2tEpDigebSHXCU5gR2sOdCEzhQB57McyyP74g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6096

Hi Tze,

On 9/22/2026 4:42 PM, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
>
> After re-locking the DLL, allow the same 5 to 5.5 ms for the clock and
> PHY signals to stabilize as sdhci_cdns6_phy_init() does. Without this

I do not think the comparison with sdhci_cdns6_phy_init() holds. That
5 ms comes after a full PHY and host reprogram, including HRS writes
that happen after PHY_INIT_COMPLETE, and that path is only used after
SDCLK or the speed mode changes. set_tune_val() only updates two
phy_dll_slave_ctrl_reg fields and re-locks the DLL; it does not touch
HRS, clock, or mode.

> settle time the command issued immediately after tuning (e.g. the R1b
> CMD6 that switches eMMC from HS200 down to HS during HS400 selection)
> can time out.

Do you have a log for this? Which mode, which card, and how often it
reproduces. I ran a long regression on eMMC and on SD cards from
several vendors and sizes, and never hit a post-tuning CMD6 timeout
without this delay. I would prefer to see the failure before we add an
unconditional 5 ms.

> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
>   drivers/mmc/host/sdhci-cadence-phy-v6.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 22d56bb46d75..35f35ef9c710 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -811,6 +811,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val)
>   	if (ret)
>   		dev_warn(mmc_dev(host->mmc), "%s: DLL reset release failed: %d\n", __func__, ret);
>   
> +	/* Allow 5 to 5.5 ms for clock and PHY signals to stabilize after configuration */

The comment is copied from phy_init() and says "after configuration",
but here we only reprogrammed the slave delay taps and re-locked the
DLL. Please reword it for this call site.

> +	usleep_range(5000, 5500);
> +

I think the placement also contradicts the rationale. After
sdhci_cdns6_dll_reset(priv, false), PHY_INIT_COMPLETE is already polled,
and per the Cadence DLL PHY user guide section 1.2 that means the master
DLLs have locked and the PHY is ready to accept commands. If a command
still cannot be issued for 5 ms after that, then all 40 scan commands
were sent on an unsettled PHY before this patch, and the real bug is a
wrongly chosen tap rather than a slow CMD6. If the scan was reliable, the
delay is only needed once, after the final tap is programmed.

Also, the sleep is placed after the "DLL reset release failed" warning,
so we also wait 5 ms when the DLL did not re-lock and we are about to
return an error. Skip it when ret is non-zero.

>   	return ret;
>   }
>   
Thanks Adrian - I'd appreciate your view on the comments I posted, given
your experience with this subsystem. I'd like to hold the patch until the
mechanism and the cost are clarified, and happy to go with whatever you
think is right once those points are answered.

