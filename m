Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39322E3396;
	Wed,  2 Apr 2025 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614636; cv=fail; b=l2FrdXfms+rMuNPPPc8Dy7mhYHWHaYBmXu5uEY08G0Q11aZxShh8XchpImw/PuXTonf01sFUCKBb+u2Itv5Z1e9soziGe7zFJnoivZr9t4FVUDqaFM8japJQyWk56d/mR2f367Id/p5Ow+yd5c3k14/+yCkiLO7DafCVxZ6iX98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614636; c=relaxed/simple;
	bh=zSlnF0JPsjR8YJzDZukYo3Rd8sL7HpwyNtKruYEFlxA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OORaPi7gKMVcDNV0ywN1/NNFclreYKuv572W4IlAEKUFUb6Xr8IiF1yG+5NH8gsJvH3dEsO/pOKE3tYaucHNRHbeN5qofMtQD+MAFdMECv9YgJpCjmKfFSNpXLgLz0mraBEzwYB5Jqye33hXlcC+sEf0OJoPN1P0HCaUuq/ARmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmFIcR3n; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmFIcR3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743614634; x=1775150634;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zSlnF0JPsjR8YJzDZukYo3Rd8sL7HpwyNtKruYEFlxA=;
  b=LmFIcR3nR2H0uPMeX1mCqjfp8Ujj4UgOVEe/9ezoT+3+PCUvPhPFuykr
   HzcN+wQZaDwwPb2/Qb0nwZ6iK9DqQKzXe8nOKAnIS6aPPAp7faoZi9uBf
   d7TNfsEkZDwHyApfXBRuK3SvkOVWTsQKn7zA5lT3gv6XeCe05ABa2IpAl
   CNf92MBQnQ8zTRmflPbJkdGIJvenrCCRPccleUCWaZJl90WDe3508IHqN
   aySNSv22P2Yn9kkIjE4u1KMu0bYSgWnixsUJA+3WmhNO0r7Gk2yKpC4pT
   TZnVmIIQmMehH3giu497EFdn818HtukqTUNaK6TOHzEZUQNaurkmwPh9K
   w==;
X-CSE-ConnectionGUID: jTAkeLtTTU6DXGBuTylifQ==
X-CSE-MsgGUID: pL+UbyTmRuGJWBzT8Izb7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="55660111"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="55660111"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:23:54 -0700
X-CSE-ConnectionGUID: dM9mVr6XQC6RjFCZGX09sA==
X-CSE-MsgGUID: fBTdSPf7QNCGrYOeOrTTbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="127666119"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 10:23:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 2 Apr 2025 10:23:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 10:23:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 10:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdSsCUDBgqpAbHRHZ2s7uiGIqP0fRGvSUVc48EyvW1EgvWKDEMIhQQq+80M2YBCL4ai/k9nfLCL8Ha1YLXIdfXTT1h/dOmDx/XcNubh5mmCGOV1uHF4MJxwluNA9RtHuCX8rQAkxTXeR9DdKu7uXH3BqQnzVGd8NWHhnaSDZBsXt6ChYqAFzTtSb0x0RijBnJQfHkVh/+jbI45iTE5yTzhwuE7EeN4brWqTa70aykxy61yNlcbrfWtBUMM5Uk58LJEjB48/JFmyaWnIvjZYJcm5Af+w6KGcpQRl+ZlkBJhfm8GtU36bRgrIhdCej7ZMuJpMOaVOpo9PDpF+wCqhZOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+3BjCrG9STGpUUVUi9bTb06eEuhZWW0Ib5O76kPcU0=;
 b=JK9bPtWzt31hPUfM0e45bKImf/+r2o8ZyJKy7klFAgQQefXYCaCN+z9tg5aifeIQuRZWa8/CbddF3tLFxG2CSHE+7shB9lsNNe1g4Y0AC4UilbIJXyGzX0Ki7mycXfYtyIn4zXMkD1alT4EmFUnoW7rwaIvjfwj4hdDT8uMAVCE61Djqkzd+PVt2Au50lAoFSr8TA1ZSMi5Sjv0OIRxFjYAT2W5/Yix3s2lrPrIwlBsXNcpSQzBMc8f+ktUZYKEieJcTNnS4ffvmceCsv6P+xU3MMXSXYDL4YbokOPYC/kLicsY/Y4V/xBxUTYy9SXjm5DyDQufs9Pev0/xd9yWnMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3612.namprd11.prod.outlook.com (2603:10b6:5:13b::21)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 17:23:50 +0000
