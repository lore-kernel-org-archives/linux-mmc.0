Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793808342;
	b=Nxxht5gog05DcT6s+4NimdAqFmm08G+7Tfq6lgEaKx4+BIQ/q4GDfiw+GsbTpc8c1EYk
	 vhj3C+3YUqwkG8hRFh2m6FsDAbEf7L7aT6S/qwmFNRAO6UV8yECJslYwM8klDBpcmMplw
	 rIq024srw3jfFG6e2P0lih3xxA/wIYApDQuskZPw0igiJ3thoA914mkBgzQU07KuU4NQz
	 qoYjCNzBUAE7UF9VRmKqnppLrCuUtkrXVt31wt9QOoY5w59rqUluAcxNKT5s7anbGHsMA
	 v0/itYaV6HfEzecHjoDIQRk6gh/QQlC3SypG3toYWvS3AwsgosuEgnxTxQ21d5K1keQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793808342;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=uBqc+xDWeIqiniruAt0MsVnHX7OPcEieoR2yKgMf/6Q=;
	b=oshzlmEs2aOB3SANrHJsy6ohDXIunJ5tXgz533a8zbTQQKtkr6BCMcGx1AncRQUPOnq2
	 D2ZTs/ymOA5ZEeKYz7kh/ck/zlxSeef+2U9jZPfprAuFyGbRaUS1N+UqIlXDZTMFPU+rL
	 UHL8nyyvxTg7VXddkajIZvhJLm83gMxm/3IKOmBORuZ/W4NhkMN9VfnSEw6VwwdKU93+U
	 cwaXgsWTaXd/S0odW5kYRq18N53ZnBjiwqWbLnNs1/m4OsSd2cr/ivEiKeQ4tAboSWZ0b
	 fIShS1nPvRI1AQdyekQWbKeQY380Z98zEunjOriYM4nBw3r7+oK8iTRWtzc5zkOQH6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WGmTQUjl;
	arc=fail smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D194606A326;
	Wed,  4 Nov 2026 16:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D194606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WGmTQUjl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793808341; x=1825344341;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ErhGTHGb5lyOftGbUoBb3p7iYn9hgLUTzpp0wcTPfM4=;
  b=WGmTQUjlznkcxd3NmeKyLRkeduM1c3QQaUilmu1hUuuIQjt2bxXPkKXi
   dM3NjNmnVwGeuy/jNsCOOionxsiUXuc2i3T3f7/GrAkNa51OvbCcGEluH
   74Jj30tkZnlusk/EDFYlarpBK07b1dnQVQ8mdHIAkczxTyFIE9J9LqMAb
   9R1pcI8qqiCIkFT/bInSSWEgKkRk4tDCdiUIUd8bwYzYFf3j2qlFJTjLk
   lio7rfiSvtc1zb7YPUP5eInpyeBvdsu2H0z2I34RZVzJPOua48H5yM0yw
   3cWUlwkx1rrFDsk87aZixnW+78CxY5Ygr5DdUMvl3Ua8jHi/AvRq0rIQc
   w==;
