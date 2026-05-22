Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4183E17A305;
	Fri, 22 May 2026 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429712; cv=fail; b=IR+mjzOJQjYkQY7PsKHjdw3xgGEoq9+ZS/eKxx20uffQx2PUR0TLnvK/5IHPwfmboSxdcBl89VV3IQH3SoEUFPFV0fcKD0jR6F+p7A+pREOIG/aQBoq9rVwME/1KNC4oMj0+kEYYf2uVVwg/xGD3k5s3u1NP5ZaNu8HwPBmvq40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429712; c=relaxed/simple;
	bh=p5gVPeZX0qs3sumOtzuZ+F6maC6slXznnktXgJiLS/M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VVO67dL6gQHnaej1V67zeKEZD+2n+x0G3jPq6a8ym1y66JKudVdUZLggkysjDBFK6hRkxanoH5BLfJoWJ72g2viLIUZ/ACkSdxtV4TXewQYtERwUC376CHX5ykgyY/vqYeqlp6W1e2+ruIS4aJ+yfwMt3EtEC/zWH8lL96wuGnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghKXlWQZ; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghKXlWQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779429711; x=1810965711;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p5gVPeZX0qs3sumOtzuZ+F6maC6slXznnktXgJiLS/M=;
  b=ghKXlWQZ+j/nao4qUQi+choIdsycl0GyquwK2UlSamz+0uRECgJxvECr
   QjEQzFiFpPqvCXRqmtSN/NEQv/HNLyfeEfhqwA0XxSveHo3ZkePlc/999
   1tFvLpGAXni7U54eBZFyOUncFAe8QAPpNirhE+9clc8e2LUsW5P1HN7eZ
   qRcUQcxKNX5fON+wMorvIpCZSzhBxube3EaOS0eJTyYzjzC1+4MrcuCVn
   vz0qHaWgz94dWGTTyZgylPC8KbsyLYKs7ZLIGYYhGAjxQT90CElUOltw8
   hkzojUsOkWBkKIcuBHyd0E+toN9N+adMk+1I97y0yOi8gyJAYZPFFH/vH
   g==;
