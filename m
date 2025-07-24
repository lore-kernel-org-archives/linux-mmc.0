Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229D2DE719;
	Thu, 24 Jul 2025 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365149; cv=fail; b=Y0JPfJmwT16isnIAh2nv1+85s/jIB1XLU84gNGkUoLQlFQVGbSx78rALe6yyBnrI6Sq4Gig1q8EOcUh/5XwLHLen76bSn2eFGvZWOMWdDzwjNx/mgFcpzEykJMTgdyJk7nz7QI6EiK2VanqXMnREyZhigNN82FuLz/nbP/J6jDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365149; c=relaxed/simple;
	bh=WxEU0AzbBw+AfQFseMeSrw8ymCZ81PmZ2/H28nfI9fU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b+h0qebT49X5NjAmBzLTNF9vaZiJ5lEYhlXkWtKSTcR+9Dm4DhPrz1t05J+M/g7PjEpJ68y5dZuB1nhiDNxHT5fbhS7nBDbFJSZ0x5gabCX6dOjjcT7QJCas5Z/tkVZjYJ2CiXlSnatb1Ha+TES/GaIMkKp6OOCDCrnkOMnOPGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1oB/1Er; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1oB/1Er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753365147; x=1784901147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WxEU0AzbBw+AfQFseMeSrw8ymCZ81PmZ2/H28nfI9fU=;
  b=W1oB/1ErZAUVQtKbMuvJqEXqJ6oW7SHyD9kw3NDHTVRZk76zZqERaC8H
   HAfnjoHVdFdmUa2WsZbj5BnEU+JYiy2CFfwaDfE+DgMbtir565Gbhc74e
   +1n3P9aI5h82Ld5ykFAyLUs5qgy9tUfPLw40rcMoV676zNrVhbU4iGuJI
   ijyNIVQqho6FS6WOZYKd4r9w7NUqmNK0cjdb156dkmizmIdrBtnnj/VdS
   T8U65SIGLbV9+a1HxRxHm1mG9MwCnNLYr6hxkTVqUhzXM7HLgDf9b1YUX
   iswnNZZ1cOyTnfumBqcEGSW+Vr1/VpEBX2YWT5OqQAyrLqU4JlxsOqrzA
   Q==;
X-CSE-ConnectionGUID: Wu3FX5sqSt+Q6NeT2oMHWw==
X-CSE-MsgGUID: pHy7I+kJQay+tcDyvKz6dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55618914"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55618914"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 06:52:26 -0700
X-CSE-ConnectionGUID: IAYCRoMkT0Ctq4qrIqIK6w==
X-CSE-MsgGUID: PTrYRn56QYGueAOug6SdeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160369552"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 06:52:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 06:52:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 06:52:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.56)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 06:52:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx2KK4q0cP12DakxkCOjQKDCQMPxTravxtPM46ZGxGDVLAjZG5AT1AP6W0LIlNA36tAOVQL+jHc65ebXeJ6od3XUEyEAdWsVHA+ZUA7KctawuLNLsaNwNUZUw53G9L9L4/AtjJ53wAAlPfHYtlIqYsdRc4+VZxAhPLJuItQeMagh6nIdTa0m9RPvo7t3UgPse5PBnHr5aOETxdq1XonL+6KargC1QKua94sK6qvzdLXVzEknJdZY6Xk22j1Im+iDNOX+l6VcLZW3o2RyUp4cuO6NeSSut8Qeu0usoBomZCBJuhxBz0M/EEH91f9MfwBnKoS8NFMuR46LJ8bqizIrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC+zpGEYPrYwRNE/b0z7bP1ixh5O1Ie0PQLCzORzCWA=;
 b=ckwqrRBcQr7e+Ycb/ZiXwDaleeIjIyPeqW7qXFQKgHCurpNds1DrwD29ud21nyEc6qd2FZ7cOMAb9+mqbTexf0p0NmY4bo664jKeLxp9CIvJy6L29XAd8/W4Nb6dyN/0UEPglZwuDNdrWRfogy3egLeiVjKPbpY3r15AA5QbHDI2t6xsYRQGdxuqqqS908ccEmWCmjeHIT8snJMRi2ttin2dHGecseGJRWA6YgPJHQM+3Mrti3OlzugGaS6IVESZKm5FAU/wlHxRiWS3Wac1dvToJIPChg1GHPbBThhPW6Sav4TyML8kSB8nazZmgARu/gE0i3OsRxQry7t/zZaxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB8070.namprd11.prod.outlook.com (2603:10b6:8:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 13:51:55 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 13:51:54 +0000
Message-ID: <4385ad70-f583-4ae3-ab14-cbc0cfe5129d@intel.com>
Date: Thu, 24 Jul 2025 16:51:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] mmc: sdhci-pxav3: add state_uhs pinctrl setting
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <phone-devel@vger.kernel.org>,
	<~postmarketos/upstreaming@lists.sr.ht>
