Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F054CF78;
	Wed, 23 Sep 2026 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190474; cv=fail; b=syOv+XIPV2PDuipKoEFEWJJ7icQk7aLplSLJgWyuawbA+iEHfx2e0peoYvEeTYyiMN0e13k9c4GRf9wXZe+2g3yBKl7xP5pOdWJZACNTMQzjB2a1+KDac2LvSHtK5WdEtmZurqRWwY4ZeMFJSUcIl3x3uW3C+JBOSlFna8QwEjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190474; c=relaxed/simple;
	bh=Ss9KG7pcdVFtnIJcI/j5loTrkK/06RDg5jxD/MyIlDE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j70L5tXGecEz/P4T1UUPcTarP/0feg+5lRRGhxSIr8w2GwH7Cjx09qIq4pOD/PGNI0q51gUOmknN7kMO03k1g3D9uDqRHBN+hKUvpYNrHEJzye/Fmxkx12zglDYa/zVRiDIuf5umi5owAZ50GyQUUnz34bfU68tvez63ZreIvvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Am6eyRXQ; arc=fail smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Am6eyRXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790190472; x=1821726472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ss9KG7pcdVFtnIJcI/j5loTrkK/06RDg5jxD/MyIlDE=;
  b=Am6eyRXQCVOAhidKx/HjNnAfvp2CuHEfbSFBL/X7m/EajUnfE2y8eQjd
   Q/qLIcEKNlun4zNbyBsLqJpNS1qpkhcCoXoZGyJyoQh7TTNuKf1McWuTR
   g7u7diF03lVZm841f2vJgoNaNU3sYzWlQ49sT9MwDR9izijzGx6bbiaLz
   x6MAz+JiZN952H2vODOOMy1NBbHFVgMSAmJsC5/xs/kmgjTvkR/bfVm8E
   DEtYMYaWXMRTkiQgHt0Q3iFR28IVqdy9rqiNr81E0wko25ratCdwicky2
   GZ4xrqwtqd5yTdExnJiW7UNnNQZLcwoEy2H6PP2xyJLA93hwEl0Er9LmM
   A==;
