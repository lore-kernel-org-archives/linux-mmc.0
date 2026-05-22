Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C074422424C;
	Fri, 22 May 2026 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430692; cv=fail; b=J5nij3GS/TP/WgumY7I2GbhkRP1DH6F0j62zrGeriKC3JPj5SMA7KQbXK6VZod28Od7eXGvcOFPG7yyRZcB8FvmYbSuB/Cae8LBS5N2+0nQPVx/g/qDNFW0tySww/pjILh5PC7Asl8K3wiUAXD+5svdPbyWXSjNCvCeaJEGY1TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430692; c=relaxed/simple;
	bh=VZQKS/5kq2ETzgECYfRJQp5GZXV/Z4c3+ISQtCl3IXw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I95CpqzdlVnwSs949zyOBC8sKd9MMrXri0aJX/gXDPYbzrsuapt6nxU0IeElvVXp+HVQYG3VdjbDJOr01pkl4ZzQm5PlJ1l7yOs7/OycD1bza6la41+GjwbBgVsmMmHqDXfy5PYiKknCMzhcz6NgIlWedhfyohnEZRG4uNXyEGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n99nHAqt; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n99nHAqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779430690; x=1810966690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VZQKS/5kq2ETzgECYfRJQp5GZXV/Z4c3+ISQtCl3IXw=;
  b=n99nHAqtEh8/a/6+X3UMhASpIT2qxT5FoGlF9D9jyRIrMSsIpKC0tSei
   7oQgl00PGjez8Gw/a7v9cOHzu+9t29Keb7gpJq5HYegRwyHjxsNJmRWFo
   swu4t5uja49ZqJ8ir4AmW93pNBqbtO2sgtRO27W2rHZua6ieyd4QV+TSx
   ooJ1awMikblINzN1ciSqobIDkuCdAFWQ24Ed3TExbJZeJ9eq1YwcyHtaQ
   lnPKQ5DzBSmOFHwHyavGlcjuxZdwj2orrzWrMretnr3FhgZvQlT3ATvgs
   cYUEcTXMvrmDNX44GQ/dhUjfPGJjyjMz4JHxC1uA2xYDvC8HAK+2T0c1N
   A==;
