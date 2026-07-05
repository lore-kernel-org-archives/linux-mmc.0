Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E8368968;
	Sun,  5 Jul 2026 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239310; cv=fail; b=IFzKVLslaxKYdGMnDvxNvdSR/EupFFYz8dNVFrqqow+W14al9q6B5fqgpG88YwqOYqIVM7/iWilbU5TFHNYrON9dF1+og6qmc86USJYKAFXxMoz/OJNS4Q1qvy6LjRqInMU+x0UtXKH6vZ9plDZ2KpKNVi+oHrJ2H9QMXIX7nBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239310; c=relaxed/simple;
	bh=fcNFUdmyEtIcGLEHGiPRvR3YBfAR982jBLrLieosZjQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bD2YK/6FbhI9UOUmC4tyoJh2SksgfISPDf9XizYOTHDLPVYeNRtYWvW5ZchoK3KD48W8bmd6RrBq41fdAZ8X+c4HC7EkNLiyrGurztS4HrqOn3AUJvuHx8KHo/8IUJqwy37Q3lEpsTOnERPRdySz1GWBBOY0IusgOd00JAkOIYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDokHzxT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDokHzxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783239307; x=1814775307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fcNFUdmyEtIcGLEHGiPRvR3YBfAR982jBLrLieosZjQ=;
  b=DDokHzxTTZRixp60n334DSUqHyfQAp0aeEE3A+yLd4tAzlJ8yaLZnwAP
   f0PO7FLyVJ+cKBIhgahC/55pY3BX7R4FOtkAKgc8wRhAhzAI2HJgFqIkg
   faGQB3NAMJDLD5i/JElgE9nsu1KmEp6z8R96hwC/v2NtJWT7E3y66f6L0
   hPw3nk8XVQS2coX1m9Qpzo16QsXETq684RMSuiZIrnOheOnJNl/MQf3I9
   E5iiimUY7SmBR0pQWgh/Sa6ZCe5KdhQFnioQwJQIDk2BaxWWA0yzBeJyE
   sC+iNzs9bXBp/qDXkKjy3K0IZs15kCg9BAv8fqmysNDyuUIlgZs+ej2iF
   A==;
X-CSE-ConnectionGUID: UaVa/M1CRgaabgsrpSxyeQ==
X-CSE-MsgGUID: nJfNnBlqQh6A6ApmEt1Gdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="83679001"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83679001"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:15:07 -0700
X-CSE-ConnectionGUID: mpVwxc1qSSamNm9EggZ/sQ==
X-CSE-MsgGUID: QyXLyU0+QtuyNzKgnQI9AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="257772725"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 01:15:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:15:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 5 Jul 2026 01:15:06 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.68) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 5 Jul 2026 01:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crhRqWx6ei5mTlHG20ZJT3mOPKCNg+rufoZ2P8jTRgXHHzJuCs4t6AsFbLtLSr9J886MXPcGuYz2Q5BZ85mUhD39u3ZQzqt3IcgVcF/GYMv++oouaTBqP58dxSUguCQJRgGuPlarstzxmJeoOUP0do8qypbb2hVPJTCFbE1XX2P2YEBxMai4QldhnIw9tjB2AokNEe/5V/rQG5SP5DeGXp8e7hKuZjsMpkOfQWUhxTgLfG6aamaIVIArWJbzjgb9MbnA75HaKZu+JqR0RIaFwqHROgz8Gtn31kOeVDqmgUPb2Xqt6K3F+woQin7pv1aSeRMBSV4rLNA5PTHmhm/5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qGYb6qbL2KvB+DM0CMnIhdyGiW5A2H64wnRT3icbScs=;
 b=bqUZnrZ4LUdDInuFnEdq7lI1dFn+vs1S8/RG9DhM/eYa0MHCgalMI/O4M6zJQ0ZgZ2q02plyMxDmSaroC1X7YS4NxFW7KxG+iDmA3RftPkTgSTtQz9+udYuA8g3cyqkXBo0fLlO3bz0hDHdubI8m3bqH8Pf0bVJhaw5tv4MxOCeBwPAAvlSC6uIamMN9nnH910E/VgrTnmAf9xPzig5mg0xW/9Vam4iZ2pDmnbrhEuCDOnfR7ykDKu9lQ6PdmQ4KPDWHu0lYjyxDrlCMTDOFGBEyXdOPu9OUrOTTjU+D2/HPrb4piUBOVpKYQSsHGRYivPN+zd/A86qJU4Pv9q+2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB9445.namprd11.prod.outlook.com (2603:10b6:208:578::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 08:14:58 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 08:14:57 +0000
Message-ID: <c1cfc800-f590-454d-9493-55cf6bed938f@intel.com>
Date: Sun, 5 Jul 2026 11:14:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] mmc: sdhci-esdhc-imx: restore pinctrl before
 restoring ios timing on resume
