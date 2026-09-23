Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825B3F4831;
	Wed, 23 Sep 2026 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184493; cv=fail; b=GTMRY3CVeJVITbPDq7gFVNygT/Kpa0Nx0rJ9LqAbnB5j5GVmdrur90QtwtpwjpEOtfYplwMrTczyfN4Y8orz0a1Wa7FLl3BU133Fb2MvkjfUdZeFXdub5sbFKHJxI98lwhSPKtHcxDqnbTq7VzmyEDQqpfKtoLv6aMf6HqSGwpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184493; c=relaxed/simple;
	bh=CqZxSXSDZARsis2e0zJ26sLCJPQftArMy7WcxXN9l5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m3TKbj4K21lx3RM9jbV8j/dU7JEP0Vwr77qcp/NvfSdIdgYYrUA1LMdftIrqRmxsFejtdfKrozRGq9ZzbYlhvi6DKLuBxz+7eYYNyaqiTzw937vmbDPN4d3Kjff4wsHDsfIURdJAhjTiuzsDpJqqg3B+6ZD0jDa89xbSzA5Edxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjGN+iJb; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjGN+iJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790184491; x=1821720491;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CqZxSXSDZARsis2e0zJ26sLCJPQftArMy7WcxXN9l5U=;
  b=ZjGN+iJbA07QK3CrY/WQ5CQVYIyFvQyL32lBNd0ZUDeQpSQ5QGZyl1Zh
   Smd8IN2Xuk0d/lR1dsJM8u31XwGSZPW4vxvDYJi+d5HManu1ciBz0Pp5A
   w8FhgUGuT2oa5vZGOZAMBREz5gyh83j+ylHtcIH1FHkCSQiV2ZKvwdMS0
   IGCXec6dw2Zgt/2CtB6ctCePo/eneS0BaOtrk/XCpJTtzrgmxA8YsWa77
   CMB6eKqrzuPc9O93ahEPmbV4PgGGro9MEHcxvXkqegW2bV7zEJfr3hUON
   B9R50LabC6a45mwm7rOgxE8Gyuj4cvzw3y5QE7nT2bELtroR4VNNbmw98
   A==;
