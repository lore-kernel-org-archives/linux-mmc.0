Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95373812DB;
	Tue,  6 Oct 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269949; cv=fail; b=g4uNMdaUh9r1IAX3GFpE8cR5c8sLr0W7VivgJkCaUFLZzuaxWohTDTWxhJGoucVDbzwp5MHFIc4b2OueFdsMa2OREwsAbLFyfX8XuPuf/x3o43twk/bMATpAdlNgdShLG2Esbu6VG24lW4SoDXfX9SbZMO2D2AyYADgPqRqxJbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269949; c=relaxed/simple;
	bh=qT6MauEJV8cuxD85SNq2gyRw96m0PCCbiE5T0aPfNFo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CZWosRIY8GL7PVZ54DJoqJH4pS8bjIL4VGN/8TEPXHxjooueYFnJDPbeivx193O2+I7V2nH7dbVQUZ6w+s+QlgV3vZ2mvfGIiBAomb0Up+s69DrnhQapX1OImaMXZxlpoeUVR3l3Ac4GC7+99odN8dAI+IS7CuTqWdnw2ZQLQzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpyD33nt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpyD33nt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791269947; x=1822805947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qT6MauEJV8cuxD85SNq2gyRw96m0PCCbiE5T0aPfNFo=;
  b=jpyD33ntUWjX6820+Gq1lMaXT8B71CeDahLxcmiOsbGMxV7QG+KxHWPP
   X7v0hS9ouWR90AlF0PQokGrzYoFfR+Gz8nLaBumbd6QhbD7DVN6fCPu5U
   4lOY7ljbzTh90HA+KZkuIVaoodj7gZ7Nn0aq5bezHROYCaIPO9zD+Kwkz
   jC96A1InCIPZ3GmbtaRDOcTgE12i7RuHF9zA9rhrtSRGahty1+s8GZysY
   4yrZFNXY/83fQeKzqiOJhgtkd8Bsf3ItrT5CHujxqaaVop6wyT15brJus
   t6osnIyjTc0YonEiain4ga94c3G+HgyakUY9yhrSsweAr7EqtPnn6huSV
   w==;
