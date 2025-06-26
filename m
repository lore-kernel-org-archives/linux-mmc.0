Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB628DB6D;
	Thu, 26 Jun 2025 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946742; cv=fail; b=gm6gFL49eJZCWi7Qyjgqz8+dRNijdPhCAyXQkXn1aCDTvYCciPBv7zjqfq4aWFNE3dmkf3RaVDynNJ2lI+QwNWut5ZEUHQK5U0qHXwzc1uMQqi95hGTdyWaDtJ9QHX6JF/vMsEvBCkRvR4wURE6AOoP4fUuFQg2+H0ghOlJBpFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946742; c=relaxed/simple;
	bh=EaYUoHRltUSnueeecXloe5MvaXabefO6kgId3e/PIxY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H7zz9n27t7Ijodh9NC2aodRo63tLcVT5nl6FFXOuBjEBDGyL+wfrT/i+c/MIGCBZl9zlJgdKeex+9WnvBGj/BQuO10lUAcRe3vDf/In30/5q/YfApjnW68FEd3G0GrH3QXCN83ufmUPegH5s/c18VUloR9iLg0mUafODTSSCHNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWCVe5T0; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWCVe5T0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750946741; x=1782482741;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EaYUoHRltUSnueeecXloe5MvaXabefO6kgId3e/PIxY=;
  b=TWCVe5T08tBluHQPul672uWxDkisEwoB/k3rWpYWqjM/U/JfWBxpQ0Ga
   aoA3uCMlKrDti3aGevlLJsUBwv5ycj8LHRXqwW+g90b8zt0+Hx4zdD/aw
   XyxE8aH4D7KQs4bhcTSLA8nY6GLmQMz/ODpA2b7JztrBkofOqWqQS0dkf
   UxcBWQD03eUs5pFBNXZ93Gmf5+Cx0zTpYRpLf0nZn5Z96sSPc3t0zM3U9
   mJTThRI9H3Cld+LlGp7U0aqiT3Mlp15Qtu1X5wVpBSPEBAtBZa5YqSkIN
   OVOLbvlWA8EzJe6Mbrxtq4v8WWIqvAqmoNMclNFYtVjf5O+PRJBLBXLkB
   w==;
X-CSE-ConnectionGUID: 5bdnhPD2QL2BEUQ+PykVZw==
X-CSE-MsgGUID: FoW9/yzwSzicBDZXWUGXKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="78680037"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="78680037"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:05:41 -0700
X-CSE-ConnectionGUID: T0lY9eOuR2m3U0DqQhe7HA==
X-CSE-MsgGUID: ZTLEBpWlQjescSO0unztNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152036459"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 07:05:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:05:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 07:05:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.78)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 07:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRgWvkGURw9e1bKxm8LmKDb1SsAO+tkgKK3USSUY40WTiTZdJgiYK0yUeeDxYJIMgOqyxCt2+o9Njx2VtTutLPSfWMmz2N8mNZoVN2hbICVEfGkinCGGVN0ZGR2leTwoQESVC2QiUoQPs6PXhZoTCTs7b11AIfxlANnn+eQYrZYDobEz41ZknXiQQutsThNbmFaqT/vQdyVw9ZVV1w/VcM9fdLKAyjL8mehb4qv1evENdayr4c2bP7FQhypNYmz7YYrxK/7B/mIgG/hPNTFK9gpQz5XueGnQPCZj+llRRf8xLbhWbFEtjyra5jNy/KMNyl72AilHVtx0VZU5aMnkTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCopN5qksMkbrRQ2BM1Y0sA4UA5LpOTyZvX7dSsfCRQ=;
 b=oJGwCoev8cjwJSPNTuF+oZMWAf9iXlMEnOtilsc6St6AWCH+YbkJDpjT1Ul46F8v786XYEjdALBvOL99iUkL66Tm/XgR++ArOtbCk/3EFw8dM0XzJkm2tPcHWTDyZM4EFipn4S9nvbQyVKYa0aLOp6DYKMBN0O1v1uoYy0tXS9+tbte19vAYFaR/g3haLLlLMUoOfXJEvfjsG9OZtw1d4BF6F8Ud1TvJiAOSYj8YiLlsIPpMQ+iESBzcqdf7WZFF+AKVOAsyxEV0S4KoXDUkfhUMp54Ty5nigEojMGl5J1nn0WC2NGFLHKG0Fz7FzF94zguUidJU4Q6sBvYeg3jyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2708.namprd11.prod.outlook.com (2603:10b6:406:a9::11)
 by CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 14:05:36 +0000