X-CSE-ConnectionGUID: /XM6ixLiT7GjK0O6ICTXsg==
X-CSE-MsgGUID: 1bhas3JcSPyGJQKsx0LWng==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90773998"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="90773998"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:28:08 -0700
X-CSE-ConnectionGUID: 9r+sjiIJRCmibVU2Ao1Iaw==
X-CSE-MsgGUID: 25B69/TiSTC4gWLvLJAINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="281789499"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 10:28:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 10:28:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 10:28:07 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.45)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 10:28:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WutRh8nnFg4gSVasKolSXiPdRCios891DuiFbnCMEKV5tpxgfmD9gTHuQiz2c8v4pGIGKmNvmnXsvWRGJcLXIvnckynE+SsJ1HCeLQ3p9MCkrgTSNEJ6sbiX0sbO/ZZiBPrFiPc6l7zHTMVzUTGBG6swlaB53eEhTe4hV5YrYQ1Df9tobGlAukUgPVA9JCpyjzb33FIQaHZHrNHEO0/rdYZZyCaWMSXd7cm9Bdlgt/miRV2ltShFe6t+IfcZxMuKv7O9kY3nZ9gLuxVgpfLahGDfFuzyBOSNCeP8SHEdIKgXW6uqnmWd6SkoP5Y2Vw4qcH3535vYRvFssw2IMHM3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSry4GK5tLyJ2hKXWQBBXeOVs0ItztRuETMVl5JgzQE=;
 b=JIz+rEjnZc83BY/sACs0Z0Q6NbCphDHjUVr6LWlmKq6Fw3R9hZXnuoSZjprWsrA/Hs2SfSJOm8Zd3a9TyV4NDKjNtfhVTZ9zXHPdEbKm2Ap3vStGgq6seW7d9O5oCilfqYVpo4sWCE2iuzrBchgtxro02sABYJjEbEC9ezQvdgKGY7DEtu5ojfMjE9cViqa9jQ5scn6MJBkaJXuiGQzZ2rqBXhL0dj1eCFN8IO5UctUlgdagHd19g9C6p6OuPBlUNXb0E2RAAN7HZvXhKTg/vh3qp+4tl1VP4aAH90IhpHN3YQjyOG2ei/50+tIgnoXonsTdCS/OBGp8CxuiYPvjqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by EAYPR11MB9946.namprd11.prod.outlook.com (2603:10b6:303:2da::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 17:28:04 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 17:28:04 +0000
Message-ID: <432a1526-cffa-4040-8153-5f57676fbc7f@intel.com>
Date: Wed, 23 Sep 2026 20:28:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pxav3: use managed clock enablement
To: Rosen Penev <rosenp@gmail.com>, <linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulfh@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260915180401.7809-1-rosenp@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260915180401.7809-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::19) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|EAYPR11MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: eae3d5b9-f6df-43df-b857-08df1998064e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|5023799004|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 7wiKlXbl6jANttxfBWy8B6tsgeqq9oSkF6Uf/LCbojTqrWG3u4xJW2GAaLH7/O3Imd8kMtTPANHixD/ZJWTHCZ1S+6v/UrOb17djpZolEf+at5pQ0MXqZirm1Arfsl6+q7+LQuioYFStD+eATDzaNABbWCr93Z8rl20w9nw5itSdmg04aRa3vCYh5tKbRaH0ploXPe8xC9ZRfaRFWjGivwEFArt41a+Th+8KUdp02TWErWVNjuB9SmO3RCMqRm4lxETsfknijSIBtkRQ9bAysbHgnx1FGI5J49KBYXyURNVrJWscwmBQ+Gt+wj+h7UQ2HeG1BUcgRTU/rjLROQzjrgQeQbB2DUTm/syc6kK05sfe5VMOZsUdSqAdFg+VQn9DYi7iXebIdZqNUtYjVoH6h+k87CLzGMG1Cb0EP/KbLJNsp1C1zkw9wLYYS/8JXJmG4jGXx/aVIonJjMGYcwc3FesxBgDW62V8LV4Le0djzJ9BC1U+IVif+WaKWlYM59pU46BmKSkHID8+hnUwuTT22cuubqlag/MKX43Dg7CPOFm4e+JkajKdtYZwGBoPpf7H+gqHMGGTRAK5D2uRJV1nFxbonabtpIGE7nGjlCCO20sRLEmI6IV3k/dEC38CraeDpDTmwtxbTX/RL0v+lsMca3gHY65AfpzGaaq1wzTM9VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(5023799004)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVo2cGdMYWVDb01nWDI2L3FxZFgzYThudUlsWmhIWUtXb3N3WFg1TEtZMW41?=
 =?utf-8?B?VnhsVWFSSE5qdWZGNnNFVGhrZHlTekQ3YzhwQURtbE5SamtRNjhlNjE0bkJ5?=
 =?utf-8?B?cENYVCtORlkzTmtEYllHUUFpSE0vb0xqV21POGl6NnVnWVVSOC9qYjhVVVJH?=
 =?utf-8?B?SXZncFRYK2xSQ2hMMEk4enA0QndmemJhcHlyTHFFQzNhOU9aMXlTQlkzcE95?=
 =?utf-8?B?dmNRZXp3QVJYVDk2anZyR0wzd1JRdHA4T2F5UDNOQ1ZOU044L2pqSWR1ODNT?=
 =?utf-8?B?endtVW9TN00xVjlWWkEwNHhlMFlQUEtWNEEvSlF2SDNXb0VmZ1lqb1NBZmhF?=
 =?utf-8?B?VDd2ZGlaWWlnQ0lIRytpdm9xZDlSUkR1V3Q0QlZteTc1OHh6azQ4REl3WTN5?=
 =?utf-8?B?N1VhcUhtYjNvYzlTMXBLN2VLRUgvWElTVkF5b21RQ20vSExlL3IzVlJSUURo?=
 =?utf-8?B?bjI3ellzMi8yeGgydDQ0VVpSVmhIc2xYdFVHNnNRZzVvSk5ZcHVWNE5RV3JY?=
 =?utf-8?B?dHN1VmtkR1VFQWRXMXg4aEw5aXJ2ZFFCaFNlQktPWFNERWNvV0p2Si92dDZo?=
 =?utf-8?B?T2Uxc1djMXhoQ3p3UFJZdFNUUEFYQVNSTEJhRGFycFFrZzQwSk9FM2pNaFlr?=
 =?utf-8?B?SGJ0cXlyY2Nkb1ZVUEF2WkhLWG5BYm5DL1o2Ym1UMHNSc1FOSndEbTVwNGZq?=
 =?utf-8?B?UVpzUnhNbHRFclZXK0dZRXdUR0dLRjMyNUxnNHZkMnU3UEZHRm1HMzh2S1J2?=
 =?utf-8?B?UCsxYzBHak5pNStBZWw5OVBCTkJISGhKelZhc0lPcXhIUTVUQjVYbXQ0R3V3?=
 =?utf-8?B?VTFqOHFpTEwrVk1CTGxnY0dhVmhIcGd3Mk96UDlBeFl0cDEwdlUvYWpGYjla?=
 =?utf-8?B?dFJNZHhBV3NwMEJ3TFk5cUd0clpOaFBoSGpuQ1dFKzBHYlYvUVZYOVNISGpO?=
 =?utf-8?B?TWpCNlRZWXo3OUU0S3BuVHMrUFlaSCtRY3Erbk1FZUNtaUV2NXA0ZTErRE9E?=
 =?utf-8?B?aG1XdXZRL01KNjd0M2o3UHlibnJsVmtCNVJ2U2xVVzkzVlk1Z0VPdEp5WEFQ?=
 =?utf-8?B?ZjNUb0lTTzJoeGl6OVk1dDZHaEZnYmdydDBoWWpUV3V6UUdBTG9SM3dlQ25w?=
 =?utf-8?B?dUljZzYxOWpYYXJ4MVRjcDZlZXg5V2tnL291ZTBBcU1VaVhBZDlwV1pxcnJE?=
 =?utf-8?B?NDNsdkxrY3REUmhxTUN5dXpMY2lDWTRIOEt2djhFS1hjUnFodXJGMjNkSmZN?=
 =?utf-8?B?ZHVwQ3l1anEyR2hxWDdDa0YxZEJsMEFqc2xXTGhjRnpiUk9haDVudExSZnhX?=
 =?utf-8?B?Y2N2R0hGb0tQdTdpek02RGRNVUlkUUl2U3J4V3NmalBPbjdtY21TMS9sMzFV?=
 =?utf-8?B?c2JSLzFZYkUxRTRHdzJuY05zRW5UeTlZQUNDMzhEejhDQlM3dnBOaDY4aU5k?=
 =?utf-8?B?RkhvN2FJYWhPM1VmUENaeGRCN3lNcTAzZi9JN1pyY2hIbVV1Q3pFRWpQeFUx?=
 =?utf-8?B?aVQzbGVkblJDR2FsSXdsRjY2QXltTVV2WE1zUXR5K3ljaG5PQnhRMEZOa20r?=
 =?utf-8?B?M0lhZEtTM2xLMWJsWTZMU3FvTHhQNEg2dVFoVmZ4aWVqOE9GaUZyRmp1STFJ?=
 =?utf-8?B?aUcrYmtUREdlRzBBOHpRZnFValRjOWtneXJ6bFZsNUE4ZDVzMFA0WGxSMVFp?=
 =?utf-8?B?OFYzNW9sdlVVV1AzUEhodDJFMk4yVWx1M3diRHJKbmtEL2plbWhlWXR3VWIy?=
 =?utf-8?B?WmNuUUVraWxEY2dyN0dGSHdjeGVqbEVFU2xNVjRydGJ1TUgzV3pUQjNoeFhz?=
 =?utf-8?B?RlZ4akIxMXVLczlnUGN0dEJ6alJxWElWYnRobWdHbGhneCtpOFd4YnZCZDJk?=
 =?utf-8?B?UmY0WGFKVWp5N1V3ZU1rTXkxdnR0SDlrTmNPSXhweVNiTy84eWtaQ253R1pF?=
 =?utf-8?B?V3dmcVU3RGZPTWpJaEJOZVlqa2kxbnRMbHZlTDlKUG9vdEFtMllZN0NFaW8v?=
 =?utf-8?B?VjBwN296cURKVUJiMnlEeE5xQW5mbzI5THhmc1FvSVZONnE5NFFWdEZDQXFn?=
 =?utf-8?B?YjM4cFRCOWYweUs5OFJyZEd0ZjdXeFhkbFhwYkNkQkNBalhIbXZ0K3VHMFpS?=
 =?utf-8?B?Y1l5enAzN01xa2dPQWVEWEthaGlmdC96bENFcXBRc1E0aUYxczJtVHJJdlJ4?=
 =?utf-8?B?MSt3WkNDNXluNTlaY0FHWWd6bVdya0xYNFo3L0pxZG1ZWTNiQWNGenBWZ0RH?=
 =?utf-8?B?NTE3cndrb2ZwRXZuQ290Rlc3SDQ0N3FlZFh1NU1SS3cwVjNsMEZvRkdzZTE0?=
 =?utf-8?B?QjkwZ3hvQXB0VWpmd3B1c3kzVUkwejN1MkYwV21DdE5vbkE0Nzh1R0x1ZHgz?=
 =?utf-8?Q?9ux+nlAaNLP+S6bs=3D?=
