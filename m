Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361D332ED6;
	Mon, 24 Aug 2026 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560277; cv=fail; b=HO5WUtlqtl/dhM6J8vq1AnhyrIfGXEOlxM5pXMblFS9jIumzM0dKyeE8zf40pYZ0cbZYU6Xoaa9e6ui/sjvdhNZdLYqwrrP8VSHu45w33RAvj6dp4U8a+v59RpNi4WFnLbouFhW8nAssXadtlqTlW1fC4GpqhPZkWrh7Hx5C8qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560277; c=relaxed/simple;
	bh=aOdvsTsy+InZLrjEEtEurPtVP0BU0r260ygDi1PZrq4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fLbaRoXuH/V6D7Ev54+q3drWI7bCmQP7IVH21IB4g0rTAg58N9qaMO0xwGnm7M9Oe6fbCRmRs4TmR0BVviFhSacp+9XM1T4UK3xtXa4dxh4AFMDVXvSHJiXYefMKZBiIJUkLTrygEY/VuFK7l6gN1deeAOCi4ZAY/zt1E6YBBAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtkNNzXh; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtkNNzXh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560275; x=1819096275;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=aOdvsTsy+InZLrjEEtEurPtVP0BU0r260ygDi1PZrq4=;
  b=VtkNNzXhKBVpkt6C3HaCgEug9lj4swV/vWpvMg27j2nFcOZid8aNn+x8
   1aQyYANfDOsAAszX82VkNLK+yTLrcFHwKzCXZh1a6oal9/omIG0ycana5
   99VykU2hhOUHYMRdQuEwRnFdzUoOYqUDAuVfjr8AB8Wsfy5Ei2UH0p8pN
   vRzA7lYgUJRfHoUJbZ5/P6PBKzv68p7M2pQ3XKguEySf+uaBoUCN5oNL0
   1Zhc5I5Uf1a0PEbw8Qe5AbzAzt5vX2ln080s/BCpMBE0qsXvPGItTNTMM
   WrI3sKWghTd/yM73RC27EugsKEQS+6V18Minb5uvku0tAnjOYJbOd4G7G
   g==;
X-CSE-ConnectionGUID: cMoAbAkxRMSKapTQM5+wDQ==
X-CSE-MsgGUID: qnSePKNXTS2eIufZdokLpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="105382136"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="105382136"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:31:14 -0700
X-CSE-ConnectionGUID: dYlsNLqBQE24eu8T0bYbrA==
X-CSE-MsgGUID: MBuuifVQQh+5abpdppSZnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="265166343"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:31:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 01:31:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 01:31:14 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 01:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyKldnmRHEgvESxJEGtfWCYAuGqO5/0sWApshfy0ucYJ23zHa5oJY6SN7IF3Y+T4J+IScyMObQhJubGj36S7NCLzGOyxoU9k9rOwh/F8iYmSqRJM1tAwiqTd5pq46vUu8h46TPoTV4Mw/AvA7Oc47wTJq4XAKp/3Mtc0W1aDPiJlmzH3HXaeF6ymghMOUJKruEvNx4YAKY88Oyg7mrlDoRp4CCjJn59vNHbJBbsmo2UmJPIpH27R/HNKlCkLMCLfgJTlf0CmoNMoR+nsGFMYqw4b0HDj30yBaSSl7yM24cylXsXoByLXx73n9gDKxIM/oNpv1JkAue8L9pqgUFlSIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qm3rYLftDQU6zndwhHh8RAsQFpsIG00Ir11E7SyoE90=;
 b=Z9J8ApJngP/D/JrbNDgAt0rQi8H/rwRhwqkyBRcaYUiyP1vs0lg4SG2lhzWi+tp/IatstWMzIQGKymmkUvUV11ArzJdGhGZ30TpLl+em3BgnbLChw2fqs+y/jvGKvjo5coTcuUL4zhONPB9IReAlJK+eKzCkLjfMTID81e7EsRHy7NUtBvd6D+tDfdXNBFjbanFoLPwgrT7EUBo0K/mAKfr2btIZwh7lFumfbujl45LDTW46Dz/zao3cuJJDUkLIh55IqEarwI/9WlbhT4mlvhJPW0sUQHZhnWh4jbER0IWGps8Lem38H3NtIcficevmf/oDWSW8mWQO5vbBn7h1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB7004.namprd11.prod.outlook.com (2603:10b6:510:20b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:31:08 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:31:08 +0000
Message-ID: <2d3b819d-4aa6-44ee-94ad-f72a477a1fca@intel.com>
Date: Mon, 24 Aug 2026 11:31:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mmc?] WARNING: suspicious RCU usage in mmc_free_host
To: syzbot <syzbot+0d22039ef0915696ad4b@syzkaller.appspotmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <ulfh@kernel.org>, Runyu Xiao
	<runyu.xiao@seu.edu.cn>, Guangshuo Li <lgs201920130244@gmail.com>, "Johan
 Hovold" <johan@kernel.org>
