Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623573AE6F5;
	Thu, 24 Sep 2026 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232126; cv=fail; b=sMhEpV4136NsqKXCDZPsbkpm1Einh9pbSjQ17tjvruKoOzWm0g070Txpu8FBJfuchg5+PM0prJBeP9aix2RyFCIA0SJY8w5jHYI2T351yvwMPWtKCrUYJG+mex5jsWrxZ7G8lwpu7zCby7ZnxjHhlFSapL7FuCg7wqpOylhkWs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232126; c=relaxed/simple;
	bh=x/iViHf7etk9rxElU/XeEBVjv1jv4Hwl3Zh/YLaDP0o=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=giW04qLbyLLRFs/RejaUax5NC9fUUBimijzLGLbtIGU/LvrGI7+m8iQ54ve/W6WkEYN/2pvj4Xc8AJTtNkXCSD0JMitNjhzHMarJMr8ALquRFZfT/14NGLva3e79KZwHqImO2h9I2h4LV++wV8iB0ambkLxlp5E7JRO89nOnsTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnmlxdBv; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnmlxdBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232123; x=1821768123;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=x/iViHf7etk9rxElU/XeEBVjv1jv4Hwl3Zh/YLaDP0o=;
  b=DnmlxdBvBnd0tmiNHy5kA7Ur0HSZXf3u6+oBC4uBGpSQTAu+nGIo49Ld
   9XOpV7taKoMWuOazIcMAvnWVPGAFz1iU1nnMZ/NQsxiwD7bv5vP4yOYqh
   5wCWPMdzhwyJFPxPA5hSt1UdY78FfRDG36jNeX5J+q5vniXeD20iD3ebM
   cdC2jEHuk4rlb2iImPwGqQbXo54w0aediT0ZZOMp+fwhuTZibaqXXFTSo
   DOLW/oeX839ehsx9GLr3u5FCnkq1EW1PAworTKrL1pEGoWwo2KLFIagAp
   Nh9h2snXCl/yD9skmUSv07axewKLG3I3ToraC78JjQalPs9KcDCoFD9bU
   Q==;
X-CSE-ConnectionGUID: nFivseuRR+CW8Wk6Qu7Nuw==
X-CSE-MsgGUID: qeEqdQjUThqG5Ff7WPhM3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91097996"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91097996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:42:02 -0700
X-CSE-ConnectionGUID: 2+QbSWhhSC+xN5c8l4SmMQ==
X-CSE-MsgGUID: AEVcfNT1RbSMkmMIXGwomA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273129040"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:42:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:42:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 23:42:01 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eupzYqccynMTl87UK8omv1sylMvUKy+nXNdXKlpTjF6V2iMsDHxGFgYAZqHmQktIBk9akv6pQIFnRTq1kP8TkLxisNHs2OmGttkfpxBGWCvIycNPE3N4dsRPvwzhNXDhUvBYajQXq4RnDGnl6lariAraZr25raO/ZHrt6k4zaeTcx62pPCzZOLYhn4PZS+a8bZ06P7HDGmvDcSFpxk7mFLmLSOJbo+mdB+6JMW4fWU0Hia5z+bbRw+3Kw+MCEJGMs+nEHEeJp17XP25b5VXCEuDHnDT53ZTw7i7L1b9HCtJJILmUCBqoahfEVu9Qgr4SuYUZJ3VE+Ttx0DUrTftgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF10ZOg84CR2qtOE0uO29v3NCWXl9Mw+3JHZ8G75oxw=;
 b=bYs8vQtj/bMJZekxFHsv8Fy3EezpCi2SamnRAGjL2VRIw4Yr1pp/oYYDAKYPZmzasAs7skFN1K2RIqmF7Cn5GXJQyGVCGVbhEEQh4Mo9xEA7Hi342CUIPNcUr/9Fx16sHWfMWrPEzIMJqw0bgzUMpZ8eNI3quhV+7NflP9P0Fhz3iiTE/wFg8oTorDgYOic6dmg5zyW8nkLJWmjra+3armllTSWt4Om6jLzIwAb+ff1dj3Rv29oWuEGtzeKMZ8oPDYhpPlqcAltuSE+bgzfVtnO0zo9FtHIOvbSNoNN/j/mLUfIj8JgQ+GthznIkGBLNKZTMeAMaZaVhETswahtFvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 06:41:20 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 06:41:20 +0000
