Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66478F34;
	Thu, 13 Mar 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854068; cv=fail; b=uIJnbDzg+js0FPyCD1Q8SBqGQlaXwGqZQXEAmPR+qewHd0efihAKplLwGJTOM3jBxev//daOAF21i500A3OVFgH1HIQ2qXCS+jIKAjV/xcFQ6XG1uYufnQf36Qjg2TCJJg5EhJD0UEpwObD4V+oKTCHb+U0/lPkIknKGzgjwTfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854068; c=relaxed/simple;
	bh=epnKhZaZdBN87MFxY2Wd6WKljcJ293ByhAu7zqM38es=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jrgv/krOfaUgC0RgXYUJiyQ59AaU/njjSFpGkOSpnBetpel4tnqGl/3NN1bU1RICzpA4Kl7Pp48Ol4BGuW1cKR2PnQa0wiX4xfGVpjNjYjuMI3zMbK0wX2apHLgPtCc+Quk8mZ4mAw1y0BPRLJ0sIElL22SdSHUk6tPiVHOjGH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acM2/MzM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acM2/MzM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741854066; x=1773390066;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=epnKhZaZdBN87MFxY2Wd6WKljcJ293ByhAu7zqM38es=;
  b=acM2/MzMzx7YvzCJy0R+/gwUrwrFJtJlfToAx+1K/TNI98URg1782oVN
   79lFM4k0Rp1zmgPNrnoUzO93b3HRGzbctHfDqivfCoK8KYu80IvtP38JK
   mVeaiBU1kezROf5SJO7vLtF7mD6lO3zaagsops+W71VNxSY8Vq+T8kO4J
   uCR1xWsmug20ebAAMtGrJNQbrZ7OqRYrYtWJ9iiZpKXRdzerpQqm3EhyL
   5Pruylzh5kZcJsvCvCIBz0jeQ2RYvZBt7dO2FJr+oD7BECfdhIhpVDtAh
   vnqYfqYunNB9DKqYuhrn27lKPJDwwPKcCpHJ2ftUZYCgmgFLh5/llsPM2
   Q==;
X-CSE-ConnectionGUID: qUJuqOY+Rl+6M9qr21twSg==
X-CSE-MsgGUID: teU5d+Q3SbOwed90+gmLqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53951475"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="53951475"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 01:21:05 -0700
X-CSE-ConnectionGUID: 4/j5IscoRFKQtrNn1t1lbA==
X-CSE-MsgGUID: adaoGyGJQVKMKhjnPIV5jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="121586246"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2025 01:21:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Mar 2025 01:21:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Mar 2025 01:21:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Mar 2025 01:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LowLHOckFZ/kNCnFoufx9d0o42N1DIIHLDKQBUdZmt8lAmpsKHBYPz6tgO+YWw23IS8vamR9uAWyhxnJCQK9Su9eSPFQEkZP7/v/rxbe5L5Xr3h0jzCYM2hIAEhXNzsHmnP6Y1OJ8f4/vcgbf99/NJ+WF87nBIajSxKUYPp1Tb7i2XNCME6Dp1x2gubgV4GVdUT17dfaSSdN2Jlhm/vO4qzb5dg3bhqsnGKf5YQ/jGDH3NPyiwyVtxYfa/84m9pqioi7DFjmxd3n9/En0PFnzDUNkxHw8AmqivArUKPp0GFcAzUrbqH+BHMIL2fZkD/8U3KPfMeCQghmCXgR1w3Kog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYEgS961TSbNYqv1h/AzIxOfm0bPGdXix305ge6+PAs=;
 b=b4yt+0kfBOZmrli01fpLrVARQsL7cKdGxHAT5amvabOhmGNdmBL7hmCUgtZYbZFphokdkxAvMBSKjH5zzi4MZFNf/U6NKfODhLAvtCZuaNHFIOxZlZ7uPrfSArGVszL+frIHysjHfWW2B8P3n8MjkcsDXUX3WTFUKraPuF0PNqo7FZxqtNTkaXKIo2c06hrXBcgru6TialxJbrljc8vuXSyum0op/ffSKa8/kbhYffn0YwMrZJKVEovfXrisIWuHRrc/hPa7pQDgXZ4T0+K/K893g2aLCIPZcZSC3A9uU+oq2+pJb5PUEOB7XA0zTn07MgCza9zZdr9Be5Gx46voWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 08:21:01 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:21:01 +0000
Message-ID: <802daedb-d82c-4d0b-8e69-d166c169cbb1@intel.com>
Date: Thu, 13 Mar 2025 10:20:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Wait for Vdd to settle on card power off
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <brad.mouring@ni.com>, <gratian.crisan@emerson.com>,
	<kyle.roeschley@ni.com>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