References: <20250718-pxav3-uhs-v1-0-2e451256f1f6@dujemihanovic.xyz>
 <20250718-pxav3-uhs-v1-2-2e451256f1f6@dujemihanovic.xyz>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250718-pxav3-uhs-v1-2-2e451256f1f6@dujemihanovic.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0262.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::27) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: ba968b3b-1743-421e-4813-08ddcab93f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlRqb2lya3hndmZIYlEweXlhc1hLcEZtSjFaQ3oyWitkOFZyT0RhOERtZjJ6?=
 =?utf-8?B?M0NRb1VlU0t4aEhzUFdGTnBuYU90NTRNYXdrVmFjZVlEc2pSL0Z6Z25DditT?=
 =?utf-8?B?Skt3cFYwWlhzZ1RWUFJBRys5ckNPYnE4T243QWN3VFcxVDVhRitBUG1Yb25W?=
 =?utf-8?B?ckc5TkFUZWdLN2F6QlJhY0txb1hMa2ZNY3BhU2szT0hZcC9yVzUxMERJdGR6?=
 =?utf-8?B?ZlF2SDBvbG9YdkFnVHVoSVhVUHo2ZTlHWGpKRDZBS3NvdlhrZ3ErdVhLRzF2?=
 =?utf-8?B?a3BDV2RqT0JUbHZUUE9GcFlRRlhyNU43UHRFdFg2VjlsUnZYT2FmTGxHaVFG?=
 =?utf-8?B?emVKWlg4UXBIOUtNOXBadWpVVWhPZ1l4UVNRNGdQcUtkTkkreGMrYU4yWmtC?=
 =?utf-8?B?WUE3R1Baa1dmL2JmQldXdC9TOFZVNHFZQ3V0dDFKMkJvUGdzVmsyYTdwR3JJ?=
 =?utf-8?B?ajRVM3BWNzdQMVhQblFjQjE1UGRtNU55cXluRFFyVGN5SGlDMWNSMXJjNCtH?=
 =?utf-8?B?dHpWS3JWcGpST1lJbnNuVjAvMUUzNEpEc09EaUIxZkNRSEd0MUlqNTNqZ1Z2?=
 =?utf-8?B?MTJZT0xLSktLNWE5ajJWRm00ZmFudlVjandBbUZiSERBMDBsRVowSVRMcVhP?=
 =?utf-8?B?anJFbWdEQm9NR2hLVTgvTUgweVFDdVAyKzJOYzJnMnpYb3I4VGh4aW1vb0p6?=
 =?utf-8?B?ZjRjVWtuekFadkVFVTFWZmd1Y3l4cEhaY042Sk5UeDExS1Ryc2libXczQnM2?=
 =?utf-8?B?ZG0wdHlER2d6NW9FaXJsSHFGY2t4c1FxK1ZSTE5sMWZnNXM1b2FVc1RQMGIw?=
 =?utf-8?B?NmJvQ1J4VE9DZ2diY2hRakliZXdnNVlXbklwa0dyNTd0WnBwNlBzRkZUZGUv?=
 =?utf-8?B?Vm1VbDJIZEJwT01GcXYySUcvKzhiNnlMTVBwTENwU2xYQVlXcXVaSy85bzlM?=
 =?utf-8?B?TkhSank1YzVjMWN5UnI3RmlPZjVVdDJvellieE9QdFBhUjhWbTJTZm5CS1BE?=
 =?utf-8?B?bTEzMjB2VG1jeEwveDQzUktDWHdId2tUV1ZYVTV1ejFOSzhmNGUwNUIyWXM2?=
 =?utf-8?B?UEF6aDdTQUxlRGxKMXdxMjNFSm83dE5oMDlCbXJxbUgwV2JYSzNIdmFXK3A2?=
 =?utf-8?B?OHp1S0lHcWkyN3ptdEgwbXZrbmNia3c4TUFpc1VZN3lLdFFMQjdDRjZ6dlUw?=
 =?utf-8?B?ZTVTZy9haEx5L3JtdHFyVnkrNHdXZ2gyUndsS3hjbXYrR0pLeUJzRTNRTGpF?=
 =?utf-8?B?cUkvUE41NzFPZEIyOXdwT3lIVjdzNE53TWRVMThmWElEV2JXNVo3OHQrOXAw?=
 =?utf-8?B?MnJ4VUNZejNMUTVaajF6MUliSGxsNDRiYUVpQlZXajJSSS9aVWJCQ3ErWnVL?=
 =?utf-8?B?N3NZN0wrenRodEVUOE1zRWVHTEc2dHJTbU5vNjhFOFdXWXR3WnhFVGg4WU1y?=
 =?utf-8?B?RUZ1bHp3TnJLZmlrdEtkcVNsL2RVQkNPT1BvWXBPbmg3empRL1NKUWZGVnVY?=
 =?utf-8?B?QVFxMWp4dnQrQm9nVXRNVjQyRERDQzlnQWNRM0djbVc4S0RyTXhSMDBlbGE3?=
 =?utf-8?B?cHBDVlRLUWltQUtlR09JQXR4SFBTbWtOSUVWclZ0L2thN1Fpa0pRQXRPN2Ex?=
 =?utf-8?B?UGdoN2hTem52dWl1K0R4OUYvd2FWeTRPNVhXN2dWRVVuV1UxQ2l2eDJodEVM?=
 =?utf-8?B?eGZvNTVhUWU4T3BMVmt2OUdqUy9GLzlyVHVSVmFaMCtEQzJidGJ4M0ppVUtx?=
 =?utf-8?B?eVlwZnBBeXM0TnVJSWEvMm90MXY1RmNqZ0RGNVJKOUp6Y0Z4dHFTT3dyMDhY?=
 =?utf-8?B?RUhydzdKWUZPdU1HU3NpQ0NJNWpTYlFieEJOeU9PbzE4RUEzTG85QjVING1a?=
 =?utf-8?B?NDNHaFVXS29lQjJTZ2crWm5Qb0NaUDEvNEd4TVdwS28xOXFBRkFxWkVrRE1o?=
 =?utf-8?Q?lihjl9apjc4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRaS0Y3ckZNZlM1WUZoQzc2NUpvSkx1cHAvaHFuelc3czJ1SFpoTklEM0Jr?=
 =?utf-8?B?Mnd0OVFRc3VOQktGaG9lNkF1czJGbGtPdDRJaEt3STh5dUUxWGxpTWI5MHYy?=
 =?utf-8?B?QjNlQzZNVjM5UVN1SWh6N2s2cFhPcDJUTHNwd0ZhVW1Fc2NUVWI4MDQxRHpJ?=
 =?utf-8?B?VTZobzBvNUpkaGcxV2ZCdWxtbmJRSFhQQS9DUnRrVU04MURKN1UyME9vQmw4?=
 =?utf-8?B?cDRFbWQ2b0dLeDNvRlNvWWRraWlZOFplNVV4czJ3MjBOL01JOFlLR0dwRmU4?=
 =?utf-8?B?amZ4YTRVakVRR2xUc1ZFT0U2NlQ1cjEybVpPa1Zhb1gvK2d3MnVUa2dZRWhC?=
 =?utf-8?B?YTBSOEo2K2E0MlBkT2pSNkhZMDZxN2VsMlpuais2bnV2aE1kZm1qckhYYm1u?=
 =?utf-8?B?clpGSXFHL2ErZFlUQk5mQ0hVYU1HUlB2eElDMWpXdFZROHJSYUpNMXFodHBu?=
 =?utf-8?B?b1pPNHU5VzVzZ014UVNTdGY0NHYyRDBJUGUyMjlIWnN5TWw2OEg2TWxScVBI?=
 =?utf-8?B?cEZkQ0J6TXdjZ3V0Tncza3hTYWxPN2tNcTc2UlFMSzJVSEUveStPMzF3RjIx?=
 =?utf-8?B?emdBVksxNjJmN1NzMlFvcmlzMzBHNDZZREJPWDZxS3p0bHFRNFkxMm1SYlA2?=
 =?utf-8?B?ZUdNRUxrYnlEMXNQRjdsL2xsNVJHM1J4RmRaT1E3OUhTN20rQ0RGbnNwT3F2?=
 =?utf-8?B?T25WYjRoemIxNm9qbGtJMjNpRy9DUlFqcDNwSWZTTHczRU96cXQ4dDBwTEtq?=
 =?utf-8?B?TUk0SlBiT3RudThYWFpmZ1ZhM0h5eGRudDV1QzM5Szl6eEJ5ZWpUcmd0bHgr?=
 =?utf-8?B?MGxiK09CMVMySXlhVHFUZFRFdWlqaVUveldSaW0vTTg1SThJRDRVdzVxUVNl?=
 =?utf-8?B?b3owb1pLUER2QUJFNEFPSGVKSVhlanV6elVBbU9nRDY4RHE2TEdmZ3JBR2JU?=
 =?utf-8?B?MWZOY1BxcFZPRWE5MXVpbnBTN3ZBcldIdEtlMGlnL1kzOTdRVTdUbEZUT0Fv?=
 =?utf-8?B?bjVlUnV4NHA0NFh6c0F6OFgybTFpUjB2V1d1TW1XNlU3SzlkRGlRNzlyTGpz?=
 =?utf-8?B?elRZSEhLVnF4ME1TUWxJM1U4Mjk2Q3U4ckZrTU9LV2tMN2xobE9NR05wTWs3?=
 =?utf-8?B?ZTRSU3g4cXJYbml0dFdsd0RhZ1lhUTUweHlzT3BJQ3Noa0NQeStKenFpM0JI?=
 =?utf-8?B?Q1ZOeWRUSDF0WUdNcWVxNzN6aGh1ZDJocDhnQUpFVTgxTER4NkFwVkFGdmRa?=
 =?utf-8?B?VThzVUpZdXRaUnRqaXpQZTBPYkpWVFFHRE9YSkNUMVovVHpoN21sQmVuV0ky?=
 =?utf-8?B?NWZmRkVRYTVRWHhoR2poNiswN1lXK0s2TTZzZHV1NGVqd2NHaGRNbXpuUXFP?=
 =?utf-8?B?ZngyWjhZRXVnRVRrQTIxY0JWOE5rZHFscGVkNWJ4NU9yWEFRWVM0U3RscHFv?=
 =?utf-8?B?RjhoMnUwVk5paWFOTUtNT0YxTHhiVWtJQzlqQWpDcExGQTJOcVIzMnd0VTBS?=
 =?utf-8?B?RDRqdGpwSDFpL200M3JGU1BOOFk4SUxjc2hSK0xRK2hKS2xJcnlvYmtoQ1hQ?=
 =?utf-8?B?WjFXYVNzc2twTXlvWUxJVTJ5UERDT2RxN2RxNGdLNkpNQ3Z5dEVIOUJvODJx?=
 =?utf-8?B?QlJSWmxCS3VCUzhoMGg0cUw1bUtyZTdPR2g2QjB2T05RYThxazlsWkppcFA3?=
 =?utf-8?B?bk9pcEd6SzM5ZmhjQUl0c0o0eUMwRGl6bFBDbkVnQ0FIUnBxOFJ5OENMZ1R0?=
 =?utf-8?B?NzVxODRuUFFrUitKMlBLdXd3Y0NjRWJqQW1oZndqSTdyTGpPbVo4UklZZlRI?=
 =?utf-8?B?UFgvc3BaMWZXaDk2UHhQb0FXVzkyRTBvdGJIT1lKdnhVV0VmbG5wVlZ2UWNO?=
 =?utf-8?B?UytVWERmaEFVMmxJRzFKSjdJQzRZdEhxclI4T0JXbGNFTTZYZVM2bEJHZU1X?=
 =?utf-8?B?Y3J4ZW9KWEZMSWtLbW1LMGEweWtEZXBqdEF1b1JzVGdmWExpRmFLcU5EWWRu?=
 =?utf-8?B?TmZMUGE1dXBwYVBkeFRKUGJRUWJ2VGQ0dWdpZ2JBKzJLVVgwZWxseWF0eElH?=
 =?utf-8?B?em1XMVNLL2dHUi9IWU4yNllNVGpnUHF2VHNWQjBQZWhJQ1AxYVQzQWdEZ2V6?=
 =?utf-8?B?QkI4UzVlMCt5V0FBdCtPSEVEay9JTjhkV0U1Y0lSbTFRQ3V3TE8wM2FYYUxh?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba968b3b-1743-421e-4813-08ddcab93f90
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 13:51:54.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xxldb8cLu7TPKqrRI1vElIugZWgKiCd1tTEM7aRd8IwAZwa8WMh4NHj8QINNo715T4Dljhv8K3B5V7USK/GDBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8070
X-OriginatorOrg: intel.com

