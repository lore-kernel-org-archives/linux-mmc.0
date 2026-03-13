Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB25B36B048;
	Fri, 13 Mar 2026 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773385839; cv=fail; b=thPO5CB/wo7GaOMYDR7DX+xUnjU1zZPxFAS0dhwGhH9kFSQqFjRHPUo6P+cJrMDo87gZ+YEwjy34rl6iFpFylMpHDm1vn0ZTJbICth0D8c+wExnWzMb1YdfA9o87U7gQo9F1zeIdg9hdRnfHwbkq+Qkrl1Q3RE/l/ZuckfnIpwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773385839; c=relaxed/simple;
	bh=anG1P3YGJoFtZJMkvG71G4AmZNZQihvsNjQUCwMomLU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YmFYPJ1PjLtzQz46Z5R3E+3Rq4KHMTAGSHzDw9HeFgh3AzOkpEjdHUUCeBLkYrh13Gc+4wgy5NxmElIC6gu4HEwPuwz1ujSdlpirenIJwqFtKEqES53UpWxAiUe0IXod0rUJK5lrbrioSBuM+FeeqIqxo5FyTymD0VOx3weQh1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pe8XgGoG; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pe8XgGoG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773385837; x=1804921837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=anG1P3YGJoFtZJMkvG71G4AmZNZQihvsNjQUCwMomLU=;
  b=Pe8XgGoG3EKvpADqUEGGFfXlrYZNSjY6L0EGS7yKxpLuUqnAxsWzGD2h
   jhlO1ykuSQVe7dZX7+BavJrY71I8HbWgOawwGuj8dx4cwCMmuxmybiYJ/
   3ByljbGrXKkLw83vNiy0kvSHxPkZazqcYrhp8QH88By+56NTc168EhDxD
   tzXADalwE4em2V6H8SXj3GASqn/0EzUuMu8Uthggp0bKa4InP3KdU80JP
   gvTigtTsKq19Xbj9KevLLhlpGkqgFUyryt68ifHIRqfPsCsc7SRuepFvS
   T5CG4Ch5bhcBygvzJIzVw7qZY2z2yfRXrjMALTCN/nT0U5ftZ+XCVVb6c
   w==;
