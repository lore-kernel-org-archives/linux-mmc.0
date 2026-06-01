Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BE32B10A
	for <linux-mmc@vger.kernel.org>; Mon,  1 Jun 2026 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299817; cv=fail; b=KjGh4DZhisldJUs6+GHICBnQPPwIWnFEgfSonVaxIvDQpyZxnNHy8U6fHwFzDKDLgI54RXMbOT9Vf7CsixYvxAknrBvKn0Lvvxx/kIlDCnOWXjkUstasueceecZz4S+QittXwc97I79A+lbBK49XA7TaxCQdJxpZBfQ9WRbQIPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299817; c=relaxed/simple;
	bh=uiUa8oJRv8f5e+PY+oCJ4j6guNe36QEmahkcDIY9Fp0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtiuayjEAuzEx5aLYCJGvZv9V9VjHGdDCe2hjtf2715+cx2ziF28oP3xbaZTUiJub0oopLF8B3wNJ10XEXRQ/uBwddG3xrDRaGrpgZamKrTK2gewGioUOuDLWVofsJdMmw+pW2IseWTHIGmRZkThIrvSQmPxqQ2PyLExFAvxh7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFsFARhp; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFsFARhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780299815; x=1811835815;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uiUa8oJRv8f5e+PY+oCJ4j6guNe36QEmahkcDIY9Fp0=;
  b=DFsFARhpACqcE8LbW3xmgWxaeiVFiCrk2Z1LwYsNGrOkgp+8Z/SnOfw1
   QDboQjERf9xQCnMuvavjKlEUM2OJy6k5o5/cUBBnRSIqkUllHll9ww9th
   RzfBhstinTGO5u+kK7xnsMtgUecuucKHszyCPURFttyGxwlh/ygDyPdmq
   uIrK5ujqZ4MCdhKU0a64HkY/iFnFSEuSuRnawARUYYG91jymkJMv3z2l5
   3g1JCTt5/PKUccqmhiv7f7e0SIaX5uKNqlXujiNZdcoRYGNNc/N6NLcPI
   bKfDt1Bk27xgkbO71DwDfnYzqOHjX4ZCe9suW8l1DAV2/1HvbJ74+ThSC
   A==;