References: <6a893bf7.dbb3a75c.13dd47.002d.GAE@google.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <6a893bf7.dbb3a75c.13dd47.002d.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::23) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: f95d4e8e-14d0-41ba-2d5b-08df01ba0bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hTZrYDjBEfXmSQheUsI5RiNdYaSnm+xmVIaKxIX0OfkubEJ42mygnyv0Rgm0V5CzComaSC39jr4KWA+Py8DxMEsC0MSk1DUF6ryU3kL6To9aiSR2JwhZoeGC+OJ+T4yY1Gr5NdIP0BRVSyLqJ8FrJkl7Y8SXRoztwUUN0gn4wnZ8wI2nw8sQjhL1ny+tZO0wbz89UWP4PWSjFmSbeNvVXIGvvfHfRkQLPlzRHWFaRoZhjBZmjK/7a+DAI2GxJ4ry4W12Pra1SpFii1lLCc3paWnnEderLOQkhMci8zJkM+HgaAO/eMN+gzv4ObcAi0pKqD5p/K8vBQ2YcjmcMxA3OuVN/JZXmzauQJSprXyeuZbs6hmqEYYvrDYAfGr31A6akRgrhS3S3jnvJ1xjlk+UIrAwFCTBBt1B9Fvt2Tv5bAN90gdY9vQbLUy3xB+m/uFkS8+GhD3dLW8H8KGmtoPXQGiNOZjK8biUqeupmKhV2CN2LvBUnrKJnCmrOY7QGEo5Nat7PGwc1i0Ks+AtIAqiNgREE3JSxvhWHUUWzEO3Gsl1QnzKHimxda7TGmGVqyAGG11USlQMh3/qqXakAbiJlrT9q8IX/YVH3Hp5lKLjUgwDZVKTYJaVD118r0Fmqjmo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldzNzMwZ3hUMWRVdTE3ckFMYk9qMVA0emRJeVd6Tit0TGRsMisrZThQVUcr?=
 =?utf-8?B?WnR2ZWNhdmxXY0FEZ213K3I0aDYxejNRbVpIajlXaUNuYmt4VFdXM3BYWXU5?=
 =?utf-8?B?Y01Nc1ZZMGNpZW9PSmMyNmFtdFhuU2RRTTBnUmVsVXJyUGJ6MXVzMUltcWxv?=
 =?utf-8?B?bVA3MElqNFkxeGZ4Z2NVbm9vWUVpYXVvRWc1R0pKSHBJWGsrNE8zcndxQ0Jm?=
 =?utf-8?B?TnBvN24xUG0zaEFia2ZDSlV4UlpiQStQMEtFTVJQeFRza1hyRDN5UzN2SUVn?=
 =?utf-8?B?cFJmN21pdkZXYkNKQjh5aXZ3UU9IVm1nb1FNaDltUVUrWk1kQ2Roc3RzK0hl?=
 =?utf-8?B?N0Nuc3Y2cXoySTUzeFl1dUhwQ2x2RUY3WDNnUHVRTkRXdExoT2tiNkVLZkQ1?=
 =?utf-8?B?ekIzdnhQUlF4a3dvUUNrL1FCZlJaRFAzWFp3MzEvV2RsMWxXK2Nwd3EvVGZE?=
 =?utf-8?B?V0I1UVRWeEprNzM2cXN2b2NqRE5jSUFJYjh5aGljRmtYekQ0WEVqdXlTRXB4?=
 =?utf-8?B?QmZjZi9xRjJXM3NENWZnZmMvRENhbCt4QkNOZUNZOElKdjBkTFpJdkhmMCth?=
 =?utf-8?B?QXpibURoMFpWSEYxWWdoYURwWkV4L3FQWUVyRFpvSkJzQTlMekJqaTc2cXR4?=
 =?utf-8?B?dnFOcm83M1R3bU1DclBXdlhwYnZNaWdXK1A0a2ZVOG5PQXZyTkNTMjZCeUhC?=
 =?utf-8?B?VzJJdEI1Yk0zUCtoNjhhQVBBb1pnNEgxdFc2cGhTL0tPQjhDSXlpNnFoczdh?=
 =?utf-8?B?d0hzdzFnN3VXRm1tQ204bVQ1UXg4aC9YR3FlRUZrSURKN3NIRTBJeGNPdndw?=
 =?utf-8?B?Z3RWL2dNQ096SFg0Z2NtQXdiQVFnZkc2WTR0V09vYVh4a2YxU0NhdEs5T1gw?=
 =?utf-8?B?UDJKTEltQVBHdWg5WUM3RjV0bU5oRGxPYUdmdzdKWS9KSC9hN2x0eEVkdkgz?=
 =?utf-8?B?bFM0NG1vUnNuY1hqelo1TDBkbGk5VzlyczNVMzZ0ckFQZUM2N1JxZUZ1RFJY?=
 =?utf-8?B?dVUxZWw0NWU4anJLbW9WbWJxeSs1dExQMW5hMWVEbFZpckErZzQ2c1RQb1VF?=
 =?utf-8?B?Vjg0VVZ6b1RLT0JVSENRQjNvcTR6L0ZmdTJWWm9ybHorU0twQnZ6YXNvWlpt?=
 =?utf-8?B?TGNFVXRUblg0dStvUVNwQkJRVFI1bGNXSFA4Y3NzNkNBNHR2YVZycW1CRFNG?=
 =?utf-8?B?SlNNNG5tZ2ZxcjFwVUdBTVF5elhFRjhjRXl0NUN3Zi8waGVrZXN4MVd0RlNB?=
 =?utf-8?B?N1orZ2VSaGhWZjFrWVo0SmlBbzZUTmIzS0J4UURpYW45Vmd6S0s5NVpCYzd1?=
 =?utf-8?B?aGVmWUc0K24ySU1CRHhvTzVwRURja2dVYlRMOExpRzJScVVmZitlb2puOEhk?=
 =?utf-8?B?KzJIM3FheEJHY1VFd1JneHlXNXZ4WlpSWWtOM2Y0WUpITmh4aE1jL1pJeCtQ?=
 =?utf-8?B?aVd6M0FQZjFacUdkRUY0N3Vmd3VocXNUNHIxMEFxWnVxSnE5TTBZaDVsa0ht?=
 =?utf-8?B?Ymx6K3J6L1ZjdnVnREFwcXpDT1c0S1JzQzJBNHdRKzVlZnV2RDdkNG1wQXZj?=
 =?utf-8?B?QmRhUUhXTS9lckhJTW9ibktJMjljeTJPSkM4clZtazFNSFRWWGpkalJ6VmNh?=
 =?utf-8?B?Z0ZsZVdCQWduMWRRMmxNL3Z4S3d0VWtldHBGblQwa3VoL1pURlRGczJUUW9y?=
 =?utf-8?B?alQxOE94eW9yUzh0WUFFMVRJSVRxTDU3aTNONzVKanV4WVJkMGVuOEJyaWUz?=
 =?utf-8?B?a0x6dTZYUmF6aDh4Smd0WkJBQnBqay9pYTRKQldWOEdIbXBOOElRME9XN0tm?=
 =?utf-8?B?cDJFNnVNZFRGTnhYakpyRlhMbVI0MFJrQVFCRzJIaDl1WUloQVczbkVYSWl5?=
 =?utf-8?B?ZURqZUptZUVqM3d5bUE3a0xVVGtaRjVlWE13Q0IzZ1BxZGdoaXhLQmJ4Q21n?=
 =?utf-8?B?aVdJT0ZGRTZJRWV2RThXZm5LMmpvL1hKS3pDa0o1UitWRVZQZURRNVhTcFFo?=
 =?utf-8?B?NVJVTTc5REYvRjc5R0NsK0ZiWUZETGZUT1Zka1oyTi94eWNtUW4xN2hHeWdE?=
 =?utf-8?B?dVplZFQ4V1JnRmU5aWttb29KSC9ISzRXcUFTQ1FteG8vVkYwZWYwcW90RmpB?=
 =?utf-8?B?a2tyZUt5VHZ3UnJVNHhuV0xYejE4UHd3UmJCdlV6NnVVNnNnR3NGOVU5WXpx?=
 =?utf-8?B?cnlZSmlRcElYeSt4djdBS09FWE1SaXRqV0ZidWNRK1hGVDhSZDhGaHhKMnZt?=
 =?utf-8?B?NXB1Zk84SG8wV0ZFdHl2MFV0bU1SZUlCM0hiUSszT0ZYTXl6RHRSWHF1T2lo?=
 =?utf-8?B?WFdEVG1zYU9EMWc2ZG1QeEpNalNNMit1TnRhcU9mVEhCRGtKT3lDMXJ4RDg2?=
 =?utf-8?Q?HAYIihuYa4O0SN2o=3D?=
