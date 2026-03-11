Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6C3C6A4B;
	Wed, 11 Mar 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773220117; cv=fail; b=o5wrY9QnCqdm9K8rTInin22LDlvKa4MjNzqhT71XY+jmhz+mF0znwtsadLL57cfKVeqQhKVXTZUuwj6NvBD5t2niUHnMmIc3eSx8Q7EkKaJZ3iaeBl2rGyW/JPmYQcMCD8o5Po/xhURYTqWvYS1ADpBhtAg1srULEAvHBI3O2XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773220117; c=relaxed/simple;
	bh=X8G2cGcufmvCldP86k11lPeazo69fzV9LYUW6LqibuY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mT094EmKPzrZU1mWpmBLIF6RMblal9OuoqUzCn+0AxDWPyjIdCVHYV8wPBr4K863Hh9uuhBkEV4UJ1iqR4IGcwJNB6E8E6I+682cc4odVVq4VzpT6rpv80fM1LVydUNEAcauyqyAm1adBcrBShwwp5nxeNg4wE9D5Kdnnnfrid8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGJPHDYl; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGJPHDYl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773220109; x=1804756109;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X8G2cGcufmvCldP86k11lPeazo69fzV9LYUW6LqibuY=;
  b=SGJPHDYl397fH5YuJNQoYXfphgqstrcWz9EE6YwLdcst944F+4aKJl3D
   +rHaO7FwdQU1GAsWeAGpYNORrNSoq96nB2BF89xC/7DEoOUon0xtF5Acf
   Q2xbzfmiVUYegAOiB1YAupihLj5KbrvVInsMOeWLtey6Aaiv6Fb/aRaHB
   KL4avkB9KAbkYjLtcyJjCAF3Xez7TspoWqnT1FWM7HOXrL4bciQtC5cOX
   j+czQc3xcJvprlTfbujmmv+iGOUrgE3WRQy/YqJuJsuyIiZLM0wg/9d1x
   t5dpnTv2mfkDmevUtZe7VfJjrQlWH8tpOiDtdUMTsqYPBvBxQWgooSQMa
   Q==;
X-CSE-ConnectionGUID: TRKVHLz9Q8SyqLuz5cXQsw==
X-CSE-MsgGUID: 7GQgpF/CRhG454E+WrfFQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74402108"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74402108"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:08:28 -0700
X-CSE-ConnectionGUID: 3/gZCL1vR0G4aWYx4VzDAg==
X-CSE-MsgGUID: ztU+VjsWQpOpcIP5eC6qEg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:08:28 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:08:27 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 02:08:27 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 02:08:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMtPM+h6d4UAhVohtGHCCi0ydoKZ7gp/Or4/JEE3Q+KXqq8k0IP//kTVaOhsb2HGZeB9Dlj0Pw4X7xND5jZQNCsOTIZJsW0qWM2GRYIqcyWMXCV0Oxk3LhCet0mjB8nfz14rRbK7O1jZck/ruaS+h4eLCkeKmBoZe6VRvV6Ec+kvXb6As6ZkxtelCBS2gZkqEi6oV5Ngwfmk+soZl02uovlJoJuU6bH52w1vXcGJt8JhhIg6v1sYLr0r9U1ZKIP+X8FJ44Mylwl/wkuBf5WUtzYDBXd7e8VVdWi8lyoZ0n5XL7izQczjFb1xPQUzR5wYTvUbZdtfavZ6PoTxOeGElg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n1LMSeIcc4uGsTkQPWcoKQCUkeaP4HA1YxrVOESZrE=;
 b=k1YtgkXDRPBIwHAHkdE6xemlnsOyq5QfRfoR3dH5x+ZSa59hRl4wkYzvrDUf8WA8MQuPqxGi0x7L3mc6D/AkslOLo090iyhmQtbfyCp5bj6g0r+WUECNwuGloUQymop6dPXeCOHGJBSXX8qcjXobZSQ4uL4B16I6G7RKLVc65l8eD9okXJft0LE0c6USOJSVnhPo9lsSYV17/pXFaDTtxBEXllxsTgzXj9OiKLMRa+nmABIj1owbB9Lj43Isbn504AboSi1Uq/pGyQi1hC+toOPI46G4/Q5kXNBlq3BYrCrxwouIDjLluB21y0I7sA0q0VCGg1wQtO+/Z47cJBgszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH0PR11MB5189.namprd11.prod.outlook.com (2603:10b6:510:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 09:08:19 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:08:19 +0000
Message-ID: <cd166dca-91bd-405a-af35-254c097bc0fe@intel.com>
Date: Wed, 11 Mar 2026 11:08:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci-pltfm: remove duplicate DTS property
 parsing
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <Frank.Li@nxp.com>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20260303105006.989339-1-ziniu.wang_1@nxp.com>
 <20260303105006.989339-5-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260303105006.989339-5-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::24) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH0PR11MB5189:EE_
