Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E53C73C3;
	Wed, 11 Mar 2026 09:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219974; cv=fail; b=TN9WeIqQQU6GNaJDJe3oTO5ill9F/yWHo1a8ArNy044SnpUr3U6NWyFH6AQVn9KOqOrSSH/K+so3OjVWK96kDnDSipuEwlIQ+0nQ0JX6GQstnHtV8eDWOvkXJDTGey15J5NH6cW1WFkxW4AHx2zxQnQZUJJEJyL4Ei1NsWInCvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219974; c=relaxed/simple;
	bh=S55D9F5Vvbf5zdnxdgBAxJfG4fhf7KVbAdqKo1mvifg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gadoemW5/X6xjFC4e2ns1EsKW+0qOqppIKznqJsg7QOlvbPlW5IepIyvPqhIDwK9XfxtsctokPDM0KYqSwAaQofHAeYQlfpUUPrPhoPowIdEsZr5Chy4MZ0qxENs66b8jE5qyoTfV1E7oDBPfQVhZMUsa40ktd/SITxAJQ0V4MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqLg9iMg; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqLg9iMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773219967; x=1804755967;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S55D9F5Vvbf5zdnxdgBAxJfG4fhf7KVbAdqKo1mvifg=;
  b=aqLg9iMgG+d8q3Ao6RKQ/TjktZjPwbpM2BkDdw79NAgA0uPTYCfkEinK
   9cwdYsTjtj+DLlzV5+PTMBXXHEagVWUOUnJ4emD06l0lPS1uS9J+JS3Y/
   Ed3OcGkiPCqWEk540WjLIIr6nWKPIjhnSgygCaaO3JztdkPeqXoCLXZzv
   t4s7TuKAXqk09Bn6/hSgl8WVjGdvwPyY8srHPGldnOaCqQXkdvg4+mqs1
   qLq2vnSKs+XMugOvcwT5tRxbikQM+uXOQsz4GImNJEPyVSYqOt2eoM9RF
   whP2xFkBFOqRyVxrOcs66B8J0nPmUIhCjlNZRPLJuqqTMlO8R9LYUuKKM
   A==;
X-CSE-ConnectionGUID: 9dUBPLt9QjCQ8OUGXhHFpQ==
X-CSE-MsgGUID: ClZyCBFNS0eExOgfSPRpIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91663618"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="91663618"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:06:05 -0700
X-CSE-ConnectionGUID: 8QHjvZIzQBGgT3Id5Ya6qw==
X-CSE-MsgGUID: 9EjdGuSLT/yjnY5PbJN7YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="216676617"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:06:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:06:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:06:03 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqmkD5qfaDGaRdw3U7o6JdCA3jsW5aXwjRWFI+l2Nig6GOvM1VZ9Hs5TBYixzXXebAmeFhWgF8N/xyPs8ymdRw3PuA96I3aAmFiypxA02f3gmUkaF8UCKhPNlXsqyli4r57BRi0NRQYeDPybSIuMAfjuOHyfcxViLd3qsPX2OyMYgo3+4I1+2zEJG8sdVrcCxwcIQ7YdSqxNyJABcIyBRuHBXg6USasOWARVdO9X3g6bOGqwXonoLQ+0a2PlYDMGL8Wpb0OjbgWXr6wKu7yjP3CdavjDhrWtmb73hoTI5sAatjdyIaUrkVF3nfvmJYXBGX3qONRTuH9aljYX0jHdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9484YF+jBzykobR4J267TiXG61lZssDcnxYQ+NwyHw=;
 b=ggC20Vj+gpkRE7hery3qOzdI9hAOlo7w0hQsYqB7KKsOTo4MqpQqjEKamnpnbNIXbpwwFg7DGXsxomZVC/qKxkDO9DOHSJu9BEjOcUXqyaNUrkGKVhj22UWZMjPNJFNkxcLvCw1illh7c0p8D9IBs40xKXRzSLetiIekl59DzZu+AtU3w1FPZEjtlnGu3V+tUKjOJ5dbn7Xg548mlj0QaaFdRDyTAMFn9Zmf/wygNdBjEhjJVzJOn4oNa/AP56nS7dllp3k6SdPk9cMH1r9knNU+Dkv4eUCB/4tqsgAfAodqajXQH9fu9O0Y6KqiomaHUYzf5Ha65gGVwl/aSl7xgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 09:06:00 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:06:00 +0000
