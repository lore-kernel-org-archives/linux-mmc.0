Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F6D3FFAC6;
	Thu, 27 Aug 2026 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787833273; cv=fail; b=O3pmhFugbm0umecSSW84YiKMzCLBwHKl6PCZ9jkQX5i/kbN0TiRG69gWsvFZw5HxWD3ZaFXaJRErc3hiVolcfM59a1WbJ7alKxPE1gtFTcM3ZvzIOvEG13kJ/aP7vwFau+rMuL/YO0OummvPAM3ApBRTBQKirZkefoFi9/YoAe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787833273; c=relaxed/simple;
	bh=xwW9lXs9Lb/l2OUsICa3XESHiX3jzCEeoibY+lm7T0M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a/P/78nKG/4v6MLrHbCj+A+cNWQ0L9NMtdwLa7OHH1RBKkord1NlWnJn40Wno1MyNo9hdaZMHs/tanocTJKHh6xq2jtbuziBXVXDKPvOcVMuZV+CGXZbO3QrTv27jJ39VNdiHlRt3HOBsT0eBA//8GQ/bbTdBQskskml2Id9kZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2a5DPoz; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2a5DPoz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787833271; x=1819369271;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xwW9lXs9Lb/l2OUsICa3XESHiX3jzCEeoibY+lm7T0M=;
  b=b2a5DPoz4a2wI43uIJ+Ht3x2lmD1oGwIuazSfFGZj2dqJ7J/AhbuQH8L
   +noy1iRwPHnAn+xmKXPVXFdKAJvWReW/saM97IjBijbkrx9tFJHp7fVoX
   ObcOT/YUkydonkOZRnYIbZ9pP6yr12bldwnPPL2BAs4+CB8mDykSY0o4M
   VdwNHHXA6SyQye2spMTQaaGnYSir6HowbrpCnwiGI8OfQenD+SZOt0DQK
   1yhNEHo8v8sgUG9FI9kTm72NXKXfYsKLY4aMdtmj7bhzmEvJSHGT5QKe4
   hlZQDh3opRfjrZEIdJpZgGGCWJYKt0P4NjcVg0LcKNRxqG6cpx7n/j5Sg
   A==;
X-CSE-ConnectionGUID: B6MhlGIXRCGVFDPQDq3Qhg==
X-CSE-MsgGUID: hXucahERQUWdgiwtJP0k4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87465904"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="87465904"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:21:10 -0700
X-CSE-ConnectionGUID: cp+JnvehRmuAhbpJV0VRAw==
X-CSE-MsgGUID: lmjEEkEyRNGXr/xwvtq1Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="267281314"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 05:21:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 05:21:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 05:21:09 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 05:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whu7CrgdIzcndu8YFUSmLieMNYQHOk7pBfMLdTgtzpa4bwI9OQxxYiofgoC1ifIoK0ybmK74OHKpsQxVpHZT3hjd92A7Ww3juTVCv8xhqzYeUN3eVGdD21+wTWPcxDq8rg7n2187DKSuC/5z9oGTg21OVBs9byIa/WchUDPNJUTGsex6GcsPJAKSexFwAOAUD1cg71Sz66zcMQ0z0F9xQ/yxHknR1FQCxPya+CWn10iwqqEIOyuTguZqDKG3Nlc6/lXlU7gJruO0DSDWjYVReWKVGsRJDio/x3+UlYg36rb89eGl81PKUnTtWk34cKfDXPCiVVfE+J9wZq7UEHUYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWlYhZOYUzGEMmQR/R+nzN/ybujvfbwXD+yNA/eYHaE=;
 b=js3ELSqEw3lGlRiqbcQu80ALRPuW20Zd4GEclCdBbmTbxeIn86gwangoxEzqFVRWRjjaTUMg407xneIKCfBsAsj1W0Eck4avDW6H7HAxp8y8ckUls1ybSIr5hKfVOaudbogZlOdb5j8bW8rJI2r9gVi2e71GlxsJG3kQB8JaMH11NOgttxwSD8WrKowuobmuTrbre4/x3mqgLpERIDygiQypH+f4L9KuHIjRuoafi6vmt2EnNDZc6pY9pkU6RV6IRO8HoXTZc7dFmDny9wMqQMhxwyDgFlXU98dPwTmwYOBujykuXKFFNTTMbSqWthMHuAxzyfZ2lpjjifozMTXW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB307637.namprd11.prod.outlook.com (2603:10b6:806:520::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 12:21:06 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 12:21:06 +0000
Message-ID: <ef228bd2-217b-4a3b-a9de-ad670bfc0d46@intel.com>
Date: Thu, 27 Aug 2026 15:20:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] mmc: sdhci-cadence: Add CQE support
To: <rohan1sj@cadence.com>, Ulf Hansson <ulfh@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mparab@cadence.com>, <pawell@cadence.com>,
	<sjakhade@cadence.com>, <mpillai@cadence.com>, <razb@mobileye.com>,
	<blarson@amd.com>