X-CSE-ConnectionGUID: XH5JGg+ySF+8MSrpjKeoIg==
X-CSE-MsgGUID: zQnWSQvUR8eMyHADRZbW7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85970984"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="85970984"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 00:10:36 -0700
X-CSE-ConnectionGUID: 4662wxmAR+e1EqNGExQHZQ==
X-CSE-MsgGUID: LYRx+s5kSKahQFnAnBGwdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="218829611"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 00:10:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 00:10:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 00:10:34 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 00:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4ghdjb26z6BMuLYSjUsfwHycQbgfihanG70+Kzvg8kZMo5SChYlFtr66SZXf0rJonXuYfxTpsyop83NyJkf2HLQtgpToqGAYJLSwNOynEPJ2W4oQ8uf7Oy/30xHR8By+lLOngfkpwOecjvop5zSJ6T7zs4NUuRiPDaHJB2HCBp1Kwg5tuPLTEBNwGI7+in27XZpU4ymnoGNKKK4zZJ1RQLxf0FbgAl7DSOFFE+urgubUNhImR8jkkLtEriJBkeU4QLFkL4nKScFAXbkAYNWnWdfxcH4+5D07+AFKafHdFBiP+QNI1d9MM3q8pIzHOGT7hE7q3iNVFyT8JEKF9NBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIw1G4tPylEk2ECYdqjO+lK9XQkkHdDvlqZojt803eY=;
 b=jnFOan/DNXUqC8cAmuGAoig/ap7PW6yGEdT2amwyk74eoIM7lhzt09oZ2vhjfTfXzhc4xjPGOOdlVM2Mpp7ov6UgSMm4PxxXECHz11IYGosn7RIYlPL9x6Vt1Zxssc9ZrvHkOecNaI8CQWxijQuQNhZBgCRBu7aNYLd6VZB5g/lP/PM20hkQVaq2S9hjF/0CaVCLWhDVykesXLH4VzKi7zmTzAdb4PDCdmsyZOAR67DZwnvgAx+DKCuZnehmmOySqEq3G/fXZeXSXUfHJQ3qicrCqWYBHyERlSL8e3JEuY9uqtxL/pFj1X9+WPgL0S3GQOiv9jYQ6OtbcSmrsRUmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB7309.namprd11.prod.outlook.com (2603:10b6:8:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 07:10:28 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 07:10:28 +0000
Message-ID: <41692167-1af7-4cde-a853-ef7b79dda9e6@intel.com>
Date: Fri, 13 Mar 2026 09:10:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
To: <nick.hawkins@hpe.com>, <ulf.hansson@linaro.org>, <jszhang@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<shawn.lin@rock-chips.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260311181112.1700667-1-nick.hawkins@hpe.com>
 <20260311181112.1700667-3-nick.hawkins@hpe.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260311181112.1700667-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0196.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::21) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 8551d950-9fff-474c-4efe-08de80cf9af7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 57s8Tz6LQIpH8NsSM1571cWfbpn3vq+1luMKHBCLoGkHnKLyEhPzyRF+TkaSPPstMEJiDVHZw7aUPb7xsOMjSqihAalrdgOYC22/L9h9lp1kjAkXwmVuzSGJgwlNqNXmYr/DbE3hhZ3h1OMZcDnnUX5su0CUzB05eqvjWWDTafHyhkGBMViPnDBQ/ubT3VM/RtrSkAe7Hxmr+1SLNF4gYRBiSDIG2kYEZMg8QYnd83FDFHDMlpx8waIKytTVCZKARxj4nQPtvW7GoEvO2Ln47eRaqZf1vod10HyDyMkDzCbj0or1Rb+ednN6hUGfvPNDbGBz9uBlS1zN+eGZ2xko/8PMOLG3pISN9Ebtny7J3O2CrIzD0ah0i4AjVUL9bS6cFOl0UEqvIC/XfsfUl2z9Xch1YL1fSM3zTVqVw9WSmaw/ktw01qm3RO4u9lcnHYXxUbGktGs3JIsTJl5heYNIwa6+B00ljNRfXdjTyuprly1giG3WHD83saFFdYGseJzOsCyIOJG7Tp9Mm4d3J7F5J+xNV+az4fH9kVvia7c7Rwq0SDJAufRX71aV//RSU/uHnJ0/QeSbotW9wU3jBUe8MGru8V5TOPl2LY35EAEbU09ayrnchZLBCM4Mj+sMyvi9CkokGAySrg23AjaxbIwqOiETRTTwfTuTr0coJoQo2kcxd4zUTlVIksxxnA0v8WgwHi1BpREpkN+yNPBIr7n8MnlGT1arnguro0BLB8Edjpo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pBaUdQMFUwdExUNnhtVStpUjFOVjJla05kbklzTCtYcEJwKzN5M3FtbzYx?=
 =?utf-8?B?a21FWnFIcXpHQ2p1MVM2dDF3cTVDMUJJNG11OGVmY2xDWHpiYzZ3bDZ3bGpm?=
 =?utf-8?B?RGRpWnRsd2ZQUmY2Q0t6UFhHNVJIc0k0UU14ODVlcU1jYjZmY0NQRGEyVjFh?=
 =?utf-8?B?MWhYeEY0RGpISUN4ZW11RVZtY1JGVHBHVlhlRlRzcFNzczVBMHdScTVubkNa?=
 =?utf-8?B?WUZ3Zk84eDU4eTZYbEJKOEhFMkp2eVE3ZWdVdVgvOERQZlM5Z0hzaTNhMGVS?=
 =?utf-8?B?dkI4OUtUUnFMUzcvU1RYQnR5dUtVY1FiVm54T09hM21IdU5DWHBKeTB6S0di?=
 =?utf-8?B?cklvRWZIdFl3SG5TVC9CcFpNSjQzZXpiRmdCYmZzT2xFK05teWVBU00yb2Ft?=
 =?utf-8?B?aDhrbmE0UUJtWnRjUnlNamxKd1FaNEJxcDU5WkJNakd6L3N2K0NhdVorTC91?=
 =?utf-8?B?Vk0wOVhjNWM5dmdJczBRbFNxaHpCblVNS2xwdkY4cm9tWVBlWGx0eUpsclc1?=
 =?utf-8?B?ZDJkNU15MHN0Z200Qmc3cWxOU2dwdmtoTjB0NzdhN3VFVTJBdmw2dTJJazZR?=
 =?utf-8?B?QXZGdE1iWSt1cVZHc3ZydHNxUTFjdGRGYXVyUW0rVHZFY2x2TFA5bXR6RHF3?=
 =?utf-8?B?NUZ3aWcybGY5VVlnNDhBQThSTkR1c1R4K1RXWHNBMjZQNUh5YmxFNzZZKzVR?=
 =?utf-8?B?SU0wODA3Ry9zR0ZrNXYxN09kNU1uTW9IRlpqTm9wdEh6T29kazVubHZqa2Zt?=
 =?utf-8?B?VnVOSDJzdXc0VklEdFpOQmlGeUM3YWIyU0RlOGJMRW8rTjBnaVBVUDU1dktx?=
 =?utf-8?B?SU5oMHJFVTZLK2d2aXNaZi9DaXJnY25lZ1AyTE91ZXk3ek95emlDdmpka1BG?=
 =?utf-8?B?THVyYi8xalV1UGZXU0VSMTQ3THdMQnoxdmpOZ0xOZm80TWU5TmU5bDZtVlZl?=
 =?utf-8?B?YlJHSWhhODh0TjZCMGx0N28vUnV5cWkyU1lXaFVNbktwdFZEcUJCSDBMTmtC?=
 =?utf-8?B?dXcwN2htb1Z1bmVVQ0ZzeGZ0b0tFMTFNU0QxUEtxWHJ3ekN5eFprajlDV3RG?=
 =?utf-8?B?UVF6Q2xLL295cGpxa3VQSG16aW9nYklSWmd5NmduQW1oY2MvNEZHQk00UnRX?=
 =?utf-8?B?KzZJNnFXWXBzOTRNaXBMeE1RSFRhb2hBMXlxVTJRd1RUZU8xQXJUYksrclFQ?=
 =?utf-8?B?a290a0pZSjEySW5VdXFyb0c0NkZSb3Npb3AyUFRpMlhpR2JRVXlMSkdFTGlq?=
 =?utf-8?B?MUVKWk1TUjRhNnNzNWtJRE1TNmNCSm1Fb2tRVHpRcEFiZWFKalNaRWRUbi9j?=
 =?utf-8?B?S2JGLy9zUEtzaExqUWxoWUt4a0ZuTk9pd1BPM285MVRQN3BYVXlCNDFsL0Vl?=
 =?utf-8?B?a3V2TzY0aEtEME9OSDFYL0lRNlF5MWxETlU1dyt2NFh5QWVPK3FESjduc3VB?=
 =?utf-8?B?ZW12QW9ldWE2U2Ryam9ycjBETFRDVG1heTJSTVRNMURYVjdMUzR6M0p0cDMr?=
 =?utf-8?B?aTZhWmNOREp5Tk1QYTVmWHp3Z0NXL2JGZXJhWVRkMG5xbHFrZkhUWklVRnMx?=
 =?utf-8?B?WW5xV3RmUURFZnlGWmdqd3E0VFJsQ0lhTVF3cnlQa1pBSEdsaXoxc2dYdU94?=
 =?utf-8?B?dWwyWHFmWDRCSU51L1J6QVU2V3d5QTA3U2N0U0Q5ak9HTDczVzQvY2gzN0tz?=
 =?utf-8?B?c3VTb3NzR2NkQm9kUFNaV1lVTXQ3QzBYWG51NTBwSEdVejFuR25rMGlzS055?=
 =?utf-8?B?VnkvOHlHY01Sekc3dnRGZHg5eXQrS0JjQ29hV2FiWHJLdGNPUkk4aUZDL1Fs?=
 =?utf-8?B?YTdMRlJwdVd6VmhQbStIYUxhQVlDR0RXcmNUOVduZTBSTTBNWEVqUTYxREhS?=
 =?utf-8?B?Umd6UUFhYVV1YzN5OGc4eDBEVkhRdkxPWWh5NHRpZVJCamx5VTFHZHRodzdV?=
 =?utf-8?B?dC9jcktXc1pXd0VUS0d3d0tHOGFJRkdhbjNlQkhhRHlNY0NZL1JOMktUNmFq?=
 =?utf-8?B?STJSUThBcytGZnVwTEQwdTdWdm82bnZ0ZDlUanJzdlU3Nlo1TzdFckp1UnJS?=
 =?utf-8?B?S2tkMmZqWGtrVGcrY1VFRjVtQ09kUEJDUE4yUWJxYlFzZVdnUENtUkl0NEl1?=
 =?utf-8?B?aEZtWGszK2xYVkcyZU1Ja05lbkZHRVZrS3ZzYVFjRHVYWWx0dTFSVjlQQmhR?=
 =?utf-8?B?S1d5QkVaR2twSm9iREZkb1czN2JvV2hzQlBISUNRNmI2THR2T1lwV3V0TUNs?=
 =?utf-8?B?RGxaVTJOYWhwOG9WMXI5eHE1QkR2bzh0RW9jSEhRaFUvZ2g2WXB2dDdZZjJF?=
 =?utf-8?B?ZGdDdlBhRi9TdUY0dWJkbTZDSkt4RGg5RnFpSzhnbjlDNHFDclhXSERTbVBR?=
 =?utf-8?Q?U8MsV5WQwjDp/J0I=3D?=
