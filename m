Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BE3A7198;
	Thu,  2 Jul 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983092; cv=fail; b=tEHqNMsDsN4uPsKLPjbkWAp4tGd1zZtsrzTah+v+MCA+Msuk7fOXKQyWT77ZTJ8api+95DSYtwHzscLAG5WirQo3UWYEbM+eSQCq61NgTeYP8Tv+zamvWrlovSj6eGGAqBj3NPIkp+FfhDxSWZUcEkBLGJ7QDVgzyMEg5jp/A3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983092; c=relaxed/simple;
	bh=w9b5nkkYSR728GZ7WV9V3JS8AMLKwLcuzEakgzCO09c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cm7l328BYuShLFQbyiA5rNs/gTziFEIsBxojY4l1Vj4VBqjKDILrbLYug4iZv8BdnZvYJvCsyDggd9XsGtsxoNB2dykIkjmlA1Ws2rAaxT6qco7S++zwuTQb66ll1cr+UPASUT5z5XeQ8qqTnfsDwjdUs2dK6xPMeINLZeG8pDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=hR9yqSch; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="hR9yqSch"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUs1VxjS9K3NouhSj6dn2nfWPFNiz6WSzHHmm1DG8tZ/m7Em8hM3VMIyYQArKR08pBBQK6f8AvHnIzhpgo21wwqW/VitUUhvgWbyzECv0Qz+47yc8jUlDfazSYlK4BF7Xc5Xsi4Medysc7mu+vd/v832btrGSg9rT6leB2jDsitSPZuFIdcVzJ4WOChWTCdNfisFuNGFuFAOQq7ECIlH4tuleUk04GaZbRJxACWoccaeHGN0Eomq4iHcGBnQellPCC9oH5xDK6l0YzNMaBaCFQxRl1czlfWxxDY6yHM9y9kfuCAblkAmTE3XbBO4ZMgJINDFMBYgNGDBZ9G+Yp3Syw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fK+TIEka9ZR2sPMB8o0OYv4+uQHN58f500Unnw5GMM=;
 b=bFdsoSciV5hKY7pEqcO4iDYRAHz3HOcq628jmiYpAVT7jwQckPIaKN/GFLcIG4cqkfy/ZgM0jpoc1V8ilmOAZm8DsffEhT+PFimv85eGfaTp0bACsBzow2emncUXA+nzAvKIwwIOp4/VQivC9XHsQJQZ3PoeYASaE3j3qm8LIQjCwYl7VtUxw6s1kwAfSQ4Bohpw+DHp+wbo5Pi3dcfRT1pX3/coxyyxtjQyvlmg/m2ghD8KTnfxF1oHRptUqD2dQtMgXd917++5qn7mrnDWwI5mzGhc/EUa8EMSyzi6ChpF+lcm0Br+j73+DqdKhAfE9v3tP1SO9aSMG1SzvAXeMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fK+TIEka9ZR2sPMB8o0OYv4+uQHN58f500Unnw5GMM=;
 b=hR9yqSchoM1XJPUNx0gs+9ZnvhpwBhx3nQWP8c5Pcm/aMmkLtnaiMl0vZNgvowRJvmw0yqOkp1jeDJdsl7+wsSl0I8+8QQCyX34y7OSqDGEW+1U7S5QaDoePuXQWMXn96D0X1TdRxbsFNrv3xekDIbmGnA7+JJgfPmdacEsTJHHBdJGA+H9BR/0+ULrnAmJ3sMscxYmqNmQZk85qLyhPOUmfBYfyDXhN+w3Tcs4wq/Da3apM/jj/nlvybCo8cHeTfdGpDLBBaiC64/qQBWq4ReFYYlx6NJ2rtwdbv9CtueP+4NkK24RX2+UFukXQVnBEnlJUiFW8pkbS6Ki66O9FGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH0PR03MB6050.namprd03.prod.outlook.com (2603:10b6:610:bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 09:04:48 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 09:04:48 +0000
Message-ID: <b689b387-be16-4533-88c5-ac95c6652e62@altera.com>
Date: Thu, 2 Jul 2026 14:34:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-10-tanmay.kathpalia@altera.com>
 <20260629-woodpecker-of-luxurious-wind-cc4ed4@quoll>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260629-woodpecker-of-luxurious-wind-cc4ed4@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0184.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH0PR03MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 1125dff0-6765-4bdd-ee0a-08ded818f7b5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|55112099003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	cTFGDIxcrsh21wCxQf2jzErytt0D5hOCFDtkT9AwNY9po242NTpIX4VwGa9iIsCYvkh8JT6ODtUjtmJQpe3RCNjVpb6OzqG+QKTQwfYj/185YnJTu/seHhm54+8IsOkGuMLy1OGlKiAeetx8DvQW7lt8Jn8FMOWZEv23OoubyelC003tNbXaCND63YTBraG4vh83EP5rY4YkHmgUINGNRFskLGqkF6ev2kxA014kfML5PuqXn33gb+ybqdZcwxr4gVlDaIZdJgl3xtH6AS9LnE9AF/CXWBrEOjKME1FIOIxadBSzpV2ufAPzCJ0E5VFKNH5tbC3lnXdYcDVwrTv/X5p9Q1eai5U03CtaApSomJlAqQ3DCi3bILzfEBpwfZBLIcD/74aq19TObc9Q3YngHGXuD9oxC3Nss8VjD7D59ep1+85qgTI9QlOAYmjV5rP/swt2dQgb5MmGI7XfAvw7k44ZYqO5UnzF6KaqzGmP0mJlW6SgJnv6HkLwgJ86+s3NV9uyELyAUY+L05Bd51M71uCmvNSGZtVzg/y/MaUn2M7+SiXMKg7dvV4kBk3jfY8RGlElRZCeN/dmQqwpk9kySzSeyLKMq4GJqcB84j+umSUiFT2GmbC6SBbfDtw3YXDISE/PbluEXFjX9FEKBFPutJ/+Fy6Cvs6DbVMgR7c8p/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR03MB6208.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(55112099003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVpwTWxQNURXdzNMUzlWVGhwd0EwYWlkdWdJR0cvWm5sd241cStpekNFNTZI?=
 =?utf-8?B?aVF1UlJaYWVFL1BCeThTdE1BQ0JHbVkrZVRoQisyTG9HY3hTenhNQkZ3RStm?=
 =?utf-8?B?NU52WnUvcU5STWczZ3pOeGxzdnhtbEtFVTMwejB6WERsZTA1Q2lCZm1yVWY5?=
 =?utf-8?B?dWw2Y0JXSmFQcjNQMkRoSDVQSGF1QmhRMlpseURQV2lqNHN4R1N6c0lZNU5x?=
 =?utf-8?B?TVNQbnR3T3R0QzM1SHducHJjTHdjWjBpU3hvNURRQVNHYW5pbFhpZkhleWkz?=
 =?utf-8?B?WU9nWTB3cVlWSGNiVW5sMUpFcmtta1JXZ25RVE42QnhiRGRKK2dDNjFzdUpk?=
 =?utf-8?B?YUJKU1NlOW1wSTR5S2VvbndnUDFudi9UTWppSU1vamxidG9OQ2tJenlvc1JW?=
 =?utf-8?B?TURjWGl1bG1FdVhWV1U1TUVkZHZycEdIWDRWSm01Q2tTNzd6OTYzcUhPZXJN?=
 =?utf-8?B?ZldCK0MzdTVOckRKZU1ocmZ6T0hwRkRJSWF3V2VseE81QXV6Zy93bVg0WlR5?=
 =?utf-8?B?cy91VjkwcW12MFBUb2RNdGhabVBlUXNpMFN1R0RNSnZYZk9VT1NWQnRBdmxr?=
 =?utf-8?B?T3pBVmNsdG5SRkd2Y0Fpb2FSR2l2SzhRSVBrZlE1NmhWeGZCeDlKVkNVL3ps?=
 =?utf-8?B?Y1NRdE9uemJEdm9rdERzMFJTVTVhWGJwdC9KVFZGOXc0Mit4OHVFWEMxQVdj?=
 =?utf-8?B?bGVkYmV3RmVPdGNLM2xJOWZlL2hkcTJHdXAzd21ETk54c2hVUERmK0Z4QitP?=
 =?utf-8?B?bEFxRVBZbTJ4NmNzMk8rNTFnT2xMWmQ3YlpvSkloNFgxMWRlVUh3bm5ZNGNu?=
 =?utf-8?B?dTZ6R3pGYlVhZXkyZUVVSGFqWkZiK0hjeHltSys1WEJENnZzcTV1eGlJTDRs?=
 =?utf-8?B?YjFxVEN3U0RPcmZVeW0wWlQ4UnVhKzV0OHpxVzJMdWxqZThicWVQRUFwNjdl?=
 =?utf-8?B?b1JFOUNTdXQySWMvMG9TZys2bGl3ZmhtaGt4Wm4zUEdXV3hqWmFOdy9LaXFK?=
 =?utf-8?B?eWZocXBzU0RyalluZXBqblMycGxtYnRFVkZkLy9tTUt4ei9DcDJWOU1zRDBX?=
 =?utf-8?B?R24zYXdJRy9aZzh3WkpEYU1RUGtSeTVpUUlhV0lXU3k0NzR2YXpWOXZNVVVC?=
 =?utf-8?B?MGVXU0thMXRxb1E0YS9TR2dqM2VudnpaKzQ4N3lUTUJUcVgyaS9Zak1HMVBP?=
 =?utf-8?B?VWYxeWwwTll3bXh6S2F0YnVwNlp3dlNQVkgyYW1BWHZqY1p5ZHlLSEdJNCtT?=
 =?utf-8?B?TWhIbFRsWlZzaG9WUmpHUmhwN0hhZXBPVER1b2V4WTk1a3hXNVpqQWl2NnFJ?=
 =?utf-8?B?QWEvOGpGMThYUWNHdExHTWZzMFI0bGpRcXBoU1hBSmF1L1dXK0o4QnhDYndY?=
 =?utf-8?B?emFUeFQ0ck0yNk84L1pCczdSVWRVYUo4WFlkWlJVc2JVbWNSSG5Gd0RjRUh6?=
 =?utf-8?B?YXl0M3pqUWxPVytyM2FodkdqbFEvQjJrUXFjL1lkQnRVZ2J6RlgyWVRYY0NU?=
 =?utf-8?B?c01tYWpBWHVsZzg4OXhoU3FqVi83YlhoMkcxNERSK3RnN3ZQWDdRRm1HcW1v?=
 =?utf-8?B?a2NFaGZ6TXJ2ZVNTK1pJek1UbnN0UWNLcVkwdEdtOSsvTFc3NjRBcHAralJw?=
 =?utf-8?B?NE1Iek1yUDNlb2JhYmpWZXpvYnpyT05EQlBJMzVtcy9jYWJpOUg2NVRHUlpY?=
 =?utf-8?B?Mjh5SzdBcjhKaFNnNWpzVG9BK05UQllMNzZDZjZVdnE2ZmthemFmTmt3VjZx?=
 =?utf-8?B?dFpZS2ZMUTF1S2RUdnNqRmtzd29yUEpoam1FeitqVnJHa21EMnVvRDdZNTBE?=
 =?utf-8?B?WHFNYTJha0RHMTduYzNBMXhCMzdUb3FHQk5oRndYQkdyWVZFNDI1NUwzMDQy?=
 =?utf-8?B?ZTNaSGZ3UGlTMHFDMzZZRTZlVm83Q3ArMUtqY0c2cGVZWjVSMEhuZU0vdjRZ?=
 =?utf-8?B?ZmxidVVKUmJJa0hhTXgxbnpRQTdDZjk0emp6UTBjTm1neHRPOHU4cnRTczJB?=
 =?utf-8?B?VXN6NnlxTWtHU1lwVVZFVEV3UzVKVGlXeHlYbTA1UCswN0hrWFArVmhLZmdo?=
 =?utf-8?B?OU52R1JmSFdjL1huaDIvNUNoTjBJNnFZbVRmaGhIYmxHcmVsQ2E2UVJTTWRv?=
 =?utf-8?B?L1JIYzNwSmVTd0FKckNqZ0pWd1lOcHAwMzljaHl0Vi9rZTI3NW93RiswbnVJ?=
 =?utf-8?B?V1A2OS9UWlFZMUpZZDlGNHJVa0RGaHVkSEs4S0lqcWk1bjVoNlQ4Wkp2R3J5?=
 =?utf-8?B?SGhhcVN2bG5IcG80Z1VnYTJEbHJsdmlvMTVHZm94M1JOUHNhYVp5Q2pVdzZP?=
 =?utf-8?B?WHA0ems4RkFhU0ZvdUJXeWlkdVBIZ0tjUjY4bldLSHZaL2V5dlNnWkE1VWpw?=
 =?utf-8?Q?xz9+srqFHC+UEacs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1125dff0-6765-4bdd-ee0a-08ded818f7b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 09:04:48.3148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcOJBzyYKkUwughDd2jhSbDfHeRcnRmOf8L4vbjEGjcniJtCa5wXYHM/aGIzgN7eC0fUGhMm7GJP1YqYfAopnEGCkzOT2MxCAZGo9pUQ8lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6050

Hi Krzysztof,

Thanks for the review.

On 6/29/2026 12:38 PM, Krzysztof Kozlowski wrote:
> On Sat, Jun 27, 2026 at 01:14:54PM -0700, Tanmay Kathpalia wrote:
>> +	rst_combophy = devm_reset_control_get_shared_deasserted(dev, "combophy");
>> +	if (IS_ERR(rst_combophy))
>> +		return dev_err_probe(dev, PTR_ERR(rst_combophy),
>> +				     "failed to get combophy reset\n");
>> +
>> +	/*
>> +	 * Assert SDHCI core and SDMMC OCP/AXI bus resets together so their
>> +	 * active periods overlap before both clock domains are released.
>> +	 */
>> +	rst_sdhc = devm_reset_control_get_exclusive(dev, "sdhc-reset");
> Binding has no reset-names property (just open the binding!), thus you
> cannot use this.

In patch 2 of this series I had added the reset-names property to the
SD6HC binding. Based on your earlier feedback, I'll be splitting the
SD6HC support into a separate binding file in v3, and reset-names
will be defined there accordingly.

>