X-CSE-ConnectionGUID: yc5O3RxGR9WPcFgu4ITD+Q==
X-CSE-MsgGUID: Ic8WiJm4SICJce+9XSIV1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="81023379"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="81023379"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:43:35 -0700
X-CSE-ConnectionGUID: nHXs/u2HSqmcjUgG1bSXDg==
X-CSE-MsgGUID: k3VsL0fiTKy5sgmMuT3FNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="242443449"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 00:43:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 00:43:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 1 Jun 2026 00:43:33 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 1 Jun 2026 00:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iwWajvzjvqTvkl2oY07kxj3DMSSUmllh758PxB8ngfRgYwFJo+6/mk7dUDIM57eUGq2xgtSHBhZeX9++2a76Q2dV4tAQ4N8unWhbRTL6EeTtAM4jRcK5IYiNSWl5YUuanAvUQ/NIJOy03HcW5/sJ4J5ZwvgxkOHKBWVZIss3CNKh/lIW+cVyLswBNx9oVWN666GYpA6AHetvurfrhrVeJifx/NKkFY3MOLXSFdDMmo41mnH+aWJo6hgvueeULiyCO6T0QrmEBr5r/9Ac8Y8qAdEgL5LJIJUxBmU/Wv8dCsdLMoWYh0/sIN01LypoJZsMlsWjaLGJG8dmCKtTfDx7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h80FdC+xablrOREiij2zHiJu1usIa3LUhnHSgt3wYFM=;
 b=GIkMsOvm01lHSzqnMsG+vyed1dboxcL0QAwgW+y1ueUSFjRjHyRPx2+R22y4IeIczgRfKQ+qYU6hgcQP7i8qcb24cDXCP0zziiNrpyfLDKmnmavHp7FvpIBn6inVRivTb95XE7ylYYWeqjjCXfYod1RgJlG5QiDC5qHXJHiGUIpqvxaRU7RYe1vOMJ4BCXRgZ9JE03xGaYMD+KtFN/J7oMohiEdAZo9c0CPayNDaGCFF7T7wkog7n4Hu9TCdrAQGyUSIKHCgVPDi+2cI8+M2AehDDscIBAgWNtJ/Pn2RhH0HQ5e/YBF1BU6B5jSUinhhIXg2t7F0ppOjw6l0qlqQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA4PR11MB9154.namprd11.prod.outlook.com (2603:10b6:208:55e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 07:43:25 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 07:43:25 +0000
Message-ID: <a3068d05-4568-4a06-b51c-b4bd7dc2db4c@intel.com>
Date: Mon, 1 Jun 2026 10:43:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: check bus clock enable result
 in the, probe() method
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>
CC: Jisheng Zhang <jszhang@kernel.org>
References: <b5dea73a-3c79-4beb-96cb-55d619a1f538@auroraos.dev>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <b5dea73a-3c79-4beb-96cb-55d619a1f538@auroraos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR06CA0007.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA4PR11MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c389870-b3e1-4bae-fefb-08debfb17696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: p5fcFJA5BOVyc+4p5vdDKtRDCCOPq7JQtCHFu3sGSHx8zWBQqHUJfLud1qcJW28MpBjp4e3X2cUifWfxnb45Q62Hr8p+wUCiAi2xUk11iqomE7tpSuIILiSdC0avSD04Z38m5k12rHF2mFZLliidpjzA+3/UDeXCX4AAcox0z2Hkr8pbtoinaNMK6uUCOeT2h1FEB16O4BO5cGW/sL+anW8UirSdlH5O+iIkRFVt5P4EddzKGqisOVcOVbkV5Rq5mmMBcJfUhn9BLMBp0uvqk3F6xFtJb9uaOwr9TExlI6Qu0aM95MKM1OT0nYd8LT2oEbo/AT+WDeByECCAg6MkHIbtTB7iqsP2wAwzxsF4TxTGlRJNosNfHASEe4DnmHDLUrTWxkgw6F0MPpam8H8cWVYr/iO9NtCDVGJhyl1ig593X4mw2b4Yy4rjK1CrsE0tNpNkIF+qozUxScrpcst38OTIhtE0HFaUF+vHlqBoDmKIzRPk+hly7dyIS2yHZsIxXdpg+yEETlXMEqM8nm6XwM4feG9vyXZqudPGPWBdsV5alGD+3qMy7uRvHjOaeJfXt55wLjUQz2MoFY2RMejw1QdIySayX912i45jSuYJNmAdQzQ8c6krJRC0UUZ8yXZwE2QAR0Cr1ZvyOAvArxszpcpILJQc17W/0uZXQMYO7A0jmTcdYnr973+grUA8CFlR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkpQWkNwUTFsUFBXb1pCZElYVkFqSW5sdEEwMEh5aDF3U1MzRHRsa0w4NEw5?=
 =?utf-8?B?L2VMMTVidWsxMFVDWGJiYjBkdUJROFBzNnZZOGo1ZVVKSk5SNW9EYjYzMEoz?=
 =?utf-8?B?c09DR1RTVWxvU1puSGVHTjNwNFJTWVhidlcycit4b3FiUXlBU2puVDV5dkV2?=
 =?utf-8?B?QmdnMnZ4MlFmSDErRW1yK29haFp2WlNOb3lUTHZJaFFPR1gvTUNkT0tjRndG?=
 =?utf-8?B?b2JHSGlDaitySkhZdzNnalJTU084OFlQWFBpZmUrRmtRTUVoQnVEakJjMklx?=
 =?utf-8?B?TzFiMWc2bnZzVm53bVI5elZ5M2pkWkpRemkwQkhJV2RCazBiQUVlWUVnVFpm?=
 =?utf-8?B?RUhld1FIVm9yc2JsZFF3MWkzcjVlaXNZTk1iSXkwTzdIekRuVGFzai9BcEpT?=
 =?utf-8?B?cTdZZlBacHV4R1JqOWhLT1U2aTRUN0VsRGNOa0dVZ3RmeFN5QVZCUEV5VXhL?=
 =?utf-8?B?TlhydmVEbVR0QWRnM3hRSUFsdFpPRzNYZmYwOTFFQ3puSjM4Z2RMWjNEQXBZ?=
 =?utf-8?B?S1UrclQ1U3IrMWkwN2JjeUxpNkdvWWtYSFFBSVovaTlhOGRsQVlrcElEd0th?=
 =?utf-8?B?YlBwUUQvNVY3VDVPaGtqemZuMHVtdnFTamt0ODBtbWQrNHZiRGd4NGpFL05B?=
 =?utf-8?B?TWxuQXVxUzFNS1pQTGNHa3NsODFnRVk1Qm5mUndhVUZ4SXEweEEyMEgxT2JQ?=
 =?utf-8?B?NjhTWXI4ZWlvTy9GRHRGRk9yQURmZmoreDN3N1JNaEhWMGpkUVhncEFycHlO?=
 =?utf-8?B?cm1JWkNJTzc5YWoxdWkwRHFGb2lQZlNSYUpOZnNNOElWUlNwQWZOalI1Mjdy?=
 =?utf-8?B?L1BCd0pnY3VZM2NSa2haQmN1TllyVnF6R1dqMFNKYm5nYkozTHdzcSttbm16?=
 =?utf-8?B?MXNTMzFOVFZndDVNUnFTaTJaQWhyWklaU2pZRDE3MjNTVEQyUkMzY3hGY2s3?=
 =?utf-8?B?UjJRMFFiREJOV3QzVlpRK3FJMGM4K0RQeER3RytMVC9oemVueEF5S3h2aXVC?=
 =?utf-8?B?Wjg2aWs2TlFJdWxjM05YNWxnZ1BjRElMQnpEZU5KRlV2NDA4Sldpb0sxMytO?=
 =?utf-8?B?bjJBUlkvYXFuKytFUkNjNXFhbFFVSG94aitXVlp6cnZwUS9wUURkWks4Smhv?=
 =?utf-8?B?dFRNYmJjT3VUYTdWelZsN1hRRnh4SS9BckRaNXlnekU1SnU3OElCb3VwT25j?=
 =?utf-8?B?bGVWbU1mb0lJL2xuM21RaHY0YkxTemlteVJPa29tWFROdUVvYnpicGcwWmlt?=
 =?utf-8?B?bmd1Tkt4UGkrWXhMNTlTb282VVZEWm4rOWNFeDlLLzlpY2MycUNsdUkxeGRR?=
 =?utf-8?B?OWc5MFlGbWxWY0ZkVlE2NkU0UkZEeUNCb1BlQTdCSkFnUE03aHlmRU9RMysr?=
 =?utf-8?B?dlkrbnZzUWFUWDlFajg5VHdqNlVvR1pxSGpTaSs0cVMzOHJFYUdHOE9Ib1Q1?=
 =?utf-8?B?T1FSK25OaVBmY0NlcFVDNVIrdkcrbnhJbStkZ1FMQkZUODRVbkIzMkt4U1Jl?=
 =?utf-8?B?dDJrUUsyemQvT2c4eXNFTlJWVXhVSlM5eG5qQVhmd1F0NEp2VjM1Vi9sUTFZ?=
 =?utf-8?B?YmVPNE95eElGQXd3UXIwNXFnak4yM00yb2lRRnBvZVJTUnh3VEFWeUp5SVZI?=
 =?utf-8?B?b0Mwcko2aXF4WVVHUE12UE1aK09NVjBiK1c5Mzk3dkQxNjI5aS9iUzZmT0xS?=
 =?utf-8?B?cm1rb0dLUVFuM2ZCYlpmSnhsNkhrS0w2UzNESW5lNGV3NW9qUjF4RVZraHFa?=
 =?utf-8?B?T2IrMmtKUGFleGZjSU0wWEhrSmNnWGNUcUxiR2dZdE1RQjZuSW54MGxRSXc2?=
 =?utf-8?B?Um11N3UxSE1NY2JyQkpYSW43RDNFZCt6dkc0UE5qajBPV3U2c1RrNFcwUjh6?=
 =?utf-8?B?MFFqcm9PajNXVVcyaUpTNzBYb2hrYTB4a0RWWG9LRGJQVVI4TUM1ak5LdU10?=
 =?utf-8?B?VlBKbHFsR1FET283S01rTEE2VGNBTzhUL0lvd2RURUlPR0NYS2NsTzZwUTZD?=
 =?utf-8?B?aWRuTUFJMm51KzZxUjRQaVRQTzNxUU9rSWk4cXRhWURjd0NyclBkRE4vTTdj?=
 =?utf-8?B?dXhyTS9DVWFZK3VGK01vQ3FiVWFwZStYQitYdUZmMmtscjByaDdoeDZ5czZI?=
 =?utf-8?B?VzNPMFV5VExBelFSQjAvRVBvclZtMGdSelFTTHJnZHcyejhwQkN2QVR4b0l3?=
 =?utf-8?B?VmhLQjA3ZVZsb243YlNObG5xRGdaUlV3TVVzVFRIYWxNZmFpNXhtSEVqYzQz?=
 =?utf-8?B?TE93UWwrM3hrbm1aTjVzaWIzendoR2hLa1E2aTgzcTcwTFY5bTNBTVJxNk0z?=
 =?utf-8?B?VEhWb0lPTW03ZE5MNWtJQlhlSjNGSzM3dW9qWG95UTFjU1JSNlFMV3JKZ1Vi?=
 =?utf-8?Q?RBo/xYMztSukFkOA=3D?=
X-Exchange-RoutingPolicyChecked: fkhjZFaOrmLPjZRp/AHiHv4sROLvmFCzH9Zg5wwnugzvuBTtqqIovOhO7zGd6Xor79O9HytoxDumW20vFsgWG0BoJFsUqKL5K89OERD7NP1vA+G68X0SDguiOzbiipSGYE8a84ZK/AWSLbNjybw97Av733tI1+1dLvxNVXEz7FMEyemUsmRGodFIkhjg4HKuSOFCQpN18IxDOy3ONy6dFPfqSbXRGaOXJOrWs4t0brJtvioH13qWXprF2FdrPmLmijMDx/UAOyHnPVFs13krPPncbG5fQNjLRzTXk2Up8diDJz0V5FiYDIQttpKCZb38GtDyyqQz176T1p+wMjsjzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c389870-b3e1-4bae-fefb-08debfb17696
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 07:43:25.4851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owPIBZSLHaEcIuXxzUDz7e0hfUZYyQNIHFnOx5UA2X76TOpuAtf9avl6LzTMxArTgZKQGtgCGqvQ4SSGjUlOmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9154
X-OriginatorOrg: intel.com

On 29/05/2026 23:28, Sergey Shtylyov wrote:
> In the driver's probe() method, clk_disable_unprepare() for the bus clock
> is called on the error path even if the prior clk_prepare_enable() call has
> failed (and the same thing happens in the remove() method as well) -- that
> would cause the prepare/enable counter imbalance.  Also, the same problem

Doesn't clk_disable_unprepare() do nothing if clk is IS_ERR_OR_NULL()?

> can happen in the driver's suspend() method; note that the resume() method
> does check the clk_prepare_enable()'s result -- let's be consistent and do
> that in probe() method as well.  BTW, I don't know for sure what does the
> bus clock control -- if it affects the register accesses, the driver will
> likely to cause (e.g. on ARM) a kernel oops if it fails to prepare/enable
> the bus clock in the probe() method...
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: e438cf49b305 ("mmc: sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
> Fixes: bccce2ec7790 ("mmc: sdhci-of-dwcmshc: add suspend/resume support")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
> 
> ---
> This patch is against the fixes branch of Ulf Hansson's mmc.git repo.
> 
> Changes in version 2:
> - mentioned the problem in the remove() method as well, somewhat rephrased
>   the patch description.
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index b9ecd91f44ad..29af07561a86 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2441,13 +2441,16 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  			return err;
>  
>  		priv->bus_clk = devm_clk_get(dev, "bus");
> -		if (!IS_ERR(priv->bus_clk))
> -			clk_prepare_enable(priv->bus_clk);
> +		if (!IS_ERR(priv->bus_clk)) {
> +			err = clk_prepare_enable(priv->bus_clk);
> +			if (err)
> +				goto err_clk;
> +		}
>  	}
>  
>  	err = mmc_of_parse(host->mmc);
>  	if (err)
> -		goto err_clk;
> +		goto err_bus_clk;
>  
>  	sdhci_get_of_property(pdev);
>  
> @@ -2461,7 +2464,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (pltfm_data->init) {
>  		err = pltfm_data->init(&pdev->dev, host, priv);
>  		if (err)
> -			goto err_clk;
> +			goto err_bus_clk;
>  	}
>  
>  #ifdef CONFIG_ACPI
> @@ -2507,9 +2510,10 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_rpm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
> +err_bus_clk:
> +	clk_disable_unprepare(priv->bus_clk);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
> -	clk_disable_unprepare(priv->bus_clk);
>  	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  	return err;
>  }