Message-ID: <2a260cf7-7a09-4755-8cd0-ef57d7e46a8f@intel.com>
Date: Thu, 24 Sep 2026 09:41:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for
 extended-read DDR
To: <tze.yee.ng@altera.com>, Ulf Hansson <ulfh@kernel.org>, Tanmay Kathpalia
	<tanmay.kathpalia@altera.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <d89d11767f8f3ea073bd54b01ffbb9e700e7808e.1790074790.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <d89d11767f8f3ea073bd54b01ffbb9e700e7808e.1790074790.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: ce298198-1703-43b1-5528-08df1a06d7fe
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: bLmXoq9GbViknMU6pvGsuD2NExj8UnaPtnsak9neo7zmzju/2QOsOTjBZVsZqp9+mBlz+J0+BS+FN3KmXnQ1sas5ydJW9brUjq4qyCnMLU9I5j/EBWRtbBpCLsYuqAKWuwMbexSpZRbwq4XlVJ9AOhfBUAfqjFTm1HUrSoY1bMXDpkED0igEwR9ASLcDWISS/lrVDRcT55tIJimLWN/HiYvZYHZhocnuHetZwGrHa888CRyJZQev4AhOOsEbZE6Ro/C4fiX/jsXFvqLYaeCXw9X2hP2EjJUaaSPxn5c7geF5RKGK+qoMlZCptmOPoWjP/97CgPyQfxtHZkWtvEsKq341TUYOtiKsh2Zx4CqGwptsld6j2mrLOYxlnWauG+yiG8Jag7lwyNWnW7fPKg1HlRmF3oXnZyRmgPOvjapt1EwU9EUdGKEp36Ia19iLdlyYf4Aa4o6J+dlGeb9A6MyyfTBqPy/kX5m53/LJ20f5j2UUYKUDQDSsaTBqey3BauXfUWWvzlBfvrxscC21DW192sFebuAncy5R64dd6U1XLliiFP57RlRcikBFqFC72tnl9ROWFAW0mnSdT8YX2FYxUtCTBNLGRnrtxLEOMhjDa0ugdF625fR2bkuO2t+CAtv1bGLkbT8+SH6qt20N1KlJsk+lkMCjRv2t890+PL0Nb2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnZtVFYydTJSV3NmeldPQm9aU2xhMlBySEladXUwcHVkN0dzYkZ4bDBrekln?=
 =?utf-8?B?eTRDL0p1UlFkckhyOWpKeXcwZzQveExLbU9Jc3BIbXA1VTFEeEJkYVdoamtK?=
 =?utf-8?B?MCtTS3VlNWIyb2VhQ0FyWE1RU1J1T0tOVDUzZHk0YTFPekp5TG9JNjBhK21x?=
 =?utf-8?B?NGVHcFRBOXU3dGs4MlZuWHJBdkd5MzlYQzNBa1pDbmdlQ2N2Z3RENkY2NjJq?=
 =?utf-8?B?TXdoeHU1MStWTldycFk4aW5pOG9RTGxmU2hSSGdYMXRSQ0d5Y2JYb2dHZXVM?=
 =?utf-8?B?YXZZUjhUVDdVdEpZd3NNSkhqNTBDYzB1TTd4eWZYSFJ4aFhvckYrcDhBWnZx?=
 =?utf-8?B?SUY1eTFSa3AvZEl6eVdGNmdmTUlWeTVNM3RleHVqTWlWOFdNdWZpbDlWRytF?=
 =?utf-8?B?d1NPaXN4MEY4UXhQWjRxK0NUb0ptQTAyQkJCMWZDQldFOTZxN3NITG13VzFI?=
 =?utf-8?B?bU43Y2dGdEtQbXpldmFLSWdRRWhiejBZVHprNHE2cFhNYysxWG50R0t2Z2o3?=
 =?utf-8?B?REEvUkpndGp5Smp2aGNRMnJ0V0M4WUp6VFJOSzJqblB0OVlocDgxT1NjekVK?=
 =?utf-8?B?cE9abkR1TWpqWk1FcHgzOGg4VHRQaFNHZ2dvNVRObXFIamFid1ZSQzJMQkdH?=
 =?utf-8?B?dVFUOEVaZXM5bitwcWdBaCtFbjNzMEpQZXVoTmJaTlR3VHVHajFsWXZpMkw3?=
 =?utf-8?B?UHpJbUhDTjJDWG5RUlVURHBtTm55cFoyQ2Y4WkhEQkp1TTE2M1M3cWVMUVh4?=
 =?utf-8?B?NyszUEs3WDFsL3NNMEJqOEZHSmlPZXFXQ2hBcjU0b3Z4Yy9iSnQ0eCswQndv?=
 =?utf-8?B?RWdYUmcxYm91UmRiaXRmRlJXdDM2UEJZM3VGbzRxclBZcUJHVDJDUnBRZHND?=
 =?utf-8?B?K2JBb1FzTGpzQkR6a2FGS3JpWkdjckp4QlUvWnRhTjlGQ2Mwd1dFaFA0RjY5?=
 =?utf-8?B?TVdVMGJsQ0Joand3eGlVTXZ5MlFJT1FuVlJPK1JTM3o5U2phQURmb0NueDRY?=
 =?utf-8?B?aUtud2FBZnhJdlNYVWxWdnY1MWRVSTNxRm15UmFEN1IzUTlhSlBGZmNUSGVl?=
 =?utf-8?B?MnJ0WXg5bmVyR1NLL0ZIWnB0UUt2QzY2cVYzRDA5d0Flc2hlZmNNSGxmUlZo?=
 =?utf-8?B?eE9nVzFMOXE5VXNyUXhRSmg4cjFYcGlzSjVBMm5tZEJvNzJIazFweHhTcy9a?=
 =?utf-8?B?UEFEQk1yVkxQRmFwdUVVTXY1a1lQRWJtb1NSTnZEMGpYUzF1RWphRGZ2ZThD?=
 =?utf-8?B?ZjVucGtpWVprakVGTXh6TDBEN1daSjJZOW5tRTROcUM5RzhSUE5WZGxnSkl4?=
 =?utf-8?B?eUI4QXQ5dXhnSWYrT0tqb1FUaktBZFlVQWhialBKSzJjRGdBdEZTVkZnR1Nu?=
 =?utf-8?B?Um5LQTRJbWE1Z1k2MGFMY2c2aUIrUHNSblRGRisvYWJEU25oTWt0VWpUSm44?=
 =?utf-8?B?bGZiK1hSV2lGU25pL2VqbTZ1V3JIaFY0WmVzRS84aXQ2YmVkd2VxMUZpbnND?=
 =?utf-8?B?NVAxUWxaOVNXcVVlWVgzY3BDZThqZVFXT2tranRBdVNUQTFkWlFvdjdXSWdi?=
 =?utf-8?B?eVZneTRsNXFwUmNZdk94aTBSN2VFQVhyN3A2OGJBQXFpTnJqM0NHZzhNYXB5?=
 =?utf-8?B?WUFnN21qNENHblBXYytOcW4xaGZNWjNiZ3cyYzZHMUFkRDJ6OWsrWWhCMW1u?=
 =?utf-8?B?a0RUL3JqUlhYV0wzbXFPd0IrR05rNm1nNUY2ZTA3M2x0N3g3T0dqQVh4ak4v?=
 =?utf-8?B?OUU4SSsybFJhb2NSK0lrdGhzVFliQWM0Q2xWUGFtajQrdVluZVdPMjQyZmpu?=
 =?utf-8?B?Q3B2djBOcVNHYzV6QjM3SDFjZjByTFYrcVpFK0dvbmR4NW45UHJRdjkxbjh2?=
 =?utf-8?B?OTdFclJxYlZFakZBakcyTzUzSUxPYzFqLzZJT3VTWjY2c01oVEVmSkNpaHdI?=
 =?utf-8?B?eFNaUjN1ZWczOWZ5akNNQ2hNYXMxL1hwOGZYSUlVdDltaFpzNTIybERGc21a?=
 =?utf-8?B?aVdtQzNOWWlEVndGQzIyNjJjZTJWZE54amgyRURoeXIzYUg3aTQ0RGE2eTlW?=
 =?utf-8?B?REVoSEVqdXEvQnhCc1BsN1F6ZzlpZjRvbXMzVWhZRW5RSFRNSG9QZUgxUENS?=
 =?utf-8?B?dE5xNGNHaDV3dUh0cmxGT3RiQVRjMFBSYzZJWUMwcjBjK1pFcVdaREZlOWVN?=
 =?utf-8?B?TXpOVWpVNGs2Z1IxdDQvOHFjckVKamVNK2VVb2NKQWN3NmV2RERTOFpWK21j?=
 =?utf-8?B?cFNXYkhPMmNWYndYZ0NYSUFKbEljc2tuZklZL2Q2Vi84Ny9vTDFmZGJoTnEy?=
 =?utf-8?B?SFVxeUJBblNwd0F1cXJFUDJSTEVaN2FqT3ZrSVkrZ01kb2NkOURSTnhLdTEz?=
 =?utf-8?Q?WA8coavN3jhFD3lM=3D?=
