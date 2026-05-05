Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB430BB9B;
	Tue,  5 May 2026 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980486; cv=fail; b=bRaW3ComITGOAVbulGeSoE9qGoBr/9OKnffTSgcWwbBZsqUwzJHwiN64fmUUbFg8C3D1K4rreeOO1zXfsjTPbcI2y3dF2weQVuVS5kNIzIDXMgFZLH7+sIRbmgzgCGqPDmVbw3+S6yQaP7QzwiS4E4t899OsSNS6fczVX9M1OF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980486; c=relaxed/simple;
	bh=UXdxxead7om4dsOgNZFwNYMHxrmIA+yRTEjAgLQDL8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SL0slZYjVjnRHPSoN9QwRhNW56Ye2B6JUr+RvdqZGWG0Yp91CTowvVpzWocR02N1bjFNjMyZMh8HdQW+x9HIHrPZb5kdnncpqvz324MwS/AzyIsuE0m836oEK+Anv9V/1In9kv+sdZkuijHQP21r5LWxfqLrZattste3UZ0uK6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LazB0yr6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LazB0yr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777980485; x=1809516485;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UXdxxead7om4dsOgNZFwNYMHxrmIA+yRTEjAgLQDL8s=;
  b=LazB0yr6ffLtGERkaaLbh3LG+Vm1jWKpo2EfoQAup/dFpV+dhLsBGNCG
   ieIZ8WnBE+L/UrE/9qT/P5B5yQ75RFKybYbMRlNtl7VEqVQOdDeOTbssG
   yVJtEQYlZSVmzlTMJAyOUtv+i3v9h1DBepuT/+yP5Wqb2V/O/g8fdKLOR
   /ebNPytxEBcLXUC+9Z9pwpyc4ZyyeZ2vaRFeRXwK3PI5YBAc52z1YYrzw
   U6k984yMQhEGqac2NVfcQNtZKKBM6CRaInDSdE8OXNqPG+h0e7KibVq4E
   K9mzbKhTzag4XhPPAdrF99NlEwSAiTrjKwm8P9ew8wt9Qry4wtFgH0/35
   Q==;