X-Exchange-RoutingPolicyChecked: p+N2hscPUTqm+5bYc34MEebOEBH/V1vgncl/8qHmemBazBHU3lR5MXQ4U0VxwhFDG55fI34pLxaHnUnOigTyPYxwplKMtjfVPGMp/9n0JhbLWSClIIB/vIXGZ975JLY8BqRmLWl/75tMPZsvtgmODszbaQRBKopv9/zG377pZpOfBBJ+fE2pj7TSc8xZL/DLvaQzJoTFuPPqkwhweYvVpjmZvUly6yQDk1KRQY35J+/MQwUvBRt/lp0i0BsOvN212zuuu899i4RxGfhXp+p1KFvKKVb4PwBdYpiIY8MfO54RUpPNFFfTx3qxLMywumzjGdLw5UffpXRrGLVfmr2T9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: eae3d5b9-f6df-43df-b857-08df1998064e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 17:28:04.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8juKsTDkX4sswMee8Vnhf5TKebgUE4Qpzz38zhLoRFpwcdXnD5iv7NbS4PSH1LXde7Bx09QGcpwgiWtZsyD65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9946
X-OriginatorOrg: intel.com

On 15/09/2026 21:04, Rosen Penev wrote:
> Replace devm_clk_get() plus clk_prepare_enable() with the managed
> variants devm_clk_get_enabled() and devm_clk_get_optional_enabled().
> The core clock becomes optional, which removes the IS_ERR() guards
> in runtime suspend/resume and lets devms unwind the clocks, so the
> manual clk_disable_unprepare() calls in the probe error paths and
> remove are dropped.
> 
> clk_prepare_enable() and friends are NULL safe, so no need to check if
> the optional clock is present.
> 
> Also handle failures of clk_prepare_enable() in runtime resume instead
> of ignoring them: a failed enable would leave controller register
> accesses hitting unclocked hardware. Bail out before resuming the host
> and unwind clk_io when enabling clk_core fails. This also drops the
> now unused pltfm_host variable from remove().
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Please remember to put something in [PATCH] when sending a patch
a second time.  "V2" with a change log saying it is just re-based
for example.

