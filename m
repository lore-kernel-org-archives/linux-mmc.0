Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794710210;
	b=mM8i8zo8h3voMYUVyqiUBav3o+s+kJc3nMlrjmYU/AvnCN1ERiMSeb1PdjaWzsmsXhE0
	 H3T2fG+iNGOawkLEV0dSnipzPp1PXMIhi6VKb7t6Om9MS3epbeZ8ju/60Roe1D92axh4Q
	 Qn8fZGkGFs/3/MT9TIUHFUKaMbYtYC2a7XzyIdfeJA2w9C5JX6DteE/CGXHENbqqhJ4qv
	 9RDmSwOYYiVIVFtbD66A8NaEKMWDS61YZ+5b+qY+OB6w6jasSA5jGvrCj7X1NlPDfjKqi
	 GLeN6/G363p00s+bsXJKYIAd8jorlqE0ad9FYNrVMaWCAWXSQOUhR3E/AS/mwrY/O2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794710210;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=4T822H3/isrVkmrhUPF4njzqX+W3SU6jq9sC9RdKzfg=;
	b=2+QGpq0gzTbV6/YmfmVckJKqLXHngLRdOJqv2x9Snb/+gS4QPHdjOk8vkwIsdmi188RQ
	 1cW64f4oLFSjAaKBbEdLTc6/OTcOlbGHVsy/ZR1wmS0XUgg5kYC4CzyE4ciNhi9K0RH+h
	 5Jv2CqCU28UdyyjLelrgQLYOuQlCqxh7vLowidm1uGeeCD4IUYNoUZ0wTqGYVR+GWqOdp
	 wqslHnqc4RUGy1rBjeHnngjdPepwfY//HtDgJ8ujIgdv4cfQgSwgMG+7MT5TP/40Kfkza
	 aRBc2poI5Btm/VSZGoEDdZy5W73Ypoe/UDuXqg51+NkccbgClaerOj3xkalKGIO0T1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OiOPyJRm;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="YObV8ns/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF3606A323;
	Sun, 15 Nov 2026 02:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FBF3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OiOPyJRm;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YObV8ns/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794710210; x=1826246210;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HC8F4aX6H6+uFypKPDCa7RvKjrGf42Bc815wv2gp9gQ=;
  b=OiOPyJRm0FuLAqStm4TGH4Ac5g5UW2pt4/hSxLOCFEoQ3P9+8q4uRDz1
   QyAHRcCsRlSN9i9mf4pR3LasRPF3hKEV3qeRUL9TdKuHOZpPuegSnhFgD
   KF+XjTYqrT1oEu9/wmAit3l7S1X9Ow6UhHeyKABwNnHueEEpLlsPNMqD1
   c/kW/btQIaPUIL00an+F+Wmj8rJd4dulHkyiTrkW8/bXZdJEvkQzkSlbO
   kQ01XoRO3a6JIbXXWDAPngEa2oPSG/Np0/QVXmRdBhgXqLN8LBfOmVMif
   730ktmwD3KLV6DfTsXsrLo+3yHx8odaD621d6vvR2woGIOH+duEkMhcFN
   w==;
