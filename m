Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E377D098;
	Thu, 22 May 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747918433; cv=fail; b=ZvjlzKWQtiV9Z5LpNT7plXGSQHM+CVxYRsDv2ANqeyHIvykNO+PS1uyFrTGGYjnM1+BP3grzXVWwz4JH8cFIW5tqeiiuO7W1sX8FmM4SNV9dXSlwzilGrVJ8MRbClkFAmQJGYG9oLgLmW94IvvN+Cpb4UXf3GcSXrPytD1CyCmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747918433; c=relaxed/simple;
	bh=Ovts4DicBKYSiGm6z6aXF3PNv5yBBA3PD5yS673T5/A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Eo+IipYXD6+Wv5IEjXlHO3MlEo/stJ/ottMYQIbRnSbL3y+/bV8cbY3Ss7fFdabctDiww0tLV5ReinOwsT0ameRvB/GS4giupl61yvlmgLW48jjYKT8Qp9v4tUSAkHk+K1Tc1UP0EnhSCN9rCRZLS3P0VLN4Q6dNCp2pAjqWDNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9cB7KWR; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9cB7KWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747918432; x=1779454432;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ovts4DicBKYSiGm6z6aXF3PNv5yBBA3PD5yS673T5/A=;
  b=j9cB7KWRp37phY+NgIJ7Vy+8rKPDXveEYbqiIY7vN4+SBUo9NWuwNvyq
   //7Xizb4ur0RH0NWv2vd8UIeLvEUJCALWcjMBnBiSYYSP/HIpGR3aeBF3
   998Oqhz2VzfT6HWpUiUjmey1CvsRMbKdqw1ljNqHxCbWDz8+GO9GHh+rT
   bKyQIsnWOa5Vazhekxcaj8z5QtLa3XFmh/ZeMIocqHBOIFzCC6s9c1cNN
   aSPwwF0dlM5KBfvZmUWUTGVnWmIQGzCYsmZEHwpMZL/egOQOElsLFrTAj
   SNFihy59fITQuX/iflTRr7Z+ALlG9A9xJzOSwNfM9uZqW4+ojszMkCoST
   w==;
X-CSE-ConnectionGUID: LtvhRKzuSsOSstJ/eTnUYA==
X-CSE-MsgGUID: 2unFwj/HQt+/2gWJ4O26Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60187638"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="60187638"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 05:53:51 -0700
X-CSE-ConnectionGUID: agUC4nh2Q2y6EiN+cTFN2A==
X-CSE-MsgGUID: 7LqabFlHSFSRCMypYE4euQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="141118528"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 05:53:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 05:53:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 05:53:49 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 05:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrm3mN2Aa7zBP+GxQFtfrW6rO1sg8GYM22ILTLlf5/YPbgER+53qPnRhhHusCDjBF8lK0i5CFtyxivgQzQvwf5GDYCZ81pICUrXeKIgDMJCI3u8miruuiawhA8ykQ4Xp1Qin3HEIhOy9s/lXWZEnP7399oIEkhpfG4iNMpVhOB/eHVcTckCfKV/RX0Zlk8xzMV1XCoomDrj0l10exybRsJKPHFD7Fy+C2EWNEi/eLyDH+Ar4LCTHFg06aC4UdZUkbQDDNVTwRqGIqLaec6APO5gDMiFDgzhaEhIZZhaqgOci7If6sdQbFk6seLVG8trIAl4yFPvLQOGhva9PDpfdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7IzmcZUH2z3hInrCr+yQDP9n7sD+cntpyXrPInyX2M=;
 b=grhUkoB7J7z7//Z/IVSI6xdJeLV24SS/I20nAEuXTcMhDUzM/Y1kTe+zRsQbhH8w4dAmXuX/dpgs59nQLn0S6JRf/+V4f6kT8NOa2PolMXo2FFwLkAzLrNaLhT2lr+zJ3yQp4WZCrL2Y4jxIoTCknTQs5JwGWIBbSFdD0+8SrTZeAiFvGMA68j8HiHRq8CivJU5qw1jeefZadVXF7v99PEEnLRa+28jxFgSqPEtFpDwtl+sJkRlIv3b/YXVd3R5z0RA4gcRpqP/UrKIe9qbZzSkYzVlFof18cUTlqBIXMYh26XMb+2/CZC1eUeDv+zQYy3jdsj/kh983Jd/1QeVS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by IA3PR11MB9327.namprd11.prod.outlook.com (2603:10b6:208:57a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 12:53:20 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 12:53:20 +0000
Message-ID: <168fa71b-9a8d-4bc5-9d8c-5cf67d9af538@intel.com>
Date: Thu, 22 May 2025 15:53:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add shutdown callback
To: Paul Alvin <alvin.paulp@amd.com>, <michal.simek@amd.com>,
	<ulf.hansson@linaro.org>
