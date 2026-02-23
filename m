Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF303346A0C;
	Mon, 23 Feb 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839561; cv=fail; b=ZtIXAylSx+oO619k1sVSLthOtIHyOG1N7aVB3bYuBKVSKaigM8VEWrkhpyGooDTkNxKlK6IDVBk6kd7A/p7ANCf7mGXEAWJKSNGmGhAV0OnioYDQnrY1Atq7FMMtwGcJkDyIdMAqe6/LhcH5Y0mhMRvLO53ahEfTDO9azHQnE7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839561; c=relaxed/simple;
	bh=UsD3K22Ho9pkoamuxZA0ync+DDe7Ms/kdrcPLy6szBg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6P4kjAED8ttCdu1HrnYPqINaN9XIvzNF2jxNu85nSnRyVvFuXfFkkdhlLXmmjFZ0adE5msvSTPjaYDSIIbyga6HemBQHUnFrsVLOAdfbx4Vmomj+ZH0QG3Uw6OWu3N2fnpSp/55N65QGk7/I6j28BJXk3xLhrPhxslNgLOuUt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIT/Y13j; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIT/Y13j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771839561; x=1803375561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UsD3K22Ho9pkoamuxZA0ync+DDe7Ms/kdrcPLy6szBg=;
  b=AIT/Y13j9cc3XpHFcieGR5wlsnCfTvJYqI6y13hje3bN12rrb0gRd1dT
   CHRpjkADn6NhvSO9bz3dZBQwk2JTvfVd6X9DDmSbcbmhIIck32R5hEVrj
   LnZJdHlaQ0dr36Z1Kq3zqjKJD5e1lDuRyf8zk3Q4Q2L8yW02VxjAWcwXj
   2nyIgD56aFEvlJvYXDeFC7MPwdAUV7sBcMTdkW1HoXfE48F1xks4iilxr
   3+jU5W8vPieg5gSXWIZlE5mZUdwkQGjuWUo2Uy0P0evY5uL/CN45HgDPA
   I5OYqJKP0lIHNgjtHHJ5MVDT1tVRgsWJKj5cmVxYy9PV/gsNN0gdjDvEt
   w==;
