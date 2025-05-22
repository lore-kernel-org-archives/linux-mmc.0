Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68F22F77A;
	Thu, 22 May 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900131; cv=fail; b=nTSGq2k61qeIxaBvxndeOFdKvvwz2kGVhK2mKaN7DqzBy7j5kKphgxMoNpGt3iUyGJE4+TGDDTxLPjm0vFs7Rkweyu3hVjuN7xWhaLKwYW5/S9bTdKAVVEfRsH9FqT9jlgollB5den6ILw2sFJv5XEaiNTDUa/dcUwx8TBGY52U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900131; c=relaxed/simple;
	bh=axPVbOhYvdUG4KP/g8GtNw49KbUL9kBOLHYdnLkgEKI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pn/MaH/gHA9kJHWeaDSIIgRBxNmaOj9XGEav6n+mpVLSFE57x7lf52sYaMa40ObvIm+vQJxAkL2VgnGyB7lGCAWWiUsJEGzPPedRR9WW2YNJrzP3m9bXErpXyXLPvMaiVT4f7jVi/M/wArNfQRFw05Zqy+Od/guW+OYueMPY2L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAEpaklD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAEpaklD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747900125; x=1779436125;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=axPVbOhYvdUG4KP/g8GtNw49KbUL9kBOLHYdnLkgEKI=;
  b=eAEpaklDx3w3ouVmrMCvpx/3sjW1q+5oy1ahZ7jLvLuWPmnw1yPlJ6GC
   3kSkWTDHDetkRWEwCabuT352EkKLM2+BVGOcx6vx9RlTli1CzaoOlKK8b
   q2tBAmCf78PnPipG8o5302IVISQ85i6vGFmd+Hh2rGqmMzDWu+zJJxXTe
   PsxgGHreGdiyHC36w87qEGjv5zg3sUzmrAzGWh54QPxqcBHCUjYanhBai
   AcwSDEFnJaJTfM3jFcAhniXrYGXvZ/snQAuxT9BjhasKSSUFY4bWpeX7l
   kNnlvkoYIDXPf2LKE06Wg382Rrb05EJfFzb8J69rcJRQO0qnvXSXCdFrh
   w==;
X-CSE-ConnectionGUID: KetJlRFnSJGvqNo6IiY6kA==
X-CSE-MsgGUID: fsGgy//bT0eOiwDdIs/qLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="52536431"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="52536431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 00:48:42 -0700
X-CSE-ConnectionGUID: erHUEby3SBmcq7jMJ4rUZQ==
X-CSE-MsgGUID: RY8jC5kASDWlanQOh4szSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140541217"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 00:48:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 00:48:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 00:48:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 00:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJMobxZjJUIPI+mCUxHksbIw2ttq9gH/FxEZaG22YyNTukMuPfvrlu8f+oyZJHPL/v2W5o1nS2hfVlsI/jJOJeDcUcTUaqt32XywhmfStwJTHuIA8BtK0IXXY+Qc6eHRQjIFAEUxjRC1c4O/dIXf85u+rnLMvZ3MeQBN4mFyt6k828MMupufiOCBdkGjwPV9I7xTvwj8jQ3mprkNS53KgLFD7OWnqK1z1m3boJ3Vr0cLvjRKWdsdkCj1gru+BpTOGJSRGvSij7HnSCPLCLCagJb8tPEw7jPklzjNWxa6R9SEJR85jZIBT5L5kGcUqQ0eRgk1k5Iut/COqCl/u+pb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAmBSN9DddzZouJurkCKG2UU4Ceesy3aBFxhpfEiIng=;
 b=XEqx37bpnL9g4qiVV6DYN1Dc8Hf6HoTKNZFpNWQw9ZV156dgBjqShJ724dtHpDgFcMA8hB0ZkuKkuwHQiOkWc8x6hQhVVyWZ12pSbVdB4hem+7B8XdQ8AaxfnAv6klsFjrJmYFQi/LkIt3jy7ue4MTrujiQej3I5i8Z4C1JpfU7l1YGJbqkOrJ69rfynnHNZXHD0BmhaYyjVjozPkcdVSOo+SzZ3ZOFcguW6apjYo3yS3FV9OLMJeteEkxcHfJ5L6qExcdDLIeCUnAIecgkT0IW0GLO8T9JheRT3qEIcAOnWvErOt5k+2uLlZsjt1VvYjnw5vhkiy9khNVH9i9eJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by DM6PR11MB4532.namprd11.prod.outlook.com (2603:10b6:5:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 07:48:38 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%5]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 07:48:38 +0000
Message-ID: <7f71db22-c535-469a-8006-3eb2bfe712f7@intel.com>
Date: Thu, 22 May 2025 10:48:32 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] sdhci: eswin: Add eic7700 sdhci driver
To: <dongxuyang@eswincomputing.com>, <ulf.hansson@linaro.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
	<shanchun1218@gmail.com>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<xuxiang@eswincomputing.com>
References: <20250516091259.774-1-dongxuyang@eswincomputing.com>
 <20250516091727.887-1-dongxuyang@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250516091727.887-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2P250CA0012.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::17) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|DM6PR11MB4532:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3a35d5-ace3-4a97-2562-08dd99051035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1VFbmtXbU1kb0RSSHRRUGU5SXZicE15d0dib3BMcmFZMEo3cUY5MmhnU1pu?=
 =?utf-8?B?VWpZQ0dtRGdjT2VkSEVmR2xGVEM2c3I1T0xoTXphUzJmN3NBZnMreGdwdmJo?=
 =?utf-8?B?UTRKREpBa043Q1pDamJTMVFnRDlOU2tyc1h0RFdjbnlNUDFsZmh0aXdiUUpa?=
 =?utf-8?B?QzVRVEJEZFpycy9HekdiYTZqQXpiRmJZUDlRK1ZvM0Y1OGFlMFhUUVZEaGUy?=
 =?utf-8?B?Q0R3VXZpKzRxbnZFdW4zTlg3aUJMWW45VC9ORG52TFJ6NjNCNXVQU3czS09m?=
 =?utf-8?B?OWhSYkhjcTN1MncwSUJxRC9MaUFja0NuUVhOVUFnSHBmbVZYeDQvVG5OWDgv?=
 =?utf-8?B?WVpXek1xSitXdjA4TS9LdE1HWS9pd0w0V29QZTB5aUtoZ0hNL1kwbFY1UEFm?=
 =?utf-8?B?OVdxR0xpc1Yxb0k0bGxqbUErODBYeXU5KzVxVk03akpwVUJWdlRQNjB4aWVF?=
 =?utf-8?B?NzVJZzhaOUZzMk5TY2NJS2ZMazdubmVQVzk1RzBTaUZyTFllcFkyRHVpMTNl?=
 =?utf-8?B?UytZOFZjOFZOQjVNdUdlUi81WVU1am9mcW5KSUdPU01CZlM2anJzTTkxOUdx?=
 =?utf-8?B?ajZ6cytscEdlbjNRZG10b1hNT0wvM0dvaGpKd1I0RHFGcmUwdG1hSVc4MVcy?=
 =?utf-8?B?cWlBTkltV1FvdkhNdHVrdDJoanl6SnV6cUpPNnExQjdRYUVuZ0VOOVJsVEd4?=
 =?utf-8?B?WkJmSFgxODlMQ1c0VjJwTmtOMjc0MTljWG1xWitwNFJFV0xYTmJaMHdlQmdT?=
 =?utf-8?B?djZCVjdFa2tiN0pmeEgrYUIyM3hzcExwaTdMMk00aWpydG5wZndrd0luNWtF?=
 =?utf-8?B?WlFEeDMvSGZGeHk3V3FvUG5FWVdydnVkc0xKd0FlWEZIL2YraUlRM2V2R09y?=
 =?utf-8?B?Z3EydW0yYzh4L0oxTHFhK3Q2Ym93d2krcEJEMDFXdElFRldkYU1YUldPK0Fy?=
 =?utf-8?B?SjZqeWpKTDlkeWJ2dGdjUEg0dHlXL096STE2M3c2aVRib1JxRkFXWGV3aGtP?=
 =?utf-8?B?NktwektYNi92OGJsOXp6TjAySnFiY0lpZHZLbjFXNXlpdkZNZnV6QmNrNElz?=
 =?utf-8?B?VlRIZzB6ZE9PZmR1aHRreG9YcXFCYjlHQVV3UStlREk2eGFtT1FpY1RtZ25H?=
 =?utf-8?B?cG9mWCtXR1EzNlR4dDh3S1FsNEU1a242KytWMFd0VEh6eXFGQWMxZUFPWi93?=
 =?utf-8?B?a0RjOEg2Rnh1cXNQUWIzaVVMTXJhMWhtM1F0OVhIdDZoQ1ZGd3FXcXF6allr?=
 =?utf-8?B?UEU0akVvWVRhY3g5TjJDRUczNXR0TTVmUzFiTk1ETUpqZis3UDE0MWM2LzZT?=
 =?utf-8?B?ejZBYlM3bGpxVlc5Skx4YithbG0zZGFaNUNVcTd2d1o2UGtpNnJ4RERjOHgw?=
 =?utf-8?B?NnBOMkdCTjhWc1Z3NjRlcmZ6VGx6TzFIYnNpT3RmTnZOSnRWTm9DSmx3M2Iv?=
 =?utf-8?B?Y3NTMFJ4S0ZORU5Db3c0SytNMVUvUm54MXpsV2RaQXpqRHBycmIyd3VMdmFa?=
 =?utf-8?B?VXJQSEswckdmMHVpT0FWa2d2STJlR0x1TG9WVVdDUHZYdFpqL1hYaFBSMFlV?=
 =?utf-8?B?TWZQdjZTbDlJOW1LaHRaSzZqdUxNOGtieWFRcjNzNXh5blljMG52ZWJ1L29q?=
 =?utf-8?B?cFBQMlVTUDJJVnNhbmk3Unhnbk9jUy9pd2ZYM2NNSkFxMW16OWFCVUFmMmx4?=
 =?utf-8?B?SkpaVWR3WVpyRWRuY205U3FBRWFqOFlxSEU3R2Vkd0RhZ01jc0ZJUFM3Tnd5?=
 =?utf-8?B?TU1WeGhYZFNOa21jT25mWGlrSitqYXY5ZDlGUDRPTGpKYlNFdlB1N3BvQ1dj?=
 =?utf-8?B?dUEySHlwRnBrOEdTU1Q4WVdseEMycmdGdmVIZnJ3cUFMTkFKZ1NYNXFGOVMy?=
 =?utf-8?B?d0g5MWZKeFhNcHd3Z0IrM1RVMGdRbXdOdFE1TjRWMG1kZjZuR05rLzNDaVVv?=
 =?utf-8?B?YTAxYkhBZlNlQ3JKL0NWMVdYZlJPT3FDQnU1QXl3aGZFSzgwUDlFbUtHUlZN?=
 =?utf-8?B?dGYvVm5nRzd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjZmNnJzV2RRZU5pYjBkbThpNUZhVDE1ZWxwMWlIZE9yZEZUQ3hsN0VlaWly?=
 =?utf-8?B?bzFFSUVseG93MVVxTmttSEFIcmZja1VDN1NWUDBsblpOZUUzVnNYS1lYL3ZG?=
 =?utf-8?B?aWJwZElreWNKd1BhdlZKeGhoM0UvZUlWUmk3VmsyTSt5UUZ1V2pzOGZJWHFi?=
 =?utf-8?B?NXlieXphZExEZlZoMUFyUEJ5cVo1Ti9mUktxQzFYdjRSTnh5MTd0aGNRR3Vk?=
 =?utf-8?B?M1prVHh0SEsreVdyU0Z2TnZHMTJPa0JtU29wemhMTERQUzNPZmg4SmlaZ2hO?=
 =?utf-8?B?OUxoSTlLZWFnMmF3ZjRmSG1GVk9mYnB0TkNlK2IxZWoyR1I0d3ZtRmp3Z3hW?=
 =?utf-8?B?aTNOYTBqK09Ydmp3Qk1mcXFMbXdKRUNISEExS1hRcHppUnhaazdmZ0ZONEZi?=
 =?utf-8?B?enZCeTBXWjNPRXp3NmNIbkV3RUI5NXpFUnpPc0N4d0RncHlJMUVYM3o3dnVs?=
 =?utf-8?B?UGtreUhhSFQ1cFpXbm1icnVna2RMWWExd2krMDdrNkRZRHcwcWcrTWQrS0pz?=
 =?utf-8?B?RjczaWpNalBheCt0TzV1SjhZckg4anpYQkdxdWhiM1Q4ZmJMd3U5UVF3QkM4?=
 =?utf-8?B?QnZPM3lKK3l0cVFNSTJvMnZqZzZDc3JxaWIwOHdmeTZwckt3eXlnZFR3K1NL?=
 =?utf-8?B?WDU4dlFUVG8rMXZLQWlBeVFRbjJUM1pLbDhLbTZSUjdGbmpCQVF0bThOeDlD?=
 =?utf-8?B?ZEtlMmh2N21kMU5jT2NOV2JnZE9yMWtCTzc1S0ZBWjg2dHdaUThkNER4RUhp?=
 =?utf-8?B?bUt0WUxMNHBFUDFTNmh0bThiNDZLTUtDRnZzVVVla0tWb3RQZW5jOFhwdkQv?=
 =?utf-8?B?cW80R0NHNUM3a0hnaUJuWUV2OXFuTHYyUWZ2MUZBYkwwNUNkT0VkK1NEYjRk?=
 =?utf-8?B?Z2xkaGZQSVNQanF2VitnQVVxYXliYys0MktoYzVZUnY0ay9LQ2FKckNQNUZM?=
 =?utf-8?B?OHNDSEQ5NkVrSUpXdGRGN0NDYWVVaUk1Ymg0VTUva3JJNExXQnFVL2huT2RY?=
 =?utf-8?B?UmZ1bmNTRjVBZXdmazlud1hxK2NYRlg2VjRKN1lFamFhSXM2b1dIZ0RXUWh4?=
 =?utf-8?B?WGhSSk83QUZySUxWS0NKd2M4SU1PLy96UXduRHdrNUROanBVVTNtZTBaaDZ4?=
 =?utf-8?B?ejVQVFgwZ0d2U2pLcUpvSHd3bDZ0R092VlBXRndxZmlxZ1RKSTZOeTdZWG9k?=
 =?utf-8?B?K2lzT2I0M2llL2U0SlVSbzcrRFhlWWhGUUVYN0dPaUdJQi9QenhBTE5DbHUw?=
 =?utf-8?B?UTlmR2I5eStvdDBNWFE2blpmMHlxbHFLWk1IUVRMUmQ0dVloTkhvUWlpd1ll?=
 =?utf-8?B?dmxnTVp1WjM0bWhYR1JMbmlkTDYwc1dOcEh0WCtmRURqa3NyNDl2M0FJRXU0?=
 =?utf-8?B?SEFuMDk3VXpWalZJK25LaEhJV3d6YUgrNWFHTXNZUEE0VEpNWG9obUFLaFpC?=
 =?utf-8?B?N3FGUVhIQnNjZlcxdXA2S3dUYmxWbFFvOHhHbFdBaDFFTlk0ZjZ5Q3J4VFhI?=
 =?utf-8?B?eGc5ZkcvSHRPWDNrbWd3YWxhcXlPUTc4QmFVV1NLbTI1R0RRQ1RhY291TTRL?=
 =?utf-8?B?c3JFOHB6VnAwajU4YVVxTWRZVFZZd1pCM0hHRkxwMlVHM3J6bng3OHhKSDg0?=
 =?utf-8?B?cU4wUWRFeXBOWExyNXlyS01FWTdPMFljb1N5OUNUZlVkN2wzTkRkMkdUcE1o?=
 =?utf-8?B?K2hvaXQzNWxaeE80d1AxWXNrNFNkSnl2RXBXMG9nRU42NUpRbXVoRjViMDBn?=
 =?utf-8?B?Wnp5M2Z4K2JjQ0ZzT1k5NjNmeVhMZi9PYlZHUWF6ZmszZXNqUXZpL1F1cWRn?=
 =?utf-8?B?SUdjSk0rT2ZBUnJvaHRJdmlFZ3g0OUVsYVZRdS93Zit1SENXOHlvQ0tnT2Rs?=
 =?utf-8?B?alc2bjNJZUJ3Qkt5UHp1SndEeGxSejMxY3BKckRKU2F4OG12ZDk5bWZPVlBp?=
 =?utf-8?B?WFV2MURzMFZrc3BJWEJUMTgvN1B5cHEvL2RpRFhlWDk1ckw3M0NUTGx0ZGRh?=
 =?utf-8?B?dW9wQzlIcXJoaFNkZE50T3FNZVQzSG9FQ29CQ29BK3M5aGZTRkVnZFp1Um1N?=
 =?utf-8?B?NzlmZ3haZ1BhK3RZbVNTUGVXeHFma2k5V2VVUlE3ellFUlljNFMvYzloaGdJ?=
 =?utf-8?B?U0c3aStuUzFKQkVuK3UzNGU4WDVqRldxV1BUMXE1aUVBaDg4cUI3VW5QMVVn?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3a35d5-ace3-4a97-2562-08dd99051035
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:48:38.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfbhY/MlhJ1hLVsUOIZjFIx7hcOpuywWCEdCcl109sxG4CJUQe37W4X8aXt87lp4JJXlGIqQd0zYdSoLGB6PVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4532
X-OriginatorOrg: intel.com

