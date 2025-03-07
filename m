Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE82417C3;
	Fri,  7 Mar 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741373073; cv=fail; b=nrlPNLl/IIsMhvgS3BJsLRnzPJOSJkaeGOdv5kFnilwVrNmpLvHkok8CwDhRMnKg2c6lzvG/IFbVp0gs0eXMtYdIWQUKF2etouSf00qD0/CAYvkYcHE1m/e0pQ2WFRwxOd0kIBpZwfTanZceV7AhtMlMwtOAz4VruiG56+A7uF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741373073; c=relaxed/simple;
	bh=4+wqBPZPY+6UkzSTeyUztmgu4na3iurQhX6HXkWukBU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RyIyzISdvowiqRZjkIPxaO2CwlxjMmxFAE0pI2rRVAqvEBAXy5cRLjnCjbS7CFwzwlUPObdvUYKrIIBuHopZv6heFleu6FIp5PR+pvt9tBF5nz9aPI1IN0+gKVv0XtwkJov3p8RKuSuJ//NGR4G0XvMwvIB/A1yADkTp9m03G2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAooB1bN; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAooB1bN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741373072; x=1772909072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4+wqBPZPY+6UkzSTeyUztmgu4na3iurQhX6HXkWukBU=;
  b=SAooB1bNHZZdbqBy9tOReq1r1tqkvRz5uahH5SaKSR16BI1veTpWQ0DY
   QYZYnDO+20Q3Mc94LBd9fMOKVzgzwkCiQAf3X7AqqSQTNDo8jb7t/IKhU
   /N0eYF2mirZIkXdBnR4Ytib6cu5sKfVKrg3SaY2kpPaIQR2MhjS92nQOy
   PmiyILXLnTJSyJLAPEZXzKBAaDizSBZcxNzVYqhztI1diWCokRAILaRpy
   eoYc8soKdDSsGppQln7jtLouhRR6LmZ6a2RzML4XC26cssk5nM0+GOpnB
   dJaxa1iKV6HqWadGrIN0URlkxp94baIrudY7p4sWsLRKEGa2uve/Dfgxa
   w==;
X-CSE-ConnectionGUID: ugJe+HT6TFqtr2RgUodNtw==
X-CSE-MsgGUID: GiaxgXl4RK+B613k6Fa7AA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42312441"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42312441"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:44:30 -0800
X-CSE-ConnectionGUID: 6yMOeNZwQ0Wfo4bDAI5F0w==
X-CSE-MsgGUID: BwckMkZHRMmgiVh93oOZ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119147557"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 10:44:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 7 Mar 2025 10:44:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 7 Mar 2025 10:44:29 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 7 Mar 2025 10:44:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyLc/8g24mTrRP9RgepUwogJkFl4x8U4eXw4Kb5ESNHmcZ5pkH/13kbe332R4Wybq1NRVlYifEAy9+QZSQmJZt4WKvTFzcraCvVE7hmflzJ4E/dp4jTS+TOLVjGOG+O242+BICRWC2ins8EYXlAvlP3QHTtW/P9763dNtb6j9g4kTiLVkhwsa+DF9huZu6vbc5tholWCbeEP5yFkPgVIXcqFH4W/v9LODw1VsNsrmthiwfzGSbl3on7qRH8jzTT5MOKfZiGYj7pvAGLWDliWcBROL8fmqGdLLCc1XRFIZQjrfcsrmYF23WaXfoyJL3R7xKk9FzaXsaF5Rgi/01aVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmY9a7M+66B/D1RlbZfRLlhy/mEUe0NIqYkFFSkN5DQ=;
 b=DB4Ug1+GLSkST9Q8I9xGgYVkhX8CBQRAA4cDHL/x4bgodX7SqXKIZRZto0fsGOe9EaHryYMYh6mUOBzW2e7sQ7fVGVf/nEHoGDXYBdcssJSWSUd5hR3oGJdnYoKp8noqya0gksFxXMdIgexcKkmSq9G7zv+YCpmquuZQoJC2sh2OeRLi46PC0I9+DwHXVoSlPtEXzKinnVrsYSb5TCZzZFBbt1P8TRR5hZiHyXpqi/ChPge52DLzTPwoLX4kirq42oAGLDe/v0uIkFAQoO2f+PO+/dIcC1k/5s8QOBkGeGNfvXPOh4ThavnUKjjBYLVhF81alq9ubjcooqjVMYPm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 18:44:26 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 18:44:26 +0000
