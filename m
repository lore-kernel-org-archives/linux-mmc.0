Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E64052AC;
	Thu, 24 Sep 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232124; cv=fail; b=UM+dypenqD3tjuaNHJkqyngkH46SweuhZ2+85I80/H8GOuaX/yfeF6HGtpq/WGx0hRQZA/GsQYlEhtsFduA4KzaS2Pl1t+SBcmIQzXR2R5wSkfS2bNmG+PI/6tIBwjSvksPrgO+1uU6PtoRI3yl5T18BhXrZeQq/M3AjhvFG7H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232124; c=relaxed/simple;
	bh=qT3bZjdzKgGl5+2M2aEapGIrIWpEEtayLO5gwhty7JY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OQ7M1LIsSft/hX9G+8Q5S4berbr/cTFrHNZaHuN6PtA6yzdqazipTke8YEj/R5LiHqsftOGc20mAzhTLU6XDbBjqowPqEz1xB8Qyyc9NlVKNsgCLOPT9dUcbbglXXAanTmacoPKonuvdIqS4m4M90Azh1p+Q9ivoIeVL96BPnT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZnAAKkR; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZnAAKkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232122; x=1821768122;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=qT3bZjdzKgGl5+2M2aEapGIrIWpEEtayLO5gwhty7JY=;
  b=HZnAAKkRTD+9QfspJ9K9qtstX59Mt85yw30G6dR/EL91SyL4NZsCSCOP
   5Je+2AznP1aHcuuuaqT4dkz8FNOxq0GwtnHy68FwkYzMPefEguWLBvCgE
   ov1uNl8D63BxAmb8uCuS7/3sNACOfqWzJ3J7WpgzKJ3VdG7VnqIofjowF
   aHqMs1qX+dmOkVhF7jWR2oZHvLl3vpu/RTXIKTwAaLKPuj0rOhbVnoWkB
   d/zMXEy1jx00ZXSjzYFaeP+kBeBMqMenhXcogP+P+/yuO4ZZnLZuWRIU9
   pXlAoMJ4nPGBjl0xCIX96sJtYoPp6iCZUIx/TVU1xoBiBv1S0fJxMb+IT
   g==;
X-CSE-ConnectionGUID: 2BeZZdUJS8qW8BsMnCBrew==
X-CSE-MsgGUID: ickgmnwlQF+C8f3M3emu3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="91097990"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91097990"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:42:01 -0700
X-CSE-ConnectionGUID: c5Aj6Y7BRDaxGuisY4YBWw==
X-CSE-MsgGUID: R39XnXiyTVSCaE4b3yw7xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273129037"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:42:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:42:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 23:42:00 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 23:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVxk94BPULarWdgsqdM2QFlJF9EFTzZKKeYC8GLMM1Mk1pVfWyi49PgQ8K/PO2H4Fn6Dj5SC4Gb0jkgpBQsDGqCztfA+bVESF0TH+IT8oWAQvaf6OI8ViiOzRkJF8HxzQ5RttmsbOkwJw0VDYA7GQwSnKBIYg5zL0xrsHnKJKLHsqLP/2NlgmcilipB5z224V2fnMIFNdiiDieZ5iDXnWzaZOiE//qEZE+hVNBCoPjO9DPIJBM4B6ImD/OzpAtcysgQzuRlHqhMme2pBfhG+ET5eSfyZEuFIzix8g9Xmrs8w0nJeWckDSAMA65J6tQfUv66gBnTkBE65jBPuJU9Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YatJZb7VYT7+92odLfryZVAEDe7Ojp4UA85lgyD9A/8=;
 b=cFh6yeU0MsWyUP8x2V+YzE9MxIiPHfKsYlP/NSGy1GwR08NLvjp16+SjzKP8q2/YLXmSpBv3bGhXJ692coNgHvk/8LQeRnuvMs0hTE6Cdlrw6w3av9Sw9af7K+8DlWMU6Tptlgbq9v4d4hrvZcv/3WSBKXbZRj8Vrvlkdu38jO8vIEYVfKMd/gH45uUH2ONsX2oGm40v7tCTZSreMdoQJJIyVEoJQnAH7QFHQSm0BT653F4Kl274IskTHS79MAMoX1eIe6ImpVXFJlA9mAPXwfWG9AWuI+BLeAN1ZurOJ91Y4sNInUsYDAcOKHYtoncE7JMFTPUmbuaREAOi+W6QeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 06:41:14 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 06:41:14 +0000