X-Exchange-RoutingPolicyChecked: hnykgacIuherWhbkDylHtubfqVEZW7YeerjDJKd73Zz9jgEK4DVNezElhL74KkK3pGT6HA+4gXAep69xWMmMHDHJ3hzLd8oEiH2K6oCiwxpIMqx/kdxCtBWQouA0Olv0UTtlhKBJhf/LdFDzJTj9u0LzNtCJOGvL7AyyUcQFo3P54HIEceE/gqQSN2MPMuiyo1ppeLD0gC4GW3qLR3HW+R3FJDaaCQCYrGeuelNGtF6HjzjJn7ttC1Wwo3NIbXwPoE2j76GhX4k04wlthORcpcyUck5JDSSxMOiKa9eKLAJ8829utCHQ+/KG/WX9TxWw+VJGutZB3MfF1yUTN07nDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ce298198-1703-43b1-5528-08df1a06d7fe
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 06:41:20.7542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQpVDJtBc0E/495JhLH6zhhVXtB6NUm8EK9dUjXjevQY4NcFfysd/qpSP4oS1rbBXUNkapxMe1kEsDwhm5Xp/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com

On 22/09/2026 14:12, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
> modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
> pulse width in clk_phy cycles minus 1 in extended read mode, and 0
> otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
> (the silent odd/even edge-capture defect).
> 
> This controller's rebar pulse is a fixed 2 clk_phy cycles, so extended-
> read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
> corrupts reads). Derive it from the extended-read-mode state and apply
> it only in DDR modes, since SDR extended-read samples a single edge and
> is unaffected. This is generic to any SD6HC-PHY SoC, so it is kept
> separate from the per-SoC read-path tuning.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 35f35ef9c710..84592ae42762 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -90,6 +90,9 @@
>  #define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
>  #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
>  
> +/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
> +#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES	2
> +
>  /* Default PHY settings */
>  #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY		2500
>  #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT		24
> @@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
>  	bool cp_use_phony_dqs;		/* bit [20] */
>  	bool cp_use_phony_dqs_cmd;	/* bit [19] */
>  
> +	/* PHY_CTRL register fields */
> +	u32 cp_phony_dqs_timing;
> +
>  	/* HRS07 register - IO delay Information */
>  	u8 sdhc_rw_compensate;		/* bits [20:16] */
>  	u8 sdhc_idelay_val;		/* bits [4:0] */
> @@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>  	if (phy->mode == MMC_TIMING_MMC_HS200)
>  		phy->cp_read_dqs_delay = phy->hs200_tune_val;
>  
> +	if (phy->sdhc_extended_rd_mode &&
> +	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
> +	     phy->mode == MMC_TIMING_MMC_DDR52))
> +		phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
> +	else
> +		phy->cp_phony_dqs_timing = 0;
> +
>  	if (strobe_dat) {
>  		/* dqs loopback input via IO cell */
>  		hcsdclkadj += phy->iocell_input_delay;
> @@ -715,6 +728,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
>  
>  	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
>  	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
> +			  phy->cp_phony_dqs_timing);
>  	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
>  
>  	/*