X-CSE-ConnectionGUID: niyCtvE6T4mWB+d+QS4DsA==
X-CSE-MsgGUID: EAxb4rFdTt2dfiRajPnfNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80327242"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80327242"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:18:10 -0700
X-CSE-ConnectionGUID: 9SNeCG/JT32de6AeZLXIEg==
X-CSE-MsgGUID: j35sOd3PRl+BZ/ky3z7QIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="278936966"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:18:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:18:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 23:18:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.40) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcxvpSMq3CRl1efuT5c14YFYXw4YPiJCkt58pDfx/9v/we4AHMIYjz0l+kBvHiRN/d99sXXW4PMQRNnIyNcYbzHiiHIdUia9lacCbWT1z0O19d8lkaGrSAHoz/jhDS4ORmkUPYNyqBNk/sE1uDpT4Haek9TGBs38P1nbXUvyUhU7SxgoKzethsuCpXX03bf2Ri1t+39zYNV++ScPok72k56ZPqwZMxprlfFkqGj98vousmllew9Zt54p9I1qv9Cml916p++yQWXoZ0/Wla1t35jT6VD1cZ2rp5VhDgTWLv5JgBDBg/mktqVQqMGnkZAjWvDCVkhKcs4ysLfYIHxhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8nK/Ym3n6wvnC8chxU36z1XPY9afc5Zxe132/Uv/ro=;
 b=TgetYXrPsIU3PiksbWRKJp1MCtmJR4zsTq1UfTQ3DxMbGQCWMlNxwWGlzmCDvhCQPU39uGN7DCqA1p50Oh+VDpuCJ+YMkKp8No5KbJm0P8WknKN+RRrfSS38478Auxocfi1StlBFP8A4aLFCh5lgDKmscvuEQH2MVyFXj6GFcXzGgE0xXV8Tg4EmMdgVZFPF5ntH/Ff5IbCZyr7LfOhStEoiiB2vDHGvHFLAffog7sewiNs4AwI6hlcf/Yd0/AxYyu/sp3pRvPsHFU94eN8cGPAUt0I9lUwgg/ummVG2zHOlT6HPG2pZGSXsDtGaNSAqzQ/eKTS3bJ/GeZqOSGGBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by DS3PR11MB9820.namprd11.prod.outlook.com (2603:10b6:8:366::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:18:01 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 06:18:01 +0000
Message-ID: <98721452-4cfa-41e7-b8c8-ec75a376e3e9@intel.com>
Date: Fri, 22 May 2026 09:17:38 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: sdhci-of-dwcmshc: use dev_err_probe() to
 simplify error paths
To: Artem Shimko <a.shimko.dev@gmail.com>, <andriy.shevchenko@intel.com>,
	<ulfh@kernel.org>, <p.zabel@pengutronix.de>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260521083506.356422-1-a.shimko.dev@gmail.com>
 <20260521083506.356422-4-a.shimko.dev@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260521083506.356422-4-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|DS3PR11MB9820:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b4166f-d4d3-4c7c-fe34-08deb7c9d757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4143699003|11063799006|22082099003|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: CkUjuxFnyKc06UcR0VxJ9lHeOfTkbmrcQavXLWv4AUIQMK5GuUOLl0Fe+zlzknj497bkboDSdTAP6+gK//ZfUXAus12AtksnYKjvoI0mjx6bBcA7ljmCIy4Z0oaT9LTTx9DLuAuKJ+o7yv7IuGT/IpWd8amLKgys3KRX+ywud0JljMn6X26nwjOfWbh6+eH5sS1Y3tI/uxnQv4c71pRHX3W5DNHfHKNT2nvGffYFddo/iO7wsFjim6gPq1y7okwwO7CI6NAdJEDIt/yx5jg3QyYhmdiNNh1lcveZHdNaQHkAUCVojaSlAGQMyJ3gQ36X9PqwriCGLRovL4B4w5S5PblmN+JeBT3/h9v8ITJH3u6y+psij6SVTscIm/WVSROwN3pMshUt3RqcNxFgEdFzY/ix+rPVRH5eIKSoz8E/sTd39LUh7MjH9eCVb6obHZGGBXydpZ72x1bpa3EdPxVEQswibMaqc498NYBkB1C7DlfuanS3EKJ71I8KybuNqXEhx1d7BR8zVMcU+THevcgO+qesCdd1Oozqv1bQSsCS++a6e1pLG62d4HVF9CqggrZ68U3DVVFdpNpN6C7mUW6ZKiLbc2mXk/n0xPMwGyuKBoXvFaZXBTdzojpJ8LIkVjNrJujfJd9FX8LyY0JWUI35K/t76KU+/nKxQxikH7Cb9IVuus8YkWnBSr1kcj1hS7vT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4143699003)(11063799006)(22082099003)(56012099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkVVcHYyVDhGTHdMQ2FPWEs3czEybldDWVQrNWQ2ekFLRzY1ZWpMOW9la2k5?=
 =?utf-8?B?cEdMd2xmY1owZHlnQ2ZPRDV1RjJ4aHR1Rk42ZXpHTy9FcWREL3IxVUswUU1h?=
 =?utf-8?B?ZHEyRDIyaWRhamUrcENpWS8zMXI1UzE4TXdTQ1g1bXJDcDVHbnpUdHRqcnN0?=
 =?utf-8?B?MSt0RHo5WmMyc2hSQkY0cGhSMzNxK29Wd2VaMXViRmFXSnBtd0ZUN1lMWDU5?=
 =?utf-8?B?Y2VlNFJjcEVwZWduZ01FQ1RCQm9BdEZXMG5wVTFlY095dGtQUzdsYlZQeUJZ?=
 =?utf-8?B?dGFLOE54OEsvQzYyYTlMekVDaHd3WDB3QTlvTWsyS3N3WndFZHNDa015dGlE?=
 =?utf-8?B?VVVSa3FxZzFhT1Y4M0RIVFdON3UzN2xCNDdxSnpqNG9aemJpR3AxT24yYzcx?=
 =?utf-8?B?NWgyRlZma1BKQ3RsYU10cTFTeGpJZk53UGNTRURUWWoxQm95RkpZNjhsVTdX?=
 =?utf-8?B?d3lIeGJJU3pkSlA5RjJJK1ZpNWR6MDRhYjBucVJ2Q0ZQNzlpVVRxczlUMklh?=
 =?utf-8?B?ZDVNTWtQY1RCMVRTT1JxMUkraXQrWGdBVDFiMTNhMlFPVTBVMFdKd1JZblRk?=
 =?utf-8?B?cDVOYVRjeXFSWWR2bHF5cy96OGsyVW51bGJrdzNZdENzWDAyaXlsOHVmU0ZG?=
 =?utf-8?B?VTBSdlE1amRIWXZQUTJlNExiZ0FLTklnWDgyWXIzK28rNWhQSUhJRHlPMWUz?=
 =?utf-8?B?ZFRDdUNaejdOdnNUdE1TZ28yeVp5VU1uZ3BGNC9ZRkxxS0JsbmxrRlIvNHF4?=
 =?utf-8?B?eHVQVXlWc3Q4bUg4TlZlUmRMcFhucFdhZWZUNG1OaEdxS2g1MHFHeCswRXZo?=
 =?utf-8?B?WTNWMTJEMkk2d1Z2a0dGaHJGcFRxOWNVckFjTFJENC84OHZZZmlvS243VmIr?=
 =?utf-8?B?YjhraENac1JJbkc5ZGQ1a3BHRWp1ZHpsdUkvTVBseUJFbGtDODJSR0g5SHMx?=
 =?utf-8?B?YUc3WVBaK2pqd0NXUUhiWjhaVk1MUlZrOHc5eEtOWXpEKzJNZXpZUVlNdFl0?=
 =?utf-8?B?dVV3MythRmZoQmxVbmJZWVNKaUJJMnV1T2U2WGFNeGhBcVlBQkovRzRzTHpT?=
 =?utf-8?B?MGYvMXBvVkRSUGltVURSdHVGMndMcEtxS1dZanBNRDRFQXY2N2pZN0hUSm1v?=
 =?utf-8?B?VlFKdUVJdUw4dU93Zms4WnVmVU5NK0Fqck1Tb1o5S1Jna2JFalgvckRpaHdH?=
 =?utf-8?B?Q3hMQUtzTFI2OUZVYXF4a1MvVFVDbTdEWGcxTnhBLzROT09xbDZnakVvZU00?=
 =?utf-8?B?Q2orYklaZUtsRythV2FPUWQ0djUzUGROK0xJbTRTT2ZXd09YRlFJcWFwR0Vu?=
 =?utf-8?B?UllHNlBWQ05idjFtYTkrOTgwOXE0MUZzdC96RXZoMVNYWEZLZC9HWUZ0YmpW?=
 =?utf-8?B?eDZ5YzNGMktPTUpmTkhTaDdBekNPNkorN1lUZnZKYjdTWVRYWVNUK01wMDBL?=
 =?utf-8?B?YVZaNE0rOFpOYW5ZNDM1VmM2UEkrU0tQQ3YxOFNRd1JHd00xbEptUWFwRHdL?=
 =?utf-8?B?dkttSjF4SnRwczZMWVNqQkUvY3I3WUg0K05ZWnlmTGRCa21MZ3ZQR21iWVhx?=
 =?utf-8?B?SzlkNWZCd0d4eFRrWnBQa2hHSjZpcnNUbVY4UHFmcTJOdnBUVVMrazBLYkFO?=
 =?utf-8?B?SURPWUxTaEMwZUZNQytFVFFTbDJmLyt0QStVSTlGa0FjNTZBREpIWWlNcVQz?=
 =?utf-8?B?NkF0QnExME8raWZQaFZLZjNZcFo4ZWVTZ3R3NCtHcnZkRDl5WHpxeko3dlF4?=
 =?utf-8?B?OG5aWmpEMjRMbGxwY0NrTlVvbjZjaDZ3ZVU4N1o2cHRCb3ZMU0dJVXdkWjdZ?=
 =?utf-8?B?UUFyY2w3ZDcxL0s2aWRBMHZGSWllNk1PdzN4TFlRS3AvdEJWc1hZSzIwRktG?=
 =?utf-8?B?cUZSbUErR1dTTTdkTFQxaDlkRGdrSkhjWHBESlpmT2xuTHdqUi84QnYrUmZX?=
 =?utf-8?B?YWdNSEpzOXFidXF6NjFrQktqQ1BTZ09kektIVWNmRDhCMSs4MDNNR2hMZ0Er?=
 =?utf-8?B?MnRINjhWcXZ2aW4ybG4rTFYzdTJtNWRtN2d4N3o5Zk0xM1JmVlpMZmJVbmxS?=
 =?utf-8?B?NFFVS1VRTUtZbnVYMWdPVkcyWm9sdVJmNnZNQ0xtT3FkbHZkTThhekJiU3l2?=
 =?utf-8?B?VlFYVEdVUVcxMlZNZVlEQjVBekpnNUwyYVVyQS9XL0RyUStQRmNibVBvaVpY?=
 =?utf-8?B?Zk5qZHdRYU5STmFhUmFyTUhKUkVjMmZqZjBuMk50TU5CYTBXRW0xdm1FdEd5?=
 =?utf-8?B?UkdXZXJUQyt0OWpKdlZZQ3Z3c3dhN3FOM1UrQ0JZZWZsdHVyNTYrVHZWYktj?=
 =?utf-8?B?eU1RSkg2OVdQR25lRnQyc2lpL0JNRmd2MlI1QTRmbGdyREJuWC8vdkhLUTFh?=
 =?utf-8?Q?d54Oq97gkz5urprs=3D?=
X-Exchange-RoutingPolicyChecked: O/Jlz/EUbqUmHeVTFBRtQymuzMemoGf03pEP+05Q4M+kq4CPV22EnOW+JpwXvotYMNT9XXvdwDWNV4TeQXSUXvphVy5aeZ2NQLNc2BqDf8hvhcaoRe5IGncBmypXOE+ihRuXiCHoxPeYfD4C7xULnX3Z2ebD1PE4XF1TeS+TXFuvNuCSFekBTiKVKTooxdAbLqnwirUbkP0mhNdOz0oIbWV34k8vZ2wfZIeFhYm7Ou9eptMstwTFBvhrjX7K6MODoFZH5Ory0mvRFIKN/5oSLmt5H7nae52mBPSOCL1H/OFFAzp0KgAv8TMmzk8lYeNHXUn+jW/cIvrQ8mDeEv8dMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b4166f-d4d3-4c7c-fe34-08deb7c9d757
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 06:18:01.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/WAw/9HS2BNY1yP+rWCdYABR7MnQgu3nPugBQkJ2fYjd2qRCToemG35+XounY+c4o2dJJkgQos/8SHG9bH8Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9820
X-OriginatorOrg: intel.com

On 21/05/2026 11:35, Artem Shimko wrote:
> Replace common pattern of dev_err() + return with dev_err_probe() in
> probe functions and their callees. This macro provides standardized
> error message format with symbolic error names and adds deferred probe
> debugging information.
> 
> The conversion makes the code more compact and ensures consistent error
> logging across all initialization paths.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 30 +++++++++++------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 925fff1c0f3a..b16027f5dd8c 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -917,11 +917,9 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>  		return -ENOMEM;
>  
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
> -	if (IS_ERR(priv->reset)) {
> -		err = PTR_ERR(priv->reset);
> -		dev_err(mmc_dev(host->mmc), "failed to get reset control %d\n", err);
> -		return err;
> -	}
> +	if (IS_ERR(priv->reset))
> +		return dev_err_probe(mmc_dev(host->mmc), PTR_ERR(priv->reset),
> +				     "failed to get reset control\n");
>  
>  	err = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
>  					    ARRAY_SIZE(clk_ids), clk_ids);
> @@ -1781,10 +1779,8 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  	dwc_priv->priv = priv;
>  
>  	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
> -	if (ret) {
> -		dev_err(dev, "failed to reset\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to reset\n");
>  
>  	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
>  					    ARRAY_SIZE(clk_ids), clk_ids);
> @@ -1792,16 +1788,14 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
>  		return ret;
>  
>  	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
> -	if (ret) {
> -		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Fail to parse 'eswin,hsp-sp-csr' phandle\n");
>  
>  	hsp_regmap = syscon_node_to_regmap(args.np);
>  	if (IS_ERR(hsp_regmap)) {
> -		dev_err(dev, "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
>  		of_node_put(args.np);
> -		return PTR_ERR(hsp_regmap);
> +		return dev_err_probe(dev, PTR_ERR(hsp_regmap),
> +				     "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
>  	}
>  	hsp_int_status = args.args[0];
>  	hsp_pwr_ctrl = args.args[1];
> @@ -2408,10 +2402,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	u32 extra, caps;
>  
>  	pltfm_data = device_get_match_data(&pdev->dev);
> -	if (!pltfm_data) {
> -		dev_err(&pdev->dev, "Error: No device match data found\n");
> -		return -ENODEV;
> -	}
> +	if (!pltfm_data)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "No device match data found\n");
>  
>  	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
>  				sizeof(struct dwcmshc_priv));