On 19/07/2025 00:12, Duje Mihanović wrote:
> Different bus clocks require different pinctrl states to remain stable.
> Add support for selecting between a default and UHS state according to
> the bus clock.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
>  drivers/mmc/host/sdhci-pxav3.c          | 30 +++++++++++++++++++++++++++++-
>  include/linux/platform_data/pxa_sdhci.h |  7 +++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3fb56face3d81259b693c8569682d05c95be2880..0e1bd75a1252e5559deb0b3caabcdc75919aee3d 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -20,9 +20,11 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mbus.h>
> +#include <linux/units.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> @@ -313,8 +315,24 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
>  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  }
>  
> +static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> +	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> +
> +	if (clock < 100 * HZ_PER_MHZ) {
> +		if (!IS_ERR(pdata->pins_default))
> +			pinctrl_select_state(pdata->pinctrl, pdata->pins_default);
> +	} else {
> +		if (!IS_ERR(pdata->pins_uhs))
> +			pinctrl_select_state(pdata->pinctrl, pdata->pins_uhs);
> +	}
> +
> +	sdhci_set_clock(host, clock);
> +}
> +
>  static const struct sdhci_ops pxav3_sdhci_ops = {
> -	.set_clock = sdhci_set_clock,
> +	.set_clock = pxav3_set_clock,
>  	.set_power = pxav3_set_power,
>  	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -441,6 +459,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  			host->mmc->pm_caps |= pdata->pm_caps;
>  	}
>  
> +	pdata->pinctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(pdata->pinctrl))
> +		dev_warn(dev, "could not get pinctrl handle\n");
> +	pdata->pins_default = pinctrl_lookup_state(pdata->pinctrl, "default");

