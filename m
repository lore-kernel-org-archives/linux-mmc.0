Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C51264F81;
	Mon,  6 Oct 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747627; cv=fail; b=iZkfrC2xrw9gGLUYvfGVNLIp6o7GigHC2Gu0xQrrywkcJ9QpUBWwab+S1Z7oOHkplZib67oaf1bSQwwFet1g2kwbu9wUUlKKPj/MbG6LkaqNOicuBEPn3/cAdcakL/xXMRyJkPE/z3tYP40Pdq6qtgcd8AmDmRxzWZFU9EWfmGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747627; c=relaxed/simple;
	bh=raDioN1JnwASXG+0WC3su48YBSoyQNrzHZgKt0Q7J/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wmz/vQ/JKzQJ6+DLmVRsEQktrBFhC5CC6Aw4Afm30yS6tUfnGd2wUOIK9n8oDGv3St9tPPYu6zcYF+yZGlNt9wKh+A6zeFeQcq+sTTHRut6aeRsB8E5Scxlwvuc58hNzIcVbez8JE5EMXFvmIOUlG5+FUqW6KDPR64eIjnr9gDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgxGRAJM; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgxGRAJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759747626; x=1791283626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=raDioN1JnwASXG+0WC3su48YBSoyQNrzHZgKt0Q7J/g=;
  b=fgxGRAJMhDQRJwbXroREt8ZE7NqiaNnuhy4sHDBX/NZe4p2ze6rzT9eB
   6MngVfRJzF9wEQLlw1MkXKgId19jpQ/CBBDMsAMifzZa2HHW7/VG+dUVh
   1McnCOu/F1AkcbATkJau5B4/hbGnmdLfDmEe6cAwIJRMkwb1ArPL/uU4H
   tZpJCP/nHgOxd7ESovf5IwPqfc9RFBt334jZhMahJymqUBJ0NOoq1KAAM
   loo8AqD6wP/yLl7JBFlkOV9SShbH9mtMg3XN5ZToejhBddbjUXbcVzq+X
   lhisG7zhxy68baw/h0DkujFvTvZNOdoWsdqRisRL9tlTohKoxTdS/nI14
   w==;
