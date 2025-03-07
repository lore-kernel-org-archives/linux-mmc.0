Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45F114A4F9;
	Fri,  7 Mar 2025 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351019; cv=fail; b=bIqPdi83mtSUuqV9eGACHjMjekZqdAlYIjGV6/49+9daC9kT/CB4oRxK3GBT1dJPlj116u/zmPgVmcj+LRmN2Hf3e/iElMYsvvsCWmnBg1aaM514OH8xyh3wYhhpxGDnaZt2tL9DScuaU7/qXCkTWEh/Vu7rLTyqyshnJSnIzJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351019; c=relaxed/simple;
	bh=zNl8hsIfcP8AgJOrwZvXi6xKOfls1SiUiNPOruKYEpc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mlj/+66DfTFGSCLrVqFkSsBgSj8q0Ljh4U+0wPWccStgs2E0wIfOiNS6sbfyTzadZP0nUgl61fTFg5G17imSLn5D7Wp9C00cedlUChUu4Jg1eFbJ4H7SVRTwozYZ45iE0ex1AIQypC+NTl6YuLLkiN7xCuTtXlJX6JmArSlYW3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIb4rGDZ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIb4rGDZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741351018; x=1772887018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zNl8hsIfcP8AgJOrwZvXi6xKOfls1SiUiNPOruKYEpc=;
  b=jIb4rGDZ8Qi5HEvjGDBx3rolDsnuQpielMu64gVwiyrhRUKUED2KyR+c
   /x1R9UUsPetGbRoO6PzdSJhBRT3WyljIx86uEyt4siOTIW1V2iiAuROra
   vP09eR13jD9PoTlP0RsMOHdb3SGk3JSbiVES2iTkX1E2AkmCbxpta67jA
   SgDsRReR8H7GlcQTY+wY6DYI4CpHZvFJqFu+A/cpGx/VfvMtrmzrorIS5
   fH2wPo8kIkzNptscxIJOtAPAANNeCfMzE/f9Hu0GIkjCIybXJp+Vnc1rt
   x0DgObTwOx98O+xip84TEcxFo1LSx8c/0Oo4/SbpdIIIPBlBAHNwLYT+l
   A==;
