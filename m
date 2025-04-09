Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80DB1DE4E5;
	Wed,  9 Apr 2025 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744176980; cv=fail; b=DIcro6nLlM4fPiLvdxTCM2LKSh5rE+N7ErlKAm8l2sNQalgOy+4TjN/17REeshih4GP4Ffp444HY02yez5vBke7yvvahbGmreWyPykWmI5v/o9SQlLykH77mnxNO5hPH7Cn8rB9rGvkRz1x519JySMYXtRPUoPuX2wCGjKhT5F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744176980; c=relaxed/simple;
	bh=VnEUf+FhXX9ey4ODXNvoHC1+Ak0nlHu+vyLERKIEflI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kW6fYitVqEZlW7PR/FWieNHQnUBEommN1/N+EomUGa4ZrpPMVhaiJRJvlVmNSOitAXi4wWs/tyJWpy3YwSCNKV3WPef8aElFSN3Yv8/G5GXhLb1KQKWs6/sXHe6Kx96+1Smxdj1mjMPkfFBMt1hgcp4U2CxUHdyHgXE4OllxREg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9Tla2sW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9Tla2sW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744176979; x=1775712979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VnEUf+FhXX9ey4ODXNvoHC1+Ak0nlHu+vyLERKIEflI=;
  b=D9Tla2sWwlIFGQNP+TjVnryUnvbkSS+pP1MEVDnuRzSi5K9e1PAhLp2d
   bakqvM6i6buasQSWChof/1ZLP1JVhfTMrSG7av8ncsW/Y4eyVAbty0a/D
   2KwqmMcS6FzTP059BEeQqU89RvSw6X/KMvBkab48BuKNqcykZhAgULoaR
   l91nr8xiRjz8Y/onABEFb6rCUEEDQ+sKzk+LsPgrROk5EYRK2kHrKyU9T
   wFKGIGpZI6+4RqD59r+J8D2HYqxc9mNNwyjemKs5RFVhTT7Ti/gIWgXro
   p6lBx+iX+aXKHGPEG4K6PrTHIChegb8ZGkQD+AOeMuMNBZR5b0wzMk6HK
   A==;
X-CSE-ConnectionGUID: Ff94Mcy3S2O+PFPjRJ2/5w==
X-CSE-MsgGUID: 8d61+uaWSwmpW2QvDZNyvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49478006"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="49478006"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:36:18 -0700
X-CSE-ConnectionGUID: xbf6mbQNRrCtw0s0jMPkjw==
X-CSE-MsgGUID: zyRlpK1kQsSW94aF2vGWAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="129427380"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 22:36:17 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 22:36:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 22:36:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 22:35:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlUSXkdrhfDL/a6G5cdkmKBBAdbEDJ30dMlNkbVFOsid4fUVFsBakJtETzOP5eNqwm5GhuCeduVPdvvbdoQNh7ugUMVgbSam2n8uMpeAIo/f5aXUH+M54RyMiJIkEf7bDMhbPqU46ZW1+HwQsq32gsurfrIFJPZd5GEwjjMHnAMvzRy5gEUUD0Z2PnZlGJsfAMhehuaen8/gc8ET6MkYwz/V/1SrjzJgmj2NpazqZFB3tzVHPYFdVHuzdi5+e53eO2vxOHLJ22cz4hdpn61rWTfSJHhsrOe2BhVkghKpvY0zPGe0I6VqgRBU/jWd5QCp+Iq+UsBOihvzBCrPRV5xCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+csfxrxVm4HuIT7S5HVyaEDcgCRyMhLE+g5QRaz+kw=;
 b=Mb0i+ZwTK4+2ZgMDKqpzuceJljRNuz3veJL1EF6V0TGfAGOSUtvrvW9MiSqIzFEbEbsWHxeHmbredKbM4ddiyKgc3DELoYwfzU9zHCH661uS6gDfg245O8Dbd+9giuw4tffDfbWNRnqYijdO5a8awgI9SR5BeZl3X9k8HycRgg2PFQwbvGcDspHD6mNhq3tojM8JseNKfxnwQSFYJzY4hsqOodYxs4EVsxBPBvBaO/3aVFuK1X51l+G2VebPH8VTZNIGWGm48B1sU9LUu58q6tW2hKCauVJWt94vPxAiK488gIXUBIw4pFvVpxH3fhlPHm+hrjhmI8HtDS8CO/SxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by DS7PR11MB8805.namprd11.prod.outlook.com (2603:10b6:8:254::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 05:35:11 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%3]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 05:35:09 +0000
