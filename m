Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795503047;
	b=bGexCkXqgvxQjxf5hGWnwR9XUGcCoXqjRKmpAVIGtuLpIalDOg1n/uXRIpbENWpZuToZ
	 /xHODU0pb/2Sc3fwt+uhjSlvVvsTXyRWdhZnHrJeBN0pU3Q4LqSINwmirz1qw8V7ZZVVH
	 5LTu8lbJIbgrXIXgoKuQ1j8DUY4hw9NxktNnNWCQghm3UTPEkq7eP79G6sQiBq88kV0Jz
	 XvG2aMBdQlw0xyXDVeAbE8bjMsqwaR2NYT8QmLoIzxd4kUG686TIClT4sGpVuhbqKZHfJ
	 NykVJU2rla1TpVtUBu3UqTf5gRc6MVXW5U9ygNi049qGR2/MH7sdWVtJfQi7WdYJKTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503047;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=vOGg4suQogK8il16+glFCIN6vlHkLpnQ3FcchCS1+9A=;
	b=Br4r6kuHlUnyb2fDp/Nzr4vDqtGINt3KlQsODeJdqnhlOImaL+ODMLhnlgUOJtqcMnkx
	 S2rW/TRyGi/aBpdW+ENta3Hk8Yp9BH9LHL4Q181uEBMNgCGQ33zQa8emXGTt98+Ufy7wV
	 jh5lHQcceQaxgMf+tiA9EXCB0r/Ep7hSKEfv23n68fkrRwdSSngXTD0OEWJynhL473wMF
	 iZWSzLdLqm4KVrpFTJIxT5Fp3tK6D54BsMwcb70UdYGyauV0B+vgVTOqzQy7/P1q6zhY5
	 3PGPjZM99n75mG9PoiKuD4Gygu97ofvRwbY/pD24UclCG+vllL6f2vTyqpgL+X3QUpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gjAe8P3t;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DVDUBg0t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8556606A31E;
	Tue, 24 Nov 2026 06:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8556606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gjAe8P3t;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DVDUBg0t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795503047; x=1827039047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NK41XF5R3OUOfkDD2kS8ohGsqHko8ep/SBNKKVLYVUI=;
  b=gjAe8P3tixe+7MxR9cJCxCTBjaAdDH7om8Yx/fmn5y7P3I59MgyjWigK
   9+/xKxhF4j7De8g+3Hr1f1wMHWE7E0v52j1UIO2EO9caBgBJw3S5hUq7A
   nVb3IRGJgXY2Tsm9YHTNJN3RM9cYpR7CQxPnVOc8Jze1kGklwF5L0ixen
   wl5ZEQHzx9fQXZMYGJ8LJiMB1jrctJKWHv3WnsoktGiLsBjC+c1K+kkGe
   17UEFuNcnLYlIjIt6wBo1bKTKQCofS0anHQS3OJWBlhrCLoz1JQ/oGVwe
   qz1Xi6YQjf3dctzM+7++VeA1Lso2cXudzXJFtdE5pDxuXsxD2kLLFRS+6
   g==;
X-CSE-ConnectionGUID: +oPQ82m0TOKF0DDJ9DfYRw==
X-CSE-MsgGUID: Z6or3HLIQ1WcDYzlsiujiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4219874"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4219874"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:41:42 -0800
X-CSE-ConnectionGUID: u9oa9dk/Q/aNlLgYXV/VVQ==
X-CSE-MsgGUID: 1lHOJ7GBROep9qYXSHf3NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13279232"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 22:32:36 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 22:32:35 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 22:32:35 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 22:32:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPKeCrLvp7DCIdOgJyM+wUSH1flMnS311BqRo3FDo/F0FqrHCaSihuhuHXs5ySEs2xKvawvunsQxCy9ONqAd9bY5UJQiqBx8dPHwtRiXP0aWzwFDLJAfI8ymGeanwDCLCd+hUSAM7LPVeN/WQgfvJ2SuN3ko4IDkmmt1bU7p2BrWz1AA7vv5ylUDARSwPfV4FKVRHbG0LO8FDRsZ09pnjbUWoHzE3kuT0hygaQymAyt6k64zILRFGDko58YbaMlsDraTFz9TUfljyd/SK3PUrEBZ5Pt8peZtolU5Z2iNv3Qo9ijyHxKtBpmTWWgF/6Ka+sFjlzWA9Qc+BFSPhbi2+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOGg4suQogK8il16+glFCIN6vlHkLpnQ3FcchCS1+9A=;
 b=qwFyAecz0neXt14KpXtjPnGK8x7utxaTKHrFFRcANvKWPMOaXPfZVR/QD5Uf3lUtwwHUukNRAxcT5Mse2LkK/vlPLBRwFvY3fxQcHzCmFSzODz8i5VuHJjOUZo4QQ3FJL5YMMMYDr78lLfZtSjE9zdLrvHT7VXiiK4LtLMw14u2O09R6N59lhzJUMxAYodfA2XvvjEEVwWAzhwV8j85r2nvsTvrhjZchKwk8onipQ0PEvveD64hmuiMUNh6zturmuXu6x0yx+RD1ismdZUGq4m97oW8lo5khuP6RaJssnOvFkIWpzIKNa5GAeilzaaVij3zGhQLXGQcYyCANObHcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOGg4suQogK8il16+glFCIN6vlHkLpnQ3FcchCS1+9A=;
 b=DVDUBg0t8ZPpLOfNN41gAdvKR9DODAQWMVrSzpwYCi8nwOnH5UraTYP208pSaue2eguOk8p4vrB+epQkFP/kZWXJmikFvcfzHImA+ei41Yzg9U+6UJvu94ICwaww7TKl2xqNoSOhU2JPF5RsA6n7kHx/pWBN7bLRTHhlNAexl5c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 06:16:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 06:16:24 +0000
