Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905C1AA1F4;
	Mon, 24 Aug 2026 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557140; cv=fail; b=FwfQnco966lW/UXNRI4cM03kcRjuchiewlUJ+rd9jXrHnhT6QLhD2bEaSQhaAytpDxIEf7XNA1NTLdr+RVV91RVcZIrT7Om6OYG8uS+wLHu+FL7lOSjx8OPWwyb4W+BYsM+zSK39Ub2G3S3qHJfug8VjgZ5fXOZQ3+5chul5axM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557140; c=relaxed/simple;
	bh=3BWFqM3QbrqlTfXlWF9kx5BfFPwZtWJBcaAqNqNfY94=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ox0zfpuRQnOo9w0zhmJ1OhnauIyRJ/PSEBQ8SOPj/HPGybHZeSP63lMndY2BZOurhUx43co74PKX6NOnB1xsKyNph9dtBNWU/48UbrNR1aOH+v1CitOJl5X/c5amt8280DHt46zTu4Ni8p45GeFh6CsAzy7tDmi3gV3MuLBE+/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhigJbrU; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhigJbrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787557138; x=1819093138;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3BWFqM3QbrqlTfXlWF9kx5BfFPwZtWJBcaAqNqNfY94=;
  b=HhigJbrUUcqFXd0nTMgsNmuK9EEpzECpkBdQ9NgX6O/sH8bEuBxoruLz
   09TW6vvPuaugd48cwLKVsEh51LQUsfW31ZOvR5lcCuaZR9aKL69xCSsDd
   RAjyawzePHdwYc6GRDEuMO8dhUpj3AdInladqZLdNbmly8KqgLn08ZYQR
   Z+JD1NkpSpYhoX5+qfCBwYYkZ5HAy9yLT+ecMChLioCljWhGbDfEBkU3l
   hakCVf6/F2+0ZwJ3+JHMAhk5qSmFousJ9bbOOveyQttHRrQ5v5Ewqy+01
   jKIJqcV/zht+JaNOrTvqyKSK3vuoQule9XUxwEZmrb7wA/qBZ9TJ0tOEB
   Q==;