References: <a7d1bf5d-6101-4282-92a8-11f9f3569d8b@intel.com>
 <20250313033552.1505631-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250313033552.1505631-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0255.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::22) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DM4PR11MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: c017f798-c381-4820-b814-08dd6207fd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WS9zYzNZbnZjdHd6MHBrUS9NZHIrSmxlUm1LdTFtRllJTTc2c2xMUmUxcnFU?=
 =?utf-8?B?Z0MrZFA3SFdqTUpTWHhKK1MydVUxZWFtT09vMFI2NCthWWY3QS9wdElTNDhH?=
 =?utf-8?B?cDdmQVlqQzRWRzNCdnFraVJyMFJWY3k4WEhaV3liUDJnUGFsQU5tbU05MHF5?=
 =?utf-8?B?Slg0RXVPOTA0OXJmSWFzbUJ4RDcvV05tTEdMdEN3aW9zMEs1SW04cjBPSXQr?=
 =?utf-8?B?cVAxK1FWNTFMVlZOcDlyWjYvT2U2aFQ4VE9SQWl6M3pzY2NWQ3YvUERJS1lS?=
 =?utf-8?B?cURBcUx4RGUxM1p6VGRuaThQdU5ESURIcmFkblNjYm40anBKajEzK1RqcFJP?=
 =?utf-8?B?RlUrT2p3Y1MzdG8vUGlmb1ovRGpLSUc5ZTcxL2xsK25WRFAxSFJTVXJ1UWJq?=
 =?utf-8?B?NmcrVFpMYVpOb1pFN1llR2lKallyYmF1MG9OMVVldXZoZUZUb3dDRkRVY3JR?=
 =?utf-8?B?RXgyWko3UkVaeWVnNWNSNUJkZCtTVmRLbitvR1lURWwyTmRTLzN4VEhsL21y?=
 =?utf-8?B?WWZqQTdBeXNuN0JOOFFFelVRb0tUQWtvdDNTSC9WSkJYdDNELzJQeXMzMXpQ?=
 =?utf-8?B?Y2xySzQ1K3JZUnpsN21VMUFmbG0waWFENDRudTB5M1YzeTRPMi84aTNzMmpD?=
 =?utf-8?B?ZzNIY2Fmcm1uMmhOVk5oRVBqZSt3c01XVC9DdDRUYmtJUnNwSWZoMmtDc2Js?=
 =?utf-8?B?eXJIa0x6M3liYVJyRWxKNElwa0lOS0tCYk5XclFiOFdMeDdoKzVDc1FnU0xK?=
 =?utf-8?B?UUZ4clJJYi83TTBEbDVIdUNKK2s3UlBUY2wwYUlPRWc1a0h5VG1sVkR2bEhj?=
 =?utf-8?B?OW51TndhMzhJNVlyMjhMOWkraCswbmUvRnpSYTFXcWYxM0h5dXpQb2I0dlFu?=
 =?utf-8?B?R1dldTJ3K3h1dCsrKzd3em50akxNZlRnaHh1UE4xS0dXQWRaeDh6SGxSNzAw?=
 =?utf-8?B?VWJYa1JqaEF4U1hIKzVBWUNtR1FadWhlbTZXREEzVjIzaXhtNnB1dTB5bjhB?=
 =?utf-8?B?ZnZiN2wwYXFRZ2hzSkFzUVU1R0J5SmI4Nk1EZDcrUVVwVDJwWjdkWEdpb0tK?=
 =?utf-8?B?WHd3WDNnWENmdzFaYnFQSGhkRHRSTHhUMDdqcXUwZWp2VFJNMXdkQUNqVXVU?=
 =?utf-8?B?bmFFRHNpZlptbXluZXVuaFhDTFlFNExGOGRicEdWanp1ZTVyejBzcGFCSGpY?=
 =?utf-8?B?TTNiMllLMXVaUG9IdTFlcm1idXpsWWNSdlg4SEN5MmtnY29TcU5Nc3laNnE4?=
 =?utf-8?B?TUhiMW1HT2ZISFN0SDRsUDN3RDBJR1BCWVR6QVhYWGk2cEd6Q2dwZG16aFJD?=
 =?utf-8?B?UE5FUzRsdVRRS25xdDNtM21hVTFMVXUxY2x2eUorS2Z2VGtGelVkOUpoeUh0?=
 =?utf-8?B?N0I4TllVQTJmdHpQY2NFRkRZb3VBNnVxdnhKeWxpR1V6RFNhcUJldXhYK1Y1?=
 =?utf-8?B?N05pNHhqZVc5R0RiM3dVTFJIS3RWNnN4Q3pjeWNsVnJBeml1ellYeDQzdFdM?=
 =?utf-8?B?c2t2UFl1VGJPZkgzbytoWXcxbWVMVzJZaDZ0c0lDd2tIakNJVU5yUWEwWkUw?=
 =?utf-8?B?bmVGdzNqWUtjZkpBOUwzeUhSNGNPOUxlaXNEV0xOb3p0NWFXSlFPT2VUT3g1?=
 =?utf-8?B?VUNMaVp5ZXQraXI1c2ViMy9PNmJsVFZmWWxMb0o4c01TZ2NCSXZMS1IrOG40?=
 =?utf-8?B?Um4wMHhnRnVnL2d1d3RMZ1BrckRDd2NwaXdhZXJmbzY0SW5aY0xvVmpCanZI?=
 =?utf-8?B?Z1hRRFlJWVZZUU1BKzJDdlEveHJmalVHUGZMRU1jWXRiRUVqZWhvR0hDZFdV?=
 =?utf-8?B?OGovZjE4ME1LVURTUkxISDZnY0h3V3dFYnVPM2ZYL1JyN3RZK2p6K2U4UVNX?=
 =?utf-8?Q?VbNt97QV1S0xL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9LU0U4RS9maWhYcUFnbDJMSkFNN0NkeEhZZnBaQ1k2Vm5tSmlmVEcxZy9P?=
 =?utf-8?B?aHhSMjJCNkJMSzdnSVMzS3BDTVJub0NUMnFneEVvb2JNOGphRjBwZE5UZ3Ns?=
 =?utf-8?B?NzVjK29NODhHS0FPNmYyVkxXT1crQTJDMm9tdmkzSFFnbm5iclMwMEtLNHM2?=
 =?utf-8?B?Vkpwa3dicTZXekQwcG5rWXV1S25CeU92eVJzc0R4My9jK2podlFxVmFLZktr?=
 =?utf-8?B?QWtRb3Y5ODg2QUM4aHNkTEhRajdUdTBpWVpJZ1lMZUtwTGhCdUFBYTFmRjha?=
 =?utf-8?B?VFhZeEVJTjcwRmtsdE93ekl1SXVkQXVCdXZ3aE5IaVVZSytPS0VKcjIyQW1s?=
 =?utf-8?B?VE5ackNRVUdKOE5ocy9Pc0NwZFU0THd2WVhtM25EZUhxU0E5U3Roa1o5YzEz?=
 =?utf-8?B?YTVWblJvc3gyaVdua2V6c1NUY3dzQjk3RGtFbFN2SjZFWit1K3N5SkFQL1l2?=
 =?utf-8?B?N280aUQ3bTh2UnRWd3dtSE1jc29sVjE3UFdnOEE1V1J4YXBzVW5zcFpZYW81?=
 =?utf-8?B?RitjTXphcEJkRGl2K0pITjMydEpmYlBUK1VOQWtJakhNY2didlRWVVVUaXRP?=
 =?utf-8?B?NStOdnJmajhNSWFic3h2MEVWY29FaXZ1c2lBaXVOaE54QWh3RGdrOWJyRVJl?=
 =?utf-8?B?bVgwcC9OZGJLWjU3d2VXejBaUGVHbWw5elpIZS96bUhIdkxSZlVwcWhsVyty?=
 =?utf-8?B?bVp6WWpyQlBnOEVQQlFFZFUwYkZMQ1hWNDZmTm1oKzZyaTRoVDd1Z0xYTE41?=
 =?utf-8?B?RjZUdUdyckQ3blpsc2pvbS9uZXNZak00ZTNkSnRtcnZsUWRtN3FBMkNXc0pU?=
 =?utf-8?B?dEcvdW01UFZENzlkVU9UL0ZhRkFMUTRrTUc0TTNPR3FXWG1rb2RCTWJJekM2?=
 =?utf-8?B?aThVU3A3ak1kcUMxbkszZGxreDExTSsxcG9KdWtHeERIK0lMSXhLL0F6WmIx?=
 =?utf-8?B?NytUWGRnQy9hU214Qkc0UlNMekVCdGJsOUpqV3FYWSt4eDBnRSs1NWliVEdo?=
 =?utf-8?B?MTAwbVhDNkhNb1o1VjUyQmZ0MVUrTXRTd3hldmlFelhZWUF5Qk9RM3dqUEJr?=
 =?utf-8?B?RXcxZjdGTjRTK2NiM1RrSUV5N0xLcUhzUGRFcERHR3BFNUEwalNDdHZlV2Vl?=
 =?utf-8?B?dzBHeTlreGtrK1o1ZnBBbitaY05PZE9KT2JjQWIyTDlTMkxhMkxrdkJKR2FJ?=
 =?utf-8?B?M01YdTdIQW9GSGdNc1V3WjFKWFNwNGdzWi80eStkcDNQcHp1dEdpQXVaYysw?=
 =?utf-8?B?RTBjV0VRWGlEUXFLSXhmWVNFUmRQVTV2NVY0MUx6QWZWbS9zTVo4L1kvQ0tJ?=
 =?utf-8?B?RDNFZU9saEFMbWVJOFJJVkRDQXdRTVpIVEVvRnQrRzZlcS85ZjFreVZSU0ph?=
 =?utf-8?B?SmszbVFYTkY1Z0FYNnhFcks1UzljVmFZQmY0SFo4OEFWRTBNOUxRdUh2TmU3?=
 =?utf-8?B?L3hCaFM3UkhzSi9RYVMvbXAzWkkrTFRWdXowS1BTRzdQTUgvd2hBcGdacWVS?=
 =?utf-8?B?NXhUNms3MVVtdEpxaHBrVEIvNXJiUkFpV0pqZldyOGhoZFV5Sm9XSHZIZnpx?=
 =?utf-8?B?ZWdKVUNTRlA1WDRnQkxrdXNXSCtqSVBNVktibTJ0K0ExWE8yOWg1RWFHdEk5?=
 =?utf-8?B?cnkrSkc0S2RKSTBUL3gyY2lDYjdhQUszM0M4UWZMa0taTldlWmk5em82cnFB?=
 =?utf-8?B?aHF4SGtrRjE2YysyODQyYkR3VUlOb2NtN3R2U3dPeFpNaXdaQVpucEhuRGZT?=
 =?utf-8?B?TThITDVEZ2dUS0kwOEVTNjlaNGxoTHhDaWtIQnIzOHVsa3RwYlcrMyt3M0tO?=
 =?utf-8?B?WlVmTW5SQ1ZJS05xQ253SkJrdkJBY0tFYWNUbUlGMnFMelQyU3lQMmZMMkVa?=
 =?utf-8?B?UFBJblNLZmZKU3dtQ2FYRjlhV1hUK0paSmpZbWNjOHdSb2Y3RGxnOXdkTGpL?=
 =?utf-8?B?WWFwQ0JLYVdieFd2YVlBR3JPZlVnc0dJUE5mbjdkL2xQYWljVVJXWXdUWGxH?=
 =?utf-8?B?dklUbnUxcDB1RzByTllLWXppYXRaK29lOWRFOXB3U0loK2hHSGlkbW5JV095?=
 =?utf-8?B?dU5tazcvRy9PUG9sdi9hd0FQenJSUlNubXZ2YXorNHhHRU54U3VVY2h1dmRz?=
 =?utf-8?B?R2pQYVZ2cHVsK1cweGVNZmlycjVjVGpZZktOOW0rcWNlVE9XNmJtVUt5dXRo?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c017f798-c381-4820-b814-08dd6207fd0f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 08:21:01.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P84q0MJ/kSy8W3YVTFghOpk9uMRyfafU/uxtlgraAb6Vcrin79RWBVbgZjBO2uX2st6P5b7ve5k8/Y+1Gf3K4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

