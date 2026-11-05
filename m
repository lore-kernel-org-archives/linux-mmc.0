Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793863652;
	b=aznTgnw9TvqRPy9v+TJIrRQaIW8uuo4qIvI4OlqNXg8s7LtsNQ4SGxOJKMtH+cUXV0MB
	 RMjbKTJPdvB8HP5cObRVMTnfMYS2JN6TRB83upJY4ndt9+6KravEYr40/2fPhPeVnmoVX
	 5croAf9YhCNNBqkKxQ9Xog0rPbHDS8YhBxiy+QkLrMLGAGTTSR0yvP3Z0aUF0Gob9vp3x
	 +74vG3BXHW7QQAvBP+npS38M18isswLiErZK2HUIibwcztZoYKP03XeGqpiP2JNUvlR0j
	 qJ578CWf/uJSpEFyQGhHzMXCo9qLSeg6nE1WawH33Jl8eeeRjg+9nDRl4ssNDi9of3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863652;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=cGzIIXsQ+3SPPbuGG2DwfRO9OX13u/OqawgcaKjGEf4=;
	b=DbRxsRNwOleqAhW8wc7a6mz1BuCQk03CL9adyfyMTOtU6r2JMO6r2Ep6bbKo+H6XF6NX
	 uzOiFPnUXaXbbT7y52VNmpRjKm5bPrBQh7zr1tdHh+u6BSf4QZRWjXpJYEVFa6toyZeYd
	 xcfFulI4kN1eqtVQHsvhGAxkc5K4Chrtc6Eqlu2gPMiepgyY+uHrllAYwRQnYJAtaWltE
	 WPg+uepgCwH8Hi6+9SywCbX85wuJ081qt2x6LCUVFuT5QCaBh8mUZUMRUuBIznB5GKpEk
	 C7vn91LzMLmCRti4vg+L2fn6XKqTsyQImfHp7hvZ8EZ8/tDhJTpe7zuVsZQudIr3VRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HcRkS1C9;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE0606A33A;
	Thu,  5 Nov 2026 07:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51FE0606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HcRkS1C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793863650; x=1825399650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Z+mfuPhMsfYR69y/ACx7sODhrloP43Dcdb/1Xuybp8=;
  b=HcRkS1C9JpmkAqwVw0NojPjTzi3viOhYTrmKHMM/Rb+qxoIV5vxJ2WbK
   CpZYm8JN1d747B75Bwb02f2j2nML9k8Jdq4wJCXSXfRocedZvOeSLVW0c
   uoMCIciFqqjnkABzrEB1zPMpFy988icCtu7npAnVUVcWgXLDo+Oubex2y
   o26G+8bhXk52cfvFUl8PvIY+z/j0PgC4ZQu4sbdqXRVOJjCcrJAfolRZN
   /UOI7HBW2qLkIE5XS5QJElbDU9W90eMBjpWKvLRtgwmNp+WBk9+L1jhnR
   dT7jqC6j2eidkY+HuZbYYqCR2V5hcWmzDVmUa/RS7ogmlSfomMDK1oiu9
   Q==;
X-CSE-ConnectionGUID: aE/QHk5wRMeKSPWQacJuyA==
X-CSE-MsgGUID: PhlutEdUQfu9Uh4atHEPkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2525635"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2525635"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 23:27:24 -0800
X-CSE-ConnectionGUID: WYhz4plsS6aqRR7KJnbkjw==
X-CSE-MsgGUID: yGAY7+gsSXGvtOv5yxo4dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7275282"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 23:27:23 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 23:27:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 23:27:22 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 23:27:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K345i/+OK2rZDgsk6a8NKO9jDbuhBJosRFkCymrWb/I+9glu6Vtv2f0oNjbUTXXhv6tgmS/2smD5Cowj3vlZNWEcsZ2Vz5678Ilx9EyJBlNRtAzFzLsHvfmtaUH8uz4NxzMvmVQHcmAXDOEMl0d14IAvZLm/Yrnz7EOJBeZKPk9hxBSRXq73GrekPaFXiO1QJQs1uuxy+Feb2sNOQTNnpPAllqkVS+qH/e5wuTRbxGLkEVx204fCPz3xYrxmFpId4T70IgFzYq3IdyvsCUFtH5j/7s5cH/hG6mEuhQGtZ2oh21JLicC7LM2wf+Oi3ObWa96fCUjNgUuT3cHM2LPHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGzIIXsQ+3SPPbuGG2DwfRO9OX13u/OqawgcaKjGEf4=;
 b=f1NxXU1THf6Hu0hYpxjLmGnRN7fqnWHOLzmz8euVaaJsU6RIhyFvdTU/t0SVtns1kyuslL1Z+x46VMayNVSSlI8ig31rw7kW7RI0pT7/p98sylzy0Y0gWYCLzn72sC2sCEaImWdPb0ewaQqK3tMIZhnee2Mw0fS8PstKerp97SjF/+LGFCAm9vZPWvvhlwVymL+vy0SuTyI/jvcz0CqWzIp9ZwjUDIEbCqx6SeSxn0aLSxSWOkeOA/rAHG3XuludY7qHvTJRnQ6083Z4BzyBrbUMeQ4eMZMf98wOBLHj5y7+JOz1oJK0pdEgzFjWeJH/JXNWz3j9IxMvKmcdZ1PdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 07:27:15 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:27:15 +0000
