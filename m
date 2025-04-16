Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73C1E9B06;
	Wed, 16 Apr 2025 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830733; cv=fail; b=oiLe84chEsLt01mUr8nTjdeJn9O+k2Pg+wjSUUXbcxAoqMnqubVciGdf2cEilT4RWSuhm+cVlN+QTAJ3+mcPnC/qv6HC0lvbddWsRoMuZUojkZAv9N6L2P0V10o8MsRzstlMbN5gmANauNnbtVMDooWJESNEHZdX84Q4/m5l1nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830733; c=relaxed/simple;
	bh=EqdCbeDNVmtfofQR4a/JiRanumKOq94Lp3D+ypjjbUQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DBvxqM3W8SwSTiShd+MZuCUF4aQfviL4/1EWfiKnIzT3AUBoXLU/KzLS9eOT3n6miuBeHk7F3TswlljlLdr26MHowRLh81z5Vqzsxkepnk7Ig25+tT9GvvOXFWPRFSf3i4Lz2IC9VxMquAzN4LZezLOwIxEKSOpZIpIaVu5y1Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9WxlXdq; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9WxlXdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744830731; x=1776366731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EqdCbeDNVmtfofQR4a/JiRanumKOq94Lp3D+ypjjbUQ=;
  b=B9WxlXdqY30n9R/jPRnlxOAQ9F2sZgzCzicT9742GcK7pMe8Qi6Dq5Cm
   wv2SeFefmRmp6241LKrbXVzvXEyoUa5tlRWw3Hx0nyqkydlQ/aeUJC0t+
   w+z77+70OlOY3Ij+Oao1LODKzV/zmP/nXxeXU0p++I4gE2oKoyShrXtZD
   N0j29+Rpl5gI2BjBztbxqoTPCvqlQhTlDhdeqNemx5IiGO7P4AY4Rkwht
   4FFWjt/bb5xJuYvd8Yr9kl9YfQ3Rg6jhevMtRzgPci0VYHHzBJh2U3I7X
   tkzI9ktYYUG1l6rSpfhhWC3e32YpHiFMFWRhUwexteDkS1gOeivzdBwiA
   Q==;
X-CSE-ConnectionGUID: gncMxhLRTrKuApRyW5m93g==
X-CSE-MsgGUID: cmTOrPvXRUWN7NMPVsHFlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46525546"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="46525546"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 12:12:10 -0700
X-CSE-ConnectionGUID: SXO3B53tQ2mHdcQLzMv2yg==
X-CSE-MsgGUID: Qx48n1J+Ry6+iQiMr0mT2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="130527798"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 12:12:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 12:12:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 12:12:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 12:12:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loWRvl3qF0rHKztc5tPlLIu/ojZLsoRe77Zb/Vb77OZGM5EtxZciZfQ3NJPEAfF1pt27xBhxb3Gfg6de/+hcZ9rVKZvMAwzd00cXOEf6UxzC4JFTrOgU0RtfTiO4wtRrHgsLyhwVqOfnjdxx8IeBTK8NYErtehN7ofE7uN6a3Ps5wuVdS2jh9O3Xo9Lr4rBpDl+dQ64b/uSjpFa9MiF0uto2NQPHYUVjkQxpG+jEEAKBFrRdq59eejnDuyQvjlLxB2mVvWVlurEYEUlC2mfTWh/QZD32jvk5HJWzNPFSwOOqXWrVKjfie5kZeAyfe83yh3KEyT8t9WTyzrcF5qfeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3SzA/iSPrnLNVn0VovBLmWlcn1SviRMiByVE3TsER4=;
 b=uEV0Z9Kx1dy95ZXbqsF3SYKIeI/PzEE7JzNHmA8Ua/8Vq0vYB8jTcsjrLSKRr6uc58y5IIf8EEgt5MH9l4r2+3+X7JaUgNqpSw9wJg9IsDw2DpMawHjKkp6LGbtYz+sVjmGqroVDb/LYpW/ESf8wIHgdrKX529d8SPThN8JEHK828hEzIGLvd3ARQYv3SdCZyyMO1ynevI4XfQFM/xJlWL4kg1uZKQZs6trd5iRfjpTUj0EoLSfZP3MwkTaAmbjDr4GRYgiLU2Ho5/y396DpdvqMrP7hVh6fXVdHN4xYlivvgopi8/kshw54ndhpVFcK3bQs+iSbawg7jr6ccblKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by MW3PR11MB4747.namprd11.prod.outlook.com (2603:10b6:303:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 19:12:07 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%3]) with mapi id 15.20.8606.033; Wed, 16 Apr 2025
 19:12:07 +0000