Message-ID: <c1446ebe-2e65-4676-8776-288b83a1fb92@intel.com>
Date: Wed, 11 Mar 2026 11:05:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] mmc: sdhci-esdhc-imx: remove duplicate HS400 bus
 width validation
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <Frank.Li@nxp.com>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
 <20260303105006.989339-4-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260303105006.989339-4-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0025.eurprd04.prod.outlook.com
 (2603:10a6:10:110::35) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 4494beff-97ac-40c1-4f2e-08de7f4d6a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mvMVhNTOvb/GwUN00WAQoIxwxl3kk+A5ruyurHmj+/SZ5UaozGAHYwWYDmAkmwW1oIOLjWo+kWi9Ms2WB2s6Y33qI5C2GDnAabNLCP0yrWzo5rSe2MoCN8getT/h6uK3xSHTktungVba4fRuKrD/4fnNiYHvqgPn2D+0gHsv9zfoKH+q/QUSV1m5XItWZVftXRg/535RrZjsQCMdXvshlqlvSU/5g/Ps6lMW2eoe5wtxD9yuCgat2R0jFLmrMvOtTJAfBBS1Fnw0JOxK2WqJOaIpmIYE1+GsrRXaxcDCUSgC6c8NiS7cLCAJJkUyY5tpjg2dWui3bC4Er9e9pJurikpRRVnddYYMejjFSUklf7AEMdSAMPncBxGGuNJXyxRpW2BYfrJCWPpvvy/mjuHbe0RNVEBSGV8CfJiuwm9rN7KCYY3IA1YDRs37dusSCTgi0XVh1E9siVUucpkT4sbYrFooNLOVX/HGFJSu61y8aS2V2VzPZtwLvSrvukfmUSxSDTvjF7imaarUTE7gK8wNK4Y9kFqN3YPMatbR0m2T6eEDB7nNNl5K1WwEcr4yy2sTXmf3EEEOMkjpcSLUd702mkwr8LOIHhAihAhgGwM+5XcXFTWbO0i5TQY+7Cwr27Gi4pTjRHOu5uNP5n1kLQKq4O2ML5L0ui4gHGhF99DqV449zd+MTTwjrUAXtvS+cXppRUt49CDWAK3DzP+SRby+NokpKHpEC2pJzmDk+ma1Nwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnR6ZmhhU2t1S3lqOWlFd0p2ZllYL0FWdXdheGVKNFk3TTUvVUJmTXdJTU4w?=
 =?utf-8?B?WUlwaldDU2FwdjZ5eEVVUUxFcFNyamFSdFdOdkhDdzVwWFgyalV3YTlFbjN5?=
 =?utf-8?B?a1ZqS3Nsb21UY0FXYnlWNEJPcFBsbmgvR1dYb3Q5WDZLSDNHYlYzZlVBMTVh?=
 =?utf-8?B?Z3N3UzVhVXFtbEdDUEdKRWJ2UUYzMlZDRHNBZFJHU093VGVCTmJxeWkrTlFw?=
 =?utf-8?B?Y2V1a3NDb0gvc3FDbHFIaFVvOUJqamUxZ3o5cHFvQVk1QTg1ZVJxNndTTGFt?=
 =?utf-8?B?ckc2NDRJbC9BOVgwallGREd1eVU5RWYxT3F5a2FyTUVoVjdtTVR2SllOMkhU?=
 =?utf-8?B?bEEwZFprQXVHNWFNbEdXK2pNdklHa213OGo1QjJRa3lmMFFSZjZ5c2Z3ZFVB?=
 =?utf-8?B?Z202TlhPNkdIR1UxMWQzT2ErTVFhcjFnMkdpMWlNVWE4RVl0TnBxR01QSEJt?=
 =?utf-8?B?bVFCZDNFVjhZYkZlRVgxNU1qL3NCWHdldkRkMXF0YUlNbDdOTktsdzlTSGRF?=
 =?utf-8?B?YytWRXlWNjlpVld4eHdtUWhVa3M3US81OHRHdjlSM2R0YVdKOE40OFJ3T1hm?=
 =?utf-8?B?RlBvbXU2NWlETEIzSnFRcnFjdXoxVGdEejVzZzQxV1BvQXBMUzNFYzIvOG5P?=
 =?utf-8?B?U3BqWUJESFM4bElHSmVvNStzMU9JaHBsdEN4YzlPRFZHL283TU9HcXlHUnM4?=
 =?utf-8?B?Mlpna0dBbEhBdjJiN0VMbWl0dXpNTTM2K3dwUzBFanRmS2xOQ2NyMC9jcWZJ?=
 =?utf-8?B?OWpSbUpCWG9hRS8vVk1raW9RREJ3azVsQk1yMHVPdXdGMFVjcy92NGhFdm03?=
 =?utf-8?B?MlJweUpUZXE1WGxsTFN1aHRKUWZHTmFreEM5WVU4S05yWVViUnY1SGlvT1Ix?=
 =?utf-8?B?NHJmK3VFdE85TnA0VC9hUWhRRURLbnVVUlFOT0l3bEZFTjRQV3FQdGlQY3B3?=
 =?utf-8?B?R1Z1a0t6MzlTR3Z0eHdpVHdnRk82UE9pUk9QVFJoZ2ZZNGpHMTFJK1Vwd3Fo?=
 =?utf-8?B?NkRRN2dWT205aWZ5K3FyMzBMdE9nd2dHYzlpNGdtR3hFdUpxVGd4bkxzQmhz?=
 =?utf-8?B?cFFzWGgyeENidHZ6TG92WHBFa0QxUUNNSHNLU1E0TkVtK2lKbTVjbHpXd0xQ?=
 =?utf-8?B?SnBEbGNJNXZCUCtNSTRWaGE3VGZsMzRKTDJZYWhXTmV6OUFUOTZ3VnluMkVj?=
 =?utf-8?B?NmhFTzdweHJlMFVmQjNoM3FEcGlNeWJwQ0RKWkk0b3NxMFAzRXlsaUZRclF4?=
 =?utf-8?B?dmJndEZRMUNKZjBQWU9VWGtROTFGakdzS1lRalJXQ09DNEFnYS9LdFFidnFC?=
 =?utf-8?B?RkpuWVpURTJsZzlJNzhKOW1lUjFDVnhUMWJBeU5ncWU3UGNFb1RQMFkrTVB1?=
 =?utf-8?B?TU5vYlg2bXVJTGFOaU5Ia0x2dmhJdEp5SnBhdVFiMlAraGJTYnlkbWE3eTdp?=
 =?utf-8?B?RE1ESmFnU1p3RTVmaGZjMHo2QW9qZWhQaHJ6Ry9FNkJJc1NPaGo5eDRyaGZ5?=
 =?utf-8?B?ZUlVMWIvT3RENExWTHZkb2p6RExoNTV5UmFDNTZnZ3BjMFRJbWE0b1IyWVRl?=
 =?utf-8?B?QUlKRWVyd3RUbmR4bVNlN1BBY1pkQW42Qi8rQ2Ewbzc3NEhqODJ2QmFuRFEy?=
 =?utf-8?B?eHY4bjhWU3cxNWpYOHNPZ0lOQTR5WStkVjlJdkVVN1ZvWVh1dXJHbW56WGhq?=
 =?utf-8?B?V3RMQUY0cnplVnpRK3BpaEgyQU1CSWdYV0tqOHVXeFNKdGRNNVpmY2hVdGpk?=
 =?utf-8?B?eXIzUTlmVkgxUEZwdCtlZEFZVEU3VW9JclVVb1JuMG9oR09TeDJ4MzVRYWRs?=
 =?utf-8?B?WjNxRGNsWUF3OG9GTG9ZOVlab1JxRnBuci9ORGlRdjFRWFRRYXNoeGl1R1Yw?=
 =?utf-8?B?Z3dsanNoUEZ1SVVoTkk4ZHlyOU9GY2dVSS9Nd29CYStUQmt2YmQwK3F6SXVX?=
 =?utf-8?B?T2JYbVBpcS9BcWF0MEFTZmVqTXJ1eHJrdm1VZ09uSll3ZWdzY3o5WXN5NEpr?=
 =?utf-8?B?Q1hhUjRjRmQ0b2I0S3YvZ05FdS96WkdXNTRlbUc5cHVadGk4OUxTK1ZYMm9M?=
 =?utf-8?B?Q1UyRm9UT0phUXYyaXlSVERxTHBmVmg1UkxNVjNLS1ZlWlQzTnR6dDkwa2RU?=
 =?utf-8?B?R090K0xCdCsrRGEyd1l2VFJyWjlqdHNKQjR5cnc4N1VpTTVnZGkybXNMZ1hm?=
 =?utf-8?B?Nzd0Qy9xN3VIRDZETG92RzE0bGczcHk2TS9lall5Nzd6SldRcU56d2FhRjFz?=
 =?utf-8?B?cStwaGtWQzc2SHVMM2JFQlQ2TXp5bE56eThQck05VHBLUEJyamdyS2NwcW9L?=
 =?utf-8?B?QW16VUd5R3JJUTl4eFU3LzRlVC9GSVJDeDV2cFRaMmt4ejMyTVNYd2lJT0Q0?=
 =?utf-8?Q?5UDqF0mTP09iPnGg=3D?=