Message-ID: <2e57a04a-71d6-416d-a49a-c7d78318ff79@intel.com>
Date: Thu, 5 Nov 2026 09:27:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: cqhci: Add support for setting command idle
 time in nanoseconds
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Asutosh Das
	<quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, "Ulf
 Hansson" <ulfh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261104112657.110536-1-changhuang.liang@starfivetech.com>
 <20261104112657.110536-2-changhuang.liang@starfivetech.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261104112657.110536-2-changhuang.liang@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR05CA0003.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::8) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: cceabc71-9bac-45f5-a71b-08df3b0e3732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|10067099003|18002099003|56012099006|11063799006|4143699003|261102123227099003|261026140227099003|261028144727099003|261022075727099003|261026121527099003|261102130727099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: Sp9h9da6FSEFPQapM4Dpric0H6kBovRf4auj5Uyux3HTQywXm09mp++dK+EotyFAF+ubQP9t7qIUTu6Xj44hzAUB8DXtmLA1kxYTmKa92uoboH2SLUhZQ6eOGlz9gsU+jKD337DO2ap5rNGkYG/bgdkpBudOhJrBZi2n17W3oZ5numZE1Dxa5JPFRH2SH3g4w7ReC2k1jtfkt/Kwrb3p6I+1QfDPgNbWBblR0AnF4IWVf0xGrKr7fjeJuI0liltIeSych/cIK0t2hrHmslhlg8mWkEHkm+KOFCx8SVh8qrkUVdgFDJ9FaVdAHayOcSuABPRx/oLBw1GNlPcByWwtGa9VTp4skoP58M9QLmzRi+PGUrigWDIWhkq8b3ZsW0srO3LMfbZ1n2SXhaLHtZR+daK7xjIL7J0HjZpS7vwbPcyQzql5xALD7AmzMIvTbDk0Ww1+VeKwS3FlG90k1DidHdKHO06d+My0SFcmE/Qalz0keMxO/7cXV9bav5ANhOhiu3fKO8fCzrLV6kETz18/CpDVUl/72qsAfFhIogi/4a8MGBVKXVCn1Lft47FuKHkivTm81lFjaqJ/0rFRZ+m2MBx1RB300vv0LGMV8MGbGbld2EXNk9h6+dLMmpVy45L+XDA2ijc0K06qVsG+k/3elHD8Mz+RKGOUDF5G1rSDjR8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(11063799006)(4143699003)(261102123227099003)(261026140227099003)(261028144727099003)(261022075727099003)(261026121527099003)(261102130727099003)(261009223027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFoMHFJcjdGdXQ4YXZzSXZLdG9wNlQ2bUxEbS9lRmhER3ZpeDYvS2ZjTGpU?=
 =?utf-8?B?S0o3amtiL0FMWk0vNDVGNmxnUVU0aDMzOVZpM2FDelozdkdxaTgxVmRtTnk2?=
 =?utf-8?B?eGlSU3E4eDlwZ3QzTkMrYlNXQXI1NUVwdmdKYWtRN09YcjZjejdpaktuVXVL?=
 =?utf-8?B?Nll2MnltcWxBbXNMdVRYN041eXZWcUhiSlUxNTQxWFdUVE5pWUdBTjBrYUE0?=
 =?utf-8?B?bWd3TU15a1U3dlNLSFBScXJLc1N6WVdNZnV1cGJmSllyRjNieXNybURscURK?=
 =?utf-8?B?MW9CMTFDNzUxRnJBT0tJRUFWVUlmalZVVVlqdWRtY0pZZS8vVlM4WWpxRkRh?=
 =?utf-8?B?TU11VkJ4VGRJNEZ5Ykdja05KUWdCMGRyQi9PdC9IaUVaa0Z3UHU0eWVkb2Vp?=
 =?utf-8?B?eWdycmdWRWFTVFlPQmdyZ1dvM3c5aFhYQy9GdCtIWlB1b0liSHZYelBCRFRN?=
 =?utf-8?B?VE5qUm9tbGlHaE5ucVFpTmE1SzNsRUsxOW1jN05pcEZaRytPNVR1TUc3OVhL?=
 =?utf-8?B?MFZaYVJEUUxZQng5YWtVNjFGcUhKTC9zdW9YVFp2T0pETkduTUY0czlBMGQy?=
 =?utf-8?B?SkZSR3dKWmw3Mm45VHJVb1lrdFdqL0s1MzNDSEVhM2hUNmd1aUtvRXZoQW5a?=
 =?utf-8?B?T1J1anJsWmp1WlN0eVZ5N2lNNmh4MmdyN1V4MzZ3czY1WDdUQ01oOFhNc0VV?=
 =?utf-8?B?VkFIalhUUWlFVUZTdDdJU2VZZ3JZK3JqcFNxL2dTODZRK0pDQ3FpblZvUldS?=
 =?utf-8?B?dENxbkZXK2xwRXFyZi9KS3A5aCtsR1ZwMmQ2U2hid3FYZzJqK0EyTWZoNXdY?=
 =?utf-8?B?Y3FlRGUxNW82eCtyV21CdU9scmNpbFAyZWFkVC81a3Njb0JvRzVpaW5tOGVp?=
 =?utf-8?B?QXVQU014cC85cStiamVxaHBCNjVTNU9MdVMzYTNSSzRxbzRweklPenhheWNt?=
 =?utf-8?B?QWk2Z2E5QUViRHdDSnl1RVA5bVdQdGpZT3l3MEx6a0w0QmFQUFZwajBKZk1W?=
 =?utf-8?B?VTdLZ09XdGwvb0lUaG5uKzRUNVlwSmxkRXF2LzZSVHQ2MFlTS3FxTlhPYVBy?=
 =?utf-8?B?Q3RydnQzWldta09UdGZKR3Izak1xa2xEYUtaRHVYaHFxeHVNRGlXcXAxdXA1?=
 =?utf-8?B?NTNxUlJBb21ieERXTmx2K0c1by85YnpGejV0YnlSdjc2UWtLUFNlNlY5MCts?=
 =?utf-8?B?RWlPakEycGFqMW9YSG1SUHRKb244NjBhY3lOMlQ5Sjh5UERFZ2VJM1prQjBE?=
 =?utf-8?B?UzVvUXVsZzRkR3ZSazliclhWNDIxVWFQVnQ0dFkreE9JbFNnK1pmT1NJRmhl?=
 =?utf-8?B?b3drdjBTUXM0THFwT0JOMWhQc05nT3EwcmJPbEVheU5wZk9VNnI3TmZTWjBD?=
 =?utf-8?B?MFVaeXF4a0FETXRmR1VWbDNFQm9iQ2NtS3duYTlxa0FIV1VVZ1lReEQ2SGhN?=
 =?utf-8?B?YW8rKy9qMlB1ODZKdHRqdVYwRU85djNyYjlQaCtVc2FzTFd4R1BLZitpTG5a?=
 =?utf-8?B?UGJSNFZSUStDcFMwWkF4bk1qUDA4SFg0c1d5VVJrSVhOMGlSSHZaWlVadTYr?=
 =?utf-8?B?RnNrb0tyZUxaTDFFWjlkWEdRK3Y2dzliYit6dXJEQ0E4UXpXbHN0S2pQS1Zu?=
 =?utf-8?B?dnJ5ZlVhTmtJbzFXRjRrK1ZOS3JSbTZWN3ZtK0tVTTM4OElMZDVTWjYxeVV0?=
 =?utf-8?B?SjU5cmE5ODJqTG5kR0taWVpyaHUwVllHNW14aEhReWJsaGRPbWxONWorSGd4?=
 =?utf-8?B?c1dGNk1aZ1BqQU9zaHozTmJNR05jbFJWTXZjNUJDbW4zbmdBQjdoOVpzR2VR?=
 =?utf-8?B?bzFKWGxMVVYrbGpnUGpDRlJGQjlRYlpPb2FWd0R1bnQwa0lTL1VSNUZYa1pv?=
 =?utf-8?B?azBjbjY2VTM1b3M1MG11OHdYcW9DbWU2bEFKbmt1N2hSQjU1aWFNODFOdVZI?=
 =?utf-8?B?NEpEcnZ5akIvRzR5TEJ2WXFJSHBuejJUUzcyQXlKY1M0enRuK0hpcFVnTVhP?=
 =?utf-8?B?UlJZa2RJWUNwdVhOMGtMWE8ra1FLdzhpMGNOMHEvQ3BzWE1wSkxucnpSQkxI?=
 =?utf-8?B?TFFZTXVYc1AxakRSMjRIeU5oeXpQYWQvREZMZ01uTlZWUlVyL1NlYk5XUENp?=
 =?utf-8?B?c3hEOWZQRGN2MUhTbU1zYmE2eEpldUlSQ0RrV1BZOVRRQTl4NTZaTGlPZ2pK?=
 =?utf-8?B?alhlVVc0MFNhTVJkVFZRMld0aUdIbDdUM3pDTzluelptMDVnWVB3UDVmMUI5?=
 =?utf-8?B?aTZaOXpkTi8wL3NsY2g0Rzh3N0xTWVhnM3N1Z2I3aG1pc2xsL011Z1RFekRl?=
 =?utf-8?B?L09YVWVWY3E2VVd4ZmtJSEV2TjZKVDVTK1hKVjc4bU51aWZqd3J4R1JqNzhG?=
 =?utf-8?Q?DDrjz/TJbp4hLURM=3D?=
X-Exchange-RoutingPolicyChecked: RjxtV60bsgXd6QMeXT10+T22uHqjeFBQvRKPysq4HsToBs6mq8gyIa+ODjXePbi/lhTM+ggr1US/jOH7sMwcjfzEZmUhNUO2RNnqKm5u53wK4HF7ERcdMXYZCTKc28EZp/07N3zQYggAMCfbyDRTcqGI20cy729d6F4q0aKEaQytQEAjCf424sPS8+5yO7QhJZYWl8SGLjAZF7DXOTuqtbLtzdQxS0cJpTMAkRFOf5OikPUf7KKyY5CZES5qSsS52xCeIPTVo3QHMK85qJmN2Ye4NXenOsK1PspQe/IKsHy9gJLU9PkvktfSpx6vsJox3rxjRyQpY6YgXahwnsm9Qw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cceabc71-9bac-45f5-a71b-08df3b0e3732
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:27:15.3508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgnpGJTx+Co/E02ypKcJLswg+ee7YjTxBQhhT2qySOOKCmxwDlVtw56CdBmrAiqasw6mLH57vx6H0WOYLMU+1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
X-OriginatorOrg: intel.com

On 04/11/2026 13:26, Changhuang Liang wrote:
> Add a helper that derives the internal timer clock frequency (ITCF) of
> the CQE from the ITCFMUL and ITCFVAL fields of the CQHCI capabilities
> register, and export cqhci_set_cmd_idle_time() to let host drivers
> program the Send Status Command Idle Timer (CIT) in CQHCI_SSC1 using a
> value in nanoseconds.
> 
> The CIT defines how long the bus has to be idle, in internal timer clock
> cycles, before the CQE issues CMD13 to poll the Queue Status Register.
> Its reset value is controller specific and can be far from optimal, so
> host drivers may need to tune it for their platform. Doing the
> conversion in the core avoids every host driver re-implementing the
> ITCFMUL/ITCFVAL decoding.

Should probably have asked this before, but why calculate it at
runtime?  If you know the hardware, then you already know what
the value is going to be?

> 
> The requested time is rounded up to whole clock cycles so that the
> programmed idle time is never shorter than requested. The helper returns
> -EOPNOTSUPP when the controller does not report a usable ITCF and
> -ERANGE when the result does not fit the 16-bit CIT field, so callers
> can report the failure instead of silently running with the reset
> default.
> 
> Record the cit value in cqhci_set_cmd_idle_time(), and if cit is non-zero,
> program it into the register on every call to __cqhci_enable().
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/mmc/host/cqhci-core.c | 64 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h      |  8 +++++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index a466cd88b043..bfa5d8b79145 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -12,6 +12,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/platform_device.h>
>  #include <linux/ktime.h>
> +#include <linux/units.h>
>  
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/host.h>
> @@ -279,6 +280,14 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
>  		     CQHCI_TDLBAU);
>  
> +	if (cq_host->cit) {
> +		u32 ssc1 = cqhci_readl(cq_host, CQHCI_SSC1);
> +
> +		ssc1 &= ~CQHCI_SSC1_CIT_MASK;
> +		ssc1 |= FIELD_PREP(CQHCI_SSC1_CIT_MASK, cq_host->cit);
> +		cqhci_writel(cq_host, ssc1, CQHCI_SSC1);
> +	}
> +
>  	cqhci_writel(cq_host, cq_host->rca, CQHCI_SSC2);
>  
>  	cqhci_set_irqs(cq_host, 0);
> @@ -1163,6 +1172,59 @@ struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL(cqhci_pltfm_init);
>  
> +static u64 cqhci_itcfmul_to_hz(u32 itcfmul)
> +{
> +	/* CQHCI_CAP.ITCFMUL: 0 = 1 kHz, 1 = 10 kHz, ..., 4 = 10 MHz, others reserved */
> +	if (itcfmul > 4)
> +		return 0;
> +
> +	return HZ_PER_KHZ * int_pow(10, itcfmul);
> +}
> +
> +static void cqhci_itcf_init(struct cqhci_host *cq_host)
> +{
> +	u32 cap = cqhci_readl(cq_host, CQHCI_CAP);
> +	u64 itcf;
> +
> +	itcf = cqhci_itcfmul_to_hz(CQHCI_ITCFMUL(cap)) * CQHCI_ITCFVAL(cap);
> +	if (!itcf || itcf > U32_MAX) {
> +		pr_debug("%s: cqhci: internal timer clock frequency not available (CAP 0x%08x)\n",
> +			 mmc_hostname(cq_host->mmc), cap);
> +		return;
> +	}
> +
> +	cq_host->itcf_hz = itcf;
> +}
> +
> +/**
> + * cqhci_set_cmd_idle_time - program the Send Status Command Idle Timer (CIT)
> + * @cq_host: CQHCI host
> + * @ns: idle time in nanoseconds
> + *
> + * Set the number of internal timer clock cycles the CQE waits on an idle bus
> + * before issuing CMD13 to poll the Queue Status Register. The cycle count is
> + * rounded up so that the resulting idle time is never shorter than @ns.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the controller does not report its
> + * internal timer clock frequency, or -ERANGE if @ns does not fit the CIT field.
> + */
> +int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns)
> +{
> +	u64 cit;
> +
> +	if (!cq_host->itcf_hz)
> +		return -EOPNOTSUPP;
> +
> +	cit = DIV_ROUND_UP_ULL((u64)cq_host->itcf_hz * ns, NSEC_PER_SEC);
> +	if (!cit || cit > FIELD_MAX(CQHCI_SSC1_CIT_MASK))
> +		return -ERANGE;
> +
> +	cq_host->cit = cit;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cqhci_set_cmd_idle_time);
> +
>  static unsigned int cqhci_ver_major(struct cqhci_host *cq_host)
>  {
>  	return CQHCI_VER_MAJOR(cqhci_readl(cq_host, CQHCI_VER));
> @@ -1207,6 +1269,8 @@ int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
>  		goto out_err;
>  	}
>  
> +	cqhci_itcf_init(cq_host);
> +
>  	spin_lock_init(&cq_host->lock);
>  
>  	init_completion(&cq_host->halt_comp);
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index 8fbbc48c3f85..e6840a8f4798 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -26,6 +26,8 @@
>  #define CQHCI_CAP_CS			0x10000000 /* Crypto Support */
>  #define CQHCI_CAP_ITCFMUL		GENMASK(15, 12)
>  #define CQHCI_ITCFMUL(x)		FIELD_GET(CQHCI_CAP_ITCFMUL, (x))
> +#define CQHCI_CAP_ITCFVAL		GENMASK(9, 0)
> +#define CQHCI_ITCFVAL(x)		FIELD_GET(CQHCI_CAP_ITCFVAL, (x))
>  
>  /* configuration */
>  #define CQHCI_CFG			0x08
> @@ -234,6 +236,11 @@ struct cqhci_host {
>  	int num_slots;
>  	int qcnt;
>  
> +	/* Internal Timer Clock Frequency (Hz), 0 if not reported by CQHCI_CAP */
> +	u32 itcf_hz;
> +	/* Send Status Command Idle Timer in ITCF cycles, 0 keeps the default */
> +	u16 cit;
> +
>  	u32 dcmd_slot;
>  	u32 caps;
>  #define CQHCI_TASK_DESC_SZ_128		0x1
> @@ -318,6 +325,7 @@ struct platform_device;
>  irqreturn_t cqhci_irq(struct mmc_host *mmc, int cmd_error, int data_error);
>  int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool dma64);
>  struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev);
> +int cqhci_set_cmd_idle_time(struct cqhci_host *cq_host, u32 ns);
>  int cqhci_deactivate(struct mmc_host *mmc);
>  void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end, bool dma64);
>  static inline int cqhci_suspend(struct mmc_host *mmc)

