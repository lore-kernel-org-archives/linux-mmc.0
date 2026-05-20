Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71717A2FC;
	Wed, 20 May 2026 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257919; cv=fail; b=VZW1XLp5vGCthPZrKse4N/mJLz15KIdIYaxDdJCA9apG2cKHJ7ubWu2Wzi8pzhzWOhzS5Z6OUkrPf/O7VAuD2NqAp2J+bN6Bj2Uu6QK8+gDkQB6RFhv0HnwnjiiVD3nvksf/v7ZUR1ZD88r3GRyqt6fcWkqBdgNyI/1ImW4GHPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257919; c=relaxed/simple;
	bh=RmB5q0Ik59S5mzw2N0T1awLv50EuGuN5kFs5eekpCLQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1yxGeDxiRf9KPOMnBVn7gmWbt0J+w+Qqcvrl7T9gEgbqj8epGDQZtXnn7FwYcOOYiSGLABhpAzVMEDbQGp8cS406VuTs6AS2Rq/t88ZxMvp4O8Joer9AQ3MN2jgs3XtUVBU9E1s5t7RDoYnkP9Rj+KKfjEYab5UrPBbbLa76zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPIMZGNp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPIMZGNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779257918; x=1810793918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RmB5q0Ik59S5mzw2N0T1awLv50EuGuN5kFs5eekpCLQ=;
  b=hPIMZGNp6ztu/SUZWryCENuMlrh0nHZ4JA77Ic4EHejgZGm8iCiqAgjS
   6/f6RkjDvgFpMkAm2FG7r3dfd9MoIWZd5qD9Lxpux1dZK9R5eJCk+r0GR
   QOkCVV/Xphf/bSVK8WrAGYXGF2J8Z4sXsdDh4hlbOh8tbeyUMTg1bwXEl
   dob/+v5pPiM6IYb8mSBmegSKkP7TYi2v/OoVSOMGucR3/JFku2g1h5GcT
   ddU2Dr5zmp+IOz+qzHnK5LvSu6vuCa06+kORf4C3DjHhA5zjyZL6AWhty
   IHM5jB0pkDAfHcVRYO/BWteQ+O75MSSS330AARTdTqbjJkiDHPfWWDNRe
   A==;
X-CSE-ConnectionGUID: 6nwADLitRK2znLOj0PFUZA==
X-CSE-MsgGUID: yrc5mm/WQj6voTrUnuq+og==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79171247"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79171247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 23:18:37 -0700
X-CSE-ConnectionGUID: gT7D+5KATIWv1oGLKIgTeg==
X-CSE-MsgGUID: KwWdUhmnTm6gm2pBzCexmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263821776"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 23:18:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 23:18:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 23:18:36 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 23:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8dNiqkzmMtyqCY8BI9ik+E7ZK/1YmgP3qaWHiMkM/GoLoTJXLiKLSgQQC/WU8EKXZsT3HCVRmiVGEIPxDjrqlztt9kJJ+ZLk9O9JkI4dFK+w/kEGARs0c8zniSV6wW4XPFb5m1cM1Iqrk0C8GitTHVpzaI1l4dzd1oDeW5uHoCPhwe9gams7vZHJ4MEz50zdWLBb7QPbOYfuQHNuOzJK775sgCLoYmfCvtoLV0zLnMsD/dhC3o00jNlxvF4tv1XPjvfB5Pp1bcPBppA2MWqs3OTXjExM0NNJUhQzCKwPEf548ol5//5oxa32NyrTBO0hmJl65pc2bHw6EHCfeo1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ur2SgQ4d0OcHDwecAyK1FTbv0ciOFP2IVwtgKkAGDk=;
 b=S4wc/L1HcoKpHJXNKewJTcNVry9aK5YeY60CiY1f3hD5B9kD0l+nQqny9IfDlaxJHcbklm3fbas+mM6+EZh1QWXSD4N58xnnWjBn8z1vsbRS8/LIBweXKc7vSylRpIUrZ8Gt9niaIa59qpBj3tFFZnvaeVtDe/gOkkW+fCfUttGzcPAkxtRLu6H81DizpIl26i7yzsYNHRRviajUZTec+lVO1z5qt8zXc06VD3RPsy+RqX+56Z8kE9fh3dGSjFjBxsd66lnDvX7Vs2eTnUiD8/+H0PCwyThrANyfkkTg8VSu85Cj9LXmleWDDd8d9Zt/jz/2uJUxe1ZRoibx6CaHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:18:32 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 06:18:32 +0000