X-CSE-ConnectionGUID: poRK2JbdSYewYTOqxJq8fg==
X-CSE-MsgGUID: omqZZxVrS2uQ8/5zgGO0Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="67881912"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="67881912"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:01:50 -0700
X-CSE-ConnectionGUID: 1dKTWzU6TvS2rCZZ4Spyug==
X-CSE-MsgGUID: DaptuDI/QB2YaEffTk2MSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="245093613"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:01:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:01:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 23:01:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:01:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8VXAay0YnvufZzFOQ39mJ9X16ks+d6X/mI4tjUQfWveMqIqmX8fJs7Bsz165uRohcdyenJAbU+50/+PmfSqOYmVXnxa/WVbt/Ito7Iq4JO3eF1FLLVJI70NG+0k4oHrRHLK37PhkId3dpg92WJiJhmWMsgu4+VnJtJy0gFtERsRnmKsUwF2qSS7FAa05K7fN7Y+9Hfmon9B25xZ4sEmojjFAItN5HLX02AZeXNvNMKe8z0hVYqAXYaQa9h1xDLtazIcqRjcniRC7Tkq///QoimTHaSZIvzbuyAeXTC8d6gNd25D81uzo7XPjsbV+iCEhQNci6AybXUw2cFdUuaV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTIPRdwmsNKJJB6n9RCPY5pUnhJb7wCNIXG8h4/7sMw=;
 b=N/Dg2WW/v1/dOEDeP+8gSJh0QX93jEzOIVrJAERUMoUCH0eRvlubctiOj4FThuQlUb5ZpWxujvQiAXrpOMUxWIrenlCClrKk7s4LRK7gW6cD5oE0nM22V2nqenAmN85Bv/IjnFAUanSqgtoJl/vpy6QTiHKzC4C3N2eV55F+cPHITzwCabInsaeuATcHm7qqorkWDtgnuXPei25Wr8Sl1FQwvPr7CoeNkcCRUUXT9iRMNNc4SQY8ZE+P9+5pkmAt0TGT8lkkcBXRSN3vCU+R1foYwKH4lyYXGaTy0OpqSb+YAhQrUd90bijDP/VtMIBNYRWQ8UH8HNGC2z8cwQMxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by SA2PR11MB4970.namprd11.prod.outlook.com (2603:10b6:806:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:01:44 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:01:43 +0000
Message-ID: <201336a1-3b8d-45dc-b2b0-3fcac611eac1@intel.com>
Date: Fri, 22 May 2026 09:01:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mmc: sdhci-of-dwcmshc: improve delay and sleep
 handling with fsleep()
To: Artem Shimko <a.shimko.dev@gmail.com>, <andriy.shevchenko@intel.com>,
	<ulfh@kernel.org>, <p.zabel@pengutronix.de>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260521083506.356422-1-a.shimko.dev@gmail.com>
 <20260521083506.356422-2-a.shimko.dev@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260521083506.356422-2-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0291.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::9) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|SA2PR11MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba8fd49-a123-4483-425f-08deb7c798ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: Miv7yCAfzMZlzZJRkUAsK0HWHQS6IAmeZ66P3nv+r8pu69gooGNQ8IFHJXEwIDrw9Ls4i5lq8ipv+zTFFYNOowcOZ+PIErmE5d566wwAdhaYkol/IiRkpZqfG9EPRSRKUTTGrNPqR5vz21yoYnakwmHmbA4IVb0mJNtdkPTfdFmcGrHnaG8t1XbLSYyX9FJfzgmaPW6elwhYxCEM6IxEtMP2QwbrbfWQmWkgYLcaJQLuvdNkvYaM2wprVRCYfFaXaY9mhL0WVJR8P6JEtvrBws2lu0+gOrgHtzzmNEb9rEFSl2be0HGsdFy2HdUMVno0J2OltGf+6XviTHoSKX3790QD2C+8+Z08/CO3XIFWDxfC5LVvK4WmOpzTIIMxYNxjTeK5ZwvkHbL4UWmc2KSIltKoC/idyhrqC1J/xo+mjH3wz3B5+n4j7F028qgb1bUCGLVlnvcVa4CxOJHFjwcS4q5awI2kmIzfNm3Bo9lGTf58SyClzvJ3+J9wiVxlda0LB42bTAbo13F7zSW09criWnLvjhR3YueIzNnonYxEzp5IP9k5KgzVxxV8tgSveKFxaNcYb2GJFhxE008KvxIvNOhC9H922LOrcswUiUErngkBsbcKL61iSbtxCJBafswoquOs61KpwqWtEiaKAXHdl4mtr4l4YE78YVHW42I6DrtLi0Nrkoza5P+3zAWq5oTe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VSt0ZGNOcnk1aFZQcXhTaVFaQXlGS3c3T2pBSGc3Mm1GZzNiaUtiZlZZR25y?=
 =?utf-8?B?UDlONmUxanhtVmIrcHU4QlE4N2VQWmVpNkNkMjVBTEtXZkhRNEFZZng4QjR3?=
 =?utf-8?B?T0pwRFhUaVMrOUR6bkdORWJZeFBRT3QvZUlyQUtmMjJyMFlFTVVYNTNUSnVj?=
 =?utf-8?B?Nyttejd6ZXN3UWZMWmxZbU9DS1FBVGNGMFhOZkYwZDJPb3N2WWJZMjdoUXZw?=
 =?utf-8?B?U2FSVHFkS0dHeldPRDBnY0J6U0NVeDB2eS9aNG9IMUlBanZXNHREWHBIcmRt?=
 =?utf-8?B?Z0sxZHptUHZ0Nm9mdHdZSmZLVVJJeGh3V0RtcWZPMkxCaVNUekpCWXZiM1pL?=
 =?utf-8?B?dUpISmFkSndVUjAwTkN4czRaSnY1ekYrd29UNjMvV09iZEg1WVZadVBoZzNq?=
 =?utf-8?B?ZGlqdUZCd2R4RE92TmdTUlRScXdXWDgrSXNjUVdmM05hdVRWWHZlQkJGazZq?=
 =?utf-8?B?aUxvWXFFQlI5ektmbGpkMkx5aU1PbmJNZGJWanNpcC9pb09tb1dSQTdPQ1VJ?=
 =?utf-8?B?bTcraDEvZGpxWFN4d3YzWEk5UVdKeGN1K1dmcCtudUFiMk1OZHR1cktPeVdl?=
 =?utf-8?B?VklBOE1WcGRUZ1ZVSEM5b1JheDBvelE5WFVma2xEdzkrdzRWQnN4eHpaZU4x?=
 =?utf-8?B?dURTRTZteEZweVBZS25sdHB0K3NXZ1NpNExVdUZnb2c5YVhObHZKQ3BiRUVv?=
 =?utf-8?B?bHhUTEdIeGNZWk5tNkFudHp3a0J4MnFSMjlBaFRYZ01pSXdUYmJsQ0pqVXBF?=
 =?utf-8?B?RzRRSVowSjNiVXpVYWkraERuc3pFYW16SVlGc0xLdyswdVY2QnpNckpQR0g5?=
 =?utf-8?B?QXRwYUJJbjNJWDVUQUo0cWlFaDVPM3k5VUhQbUQzbGk2cUdMajVLd3B6L1JP?=
 =?utf-8?B?dDY1Wk9mMnRET2pQd0w0VkI2ZWhqQU1xT0UwVTk0eG1oakU0NFZQNDd1Y1pS?=
 =?utf-8?B?U285TVRhM2dlUW1LRFRrNUNDQTdHVmdUSHRjN2tvMFVydVY4QjhiWUhoWExR?=
 =?utf-8?B?NzJwbkpKVWszMys4QzA5aGo2a21UK3U1UXhTeHptN0diU2JPcGVFNGd1a0Uw?=
 =?utf-8?B?K3VlUU05UXVld0ZKSG5TUjhySFlVZy93STVMVTVEYml3dUordTFSYWhYRzlU?=
 =?utf-8?B?eWNmMk1QQTh2bFpDZ0E3N1Z3Q2NhN1dLWVYxTUQzcFF1M1JsTzUvbWh1TkJD?=
 =?utf-8?B?ckxWMisvQ1R3VkhvM2M5UVNoUjRxUGt6NWt3eGt3VS9GVWM0dmt3MDV4ekt3?=
 =?utf-8?B?OGF5WXc1OC9PV0o1NEVoZVFjRGcyOWRVbXVLZ1RvYkhrWEpIUjZDT1kxb3Fz?=
 =?utf-8?B?d1hKQ1R4L3Z6SEZvTTNIRTJtQ0cyNDVNeFRnem0xK0dFRzNpL3ZQSHJ2bitO?=
 =?utf-8?B?Q05QS2Zvd2hnSUZ4aGROT292ZFlBbFVBbHpkMHBoNGN0cGpaemMyWEprcHJm?=
 =?utf-8?B?T3VTeDcxSG9mOU12VFZIeXZjLzB0VHdpbUJFdEIyZS9RNU8xM3JmajMrcUZT?=
 =?utf-8?B?blZBVVM0YkhobjNpUVFiakJ6TjJjWXhFeTYxYWFtWHM0RExXUTdWK05LS3gx?=
 =?utf-8?B?cVN1UnJ5REZzWkNoSmJybnJoM1J0RFRVb1Nhczl2cE9PTjJMZjhEekNwVHVJ?=
 =?utf-8?B?d05sTjRxUDM3V0RPTjBEUDNzMUxjcVpDRTRnMG90TlM3MDU2UjhQd01GcVJ3?=
 =?utf-8?B?azBiK243cjRnTGtWZlJWbzMyanI4aHF2bGxqS09KbE41c3pwQ29xWVdhMCtG?=
 =?utf-8?B?WXdpRzlJbFlVUnhFVzFNT1RuSzFUeWduWEtnUGtIV0FTUVA4SzN1MUZCOUNL?=
 =?utf-8?B?UXc4cHQ1MjdQaXc3WUVxa1pmYU1IL0lyTll1K1JoQUhrRW14dzF6U1ZHZzYz?=
 =?utf-8?B?Q0xyYTJORkJKSm1COTYxVnJieHdsallEd2g4d3ZhdWhtMnpOMThFdW9JMHBh?=
 =?utf-8?B?R2w3WTVScUxkYzJIY2NOb25adDVXZnljMU9Pam92Mm9JWkVMck5xcnU5YmIv?=
 =?utf-8?B?WksweHlINTQ3a3BwUzZZd3Y4WTNXSVlOdDFmWXJkaEJXK280TlFHd3E4bkdt?=
 =?utf-8?B?MkZHeXZYUFFtUFlBcjZQdGhSN3h4bW1RenZ3ZmFHbzZJNHNmRDBpbXo1R0lG?=
 =?utf-8?B?ZHBMTlBLcGpRck5sRmZTckRwOG9ydXc1NFZYMGIzbDJpWUVxTTJnMDEzMkox?=
 =?utf-8?B?ZW9DYkl3WThaQUNNbWZ3UVFtb2JaSitLOUY4SlhnSjI0YnJEbzBjejBTS1BL?=
 =?utf-8?B?T2pmRGZPNmVic1IxTnQ0YXVQdGRWK09yZ2lQYzBPVlBndnI0WFNQUHVsTm5U?=
 =?utf-8?B?NUkzYU9ZYnFYbFh3bWd3eC9SNXc1UHBKUGpzOTkxNnJJSTZVUFBZMGhzaDA5?=
 =?utf-8?Q?jLfBbi7ogi8YyNPo=3D?=