Message-ID: <d6066aa0-417c-49f0-82b5-745bd798706b@intel.com>
Date: Thu, 24 Sep 2026 09:41:10 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mmc: sdhci-cadence6: add PHY settle delay after
 tuning DLL re-lock
To: <tze.yee.ng@altera.com>, Ulf Hansson <ulfh@kernel.org>, Tanmay Kathpalia
	<tanmay.kathpalia@altera.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>
References: <cover.1790074790.git.tze.yee.ng@altera.com>
 <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <a0edc86ec30949ca7b923f4939a911960e8b5395.1790074790.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::9) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e637b6a-8992-4986-6c7b-08df1a06d419
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|11063799006|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: wRzvliB6hpYCLB0Ya39SuNB0aS3BqYOg8nCfcT5THG3gtU+48Jc8wshPkJsNlnEXXsg5mI6C4gCRUQw207MKjSowQAPKp0tjZ12LRN4OHF4+6uaGw3TfOKjS0TiAFEKSoMstZUYVf53qJ6WmzjM+raAS1++CYo5Lgci2rDcZGk6/oAa57IZRLhW7haDOr8orYtWZKy0EjSM/kFGDBbVcp3hNwij8J6G8m5oWoFlV9IJ/Cr1DWn18VuZe6J5C3Xy3Sw8ruV4nXIlUtkyJGMILuHcm8sXbXC68+sV1elus6RvvkziIIU0am0kogl29AKKBO+gu2HZ/KqHAxjBkl7Y/KDgj0DoyTCEQ1EweMnVxeDU/SHcJV7xXhddzKdSugyQLqQ0mvjOfGShI1vVOLF9PxIy5i56GeCcUjgtlu6Iu4kXQcWb+75e+f2l1u8iP49g7LCbamUR48FUBPNqJQLgzg++EuG9hypfFxT7ZUSZ4a7wWWrJz2LvEMDWghwIplflWBKdIHWeAz9aJCezn/+DmIVuAh3i50CB8Iy4UIo7vdlzXxgCix1TtqW7WrE6yrQNOvxxdwghwdngFR6k9VwoA6PFKcp1WCGZOBtkwLicqGKUBwk9N7pwfs3uL13NXBoYUuA10Ecd+bLM0+Cwfsms50mweIxRMIJf8d0N1jwh3bFc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Umg5MldVcG95bFhyK3JWUmxkSHYxODRmS1dCTGhlb0tKUHdsNEt3T2M0MG1p?=
 =?utf-8?B?a3M2WTNtSVJFazB1d05nWURjc1B2MTNwbkN3WUw3bDZhWmpSbGpFWU5RaUtL?=
 =?utf-8?B?ZnJ6dUl4RmtycEVkS2c4QUNSNTc4ZEFVS3NUeG82TlJSdWhvb3JHanV0eE9Y?=
 =?utf-8?B?RFM3d3ZpMlIyQXFuR2ljN0s1QTMvY29lTzlZcDVSaGhjeXRWSzlxTXI1Sksx?=
 =?utf-8?B?RlY0NkJUTTdhSVRRdis4R1VYaCtVcy9tSkxrRlUyZ2lDbzZkTWNydElTdENL?=
 =?utf-8?B?clVkM1RlWlhOdGVVazZiZXJZNktLNUFLUy9kV3VRTE4vUWRjMHRzY0hJYjhV?=
 =?utf-8?B?cFFEamhiTjVGbUduT0gyYnZVUXdsSU9qUnhDR3hRTlE3U3pIeDFicjRmbVdx?=
 =?utf-8?B?aE4rWnNQRjRPdGNjZk55eVpCWUdVcElnaG9KMmlhZFpxS2k3YVRIVVB1SThY?=
 =?utf-8?B?dTl0SWczb28vNTVwa2I3Y2pGRE9seFFtS3h0OFpVdGRJc3h4bjdGNmZYTEtQ?=
 =?utf-8?B?VDB2SHBITzI2Nmx3aUhHeTNGRjNYeHkwTW1DeDAwT0xuM3dqaEJXVVEzeThl?=
 =?utf-8?B?SGdtUk5Fc0VLeGdIM2tjOElaOGtPd0gzTnRUcE1iYmowR1BvU1FGOXJjbjJz?=
 =?utf-8?B?Qys5aUtwQjJJOU9xcU92NXhmc0dsc1I4Ti9YZm5HLzBKU2N0ZlFlRjMzamhv?=
 =?utf-8?B?U3VpV254MDNIT0MxSzhXK3ZXYUMxQVdNZGUvaHYzUXB6d2I1OEgzZFZnM1B3?=
 =?utf-8?B?R3A2SFFmbGp2UERDREt2S1lZb3BzN2xjSU8zTGh3eC9FUjV5SnhYb0dmNmFs?=
 =?utf-8?B?Sk1UZE43Z1dHK1VWdXBHMFJWckI5WmYwdU5Rc2gxS1FmdXluZnhOcU1aTmFT?=
 =?utf-8?B?SG84QlR4K0dzd0RLSE04ZjhvNEJhK0orQWpicHNLbGpmdGhGSlRGSDNKdmtR?=
 =?utf-8?B?MlNPclZqMCtMS1VjMHJnNWtpbm9NUGJVR2pJLzFYaStQQXY3R0dHekhlRXFE?=
 =?utf-8?B?Y25BV3JuM2s3eDFEVVg2NjRQRmtXSWlXS3dzOHhMK2xYdDU0aERnV0NSVXhn?=
 =?utf-8?B?YkpNcTVpTVdSOEVQWkRKdGtSOVN3blgySGJsdjdQSkc5Rkg3VFJ3RlBRRTM1?=
 =?utf-8?B?UkpLclExS1ZwaVgwZVdoVjQ1QU9nNjUwYThCK0hZYTRJTnhMY0J3a2dwbWwy?=
 =?utf-8?B?aVZHTWw3ZkF5cWNKcS9uOVFkOWEwMjAxV2VnNzFlWTBlK0Zlc2IzRU9qYU03?=
 =?utf-8?B?dlprMkJWTXJsdjlQejJrQk5vV3cvTkQvbUFWT092SXFrMGpCb09OaFRlM0xm?=
 =?utf-8?B?SGtoc2p5cTJTRkpEWjhtQy9FaDd6VnVzR3pvMmo1NmQrS0lLYTZwMUgwUG1u?=
 =?utf-8?B?Q1d6b0RiZzhRWTJ2SmpVK0JjK09KSi9XdFBMeDVNb1BKdEFhNnNMRnBQS0Np?=
 =?utf-8?B?bXpoVTU4T3RndTdCVEwyNDNScWpjV1cwcm84S2ZVKzJjMjZyOTRid1pSSEY4?=
 =?utf-8?B?TlM2MUpRU0xxMExmSmJ1U1BYT2hMU3lvZkpGMlQrVlJPZDdMaG9MWE9LZGgz?=
 =?utf-8?B?WG9vRmVKaHl0N05vZ200YlZoUlhBaU51VVBhZmo0UVlhYnZZc3RyOVd1V1JO?=
 =?utf-8?B?dG1zUmhJVzhIamFtTlByRk1yUjJEaCtHVFNBcjFudzhrcm9ZWUNmMDdIYUZx?=
 =?utf-8?B?a3dwRndnc3ZNc3hNVVpSSmRueE1FM3ViQzVoRU5UYnhVTTNIellia0tzQlQ2?=
 =?utf-8?B?UXdiMTY1S2xPSS9ETERmZUJoTklCWHVyNUxZOHlPU21HeUJYTlVzQWRuNm4r?=
 =?utf-8?B?WEUvT0dMZm5uaHlpeTEycG12Zkx2MVRwWktlQ2U1ZFF3UTJkNGxaN0lSOUs4?=
 =?utf-8?B?aERyY3p3TUZ2NXRlaWdNWWt2QjhVYkM3S2RzajI4M2xtOFpjZ0ZzUHhrOWxp?=
 =?utf-8?B?VnZoTTlCSDJWUHN6dXNDWlJqcGI5eGQvWGxsTnZ6N2l2bUNuZ2pkOVM2YkN1?=
 =?utf-8?B?djNyVjA1K0FMSGZnSGtzcHFrWmhPTmQrUEZFVGtwYVkreEUrQitvRkV6MkFE?=
 =?utf-8?B?Tko3dmlieksvOVF2azl5cXJ4MG9Tcm1xRHplY0J0bkR3cnU3akNwOEpjYU1y?=
 =?utf-8?B?V05KOGxGR2dEVE13MURhbDhPKzRQT1UvR1V5dFF0ZnFSZkkzMWRxZjlwS0x6?=
 =?utf-8?B?ckJnaVU1QUFhT3JKTHBsMlgza0EyZ1c1MUJnWnJWc01CM0FFVUlON0tHZWtm?=
 =?utf-8?B?b0c1dzZEMTBodEU0TDd5Kzh2bW5iaHpHT0tTaTVYOGxiZEU4ZENML2tJU2Zw?=
 =?utf-8?B?Lys3aXNVU1Q1WkxSRmFPRlpQMWpvQTRnNDVOaUJoVnRvbTNWenVOcCtndUND?=
 =?utf-8?Q?wU2dWHimcn0z/C/8=3D?=