X-CSE-ConnectionGUID: oIfO2GkNQuuazjEdJ4CSTg==
X-CSE-MsgGUID: ahvvHJqmRQSmYKNSSAqTjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78784806"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78784806"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 04:28:04 -0700
X-CSE-ConnectionGUID: jgsYjKrbQGKqnpMhCE6AHQ==
X-CSE-MsgGUID: didZcXJyTO+d/ktMoK+mHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="236046095"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 04:28:03 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 04:28:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 04:28:03 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.21) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 04:28:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bndE/FsHHJzyupfeY0izgAGU8bVLum3Nrn5sGD55d68STlmPpq1cAymxXEifg4PB6zXkSKs0iA2BLKfVfGj04bDwptKRsQflJN0mrGobItSX3v0EA6MPf1UGOm5GDQFA/7l+B9nszdOEORINBKW0pPxWtbKEuc6gVdqaiLDAbl+6E0/jvJ0eHnScx0ZwusVAE20h0PHLY8CGPFh0lxF1dXNB+Xk1Tm3XK9TBIVXyiLZXPWxsgVlhdgn9S/mEpMp+VV7FhyxiDqiEb0rg3ObToK7N6Vm1/IWs4C3KtOMekHvUr+37UKIrlnCfjVJj8SWHrnrxmn9vVHKLwOo8mS3zOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IADfXA7erhr7NJ9JPm5qW7qUPDC9tE1sqgXFGoaqpN8=;
 b=Rv+Ry+bE4efKtcFPe9Pj71oeT6Zk350Pfol3HeT9H/bIKPbS3Yq3MNKxJL1BbHvLc8bjmITCkDbfq9Bfgpiu+3xg9zzQO/8TvG3VCh5n+wvhjfRsEpjxzU8IgW3kILxwvypevijv714PILdD86SMj7jWuOelPuyj5v0cKyo9+KSserzn4l71CLt0pNrzQF1Ol9SBusO2ElPlNYaAhAVAgEVNa6Yhp6QBHL4EPDHrhf8pp+9errfH4b3oIM26/+NU3y/O/p/hO3+boZN1LuAZj3WfGdZlsHVTZ6rYBR3coAA8gwsBLioz0ZimEYyyQdcvsPXTbHXghKSDyD0TErl75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB8895.namprd11.prod.outlook.com (2603:10b6:208:579::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 11:28:00 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:28:00 +0000
Message-ID: <53c62677-2185-4cac-aba8-09363d0ce9c8@intel.com>
Date: Tue, 5 May 2026 14:27:55 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: add reset control support in
 suspend/resume
To: Artem Shimko <a.shimko.dev@gmail.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: <Jisheng.Zhang@synaptics.com>, <hehuan1@eswincomputing.com>,
	<yifeng.zhao@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260415123411.437450-1-a.shimko.dev@gmail.com>
 <ad-mCsvOWWgqt-rc@ashevche-desk.local>
 <CAOPX747KM+Ct8Edj__ng4GMeLvjnyaBG1T2h54LSr=SFgQcuqQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAOPX747KM+Ct8Edj__ng4GMeLvjnyaBG1T2h54LSr=SFgQcuqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0305.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: fca71208-19dd-4358-f9b2-08deaa995d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: /PaRZn7GNKgy7uSSakwxZWO/FuVafzhItXcXdQyuZIGd8+fDnz/08wqV14ZBdKIqmftT25aFae2eCYc7ckxdCHQB91X5nuZmy45iQFVkGdscGbLVdLIGk1tq9hKftLesztzoDrgGKA/mkp0daJBWXwrTFjdJ9CicJT8a8iuNoxU9qAEQ/ITr7bP0p1hHHJZQGB8oVwrAKXJqhbB1mEneLCAAMKBm+rnThu5Yqp+UypGCGDWQQWw706UO7iZex8+4LvppIlEWO7gCp0SK2SwLUnXTiYxfOZtDQQBkS9/ClEFsQSr9W4sMlco37jB9CgW2AQqAhh0luZ+YhpaA/EmhCm9AwykIRJPbQ9nK779FRxaK164yxHs0zX9B6IMTbyKfqoe1ZSUNHGaCfWvWV7L3totnctwRCGAhr0QoZboftPr7lgb17r0MFecDk/cVW037kJautzgHicQSp2tzAk/t3/VIpnoyTw2YvLcZZvJi8J+yDO6KA6Z+3wsL606IO0jX/JfNU+UFK1RkObGLmoTdYpJnz76tSFvYsCOCr4spShdRjgTf8a8B25kyNeCSq2R1oRsHi8wZYYr2LBp5fchDafmicvqUmKa1rA082AclWOvKc4m4oPjwWTuWMmIhiNykHyAvHOVkbG3LfUMTUy5eYsFWNZSGpHopV67WOTyH8vQkLtbRJVCH1NtaDkyw/4et
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cllJaHdmQ1h4MmJiRzZCWVZaTXFvd1lBdTZiTWVTMDJ0UHdjWUhicStQNWI1?=
 =?utf-8?B?aHFUanlyU1M2YW1RcURCQ3VmazNHaUs3SGFyeE5pWk5HQlpiUzZ2ZHdNQTd6?=
 =?utf-8?B?cGJqa1dkQnZPaUJNOU51ZmViYmR3Tmo0Qk1La3dxanBGSTZEczZxYkNXNTVp?=
 =?utf-8?B?Vy9STUo0ZmFIa1Q5cEhXL0NGUXF2UWdmZmtlUXZMcUtJMWh3QjZJMUQwVWJa?=
 =?utf-8?B?UGVCRzRPcW1ZUGplRnB5RWtlQ2crd2ZwYkFRVGNrRWJjRnJnR1Q2dXNKNS9R?=
 =?utf-8?B?N2xQYkhURFcyOTR5ZHF3Yjc0RDU4cnF0eGpqL29DUGJndEplK2ljZ0xFUWxD?=
 =?utf-8?B?VU9oRkdQclBYRFZCUW5wWFh1T2FtaHI3VElNdFhUSFlPbjNMdEQ1aloxaFFL?=
 =?utf-8?B?R1RoaW1CY09PTURNb050UXl3Y2NoZTN3Z0VlcDg1Z3hJNFR3ajh0NE1DeHBB?=
 =?utf-8?B?RHIvZVhQd0pGaXM5Y3NLY2dMTS9pbmRPdkwxRFcwTENBR3l5ZTFaVkNVRUtL?=
 =?utf-8?B?M2VYa2l2NjZmRWdBU0FCYjlIUnZGM2pmZWVsQWxNV0ZibmFOWW5XK1cwTTNq?=
 =?utf-8?B?QnQ0ZG95Q1JudHRnWklMK2p1ZDRFTVlrRHQwSk54cFRqemk3TnVnS0xBYkdl?=
 =?utf-8?B?U2FldmIwSldLTUc3ZC96OEFyUHIyOTRkUlpwTmdGRzlpV2xjVWNIQTNXVUd3?=
 =?utf-8?B?ZGtONTdPNlAxS1IzUmRrbzBGdkJIN0lnNEtTbml4S1hkVU1LdU9ITzJJbnIz?=
 =?utf-8?B?bDYwUkNKMkU2R3dkSUhHUzZQdEprRjlTTG82YXdvV0swQWhRSHBEUHNhYSto?=
 =?utf-8?B?VytaMVNTakpDeVlBTEp2R1g0YnNDaGZhL3gwNXZkb01paDF6bmQ0MjBvVGpT?=
 =?utf-8?B?YS9YWnBUTFNBRWxPZkMyNklwakJxcXdEUEpNRERISUNZVHlpRFV3TnhiWTh6?=
 =?utf-8?B?YW5JWHUzTEEvbzR6Qm5nZkZLVmFQZXh6V29rOE9QREZveUtiLzBWT2tZYzdZ?=
 =?utf-8?B?NHVhejRaRVBza282cis4c3JiVExQZkZBOUtDVnd0c0Jmc1ZkMWd4T3ROMGE0?=
 =?utf-8?B?cW9HRnpuS0kvWEltN3NWUDNCREFBZHp3eVAyZmRpWjd6MHBZTFNLR0V4TnI3?=
 =?utf-8?B?ZVY4OW85eS93bjlrSHRwaytiaDdFS2hBSit6VnlBeXNTMm00ZmxUbVFDODht?=
 =?utf-8?B?ckdmek10dDlML01hSUhaMDdjZjF5b3lMaGZSaVFnTzV3aVN5MjJCcDZVbVd5?=
 =?utf-8?B?M3ZjalFNZDF4bkZGaS92REh2bFlrNVNvRjBaLzZFLzkrbVZmbTZpWnNGRzFi?=
 =?utf-8?B?QmRMazV5M290RDlqN0JIVGZ5QjI5L3B5QWwyVVdBT2FTZDFmeldyMURLd2xE?=
 =?utf-8?B?OUN6YVNOd3plVXQzYzlNL1lZdlhWSGxWbzBFQ2tieFdWaVRTMUh4Z3dYaUJO?=
 =?utf-8?B?MlJEbXN1NGJpdXV3c2FQV3JwUVc0TWcwUng2OXFIa3BvcEZTK2RKU01mbzVv?=
 =?utf-8?B?WFJhVlNFQndkY1lWZEp2MUJsN0ovVXR3emR0RW5wQ05zbGFWQnFDRGo2VU1K?=
 =?utf-8?B?TDArRGxraHhWakl3Q2w4L0JBNWZLMlFSR0kxVllkVzV5QmcycE1qaE5IVU1Z?=
 =?utf-8?B?em5WYkUrczJkSnBDVC9Bb21jUnIvbkVnNkdPVFJsYWF3NUYrU1lDQXpKUnAx?=
 =?utf-8?B?eHRQVlNIR3gvMHZERDdwOVk1VHhaTCs1aEpQN3RTMkNYWk0yMUxvdTVXN2FU?=
 =?utf-8?B?dUNvSmdDYzJ4ekdVdCtzTjRVUXJtOTNhYWwvMTFSTWhYbWVLNlFrenJKb0FF?=
 =?utf-8?B?OUNRRFFPMGQ1d255MFdjK2s1SjJFUlNsT0xzOU5Mamh4dUJycVRkem1MeXNl?=
 =?utf-8?B?RXhLMGVrR1g4RGhXT2RRY3RObzZsNTMyVURNK3VtUVJNM0RYdnNVclJvdEMr?=
 =?utf-8?B?V0NvTkpiZHlLbnM2ZEdadVNibDhGbjVQTkUxSDlOaDdORkhzcjlKTjZ1NWI3?=
 =?utf-8?B?MXI2R2lCVjBENGRWWnN2TlZIb25yTGpZOE45bk9mYzlycTdDUVcrQWJObkZ6?=
 =?utf-8?B?RHRjeG9vNDdOWEpQUzYya2J0SnVQSWFkdU1KSHZqRXgxRDFERVRDdHBHNVZK?=
 =?utf-8?B?bm9RQnNnZGhjZUREbUJIQzZqZUtsNCtrSFdiTitubDR4clZhaUJDUzJ4enZ4?=
 =?utf-8?B?V3VLeXNSQVlkc3R1UHZxNWhSaDQ0QmtmMTBQVXpXOXBvQ0N3ajBWQVZ3U0Zn?=
 =?utf-8?B?L081TUlQa2RFVlY2NzVVV3k4ZUxvWjhiL2pta0phYm1UcDcvWWNpM2dqUGN2?=
 =?utf-8?B?cUJhUDhLbHR6dlFpTkR0NFlmTlR5bnRQcHYvclRxMGY5UDRuVUhRZUNQQXR0?=
 =?utf-8?Q?V4fc8eis6EzWZYds=3D?=
X-Exchange-RoutingPolicyChecked: hjedsl7uwB/+o3CQk3nvXBs3xa0WPh2ZEnxEC1IGansM925O2+WRbA3W7jO+L461A7b01z58PmGGE4Kdc/1iyBiAnPNGE248ERGIEU5bLH5OGmnFtLOEjW6zUz5NfsjVANW3kGZMF1uQaG0fcZnZCYFxD81RrwWuZPpl4Yu7jh600ynRep8leOfFMuj4MqRb2veI2ALud3A7V3qinTD5h/mGDHnidwkT7l0TX9BFio8aT8Zy5mT8q1lAxHuAyHX+7G1OubAhrLOGcxQgF5EQyc2obbqOEbBNCgo2yULoi1+JOQ7WyTTZCU7zo4z5meQSC64odux83nwyIWknEBrflQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fca71208-19dd-4358-f9b2-08deaa995d22
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:28:00.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vOxdKvEqMuV8Q8ST9HP5ypxbMZ2UerDJ4asBrNBZ6KMPMCi2c8b+SSq0vLmtS9ixuLHoZDKHeRd1QmRZl7ljA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8895
X-OriginatorOrg: intel.com

On 17/04/2026 13:45, Artem Shimko wrote:
> Hi Andy,
> 
> Thank you for your review!
> 
> On Wed, Apr 15, 2026 at 5:52 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>> No need to repeat the commit message in the comments. It does not add any value.
> 
> Got it =)
> 
>> This is serious behaviour change (might not be, one needs to understand what it
>> does in comparison to no reset (and in accordance with datasheet).
>>
>> Do you have any HW to test?
> 
> I made these changes so that our MMC controller (dwc) can handle the
> reset signal not only during the initialization function, but also
> during suspend and resume.
> Since the reset control was previously stored in vendor-specific
> private structures (rk35xx_priv and eic7700_priv), it was inaccessible
> from the common PM code.
> To make suspend/resume work for our platform, I had to move the reset
> pointer to the generic dwcmshc_priv structure, which required updating
> the Rockchip and EIC7700 variants accordingly.
> 
> 
> 
>> The driver seems can be refactored a lot (with no functional changes) by:
>> - replacing *sleep() with fsleep() API
>> - dropping unneeded checks like above, clk_disable_unprepare() is error
>> pointer-aware IIRC (or it can be made so it is either NULL or valid one)
>> - using 'return dev_err_probe()'
>>
>> This is just a side note in case you are interested.
> 
> Yes, sure, thank you!
> 
>> No need to add an extra blank line.
> okay =)
> 
> 
> Instead of moving the reset control directly into the common path,
> perhaps a cleaner solution would be to introduce a set of platform PM
> ops (e.g., suspend/resume callbacks in the variant data).
> These ops could be checked for NULL in the common
> dwcmshc_suspend/resume functions. For platforms that don't implement
> them, the behavior remains exactly as it was before (no reset
> assertion),
> ensuring zero risk of regression for Rockchip and EIC7700. Our
> platform would then simply implement these ops to handle the custom
> reset sequence.
> 
> What do you think about it?

Only dwcmshc_rk35xx_init() and sdhci_eic7700_reset_init() assign
dwc_priv->reset, so I am confused about what devices you intend
this patch for.

You definitely need to limit the change to devices that you know
for certain it will work.

> --
> Regards,
> Artem

