Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FD408008;
	Tue, 19 May 2026 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204589; cv=fail; b=Hnc8cOFI16mjsvseut997Sn28auuZEXGmznihRVtTjQURSU25n8Uz8idySklwZYo+P6+9RwOQFQ6eI8b0o9+a5sIYd+O6bK7NtzeL9DKpjGJDjDFviUO0gHHblBbc0RythCJURw63q5pfzM3R3WAXJMzF2Ywx33RYBlSQIYdk9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204589; c=relaxed/simple;
	bh=N7JatbMGcCQnjzO7UOsMLkF88mXw9e00htaqeCObjaM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Za5iQ1CErYBMWCtnBDRrkIcpaZXNb+i/90e3tR1Gfwn5CF2CeLhymBmpU+K7oShdn8/zPkgVTbdjYdFqWuk3nV2B6j8ZN86qRUXBTJd1/0SkrBPShiDkMIXA5hLXSDsWO42EQV16KIQuHGF34oxmeqKzHblrl9rU/eUl54S5Weo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZFIzmrc; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZFIzmrc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779204587; x=1810740587;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N7JatbMGcCQnjzO7UOsMLkF88mXw9e00htaqeCObjaM=;
  b=dZFIzmrcDHKFWj8+lWlMAwh3kHWLya7EQHW+y1s4RwZBxPo7RNuIscLB
   YeTh0R1PGvtfsEqRIxEolf3cr8iYcAHdpuHKDgV4+1PQVd5YwELwqlMCE
   RGdFCJxvmRbFWJuczmUVinCC9TVEuR3PgOBgKLVdpH5OluV7/zEg5Sdz0
   MSRTjNHT29Acq1UvBgNZUZG6R9/M2zKcqDSkNPeS+CD/Mb/dnitnRD2Ut
   ZH7de81pGKKxVmPpUDrZrNzpbA1KREJBxdzmm+RF0xImSgdzwZ8rQMd2x
   DCjkM0556DIXNnL7UEvDx2Osj3vsICPFKzoRxZ2eiWrjLzURtV1mEhTVo
   g==;