On 16/05/2025 12:17, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> Add support for sdhci controller in eic7700 series chips.
> Provide functionality of sdhci-emmc and sdhci-sdio on the chip.
> 
> Signed-off-by: Xiang Xu <xuxiang@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  drivers/mmc/host/Kconfig                 |   47 +
>  drivers/mmc/host/Makefile                |    4 +-
>  drivers/mmc/host/sdhci-eic7700.c         |  353 ++++++++
>  drivers/mmc/host/sdhci-eic7700.h         |  237 +++++
>  drivers/mmc/host/sdhci-of-eic7700-sdio.c |  991 ++++++++++++++++++++
>  drivers/mmc/host/sdhci-of-eic7700.c      | 1053 ++++++++++++++++++++++
>  6 files changed, 2685 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-eic7700.c
>  create mode 100644 drivers/mmc/host/sdhci-eic7700.h
>  create mode 100644 drivers/mmc/host/sdhci-of-eic7700-sdio.c
>  create mode 100644 drivers/mmc/host/sdhci-of-eic7700.c

Thanks for sending your driver.  The code is neat but doesn't
follow kernel expectations in a few ways.

Please aim for simplicity.  For example,
why not one C file (1 module) and no .h file?

I haven't looked closely but there are a few comments below,
and plenty to work on.

> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 264e11fa58ea..c1be4b6e1411 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -160,6 +160,53 @@ config MMC_SDHCI_PLTFM
>  
>  	  If unsure, say N.
>  
> +config MMC_EIC7700
> +	tristate "support for the EIC7700 controllers"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	depends on COMMON_CLK
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	select MMC_CQHCI
> +	help
> +	  This selects the EIC7700 Secure Digital Host Controller Interface
> +	  (SDHCI).
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
> +config MMC_SDHCI_OF_EIC7700
> +	tristate "SDHCI OF support for the EIC7700 SDHCI controllers"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	depends on COMMON_CLK
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	depends on MMC_EIC7700
> +	select MMC_CQHCI
> +	help
> +	  This selects the EIC7700 Secure Digital Host Controller Interface
> +	  (SDHCI).
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +
> +config MMC_SDHCI_OF_SDIO_EIC7700
> +	tristate "SDHCI OF SDIO support for the EIC7700 SDHCI controllers"
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	depends on COMMON_CLK
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	depends on MMC_EIC7700
> +	select MMC_CQHCI
> +	help
> +	 This selects the EIC7700 Secure Digital Host Controller Interface
> +	 (SDHCI-SDIO).
> +
> +	 If you have a controller with this interface, say Y or M here.
> +
> +	 If unsure, say N.
> +
>  config MMC_SDHCI_OF_ARASAN
>  	tristate "SDHCI OF support for the Arasan SDHCI controllers"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 5147467ec825..4ba3962f90b8 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -105,7 +105,9 @@ cqhci-y					+= cqhci-core.o
>  cqhci-$(CONFIG_MMC_CRYPTO)		+= cqhci-crypto.o
>  obj-$(CONFIG_MMC_HSQ)			+= mmc_hsq.o
>  obj-$(CONFIG_MMC_LITEX)			+= litex_mmc.o
> -
> +obj-$(CONFIG_MMC_EIC7700)                 += sdhci-eic7700.o
> +obj-$(CONFIG_MMC_SDHCI_OF_EIC7700)        += sdhci-of-eic7700.o
> +obj-$(CONFIG_MMC_SDHCI_OF_SDIO_EIC7700)   += sdhci-of-eic7700-sdio.o
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+= -DDEBUG
>  endif
> diff --git a/drivers/mmc/host/sdhci-eic7700.c b/drivers/mmc/host/sdhci-eic7700.c
> new file mode 100644
> index 000000000000..84a7a1186b90
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-eic7700.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN Emmc Driver
> + *
> + * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd.. All rights reserved.
> + *
> + * Authors:
> + *	Shuang Liang <liangshuang@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +#include "sdhci-eic7700.h"
> +#include <linux/delay.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +static void eswin_mshc_coreclk_config(struct sdhci_host *host, uint16_t divisor,
> +				      unsigned int flag_sel)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct eswin_sdhci_data *eswin_sdhci;
> +	u32 val = 0;
> +	u32 delay = 0xfffff;
> +
> +	pltfm_host = sdhci_priv(host);
> +	eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +
> +	regmap_read(eswin_sdhci->crg_regmap, eswin_sdhci->crg_core_clk, &val);
> +	val &= ~MSHC_CORE_CLK_ENABLE;
> +	regmap_write(eswin_sdhci->crg_regmap, eswin_sdhci->crg_core_clk, val);
> +	while (delay--)
> +		;

Please use a kernel delay/sleep function

> +	val &= ~(MSHC_CORE_CLK_FREQ_BIT_MASK << MSHC_CORE_CLK_FREQ_BIT_SHIFT);
> +	val |= (divisor & MSHC_CORE_CLK_FREQ_BIT_MASK)
> +	       << MSHC_CORE_CLK_FREQ_BIT_SHIFT;
> +	val &= ~(MSHC_CORE_CLK_SEL_BIT);
> +	val |= flag_sel;
> +	regmap_write(eswin_sdhci->crg_regmap, eswin_sdhci->crg_core_clk, val);
> +
> +	udelay(100);

100 is generally considered too long for udelay.
usleep_range() is better

> +	val |= MSHC_CORE_CLK_ENABLE;
> +	regmap_write(eswin_sdhci->crg_regmap, eswin_sdhci->crg_core_clk, val);
> +	mdelay(1);

Prefer usleep_range() to mdelay

> +}
> +
> +static void eswin_mshc_coreclk_disable(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct eswin_sdhci_data *eswin_sdhci;
> +	u32 val = 0;
> +
> +	pltfm_host = sdhci_priv(host);
> +	eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +
> +	regmap_read(eswin_sdhci->crg_regmap, eswin_sdhci->crg_core_clk, &val);
> +	val &= ~MSHC_CORE_CLK_ENABLE;
> +	regmap_write(eswin_sdhci->crg_regmap, eswin_sdhci->crg_core_clk, val);
> +}
> +
> +void eswin_sdhci_disable_card_clk(struct sdhci_host *host)

sdhci drivers tend to do the naming convention the other way around
e.g. sdhci_eswin_disable_card_clk
or SDHCI_ESWIN_...

> +{
> +	unsigned int clk;
> +
> +	/* Reset SD Clock Enable */
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +void eswin_sdhci_enable_card_clk(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	unsigned int clk;
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	/* Wait max 150 ms */
> +	timeout = ktime_add_ms(ktime_get(), 150);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		if (clk & SDHCI_CLOCK_INT_STABLE)
> +			break;
> +		if (timedout) {
> +			pr_err("%s: Internal clock never stabilised.\n",
> +			       mmc_hostname(host->mmc));
> +			return;
> +		}
> +		udelay(10);
> +	}
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +	mdelay(1);
> +}
> +
> +void eswin_sdhci_set_core_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	unsigned int div, divide;
> +	unsigned int flag_sel, max_clk;
> +
> +	host->mmc->actual_clock = clock;
> +
> +	if (clock == 0) {
> +		eswin_mshc_coreclk_disable(host);
> +		return;
> +	}
> +
> +	if (SDHCI_CLK_208M % clock == 0) {
> +		flag_sel = 1;
> +		max_clk = SDHCI_CLK_208M;
> +	} else {
> +		flag_sel = 0;
> +		max_clk = SDHCI_CLK_200M;
> +	}
> +
> +	for (div = 1; div <= MAX_CORE_CLK_DIV; div++) {
> +		if ((max_clk / div) <= clock)
> +			break;
> +	}
> +	div--;
> +
> +	if (div == 0 || div == 1)
> +		divide = 2;
> +	else
> +		divide = (div + 1) * 2;
> +
> +	pr_debug("%s: clock:%d timing:%d\n", mmc_hostname(host->mmc), clock,
> +		 host->timing);
> +
> +	eswin_sdhci_disable_card_clk(host);
> +	eswin_mshc_coreclk_config(host, divide, flag_sel);
> +	eswin_sdhci_enable_card_clk(host);
> +	mdelay(2);
> +}
> +
> +static void eswin_sdhci_set_clk_delays(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	struct eswin_sdhci_clk_data *clk_data = &eswin_sdhci->clk_data;
> +
> +	clk_set_phase(clk_data->sampleclk,
> +		      clk_data->clk_phase_in[host->timing]);
> +	clk_set_phase(clk_data->sdcardclk,
> +		      clk_data->clk_phase_out[host->timing]);
> +}
> +
> +static void eswin_sdhci_dt_read_clk_phase(struct device *dev,
> +					  struct eswin_sdhci_clk_data *clk_data,
> +					  unsigned int timing, const char *prop)
> +{
> +	struct device_node *np = dev->of_node;
> +
> +	int clk_phase[2] = {0};
> +
> +	/*
> +	 * Read Tap Delay values from DT, if the DT does not contain the
> +	 * Tap Values then use the pre-defined values.
> +	 */
> +	if (of_property_read_variable_u32_array(np, prop, &clk_phase[0], 2,
> +						0)) {
> +		dev_dbg(dev, "Using predefined clock phase for %s = %d %d\n",
> +			prop, clk_data->clk_phase_in[timing],
> +			clk_data->clk_phase_out[timing]);
> +		return;
> +	}
> +
> +	/* The values read are Input and Output Clock Delays in order */
> +	clk_data->clk_phase_in[timing] = clk_phase[0];
> +	clk_data->clk_phase_out[timing] = clk_phase[1];
> +}
> +
> +/**
> + * eswin_sdhci_dt_parse_clk_phases - Read Clock Delay values from DT
> + *
> + * @dev:        Pointer to our struct device.
> + * @clk_data:       Pointer to the Clock Data structure
> + *
> + * Called at initialization to parse the values of Clock Delays.
> + */
> +void eswin_sdhci_dt_parse_clk_phases(struct device *dev,
> +				     struct eswin_sdhci_clk_data *clk_data)
> +{
> +	clk_data->set_clk_delays = eswin_sdhci_set_clk_delays;
> +
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
> +				      "clk-phase-legacy");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
> +				      "clk-phase-mmc-hs");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_SD_HS,
> +				      "clk-phase-sd-hs");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR12,
> +				      "clk-phase-uhs-sdr12");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR25,
> +				      "clk-phase-uhs-sdr25");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR50,
> +				      "clk-phase-uhs-sdr50");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR104,
> +				      "clk-phase-uhs-sdr104");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_DDR50,
> +				      "clk-phase-uhs-ddr50");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_DDR52,
> +				      "clk-phase-mmc-ddr52");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS200,
> +				      "clk-phase-mmc-hs200");
> +	eswin_sdhci_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS400,
> +				      "clk-phase-mmc-hs400");
> +}
> +
> +unsigned int eswin_convert_drive_impedance_ohm(struct platform_device *pdev,
> +					       unsigned int dr_ohm)
> +{
> +	switch (dr_ohm) {
> +	case 100:
> +		return PHYCTRL_DR_100OHM;
> +	case 66:
> +		return PHYCTRL_DR_66OHM;
> +	case 50:
> +		return PHYCTRL_DR_50OHM;
> +	case 40:
> +		return PHYCTRL_DR_40OHM;
> +	case 33:
> +		return PHYCTRL_DR_33OHM;
> +	}
> +
> +	dev_warn(&pdev->dev, "Invalid value %u for drive-impedance-ohm.\n",
> +		 dr_ohm);
> +	return PHYCTRL_DR_50OHM;
> +}
> +
> +static void eswin_sdhci_do_reset(struct eswin_sdhci_data *eswin_sdhci)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(eswin_sdhci->txrx_rst);
> +	WARN_ON(ret != 0);
> +	ret = reset_control_assert(eswin_sdhci->phy_rst);
> +	WARN_ON(ret != 0);
> +	ret = reset_control_assert(eswin_sdhci->prstn);
> +	WARN_ON(ret != 0);
> +	ret = reset_control_assert(eswin_sdhci->arstn);
> +	WARN_ON(ret != 0);
> +
> +	mdelay(2);
> +
> +	ret = reset_control_deassert(eswin_sdhci->txrx_rst);
> +	WARN_ON(ret != 0);
> +	ret = reset_control_deassert(eswin_sdhci->phy_rst);
> +	WARN_ON(ret != 0);
> +	ret = reset_control_deassert(eswin_sdhci->prstn);
> +	WARN_ON(ret != 0);
> +	ret = reset_control_deassert(eswin_sdhci->arstn);
> +	WARN_ON(ret != 0);

