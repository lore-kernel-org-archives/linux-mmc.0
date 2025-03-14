Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67092E3363;
	Fri, 14 Mar 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931799; cv=fail; b=cgq1ur3CWIb7mdRFN2jSCzepEHd0cVZrj9vIidloDNJcES3ANQv58iTQ/urcWsBg6EcgA72Aqa/yUF1hsVYFb+Ni6VhiWIQ0MVnrLjJ7eQ+a1USOM3JHXGqzkhGIfMe0WaUkj5yG+Wrzva5O6xIWRrPNHqtsFZ7oPl7xVqVXyT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931799; c=relaxed/simple;
	bh=BTusyODk8bjkF2CUa5Vll95hkN6Ivd5k+QKZ4zS85Fg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSFuz9z+y8pEXNj2BEnAv3jU7HTQmVeyeImtI5FkuYZFjqJ8OfjHRjE7E09XOXRT8Px6YvPQHa0PxRBuRy0s8FTlAHNiZaza51ofZbxyHAIVMF23GPAMOxgWr+SU7Kx65z8k2RgrfGjlvqiR2irSr1EK6GAb10m1dSWC9kW725E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuNQbg/0; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuNQbg/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741931797; x=1773467797;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BTusyODk8bjkF2CUa5Vll95hkN6Ivd5k+QKZ4zS85Fg=;
  b=IuNQbg/0nZ2Lgx3Ajo5s6vf5ARZqfWrxNy4dKSU3tbkvA631UWJLFL0+
   Rk51IrCB0huOcUmdkdewB8TUUpMJGfRyC49XyLOdmvEe42Q9DfpQEGZmw
   Q8x8z0MnjlFIfxx494tvpC4VwIZm9e80wt89+g5Bi+htUUeMzwbtFcCVX
   uJe/QAG699IT2s2KJL5tgHkLNlTxQgnxMT/OrAXJUEcH1eeMoeBdp2tN6
   BZ/XwBd+YzdTa57kZubc9nSiKNc1+JRl0TreJs8n+slmTRe/UvW1Pi33D
   NtR1EL2/BKJ/OZchUGCpxN8cF0BlO3+Z6GttIqJThA9MQqwO1EmV1VXvN
   Q==;
