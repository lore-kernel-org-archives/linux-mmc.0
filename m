Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79C379C53;
	Fri, 22 May 2026 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433894; cv=fail; b=JqrtWQ5omFKA5FPL2MD1FLj5qlq4n0uctDKapxnAtjutAtCWdHZ1nlTmUeM3ZBP7ztZqtbc38F0/46sdz1adcbywaU42rHVpcUIPseHChnXMGsIVRnO9XRzO5w7chlDL6m2mhcPfoYwYWlza0cSPRgq3g1KDpxUgI9kwDaZcIyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433894; c=relaxed/simple;
	bh=IfPwih0PNDdvMVeWFGDN26U65/A4kCzZVpdeiWPyQ2c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JEXlWe3s56k1PpohkyvXkA9Txc76Y9xtDyWJOrLVFhXR0tFP6sAx00DkXqDkzBaLGVmsM2yz97EvASXZlAU1pKEZRMytYgs7p07eH5EqamhmKsyfC+Cp/RsImathdJu37aRVMVOKSaSKenF1TkCvzjnhb5//rQO6miv8CtE9kLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yd5BKeDk; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yd5BKeDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779433893; x=1810969893;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IfPwih0PNDdvMVeWFGDN26U65/A4kCzZVpdeiWPyQ2c=;
  b=Yd5BKeDkYcV/Tqr0qxjo4IdKo4O0nl0YkC+fhPFOtpxw7F4iEDmSy/ks
   HvFKYRXW3L3dRmN+Plo6z+UWOCgYlxMndXmJ4Lm0RKPAqMK8WODiIK2ti
   ItOwczCpfQD1HrhXahLzpHdTf/KgU4PtOUyXUvXfmCBe18nYD9wyU1/PC
   tpWAuXh+GcLmN2GI4WTX5QpB7D/kkt31Pps63Kc8wvu3A6VjXkQwtNBVO
   mXQSFilZZSTErYdzj1FGQlHrizjQuttD9QiOu11S51LUu1+i+C2eJJyZL
   FKiQj9vAEZo879RL3FzG6tOgwBaOlCUGYIL5Mc9jTzzsV6XJs7AiDcZ9K
   g==;