X-Exchange-RoutingPolicyChecked: jpfBKlkdo98rHPZq/J7JJRdgf7Y1pAA8KJZKcp4bGk4sXCpG3bR4KhsoY3UmdaHLRCm8YwU9H804mCbOisLjKExyFQh9wuvy9sngWvUdbOj2Q2NAuT4ybelaFacB9ODlMLfrAoy5RbUH/dkCNyeZMkNqF6Q82v5HbNBAcvN9jvyS99r4cK0QEeb8iqGLZ3OSJGAZ2xXF51mIFnH/8I9+KqAN6tngu3MJRLOotCcVNPmbRc6mRhKWOBb91VYK0ZPr6VLuPCOmr5U60P33DpQQ8xDWRyNYAfX79l9/FGxzViSipGlfll+UlWp9eWxjesKG1GFGu/9RZkQOuWP0zfG0KA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e637b6a-8992-4986-6c7b-08df1a06d419
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 06:41:14.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8LYyXinX1Cg9B0o5MLJ/Ft44Mzmgx5CU86DNU5aHRBAzCUtmB/tX00EmYwuhr0djSiPrUTSmldsbXXdfUfGgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com

On 22/09/2026 14:12, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> After re-locking the DLL, allow the same 5 to 5.5 ms for the clock and
> PHY signals to stabilize as sdhci_cdns6_phy_init() does. Without this
> settle time the command issued immediately after tuning (e.g. the R1b
> CMD6 that switches eMMC from HS200 down to HS during HS400 selection)
> can time out.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>

Presume you realize the delay is inside the tuning loop, so 40x 5ms
is 200ms total.

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence-phy-v6.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 22d56bb46d75..35f35ef9c710 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -811,6 +811,9 @@ int sdhci_cdns6_set_tune_val(struct sdhci_host *host, unsigned int val)
>  	if (ret)
>  		dev_warn(mmc_dev(host->mmc), "%s: DLL reset release failed: %d\n", __func__, ret);
>  
> +	/* Allow 5 to 5.5 ms for clock and PHY signals to stabilize after configuration */
> +	usleep_range(5000, 5500);
> +
>  	return ret;
>  }
>  