X-CSE-ConnectionGUID: 2YCEcRrLQIyD6i5ImcWx4Q==
X-CSE-MsgGUID: wsI8qPR7TLCfp0W/4QS4wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42240267"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="42240267"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 22:56:36 -0700
X-CSE-ConnectionGUID: EEM9iYhFRSmcn9RiXfUc0Q==
X-CSE-MsgGUID: QnGmgXKZSKW9MyZxFs3QeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="122094638"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 22:56:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 22:56:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 22:56:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 22:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3BCjop87KcG1OxA7qr9vKMguUE/ul4EQ4fLURSdPd8orq9N47iyLgZfFJrD39387bM/r+HQ7VW41ZegUQk5x91QUH5WUQUsYkrvp0AKFYR8C/jvfcmp5GqhH8xB+c9pCfS/4FFjUD+l9SUnAcIbaA3VEVD3kn7CG8lIKEAEb+UfUOkkirsq9zI/zKCSTU55rtIke1l/fNF5RC5rKbvbpXxHN2ZTnt5yOw2gs08i/qWWeynaoKr6dlxvTAioYrTlTPE8OSF7Tp99aCywq5jz2AXmQd4Kb4tMDdZHugHCLqTcCN/03FHhzQGX+5T/kW0GsnwsOj2DmLTN3tAAlGpfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KxBpLJMLUJH5U5LpLWcT4jeVdYheyLxxHEH6mJ2OTs=;
 b=Y2UuzpE/DToAyn4AoxIaZX8J+u82KXxG9KhyvZEjF5gloIWuEYmI01fF9Ah/nk2TQs8pT2fVyemXQBvp9+IDaQ2zwmS3eAYb50n3pfLLrysR7r1fj/jQttr6sFwy9r1g3eUZE6v4s0fEyzf8bByiB7AgUoAIyvASWyd+JS7FGOwzU/9f3L+m7Wk1HGiYLKaBLk7Y0RJRuemxKZh+vSO2uKOZ88Kks17gCCmOtcOvUFPgqqhkdlqxWiviXei99NNhvIvQYwm/nNfgiyKznGzrYbUtiuKR50+ezFC3PYd9o6rOqGAlENcBJUQtlMOWAkFAu4rggv4qTg1vN/kgV+GgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DS0PR11MB7972.namprd11.prod.outlook.com (2603:10b6:8:124::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 05:56:29 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 05:56:26 +0000
Message-ID: <5f17df10-2622-4062-b2ae-f6f94ac22ac8@intel.com>
Date: Fri, 14 Mar 2025 07:56:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Wait for Vdd to settle on card power off
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <brad.mouring@ni.com>, <gratian.crisan@emerson.com>,
	<kyle.roeschley@ni.com>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
References: <802daedb-d82c-4d0b-8e69-d166c169cbb1@intel.com>
 <20250313204439.1582652-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250313204439.1582652-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DS0PR11MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e68802-4d06-4ac7-30e9-08dd62bcf517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHpIY1FZckpLTFFrTDNoSUdWUUZwcElmeUQvU3lWWW55c2RUa0hYZGltSk5S?=
 =?utf-8?B?SnA5Y2VBVUxZRmlLcUQ0RDM4cC9oZkRpbndPZ2RxSE0rU1R0NEFJekJWTUdD?=
 =?utf-8?B?a2FDTjQ0RCtuNTU2TDJuN0xJTVpSaVNSWUo3ditEZGgwS3lvWHozT0Qwa01k?=
 =?utf-8?B?ZnVxMjdSVVljam5RV2lFS0IwOHlHWHZiZFZVa1lQRHora25RUmlRKzhQZTl0?=
 =?utf-8?B?WDBDeVFZTkxYTklCWUFXYk5ZVWV4dWxmaDBuMVVTeWtXSmh0aVNkYjRqUzZC?=
 =?utf-8?B?MnZwalBzdkQrU1Z2ZDIwMElqYzB5ZHU2N0Q1NHI2L2hObEFOL3EwL1ZvbGNs?=
 =?utf-8?B?U2pZakNMTFBOMkFTNUo4dnNqblpjcmpIemNCVEhTQUVtd0FUaTVGZTNDVVdQ?=
 =?utf-8?B?M2d5bTBybFdwalhkMmRRN0UzcWpEWGJYT1EvYSt2ckxSTmR2dW9LL21SS2hQ?=
 =?utf-8?B?aUw4VlNKU1ptQ3dLZlJUV0d6c3hlV3B0SGgwSEE0aFh6aEdMWXF4bmJHZlg0?=
 =?utf-8?B?VURtem9Lak0vMUpDUzc4c2V5Y05IT0FkV1I0ZUxtSXBCQk1EbThSaDlWeEtn?=
 =?utf-8?B?M1U3bmNkUld6TTFFZGRYZ2FCblBoUjYrd1NweVFBdWkrNCsxWVAwanhTVDhZ?=
 =?utf-8?B?RGg2cUltaGFXRXpKT01uUXpmWHJRVGFISVhuV3Vad0E4eWUxY3VTQ3F0RXRL?=
 =?utf-8?B?UVNDZnNQSjU2eW5tbDNmdGNSSkxLVXZSVDErZWd4cmo4UEE5bXcxNGRVUGdQ?=
 =?utf-8?B?Yko0VS96K3IwTzArazRwb2dHTnBoZkp4YzN0TitURmJGWGg1ajN1M0ZJWlI4?=
 =?utf-8?B?c3U5aTV5NTRNbm9McXBmdzF1SVg4WFhXMjNNU1JQSmMwYzhnRnNLQVZaTCtp?=
 =?utf-8?B?MVd1ZGdjalgxR29Yc1grUW9mRUpQd0ZrSTV0Q0xZKzdWYzM2bGVobW00clFB?=
 =?utf-8?B?Z1gxY3JrdGhMSDR3ZWpjVzJFVGNWMDAxUGpMRWgvQTFWcmsrV1NIRXZPY2Y4?=
 =?utf-8?B?L1BnWG9JM1Y1ekwxUUJicExleGZ1c3pRdlR4SmJUOG1ia0EwN3FwZmcyOWVV?=
 =?utf-8?B?UWJzT1IwRC9KQ0NSaS8weU5vYmJGaXFscEk4SklST1lCaFhtaFhsMEhZMjE1?=
 =?utf-8?B?WitVU3AvcU9FVUpWeEcyYWsreWJ6R2xRbFI2R3QwQTcxMVNJUkk5bEp2K0hh?=
 =?utf-8?B?dzV2STdkaytFYzFOYUNVZi9XVzR4aWhlWWhSSEZhZzQrMjZXTVhJdUd4S2Za?=
 =?utf-8?B?QmxldnFoYUNYaUFXSmZHaU9uM0lOTHBKbzkvTWRWQW5teHBXdTBDQVhXcS9G?=
 =?utf-8?B?RTc5MTFLcjFpU1VDVGViVXRRanNyZTlyRGowbHhXQ3VycTgrUGNQVENDTFlV?=
 =?utf-8?B?RmUwb3ZyRkNESUJhclY2TENKclJuTThGRUV5SGRtc3diVDNIcVZzb09xZVN6?=
 =?utf-8?B?Q051UXlEcFgwZlRXVjM2STVOQlRKZlp0MDU4VHhjVlRLbzZCYVVHZDZwVi9B?=
 =?utf-8?B?NHBUYnZGK3dwMjFYVmVFTUJqaXpzTXFtN3BsSnR2UExoVzVlRDJRMElKYjd5?=
 =?utf-8?B?TEk2cVRVbzJsQ0laN09VemdkR25TQmtOTDMvd3RSanVjbS9mbHR6aFFEbWlx?=
 =?utf-8?B?MGZMTkgxMzdCK21Rc3FSVnJNU2RNUVh4SWNVV0dQZ2xqRzRscURab3V6bnIy?=
 =?utf-8?B?MjErL0lVeU1Va0VjZzE4MVFNbnZINkhxa2RnR21pVE9SVFdwSXdvZm1hYllO?=
 =?utf-8?B?cmdBelpZNHVqL3l3Y0VzUXlYS2xCRzY5bzV0L3ZVRTc1dFlqOXNHK1A1TVAz?=
 =?utf-8?B?Rzlkb0FnYmZFcGFlV1JMSk8zN0Yvdlh0NllsbTFaRng0MEdUeVUrRHdLT1FI?=
 =?utf-8?Q?mHJr/dIZnnALF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1drSUd6L3lhMkJHQTBlVTQ1dndpdU9PdS9IQXQzY1FZbFVDb21TdUgxNlA2?=
 =?utf-8?B?b09oVHBWSDJqUkRrQ3Fnek9MQTJ3RFFIV1p0TXYzaGlDdjdPaU11d2RkVUFR?=
 =?utf-8?B?UEdmeDladW1ucklZakhwc211dmRPWmdZS3haRkRjWXFqRDlTN1d2UDUvNzIr?=
 =?utf-8?B?TjRXam5ReW1xMTJXdzdoZWRSUFJGb01VM1laZmgzbmJ4WFBiN05TdjNIK2V6?=
 =?utf-8?B?U2llMnJ5RFQvRUdrODFid2g3Z0dkQVBsNE5Zcm8vWWFESWxpU2d5M1JlZUl2?=
 =?utf-8?B?TUxnYVdzUmYxcE9SV01PMTFnVnAwYk9neEZSd1VqOWhoNjhPYWdtRFBFOTBn?=
 =?utf-8?B?R3g1NGwyTGRGekw0T3d6MWphN1V3VjN2UXdzYUozSFNmV0lsenNjMkRodDFx?=
 =?utf-8?B?dHhkNFhaMjFoUzZDT2MwL1lid1F2Qno4aytBZ2RKN25iamZmdmdadE1seGVv?=
 =?utf-8?B?UUpyZW9pMmJKUUNIUXhGemNpdk9EcU5TRzV4K09JcWpqTlB6MU1NeVZQUHlL?=
 =?utf-8?B?WjRCaUpsZTdFUll2U09IRzllcGgzQm5oQWI0RWxoNmd1anNPdG9oVjdJTjJY?=
 =?utf-8?B?Q2JxS1NwNDM5WW03RUZRRzRURmdFU293aml4MHN5RGVMNFNtQUtucHdUN1p2?=
 =?utf-8?B?ZWtyem9lSlR5WE5WWU1zNUMxMnFNNFd2cFdidXVyTkNMZGdob0UrUUM1c0Zy?=
 =?utf-8?B?Q2hjUmRuUzdGTzR0cGpWT1p2SEFGOXRNZVdaMXljNnZrcDArN3o1TTFsN2ww?=
 =?utf-8?B?L0VZSjJlZG94dk9zR2E4a0JwaytsMWFqc0hHSkplcVRvRXJCbnp2VEw4U1gv?=
 =?utf-8?B?dFpKV0RHRENhcEUxSTYrb3BYSGk0MVdBTUh3UEZEa3lKVUZjOUJ4ZERtbjI0?=
 =?utf-8?B?S2ZhRktWV0htL1JCbStUVkFjUkdFT0d6NTJMVVU4eGd2M012SjhWdTVGTDZQ?=
 =?utf-8?B?RWVra0daaGh6cU9JSHRiZmxnOWh1UWlSYlJ1RlExQ1hqdW5yNGl2SnZJVmlT?=
 =?utf-8?B?YW9pQ3E5SU50U2lnaExOdDJWWWIraUZNZkQ4UkJQVjhMN2F4MXdKcnhHY01n?=
 =?utf-8?B?N1pUcU1wcitRVFNPRzNWZ3ByL2lOeFFZK1JrMlYwUGFua04rSzVZTGpLbVlR?=
 =?utf-8?B?LzJpQ1JiamY1VVREUi9kSUczVnJIaitXS0hRSFd2R25pM2dieWVJMnUrQUlv?=
 =?utf-8?B?aTFQSTNmVFh1c2tXVG5CazdWdXVrUmZMRlBsem1odDdSdXY5Qk9LbFVzUUxq?=
 =?utf-8?B?NUNZK0xwYmtPRStqV0VJQytWTk5iYzl4MGFIbVZTd2VPQmtScndyUDdubDAx?=
 =?utf-8?B?WEZQRUJwc2dQdlFadVRIUVJYaC8rdTloYlhITWNEcFg0SUx2eTJUUWZxcEV5?=
 =?utf-8?B?UWFRS1JYS0hxZVhjdkIyTHlrcnNXd3NsTkFndHBOTm9xT3l1N1cvbGlyUzFE?=
 =?utf-8?B?ZWFyUHhxTnh4eW85akhralE4UUM2N2tWL3hBREYrdnM5NExRQlA4Mm5adytw?=
 =?utf-8?B?eVRDODl6OS9aT3J3WVFPUENBWmt4Kzg0L3kxdjdMVWx6S1pRbkFURjlPYkh0?=
 =?utf-8?B?VW5wNmp0SVJyVlRQd0ZXSUp4ZE85N3V3Ykg2aW82RUMyV2MxVHdyZVRGQWUr?=
 =?utf-8?B?djBSaFVKVEtwTUJWdTBNSDNFajhEUFY4VmV2dEhRZVJ6UVFWeGU1N0dXZGRy?=
 =?utf-8?B?ZnZ3T0dkYTc0RDN4dFRScUh4VktiNEs1bnR2dXo5MTNQdXBkM2h5VVhNWWNm?=
 =?utf-8?B?VUVUbjdSQmljQTNRNlVLZXVsNmRCakFGQStqbUNIemVLNENrMEE4TzJDZStD?=
 =?utf-8?B?ZVpWbXhJcjlVN3doMU5LSDFPQndBZXF2NDBFNTcxY20wSEp1MUdUVnFJbnJM?=
 =?utf-8?B?ZW9LRUlVVlhkQTNIc1E3anJZY3lvNkpWbUNObER5SWt3NTJPRGd1YUdDQVkw?=
 =?utf-8?B?Ym5HZTZXSG9QVEZnaFRkcyszQ3B6bUJPOXdJdS9OOWt6UkZpVnBXRnRXYTB4?=
 =?utf-8?B?NEtiVlJtbVhpeC8wYTErRCtNMXpoNlZDK01kZVZibzZFWC9KektwMDA2d3Qz?=
 =?utf-8?B?NVpZbFJybVlCcjZQV3VWZXF0VElUaDRES2pmSS9BY3RwcnBFVloxZGFpRUEw?=
 =?utf-8?B?cGlBdTlQcDAxSkZ2Vk12QUpxdzBQK25XZEpJTm5XNGNtbTZUclBtL05la21H?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e68802-4d06-4ac7-30e9-08dd62bcf517
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 05:56:26.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWYonSyaJQh+YLNEvmOmQRjx4ZV9CL4XVkmbR+ZZmA5+qAhBJLKGEsyOchRXljEXQiuj4ANksHYQWr5GutJBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7972
X-OriginatorOrg: intel.com

On 13/03/25 22:44, Erick Shepherd wrote:
>> sdhci is used by a number of drivers (drivers/mmc/host/sdhci*)
>> that typically use the regulator framework to meet voltage
>> requirements. So that is not the right place to make changes.
> 
>> It would be best to put the affected PCI device IDs into
>> sdhci_intel_set_power() as I showed.
> 
> I see, that makes sense. The majority of our devices are using either
> Apollo Lake or Bay Trail host controllers. Would it be ok to expand
> your solution to include both? I tested the following change on a few
> of our devices and confirmed the delay is called. If this looks good I
> can submit a V2 of this patch.
> 
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -610,9 +610,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>  
>  	sdhci_set_power(host, mode, vdd);
>  
> -	if (mode == MMC_POWER_OFF)
> +	if (mode == MMC_POWER_OFF) {
> +		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
> +		    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
> +			usleep_range(15000, 17500);
>  		return;
> -
> +	}
>  	/*
>  	 * Bus power might not enable after D3 -> D0 transition due to the
>  	 * present state not yet having propagated. Retry for up to 2ms.

That would be fine