X-CSE-ConnectionGUID: rs1jovTOR3qGO4lz7UDqzw==
X-CSE-MsgGUID: R0+n4PppRUSj66Wj29Rs5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41651497"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="41651497"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:36:56 -0800
X-CSE-ConnectionGUID: Vvqk3zBnSISlFyJVz1XLpg==
X-CSE-MsgGUID: bnSW+mWMQ6miclYYxKfShA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119484531"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:36:56 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 7 Mar 2025 04:36:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 7 Mar 2025 04:36:55 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 04:36:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6F4oQ5Q4X0XIB76TMYLUV5wiPyBLKzvRyCVMmMNLUxekqsyDg2scZA1gI0hvBQrKmn6S7yaYcN1RfYD3wRKEM4VM5MoaHlj5mJO1K2CJJF602PzlTZL8FT+k0nFdmBoMMzZ0ygH/xw4EU6l82tt+ImpBAn5gDkSyqid5V3iTWrYmewD1rv+OrqSyxjnHauplKr7ecb8I4t2BYiFpgRVBdZjKxVAUQ09Y/k/C7Voa8S+ONU+w7M3O/5xNHCjvIJBCI3nzCNdwZByDh/36Jy5WXJ0eZn22HGVXgT8+tQCUoCrStl+e5VJeAUvc2ZgJilwjrNCetRtlVY2kvugU/9A/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlL+qW2owfUyOZhQuxy+w1wU3+RCNH7rUsVCVdqDTx4=;
 b=A5ycm1IM6XZg3cWQRjID9cgvnNK9YOD6xBzbroAarLNkXY4CkA2LsAdL/VQ7TIZCn+gb1e1jY9eip8/2plEgrKt191JGGXir++YfvZo3S5trDS0b2BVFMfFmDQ0rKq4U7ivvrJ5pEfiv925MtC0k7jw6X+a/eCP60Ejmxz+khn3/kkkD8OvTakQo18uC7p6oZcL6NByIJqtmH+It6gjs4ZXsWuSm2AX4dwX7qVO100VekJA0k+fz9UDfmIUlbFgj5UmxY66Lg6srW1euuhHZjoAijvYh6Dus6S3j0Y5N+5g1jltXEt/0GCSMCS4kJv7CibyxZRAvKNfwwUZd5aS+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by CO1PR11MB5027.namprd11.prod.outlook.com (2603:10b6:303:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 12:36:20 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 12:36:20 +0000
Message-ID: <c7e98e11-38d2-40b4-a7d0-3a884cf8d8b8@intel.com>
Date: Fri, 7 Mar 2025 14:36:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mmc: sdhci: prevent command execution after
 undervoltage shutdown
To: Oleksij Rempel <o.rempel@pengutronix.de>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, Christian Loehle
	<christian.loehle@arm.com>
References: <20250221093918.3942378-1-o.rempel@pengutronix.de>
 <20250221093918.3942378-7-o.rempel@pengutronix.de>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250221093918.3942378-7-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|CO1PR11MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 86018a97-5cba-49e2-befd-08dd5d74a8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0Qwc1NLUVJBOUFUSkYvTk9ZVFQ2UEtGeEtobWdlZnNYVmdsOXFYZXdFQ3U1?=
 =?utf-8?B?ZUV1a0l2UEZtVWFuTWpuMUUwS3p4cG9PQkpaZWpZdzdPeEd5N0Q3bGpUT3dQ?=
 =?utf-8?B?dndhWnJCd0FGQmZmV3BDa3FpQm1LejRmVytycHlGRmhNZGJ2U3IrVUV0enJO?=
 =?utf-8?B?Y0VGUnFVQXdjUFU4WmtScXlReXB2d0tmTkcvb1hxVEp5RThYMVV4U2JBWVRR?=
 =?utf-8?B?YnVzQ2oxcGxzTlU3YVFYakFZZU1KNytvSW95cEhDR3hubk5qelZhYVFQNzdz?=
 =?utf-8?B?U20yVVltUWdLdE9zbEZKa1lFZVkyMDRHTmhuT2JDQ3NvSDFiZ3F0eUJBcVp0?=
 =?utf-8?B?RVQwYll4NGkvQzBEbUllRWE2S1JSeUljU1owL1BvUWJGb0YzRVcxdWxidGZ2?=
 =?utf-8?B?ckJJOE1hVk44eks3Z2huVnozZVF5M3dlN2pPZElyNE4xakx6OHpvUDVQcjVy?=
 =?utf-8?B?QzNNUk5QcGF2N2RrdUs1bmR4VExsWXkvSW1rNzZYVno4ZFg5MG1ramI5UWRv?=
 =?utf-8?B?d3lOemI1c2FmTjZYNE1oNDZOSU9SUnZoYVViWDAvQW5ock4xcE8va0Y3TFg2?=
 =?utf-8?B?K1Q0MGxSSlZXc1pWUzY2eGRqdHluZEFQUDdOUWRHeC9ubkhaTWM2MXd5YjRV?=
 =?utf-8?B?dHNEQlRkUFVjLzNvVzN4Sm1jdi9OSURreEtibUFyUENMSGVzZmMvZkdxSk1v?=
 =?utf-8?B?eUpGb2xoUVBuQXBMaldaN0lYVFhuNXFHcU03NU1YeS9qc2NZMjVka3d2bldZ?=
 =?utf-8?B?SHBrN3BzekEwNHNXQjg3RTBCQ0FXeWdQVHVTclk0WGk4SHZaU0t1Y2VVWjU0?=
 =?utf-8?B?Qy9VdTY3MzBKNmt3d1J0RnNBcmdFMzdTdlA5cEFSSERKeEVDbE9xeEUzZmEr?=
 =?utf-8?B?ZkpEOXg1YXJvM2U3ZVVlOUp0VlpzdW8zUVp5SFZ6WVBTNDJrOTNVRE8zcFh2?=
 =?utf-8?B?d0trckZrWko5U3JUQ1lhTkFpTFdieU45bXEyaWlFa0FMcldoOFBGeTdrT3hn?=
 =?utf-8?B?T0Uza0Q3T2thYVJoZVJCb043NlZxZ0JlRllZbXFya2dpaTR6SjN4cDNWNGc1?=
 =?utf-8?B?M0crVWJkTzFaTUorRWtOcnVxOVNXYnZncnNyRk9JOEZaUkhMVmpaNkVSSHMv?=
 =?utf-8?B?WUI1cnlVSS9UanY5ZFVIMWdlRkQwK2sySkxkWGpzdUZRWldQR1RqdUQwQU1K?=
 =?utf-8?B?REFvL0hDN3htbUpEMGw4WUliejdPQ3ZLeDN0K2ZzY09zampqcFJvWGNkVmlq?=
 =?utf-8?B?VFlaMktHK2x2OE1mY3JRb3FMbURQLzkyNk5RcEdtRmcvQzVHSzhRR3J2SnBB?=
 =?utf-8?B?anB1eWMxMlIyRk5iRjNyd2dJck0yWmV3Y3dLbTlxRHBHQi84UU1JZ1dsT1ZL?=
 =?utf-8?B?TjEwVzY5NFFJTUVTdjF3MmN6U0tDbnZhb083TzBEdHk1L1dybDNqeWtscThW?=
 =?utf-8?B?ZThMay8rYlFhbU0wbmd4dzUrU2FtNnU3VzJIVnYyYUlLN21oSExEd3YvNEY1?=
 =?utf-8?B?SVZUY2lZQlBIOG51ekNvMUcxREdJTWdvdnVubm12Ym9jaFpPVWtkRmlVYU4x?=
 =?utf-8?B?L0gyZWtnQnNva2pMbTFMRWZ1WUtERWVhdU45TzFsSEV6cTIvN284RlgzZWp5?=
 =?utf-8?B?NFo0RG1XcFdPcVlBc3lBSGgzYTdyeWhlOTNXVlJtS3A1SDRSdkl1elpvYlQy?=
 =?utf-8?B?N1NtQ01SN3cwam5jTGdIRVRsWWR2WkR1ZSswaERsSjZBOHVwN3FEa0E2Vy94?=
 =?utf-8?B?Skw4RE5xb3h6V0UySUJrTFk0TG45Q3VrejFweXVtS2VwUXdUSzZaMjdINHVv?=
 =?utf-8?B?ZHJlYjNxczZ0aE85N0dTbHBiS3RWRmN1dUFrZEYrNHhJbG5yRWZBN2NXd0M3?=
 =?utf-8?Q?/4NLKuBcGFBnE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjdzODBuS21zZkR1Tk81ZGVBaUswbkwxdmhpWEhIbXJLRXR4eUpKcVBNSHJn?=
 =?utf-8?B?SEJPL2dESzIwN20rUEFqMDk1U09LSzQyTzlLOCtSTWZ5djFDSzlza0NSclhl?=
 =?utf-8?B?c1ZCTGxKMUoxL1F4UUhsSUFqajMrS1VFZ21SYWI4OC9OSUhQRlBRQ1ZJblRF?=
 =?utf-8?B?VjBCL3F5MFl2VkQ0Q1FUa0YwTEdZMDBLd3ZXVmxTcldKQ24vMUFxbms4Ykxz?=
 =?utf-8?B?L1lDK0ppQXYzK3ZvTUdwSXcySUpPUi8xeElUcitJTjJnT2dhRWZtSFl5TC82?=
 =?utf-8?B?NE9oeDhIbU8rM2FIekptamw0TGZ1M1l4L2dWc250WFA5ZU9ZNTFiUmIvZ2dT?=
 =?utf-8?B?eisxZnFZRXA2V0FuY3hNVjI4dy9aWWNnRnh4a25UbTBhVXVuTkJiUUkxelA3?=
 =?utf-8?B?bUtUUTgzeEV6KzVxQWZxQzF4RllnZ3FXZG1menZjS2Jia1N5NlhYVHBFMzdI?=
 =?utf-8?B?YVdQYTlIMTl2YmV4WUZxUktnbjkxYTd5bHBxZVNIclU3ZzlPa3VWU3E4WnZ1?=
 =?utf-8?B?WmdNalZQRlY4MjdSVTZUMkJTMElRNmUwT2NQVGZMVHdqTVlWdWZQd0NlVzVG?=
 =?utf-8?B?aXJHRDFkN1RoOGpHOVdnOG9kMU1iWVhvUkpBUTFGcWFGSXVBMUtPYmtkSGx0?=
 =?utf-8?B?dlNVMno5ejhXVmFQdi9RcnQwVnozUHNjWkk3SHpnelF3a3Q4Q21yTkI4ckZY?=
 =?utf-8?B?T2ZtWGNmalRaT1dBNGZyL2krUWlqMXdiRkxUY2VmSVBTejkxTWxyWkpPR0w5?=
 =?utf-8?B?aittZTZHeFEvYnBlSGZhSFBRM2Rra1pyMmxBZHZZWmI0V1NsTGxzakFTRFRW?=
 =?utf-8?B?OUp4RnY0aGhoKzFaeFlCak01SXdlTkN0aktxN3FXKzBoRnhFWnBQL0Q4ZGlR?=
 =?utf-8?B?ZURMdDZjSmM5UDZLMUdDcVFPMXhXT1QyMUNiVEtoTk4vYktsMFpKTEN2bzg2?=
 =?utf-8?B?MGVPcUltWjdHTDFLSVdFV1BKNXpKcGNvRHllQnhPQWJZdEdtSW9Wa0hDTlkx?=
 =?utf-8?B?RjJEK25ydTg1Q3dlSXlraGx1V0ZNUDM1M2t0WnRUdnpCWnh2Ny9VOVEvTE9Q?=
 =?utf-8?B?TER3TTI5ejZmYzRlUVZuazFnalRzWndadU4vWmRQdDNRc3ZQS1REWmwyWHQ3?=
 =?utf-8?B?RWgrR2hpVk5KOERZNWY0bXRvMDcvcXYyWXk0YjhCbjFCRkU1OGt3SDVvVVhy?=
 =?utf-8?B?bWxqbUs0VkFRem9YdndWVlNYTU53c0FocHN0bGpPQmtCQ2l3VHhPWlNrZkFU?=
 =?utf-8?B?V0gveE9ueWd1Sy8xZkMwVEVFcVJiQjVJajNBNklQbWUyd0JmNDZ0bk0xdk5Z?=
 =?utf-8?B?Q2s5bXVNUHZEMkNwbDkrU0dlMWE4UVBsYVl1UHl1bWV1dmVzYWdMelRRem9O?=
 =?utf-8?B?NlpMTzNCY2FURENhZmxNV2lRMHh0dzVGdUdBRWkvcEdHTzZ4OE1mdFVpTm1p?=
 =?utf-8?B?Z2JMMlFvUFBwVWxDSkt1TlFaMUcveFhNcmxGNDh5ZHUyTTVWWnkvZSszMElz?=
 =?utf-8?B?RVhvKzJGRmdxdjBNWS8yNWYyVU9sY2Z4Z1Jlalp1TXNBQXZRanJISHVrSGpE?=
 =?utf-8?B?cUF6Skc1RnVhSDcwUnlueWloV0dZbFBlYVhzeUswYUtaQis2b3hDVmJMa2tx?=
 =?utf-8?B?ZkJYQURhQm8rUWpMOTE0WEdIRktNaDlvc1hLL3lXQUxZRGl4MU8wWjZuUm9k?=
 =?utf-8?B?ZUV3MVFURGhmWllzMzV2ZWxJMmZyWENlNmVhbGtqSXVjM1ZCS0h1SnIrTlJi?=
 =?utf-8?B?RVN0czB2cXBtUlN6NVJ3Uk5abkU5cWZ6M1dCZkRmSk5EOEt2eDMrR0xYemFM?=
 =?utf-8?B?cnZjTHQ4RVQrK2hHdUd3Y0tEdW8rMjZuVDVhK0dYeHFqaGFMV2JhaWJpMmQr?=
 =?utf-8?B?RFkwR25Ybkg5am55QzVmbjk4aUFxMzlGdkZjTlZvZGt5SS9abEVXUCtFNnZL?=
 =?utf-8?B?TXpKWnlQY0c0ZUxqN1JFQ29Yek45Zmlxdi9YcU5KNVZMOU5lcGwzclNySXFk?=
 =?utf-8?B?NlNlWVVVSVlpVVlFTjJzVHJxSWQwQisxQncyWGNCOUlZQmcxYkx1T3ZnRmZx?=
 =?utf-8?B?cUtzQzhhckc0RXBsSFIycnpVdXg2dHhWNndkVnZaWERwUXBiVDRudE8xekVN?=
 =?utf-8?B?MWhkM3NoUHEzTWZRZEJ4M3dsOExFaGhGRHNnbVA2U3cxUDVTQlVxZG81RXl5?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86018a97-5cba-49e2-befd-08dd5d74a8b1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 12:36:20.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyE1R6baLw7f1aKOhbZODS2oj202DHNHLB6Xj3KNUVoujX2j/5R6otzS7xoDTeL4yVCbAmpUZEuYG4kb2MXOQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5027
X-OriginatorOrg: intel.com

On 21/02/25 11:39, Oleksij Rempel wrote:
> Introduce an emergency_stop flag in struct mmc_host to block further
> MMC/SD commands after an undervoltage shutdown. If emergency_stop is
> set, sdhci_send_command() will reject new requests with -EBUSY and log a
> warning. This helps diagnose and identify code paths that may still
> attempt writes after the undervoltage shutdown sequence has completed.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - add comments
> ---
>  drivers/mmc/core/mmc.c   | 7 +++++++
>  drivers/mmc/host/sdhci.c | 9 +++++++++
>  include/linux/mmc/host.h | 1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a50cdd550a22..0cd6b81d0678 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -2370,6 +2370,13 @@ static int _mmc_handle_undervoltage(struct mmc_host *host)
>  	 */
>  	mmc_card_set_removed(card);
>  
> +	/*
> +	 * Signal the host controller driver that we are in emergency stop mode.
> +	 * This prevents any new storage requests from being issued, ensuring
> +	 * that no further operations take place while in this state.
> +	 */
> +	host->emergency_stop = true;
> +
>  	return err;
>  }
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..8d67f27e7d9e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1658,6 +1658,15 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  
>  	WARN_ON(host->cmd);
>  
> +	if (host->mmc->emergency_stop) {

This is unnecessary.

The host controller driver should not have to block requests
because the mmc core layer should not be requesting them.

We definitely wouldn't want to be duplicating this code in
every host controller driver, so let's not start.

> +		pr_warn("%s: Ignoring normal request, emergency stop is active\n",
> +			mmc_hostname(host->mmc));
> +		WARN_ON_ONCE(1);
> +
> +		cmd->error = -EBUSY;
> +		return true;
> +	}
> +
>  	/* Initially, a command has no error */
>  	cmd->error = 0;
>  
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4e147ad82804..5dfe2cdde59f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -501,6 +501,7 @@ struct mmc_host {
>  	unsigned int		can_dma_map_merge:1; /* merging can be used */
>  	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
>  	unsigned int		undervoltage:1;	 /* Undervoltage state */
> +	unsigned int		emergency_stop:1; /* Emergency stop. No transfers are allowed. */
>  
>  	int			rescan_disable;	/* disable card detection */
>  	int			rescan_entered;	/* used with nonremovable devices */