X-CSE-ConnectionGUID: oW6HGrJRTx2j9oebq2IlcA==
X-CSE-MsgGUID: kEwrR4yAQJCsxEg3a8hjsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="95447245"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="95447245"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:39:20 -0800
X-CSE-ConnectionGUID: bBAAeZ1RSHy5f2jy/Sl27A==
X-CSE-MsgGUID: nmmcpmF0QpWLMe1Wz4cJig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="219059974"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:39:19 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 01:39:18 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 01:39:18 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 01:39:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtOKRO+V59PyjnpTyvpyrQUBxYXqTICEogEDRilweP1ILDjzjQw5bmklp9i17xVI8+VimpwjMLmaU1DXC0jVdwcvqXLFuPnFTEN+WfaoFHe6LNREvKJJhRdTEdUZSJRs12Xdzluuav0eZR6Vj0at9hU2C/wX1eRYpZU/EVuXWkxwdh/TFix4urqZCNiVw+5zvapOFoP10A1XPe37Rjqt5YjmyqyJ/7NV4p214xrSMdZwOSUxrvO9P9Q33hVYe/Tg25KuM0dcULl4ZuHRZcCsOpPA7CTMzP6hs1OuZGJfJnL2w6NIiaOduOyG1q6nTrZ+o0fjbmnvPN9bzAARxFnxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYiov0D3duLTcrHKWDfTYiCNYUs4eo+Jr256fZjyJLM=;
 b=KOiNcYFzuQqKRkB9lfwtUNoNYQyrwVSjFqN4fMZpDt8MGxm9AlAzNiKTkCPeJhLGLiYA7efekP+1sgBhGpMQI8CuHEoBw28TmbQOJrsi3imBjsWLI+QUNfFLqkw2LjiUJE+xeTXD9g9jNnNRg2VgSa86xpLKEyCMbBuZfIELokqlf+yO8ls1iX79XDWNO5e3k1TQ4uYkIre5wSGjR0LNrI9FQ3rcDJP7tKN0oYl1gwMLN25lxVKVp9la07lvRBZqzB5+2WExh+WZTzc/2Ugbrhsj0KSLn3U3eMXm0+i0W9w+9aMfdzrCFiPkt7KeajS2jFU6XKPTAUpYPuFpwF35eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN7PR11MB7706.namprd11.prod.outlook.com (2603:10b6:806:32c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Mon, 23 Feb
 2026 09:39:11 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 09:39:11 +0000
Message-ID: <1c71bbc1-db98-4a0c-8b78-e40bc13cc738@intel.com>
Date: Mon, 23 Feb 2026 11:39:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-pic32: allow driver to be compiled with
 COMPILE_TEST
To: Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260222-mmc-pic32-v1-0-110382af02b0@redhat.com>
 <20260222-mmc-pic32-v1-2-110382af02b0@redhat.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260222-mmc-pic32-v1-2-110382af02b0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0212.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN7PR11MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fe9a38-e893-406a-d509-08de72bf6623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0E2SUFQbkp1d1BVVTJOWDMxSER6MktrTGJjaDFaZHhEZTVqeng1a2hsb2Vl?=
 =?utf-8?B?aXUwQ0FDZGczZDlPTW1BaVR1SEp0VEhUeWx3WFpnMkVCSVdpWjZWQ0hlVDUy?=
 =?utf-8?B?WWNwKzh5WFpSa0tQY0hUSDUybUY5ZitNK1FBTkR0T3dqMnRkOWFEaU92cTRa?=
 =?utf-8?B?RFFENUdsM2x2U2FEQWs0dERkVVhuUWpPa3pmVThOWU5kYjMwdFZUc25ucm95?=
 =?utf-8?B?R1oxOSsrOFFQZXFNZ0ZLKzhxazhsSWI3cXV4ZlFYNjNLSHo5cFU1S3FHbTNX?=
 =?utf-8?B?VzFtN2tGbUF6bG1SbW5qeHprZm1UaE5TVVUwckdFRHdDNGlYeHZwdzBGNEJK?=
 =?utf-8?B?dVVkUmRGTWMrY215b3E3OU1YeTh3RGU4QVA5aDdDVWwvRzF4ak1aQ3Jjd1BF?=
 =?utf-8?B?d3FBa1FvWjBMWWVKNHBRWTZRMVBjbFN2TEViZ0IxRVhQNHJFaWpHbXgzVmlE?=
 =?utf-8?B?SGpoMmFkd2JpNEpTZTFoZXdyd252aEVwL2NsM0JDbisyQkhtd2JIeEZYRG5M?=
 =?utf-8?B?Y3NYMUF4bFk2K3lLRkpXVDZTYU9mY2dDQ0FhY2F6VnBKL2dSaWlvMlJVelcw?=
 =?utf-8?B?cm9yNnF6Y2h5VTY2dmFpT3Z3Y284Njc1d2g3dUx6eFFVdDU2WUpLdXFNQzBo?=
 =?utf-8?B?UVhWSDl6QWN6cWtZbVRUaFRkUzZEWGREQVhveU5mVEtHZ0M3Z3A3VjdEdnh4?=
 =?utf-8?B?eWFMMkV1MUt0LzNLczJ3MGwxcGk5Ukg5NVBvdXBCNk93RkZocEY4TVpObHU0?=
 =?utf-8?B?Z1ZpRFZKMTZseFp1QTVrcndKellIa3dmYjNBSmt2MmZUV09OZmNxNzlJUU9y?=
 =?utf-8?B?MzQvTUQzYVliREczVzhLVGRoOWhEby8rVlRPQXQvQW11aG42YTBjeEVIRGRv?=
 =?utf-8?B?UTA4RFhjZmJiMlF3VTdPWVRZWUlPaE1SL3VtVDJnWUVmbEdUd2JwVkNTSHlR?=
 =?utf-8?B?eTlrTGZHaEZTdnlQSzBVdGN1cHdGMDdtNllrNHhHZXZCdHVXSC9INzhKQTlR?=
 =?utf-8?B?RWdjVDZ5bUFndWRoYjI3cG12N1hSSTNkNnh5d0dXaitMZG9hMlE5cytUZVUw?=
 =?utf-8?B?RFRPdUJlVDNSR2w5d1JuOXhGRGNXcFV3R2xkako1TVZkMnU3QXpvNnJKVkYz?=
 =?utf-8?B?UnZzZlFma29PM0FpRjRmOVFiOE9DeWJOWG12TlRHMmNoN3ArYy9TT0lZNitH?=
 =?utf-8?B?bERNMU1ISFcvM09KaHQ4WVUwbWRlbXUrWXlzQW5sRHhCWWlQYUVBb3EvSnpF?=
 =?utf-8?B?Z0FCUVRNem5JTlJHOW1HSzAva3VpREZOa2h5SlQyQ2tMYVhiS3Zlcm4yU3ph?=
 =?utf-8?B?eFhhdUNhUUZGQnpuRFZuY3FGTTIxU1ZOc1RkN1JHWnVLZ1NvTC9pU3BvenJI?=
 =?utf-8?B?SzdUcEwzSTBtU2p3QkVYUFNGVjQ4clpaeXRJZXBSaW9OSWNUbzc1UVRsdzE1?=
 =?utf-8?B?djNxOFUvdlNacEtxOEtlWnk0a2QvTVM5eFB1REtWWE12eVZqbHUrbXgvYi9I?=
 =?utf-8?B?V0RZNGo4QlNXUzV2cCtjdXovRE4rc1ZBT05pczBxc1FkazlGSDZyRVVMSmcr?=
 =?utf-8?B?RTI5bWtnWGhSUU55RlM2SkpoVGJEVzRWL3pPSG1XN1VGYU9SbjAycGF3b2hM?=
 =?utf-8?B?NUFtTWtiN1NMQWZrZlZvRmdYRHNVb3Y3cTZjT1ROYkQxOEtabXBGZ0tESVFH?=
 =?utf-8?B?NWJ2MzhrZlBlR043WFFqMEZXUEVNZWJHWkhHUVFxYnNsbWJ1RlczVmNmREdv?=
 =?utf-8?B?RmJVbjVaL0R0Vm5qRmlWVXpvTlZrVWJFajhLWktUNDJxZEUrWXlCQlViZWJh?=
 =?utf-8?B?RkRlSmpzRit4c1lDSzZERjMrMHlGd1VkQm5nNE05UVJWcDljOGFpdTg0NUhJ?=
 =?utf-8?B?MWxYWXcrOGw2UTFtRmIzTzh4VTFlc2toT1EvYW1BcEJ0OW5RdEE3eE1RM2pX?=
 =?utf-8?B?S0NGcnhlZTFITjQ5VlhETCtXVHBYWTgySHIxK3g2VXdCSUJZZGlYTGNYcGpw?=
 =?utf-8?B?SCt4UGQxQWI1VmoxejY3Rk1VWUlKdnVIV3l0QXh0MkRhMEtHNDVjdVE3TzBZ?=
 =?utf-8?B?cTFJYXZrUzVRRjdBZ1RWc2hxeUgyOWdZS3dKczd5TXcyakE3Q3dvcW1SR3Bi?=
 =?utf-8?Q?7Fe0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBMRUcvMzkvZmxJMUJ1L2lzeHlKTVNadE1LTnBsUUhVaVRoTEsrUXUrR0ZB?=
 =?utf-8?B?aWpTeFVHbUtWcGdBbUlMMjQxT00zN1ZJU2hWNVRLeVYwckx4QVFFZnlGWHNi?=
 =?utf-8?B?bnRDRDZTcUtQMVVpK0I5MEdwK0JKdFNhZExRZGQ3NmtyaHFYd3M5VVNmaDFU?=
 =?utf-8?B?czIycGIwQ2dBK2dXeGNXcS8zdXd4YXhSVkdwckJpbHg2ZldYUzVZUmVQMXJx?=
 =?utf-8?B?SkxWRkF6bCtsVWx6Ni9iODRaUnpYRnZrTkoyU0N5WTl4MVVnZ1MyZ08va3h2?=
 =?utf-8?B?R1NJUDc2TFRHTnhMQXBlejBHMC9qUzhkSGRwVFBRVjZCcUJjY3JVc2lESkZI?=
 =?utf-8?B?eW1IVitRYVVPSmZNZ2VqN3ZCbTE1SU1qbnpjRHNvK3BqV2hRdVAzOHd6OGQ4?=
 =?utf-8?B?cWc5NnVkKzAzbEJxRHZoZ2wvaG5tMy9jaHdISUhNNmpibDhVQWZUbStXZDhV?=
 =?utf-8?B?eGhtT1AydFRIRzh2NnRVRVBxaThyVTdydGNNN1dBVDRaa3o1NUthMU5TVStG?=
 =?utf-8?B?SW9LM25RQ2RMWFFoaFJML0FiOGZKT2ZqbEg0cCttZU93bzhheFQ1UHhEelZa?=
 =?utf-8?B?UVN6QVZ2dGFneDEzaGpvK1NWeHQ2YnFRR245SlJ2d3RyemZQVmlrQS9IMDBm?=
 =?utf-8?B?TmNJNGlrUEIvVG5IL0ZLcnk1RHdUc0FKOVNCZzVNczRKN0Y0azBYUTFzVmZR?=
 =?utf-8?B?d2lWOTFCbGJDNmtwcHE5TXJpWkxldUgyQlRkVXZSQXdsTFVKZUlaZXhvNTRl?=
 =?utf-8?B?MGNYbWdKOVZka21LRnBYUHExKzlWbVUwOXl1MUtYdUtwU3RnV2dhYnkyajBX?=
 =?utf-8?B?MDRTYUk3VHc0aDBKSkpuQkpjWFdjZHJDazlqOXArUzZwL2xJMHNDd0RXNDZR?=
 =?utf-8?B?WFpTTThXZkhpR1BJbHFHODVtNDFxSWFjbXNzRUZOdy9WWEcrcXRGTXdpV2VG?=
 =?utf-8?B?eVVPVkY2eHZZTUlLK0ZsTndpRFc3N3pIT0MxTnVoNTg0eUFsR3dTUVZPTjVz?=
 =?utf-8?B?Zk1hUWZOSGh4dmlrWGVyRmFZdHpuUFAyYmcwWlRwNjBweFlPUWNwYkVRNWJ6?=
 =?utf-8?B?QWc3N0tkMnc1a3Vrby9XL280eXkwUWtvUG1oTzFnNHE2YVc0OSsrSk9xekFh?=
 =?utf-8?B?MjZydU1FSjB4c0IwVVdlcysyMHAwT0QyZnpFV3ZTQytFOVMyQjhaVEh4T3FF?=
 =?utf-8?B?dEVNYk8xQXFydWc2UzR0L09WR2tFQys0a3l5NURFczdlQjJ2djA2Q00zQWFG?=
 =?utf-8?B?SzZkbGdGVE52dU5KWlBQNG00WU13U2NsMXZHN2hpeGxzajI5VWppNUxRNDVX?=
 =?utf-8?B?MDBYT01raTd1QytOM004b2NFOS91clBJZ2xxV3pmNGJSY0M0S1lGY0tpRCsr?=
 =?utf-8?B?bzlTQ3Z4RllMRXBrZG9pQkl6RUdMUlhzSGFJTDVVS21paXNVZktsVUpGbDR6?=
 =?utf-8?B?WFpVQU81S3d5WW5RVityUitlSE8wTk8xaUU2ZktPYzJ0c1E0bDRCbXIyQU0z?=
 =?utf-8?B?MG95QWlpSTNlb0JQOGg4enRYQnZpOWVpaDJxWFIwY2p4Q2NBS3hXRUxBaEpo?=
 =?utf-8?B?ZnJBKzlRVDUwTFoyU3VMUXF1VExkQit3ZFFsaElmcmdTanFXaDZBUVJySUNX?=
 =?utf-8?B?TGJYdnFlaUxqMURSeC9VSjJPU0NVWDJwUUhlUldDU2xTU2ovZ3ptT2h5eU4y?=
 =?utf-8?B?OXBBeng4eURZcTlRSk1NTXRCZEl6MjdRaG1OVzdES211ZVUrQWUvQVBTV1N1?=
 =?utf-8?B?aUxick5TUm51bkNuQmNTZ0Fja25xdEZYKzFuamh3aW9WVzI3bDdUQ005ekFh?=
 =?utf-8?B?TVBWTDYrV3FFS1htMStzNWxxUEVhZ21yWUd5Z3EvcHRhd3dWcHI4MjMvNklW?=
 =?utf-8?B?TnpTZ3VOM21Tc2J6UFZRZ2FKOG5qcUZ5THZSRC9CV20wY3EwR3p3ZFl5N2Nk?=
 =?utf-8?B?d3FnODNxVFBMVjZzUmFMalRhODRTZDNoSU9MbHNzZmJZOGxKcUhxY1pTTFA2?=
 =?utf-8?B?MkptOG8rOEtXZTlscjBSbFRiNlFQUmhIVStsWENQK21kMTk5b1gybHpSTGpW?=
 =?utf-8?B?NndET2hZb3hqMVJFdDB0dU9wZmJiYTU5aDgvMnIzS0FUSVRtTGF1Uzg2SmNL?=
 =?utf-8?B?bTJWbHlGTkNjVEpkZ3Q2eHAxT1lrSkpKUkFiaVlKQVhKUmdNM0E5NGhGcEJu?=
 =?utf-8?B?aFMxTGdndDFDVGZhbmRJaldvZWZVU2NPbUxVSVJEbXRXa2Jhd0hpb29YWU11?=
 =?utf-8?B?QWlOS25VME1vYXo1OVhvRm5BTXB3Z0JLc0E4Z3RhZlRKaHRXOTJFcGVrOTFt?=
 =?utf-8?B?UkdrVXFPOEdmbGZsTGpGcjFRK1NzMy9TQVg2NS9rTGc3cjV6bktWdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fe9a38-e893-406a-d509-08de72bf6623
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 09:39:11.3162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9iyqm1SYtWZnnlPu+NF7VOxqgio3iUSplXwHxhzdKLuKrSmsVgrGti6rlzJsEGCG9tFmEquPaXt3eSNShBLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7706
X-OriginatorOrg: intel.com

On 23/02/2026 01:39, Brian Masney wrote:
> This driver currently only supports builds against a PIC32 target. Now
> that commit d6618d277c1a ("mmc: sdhci-pic32: update include to use
> pic32.h from platform_data") is merged, it's possible to compile this
> driver on other architectures.
> 
> To avoid future breakage of this driver in the future, let's update the
> Kconfig so that it can be built with COMPILE_TEST enabled on all
> architectures.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 6d79cc9a79e22d80bdb8977a8182d814ab91927f..4ca55c025159ee4c6b70dfff0ea3a44ecad98ff3 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1044,7 +1044,7 @@ config MMC_MTK
>  
>  config MMC_SDHCI_MICROCHIP_PIC32
>  	tristate "Microchip PIC32MZDA SDHCI support"
> -	depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
> +	depends on MMC_SDHCI && MMC_SDHCI_PLTFM && (PIC32MZDA || COMPILE_TEST)
>  	help
>  	  This selects the Secure Digital Host Controller Interface (SDHCI)
>  	  for PIC32MZDA platform.
> 

