Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A073148FED
	for <linux-mmc@vger.kernel.org>; Fri,  7 Feb 2025 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738914776; cv=fail; b=buw8zgtGw3wNieLToarhnkQ7plFRJBfuUEOFLiO/5/TRaR2gpl80VH7xhnDzjJqiIJpJgO7kUhm+uEzCYl820mkPtX00O6zEsRGe9i2X4WuAsHW5zdSH+pM8EQRS2cwtt/m8PFN8n3I/kKNT2qses8H4R04pRfP91B024ttxylo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738914776; c=relaxed/simple;
	bh=tXlao/FsnQZZFUSGC1KZL3G5SYuaxpW/f7Nd6OXIs+k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=msh2H8A2jMop0bqqu+g/hgUmBoMt4R9eEFfOezWCllUCZDLy4Tf5cB0RHGgIT2N7yPti8kDHxKiDBTDVYC2CwQu8W58gKBxCNEica0Yprr6SeZiwe78iwmmjF3dRGnfcImK2m5O0gj93f3SJwj1q5x44EoZLSNBQPO9JaNNnaq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgejieQN; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgejieQN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738914774; x=1770450774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tXlao/FsnQZZFUSGC1KZL3G5SYuaxpW/f7Nd6OXIs+k=;
  b=fgejieQNmak0BkA6lGXZO0fHOeSLVpSmhdHYkZux4bAPKHJ1sJYPda/q
   uR0rWQ7cxltCsIsfvYknANBmEX41WWb1MHpDHJ6+iL9VoPMy5G59ysat+
   aB+0DDbqDYFh9E+BAs/RgnFSWcc/pPooYk5wIv2y7VEd8S7Yvk7EIr9VS
   e9WyAd2AqSSF2pyUWaGOE7xUEsrOuyuLE42s58cB3kwjj84TBu9DbfXqv
   qp9djbgS47mTZQ6bayaDlrrpGHYvF7LnrZLR8t5Y6gZZlCs9Y0ZKuHEbV
   pHJ/IT/RXTR3bWK5NvAVVV9TCBPvqHV0BJx1iUpzR7BxhfEQlyYef10Kt
   w==;