Really need to report only 1 error for this function.  pr_err()
is more appropriate than WARN_ON() for device errors.

> +}
> +
> +int eswin_sdhci_reset_init(struct device *dev,
> +			   struct eswin_sdhci_data *eswin_sdhci)
> +{
> +	int ret = 0;
> +
> +	eswin_sdhci->txrx_rst =
> +		devm_reset_control_get_optional(dev, "txrx_rst");
> +	if (IS_ERR_OR_NULL(eswin_sdhci->txrx_rst)) {
> +		dev_err_probe(dev, PTR_ERR(eswin_sdhci->txrx_rst),
> +			      "txrx_rst reset not found.\n");
> +		return -EFAULT;
> +	}
> +
> +	eswin_sdhci->phy_rst = devm_reset_control_get_optional(dev, "phy_rst");
> +	if (IS_ERR_OR_NULL(eswin_sdhci->phy_rst)) {
> +		dev_err_probe(dev, PTR_ERR(eswin_sdhci->phy_rst),
> +			      "phy_rst reset not found.\n");
> +		return -EFAULT;
> +	}
> +
> +	eswin_sdhci->prstn = devm_reset_control_get_optional(dev, "prstn");
> +	if (IS_ERR_OR_NULL(eswin_sdhci->prstn)) {
> +		dev_err_probe(dev, PTR_ERR(eswin_sdhci->prstn),
> +			      "prstn reset not found.\n");
> +		return -EFAULT;
> +	}
> +
> +	eswin_sdhci->arstn = devm_reset_control_get_optional(dev, "arstn");
> +	if (IS_ERR_OR_NULL(eswin_sdhci->arstn)) {
> +		dev_err_probe(dev, PTR_ERR(eswin_sdhci->arstn),
> +			      "arstn reset not found.\n");
> +		return -EFAULT;
> +	}
> +	eswin_sdhci_do_reset(eswin_sdhci);
> +
> +	return ret;
> +}
> +
> +#define DRIVER_NAME "sdhci_esw"
> +#define SDHCI_ESW_DUMP(f, x...)                                                \
> +	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ##x)

Older code does this kind of thing, but it can be done with pr_fmt()
instead

> +
> +void eswin_sdhci_dump_vendor_regs(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +	u32 val = 0, val1 = 0;
> +
> +	SDHCI_ESW_DUMP("----------- VENDOR REGISTER DUMP -----------\n");
> +
> +	ret = regmap_read(eswin_sdhci->crg_regmap, eswin_sdhci->crg_core_clk,
> +			  &val);
> +	if (ret) {
> +		pr_err("%s: read crg_core_clk failed, ret:%d\n",
> +		       mmc_hostname(host->mmc), ret);
> +		return;
> +	}
> +
> +	SDHCI_ESW_DUMP("CORE CLK: 0x%08x | IRQ FLAG:  0x%016lx\n", val,
> +		       arch_local_save_flags());
> +
> +	ret = regmap_read(eswin_sdhci->crg_regmap, eswin_sdhci->crg_aclk_ctrl,
> +			  &val);
> +	if (ret) {
> +		pr_err("%s: read crg_aclk_ctrl failed, ret:%d\n",
> +		       mmc_hostname(host->mmc), ret);
> +		return;
> +	}
> +	ret = regmap_read(eswin_sdhci->crg_regmap, eswin_sdhci->crg_cfg_ctrl,
> +			  &val1);
> +	if (ret) {
> +		pr_err("%s: read crg_cfg_ctrl failed, ret:%d\n",
> +		       mmc_hostname(host->mmc), ret);
> +		return;
> +	}
> +	SDHCI_ESW_DUMP("HSP ACLK: 0x%08x | HSP CFG:  0x%08x\n", val, val1);
> +
> +	ret = regmap_read(eswin_sdhci->hsp_regmap, eswin_sdhci->hsp_int_status,
> +			  &val);
> +	if (ret) {
> +		pr_err("%s: read hsp_int_status failed, ret:%d\n",
> +		       mmc_hostname(host->mmc), ret);
> +		return;
> +	}
> +	ret = regmap_read(eswin_sdhci->hsp_regmap, eswin_sdhci->hsp_pwr_ctrl,
> +			  &val1);
> +	if (ret) {
> +		pr_err("%s: read hsp_pwr_ctrl failed, ret:%d\n",
> +		       mmc_hostname(host->mmc), ret);
> +		return;
> +	}
> +	SDHCI_ESW_DUMP("HSP STA: 0x%08x | PWR CTRL:  0x%08x\n", val, val1);
> +}
> diff --git a/drivers/mmc/host/sdhci-eic7700.h b/drivers/mmc/host/sdhci-eic7700.h
> new file mode 100644
> index 000000000000..4e6f4ac8e7ff
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-eic7700.h
> @@ -0,0 +1,237 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * ESWIN SDHCI Driver
> + *
> + * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd.. All rights reserved.
> + *
> + * Authors:
> + *	Shuang Liang <liangshuang@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +#ifndef _DRIVERS_MMC_SDHCI_ESWIN_H
> +#define _DRIVERS_MMC_SDHCI_ESWIN_H
> +
> +#include "sdhci-pltfm.h"
> +#include <linux/clk-provider.h>
> +#include <linux/reset.h>
> +
> +#define MSHC_CARD_CLK_STABLE BIT(28)
> +#define MSHC_INT_BCLK_STABLE BIT(16)
> +#define MSHC_INT_ACLK_STABLE BIT(8)
> +#define MSHC_INT_TMCLK_STABLE BIT(0)
> +#define MSHC_INT_CLK_STABLE                                                    \
> +	(MSHC_CARD_CLK_STABLE | MSHC_INT_ACLK_STABLE | MSHC_INT_BCLK_STABLE |  \
> +	 MSHC_INT_TMCLK_STABLE)
> +#define MSHC_HOST_VAL_STABLE BIT(0)
> +#define EMMC0_CARD_DETECT BIT(9)
> +#define EMMC0_CARD_WRITE_PROT BIT(8)
> +
> +#define MSHC_CORE_CLK_ENABLE BIT(16)
> +#define MSHC_CORE_CLK_FREQ_BIT_SHIFT 4
> +#define MSHC_CORE_CLK_FREQ_BIT_MASK 0xfffu
> +#define MSHC_CORE_CLK_SEL_BIT BIT(0)
> +
> +/* Controller does not have CD wired and will not function normally without */
> +#define SDHCI_ESWIN_QUIRK_FORCE_CDTEST BIT(0)
> +/* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
> + * internal clock even when the clock isn't stable
> + */
> +#define SDHCI_ESWIN_QUIRK_CLOCK_UNSTABLE BIT(1)
> +
> +#define ESWIN_SDHCI_CTRL_HS400                                                 \
> +	0x0007 // Non-standard, for eswin,these bits are 0x7

Can wrap at 100 cols, and for sdhci vendor drivers, I prefer /* */ to //

#define ESWIN_SDHCI_CTRL_HS400	0x0007 /* Non-standard, for eswin, these bits are 0x7 */

> +
> +#define SDHCI_CLK_208M 208000000
> +#define SDHCI_CLK_200M 200000000

These names don't describe the meaning.  Might just as
well use constants e.g. 208 * HZ_PER_MHZ

Also, by itself, the SDHCI_ prefix really belongs to sdhci module.
So SDHCI_ESWIN_ is better

> +
> +#define AWSMMUSID GENMASK(31, 24)  // The sid of write operation
> +#define AWSMMUSSID GENMASK(23, 16) // The ssid of write operation
> +#define ARSMMUSID GENMASK(15, 8)   // The sid of read operation
> +#define ARSMMUSSID GENMASK(7, 0)   // The ssid of read operation

Try to line up everything up

#define ARSMMUSSID		GENMASK(7, 0)   /* The ssid of read operation */

#define DWC_MSHC_PTR_PHY_R	0x300
#define PHY_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x00)
#define PHY_CMDPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x04)

> +
> +/* DWC_mshc_map/DWC_mshc_phy_block register */

If this is based on DWCMSHC, did you consider using sdhci-of-dwcmshc.c?

> +#define DWC_MSHC_PTR_PHY_R 0x300
> +#define PHY_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x00)
> +#define PHY_CMDPAD_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x04)
> +#define PHY_DATAPAD_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x06)
> +#define PHY_CLKPAD_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x08)
> +#define PHY_STBPAD_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x0a)
> +#define PHY_RSTNPAD_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x0c)
> +#define PHY_PADTEST_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x0e)
> +#define PHY_PADTEST_OUT_R (DWC_MSHC_PTR_PHY_R + 0x10)
> +#define PHY_PADTEST_IN_R (DWC_MSHC_PTR_PHY_R + 0x12)
> +#define PHY_PRBS_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x18)
> +#define PHY_PHYLBK_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x1a)
> +#define PHY_COMMDL_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x1c)
> +#define PHY_SDCLKDL_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x1d)
> +#define PHY_SDCLKDL_DC_R (DWC_MSHC_PTR_PHY_R + 0x1e)
> +#define PHY_SMPLDL_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x20)
> +#define PHY_ATDL_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x21)
> +#define PHY_DLL_CTRL_R (DWC_MSHC_PTR_PHY_R + 0x24)
> +#define PHY_DLL_CNFG1_R (DWC_MSHC_PTR_PHY_R + 0x25)
> +#define PHY_DLL_CNFG2_R (DWC_MSHC_PTR_PHY_R + 0x26)
> +#define PHY_DLLDL_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x28)
> +#define PHY_DLL_OFFST_R (DWC_MSHC_PTR_PHY_R + 0x29)
> +#define PHY_DLLMST_TSTDC_R (DWC_MSHC_PTR_PHY_R + 0x2a)
> +#define PHY_DLLBT_CNFG_R (DWC_MSHC_PTR_PHY_R + 0x2c)
> +#define PHY_DLL_STATUS_R (DWC_MSHC_PTR_PHY_R + 0x2e)
> +#define PHY_DLLDBG_MLKDC_R (DWC_MSHC_PTR_PHY_R + 0x30)
> +#define PHY_DLLDBG_SLKDC_R (DWC_MSHC_PTR_PHY_R + 0x32)
> +
> +#define ENABLE 1
> +#define DISABLE 0

Don't use macros for this - just use 1 and 0

> +/* strength definition */
> +#define PHYCTRL_DR_33OHM 0xee
> +#define PHYCTRL_DR_40OHM 0xcc
> +#define PHYCTRL_DR_50OHM 0x88
> +#define PHYCTRL_DR_66OHM 0x44
> +#define PHYCTRL_DR_100OHM 0x00
> +
> +#define PHY_PAD_MAX_DRIVE_STRENGTH 0xf
> +#define PHY_CLK_MAX_DELAY_MASK 0x7f
> +#define PHY_PAD_SP_DRIVE_SHIF 16
> +#define PHY_PAD_SN_DRIVE_SHIF 20
> +
> +#define PHY_RSTN BIT(0)
> +#define PHY_UPDATE_DELAY_CODE BIT(4)
> +
> +#define VENDOR_EMMC_CTRL_R 0x52c
> +#define EMMC_CRAD_PRESENT BIT(0)
> +#define EMMC_RST_N_OE BIT(3)
> +#define EMMC_RST_N BIT(2)

Arguably EMMC_ names belong to mmc core.
Just prefix with ESWIN_

> +
> +#define PHY_SLEW_0 0x0
> +#define PHY_SLEW_1 0x1
> +#define PHY_SLEW_2 0x2
> +#define PHY_SLEW_3 0x3
> +#define PHY_TX_SLEW_CTRL_P_BIT_SHIFT 5
> +#define PHY_TX_SLEW_CTRL_N_BIT_SHIFT 9
> +
> +#define PHY_PULL_BIT_SHIF 0x3
> +#define PHY_PULL_DISABLED 0x0
> +#define PHY_PULL_UP 0x1
> +#define PHY_PULL_DOWN 0x2
> +#define PHY_PULL_MASK 0x3
> +
> +#define PHY_PAD_RXSEL_0 0x0
> +#define PHY_PAD_RXSEL_1 0x1
> +
> +#define VENDOR_AT_CTRL_R 0x540
> +#define LATENCY_LT_BIT_OFFSET 19
> +#define LATENCY_LT_MASK 0x3
> +
> +#define LATENCY_LT_1 0x0
> +#define LATENCY_LT_2 0x1
> +#define LATENCY_LT_3 0x2
> +#define LATENCY_LT_4 0x3
> +#define SW_TUNE_ENABLE BIT(4)
> +
> +#define VENDOR_AT_SATA_R 0x544
> +#define MAX_PHASE_CODE 0xff
> +
> +#define DLL_ENABEL BIT(0)
> +#define DLL_LOCK_STS BIT(0)
> +#define DLL_ERROR_STS BIT(1)
> +#define PHY_DELAY_CODE_MASK 0x7f
> +#define PHY_DELAY_CODE_MAX 0x7f
> +
> +#define MAX_CORE_CLK_DIV 0xfff
> +
> +/**
> + * struct eswin_sdhci_clk_ops - Clock Operations for eswin SD controller
> + *
> + * @sdcardclk_ops:  The output clock related operations
> + * @sampleclk_ops:  The sample clock related operations
> + */
> +struct eswin_sdhci_clk_ops {
> +	const struct clk_ops *sdcardclk_ops;
> +	const struct clk_ops *sampleclk_ops;
> +};