References: <20260825-cdns_sdhci_cqe-support-v4-0-e9f72e338373@cadence.com>
 <20260825-cdns_sdhci_cqe-support-v4-2-e9f72e338373@cadence.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260825-cdns_sdhci_cqe-support-v4-2-e9f72e338373@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB307637:EE_
X-MS-Office365-Filtering-Correlation-Id: b6545d9e-6f1e-4dd6-d13e-08df0435ab0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|6133799003|4143699003|10067099003|56012099006|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8qS5DAIfE5/njYaSUq40PaDPGGfxv8twDZkuhtQBzzQi2t16qDgn8IeupDOQ5OPCuaN1nQuVown6wMotsPm+juYRKpzO9f3Q4EkmihIVdBJfMVqrCrmkLc3agXr8Pzt6XJuDGcn29FttL4tklXl0++Bx+LfdhMWo0KXPI3PSrECMjg8Zlm+W7tI4zHTNiRcUyn7CsO0m+s36prMy1TjBZMJ5ya2ZiUtTzh1xURXXbgJOTI+uo+IV8FS1Z0rQ3Cb4Os5nMqL4ai79lnS3mOlbTeciDR0npoSTqOr95L7SuUYUfq8XfWjshAp+x832v4GGzRByA7pdzLQnQ71JKSyPBbx/LQclAJJCuJ3OsOLAkze4dIWNgxtLHXj3DgGSTABLYb5sBSZnslp5zwvZ3wZ7FTgYyvTgmaC+/dPu2uUhxTg8/7M4AVjUtBcPrHSJb+s5/OjG6uXC1+wZQbsEY4N7VwA910z/a74MMio+v3n0lhFvJgHz8u0+mIhfhsNzb/69SYKwWBiNGxaUELYNkC3W9KZXpxaEn0Tj62z3sVBvnFZz8+ckdZZQ4kafj5U526raSEGs+6fn7psxWNXgMohA2z6vRDhSCRKdWu8Si1BEUWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(6133799003)(4143699003)(10067099003)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlcxcGJxS0RCVHRacnlVWDlUWGUvZ3lEenRIWkg4WE9RVkU1ZnV6U0tnQmRU?=
 =?utf-8?B?UHl0REM2d0s4eGJaT3ltYTQ3ZVlxT2lyN1RHU2JmcjAwdGdMTkNQOGl2R3NB?=
 =?utf-8?B?U1dZYWp6U1lscGx3TFZjUFgrdjlTQmhwYkVBYjM0MVdmUjk4TkFqUFF0SjZw?=
 =?utf-8?B?NGlsNnRrQ1RCT3RqN3RQcXlEZzc5dUdtWXd0UnZ4anA1aVZldlNveEQxdHVu?=
 =?utf-8?B?ZnM0REtXQVpLKzFmTGNoRGgzWExxajBVWUR2R3Fkb3V2bURGMUJMdm9hNnhk?=
 =?utf-8?B?Y1JqOE5nT0dTdXJKN3ZaTzc0dzlrNzQ0UWhOU2VrTjREd0hmR00xdm9oY0dT?=
 =?utf-8?B?UmhKbzd5S3NqUFg2a1FpWTNFRUUrWGUxdE16R1FyNSs0Uko1MXVwK1V4SlFI?=
 =?utf-8?B?dDBGbExJQXc1cCtSd000djhXaTl5b2FaK1RWRklYRmxYd2N5OXFJU0FlK2F1?=
 =?utf-8?B?OE1wd1FMZys3RFNUbnhWbUhtTnpzbGxwUmNLNTlOUWU1OFRrWEpqenM1YkhP?=
 =?utf-8?B?aXFxMHJPQlN3bmZ3NGJRanF2VjlidWNvdkVZQzBmTWRNdzkrMmJaVHZzL0t2?=
 =?utf-8?B?QTBhdHpFakx3cHd1WFgwbFFZZ3hPS25aVWx0TnFBQlhPV1pxNVVpWVBCYnVh?=
 =?utf-8?B?RW9VSWIrMy90QjZJdTVpc2orQ2dxL1ZmN0U2QlZrNHBaQkxQb3BTUjRNTFJ4?=
 =?utf-8?B?c29BenJId1pDeUJST3gwMWlIT0x1YVc3TXN0a3gxUXduYi9CZXFkYjU5S3Qr?=
 =?utf-8?B?WHp6dE5NUEtQOTJ6ZmNXRXZXVmlmaGVSNVVNQ1JadjJqL0F2eGZTbWRyV0Z1?=
 =?utf-8?B?OXpqQ2g2L1RTUUNxSFZ1a0ovSWl6NjZ2UnlBUXNXREFzYy91WnFIOEd6MHdG?=
 =?utf-8?B?NDVkQmlYdlFhQzNpU29iTHUzRnhmVVZWNEFiVDE4UXA3eWZWcmRxNzFocTYw?=
 =?utf-8?B?WGszdGhaRURua3ZTTUlpdXlnOWc1Y3NGQUZkcDJhNHg2TDY3MnF1d0UxQUlS?=
 =?utf-8?B?SkhtdFhyaFJZWHhYREhaa2E2dmtiUFc1RmVpQ0NNWkJvTG5LNHRuUDRvaDdJ?=
 =?utf-8?B?NFZNUVFkeCtEVWUwU3FBd002U21ESnJNa3p4VHpvWnVGNC9hNzVTNFBoaXVu?=
 =?utf-8?B?Ry9MdVJiS2M3YVZOVTlXMWZBdkFadytiMmxlVTEwSTkzQUZ5QWIvUHRDNmxB?=
 =?utf-8?B?SW4wR00yckJBcmhaWUtKVjBuSFVUTlNpOThBQVJudjRGbDN3R2ZrZWJRWElQ?=
 =?utf-8?B?TWl4REpaTU15SllQeVBaODZGQlFtZ3FBdUxyZkhLUmp3RGJWWGltbmlaYVVL?=
 =?utf-8?B?S0dSc0dsU3RzbWladzBoNXMxMnB6MGZlQ01rNTk2bnNMeExsRnEwQnczcVp3?=
 =?utf-8?B?SkNUWTZqR280K2U0T1BQcG92NG1EZjM2azJnYUpGVGZ4bVZsTEh0YmhpZnVD?=
 =?utf-8?B?QjdYWS83eGNnNXNvTWlqb01mY1JZcW9xaXc2enBkRFZXd3B3OGZDbjlCSzFV?=
 =?utf-8?B?eXFBVHNQcDU1bGhNUkdMQmxTSXIwbm5VdkYrZWxaOGRMQ3htMUM0ZlN4bWZE?=
 =?utf-8?B?c2NvUGlvR2lIaEt1NndBdFNiRmpuTHZDVlpIeFZmdW1XcXhta1dDWXhrdzlx?=
 =?utf-8?B?aXdpQTFvM3Y2eExsYmhLM3FCWHViZ1R2Tml3SjBpSGtZYUNsUVZkaVBCdk5B?=
 =?utf-8?B?WkdQTmdUaE5xTmsxNlJQdUVCMGFxbmI0cFcySDZEWGcyQ1ZERXFPQXJOVUFs?=
 =?utf-8?B?ZVg0Q0JPUjM1dGtYMWY4ai9SNTNlei91QThycS92M2J5WE9uVkRBWU1UMG05?=
 =?utf-8?B?R3Noa09lT1J1cEMrdHNYMHcwV05uM2psejlZUDgyZm0vcnNYOCtNb3llcU5I?=
 =?utf-8?B?bE5pUHZNTUZJbDAwb3BFaWxNcUtpNllIZno1aHVzM01BZHFEL1cyTFB5Y3lX?=
 =?utf-8?B?d2Qvb2NGdTVLS3VsMi9YQit2Qk1vdHl1RHpCUWJ1cDhGTFdJYWxkV0JnR1R0?=
 =?utf-8?B?MDNuY1cyZ3p0MFI5c3ZkSEJZTGM5SERDa3JLSU11LzN6OElVb0dGdC9sRXp5?=
 =?utf-8?B?Q3M2SFBZV2ZNM2hxTGRuaCswQm10U29xOFQrdjZZRDJGTUY2ejJZWDRoOFRD?=
 =?utf-8?B?VU1LeGxUK3VNd3Mwa1VCWVJPclJkeGNDdWE2ak5sZXF4V2lIUGZVQmp1MGNT?=
 =?utf-8?B?Y2hFeWxKOHBZcU5DUjM1NDZ4VXZRL25aVFFwL05sYjl2VitDOFVFOUsrMHFE?=
 =?utf-8?B?K2U0cUVwSGpEZ1pYZHI2UUQ4MzVBVjJ5MFR0cmpPMk1MazZyaWRlTDZvN0Jo?=
 =?utf-8?B?ZVQ1WnI1eG9lS1BkemtNa29LaDd2d3JsbUE3aHBNaTRmK284NnRYYVgrOVZL?=
 =?utf-8?Q?Fe3fOXGwwrmFxqy0=3D?=