Message-ID: <1f6cefa9-497c-4803-a027-81e84f6a6e9f@intel.com>
Date: Tue, 24 Nov 2026 08:16:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-acpi: Fix free_irq() of a never requested IRQ
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>, Ulf Hansson
	<ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261110070032.1387-1-laixiangwu@cmss.chinamobile.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <20261110070032.1387-1-laixiangwu@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 32539cc2-9149-4e93-a1fe-08df49f276ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|18002099003|261009223027099003|22082099003|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info: P+f0x1r7HtzOKCSiqBkeJu87MmhkVXddTctDr08DjNkOQhqqFZEEzy4khdrwPKlUoynZfO+rK4NXw85Nv2eqMLdtXbxnGFMh+qCatYADlB1ylKhsKrLgAjMSu6o9l8Hn2IKsGNQYCi8dBD97/fLCMSMSjjSQTtg7hA3vhMX63gb39Hq9t4Jalb+b6OAHSOFAMwkdZLDI71EAU9sN/k1UMo7oppMpBSnfT31T0L7Pgc4FySCCYIA2/BvgHtEYaKhd3HIA7PGUS7egK23Il1xeUKylAIi5HiPgo3ZBdr4O/Ohf9K6UnZX7h7/ZjxosiLNkbgA0gMD/ALIeyFflLq4Gy8shmHeg08nyDbg/x31uJvErv1SjiYAM+mF1oD2mQ2L70ymmaE5as4ZMJbXVp7d5Sit5yjSes4+5TePHUQ1s36zoGkvdbvXMiXP22/XT8EdXQO/03sbz78YplOBrJgAlzrSYAJi6WimPsdvn66dVrdf9M8ahnDEGy1dUFTUzWY54gL1d5uFMwP2uDjjQ5Sc2WlW3l2C+wZrN/zPpvY2koKYYv9zTzvwfug68IdjTdOBDjQxFy96diPqSbVG/qtl8l+gYtWUe8L5+IWMnl5rC16YAZaHY/izllq1DqUpU6ixsLcVSBUZsk8v0fubtlVKjPmF2mocaDuFAIIwkaDNa+BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(18002099003)(261009223027099003)(22082099003)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHUwWm40MzVFSFNqUXNwbTEvTFRXMDlQYTM5elVsM21hcGo0UWFSbEhFdzll?=
 =?utf-8?B?dTdzNHB5K0VGLzFMZ2JXRk9MNHp5c29VbllPKzh0NHJzbnhqTFlqdThDMXJl?=
 =?utf-8?B?VGUrT0VoRy8yUzRPRjdFTlZOY3NaSFZGWSs1NTNLZ0FzbjdUcWxteU9iVWc0?=
 =?utf-8?B?cncyWmFDUEhhbjkzTnhkSUE0bzFKRW5VVGJhK0QyMjljVUZrOUdaUGswaEZB?=
 =?utf-8?B?cDJPOHVDNHFabDJrbUpPdHVwb25FNUZRQy9raExLSUtVSGhVNTFBQ1JjUzVU?=
 =?utf-8?B?UmhicW13T21nT2FmT0NoLzFVYWtvNmlpb3NDVWt4anNvMzZtVGtTc081M3FW?=
 =?utf-8?B?d1JpbmJuR05TbGVkZENMTVdxMnM4K29sekp6bGVNek9jN0hZSHlva2dvQ1Nu?=
 =?utf-8?B?d1V4bXBFdC9Vc2QzRUpqei9DUlBQdnZPTVJoWVZBUjNjdkUzZS81eG0rbzh3?=
 =?utf-8?B?VEVJcGs0UitmeWZXZ2FwUmpHNDEyYmtFS05BMThKSTM3ZmhaU0RJUWNHd05K?=
 =?utf-8?B?ejdIdC9POVRzSWw4NUdDa1hOaTdBczRrUTZWdTB1cWJxTVhWbkJZYlJUL1l2?=
 =?utf-8?B?enpkS3ptV2NnWXBjYUMxdnNmem1iMUxjZys1YThwS1FRa1VFSk12K1gxSDRP?=
 =?utf-8?B?NEpjSWEyQlcvamFwajJISmt1RlZEU3Ayd3VtcHlTSGlmUlZRTGgxZzVKTzND?=
 =?utf-8?B?V0ZQa1dhNnhOTktsR2FxZ1l5YUJpcWN1N1cyMXRpTE5ObDI3VmZsei9kZ1hF?=
 =?utf-8?B?K0taYnVtaSsyZ3JZL3gyVnRacExtcXJ1dk1aaE0yTFFYZUZBb0x5d2UyVmxi?=
 =?utf-8?B?NFRqa0Z5VTl1dzRlU2hkL24xa2czOUtuMGVFNkVKODBqbEE3K0VQUEMzeTNy?=
 =?utf-8?B?K1JxQ2wyQ0dEc3NwSHZrblV2dkc5VmV5MTNEQUMzTnZGVHhWOTUvYW5HMlh2?=
 =?utf-8?B?VWlVQzh2QkJZUVZwbEl3QXRZTFZGVjYzRXRPeEdQS3hOVlc3UWJpdGx6NmdC?=
 =?utf-8?B?UjIzd0p0bHhSLzNUMEl2SVAzNDNPTVY5dU55dVFCRE81bzFHcTd5RS9wY25C?=
 =?utf-8?B?WXpJZ1lIMlozU0Z1UVdtaTA5ajVZR2RSdGdxN2xuU2NWOENYd1JqRjJKY0Ju?=
 =?utf-8?B?NVNTOE8wUUM2ZVYxSE91UmxYVk5NK2trbXdQSkhUUTFKT2xJZERFVExDME52?=
 =?utf-8?B?T3NjQjJYRmFvQUtNVzRSV28wUVYxVytKeVc2RTdudDZodVh5bUpKUzhqejRs?=
 =?utf-8?B?YVNXZkI1NFhCcCtwaUd3NEtJcFozZkNDQ1hKRzBlOCtUcGRIZWZHTjFBVFpo?=
 =?utf-8?B?cXpNSGc3eW1qSVY1OHduMnRGZ21HcXVrc2pJQ0UrUHJiYXBLK0lHdWtVNThP?=
 =?utf-8?B?RVlMbkt2SGR4Q0MvSWF3UzF2SWplYnlQYzEzdXp0ejNpbmVJUEc2QVdhSGhO?=
 =?utf-8?B?Y1FZMnRCdjhpcUZhK1ArdW1US0FjZmpTMndhbnJFU0k2QnNFZ2lkZTFFTGh5?=
 =?utf-8?B?YWlwbkUxMEFoSlpmM1dnWnROdVVqbkh4dkg2dlJlUDBSSEpyODI1MTg3MWZT?=
 =?utf-8?B?WWFTck5GSzRxeS9zNnFhRWxVYkwyUjhUN2dwNHptbFpmcmw4ckFoZmhlQWlW?=
 =?utf-8?B?ZFJ5ZFhtcnE3QnFIcy8xTmdVQUFRb2VxdXRpYVBmUnBicUIxNWJvNTAvaUNy?=
 =?utf-8?B?MTV1dG1QYXRteUxPTThKeVV2Y1hpWHRyWSt1YzcxUGZpWFZKakJ4c3p5ZzI2?=
 =?utf-8?B?eUVUcXNEdVNSbjBNRE1GcU9tdEg0YmZjTU80WGhiWVU5c1crRDNEWTl0WFlY?=
 =?utf-8?B?bW4vM1ZnTTl0Q2l3RXMwd1BQejBpS2lYOCtRaHdzNUhvRTk1U0xqeklwU1RR?=
 =?utf-8?B?RVRCVFdxMFRzRlVlYVhuZTVQUWR4dE9hUTcyNXRzck1vMXJMT1RmK1FLYVcr?=
 =?utf-8?B?WDB6bjNmdjdDWTJuYzU1eGhtQTF6b2tjaUlLTTYrMFdMV1V5T21uTk0yRy9D?=
 =?utf-8?B?SDZJcmtqaDdDNUthWHJyUWJOYnNBK0NvZnlVb0xkUC80blJpcmtUdmwxZjhh?=
 =?utf-8?B?TnQxa2J6MUpad3o0U3dOMmNJU2QvekZMSnlMMVJxaThDNGhGRElucDVuTUg2?=
 =?utf-8?B?YS9SbGhpQlY0R2RWbjg3UWxIdTJ3U01KY3FnZTN3eW9PampmMFFsY0JJUXBH?=
 =?utf-8?B?amxJZXJRSFRZUiszblRyWTl5TFdiSkZ0MXpkUDVFTWZ1bHFHZTdKSThmY241?=
 =?utf-8?B?OU93MkRVOXJ1YmhRdzVXdytneDlHTnYzcGs5Rk5HL2NoaTFaeWRHcW1aQ3N6?=
 =?utf-8?B?aVgrNjFwaTB3SWNDNnRrNitDTHFWMXFKS3V4bUhOMTBwU1R2N01EWkg3NldN?=
 =?utf-8?Q?iIjg8VbkjNb7pUis=3D?=