> ---
>  drivers/mmc/host/sdhci-pxav3.c | 42 +++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index f39764ffd4a0..c2ad801dc9a8 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -413,19 +413,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	pltfm_host = sdhci_priv(host);
>  	pxa = sdhci_pltfm_priv(pltfm_host);
>  
> -	pxa->clk_io = devm_clk_get(dev, "io");
> +	pxa->clk_io = devm_clk_get_enabled(dev, "io");
>  	if (IS_ERR(pxa->clk_io))
> -		pxa->clk_io = devm_clk_get(dev, NULL);
> +		pxa->clk_io = devm_clk_get_enabled(dev, NULL);

Let's follow sdhci-pxav2 approach e.g. from sdhci_pxav2_probe()

	clk = devm_clk_get_optional_enabled(dev, "io");
	if (!clk)
		clk = devm_clk_get_enabled(dev, NULL);
	if (IS_ERR(clk))
		return dev_err_probe(dev, PTR_ERR(clk), "failed to get io clock\n");



>  	if (IS_ERR(pxa->clk_io)) {
>  		dev_err(dev, "failed to get io clock\n");
>  		return PTR_ERR(pxa->clk_io);
>  	}
>  	pltfm_host->clk = pxa->clk_io;
> -	clk_prepare_enable(pxa->clk_io);
>  
> -	pxa->clk_core = devm_clk_get(dev, "core");
> -	if (!IS_ERR(pxa->clk_core))
> -		clk_prepare_enable(pxa->clk_core);
> +	pxa->clk_core = devm_clk_get_optional_enabled(dev, "core");
> +	if (IS_ERR(pxa->clk_core))
> +		return PTR_ERR(pxa->clk_core);
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  	/* enable 1/8V DDR capable */
> @@ -434,17 +433,17 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	if (device_is_compatible(dev, "marvell,armada-380-sdhci")) {
>  		ret = armada_38x_quirks(pdev, host);
>  		if (ret < 0)
> -			goto err_mbus_win;
> +			return ret;
>  		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>  		if (ret < 0)
> -			goto err_mbus_win;
> +			return ret;
>  	}
>  
>  	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
>  	if (match) {
>  		ret = mmc_of_parse(host->mmc);
>  		if (ret)
> -			goto err_of_parse;
> +			return ret;
>  		sdhci_get_of_property(pdev);
>  		pdata = pxav3_get_mmc_pdata(dev);
>  		pdev->dev.platform_data = pdata;
> @@ -499,27 +498,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  err_add_host:
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> -err_of_parse:
> -err_mbus_win:
> -	clk_disable_unprepare(pxa->clk_io);
> -	clk_disable_unprepare(pxa->clk_core);
>  	return ret;
>  }
>  
>  static void sdhci_pxav3_remove(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
>  
>  	sdhci_remove_host(host, 1);
> -
> -	clk_disable_unprepare(pxa->clk_io);
> -	clk_disable_unprepare(pxa->clk_core);
>  }
>  
>  static int sdhci_pxav3_suspend(struct device *dev)
> @@ -560,8 +550,7 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
>  		mmc_retune_needed(host->mmc);
>  
>  	clk_disable_unprepare(pxa->clk_io);
> -	if (!IS_ERR(pxa->clk_core))
> -		clk_disable_unprepare(pxa->clk_core);
> +	clk_disable_unprepare(pxa->clk_core);
>  
>  	return 0;
>  }
> @@ -571,10 +560,17 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
>  
> -	clk_prepare_enable(pxa->clk_io);
> -	if (!IS_ERR(pxa->clk_core))
> -		clk_prepare_enable(pxa->clk_core);
> +	ret = clk_prepare_enable(pxa->clk_io);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(pxa->clk_core);
> +	if (ret) {
> +		clk_disable_unprepare(pxa->clk_io);
> +		return ret;
> +	}
>  
>  	sdhci_runtime_resume_host(host, 0);
>  	return 0;