Message-ID: <ce639149-0089-45dc-9c6e-5e6ab4afbf9f@intel.com>
Date: Wed, 20 May 2026 09:18:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-of-dwcmshc: remove redundant IS_ERR()
 check
To: Artem Shimko <a.shimko.dev@gmail.com>, <andriy.shevchenko@intel.com>,
	<ulfh@kernel.org>, <p.zabel@pengutronix.de>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
 <20260518110034.142587-3-a.shimko.dev@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260518110034.142587-3-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::15) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd0710d-0ca7-478c-0f20-08deb6379dd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: RcVeK+++/SeKF3bmYA92JTFPVBfhAu+LjXjjAMdXZkOSegULWSPctbs0W7E/8rXhR7muUbRK81pYZAi/iAnFEPzDrJOrghKpwQb+K007ce6VgVQJJfUu9iJiRppAKVPaOgWNuyUckC/g0r8MstGhWfS1yCyZtyjAJaUd/h4T9prftCh5P9Jhd2N2TTpTIGWWDmu0PDnYy8RfybotABJaNtk0GCVfU3NEUYQKfP+9PtfRGXVIOGJvUXGsC2gATck6j6Jutuw/3dNfHyFNqUR/V8jdJOuDMVWE0VoanHH8p++Xep/OSFfks848QC0RYrKkse/CR1LcGyPKBl3dUog6cWRcMqm7d9Di7XAA+RnizMq00UvqKGueV/iPbpadpB0amCpiJ5oIXp75fjVj/U8wqHZfk84rRFNN5NdJ9IF5uuKVwNhB3ROmaL5/1G0mvk2DXOVLIfmsoYIPGPdn5jGIeyfcCtJHlaQdUyB74a1shiN/3LFCIkWIapVCbpGlh+HdB4fNO57EElLRvFzT1e6BNJWb0+YITeIcRQ9yEHtsJsLm8AYBFnQMeixsmlg4D0B9ZzVaVhGomSNiclrdcTHufF5SsCampOd7LlauDvxgK/WSkI6b/SqoV9zEkJZkGY9zjiZGZKnt5/tCR7I0NCCDt+/mDVYhAn60ZuBGBwg9BZT1PhOjgmIS3zRvcB//iXtv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnlxdDlpZEt0NDNyQ3JUM1J0UDlCUEs0NGpuN09lVG5HanhvaXh1M2N4S1Fz?=
 =?utf-8?B?SUlkUGFqRTlSN1hXNHF4RWhNbTUzVjNiWmh5VWZuLzJTaWxTenNaVHh5R3Y0?=
 =?utf-8?B?cUpWMS9xYXY1cUJRdm5LWkxqOEVWaXkxbzdjQ0VlTy8wa3c1OGFWdkhKTlEx?=
 =?utf-8?B?cEJxTVY4U09vTlJWYUVlTnA1L3J5QkFvbG1zWUlWOEY0c2p6MmFtUjNrMkds?=
 =?utf-8?B?MzJUV3VFUHppdHlRc3RzbzNSbnpOTXpheGVZUWwvcDFqdFpGUlhjNGZaa2ZU?=
 =?utf-8?B?NERqNXBsQTdxYkNDV3hzSTZ5YXFoVnYrZzFsMEZha29tdGpEVFVabkd6SGdR?=
 =?utf-8?B?TksxeXhkM2JJVndjTmVQaE9Vb0doZDZ0bllsTTJlc0drUXh2aFhqUGx2QzR2?=
 =?utf-8?B?Ym9hSmtaa1JqbGNKNlE4Z3duOU5rbzJNcjlmU001VFZodnVxRnl5SnBtNVgr?=
 =?utf-8?B?WWVZYk9TSTdGSkpGYnQ4ZU9tYmJrdlRmMFc2OTBIRWpSOFAzRTNJZ2VTUTJa?=
 =?utf-8?B?QmpTNlNIMnF3V3IrRWowQXl6L1lyV2pXNEZ2UFBIWUVnR2FPUWFDMXZwQVJt?=
 =?utf-8?B?V0JjRUFvZnFoWG5TbmJjVmZBaGMxdFlldEVvSkVJVndtRWJ3TXdiNGYzY3Zx?=
 =?utf-8?B?azR3UVNUdTg2YUhWMlZXTE5jMGpJK0h6WDNVeXJwekxLZ1g2NTFsSkNWcDg5?=
 =?utf-8?B?amxYNlJHL2twc3NLQm84Zi9iUVErcTdOc2sxQ0V5ZkRDK2xPTWtJc0pzb1N3?=
 =?utf-8?B?dE1oWUZHSm9ISGZDb2tKSGc3UHlUUy83Y3EyYnZ0YkZ1Q3ZYQUpOSXVYaHJh?=
 =?utf-8?B?ekRzcG5JRmRsTDdhZlB3cHJHRmp2KzF2YkpzaWFGVEF4U0daVythaGxaYjln?=
 =?utf-8?B?YTRnQ1d1UkMrQTRpTFV1Zlp2bG1EakFlVXpJbGZsSWo0UkxGZThwdVJjY2JY?=
 =?utf-8?B?a29zbHhLRnlNNDNSTUM1N3BtekRQV1JNUTIxdmMxcktXZnEwWkFYakVhY2xC?=
 =?utf-8?B?U1d0WVFsV1pxb0t0NTFTaDVGUmg2RjNuV21tZ2lZTENCRjRJRFFUdlFDRXpj?=
 =?utf-8?B?MDg0STVTMVhqZzd0SjlwaG56b3ZkVFRwOFl1aGlGTGhvU3lRdS9DZUVCVUg4?=
 =?utf-8?B?RTh6OHVoTXE1NW5JNEJNbld2YmNFdXZ5OG9EUGpseXlYcVh3R0FpakI3MDhF?=
 =?utf-8?B?aHZEQTlsVmZlM2pWa2JJNWFDVGFwTDA0aSttR1dlMTl2cUtPTld3Ujc5cEM4?=
 =?utf-8?B?WVcwNm1Ja0RVUkZCZkdDbTFBNlM4VEllY1dxdkJUdHhUc3d6REtZcit1UEV1?=
 =?utf-8?B?NjlsMWpuZ3ovVUJiVSt1dTBqOTc1ZTJVQWlqbnZTN0lZWnZ6Yi92Zi95c2sz?=
 =?utf-8?B?REVrN3FJcGpCUjRsNWFlbkMvRk1EWm1KVFl2RVo0bEFUeWNpbmZnVmk4VmMr?=
 =?utf-8?B?L21HZUt3d1pwRkNQU2I5MEd1MmtObHdDSFB0eExZcTVwZmF0TVhWY3VVWFBa?=
 =?utf-8?B?YkltOTRkMTJZMUw5dUw4d0tYSE9wMW5CUjBPTERJdW1VUmdZS0xRc2FyNG03?=
 =?utf-8?B?ZzRORnRBaXZ2YWNPb2I5ckNuMWVTT25vRjFacXg3dUphRjJQdUFZUE9iQXl1?=
 =?utf-8?B?anNEWUNuOGRVU0dXTFhZcWV1SldRSjB2MFZUNUgzaStsQ3hYWXJqbjFFKzcz?=
 =?utf-8?B?NFNPTG12NFVrQ0plVURRck5SbjZ4TWFkNDIwMExsNmo3YVNaZlQ1S3lodTUr?=
 =?utf-8?B?aVN6QVAweWlyNzNCNGNkZmp4TVBCQU5Zbms5TVpjN0E2RXZmTTRkOHR2ZVRK?=
 =?utf-8?B?VTRXRnViOUtUS01USlFmTnlpSDlpOEdQZ3VwbWFnWkh2eVZKMkF5eUN0bnlN?=
 =?utf-8?B?UTllc2Rpb0tyU1prOEZsWm9XbmN6V2xYTTVBdndFQmN5ZUh3Uy9KdFpPV0tJ?=
 =?utf-8?B?eTVVVU1DZk14Yll6V0RCdHlXeS8yMStyeDdhLzJUV1ZGU2xuUkx4emVyZnQy?=
 =?utf-8?B?ZWlXYitaZEt5akNmTWFBV1c0S3JWK2gzNnhtWnA4aEVEVVdBSWRWMlJGdWgz?=
 =?utf-8?B?dU9PY1N1Wk0waFFRNHNTb3orTkd2ODJHQVNFM1NXa0ZPTVVZL2dBbXp3R1RV?=
 =?utf-8?B?QnJKQmlFd1dabDBWQXFVenlmMlRVVG5uNUo4OVpXdldtUlVhUWRPbFFxcXZu?=
 =?utf-8?B?VUZjMFZianYvZHc5R1p0b2FiN0lSS3pEWmdlNTE3WVp3OWJRcDlPSW5HdmZs?=
 =?utf-8?B?RFBGYnVYNVlLdFRoMTAvQ2oxMFl1U3FxZVBwenRld213UkNQTmN1OE1HaE9z?=
 =?utf-8?B?bVY5bXRWaTNwNStFd0ZpVHNLRm5GMWRaYlVwNlM5dFFxSGMrK1UzemdqZS8z?=
 =?utf-8?Q?naIk1VX4MZ3uW6CA=3D?=