X-CSE-ConnectionGUID: TPWev00fRFiq0aG6d+zhpA==
X-CSE-MsgGUID: sjyLa8MTRP+qwi+C31LiYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2563599"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2563599"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 08:05:40 -0800
X-CSE-ConnectionGUID: pPS/0ylYTiqwxYHlGQkvRA==
X-CSE-MsgGUID: bAvgyWU/SMWLOJydFi2Bcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7076210"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 08:05:40 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:05:39 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 08:05:39 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 08:05:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elUfFr6pT/Zfn2twEG5PCo/oJkj27wBLc5OnInD4ES+1rkmvEq51fGVArRwcGg7TL+mohoJOk/bTqxqOGKB7/RaEeVsHWT4SnGdjW8LB2dL7h5y9tLScvIYAoVP8FN4EARzzjPx6QNak+qNaPmFXoGeRDlgXGc+k81WuXtcKewcKHVE7FuQaGX7h5BP45R76mP0HWK4Snfs+ImW0PSbB900E8V0LDH3cRhTLHLMre7yUSTCiB1RZ+ZOZ05Ykpo2Yp6mFxCTZFTT54VFISlFF8EnhR3Sf33HgdUfKn1CpoalfOVtXm8AifrZY+Hepo031013AuZ8mS2OJiBH/+N1FSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBqc+xDWeIqiniruAt0MsVnHX7OPcEieoR2yKgMf/6Q=;
 b=UskTeUVyx7pRe7Shq1VQgDFOEqiGxp6FSSDpXQHdAE9/qGmTl8sxdsWW/cNMkr5UNuUmzlEFu0+KfhrCGnXgGE1pd7HRoWN8Uf8ohBc08cmAuD2ZuUvYdX3wfgGlZ6MYUyLyFnb3TKK2lq5MR3Tmm4OKqddWvMaA4YnDLQJ+eIlqi/o3PNB2+CWxneWc3ytHs/4kVvknJgJYTb3x1bQPgowtYKwA5rXddjReTYyaVHTVLGwwjy30+rag12ICePH/HGp4M0h8JJlr+uYsmIuSTnvzv92i+vMd2l/KQ6T58feItg2QjsIYjwuZ4SY+hxDPhGEX2bpG/4xWFPKPpwcDBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB4871.namprd11.prod.outlook.com (2603:10b6:510:30::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:05:35 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 16:05:35 +0000
Message-ID: <d9a9f45c-931f-4799-8c17-3f39bf4dc50d@intel.com>
Date: Wed, 4 Nov 2026 18:05:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence: enable probing from ACPI
To: Paul Cercueil <paul.cercueil@bootlin.com>, Tanmay Kathpalia
	<tanmay.kathpalia@altera.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
References: <20261103093501.218232-1-paul.cercueil@bootlin.com>
 <c8dc0612-7ba2-45f0-9aa9-5e312fc8aab4@intel.com>
 <21015d0ab9c99bbe8b187792836ecd267e02d4dd.camel@bootlin.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <21015d0ab9c99bbe8b187792836ecd267e02d4dd.camel@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P195CA0015.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::33) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB4871:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d14935c-00ef-4953-11b0-08df3a8d75d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|22082099003|18002099003|56012099006|4143699003|261022105027099003|11063799006|261022075727099003|261026121527099003|261026140227099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: NHQGZ5afj/yWHpFid8C+y2eOxMZ29E24l78CpW3sljd6JWTfEqW0oU7qk55cRmv7aM62UULKQbSRKLpGlqT9o08e8sG788RYrVwnoCaRpNB+HL6VB3ZTxhQ1PC6bmW/XJzmsKaPlbYJ/HRYJK9xSygIfMS4OjnzVCAzmypoZBCBsn5kx/96dkBPSJqZaeK7MYVpKPpsLIMpW7VpQizNnCu2UYSIcOgVEDhGIEqPeM88WXfyu8SOAtpB6sjuCVKLHl+vUoNy64Rd3bpTkd76+0Vrsa3ExtjDTpvQl7K0FvGFxMqESbC/P3tetDzROwS28Bo8+KH1Ma/sz6Bm+JlMjcIfiGMIAt+ojNS2x7/2W/l1EZVTxl3fxsg/YAMD5hjeJhtnoFRPtjiCulv5sqEdW9A15s6Hmb/7IC9ZCIIaUbTclr4esen/tdkSoPeFvvhilx8CcL6KEip/AnXmjU4B8+tnc+ShiNXHmNdWE3ND7GqH4Ol2I2ldo8qsHqhKMbN7tuRakSPcBwReczByzuTo/9OJEYOrzm1Zv54xoKZUDrvXlQGK4qD8DiM+/ynC5mYmdAdURv8+5ddybc1AmlY+gGt+6yiTrh+lbXLzXf3Kzm9PwkuF681iHI4E5NcgZBpEk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(261022105027099003)(11063799006)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkU2QVd3TEpRQm5aeEExMU53SENoWmZieUpDL3o2T24zaThzdjNNcWVDRHJq?=
 =?utf-8?B?NE9WcCtGNVFtM3k3MUZlUjFDR0tvM3d2UnJ3RFppeVY5ZVBVV2l4ZU0vek5y?=
 =?utf-8?B?L3RIT3RtdlNNeDlmK0ZZZmhaWXF5TEhnOEI1ZGx2b3pCZjJxMFozZ21Hbm5u?=
 =?utf-8?B?c1E4bE82VDk4Z093dFN2TzhLZk1ERkJRQmw4ZkREbzRQVUwwVTNNQjV6dGtw?=
 =?utf-8?B?NDhkVE1MTWJSeFZyTWlFTnFXVW5NR1FJNnU5ZVdsSVNkS1pUTWozMXppVjVZ?=
 =?utf-8?B?enZPU0FoaXZDNkNtRjZkVFpybFlUOTFKUkJIeXBOVzlxOC9CT2F1cGRJdE9J?=
 =?utf-8?B?N3BFd3pkR0NJMXQ3b25kcWhFS256ZHNSdlpQV2lRbGE4WXROdGlHMkkzYi9Q?=
 =?utf-8?B?dUxXRGVsaUR1bkdkQXlqRWtDc3RTUkpGSG9qU2JQNzYwS2NPVzl4bUtZVDdt?=
 =?utf-8?B?OWxTV0pkeDBJNitWVVRNM0dzOXNZcXIyTjQ0VlRrU3hqNmp4SnNLcUgzZmNX?=
 =?utf-8?B?cm1rRHQzeFdlRUlkMGx1a1NQT0d1MWRNNzU1TGViTFRkRjZ4WnBjZjEyVjJH?=
 =?utf-8?B?elcrdk4vOE1rZTZmdmZ0aFlLNDhIYVBnOFJOb2sxZldXT0VzSW0wZjY0eVJo?=
 =?utf-8?B?bzdNRmhWbXZsRXFpNklHRXNWY1NKalpETCs3d0JEcEFTUXFQRnlCc0w0Q1hn?=
 =?utf-8?B?NUpPMlVsdlpLRnl5VDNtaHNnTkRTU3Y4RTAyUU9hODZ6alp6V2FISVZFK3px?=
 =?utf-8?B?SHZuN1VGRlI4dXNYS05lN01DeUFFRXVkekhkZjNSMm9ncW50WHFXbXovTyts?=
 =?utf-8?B?bHJ2Y3FvQmlhRXN0QmhPZ1hzTXY4VU9HNENqanRkcXd4bHBjVVJ0S3A5KzlQ?=
 =?utf-8?B?UVA4eEJ4aVVKUktQTzcxdlA5RXAwWEN3My92U3R3ODh6Z1BhcDJqNVlidlhj?=
 =?utf-8?B?NGZXMkwxWDJGVUlyOUJlblRyMkN1bnpGWG1XVXBuMlg2VjN5TmpCZUdTNEN3?=
 =?utf-8?B?aGtwVmwyTXdCMmxDWHVtZTl6Y0pUWXFRQmdLUDAxRXNNNnpWWmN3N0pXL1Nr?=
 =?utf-8?B?ejVrZkIwaWs4TDlXUWJnWWdIckRCQm0wOWtVZ2s1RnVPelVINU9MVk1NZVNT?=
 =?utf-8?B?NlNUMjNhdEtybFkvQ0N0eGtrSS91aHlsTmFVSEZTNm0wcjMvakJOUTBhOEhB?=
 =?utf-8?B?d1hMTW5rQ25BMnpURzFLNHZMNHh3YmpkL1RudGd5QmNxT3J6S3RRTFZGSjQr?=
 =?utf-8?B?aU10MjBjWFhQdGdnOGU4QUxIVEdTSzc0ZmZOZ1F1K3VjUkxZODRtdWJMQ1Zz?=
 =?utf-8?B?QkFiUmZ5R0E3T05WdUwvRy9GWlpoa2xrVUtUR29Ua2NHRmd1UUZmbDJpcmN3?=
 =?utf-8?B?Wnc5TTVRWUhlV0pYaktxMjBKTjY0WnAxNnc4OHk1TDdiSXBnaGFTVHVlL1JB?=
 =?utf-8?B?UThqU2c0ZDVTYURSbkxua1lXS3dsNVlwdWxhMFZ4bnQvSWF5MElsUk10Ull5?=
 =?utf-8?B?MnJKcFhZNGdnV3JpajdzbXBFcHpvQk9NcDhDQ3U5VzFtTytvRDdOOUF3UUl5?=
 =?utf-8?B?NGxZMG95ZGJrNHN1eWhVNmNoOUQ5OHBoNTJiZW9VODNkODRHaEFjbjJMY2Nn?=
 =?utf-8?B?VFRUU0pTZzZsQ1hsVVBVTTV2ME1GbUpiZnhnc1piSklsaC8vWkl0UEl4by92?=
 =?utf-8?B?K1ZrNEduRHdOVFgxK1dkc1RsVS9CNHB5bVpEa1BJK0ZnWWQvUE53YitXMGNv?=
 =?utf-8?B?UjJ1eXJqNS9nQmx0aXZtUHpsdEtkTU53NWJGY2RlcmFNZHJ4bEdXcjc3M1VN?=
 =?utf-8?B?Nng3SDkvUzZsNXZYVW94elJ4S2Y1MGptemRWc1R0MndzOEM5a1RVTFBsMnhk?=
 =?utf-8?B?R09ieUdrL3NCY1N6Ly8wNC9sMVNZZEZlRVFNMWJiYWUvelhLbzlsRW9Bbkxh?=
 =?utf-8?B?QzBZRENzbExNWDBGWmxOY3dkU2ZIVW9qUkRKMmo2L2tpTWxVS3Nyb2xabm5T?=
 =?utf-8?B?cDZDYVRPRmpOb25MZjdJekpCdXB6dkQ5UFg4S08yY3hVcHlYWlcrTDRBeHlq?=
 =?utf-8?B?aFZZNTIrU1NNRnNMbmM1L2oxV0pZZnl5N3VYNjFmNkhiODlaK3NkVk1OWWhk?=
 =?utf-8?B?V2gvYy84K0pTSWV3eTJKZDBNaStlRGRZR0xvZzRIZ01uOHJEYXpLeEloNERj?=
 =?utf-8?B?OEwwazVSU1lxZ29RSVNibmRzUk8wZ2ZGcjdGcjhFTkViWUtRaXFtbUZmajJy?=
 =?utf-8?B?QjM2T295NHNuK0kvUHkxSVVQclBDWXZZM1paU2RNN21oUWs2Yk9IcnZxSlU5?=
 =?utf-8?B?U3pMT2J4NVF1Wkh0WmtwQ0VxN3lPRmhBUUF0MEI2bzRPUXdpODMxQ3dFb1I1?=
 =?utf-8?Q?Hq4WvjFh99mp2KlY=3D?=