On 13/03/25 05:35, Erick Shepherd wrote:
>> What about something like this?
> 
>> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
>> index 1f0bd723f011..0789df732e93 100644
>> --- a/drivers/mmc/host/sdhci-pci-core.c
>> +++ b/drivers/mmc/host/sdhci-pci-core.c
>> @@ -610,8 +610,11 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>  
>>  	sdhci_set_power(host, mode, vdd);
>  
>> -	if (mode == MMC_POWER_OFF)
>> +	if (mode == MMC_POWER_OFF) {
>> +		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD)
>> +			usleep_range(15000, 17500);
>>  		return;
>> +	}
>  
>> 	/*
>> 	 * Bus power might not enable after D3 -> D0 transition due to the
> 
> I talked to one of our digital hardware engineers who worked on this
> issue. He believes that the issue is likely affecting more than just 
> Apollo Lake devices and recommended keeping the delay for all of our
> devices. Could something like this work?
> 
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2176,6 +2176,9 @@ EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
>  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  		     unsigned short vdd)
>  {
> +	if (mode == MMC_POWER_OFF)
> +		usleep_range(15000, 17500);
> +
>  	if (IS_ERR(host->mmc->supply.vmmc))
>  		sdhci_set_power_noreg(host, mode, vdd);
>  	else

sdhci is used by a number of drivers (drivers/mmc/host/sdhci*)
that typically use the regulator framework to meet voltage
requirements. So that is not the right place to make changes.

It would be best to put the affected PCI device IDs into
sdhci_intel_set_power() as I showed.