X-Exchange-RoutingPolicyChecked: a9/dRGOFODH9KY9LSRf1FO3WUVAqySaO2nw8hFeJ4nwfAI41BuiHn4NUjl7I+kDvu4RpD+as07MHEtvRqGoxnDpvoodopDTOqETHDKeewEfz/g9A9Alb4UqyKY7yUZIp6VPhE3aiF/OsGArHhaO38c7O9xwKuv1xObLByQjSiR4U23zqp1UUvKUyJkKBhttMCRQNWCPm3WNrt9EvAZwZefnoXFpdiXrn5ZPbhdSIxRjhT2DQhFYvL15pb4qUDDUEcta3QwB9MORD6RZ060RpuPfC5NfAUJS0Tq63H7I60E8IoXYAXmAljTb8EsR5t1b81/ok6YHG/KhhPYXbtIlS+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd0710d-0ca7-478c-0f20-08deb6379dd0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:18:32.2611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9phTkSIj5af1pHonGHivjMrtPkXEAH816E6//pS7D5C5AG7NZDncMmWUhzYWjYhwZW6AZMCagib7IfLIFNY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

On 18/05/2026 14:00, Artem Shimko wrote:
> The clk_disable_unprepare() function has internal protection against
> ERR_PTR and NULL pointers (IS_ERR_OR_NULL). Remove the redundant
> IS_ERR() check for bus_clk in dwcmshc_suspend() and in the error
> path of dwcmshc_resume() to simplify the code.
> 
> Note that the clk_prepare_enable() call in dwcmshc_resume() must retain
> its IS_ERR() check because clk_prepare() only handles NULL pointers,
> not ERR_PTR.
> 
> No functional change intended.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 8c3ca47c8060..29bb46783ee5 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -2564,8 +2564,7 @@ static int dwcmshc_suspend(struct device *dev)
>  		return ret;
>  
>  	clk_disable_unprepare(pltfm_host->clk);
> -	if (!IS_ERR(priv->bus_clk))
> -		clk_disable_unprepare(priv->bus_clk);
> +	clk_disable_unprepare(priv->bus_clk);
>  
>  	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  
> @@ -2608,8 +2607,7 @@ static int dwcmshc_resume(struct device *dev)
>  disable_other_clks:
>  	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
>  disable_bus_clk:
> -	if (!IS_ERR(priv->bus_clk))
> -		clk_disable_unprepare(priv->bus_clk);
> +	clk_disable_unprepare(priv->bus_clk);
>  disable_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	return ret;