X-Exchange-RoutingPolicyChecked: 1np3axtWVlasv5fIiNVsE7lPq6OALF8UGE8MERufSqkf+FPwpBDIMQQ/ZjNZDamLdsZyWC9rGzxITlPlR0mEr0LlLe3bB4UgzbJj7vhb2YE/DzWwK4uvyno16d69WHbAYL4kM/88mYwt++GmdkaSl4Uu27syGkheKq0v6dV2lkcYBO915FSYJmS3Ej1T5lY/MjEx8a8HmgYBvIToROSc3cxl8+cjuK0v3u/Ue6gNO/MhqypMzb1AvOqCGxBvRlZuOtz+VkySigcIn3OhnfNRGVXpOpwASqYVMu64VnJLTaw9uY7qujhLI7xXLmcVdQW7uxzl973YIBFLADvhd9Da/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: f95d4e8e-14d0-41ba-2d5b-08df01ba0bb2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:31:08.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecEq5m2Uza/meRQbGiSQ6GcqzI2Q04dgk2jpGPK+d/LKWeyc6iC5QTV9WG6sbCyx6eFtsCQctqQ+wHWhLYqF0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7004
X-OriginatorOrg: intel.com

+ vub300 people

On 22/08/2026 09:04, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1109e549580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59b38fbc070dad5e
> dashboard link: https://syzkaller.appspot.com/bug?extid=0d22039ef0915696ad4b
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/51af0608b198/disk-818bebeb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ecaa10d3a300/vmlinux-818bebeb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6ce61fdcbede/bzImage-818bebeb.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0d22039ef0915696ad4b@syzkaller.appspotmail.com
> 
> =============================
> WARNING: suspicious RCU usage
> syzkaller #0 Tainted: G             L     
> -----------------------------
> kernel/sched/core.c:9196 Illegal context switch in RCU-sched read-side critical section!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> locks held by syz-executor/5632: 9, last CPU#1:
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
>  #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6894
>  __might_resched+0xbb/0x4c0 kernel/sched/core.c:9196
>  __cancel_work_sync+0x6d/0x110 kernel/workqueue.c:4552
>  mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700