X-CSE-ConnectionGUID: jENzdeeQSXGIk0aNje/JnQ==
X-CSE-MsgGUID: Dyqei50GQjyQARvo8UMWmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80116661"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80116661"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 08:29:47 -0700
X-CSE-ConnectionGUID: i4DZfA06RJugS1EVjqybPg==
X-CSE-MsgGUID: /HwdW8l0RK2LEnzbiovRwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241632591"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 08:29:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:29:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 08:29:46 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 08:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsmMG9S39z+iHGKoFz+CRyT1MUqpgqFmDRN7m9LdYnxdhRk5XkngHrBQWhigkWOjzwBMoUeX+DvqbuuJY2Qp4sBU+9bc206aRgz1pnd5C4qMIX517Fm4vYR0T8HgumEIr8ue1d3pSEfL40V/dt/SRuaxCQC79Ud6Icwig+4FQOhB7YkH4RZZKqwmNWJiL9lpZBA+F9gEe6PBmHCwoTq1YnRY3SiMnNj2LzbJtUy2oH2U7rDq8N+X1Hw3italdwp7+n8V5IXFIDD0X0Qd+PvlmGgzue283f1J7XC+HoQ5hGN+/b5ZifNurBT376XkR0npGKeUno+bYWHxFR0/UKkB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDKWPkYZeQ2rsmqteq9WD5ZpDJqZjCbkHDeEv1K/URg=;
 b=gIRfZfzIT9tTyM8cQNP4ZNAoRSfe9WeDBNbGEC8YWBsi+eJ1GgSOzxKiNysYDNL5xOVB+NrMX2hs2opGz1WBcKsxeC/HcwFsk3klNid0X68SQmF0iMD4S5s2YyfRcE2HcF/er6aIY1uVfcUbjQsG4jw8hdhzU4VE9nT5Z+Aun5o15PyLyboAOX0aEAdWdIETpIpKzpu7BtKFBMB3J1F3Tny+T/RmSRYk8favysfdsgsOEtRpNBdHiSl2p5lnyJe83AqSlCns7673t4lXWYEOwO2mN++q2+PgJFE9HZYewzYYwh/Q3jhylo6RepY8LWq08c5o0WhizN9C1sA4qjXrmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS4PPF6F32BC4DA.namprd11.prod.outlook.com (2603:10b6:f:fc02::2e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 15:29:41 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 15:29:41 +0000
Message-ID: <7e4300b6-c54c-4161-8af6-8fa1ce172dd1@intel.com>
Date: Tue, 19 May 2026 18:29:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] mmc: sdhci-cadence: rename V4 functions for V6
 controller groundwork
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-7-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260511202132.5597-7-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0234.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::25) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS4PPF6F32BC4DA:EE_
X-MS-Office365-Filtering-Correlation-Id: 638ccc2a-17c9-4f14-0a5f-08deb5bb71f6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|11063799006|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: 7nWgM54l2B5rjAuwYAc3FeUioq8gD9B8V4RtpvT/F7rVGSK1+wjPgguwnJ35kwuzNMbx8GcVpuxwNTH6gRfGMgiAlKj6B4V1+3WLAFjUCJA/uC2Yh9E5hAFi0JXQoWHFjRMsY4RhPFpGhpb7SyyCxZCUwQv6lcDQNmyaIR08DJ09yqQ6mR7mmbtgXALuG/Mk/VI07SMXXDu/Ym3bCj09f5DBSBRQ+1vvZ71vek2+OtZxl9uErigo2PDG95A/CF//PdxlEQBGbm9U6VGDfqD3fie+Pl/dREgIXg/Z23nYWRUtfMoq2byYtcFMpGBuGGRItqNqGecL3JXlDArDZs64UBFjMSFbDWvmfekAEToLYqu1hGeDRKvMVId2SRisUL5UFy4esBOdi97+7W/qv6/ONVQ9Nr8G0PLdy2UbCc2iCdPEqqFJam7s6fOPUhnndpPSycDhTTWtMko4iSVkAScujBdrbSkOVNCMLT1FvGPVIocdraC7ZMmmd/AVNipnHbCUrZs8tNHnMLjX1+eJkNkxw3zWXZNtOUFImyecX8LPhCd42p2GAlIOaEYyzIMpq9BfuL3sWoHfJqp60rRYIaE02j72onKOrZyLHW4+SiGWSVtoFSa99xOcztwB5hc/vf3NLynarZFQYltkcV0i0SGIXAyDmWd49F7f6jMob894Om0owfjunXZ3YNzDT75OeEYA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVRwc3lldnh0dEsraEJjeGlXTnFCN2xKaE9ndlU3cWxIdENJYXRxUXZ3ZnFq?=
 =?utf-8?B?ZlhxcUczV2NGTkVMOGljNE5IR2ZXZXd2eGl2bjNoejJCRWRJK0hST2VCdFNw?=
 =?utf-8?B?SE5XQ1NDcExNZDQ2dHBXUXk3OFRRMlo1b3pqai9DSXJ6OHdtR0JHamZ5ZU1K?=
 =?utf-8?B?UmNYRVFmcGxmQXlXQkFUVjdmWFNhcjhQbmNlMWRRT2ZlMnZ0S3QwZkJJd3lm?=
 =?utf-8?B?WmVQVWRyUEFFSDd6cnZwalFqVnhsKzRvVU16ZTZ2KzBkbkluOWxBaDNwQW44?=
 =?utf-8?B?YmxpTTZCb0wxSnBIQ1RyWWhlWnNpT1poMzAwK3kxaHcxTC9GaEZZNjhQQ0dI?=
 =?utf-8?B?bU80TzBLMVU3cHNyYUIzMzRZUFVpeDNpWEMzTG5sdTIrVm1HOVhXa3pRcitT?=
 =?utf-8?B?OGJwQThwSVRJWFlSQ0V4b3JldGlaa081Z1FjR2M0RUJEcDZIQkE0aEQ1VUNx?=
 =?utf-8?B?RXZwYnM4Sk5wZldzYy94amR5U1NlYzJoRk5MWnVEMEw3UVQxbThTeG5Td0hC?=
 =?utf-8?B?RHpxbXFkVFNxMkllR092dXlXSUEyamprZVRiVlBvWVV6RkV3RGtFM3ZqRit1?=
 =?utf-8?B?YWwxK3VJdjhUbVpFa0gvV0IvbTc4MGhnbEFWMFd2N2tJbjZsRklEcFBjM2FQ?=
 =?utf-8?B?Wkc0Y0RvM05LR2NZRWNrR2ZqMWlQRERyUm5hMXNXNFAvbFZaajQ4eVVmVWJs?=
 =?utf-8?B?a3VwYnFJVHpvWnZycWZ3aEpCdXVjeVZjTUpUNkhPVVdlZzJqL2xkUDZUTEtH?=
 =?utf-8?B?dDJEQklVSGxOUnVpZzVRNEZWalRKNkt5QUVGOCtSNWZQZHQvU2xZdWVDaFlk?=
 =?utf-8?B?MWJ2UUN3aUx4YVE5QjdSVEVZWlc4NWZScS8vSmNsLzVkcXdYNTRtazBYc2pX?=
 =?utf-8?B?eTRxclc1QTlzM0J2MFNvVlIxYUFlOHdEeE9FU0lmNGZlTzBJUjdGMGJoRnVy?=
 =?utf-8?B?RWlHUXdOWDcrVGt6SFBtejV1N3VhczRkeGNBc1E3UWF3SzVLVTR2RitlaFky?=
 =?utf-8?B?Tk03OEZiRFdWZC9WUlFjRjFpTlRzMDIzZncwTjV2bHIwQzNRRjZLTTY0bWpj?=
 =?utf-8?B?TERTUjhMRkhyYkN6b3JYZUtjbkEvdFNKR2VqOThxOHYxdWFGVUYwWE1yaU1j?=
 =?utf-8?B?blhmQWxKNzdVcFIySi92bVF1aURiYUF1ZnZqUVBsajR1b1NkSmJFRlNuOEFa?=
 =?utf-8?B?SjRkR3czcDFnSnZrY1cxemYvM0luL3R4NkVKczlNTnUyTEdZNUxtQWhsOHRJ?=
 =?utf-8?B?N2xabTJsbHE3T0JBWk5HcTR4NnMrMHIzWEROQWF4WEFqRlJpZGVQcjM4MHRO?=
 =?utf-8?B?U1NPZzY4Y200dGJUc2xhU3k2SStsaEVWN2F3a1lxVW5aUnVKN3pyRm1yR1pD?=
 =?utf-8?B?N1BsdjVuOWpCZ04xUDR1SEd4NE1jOERuTDJYeUZ1aStCelpkeXVRazJHazZi?=
 =?utf-8?B?V3g5emtZYUhEYjJMWmhyRkUvdUdqWElDNWQ4cnZpaG9iZ2lETmJnT3ZUWTU3?=
 =?utf-8?B?VmhuZXMwTnc5a2gzNjl2dUtRd3BpZVlDVkNSc0h3eHNZRUpYb3IyM2ZBdXRT?=
 =?utf-8?B?OXNwZ3FaelcwNGYzNTg2cmNYcTB3b3R1enFydjlFVTgrVk1qd3FnSHBteGhT?=
 =?utf-8?B?b09CUUdJRmZuNzNKdGdHMDRrSm5GcnZyY1Jzam53clZRTFJpVS9uSFJyY0Ni?=
 =?utf-8?B?SUlhVFJveWkyaWhRNVpiZGoySlBwU09zc2NNZFRYSHFxeGk0bFhaWTRhRHB0?=
 =?utf-8?B?Q1MvNGRQTkJpQndSNStaNjM3VWRPY3BwT3pUbVZoVU5palZTZWFZZWExNHFU?=
 =?utf-8?B?L3M1OXhZVVBvNG83Qmw1NGxJQTNoalNvR3R2TlgvbHc4VStnTDJHeDdvemMx?=
 =?utf-8?B?bGlGalROeGxVeVdmYXRpN0RFOXNwWlJpdEpFVEJvb25vVkkrWU5mUDhHcGVo?=
 =?utf-8?B?dEZYQkZ1WWIvVThWV0RCT1pyM2JjUzdyVlJCUi9ZWmRjTVhLT0xVZHkvMDRI?=
 =?utf-8?B?eVJrWkdGL0FCd3o4Z2t4N05zUjdTMjJhQThKNC9iaFdrcDlWWGFic1d1aFJE?=
 =?utf-8?B?Y21xcUpWTnN4RmovZks1WXNta2lmVkZGeTFKcVhpWFV4Wm1kRWNNdDVxN3hZ?=
 =?utf-8?B?bDlwSTNoMXNPZlc3VlplL2V1WW96bkJ6OUlLc2tSMHJ4T3J1NHRZVmFIcWhS?=
 =?utf-8?B?bDZ3bFhxb0tHNlJBMXF5dHFUNkVhNGJ5S2V1eHIwdFVBNEpCbnI1QVZKSGhC?=
 =?utf-8?B?RnRDenlHQWNoTllzbDFXQngvd3R2N3V0cXR2bVppdzJZblhRUE9Wc0tJNjBv?=
 =?utf-8?B?ZnpkalpQYnVmK0pmN1JhQ3pJSHZSem5hMldyZ1EyTS9IZkptTEdSRHJxeC9h?=
 =?utf-8?Q?WmA6xUrrxK2Vtdd4=3D?=