X-Exchange-RoutingPolicyChecked: Lmqw8k5BgOo3kfbIxaRCerR5nK32PqCSyNXO1Pwk4r5xiVNmj6qZl26nuUKJJC0QqfWrlujwmzKoWZNkM4obMz0+lqZYNOgNjGe4WI4tsKd4G5JcHAjZrtFq7C2Gh/GoRa33P6/aUbiRlpga6fzL78onUtv3pLzfw5fmV2qnRBf7loWzhCBJb57q/N32aFG3iegiubCtvmR+HhbXFvcNgeeKPiAbEMrfzqxmu8SW5J3ODp/ce9IPKYr5l8wp+chupcJOARhq11dO6ISzkrYu72423gzbMqlTmiNAe9RaSvN3TyYSZQxhqTf1l2I5sZShv9nuhMc/8t6teQvaW+gyRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8551d950-9fff-474c-4efe-08de80cf9af7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 07:10:28.1984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dMHj1dLDkQqqOLbSagqKlkdSpb8yJrcS9R61/rLRv3Z6fvthaF05g78MZdpxHR1Ev2r+ff6hPxRNymY9Hef3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7309
X-OriginatorOrg: intel.com

On 11/03/2026 20:11, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add support for the eMMC controller integrated in the HPE GSC (ARM64
> Cortex-A53) BMC SoC under the new 'hpe,gsc-dwcmshc' compatible
> string.
> 
> The HPE GSC eMMC controller is based on the DesignWare Cores MSHC IP
> but requires several platform-specific adjustments:
> 
> Clock mux (dwcmshc_hpe_set_clock):
>   The GSC SoC wires SDHCI_CLOCK_CONTROL.freq_sel directly to a clock
>   mux rather than a divider.  Forcing freq_sel = 1 when the requested
>   clock is 200 MHz (HS200) selects the correct high-speed clock source.
>   Using the generic sdhci_set_clock() would otherwise leave the mux on
>   the wrong source after tuning.
> 
> Auto-tuning / vendor config (dwcmshc_hpe_vendor_specific):
>   Disables the command-conflict check (DWCMSHC_HOST_CTRL3 BIT(0)) and
>   programs the ATCTRL register using existing AT_CTRL_* macros:
>     AT_CTRL_AT_EN           auto-tuning circuit enable
>     AT_CTRL_SWIN_TH_EN      sampling window threshold enable
>     AT_CTRL_TUNE_CLK_STOP_EN tune-clock-stop enable
>     PRE_CHANGE_DLY  = 3     pre-change delay
>     POST_CHANGE_DLY = 3     post-change delay
>     SWIN_TH_VAL    = 2      sampling window threshold
>   This combination is required for reliable HS200 signal integrity on
>   the GSC PCB trace topology.
> 
> Reset (dwcmshc_hpe_reset):
>   Calls sdhci_reset(), re-applies the vendor config above, and then
>   sets DWCMSHC_CARD_IS_EMMC unconditionally.  The GSC controller
>   clears this bit on every reset; leaving it clear causes card-detect
>   mis-identification on an eMMC-only slot.
> 
> UHS signaling (dwcmshc_hpe_set_uhs_signaling):
>   Wraps dwcmshc_set_uhs_signaling() and unconditionally sets
>   CARD_IS_EMMC for all timing modes, not just HS400.
> 
> Init (dwcmshc_hpe_gsc_init):
>   Obtains the SoC register block via the 'hpe,gxp-sysreg' syscon
>   phandle and sets SCGSyncDis (BIT(18)) in MSHCCS (offset 0x110)
>   to allow the HS200 RX delay lines to settle while the card clock
>   is stopped during auto-tuning.  Enables SDHCI v4 mode.
> 
> Quirks:
>   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN:  base clock not advertised in
>     capabilities; must be obtained from the DTS 'clocks' property.
>   SDHCI_QUIRK2_PRESET_VALUE_BROKEN:  preset-value registers are not
>     populated in the GSC ROM.
> 
> All HPE-specific code is isolated to the new hpe_gsc_init / hpe_ops /
> hpe_gsc_pdata symbols.  No existing platform (Rockchip, T-Head, sg2042,
> etc.) is affected.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 149 ++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 2b75a36c096b..46662071cc61 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -1245,6 +1245,132 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
>  					     ARRAY_SIZE(clk_ids), clk_ids);
>  }
>  
> +/* HPE GSC-specific vendor configuration: disable command conflict check
> + * and program Auto-Tuning Control register.
> + */