X-Exchange-RoutingPolicyChecked: iURQkiLMwt/o1rSKplP22odN5irS20QC3ZyYhUxaRFBBehKHfL6o3ZH1DydKTFy8V8rrr9p3IgkEBNugCcqzTxfHk2Bmn3+fqv0oRSBvN8WYPTHMCr/LVjyMLj+M03LX3UJonWrA1UUtnWkJ7iKNibqkzLY2FlgmLdxENtlNQKYkxmR3e+jkrKYlNdz4IMZUupCp6bJEMJexGPQqU2B4lwpj/9DsYK/NxuK2QT6058elEQI93fjtzqI6hjFW1LCLNhkDVzRIfHAG8c8Rc6YO58z7/NXrKWd6toB0x4xSF/iEcGsU1Vlherr72jptvFf2S67i3qhk8WraUFm1LfexqA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d14935c-00ef-4953-11b0-08df3a8d75d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 16:05:35.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhvlCBB/SvI5XIbA7LpcTfWFIdzPPlNQDT99rQ+hlWG5TIljB6lLUTfLcwrD2k96zULcGoy/YO+XEc0TNeokNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4871
X-OriginatorOrg: intel.com

On 04/11/2026 16:38, Paul Cercueil wrote:
> Hi Adrian,
> 
> Le mercredi 04 novembre 2026 à 16:30 +0200, Adrian Hunter a écrit :
>> On 03/11/2026 11:35, Paul Cercueil wrote:
>>> Use the device property API instead of the OF-specific property API.
>>> This way, the driver will also probe from ACPI.
>>>
>>> Note the change in the core's probe function for SD6HC. We can't have
>>> named clocks in ACPI.
>>
>> Do you mean in the future?  ACPI does not provide clocks at all
>> at the moment does it?  Otherwise, clocks registered directly by
>> clk_register_clkdev() can have names.  Maybe I misunderstand,
>> but perhaps clarify the commit message.
> 
> I sent another patch in parallel of this one, that adds basic support for clock
> resources introduced in ACPI 6.5:
> 
> https://lore.kernel.org/linux-acpi/20261103084718.8222-1-paul.cercueil@bootlin.com/T/#u
> 
Would have been worth mentioning that in a cover letter.

Seems like it gives the clock a name

+		snprintf(name, sizeof(name), "%s-clk%u", dev_name(dev), data->idx++);
+
+		err = devm_clk_hw_register_clkdev(dev, clk, name, dev_name(dev));

 but clk_find() doesn't look like it would match then - the comment says:
 *  An entry with a NULL ID is assumed to be a wildcard.
 *  If an entry has a device ID, it must match
 *  If an entry has a connection ID, it must match	<------