X-Exchange-RoutingPolicyChecked: PGMonAT3oFH7OjPUBrM/KkAKjkxydBERBqENKiMiehbLO41XeAyuNf7dXeUDmV+1zjtXLg6DIX5Yyjz2XZ4ImH6nyTU4IBFtW+K40fv2N5YzY6rVfMdw8ms+zfi1Dwe9J6YDSzQMgZmZZgI1rXSdQpF8oegO0PQ5QPF7Dd2PloCgTi8Wm47ZzdIUrH5+pLdsE7xspK9CV/AeB6OURCnr9hMqS8lfUPn2I5UcLQFg/ywobyrJnDTTAha5DGZrEkXG0YcpCCCq1mCzgtgPzpNA+sUaNOIIaLPravTopEf6ALFGwUcar7w0JdBMEPkIxPQNA4MWrJWQ+abWS65CgodzbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 638ccc2a-17c9-4f14-0a5f-08deb5bb71f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 15:29:41.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvWDgsWmS9rBfOF6NyJXQN7qqMyQzPS7YKzp5tjkFjM48XNqdyZMqT28YnATNsL38fKXNXo/hVgmFB/gTHGR/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com

On 11/05/2026 23:21, Tanmay Kathpalia wrote:
> PHY-related functions and data structures in the driver are not
> explicitly scoped to the SD4HC (V4) controller, making it unclear
> which code is shared and which is version-specific.
> 
> Rename them with a "cdns4" prefix to distinguish SD4HC-specific
> implementation from the shared driver core, and to avoid naming
> conflicts when SD6HC (V6) support is introduced.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