Message-ID: <da959d37-1513-4679-bb09-d08bdbe00fa8@intel.com>
Date: Wed, 16 Apr 2025 22:11:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Josua Mayer
	<josua@solid-run.com>, Moteen Shah <m-shah@ti.com>, Hiago De Franco
	<hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <3f31eded-4a7b-43f0-819f-a3be48cffc7b@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3f31eded-4a7b-43f0-819f-a3be48cffc7b@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:803:14::22) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|MW3PR11MB4747:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f6a5cc-a55f-4979-b16b-08dd7d1a948f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHlTTU00NllqM2QyemdUMHdzRC9JVm1ycXlndkZRcmo0LzY3YlA3a2dKRStq?=
 =?utf-8?B?OG5lVEgyNGMxMEFoazNVVnVHOW40ZitjR0FjM3RZMFdaKzBmRENUUURQdmx3?=
 =?utf-8?B?OXhFZ3dFLzQwNHV2eGlhMDNVMW9TUVNYWUdkbDlTT09VZmI3LzExMjBmZ2c0?=
 =?utf-8?B?Y2IvRUFKeGhtTmM5ZnZpRXRsZzBncml6K0txWDhSdFMycEFCcW9pQ2hrMmww?=
 =?utf-8?B?SnNXNUZlbUE1YytsckRXY0xYV2FQMEhoWHJpU2RTSnFwSmdGVXpoa2FnQjNo?=
 =?utf-8?B?V3FmSFdGK2kyUHhHSFJJdm9QZElSK3czMVBDblRiMmdZVUVoY0hRcWdTYktk?=
 =?utf-8?B?eDRKOFdtSE5YUWlUdnloL3NFbTFDOUxXTlZkUkRiQzY2QVJ3QW5EOVkyVTlV?=
 =?utf-8?B?Y1BRS2YwalYxeHlWVitidmhwbHpMWUhQTkh5RmlQUENRbkRiQTQ5RDV2a0N2?=
 =?utf-8?B?OVo2alF6WVNLMjRoM2JwVDQ1Q1EvVzlHSkdnTi9FYStUTmY1M3J3eG5nWjdD?=
 =?utf-8?B?M3lTYXdUSjFDNldKYkR4ZnFhVjR6aEpvWUpxNVg3eTJTT04rOWxRRVdkYWdV?=
 =?utf-8?B?blJ3NitQQUpJOWZRcVZRelVPbkt0M0dCaW1kOWVoVDN3L1pOVmw3amxUL05P?=
 =?utf-8?B?Mk45djNIQlNXekFyVlZGOXRaKzZOWkk1Umo4VDN2Mlltd00xRm9DUm5NcEVi?=
 =?utf-8?B?U1Axa0RRWUZFNVNTbE5tTXN5QjZYMVZjS1VXRmJuU1ExYUc5SXJHQUVIZlBk?=
 =?utf-8?B?T1lwdnBmNWsxZ2xRODNNYWUyOEdtaDNqQkU1eElkUUZ1dVloSit3YnJRSmZw?=
 =?utf-8?B?em1oYVBpV2pHaDN6OERNUCtJZnpsdHVVektaY0ZKd09jMkdnRzl6SElZNzVU?=
 =?utf-8?B?V3lXVWd5cENPWmpnbXFDb0dmNUM5bkVXYmdQTHdDcXJtWHdOZjcreTNSTE9R?=
 =?utf-8?B?Q0NWeG9rUDk3OHRuY2hIOG9TcnJoajBxTzFGS3JUZVBXL1hyQ0NyTjFUdWtM?=
 =?utf-8?B?Nis3ZkV3bW1jb2lSTVZtcWNMMXZ3cmxHR1NDaGsrUU50d1J3VkRoSWhBNStB?=
 =?utf-8?B?dTk5ZjVmTjZZZVo0aUd2WDc3Q3FYa2JJYlR1cnZyd0FTVTZOeEErekRHM09O?=
 =?utf-8?B?Q2RrZUZEOStPcGgza3krNTNqcXZhckRVUzR1ck0rVHFRZHROZTZCZVBDTVJP?=
 =?utf-8?B?SERSdjJna1BoWG1WLzZWVDJwdmlSVjRySzVrWHFDd0JUaDM2aEFudWV5c0Nt?=
 =?utf-8?B?bzhLWG1PWXJseVlwSWRRMDByUno0MUI1aXltK2pxSjcySnJLWkE3eWlzY0pl?=
 =?utf-8?B?alBSai9yQXduR2JtQlhHbkxUbzVoaVNZU0UwZzJmRk4yeHR5MWJVTkQ3MTVK?=
 =?utf-8?B?N2hoRGlZaFB5L2xDKzloRkNGYzVrVnNaNWhtNUlyckdFUUgxVGExUTJIWmVI?=
 =?utf-8?B?cHZ5Tk1kRExSZHRoREFDaXBIWno4c1NNTkxCazIxS0JtcE9VTVczNzNHUlc1?=
 =?utf-8?B?cTNWQlZjNkwzSVQyUTFrcFByT0RFQmY3eVJNNkpwcG9STHdueUJ6TTF4Q0dL?=
 =?utf-8?B?blJuZStINDcvK04rcXdFckNwbk1nZHk4Rzk1NW96Z01VL3U3QkNMeG1WSFhF?=
 =?utf-8?B?VXBFanF0Y052UjNEbkFkcHAweGhySEtpNjFYazZDdUg5ZVFMcmpSTmVGd3do?=
 =?utf-8?B?SURMQzdrYWJ6NUQvL1l6bUl0b21ydTc0aFF2eHdKVDhZUXdSc1FBV0h3VVl6?=
 =?utf-8?B?VmNOMVBFWkpybnZsM2JoZTBlRjJDdFBRQlpXUlo5VWVqK3lzVXNkbDZudks0?=
 =?utf-8?B?TXN4R3hsVFY5U0VCRjNXN01XMm1jVDZQVU1iOXlGendGUGxUTGIyelpSak02?=
 =?utf-8?B?R09McEhXUnQyaEtKUHJaaS84VkdHNXhKMUJMQWExQVo2N3pZWTMrR3FEZ3dj?=
 =?utf-8?Q?BIHn8spsJuc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFhqWU1mc3NxM2p2ZUZRWG1YclV3UlhQQWFOaEo5QUtHS3Fyamw1M2xUNWgz?=
 =?utf-8?B?VmtDcWluSjJ0OGQ5QXhlVTNTejZQNTYvRHp0SDFlZlVKVko1UFlCTXVNOUNn?=
 =?utf-8?B?TlBMOEhkMHV0WDhKZzg5MUY4ZTJ0ai94UXRLbDVNOUlORkIzOTZOR1BoMUN5?=
 =?utf-8?B?L0J5d2FSRkFwL0JzdEZUSnowVzRSMmM5eUM0ZjZuQ3hBU2MxZ0FmSkpWN1JW?=
 =?utf-8?B?N1hoL01jSDh5QThZQUk2OVZaL0ZuQU1GNGZEYWlpOVB2S3pYak5iOGo2Y1VT?=
 =?utf-8?B?ektVQTl3Sis5VnRhZUNCT0N5WWk1cHJ5dUV4YW9TaVl6SU9BUUQvOUNTT1Fx?=
 =?utf-8?B?NjJrQjJVQUtNdzJnRjFxMDJRWjEwelZVbmh6MlM1dUM4K0FxcmVrOTBzVDN4?=
 =?utf-8?B?Um9Ca3BqeXV4UUNOOGF1UE9idCszRXR0UkRsZExMbUZ2dFYzTGoyZENSeDlt?=
 =?utf-8?B?Ykl2L0RHQ3M3aEN5bGtEdDhEblQ4RGF6a0M3dDNxOSthcWltUGtpaDJmKzhX?=
 =?utf-8?B?QWM5Zm1YNnJjTkxuQTlZWURMTzdqZDhuMTA4RVdHYkFtVzZJWWEzdUxibjJC?=
 =?utf-8?B?TTMyQlVrNG1wZVYwbm1UYmR5c0FWazdVVGRrOUVLM2I0b1A3UDVPcDFOSDBK?=
 =?utf-8?B?ZWhiOTVLNTgwTS9kSnQ5WVhxSUxlSFhGcmxrbkJOTnhZU2l2K0l2TEhiVTVh?=
 =?utf-8?B?VlBxZ2dSRjZabDhHdHc2SGlYY1c0Tmo3Y1F2VC9WUUdhWUxKN0R3QmJzYkc1?=
 =?utf-8?B?K2N6bWR6Zk02eGRCRGR6Zy80ZjU4TW9Pc1I3MmhjSlRid2FmVTRxdHlSVFhV?=
 =?utf-8?B?Y1I3U0N4YUtock4zVXNuYUZPZ2hGUU16R2FWUzBtTzBmQWNXaG0xdkcvcXE0?=
 =?utf-8?B?SEF1UjBYMXlsSDhTUUNLenpkdk95N0dwS0c2MDN1Szg2aE9CWmw3QnFkcnVm?=
 =?utf-8?B?VlBhVHgzcVo1SEIvcVBaOXg2T0NjVXc4enNiaXZIaHZIUk5aSzR3MnZEY083?=
 =?utf-8?B?a0UzeHFOemYwa3ZvQUpoNG56SHNEc1hUK1ZwNUVia1VNV01vRVhGT3h5aDAz?=
 =?utf-8?B?TlFXQVJmdzhONEZycXg5SGg3L1c2eDlINDhLdzBRbzBNVHVZZS9VaFJxa2tW?=
 =?utf-8?B?UEdSSmc5QjlVaGtpODNaSWJmU01EUXg0bGIvUG9ZNkc0MExhMHUyeXNwcmk3?=
 =?utf-8?B?ZzZLQk9DY0piSXdMMmNFOFRhNzZJV0VpUFhYYW52S3Z4anc4YWN3V1RRNE1q?=
 =?utf-8?B?b0VzT0wyaU92dFprbThyVUdaN2M5UFhHMHhIdm96d0NxSTVCTWtsa0pBeC9T?=
 =?utf-8?B?cG4vZHZJWlB5bW51alhOdmR3Uy9SRXpDUjBiMHpKU3F5U1A1RXhIcWRCaUdZ?=
 =?utf-8?B?d3EvWEFKTGxXTXdmYVVaWURkeGhxbzBid2J5eGhYTFlaQ3IzblFqNjBDV1hv?=
 =?utf-8?B?RkROVC9DUDNaNWJSY0VJenl0R1VNbG13YlRFNERSTFNzejdrWUxyZVQyalhI?=
 =?utf-8?B?cnNPbkRoS3p0eVRJdGtDTW0vclc1K3JTQitkYkNMUzdZVjNPR2JXaWRrTGlk?=
 =?utf-8?B?bHdLRFZGNWp5R1ZIRmJBZUIrN2ltQkwvck95SmU1SlIrTVVFaGlPS3RudmhK?=
 =?utf-8?B?T2lCUHhWUkFqSFJTOHpmZElwSENxdnlsWlVDVGUxMDBzWU41b21ic1YzWm5x?=
 =?utf-8?B?YnVicVRyb01BeWROZ2JtRFkvdHp1SGM3M0RNM0c1TEpROGpLMFN3ZmhiMGIy?=
 =?utf-8?B?a21QSytiQzVGZHcvK2lzL01pYlFzcTA0bE5zb1FKTml0VGd0aDFYMnZvYW0r?=
 =?utf-8?B?U2hRWGxvWHIxTjAvNzlWMWNHUVRBdHlLcjZWMDMzWW90NmlsL00vNkR1TUtk?=
 =?utf-8?B?VDQrNVFIWDE3MDF5SEFybi9VWlpxbUYrem5jbHZJbmN5ekkyNlFGME5lZktU?=
 =?utf-8?B?VlVHMWN2aDg4QlhzMkRTRXhpYmFXRVdnUzI4RE5MWEpSU2JJUVlWQ2RhSlhN?=
 =?utf-8?B?MFJxNXcxdis1ZFQ3RjN1M2lsQ1ZUTDVHOUR5eTlwVVJJamRCWC9vSXJLeGNj?=
 =?utf-8?B?d25IdWpRSXVuVjhQcy9Id3JTcWJEY3FmM3pYenlLM0oxZkN0R2dCVXFQTm5V?=
 =?utf-8?B?TjIxOWlGL2Q5UWtDdXkydnlxWk5hbDZpNzRRMUVVcHpRdlJuM1JiZ3pGb0dL?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f6a5cc-a55f-4979-b16b-08dd7d1a948f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 19:12:07.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaq3cOPF9V9SqTenDuERMQ7mFm6A5mBbEE9X/AowraLkQh8+gA0TlXAfbEPOrcweHlFzsgG8Jok9YMgyr0si1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4747