X-CSE-ConnectionGUID: kuTNT+v3RFSbJhfe6ig4HA==
X-CSE-MsgGUID: R91TLgHZQ6atX132P+iGJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3372956"
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="3372956"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 18:36:49 -0800
X-CSE-ConnectionGUID: YIt7FRixRhGy+naaUJyZDA==
X-CSE-MsgGUID: DF1KPt/EQkqIuAHdI0mFGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,214,1787036400"; 
   d="scan'208";a="9596242"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 18:36:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 14 Nov 2026 18:36:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sat, 14 Nov 2026 18:36:48 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sat, 14 Nov 2026 18:36:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qt3B1szAk4aE3JkD4YNExv4Q6xGHRv7RYSxBAdQY7WPmVZMyBmRblHgHXSAAb67W2mDzBHwf92EI0dTzxeTklyYsmr767uhuB5BHlGc3cdgch0Cly7oaXDbwhZAU9Q1H2C9BSByz1Vd/7Ne3GmGaV2xT6O9ZNzBrNssiUeic0ELWOWJEYPt57TzzrMdOVn668TFfqsWpQ2uZNnmsuWeBdeI+4CJGvLP35tPDDG8EBSe2SV3d0/zEtGsYiU9QVBgV9UUpsRQeENu5dVtvbA1xQztaA2Fym9vAKlj0r80fSg+ia9JM4vOFF8uGnjf8AUn7B6y/0AZit4+P9d2ic3CJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4T822H3/isrVkmrhUPF4njzqX+W3SU6jq9sC9RdKzfg=;
 b=rv6WUknfKx6fHLWKcCO82vYFjMg7d+c4gWjUQwFqIPBSsBk/g5iWvnpV8iOs83eZP96pLFMuV8GMB/kqL0DRyzhduy2YX6saAplQLw0C8jtFjgbicT7Hccby7S+w49AqMjpkIl5RXWqo2jYDDTjgAz/Chw0RQxVMnGxThOG6jOIMu7Nk5813ryaGnLhp9vpf4amu8XPcryquqlqQRatseaZ/vmiZtlzmjALjtGxmC0hbAbSCJTB4M4mHZra6gUnXNWKl8Z+ENXFMDFNTZFOQHZrU0l06GUyPQmpXuPHKYWGJmljixmALOOx8ncqn7CibC/kIBbIzBWR1+y8BuURBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4T822H3/isrVkmrhUPF4njzqX+W3SU6jq9sC9RdKzfg=;
 b=YObV8ns/qMzzD+zWtm6HmwiVtkJTXl4A3UwMau0FIOA8+p2wZUq/akPhJag83CLl1s68mopxctu2kI/NJXKIyCfg8vdTJCpo9vdNOjLYqEP1vGjBzASTKydEVSmo/JtPpEwD+XCCDKeP2hl5P9Q7Szp8lhUPHcDHjIJtz1xuBK4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SAWPR11MB9572.namprd11.prod.outlook.com (2603:10b6:806:4e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Sun, 15 Nov
 2026 02:36:45 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0615.009; Sun, 15 Nov 2026
 02:36:45 +0000
Message-ID: <bd930ab2-71c5-4c10-9d04-56dcae99b5c8@intel.com>
Date: Sat, 14 Nov 2026 19:36:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: mmc: Drop Asutosh Das
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Ritesh Harjani
	<ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261112101443.62417-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606-4,
 Domiciled in Helsinki
In-Reply-To: <20261112101443.62417-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:303:8e::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SAWPR11MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d1e2ab-5258-4fa0-544a-08df42c14a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261026140227099003|10067099003|56012099006|261021123027099003|261009223027099003|11063799006|261028144727099003|261022105027099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7o4dVujSKauiJruV+a+NbIB/29LNlZu+tfnwzlLxSQ4O2gAVmK23UYMpC0B4ByqJ19vSCLsvtcH4U37641awBRk+5Cz5uS6V4yDywWDKE3cKIlzUVSTneARdoD8iBR8y0uY7k1e3HlnyKzQzRCZ6N6QBZxIukAmA9oufEvpbNHcQUeo8wr1LAO5qjXtA6v7Bs4usNA4REge42pf5tUU8wrAkqJXHQfK0vVAt2OoP/GLx/EMTPM+xjHWjAXIsvHAvLsPmSIA+o3PpCZaejahKPtd0M0ndaOesmkSP8OoF4sLt6ndJ8L9EDdT6pBxcaS8K3DOTp9lDaZQI//clqMPixnwXsGUkMiARLe9CebOmRljiSE2fMV2XE08PkZ1EVar6qvees7t8QWkLa4FyjHWg3Jn9cZBKrggB0mKyfrtohYIdfl5so1v0873l9fzfCwrpJiAV4HRJ7VcPH2uNMNxjHNDhUEiDbTVo0X2Z6bp3s2DrdNXMmMXmd/QQIYFqgSjFa6W2x6Tms+YFGjB+96SbhAiNgePvGHeMia698V7EBpMNaNvKhviP3HPY4Tzk0yhphLPehk1hZD12De71yZl/ihGkPOx1YeAuwY/q3gMOkFa9E0u4bjY6JaAT39EdftqTVoRheezvsSzuxUBs8ICGIp5kaRv+21pdvvFpKCRp4io=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261026140227099003)(10067099003)(56012099006)(261021123027099003)(261009223027099003)(11063799006)(261028144727099003)(261022105027099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xDL0p2ampQT1kxMlY5aHFXNWE5R1JUSEoxdGpWbWpxSnI0UDRuK0VLWm5Z?=
 =?utf-8?B?YUh5dkpXd0tCOEtscWxoN3J6T1Y3VUcxcElBY2YwOUtOd1RtMGcxQ3lwclRX?=
 =?utf-8?B?d3J6M3prNGRzOFlDNlY4dGZ0TGl5eFhSeVAxbUtjY000Z3ZWcFovQU5qNUZ4?=
 =?utf-8?B?RFlJMDF1c2NOcjVCQzMrekFhRWpxVTNaYXF0bTZacTBmaWllVUpTSVdpQktw?=
 =?utf-8?B?S0lra0wwbVpQaGM0RWxyZGFQd0RSNkpBWnNKdVlONTV5UXFSWWx5ZVozMEdy?=
 =?utf-8?B?TTB3QVRuS21TdFlPdGFZSEpuZ1NGZkxnS1lmY1VjVy9pT1VWcG84K1p5ZTFj?=
 =?utf-8?B?N1RGZGZCSW9HakM3ZThwaGZBdjFyUzRQRWNMS1QyVEJocmlYSEpVQTRYb1No?=
 =?utf-8?B?VDBpUHdQM1RFSjRoWC9jeXlZS2U1ejFHL3NPV0V3S2xWZHdSSU5xS2RCQkdP?=
 =?utf-8?B?UzFOMHhaQlhlR25TOTlRUVlhYUp5UEUrMEF5NTJScHhMQTB2TG8vUWtoUEVS?=
 =?utf-8?B?eHdzVGNOOFcyTzArRXhlRW5paXBKbnhmck9IcTdzdVlZcWpaU0kzamdsZzJR?=
 =?utf-8?B?a1g0THkwSHR2b25oSUwxcHJjVWk3UU5adEhucjd1eEJDaEVsWnBTemwvL0pz?=
 =?utf-8?B?K1IxRlRreEpwNTZXZXh1Tlo0NTZvZFU1akFvcWdxY2tvZ3Y3aWd6Sm1DTG9L?=
 =?utf-8?B?TnVvRm9FYk5iT3BqT094blljWnBXbDJKTTNiVVgvY3I4TEZkZ0tMeFBaYVBV?=
 =?utf-8?B?TGluNVlmZTVuejVPS3NZUlJoZDBoVU81N2I3ZzZGaFVVNHYzb3dkWWROVTZT?=
 =?utf-8?B?bFJKR2tDWTVPNFd6YnNWTEdzSml5QWx4Qmc0TGhWYUJJTXFrT3lxU1Nwalox?=
 =?utf-8?B?d0lEZ3hOWFYyMUtWVDFJekt6anFJWkFYYzR1ckFCcEc0U0hnMC9tOHkxa1Ru?=
 =?utf-8?B?Y1ltUDZ2czBodjVxc2d0aHlPVDhIU09JWnhqMHFTTFgwZW5aaWpJYm9Rc1FZ?=
 =?utf-8?B?aGpjdDUvQmV1UGJwbDJoWlhEem1mTXUzQ0FhbDVFZkVzY3REVGIranMyc2NN?=
 =?utf-8?B?NFJ3dUsxYld6d2lkMW8xS0tEcVlQNVBkRm9LeFZKMVFYYmFmUWZUbWtVMklo?=
 =?utf-8?B?eW1McURLOStiMlVpc2NYcGxPM2VQQnZIdEViN2YzQ3lsbGZCek1qZktnNzA4?=
 =?utf-8?B?TzNoeGk3NTY5M1ZMRFZ6MUR4S0gxdWpJVE5FR0xpT0VmN2EySVVOUzR0OG9l?=
 =?utf-8?B?N1NEd2p5ZU1tVWlabUkzVW5RMHE3aGtDK1BIQXpGZUQrRUlnb1pLZHRvTW5F?=
 =?utf-8?B?WHduSmpSVDVUckJjcGFBNm9DaTVKNUd3a1c1UUFVeTUwRHRQT21aam1GYTl6?=
 =?utf-8?B?VTBTelpYU3B4cXljeDBrc1pHT2FpVjRQNFFpWHJqbGZhTXN1blltL3ZYNWox?=
 =?utf-8?B?TjJQbkx1TWNGVVB6K2ZQWExqYUR0Lzk4R2hKUWlRWnpHN1FjWFEvWnRtWmVC?=
 =?utf-8?B?MmVBdTUyeU9hVTRFS2JhVmpqQUdHci9BTjNPTWo4MnV6ZmRjRWtWWm1WWmox?=
 =?utf-8?B?VHM2Y0NKR1NCc3VaM1BxNWEzM1p0K3JZL0lZazVtVG1ic3Y1UU81aDd5TndW?=
 =?utf-8?B?RFNpNVJYNmJpTkt4bnUyVk1WYVZvVzl3NU1vYy9KaE1DQnFPVFJMaWlibnpI?=
 =?utf-8?B?S0NQVDkxZUtpT0l5VC9BMmtKdU9QSUpDZlIvZFQ3cktsZ0s0S3BHLzMvaUlj?=
 =?utf-8?B?UTB5dWxXaE1NWVFaSnowOG1KQlBzcWRXUXBBZ2FzbEJlYlVZR0d6WFVvNlk4?=
 =?utf-8?B?OGhVREtadzVYblQ5dXJhMGY4MU1UQ3VNdVNWNWdLUXlkeS9wMkh0TVBXdG1m?=
 =?utf-8?B?elhGdUU2MUVwMUNrZTVyMkJnMThYVnhUT1ZYMnZGdDlhTlFtcW5CUVQ3T0VO?=
 =?utf-8?B?V0ZTbTVaMEdjNk9zam5XWkhJYXJlMFJLOEd5ZXVOMk1TZzNBazVtWi9jV2RT?=
 =?utf-8?B?U1BoOFZIdlh3Z3hWc21xMzhlU0NudFArbGNmeEYvU2NJUThZcG1QdTdtUkIz?=
 =?utf-8?B?amlQZkl1bExFQTdyY2Y3b3BRY3lzcDBMTFN5aTlISkdwckR4YnZtL3F6d0hq?=
 =?utf-8?B?c0ZrQUFBY3BHZVlRcFJOak9zbnc0NEtwYW82cDJNc3BHaHJXbExneVhCZ0x2?=
 =?utf-8?B?TEpYZENrbFozamlYdmlET1A4QUpZM1RoTW9PandkeWo5ckFhNys3aTNTZTYv?=
 =?utf-8?B?L2cxTkw1Sng2V1pBQVZ4eU1OS1lsL1Zycm5BQWZFSmZuUUpiRjFoUVVROS9s?=
 =?utf-8?B?QnhSOE1ZNlJsc3R4VWxkMHZ5RWc5ODc1dEczeFlFNzYyMXJVNkxGZz09?=
X-Exchange-RoutingPolicyChecked: MHXHI01kJqjmydaMnVWEAgt79f+H2rvuICicgRJk+5xf5s5/p70N8iJKaHlNUbCXvwo6bbNgzEOGjF8h9O7z8qYQ7UgprGPM3tZ2lOWeedOjo/w3mhkIYVHkvdDdKUVBUuBzKHpK7Bh3882nXl0a5YJXDblCeCzvCHZrwLCZp4nEpMvb+/IhTKQHWUol/RuOLryQyno9xmT0SRsT3XvZ3EwjjlCQECvckIpIuFjGwyk1MxXx5j9zW6Hpd4CqU9/5fyv7KYbTaTC8j1mIETVOV9k3GFmaAcXXBmvUToeh9LD2DHobw9P/IL64SfQFt7zZ+uxK+DNQJ5etvM1/7Rw8mQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d1e2ab-5258-4fa0-544a-08df42c14a6a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 02:36:45.7085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT2drhrGA0jZAGtpCp5P0/G3vHpNBnksUFeS9ZPmfGlkI3On7g6XGekvmdgtFPXUaajvnLQFi4CetbhCOnHVHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9572
X-OriginatorOrg: intel.com

On 12/11/2026 12:14, Krzysztof Kozlowski wrote:
> Emails to Asutosh Das bounce permanently with 550 code.  quicinc.com
> domain was long time ago changed to oss.qualcomm.com and every Qualcomm
> maintainer was asked to do the update in maintainers file, thus if that
> update did not happen, then maintainer has moved on.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa647f5d37dd..b0ba5fd61b33 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9868,7 +9868,6 @@ F:	drivers/media/usb/em28xx/
>   
>   EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
>   M:	Adrian Hunter <adrian.hunter@intel.com>
> -M:	Asutosh Das <quic_asutoshd@quicinc.com>
>   R:	Ritesh Harjani <ritesh.list@gmail.com>
>   L:	linux-mmc@vger.kernel.org
>   S:	Supported