X-Exchange-RoutingPolicyChecked: 1M9Lm60pzvzQtGgEhMn1Ykf4wEd+x5GtT5q8MYNKkzHgVN6hWxvTlvnBWcXGk4e4kiPyzJ17YVbsa5yWuIxQSK0oujTgnVK39pE/wfBFWEwF63ATlJJw5Pnk33Gs662fAqt3yVwooKYjhBu1JC8vVrZmqssPnX3i4uZm4+BX5VYajLX+jFUu/BxX+CfHh8KHqCjToJCwL2FC7e+aA9lsHwwwI9n6RMkhLUjwW1+EM+01uDnaF54RQFuI6WbUZW4yRaIk5m6wcUXmgp7fv5cCIxvTc6Lfb65A8hTPLZnIp/jsX9CF89Iyeyib+zX+5IwSW9IAwJjrJ/kEea6ZTmGIbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b6545d9e-6f1e-4dd6-d13e-08df0435ab0d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 12:21:06.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFl+apf3MUclVgBZ9ulw/BIRXhmv4aHKvGl0p+ktyxaQfD4pUm1C0qjAYS4i2UMv7pFcOv2wY4BdctOQSebuWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB307637
X-OriginatorOrg: intel.com

On 25/08/2026 14:10, Rohan Joshi via B4 Relay wrote:
> From: Rohan Joshi <rohan1sj@cadence.com>
> 
> Cadence host controller has optional CQE (Command Queue Engine).
> The HW presence of CQE is determined by an additional host capability
> register. Look up for "cqhci" register space from the DT and when
> present, initialize CQHCI engine.