X-MS-Office365-Filtering-Correlation-Id: 78561529-0e44-4e20-4476-08de7f4dbd1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4+3+QI9vjixJzyr0UH2HDm49vm0xNgyIdDLzYXQJkgEecuTzeNpSo1butNM/RoltxTNZ8riDfUHsY8FUFlfPersCXiYVgtVkF2st2RecbAceQX0K+NLQufykYc6RmpKO6U2vKnBQUupieEmuFLYmRacNPrwb9cGIm2Q43RUP/wn3gWN6V3M2L2wmt/jwJXaGiFGJQ6pRPvAg30boIL9T68uENFLG1IuLec9/o0I9hLBFZW7PKxeZ9kn3BAJBoKIjq7bYKB2vlUX0oj4yXSvKV/AP38/nhAkpZV7jM6/gBarIRWApr2YjpTLOWszm9eOASDuvUxK1tnDdWIN2dFU2barcHr8D4rBufdIkqz5sgdSPo7BkRlgHCS/GjGEG2gZ5dzrLGl3d/r9J14GyNOAKPBdQeju7fTMx3VPDoiIDWG7OGl4ZRFyTRIufMNMdXJoJ5320QOjM04r1naDq9+5LPfFuFJsw4p3OSAQlpyJGl3CVOD5s4KwYA2kZ6uNsnJ0w9GhxTdniew+71UChcvcnxjDg4B3ryZxGXyDbtzOaYkEwk6e4OKF1fKnduTz1URpyad+NZDwXHKFYh6UdBQKHge5ssVbQf0BbTNEPaOSL8fkIgVbkwaSyxeYd2eiZPTxiVQD8RNWno5/1K2GOENuo4VBhfFaeK3UqZCosy4zchDPF7HlyQvur6PgatgCRKa6+e7B1sQ8FFMcuNkkvtFaj79GQgSPxjsCyZ9U6xDDsLzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHlsZ0NhdUJXblJhUnhSQzhuWWp1VVhNbHBodDVEODV0YzJQd1RMeFhOYWpy?=
 =?utf-8?B?b014RGgrS3RXTEpwTUd5QmwzbGVoNUNhSVp1Szh6TDFLMStpZDBXOTVMMmVn?=
 =?utf-8?B?TVNmNC9wVDBubVZOOU1ESERrYmRHWnIrUk5hY1dDRGZlVU1nV0NJanordHcv?=
 =?utf-8?B?cHdCOGVpRUM5WWVvcmp6RHpVWitpdzVEWEhIUUNBaWxnNnQxb2liaUJTL3Zo?=
 =?utf-8?B?YVRmTWJpdzl4YVhzanQ2OGVZaHVLcytBaEZKNUpRMWJHelRkVTBZYlZFWWRW?=
 =?utf-8?B?NHZQcDdDYnJvOEVtU2Jtam5jTW1lMTU2d3JuVHVmQ3IvRzFQdWh1ZFlhc0ZZ?=
 =?utf-8?B?Tmp0TU1HeUFwR21jWUVWTkVnUENyQTNtSzhvT296R3hIZXJwMkMwRXFtaVRx?=
 =?utf-8?B?clBlVUxveUMwUzNZZFdtV3hneWI1c3NNdis0ZDFxZmRBb2dYeitUemxiamZH?=
 =?utf-8?B?cHVudUJDZEN4aEw1UUx6a2ZxRGxpT3JHN21uQ0dMMjhHSmpSREFLb05GRVJ0?=
 =?utf-8?B?bXNEMVZOaktaVXhoam1hN0N6MUsvZkY2ZHo1Rmh6b1NlTzF4VEtVbmlKU3c5?=
 =?utf-8?B?V3VUZ3VwN3kvSW13RDZ3UU1nVEtETEVlTm95b0RMaXMzZmRLWVRyaUFML0xn?=
 =?utf-8?B?M3ltZ09NRjg4NnRDMHZ4Y1BQVi9FZUtpMGliSytjQWVnUlk5Y3pIOWcyUEZ1?=
 =?utf-8?B?QVBjVEtJc2JMV2F6ZUc3NjViaHFPKzNSOWgybVN0aDhwaUNCV3c1bTFPc1FE?=
 =?utf-8?B?YkRLU2w4cDJEVTVuSnNhaGpaazBWdUVCV3VQVzMrMjN0S3lNcjdqRXJUVWgy?=
 =?utf-8?B?ZHdTN3JUa01TS2o4ZWEzYUk3WTlkbEZRbnpIc2FZdkt2UFRMbWt5NXNad2dE?=
 =?utf-8?B?aUFCR2FzRlhhOE5YdlVIZzIza0QwVEJoa28zRXdveEVxdkdhTndXTCtjYmJ1?=
 =?utf-8?B?YnkydzJXeHJsU25CVjdrLzJuWXZ1L1VYQzlBMmVMNWc1Z0xoa0h1NmpZaTdk?=
 =?utf-8?B?ajFjMVEzVU9VV0grNy9FVUJlaWQyRGJLdWRLTGJSUDFQVEdOa1pPR1kzWWN2?=
 =?utf-8?B?TXB3cU1nQmxVNS9DdlYra0NZbWdWdGVjektyNnZIeFhiV3NUR2Vpc3VsazNv?=
 =?utf-8?B?dGh4MnhLSTU1Z2lLNnNJVFhxNlpKRUU1WGhXc2NxQ2hUQWJHMDVzTGpjZG9i?=
 =?utf-8?B?ODRXQVU1K1VjTzRKb3MyRktMcFFUaHJ3ZFlLbEJBRzNaZHlRMkw3T1dxblpv?=
 =?utf-8?B?LzdKVGpVSHRJS3dyUkNDcm55NXhjR21CbFRQYVUwM2ZSYVpqbjhqUzl1R1hE?=
 =?utf-8?B?M044RzFtZDgxRm5oNWJYWTB6ZTRhalpyWklLTkV4blJhTHZkYi9kSndLYkxh?=
 =?utf-8?B?bHBLRlBTVjBqQ1g2bzdNKy94bExKQVhpMm1DdGtZVGJPVTFEeHIyVjNDMVUy?=
 =?utf-8?B?blErMmVKUEpsL1JIcFdZeUhjaEdoWmE0cU5oN1E1WGVHVG5WQXJsdk44YU40?=
 =?utf-8?B?WndUOFBrK2lVUjBocDV2aVpRTUlUM0VycXBDQUJnYWVjcHRsTTZ3MmcyU21R?=
 =?utf-8?B?blJWK2U0RUw0RWlSclE3SEdvckFyTFNFVldqQ2lrTGZaNERNM0pRRE84SEhQ?=
 =?utf-8?B?OVFOM0FWcFNOREMvNEZrTTB0S0I5RjFTNnZ3R3lQbEUwM2xOaE92OGFoM3pP?=
 =?utf-8?B?TkVtVmpJdG1Rdll6M0pBNkNBNHpqSTBFOTdSdXJoU2w1Y1lZRVFLS3l4L3Nz?=
 =?utf-8?B?cGd1VVpiRS9IdkVIRko1NzZmNVFaS013dmh0VHF1ZzdjazdJLzg3QmNSbFF5?=
 =?utf-8?B?MmprNFFiVFNUZXkxM0JCZ05GZXNwN2Z1czFGeVdXZThhb1ovRUp4UGI3WVdx?=
 =?utf-8?B?NktXVVp3WnBKQXV5dEY2eDRhd3l1ZTJTaGZVaE9jVlBzY3FqeHlHaGl2MGM0?=
 =?utf-8?B?V1dGcFpwTDQ0bU9yM2crVVpMSTg4WUIwZTVMVTVqL3ZXUVZsQndNTDNNUlQv?=
 =?utf-8?B?UWNDdzhlOEo4Ni9pSllNWGNrVzBBN3ZDNzdTN1FiS29MYmpkWHdQM1RiR2Zh?=
 =?utf-8?B?dUUyY3Rld0t2SllXRVFUREJzYUluaGxtN244UDl0WW50Vy80aDhQSGhyU3A0?=
 =?utf-8?B?UFozQmNOd2JzM1ZrbWxrU2VWeVFpOWtQRjlhNjJvS1AwaTFYRVYyUnR1UWs1?=
 =?utf-8?B?c2U1L0hNZ1dzTzgwNjBreENCelpWbjZxVEFIYXVKMnlENEl5NDNUQkZwVHRE?=
 =?utf-8?B?S1NNaytSM3dDVVJVdWpOS0hTRlpmOE55SEI5UHo4WTNpbzFOaDJlakpTR2Nl?=
 =?utf-8?B?RU04OGJudjZ4alhQK3RBYUhFUEVEQXBoZ05tMDhuMGxtVlBLQ2ZZL0J3cFpi?=
 =?utf-8?Q?MVS91rwbN09ukWYQ=3D?=