To: <ziniu.wang_1@oss.nxp.com>, <ulfh@kernel.org>, <haibo.chen@nxp.com>,
	<Frank.Li@nxp.com>
CC: <s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260703104208.3426374-1-ziniu.wang_1@oss.nxp.com>
 <20260703104208.3426374-4-ziniu.wang_1@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260703104208.3426374-4-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0236.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::31) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ee273d-3793-4db1-f1d1-08deda6d808e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|18002099003|56012099006|4143699003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: bIFDopd6t/gYWSSaeepLchGdyq+/AZ+/StiHDQn3f3OxB9rmqWX/TidJ5w+o88nuDxnFvkyDKRLHGPfakrPrbRbtBBzVlIPYwdk4LvpYGcie2YZhjkc2CdrTKdtVxlbURGEbotQoXA0XLNgozUkxYLGLuqEkAMdsmHYOUN6fIvMkBSvXpZ6dkMJM7lRd6xv5XZeCiLXyo2acY7X5oHqLnPVbTOgUR5UQb5QKZ9Ek/VgMRnTkE0XmDuN+E7+b3mYh0fE11uba1EuoFWywg2bUDB2kkUFWc637vVnfHzPHfdQalH1QF+Lss6wg91bPpCX1XeRCmibzNqpWeG7GHuMQwMbxc4ClMFG0Jxdvr6IPRLKi55Ywj5bymSRBYWVOkc8hfWmq5gN+hWwOmHJrUBzNZ0hRh2WkjFXq1m2w9q4upbG+8aHQUrkMvdgBQPGgAh/sbdOr4BUpxTdTbKMzzn6n0JJldwsnmk1jjt2vpdUiXd3JVufujtrnMmkPRTOBJZwzFgI2KTmrOf/jvzlbbvROAdG64QZVXCzDoyCyrkk23S9LjD6oCLw02XBluO6rPQQQUtllznaxitehcqtKBH3PZYMNwa/pEsfDOljmk38JVIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(18002099003)(56012099006)(4143699003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVcvVVZZYlRFWVpOQmhFMGNFSWd2ZkhidWVWVmdVWXRRZkM3R0VIcnZxREY5?=
 =?utf-8?B?YTViR1FHL3E3VU5kWGF0dm5jYjBtNFFxWTkwMHd2a3BUSytKZDdzQ1VBTTNG?=
 =?utf-8?B?eFNNMitSL3IxZnB6YXIyRXYxdXZGaXVGMHlFdENYYTJtYnFLQTJ1OU1sL1NL?=
 =?utf-8?B?V2dDVDMxV2FWaTUyVTlaeU0yRlFnQ3U0UnJ4VjZIRHVCQWUzanN3T0drVk9M?=
 =?utf-8?B?czJuWG4vUmxtZk5zRi9XbHZwZkhidkhrU1VIRCttUEdycGU5SGhEMHJCaG1O?=
 =?utf-8?B?Z2xNdGZGYmE4bWJyVGdoalFQVkthZEtGRTkrWjk3a0xiV1JFME44NlpQUFh3?=
 =?utf-8?B?UkdDWVFJM1hPeXA4NUhGSmhtb2drNFZpTHFNd2xPa3pFQURFRUZGMlg2N09J?=
 =?utf-8?B?ZklBbzFQa1pwa3k4RU1icHlxQTBBMFQyS2dpZTR2TEQ3STErdmdIZjBWQis3?=
 =?utf-8?B?RENNKzhCYU1RU3hsOC96S2ovUXhteXV1Mys0YUphQ1kyN3llTTU0WkZhcytZ?=
 =?utf-8?B?ZEcvOWRjQTV5R2VIS054eG1ycmUraU1LUXNXVjB4QXdQMkcxdmU5VGRDQVl5?=
 =?utf-8?B?bFoxN3BrTWtVeXZsbnpmYTlTdnBSV3dSc25uTnI2QTBXbTc0ZlRpd1RxMzhj?=
 =?utf-8?B?ZW42MHYzZkpFRnBFN05CWUJtWUFRZzZhL1JJOHBsOGZPRVhMalBWUE15TXNE?=
 =?utf-8?B?bkRzYWZCOWtuZTBVUEZJM1FBU2I2Zkg3bDNBaTBqNXQ2Mi94TXZpbU1odlYv?=
 =?utf-8?B?ZnNRTXhDVTkybXN6akNhNzVJR3VTOCtEMGZ5dk8zRU5OTHk2SkdCcGxlQnNZ?=
 =?utf-8?B?RUdwenZGSDNFalR5Tkp3MlV3dUFwTGNUUUJoRWIvMWtnSjl3VkQ3Q0xaTzZ4?=
 =?utf-8?B?dnNrc1hQeHAyVFVHNmxiMyttNzIxcVYzV1NNekcrMXVpY1d4M3FoV01WQUJm?=
 =?utf-8?B?MUlNT2ZDcGNXdmZEMzZmczRaYitTV1UwZzRmZkI0Rmx4RU1qbTl2S1RxWVpo?=
 =?utf-8?B?d0tqblkzcm9ybGdnUnBjMWpTNy9rekN4aVoyRGRZZEYwS3hiWWErK0N5dDhE?=
 =?utf-8?B?Mm5oT2kvM2pjY3h2cVcwaVIvYzhnbmlSeXAyTjBJQ09WTlY1T0pCTm5HRUIy?=
 =?utf-8?B?Y3BRZENQSjBVbkdvN3hjRFJoQnA3VXlZRUI3czZMem5RVnpWQjEzVHZOYlpl?=
 =?utf-8?B?UHp3Wm42NFVoenpTN3RyeW1WRFcybkczRVMwc1hlMUxZaUVGcWl3dDF4dGFh?=
 =?utf-8?B?QVlZU1l5RmFLNWFJRUNROVdOU0xHT2tmdXQxbFo1TGlPazlDVU9zQlJvVjN4?=
 =?utf-8?B?Q2ROSmtaem5KN1RrWEhGMnhSSXpLS04zcElwN25makRCTXhEblkyNXFCWjlK?=
 =?utf-8?B?Q3FrR0FhaEdGeTVBUXV1cFRLdE5FV0llY3lNYkFQQ1FJR1A0Z0FBczdFOGV1?=
 =?utf-8?B?aStwWlB3bENEd1BIaG5yK2dMK0paSUF3a1NYVENHNExydzFNaTFOeUlWVUhw?=
 =?utf-8?B?ZkcvYzBPSis4c0ZYTlIrc0ttZUhtRWtlaTJxZEFsZk5iRG5pK2lKMkM5MWtP?=
 =?utf-8?B?RGFKVnlJYnd2ZmtpcjBXdkoyUGk3bjlsNkFpRlhHVmZGYjZNR2M5VHk1VlM4?=
 =?utf-8?B?QkNHTmswbXdKdWJrNWhwYXZjTFdGM2RMN3BUbHpGb01uZzFpMU11L0EydkJV?=
 =?utf-8?B?dVdqcCt0bjhnVGdXSjBSVzF4YnZrYnhkNkgyRllwai9wV2FiekxrNnlLdWpL?=
 =?utf-8?B?ZFk2M0VtcTNIRVZyaTFabGVKVS9YdVdZeXdubVkvRzhkd2hhOHN6QjJqZ1Q4?=
 =?utf-8?B?WkFMdmZoWXgzMU1POUVRT1BSOTliMTVZMm4vSmpUa3hJajRJVUpPSDhXWXk5?=
 =?utf-8?B?Q1BSeFpqK1ZaanZuU3RqQzlUY1FDTWVGZHVrcXlIeEkrbXNKV2J3cGwreCt0?=
 =?utf-8?B?ZmZJTDhOZkp6eXB4RlptVkY2Q1hSVkJqOGpieHFRVlpMRzVyRW5sUWVOdG14?=
 =?utf-8?B?NzNVYkJYYWp3QTdLTXg1aVlYS1lmNHI1bFdscjBGRmtMckJqK3puRVpzU2N0?=
 =?utf-8?B?S2NIZFBxT0FpOFNuSjl6bmFhUCsySitrZ3JldnNkTmdlOHIxZlM1anRNa1NZ?=
 =?utf-8?B?RllhUE9vZFFyZGcxakpzTkN4VFFwZkRReENUOGhNZnFjdGI0MldRVHVQLzZt?=
 =?utf-8?B?cVQ1dzMyUU1GeXVXcG1MUy9FeG1pM1htcTQwUERkN21wQy9yS2ZXRHpad0xh?=
 =?utf-8?B?OERycHFiK2RhbW5PaHo0OEtreTI2ZTUxVGgyTXJtYytNSFVKRnR5dVc1Q1hH?=
 =?utf-8?B?STlwbjlza2tseUlLcHNrYVFKaS9uK25uTERuOGY4SEdrVnNVVE9zR2pXbXh3?=
 =?utf-8?Q?aKj0NRyTLPFwpbJw=3D?=
X-Exchange-RoutingPolicyChecked: jO/dsIC2G+06MGL6cYbImbEoy2l3OJ58iWWt9HKtJeOYvJQbWQEub0DK4Z4aHQKOpjNSioF40LPOvC3cvykZmu2XPks9dFLZhbDvRIvCRdTDHCEtC1aOyRT1gSIAh+OS6+yun+6NmkZqQfPsdvudkHXobYoofrzAFL72Ix1abS6Fe+yONemeBfOkUBXFNB3HfYuwYqZlg24cHvw8L451n5p3gSKzjlmDMLDwbkA5Q4zXv4+L//LVnY6e6jrmIpnJ+00i4wVbEG4c8nqBe4tY+WuMdMHEXSQjJjU7IrtoHI5C5MJY8PjacuSM9DErYSq6cDnQvX8VsLbcpxIHCv+e1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ee273d-3793-4db1-f1d1-08deda6d808e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 08:14:57.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvn0z9EEcXrIw1m7TazUSK9E7CsvO+Rn+OzKGJ/WYH2/8eO9JF8J80/giVZqPeo61QaVAlfnEH/T9OLq4IpMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9445
X-OriginatorOrg: intel.com

On 03/07/2026 13:42, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> SDIO devices such as WiFi may keep power during suspend, so the MMC
> core skips full card re-initialization on resume and directly restores
> the host controller's ios timing to match the card. For DDR mode,
> pm_runtime_force_resume() sets DDR_EN before the pin configuration is
> restored from sleep state.
> 
> This is related to the SoC IP integration: switching pinctrl setting
> (changing alt from GPIO to USDHC) impacts the internal loopback path.
> If pinctrl configures the pad to GPIO function, once DDR_EN is set, the
> DLL delay will be fixed based on the GPIO function loopback path. When
> the pinctrl is later changed to USDHC function, the internal loopback
> path changes, making the original fixed sample point no longer suitable
> for the current loopback path. This causes persistent read CRC errors on
> subsequent data transfers.
> 
> SD/eMMC running in DDR mode are unaffected as they are fully
> re-initialized from legacy timing after resume.
> 
> Fix this by restoring the pinctrl state based on current timing mode
> using esdhc_change_pinstate() before pm_runtime_force_resume(). This
> ensures the correct pin configuration (e.g., 100/200MHz for UHS modes)
> is applied before DDR_EN is set. Only restore for non-wakeup devices
> since wakeup devices kept their active pin state during suspend.
> 
> Fixes: 676a83855614 ("mmc: host: sdhci-esdhc-imx: refactor the system PM logic")
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7230d70e02ae..3b1e63425a19 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -2113,6 +2113,12 @@ static int sdhci_esdhc_resume(struct device *dev)
>  	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>  	int ret;
>  
> +	if (!device_may_wakeup(dev)) {
> +		ret = esdhc_change_pinstate(host, host->timing);
> +		if (ret)
> +			dev_warn(dev, "Failed to restore pinctrl state\n");

Sashiko has a point about this dev_warn().  See its first comment in:

	https://sashiko.dev/#/patchset/20260703104208.3426374-1-ziniu.wang_1%40oss.nxp.com?part=3

> +	}
> +
>  	pm_runtime_force_resume(dev);
>  
>  	ret = mmc_gpio_set_cd_wake(host->mmc, false);