X-CSE-ConnectionGUID: 64RWNO5TR1uT/yKEjUnhLg==
X-CSE-MsgGUID: 2N0hmi4zRLGjQPztO+aYWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="86951782"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="86951782"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:37:47 -0700
X-CSE-ConnectionGUID: P1StbDWJTuSwu21q8R6Qog==
X-CSE-MsgGUID: 4sBRMfopSq2xxPg5+Jk2fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="305125777"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 00:37:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 00:37:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 00:37:35 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 00:35:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evj6PBUi+dGmRl6O+o+LHtqHFxqidPtbdh+jO/Z1HW01HoDkx/GaX1hNIe9m5C2lQI+A7LfL25iA0g1uKGrmijS1qLOvSxr6oyTskT1W5VVfgpP5HylbNmjE0I1cZsvfahdTBKBFXgVL4Nb5iyEcNCtMMWbsZkc9flz+Yu9S+x54/J2cp9pOrydAbHEI/r5ETSMXOsx+DmYzIASzW69MwQFrWB7jnXn0ZvuxJOhjYOdcwLCPzDA06DiBfoWqp77aiBtaQJqaDm7A7TwcZ20PRALOTtegYbTuXCHQpZHPX/ETaZlIytXmrU4aXJbhYHwjpH+Izes8Od5Ow0kuRuQ+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kC6ttUMYKftRMcmeMQ5dFo1O28Bz2JXxwB/tgzhjCg=;
 b=Z+f+6ejnBexsFdaJwo+SYY7CkP7QW1I3y02NtwWFXgahjpA93qo8rPJwL0GRIkJ9L05Ee2eLSKZ4Nxa4bAMgQuWPTRnF9sEWaspHH3c/eWVHHfrO/yT+BaWDUUZsDgG3HDJYBk3xR2DEzrEA6hm70ZAbEJysn6sK1yjLn+jZkHzGmuNCgL32j+Bt9NdqgTKjbVvQxOTUg6ZVsIRsZi4g9FZymm3YTfbrmcKRL6MEnBgiYQKlKPMYLNbHEa/cqvWpo3LAm0mzyB2oLoCLH789D9mMXGhe812Q4eebpnFCGFFhatVfoZ+m0LS1FpzJvc6q0+bqVS+oA9U+9p9YAbxqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB941921.namprd11.prod.outlook.com (2603:10b6:610:363::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 06:52:34 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 06:52:34 +0000
Message-ID: <190b73d8-08d2-4e31-8c06-1db91a385d3c@intel.com>
Date: Mon, 24 Aug 2026 09:52:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-of-arasan: Make sure clk_init_data is
 fully initialized
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson
	<ulfh@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Michal Simek
	<michal.simek@amd.com>
CC: <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>
References: <cover.1787240090.git.geert+renesas@glider.be>
 <0235d3a3d5b71a125eeff6d7be25ddaec80ce539.1787240090.git.geert+renesas@glider.be>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <0235d3a3d5b71a125eeff6d7be25ddaec80ce539.1787240090.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0190.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB941921:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd32086-cc28-4528-f61c-08df01ac46e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: plgN3peQSxnghI/fwxYmdI8SiVylBO6cjTywwBCdtgLsDj2SG0LTiNlALLN4BAbCkQV3njTujOAnc0Po37mln9rhCzhArq84Fbj2JKR3UW79ANygQZi0Q/QTVX/5Hb4xGc8Hh7FkDCdqGlj/pX760T9LTIWE1k+ZI+dZ4nr4YFMWF6H9u3wdsxsbWAuMSIAe9uuZfqpb9qCLJM6jCZFMiJBOXql73hVfIt3FY+06MLSTPEM9Q9NzPH6PptWdXQP53pPen1/C87mj9BTiWVdx4E1GuuApgRPYcJhFJpLya/1ndK4ryAIbAcSdgdcDrdqAOAW7idPQznLUvTj1qdsTYs6tHhXrALF+NcdsxpDF3nes9lb33JpLEuVAI24T95VPiGMTHE30KCxwQbhGr7Mzyv1VgPlIS5Z1x8GF0sdaIF/66K3oWmjc1LWOOS0CJ7gL6/htE6QWZ48QQLfp8P5El5A5mRjHvhAYahsy+TAwrJ7xqMUC9t1DuS2hKNzHIeXVJTMQ+Hb4ExEJc6rsbghUrD9x9RguxSXDH7ClGJ1xHyIxfoM6Ps4GHsJeWNbUI4M1l4aqgk2fCSF2BYcRw3s9K7Td/6HgBvkNGxcQlsMB4w2lg9dgYMcQwDOlJEwBPkCVIxYW3/iFrGDQPQJb1V2Hy8Eazmrl+ey3PRKqPnYag84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnRvdEIrWTM1MWRmdWhCZ3dWdmp1TitwcHdOZWdWTlJKOWZFUFE3dytETlZy?=
 =?utf-8?B?RDk3OG1XNXdnY2RkV21TTnFweGI4TXJucTRkZ3ArWDFBNXlUTXNkcEs3QmFx?=
 =?utf-8?B?Qk43STFtaWxvTS9lYVd1eHh2Z3FPeUVSYldKUEF5aHdwTHpCR2FCU2ZNS1Iv?=
 =?utf-8?B?TzAxRmtuMEdiaHNlZllIVWZtaXNWUnFTcHYrQkk1dCtpYmtnVkF0SWFTOGVS?=
 =?utf-8?B?bVM5Zmd2dm9zYnJQOHVpbDdTUENjdHcwaGc0d2hQVnBVWmpzbC84TkFXMlRu?=
 =?utf-8?B?d3pVT3ZLR2ZWYWhsR2laU013UlZBWlRuOUhxcERFclN6OVFaaHBBNUxGVHZN?=
 =?utf-8?B?UmxkRWdPdTNzbkJLcHh5MHA0RURFTEpLOEw5c1hyMVM3S1BjbU1DUktIMGFP?=
 =?utf-8?B?YU9pcGdXeHlNTVZEc3hSM1o2K210bEFtcnliR1RoSk40d3lWNVc2RXRWaFM3?=
 =?utf-8?B?S2pzdzBHL3NjZW9mM2owdTFTUjdSVEl4azRTRlNVRWFkVHVwUzFPVTQ4emxM?=
 =?utf-8?B?RnZRYTZpVW9QcFNjb256RUVCSituWFBhbFJIb3lQVEN1RW5MdjQyTU9MUHdh?=
 =?utf-8?B?TEF6Z2tLSVZHVGhXSmI1azNIMWd2SDVTMXpOUFVYRFVnRHIxQU9CSVZ6VjRm?=
 =?utf-8?B?OVJWa0JrMXhYekRTb0lZUitIOEMrMDJUR2FicGNseExLdUVwbkhLWi9JendW?=
 =?utf-8?B?RmtLbnFyd1g2SGhEMkZFN2VVSG1NblNraVYxSUMrRWNKNGZKTnJkYVhjUkZq?=
 =?utf-8?B?Wkg2QWE5ajFIeGY1MVJET0dFamt0eFU5cDR4ZWwwV01sUERJTUljeUU1SDVv?=
 =?utf-8?B?Vy9JL05ITE5GNTZVWWpNbzVEUDRHTlBwNVBvRG42eGE1NmlxNnpOTlVHOERr?=
 =?utf-8?B?Q1RlZ0dwbS9sKzFrbFMzb1lScFMrMnBJdFBCalRPTzFiMFlndFJEV1N4WHhn?=
 =?utf-8?B?RzFJdjdsSUxkQmV1Z2hYR3B1akp6RG9MTHJHb3V6cmhnNk5ISzFKSWdRN1la?=
 =?utf-8?B?ZjhNZXlnN1MyaFFlVUtnUlFza1ZPMi9sZFhMbnlXeEZZZzQrbTlJdmh1aC9C?=
 =?utf-8?B?UEpteXE2T3JqbXdHTTdqaXlZdnNRSGVNREswTk5SK0kyVkZSR2M2THVkMDFC?=
 =?utf-8?B?ZGlDeXk1cDBjUmZwOGI1Z0JTZ3BXSXRPZ0NiOUJyMFE1YWk2RUdyWnh6SWdn?=
 =?utf-8?B?N0hLam1RRVRFekJzb2FqMmNNWkRwU2pYN29uTWJkT0FmU0FvdjZYTVJ5eUhy?=
 =?utf-8?B?Wmp2bmRMR0xaYUNzb3MxWnNiai9pOXBFSGpzVkhna3FPSUt2WmxLV2p5NHRk?=
 =?utf-8?B?c2hxcklxd2NEYlpZY0NTNnNxa05OcXFyOHVucUNEZDN0TnR5SVlnOHcyQzFx?=
 =?utf-8?B?eWJyT1duYlc1c0dQbTlzQ1JIN2NUZVpHcjNCbWNvSGlkVTNBZ09JZ216NkxQ?=
 =?utf-8?B?dUp6enVKenNqR2NkTlM2Rzl4YUMxZUxjREtpdnlMSjlnZnVtNGZMalJGZlRw?=
 =?utf-8?B?MjdMM3UrZEFaNDVaeVpFb243cituY3h6aHdOaXAyRnNWaDNWSDl0U1F5NmRq?=
 =?utf-8?B?UWVGTytNMzUyR1piU05yZGxyYW9VWUJtRld3bEFDVnIvejVwYTNmR1JRMHk2?=
 =?utf-8?B?TDhBUUJLaEorWWpQQUU1VGx2bmduSlVkS2lIbkhXQkt3VlQ4OENhcWVFZGw3?=
 =?utf-8?B?cENyeGw0cU5nSjhHOHNodTNjbFNlNjJqclpHRnN1TW1QbnJvVHlXV1Q0V1li?=
 =?utf-8?B?WkZaNzE0SFAxZ3J5WlJRYkpXWGloY2RjeE0ySWRtM1B1NHpaTFVNS21PRmlX?=
 =?utf-8?B?enYzbVNMMEEwQS9LUmw1S3lqVmtaOXg4a1pVWk9oZUFNOHprRWNGcG52eC8y?=
 =?utf-8?B?elZoRE5PazFjN2huanU5Y2JYK1JPWlo2d2FxaWVYRTZsQnRmU0FGQmdQLzBW?=
 =?utf-8?B?SUt1SFBaTG5pTVRtVHJzMkxPUFlzeWdQbnpBOGhkakhmaEV2WGdwYXJ3RVFs?=
 =?utf-8?B?SGdDc1k5TkswZm9WV2ppKzZuV1pScStBeUh3MnVaVTJnTHRNeXplQmxXalZJ?=
 =?utf-8?B?WVJpU1JHQ2dyUkt4K1djWW5HNFZkRVpmZ3M4WmZ0RUxRckkrZUJHaVIvenlD?=
 =?utf-8?B?M204bWZ3Q21FdUVxck5JbERHUnNIZHI3ZkpPNHZreXhLNjMzYzFGY2ZWQmdj?=
 =?utf-8?B?bFo0NFBBTTJSZFE2TVBzTXVscUhYRmtIL0FyS3NNZXk2ZExYWFlUK1lvNjE2?=
 =?utf-8?B?ajBwV1UwWFJ1YWg5UXBOZEh5TDdURjJzWVZrRTRHekRVbTJMUGs4a0c5aXYx?=
 =?utf-8?B?aHc2L2k3YmxIeHpvdTBpSWJxSTh2VEo4dk5ZN0lwWWhUUjFnZEpUWUNGR0RG?=
 =?utf-8?Q?GnDNtuTHpUPpb8Ss=3D?=
X-Exchange-RoutingPolicyChecked: j+iUJH7jb/f4eQkGcZspTLh8se+tYC+vsT1mynGBi73dyhNIrV2N17oja4+wGRCRBQZpzQmEjHJdErHPMSPu6e1YYGrdd8TPoZ6mqkxdJaBh4H9SiLWFuCkR2LNq6h5yxeH2ORjIWsedyM+g7yzduxa8YE/51OCeMj4J6rO6Bm/t11GGY/NBMu/ms6Fr82Ig43dXlgoILykQjhm4p6MM0n3n2ar/ZGr0BxN4cuD9EEWPlvvJ2liaj+Mb4IV7P+aeCHMiZCX23TQBV9gO5VRplElH5ktw6ZiFrE8F7wTIabOOlf75R4TuILO+xJaSCjN4PRY76fSEZlYYxqt/Zz0TxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd32086-cc28-4528-f61c-08df01ac46e4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 06:52:34.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8U639E7pvp6sRuDWJOXzPCglhwfM4Ma2YwJqfNIJW3rwsiKBwwtegs2zZaMfILcGFV0YN+rA2Gl9akZeugwTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB941921
X-OriginatorOrg: intel.com

On 21/08/2026 13:06, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Compile-tested only.
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 4ca73e7d799ead0d..0ee22923ad568124 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1552,8 +1552,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
>  				struct device *dev)
>  {
>  	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
> +	struct clk_init_data sdcardclk_init = {};
>  	struct device_node *np = dev->of_node;
> -	struct clk_init_data sdcardclk_init;
>  	const char *parent_clk_name;
>  	int ret;
>  
> @@ -1604,8 +1604,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
>  				struct device *dev)
>  {
>  	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
> +	struct clk_init_data sampleclk_init = {};
>  	struct device_node *np = dev->of_node;
> -	struct clk_init_data sampleclk_init;
>  	const char *parent_clk_name;
>  	int ret;
>  