Mustn't use pdata->pinctrl if it is not valid

> +	if (IS_ERR(pdata->pins_default))
> +		dev_warn(dev, "could not get default state\n");
> +	pdata->pins_uhs = pinctrl_lookup_state(pdata->pinctrl, "state_uhs");

Mustn't use pdata->pinctrl if it is not valid, and probably don't
want to change pin state unless both pdata->pins_default and
pdata->pins_uhs are valid

> +	if (IS_ERR(pdata->pins_uhs))
> +		dev_warn(dev, "could not get uhs state\n");

I'd suggest dev_dbg() rather than dev_warn() for all the
new dev_warn()s

> +
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
> index 899457cee425d33f82606f0b8c280003bc73d48d..540aa36db11243719707bdf22db23a8e2035674d 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -35,6 +35,9 @@
>   * @quirks: quirks of platfrom
>   * @quirks2: quirks2 of platfrom
>   * @pm_caps: pm_caps of platfrom
> + * @pinctrl: pinctrl handle
> + * @pins_default: default pinctrl state
> + * @pins_uhs: pinctrl state for fast (>100 MHz) bus clocks
>   */
>  struct sdhci_pxa_platdata {
>  	unsigned int	flags;
> @@ -47,5 +50,9 @@ struct sdhci_pxa_platdata {
>  	unsigned int	quirks;
>  	unsigned int	quirks2;
>  	unsigned int	pm_caps;
> +
> +	struct pinctrl	     *pinctrl;
> +	struct pinctrl_state *pins_default;
> +	struct pinctrl_state *pins_uhs;
>  };
>  #endif /* _PXA_SDHCI_H_ */
> 