X-CSE-ConnectionGUID: nqvyNEGeRrGd+iLsdkPiSw==
X-CSE-MsgGUID: 6+vguiBIR0iWLNqAKLFgTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50532298"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="50532298"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 23:52:52 -0800
X-CSE-ConnectionGUID: 7rSKs5EESZGxKWk1m2O5+g==
X-CSE-MsgGUID: zh9YhjtFQCeaw1qV++trHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115548244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 23:52:51 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 23:52:50 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 23:52:50 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 23:52:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF9OCMvoqFfiJVcAGkppxQelGq+IUlwOzv8OgEWYeTfc7yFXJ+XWDdLU5C2iofw3y7y9jNIjm3X2xHmFTuGJlVUaEXEaunBWcU6ngNEABmQ5f9US4n1Jjlh8EtnQUixNqUUJF4D7to98xRux1bJoxF+ycX0TAX1xxYG/FdmGjILC5CPXm7fSg+sKrcHGm9Ilfe7hxsx1F9WlyGP2o2g6v8oBBx4dufl34K8K5X6/GhiC+NF1Nz8C0OXVferaLvzh/NeB6pqUvoBR6oKRhLwQ3IVjOLGj+x0lOjqysIrq2VUte/iiKt3a/bWtP5jqo9ntlN/Pe8sJL4+x4yLQ9GZqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDtcHzSHXURq2ByC7VmDvbHDTIT7xUwx9Pr2MTqf/ts=;
 b=ctebsKwbPlD25DWp5a+LQC9B3XuZrOVJ/iCtXsEgwxdmUyIiucgso99WnVMrDfuPSEE1FyNlOnlRWzzLJoS8SAaDbjNKSNCdvKKDv7s79tFRhIlw/SAMUyJTlYP4tql6heC6qPy198kIo+mLDzsHExhOwEV03CEd/YqmXJysGExBOOdD9ZPlIApvRwdUJPQNtjfcEsAQ+B13CdLDyCzKvaz6vV0DyFBGc7YDiRGCd10xTESoAKZcwIZSGJzkwimnyr5gQYKYhvp2Bm5Cg1KOMhzuPxmhQzQvl92L5Ovl0C6FSvGn4sttcwMppyvr34HHPSZh5gg9hH8SZoe8W8tZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by PH7PR11MB7123.namprd11.prod.outlook.com (2603:10b6:510:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Fri, 7 Feb
 2025 07:52:34 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 07:52:33 +0000
Message-ID: <002d931a-d8ea-4cc2-9e10-b70a5716b6ed@intel.com>
Date: Fri, 7 Feb 2025 09:52:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
To: Jaehoon Chung <jh80.chung@samsung.com>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>
References: <CGME20250131025408epcas1p10fa298907557074b1d38b25a56b51f5e@epcas1p1.samsung.com>
 <20250131025406.1753513-1-jh80.chung@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250131025406.1753513-1-jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|PH7PR11MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e62a926-db13-4e61-38ea-08dd474c617f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE11dlNuVzM1M2p0blh1ZVlHUUdxa1QrTmNoRVdEZmcyNTNLQkdRSFBXeEdH?=
 =?utf-8?B?SERCdktHbmhiWHduYTJ1M0pERGFDRGZQemh3S1RYWDdVbGsrR1BkM2dMd2ov?=
 =?utf-8?B?aFVZVzZEOUw3Y2wwQmJiQklET0crbnpQczJJQVN1QTFPQk5JWGpWY0s1Q0RZ?=
 =?utf-8?B?SUJlYXY1TFFCMCtndjlsZTRKcnArQ3ZZYVRwd2NZdVNEK3NUZXN2aUprZmM4?=
 =?utf-8?B?QUdBMnlhamNLbXpkVXJmaHAxKzQ5RkMyYkJ2QjJSUVVDRENCNE5RdWl4eWpB?=
 =?utf-8?B?U1NtUU9YcjBnMmxvYlZvd0hxQmhqSUloNzFWcGFqbXJWR3kzb3o3djVUUCtE?=
 =?utf-8?B?UU1Mb2pOc08rbkZyV0dCQUovMjhDa1BqN2hEUmxXUEJDMjBOMHZsYXowRlhq?=
 =?utf-8?B?STQ1WHJXS3lUOEtvYk80VEhVbHE0YjgrZVpVamFmckJIRVRlaHJRa3FEcitQ?=
 =?utf-8?B?amZyYWVscU1jVkVXNzZrZW5BbGhNc21zWUt6RURHT3NIRU9MemhTSDdjeDBi?=
 =?utf-8?B?NHg4dkhZMnlZaUlZcUxxR3VNYjlaR0pLajVVbzFIMHJmRXBFek1uVnRpVktk?=
 =?utf-8?B?RDRBeEQ5NXYvNzBMZVd6U2RGRXNUVmNiM2Y1WFNkeU5HdEFzL3BSVER6cmVP?=
 =?utf-8?B?R1V6S1NOdjlhLzRHMEo2djV2RUpOZE1VOFN0QS9nME9IUkpySzdlVUxydldj?=
 =?utf-8?B?aFVhUkRvVzN2dkRwUjhRbHV3aDk4ZEYvSEdnOUxxanNPOUdlbWRnM1ZXaVVE?=
 =?utf-8?B?RGFJOS9YOU11WjlzUDhDT0QxK1FncmxpNzZCa3FrOGkvQUNFOEZLTWZkU2RZ?=
 =?utf-8?B?OEhJZEgzZFlaVVhVQkNlMTJ5U2UxOGhJVzlwYXkwcGNoV3UzclVrQlZkNGRG?=
 =?utf-8?B?b3ByYUg1bUhSVkFJZ3Y2ZHFFL20zUGw5RzhKdFd3OFRWb0tjMzRnaDdtN1lI?=
 =?utf-8?B?enZlNUtRNUxDNW9RMldJbWJXN1pKS0s2dUdHQzhySUQrNjNKWUd6NkM4WFlH?=
 =?utf-8?B?YzF6UzBnQ0FSOVRQd2pucEV0L3JOVUdSZ0NjTWZrVC9LR2pWbDd2czB3clFr?=
 =?utf-8?B?QWlwUHZkU056bE9iTi9iSyt3WS83K2ZzaUU0TVVkcHFBbUVJKzZzNmNTWTJZ?=
 =?utf-8?B?V3E5LzZCOFp5dW1VNkIxeGZUanlxZEFVWDJENDhWY1oydkM5OEswTlh6MGdo?=
 =?utf-8?B?dGJiSGV3T0dBcnA2czFSNE5DaUYxWGRRaTI1YkJLaHFQbGphdlJNR2ZUN0RK?=
 =?utf-8?B?dXR4clVtbGRZY0NkU0RMTEc2NE9YdWJST2MyUGxXSzJ0MGhpU2hERW54N0FP?=
 =?utf-8?B?NFUrSmdRT3VzSVdIa21ZQm8xdU1BUXIrU1lMRGJrVndsUERZSG1Wb0hlRHAr?=
 =?utf-8?B?N2U0Z0ppZWVBQ0R0eDJVMGt6SGwzVTR4azNkaUdwNmtxZnNQT2NySTVBWkJW?=
 =?utf-8?B?SWM1U0xiSkpjWWcyVlF0ZFZRdWxzQ3NxSUdoOTRVSHNnVWJMNm5yOXo3UTJW?=
 =?utf-8?B?aGNWZjZrOExCSWtDbXh3YlhhbFFvMGNmdTBtMFdaamhnejBuRVFzM29TcWFG?=
 =?utf-8?B?QTUxQkc5ZmhDRnIvblprd0RPUHRHUGVaOCtBV1VuRVh2ZFBBZTNYaDM5OHhv?=
 =?utf-8?B?Y1Jsc0lqTVR2K29Jdkh4ajlRUTFBa3RlSGxYMS9tUlhSSnVXaFJabkdvc21O?=
 =?utf-8?B?UjRISXdRdHoxUldTLzMraXNIRitkY3FSaWRya0c2TkZSb1pETzRSbFY2YmND?=
 =?utf-8?B?WWlqaE9naUE4dzU0L090dE90VkVuWFBvYTlDWkFBNE1LbGYwYTk5SEppUjRq?=
 =?utf-8?B?ZHJJYTZtUWQyRnE3ZEFrT0x4UVlscmd2NnlTQkJPTGY1QTJqSlRPYnhQRHpL?=
 =?utf-8?Q?c86Pa3jqgZa0S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEg0Z3M5U1NCUXNhS2FmN0dycmIwUG0xdFpmYnVWT3RUQmF4cldKaHBLNGRY?=
 =?utf-8?B?cXJXd09iUTF4allOVjNGaTVCMk9PckQ5THN3VWlHODdkblFDT0xNV3VvdWo3?=
 =?utf-8?B?YkdHdU05R1drR1JaUUVZK1A2UGJCeENUZnU2Mi9QN21zSzdoN05PZTlQVlFv?=
 =?utf-8?B?QWVzMzN6S0VlSmxTNFVqY1BNMG8xVnJIUTg1ZzZCeitvUzA5WDZvWHdnNnRy?=
 =?utf-8?B?RlNHeXJMdkx2eE5sNXdFMXNtd3VuSUJac0lPN1NEcGJLQngvVitGQXFHaHdy?=
 =?utf-8?B?a2NkR0tBSlJWZVIwQm1ydndDS0RkbVhhVlBhMlVzR0ZXeUFqVjJjd01TcXhk?=
 =?utf-8?B?dTdNaUtwNW5DSjhhRi9tV2piWUxWQWhpZVRucHFSVkdnNGZyT1lhRnRScjJM?=
 =?utf-8?B?OXZxdG1iaFdqYmJhN2FGallxQWE5dU13c21wZjRlc0U4UkNCQ2hIZkdab2x5?=
 =?utf-8?B?NlJlYWJVY0pnOS9PTTU3bXRBeTBFQmRMejNITTRVeERTVWZIcm91K1VMdWYy?=
 =?utf-8?B?T1ZZS0gxbmpqQjNnbzFOUVVpaGUyeDFVUnlXRWkwZ3Z5UTFRWFJ0Qi9vUStY?=
 =?utf-8?B?KzRIc0srWnVQb2tLSEtjNkpCRjF1VUcycXpYSXREUDkxR2w2anVXQzVPbHBs?=
 =?utf-8?B?Tk1tTjZZMC9VU1RyTTZJaFBwZi9BcFFYaGVPY3FIUmsxRzd0bWdHVldlQjRw?=
 =?utf-8?B?OXEzVEtIVy9NTHdFdWhkVGNpWmU3T3NncmNmRmswVko4ekJTYWduR1JIOGdR?=
 =?utf-8?B?T0pyaXlEME5vWTZYbmtCVVdTdm5GN2xRY0FwRFpab3MxT1o0ZkpydVhDanli?=
 =?utf-8?B?Z0o0NkRMTGcvOGE0ZWNYKytQYkZpSEhFWXF6Mnk0UmNJeHl2Y0x0OW84NW1y?=
 =?utf-8?B?LzY2YithcDcwZjd3bjdsdlJQeDVLU1JWWTF0TktrcDhXcmNNU0RmSWRSeVpl?=
 =?utf-8?B?eTZxN1l3bDA2aTVPTWhDVWFtTzd1SDlOOXY5cGhCbTAycURkRityMjRxR01F?=
 =?utf-8?B?TDVYOGJKc2FkekFZVGJwZFdqT3d5cGw1RHNWMGF4cFFCUm9kTHR0UnJYanJ5?=
 =?utf-8?B?NzNCdTBkb25TTWExV2hnOHVpcmhzMlF6NVg5UFg4OFFRQXBnRU5wd01OMzhX?=
 =?utf-8?B?UjU2a2NESStlL1E1ZXhkelNPOU5YRlRteVkxTzR2YXljUG55MW51eHBaYXhK?=
 =?utf-8?B?TjFORHcwZWZVemYyT01PQVI5MDJuZVdMazE4NVc5ZjFhOFluVGZCYlpkTDRQ?=
 =?utf-8?B?S0VHVDZ2ZGovSk5YdHBINjhDVmt5WFBjS1pUL3ZEb253WUpUMUNDSXJINHZU?=
 =?utf-8?B?Q1VsSm5xTWV2Sk1wM3pTY1RoSVZHQnVWM043clE3WEFhSXJTYzd3SFlrVmpY?=
 =?utf-8?B?TDhZd1lpVmk4YXU4TmlOS0RnMVZZZU9lUll1Yk1lSmI0K1NkRjRPY09SdWgv?=
 =?utf-8?B?N3hnTnppR1NCclBuUm42S0dXUlp0RFRsTFVFblQxOU9tUEZCNC9qOXJWUzRl?=
 =?utf-8?B?UVhEUTFTbXFGQlR4RjRFcFA5Nkw5TUdSUVBMTk5Fc3MvbWdtMTJoYW1sOG9h?=
 =?utf-8?B?Y1JqV053b2ltaWcvMTNFL0RCdmxvTTRKT1lWL0wyM281ZUdsOEwwQWJhQUta?=
 =?utf-8?B?d2xWU3M1THNRNTNRU1hYdXpnc251TWwvT1NGL1hncUlUU0krbmhKN2tBalp3?=
 =?utf-8?B?bGdHVzZrQkUxTmJVSitJSjVGTDhBQTdWcEhvb1VnQXZZUmtVV0tlN2FWMGUr?=
 =?utf-8?B?UUV6eUR5Y1JUTzdkenhIKzEwU3VORHZSYThqYzFQbHhTOER1S09FclE3U2Yx?=
 =?utf-8?B?bUxpcXl6L2FUamNESEQrcFlDY1lEYndlWXBZZlE5aXhLMTFuOTRSQW45UWZR?=
 =?utf-8?B?Q3h5SUVYSktvYWVsZlM2RjhJWmRoSnA3MFdEcUEwTllTdWZ3S2dZelA0eU53?=
 =?utf-8?B?L2FzVVFDSzVPY3NVM25SOGRyT3NyV2loSkNDRGpOa0FOWXNCczhMMTI3eXBG?=
 =?utf-8?B?a0ZOMUNCWE1UTElBQXg2UDJ0dk0wcXB3V2lhbi9sVGtsUVFRSGdEU05WeDhU?=
 =?utf-8?B?R3ZIZmpqZ3RZQkZuTUc2WlptQnVYMHExMzhPaGFiZVByM2d4UTJUU3lVNzRu?=
 =?utf-8?B?OEJTUUxPd1ROTG50N1I3VC9iT3Vhc1hNSDdPQkFjYndINkhkREFLSm9WWUpG?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e62a926-db13-4e61-38ea-08dd474c617f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 07:52:33.8639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQjBx7yV2JeLG5IUK4mGF2Imo6f2OvKo3XRw/8phMWHvuMrEYVy9OoS0Pdq8N7aD9/h2LAI6WEhdjX9vxJWHeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7123
X-OriginatorOrg: intel.com

On 31/01/25 04:54, Jaehoon Chung wrote:
> dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
> lines of code. This allow us to reuse code depending on voltage.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Subject would be better with:

	sdhci-of_dwcmshc -> sdhci-of-dwcmshc

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog V3:
> - Remove unnecessary condition
> - Check rxsel value instead of checking entire condition
> Changelog V2:
> - Add more conditions to clarify if it's MMC_SIGNAL_VOLTAGE_180
> - Order the local variable according to Adrian's comment
> - Use local variable to make more readable
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++-----------------------
>  1 file changed, 15 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 7ea3da45db32..09b9ab15e499 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -328,12 +328,17 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	sdhci_request(mmc, mrq);
>  }
>  
> -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
> +static void dwcmshc_phy_init(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 rxsel = PHY_PAD_RXSEL_3V3;
>  	u32 val;
>  
> +	if (priv->flags & FLAG_IO_FIXED_1V8 ||
> +		host->mmc->ios.timing & MMC_SIGNAL_VOLTAGE_180)
> +		rxsel = PHY_PAD_RXSEL_1V8;
> +
>  	/* deassert phy reset & set tx drive strength */
>  	val = PHY_CNFG_RSTN_DEASSERT;
>  	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> @@ -353,7 +358,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>  	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
>  
>  	/* configure phy pads */
> -	val = PHY_PAD_RXSEL_1V8;
> +	val = rxsel;
>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> @@ -365,65 +370,22 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>  	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
>  
> -	val = PHY_PAD_RXSEL_1V8;
> +	val = rxsel;
>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>  	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
>  
>  	/* enable data strobe mode */
> -	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
> -		     PHY_DLLDL_CNFG_R);
> -
> -	/* enable phy dll */
> -	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> -}
> -
> -static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
> -{
> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> -	u32 val;
> -
> -	/* deassert phy reset & set tx drive strength */
> -	val = PHY_CNFG_RSTN_DEASSERT;
> -	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
> -	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
> -	sdhci_writel(host, val, PHY_CNFG_R);
> -
> -	/* disable delay line */
> -	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> -
> -	/* set delay line */
> -	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
> -	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
> -
> -	/* enable delay lane */
> -	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> -	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
> -	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> +	if (rxsel == PHY_PAD_RXSEL_1V8) {
> +		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
>  
> -	/* configure phy pads */
> -	val = PHY_PAD_RXSEL_3V3;
> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> -	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> -	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> -
> -	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> -
> -	val = PHY_PAD_RXSEL_3V3;
> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
> -	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
> +	}
>  
>  	/* enable phy dll */
>  	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +
>  }
>  
>  static void th1520_sdhci_set_phy(struct sdhci_host *host)
> @@ -433,11 +395,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
>  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>  	u16 emmc_ctrl;
>  
> -	/* Before power on, set PHY configs */
> -	if (priv->flags & FLAG_IO_FIXED_1V8)
> -		dwcmshc_phy_1_8v_init(host);
> -	else
> -		dwcmshc_phy_3_3v_init(host);
> +	dwcmshc_phy_init(host);
>  
>  	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
>  		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> @@ -1163,7 +1121,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
>  	.get_max_clock		= dwcmshc_get_max_clock,
>  	.reset			= th1520_sdhci_reset,
>  	.adma_write_desc	= dwcmshc_adma_write_desc,
> -	.voltage_switch		= dwcmshc_phy_1_8v_init,
> +	.voltage_switch		= dwcmshc_phy_init,
>  	.platform_execute_tuning = th1520_execute_tuning,
>  };
>  