X-CSE-ConnectionGUID: SSOuXU7dRT+/5P6xkDM4zg==
X-CSE-MsgGUID: PSxtETQjQnGkk2oqXqkheA==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1435656"
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="1435656"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 12:07:51 -0700
X-CSE-ConnectionGUID: qoXu5qEsTMeOLaiu+t5M4A==
X-CSE-MsgGUID: uJdFcZF4QJe8C/FJqTkkzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,119,1787036400"; 
   d="scan'208";a="300010958"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 12:07:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 12:07:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 12:07:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 12:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6C3AKi16YLf420qQU+xScB5TcbwR6c3vnSUnqid9oOVMvyrjXo4i3reCcLBv0f6pFP/r9C/8qxtEzUSNv/6EA2D7n4TKpT2/K30luyUOPppRwaXu1mqrRtrMmMRi16VT1c2XGkHTvQrpKxHKbgXk/tRVIIMUn/Z35dDlgEN00aVGyizmvMVsxV/6H4C2ocbgzCoX7m8udKkZQl8oVzL+Xb7bKkzz503+OQ8x+FZP/ky+P0I81sZGt7YU3CyML7hLL+UznzbcNP/z54YY3WuAy7Ep9ZWgC4Rq6WRV/yzmDYLWz1s55Z6fja2nW5OC1S1OEi4rG54Zal1MlirhbnvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STDSHAR9qNhlFVd8fo/lvp5HXFoPMCOkO6w4qu2OcIQ=;
 b=KjyzrHsh+9IXT7uISjR/A40OUmsjjqxCFNOia4vFWDBmqP3Mg6NeiBk4ElZ/lcFoL7BTNQ+9PDBeeE4dPxK/HoLOlkT4qOoPwengZjVIxaM5gcB/9lnX1DGgF8ZSwI/O3zS6fkE6JzRp0i8R39/7LWpyGsFyTgB0PBkdN4rIofvyUGckTY9kzct3dpnkBQq7cWwlD39KJt2Zj9RDlpUHYhcFlX9PsU6RyQUxr6wkSSdjItWYNbP4Qv39cCmzfNnoG9Fj33p3T/Z8usJAFR0feBLyZ+fCf098TIGybjlW9RVRc8XYDi7zPhZCnY7H+Sp4BW06/ADHz7xNFzIJC6FcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PR11MB217768.namprd11.prod.outlook.com (2603:10b6:8:50e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 19:07:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 19:07:45 +0000
Message-ID: <e01a17f2-f736-4b12-9336-bb862dafda59@intel.com>
Date: Wed, 23 Sep 2026 22:07:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Add support for StarFive
 JHB100
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Inochi Amaoto
	<inochiama@gmail.com>, Chen Wang <chen.wang@linux.dev>, Jisheng Zhang
	<jszhang@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <sophgo@lists.linux.dev>, Philipp Zabel
	<p.zabel@pengutronix.de>
References: <20260919092950.178617-1-changhuang.liang@starfivetech.com>
 <20260919092950.178617-3-changhuang.liang@starfivetech.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260919092950.178617-3-changhuang.liang@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PR11MB217768:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d1c19b-2c25-4c1f-2631-08df19a5f310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|5023799004|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WY2qj3axRpfyjQs3+FmpFldyUe3/J+LcIZQ0AgA6EQ5P7nj3V/RwbqwwZW1RrxgzT/r2sSL65TPSCKF/rfTWuKnfySzKvedbYM8D0JxUPGY4prJ/JJnrayB91l5SqKpFRrBJQ1iXA268sAvEhU3W39PqXwblZrirGwuAiRsojWjd3rjOhDs/oS+tnNA4B4bvfURzJHVRH54W+GIdbHN5doMIsMvYXlaqbqZUOuH09256PkP42hZY2/cHifgTvscastU4LNMQMjNikGKO8cwsyePc/g6hXSLYf9Gws7H0+LgQCucFSNTk0g5wHwg9JiaMM9knMFptCWkac4xWpaAvGdrEATCzP6SrrllYFCM9NZyCdlotOqoyRg3K7eQJddFsKM9Fff3Mu9OKN1oVTLJS4hfOMgWf2XxNtRSEra0ReEPDRdQ6Q82d4yqE1F9y0hzo2EVMzjm3pZVuQwz5GiGN6GOU7QZGsA5CGdmHRCFxIhz5Bl5l8Qz6FjG5K9VqL7wIxRmEpET6brC7mOzEezkEaoUUr0hIUVlFd3OnImpEYWwyaiUuk2YFOy5q9Q/VWhtUF8xuuUETZYncMdR7W4R6BsAh+o2fmmlCUv0WJkWqDlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXdxSDE3Mnl4M2tzSGcvcGo3RFRzVFVweHErK2U4VXVYRlB3dEx4RVo2Yzl1?=
 =?utf-8?B?eHFqb3VyR1hKSTB0alZLb0tjVTZ1aGVGcFpyUGg1UWRlS2NsQk82ZUZCbUVH?=
 =?utf-8?B?QXdqL0VNUjhBWU5nYzhhSC91eWtPVmg1TWJQc051WHhsQjJZVDcxbUhvWUlG?=
 =?utf-8?B?SkpoNFJmQnJUUkpIZmY2djBaaWFXSVc1WEpjTmZSMmxPUDZRaERKU0x2ZGRi?=
 =?utf-8?B?RmhiakJkQU1vdUZXSVh4VVlHUnhLeXI2d3drcXA0UGxVMjMrelkrVnpjcGdU?=
 =?utf-8?B?TWtHdDdNWVZOL3JZV1I0WjlyWkJvZWJ0NEg3YU5EQklDWkdHcnBudE5NTm50?=
 =?utf-8?B?Zi9zM0pvVXVDK3d5cFI2dXJYdFEzUFZWL28zNTdMNnpuUzMybDdYMXVjVXRO?=
 =?utf-8?B?MWhjSjhEVlNjQXdxTlhRTGZMRSthWnozWkdDUWtLa0habllhRWNUOVJWeW5i?=
 =?utf-8?B?OWYxZjFYRmJYdVZtYlMrV09idVgzclhScnVVVCtDNWVmYTNxbktVeW03V3Ur?=
 =?utf-8?B?TkM3ODBRU3B0aU9ZOWFVR3VtT090MVcwSTBHVjdKOUNhcGR1VGFTRS9KTVFw?=
 =?utf-8?B?WjdqY3B3ZW1OLzZ4d0JCNHRSR3FEL01Iay9wN05HK0ZEU0FyaEtkdHh4cktM?=
 =?utf-8?B?YUZwWjE2SHZmRkVjbWhRWVZsQ1dTUEN6ZVBnWTgzY2VLS1VSN0w1WTBudks2?=
 =?utf-8?B?VHdOWlM3aHVSL3pPTmdBOEUvNlV2MEtub3NVN28ybFNWdTIyN21GQkxDMklX?=
 =?utf-8?B?QjRXMTc1Uy9sWGZSSHlDN1IzNlhLWDEyM1BPT2tYYmhBdjZ6NFNCZSs2YSt4?=
 =?utf-8?B?cXEvRzFSK2FCRWpDNEEyMGdKdlNDOTBNRjBKUkF3a3NmL1IrSkU3b0dMS2Jr?=
 =?utf-8?B?RFErTnZYODlrRnhIQjFqMzdCZ1NEMTNZSTIyTFZKaElIdUQ3R3FQWFE3SXdz?=
 =?utf-8?B?Z2ZqMS9Ua3V1N2hRWGw1N3dKZTVKc1VDTjlpSTRUelloaUdWSnh2eFBvVnNy?=
 =?utf-8?B?MDBHUW9TUFpBakJDMkN4QU50dHpNZk90SWUwTWdidk9STGhYSzhQTHlsdit2?=
 =?utf-8?B?SUYrZDlNdDk1U1NtYnlmYmdSbmlkajRKMHJ6ZFdMTDEwZWdDQnoxOUozRjR6?=
 =?utf-8?B?SFozeFNwWGIwRFUyV3lRT3ZXakJ3Q0ZSakVNR1JEUDExWWQvT1hkdzJXcVVC?=
 =?utf-8?B?UmRydHBlakpzTkY0Y2tMcHZXWTNpZ3dwUmxsZW4vN2hDb25QVG5tU1JFZ25Y?=
 =?utf-8?B?RDN6NitvUjJCN3hDaVp3b3pYOEU5bGZsblR3NmZvRkxsV01PWkFrZ2JZSXo3?=
 =?utf-8?B?Z3Z5SDV1dWxSalRaQ0ZtM280bDdXUFlsekJtd2ZDakpmYTVDTjFiRGVFOVFq?=
 =?utf-8?B?MGJVMGdtNVE4QzlZNDNrWExYREc4WEYvNjVOUVRxQ1I2cGJsQkxiYklIWW41?=
 =?utf-8?B?bmJNR3J0VjRrM2lXTm85U3o4a2thSHB6eGtlNnJNZ0RVZEVkMEZOU0J4ZVNR?=
 =?utf-8?B?R05lZnRuQlk3V0NSbVhRNTZ6RkNwSXl4blJ1aTNhWTBFQyt1ZGltS2JnMGpQ?=
 =?utf-8?B?bzhsS0lZRnQrekpzOGMrQzVPVURWVjByYVBEQ3dYWHBsUnRZcVBUTlRhc2Fq?=
 =?utf-8?B?TnJ3ZmNjRml3cW9WeE5scmIrT1M0R0VPVnhOT3FISzc3N3JPUXpuMVhtUnRy?=
 =?utf-8?B?Snhxc0F4WE5DaHVQamlxMzVwTUg1S1g1cHFCRkUyRTc3UVBMVURweXh1YThW?=
 =?utf-8?B?VEJpSEdKMFlSeHJLeVMrV0xsbEZZSzEvWEZYZmxrNHppRTZYS1JVTmxYcldw?=
 =?utf-8?B?N1FoVjNGMEJ0WnBKTTBnZDlXZm1YVmdCWVFhQTlVYVlXaDY1YkdYbHdNbWF3?=
 =?utf-8?B?eGVtQ29lb0E2dVpNNjB4M1lWMnBGakx0NFNDdWQ4UHh1WGZuaWRVb1R0Nm41?=
 =?utf-8?B?dDlRT0lHMnk1ZW45U2JyK1pyem1mTFA5OFBUdzYvREdkTVpMbU1KbkF5M3B2?=
 =?utf-8?B?K1Q4d0cyQXFKQzk3cENyKzNsM2NMRFhqRXpUNm5CS1FkMGprMFpaT3ptOHpM?=
 =?utf-8?B?bzNJTFdlRGVzbWZ4OWVuMkk0TC9VNjF5OFptZm8yTlltOXBKVkZGS3REU3dS?=
 =?utf-8?B?UXZLa1o2WU1rWGtmTjFmZ1dJaFpJdzFGOUE3bWVmQjFsV0lwcUE5S053T1Fl?=
 =?utf-8?B?KzFzRVN6bDFob3FEWlgwQ0MrbkhLM2s0d2hTWjJMN2hBZ3NZMzRRQUFYT21Z?=
 =?utf-8?B?cmc4bzdpdHNrUXR3a1BGQUF6TUtNcVBuTXZjQ2RCMmpDRlJwOE1EdEJSUDl1?=
 =?utf-8?B?RDJXeG82Sk9oNXorRzh2b3N3UEgvcHBKZm1xc2w3NEtiUERVa1pSYXlJVHo2?=
 =?utf-8?Q?IQfmzW9fJF3V79Y4=3D?=
X-Exchange-RoutingPolicyChecked: UXapun5lEEiOUk7QYUy8jXcdLGpsByrhnyrd30U9yVlgouln/V02Fv66AzY+aGsVORGJC2QL2sEllJv8VaZEjbDNnV2zXRkW4SDKNLQMSJeNElcsB6ykqbQe+kio524rPYF5epD+Aj474EovPiuwOekjF0Wk/SW7bgoVK/2wG+b0IOvV9OBRlZ/uRq11w20Em4/9XG+Yxi+nIC0aGJHQU7gzhosg90O+l3sX/Ikh5OgQmQ6t1Qbz02UWw3dbo7Nt5Mll/5goMW4tPzXPlDn4Yp5ePNRq7JY43T9yw7BFdS+1c13YG7GZTAm4qrQt1wS6pyoZi3SLr3rMf2P6kgvjFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d1c19b-2c25-4c1f-2631-08df19a5f310
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:07:45.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Wqd6eVL6R1l1zqYnx/b0vH44zE74ITeA3R1aBZqkrqjv+860XzqDBL6GWBlIQ1mtEkXTjfQAUSble2zuufC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR11MB217768
X-OriginatorOrg: intel.com

On 19/09/2026 12:29, Changhuang Liang wrote:
> Add support for the DWCMSHC controller found on the StarFive JHB100
> SoC.
> 
> The JHB100 CMSHC controller has only 32-bit DMA capability by default.
> The higher DMA address bits [35:32] can be configured through the
> PER1 SYSCON, extending the DMA address range up to 36 bits. Fix these
> bits to 4, which limits the DMA range to [0x40000000 - 0x4ffffffff].

0x40000000 missing a 0 ?

> 
> The cclk_tx clock must be disabled before sdhci_set_clock() to
> eliminate glitches, and re-enabled afterwards. It is enabled during
> probe and disabled in the platform deinit callback, which is invoked
> from dwcmshc_remove().
> 
> Additionally, clear the PHY_DLLDL_CNFG_R register and re-initialize
> the PHY when setting UHS signaling, and force 1.8V fixed I/O when the
> DT specifies a DDR/HS200/HS400 1.8V mode.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 158 ++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 1baa2379c9c3..021b03c17312 100644
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
> @@ -294,6 +297,11 @@ struct k230_priv  {
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
> @@ -314,6 +322,7 @@ struct dwcmshc_pltfm_data {
>  	const struct sdhci_pltfm_data pdata;
>  	const struct cqhci_host_ops *cqhci_host_ops;
>  	int (*init)(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
> +	void (*deinit)(struct dwcmshc_priv *dwc_priv);
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
> 
> @@ -2257,6 +2266,145 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
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
> +	 * The StarFive JHB100's CMSHC controller only has 32-bit DMA
> +	 * capability by default, but the higher DMA address bits [35:32]
> +	 * can be configured through SYSCON, thus supporting up to 36-bit
> +	 * DMA capability.

Doesn't really explain how a 36-bit DMA mask works if the valid range
is 0x400000000 - 0x4ffffffff

Sashiko questions whether it works:

	https://sashiko.dev/#/patchset/20260919092950.178617-1-changhuang.liang%40starfivetech.com

Perhaps also check its point about leaving cclk_tx on during suspend.

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
> +	/* the cclk_tx clock is disabled before sdhci_set_clock() to eliminate glitches */
> +	if (priv->cclk_tx_on) {
> +		clk_disable_unprepare(priv->cclk_tx);
> +		priv->cclk_tx_on = false;
> +	}
> +
> +	fsleep(15);

The delay could use a comment explaining why it is needed and
where the value comes from.

> +
> +	sdhci_set_clock(host, clock);
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
> +	.reset			= sdhci_reset,

Everywhere else seems to reset via dwcmshc_reset().
Is sdhci_reset() ok here?

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
> +	if (device_property_read_bool(mmc_dev(host->mmc), "mmc-ddr-1_8v") ||
> +	    device_property_read_bool(mmc_dev(host->mmc), "mmc-hs200-1_8v") ||
> +	    device_property_read_bool(mmc_dev(host->mmc), "mmc-hs400-1_8v"))
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	else
> +		dwc_priv->flags &= ~FLAG_IO_FIXED_1V8;
> +
> +	dwc_priv->delay_line = 0x10;

Everywhere else delay_line value is a named define.

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
> @@ -2377,6 +2525,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
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
> @@ -2503,6 +2655,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  err_rpm:
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
> +	if (pltfm_data->deinit)
> +		pltfm_data->deinit(priv);
>  err_bus_clk:
>  	clk_disable_unprepare(priv->bus_clk);
>  err_clk:
> @@ -2527,6 +2681,7 @@ static void dwcmshc_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	const struct dwcmshc_pltfm_data *pltfm_data = priv->dwcmshc_pdata;
> 
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> @@ -2534,6 +2689,9 @@ static void dwcmshc_remove(struct platform_device *pdev)
> 
>  	sdhci_remove_host(host, 0);
> 
> +	if (pltfm_data->deinit)
> +		pltfm_data->deinit(priv);
> +
>  	dwcmshc_disable_card_clk(host);
> 
>  	clk_disable_unprepare(pltfm_host->clk);
> --
> 2.25.1

