Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8E2DFF3F;
	Fri, 20 Mar 2026 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774001842; cv=fail; b=fnLktMb+EuUwjI/Idm5sviTBf61tDhVsUMNpfK6CxvJW1n9PQvQYvAQTalIADOJ6GoegBCfSmuJ4hjbxfigM/gvILOE1aK5Agoe0FP6jeZtzwz+DZ8r6xXqcnplgDIHAfe0bz/1oykiY7v36t6w4jYhJhIeaJ9iyqkulJy5V3gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774001842; c=relaxed/simple;
	bh=O5p7tnLZ6hhDudaCqTGNul27BRjfFJ5qoVUZ2AzrH/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RKO8MAJQvpKe7Tt/TR8+2hXgfal6QtUNqMfTyuAwcj3FFtnUuR0IVWremuzf533L23MQM5JpSjTJ86bkgu2rFxj3XuY2gmruLL14Sex6/s+5WwDw9btyK5X1m4fRWXcy16k+CsGEm+/6fxm6mXamQ8QpCGxaz41YDiTr3++mPx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ni/slink; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ni/slink"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774001841; x=1805537841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O5p7tnLZ6hhDudaCqTGNul27BRjfFJ5qoVUZ2AzrH/E=;
  b=ni/slink/RPcxBuoXqLEOZv9eSqmuf7bWQRqhdjpPkATCE6c5rmSjH84
   zNEfR+1FtDSz3icFjY/P32+LIm81Ml+bS/mV2YTIsBxfFbcmL0rFIeRT1
   hZSA7MFIj1071VYwfRvS9hnYVcoJp6MslDSA4SI3gS4V0a9jKtCuYkwJx
   71W0A+wDqp+c3ysLEtnyCGgFBKRey85kgKuBA+kK6myRIbSW0WHED1BAr
   A9mWLmDJf1LL9fSW2f8xcYfP19gEoP8gFIBqTqh2JLgQDEyeRFkn0KZxB
   aKPZwqS8mReaj1flW+Dn4CLABAhlLPglsLb8d0PJBk/Cw+uWQcBalHSlM
   A==;