Kernel style is to avoid creating sub-structures.  Instead
just put the members in parent structure e.g. eswin_sdhci_data
and eswin_sdhci_of_data

> +
> +/**
> + * struct eswin_sdhci_clk_data - ESWIN Controller Clock Data.
> + *
> + * @sdcardclk_hw:   Struct for the clock we might provide to a PHY.
> + * @sdcardclk:      Pointer to normal 'struct clock' for sdcardclk_hw.
> + * @sampleclk_hw:   Struct for the clock we might provide to a PHY.
> + * @sampleclk:      Pointer to normal 'struct clock' for sampleclk_hw.
> + * @clk_phase_in:   Array of Input Clock Phase Delays for all speed modes
> + * @clk_phase_out:  Array of Output Clock Phase Delays for all speed modes
> + * @set_clk_delays: Function pointer for setting Clock Delays
> + * @clk_of_data:    Platform specific runtime clock data storage pointer
> + */
> +struct eswin_sdhci_clk_data {
> +	struct clk_hw sdcardclk_hw;
> +	struct clk *sdcardclk;
> +	struct clk_hw sampleclk_hw;
> +	struct clk *sampleclk;
> +	int clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
> +	int clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
> +	void (*set_clk_delays)(struct sdhci_host *host);
> +	void *clk_of_data;
> +};

Kernel style is to avoid creating sub-structures.  Instead
just put the members in parent structure e.g. eswin_sdhci_data

> +
> +struct eswin_sdhci_phy_data {
> +	unsigned int drive_impedance;
> +	unsigned int enable_strobe_pulldown;
> +	unsigned int enable_data_pullup;
> +	unsigned int enable_cmd_pullup;
> +	unsigned int delay_code;
> +};

Kernel style is to avoid creating sub-structures.  Instead
just put the members in parent structure e.g. eswin_sdhci_data

> +
> +/**
> + * struct eswin_sdhci_data - ESWIN Controller Data
> + *
> + * @host:       Pointer to the main SDHCI host structure.
> + * @clk_ahb:        Pointer to the AHB clock
> + * @has_cqe:        True if controller has command queuing engine.
> + * @clk_data:       Struct for the ESWIN Controller Clock Data.
> + * @clk_ops:        Struct for the ESWIN Controller Clock Operations.
> + * @soc_ctl_base:   Pointer to regmap for syscon for soc_ctl registers.
> + * @soc_ctl_map:    Map to get offsets into soc_ctl registers.
> + * @quirks:     ESWIN deviations from spec.
> + * @phy:        ESWIN sdhci phy configs.
> + * @private:    private for spec driver.
> + */
> +struct eswin_sdhci_data {

The main struct name will come up a lot, so it could be shortened to
eswin_host or sdhci_eswin

> +	struct sdhci_host *host;
> +	struct clk *clk_ahb;
> +	bool has_cqe;
> +	struct eswin_sdhci_clk_data clk_data;
> +	const struct eswin_sdhci_clk_ops *clk_ops;
> +	unsigned int quirks;
> +
> +	struct regmap *crg_regmap;
> +	unsigned int crg_core_clk;
> +	unsigned int crg_aclk_ctrl;
> +	unsigned int crg_cfg_ctrl;
> +
> +	struct regmap *hsp_regmap;
> +	unsigned int hsp_int_status;
> +	unsigned int hsp_pwr_ctrl;
> +
> +	struct reset_control *txrx_rst;
> +	struct reset_control *phy_rst;
> +	struct reset_control *prstn;
> +	struct reset_control *arstn;
> +	struct eswin_sdhci_phy_data phy;
> +	unsigned long private[] ____cacheline_aligned;

Don't know why a driver would need anonymous private data,
but it doesn't look it is being used, so it could be removed.

> +};
> +
> +struct eswin_sdhci_of_data {

Might be better to call this eswin_sdhci_of_pdata to avoid
confusion with eswin_sdhci_data

> +	const struct sdhci_pltfm_data *pdata;
> +	const struct eswin_sdhci_clk_ops *clk_ops;
> +};
> +
> +void eswin_sdhci_set_core_clock(struct sdhci_host *host, unsigned int clock);
> +void eswin_sdhci_disable_card_clk(struct sdhci_host *host);
> +void eswin_sdhci_enable_card_clk(struct sdhci_host *host);
> +void eswin_sdhci_dt_parse_clk_phases(struct device *dev,
> +				     struct eswin_sdhci_clk_data *clk_data);
> +unsigned int eswin_convert_drive_impedance_ohm(struct platform_device *pdev,
> +					       unsigned int dr_ohm);
> +int eswin_sdhci_reset_init(struct device *dev,
> +			   struct eswin_sdhci_data *eswin_sdhci);
> +void eswin_sdhci_dump_vendor_regs(struct sdhci_host *host);
> +
> +#endif /* _DRIVERS_MMC_SDHCI_ESWIN_H */
> diff --git a/drivers/mmc/host/sdhci-of-eic7700-sdio.c b/drivers/mmc/host/sdhci-of-eic7700-sdio.c
> new file mode 100644
> index 000000000000..68f9995ab3b6
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-eic7700-sdio.c
> @@ -0,0 +1,991 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN sdio Driver
> + *
> + * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd.. All rights reserved.
> + *
> + * Authors:
> + *	Shuang Liang <liangshuang@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +
> +#include "cqhci.h"
> +#include "sdhci-eic7700.h"
> +#include "sdhci-pltfm.h"
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/iommu.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#define ESWIN_SDHCI_SD_CQE_BASE_ADDR 0x180
> +#define TUNING_RANGE_THRESHOLD 40
> +
> +static inline void *sdhci_sdio_priv(struct eswin_sdhci_data *sdio)

Not used?

