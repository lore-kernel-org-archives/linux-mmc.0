Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED552472AE;
	Thu, 24 Sep 2026 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234328; cv=fail; b=bckUoInV8VC1HEwr3E3cwyuy8o0C+AomKXZKervNWehuuQbXfourQ4gJ/RKshDaCWs6BBQjW+avDwIWbpRIPYO5ZTZ5sDEtCE8SRRtkNUN68vIwTn9kInNmE0Xk62/NEdUfpDSvf6RjUsEi4ayZKYpdZgJKnIa0ddpcvdCDuuLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234328; c=relaxed/simple;
	bh=yXED2S/+k4M6Yg488b23U2YDGH7ru/f6MvLfMSb2IOA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mTmsJ4o+ctI01Adwzz1DvbV13z4uzT7tJkfYVxgrNwY0lZCQ3s+/PC0Qun2qBYiy8SsaQscNjqFUPETXuWSoeVi1bTKuCZ1KfBm9OhIdKGFjIUlPIRKBS+o7b5JHCQlEmBZTbliJVFMO8T75zVd83UFIEf0nrkccOXlyFRba+Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/Vy5y9R; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/Vy5y9R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790234323; x=1821770323;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yXED2S/+k4M6Yg488b23U2YDGH7ru/f6MvLfMSb2IOA=;
  b=b/Vy5y9RTLKXEtQ0aDPH4dUIETT9sLyGR+/ck6LBcz8do6GIc4XPnKwQ
   6nj2eJA40NndRUXC2NbwiDe4h8/SKDD6u5RvjEFxcS5n6uduO4iYU+Y+5
   tgMLRPPm0VurEoEnxJZkuHLi7FOu562YGCNMeyakYtfIU3ReCj1UdDIUd
   CSCtUG8+lXCgX7Sm8TKhguaASd1gi/gF+Ch2qtrGMB6Rpn1Xhiy3nbMdE
   8mphlVmPboTEM5VeRVKoX7PdU8a9TEHH4LmUPmZjvAob7gbGygcfPleAV
   LbzkmvisXliVw7zgFm2h9ojL9DQkhTgTt2ddagYvbvOYlhLqnfp0pauEh
   Q==;
X-CSE-ConnectionGUID: 2L4nig2sR9GQeLmmSe9dUg==
X-CSE-MsgGUID: oNPmx4sCQN2xF5hssoXfMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93493745"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="93493745"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:18:40 -0700
X-CSE-ConnectionGUID: PcvBvxdyQrC3qeYVW/TXQw==
X-CSE-MsgGUID: U+PdG6vjT1GlAENBJy75XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274074272"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:18:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:18:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 00:18:40 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azA7UX5aFHMv3eYc2BRcYo13mHB8jJUqlb54TAFTd3ptuMYO+UzHfhhd+B2zYvyuBQvUpdzTKWkILceeOWydd4TakgLUUZq2Qet5zLti6wTzznCSLGrBQIfvv/0oYJN2FAjUQks20Ww0xAgAbn4RPalgbmadV5fZ70C0a/SQRO87/9JVfAFpf6t61oX1hh/Z04rd0jmAKel+KQJ/zlrp3rsZbJ/oURmSxlYuGOhlVCwK8CvKgq93iBNLLdPQ0lbT75Q8IUUkvu1ImQ27UrSwUXR28N7XUNYwmkvQlXMyLq3BNFy6efHGTW1ZtBXnACnuulqoMDW1pkn3jd6ARRjZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT6gbBkJlEO1G/LoWg7HwUkKc8H+zpyCmEpWB19B7wk=;
 b=w196VQ+e2CCiriisNGIxKoO13/G26JMDaQYQvbyNPSP0EtX0txnEQ4fH/Y4agZ1w6YVkQkh4WKTL92jXV3N051/91G0s+h1DaAH5CKbDCI/IHBzckm1SBTowYnaVNzrein+WlzTyPLhotKXXqvzE1GMVty7jcMtU/JTXWYk7xHsYNHhZv2CbduM+wKBXwxJQgb9apMSizgRmWZIUl+T3YkFLrq2TPxGP6zPQpX4SMt09Vk2Yi2sKL5t/XIkQjOw1JUt8rry7efI1rkS7MghXuBiwGlfFfYgRfeILdr3mRE0HlqOSJISeJleLu60xXavAx3jzrDjXne4YejJkiiG2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Thu, 24 Sep
 2026 07:18:28 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:18:28 +0000