One minor comment below

> ---
>  drivers/mmc/host/sdhci-cadence.c | 74 ++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 435603c8c00b..47690a52a221 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -78,7 +78,7 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> -struct sdhci_cdns_phy_param {
> +struct sdhci_cdns4_phy_param {
>  	u8 addr;
>  	u8 data;
>  };
> @@ -91,10 +91,10 @@ struct sdhci_cdns_priv {
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
> -	struct sdhci_cdns_phy_param phy_params[];
> +	struct sdhci_cdns4_phy_param phy_params[];
>  };
>  
> -struct sdhci_cdns_phy_cfg {
> +struct sdhci_cdns4_phy_cfg {
>  	const char *property;
>  	u8 addr;
>  };
> @@ -104,7 +104,7 @@ struct sdhci_cdns_drv_data {
>  	const struct sdhci_pltfm_data pltfm_data;
>  };
>  
> -static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> +static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
>  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
>  	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> @@ -124,8 +124,8 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
>  	writel(val, reg);
>  }
>  
> -static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> -				    u8 addr, u8 data)
> +static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv,
> +				     u8 addr, u8 data)
>  {
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>  	u32 tmp;
> @@ -156,44 +156,44 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>  	return ret;
>  }
>  
> -static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
> +static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
>  {
>  	unsigned int count = 0;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
> -		if (of_property_present(np, sdhci_cdns_phy_cfgs[i].property))
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
> +		if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].property))
>  			count++;
>  
>  	return count;
>  }
>  
> -static void sdhci_cdns_phy_param_parse(struct device_node *np,
> -				       struct sdhci_cdns_priv *priv)
> +static void sdhci_cdns4_phy_param_parse(struct device_node *np,
> +					struct sdhci_cdns_priv *priv)
>  {
> -	struct sdhci_cdns_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns4_phy_param *p = priv->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
> -		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
> +		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property,
>  					   &val);
>  		if (ret)
>  			continue;
>  
> -		p->addr = sdhci_cdns_phy_cfgs[i].addr;
> +		p->addr = sdhci_cdns4_phy_cfgs[i].addr;
>  		p->data = val;
>  		p++;
>  	}
>  }
>  
> -static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>  {
>  	int ret, i;
>  
>  	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
> -					       priv->phy_params[i].data);
> +		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
> +						priv->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -201,7 +201,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
>  	return 0;
>  }
>  
> -static void *sdhci_cdns_priv(struct sdhci_host *host)
> +static void *sdhci_cdns_get_priv(struct sdhci_host *host)