X-CSE-ConnectionGUID: ro4Jj+/3T2O9L+3Szng8tA==
X-CSE-MsgGUID: fUIojOpyQjemi3VhSqoIZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91754132"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="91754132"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 00:11:32 -0700
X-CSE-ConnectionGUID: S2vx2KX1TIqfT/8/lowj+g==
X-CSE-MsgGUID: 6y3tiJPzTLumW1l27DQGlQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 00:11:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:11:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 00:11:31 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 00:11:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiVAFBy718ftOwS9qTChb8/5vlXFb+b5wEYgJX2DEPTfPE7RLBo0gmWCI+0VjIIM8ruX5HCQD5e6ugyQpdKN65sXrPIGtPPdcaeqXFJiefRDvtR03/jLuXnzr00bqvd48JkrgUWEqiiRsxU4XFmXouzhpjDnFrFLL50uAYRFv6CHKlQURUiVu458kSCIto/8UAK+OXgYJnbgmxwpQleT6SDIwpFPTadcVqCNjmsMPe2UO6XNKcWZpos5frudorzS23sYFMN1O7rILywbKVuj4KMwZSZD+wnnP7L4qnUszhSqcCkbmOtui6HGj+acuDSA/SMgg3tQiB6s4wTVKv7sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JdmpEvz5kgVsrqw9jkMNWCwcPRKQHw+iGsdcE72/tE=;
 b=P++Kss0Zj2vHjG3EKMi2DZ6nu17Quviem8tDAyzakQWFGkpZyZLvmlXJXwR40P21ijTt2Or3nsKhMez1wx49mtu66ABC5g7H/H6BnL5r9X4eLJGLPvlG5aZm5Mba4StbxK1n+eYha8p+Va5hzxRfG5JLZIhda42x8ARVNMKNoqUzSSYcNt8Az6QAOVmdWSKwH9UHnvlq1Xr+JC4AiubVGp4ktZQewTGluac6zfQzyEXxfUh/stOc4nBGlI13n6d8eABDjfSeWu1zRU/whkOxuhQPPqjXSE/0usM43a22Hcki808QW8HnbgyCLSPIzpi1XB1CTNwCVeW6/loxkQVsYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by DSWPR11MB9692.namprd11.prod.outlook.com (2603:10b6:8:353::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 07:11:29 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 07:11:29 +0000
Message-ID: <eb7237d7-b148-4ceb-8c6f-b4af9786064c@intel.com>
Date: Fri, 22 May 2026 10:11:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mmc: sdhci-of-dwcmshc: improve delay and sleep
 handling with fsleep()
To: Artem Shimko <a.shimko.dev@gmail.com>
CC: <andriy.shevchenko@intel.com>, <ulfh@kernel.org>,
	<p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260521083506.356422-1-a.shimko.dev@gmail.com>
 <20260521083506.356422-2-a.shimko.dev@gmail.com>
 <201336a1-3b8d-45dc-b2b0-3fcac611eac1@intel.com>
 <CAOPX744+iK+Okhd5rS1uXaFgCcA7CndYeJ38gB2Mv1T=TQG7CQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAOPX744+iK+Okhd5rS1uXaFgCcA7CndYeJ38gB2Mv1T=TQG7CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0218.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::21) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|DSWPR11MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 17927e5c-a3a5-43bf-5c17-08deb7d1575f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: BHolxVSAWmPXrn1BJXrs1ZhTCWIGEVp/W41pGlhTwXu8Ld3xt5cOTjzjdnS3pL+qoTveAKh6H42ZvA6L3jMCRb1BeGU6qxXMr9Rha+P+jnk8fqL1z9O927Ee70gdf0siiiXaMaIbY6wuLvYus8SqcMLhDFKKDHA2OBAKKs95fEyLi5FpxyTZ9POa1kcAB2uc//Y0HQ9IzC5KicbWjtDDBLPUNqrBvRSQ/7u9KqApoDQJOtxiMOQM5DYu/W7r/dqurT6xg7tSop82V54DnB82WmBCfPBrLLWHBMqmBJn4UUngxTesknuCz0bzqTyOEtP8TGzXyhjyWEKnbqQoP/fDGzoBK9Bt0/SKnRHVhgTXGszdqh3+qDZ2P+DvW8N8peywmg4NmTBBH2plIMDrrpwDOIlTPWEXi2xgnRUzt1I3tKy0SUKJ/9PYlxLGRE2e3mewLU9SA+fcThc5vJhEUi2ipoVFssOe36rDKlu/GW2ICFxxlPjipp/kYAdk/pwIIC1XSN2DDhrb0ygmOpNoR6dwWbbEoGBPocTPfkbLVE7BPqfiWNBfQohlGtapiyEgvPAxuR6cWpy2/DUjDPzHMxvBD576G3e/30DHFPWu9GjJu11q+5yxI2+AxSs3fMP08qkeRceUYh4PtTRNMCQR7Ybhokv/Z7Uuo9u6JM0UsTvFkRJsEj+Wr37jqYMRQvS5wcju
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0xjT243WlFnVTVPTndWSXZ0bXVZQ2NRZnhwSHRFY2NnRkkxTkJEZ0J5Z3Az?=
 =?utf-8?B?WHVGcTNSWi80eGZiVWtJUE45THd0dUVpRkdIazF4SHU3Tm1udGJGN01Bd1Na?=
 =?utf-8?B?QlBHN2hKaGJlZDF2Q3ljeENza1o5ZWdERllHaFFvQ1lIMWh3cDVLQ2hDTG9p?=
 =?utf-8?B?MmJweHlsd2VJbzRBSW1RU3hCWUtGZWNna2VQakdiZWJYSlJPMnN6RUZwRUdX?=
 =?utf-8?B?a3pEMURWU2Y2cUhCTjRSUFB5a0hhaDFhc0JiaDB2OXRxSC9LdzRXWnlOSXVW?=
 =?utf-8?B?MzViTjRVanI3d3lPR0VINjBxOU1oYUtYQ0VLcHFHSnRVVWUvU3ZHQVE1eFdI?=
 =?utf-8?B?WXpzUU44NGJzdXVBTHIrYkRoMDhyMW5Yb2pOT0FUZnhTNEM5REt6STRGZU00?=
 =?utf-8?B?akFhU1hoekhtNzBFQk9ONGhZeDVtVW92blViWDdvS0paN3MxVTlYbHJKbytE?=
 =?utf-8?B?ODNqZXhuakJUbm5hTUk2bjliMmlSaVlJdnBQZ1dwZjhnbXEwUUdFMk9jYjBp?=
 =?utf-8?B?ZGFyMXNUSUE4Ly9qWnR2UmhjbUJ2UGFEaUhCL1c1eVczRytya0l3dktBcndr?=
 =?utf-8?B?Z3BHbVJSUjE2RXRka1MwczhGTk9aU09nRkI5UEw1empmVklnTk40MG1MM2Vv?=
 =?utf-8?B?dlJydWNxUUk3WkxDOGxrK3VJQUUrazY4Nm1SWVc1QmZiNlRWTFRkU21tY2dj?=
 =?utf-8?B?UUw3cEhVTXlLMXg4VUJaM3Fjbk13ZC9MU2hNTENlZHRiSG81T0M1SlZRNUJj?=
 =?utf-8?B?Rm9iczhsRzVmMGdBZTBaQTVTY0J4Y1lCUTJiRDVRRWN2WXpyUjhnSGo0aFhi?=
 =?utf-8?B?N0ZHbCtVeUdFR2gyNUpFbWxUM1RoRVFrQnJtNGJEMHV1NEZyamNkbWNHTjR2?=
 =?utf-8?B?Nnh1T0xaQnI2OVhLRXNLeVpwRFJ4dDA5N3J4UXUrRWdNOUpIWjR0aUtQYU5K?=
 =?utf-8?B?czU5dUhwWTVHVC8vR0FlelE2djB5a3R2emJ6NHU5dm5ZS2FTMzFJVnNhMjdJ?=
 =?utf-8?B?eWdhWHFLNEk5ZU01QVp4WmR6dGo2N1pFOWlUYXAveDhhQjNPOUg3VDdURUdD?=
 =?utf-8?B?cVhZSXBzaFdMVVBjaDQ3OHhNM253UmVGRjE5OG5YQnRSVlRVcEhRYnZNUURH?=
 =?utf-8?B?SGk0MXE4NWVuazJtdWpnRTdlUms5ZVZEL210WFoxSlY2ajY4KzZkSGc1SW5Z?=
 =?utf-8?B?TVFrM09VQmF2YkRua3RtWnEwK2FzeUtXa3JtaUQxU1ZxdFIvaGxyVGVWUzVm?=
 =?utf-8?B?eEZ3eEJvSzBuWXpJWis0cWZqSTZHV013c3NuNDBQS2grb05JRkJhQUJKTlJz?=
 =?utf-8?B?eTRzSXBjRERtUmhmekdYY1lneFlhdzNQbkcvelJXQ0hvbDY3RzJTODNPQ0Jk?=
 =?utf-8?B?Qm5RMWpJWXlDcXFjczIvZUFEZlBpendxL3U5YmRoR3R4YVA3TnRIOVZzamNG?=
 =?utf-8?B?NG83YVZaSEhxTDYxWmdLb2VNSnVBNVZFbzl5MnE1OEJ5UmNvNVltUThkY2g0?=
 =?utf-8?B?UGJlb0ZuOTlhS05kdFFYM3plQXEwdS9zTVdpd1BlazBrOGtoaUlsTzc4U1o4?=
 =?utf-8?B?Skh0aE9vT2lVVEFCZ21vWkphdFpuVG9ZcHdsOUJ1SjRFNUlmYUpVUkxrUW9F?=
 =?utf-8?B?ZnIrTm8wSGxqMFEyZTB0SUg4SkZ0N01Pcm9ETCtlYkxrY2kzdWc0NWJZb0NT?=
 =?utf-8?B?ZUpCYjZCeFJybFMvaW9DSFdtbUxCc1pPWjVXS1lXR1JKbU9BcEMxUnpBZjkv?=
 =?utf-8?B?cnFJY3ZZWW5hczUvWlV3OWpwVnVTcitIeWgybEpOMERka0t6eWRGNnQyUnNy?=
 =?utf-8?B?cDBLOC9Oem1TaGpleUdjTU9LdE9oOW9RN0dlS0ZIdWNreTMxMGlENVhjbFBE?=
 =?utf-8?B?RWRHeFh6bjZSSVBnUHBvVXg0TmpRYXJJNXJKRmN6UVVhdkxsRFgzN1dtZFRP?=
 =?utf-8?B?N0pNRWFmRldpWEZjcWZPVHVMeVZNSU14UTFrNGEwNVBnaHJ5NGlpUVhzNzUz?=
 =?utf-8?B?c2I4ZVc5U2FGTUc2QU5XVVk5ZXFoNTU2cHBwenpDYTVMVEFyZE1XbDRYQnBy?=
 =?utf-8?B?S211eittU0c4YTl2OWNmaStQdUYrcDJNWXNQUXVUbSt3R3lUSjJkVDdOb3lL?=
 =?utf-8?B?ZDdlY0xINjZoWVBHWHVkZ29ETzM1eEVaWUlqdHVaRE5DQVVoNnVrcno1dDJ6?=
 =?utf-8?B?c2RCWGxCczBEc2V2L1kwS1JKdDRYOEJXVmh4Yjgwb2ROd2t3MW1WQ0xLZTJs?=
 =?utf-8?B?UFRmWmM0MGp3Vlk4aVJobi9henlUVkw2Y1VQaHZIRUxwUjd4OHVuM1pzL0g0?=
 =?utf-8?B?Tk5tUnFUd3BQeFdxdmRib25KUjlyUUhmOG5aaVU3ZkRUamZ4Nlh6bUxYa3Ez?=
 =?utf-8?Q?knaBx5VzAmSA0lAE=3D?=