Still says nothing about Elba.  Only the cover letter says.
Needs to be here too.

However, Sashiko raises a valid question of whether Elba
would need special accessor functions for cqhci registers
like it does for sdhci registers:

	https://sashiko.dev/#/patchset/20260825-cdns_sdhci_cqe-support-v4-0-e9f72e338373%40cadence.com?part=2

Probably you should just say (in the commit message) that
Elba is not supported, and then make sure in the code that
it will be unaffected.

> 
> Signed-off-by: Rohan Joshi <rohan1sj@cadence.com>
> ---
>  drivers/mmc/host/Kconfig         |   1 +
>  drivers/mmc/host/sdhci-cadence.c | 125 +++++++++++++++++++++++++++++++++++++--
>  2 files changed, 122 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 4f060d3e5636..2cc8133e8ef3 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -293,6 +293,7 @@ config MMC_SDHCI_CADENCE
>  	depends on MMC_SDHCI_PLTFM
>  	depends on OF
>  	select MMC_SDHCI_IO_ACCESSORS
> +	select MMC_CQHCI
>  	help
>  	  This selects the Cadence SD/SDIO/eMMC driver.
>  
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 435603c8c00b..aa4431ef2b39 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,6 +15,8 @@
>  #include <linux/reset.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "sdhci-cqhci.h"
> +#include "cqhci.h"
>  
>  /* HRS - Host Register Set (specific to Cadence) */
>  #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> @@ -36,6 +38,10 @@
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>  
> +/* Host capabilities not covered by the standard capability registers (SRS16-SRS18) */
> +#define SDHCI_CDNS_HRS30		0x78	/* Host capabilities */
> +#define SDHCI_CDNS_HRS30_CQE_SUPPORTED	BIT(0)
> +
>  /* Read block gap */
>  #define SDHCI_CDNS_HRS37		0x94	/* interface mode select */
>  #define   SDHCI_CDNS_HRS37_MODE_DS		0x0
> @@ -88,6 +94,7 @@ struct sdhci_cdns_priv {
>  	void __iomem *ctl_addr;	/* write control */
>  	spinlock_t wrlock;	/* write lock */
>  	bool enhanced_strobe;
> +	bool cqe_support;	/* Command Queuing Engine support */
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
> @@ -385,6 +392,68 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> +static u32 sdhci_cdns_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_err = 0;
> +	int data_err = 0;
> +
> +	/* return original intmask to be handled by other handlers if it's not a CQE interrupt */
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_err, &data_err))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, cmd_err, data_err);
> +
> +	return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_cdns_cqhci_ops = {
> +	.enable		= sdhci_cqe_enable,
> +	.disable	= sdhci_cqe_disable,
> +};
> +
> +static int sdhci_cdns_cqe_add_host(struct sdhci_host *host, struct platform_device *pdev)
> +{
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	cq_host = cqhci_pltfm_init(pdev);
> +	if (IS_ERR(cq_host)) {
> +		ret = PTR_ERR(cq_host);
> +		dev_err_probe(&pdev->dev, ret, "cqhci platform init failed\n");
> +		goto cleanup;
> +	}
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	cq_host->ops = &sdhci_cdns_cqhci_ops;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "cqhci init failed\n");
> +		goto cleanup;
> +	}
> +
> +	/* add host to MMC subsystem */
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
>  /* Elba control register bits [6:3] are byte-lane enables */
>  #define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
>  
> @@ -445,8 +514,9 @@ static const struct sdhci_ops sdhci_elba_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.irq = sdhci_cdns_cqhci_irq,
>  };
>  
>  static int elba_drv_init(struct platform_device *pdev)
> @@ -474,9 +544,10 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  	.platform_execute_tuning = sdhci_cdns_execute_tuning,
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.irq = sdhci_cdns_cqhci_irq,
>  };
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> @@ -553,6 +624,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> +	bool cqe_enabled;
> +	u32 host_caps;
>  
>  	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
> @@ -608,7 +681,43 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
>  	}
>  
> -	return sdhci_add_host(host);
> +	host_caps = readl(priv->hrs_addr + SDHCI_CDNS_HRS30);
> +
> +	/*
> +	 * CQE is enabled only when both conditions are met:
> +	 *   1. Hardware reports CQE support via HRS30[0].
> +	 *   2. DT provides a named "cqhci" register space.
> +	 */
> +	cqe_enabled = (host_caps & SDHCI_CDNS_HRS30_CQE_SUPPORTED) &&
> +		      !!platform_get_resource_byname(pdev, IORESOURCE_MEM, "cqhci");
> +
> +	if ((host_caps & SDHCI_CDNS_HRS30_CQE_SUPPORTED) && !cqe_enabled)
> +		dev_dbg(dev, "CQE supported by hardware but no 'cqhci' register space in DT, disabling\n");
> +
> +	if (cqe_enabled) {
> +		priv->cqe_support = true;
> +		ret = sdhci_cdns_cqe_add_host(host, pdev);
> +	} else {
> +		ret = sdhci_add_host(host);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sdhci_cdns_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (priv->cqe_support) {
> +		ret = cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return sdhci_pltfm_suspend(dev);
>  }
>  
>  static int sdhci_cdns_resume(struct device *dev)
> @@ -630,6 +739,14 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		goto disable_clk;
>  
> +	/* Resume CQE if enabled */
> +	if (priv->cqe_support) {
> +		ret = cqhci_resume(host->mmc);
> +		if (ret)
> +			dev_warn(dev, "CQE resume failed (%pe), continuing without CQE\n",
> +				 ERR_PTR(ret));
> +	}
> +
>  	return 0;
>  
>  disable_clk:
> @@ -638,7 +755,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_cdns_pm_ops, sdhci_pltfm_suspend, sdhci_cdns_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_cdns_pm_ops, sdhci_cdns_suspend, sdhci_cdns_resume);
>  
>  static const struct of_device_id sdhci_cdns_match[] = {
>  	{
> 