X-CSE-ConnectionGUID: gP5vYdWWTPOwfmAAhmpEiw==
X-CSE-MsgGUID: iHOgwkD7Sa+otI+RXXiCtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74100301"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74100301"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:17:20 -0700
X-CSE-ConnectionGUID: kzbbJxfjS52u/S0SqFLa+A==
X-CSE-MsgGUID: VCe8rk1TShOVe1+LMErHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="246273397"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:17:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:17:18 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 03:17:18 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:17:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQjTiy+t7HE2c2h56YAZ4jDUDTNAFpOnBS4+mzAqRnYTyzIuAo7sqWexZ9RbYfBrOEs0Ns7mWPuQ07hbZkuwck9Bn3RY/CXpAmpJJVot2zTrku/MnTTkMF2QRT+rYmOx2d/LbHRIoCvH21dynVANTJQ1iwZ1tqfEk2MAMCBxZbYsI51/uSw53k318R/KYvHMM3rBxxNaaADlrJT3oeae83mZrsLoQGxrCqQLkNArcDRdy5m9fEP9OFo2gsCuIwjoZwmSsq3wg/EUB66sFewCzIUumVzoF4aQzyoc+7KEe9YvX5eB66EpZuADndUTL0O0Zml4+UVdRXy8BrPjYq4qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IyxI/36udl7nqqnOmPVLrwytkINw1koZHm+53CCl5E=;
 b=DudHkx4/xhfxkL+YJUuw+U68Iyniy6q+mqYipf8it2y1hka8ql8JGWPF3uoR74dmlQcL6mO5SAjNzeZkAnSxdgn28LLBPuQHHiWe333G/dyb+/CrlVCZKf1DnYui8HIwTqKLm5UbTVo5+gxEZbRKTqn07c9FsiuIY7eX+zb0opENGgwD78umD0XaNqIfTlROJwUJ94MPbBUdB6+3/ZAC8Zi1nBMYm6I4IUgYy6q49qx7XTg1wtUuRR1UqLFO5Wr3p9i/PuZMhpM/PE+MGlYiXECidU0fWbQHXubuOUplzbfG84OlWI1bmFBtu+Xwvm5LlFjAj3q1O/6f/pkrj8PEhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DM3PR11MB8758.namprd11.prod.outlook.com (2603:10b6:0:47::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Fri, 20 Mar
 2026 10:17:12 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:17:12 +0000
Message-ID: <8e96dc15-a0de-4711-b6ab-b2b08484a502@intel.com>
Date: Fri, 20 Mar 2026 12:17:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC
 controller support
To: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>, <krzk@kernel.org>,
	<ulf.hansson@linaro.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<gaohan@iscas.ac.cn>, <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>
References: <20260319140705.123502-1-jiayu.riscv@isrc.iscas.ac.cn>
 <20260319140705.123502-3-jiayu.riscv@isrc.iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260319140705.123502-3-jiayu.riscv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0339.eurprd04.prod.outlook.com
 (2603:10a6:10:2b4::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DM3PR11MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 22eedfe1-f97d-4798-1374-08de8669da51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: tqxH498j5WZegIdm23qvJszeuw41jmwGMmd/xGQb7Fe+ERgPIn9CZGAvz4+LFg8JMz+NMv2B/mIetUxYpsjFSERljRMfNvIdoED6LBztU0EXyRuV59umiXx5yVypFpimvCbhwTIh+2gnAVeQeGort8EPBaAzclP2Um2/4oTmKejfCik3T5yqPR2pcFAp0Gx9F9yUlJ/hhsNAgAP2fe1j/v4pbrkpGEYbpJowuO0vMkhB1d/C7LLbYQKiiKQLzKAIxbUsj7jqxD/27aSLWoIp3ObF1ldsryDxhxw/efJpPfGgCgQl+IEs5P7GxK66XnVWcMyfQVPY80GHpoY1+cAq0PqaVbpFK5itD6IuFHMfAxsu5hHG3oXnFjstaCuv9idR6bPglG82oQDK95LpD3t6zBYBWZ+HuqZVSxLROprfCV71iP9OanP7B5I0Xx0XNqRALd/hI/qozF3prOUj/1gvlg+T4T9bGmO7po2CoLFdYuoQzp7VGQXhsIw9D7slzfkcNUUpmT2DByj/PVNcZ+xH6z03IXKuKM6DlcAnjBO4RMxl4mKKENqPBuvuykcszxj3bb7iCfSMvY2useHoz5YAmBeQfjrQOeoThdMfnA9MG2HcLTdQEbr2zs64f6tov/pRtFs0tC+QF8ANDVcKaWcY76/txwFXGQnl3bKyzWR9j2Y6VGhEKmc0tWhLIBHZR2pxV0RVGqFBwQRbvSr8CTKHSkdz+jNJJq86BjP/0rdMXnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0R0c2QwNXVOb0dwdVpXVkY2dVEvSGVNS1JnMXErblN1TTNZSVFLUlhJZjdr?=
 =?utf-8?B?N0o3RzZGU25JNXFJUm5CTlBKcmRQUUxzelRjc3hPajdmMHB2c25qQzVwVTAy?=
 =?utf-8?B?emlaVjR5S3ZHSjdjZjA4STFtTHF5Q2Nubmx1Vzh0cjc1dkdSZWFpc2psYnJ1?=
 =?utf-8?B?QnI2cVFVMWYwbDJmeXN2U3NsZ3pjRU5MM0hQRE0vWEZSUVdJMkdoQ3NubXp5?=
 =?utf-8?B?R1ZHUnB1SUZHcmJzMHU3NHNIdXRNS2NCQXppYnNvYmxJQVRLUkNzNThoWHJq?=
 =?utf-8?B?QkxnYTliUUNybUlUWHZoNXVuOEwrKy9vSXNjaG03YU5xdTVDa0lIbDJOdVZL?=
 =?utf-8?B?VHdweGp0OWZyQWlLeGxDQmNKa3NhOVFPNGtZbGczYlYyOUdDbW9hanJNYXNG?=
 =?utf-8?B?a3RvQlBBamZla3Exa0dTVEM2WHhiVTI5cC9va0tZa3BpMnN3Nm53dkpHTWFR?=
 =?utf-8?B?WEhUYmt3ei9rdjhLeGdXWmpDS00yWFc0Tkx5OG4vZzNucEYxQjhQZVB2cUpS?=
 =?utf-8?B?UldJaTkrRmJYcnZjU0J2WEN4UDNPRVdhUWxYZTRUckVOWDRpM1FLNlJBcGJO?=
 =?utf-8?B?NlI3bnNSc2pOcXVwaTlTQXlBcVNZenlxOEdpdW5mOEJncjRJMXlZNGtKSWFs?=
 =?utf-8?B?UVFGc0lmOGN6amxLS3d2cmFuSDFSQThsbHJlbGE0OUYyVU11YlRXd0Y4K3B5?=
 =?utf-8?B?dm9KOHVGRWZveEVybXdRdjA2cWE1V0t1NXFEVUpXT1d2SnByamJlN2dMeXZY?=
 =?utf-8?B?cU5sMjlQNXdYKzNPd1VHTGpXMkV1M1NEUTlpK2xvL0haMFpxQS9kSHFPdFhO?=
 =?utf-8?B?aXZsaHpZYzc4SVJQb1pYd1c2UzNGalRHNXBoWEN4aVNIL3B2YytLVUJoWWc5?=
 =?utf-8?B?emkwL2JtQnRFUFNoazROM2hFU2dtQWtNNUt0dnkzMlUwZ0lITlRmMzFvdyt5?=
 =?utf-8?B?VFBPTVZvV0grU1VhaU5QWWdSUWJ4b2tUT29tby9PcmlLcE9QSklkcHJxeE84?=
 =?utf-8?B?dy9KQmFXZ3UyM1oxSVVYZUtHc3F6OHY1Y1FnUEJpK3NpMVBSclh5d2dlOU5v?=
 =?utf-8?B?QTJGL1pyL1FINHFvUEFVUEpkZVc2emR2UmluVThxTnI5TUZCZUpQaldUampF?=
 =?utf-8?B?ZGdwSUE4bGllWmF6V2NwZUx3U28wRU1jeWRpcEVYTG44Q1BBQUtFeDZ4ZGNz?=
 =?utf-8?B?bjFQNm4zaStyb09FWHJuU0dmbGl2TWVnNm0zeEJkVGFKVnhpODNNMXVMRm95?=
 =?utf-8?B?Z2xMbXc5ek1rdFRCUndSQTVwcTBPa0JRcWl4cGxDdlZKWHVZeU1Ic1YveEhQ?=
 =?utf-8?B?UEdnVXhBNWJRZVo2NTAybTNMWUpCUHNhbkZBNE04ZFJFSVEwZExRNi82bE1S?=
 =?utf-8?B?NnhRdHd4NnhremsxaGI2RmlSeVkzVFVLdk9hSnQrbkhURERtR1hMOGIrbHd1?=
 =?utf-8?B?RHlyZTFtQjdNUHVhN1NVS0ZjeGdmWFkzRkFVNnEwcHNHS1Z2SkN1dlBlQmEv?=
 =?utf-8?B?Lzd0S0FPbm5UUkV6Ri9sVFpieVQxL0RDTTh0dWVORmh1UkJjSGtnRzRQaFRO?=
 =?utf-8?B?YmtoVDhhdjBqclAyQU1IZU1RVEUyVWVkR3ljM29HSHJINlNpYkROc2FqZFZ1?=
 =?utf-8?B?cWNTZmFadGZuV3lqYzJvWSs3WkQ3UmEzdVZiZUNWNG5pYWJUNmZ0V1RmTENa?=
 =?utf-8?B?NTA4UHRkcXBnbzZyeVNHemNFdW9rK1JLV2hDNEFrUktaQTRHUmRqdk0rcVE3?=
 =?utf-8?B?ZG5oR0JiWGdZeFc2WUZxY25BQUQ5N2hiTGZaU3ZjMkxXSDZQT0ErdGtobHRn?=
 =?utf-8?B?ZTBONGFBeE1CUkVmUUFMNlJCbkxNZHRGNWJSZXpYWWVDMGxGN1VqaTRtdTIv?=
 =?utf-8?B?dDlFeENaWG15UGV6UmNXWGtRMldwMWNBL3FzYzVyQWNoNkJIRDZiVG5MenNs?=
 =?utf-8?B?dmQxV3U2MFp0dFMxeFBkaDR5dDduL3ZERTNZSDVyczk5UTdFbWVkZzdDQmJ2?=
 =?utf-8?B?U2FPenRxRnFqTVZxWmx5b3FBTnFqdDZHclhiaTVYakp2d3ZLZkRFM2tWbjcx?=
 =?utf-8?B?YWFHcXI3dVhoZEJ2aUgyY2gvcG5rdmlWWGxRRGpvK3B6VU5ZUjVGeDBxSHlk?=
 =?utf-8?B?NzRqbEhsa096QkxXNW5UQjQwUDlZbDNpNE1nK1F0RFpYRzk4dXlMbHc5Z2ZJ?=
 =?utf-8?B?bTh5V2pYMUw0czFlTmdqcHdEMnU1U2R2dHozNlBFZG9QTmFUNHVuUnVFS2RT?=
 =?utf-8?B?RzdJelVZYlY4T0phQ3VDdjZsMCtJNVFvS1laTGVhQnlRQk5sT2pBT2lGVnRV?=
 =?utf-8?B?MXk4YTB0dFQ2OG9vR1phN3VJUnpVNXJ4RGtSdVcyZjY3QkVFWkVvTEgzUU8r?=
 =?utf-8?Q?KmecxpbcXfMN+PBQ=3D?=
X-Exchange-RoutingPolicyChecked: anrWkqHn5halaWiLSktNHhMeL7Fl+AwDw77iZ9bbg0IeFI45dXoKU/Yc7dr41nNvqieNI7OzKqceu6ZPKrUFAzRC0RKjoStjiS7wRknHevNWZatJ2G9uacEgrIsR7zC0IW2OEi2TN8tOnd1RcXBF5McAsAi6rS3c7ClavF2+jrYyNuTmzQsXd6KocO8sLYGN+VGoMWb9LKNQXKc69OrI3TilyNk8RY0xqBXEk7BvWscJeK3qJOUQxgUjyXowCdGK26bKsdLGHMNwYHM1z10aQvXnl3yT2sqTi+w3skr6ndwj+SLpGdOC1DK0BJiBwq7rWvqI8DhCNWBtKVip1YZ5FA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22eedfe1-f97d-4798-1374-08de8669da51
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:17:12.7418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHg4iXf0u7mSlGGHSWKsaJ+7HB/kPf9qz3L7Hd5x3XjNcASMVf3AwE4JRNfJQP7bITQDV/r3sEuVw7RRTKKykQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8758
X-OriginatorOrg: intel.com

On 19/03/2026 16:07, Jiayu Du wrote:
> Add SDHCI controller driver for Canaan k230 SoC. Implement custom
> sdhci_ops for set_clock, phy init, init and reset.
> 
> Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>
> Signed-off-by: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 260 ++++++++++++++++++++++++++++
>  1 file changed, 260 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..2b34444b8608 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -128,9 +128,11 @@
>  #define PHY_CNFG_PHY_PWRGOOD_MASK	BIT_MASK(1) /* bit [1] */
>  #define PHY_CNFG_PAD_SP_MASK		GENMASK(19, 16) /* bits [19:16] */
>  #define PHY_CNFG_PAD_SP			0x0c /* PMOS TX drive strength */
> +#define PHY_CNFG_PAD_SP_k230		0x09 /* PMOS TX drive strength for k230 */
>  #define PHY_CNFG_PAD_SP_SG2042		0x09 /* PMOS TX drive strength for SG2042 */
>  #define PHY_CNFG_PAD_SN_MASK		GENMASK(23, 20) /* bits [23:20] */
>  #define PHY_CNFG_PAD_SN			0x0c /* NMOS TX drive strength */
> +#define PHY_CNFG_PAD_SN_k230		0x08 /* NMOS TX drive strength for k230 */
>  #define PHY_CNFG_PAD_SN_SG2042		0x08 /* NMOS TX drive strength for SG2042 */
>  
>  /* PHY command/response pad settings */
> @@ -153,14 +155,21 @@
>  #define PHY_PAD_RXSEL_3V3		0x2 /* Receiver type select for 3.3V */
>  
>  #define PHY_PAD_WEAKPULL_MASK		GENMASK(4, 3) /* bits [4:3] */
> +#define PHY_PAD_WEAKPULL_DISABLED	0x0 /* Weak pull up and pull down disabled */
>  #define PHY_PAD_WEAKPULL_PULLUP		0x1 /* Weak pull up enabled */
>  #define PHY_PAD_WEAKPULL_PULLDOWN	0x2 /* Weak pull down enabled */
>  
>  #define PHY_PAD_TXSLEW_CTRL_P_MASK	GENMASK(8, 5) /* bits [8:5] */
>  #define PHY_PAD_TXSLEW_CTRL_P		0x3 /* Slew control for P-Type pad TX */
> +#define PHY_PAD_TXSLEW_CTRL_P_k230	0x2 /* Slew control for P-Type pad TX for k230 */
>  #define PHY_PAD_TXSLEW_CTRL_N_MASK	GENMASK(12, 9) /* bits [12:9] */
>  #define PHY_PAD_TXSLEW_CTRL_N		0x3 /* Slew control for N-Type pad TX */
>  #define PHY_PAD_TXSLEW_CTRL_N_SG2042	0x2 /* Slew control for N-Type pad TX for SG2042 */
> +#define PHY_PAD_TXSLEW_CTRL_N_k230	0x2 /* Slew control for N-Type pad TX for k230 */
> +
> +/* PHY Common DelayLine config settings */
> +#define PHY_COMMDL_CNFG			(DWC_MSHC_PTR_PHY_R + 0x1c)
> +#define PHY_COMMDL_CNFG_DLSTEP_SEL	BIT(0) /* DelayLine outputs on PAD enabled */
>  
>  /* PHY CLK delay line settings */
>  #define PHY_SDCLKDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x1d)
> @@ -174,7 +183,10 @@
>  #define PHY_SDCLKDL_DC_HS400		0x18 /* delay code for HS400 mode */
>  
>  #define PHY_SMPLDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x20)
> +#define PHY_SMPLDL_CNFG_EXTDLY_EN	BIT(0)
>  #define PHY_SMPLDL_CNFG_BYPASS_EN	BIT(1)
> +#define PHY_SMPLDL_CNFG_INPSEL_MASK	GENMASK(3, 2) /* bits [3:2] */
> +#define PHY_SMPLDL_CNFG_INPSEL		0x3 /* delay line input source */
>  
>  /* PHY drift_cclk_rx delay line configuration setting */
>  #define PHY_ATDL_CNFG_R			(DWC_MSHC_PTR_PHY_R + 0x21)
> @@ -224,9 +236,20 @@
>  					 SDHCI_TRNS_BLK_CNT_EN | \
>  					 SDHCI_TRNS_DMA)
>  
> +#define to_pltfm_data(priv, name) \
> +	container_of((priv)->dwcmshc_pdata, struct name##_pltfm_data, dwcmshc_pdata)
> +
>  /* SMC call for BlueField-3 eMMC RST_N */
>  #define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
>  
> +/* Canaan specific Registers */
> +#define SD0_CTRL			0x00
> +#define SD0_HOST_REG_VOL_STABLE		BIT(4)
> +#define SD0_CARD_WRITE_PROT		BIT(6)
> +#define SD1_CTRL			0x08
> +#define SD1_HOST_REG_VOL_STABLE		BIT(0)
> +#define SD1_CARD_WRITE_PROT		BIT(2)
> +
>  /* Eswin specific Registers */
>  #define EIC7700_CARD_CLK_STABLE		BIT(28)
>  #define EIC7700_INT_BCLK_STABLE		BIT(16)
> @@ -268,6 +291,11 @@ struct eic7700_priv {
>  	unsigned int drive_impedance;
>  };
>  
> +struct k230_priv  {
> +	/* Canaan k230 specific */
> +	struct regmap *hi_sys_regmap;
> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>  
>  struct dwcmshc_priv {
> @@ -278,6 +306,7 @@ struct dwcmshc_priv {
>  	int num_other_clks;
>  	struct clk_bulk_data other_clks[DWCMSHC_MAX_OTHER_CLKS];
>  
> +	const struct dwcmshc_pltfm_data *dwcmshc_pdata;
>  	void *priv; /* pointer to SoC private stuff */
>  	u16 delay_line;
>  	u16 flags;
> @@ -290,6 +319,14 @@ struct dwcmshc_pltfm_data {
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>  
> +struct k230_pltfm_data {
> +	struct dwcmshc_pltfm_data dwcmshc_pdata;
> +	bool is_emmc;
> +	u32 ctrl_reg;
> +	u32 vol_stable_bit;
> +	u32 write_prot_bit;
> +};
> +
>  static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>  {
>  	u16 ctrl;
> @@ -1656,6 +1693,181 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  	return 0;
>  }
>  
> +static void dwcmshc_k230_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	sdhci_set_clock(host, clock);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	/*
> +	 * It is necessary to enable SDHCI_PROG_CLOCK_MODE. This is a
> +	 * vendor-specific quirk. If this is not done, the eMMC will be
> +	 * unable to read or write.
> +	 */
> +	clk |= SDHCI_PROG_CLOCK_MODE;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void sdhci_k230_config_phy_delay(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 val;
> +
> +	sdhci_writeb(host, PHY_COMMDL_CNFG_DLSTEP_SEL, PHY_COMMDL_CNFG);
> +	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
> +	sdhci_writeb(host, PHY_SDCLKDL_DC_INITIAL, PHY_SDCLKDL_DC_R);
> +
> +	val = PHY_SMPLDL_CNFG_EXTDLY_EN;
> +	val |= FIELD_PREP(PHY_SMPLDL_CNFG_INPSEL_MASK, PHY_SMPLDL_CNFG_INPSEL);
> +	sdhci_writeb(host, val, PHY_SMPLDL_CNFG_R);
> +
> +	sdhci_writeb(host, FIELD_PREP(PHY_ATDL_CNFG_INPSEL_MASK, PHY_ATDL_CNFG_INPSEL),
> +		     PHY_ATDL_CNFG_R);
> +
> +	val = sdhci_readl(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +	val |= AT_CTRL_TUNE_CLK_STOP_EN;
> +	val |= FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, AT_CTRL_PRE_CHANGE_DLY);
> +	val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY);
> +	sdhci_writel(host, val, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +	sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +}
> +
> +static int dwcmshc_k230_phy_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 rxsel;
> +	u32 val;
> +	u32 reg;
> +	int ret;
> +
> +	/* reset phy */
> +	sdhci_writew(host, 0, PHY_CNFG_R);
> +
> +	/* Disable the clock */
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	rxsel = dwc_priv->flags & FLAG_IO_FIXED_1V8 ? PHY_PAD_RXSEL_1V8 : PHY_PAD_RXSEL_3V3;
> +
> +	val = rxsel;
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230);
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> +
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	val = rxsel;
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	val = rxsel;
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P_k230);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_k230);
> +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +
> +	sdhci_k230_config_phy_delay(host);
> +
> +	/* Wait max 150 ms */
> +	ret = read_poll_timeout(sdhci_readl, reg,
> +				(reg & FIELD_PREP(PHY_CNFG_PHY_PWRGOOD_MASK, 1)),
> +				10, 150000, false, host, PHY_CNFG_R);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc), "READ PHY PWRGOOD timeout!\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	reg = FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN_k230) |
> +	      FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP_k230);
> +	sdhci_writel(host, reg, PHY_CNFG_R);
> +
> +	/* de-assert the phy */
> +	reg |= PHY_CNFG_RSTN_DEASSERT;
> +	sdhci_writel(host, reg, PHY_CNFG_R);
> +
> +	return 0;
> +}
> +
> +static void dwcmshc_k230_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	const struct k230_pltfm_data *k230_pdata = to_pltfm_data(dwc_priv, k230);
> +	u8 emmc_ctrl;
> +
> +	dwcmshc_reset(host, mask);
> +
> +	if (mask != SDHCI_RESET_ALL)
> +		return;
> +
> +	emmc_ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	sdhci_writeb(host, emmc_ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +
> +	if (k230_pdata->is_emmc)
> +		dwcmshc_k230_phy_init(host);
> +	else
> +		sdhci_writel(host, 0x0, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +}
> +
> +static int dwcmshc_k230_init(struct device *dev, struct sdhci_host *host,
> +			     struct dwcmshc_priv *dwc_priv)
> +{
> +	const struct k230_pltfm_data *k230_pdata = to_pltfm_data(dwc_priv, k230);
> +	static const char * const clk_ids[] = {"block", "timer", "axi"};
> +	struct device_node *usb_phy_node;
> +	struct k230_priv *k230_priv;
> +	u32 data;
> +	int ret;
> +
> +	k230_priv = devm_kzalloc(dev, sizeof(struct k230_priv), GFP_KERNEL);
> +	if (!k230_priv)
> +		return -ENOMEM;
> +
> +	dwc_priv->priv = k230_priv;
> +
> +	usb_phy_node = of_parse_phandle(dev->of_node, "canaan,usb-phy", 0);
> +	if (!usb_phy_node)
> +		return dev_err_probe(dev, -ENODEV, "Failed to find canaan,usb-phy phandle\n");
> +
> +	k230_priv->hi_sys_regmap = device_node_to_regmap(usb_phy_node);
> +	of_node_put(usb_phy_node);
> +
> +	if (IS_ERR(k230_priv->hi_sys_regmap))
> +		return dev_err_probe(dev, PTR_ERR(k230_priv->hi_sys_regmap),
> +				     "Failed to get k230-usb-phy regmap\n");
> +
> +	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
> +					    ARRAY_SIZE(clk_ids), clk_ids);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get/enable k230 mmc other clocks\n");
> +
> +	if (k230_pdata->is_emmc) {
> +		host->flags &= ~SDHCI_SIGNALING_330;
> +		dwc_priv->flags |= FLAG_IO_FIXED_1V8;
> +	} else {
> +		host->mmc->caps |= MMC_CAP_SD_HIGHSPEED;
> +		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> +	}
> +
> +	ret = regmap_read(k230_priv->hi_sys_regmap, k230_pdata->ctrl_reg, &data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read control reg 0x%x\n",
> +				     k230_pdata->ctrl_reg);
> +
> +	data |= k230_pdata->write_prot_bit | k230_pdata->vol_stable_bit;
> +	ret = regmap_write(k230_priv->hi_sys_regmap, k230_pdata->ctrl_reg, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write control reg 0x%x\n",
> +				     k230_pdata->ctrl_reg);
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -1743,6 +1955,15 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
>  	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_k230_ops = {
> +	.set_clock = dwcmshc_k230_sdhci_set_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.set_uhs_signaling = dwcmshc_set_uhs_signaling,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.reset = dwcmshc_k230_sdhci_reset,
> +	.adma_write_desc = dwcmshc_adma_write_desc,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
>  	.pdata = {
>  		.ops = &sdhci_dwcmshc_ops,
> @@ -1834,6 +2055,36 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
>  	.init = eic7700_init,
>  };
>  
> +static const struct k230_pltfm_data k230_emmc_data = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_k230_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +		},
> +		.init = dwcmshc_k230_init,
> +	},
> +	.is_emmc = true,
> +	.ctrl_reg = SD0_CTRL,
> +	.vol_stable_bit = SD0_HOST_REG_VOL_STABLE,
> +	.write_prot_bit = SD0_CARD_WRITE_PROT,
> +};
> +
> +static const struct k230_pltfm_data k230_sdio_data = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_k230_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +		},
> +		.init = dwcmshc_k230_init,
> +	},
> +	.is_emmc = false,
> +	.ctrl_reg = SD1_CTRL,
> +	.vol_stable_bit = SD1_HOST_REG_VOL_STABLE,
> +	.write_prot_bit = SD1_CARD_WRITE_PROT,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -1906,6 +2157,14 @@ static void dwcmshc_cqhci_init(struct sdhci_host *host, struct platform_device *
>  }
>  
>  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> +	{
> +		.compatible = "canaan,k230-emmc",
> +		.data = &k230_emmc_data.dwcmshc_pdata,
> +	},
> +	{
> +		.compatible = "canaan,k230-sdio",
> +		.data = &k230_sdio_data.dwcmshc_pdata,
> +	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
>  		.data = &sdhci_dwcmshc_rk35xx_pdata,
> @@ -1988,6 +2247,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	pltfm_host = sdhci_priv(host);
>  	priv = sdhci_pltfm_priv(pltfm_host);
> +	priv->dwcmshc_pdata = pltfm_data;
>  
>  	if (dev->of_node) {
>  		pltfm_host->clk = devm_clk_get(dev, "core");