CC: <git@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250522094932.4187301-1-alvin.paulp@amd.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250522094932.4187301-1-alvin.paulp@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0056.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::17) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|IA3PR11MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa236e3-f6d2-4518-e4d3-08dd992fa0e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHMvTkU3cmxPSVdYTEI0Vjc3b1VPSDBrT2RnT3lWdDhMM0puQ0pNKzNObjJs?=
 =?utf-8?B?a1htMm15RlJzdUZtTnhCcTVLNWNiV2FZdDduQVN2Z0tqWVRPVVI3UGJmZFJJ?=
 =?utf-8?B?VnkzSGJOTktXT0hUdTVORXhVUXh0VWcrdk5Ea3hRb003aFNoQ3FtSFdmMEJG?=
 =?utf-8?B?Q3ltdXBNOVJkQUFhaFByalhTSjY5V0lCdmZJOEFadGNNV1Q0UlRDdjlpYW0w?=
 =?utf-8?B?K290K1VMYVN2TVp6YXkzdFpNeUNIYzY1ZEQwUGhCcmNVY2poc2p0TUlHQzFB?=
 =?utf-8?B?bVRSSytYeTZCWStYZ3BXMXluZ1hGVU56MjlDclQrOXVvWUFXc3djV29KT3M5?=
 =?utf-8?B?aEFCTkpIMUx4RktveE5HNm5tZU94bFVVNWd0YkJWYkkwQWlybS9JTTBucFA5?=
 =?utf-8?B?TWNWTVplN0VIdGdvYWhuVmlkSXFnd1I0ZjRDSjZNMFI1cFhBTytFMHpOUGhi?=
 =?utf-8?B?U0l2eHppWmVjTmdORDVUNk52V3JENmNFUDlQSnlkNUF0bEpzWXFXeFRJRjgv?=
 =?utf-8?B?R3NFWUtUdEViWWUzZ1Q1QUYydWVHd2lPQy9UOVMwTzUrcE1yNldBZTlEQ1g3?=
 =?utf-8?B?VTdqbTgwbk96a0tlTDNjZEcwb1JKQjd5cGorMTFyMlNkQjR0LzZRU01qaU9N?=
 =?utf-8?B?dnpzLzREN3E0QklQTGNhWkdNWU43K0dueFBZTTd2RGlVWHQzL0FHclN3a3l3?=
 =?utf-8?B?d3J2Nzdoa2UwZzlRLzBUTDBEWWpGZ2J5Rk5xNXUySVoyMVpILzZVM3YzWHFy?=
 =?utf-8?B?MGtnOVRQVzFBZ3F5QlBVS0FLeU9BTXF0WkYwZWVXY2FuVlN1SzNhNzltTHJi?=
 =?utf-8?B?UnlkbG5wOXdYOUFKamFaclo2V2VoQ0ZtSlY3SUJpWHpBb2p4S3VYUWRvaTZq?=
 =?utf-8?B?TjNOUDBPTXMyV3RENHM3Qk11L2pSVmYvSnZnb0JBZ0tkR1l3WURxVmpYNnF3?=
 =?utf-8?B?Ulp1eUh1QTVCUFlNdWtXTWt4Zm5FK3I4ZlZqSVlOUC82SjNKRXN3Kzl3WG9w?=
 =?utf-8?B?aGtHMUg3MURGVFkrcENhVGNZSGs3MDI5Y3I1d3ZJbERzaGI5TklReW9QckVm?=
 =?utf-8?B?M21WelJxZTdCSkM0aVNmaUlvakJ2VDNoV0s2V3FhZXltaTRKWXZBVjB3Ky9C?=
 =?utf-8?B?SzJIa1NLS05USEQ1enFGakU2aTBoS1MvS2VWR1l5WlFSTXI1Z2RkaUk1a0VY?=
 =?utf-8?B?SlV6ckZLWUNIemVVQVRYM3B6aVl3d1NJRHlhNGtyK2lsd3JaenhIN3RyTTMv?=
 =?utf-8?B?amVtRTlveFp0L1RwY3YrRzU5bUpiSzQvQzFlZ2luRExnOHZmdlRqZTlKYVV5?=
 =?utf-8?B?RVZmTHd0b01hd2ZaTi9NbGNRV08vUlg4eGpXa2h1WklMMCtQR0F4WkpmNW9p?=
 =?utf-8?B?dG5jNGYwWWs1MDdWNUVlbWFMRmI1NWNoNGxtZkoyZC9HSEtPZzZzdE9yYU9I?=
 =?utf-8?B?TkYrQnZIcnQwMWNyWmFoNGN5Vjc3MGhzS3VUdHRQeFp3SjZaaWN5UllYQlJO?=
 =?utf-8?B?ZWVQZWlRS3BYVnRpZkZ4ZXNIbXNpOTUrQUxETVpuZUE4dVoxZnpBNFpNUjVP?=
 =?utf-8?B?dWJkV3ZSZnBtNkx4enRXTysxMGlYdm9tQklmdEc4U2ZQNjBsYUdMb3VQQ01K?=
 =?utf-8?B?aWtrRTl6a2hjS1hFaHNCbklCdGpXLzRnS3lZSURyYXV4eWNSa0liK1NUTXF1?=
 =?utf-8?B?ZUx0SUxVTWlmUk5pK0tnVEVJOWc4YjFrbHJ1bElUdXFxR3FVUm1GVjBnUjRR?=
 =?utf-8?B?SVNTbWkwaEFRNnJGMUZ5aG5YclVKVTlJc2U3WXZaQkZubzNGV3hnc0p2Uity?=
 =?utf-8?B?MlZlbHV3RCtjd3Z5dENhb0w2NzlBL01hUXBzNTB4VUFVNFk1Y0NZMGpoM1VC?=
 =?utf-8?B?TXJJTkpOdkVsbnlZYmFGZUVNQlU4SDFod1RiS2EvaHJiWmpBYkJzVlZnem9a?=
 =?utf-8?Q?qfL2ep/Ja0I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNFY2xIVmVhL01oV1lybVFES1RJZWVydU13TlNXYTZEV3Z0STRWTVZkNjZ3?=
 =?utf-8?B?Nnc1bTlWWHNKZXdBcVliR0hYbE9yU25MYnlhU2JKVW1rbGlweVZlOWxsQ3l1?=
 =?utf-8?B?NUwwNFhNYlA1dTJ5NDlFQTZLWUg0UGc1YVEyWkZFRklUejkxVVFNR1JmK1cz?=
 =?utf-8?B?WndtK1pCY1JsL2c2YVRLaXNMcHVoRjl6cEVNMEhnelNVNndLSVAwQUFZNTMw?=
 =?utf-8?B?UDZySW8wTHZLeGd0bnlyR1lIMHV2dmRHVW15VGJiOTVCSXozcVNBdDZYMlI2?=
 =?utf-8?B?SVJaS2Vwbkh3SngzMWtZMnEzRHVLVGtoL25XeTd0bkxzVnZuSGlCRmp1Q3Bn?=
 =?utf-8?B?ODRYNThtekwwWlVvUHU3c0IzV202VHFLbXhtYjlOZ0phVHV4SUhOWldzdEFB?=
 =?utf-8?B?OVZEdEhMMWhaNWFHZnZaeGV4ejU2RFZYQyt1dkhnY2NjSlJQSG5iN0R2N2RV?=
 =?utf-8?B?U3FoL0ZTbm9pM20vQm11Y2pNb1ZnOXRyREdFbGNaQTBIY0F1YzdaZmpFekdl?=
 =?utf-8?B?MnRMQ3FQTzFZRFZQOTBoWFA3MjRucVRhZ2tjZ2JzaU02SnVoU292VzVXMFcv?=
 =?utf-8?B?MGg1cmxqRFljLytqMDREYWwwWER3NVRLYnVLYytHTWNIM2xLNFViUkZOelo0?=
 =?utf-8?B?WnhqS1dIeWl6OEFLUGNSaTUrSUlFQTZ5Y2NFN1VhT3V3dks1N2NhNlNyNyty?=
 =?utf-8?B?YWw3c1F6c3l1eWNQcjBhRFRFNy9WRFhrUGQwZUV0MzYvSWROQi9IQWNHeCt1?=
 =?utf-8?B?Y1JKcU5IazNDQSttdCtlak5Xd3VWbmdPOFdqU3hzQTc3OEJjL2dwVFdWeDdW?=
 =?utf-8?B?eFpVSUc0QUh6VUdIQSt2MUxMMXlLdmE5V1Nad2VUNVcvNFRJbWpQOUgwTHVr?=
 =?utf-8?B?dXNiR29QenBqNFFjR1VwOXBlZFFORkhvVHlua3FTYVdDaUFKdDdVcGZvOHFG?=
 =?utf-8?B?SnhoNUtuWTJjZGY3UlV5TDdoWU5WTDhsdlF3bXVvV2lFdFBiMnI4NDc1MHV1?=
 =?utf-8?B?TWU1NG1FQXVPdm9hdlZVbVgySlFaZVh6R0xZYTU3SW1TUklBdFRSYkVxL2pa?=
 =?utf-8?B?T1Rhb0ZBano2bmhXRjR3L3dINU5iYlpZOEE1b2dhWFg2eklFYys5TlcxTk01?=
 =?utf-8?B?YmVoQUJZc0lqNENqeXBSZ0lWL2l4b1VYdDZCU1FiQ21Cc0dxWHpOU3ZtUFhz?=
 =?utf-8?B?VkIzb296b1FRTmJldXNML2xRU1RQZGpHZm90VXJEV3RUamN4VDgvWmNIRzhY?=
 =?utf-8?B?RTU1bmRiREdkK0M5UDRmTTNnSUM3UlJPbWlObzd3SWlRZEs0R0tuVlpIcVRr?=
 =?utf-8?B?RVJpM3VEYjNTTytRSm1GVEt2RkcrOUYzTnY4b3ZsRDcwZlF1ZWo4bWY5a3A2?=
 =?utf-8?B?ZVNBbHF2dW03Nng3UklRRnhqV0ZjZW4xVHJ6SlBWOExYSVRteHI3QUpNVytJ?=
 =?utf-8?B?SnpsQjAyZlFQV2FlbUIvM0ZpTkFxQkZPa08zc0d2bG1xZjA2RTRHYUgxVHFO?=
 =?utf-8?B?MjNkZnZvUExLOEdhUlV0MXpWWE96VWpaeHJFWU9DODZ4dzJZMVZzNU9VNU12?=
 =?utf-8?B?ZUdWQkRXVVZ1ODhaempaeGtuaW9KWEp5TzRLeGFyZEhlVC91MzNqTTdIM2NN?=
 =?utf-8?B?dDV6ZWpMLzFRY0JmZDMyeThqMTRySEVEODlIaDFzc0tqd1pQNGNELzZ3VjJj?=
 =?utf-8?B?c0xseDRpaEFvQnRFNnl5MC9pd0tFNXNvNkQ5MFdhcEFBSEEyb2dTdU5LTFdJ?=
 =?utf-8?B?YzFQTnpOVnp0WkxaQ3d2ekFXK3hFY3diVHpsYms2YTlLdzJIYTFQU2s2Qkpu?=
 =?utf-8?B?VFB0Q3gxNEJPWnNHTVJUWjVPZDRkSURXTW5ZYlp2ejhWejR2M05uSkZWemlu?=
 =?utf-8?B?RFhBVkpzMTJGNTJzRzROam1taVU0bCtWM1NQVDZKN1labVR1Nk93K1N1SXY1?=
 =?utf-8?B?blJ3Q1FqcGlraXlMQXRvVUFRa2Z4VlBtcXU0YVAzV2FyR0x3TUp3U2FxSDBl?=
 =?utf-8?B?V1pUUUpLRHhDdVU2bjBtUGZxQXJqOFhZVTE3SFVMWkI3VnBvNHRpZXBNV05E?=
 =?utf-8?B?ek5ITkxQMHlRdzIvMjd6WFZBcThKUWp0ZTlLNlZHdktnbWlhTHZ6cnJMU2hM?=
 =?utf-8?B?M0taRG1NUnhSQXhURjVKMWlXbzVaV3pxa0tRcXpjZlFETlZEYUdWNVRhUWR4?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa236e3-f6d2-4518-e4d3-08dd992fa0e1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 12:53:20.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHkgvxGFDIbG9EV7FZ/mllijzvBsCD1G8EhzXwXO4mf56F13/T1Gy/BtTzKErE5+SfnktIo+HN5pRplklbaAcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9327
X-OriginatorOrg: intel.com

On 22/05/2025 12:49, Paul Alvin wrote:
> Implement shutdown hook to suspend host, power off PHY if enabled and
> disable all mmc clocks.

Please extend commit message to say why you want to do that.

> 
> Signed-off-by: Paul Alvin <alvin.paulp@amd.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 8c29676ab662..af4643e24ecc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -2056,6 +2056,13 @@ static void sdhci_arasan_remove(struct platform_device *pdev)
>  	clk_disable_unprepare(clk_ahb);
>  }
>  
> +static void sdhci_arasan_shutdown(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	sdhci_arasan_suspend(dev);
> +}
> +
>  static struct platform_driver sdhci_arasan_driver = {
>  	.driver = {
>  		.name = "sdhci-arasan",
> @@ -2065,6 +2072,7 @@ static struct platform_driver sdhci_arasan_driver = {
>  	},
>  	.probe = sdhci_arasan_probe,
>  	.remove = sdhci_arasan_remove,
> +	.shutdown = sdhci_arasan_shutdown,
>  };
>  
>  module_platform_driver(sdhci_arasan_driver);