X-CSE-ConnectionGUID: CLVR7zRORVWxdfrBlYvEQg==
X-CSE-MsgGUID: b8doNBGrSnSedBeZPVtgkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="109440238"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="109440238"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 23:59:06 -0700
X-CSE-ConnectionGUID: SVYwIWyvSAGAEAu/lLsCTQ==
X-CSE-MsgGUID: h7U9bYeFS86UzSP5SBEViA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280360607"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 23:59:06 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 23:59:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 23:59:04 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 23:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxDlHBYnAdoFJrhAKhd12pjKWZfNio1aB26rLclEjcKDMwIuFKGQpS4iNdQ5Bjo/Ru7WttkxHuCk5J/D20a2TJPCtt1DRurB6SxyQzJciJ2qlRxtC/7kNc9DNcDidWodr+NhWIOExWgszzySqSN7zK1rKwyLq/2XuZDVUWRBoxdhO6itARkVn3sJfaeI1gPKJnvFy4TI/pItY04a/HNIH85/pKzVrog8NjKF9W8b7lowQor2OnJ7wbJhvGu5iiaFYDpeMvxI+uOSOEWqd/O6jcJ+mpysSsRPKnK0dk7Q2X/9B53fh9dAj34h/yDMXWbG1/tjsX4I4DaEbJhuu0TQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BabfzHiqQagtgsl8VtBOhSsMzrIZTGiB5A+HQT/5khA=;
 b=S7sXfbvP3j3K/FyzIjoulQ0l1KEvNvUTsMHHVgl7VJ9GlG8LtZl2mfTErxNG1tfGfAgtHabjJwb5zeQ8WtBD9TuDFqHxW4xA05j28mKUdP2vKrcK2o60PT/VW79ZEv8FWiI8Kh81eRFf7O6Az0DFOvJwSwDv9kqBHoLs9pvx/H5pNbrEq+E2j03R1cXV9R/+r8wWw9DifAokf6kSJ8ikfCQS8XrdClZRLc5Mqzi3rXvnCh5gR2nAADzEzOYrP7JlzUViHiTF0CbnEXIsY0651kygOvgdwKjIuOG29X9q+PALkzG20AmhtpRdQ2JGwTs2RsKIjXlat0UN/O4mzqkLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by BL1PR11MB5253.namprd11.prod.outlook.com (2603:10b6:208:310::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 06:58:57 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 06:58:57 +0000
Message-ID: <b79f1b5c-9fc7-4138-a6ec-e82571307622@intel.com>
Date: Tue, 6 Oct 2026 09:58:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: Add support for StarFive
 JHB100
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Inochi Amaoto
	<inochiama@gmail.com>, Chen Wang <chen.wang@linux.dev>, Jisheng Zhang
	<jszhang@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <sophgo@lists.linux.dev>, Philipp Zabel
	<p.zabel@pengutronix.de>
References: <20260930103258.13375-1-changhuang.liang@starfivetech.com>
 <20260930103258.13375-3-changhuang.liang@starfivetech.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260930103258.13375-3-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0201.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|BL1PR11MB5253:EE_
X-MS-Office365-Filtering-Correlation-Id: 074f635b-4eb9-4ab4-8150-08df23774a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|10067099003|5023799004|4143699003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CeaxXglgkR1/GQjuGw5/w6cjVHU3N/qTYzVPdcD3qkaWc/7m201g5uAPG6FupjOLgr0D/k+GUxU4+EoVow1/vs4LgZmVRleu55IoHyQ7fsSdCxVbi55mJwQdG8M/kIejF4g0taKUdRY4U9VpK2XYVqYPbzZ/2hmTblnwzPi3vdGLIOQmlsEB7/ZOssKon31zDfVTV/jHpWV/LC3O+I+HHdaBm6OQXaQaI91JF/Bv/IbV3H6XSfMOOWwRsmKKrN18VA8l45lS0EED2txXd0PiXjQmC7jepSx2W8EgGUoa+v52bGRj5d3m6kPD/OawUr9YmJt51sRJkhd7IJbrHh1I0T+aPHaFi/L/mfyljYNW0BaKVPDk9Zu5HKsJSnXblu5J/Br9EF/bNaRot2oOzbfTNYb07QVDsOJwFctXp4H0/4heFqNZ18oGUKmTe3uutS856VVV+nBHL4exc9cLvSYsjIITiGCRJFTnmnjdUiKNcxC4VUK0EJuU8jmqJijYzJVCdX9TZFSNaRgwvjLGVxbI5tFt3v6Y5553+QA6nn2nXRhQyDkpmX4g40byOccyPLESI7imdA3MDscpW5YOqRSKdZI9B51SdTQilbF8n5BUSYGlYc/xe0mdmcEb0dtXDw9UgRm2jmjpQjHIO3Dz3UxNr+HKR18WbDQpjZEmpjysn/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10067099003)(5023799004)(4143699003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhDUGQ1a3A3cjRzdE5wbHZOK0lBaGVLemJXYy9YRThPam9lOWNaRkNrRGdy?=
 =?utf-8?B?NVhYaHUyVEF1anBIUG1wdHFaQ08vMjhERDNUdjFBeVFjbk1kajVqR21QQlJ1?=
 =?utf-8?B?cHZJVVoyaDZnUmlwQ0NLajUrN1FXYWh6SkprNWthdXdiS0g1WjVzekljTEdT?=
 =?utf-8?B?d1hSMlVEb3RxdmFITFdYei9LeHRUTC85VjZZREJucHpLRGJEQkhwVG02NkJw?=
 =?utf-8?B?b21FeWdpWUFWZTJsMXg3LzEvbEtlRHVSK2wrY3pPOEhsdW9vSmtvcmY2Skwv?=
 =?utf-8?B?cVFJS25wZU9jNHpLNE5FMXpacGV6SGwvdnpKVUhoVEgzWHFUQ3BzNUZFNGVC?=
 =?utf-8?B?NnkrSnpPUTVHWmNhWVoxZ3FncnZtYXAvM3NKVHpvZkhyUjZpR2dob0gyckFn?=
 =?utf-8?B?NG0vNy9wcE9xNFhLMkJJbGFzVkhGZ1hHMHJ1YmhVZmx1Zm90ZDh4Nk5USzNY?=
 =?utf-8?B?VjY3b0R4blljZlJHZW82Nmk1TFZBSG9pMm1nVlFDanNwYVI0TkRrNnY3MDk3?=
 =?utf-8?B?S0ZseFhPZEwwT0hHWE03RVF4dHZHK1B5aWZXVk4zOWRKTmZpV0Ird1dWQkNQ?=
 =?utf-8?B?YUdCTnloMHYrOThQZ2FOSXlWdjdONE11clcrQWtHZkNwalFzWjRObVlJLzdr?=
 =?utf-8?B?TXFaNUV3dGhha1FhbnRPL2x1OUs5UFRDYXYxOFExL2VLS3JJQXFsREhiRlBu?=
 =?utf-8?B?aU1xVzJBZXFJb3Vwb3EwSVRicU5ySmZHVzBtenZpZ1lLazU2UHlPcDVTZzJ3?=
 =?utf-8?B?THRwU2hBZWVaTDJJLzB2dFpVZmw1TWNqL091aHZWVElNVHNFcnc5Y283Y1B4?=
 =?utf-8?B?OHZaZmU0R05jUThnK2o3RVJTQWFmdXVmOGdzNUQ4cEtjcitNV1F2dWhWUWE1?=
 =?utf-8?B?aUErS1F2WEpUQzRVcnBwd3JPU1hxUnJ5YmZiWTM3YTF2QjY1QXlVYS9IYXdI?=
 =?utf-8?B?RkhmWXVzcU1qSWZCbHRBQk4zUnBJTG1GOFhiRkRqd0F5U0dmRUNlaUNJdFgy?=
 =?utf-8?B?SHROSVNiaUhXUDRCYzZPMmhLaVBhS05qYUVZck9ZWDkzWVgzNHRNQ3JpZ3l2?=
 =?utf-8?B?VzVvMlp3aWhpUnZLbmdEVEMzN3EyZHJJY01JT1V5TFcxQUR1SjJuOGFsSXpK?=
 =?utf-8?B?VkNVbVpiWHhQOXF4NVN1bHAyNUtDM3l0cjMxZ3BJOXA4NkJ2WDRibGppZjdw?=
 =?utf-8?B?dGpEVUlIbzU5WWxIMGcwbU9udVJOZWJCb0FleFcwS28xUTE4RU5BTEtuNWEz?=
 =?utf-8?B?N3RxL2VwVE9SVjg2R0xmT2t1N2RqQkVFYjJ3cE5idXFLSDBpUVBRR0hpNEZ4?=
 =?utf-8?B?Yk1CRU5MbDhWODlUb2EwdGlvK2krMDVLY0xTaWJ2TGVRc3VieThjaGQrZjd1?=
 =?utf-8?B?eTRFUEtxck12K1NPc1lNSXNIRUNmRmZLK2o1ckw1SXdVWkF6UHVzclRnMWxx?=
 =?utf-8?B?eDFGallqN1BBLytQSmpMRmhWOUNEN0FKSmx5MkFVT1JjL0hDNjZnYm4yZXRl?=
 =?utf-8?B?S3N6aHlRTkdiZkI4L3p3SnZBS0VwOEdoL1pIL1YrVkRBMDN3RnVEanQ5eVlR?=
 =?utf-8?B?VEczdFBLSzZQSWRIanNHUlIxZjdWa3E4Ly9KYWg4SW5XamcvcFpTYzFmbnJz?=
 =?utf-8?B?UUVQYjhTVXg1UzlNeDBMTzdsSmFHQVdrdVlubUNCZ3RTTjhodERWYStDS2RQ?=
 =?utf-8?B?cFpJODVGZEIwcWhNTEp1aFVzaGlUYVNPM0NSZE1qWUx1bllZVmp2VmpKOStm?=
 =?utf-8?B?R1d3UVB4TFJuQnFWN1R2UWJyMXZYMHZ3VzNBNjdPTDJ6Skt6YUlwTlZoKzdL?=
 =?utf-8?B?bzdnWTZObTFVUG54VXJrN3ZtUlBYNENjQTVNaTlkQnZXYXZ6OWdnd1RQc2hY?=
 =?utf-8?B?aUpSKzU4OWVZSjhjRmhiNDlFb2ZDcDczTmFpMVROYm5tT0RFTkh1SnFTaVRU?=
 =?utf-8?B?UGNRT2duV3V1M0ZRU0xBalF2L1FqMXh2cE1sQUFOVWtxNnNuWUhZdEREWi9l?=
 =?utf-8?B?Rjg0UHN5NklUVGFYblF5d09FV3hqbHpJeDhOelMyRHg4aGNhcW93WnFLbUpo?=
 =?utf-8?B?VVhYUUlCYlQyTXY0K1ZuVW11Q0NWV3FzL2dQTU9BcHhMU2dLM3E1TlI2Y1h2?=
 =?utf-8?B?amJZTW55Wkt1WlJTdlRHTVpjVEpXOFVNa29hMHh4UTY5SWR2aVpSNm1NUy9L?=
 =?utf-8?B?VHN3OVZreTlmS25MeDlmZ2I1d0RzcDdnTVZuVU5sRHVZZS9aWEN2NGdWdGcv?=
 =?utf-8?B?NmMzdERKUzdtbzRlbnZvTEZndkk5ZWcvTm1PQkpyWjhIWlo2OGd1TU1oQXFZ?=
 =?utf-8?B?SGRQLytFdzQ2NklzZTFzVUdZSkJzZWFTOUJrbWYzMy9WTHBUUjZZSU10MWF2?=
 =?utf-8?Q?IW4CV5ckR4yS5Mc4=3D?=
X-Exchange-RoutingPolicyChecked: TKRdDeWwAxx8kNd5iLX2NNuoFRl2JXafkYytASSXmFD645aXawhYUlrbGP7+t3kSvwcOncEKu4z0wyzmKVyfeUV9moLvUCz/0eKvGvsnMqcIBcguN1jT2LBp4yzC3geeXYssfS6YT/msdBcsG5qZMxUk3FsJJp7HMFWRyTtg0ZNDRPj706xILc7sYauroF40EC1rN6ZoPJ1k2/thnN5S+aqKBehWy4RDfqWgkkSp6Zmq653vuOHiukogwgoIRNdZ+9+hKabL57kAXW8KHvbYBKFv7GR4BtjPqahjNtZlRIgLrI8M6OQ1fMv/QER6H0RmY1icuDf5MKyArPC3G0P4JQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 074f635b-4eb9-4ab4-8150-08df23774a98
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 06:58:57.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KD9zherAWptk0rPSXJkKollhY6lEpxXk61zQamlptuTdIVgYI3zpk8XrNv3eTeHeLZpQGGpjzIILVmIfYXg3VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5253
X-OriginatorOrg: intel.com

On 30/09/2026 13:32, Changhuang Liang wrote:
> Add support for the DWCMSHC controller found on the StarFive JHB100
> SoC.
> 
> The JHB100 CMSHC controller only drives 32 DMA address bits. The higher
> DMA address bits [35:32] are supplied by the PER1 SYSCON, so the DMA
> mask is set to 36 bits to describe this hardware capability. Fix these
> bits to 4, which limits the DMA range to [0x400000000 - 0x4ffffffff].
> The dma-ranges of the parent bus are expected to restrict DMA to this
> window, so that any address outside of it fails to map instead of
> being passed to the hardware.
> 
> The cclk_tx clock must be disabled before sdhci_set_clock() to
> eliminate glitches, and re-enabled afterwards unless the card clock is
> turned off, so that cclk_tx stays gated during suspend. The 15us delay
> after disabling cclk_tx is a JHB100 specific requirement from the SoC
> simulation. cclk_tx is enabled during probe and disabled in the
> platform deinit callback, which is invoked from dwcmshc_remove().
> 
> Additionally, clear the PHY_DLLDL_CNFG_R register and re-initialize
> the PHY when setting UHS signaling, and force 1.8V fixed I/O when the
> DT specifies a DDR/HS200/HS400 1.8V mode.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 169 ++++++++++++++++++++++++++++
>  1 file changed, 169 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1baa2379c9c3..249055f14162 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -48,6 +48,9 @@
>  #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>  #define DWCMSHC_EMMC_ATCTRL		0x40
>  #define DWCMSHC_AT_STAT			0x44
> +/* StarFive JHB100 SoC MSHCCS register */
> +#define DWCMSHC_ARWADDR			GENMASK(3, 0)
> +#define DWCMSHC_ARWADDR_DEFAULT		4
>  /* Tuning and auto-tuning fields in AT_CTRL_R control register */
>  #define AT_CTRL_AT_EN			BIT(0) /* autotuning is enabled */
>  #define AT_CTRL_CI_SEL			BIT(1) /* interval to drive center phase select */
> @@ -184,6 +187,7 @@
>  #define PHY_SDCLKDL_DC_INITIAL		0x40 /* initial delay code */
>  #define PHY_SDCLKDL_DC_DEFAULT		0x32 /* default delay code */
>  #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
> +#define PHY_SDCLKDL_DC_JHB100		0x10 /* delay code for StarFive JHB100 */
>  
>  #define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
>  #define PHY_SMPLDL_CNFG_EXTDLY_EN	BIT(0)
> @@ -294,6 +298,11 @@ struct k230_priv  {
>  	struct regmap *hi_sys_regmap;
>  };
>  
> +struct jhb100_priv {
> +	struct clk *cclk_tx;
> +	bool cclk_tx_on;
> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>  
>  struct dwcmshc_priv {
> @@ -314,6 +323,7 @@ struct dwcmshc_pltfm_data {
>  	const struct sdhci_pltfm_data pdata;
>  	const struct cqhci_host_ops *cqhci_host_ops;
>  	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	void (*deinit)(struct dwcmshc_priv *dwc_priv);
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>  
> @@ -2257,6 +2267,155 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
>  	.init = dwcmshc_hpe_gsc_init,
>  };
>  
> +static int sdhci_jhb100_set_dma_mask(struct sdhci_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	struct device *dev = mmc_dev(mmc);
> +	int ret;
> +
> +	/*
> +	 * The StarFive JHB100's CMSHC controller only drives 32 DMA address
> +	 * bits, the higher DMA address bits [35:32] are supplied by the
> +	 * ARWADDR field in the PER1 SYSCON. The 36-bit mask describes this
> +	 * hardware capability. As ARWADDR is fixed to 4, the controller can
> +	 * only reach [0x400000000 - 0x4ffffffff]. The dma-ranges of the
> +	 * parent bus must restrict DMA to this window, so that any address
> +	 * outside of it fails to map and is never passed to the hardware.
> +	 */
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> +	if (ret)
> +		dev_err(dev, "Failed to set 36-bit DMA mask.\n");
> +
> +	return ret;
> +}
> +
> +static void sdhci_jhb100_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	struct jhb100_priv *priv = dwc_priv->priv;
> +
> +	/*
> +	 * The cclk_tx clock is disabled before sdhci_set_clock(), and then a
> +	 * 15us delay is required, This delay is determined by SoC simulation
> +	 * and is a special requirement on JHB100 SoC, mainly used to eliminate
> +	 * glitches caused by frequency switching.
> +	 */
> +	if (priv->cclk_tx_on) {
> +		clk_disable_unprepare(priv->cclk_tx);
> +		priv->cclk_tx_on = false;
> +		fsleep(15);
> +	}
> +
> +	sdhci_set_clock(host, clock);
> +
> +	/* keep cclk_tx gated while the card clock is off, e.g. during suspend */
> +	if (!clock)
> +		return;
> +
> +	if (clk_prepare_enable(priv->cclk_tx))
> +		dev_err(mmc_dev(host->mmc), "failed to re-enable cclk_tx\n");
> +	else
> +		priv->cclk_tx_on = true;
> +}
> +
> +static void sdhci_jhb100_set_uhs_signaling(struct sdhci_host *host,
> +					   unsigned int timing)
> +{
> +	dwcmshc_set_uhs_signaling(host, timing);
> +	sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
> +	th1520_sdhci_set_phy(host);
> +}
> +
> +static const struct sdhci_ops starfive_jhb100_ops = {
> +	.set_dma_mask		= sdhci_jhb100_set_dma_mask,
> +	.set_clock		= sdhci_jhb100_set_clock,
> +	.set_uhs_signaling	= sdhci_jhb100_set_uhs_signaling,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= dwcmshc_reset,
> +	.get_max_clock		= dwcmshc_get_max_clock,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
> +	.voltage_switch		= dwcmshc_phy_init,
> +	.platform_execute_tuning = th1520_execute_tuning,
> +};
> +
> +static int dwcmshc_starfive_jhb100_init(struct device *dev, struct sdhci_host *host,
> +					struct dwcmshc_priv *dwc_priv)
> +{
> +	struct reset_control *reset;
> +	struct jhb100_priv *priv;
> +	unsigned int reg_offset;
> +	struct regmap *syscon;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct jhb100_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	syscon = syscon_regmap_lookup_by_phandle_args(dev->of_node,
> +						      "starfive,jhb100-per1-syscon",
> +						      1, &reg_offset);
> +	if (IS_ERR(syscon))
> +		return PTR_ERR(syscon);
> +
> +	/* configure the higher DMA address bits [35:32] */
> +	ret = regmap_update_bits(syscon, reg_offset, DWCMSHC_ARWADDR,
> +				 DWCMSHC_ARWADDR_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	reset = devm_reset_control_get_exclusive_deasserted(mmc_dev(host->mmc), NULL);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(reset),
> +				     "Failed to get&deassert reset control\n");
> +
> +	priv->cclk_tx = devm_clk_get(dev, "cclk_tx");
> +	if (IS_ERR(priv->cclk_tx))
> +		return dev_err_probe(dev, PTR_ERR(priv->cclk_tx),
> +				     "Failed to get cclk_tx clock\n");
> +
> +	ret = clk_prepare_enable(priv->cclk_tx);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable cclk_tx clock\n");
> +
> +	priv->cclk_tx_on = true;
> +
> +	if (host->mmc->caps & MMC_CAP_1_8V_DDR ||
> +	    host->mmc->caps2 & (MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR))
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	else
> +		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
> +
> +	dwc_priv->delay_line = PHY_SDCLKDL_DC_JHB100;
> +	dwc_priv->priv = priv;
> +
> +	if (dwc_priv->flags & FLAG_IO_FIXED_1V8) {
> +		host->flags &= ~SDHCI_SIGNALING_330;
> +		host->flags |=  SDHCI_SIGNALING_180;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dwcmshc_starfive_jhb100_deinit(struct dwcmshc_priv *dwc_priv)
> +{
> +	struct jhb100_priv *priv = dwc_priv->priv;
> +
> +	if (priv->cclk_tx_on)
> +		clk_disable_unprepare(priv->cclk_tx);
> +}
> +
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
> +	.pdata = {
> +		.ops = &starfive_jhb100_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
> +	.init = dwcmshc_starfive_jhb100_init,
> +	.deinit = dwcmshc_starfive_jhb100_deinit,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -2377,6 +2536,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  		.compatible = "hpe,gsc-dwcmshc",
>  		.data = &sdhci_dwcmshc_hpe_gsc_pdata,
>  	},
> +	{
> +		.compatible = "starfive,jhb100-dwcmshc",
> +		.data = &sdhci_dwcmshc_jhb100_pdata,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> @@ -2503,6 +2666,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_rpm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
> +	if (pltfm_data->deinit)
> +		pltfm_data->deinit(priv);
>  err_bus_clk:
>  	clk_disable_unprepare(priv->bus_clk);
>  err_clk:
> @@ -2527,6 +2692,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	const struct dwcmshc_pltfm_data *pltfm_data = priv->dwcmshc_pdata;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -2534,6 +2700,9 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  
>  	sdhci_remove_host(host, 0);
>  
> +	if (pltfm_data->deinit)
> +		pltfm_data->deinit(priv);
> +
>  	dwcmshc_disable_card_clk(host);
>  
>  	clk_disable_unprepare(pltfm_host->clk);