Received: from DM6PR11MB3612.namprd11.prod.outlook.com
 ([fe80::80bf:d25e:d9d:1228]) by DM6PR11MB3612.namprd11.prod.outlook.com
 ([fe80::80bf:d25e:d9d:1228%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 17:23:50 +0000
Message-ID: <37fea39e-6687-4ad4-9dac-f09333953afa@intel.com>
Date: Wed, 2 Apr 2025 20:23:41 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: Add quirk to disable DDR50 tuning
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <keita.aihara@sony.com>,
	<linux-kernel@vger.kernel.org>, <avri.altman@wdc.com>,
	<wsa+renesas@sang-engineering.com>, <jason.lai@genesyslogic.com.tw>,
	<jeff.johnson@oss.qualcomm.com>, <victor.shih@genesyslogic.com.tw>,
	<andy-ld.lu@mediatek.com>, <dsimic@manjaro.org>, <jonathan@raspberrypi.com>
References: <20250331221337.1414534-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250331221337.1414534-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To DM6PR11MB3612.namprd11.prod.outlook.com
 (2603:10b6:5:13b::21)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3612:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 53738142-ac4e-49e8-9db0-08dd720b2209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amVzc3BZQXA4cGVhRExtdFBBdTMxYTVLeXh6TjJNT0NBdjdYR2ZnNEpwOEtK?=
 =?utf-8?B?T1ZyanZMN1QwY3NIQVBWV3BjNDM4NC90dUtGV1NPK252RFAvNG5Ec1orY21s?=
 =?utf-8?B?aXU2a3lDbjJMYkJKZUhwaFZmakd3c3N0cVpoWGxxYjNjakpGNHJ6Sm1KNlM4?=
 =?utf-8?B?eWM1TDJyOHlRWitMWndUV29MWW9VbEFFbDdnU01TVGtkclVFQmNQSXc0MUha?=
 =?utf-8?B?UHV6OVkwZjNrZHVsRVJxeE1MWXRHVjJsSGlscU52dDJKZk5la2dmeFVFeDBv?=
 =?utf-8?B?T3NMV2VJYmVDUVdKK3JMRDVnb3NKd1dOZEJxY3dubUVVaE5oM3dncDAxTm9p?=
 =?utf-8?B?ZmV5alRva0ZHbW52OTBIajZXUEpyMFRRd2tJMlFHRGNHYm42bVc1OUI0WFFv?=
 =?utf-8?B?b3dnbnpTZnhlc2NFTnJtbklNQWxNY3RMNS9HZFI0T1JYZGVSZTRXOU00NHRi?=
 =?utf-8?B?SVE1Rk8rNWdaN2p0YjhQN3RLY3pjR0ZBTHNCSHNzY01WS0ExSUVYbGdZYkFv?=
 =?utf-8?B?QmRzeVZkY3ZKZEwvZzRlYURFV29VY3YvZEdYaTFpNzhScHVJWVY0Uzl2bUpY?=
 =?utf-8?B?VHpTQ2djYU1nS21WSGIrcGxUOCs0THBwbUVKdzJUeEdOekxJelh1ZW5hUjBx?=
 =?utf-8?B?Q1orTzFyZ3YrZEc3ZCtrS0h6Ky95S01OWWJsdnphYnQwQW05bTF4c0FDYVVR?=
 =?utf-8?B?cGpoSTNzWENTT3AwZDQ3RmZCemNoTTJSeHVVcTU3VUl2ei9IQUtSU29pNXk5?=
 =?utf-8?B?dDNSVHp3Mm1LSUMzUmFGdkVoUFlsYmV4R0Y4WmhmdVlsQnprd2lLSldBc2Jv?=
 =?utf-8?B?cWJNMVF4UEc1c010c0hOYlFzWVAxTVJZdVViZUhRL0R2VzV0d2RkRzVhSkx6?=
 =?utf-8?B?WmM2UXh0M2lPNlByUFpQTnI1eTM5RkkxTnltbzhuZkczQzk4M2tuU04xM0dO?=
 =?utf-8?B?YXQzaGRJRDl3NFZzeHQxUXFkVkpocFFQOEtYZnArY3N6UUJldWkzTnVoTzZ3?=
 =?utf-8?B?a0dkc3IxZjU3NThQeGNsUlcyUUV4VjFkWHVWSzB4ZTMzR3JyRDVyTmRVR1Ns?=
 =?utf-8?B?L0dWZ044N3FBT2pkNWdPaDNYSEdpQkI0ZmYxbCtyb2JEZ1U3N3ZqQmZkaFhH?=
 =?utf-8?B?QWZiYmx0elJ5UGtrMkJ4ZWJCUkgzZy9mY25NRW94NGZDNGVJOHJpelZoeEt4?=
 =?utf-8?B?a2pESW53MnlLUGw5NVBIbS9Ob1ZLL3ZlZnpRRHVycUQya3YrYWVmMHdpM1dk?=
 =?utf-8?B?SlhuVkdmMjNmN290c3JCZHRKSUlKaXNJUDExVWdRdGhFaklnZ0JwN0lZTnVj?=
 =?utf-8?B?ZzhmNWhTdElzbDhxT0VsMTlWWG9qUXo5anFuQkpuNUErR2M0dTBrNnJGUEpC?=
 =?utf-8?B?TDhXQndoZ253bVRWVVlEQ0FTZWdIbVpzREp3SThlQlBkUjlOZlZ5UnR5Qm5p?=
 =?utf-8?B?bkN2bU9yaHN1MG4zbWJwZTMxRUJEa09td1I2c1h5MXVvM0ZYSng4a3JpdW5L?=
 =?utf-8?B?OXQ3VERTaDZLUnJCaE9RZGZUVlcxNXJzbG0za3FEaTlUYkVWTmtLQ2orUmNG?=
 =?utf-8?B?b2FyRTZUTkpaMEdGNmlHdFBBUTlvTGk3SVdYZDhCOUxlVGExMkN5RnI1cmZV?=
 =?utf-8?B?MnlHU2Yyc1hJWlU4aGZ3SC9pSHBGbHFsTlBvZmZ0REFTRitMSDQyU0VLL1Vm?=
 =?utf-8?B?VXRJdFpWTTViV3RUVTFtUndmTTNWZDV0Q2NjTENNdUN5ZHhyZ2ptcUg3Vkh0?=
 =?utf-8?B?MG5EN05vTkZQbTlNV2l4RWovYlhIV3dEb1FING5qYUZ3M3RGV0xNTCtVN2Ju?=
 =?utf-8?B?UktKY3VxQWN4M2tnaHdVZlhkbUJqZlFoNU12THBYYmFiZmNVOE1ldEl0dm1k?=
 =?utf-8?Q?zH5XeN8DfkWaw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3612.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUNzblhMN1dVVmw0REtuZnVFS0pKWVBpb1Q5REljQ2kzYkFnVXkyT2JJd3kx?=
 =?utf-8?B?MHE4SEVPQUozczdSY0V2aEw2MEFRN1ZQV05ncnZIQk04RXQwS1FHemNUYkVq?=
 =?utf-8?B?RjM4dDRpZnBtTVVUSHkySlJYR3Y2VmRXKzh4WFlBb3BFaDZwLzBpYUJkYlJI?=
 =?utf-8?B?aHdQWEF2eU9vV3VKQkQvdEZHWXYveFp0Q3Nna0VaUDFTNEUvSGc2dzJNQUFz?=
 =?utf-8?B?Z0Rid0ZJU0JRcFZMeFFteWVJemNMSks2YW50bGVsYXloMnNUOTE3V2ZVeENq?=
 =?utf-8?B?a1NLY1ZlVm0wREwwMEhsbTZFR3NtTEp0WWtqVXNkcHg2VnM5djFiWXdheFJI?=
 =?utf-8?B?Z1l5SzFuL0RGeC9lYVBtYis2bHhCV3hXUkRnUStQaDBGZTYwR2t5OS94T0V5?=
 =?utf-8?B?Y1lYSk1jUkkvNXlwRUc4NTQ5eEczRVJ6Nkc1TStOcXpvV0t6R0RJY1UwZ0pG?=
 =?utf-8?B?Tks3TkhXTUtQVzkwOUtRa3pEWjlXeURNdUJObUhMeGtnTzl4ZEtDS05aTlN2?=
 =?utf-8?B?RXB6ZjVRSWEzYlFJR3NDbnJ3OFVEQWhTaURSRDlTL2dZdEZlMUJtRVdzcUsz?=
 =?utf-8?B?d1FNRFZsWGdkd2xWUk1JQndhdjF0K25iSXRZNCt4VHRNQXgxNE8zVjY5ZmRW?=
 =?utf-8?B?eXl6aGFPWU9sTjVyQVF2eTFLTkFkeUFrZE0ySkp6ekdwemJZaTV2VUtEeXNJ?=
 =?utf-8?B?SGFlNGtQWkhxWGF1OFdDdkNsOFk0NHZ4ZzVsNS80cGZiY1c0SDVEZ0JYMlVU?=
 =?utf-8?B?NjBSUEx5K0lyYXU4aEFjdWt5TWZCb1pmSWhMQnc3UkkxVnR5OXFBWFdVSnk1?=
 =?utf-8?B?d2t4ZXZaVi84c0ZwUWJqVm5HTzhXQVpPUUdTdngzUU1mS3VGOUhKTXVaRS9O?=
 =?utf-8?B?QXJNY1F5enhleEFIUkJReHRPTnc0b3U0NmJkZEVtZzhaOExFSWhmZ3lxUmdu?=
 =?utf-8?B?b2dSNFRhQ09uTk10dmdtYzZSdVRlbEkrMm92Vy91aVBDREIrL3ZTWnc0UVZP?=
 =?utf-8?B?dDRlU01JbW1Jd2NBMVZHTGFBYm15eVhSeWVQWmFzdk50Q3R5Q0hIZGlXY1JJ?=
 =?utf-8?B?YWhLaHhNWGMzTDRuSHlXNTMvSy9jS1pLbXBFMUE4RkZKU1ZlRm15aDgwZXhZ?=
 =?utf-8?B?NVNJR0EybFhIVHpOVWg4OFM4Vk01dU55VlFuK0tKU2lLa3E4MzcwZENHT3ZW?=
 =?utf-8?B?RHdlWTdTM0RkOVE0TFRiNzNKNjRLNUc2WXNQVTR5NnZ5Z2hmeW40NjY0NkUy?=
 =?utf-8?B?VWFqa2hyQ1NWQUdHYUNDRENSMVl1cHNybHl6OUdnMGpMSnVvMDRpNWJNdGZ5?=
 =?utf-8?B?anBVQnM3OE11blF1dVprQnMzZWR6MnRmdjR1QzRaS1pWcUdXb3crSFQ3d2JE?=
 =?utf-8?B?MnFtejgrR0NUZ1ZlL05aQ0dxSlF4UThTanUvNGxXRjNJZEFpSWNqeVd5d1g1?=
 =?utf-8?B?S1NvSHpUN0RQQXFMTW1sUG5HVmxQK2dQUXZCMmRoKzNHOWN3bmN2WGFqQkZ0?=
 =?utf-8?B?eHhJV1pxS0hJZGRJQkdrdkFQajNwMFRNdWQ2bmRkQTV0S1FwQWNidkxiK2Ir?=
 =?utf-8?B?R1VxTmU4Q1ZicXZjYyszR2ZCVThpNUZQQzRVZk5ockhWUFZSNE9FbnRKQW13?=
 =?utf-8?B?S0V1aFB5ZHJBQlNlOGJXVklRcTFNeWRvWnhXbVhIZ1J4Wk95UWZGUURkZDFG?=
 =?utf-8?B?UXBxdE1pRFFXSlFCQ3B3MXdOejVVMkNidlBsUEZOMnUweHZVZUJFMk5lbEhz?=
 =?utf-8?B?WGgzdEFWTXhXRHNMdnNaMmhHQXFkM3U5YlltWWJ2VDF1Q2w5NEdXV1ZGZFBY?=
 =?utf-8?B?RkkyK3R1OXh4ekxwbWJPSUU3Q1JSdnd3VVpDSThleHM4aEIzQUpUY3BiNnha?=
 =?utf-8?B?MHJjVTlzT0Jub1cvZHF4Tjl6UERFMm4yOTY1c2s0UmpQR3pQQldqZ21SNVJO?=
 =?utf-8?B?RmY2cHgvOGZBNEd3NU1vWjRjOXY2cjdNVFVwY0FHY0JsYTRNTFZaNVBVMmZ4?=
 =?utf-8?B?ZEJ1LzNuQUQ4dWpwZytUZjFFbERRdnRuUTNjaVJTaTVXM0NOb2l3TFBOM3RF?=
 =?utf-8?B?bWtRYU5DcjBsbDhIcUdTY0lFSnRrTmJSMkdpbVRJRWtnSklDcXovYVVQci83?=
 =?utf-8?B?YVBQelk4dHlRVmJKRCtwYUxYR0VFQXJuSDFMdWJxT1V0cSttZkNLMjQ5cXR6?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53738142-ac4e-49e8-9db0-08dd720b2209
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3612.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 17:23:50.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl5ebEPFwS1zzVlwGPE5F2w4+NHHtI1wd7nnZmroADgcFpqVZZK4t72QCM4fN/O0rChavhZUeCVztC+wRZpVJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com

On 1/04/25 01:13, Erick Shepherd wrote:
> Adds the MMC_QUIRK_NO_UHS_DDR50_TUNING quirk and updates
> mmc_execute_tuning() to return 0 if that quirk is set. This fixes an
> issue on certain Swissbit SD cards that do not support DDR50 tuning
> where tuning requests caused I/O errors to be thrown.
> 
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/core/card.h   |  6 ++++++
>  drivers/mmc/core/quirks.h | 10 ++++++++++
>  drivers/mmc/core/sd.c     | 32 ++++++++++++++++++++++++--------
>  include/linux/mmc/card.h  |  1 +
>  4 files changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 3205feb1e8ff..9cbdd240c3a7 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -89,6 +89,7 @@ struct mmc_fixup {
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
>  #define CID_MANFID_APACER       0x27
> +#define CID_MANFID_SWISSBIT     0x5D
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX	0x90
>  #define CID_MANFID_KINGSTON_SD	0x9F
> @@ -294,4 +295,9 @@ static inline int mmc_card_broken_sd_poweroff_notify(const struct mmc_card *c)
>  	return c->quirks & MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY;
>  }
>  
> +static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 89b512905be1..7f893bafaa60 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -34,6 +34,16 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>  		   MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
>  		   EXT_CSD_REV_ANY),
>  
> +	/*
> +	 * Swissbit series S46-u cards throw I/O errors during tuning requests
> +	 * after the initial tuning request expectedly times out. This has
> +	 * only been observed on cards manufactured on 01/2019 that are using
> +	 * Bay Trail host controllers.
> +	 */
> +	_FIXUP_EXT("0016G", CID_MANFID_SWISSBIT, 0x5342, 2019, 1,
> +		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +		   MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
> +
>  	END_FIXUP
>  };
>  
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cc757b850e79..fc3416027033 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -613,6 +613,29 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>  	return 0;
>  }
>  
> +/*
> + * Determine if the card should tune or not.
> + */
> +static bool mmc_sd_use_tuning(struct mmc_card *card)
> +{
> +	/*
> +	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
> +	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
> +	 */
> +	if (mmc_host_is_spi(card->host))
> +		return false;
> +
> +	switch (card->host->ios.timing) {
> +	case MMC_TIMING_UHS_SDR50:
> +	case MMC_TIMING_UHS_SDR104:
> +		return true;
> +	case MMC_TIMING_UHS_DDR50:
> +		return !mmc_card_no_uhs_ddr50_tuning(card);
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * UHS-I specific initialization procedure
>   */
> @@ -656,14 +679,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>  	if (err)
>  		goto out;
>  
> -	/*
> -	 * SPI mode doesn't define CMD19 and tuning is only valid for SDR50 and
> -	 * SDR104 mode SD-cards. Note that tuning is mandatory for SDR104.
> -	 */
> -	if (!mmc_host_is_spi(card->host) &&
> -		(card->host->ios.timing == MMC_TIMING_UHS_SDR50 ||
> -		 card->host->ios.timing == MMC_TIMING_UHS_DDR50 ||
> -		 card->host->ios.timing == MMC_TIMING_UHS_SDR104)) {
> +	if (mmc_sd_use_tuning(card)) {
>  		err = mmc_execute_tuning(card);
>  
>  		/*
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 526fce581657..ddcdf23d731c 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -329,6 +329,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_SD_CACHE	(1<<15)	/* Disable broken SD cache support */
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
>  #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
> +#define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
>  
>  	bool			written_flag;	/* Indicates eMMC has been written since power on */
>  	bool			reenable_cmdq;	/* Re-enable Command Queue */