Message-ID: <4030ee60-b607-4ddf-99d9-5348a741f7d5@intel.com>
Date: Fri, 7 Mar 2025 20:44:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] mmc: allow card to disable tuning
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <andy-ld.lu@mediatek.com>, <avri.altman@wdc.com>,
	<cw9316.lee@samsung.com>, <dsimic@manjaro.org>, <keita.aihara@sony.com>,
	<linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<quic_jjohnson@quicinc.com>, <ricardo@marliere.net>,
	<ulf.hansson@linaro.org>, <victor.shih@genesyslogic.com.tw>,
	<wsa+renesas@sang-engineering.com>
References: <9e34fea2-6bdd-4673-a75d-837d9b793c3d@intel.com>
 <20250307174545.1288682-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250307174545.1288682-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0a8c6a-4a62-41d0-fd57-08dd5da8161a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy9RYWc5N3QxMHFNZEhrQ1VvN3l3czBJbVFUVThHOFpjWGhLTCt2OTdubm1n?=
 =?utf-8?B?ZXVTUzJyRnp1RW1mY0JLVGw4OTNPWWNTMkM2LzFJQW1WZEMrZU4rbzFwSTE5?=
 =?utf-8?B?R3dnUG52K2FCSUxnQ0xUVHRFTlBLMy9LcWVwWHJBNEVaVzVaMDVhRTFnMDEy?=
 =?utf-8?B?YnFiSU1QTzk1Y2Y2ZXF4MlN4WTV2dzBmL29IeWVwYU0rMXNKUEFSOEttdVlo?=
 =?utf-8?B?cnpnUmpLK3pBME41MzVTU200dk42cEprcmpNR2VkUGF2UDhEN3U3QkVzd01L?=
 =?utf-8?B?YlBTclhZUTNrM1dxN3NVWTRrOUJoWkwrSUU2SUs1dExMVmF6dGkzd0o1Z0FS?=
 =?utf-8?B?bmV4SUV3RzZ4RERPaGlRcDJTN1U1UktYVzdqcHBjMFBGdVVjSTFncFVSdlBV?=
 =?utf-8?B?Q3dnSDlZZXVuR0ROUFUzTWNzTnU0WlNDQVVtR2JiZ0ZLak9NU2luTGpqU09I?=
 =?utf-8?B?TWpkM3FDOUtKVUlSK2F2ZDZJczVVYkFVVDhhc3ozY3hrQmlmY2FZQU9OL2U1?=
 =?utf-8?B?RTgvdEQ3VmJDT05KQmppSTVVV1hvOVc5SDUwSFJqTDJ4YnNpanNwU3AyWkJx?=
 =?utf-8?B?OExaa2lVRjFFWkNuRC9NdThBWUdRaU9UUWdPcURDRHpSZGVPNVNsb1RSd2c0?=
 =?utf-8?B?SVgvK0FPNlpJb2JWd1BHVDJQaVRsaFFkTUFtNGd6bk5nUHBPeWVER0N5STlz?=
 =?utf-8?B?NzBrREZzSXJZcmNkMGVVVjdkb2RhMUdqbGJxNkFXT3V1aldKQ2UwVkpUTHc3?=
 =?utf-8?B?ZFJpSjYyanBqUlZHOGJxT0ZSME44UWQ2ZEYrTko3ZnZpOGxXQkg4b0R3dFhC?=
 =?utf-8?B?WUtYYjltdDJjM2VQbEtWWTUwTVVHTUJCNmczd29meTRlM0Q0RjlzMDgrTVda?=
 =?utf-8?B?UkRUaHl3SHVFWGRLT3VLbGtxY2dDNThNZ2hsUGRyeEJjUzVxbVBWK2pUaHlh?=
 =?utf-8?B?a0tnUkJuNmRiMmREd3RPMTYyUnVQeWdsU0tVYnZCMWFNMWcwUUpaYkxsODdX?=
 =?utf-8?B?WHBGTmhTaXdGdUUwYnN4YXpLaGdYR2FPOExBK1FCL1dNS3hJMUU5NGZGTEhw?=
 =?utf-8?B?WU1EcnFsdE1VbFJLTjJhZDJGZnNwTHVacVVDQm13cGNYT0pOTTZnU3UxcXda?=
 =?utf-8?B?ZlFuT1FGVG90NEVzem5YZjJMMlFoMy9wT1krYTFYOEVKSU5MdGtWSkRqMGJE?=
 =?utf-8?B?am9BNk80RlMzZGRRL281aUg2MFJhd1BPREhvbFZ1dzVnRE1FSEdha3A4Z0ha?=
 =?utf-8?B?aWpTSlpUVmg2SFBoRExBMnkzUEk1eDhac001S1IxU2V4Ykc5OXNCT3pFclR6?=
 =?utf-8?B?bjhZTHFPNjExSWpRUmtMYWJlLzNZN0Q5MzA0c2lDREdaUkt6ZzZFVFFhWEpF?=
 =?utf-8?B?bkZkV01yRnFKTTd3MHpvaElGTE40RzRuRWxDckFZQzZSL1B6RVY0Mms3NTlJ?=
 =?utf-8?B?VDc4d1FPUC9ialg0T2M1dEs4UFRubXJ4OFNzQThldTFybVFBdlRKZjVHL2dt?=
 =?utf-8?B?MGd3R3MrWTNzQmlyWTBRVStQUThUcnhIbXEzdHUwcVNjbFJoS3ozUEg2TGFZ?=
 =?utf-8?B?d0RVNy8wZGlwNnJEZjFrSlArOS81bU5rMjRFTWZyYlRoVzMrNGNWeExxRTdC?=
 =?utf-8?B?aG9kdXdycnBpMjNHdEduTU9WQm02djlLV3NJUG5xd2RmSnJBMVEwMjl4Rno5?=
 =?utf-8?B?RUo2RmZkOHRobmNBQWkxMUJtMXhJTkdrd1grVDFERnlKL0ZPdUlzZkVJUlNC?=
 =?utf-8?B?WkxuRUJwTWdYYnFnSjc2czQvZTBVY3M5bERqMW9NZ2JnK1FBcmlGS0NkUVl4?=
 =?utf-8?Q?Y9zcGsyF69p48i6yJ1WnCu5Ha1px9sexXTHmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhNTHAyVWk5Y3dyOEVaN3dZcTZvSmFjUGRxRmlwRUVpWVpBZ3RqbVRycFVx?=
 =?utf-8?B?Nis4NFlodVErQWdmRmFOOXNHNkp0OGxYTCthZ3B2ZEhUUng2aHcvdUFMZXV5?=
 =?utf-8?B?TUNFemJKNElWczNBeGFMaTVqbmsvb0JkaWF1cWtjdEZmclpONFpsTmorTFEx?=
 =?utf-8?B?UW1xNG96aXNHbytxd2VmM1dVSFlFOEVJK1R1dGFoblMydkxOS1FFR3RRdnBE?=
 =?utf-8?B?UkFVWVJVME52TnVxWVpFNUl4WUNGTnBvOEtRUXU0MjUvb1Zxa084U0JZcmlQ?=
 =?utf-8?B?b0tjc2dFdFJiUGEvTkZ0N24xSURhWUZLM2JzalFRV1hBR3g5bFg0VjlWSW45?=
 =?utf-8?B?ZG84R2hEWmNieHIyVWJpR0xxaXl0dGlNV1FVbnBxQUYvV0FyN25tWDM5S2F6?=
 =?utf-8?B?RHVSdHVVeGtUT3o4Wi92SXgzT3FCNTMzWXFyN0xlOEg4Wmpzb3lkRlVLRDFt?=
 =?utf-8?B?TjR6VkJqVkkza0JrUTFUK1hDSXJvSGU5Q1JBczU4azNFOWNiM2szczJqN2ZY?=
 =?utf-8?B?THVKYTFtcm0wTFZtTDJPN0lSQ01kSm0vY0RycnA2MjhoMExRTXFXNWsrN09i?=
 =?utf-8?B?ZGtZZGx2VUV6YlZrN2lUblNzdHc1VlNseTliZFlsT1hNSDMyaW1TWktCUDBu?=
 =?utf-8?B?N3BWbllmWjZ5TW9RNGxNbG9KMkFqYUp3dnN2ZmlZUFRTSkliSkZoT05wTkdS?=
 =?utf-8?B?QStacFl6UDJBTU45djNEVkY1aWdVZEhadm1nMnEwRUVMTHFwL3ZETWNsUUpj?=
 =?utf-8?B?SnR0cmduQ2prbDQ5am9zQTFpT0tMR0paYTJMcGRsbDN1dDhCa29HQ0lTTUhE?=
 =?utf-8?B?c2d1QS9pOEY5UEs3WEdTQWFUc3hBOHVNZ25Gd082TEljNHpXa29uRUZhKzJG?=
 =?utf-8?B?elZKYTNkaGEzbG8rdEpETnR0a0dJSndlYXhHVS8yd3NYd29CZTlWVWV5VGhH?=
 =?utf-8?B?UjgwYXpPblk1Zlpka05EVE43SlF5RWNwUitYOXlaLzNnSlBZczRnSE9lM0ZE?=
 =?utf-8?B?bk9lZXVSMlRwek5nS2NKMnJaK1I2L2lVd2hkdld3SlU5UUVJanVtK1kxdFRJ?=
 =?utf-8?B?VDNlR3JpTDVYSWlBWDZzUDJHMmZYc01BTUEweXNCcWxWbGNVczhTY2NlZkU1?=
 =?utf-8?B?bjgxVklPbmxFWFVMQ25yUzRUVXdOa3Q3Sm1HNWJ4MWtKMWlIN2hWTkRMRlp5?=
 =?utf-8?B?Nitqa2Jad3lPMUZvMC9QMkhWUmthUG1tZDFUQVpFY1h5SmdPZnFnV2t2NnlL?=
 =?utf-8?B?ellKbnltR2d4Q1dUZmdMYXdwUEpkZDlpcTMyd3V0Ykp6OEtMUHVqSVdCZWJB?=
 =?utf-8?B?MVlQeGF4ZTViN3BpQzhRbUppMXcvYXdqNFduU1g0Lzdmb1ZxeG1DLzFMNG16?=
 =?utf-8?B?UGZRRkJVbTIrekZmOEYwZzdyUzY2Z0tLeXJTVktnbndNODY0NXZKa2p6Qmlp?=
 =?utf-8?B?MGovcFc2RXZQU3JBUXdNM3NKcE5pR05FeXFpT2lIWll1Z0hqYWI2VUMwOXMx?=
 =?utf-8?B?RWdOZTVKYUx4YVRmM3FQS2dVMW41eEhkN2kyL3NGTEFRc1F5TjVjY1M3eWJS?=
 =?utf-8?B?em14cVJYV205QWMrdE9UL0l1VHU2TkRWRWRqNytxaXhiNlZkWWJNVWxkTmR6?=
 =?utf-8?B?bW54cU50eERqdXU3ejlnWVc4RE0xVFNPOStqbnpOb3k3MUJja0tUODdobzlB?=
 =?utf-8?B?QzVRaVZhSlIvWGhYOVJpT2JjekVnMlR6KzBkZ0dQdSt5bGs1U2V1NGJqcG8x?=
 =?utf-8?B?MFc4VmprWlJiK2FvQ2U4SnJCQzdoL1U2VVdBQlBRdlZjb21BdVRPdlNGY2FI?=
 =?utf-8?B?MUVFZUFFWkgzSko2aHJWMFlaeERNNUtJNjZDVnRwZXR1MFJZVnk1bjUxdytw?=
 =?utf-8?B?aVoxN1o2NjFjZ2F2UXdDOEF3RmE1cnNqakJoa0MrVFptczk0cU54YTdaQVBI?=
 =?utf-8?B?dmV4aGw2RndNK1hRMldjTHVxSzU4Z29QYlloOXdlanVWTkUvcURHek9BWENG?=
 =?utf-8?B?R1Q2bGZ1dDR6b2ZaV0c3NnpKaVFFQVkyNGdEK3lUc1Era2NSaUMveWVIaSts?=
 =?utf-8?B?UDdPUVFtSHJBWHFOL1hDK1Q4MDZxb1NKUTBpd3liajdDNld3TlpaZVNsSlo5?=
 =?utf-8?B?WERXQ2lSOWJvTnZFTVJFYkFXNndnL0xaaWx1M0VkZ2hFYy9yancwZlRSaCtx?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0a8c6a-4a62-41d0-fd57-08dd5da8161a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 18:44:26.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwFORYnWta1qmULjQUEGFyF3v9m6guCNL7r63G6LLS8Oy+TJX6Pwh+DVcRrwgpH8Tt+4CVJ2PhLTCkwR46AUnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
X-OriginatorOrg: intel.com

On 7/03/25 19:45, Erick Shepherd wrote:
>> Sorry for the slow reply.
> 
>> I would expect if there was a general problem with DDR50 SD cards,
>> it would have come to light before now.
> 
>> Does the card work with any other host controllers with linux?
> 
>> If it is specific to a particular kind of card, a card quirk
>> could be added, say MMC_QUIRK_BROKEN_DDR50_TUNING
> 
> No worries. I have not tested this with other host controllers but
> can try to get something set up. This issue has only appeared on
> one particular SD card model for us so I would not be surprised if
> the I/O errors we see on subsequent tune requests are specific to this
> card. I can put together a solution using the card quirk you suggested
> if you think that is the best way forward.
> 
> My fix is currently spread across two commits, one to return the error
> code thrown by the tune request timing out, which prevents the card from
> retuning, and this one that prevents the initial card tuning if it has
> already failed. Should both parts be controlled by the new card quirk?

Does it tuning at all?  Maybe MMC_QUIRK_NO_UHS_DDR50_TUNING is a better
name, then at the top of mmc_execute_tuning()

	if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&
	    host->ios->timing == MMC_TIMING_UHS_DDR50)
		return 0;