In this file, multiline comments use the slightly longer form:

	/*
	 * HPE GSC-specific vendor configuration: disable command conflict check
	 * and program Auto-Tuning Control register.
	 */

> +static void dwcmshc_hpe_vendor_specific(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 atctrl;
> +	u8 extra;
> +
> +	extra = sdhci_readb(host, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +	extra &= ~BIT(0);

BIT(0)?

> +	sdhci_writeb(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
> +
> +	atctrl = AT_CTRL_AT_EN | AT_CTRL_SWIN_TH_EN | AT_CTRL_TUNE_CLK_STOP_EN |
> +		FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, 3) |
> +		FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY) |
> +		FIELD_PREP(AT_CTRL_SWIN_TH_VAL_MASK, 2);
> +	sdhci_writel(host, atctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +}
> +
> +static void dwcmshc_hpe_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl;
> +
> +	dwcmshc_reset(host, mask);
> +
> +	dwcmshc_hpe_vendor_specific(host);
> +
> +	/* HPE GSC eMMC always needs CARD_IS_EMMC set after reset */
> +	ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	ctrl |= DWCMSHC_CARD_IS_EMMC;
> +	sdhci_writew(host, ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +}
> +
> +static void dwcmshc_hpe_set_uhs_signaling(struct sdhci_host *host,
> +					  unsigned int timing)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl;
> +
> +	dwcmshc_set_uhs_signaling(host, timing);
> +
> +	/* HPE GSC: always set CARD_IS_EMMC for all timing modes */
> +	ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	ctrl |= DWCMSHC_CARD_IS_EMMC;
> +	sdhci_writew(host, ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);

Might be neater as a separate helper function that can be called from
dwcmshc_hpe_reset() also

> +}
> +
> +/*
> + * HPE GSC eMMC controller clock setup.
> + *
> + * The GSC SoC wires the freq_sel field of SDHCI_CLOCK_CONTROL directly to a
> + * clock mux rather than a divider. Force freq_sel = 1 when running at
> + * 200 MHz (HS200) so the mux selects the correct clock source.
> + */
> +static void dwcmshc_hpe_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	host->mmc->actual_clock = 0;
> +
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +	if (clock == 0)
> +		return;
> +
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +
> +	if (host->mmc->actual_clock == 200000000)
> +		clk |= (1 << SDHCI_DIVIDER_SHIFT);
> +
> +	sdhci_enable_clk(host, clk);
> +}
> +
> +/*
> + * HPE GSC eMMC controller init.
> + *
> + * The GSC SoC requires configuring MSHCCS.  Bit 18 (SCGSyncDis) disables clock
> + * synchronisation for phase-select values going to the HS200 RX delay lines,
> + * allowing the card clock to be stopped while the delay selection settles and
> + * the phase shift is applied.  This must be used together with the ATCTRL
> + * settings programmed in dwcmshc_hpe_vendor_specific():
> + *   AT_CTRL_R.TUNE_CLK_STOP_EN  = 0x1
> + *   AT_CTRL_R.POST_CHANGE_DLY   = 0x3
> + *   AT_CTRL_R.PRE_CHANGE_DLY    = 0x3
> + *
> + * The DTS node provides a syscon phandle ('hpe,gxp-sysreg') to access
> + * this register at offset 0x110 within the SoC control block.
> + */
> +#define HPE_GSC_MSHCCS_OFFSET		0x110
> +#define HPE_GSC_MSHCCS_SCGSYNCDIS	BIT(18)
> +
> +static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host *host,
> +				struct dwcmshc_priv *dwc_priv)
> +{
> +	struct regmap *soc_ctrl;
> +	int ret;
> +
> +	/* Disable cmd conflict check and configure auto-tuning */
> +	dwcmshc_hpe_vendor_specific(host);
> +
> +	/* Look up the GXP sysreg syscon for MSHCCS access */
> +	soc_ctrl = syscon_regmap_lookup_by_phandle(dev->of_node, "hpe,gxp-sysreg");
> +	if (IS_ERR(soc_ctrl)) {
> +		dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
> +		return PTR_ERR(soc_ctrl);
> +	}
> +
> +	/* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
> +	ret = regmap_update_bits(soc_ctrl, HPE_GSC_MSHCCS_OFFSET,
> +				HPE_GSC_MSHCCS_SCGSYNCDIS,
> +				HPE_GSC_MSHCCS_SCGSYNCDIS);

Doesn't quite line up

> +	if (ret) {
> +		dev_err(dev, "failed to set SCGSyncDis in MSHCCS\n");
> +		return ret;
> +	}
> +
> +	sdhci_enable_v4_mode(host);
> +
> +	return 0;
> +}
> +
>  static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1834,6 +1960,25 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
>  	.init = eic7700_init,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_hpe_ops = {
> +	.set_clock		= dwcmshc_hpe_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= dwcmshc_hpe_set_uhs_signaling,
> +	.get_max_clock		= dwcmshc_get_max_clock,
> +	.reset			= dwcmshc_hpe_reset,
> +	.adma_write_desc	= dwcmshc_adma_write_desc,
> +	.irq			= dwcmshc_cqe_irq_handler,
> +};
> +
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_hpe_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	},
> +	.init = dwcmshc_hpe_gsc_init,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -1942,6 +2087,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  		.compatible = "eswin,eic7700-dwcmshc",
>  		.data = &sdhci_dwcmshc_eic7700_pdata,
>  	},
> +	{
> +		.compatible = "hpe,gsc-dwcmshc",
> +		.data = &sdhci_dwcmshc_hpe_gsc_pdata,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);