X-CSE-ConnectionGUID: YHWu+zWPT0KaPbhjR4on9w==
X-CSE-MsgGUID: HBA4QuhQTpycU7KB9iF96A==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="84546460"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="84546460"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:47:05 -0700
X-CSE-ConnectionGUID: 86whBuxgQOS4vHQA7pVxWw==
X-CSE-MsgGUID: 3DpFlj6vTqK1ixLYgCMvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="203589840"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 03:47:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:47:03 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 03:47:03 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 03:47:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NnNDLaFmpq53z686nd1IjIsmsgNfjiTZ5bZn2gRD6bP7wj6iETOkszuo6hSlFMMbz2bVZQ9+WKyG3mOnAsO5ogxbPJfdz3TISm3+GdguZBzpvGy9fKIYfw9BYxLSzQCrwJdCuXvWrFdwi+X0bQe9U5xY8ZRLcAPV4oM7DFK3bX7kggahLgLlFAWCsSyxkW6JEGDOoClKAnUEqmN9RL8hQ7IcuVZD5JtBN/9X2Rj8MRoP77wQwGXjmRdp9fZ5UUcs0p/vXjP3b1vzmZ9LTqg1xSMss0xNvMLiSRWV2lA1fjPlIWqryVtroUjurO2EqbTdj1pBo8LXS7OrcUs/zAFntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+XY7KdEOeXelmFURNAQt2ENWXyJnl9JLzNbyBQL/I0=;
 b=uXdryQbHI6hGCRrbJsyHu4uAr2ZBinVqx6m+cBE7lnd4YGNDSHzJJrTpuxnzl3BtPZ02JdnEsItfZFVtBAdIg/B93CpTSjo9AiYSHrHCrEYzh6hHX2lnco0ipFneKi270KoJo5EQFj4TMRGFfXfotRa5V9zcXvQUQ391PwdEgBq9bXcOzGD/qlmD4cPWdq4Qk098yVjinqHCZLL3WFBkoAnW+r95J3AKFMbRj0yyaOBuyz51yLPs8nphF8ak18uCKhJ4ppwwDk9GfYvU+aGRH9tAGAq4VOW79XnZQEdHQiX9MWvXsjsqcBlixkxIgD+1F8ObzCkTcYb3LZQDslRToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB7063.namprd11.prod.outlook.com (2603:10b6:806:2b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:46:56 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:46:56 +0000
Message-ID: <6294fb07-31b4-4c0e-9023-7c5ab604bbf1@intel.com>
Date: Mon, 6 Oct 2025 13:46:53 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
To: Michael Garofalo <officialtechflashyt@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<ulf.hansson@linaro.org>
References: <21d7f0c8-9a61-4759-b655-b12a6fad9885@intel.com>
 <20251006092815.2555733-1-officialTechflashYT@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251006092815.2555733-1-officialTechflashYT@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0245.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b37edb-1cb1-4a0c-e682-08de04c5ab3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmdiS0lwenc4VVp3bnRDQk5VR2dBN29LMUhDenRlTStuMGxQekJLMzFQWm8y?=
 =?utf-8?B?a0YzdlVxaFR1blBwakZBVFl1Q3BJZnIrNWJwa3ZSQ1ZETjVSU3p1bHlqQ0N3?=
 =?utf-8?B?VW4vMVN2Q1J3R0tmdDFNeFBnUWdYK3dvMnhhK0xHTE8zYWoyT05ldkk2VDZJ?=
 =?utf-8?B?M3J6dzljeGRKYzlUWjdUT2ZDZERvMldXT0RxTFo3MEhHUGFkb1p4UXRtSncr?=
 =?utf-8?B?TW9kcW1oRS9CdGNnK2FhcjhyZ3JySTNnWHlIaGhNbGYzN1I4NEV4aW13UWVx?=
 =?utf-8?B?ZVgyYlp1cEI4bnRvVHNZeUxyRWJhaUZqR3pvQ2IxQmRDL1Z0U1d4b1RIeEFO?=
 =?utf-8?B?WlIyUDVjZno4NEJNM05FbURIWUNoTDIxaCtNOWhyNVF2aEsyWkZEMmt5TUIw?=
 =?utf-8?B?VWg2UkNycFZ1QkZCYXlNR2Zma0w0bGhhR3dUWkQ2bUpYRXVHcmNQdFBOempj?=
 =?utf-8?B?aWVLbEZoZ3cyU0kxUm12RHhPOEpHNkxxL0VVNC94NG81dXVER1IxSXU3SEFq?=
 =?utf-8?B?T2kySHB5MzlnbW12eE9wbFh2TFliZ3p4SnRWQUcxL1dycHlYL3ZoR25xekw2?=
 =?utf-8?B?eElCbDRmQXo4YzJxcFhxVVppTWF2ckZUVWpzdjUxZlNpNzVlSWgzdmNPVGYz?=
 =?utf-8?B?Z0Fzajl5S1l5VllaZ2lmZm5tMzFQK29oQXJIMDYxYlA2R21PSVFFdHNoV2ZI?=
 =?utf-8?B?VG1mVmUxVWw5RUI5SnNCVStja3R4T1UxcnRSMDc5UCtEeVExTWRyVExmc1I1?=
 =?utf-8?B?OFVyUzczcEdFNGpHUnhPWkNNd1R3a2pYUm1ZSFROZ0Q4dFhDT2o5Y29NT2No?=
 =?utf-8?B?VUJvN2d0b0JxOTFwb0JnWFM4M2RpMGwxZjJ5ZkcxU0xPSUxjaHFYaTRDSE5B?=
 =?utf-8?B?ZjZjOVcvQ1h1YlhUaEVMN0lpaTZ0eTRYb2s0WXVtWG04YnVCeVNHSDlncTJu?=
 =?utf-8?B?bkRTZ3Arak45aFQ0NngrdytoZmVORUlOZjBYNkZEL1oyRDl3eGlUK3l5a0k1?=
 =?utf-8?B?SjY2NHF1R2xsY1ZFMExqMFNwUGJvSk0wV3psVE1iazh3d1lpRnhUalpGRUVN?=
 =?utf-8?B?OU9kSHZXZnFNWk9GS01VQmhjRERqY2pBMmVOQm51Mm5uT0JzZU14WDR1M1VG?=
 =?utf-8?B?WEtFRTdrOTN6b1dlTHp2V0dqY0JtZE1RM1l6cEJucW13cjc4Ums4azNnb0kv?=
 =?utf-8?B?YU5KaUtHaHVLemFVRHV2SXJ1eW1BL1BpT25iaDZjS2kyTDFkOGFzZFJ5UG1C?=
 =?utf-8?B?MzltRkY1Ty81dmxESURiR3J6M2hDb3lOcS9XSExqWGoxVngzKytmUlQ5T3RK?=
 =?utf-8?B?MGoxM0dGZW9lQUl4SnlKZjlNZjI5enN4N0hnRnRwNDdTN0J3ZFJSWTR2Uk5T?=
 =?utf-8?B?dTJMWnQ3Rlg2Mmh2UEkwQkVkd1kvNXhFelFCTEdNZVBlM1JxVXIzU2dMOWRp?=
 =?utf-8?B?ZDh4NmhDOHFXWHhYYUdHVThKY3RlbHQ1anJURXNkc0VHSjM0bmVLZ0lLcGY1?=
 =?utf-8?B?Mm4xL1N0VFhaSEN1RHBLUkI5dS9OTDhVZnBOcHdlTmg1WElicHdJN0NnQjB5?=
 =?utf-8?B?ekNkai9SSzAyaUpiNlB1a2JMTVhYajJiL2pjL0pWL2MxQ05iNEpnSFFLc1Zr?=
 =?utf-8?B?bXArWDVOSy91WnFHaXorNVZtbTZQY094VVlOYkxRWEtvSkw4NVhxNFpyOFBW?=
 =?utf-8?B?a1VLZUdGWWcyNGRkZXdscG5TaXVodGY5THJiMlBVL283YkxYRTdjWG52bmlF?=
 =?utf-8?B?bzAvK0FFaitqOHZjRVQxakF4WStQVzZmR05iaFk3OG5zZU4yZUcvaVUrMnpC?=
 =?utf-8?B?NzRCVEVoNS9lWXlub0lFNTM4UGxrWG5kM3J6ZVZlN3ZCeU9pbTcxMEtrYVNk?=
 =?utf-8?B?OFhIVzlJeHpYZzFWWlc5bW5IQlo4UU9sdFU3MFJuQ3d1cGZlaTRRdWpQTzU0?=
 =?utf-8?Q?IoIhS+0hYLtgdGNnL1FcnhncFO6qV6GX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFBU2hlR053cmRRMHhSSnZPVDdOb0dMUUVoUXZ2L0RoYkxnSEp4U2pRendn?=
 =?utf-8?B?UlVOZC94ZGRrUk93WG1FQncrRUlwY0tpbXhqTTBzRWY0R1hoS3ZnZ3Y1Y3J1?=
 =?utf-8?B?dnBEQXg2RXg0bXplVmFQOGZCN0RUU3o0TXlmS0trVjQxWjNCK3ZacnVuVXFE?=
 =?utf-8?B?QWJMTHNSSXphL0l5eUVlVk1sV3VGcGdkT2kxV093UlQzeHYvbEhFQnJWdlJD?=
 =?utf-8?B?VTl2Wno5UG9Rd1NRcmJQekRpNzNUUHFSa2ZoN2VBY0haRVYyRldYRzVvZmU0?=
 =?utf-8?B?YVZLWXN3TVRLbG4zQ3N3UDA4eHZ0Mit2NE4vTUhnZys0cWNzY2pWV2JCREhy?=
 =?utf-8?B?aCtGQWd6SEttbDNFUUM1UERncDR5QXdwZGpBUW1DL1BtTUhHUGdKRUdwV3JB?=
 =?utf-8?B?bzQ0NnJYbkJwT3drbUtZTml6WFNBK0ZsV2dEVEpWcWVucFVRNU1ycnhOcHJG?=
 =?utf-8?B?eE5qSGEyZm1id3IwWVJzM2lJWkRJYm1Bd0I3YkxRRjN4QWFtcHg2djRPUXVK?=
 =?utf-8?B?aFdoMitrMlVCVWhLN0hiYU9qTklpM3F6NC9BbjFaakRvN2dQK2dzOENGZXZP?=
 =?utf-8?B?RWt0MXdEMzlVeFlZOTAveXpUT0NacDhVQysxNE1nQXAxdDdjNXhEYVhKRTBx?=
 =?utf-8?B?RnhGb0s1c2pkY3NyTXpvMDY0YkJ0QXRkMzFSRzlsVTZuODJ5aUxJR0lCMHFr?=
 =?utf-8?B?NGxZRUJkSWNTS2haTmVtWVp6QURIZXIxbkY2ckwweGg3eWFUNmJjWmh3WGND?=
 =?utf-8?B?ZkZERnRWTkpSZTAwOVhRZlB2dnV0UGdENUtDYzkwY1ZFbklYencvaXcxTHlP?=
 =?utf-8?B?Q0JYU2xURWtvY2s0dS9BVFpKMDg1RmUrK2tBalRwZGllcEtaTDBJTmJCRzJp?=
 =?utf-8?B?S2tnSDV1TTBBdFFXRkRJdmJFcXh5TTZoNzEzVmU5TUFQd2p6akRjM0xUV2M2?=
 =?utf-8?B?YXZ2WGpPdUpOeWdZVnpMVXBPQ1ZqWTNHRFQ5cXM1WHc5VUMweCtDNmpaZkN1?=
 =?utf-8?B?MXh3V2dhUjhsY0hNREtBck1NV1FORlM1Qmc0dlpuaDU3UWE3SmtvTEM0UCtM?=
 =?utf-8?B?cWdGajI2QlQ2UXpLOEN1M0psNG5kN2RRR3lrWktaQURDbUdBVXVzekduM1BK?=
 =?utf-8?B?WjJLZlBKRGU5cmtYWDlOSHpFbzdrdjhORnhtNGVLVjJhZDZBTUJiQll5RkM3?=
 =?utf-8?B?bTgzb3RUWTZ3SytsbW1GcWxuT0duck5YOWNTMUZOdUIyQ3NrTm5TVm9SVXkz?=
 =?utf-8?B?d25CQVcwYVYyaXIxaHo3M2hFYmdUZm4xcExVVlhjaUY5YkdNYWIreUsvS2JF?=
 =?utf-8?B?azhLdUZJK0NyVjVCWXhvNGNZYVp2MncxNVpRVlhEQTFNN0puaUJIUUhRandF?=
 =?utf-8?B?RWNlaXNIakRSNWd6MWRqMHBmVzE0cHR1bmpuMCswQytlblhPNGhlbWF5eExo?=
 =?utf-8?B?cHVlcVV5MTliRjVOU2M2V000eVNsRWtRMUYxSXJUcnFqaDRFU1plNm9YaUxH?=
 =?utf-8?B?ZVJycVMwL3FqTUQ2UWhGeHVLdjA2bEJ1dnpQR1gwWkZVT3YzTERPMk4vWWY2?=
 =?utf-8?B?QXRiV004QmFUblRkZjJPNE92NFNiMzdseXF1d2RGRkQyR0hrdjI2OHRPcity?=
 =?utf-8?B?dGlJU3FwQWxuUkZjdExTWHZac2pHTGY5Ri8rdVBiT1JySUJhemx1WllzUGZQ?=
 =?utf-8?B?eTZNc3h3YmVQdjZkdU1Tb1UvbEVneTkySVNOQ1UxU0NaWnBXNklpZzV2M0oz?=
 =?utf-8?B?Y3hTNkFMd0FhMTdLTTU4S214VWZhZFpteUdDOWV0ODdDTmY2aGJBd0M3SmxL?=
 =?utf-8?B?NXE2bU92c0ZzT3BmbWxFZjh0N1FMaG9VSUsvc2haYmpZblByT1FwSkRKeVVK?=
 =?utf-8?B?amFSb2tMSmZBTkpldXdiUit1LzBRTXQ5Y2w1UWVZSWdudUwyd2tBZ1FWYW5L?=
 =?utf-8?B?bGMzSlV5RTZrNGQ5bjJWTXI2NGw2aVJhbmtVSlFiT2tIT3lkQjV2UnR6UjFY?=
 =?utf-8?B?US82U1BiZk8reXU4Umtta043YW9waUJORlBBMFhPdXdyRkpsRENFSVFsYnFE?=
 =?utf-8?B?SUZiVFVxMzR0SFpVVjgwVGw3S1pjZ3ZqQzUrYWtJeks3Nk1QaHBFcXR5b1VB?=
 =?utf-8?B?dE4xd1dXNGJ6dGNOSHJLaDVheDhpUWk3MzhSQ0k5VTBuK21zWmZKUEhxMllV?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b37edb-1cb1-4a0c-e682-08de04c5ab3f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:46:56.4400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFZQDqkNE9039nekhngWAJhBUIKayoLn+6sJusx52CtD+Z1Z2q9nZT7RvHeFzbMEu166PT8NZAj/xKxTw3f8/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com

On 06/10/2025 12:28, Michael Garofalo wrote:
>> On 06/10/2025 10:35, Adrian Hunter wrote:
>>> On 06/10/2025 04:36, Michael Garofalo wrote:
>>>> This patch series adds a new bit to quirks2 for disabling the bounce
>>>> buffer.  On some hardware, this is required for proper operation.  An
>>>> example of such hardware is the SDHCI controller of the Nintendo Wii's
>>>> "Hollywood" chipset.  Without this patch, the onboard Broadcom 4318
>>>> Wi-Fi fails to connect to any networks.
>>>
>>> The bounce buffer should not make any difference, so it is likely
>>> a different problem that gets hidden when the bounce buffer is not
>>> used.
>>>
>>>> Could you enable dynamic debug messages and show the messages
>>>> for the failing case?
>>>
>>> Actually will also need to see the messages in the "fixed" case
>>> to compare.
> I'm afraid I won't be able to provide those easily, at least not with the
> commands you've provided.  Since the rootfs is _also_ running from SD,
> turning on full MMC logs like this produces an obscene amount of noise
> from the storage, unrelated to the SDIO wireless.  It gets even worse with
> my original intention, which was to save the logs to SD Card, (since my USB
> Gecko serial console is rather flakey, and introduces corruption now and then),
> since it's now logging the writes of it's own logs in a permanent loop.
> If there's a way to narrow down the logs to specifically whatever portions
> you're interested in, and filter out the noise, I would happily provide it.

Are there any error messages?