Message-ID: <da386006-9673-4774-85fb-3a145fc972bf@intel.com>
Date: Thu, 24 Sep 2026 10:18:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: apply a per-command tuning timeout instead of
 the whole sequence budget
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shawn Lin
	<shawn.lin@linux.dev>
References: <1789530589-8466-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1789530589-8466-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::24) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS7PR11MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfcbb9a-6c20-49ce-ae3c-08df1a0c07b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|6133799003|11063799006|3023799007|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8I9a2duy8xdVYjP+efQzphbsNMhZ/JhacOuuJmHroYNoJNGn+mfapttnAZcVzoW9AER2c6RDZH6PeuRTlTYnOfL+k93WocAKA/Aw1cX0Zo51A9uRai9rY/4p867AZKoItIec5H9FkYO99tSc0bKkukYTOz+h0Lxm48dGhwu8Cdmh2vHSdu5sosqUZFlKBoGJNqgQBV0OJH9zF05gw9gq5cLR/pkTZoBd8FfJaLzj649WWnAfem7GGLjpns24KDNQfTmlK6f4q9zpaF7VE6UDq80StVr91Z9aYWgykFMxYSKtQdHVwB3vTco/MeAPCgzzl1/ApXicfPYfD7f8G0XZ0k/NCLiOqiaaX2wS1MClkmn3Zing8bSGc94ywX3Leoeibj2y+m3qLtCsgTM1257Z85wIvLJnE7BTPhbkVD+PYAg/s5S413cuYnzgj5zhJlPOnir82mZtc11wcBt+uYG7EmXvUvhuGqyLRe7Jv+x1l92oFyp2C9tbWFxM3AHN0NJsGZDvb1Wpuu6aTER+ZfoVKtR7ROA/wZsqSCqG6GEEnKboM3iSuP/jEmxBK3xDhcjdOoeRaFZ5iiFFNIQ0U3ZkZ4qUAz2UU1Qm++fjSeC6i30ctD1tplz/sejSg4MEtu6m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(6133799003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjFmYlE5SzJNdGUzUTFxQm54cnBuUnBYb2UyZjhmd2hnOXJscmxsU1laSWQ0?=
 =?utf-8?B?R1RrUkV2VFVLS1RqWnJ0bHNrSysrTkc4K0pjMm52TmVRSXpKVkNncFVCMlVL?=
 =?utf-8?B?akI2OVlxaEp0Y3MxL3Y4b3NPUHBWaC8rbWRlZ1RIb1N0QmNDN2h6bXNyV1VK?=
 =?utf-8?B?djNRWmFwTHh4MndLWm1QTERvRFl3YUR2ZklmbnNGMzRGdXJma1ZlR3ZVNjc2?=
 =?utf-8?B?cFM0V2ZqaHRlbXFOUXBGU0tiQ1k3Ym1obnRuY3FoMU5TT0JJbStNbEdZaXBS?=
 =?utf-8?B?V25rL2RaQzBpRUZ2eHAzRVQ1VE00TTZKOW5OeUxZK0FzbHF1YVFPWjFwY2Rk?=
 =?utf-8?B?MHI3azVRa3NYUUxQZUNOV0tqeGdTTTBWa0tSQ0lTMjRFblJzckREa0VpZFdR?=
 =?utf-8?B?QVhRNjJvekNMSUpDWHRpSCtkWVo0QlluVnFoNzViRWw3ZXZxMG5LNksybjBl?=
 =?utf-8?B?dFFPaU5ULzF4OStyR21QbEpsTUNMZnJwNkUvVjE2U2RIVk8zbkZ5UG1xV3dz?=
 =?utf-8?B?eU9QVFh6NGZZT05LSTZDK0VQQmtyY1BKanJGTGJsV3ZWOVFoRkk5YWplN21o?=
 =?utf-8?B?VkUzVFpMVVlGSHZqYWsrVmkxOWR5ZEw0aTBjZHdBYmg2Z0w3dVpMYWh1WmNz?=
 =?utf-8?B?K0ozSW5ZMWxzTmdmcE9BcTZKNjhHSnd1N3VnMFJsa2dWN0NYWEUxUzlLOWZt?=
 =?utf-8?B?OFpMRExsM0FUOUFHeGJWTENvN3lHck5MTnZNWHpnaE9mUUxDNGZ0MWtURXQ0?=
 =?utf-8?B?UGVVajhSK1Y4UWpBMS9DbFdDVjRmNURaL2RoVWlsTVdNbWVQR3NNT0xGY1Zh?=
 =?utf-8?B?MVdUb3RTendWOGdFbEJIdm0vSThnTXB6LzliZWtKMW0rWE40MkJ1NG9CYnZo?=
 =?utf-8?B?RW5HdW9VdTJHclJkclBYd1l5Z0tpNXlsUzdQZTI1bWZ6VThaMnVxeHR0anNl?=
 =?utf-8?B?Y05XVk5UVGZxd1JXY0tTaXVnMzBJTytlbmlLSnppWWpWUTFtNFc2MVRDT1pl?=
 =?utf-8?B?ZUl6ZmRlV08wSmZRMU9QdVNYU1BESzBEaUlTOTJ1a1A4S0diSEd2Rmd6UWJK?=
 =?utf-8?B?bXRDSDZ2QzdRUFRNQWFLYklsSjkxV3JlMkllSUVvTmdOdzYrNDFtYzQvSGhL?=
 =?utf-8?B?dUx2Y3BDNGtHbytpYTBDRlF4L2NjVDZSSFF1OWdUa1VRN2VuSU8xQ1NURmQ4?=
 =?utf-8?B?Y2lSbG4rVG9QdS94MUVyTG5Za1l0U3I2MFU3MzBYV05VZDAwMDV6b3NMMXU0?=
 =?utf-8?B?K21PcHJYbUM4MGw2aXJmcjNlNENYTHRXSG00ekQ4Zm1zL0gxdDdKSUl5OHJK?=
 =?utf-8?B?WGpRa1Y0ck5tdGhxNG42TWMwT0kvSWJuRm0xd1lGSTcrcCsxSzBkMEY5RDFi?=
 =?utf-8?B?aDVvalZDNWRWRnlYc2tUdjBGYktKeVRuYjVxZTIwNVk4RTRzY3lEUGtaUUti?=
 =?utf-8?B?c2NjU3liV2dWVktJc29zMGZIa3VQTHZBcGcrK2FVYTBoZjI1RTVRN1VsYnpS?=
 =?utf-8?B?SUoyKzhCWUJIQjRidy9Kd0R5djFqakwrMFZMOXRJOGh5T1A0OXl3SWxZeXYx?=
 =?utf-8?B?eDJXQUZQdFJnT2gyTGh4Z3NrUDcwU1VFVHpxV0Y0dWxQVUVhSDhKYWxQTnJR?=
 =?utf-8?B?UGFTSkdMem9XTGZyVkpWSmhRM2lVZEtuUU5BK3VUU3ZzVDRoK2ZIQ0hUMzBq?=
 =?utf-8?B?d2kybVdLRU1sU2swZEF6ZFdCWXpTMkJVNEFlSnIvTEJPR0NvNGVaWW1wd3k5?=
 =?utf-8?B?ZDA3cE94WWR4MkVTWmtJcm1yN1dPeWhLTFd1L0oyZ0VDOE93N0ROa0VNV1NJ?=
 =?utf-8?B?dVpJZEU3M0F4T2k5THNrQ1JRellucGVGY3FzZ094YXZjSDB4OWhCT3pZaUNo?=
 =?utf-8?B?TGFaM0FTT3A5YndaQkxYcGJOUVpLM292V3VXblJTVDFld2hQTTBpWEhTaEE4?=
 =?utf-8?B?TG4yNFY2TEU2N3o3d2IrUHRGK3BSOXp4TE5kUlNhc1I3UjFISVEzOU83RThW?=
 =?utf-8?B?eWlhTUhxZ28xTGsvS2c5U2N0VjIrcHZ4QXg2MXRPYmNpN09vM1MzbU1vUU9x?=
 =?utf-8?B?MzNud1QvSm5yZ3A5TWJXYUdGQXR6eEc3SmIwb1I1OXpCWFpHV25UQ0Y0bHVv?=
 =?utf-8?B?dEIvRzJ5Wmg5ZEhSV0I5TlFwL01KVVl2ZXlJa09OZlQ5MVJYQzkrSElOd2Ns?=
 =?utf-8?B?Q1pEWE94NGZpVGpla3Jmem5tVWVtSUo4M2tqSGZURDViMUI0VThFSENoNkNq?=
 =?utf-8?B?MmRETThKSG0rdS82THRLUEZRM1d2aEcvcDZIMm1Xdk1uMjIzL0FRSmZWTU9X?=
 =?utf-8?B?S1psOTV5dVdVVkU4YjJTdWF4UUhUUFlGbEwrOE82ZnN1VFVaNnhlNFQ1akVH?=
 =?utf-8?Q?dTnAI8WJQOW4OyRE=3D?=
X-Exchange-RoutingPolicyChecked: YRT6tBHxO30fpMPorHpLnNra8JHtGGIFhNhyqtNMkOmrr+MndrpHTJFK/Wt2DLlTLhe8q/6/08Xi5Ex1heesxymIZvNJeNC7R+Ic2RmjeokaOlD0za75csIJIaORpOSAOBxrfdFpVhOELOe72C7hb75KykP7CuF8UhGEyb+waoVi9LVbhxUsXV6fpQbPqGUVycBenXqEcQeB5udOYIKRu/qkanOLwF1nBHgmhPvgi/OgrAhWAswm/qLO2jXafItacJdWxq95LIJASJ/5jO3lY6ReP0oVVspoIk+yu8RinvyepR827xc0Dimht4KvYHJW5dPiAHWvzcI2ERBtU8qEjw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfcbb9a-6c20-49ce-ae3c-08df1a0c07b2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:18:28.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mERdzFL90RI0KGFDS3sKFPojMA850BYSvENIKkFDMsCjdcAPrxWEGzDcqxRdXR3m1cFFpqocsrVNjxfbDap83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8806
X-OriginatorOrg: intel.com

On 16/09/2026 06:49, Shawn Lin wrote:
> From: Shawn Lin <shawn.lin@linux.dev>
> 
> The tuning specs guarantee that a *sequence* of 40 tuning commands
> completes within 150 ms, exclusive of any host overhead:
> 
>   eMMC, JESD84-B51B 6.6.5.1 "Sampling Tuning Sequence for HS200":
> 
>     "The Device is guaranteed to complete a sequence of 40 times CMD21
>     executions within 150 ms. This is exclusive of any host overhead."
> 
>   SD Physical Layer Specification Version 4.00:
> 
>     "The card shall complete a sequence of 40 times CMD19 executions
>     in no more than 150ms. The tuning process is normally shorter than
>     40 executions of CMD19, and therefore should be shorter than
>     150 ms."
> 
> mmc_send_tuning() however applied that 150 ms as the data timeout of
> every single CMD19/CMD21, i.e. 40x the per-execution budget implied
> by the specs (150 ms / 40 = 3.75 ms of device time, excluding host
> overhead).
> 
> The data timeout only matters for tuning commands where the device
> never returns the tuning block at all; a wrong sampling phase
> normally fails fast with a CRC error instead.  Waiting 150 ms per
> such test makes software phase scanning painfully slow.  With
> dw_mmc-rockchip HS200 eMMC the TMOUT register saturates at ~112 ms
> for the requested 150 ms, and dw_mmc's execute_tuning() scans every
> phase of the tuning window, stalling that long on each phase that
> misses the window.  Multi-second boot slowdowns have been reported[1].
> 
> Note that SDHCI hosts are unaffected: sdhci_send_tuning() does not
> use mmc_send_tuning() (the hardware generates and checks the tuning
> pattern itself) and bounds every tuning command to 50 ms in software
> (sdhci.c).  The SDHCI variants which scan the tuning phases manually
> through mmc_send_tuning() -- sdhci-msm, sdhci-omap, sdhci-tegra,
> sdhci-cadence, sdhci-esdhc-imx, sdhci_am654, sdhci-of-k1,
> sdhci-of-dwcmshc (CV180x), sdhci-of-bst and the AMD sdhci-pci
> variant -- suffer from the same excessive per-command timeout and
> benefit from this change as well.
> 
> Use 5 ms per tuning command.  For reference, the device serves the
> tuning block straight out of its SD/MMC IP (no storage access is
> involved), so even in the slowest reasonable setup -- a 64-byte
> tuning block at 50 MHz over a 4-bit bus -- the block transfer alone
> takes ~2.6 us, and a full tuning transaction only a few us of bus
> time.  5 ms is ~1.3x the spec-implied per-execution device budget
> (150 ms / 40 = 3.75 ms, excluding host overhead), 30x below the
> 150 ms ceiling, and the reporter verified that tuning keeps passing
> with it on dw_mmc-rockchip HS200 eMMC.  Even in the worst case where
> every tuning command times out, the whole tuning process stays
> bounded within a few hundred milliseconds.
> 
> This also bounds the cost of runtime re-tuning, not just the tuning
> performed at enumeration time.
> 
> [1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=221781
> Signed-off-by: Shawn Lin <shawn.lin@linux.dev>
> ---
> 
>  drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index a952cc8..abcdcf8 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -708,11 +708,33 @@ int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
>  	data.flags = MMC_DATA_READ;
>  
>  	/*
> -	 * According to the tuning specs, Tuning process
> -	 * is normally shorter 40 executions of CMD19,
> -	 * and timeout value should be shorter than 150 ms
> +	 * JESD84-B51B 6.6.5.1, "Sampling Tuning Sequence for HS200":
> +	 *
> +	 *   "The Device is guaranteed to complete a sequence of 40 times
> +	 *   CMD21 executions within 150 ms. This is exclusive of any
> +	 *   host overhead."
> +	 *
> +	 * SD Physical Layer Specification Version 4.00:
> +	 *
> +	 *   "The card shall complete a sequence of 40 times CMD19
> +	 *   executions in no more than 150ms. The tuning process is
> +	 *   normally shorter than 40 executions of CMD19, and therefore
> +	 *   should be shorter than 150 ms."
> +	 *
> +	 * Both specs bound a *sequence* of 40 tuning commands, i.e. at
> +	 * most 150/40 ms (3.75 ms) of device time per command, excluding
> +	 * host overhead.  And that is generous: the device serves the
> +	 * tuning block straight from its SD/MMC IP, no storage access
> +	 * involved, so the whole transaction is only a few us of bus
> +	 * time even in the slowest reasonable setup (64 bytes at
> +	 * 50 MHz, 4-bit takes ~2.6 us).  The timeout exists solely to
> +	 * catch devices which never return the block at all.
> +	 *
> +	 * Use 5 ms per command: ~1.3x the spec-implied per-command
> +	 * budget for host overhead and slower devices, still 30x below
> +	 * the 150 ms bound.
>  	 */
> -	data.timeout_ns = 150 * NSEC_PER_MSEC;
> +	data.timeout_ns = 5 * NSEC_PER_MSEC;

Perhaps it is safer to let drivers provide an override value,
either as an mmc_host member or create
mmc_send_tuning_timeout(host, opcode, cmd_error, timeout_ns)

>  
>  	data.sg = &sg;
>  	data.sg_len = 1;

