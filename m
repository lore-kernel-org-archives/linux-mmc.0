Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A03B5F48;
	Wed, 12 Aug 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786523197; cv=fail; b=UC38ulZxrV+5dk1ympMQnAM/5qj4hyI/0fbqv5DI/TZDXf4Svm532pn2nhn1lUzHnC4r1dLyxldZbLH3NfTeKAROnb3RB3xnl+HW2Nr2IMZibJxyRu2DPWN3gv+GAm8E15IclhtWG/fxtzafYAV9KQjgWUo1vWt9MJvNcwiAxOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786523197; c=relaxed/simple;
	bh=LevHCKkpkobN2yFLcCQ1K4AtV4Kv/86W7zhIt38gQlo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sp/Wi11ogn3dRCRp5vpChOjAG035FXcG+CmdigeF27LvK9VL6wIfH1OPtPLgy3SSeJ4dmpYE/zZbYaAnBjf0ENKb0OGiJIl+9Rxce/BYvN0zS2vs2NAGkEwCI0SEux+KQ/Y5gA6CnBoI5paRRlbvOPTygCcz1jY51EcyQr/mfOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtUjMDfO; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtUjMDfO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786523195; x=1818059195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LevHCKkpkobN2yFLcCQ1K4AtV4Kv/86W7zhIt38gQlo=;
  b=QtUjMDfOwLHsbyIeEPd+3O6L+Os+6UWC418xDcNAvzQPz6FjKjHIm17Q
   wM1l1tq4o4ZyGWv8VJhVigJqCEDjbfaTgO2lhKFldasKWbhPkM66ui33l
   4by3KXOpaCD8IOrW9LV4moaNTqrLJJ2Kj5VQUlwNfNxX3hdGYmhM1dQzR
   jzhlDN9vYQMTJuLCCIJe+q6n+mEFo1X4YfzXbp0QQ94LW1MS9j62HUO9d
   k5X2ykAkVWvwymPPpAkowfqfoFKHkq85Lj8xUY10qqWUww13ktb2pe+UC
   fJNth12ZV45+2DItdZ//5rqqGajdp7ZSK5aMLkSIijFyTv7fAT9pWz8xC
   w==;
X-CSE-ConnectionGUID: KuFYmDZXQ26VmjQqpdBCZA==
X-CSE-MsgGUID: 3lp4ivfQSf6/m3VcLAbYnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86188708"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="86188708"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:26:34 -0700
X-CSE-ConnectionGUID: JBVj4YmKSXe2jeXPkwUDkw==
X-CSE-MsgGUID: 1ahOlUj9Q768SsVnPwS78A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="301825784"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 01:26:34 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 01:26:33 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 01:26:33 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.24) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 01:26:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaKVQLnNAvo7//tZ05n3Q1DJVJVrEa4iM1/yBjNPSdRJqzMEzbvRldeU0F/XQ24zYFMWCuAh+MYyecmvbiUgC6PvAwEUFDoTmIsp43XereVfWhf8Y5QMacF5ZVL46DJBr1NMrCvgOwwX1XjKqDHcnR4zXuQKHcoOWFtNapXOr48fuqiUmuFu8wJbUOlD9npblVI4FT4sT6EQawzi5e/YERjCWF4l6En+aJ8+S1w4uj3+EqyA0a8cIAQhAAKibsEdFLc8ADwUt5Mquq2JseNoQI/D6TEwfqeY4yO+nYzj6b/ncNUfZGdF6SPJSbp0IkkL+U+WpXhLTzyEUuK5tPNyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETgmrsfU9doT5ZZIBXmjEyAe6i4Qdmeo74M4a/w6I8Y=;
 b=wIzHYHoB6lPwysun5LhcoKcGJRbng/JEN74UY9cR1/2JpmvwhZdjUbSzfPT/aP7dDMda5LDz1A53tgLrjK3Ps212LqsSJEx8RFxpZPGAjD0hNAtw/4+0hmd9mnY7zw0e3XncMMpMDaskOBMcVYqqUm98dvsgrdf0RZTrEOLsiD9tCK2LeTUM4SgnBrxX3RgcyUFm882ijhc3sAZAb+X9dePutAHPWfvuAAqtXk3xDN7C31wYC8twZ+Jt5mHHfvJX/QfmfC3c0brTpK5+B/gHLoEl0wBd/wPnhCi/Blb2x0r/X39uJAjSHHwNeEco2AGA8kTxZr6FTxVYLqK4FArnnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 08:26:28 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 08:26:28 +0000