Received: from BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d]) by BN7PR11MB2708.namprd11.prod.outlook.com
 ([fe80::6790:e12f:b391:837d%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 14:05:35 +0000
Message-ID: <81d519f5-caac-4fd8-8491-3580ce1b6060@intel.com>
Date: Thu, 26 Jun 2025 17:05:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Quirk for broken command queuing on Intel
 GLK-based Positivo models
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
CC: <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250626112442.9791-1-edson.drosdeck@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250626112442.9791-1-edson.drosdeck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::8) To BN7PR11MB2708.namprd11.prod.outlook.com
 (2603:10b6:406:a9::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2708:EE_|CYXPR11MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2d3787-1945-4464-0e51-08ddb4ba84cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkxsYVlVcHB6SXR2L3Z0UWZxNWZhS3BVaUorNGtYVi9ERnhGV2x1RUg2MjBH?=
 =?utf-8?B?aU1CY1d2Z2dXdE5HdWdLdGhjaUY1TmxZTGR3eVNtV1pIZjhXTlFZdGwyMy9H?=
 =?utf-8?B?QTNPOEh2Z3FXRkpKN1lWckpOQmpTSDlrby8yRW9NTDBTWTMyeDNHUVNDWDIr?=
 =?utf-8?B?MnpIK1c0RkVHdDRXbVFhcmxTSzdWSUkweTc4bXZObVRTNEI5YWlzR2FqNmt2?=
 =?utf-8?B?dVQ5Q3NGS0ZMNGVaVEFLTXhEZTJBZzBQaXU4MjBNaGJhOWxCMHpXcVMyUVlh?=
 =?utf-8?B?aDRIN3pLYU1hM1BPdGdmQkNMOGJiL0pPU3ZXQlNxUE9BZE4yUXUxeFNMOHMr?=
 =?utf-8?B?QkMzb2hFQXNBeTA4a21JdFZ4ZlRkQ2R5OUEySGNPWVdiVUtycERjUWJQTWFx?=
 =?utf-8?B?Q3ZFQ0tFWnNmOGg3NTBhQmd2cUsvVXNCdDZpMHVjWEk4TVdYTjdMa0R5TUFE?=
 =?utf-8?B?QzUveFRNOFlObkVNSzN0TFdQZnNxanJONVRZYUJtSTRPZEN2YmpmWWc3aUxN?=
 =?utf-8?B?a2Z5TU5BSTV0VVV6N25tUm5tU0g4YTFBY1V5MEdPYWZlOXU1eHlaeW5IQ295?=
 =?utf-8?B?ZkRWYVJic0pXYlNQdmN5UjZWak16TjhkMEdsVW1mOEJVQ09JTGppN2dtM3M4?=
 =?utf-8?B?WW12NTBpQ2Y2Y3ZaaTI0bGwyVjMwekZ6emRMUC9vajB3cUkveFpBQkZXajBD?=
 =?utf-8?B?MWJsd2Judzlpb2J4eEoxV3dUUG9sWENkYTRueFVMelFpbzVzQXRYVHFpK0li?=
 =?utf-8?B?VlhyVlpRREhMazhqUVJHZ0pibWIyckxrMldkcVllMFZ1WXh4SE85M0NZd0Na?=
 =?utf-8?B?bmJoQ0xOM1RZNHlJRVVUN1JMYS9Iako1NTIwekRlTnF6SzNzM0hCUXNKQjZz?=
 =?utf-8?B?cEVwR3pQMkZIbkh0YjlDakIrSVlyaFJIYkJxSUVqd1RJNFowcTRibUFYZnQx?=
 =?utf-8?B?bHhtTnpVV2hWVURpSVZPWG4yY0RBekh3WTB5czRsdnpta2dwVE44cC8xZ3F1?=
 =?utf-8?B?M3FQMDcyaEhlcjhPbEl3c1NjU2IxajhhbGN3NkxBVzhRSTNnTlM4OExiQmtU?=
 =?utf-8?B?aU5oQWplSGNsUU1Ud0JFYy92RC9Ed0p4Zlp2d0xvcEx1QkpaMGwyejFtWW9T?=
 =?utf-8?B?dno4a2YxNEc1SmI3cEszTkxtR2hWaFVQSk0vWjZCQlQwMHFMMlVrUkRCOW9J?=
 =?utf-8?B?VU1CR2wzamkzU05kMnQwTUNFRFJkT2x5MHBxcmQ4bGpUNUhpNXFvMjN1ak5o?=
 =?utf-8?B?LzJRdXhVb05PNFVLWXNGQ2JiYTdZZGJtd3pHa2h3Uy9OZFNUQkJHNlRNcjNW?=
 =?utf-8?B?R2krZlVJNTdkVHVjczIrZEp2RndsaUF3SEZxKzhMaHMrQkw0UlM0OVlSdFIz?=
 =?utf-8?B?cmR0ZGdQeHUrdzJtQlcxdGFtZG1GQUpzSStJRkYvMVBlR3ZITWcyMUZqSjBO?=
 =?utf-8?B?VExSNzZ6T2NqSTBvcFdkRExZUEFtRkUxZEllTGNuMkEvVnpjSkpsYmxmZ0Uz?=
 =?utf-8?B?Q3Z2dDVueDhtS3FyeGRzNndqTmMxWGZyUUdVeUhrOFhRait1TmdPbzZpL2Zz?=
 =?utf-8?B?ZUxTRTR1ZGNEOFBSc2kvZm52Z1ROYVUzaHJsaTJIQkpzNWRQM3ovcVpMVlF6?=
 =?utf-8?B?eVV5Q1NyanRhYmVhSytDbzVVVXFjeTVTU0VGY2ZJbWxiOExuU0xDcU9JWFVy?=
 =?utf-8?B?R2hIZjFIblRiaGZKdXlkcjZQU0Ywd084cURqMTcrUVc3b3dPVC9zeXRxZFNo?=
 =?utf-8?B?UlBqTHRLa2VNTEtLSWR4amV5WEJzMnRUOXZySWk1RnZhWWlwTjh4N0dBdkJv?=
 =?utf-8?B?MFQzSXo1WWVpQ3A3bDRTWlc1KzRlS05OeGp5K0UyOVo2czhsRHVhaytENjhh?=
 =?utf-8?B?UDRqVnRHVWNXOXExSHRpSTlTbi9Vc1FKZTExMVVCRm1DT2lIaTUvWjdqeVhQ?=
 =?utf-8?Q?VZiCF/RkQ54=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2708.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVtWVdDQ2NwaEpkUzJZYm9iNDJZN3l3L2VNaFVjVThhMnJZWFU5UVFDbE0z?=
 =?utf-8?B?L0R4WDFjNitubFE1czJLMUpxa0dXcVgrbFJjSlFrMEwrNSsyZXh4eTkvRHJi?=
 =?utf-8?B?SmF6VFlsUUlaSnVJNGMxYVppSVZ5aGx4UUs5dU9vbFRVaGV3SXo0eUcxMENr?=
 =?utf-8?B?djhLcCtxUG9zZGJKNVhyRno4akdGcHpTZVpLdWJnRVRRcmd2MkZ2NEt2TmJq?=
 =?utf-8?B?eE5sNDAyZ29PZVBvZllDWmR6dmdpWURtWElyTDNNWmJlVmloS3dxOHQwMUtB?=
 =?utf-8?B?WHpyWlY5TndEZmVLU082MTJHQ0phSDBIVmZRV3VjdHZaN2tOc2RrVWtmWnZl?=
 =?utf-8?B?eDkrcE5VblQzYlZjNE9WamlHejZ1Q2pIeUgyNUUyR1RxNlpUUlVYM0NTN2N3?=
 =?utf-8?B?enJvazk3MkM2dEFVK0NJaHNDSXJpNTFUT1FXYzN2QVFXa2lBNVgyTHJMUFpF?=
 =?utf-8?B?Zm1DRnFRMm1DOWpBa0x5WEZNSlBKbk1RbzYyV2FMSGZnRHRLMHpwakJSa0JJ?=
 =?utf-8?B?SHRYRi9TNlJXSXJINnIrK0YwS2dZVmNNYWozb3AvdzhZbis4VEJQdGZIS2hj?=
 =?utf-8?B?cFRPTUVOaHVmUlVmWVRVbXZrWEhsbjNUMlFkem1vMGxXeEJ3RFF6c28zUFNF?=
 =?utf-8?B?ZnNvV3NIbDkwVVhFaW9ONFRScW1PUWhRTXIxL1ZmT1lVNmI1Rm1GQmtQWXV3?=
 =?utf-8?B?U01vTEN2bW8yODcvRGJEaVlERTNFbm1pcHMzZ1AzTFhjOEZUbkN3K1A3aDYx?=
 =?utf-8?B?RG9yU3J6d0NsL21nMGxUc1graDlnY0hKbGV0S3FNNklJaEFVejEzL3Y3SXZk?=
 =?utf-8?B?Qkg1UU5BUWpXZG1wTk5JbVcvekZDeEMvWnZsRGNoaHMxam1rVVV2Tms5RURz?=
 =?utf-8?B?aEZLMnNTaDZtejRDMG9hZS9OVXNkOGZQSnNIYUROOERDMDNYVXRjb1pnd1lG?=
 =?utf-8?B?MmhaMUZMZ0VoWlFGeXdPMTFyWDg3YTk2TjExV1RidnJkNTBpS3BGOXRVQ2My?=
 =?utf-8?B?VnZxMFNoZlN4VlZSeHAwNUxSRVVnNGZ4WGowcUJLL2sxWFlzYmwzVVdSeEM0?=
 =?utf-8?B?UHJ4bVZ3b0VvcUtCNFUwcnlaTVZ0MTUxYlJZaTM1WnZuSVVhcU1vd2JEVHRC?=
 =?utf-8?B?dW1oZHFWUW9TYThQZGRSNFRIUU5mcWF4RUh0ZWhkZ1dsckRaRE14cjVRakQy?=
 =?utf-8?B?THMrTElFWW5uUk9Ca2JPWTcxQXhTUHhScUREaG5vbVVwNDNxenlqa3pzSXVr?=
 =?utf-8?B?MDNsaDVtTTViZ0F6eS9YRWlFL0xWM1cySDJIUENiK2d0bE5uWktnYUFNZzZH?=
 =?utf-8?B?THN6aVZwSFhOei9EUXFoZFhnZWUwYkhwZHpLZkw2eW5jc2RxWjZ0Yk5JMGpM?=
 =?utf-8?B?Vnl3MEowWWc5U0lmTFVjelRCeWdzYkh5cDFJRUJzL3NhY0VSQTFtSmxoaU91?=
 =?utf-8?B?c1dnQkxncmE4UlM5eEk1Y1Jjcmo1VE42aEhSS1kxZm4xK2w5Sm82cUJ6RG5Z?=
 =?utf-8?B?VFl4T3EyZzdLc2cxNGdNV3lCR3lZU0NBWUtoZ1lDWDJ6cEdJdW03c2VlNWZz?=
 =?utf-8?B?WlZTUVVQcDV4U1UwdnppQmtBYlo1ZmlQTmpiYlNjWS9WVHhTYi9ET05Fb0Z0?=
 =?utf-8?B?Y212aUEvUDR5cmZoa2RFR2d4UTdlekNodHB0U2xYM2JTUmcyY2pCQjh2eVF4?=
 =?utf-8?B?ZldpMGNpaW5ickhiSWpDOXkzc3loQmtsbW1TMzhRQUp5a2dHSXRJUi81dVRB?=
 =?utf-8?B?YlhjQzhkaGFIcEVIZWpocEVLMlFEQjZpeFJIVWpZS1UwWUVjdm5iTEwwaDVm?=
 =?utf-8?B?eEhyUDBxMFBtTGhRdDJybVM3VXQ5L0kyRGZlVlFybGhGQXRuYUluNmhYbHhP?=
 =?utf-8?B?ZnRGSGJKeEJZaytqd0MyWmZoVG5SYUg3WFBscUVxWlFFMlNPbDJUbTArNWZO?=
 =?utf-8?B?WE1Vd1NTU3g3WjlWbXRZYnF4WHFuZktRRUprWFYydVczNWIwRk9GbTN0cURX?=
 =?utf-8?B?d3lITUdvTmlMMndpbndxU3pRTmJyQmRiSkpNRTB2VXlSaWsyemhaUlFuTjRU?=
 =?utf-8?B?ZE11NjdnZjdQZEkwY2NubXVlYVJIVFcwK1JqY0xmUmdSbVRPckhpR0hDbElV?=
 =?utf-8?B?WDZyelBDcEtMVk5ObXZ5MTFzTVhQU3BGSkp4SWIxeGc2aDBpaG9xL0N6TDRQ?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2d3787-1945-4464-0e51-08ddb4ba84cb
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2708.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 14:05:35.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vghJ4112Gy620SjUrmR2mN4jgEwkDs/asOxdAfY/UeJXe/4cL2Wx1/7anUr/A1hsnNebc7wH0y0kUqXeClDP7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8729
X-OriginatorOrg: intel.com

On 26/06/2025 14:24, Edson Juliano Drosdeck wrote:
> Disable command queuing on Intel GLK-based Positivo models.
> 
> Without this quirk, CQE (Command Queuing Engine) causes instability
> or I/O errors during operation. Disabling it ensures stable
> operation on affected devices.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Subject would normally begin "mmc: sdhci-pci:" instead of "mmc: sdhci:"

Otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Also I guess:

Fixes: bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on Intel GLK")
Cc: stable@vger.kernel.org

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 13a84b9309e0..e3877a1c72a9 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -913,7 +913,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
>  {
>  	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
>  	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> -		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> +		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
> +		dmi_match(DMI_SYS_VENDOR, "Positivo Tecnologia SA"));
>  }
>  
>  static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)