X-Exchange-RoutingPolicyChecked: Rg/JtQnBjhBCJjhwkuqtMQKPQZLLwA6YzO910DN8B6QdvYSzbTTnZTfgrM9d+acGRIsVdXY6RUOaQ8zZqVO7m40AsN0XqcUjYLYtrqdSzhO9y5m6c6c09qAUTUMgka4JwEhmIPdGi7C9n6WQjGbKD1XeAUc3Pc+bTHismBDD7APEkcUXzjorblCNaLUxKpfh6gkVIZXmST6Vqj0DF0b58GMCiAAjIN751laxodIMRHabfjdwHLWjqf7sT6VrEQxQVNpuSxiYZkcqXvA7T0GRNynYQiCy3DbhoxEjuRHulJmzmlVccQFGeo14/dkHoq3pvubyLTR+0sa9+3Q4Sm8bUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba8fd49-a123-4483-425f-08deb7c798ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 06:01:43.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fu+sHwQNqZYtcH/pcxYRxeBghnRLSxEUYUHUsi/x6LWoeAzrIQOm5HuNKs+8Uo+uV5vZC6C5WUMOqh64nwX8kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4970
X-OriginatorOrg: intel.com

On 21/05/2026 11:35, Artem Shimko wrote:
> Replace usleep_range() and udelay(1) (for consistency) with fsleep()
> in several places to follow kernel documentation recommendation [1]
> of using fsleep() for delays in non-atomic contexts.