Message-ID: <6ac3472f-13d4-4637-8a13-f8b98a90c3e4@intel.com>
Date: Wed, 9 Apr 2025 08:35:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: host: sdhci-esdhc-imx: save tuning value for the
 card which keep power in suspend
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <frank.li@nxp.com>, <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
	<kernel@pengutronix.de>, <festevam@gmail.com>, <imx@lists.linux.dev>,
	<linux-mmc@vger.kernel.org>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250328112517.2624806-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250328112517.2624806-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0046.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::11) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|DS7PR11MB8805:EE_
X-MS-Office365-Filtering-Correlation-Id: 159e9519-f5de-4a16-363e-08dd77284a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnNkRVZPd0tyOUxGVUR2VDJqSXo5UjJLOWc2MTNwQ0ZKRHhLRmhEeFhBVWYv?=
 =?utf-8?B?TWdhYmpLYzVleGNiNGJrYWhldm11K0V4NSsyNi9YRmt4cXpFWk1NVlBUTjMw?=
 =?utf-8?B?SnUzSEh2dHlFd3F2T0RvcjJFczg4Yjk0eDVFeE5IMjlPanV6Q0oxTkxtYTAx?=
 =?utf-8?B?MHQ4aHBPWTZUZ2RKQWJYazRZY05ZSWRtNGhDWWhYYkhYNE12SXNHRDVWZUpD?=
 =?utf-8?B?bFIxcy95VUZjckU5UGx1R1ZTa0ptdExudk8xZDl2c0hzLzZUWVh2WWxwb01p?=
 =?utf-8?B?WWtQL1RNOTlsUldZTG41VzZnM1c2ZERianRXaWg2R1VrbTcyVnZYRWZzNVNw?=
 =?utf-8?B?N21Zc29XL0lWV1B4NjNzRjZKdC9vdkFYb2JwTmlFZk9WS3ZadHVjemRMRDZz?=
 =?utf-8?B?ZTZST0tGcEd5UG9PajFyaldpTGpweVMzR0JOOWw0YU42eEpLK09BTHdTbVFE?=
 =?utf-8?B?RmsyQnRZM2Q4N3dyMHFMTk9WVnNlaUVKblZmUHhkN1RYQTRJNFhhenJUcFA3?=
 =?utf-8?B?Yk05RUVDMmRsV1dxUlRKbUNFUzhDME4xak9MWHFsSEcvYVRIdFFVZE5pU3hY?=
 =?utf-8?B?UExJdjlLcEE4a3YrcTQzTXpnaEdRWTFRbFE3eDlEWkdDT0hiNldUbTJiOG5p?=
 =?utf-8?B?UVZ2Rk5VY2lNdFBBeHdFTko3aDVBZlUxdWpDLzBZeFp0Rlk5Y1R0NFJUZUl4?=
 =?utf-8?B?UXRLeGxkMmtMQkl3WXJqaGl3SmxydFNpUE11T1ptcGhoTU53MHZVQzJSOXlI?=
 =?utf-8?B?cWFiSmxsOU5uZ0hKYlYxUUpzNmo3MzJUSXNtczhPNVowb0NwZEljOWVtQndm?=
 =?utf-8?B?UHdXRlp3RGUraDFSdkFjRU8xRVlrdnU2djFScmduazBYYTFoQXgrSGVFQlFk?=
 =?utf-8?B?cjZOR0lTSG9aNWY2alo3OUJkcGNlTWJUaFFjMHhyNmJTbmVBTkVsV0NUL2hK?=
 =?utf-8?B?TStlSHk4Z2ZGYjh4TW1mc0RYSGF3aHU1cDZ5eEcwaFg3TlVsQlJ3Ym1ib05R?=
 =?utf-8?B?VURFUG02MVhmN28wTVVBM05Wd3BMd0pRZEpTQjhiaWhiZU9jVEVFZTliMlZZ?=
 =?utf-8?B?bjIwVmlPSlBHNmwvc2RYYjNoTlMrVk9TeFZYR2pWT3dpUFdFVTZqdWpqdElK?=
 =?utf-8?B?dHVPeVBobFZWK0M4aG5MbzhUMllodFl0NkoyVEN0N243OTJpcEk1UlROalI4?=
 =?utf-8?B?emRGUXIzeUNLOTNFSkJWd29YazMrd1phckZwNEp4VWJRRDU5NUMyTU91Y3Bh?=
 =?utf-8?B?d0VYTXBDNWRGelA1eUNmYlVPVzZxaWgxNnZNMW14NFluZlU2VVF1Z3g3QUNV?=
 =?utf-8?B?OGQ1L0x2QjUzdDIxSlovZWxBcjN2aEhZN0Q1akpMcEJXMzNJMkpMUkxtdHBS?=
 =?utf-8?B?Uzk5QVd4cnpCSE5QOURVUkhoYnQyaGYwYzZiV0RYaVhPcmRvOCt6Wk9GakE0?=
 =?utf-8?B?Q1B1OEhSaXBCSm9IYTlnSTJnOXpxbldZUUErb1AxVnhneEIvWU5iR1dnSGpq?=
 =?utf-8?B?UUNOU1JWSWdlRkd2dkhVYWp2WlJQTXhhTmxkL3pWT1JlV0V0TkIraVQyMmJ4?=
 =?utf-8?B?UGtOazl6ZW9wR1p2V0Z3UmxCNW91a1A1UjFxaWNmZ0ZMTzhtSzg0YlcvSnZ0?=
 =?utf-8?B?SHROVWJvWTFGaXk5ckhid3dQUGsrbE10dTRmcGFaSk1vL1NRM1A4RlFmbVdm?=
 =?utf-8?Q?IBVLWnKEzppwWv9HOZ/V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JtRFRQanZIY0QvVE41U2lSUkJEdzBVYTJnN2dHQUs0RE1OWjFRNUJUU3Mv?=
 =?utf-8?B?SnFOMEhsRDhwSlBaN3NpNERmU09qNkxDR1NVRjNOVDlSRytBU1E3MGNUcDll?=
 =?utf-8?B?VG8vcmRXMHFQTVUycGs5TEJZV2NoNHFEOHNlbEFmdENKSHRHbkNBMzAzcTFC?=
 =?utf-8?B?REVUb29OaDhNL2hqUHNpVUdubGhBR3VPT3JzZklnSTNBbFJqL21DaTA5Rkp5?=
 =?utf-8?B?RVdNNXBZU2cyWHZFYjFUMmZKVzhoemtaY0o4bjJhOHhyQ1pOdnB1dStnWVRa?=
 =?utf-8?B?NkVUQUZJWktqbTlSbTJDenY4eWFsbHJ5d3E2dWhOQk1ZN0lUOCtiVEZwak1K?=
 =?utf-8?B?a3Jnd1M5ZnFQVk9PWmFUOHpldzFnMnJXVGNNcEdUd0NTYWRTZnZ0Vm1JSVdw?=
 =?utf-8?B?b2FyaytBeVljSFAzVElHT0hYR1VSQWY2b21TeDFQZlZZcHIrWWtCQWpHWnlW?=
 =?utf-8?B?OGFDdlpZTVR4S0Z5MkI2S1l6WHdBSXVuSkNuSm5NMlpGa1RHVFdTZFFjQkZN?=
 =?utf-8?B?QWNYOW0xaTlGZFhIQjI5Q2tIWVNFMG8yTk9rMXMrcTZhVUNuVzhUd2JKMnlo?=
 =?utf-8?B?NmRTUExpWXRQSGlsVEpmcWQvWmRPb2Q5VDhZUEtRUlhpdDV2RW1tRjdLbkJK?=
 =?utf-8?B?cmxNUWJnd2JUcExPbTlZbWowYTIrekptL0NmNzJnR2dTTU5aeHFhRFZhaHhY?=
 =?utf-8?B?MXdhREdmcEUzbFhncXVTNzk4WXFVRzNuWkVuYjNJbjNDQUIxMytUWEpPVXA0?=
 =?utf-8?B?YTFaNUZVYjhpRm80ZlQxalY5bUIvV0hIejhCTFlEcDN4U2MyQlprbDlIMitT?=
 =?utf-8?B?OHVyVGRYVmdQQ0pJRVFjQlpKczYvMkRaTDhNOVdvQktyakpCWVphZFFjRXI4?=
 =?utf-8?B?Tm5jYk9vd2lFd1cxUi8xdWgyQ3hPU3FSZmhxL1NnZXdmWHliQTBxc1VudU5h?=
 =?utf-8?B?aDc5Q1lqQTNCUFc1Rm9Zb2FFNG81SmF6cDVWMHB3MTdsRTVuM3RaSENyK2Jt?=
 =?utf-8?B?SGNub3B3cG4wRTZjQTZ1d1BDT1JSbEZtYU9kQmdNSUh1NlBzQUZzMTl5clFw?=
 =?utf-8?B?M0F1L0J3b0pBUnVxR3VqNnFBcytGaXFGQjNlRVBNVGcxRDdObE9WZ3d3VmdD?=
 =?utf-8?B?Y1BKRVQ0bitoRjNuSVZWakxLcWdIU3hPSkpCSk54aXBPdlJGcGdFWlBCQlVq?=
 =?utf-8?B?ejRzemtTS0VqVUMwLytWVWJET255S0xhV2xCbUFnam9KU1BFUmlYYXRmRWJa?=
 =?utf-8?B?RXI4VEpDSzRNNjkwWktQcFRUazJtcko2Mm5WU3UySzM2UkRZTEVoM2tQOXNP?=
 =?utf-8?B?YmZneDcwbjU5WStGWnFiM2Fud2R6WUNpN2lBM3cxbnBmenhhMGMrVnN4eXE1?=
 =?utf-8?B?ZVZiM0IzbUNGa01LamdjRHhtcGJjRUs0Vy96SUd5b2FSejdJTzlTZExzQjRX?=
 =?utf-8?B?eThBRmdxc0tUQ1VxOE1DRkZmcHdSNGQ3aHB6WDA5RFp4SFNIUHNqYzA2dDU0?=
 =?utf-8?B?bk94aENhNDlmUTZ2dlNvV2dQRjh3blBsYTBWVHlmbU1aczUyVnN5Sk0yRHU1?=
 =?utf-8?B?QjQ4THlFQ2RkQnpKZmxCY1VWN09aeXdMelRBTVVGQis5dWJXM1h4VEF2L0Jy?=
 =?utf-8?B?b3FoL24ySWdodTV3STZ1cjk0SEZ1dXBDMS9RaDBLa0tBN2JIY21XNktORTRx?=
 =?utf-8?B?N1UwU29CSDNrd1FZY3hJWHY1ckpVNnJwVy82NUNrTDVBOVRhTDhyaTB6YytN?=
 =?utf-8?B?YlRydnhvSzQ5a3lxdFFubi9vdnZVNGZCU2l0K3ltSS9VTW15V0V5ZS85MFU4?=
 =?utf-8?B?OEh4bmM4S2FsZktoTWZkV3gwd2p2STYxMEpBYkVZd21xSFNXNXZxU0dDM1FC?=
 =?utf-8?B?K3p6dDNKVU1keWdldjBxb3A4TEM3OVR2NmhnTEVudXRKd3ZlOEM0a2tTcm5j?=
 =?utf-8?B?OVBFTVg1RjVLdFFrclN5SVllbU5ZbW9MT09MeEJ1QllnVFJoVnR1akg2bUxY?=
 =?utf-8?B?ejljZnR5N3c3RlJXME5Qbk03U2Q0VUdxSyttbmhUME04ZDlyN3NvN2twalVB?=
 =?utf-8?B?NXJ5QzlPYWg3WVdyZ01CY1o2MjNNS1c2MEF3RC93QUpBbVRya0t5QThYWkxr?=
 =?utf-8?B?aUJvZ1hzbnIxc1B0RjJmOFp3OVEyQjhSaVZIUStwSXBwRWgrNWtvQ3pwT016?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 159e9519-f5de-4a16-363e-08dd77284a8f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 05:35:09.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S51CbZmBNSc5wFT2z5co7g9zfMggdvzx7yUnjt+fOyPfabJkaI/uWtZINZK1FepH1fJZgnSgRAoSz0EiQ9YmpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8805