> +{
> +	return sdio->private;
> +}
> +
> +static void eswin_sdhci_sdio_set_clock(struct sdhci_host *host,
> +				       unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		sdhci_pltfm_priv(pltfm_host);
> +	struct eswin_sdhci_clk_data *clk_data = &eswin_sdhci_sdio->clk_data;
> +
> +	/* Set the Input and Output Clock Phase Delays */
> +	if (clk_data->set_clk_delays)
> +		clk_data->set_clk_delays(host);
> +
> +	eswin_sdhci_set_core_clock(host, clock);
> +
> +	if (eswin_sdhci_sdio->quirks & SDHCI_ESWIN_QUIRK_CLOCK_UNSTABLE)
> +		/*
> +		 * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
> +		 * after enabling the clock even though the clock is not
> +		 * stable. Trying to use a clock without waiting here results
> +		 * in EILSEQ while detecting some older/slower cards. The
> +		 * chosen delay is the maximum delay from sdhci_set_clock.
> +		 */
> +		msleep(20);
> +}
> +
> +static void eswin_sdhci_sdio_config_phy_delay(struct sdhci_host *host,
> +					      int delay)
> +{
> +	delay &= PHY_CLK_MAX_DELAY_MASK;
> +
> +	/*phy clk delay line config*/
> +	sdhci_writeb(host, PHY_UPDATE_DELAY_CODE, PHY_SDCLKDL_CNFG_R);
> +	sdhci_writeb(host, delay, PHY_SDCLKDL_DC_R);
> +	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
> +}
> +
> +static void eswin_sdhci_sdio_config_phy(struct sdhci_host *host)
> +{
> +	unsigned int val = 0;
> +	unsigned int drv = 0;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	struct eswin_sdhci_phy_data *phy = &eswin_sdhci->phy;
> +
> +	drv = phy->drive_impedance << PHY_PAD_SP_DRIVE_SHIF;
> +	pr_debug("%s: phy drv=0x%x\n", mmc_hostname(host->mmc), drv);
> +
> +	eswin_sdhci_disable_card_clk(host);
> +
> +	/* reset phy,config phy's pad */
> +	sdhci_writel(host, drv | (~PHY_RSTN), PHY_CNFG_R);
> +	/*CMDPAD_CNFS*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) |
> +	      (phy->enable_cmd_pullup << PHY_PULL_BIT_SHIF) | PHY_PAD_RXSEL_1;
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	pr_debug("%s: phy cmd=0x%x\n", mmc_hostname(host->mmc), val);
> +
> +	/*DATA PAD CNFG*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) |
> +	      (phy->enable_data_pullup << PHY_PULL_BIT_SHIF) | PHY_PAD_RXSEL_1;
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	pr_debug("%s: phy data=0x%x\n", mmc_hostname(host->mmc), val);
> +
> +	/*Clock PAD Setting*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) | PHY_PAD_RXSEL_0;
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +	pr_debug("%s: phy clk=0x%x\n", mmc_hostname(host->mmc), val);
> +	mdelay(2);
> +
> +	/*PHY RSTN PAD setting*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) |
> +	      (PHY_PULL_UP << PHY_PULL_BIT_SHIF) | PHY_PAD_RXSEL_1;
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	sdhci_writel(host, drv | PHY_RSTN, PHY_CNFG_R);
> +
> +	eswin_sdhci_sdio_config_phy_delay(host, phy->delay_code);
> +
> +	eswin_sdhci_enable_card_clk(host);
> +}
> +
> +static void eswin_sdhci_sdio_reset(struct sdhci_host *host, u8 mask)
> +{
> +	u8 ctrl;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> +
> +	if (mask & SDHCI_RESET_ALL)
> +		sdhci_reset(host, SDHCI_RESET_ALL);
> +
> +	if (mask & SDHCI_RESET_DATA)
> +		sdhci_reset(host, SDHCI_RESET_DATA);
> +
> +	if (mask & SDHCI_RESET_CMD)
> +		sdhci_reset(host, SDHCI_RESET_CMD);
> +
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +	if (eswin_sdhci_sdio->quirks & SDHCI_ESWIN_QUIRK_FORCE_CDTEST) {
> +		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +		ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +	}
> +	if (mask == SDHCI_RESET_ALL) { // after reset all,the phy`s config will
> +				       // be clear.
> +		eswin_sdhci_sdio_config_phy(host);
> +	}
> +}
> +
> +static int eswin_sdhci_sdio_phase_code_tuning(struct sdhci_host *host,
> +					      u32 opcode)
> +{
> +	int cmd_error = 0;
> +	int ret = 0;
> +	int phase_code = -1;
> +	int code_min = -1;
> +	int code_max = -1;
> +	int code_range = -1;
> +	int i = 0;
> +
> +	for (i = 0; i <= MAX_PHASE_CODE; i++) {
> +		eswin_sdhci_disable_card_clk(host);
> +		sdhci_writew(host, i, VENDOR_AT_SATA_R);
> +		eswin_sdhci_enable_card_clk(host);
> +
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +		if (ret) {
> +			udelay(200);
> +			pr_debug("%s: bad phase_code:0x%x!\n",
> +				 mmc_hostname(host->mmc), i);
> +			if (code_min != -1 && code_max != -1) {
> +				if (code_max - code_min > code_range) {
> +					code_range = code_max - code_min;
> +					phase_code = (code_min + code_max) / 2;
> +					if (code_range > TUNING_RANGE_THRESHOLD)
> +						break;
> +				}
> +				code_min = -1;
> +				code_max = -1;
> +			}
> +		} else {
> +			pr_debug("%s: ok phase_code:0x%x\n",
> +				 mmc_hostname(host->mmc), i);
> +			if (code_min == -1)
> +				code_min = i;
> +
> +			code_max = i;
> +			if (i == MAX_PHASE_CODE) {
> +				if (code_max - code_min > code_range) {
> +					code_range = code_max - code_min;
> +					phase_code = (code_min + code_max) / 2;
> +				}
> +			}
> +			continue;
> +		}
> +	}
> +
> +	if (phase_code == -1) {
> +		pr_err("%s: phase code tuning failed!\n",
> +		       mmc_hostname(host->mmc));
> +		eswin_sdhci_disable_card_clk(host);
> +		sdhci_writew(host, 0, VENDOR_AT_SATA_R);
> +		eswin_sdhci_enable_card_clk(host);
> +		return -EIO;
> +	}
> +
> +	pr_debug("%s: set phase_code:0x%x\n", mmc_hostname(host->mmc),
> +		 phase_code);
> +
> +	eswin_sdhci_disable_card_clk(host);
> +	sdhci_writew(host, phase_code, VENDOR_AT_SATA_R);
> +	eswin_sdhci_enable_card_clk(host);
> +
> +	ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +	host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +	if (ret) {
> +		pr_err("%s: phase_code code(0x%x) not work, tuning failed!\n",
> +		       mmc_hostname(host->mmc), phase_code);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eswin_sdhci_sdio_executing_tuning(struct sdhci_host *host,
> +					     u32 opcode)
> +{
> +	u32 ctrl;
> +	u32 val;
> +	int ret = 0;
> +	struct sdhci_pltfm_host *pltfm_host;
> +
> +	pltfm_host = sdhci_priv(host);
> +	sdhci_pltfm_priv(pltfm_host);
> +
> +	eswin_sdhci_disable_card_clk(host);
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readl(host, VENDOR_AT_CTRL_R);
> +	val |= SW_TUNE_ENABLE;
> +	sdhci_writew(host, val, VENDOR_AT_CTRL_R);
> +	sdhci_writew(host, 0, VENDOR_AT_SATA_R);
> +
> +	eswin_sdhci_enable_card_clk(host);
> +
> +	sdhci_writew(host, 0x0, SDHCI_CMD_DATA);
> +
> +	ret = eswin_sdhci_sdio_phase_code_tuning(host, opcode);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static u32 eswin_sdhci_sdio_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
> +static void eswin_sdhci_sdio_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static void eswin_sdhci_sdio_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	while (reg & SDHCI_DATA_AVAILABLE) {
> +		sdhci_readl(host, SDHCI_BUFFER);
> +		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	}
> +
> +	sdhci_cqe_enable(mmc);
> +}
> +
> +static const struct cqhci_host_ops eswin_sdhci_sdio_cqhci_ops = {
> +	.enable = eswin_sdhci_sdio_cqe_enable,
> +	.disable = sdhci_cqe_disable,
> +	.dumpregs = eswin_sdhci_sdio_dumpregs,
> +};
> +
> +static const struct sdhci_ops eswin_sdhci_sdio_cqe_ops = {
> +	.set_clock = eswin_sdhci_sdio_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = eswin_sdhci_sdio_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +	.set_power = sdhci_set_power_and_bus_voltage,
> +	.irq = eswin_sdhci_sdio_cqhci_irq,
> +	.platform_execute_tuning = eswin_sdhci_sdio_executing_tuning,
> +	.dump_vendor_regs = eswin_sdhci_dump_vendor_regs,
> +};
> +
> +static const struct sdhci_pltfm_data eswin_sdhci_sdio_cqe_pdata = {
> +	.ops = &eswin_sdhci_sdio_cqe_ops,
> +	.quirks = SDHCI_QUIRK_BROKEN_CQE | SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +/**
> + * eswin_sdhci_sdio_suspend- Suspend method for the driver
> + * @dev:        Address of the device structure
> + *
> + * Put the device in a low power state.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int eswin_sdhci_sdio_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	pm_runtime_get_sync(dev);
> +
> +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	ret = sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(eswin_sdhci_sdio->clk_ahb);
> +
> +	return 0;
> +}
> +
> +/**
> + * eswin_sdhci_sdio_resume- Resume method for the driver
> + * @dev:        Address of the device structure
> + *
> + * Resume operation after suspend
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int eswin_sdhci_sdio_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	pm_runtime_put_sync(dev);
> +	ret = clk_prepare_enable(eswin_sdhci_sdio->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "can't enable clk_ahb.\n");
> +		return ret;
> +	}
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable mainck.\n");
> +		goto clk_ahb_disable;
> +	}
> +
> +	ret = sdhci_resume_host(host);
> +	if (ret) {
> +		dev_err(dev, "runtime resume failed!\n");
> +		goto clk_disable;
> +	}
> +
> +	return 0;
> +clk_disable:
> +	clk_disable_unprepare(pltfm_host->clk);
> +clk_ahb_disable:
> +	clk_disable_unprepare(eswin_sdhci_sdio->clk_ahb);
> +
> +	return ret;
> +}
> +
> +static int eswin_sdhci_sdio_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = sdhci_runtime_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(eswin_sdhci_sdio->clk_ahb);
> +
> +	return 0;
> +}
> +
> +static int eswin_sdhci_sdio_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = clk_prepare_enable(eswin_sdhci_sdio->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "can't enable clk_ahb\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable mainck\n");
> +		goto clk_ahb_disable;
> +	}
> +
> +	ret = sdhci_runtime_resume_host(host, 1);
> +	if (ret) {
> +		dev_err(dev, "runtime resume failed!\n");
> +		goto clk_disable;
> +	}
> +
> +	return 0;
> +clk_disable:
> +	clk_disable_unprepare(pltfm_host->clk);
> +clk_ahb_disable:
> +	clk_disable_unprepare(eswin_sdhci_sdio->clk_ahb);
> +
> +	return ret;
> +}
> +
> +#endif /* ! CONFIG_PM_SLEEP */
> +
> +/**
> + * eswin_sdhci_sdio_sdcardclk_recalc_rate- Return the card clock rate
> + *
> + * @hw:                 Pointer to the hardware clock structure.
> + * @parent_rate:                The parent rate (should be rate of clk_xin).
> + *
> + * Return the current actual rate of the SD card clock.  This can be used
> + * to communicate with out PHY.
> + *
> + * Return: The card clock rate.
> + */
> +static unsigned long
> +eswin_sdhci_sdio_sdcardclk_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct eswin_sdhci_clk_data *clk_data =
> +		container_of(hw, struct eswin_sdhci_clk_data, sdcardclk_hw);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		container_of(clk_data, struct eswin_sdhci_data, clk_data);
> +	struct sdhci_host *host = eswin_sdhci_sdio->host;
> +
> +	return host->mmc->actual_clock;
> +}
> +
> +static const struct clk_ops eswin_sdio_sdcardclk_ops = {
> +	.recalc_rate = eswin_sdhci_sdio_sdcardclk_recalc_rate,
> +};
> +
> +/**
> + * eswin_sdhci_sdio_sampleclk_recalc_rate- Return the sampling clock rate
> + *
> + * @hw:                 Pointer to the hardware clock structure.
> + * @parent_rate:                The parent rate (should be rate of clk_xin).
> + *
> + * Return the current actual rate of the sampling clock.  This can be used
> + * to communicate with out PHY.
> + *
> + * Return: The sample clock rate.
> + */
> +static unsigned long
> +eswin_sdhci_sdio_sampleclk_recalc_rate(struct clk_hw *hw,
> +				       unsigned long parent_rate)
> +{
> +	struct eswin_sdhci_clk_data *clk_data =
> +		container_of(hw, struct eswin_sdhci_clk_data, sampleclk_hw);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		container_of(clk_data, struct eswin_sdhci_data, clk_data);
> +	struct sdhci_host *host = eswin_sdhci_sdio->host;
> +
> +	return host->mmc->actual_clock;
> +}
> +
> +static const struct clk_ops eswin_sdio_sampleclk_ops = {
> +	.recalc_rate = eswin_sdhci_sdio_sampleclk_recalc_rate,
> +};
> +
> +static const struct eswin_sdhci_clk_ops eswin_sdio_clk_ops = {
> +	.sdcardclk_ops = &eswin_sdio_sdcardclk_ops,
> +	.sampleclk_ops = &eswin_sdio_sampleclk_ops,
> +};
> +
> +static struct eswin_sdhci_of_data eswin_sdhci_fu800_sdio_data = {
> +	.pdata = &eswin_sdhci_sdio_cqe_pdata,
> +	.clk_ops = &eswin_sdio_clk_ops,
> +};
> +
> +static const struct of_device_id eswin_sdhci_sdio_of_match[] = {
> +	/* SoC-specific compatible strings*/
> +	{
> +		.compatible = "eswin,sdhci-sdio",
> +		.data = &eswin_sdhci_fu800_sdio_data,
> +	},
> +	{/* sentinel */}};
> +MODULE_DEVICE_TABLE(of, eswin_sdhci_sdio_of_match);
> +
> +/**
> + * eswin_sdhci_sdio_register_sdcardclk- Register the sdcardclk for a PHY to use
> + *
> + * @eswin_sdhci_sdio:       Our private data structure.
> + * @clk_xin:            Pointer to the functional clock
> + * @dev:                Pointer to our struct device.
> + *
> + * Some PHY devices need to know what the actual card clock is.  In order for
> + * them to find out, we'll provide a clock through the common clock framework
> + * for them to query.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int
> +eswin_sdhci_sdio_register_sdcardclk(struct eswin_sdhci_data *eswin_sdhci_sdio,
> +				    struct clk *clk_xin, struct device *dev)
> +{
> +	struct eswin_sdhci_clk_data *clk_data = &eswin_sdhci_sdio->clk_data;
> +	struct device_node *np = dev->of_node;
> +	struct clk_init_data sdcardclk_init;
> +	const char *parent_clk_name;
> +	int ret;
> +
> +	ret = of_property_read_string_index(np, "clock-output-names", 0,
> +					    &sdcardclk_init.name);
> +	if (ret) {
> +		dev_err(dev, "DT has #clock-cells but no clock-output-names\n");
> +		return ret;
> +	}
> +
> +	parent_clk_name = __clk_get_name(clk_xin);
> +	sdcardclk_init.parent_names = &parent_clk_name;
> +	sdcardclk_init.num_parents = 1;
> +	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
> +	sdcardclk_init.ops = eswin_sdhci_sdio->clk_ops->sdcardclk_ops;
> +
> +	clk_data->sdcardclk_hw.init = &sdcardclk_init;
> +	clk_data->sdcardclk = devm_clk_register(dev, &clk_data->sdcardclk_hw);
> +	if (IS_ERR(clk_data->sdcardclk))
> +		return PTR_ERR(clk_data->sdcardclk);
> +
> +	clk_data->sdcardclk_hw.init = NULL;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_simple_get,
> +				  clk_data->sdcardclk);
> +	if (ret)
> +		dev_err(dev, "Failed to add sdcard clock provider\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * eswin_sdhci_sdio_register_sampleclk - Register the sampleclk for a PHY to use
> + *
> + * @eswin_sdhci_sdio:       Our private data structure.
> + * @clk_xin:            Pointer to the functional clock
> + * @dev:                Pointer to our struct device.
> + *
> + * Some PHY devices need to know what the actual card clock is.  In order for
> + * them to find out, we'll provide a clock through the common clock framework
> + * for them to query.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int
> +eswin_sdhci_sdio_register_sampleclk(struct eswin_sdhci_data *eswin_sdhci_sdio,
> +				    struct clk *clk_xin, struct device *dev)
> +{
> +	struct eswin_sdhci_clk_data *clk_data = &eswin_sdhci_sdio->clk_data;
> +	struct device_node *np = dev->of_node;
> +	struct clk_init_data sampleclk_init;
> +	const char *parent_clk_name;
> +	int ret;
> +
> +	ret = of_property_read_string_index(np, "clock-output-names", 1,
> +					    &sampleclk_init.name);
> +	if (ret) {
> +		dev_err(dev, "DT has #clock-cells but no clock-output-names\n");
> +		return ret;
> +	}
> +
> +	parent_clk_name = __clk_get_name(clk_xin);
> +	sampleclk_init.parent_names = &parent_clk_name;
> +	sampleclk_init.num_parents = 1;
> +	sampleclk_init.flags = CLK_GET_RATE_NOCACHE;
> +	sampleclk_init.ops = eswin_sdhci_sdio->clk_ops->sampleclk_ops;
> +
> +	clk_data->sampleclk_hw.init = &sampleclk_init;
> +	clk_data->sampleclk = devm_clk_register(dev, &clk_data->sampleclk_hw);
> +	if (IS_ERR(clk_data->sampleclk))
> +		return PTR_ERR(clk_data->sampleclk);
> +	clk_data->sampleclk_hw.init = NULL;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_simple_get,
> +				  clk_data->sampleclk);
> +	if (ret)
> +		dev_err(dev, "Failed to add sample clock provider\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * eswin_sdhci_sdio_unregister_sdclk- Undoes sdhci_arasan_register_sdclk()
> + *
> + * @dev:                Pointer to our struct device.
> + *
> + * Should be called any time we're exiting and sdhci_arasan_register_sdclk()
> + * returned success.
> + */
> +static void eswin_sdhci_sdio_unregister_sdclk(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +
> +	if (!of_find_property(np, "#clock-cells", NULL))
> +		return;
> +
> +	of_clk_del_provider(dev->of_node);
> +}
> +
> +/**
> + * eswin_sdhci_sdio_register_sdclk- Register the sdcardclk for a PHY to use
> + *
> + * @eswin_sdhci_sdio:   Our private data structure.
> + * @clk_xin:            Pointer to the functional clock
> + * @dev:                Pointer to our struct device.
> + *
> + * Some PHY devices need to know what the actual card clock is.  In order for
> + * them to find out, we'll provide a clock through the common clock framework
> + * for them to query.
> + *
> + * Note: without seriously re-architecting SDHCI's clock code and testing on
> + * all platforms, there's no way to create a totally beautiful clock here
> + * with all clock ops implemented.      Instead, we'll just create a clock that
> + * can be queried and set the CLK_GET_RATE_NOCACHE attribute to tell common
> + * clock framework that we're doing things behind its back.  This should be
> + * sufficient to create nice clean device tree bindings and later (if needed) we
> + * can try re-architecting SDHCI if we see some benefit to it.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int
> +eswin_sdhci_sdio_register_sdclk(struct eswin_sdhci_data *eswin_sdhci_sdio,
> +				struct clk *clk_xin, struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	u32 num_clks = 0;
> +	int ret;
> +
> +	/* Providing a clock to the PHY is optional; no error if missing */
> +	if (of_property_read_u32(np, "#clock-cells", &num_clks) < 0)
> +		return 0;
> +
> +	ret = eswin_sdhci_sdio_register_sdcardclk(eswin_sdhci_sdio, clk_xin,
> +						  dev);
> +	if (ret)
> +		return ret;
> +
> +	if (num_clks) {
> +		ret = eswin_sdhci_sdio_register_sampleclk(eswin_sdhci_sdio,
> +							  clk_xin, dev);
> +		if (ret) {
> +			eswin_sdhci_sdio_unregister_sdclk(dev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int eswin_sdhci_sdio_add_host(struct eswin_sdhci_data *eswin_sdhci_sdio)
> +{
> +	struct sdhci_host *host = eswin_sdhci_sdio->host;
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	if (!eswin_sdhci_sdio->has_cqe)
> +		return sdhci_add_host(host);
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	cq_host = devm_kzalloc(host->mmc->parent, sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	cq_host->mmio = host->ioaddr + ESWIN_SDHCI_SD_CQE_BASE_ADDR;
> +	cq_host->ops = &eswin_sdhci_sdio_cqhci_ops;
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	sdhci_cleanup_host(host);
> +	return ret;
> +}
> +
> +static int eswin_sdhci_sdio_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct clk *clk_xin;
> +	struct clk *clk_spll2_fout3;
> +	struct clk *clk_mux;
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct eswin_sdhci_data *eswin_sdhci_sdio;
> +	const struct eswin_sdhci_of_data *data;
> +	unsigned int val = 0;
> +
> +	data = of_device_get_match_data(dev);
> +	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*eswin_sdhci_sdio));
> +
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	eswin_sdhci_sdio = sdhci_pltfm_priv(pltfm_host);
> +	eswin_sdhci_sdio->host = host;
> +	eswin_sdhci_sdio->has_cqe = false;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	eswin_sdhci_sdio->clk_ops = data->clk_ops;
> +	eswin_sdhci_sdio->clk_ahb = devm_clk_get(dev, "clk_ahb");
> +	if (IS_ERR(eswin_sdhci_sdio->clk_ahb)) {
> +		ret = dev_err_probe(dev, PTR_ERR(eswin_sdhci_sdio->clk_ahb),
> +				    "clk_ahb clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	clk_xin = devm_clk_get(dev, "clk_xin");
> +	if (IS_ERR(clk_xin)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_xin),
> +				    "clk_xin clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	clk_spll2_fout3 = devm_clk_get(dev, "clk_spll2_fout3");
> +
> +	if (IS_ERR(clk_spll2_fout3)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_spll2_fout3),
> +				    "clk_spll2_fout3 clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	if (of_device_is_compatible(np, "eswin,sdhci-sdio")) {
> +		clk_mux = devm_clk_get(dev, "clk_mux1_1");
> +		if (IS_ERR(clk_mux)) {
> +			ret = dev_err_probe(dev, PTR_ERR(clk_mux),
> +					    "clk_mux1_1 clock not found.\n");
> +			goto err_pltfm_free;
> +		}
> +		/*switch the core clk source*/
> +		clk_set_parent(clk_mux, clk_spll2_fout3);
> +	}
> +
> +	ret = clk_prepare_enable(eswin_sdhci_sdio->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "Unable to enable AHB clock.\n");
> +		goto err_pltfm_free;
> +	}
> +	/* If clock-frequency property is set, use the provided value */
> +	if (pltfm_host->clock && pltfm_host->clock != clk_get_rate(clk_xin)) {
> +		ret = clk_set_rate(clk_xin, pltfm_host->clock);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to set SD clock rate\n");
> +			goto clk_dis_ahb;
> +		}
> +	}
> +
> +	ret = clk_prepare_enable(clk_xin);
> +	if (ret) {
> +		dev_err(dev, "Unable to enable SD clock.\n");
> +		goto clk_dis_ahb;
> +	}
> +
> +	pltfm_host->clk = clk_xin;
> +	ret = eswin_sdhci_sdio_register_sdclk(eswin_sdhci_sdio, clk_xin, dev);
> +	if (ret)
> +		goto clk_disable_all;
> +
> +	ret = eswin_sdhci_reset_init(dev, eswin_sdhci_sdio);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to reset\n");
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci_sdio->crg_regmap = syscon_regmap_lookup_by_phandle(
> +		pdev->dev.of_node, "eswin,syscrg_csr");
> +	if (IS_ERR(eswin_sdhci_sdio->crg_regmap)) {
> +		dev_dbg(&pdev->dev, "No syscrg_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 1, &eswin_sdhci_sdio->crg_core_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_core_clk (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 2, &eswin_sdhci_sdio->crg_aclk_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_aclk_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 3, &eswin_sdhci_sdio->crg_cfg_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_cfg_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci_sdio->hsp_regmap = syscon_regmap_lookup_by_phandle(
> +		dev->of_node, "eswin,hsp_sp_csr");
> +	if (IS_ERR(eswin_sdhci_sdio->hsp_regmap)) {
> +		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 2, &eswin_sdhci_sdio->hsp_int_status);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_int_status (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 3, &eswin_sdhci_sdio->hsp_pwr_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_pwr_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	regmap_write(eswin_sdhci_sdio->hsp_regmap,
> +		     eswin_sdhci_sdio->hsp_int_status, MSHC_INT_CLK_STABLE);
> +	regmap_write(eswin_sdhci_sdio->hsp_regmap,
> +		     eswin_sdhci_sdio->hsp_pwr_ctrl, MSHC_HOST_VAL_STABLE);
> +
> +	if (!of_property_read_u32(dev->of_node, "delay_code", &val))
> +		eswin_sdhci_sdio->phy.delay_code = val;
> +
> +	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
> +		eswin_sdhci_sdio->phy.drive_impedance =
> +			eswin_convert_drive_impedance_ohm(pdev, val);
> +
> +	if (of_property_read_bool(dev->of_node, "enable-cmd-pullup"))
> +		eswin_sdhci_sdio->phy.enable_cmd_pullup = ENABLE;
> +	else
> +		eswin_sdhci_sdio->phy.enable_cmd_pullup = DISABLE;
> +
> +	if (of_property_read_bool(dev->of_node, "enable-data-pullup"))
> +		eswin_sdhci_sdio->phy.enable_data_pullup = ENABLE;
> +	else
> +		eswin_sdhci_sdio->phy.enable_data_pullup = DISABLE;
> +
> +	eswin_sdhci_dt_parse_clk_phases(dev, &eswin_sdhci_sdio->clk_data);
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
> +		goto unreg_clk;
> +	}
> +
> +	ret = eswin_sdhci_sdio_add_host(eswin_sdhci_sdio);
> +	if (ret)
> +		goto unreg_clk;
> +
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_suspend_ignore_children(&pdev->dev, 1);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +unreg_clk:
> +	eswin_sdhci_sdio_unregister_sdclk(dev);
> +clk_disable_all:
> +	clk_disable_unprepare(clk_xin);
> +clk_dis_ahb:
> +	clk_disable_unprepare(eswin_sdhci_sdio->clk_ahb);
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static void eswin_sdhci_sdio_remove(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci_sdio =
> +		sdhci_pltfm_priv(pltfm_host);
> +	struct clk *clk_ahb = eswin_sdhci_sdio->clk_ahb;
> +
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
> +	sdhci_pltfm_remove(pdev);
> +
> +	if (eswin_sdhci_sdio->txrx_rst) {
> +		ret = reset_control_assert(eswin_sdhci_sdio->txrx_rst);
> +		WARN_ON(ret != 0);
> +	}
> +
> +	if (eswin_sdhci_sdio->phy_rst) {
> +		ret = reset_control_assert(eswin_sdhci_sdio->phy_rst);
> +		WARN_ON(ret != 0);
> +	}
> +
> +	if (eswin_sdhci_sdio->prstn) {
> +		ret = reset_control_assert(eswin_sdhci_sdio->prstn);
> +		WARN_ON(ret != 0);
> +	}
> +
> +	if (eswin_sdhci_sdio->arstn) {
> +		ret = reset_control_assert(eswin_sdhci_sdio->arstn);
> +		WARN_ON(ret != 0);
> +	}
> +
> +	eswin_sdhci_sdio_unregister_sdclk(&pdev->dev);
> +	clk_disable_unprepare(clk_ahb);
> +}
> +
> +static const struct dev_pm_ops eswin_sdhci_sdio_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(eswin_sdhci_sdio_suspend,
> +				eswin_sdhci_sdio_resume)
> +		SET_RUNTIME_PM_OPS(eswin_sdhci_sdio_runtime_suspend,
> +				   eswin_sdhci_sdio_runtime_resume, NULL)};
> +
> +static struct platform_driver eswin_sdhci_sdio_driver = {
> +	.driver = {
> +		.name = "eswin-sdhci-sdio",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table = eswin_sdhci_sdio_of_match,
> +		.pm = &eswin_sdhci_sdio_pmops,
> +	},
> +	.probe = eswin_sdhci_sdio_probe,
> +	.remove = eswin_sdhci_sdio_remove,
> +};
> +
> +module_platform_driver(eswin_sdhci_sdio_driver);
> +
> +MODULE_DESCRIPTION("Driver for the Eswin SDHCI Controller");
> +MODULE_AUTHOR("Shuang Liang <liangshuang@eswincomputing.com>");
> +MODULE_AUTHOR("Xuyang Dong <dongxuyang@eswincomputing.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/host/sdhci-of-eic7700.c b/drivers/mmc/host/sdhci-of-eic7700.c
> new file mode 100644
> index 000000000000..078f15b99d67
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-eic7700.c
> @@ -0,0 +1,1053 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN Emmc Driver
> + *
> + * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd.. All rights reserved.
> + *
> + * Authors:
> + *	Shuang Liang <liangshuang@eswincomputing.com>
> + *	Xuyang Dong <dongxuyang@eswincomputing.com>
> + */
> +
> +#include "cqhci.h"
> +#include "sdhci-eic7700.h"
> +#include "sdhci-pltfm.h"
> +#include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
> +#include <linux/iommu.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +// EMMC_DWC_MSHC_CRYPTO_CFG_PTR 8 -- parameter
> +#define eswin_sdhci_VENDOR_REGISTER_BASEADDR 0x800
> +#define eswin_sdhci_VENDOR_EMMC_CTRL_REGISTER 0x2c
> +#define VENDOR_ENHANCED_STROBE BIT(8)
> +
> +#define eswin_sdhci_CQE_BASE_ADDR eswin_sdhci_VENDOR_REGISTER_BASEADDR
> +
> +/* Controller does not have CD wired and will not function normally without */
> +#define eswin_sdhci_QUIRK_FORCE_CDTEST BIT(0)
> +/* Controller immediately reports SDHCI_CLOCK_INT_STABLE after enabling the
> + * internal clock even when the clock isn't stable
> + */
> +#define eswin_sdhci_QUIRK_CLOCK_UNSTABLE BIT(1)
> +
> +/*
> + * On some SoCs the syscon area has a feature where the upper 16-bits of
> + * each 32-bit register act as a write mask for the lower 16-bits.  This allows
> + * atomic updates of the register without locking.  This macro is used on SoCs
> + * that have that feature.
> + */
> +#define HIWORD_UPDATE(val, mask, shift)                                        \
> +	((val) << (shift) | (mask) << ((shift) + 16))
> +
> +static void eswin_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	struct eswin_sdhci_clk_data *clk_data = &eswin_sdhci->clk_data;
> +
> +	/* Set the Input and Output Clock Phase Delays */
> +	if (clk_data->set_clk_delays)
> +		clk_data->set_clk_delays(host);
> +
> +	eswin_sdhci_set_core_clock(host, clock);
> +
> +	/*
> +	 * Some controllers immediately report SDHCI_CLOCK_INT_STABLE
> +	 * after enabling the clock even though the clock is not
> +	 * stable. Trying to use a clock without waiting here results
> +	 * in EILSEQ while detecting some older/slower cards. The
> +	 * chosen delay is the maximum delay from sdhci_set_clock.
> +	 */
> +	if (eswin_sdhci->quirks & SDHCI_ESWIN_QUIRK_CLOCK_UNSTABLE)
> +		msleep(20);
> +}
> +
> +static void eswin_sdhci_hs400_enhanced_strobe(struct mmc_host *mmc,
> +					      struct mmc_ios *ios)
> +{
> +	u32 vendor;
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	vendor = sdhci_readl(host, eswin_sdhci_VENDOR_EMMC_CTRL_REGISTER);
> +	if (ios->enhanced_strobe)
> +		vendor |= VENDOR_ENHANCED_STROBE;
> +	else
> +		vendor &= ~VENDOR_ENHANCED_STROBE;
> +
> +	sdhci_writel(host, vendor, eswin_sdhci_VENDOR_EMMC_CTRL_REGISTER);
> +}
> +
> +static void eswin_sdhci_config_phy_delay(struct sdhci_host *host, int delay)
> +{
> +	delay &= PHY_CLK_MAX_DELAY_MASK;
> +
> +	/*phy clk delay line config*/
> +	sdhci_writeb(host, PHY_UPDATE_DELAY_CODE, PHY_SDCLKDL_CNFG_R);
> +	sdhci_writeb(host, delay, PHY_SDCLKDL_DC_R);
> +	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
> +}
> +
> +static void eswin_sdhci_config_phy(struct sdhci_host *host)
> +{
> +	unsigned int val = 0;
> +	unsigned int drv = 0;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	struct eswin_sdhci_phy_data *phy = &eswin_sdhci->phy;
> +
> +	drv = phy->drive_impedance << PHY_PAD_SP_DRIVE_SHIF;
> +
> +	pr_debug("%s: phy drv=0x%x\n", mmc_hostname(host->mmc), drv);
> +
> +	val = sdhci_readw(host, VENDOR_EMMC_CTRL_R);
> +	val |= EMMC_CRAD_PRESENT; // emmc card
> +	sdhci_writew(host, val, VENDOR_EMMC_CTRL_R);
> +
> +	eswin_sdhci_disable_card_clk(host);
> +
> +	/* reset phy,config phy's pad */
> +	sdhci_writel(host, drv | (~PHY_RSTN), PHY_CNFG_R);
> +	/*CMDPAD_CNFS*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) |
> +	      (phy->enable_cmd_pullup << PHY_PULL_BIT_SHIF) | PHY_PAD_RXSEL_1;
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	pr_debug("%s: phy cmd=0x%x\n", mmc_hostname(host->mmc), val);
> +
> +	/*DATA PAD CNFG*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) |
> +	      (phy->enable_data_pullup << PHY_PULL_BIT_SHIF) | PHY_PAD_RXSEL_1;
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	pr_debug("%s: phy data=0x%x\n", mmc_hostname(host->mmc), val);
> +
> +	/*Clock PAD Setting*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) | PHY_PAD_RXSEL_0;
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +	pr_debug("%s: phy clk=0x%x\n", mmc_hostname(host->mmc), val);
> +
> +	/*PHY strobe PAD setting*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) |
> +	      ((phy->enable_strobe_pulldown * PHY_PULL_DOWN)
> +	       << PHY_PULL_BIT_SHIF) |
> +	      PHY_PAD_RXSEL_1;
> +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +	pr_debug("%s: phy strobe=0x%x\n", mmc_hostname(host->mmc), val);
> +	mdelay(2);
> +
> +	/*PHY RSTN PAD setting*/
> +	val = (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_P_BIT_SHIFT) |
> +	      (PHY_SLEW_2 << PHY_TX_SLEW_CTRL_N_BIT_SHIFT) |
> +	      (PHY_PULL_UP << PHY_PULL_BIT_SHIF) | PHY_PAD_RXSEL_1;
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +	pr_debug("%s: phy rstn=0x%x\n", mmc_hostname(host->mmc), val);
> +
> +	sdhci_writel(host, drv | PHY_RSTN, PHY_CNFG_R);
> +
> +	eswin_sdhci_config_phy_delay(host, phy->delay_code);
> +
> +	eswin_sdhci_enable_card_clk(host);
> +}
> +
> +static void eswin_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	u8 ctrl;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +
> +	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
> +	sdhci_reset(host, mask);
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +
> +	if (eswin_sdhci->quirks & SDHCI_ESWIN_QUIRK_FORCE_CDTEST) {
> +		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +		ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +	}
> +
> +	if (mask == SDHCI_RESET_ALL) { // after reset all,the phy`s config will
> +				       // be clear.
> +		eswin_sdhci_config_phy(host);
> +	}
> +}
> +
> +static u32 eswin_sdhci_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_error = 0;
> +	int data_error = 0;
> +
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_error, &data_error))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_error, data_error);
> +
> +	return 0;
> +}
> +
> +static void eswin_sdhci_dumpregs(struct mmc_host *mmc)
> +{
> +	sdhci_dumpregs(mmc_priv(mmc));
> +}
> +
> +static void eswin_sdhci_cqe_enable(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u32 reg;
> +
> +	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	while (reg & SDHCI_DATA_AVAILABLE) {
> +		sdhci_readl(host, SDHCI_BUFFER);
> +		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +	}
> +
> +	sdhci_cqe_enable(mmc);
> +}
> +
> +static int eswin_sdhci_delay_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int ret;
> +	int delay = 0;
> +	int i = 0;
> +	int delay_min = -1;
> +	int delay_max = -1;
> +	int cmd_error = 0;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +
> +	for (i = 0; i <= PHY_DELAY_CODE_MAX; i++) {
> +		eswin_sdhci_disable_card_clk(host);
> +		eswin_sdhci_config_phy_delay(host, i);
> +		eswin_sdhci_enable_card_clk(host);
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		if (ret) {
> +			host->ops->reset(host,
> +					 SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +			udelay(200);
> +			if (delay_min != -1 && delay_max != -1)
> +				break;
> +		} else {
> +			if (delay_min == -1) {
> +				delay_min = i;
> +				continue;
> +			} else {
> +				delay_max = i;
> +				continue;
> +			}
> +		}
> +	}
> +	if (delay_min == -1 && delay_max == -1) {
> +		pr_err("%s: delay code tuning failed!\n",
> +		       mmc_hostname(host->mmc));
> +		eswin_sdhci_disable_card_clk(host);
> +		eswin_sdhci_config_phy_delay(host, eswin_sdhci->phy.delay_code);
> +		eswin_sdhci_enable_card_clk(host);
> +
> +		return ret;
> +	}
> +
> +	delay = (delay_min + delay_max) / 2;
> +	pr_debug("%s: set delay:0x%x\n", mmc_hostname(host->mmc), delay);
> +	eswin_sdhci_disable_card_clk(host);
> +	eswin_sdhci_config_phy_delay(host, delay);
> +	eswin_sdhci_enable_card_clk(host);
> +
> +	return 0;
> +}
> +
> +static int eswin_sdhci_phase_code_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int cmd_error = 0;
> +	int ret = 0;
> +	int phase_code = 0;
> +	int code_min = -1;
> +	int code_max = -1;
> +
> +	for (phase_code = 0; phase_code <= MAX_PHASE_CODE; phase_code++) {
> +		eswin_sdhci_disable_card_clk(host);
> +		sdhci_writew(host, phase_code, VENDOR_AT_SATA_R);
> +		eswin_sdhci_enable_card_clk(host);
> +
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		if (ret) {
> +			host->ops->reset(host,
> +					 SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +			udelay(200);
> +			if (code_min != -1 && code_max != -1)
> +				break;
> +		} else {
> +			if (code_min == -1) {
> +				code_min = phase_code;
> +				continue;
> +			} else {
> +				code_max = phase_code;
> +				continue;
> +			}
> +		}
> +	}
> +	if (code_min == -1 && code_max == -1) {
> +		pr_err("%s: phase code tuning failed!\n",
> +		       mmc_hostname(host->mmc));
> +		eswin_sdhci_disable_card_clk(host);
> +		sdhci_writew(host, 0, VENDOR_AT_SATA_R);
> +		eswin_sdhci_enable_card_clk(host);
> +		return -EIO;
> +	}
> +
> +	phase_code = (code_min + code_max) / 2;
> +	pr_debug("%s: set phase_code:0x%x\n", mmc_hostname(host->mmc),
> +		 phase_code);
> +
> +	eswin_sdhci_disable_card_clk(host);
> +	sdhci_writew(host, phase_code, VENDOR_AT_SATA_R);
> +	eswin_sdhci_enable_card_clk(host);
> +
> +	return 0;
> +}
> +
> +static int eswin_sdhci_executing_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	u32 ctrl;
> +	u32 val;
> +	int ret = 0;
> +
> +	eswin_sdhci_disable_card_clk(host);
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readl(host, VENDOR_AT_CTRL_R);
> +	val |= SW_TUNE_ENABLE;
> +	sdhci_writew(host, val, VENDOR_AT_CTRL_R);
> +	sdhci_writew(host, 0, VENDOR_AT_SATA_R);
> +
> +	eswin_sdhci_enable_card_clk(host);
> +
> +	sdhci_writew(host, 0x0, SDHCI_CMD_DATA);
> +
> +	ret = eswin_sdhci_delay_tuning(host, opcode);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = eswin_sdhci_phase_code_tuning(host, opcode);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void eswin_sdhci_set_uhs_signaling(struct sdhci_host *host,
> +					  unsigned int timing)
> +{
> +	u32 val;
> +	u32 status;
> +	u32 timeout = 0;
> +	u16 ctrl_2;
> +
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	/* Select Bus Speed Mode for host */
> +	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +	if ((timing == MMC_TIMING_MMC_HS200) ||
> +	    (timing == MMC_TIMING_UHS_SDR104))
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> +	else if (timing == MMC_TIMING_UHS_SDR12)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> +	else if (timing == MMC_TIMING_UHS_SDR25)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
> +	else if (timing == MMC_TIMING_UHS_SDR50)
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> +	else if ((timing == MMC_TIMING_UHS_DDR50) ||
> +		 (timing == MMC_TIMING_MMC_DDR52))
> +		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> +	else if (timing == MMC_TIMING_MMC_HS400)
> +		ctrl_2 |= ESWIN_SDHCI_CTRL_HS400; /* Non-standard */
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +	/*
> +	 * here need make dll locked when in hs400 at 200MHz
> +	 */
> +	if ((timing == MMC_TIMING_MMC_HS400) && (host->clock == 200000000)) {
> +		eswin_sdhci_disable_card_clk(host);
> +
> +		val = sdhci_readl(host, VENDOR_AT_CTRL_R);
> +		val &= ~(LATENCY_LT_MASK << LATENCY_LT_BIT_OFFSET);
> +		val |= (LATENCY_LT_3 << LATENCY_LT_MASK);
> +		sdhci_writel(host, val, VENDOR_AT_CTRL_R);
> +
> +		sdhci_writeb(host, 0x23, PHY_DLL_CNFG1_R);
> +		sdhci_writeb(host, 0x02, PHY_DLL_CNFG2_R);
> +		sdhci_writeb(host, 0x60, PHY_DLLDL_CNFG_R);
> +		sdhci_writeb(host, 0x00, PHY_DLL_OFFST_R);
> +		sdhci_writew(host, 0xffff, PHY_DLLBT_CNFG_R);
> +
> +		eswin_sdhci_enable_card_clk(host);
> +		sdhci_writeb(host, DLL_ENABEL, PHY_DLL_CTRL_R);
> +		udelay(100);
> +
> +		while (1) {
> +			status = sdhci_readb(host, PHY_DLL_STATUS_R);
> +			if (status & DLL_LOCK_STS) {
> +				pr_debug("%s: locked status:0x%x\n",
> +					 mmc_hostname(host->mmc), status);
> +				break;
> +			}
> +			timeout++;
> +			udelay(100);
> +			if (timeout > 10000) {
> +				pr_err("%s: DLL lock failed!status:0x%x\n",
> +				       mmc_hostname(host->mmc), status);
> +				return;
> +			}
> +		}
> +
> +		status = sdhci_readb(host, PHY_DLL_STATUS_R);
> +		if (status & DLL_ERROR_STS) {
> +			pr_err("%s: DLL lock failed!err_status:0x%x\n",
> +			       mmc_hostname(host->mmc), status);
> +		} else {
> +			pr_debug("%s: DLL lock is success\n",
> +				 mmc_hostname(host->mmc));
> +		}
> +	}
> +}
> +
> +static const struct cqhci_host_ops eswin_sdhci_cqhci_ops = {
> +	.enable = eswin_sdhci_cqe_enable,
> +	.disable = sdhci_cqe_disable,
> +	.dumpregs = eswin_sdhci_dumpregs,
> +};
> +
> +static const struct sdhci_ops eswin_sdhci_cqe_ops = {
> +	.set_clock = eswin_sdhci_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = eswin_sdhci_reset,
> +	.set_uhs_signaling = eswin_sdhci_set_uhs_signaling,
> +	.set_power = sdhci_set_power_and_bus_voltage,
> +	.irq = eswin_sdhci_cqhci_irq,
> +	.platform_execute_tuning = eswin_sdhci_executing_tuning,
> +	.dump_vendor_regs = eswin_sdhci_dump_vendor_regs,
> +};
> +
> +static const struct sdhci_pltfm_data eswin_sdhci_cqe_pdata = {
> +	.ops = &eswin_sdhci_cqe_ops,
> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +/**
> + * eswin_sdhci_suspend - Suspend method for the driver
> + * @dev:    Address of the device structure
> + *
> + * Put the device in a low power state.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int eswin_sdhci_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +		mmc_retune_needed(host->mmc);
> +
> +	ret = sdhci_suspend_host(host);
> +	if (ret)
> +		return ret;
> +
> +	clk_disable_unprepare(pltfm_host->clk);
> +	clk_disable_unprepare(eswin_sdhci->clk_ahb);
> +
> +	return 0;
> +}
> +
> +/**
> + * eswin_sdhci_resume - Resume method for the driver
> + * @dev:    Address of the device structure
> + *
> + * Resume operation after suspend
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int eswin_sdhci_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	ret = clk_prepare_enable(eswin_sdhci->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "can't enable clk_ahb\n");
> +		return ret;
> +	}
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(dev, "can't enable mainck\n");
> +		goto clk_ahb_disable;
> +	}
> +
> +	ret = sdhci_resume_host(host);
> +	if (ret) {
> +		dev_err(dev, "runtime resume failed!\n");
> +		goto clk_disable;
> +	}
> +
> +	return 0;
> +clk_disable:
> +	clk_disable_unprepare(pltfm_host->clk);
> +clk_ahb_disable:
> +	clk_disable_unprepare(eswin_sdhci->clk_ahb);
> +
> +	return ret;
> +}
> +
> +#endif /* ! CONFIG_PM_SLEEP */
> +
> +/**
> + * eswin_sdhci_sdcardclk_recalc_rate - Return the card clock rate
> + *
> + * @hw:         Pointer to the hardware clock structure.
> + * @parent_rate:        The parent rate (should be rate of clk_xin).
> + *
> + * Return the current actual rate of the SD card clock.  This can be used
> + * to communicate with out PHY.
> + *
> + * Return: The card clock rate.
> + */
> +static unsigned long
> +eswin_sdhci_sdcardclk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct eswin_sdhci_clk_data *clk_data =
> +		container_of(hw, struct eswin_sdhci_clk_data, sdcardclk_hw);
> +	struct eswin_sdhci_data *eswin_sdhci =
> +		container_of(clk_data, struct eswin_sdhci_data, clk_data);
> +	struct sdhci_host *host = eswin_sdhci->host;
> +
> +	return host->mmc->actual_clock;
> +}
> +
> +static const struct clk_ops eswin_sdcardclk_ops = {
> +	.recalc_rate = eswin_sdhci_sdcardclk_recalc_rate,
> +};
> +
> +/**
> + * eswin_sdhci_sampleclk_recalc_rate - Return the sampling clock rate
> + *
> + * @hw:         Pointer to the hardware clock structure.
> + * @parent_rate:        The parent rate (should be rate of clk_xin).
> + *
> + * Return the current actual rate of the sampling clock.  This can be used
> + * to communicate with out PHY.
> + *
> + * Return: The sample clock rate.
> + */
> +static unsigned long
> +eswin_sdhci_sampleclk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct eswin_sdhci_clk_data *clk_data =
> +		container_of(hw, struct eswin_sdhci_clk_data, sampleclk_hw);
> +	struct eswin_sdhci_data *eswin_sdhci =
> +		container_of(clk_data, struct eswin_sdhci_data, clk_data);
> +	struct sdhci_host *host = eswin_sdhci->host;
> +
> +	return host->mmc->actual_clock;
> +}
> +
> +static const struct clk_ops eswin_sampleclk_ops = {
> +	.recalc_rate = eswin_sdhci_sampleclk_recalc_rate,
> +};
> +
> +static const struct eswin_sdhci_clk_ops eswin_clk_ops = {
> +	.sdcardclk_ops = &eswin_sdcardclk_ops,
> +	.sampleclk_ops = &eswin_sampleclk_ops,
> +};
> +
> +static struct eswin_sdhci_of_data eswin_sdhci_fu800_data = {
> +	.pdata = &eswin_sdhci_cqe_pdata,
> +	.clk_ops = &eswin_clk_ops,
> +};
> +
> +static const struct of_device_id eswin_sdhci_of_match[] = {
> +	{
> +		.compatible = "eswin,eic7700-emmc-sdhci",
> +		.data = &eswin_sdhci_fu800_data,
> +	},
> +	{/* sentinel */}};
> +MODULE_DEVICE_TABLE(of, eswin_sdhci_of_match);
> +
> +/**
> + * eswin_sdhci_register_sdcardclk - Register the sdcardclk for a PHY to use
> + *
> + * @eswin_sdhci:    Our private data structure.
> + * @clk_xin:        Pointer to the functional clock
> + * @dev:        Pointer to our struct device.
> + *
> + * Some PHY devices need to know what the actual card clock is.  In order for
> + * them to find out, we'll provide a clock through the common clock framework
> + * for them to query.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int eswin_sdhci_register_sdcardclk(struct eswin_sdhci_data *eswin_sdhci,
> +					  struct clk *clk_xin,
> +					  struct device *dev)
> +{
> +	struct eswin_sdhci_clk_data *clk_data = &eswin_sdhci->clk_data;
> +	struct device_node *np = dev->of_node;
> +	struct clk_init_data sdcardclk_init;
> +	const char *parent_clk_name;
> +	int ret;
> +
> +	ret = of_property_read_string_index(np, "clock-output-names", 0,
> +					    &sdcardclk_init.name);
> +	if (ret) {
> +		dev_err(dev, "DT has #clock-cells but no clock-output-names\n");
> +		return ret;
> +	}
> +
> +	parent_clk_name = __clk_get_name(clk_xin);
> +	sdcardclk_init.parent_names = &parent_clk_name;
> +	sdcardclk_init.num_parents = 1;
> +	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
> +	sdcardclk_init.ops = eswin_sdhci->clk_ops->sdcardclk_ops;
> +
> +	clk_data->sdcardclk_hw.init = &sdcardclk_init;
> +	clk_data->sdcardclk = devm_clk_register(dev, &clk_data->sdcardclk_hw);
> +	if (IS_ERR(clk_data->sdcardclk))
> +		return PTR_ERR(clk_data->sdcardclk);
> +	clk_data->sdcardclk_hw.init = NULL;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_simple_get,
> +				  clk_data->sdcardclk);
> +	if (ret)
> +		dev_err(dev, "Failed to add sdcard clock provider\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * eswin_sdhci_register_sampleclk - Register the sampleclk for a PHY to use
> + *
> + * @eswin_sdhci:    Our private data structure.
> + * @clk_xin:        Pointer to the functional clock
> + * @dev:        Pointer to our struct device.
> + *
> + * Some PHY devices need to know what the actual card clock is.  In order for
> + * them to find out, we'll provide a clock through the common clock framework
> + * for them to query.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int eswin_sdhci_register_sampleclk(struct eswin_sdhci_data *eswin_sdhci,
> +					  struct clk *clk_xin,
> +					  struct device *dev)
> +{
> +	struct eswin_sdhci_clk_data *clk_data = &eswin_sdhci->clk_data;
> +	struct device_node *np = dev->of_node;
> +	struct clk_init_data sampleclk_init;
> +	const char *parent_clk_name;
> +	int ret;
> +
> +	ret = of_property_read_string_index(np, "clock-output-names", 1,
> +					    &sampleclk_init.name);
> +	if (ret) {
> +		dev_err(dev, "DT has #clock-cells but no clock-output-names\n");
> +		return ret;
> +	}
> +
> +	parent_clk_name = __clk_get_name(clk_xin);
> +	sampleclk_init.parent_names = &parent_clk_name;
> +	sampleclk_init.num_parents = 1;
> +	sampleclk_init.flags = CLK_GET_RATE_NOCACHE;
> +	sampleclk_init.ops = eswin_sdhci->clk_ops->sampleclk_ops;
> +
> +	clk_data->sampleclk_hw.init = &sampleclk_init;
> +	clk_data->sampleclk = devm_clk_register(dev, &clk_data->sampleclk_hw);
> +	if (IS_ERR(clk_data->sampleclk))
> +		return PTR_ERR(clk_data->sampleclk);
> +	clk_data->sampleclk_hw.init = NULL;
> +
> +	ret = of_clk_add_provider(np, of_clk_src_simple_get,
> +				  clk_data->sampleclk);
> +	if (ret)
> +		dev_err(dev, "Failed to add sample clock provider\n");
> +
> +	return ret;
> +}
> +
> +/**
> + * eswin_sdhci_unregister_sdclk - Undoes eswin_sdhci_register_sdclk()
> + *
> + * @dev:        Pointer to our struct device.
> + *
> + * Should be called any time we're exiting and eswin_sdhci_register_sdclk()
> + * returned success.
> + */
> +static void eswin_sdhci_unregister_sdclk(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +
> +	if (!of_find_property(np, "#clock-cells", NULL))
> +		return;
> +
> +	of_clk_del_provider(dev->of_node);
> +}
> +
> +/**
> + * eswin_sdhci_register_sdclk - Register the sdcardclk for a PHY to use
> + *
> + * @eswin_sdhci:    Our private data structure.
> + * @clk_xin:        Pointer to the functional clock
> + * @dev:        Pointer to our struct device.
> + *
> + * Some PHY devices need to know what the actual card clock is.  In order for
> + * them to find out, we'll provide a clock through the common clock framework
> + * for them to query.
> + *
> + * Note: without seriously re-architecting SDHCI's clock code and testing on
> + * all platforms, there's no way to create a totally beautiful clock here
> + * with all clock ops implemented.  Instead, we'll just create a clock that can
> + * be queried and set the CLK_GET_RATE_NOCACHE attribute to tell common clock
> + * framework that we're doing things behind its back.  This should be sufficient
> + * to create nice clean device tree bindings and later (if needed) we can try
> + * re-architecting SDHCI if we see some benefit to it.
> + *
> + * Return: 0 on success and error value on error
> + */
> +static int eswin_sdhci_register_sdclk(struct eswin_sdhci_data *eswin_sdhci,
> +				      struct clk *clk_xin, struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	u32 num_clks = 0;
> +	int ret;
> +
> +	/* Providing a clock to the PHY is optional; no error if missing */
> +	if (of_property_read_u32(np, "#clock-cells", &num_clks) < 0)
> +		return 0;
> +
> +	ret = eswin_sdhci_register_sdcardclk(eswin_sdhci, clk_xin, dev);
> +	if (ret)
> +		return ret;
> +
> +	if (num_clks) {
> +		ret = eswin_sdhci_register_sampleclk(eswin_sdhci, clk_xin, dev);
> +		if (ret) {
> +			eswin_sdhci_unregister_sdclk(dev);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int eswin_sdhci_add_host(struct eswin_sdhci_data *eswin_sdhci)
> +{
> +	struct sdhci_host *host = eswin_sdhci->host;
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	if (!eswin_sdhci->has_cqe)
> +		return sdhci_add_host(host);
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	cq_host = devm_kzalloc(host->mmc->parent, sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	cq_host->mmio = host->ioaddr + eswin_sdhci_CQE_BASE_ADDR;
> +	cq_host->ops = &eswin_sdhci_cqhci_ops;
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret)
> +		goto cleanup;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	sdhci_cleanup_host(host);
> +	return ret;
> +}
> +
> +static int eswin_sdhci_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct clk *clk_xin;
> +	struct sdhci_host *host;
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct device *dev = &pdev->dev;
> +	struct eswin_sdhci_data *eswin_sdhci;
> +	const struct eswin_sdhci_of_data *data;
> +	unsigned int val = 0;
> +
> +	data = of_device_get_match_data(dev);
> +	host = sdhci_pltfm_init(pdev, data->pdata, sizeof(*eswin_sdhci));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	eswin_sdhci->host = host;
> +	eswin_sdhci->clk_ops = data->clk_ops;
> +
> +	eswin_sdhci->clk_ahb = devm_clk_get(dev, "clk_ahb");
> +	if (IS_ERR(eswin_sdhci->clk_ahb)) {
> +		ret = dev_err_probe(dev, PTR_ERR(eswin_sdhci->clk_ahb),
> +				    "clk_ahb clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	clk_xin = devm_clk_get(dev, "clk_xin");
> +	if (IS_ERR(clk_xin)) {
> +		ret = dev_err_probe(dev, PTR_ERR(clk_xin),
> +				    "clk_xin clock not found.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	ret = clk_prepare_enable(eswin_sdhci->clk_ahb);
> +	if (ret) {
> +		dev_err(dev, "Unable to enable AHB clock.\n");
> +		goto err_pltfm_free;
> +	}
> +
> +	ret = clk_prepare_enable(clk_xin);
> +	if (ret) {
> +		dev_err(dev, "Unable to enable SD clock.\n");
> +		goto clk_dis_ahb;
> +	}
> +
> +	ret = eswin_sdhci_reset_init(dev, eswin_sdhci);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to reset\n");
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci->crg_regmap = syscon_regmap_lookup_by_phandle(
> +		pdev->dev.of_node, "eswin,syscrg_csr");
> +	if (IS_ERR(eswin_sdhci->crg_regmap)) {
> +		dev_dbg(&pdev->dev, "No syscrg_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 1, &eswin_sdhci->crg_core_clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_core_clk (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 2, &eswin_sdhci->crg_aclk_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_aclk_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,syscrg_csr",
> +					 3, &eswin_sdhci->crg_cfg_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get crg_cfg_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	eswin_sdhci->hsp_regmap = syscon_regmap_lookup_by_phandle(
> +		dev->of_node, "eswin,hsp_sp_csr");
> +	if (IS_ERR(eswin_sdhci->hsp_regmap)) {
> +		dev_dbg(dev, "No hsp_sp_csr phandle specified\n");
> +		goto clk_disable_all;
> +	}
> +
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 2, &eswin_sdhci->hsp_int_status);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_int_status (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +	ret = of_property_read_u32_index(pdev->dev.of_node, "eswin,hsp_sp_csr",
> +					 3, &eswin_sdhci->hsp_pwr_ctrl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "can't get hsp_pwr_ctrl (%d)\n", ret);
> +		goto clk_disable_all;
> +	}
> +
> +	regmap_write(eswin_sdhci->hsp_regmap, eswin_sdhci->hsp_int_status,
> +		     MSHC_INT_CLK_STABLE);
> +	regmap_write(eswin_sdhci->hsp_regmap, eswin_sdhci->hsp_pwr_ctrl,
> +		     MSHC_HOST_VAL_STABLE);
> +
> +	if (!of_property_read_u32(dev->of_node, "delay_code", &val))
> +		eswin_sdhci->phy.delay_code = val;
> +
> +	if (!of_property_read_u32(dev->of_node, "drive-impedance-ohm", &val))
> +		eswin_sdhci->phy.drive_impedance =
> +			eswin_convert_drive_impedance_ohm(pdev, val);
> +
> +	if (of_property_read_bool(dev->of_node, "enable-cmd-pullup"))
> +		eswin_sdhci->phy.enable_cmd_pullup = ENABLE;
> +	else
> +		eswin_sdhci->phy.enable_cmd_pullup = DISABLE;
> +
> +	if (of_property_read_bool(dev->of_node, "enable-data-pullup"))
> +		eswin_sdhci->phy.enable_data_pullup = ENABLE;
> +	else
> +		eswin_sdhci->phy.enable_data_pullup = DISABLE;
> +
> +	if (of_property_read_bool(dev->of_node, "enable-strobe-pulldown"))
> +		eswin_sdhci->phy.enable_strobe_pulldown = ENABLE;
> +	else
> +		eswin_sdhci->phy.enable_strobe_pulldown = DISABLE;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	pltfm_host->clk = clk_xin;
> +
> +	ret = eswin_sdhci_register_sdclk(eswin_sdhci, clk_xin, dev);
> +	if (ret)
> +		goto clk_disable_all;
> +
> +	eswin_sdhci_dt_parse_clk_phases(dev, &eswin_sdhci->clk_data);
> +
> +	ret = mmc_of_parse(host->mmc);
> +	if (ret) {
> +		ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
> +		goto unreg_clk;
> +	}
> +
> +	if (of_device_is_compatible(dev->of_node, "eswin,sdhci-5.1")) {
> +		host->mmc_host_ops.hs400_enhanced_strobe =
> +			eswin_sdhci_hs400_enhanced_strobe;
> +		eswin_sdhci->has_cqe = true;
> +		host->mmc->caps2 |= MMC_CAP2_CQE;
> +
> +		if (!of_property_read_bool(dev->of_node, "disable-cqe-dcmd"))
> +			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
> +	}
> +
> +	sdhci_enable_v4_mode(eswin_sdhci->host);
> +
> +	ret = eswin_sdhci_add_host(eswin_sdhci);
> +	if (ret)
> +		goto unreg_clk;
> +
> +	return 0;
> +
> +unreg_clk:
> +	eswin_sdhci_unregister_sdclk(dev);
> +clk_disable_all:
> +	clk_disable_unprepare(clk_xin);
> +clk_dis_ahb:
> +	clk_disable_unprepare(eswin_sdhci->clk_ahb);
> +err_pltfm_free:
> +	sdhci_pltfm_free(pdev);
> +	return ret;
> +}
> +
> +static void eswin_sdhci_remove(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct eswin_sdhci_data *eswin_sdhci = sdhci_pltfm_priv(pltfm_host);
> +	struct clk *clk_ahb = eswin_sdhci->clk_ahb;
> +
> +	sdhci_pltfm_remove(pdev);
> +
> +	if (eswin_sdhci->txrx_rst) {
> +		ret = reset_control_assert(eswin_sdhci->txrx_rst);
> +		WARN_ON(ret != 0);
> +	}
> +
> +	if (eswin_sdhci->phy_rst) {
> +		ret = reset_control_assert(eswin_sdhci->phy_rst);
> +		WARN_ON(ret != 0);
> +	}
> +
> +	if (eswin_sdhci->prstn) {
> +		ret = reset_control_assert(eswin_sdhci->prstn);
> +		WARN_ON(ret != 0);
> +	}
> +
> +	if (eswin_sdhci->arstn) {
> +		ret = reset_control_assert(eswin_sdhci->arstn);
> +		WARN_ON(ret != 0);
> +	}
> +	eswin_sdhci_unregister_sdclk(&pdev->dev);
> +	clk_disable_unprepare(clk_ahb);
> +}
> +
> +static void emmc_hard_reset(struct sdhci_host *host)
> +{
> +	unsigned int val;
> +
> +	val = sdhci_readw(host, VENDOR_EMMC_CTRL_R);
> +	val |= EMMC_RST_N_OE;
> +	sdhci_writew(host, val, VENDOR_EMMC_CTRL_R);
> +	val &= ~EMMC_RST_N;
> +	sdhci_writew(host, val, VENDOR_EMMC_CTRL_R);
> +	mdelay(20);
> +	val |= EMMC_RST_N;
> +	sdhci_writew(host, val, VENDOR_EMMC_CTRL_R);
> +}
> +
> +static void eswin_sdhci_shutdown(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	if (!host)
> +		return;
> +
> +	emmc_hard_reset(host);
> +	host->ops->reset(host, SDHCI_RESET_ALL);
> +	platform_set_drvdata(pdev, NULL);
> +}
> +
> +static const struct dev_pm_ops eswin_sdhci_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(eswin_sdhci_suspend, eswin_sdhci_resume)};
> +
> +static struct platform_driver eswin_sdhci_driver = {
> +	.driver = {
> +		.name = "sdhci-eic7700",
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +		.of_match_table = eswin_sdhci_of_match,
> +		.pm = &eswin_sdhci_pmops,
> +	},
> +	.probe = eswin_sdhci_probe,
> +	.remove = eswin_sdhci_remove,
> +	.shutdown = eswin_sdhci_shutdown,
> +};
> +
> +module_platform_driver(eswin_sdhci_driver);
> +
> +MODULE_DESCRIPTION("Driver for the ESWIN SDHCI Controller");
> +MODULE_AUTHOR("Shuang Liang <liangshuang@eswincomputing.com>");
> +MODULE_AUTHOR("Xuyang Dong <dongxuyang@eswincomputing.com>");
> +MODULE_LICENSE("GPL");