X-Exchange-RoutingPolicyChecked: GmJPjLANL54jioGdOMWhVuOKauUSha4t7GDzCsKh1YZgkw1GRbQn+cEmOH4kh7UpMUmT1C96KJBSRuJlRumc6RIE5/CVxb0ItYRFxdv9zPlqctTjQ67ZVVH71/ELTvnzAlX5qze1gGeSFw8JVDUvLT0Czp68o4HYrz37hLiUv+SPF8qAdgf8m45kMye3r/YDvF73BEk3lPdXVvfx3K4JiIS/w1Xti0IOL5aXHI3P0K1gKj4G/aGen2BohA0XqDmhlPowlsAJde0SxFMV7/W0kBugfEIKnyhzzETftxjniACvMf6avu5ypTvPq2Wjl3+fRU+W/RrmUs8CkrsgyZrqLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 17927e5c-a3a5-43bf-5c17-08deb7d1575f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 07:11:29.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eCaNgJHVhdkeywnWsKEkDroBe+Gt+Qt5MxnkdoZ94zpJZliXr/umJX4EKkMfsgr4v/DKKbZnfypFuF2mVQmag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9692
X-OriginatorOrg: intel.com

On 22/05/2026 09:58, Artem Shimko wrote:
> Hi Adrian,
> 
> On Fri, May 22, 2026 at 9:01 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 21/05/2026 11:35, Artem Shimko wrote:
>>> Replace usleep_range() and udelay(1) (for consistency) with fsleep()
>>> in several places to follow kernel documentation recommendation [1]
>>> of using fsleep() for delays in non-atomic contexts.
>>
>> The usleep_range()'s have presumably been chosen and validated.
>> They cannot be arbitrarily changed.  And then there is no point
>> changing udelay() to fsleep().  Please let's just leave this.
> 
> Sure.
> 
> Should I send v3 without the commit?

Sure