X-OriginatorOrg: intel.com

On 28/03/25 13:25, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> For SoCs like i.MX6UL(L/Z) and i.MX7D, USDHC powers off completely during
> system power management (PM), causing the internal tuning status to be
> lost. To address this, save the tuning value when system suspend and
> restore it for any command issued after system resume when re-tuning is
> held.
> 
> A typical case involves SDIO WiFi devices with the MMC_PM_KEEP_POWER and
> MMC_PM_WAKE_SDIO_IRQ flag, which retain power during system PM. To
> conserve power, WiFi switches to 1-bit mode and restores 4-bit mode upon
> resume. As per the specification, tuning commands are not supported in
> 1-bit mode. When sending CMD52 to restore 4-bit mode, re-tuning must be
> held. However, CMD52 still requires a correct sample point to avoid CRC
> errors, necessitating preservation of the previous tuning value.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v1->v2:
>  * Used GENMASK/FIELD_GET/FIELD_PREP macro
>  * Added check MMC_PM_WAKE_SDIO_IRQ for save/restore tuning value
>  * Fixed typo and tune commit message
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 88 +++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ff78a7c6a04c..7e8addaed697 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -81,6 +81,8 @@
>  #define  ESDHC_TUNE_CTRL_STEP		1
>  #define  ESDHC_TUNE_CTRL_MIN		0
>  #define  ESDHC_TUNE_CTRL_MAX		((1 << 7) - 1)
> +#define  ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK	GENMASK(30, 24)
> +#define  ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK	GENMASK(14, 8)
>  
>  /* strobe dll register */
>  #define ESDHC_STROBE_DLL_CTRL		0x70
> @@ -235,6 +237,7 @@ struct esdhc_platform_data {
>  	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
>  	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
>  	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
> +	unsigned int saved_tuning_delay_cell;	/* save the value of tuning delay cell */
>  };
>  
>  struct esdhc_soc_data {
> @@ -1057,7 +1060,7 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> -	u32 ctrl;
> +	u32 ctrl, tuning_ctrl;
>  	int ret;
>  
>  	/* Reset the tuning circuit */
> @@ -1071,6 +1074,16 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
> +			/*
> +			 * enable the std tuning just in case it cleared in
> +			 * sdhc_esdhc_tuning_restore.
> +			 */
> +			tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> +			if (!(tuning_ctrl & ESDHC_STD_TUNING_EN)) {
> +				tuning_ctrl |= ESDHC_STD_TUNING_EN;
> +				writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
> +			}
> +
>  			ctrl = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
>  			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>  			ctrl &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> @@ -1149,7 +1162,8 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>  	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
>  			ESDHC_MIX_CTRL_FBCLK_SEL;
>  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
> -	writel(val << 8, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +	writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
> +	       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  	dev_dbg(mmc_dev(host->mmc),
>  		"tuning with delay 0x%x ESDHC_TUNE_CTRL_STATUS 0x%x\n",
>  			val, readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS));
> @@ -1569,6 +1583,57 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>  	}
>  }
>  
> +static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	/*
> +	 * SD/eMMC do not need this tuning save because it will re-init
> +	 * after system resume back.
> +	 * Here save the tuning delay value for SDIO device since it may
> +	 * keep power during system PM. And for usdhc, only SDR50 and
> +	 * SDR104 mode for SDIO device need to do tuning, and need to
> +	 * save/restore.
> +	 */
> +	if (host->timing == MMC_TIMING_UHS_SDR50 ||
> +	    host->timing == MMC_TIMING_UHS_SDR104) {
> +		reg = readl(host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +		reg = FIELD_GET(ESDHC_TUNE_CTRL_STATUS_TAP_SEL_PRE_MASK, reg);
> +		imx_data->boarddata.saved_tuning_delay_cell = reg;
> +	}
> +}
> +
> +static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
> +	u32 reg;
> +
> +	if (host->timing == MMC_TIMING_UHS_SDR50 ||
> +	    host->timing == MMC_TIMING_UHS_SDR104) {
> +		/*
> +		 * restore the tuning delay value actually is a
> +		 * manual tuning method, so clear the standard
> +		 * tuning enable bit here. Will set back this
> +		 * ESDHC_STD_TUNING_EN in esdhc_reset_tuning()
> +		 * when trigger re-tuning.
> +		 */
> +		reg = readl(host->ioaddr + ESDHC_TUNING_CTRL);
> +		reg &= ~ESDHC_STD_TUNING_EN;
> +		writel(reg, host->ioaddr + ESDHC_TUNING_CTRL);
> +
> +		reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
> +		reg |= ESDHC_MIX_CTRL_SMPCLK_SEL | ESDHC_MIX_CTRL_FBCLK_SEL;
> +		writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
> +
> +		writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK,
> +				  imx_data->boarddata.saved_tuning_delay_cell),
> +		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> +	}
> +}
> +
>  static void esdhc_cqe_enable(struct mmc_host *mmc)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> @@ -1900,6 +1965,15 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> +	/*
> +	 * For the device need to keep power during system PM, need
> +	 * to save the tuning delay value just in case the usdhc
> +	 * lost power during system PM.
> +	 */
> +	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> +	    esdhc_is_usdhc(imx_data))
> +		sdhc_esdhc_tuning_save(host);
> +
>  	ret = sdhci_suspend_host(host);
>  	if (ret)
>  		return ret;
> @@ -1916,6 +1990,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
>  static int sdhci_esdhc_resume(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
>  	ret = pinctrl_pm_select_default_state(dev);
> @@ -1929,6 +2005,14 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * restore the saved tuning delay value for the device which keep
> +	 * power during system PM.
> +	 */
> +	if (mmc_card_keep_power(host->mmc) && mmc_card_wake_sdio_irq(host->mmc) &&
> +	    esdhc_is_usdhc(imx_data))
> +		sdhc_esdhc_tuning_restore(host);
> +
>  	if (host->mmc->caps2 & MMC_CAP2_CQE)
>  		ret = cqhci_resume(host->mmc);
>  