Message-ID: <1dc90386-11ff-4b95-a1c8-1365cad1b4d4@intel.com>
Date: Wed, 12 Aug 2026 11:26:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] mmc: Add pstore backend for crash dump storage on
 eMMC
To: Florian Fainelli <florian.fainelli@broadcom.com>, Kamal Dasu
	<kamal.dasu@broadcom.com>, Ulf Hansson <ulfh@kernel.org>
CC: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G
 . Piccoli" <gpiccoli@igalia.com>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, William Zhang <william.zhang@broadcom.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260422205053.3392395-1-kamal.dasu@broadcom.com>
 <CAKekbesT-CazRUv-LMU92h8pPP06PdrP8PQSTQZkeJs8vUePXw@mail.gmail.com>
 <CAKekbes22Es97vR39y==Ds-VszAOo0ypwYhVT2ODbSpkb=cZfA@mail.gmail.com>
 <b6cdd25a-af18-40f4-8fc1-fac2e1d0ef41@broadcom.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <b6cdd25a-af18-40f4-8fc1-fac2e1d0ef41@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH8PR11MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6192a8-1da7-4848-3dca-08def84b6787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|4143699003|11063799006|6133799003|56012099006|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: RvM6uWU+vvj6UwHYANZ7psOqYu8/TBPOBbxEbEahiim+uM6f5J9A86xpTUI3Yo7+VdNI5XH6p5fbPjk2zJZGicHJAdOeeZJkvlYNCWM9izWUaeYA5fgESlKpZ81TS6ww2h38macVetFeteBPKkF6vGhZVDlfrWbE24y8i5iyk58iR3n3aBgIp2pWE76pN3FBJ4vsR97hK1FoPy/Pcu4cvjMzTy4wBl8i/E1ifvLzk+vcXSYQPV1OUlABMCh3uA+kqLqJG0eT9iEhPjf1HxqitieTJSarf+ZA7ZFUH62qeJeE3eXlgYpY/vYJObZ/OZ53olKV/5XEpzxOsF2VT/5v/vthYZ0HDJFCCcgGhfIFT58D+jvEO8X2FJjNDv0tzkYPtfbxGPJ35X/YtaHgQpj2blfMZoe4Tm4aK3qMwWT+5cpJCoXKObNTMaxvjgY6j2/1G9d2WFWXtVp0j1aDKKYZUkBEJQa5LHk9tk4GUmXDhFwt8lZaMC57Md2xjqgkWclYqthQ+Ha0xaxjuvqANasc7KtuAaCNrt9/bnWzi9dxOvfsfXsfWuJG5k/vw1jgo+6pze197SzOqz7e21GYd23FQrlOj2fGyOjfyczUUQyMHRXeCTSRaRET9Qsvc+dIFnqz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003)(56012099006)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZvUjREMW1TZFYzR2RSV1VNZ1pLVEhXKzIyU2tZbDdXMmhiQUVrcE04OHVi?=
 =?utf-8?B?WURIbVgyYjBBWjNkZ3dIRFVsQkV2UERPdlpYK2lOOWx5dFhveDQ5c1VSZ3VY?=
 =?utf-8?B?R2VWREpxQndHWjlpNXk5cmFPMDdJUFA5L2k2cFd3Wkk4NDd6R3ZSeHFFL2Fs?=
 =?utf-8?B?d3R4bG5sdmwrdDNReDYzNHVQMWUwK29la0RNZXVoT1diM2k5aVh5cnFLd3VE?=
 =?utf-8?B?U3hFaXBqYjQ2OXRGSVYxRFhDSUNVMGs2YTh1WTZHQ3JyR0lQWnhHTXdzT3Rk?=
 =?utf-8?B?U202V1h1bjNLelJxSkt6V25kZGVtOXBWcUtVNDlvZDBKM091aHV3SHdhdmNT?=
 =?utf-8?B?TDZvc3JNbXFpOUdCOWZZeWVhWkkxR0JYSktsV2YzVndRRFY4NG50N2E0cVlu?=
 =?utf-8?B?dnNrYWJNR3N2ejcvaDBEMlRzdlZIR1RUa0JtbmFvUjlQeHVsWnk1Zkp6aGRJ?=
 =?utf-8?B?UU93cWZZZTZ6bkFEYkZWSWRJQnZMeWVweDJQc21JUlcwY0daNitNM2craVVS?=
 =?utf-8?B?ck1PRkVaTGFmRDdtN0JJa1Rmc0tLUmdMWkxFdGVEZVJSeVNaNmpmOEdQOTJq?=
 =?utf-8?B?NFFkSmNUM1NIaXgzUWduZUZlWGlpblNRZmo5OVR0bzNxWVNKa2hJM1V6ZmFj?=
 =?utf-8?B?QWFJdjdjeWZCdmNjMjlFQ0Z1VWw2VC9Pa1NReXRkNUZ4ZHcyVW9BR1JRMWJK?=
 =?utf-8?B?ZVd1c1I1dWF2RWNpc2lSSzVXNnZ3NjVRSTBMRHpDTDhPdjNmbWp5U09Ua1lW?=
 =?utf-8?B?ZmMrdXlsMWFzc1pGVTJLazBaclBIeER2VUJ0azlRZ2kyNXRhbjJpUDhKUURy?=
 =?utf-8?B?cFBIYkcyT0JEK05RSWJoL0lQUWZHYS9nbXJmbGhTN1hlakg3ZFlpaUxmZ2VF?=
 =?utf-8?B?MWxxaTczdkxLZVFlVGQrOW1EdFpoUEsrNS8venY4N0pxTTJYTTFXUkdwU3Jl?=
 =?utf-8?B?WjRpMm16UWlEZ01jbnkzczZNQUFmRTJndytUNVM0NFhiTG5vS2JJWjltdUJD?=
 =?utf-8?B?Ulo2aVFUaHZ1c0xFaXkwazFDOE1ZbCsvZm9wWEhvek1QSUhBc3JubzkyN2Nw?=
 =?utf-8?B?ZjhUdmZiUzhwbWZqWWtDekxycmhEdFNhdFJqUnhTamI1UkxUK05kRENGSXhz?=
 =?utf-8?B?V3ZIRHBoSXlnRHF3c1JENExmT1JUbWJrY2ZsUU9wSmQ5K1VZa2lmQlZIOEpn?=
 =?utf-8?B?NHZyRTAvQ0RBaGMzR2h1WEVrSHFTSjgzNlpGRlRCaExKNi9oKzR0VCt6M0hm?=
 =?utf-8?B?V3JSNG5LTUZWQTdVMDAxUXlmZFBrTlhHdjV3MFovQWlTM1BXOVZZbFpLUFBS?=
 =?utf-8?B?OXVhdExCcW9vanpWRVcvNUxxbGdiN0pDUXdPOTUrRmFBb08wQVpnbEg2c2tL?=
 =?utf-8?B?bWdlS1h0QTNLczNnR1FQclpEOTIwQjNsN0l6SWlNRExiWlp5LzRqczN6Q0F2?=
 =?utf-8?B?SUFZZlV3ME1aeHVZMG5selovY0JML0Y0MHFhVVVXRXlYS3FqTk9QQXVSQjNv?=
 =?utf-8?B?RW4zMzA2cGVuRDdkZWkyK29RUHVJdmg3V0JLRnNoOE1SZWs0bkNYR0NiMnN3?=
 =?utf-8?B?T2FLN0Z4MmQ3Z2JQWHBwYmZPNUo1MEdqRFVrcGhOUnkreWJUaWtiSHRmNHFs?=
 =?utf-8?B?ZkFKMUhkYjhPckdoZGJCeG40R09NekhjUml2QjdFcWFQZHduc2tVdTZQOVpm?=
 =?utf-8?B?OWREM2dWWGlPNWlLUmtvM0h6aC84NEtjOUhTcVByc2hIalNDeUFCVmlmS2tH?=
 =?utf-8?B?dzkwSzU0RjVFWkpVMG81TXN1M1BPYWwrOVZBa0tMaEZjaUFiNGhFcG9GTS9Z?=
 =?utf-8?B?T0daQmhqb1cyYWxXNjhVVTFsMHcyanRPNm5lTmtPc3ZGcnlKLzRTUGxTYnIv?=
 =?utf-8?B?YzNPYWJ0Q29aMU9VekZSMnAzSnF4YTJvaFR6QzJxSGNmdlVsSmRvZElnc1ds?=
 =?utf-8?B?WHNjR2lnZ21Zb2h2WlFuWHFPeUFndko0OEdGMWV6VFpreSs4Mnp0d0ZYWS96?=
 =?utf-8?B?dXJsR3IraVR2NUh5VmQ2b3dMVllUQVBwcVBNYklkK1h1L2VFdjEzdFlKTkdr?=
 =?utf-8?B?eWI5NHF0S3o0emdLeG11Z3ovaWppaTUyL2pHNnZjdHdZY3Jxekxrb2tJVnVJ?=
 =?utf-8?B?MXBlczYxMkR1U095bWE1MzZvRTA4YlF0azlMVEEyaHVvYTVvQ21mdUpVWFp2?=
 =?utf-8?B?WHA0Mm5odi9pZGhyaTJwTW52L0xtbUxDTDZFSitCMDRuUHFHbXRheWtKZUV3?=
 =?utf-8?B?MzZESXVoMnl1MFVSb2Z1aG54RUxxSGZ2N3F1M2ZXT3RyRTc1UG95Tm83bm93?=
 =?utf-8?B?VmE3TTZWSWZDTzNQd3JJMzFWNnQ0cjlQaTlwOFhoSlpiMDZzd1lBL1l0VU5a?=
 =?utf-8?Q?dRLxf1NcmaORA2JM=3D?=