X-OriginatorOrg: intel.com

On 16/04/25 19:59, Judith Mendez wrote:
> Hello Adrian,
> 
> On 4/7/25 5:27 PM, Judith Mendez wrote:
>> For all TI devices, timing was closed For Legacy and HS modes in
>> half cycle timing, where data is launched on the negative edge of
>> clock and latched on the following positive edge of clock. The
>> switch to full cycle timing happens when any of HIGH_SPEED_ENA,
>> V1P8_SIGNAL_ENA, or UHS_MODE_SELECT is set.
>>
>> Currently HIGH_SPEED_ENA is set for HS modes and violates timing
>> requirements for TI devices so add a .set_hs_ena callback in
>> sdhci_am654 driver so that HIGH_SPEED_ENA is not set for this mode.
>>
>> There are eMMC boot failures seen with V1P8_SIGNAL_ENA with a
>> specific Kingston eMMC due to the sequencing when enumerating to
>> HS200 mode. Since V1P8_SIGNAL_ENA is optional for eMMC, do not
>> set V1P8_SIGNAL_ENA be default. This fix was previously merged in
>> the kernel, but was reverted due to the "heuristics for enabling
>> the quirk"[0]. The new implementation applies the quirk based-off of
>> bus width, which should not be an issue since there is no internal
>> LDO for MMC0 8bit wide interface and hence V1P8_SIGNAL_ENA should only
>> effect timing for MMC0 interface.
> 
> 
> On this patch series, I am bringing back the fix for V1P8_SIGNAL_ENA,
> Ulf requested a change [0] which I am planning to do for v2. But I was
> hoping to get your opinion on whether Hiago's suggestion [1] is doable
> so I can add that as well to v2. Thanks for your attention.
> 
> 
> [0] https://lore.kernel.org/linux-mmc/CAPDyKFqx-G4NynanFWrspz7-uXXF74RfjcU-Sw2nq2JhL3LPuQ@mail.gmail.com/
> [1] https://lore.kernel.org/linux-mmc/20250412132012.xpjywokcpztb4jg4@hiago-nb/
> 

Sorry for the slow reply - been a bit distracted.

I'll look at it properly tomorrow, but noticed
sdhci_am654_write_b() already is dealing with SDHCI_HOST_CONTROL
and SDHCI_CTRL_HISPD.  Can you make use of that instead of
a .set_hs_ena callback?