Why rename this?  It seems to just create churn.

>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  
> @@ -238,7 +238,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>  
>  static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>  {
> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
>  	u32 tmp;
>  	int i, ret;
> @@ -354,7 +354,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>  static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  					 unsigned int timing)
>  {
> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>  	u32 mode;
>  
>  	switch (timing) {
> @@ -407,12 +407,12 @@ static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
>  
>  static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
>  {
> -	elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
> +	elba_priv_writel(sdhci_cdns_get_priv(host), val, host->ioaddr + reg);
>  }
>  
>  static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
>  {
> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>  	u32 shift = reg & GENMASK(1, 0);
>  	unsigned long flags;
>  	u32 byte_enables;
> @@ -426,7 +426,7 @@ static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
>  
>  static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
>  {
> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>  	u32 shift = reg & GENMASK(1, 0);
>  	unsigned long flags;
>  	u32 byte_enables;
> @@ -452,7 +452,7 @@ static const struct sdhci_ops sdhci_elba_ops = {
>  static int elba_drv_init(struct platform_device *pdev)
>  {
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>  	void __iomem *ioaddr;
>  
>  	host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA;
> @@ -470,7 +470,7 @@ static int elba_drv_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct sdhci_ops sdhci_cdns_ops = {
> +static const struct sdhci_ops sdhci_cdns4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -481,7 +481,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns4_ops,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	},
>  };
> @@ -495,14 +495,14 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
>  
>  static const struct sdhci_cdns_drv_data sdhci_eyeq_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns4_ops,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	},
>  };
>  
> -static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> +static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns4_ops,
>  	},
>  };
>  
> @@ -510,7 +510,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					     struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>  	u32 mode;
>  
>  	priv->enhanced_strobe = ios->enhanced_strobe;
> @@ -529,7 +529,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>  static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>  
>  	dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
>  
> @@ -560,9 +560,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
> -		data = &sdhci_cdns_drv_data;
> +		data = &sdhci_cdns4_drv_data;
>  
> -	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> +	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
>  	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>  				struct_size(priv, phy_params, nr_phy_params));
>  	if (IS_ERR(host))
> @@ -593,9 +593,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	sdhci_cdns_phy_param_parse(dev->of_node, priv);
> +	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = sdhci_cdns4_phy_init(priv);
>  	if (ret)
>  		return ret;
>  
> @@ -622,7 +622,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = sdhci_cdns4_phy_init(priv);
>  	if (ret)
>  		goto disable_clk;
>  