X-Exchange-RoutingPolicyChecked: kH6kKat1lHvDH5yye3PUy0/c2/wes0xATinnIp8ikViKKjwHy58GtAB4N6BRZFs2WUz7CKQwwQ7B0u8xcsnnHFS/ifz2lG2MDSl99zlVoUCL3C8oM4yVNpCRvxsRDyUviiuChVVA4mBSYWMmqLhI5FyG5Sg1d9N4hdYstWnsd3RuQp41lzjn8fBolDrqdvjpAq6OlrlnanmMGe5FmnW8Jh/79veYkhwSGn+KDvkXJrHJKMIITV7UzQclYh6iOAtE1c6smDpfEoKkDdw6X9Qm7N6ZDEzkMkLnJTyO0BqeNLocLvxlz02DbwO/swBZwAD4jGNytyGEGHhjTefUwWxk+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4494beff-97ac-40c1-4f2e-08de7f4d6a32
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:06:00.7016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKevti1oNHF+a/LpIJoPnkiDuT+OE2PP5MOvurtNBnnnrdsgCYV0JZ5/soeyK9+fmbr2zCp5KU6Fu+LES0XfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com

On 03/03/2026 12:50, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> mmc_validate_host_caps() already validates that HS400/HS400ES requires
> 8-bit bus width. Remove the duplicate validation.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index b607d4ffc562..d49069986efc 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1833,10 +1833,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>  
>  	sdhci_get_property(pdev);
>  
> -	/* HS400/HS400ES require 8 bit bus */
> -	if (!(host->mmc->caps & MMC_CAP_8_BIT_DATA))
> -		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
> -
>  	if (mmc_gpio_get_cd(host->mmc) >= 0)
>  		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>  