X-Exchange-RoutingPolicyChecked: FBaxIwUL15RIq554WSFNsSP/tHeKeN4kk5CJ/Fq3zILSADvBv1S0cYDJd3GS3WSvsLgJxZDeQW65NUpc+sW+2lsGzs5InLpf9jwsO3CvcCf6aniXph9sR8AbqtXTvxhuEspS18QirLhiOnR98F9FEAMDH5HM5Q8258jqUGb2YPJwK4Xcr2Yb5HSThue0+jJBm6MUt9PKHBMbeSyzpkO4ldhNOrcF6UhaW+Poptwcnlo+kjR9J1JPCunsFt7r0p/+qJMysM1xJWFmpkMLMj5Sp7f9Tm3W0G6PYjvohKqO5QhvP2diq4O0nK1+tlBYNzKvVwrSwU6GuA1j2zYY4nbMBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6192a8-1da7-4848-3dca-08def84b6787
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 08:26:28.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvyCaiA30zPAQMglF6U6NUqvN7Shsww/yv29/EMDuWYoKtAirZ9Rs1EYWP+uriTN0/iiTntlSbmoXBS/W8EHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-OriginatorOrg: intel.com

On 11/08/2026 19:47, Florian Fainelli wrote:
> Hi Ulf,
> 
> On 6/10/26 10:01, Kamal Dasu wrote:
>>
>>
>> On Wed, Jun 10, 2026 at 12:53 PM Kamal Dasu <kamal.dasu@broadcom.com <mailto:kamal.dasu@broadcom.com>> wrote:
>>
>>
>>
>>     On Wed, Apr 22, 2026 at 4:51 PM Kamal Dasu <kamal.dasu@broadcom.com
>>     <mailto:kamal.dasu@broadcom.com>> wrote:
>>
>>         This series adds mmcpstore, a pstore backend driver that enables
>>         persistent storage of kernel crash logs on eMMC devices. When the
>>         kernel panics, pstore captures the kmsg dump and writes it directly
>>         to a dedicated MMC partition using polled I/O with interrupts
>>         disabled.
>>
>>         Changes since v4 (addresses Ulf Hansson's feedback on the v4 panic
>>         host path, linux-mmc):
>>         - mmc_panic_claim_host(): log claimed, runtime suspend, and
>>            ongoing_mrq before claim; always call panic_prepare() when
>>            implemented so the host can drain or gracefully terminate
>>            in-flight requests, then force-claim. Vendor controllers may
>>            supply their own panic_prepare for platform-specific cases (1/4).
>>         - SDHCI: reference panic_prepare implementation; longer drain/reset
>>            timeouts; document panic helper return values in kernel-doc
>>         (2/4).
>>         - mmcpstore: single prepare/claim path; panic_complete() after
>>            panic_poll_completion() on panic writes (4/4).
>>
>>         Changes since v3:
>>         - Fixed kernel-doc warnings reported by kernel test robot:
>>            - Added missing @param descriptions for sdhci_panic_prepare(),
>>              sdhci_panic_poll_completion(), sdhci_panic_complete() (patch 2)
>>            - Added missing @sect_offset param doc for
>>              mmcpstore_do_request_internal() (patch 4)
>>            - Fixed kernel-doc function name mismatch: mmcpstore_read() ->
>>              mmcpstore_read_zone() (patch 4)
>>            - Added missing @disk param doc for mmcpstore_card_add()
>>         (patch 4)
>>         - Removed unused 'offset_bytes' variable in
>>            mmcpstore_register_for_card() (patch 4)
>>
>>         Changes since v2 (RFC):
>>         - Rebased onto v7.0-rc — no longer reverts any existing MMC core
>>            or SDHCI changes (v1/v2 accidentally reverted recent upstream
>>            commits due to being based on an older tree)
>>         - Removed all erase/bitmap tracking logic — MMC/eMMC is managed
>>            flash and does not need erase-before-write; the pstore_zone
>>            framework handles zone management internally
>>         - Uses standard MMC core request path (mmc_start_request) instead
>>            of hand-building mmc_request structs; panic-context I/O is
>>            handled through proper mmc_host_ops callbacks rather than ad-hoc
>>            code in the driver
>>         - Added panic-context ops to mmc_host_ops and sdhci_ops for clean
>>            separation of panic and normal I/O paths
>>         - Fixed deadlocks caused by spinlock contention during panic
>>            (lockless mmc_panic_claim_host using WRITE_ONCE)
>>         - Fixed data corruption in pstore recovery (zlib_inflate failures)
>>            by letting the normal sdhci_request() path run instead of a
>>            custom panic request handler
>>         - Added PM suspend/resume support with eMMC re-initialization
>>         - Supports module loading or builtin loading of the driver
>>         - Added MAINTAINERS entry
>>         - Split into 4-patch series for reviewability
>>
>>         The series is structured as follows:
>>
>>         Patch 1 adds panic-context operations to struct mmc_host_ops and a
>>         lockless mmc_panic_claim_host() for use during kernel panic when
>>         other CPUs are stopped and may hold locks. Host drivers may replace
>>         panic_prepare with vendor-specific code where needed.
>>
>>         Patch 2 implements the SDHCI reference panic_prepare (graceful
>>         termination of in-flight work, then polled completion paths); other
>>         MMC host drivers use the same mmc_host_ops hooks with their own
>>         panic_prepare where the hardware differs.
>>
>>         Patch 3 adds mmc_blk_get_card_by_name() helper to look up an
>>         mmc_card from a block device name, used by the mmcpstore module
>>         path for card discovery.
>>
>>         Patch 4 adds the mmcpstore driver itself, which registers with the
>>         pstore_blk framework and handles panic writes, PM suspend/resume,
>>         and dual-path registration (direct probe hook for builtin,
>>         mmc_blk_get_card_by_name() for module). Also adds probe/remove
>>         hooks in block.c and declarations in block.h for the builtin path.
>>
>>         Tested on Broadcom STB platforms (ARM64) with SDHCI controllers,
>>         verified panic dump recovery across multiple panic/reboot cycles
>>         with kmsg, pmsg, and console pstore; also tested with concurrent
>>         I/O stress before panic.
>>
>>         Previous submissions and related work:
>>            RFC v1: https://lore.kernel.org/linux-
>>         mmc/20221216212738.7928-1-kdasu.kdev@gmail.com/ <https://
>>         lore.kernel.org/linux-mmc/20221216212738.7928-1-
>>         kdasu.kdev@gmail.com/>
>>            RFC v2: https://lore.kernel.org/linux-
>>         mmc/20221222185948.12717-1-kdasu.kdev@gmail.com/ <https://
>>         lore.kernel.org/linux-mmc/20221222185948.12717-1-
>>         kdasu.kdev@gmail.com/>
>>            v3: https://lore.kernel.org/linux-
>>         mmc/20260319185705.1516950-1-kamal.dasu@broadcom.com/ <https://
>>         lore.kernel.org/linux-mmc/20260319185705.1516950-1-
>>         kamal.dasu@broadcom.com/>
>>            v4: linux-mmc (same thread as v3; superseded by this v5)
>>            Marvell MMC pstore attempt (2020):
>>         https://lore.kernel.org/linux-mmc/20201207115753.21728-1-
>>         bbudiredla@marvell.com/ <https://lore.kernel.org/linux-
>>         mmc/20201207115753.21728-1-bbudiredla@marvell.com/>
>>            pstore/blk documentation:
>>         https://www.kernel.org/doc/html/latest/admin-guide/pstore-
>>         blk.html <https://www.kernel.org/doc/html/latest/admin-guide/
>>         pstore-blk.html>
>>
>>         Kamal Dasu (4):
>>            mmc: core: Add panic-context host operations for pstore backends
>>            mmc: sdhci: Implement panic-context write support
>>            mmc: block: Add helper to look up mmc_card by device name
>>            mmc: core: Add MMC pstore backend driver
>>
>>           MAINTAINERS                  |    6 +
>>           drivers/mmc/core/Kconfig     |   12 +
>>           drivers/mmc/core/Makefile    |    1 +
>>           drivers/mmc/core/block.c     |   56 ++
>>           drivers/mmc/core/block.h     |   18 +
>>           drivers/mmc/core/core.c      |   54 ++
>>           drivers/mmc/core/mmcpstore.c | 1511 ++++++++++++++++++++++++++
>>         ++++++++
>>           drivers/mmc/host/sdhci.c     |  173 +++-
>>           drivers/mmc/host/sdhci.h     |    6 +
>>           include/linux/mmc/host.h     |   12 +
>>           10 files changed, 1845 insertions(+), 4 deletions(-)
>>           create mode 100644 drivers/mmc/core/mmcpstore.c
>>
>>         --         2.34.1
>>
>>
>>
>>
>> Ulf,
>>
>> I'm resending a gentle reminder regarding the v5 patch series for mmcpstore.
>>
>> This version addresses your previous feedback on the v4 panic host path and includes several key stability improvements:
>>
>> - Implements a lockless mmc_panic_claim_host using WRITE_ONCE to avoid deadlocks during panic.
>> - Adds panic_prepare to the host ops to ensure in-flight requests are drained and runtime PM states are handled before panic writes.
>> - Uses standard MMC core request paths with polling-based completion for robust I/O during a crash.
>> - Includes full PM suspend/resume support with eMMC re-initialization.
>>
>> The series has been tested thoroughly on Broadcom STB platforms (ARM64), verifying reliable recovery of kmsg, pmsg, and console logs across multiple panic cycles.
>>
>> Please let me know if you need any further information or if there are additional changes required for acceptance.
> 
> Is there anything we could do here to move this forward? We have large number of devices in the field that make use of that feature and we would really like for this to be included upstream and usable by others as well.
> 
> Thanks!

Perhaps start by describing the problem.  pstore_blk already supports
block devices including mmc block devices, right?  Have you any
information on how well that works in practice?  Is a dedicated mmc
pstore back end really needed?

What are the generic requirements for a pstore backend?  How do they
map to requirements for mmc?

How are big obstacles handled like:
- the device is in use
- the device is runtime suspended
- the controller is runtime suspended
- a runtime power management transition is underway
- a system power management transition is underway
- reset or recovery is in progress
- the panic originates in the mmc subsystem
- switching emmc partitions
- device tuning / re-tuning
- maybe other things?

Is it so that in some cases the pstore back end needs to leave the
mmc system in an operational state?  Whereas in a panic/oops it
could leave it broken?