X-Exchange-RoutingPolicyChecked: EEAoO0gTaDS6cThXhGMfGZ17NmTUlWfTeIZO3Qfappfa6VPIhdo3xDueefolWyJ1ntfMcDCQjVdsZwFYNF5wqfPE3vfGXRJEHSUHtxfEJk6681xG3QXB5iPmhhRCmSmQxjwqzzb53V/BKZhf2AGEowjKl1+EPr9lco0WrhoA2yt6FeI6hzXy0csW5Zp5tjc3YeqkbB3Ip2xpbkZV5g1qyi5mUtCycplx0Q4nsNQN9Kk8/73BmzSzC13YzANi3OBt40PdUV8UaETLin8646XFZLW5Y6N/t+NDI853fbKleAtqrxPyEK0vPNP9eRFnGdgd9R7YOsGSzrVrZadmn985Qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 32539cc2-9149-4e93-a1fe-08df49f276ed
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 06:16:23.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDZDNxXrI37dK5ckWipu3StC/iDBRCt0RKM4muQtqqOzPmwCJ0posHhHYbtyZa3eWkFA/wjgcLsNBjQeQMmhLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8313
X-OriginatorOrg: intel.com

On 10/11/2026 09:00, Xiangwu Lai wrote:
> qcom_probe_slot() stores the IRQ number from platform_get_irq() in
> *irq and requests it afterwards.  When request_threaded_irq() fails,
> sdhci_acpi_probe() already jumps to the error path that calls
> qcom_free_slot(), but *irq still holds the positive IRQ number, so
> the (*irq < 0) guard in qcom_free_slot() does not catch it and
> free_irq() is called for an IRQ that was never requested, resulting
> in a "Trying to free already-free IRQ" warning.
> 
> Reset *irq to the -EINVAL sentinel when the request fails, so
> qcom_free_slot() skips the free_irq() as intended.
> 
> Fixes: 96ccb858093d ("sdhci: acpi: add qcom sdhci host reset quirk fix")
> Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>

WARNING: From:/Signed-off-by: email name mismatch: 'From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>' != 'Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>'

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 84c705460..85705d2eb 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -412,6 +412,7 @@ static int qcom_probe_slot(struct platform_device *pdev, struct acpi_device *ade
>  	struct sdhci_acpi_host *c = platform_get_drvdata(pdev);
>  	struct sdhci_host *host = c->host;
>  	int *irq = sdhci_acpi_priv(c);
> +	int ret;
>  
>  	*irq = -EINVAL;
>  
> @@ -422,9 +423,13 @@ static int qcom_probe_slot(struct platform_device *pdev, struct acpi_device *ade
>  	if (*irq < 0)
>  		return 0;
>  
> -	return request_threaded_irq(*irq, NULL, sdhci_acpi_qcom_handler,
> +	ret = request_threaded_irq(*irq, NULL, sdhci_acpi_qcom_handler,
>  				    IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
>  				    "sdhci_qcom", host);
> +	if (ret)
> +		*irq = -EINVAL;
> +
> +	return ret;
>  }
>  
>  static int qcom_free_slot(struct platform_device *pdev)
> 
> 