X-Exchange-RoutingPolicyChecked: Q6QSvxpDQriKNJhMogO+pQL4lXn8/cG1N4SWFF5Nsk27u7fMCvR4WXgDZxSxF9V9R/WfhSpG1IrlVptIE4gmSeIweuOEQHAKa1NmgyJp8jXdOQBJotIdbCyec/iC8rtnjW+m9VIjUX0l+0YCP0DbWE28xAZOhIQutLo767+LOuq1yM8mTSpgFDaiVuz9SSbEJy9amkoQrOzIpXJrsKgDmw13SdJBGxAIosLTP/G+kzknoCm1R8SYy/JbXASlpKMg2ExM1HnnSFVhBjc+TOgfjE78sQ2eFfB53GistnVYS9uW1OxtenMy35Nbrsal+oQHOWN72bE/H8jeQc6b+ZDm7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78561529-0e44-4e20-4476-08de7f4dbd1d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 09:08:19.7720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxhjpQZ6GjaE+oepUmGt589xhqAYT+kH7Dc7GmDryIhs7WdfGhP+teM3ZAX+bKGJUuyD62JsEDAdVp5v+iIFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5189
X-OriginatorOrg: intel.com

On 03/03/2026 12:50, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> The "keep-power-in-suspend", "wakeup-source" and "enable-sdio-wakeup"
> properties are already parsed in mmc_of_parse(). All sdhci drivers that
> call sdhci_get_property() also call mmc_of_parse(). The only exception
> is sdhci-of-hlwd, which does not call mmc_of_parse(), but its devicetree
> does not use these properties anyway.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pltfm.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index d4fb60c1ef69..933fafe0a0ef 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -95,13 +95,6 @@ void sdhci_get_property(struct platform_device *pdev)
>  	sdhci_get_compatibility(pdev);
>  
>  	device_property_read_u32(dev, "clock-frequency", &pltfm_host->clock);
> -
> -	if (device_property_present(dev, "keep-power-in-suspend"))
> -		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
> -
> -	if (device_property_read_bool(dev, "wakeup-source") ||
> -	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
> -		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>  }
>  EXPORT_SYMBOL_GPL(sdhci_get_property);
>  