The usleep_range()'s have presumably been chosen and validated.
They cannot be arbitrarily changed.  And then there is no point
changing udelay() to fsleep().  Please let's just leave this.

> 
> The fsleep() function automatically selects the optimal delay mechanism:
> udelay() for delays <= 10 us, usleep_range() for 10-20000 us, and msleep()
> for longer delays. This makes the code more consistent and simplifies
> future adjustments if delay durations ever change.
> 
> [1] https://docs.kernel.org/timers/delay_sleep_functions.html
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 0b2158a7e409..4cccd6e42e60 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -816,7 +816,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  
>  	/* Reset DLL */
>  	sdhci_writel(host, BIT(1), DWCMSHC_EMMC_DLL_CTRL);
> -	udelay(1);
> +	fsleep(1);
>  	sdhci_writel(host, 0x0, DWCMSHC_EMMC_DLL_CTRL);
>  
>  	/*
> @@ -895,7 +895,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>  
>  	if (mask & SDHCI_RESET_ALL && priv->reset) {
>  		reset_control_assert(priv->reset);
> -		udelay(1);
> +		fsleep(1);
>  		reset_control_deassert(priv->reset);
>  	}
>  
> @@ -1136,7 +1136,7 @@ static void cv18xx_sdhci_set_tap(struct sdhci_host *host, int tap)
>  
>  	clk |= SDHCI_CLOCK_CARD_EN;
>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> -	usleep_range(1000, 2000);
> +	fsleep(1500);
>  }
>  
>  static int cv18xx_retry_tuning(struct mmc_host *mmc, u32 opcode, int *cmd_error)
> @@ -1490,7 +1490,7 @@ static void sdhci_eic7700_config_phy(struct sdhci_host *host)
>  		val |= PHY_PAD_RXSEL_1V8;
>  		sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
>  	}
> -	usleep_range(2000, 3000);
> +	fsleep(2500);
>  	sdhci_writel(host, drv | PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
>  	sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
>  }
> @@ -1520,7 +1520,7 @@ static int sdhci_eic7700_reset_init(struct device *dev, struct eic7700_priv *pri
>  		dev_err(dev, "Failed to assert reset signals: %d\n", ret);
>  		return ret;
>  	}
> -	usleep_range(2000, 2100);
> +	fsleep(2050);
>  	ret = reset_control_deassert(priv->reset);
>  	if (ret) {
>  		dev_err(dev, "Failed to deassert reset signals: %d\n", ret);
> @@ -1565,7 +1565,7 @@ static int sdhci_eic7700_delay_tuning(struct sdhci_host *host, u32 opcode)
>  		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
>  		if (ret) {
>  			host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> -			usleep_range(200, 210);
> +			fsleep(205);
>  			if (delay_min != -1 && delay_max != -1)
>  				break;
>  		} else {
> @@ -1736,7 +1736,7 @@ static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned in
>  		 */
>  		sdhci_writew(host, 0xffff, PHY_DLLBT_CNFG_R);
>  		sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> -		usleep_range(100, 110);
> +		fsleep(105);
>  
>  		ret = read_poll_timeout(sdhci_readb, status, status & DLL_LOCK_STS, 100, 1000000,
>  					false, host, PHY_DLL_STATUS_R);