The only path that seems to use a timer is:

vub300_inactivity_timer_expired() can do kref_put(&vub300->kref, vub300_delete).
vub300_delete() calls mmc_free_host()

which is a problem...

>  call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
>  expire_timers kernel/time/timer.c:1799 [inline]
>  __run_timers kernel/time/timer.c:2374 [inline]
>  __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
>  run_timer_base kernel/time/timer.c:2395 [inline]
>  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
>  handle_softirqs+0x226/0x860 kernel/softirq.c:645
>  __do_softirq kernel/softirq.c:679 [inline]
>  invoke_softirq kernel/softirq.c:519 [inline]
>  __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
> RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
> Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
> RSP: 0018:ffffc90004307210 EFLAGS: 00000282
> RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
> RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
> RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
> R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
>  rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
>  page_table_check_set+0x25/0x530 mm/page_table_check.c:105
>  page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
>  set_ptes include/linux/pgtable.h:447 [inline]
>  __copy_present_ptes mm/memory.c:1138 [inline]
>  copy_present_ptes mm/memory.c:1217 [inline]
>  copy_pte_range mm/memory.c:1340 [inline]
>  copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
>  copy_pud_range mm/memory.c:1465 [inline]
>  copy_p4d_range mm/memory.c:1489 [inline]
>  copy_page_range+0xc25/0x1230 mm/memory.c:1575
>  dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
>  dup_mm kernel/fork.c:1549 [inline]
>  copy_mm+0x11a/0x480 kernel/fork.c:1601
>  copy_process+0x1e75/0x43e0 kernel/fork.c:2313
>  kernel_clone+0x2d7/0x940 kernel/fork.c:2772
>  __do_sys_clone kernel/fork.c:2914 [inline]
>  __se_sys_clone kernel/fork.c:2898 [inline]
>  __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5322fc6b52
> Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
> RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
> R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
>  </TASK>
> BUG: sleeping function called from invalid context at kernel/workqueue.c:4552
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5632, name: syz-executor
> preempt_count: 103, expected: 0
> RCU nest depth: 2, expected: 0
> locks held by syz-executor/5632: 9, last CPU#1:
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
>  #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  __might_resched+0x36a/0x4c0 kernel/sched/core.c:9234
>  __cancel_work_sync+0x6d/0x110 kernel/workqueue.c:4552
>  mmc_free_host+0x19/0x30 drivers/mmc/core/host.c:700
>  call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
>  expire_timers kernel/time/timer.c:1799 [inline]
>  __run_timers kernel/time/timer.c:2374 [inline]
>  __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
>  run_timer_base kernel/time/timer.c:2395 [inline]
>  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
>  handle_softirqs+0x226/0x860 kernel/softirq.c:645
>  __do_softirq kernel/softirq.c:679 [inline]
>  invoke_softirq kernel/softirq.c:519 [inline]
>  __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
> RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
> Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
> RSP: 0018:ffffc90004307210 EFLAGS: 00000282
> RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
> RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
> RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
> R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
>  rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
>  page_table_check_set+0x25/0x530 mm/page_table_check.c:105
>  page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
>  set_ptes include/linux/pgtable.h:447 [inline]
>  __copy_present_ptes mm/memory.c:1138 [inline]
>  copy_present_ptes mm/memory.c:1217 [inline]
>  copy_pte_range mm/memory.c:1340 [inline]
>  copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
>  copy_pud_range mm/memory.c:1465 [inline]
>  copy_p4d_range mm/memory.c:1489 [inline]
>  copy_page_range+0xc25/0x1230 mm/memory.c:1575
>  dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
>  dup_mm kernel/fork.c:1549 [inline]
>  copy_mm+0x11a/0x480 kernel/fork.c:1601
>  copy_process+0x1e75/0x43e0 kernel/fork.c:2313
>  kernel_clone+0x2d7/0x940 kernel/fork.c:2772
>  __do_sys_clone kernel/fork.c:2914 [inline]
>  __se_sys_clone kernel/fork.c:2898 [inline]
>  __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5322fc6b52
> Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
> RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
> R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
>  </TASK>
> 
> =============================
> WARNING: suspicious RCU usage
> syzkaller #0 Tainted: G        W    L     
> -----------------------------
> kernel/rcu/srcutree.c:1487 Illegal synchronize_srcu() in same-type SRCU (or in RCU) read-side critical section!
> 
> other info that might help us debug this:
> 
> 
> rcu_scheduler_active = 2, debug_locks = 1
> locks held by syz-executor/5632: 9, last CPU#1:
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
>  #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
> Tainted: [W]=WARN, [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x140/0x1d0 kernel/locking/lockdep.c:6894
>  __synchronize_srcu+0x157/0x2f0 kernel/rcu/srcutree.c:1483
>  wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
>  wakeup_source_unregister+0x129/0x3f0 drivers/base/power/wakeup.c:237
>  mmc_host_classdev_release+0x47/0x100 drivers/mmc/core/host.c:69
>  device_release+0xc4/0x1f0 drivers/base/core.c:-1
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x222/0x550 lib/kobject.c:737
>  call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
>  expire_timers kernel/time/timer.c:1799 [inline]
>  __run_timers kernel/time/timer.c:2374 [inline]
>  __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
>  run_timer_base kernel/time/timer.c:2395 [inline]
>  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
>  handle_softirqs+0x226/0x860 kernel/softirq.c:645
>  __do_softirq kernel/softirq.c:679 [inline]
>  invoke_softirq kernel/softirq.c:519 [inline]
>  __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
> RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
> Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
> RSP: 0018:ffffc90004307210 EFLAGS: 00000282
> RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
> RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
> RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
> R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
>  rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
>  page_table_check_set+0x25/0x530 mm/page_table_check.c:105
>  page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
>  set_ptes include/linux/pgtable.h:447 [inline]
>  __copy_present_ptes mm/memory.c:1138 [inline]
>  copy_present_ptes mm/memory.c:1217 [inline]
>  copy_pte_range mm/memory.c:1340 [inline]
>  copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
>  copy_pud_range mm/memory.c:1465 [inline]
>  copy_p4d_range mm/memory.c:1489 [inline]
>  copy_page_range+0xc25/0x1230 mm/memory.c:1575
>  dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
>  dup_mm kernel/fork.c:1549 [inline]
>  copy_mm+0x11a/0x480 kernel/fork.c:1601
>  copy_process+0x1e75/0x43e0 kernel/fork.c:2313
>  kernel_clone+0x2d7/0x940 kernel/fork.c:2772
>  __do_sys_clone kernel/fork.c:2914 [inline]
>  __se_sys_clone kernel/fork.c:2898 [inline]
>  __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5322fc6b52
> Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
> RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
> R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
>  </TASK>
> BUG: sleeping function called from invalid context at kernel/rcu/srcutree.c:1491
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5632, name: syz-executor
> preempt_count: 103, expected: 0
> RCU nest depth: 2, expected: 0
> locks held by syz-executor/5632: 9, last CPU#1:
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1548 [inline]
>  #0: ffffffff8ec332d0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x10f/0x480 kernel/fork.c:1601
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:562 [inline]
>  #1: ffff8880297203b8 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap+0x195/0x1dc0 mm/mmap.c:1716
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:552 [inline]
>  #2: ffff888022fb03b8 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x221/0x1dc0 mm/mmap.c:1723
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #3: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
>  #4: ffff88801b0621f8 (ptlock_ptr(ptdesc)#2){+.+.}-{3:3}, at: pte_offset_map_lock+0x13d/0x210 mm/pgtable-generic.c:404
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
>  #5: ffffffff8eb5a360 (rcu_read_lock){....}-{1:3}, at: __pte_offset_map+0x29/0x240 mm/pgtable-generic.c:290
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pte_range mm/memory.c:1292 [inline]
>  #6: ffff88805b9e76d8 (ptlock_ptr(ptdesc)#2/1){+.+.}-{3:3}, at: copy_pmd_range+0x70f/0x5c50 mm/memory.c:1428
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  #7: ffffffff8eb5a420 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid+0xba/0x490 include/linux/mmzone.h:2266
>  #8: ffffc90000a08cc0 ((&vub300->inactivity_timer)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x5f0 kernel/time/timer.c:1745
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 1 UID: 0 PID: 5632 Comm: syz-executor Tainted: G        W    L      syzkaller #0 PREEMPT(full) 
> Tainted: [W]=WARN, [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Call Trace:
>  <IRQ>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  __might_resched+0x36a/0x4c0 kernel/sched/core.c:9234
>  __synchronize_srcu+0x1a1/0x2f0 kernel/rcu/srcutree.c:1491
>  wakeup_source_remove drivers/base/power/wakeup.c:201 [inline]
>  wakeup_source_unregister+0x129/0x3f0 drivers/base/power/wakeup.c:237
>  mmc_host_classdev_release+0x47/0x100 drivers/mmc/core/host.c:69
>  device_release+0xc4/0x1f0 drivers/base/core.c:-1
>  kobject_cleanup lib/kobject.c:689 [inline]
>  kobject_release lib/kobject.c:720 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x222/0x550 lib/kobject.c:737
>  call_timer_fn+0x18d/0x5f0 kernel/time/timer.c:1748
>  expire_timers kernel/time/timer.c:1799 [inline]
>  __run_timers kernel/time/timer.c:2374 [inline]
>  __run_timer_base+0x652/0x8b0 kernel/time/timer.c:2386
>  run_timer_base kernel/time/timer.c:2395 [inline]
>  run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2405
>  handle_softirqs+0x226/0x860 kernel/softirq.c:645
>  __do_softirq kernel/softirq.c:679 [inline]
>  invoke_softirq kernel/softirq.c:519 [inline]
>  __irq_exit_rcu+0xcb/0x220 kernel/softirq.c:767
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:784
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
> RIP: 0010:lock_acquire+0x222/0x350 kernel/locking/lockdep.c:5890
> Code: ff ff ff e8 a0 20 39 0a f7 44 24 08 00 02 00 00 0f 84 39 ff ff ff 65 48 8b 05 f2 0b ce 11 48 3b 44 24 58 75 33 fb 48 83 c4 60 <5b> 41 5c 41 5d 41 5e 41 5f 5d e9 cf 27 3c 0a cc 48 8d 3d a7 64 b9
> RSP: 0018:ffffc90004307210 EFLAGS: 00000282
> RAX: 2ab30850d67e6b00 RBX: 0000000000000000 RCX: 8000000000000003
> RDX: 00000000dc7298f8 RSI: ffffffff8e4e132a RDI: ffffffff8c4cf580
> RBP: ffffffff8242ba4a R08: ffffffff8242ba4a R09: 0000000000000000
> R10: 0000000000000000 R11: ffffffff8eb5a420 R12: 0000000000000002
> R13: ffffffff8eb5a420 R14: 0000000000000000 R15: 0000000000000246
>  rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
>  rcu_read_lock_sched include/linux/rcupdate.h:938 [inline]
>  pfn_valid+0xd6/0x490 include/linux/mmzone.h:2266
>  page_table_check_set+0x25/0x530 mm/page_table_check.c:105
>  page_table_check_ptes_set include/linux/page_table_check.h:83 [inline]
>  set_ptes include/linux/pgtable.h:447 [inline]
>  __copy_present_ptes mm/memory.c:1138 [inline]
>  copy_present_ptes mm/memory.c:1217 [inline]
>  copy_pte_range mm/memory.c:1340 [inline]
>  copy_pmd_range+0x4b46/0x5c50 mm/memory.c:1428
>  copy_pud_range mm/memory.c:1465 [inline]
>  copy_p4d_range mm/memory.c:1489 [inline]
>  copy_page_range+0xc25/0x1230 mm/memory.c:1575
>  dup_mmap+0xf17/0x1dc0 mm/mmap.c:1819
>  dup_mm kernel/fork.c:1549 [inline]
>  copy_mm+0x11a/0x480 kernel/fork.c:1601
>  copy_process+0x1e75/0x43e0 kernel/fork.c:2313
>  kernel_clone+0x2d7/0x940 kernel/fork.c:2772
>  __do_sys_clone kernel/fork.c:2914 [inline]
>  __se_sys_clone kernel/fork.c:2898 [inline]
>  __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2898
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5322fc6b52
> Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
> RSP: 002b:00007f532334fc60 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007f532334fc60 RCX: 00007f5322fc6b52
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> RBP: 00007f532334fdec R08: 0000000000000000 R09: 0000000000000001
> R10: 0000555576c227d0 R11: 0000000000000246 R12: 0000000000000001
> R13: 00000000000927c0 R14: 0000000000039654 R15: 00007f532334fe40
>  </TASK>
> ODEBUG: object ffffc90000a08a80 is NOT on stack ffffc90004300000, but annotated.
> 
> ======================================================
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>    0:	ff                   	ljmp   (bad)
>    1:	e8 a0 20 39 0a       	call   0xa3920a6
>    6:	f7 44 24 08 00 02 00 	testl  $0x200,0x8(%rsp)
>    d:	00
>    e:	0f 84 39 ff ff ff    	je     0xffffff4d
>   14:	65 48 8b 05 f2 0b ce 	mov    %gs:0x11ce0bf2(%rip),%rax        # 0x11ce0c0e
>   1b:	11
>   1c:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax
>   21:	75 33                	jne    0x56
>   23:	fb                   	sti
>   24:	48 83 c4 60          	add    $0x60,%rsp
> * 28:	5b                   	pop    %rbx <-- trapping instruction
>   29:	41 5c                	pop    %r12
>   2b:	41 5d                	pop    %r13
>   2d:	41 5e                	pop    %r14
>   2f:	41 5f                	pop    %r15
>   31:	5d                   	pop    %rbp
>   32:	e9 cf 27 3c 0a       	jmp    0xa3c2806
>   37:	cc                   	int3
>   38:	48                   	rex.W
>   39:	8d                   	.byte 0x8d
>   3a:	3d                   	.byte 0x3d
>   3b:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
>   3c:	64                   	fs
>   3d:	b9                   	.byte 0xb9
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

