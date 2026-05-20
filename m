Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90C17A2FC;
	Wed, 20 May 2026 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257908; cv=fail; b=SR/FmbXPIt5/YU+yi1EZwF8tWGuDNALjCDrpg2eQR/BrHOnBp+hx2FoICMj8odcb4k2rC1HPmKlYvVcYd3VaeVgcF02Cq1+pJPu/+/LoeU6wxvUiJogRjxpwfTpwWMaUXvScIE83jffyb1BEcPHMIiPPb6AAqjGK62ebQFd0JMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257908; c=relaxed/simple;
	bh=aEdtXip4b1QqVJ52L3/+hvECvzYEykZHsjru+XsVQX0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pOFqjFgdGEMrVnQlPuhW+O3mVjkXoLbQuQGfzCGdI24nLg7mWSphj+wPHRBnZCWTttoomwdd186aRMOlkYGehJysE+4BoiXwqhzspQn0gDPFnNkYv+ppHtI43hrbvDFngKCMVOabttrlzfyfBNtD+UzrDwXXyDXnVcb2zOENqrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hHy2UTtm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hHy2UTtm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779257906; x=1810793906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aEdtXip4b1QqVJ52L3/+hvECvzYEykZHsjru+XsVQX0=;
  b=hHy2UTtmzWls5vYwREEiWzaHNcSExzcgwvyj3JPs/77CFn0S8HC/+oHp
   geyxvBNA2T3vskKk8uYTU8GJtQuUQEM267OnsApJYubiMTGFxTeQAaMTS
   pTqFd7fAYPzibMM34zhurmsVVkBZ0uepPMA7Wu2PtsUUYGvcMQ1NucGny
   1oWqig3vDWL5sqUs+FRH63Wg/eKejLMRWhDttg5bRI8ekz58LndUMsBPR
   pbL75aFrA/ftFcTPF8UsyWRPHzs1Nlf5iD6SnBNftnzlE/9ZxCKpHMjZL
   ZCdmN4RMVn/B3KnPJES5taVI5i1F8wasV1FSVK5DQwMXUAzYST6iumyfG
   A==;
X-CSE-ConnectionGUID: fhkhVGBsS+GKlFPNFXwy4w==
X-CSE-MsgGUID: xlWb/MGWTKCiz1/404zFDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79171226"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79171226"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 23:18:24 -0700
X-CSE-ConnectionGUID: ubLOqka+Q3iUFOVGa0wZ1Q==
X-CSE-MsgGUID: M3S0zsJoQ2WFtwUTi8wGBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263821741"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 23:18:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 23:18:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 23:18:21 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 23:18:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQG9E7KlNm2PKe5smhfF4cgVapMCzRAOMFItFh/GCUM7+NZq/M1DPbUWdJwD583jKrBRpQuq38FAUVIdTbj/olYe18etmDla3jcUMgw2mESR/VyFaXgNaMUb7ckypwPjqbNvpeRf1qBbNR3gXPdW5TFGwGsiBaMwNQkUNES5J5a3B2N5cDgZh6Odkchs0RX9IbH1UeBJH+jnVzxSKH99eGA09gKqYYazV6MKeT6l5EM/h0xxSW6q2H+Fm6IFeEzxcNoFnKXlXBzeB9V/4JSQK1DMxmW4Ll2it9mC8LLWukQt7Jpmv1qwNpLutQ6Oep0j2PLEv4lp0wDnzGd1wZkQUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heyiTXiSnLFSvxHjUcoWOaYQ6KK2GwRmwhveaWMjv8Y=;
 b=BCM0Gxeg6w44oKQIv9mp90XilKhGW6vRYdnjP5hFMPKyfZtHsqY1VshU4o00L5wn97X3e6nIeiHB4bTJO33urMG6ZSHb6xnxS/UYpuehRs+Itu4UmyiISmapR/OzupZW9hjJZOkAhR/ijGtvbd/XxvY5rer4XqRHFLZfMbl5HkStP24ith6Qn5qIfyw7wLkux7YJ/glJo8JC71jyu3uyQ4dL0mQl7ujx2PLadtVagx4bC0chptu+ICkUuCz98qzwO1LVunrvlBjYy0e0zBWi86SqpIG6Uy7MZSyn+AN1dF3tsJ3X7sQ3mmvAh+f6loQOWOB/swTjE5OpIQ9LtMmOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB8752.namprd11.prod.outlook.com (2603:10b6:610:1c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:18:16 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 06:18:16 +0000
Message-ID: <1fd00df1-9529-43b1-886f-7aa7b3d9c334@intel.com>
Date: Wed, 20 May 2026 09:18:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mmc: sdhci-of-dwcmshc: use dev_err_probe() to
 simplify error paths
To: Artem Shimko <a.shimko.dev@gmail.com>, <andriy.shevchenko@intel.com>,
	<ulfh@kernel.org>, <p.zabel@pengutronix.de>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
 <20260518110034.142587-4-a.shimko.dev@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260518110034.142587-4-a.shimko.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::19) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: ae54955b-5d5e-4678-9964-08deb63793f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|4143699003|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: 2EY5GpjE2ooS4hiJecqW8Enx99nYhPPa11bOHCc3ivJe2HTTRi3jxh/DsYrVmVdLcHlyAcYgzXwBzjZcoUio3twUyJ2PNMPKKvrRjkf/9rDFl+UcbwmfGkC6TqlQCEX9kPkYA7W0JPK2ez0uyyAiM3kzG3Yr/S5an1IzxoNDv/VzLT+edYfxrahBt45gFeloeSb20AE2/j4HwqfRZjuJlLo28ip8Gi+IN1b1Iz2uwNWfsr4b806yCs77HK6MtBVniz2VskLza5xixX6mlq1jdwhzrsr+DMwChj+xPsu2Pb+1Q5NQaUYUS5kEbu7dbioM04713ucf17k/e/khNIX6tdNp160g6ZtxQ6GXHfxnCZ60n+FBl40hb0HHBGO44ZvEqKC7ItG9PeAVeMUDM9W585ATFbV7COmDdP1bSaMqFtU/Fp6KWX4lcaIUovVvpDbVLTqQl0TvLAQq0kN5NrlB6cTdKxg7G6g/FJjWuzXiJUputbH1ZJCxJ8Tr65tzhPXYOMpaiXJQwPBdIuUneL4CqZ7M9CedFm3c/deV5gwg6iodHLJUQhxeMi5hbidqKvAUsgjPKDH9BfMt0RIYm5WbbKi7YBPJ3dT8jr405W5f/wUkURd7qEO6pSKZNoS+ZyK0uMmw+N1tHmSfleRwksjFPbPG30Uhw0COebiaNknjh9p1sZg6OXR8WTpGqAYSZBPV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(4143699003)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHVsS0NPRlZObE9EYm1adTlJL1NyZHMxQURFUzRsbzNrRXQ5RUorOHNEMkZv?=
 =?utf-8?B?SFo5Q3ppbEpEOEpjUklIYWtBcnJkamtYRXBlU2lJTEh0N2Z4WXQraFJJTW1N?=
 =?utf-8?B?WEhlWTBIZ2Vva0MxcGdFVWZsUndkWVNlb2tYQmFOLzM2ZjRScGFVemhGaEY1?=
 =?utf-8?B?NkVDeUJLZ3g1OFRqdGhvdzhqV3JIRmJPbnlUczlJL1JiL1FzRU5PRGVXSE1E?=
 =?utf-8?B?WmxzOUtkMGc3L3BjTy9qR2tNYW9INHY4eHdtMlBGNnY3S01jTy9rTU5iVjQ2?=
 =?utf-8?B?VitwOFFVT3l3K1hscmlEWHV1ZEQ5Ukhyc2lwdTZ2bmExZkVKU2x4b2tBeGVa?=
 =?utf-8?B?Z2sxalFzU0EwUExnY2cvb1F0dHZzUFExc3VkZHN1cmtmMzJsdXNYcklpL1NC?=
 =?utf-8?B?NTdCSm9kOVVFZ2ZjSC9uZXVYc0RDUUVFR1VQcExHZi9BTmFIODIvQ1BQWk9z?=
 =?utf-8?B?akdjQjgzVnBWM2dsRjNIN0pOV1RjVXdFUDg5bzkwVHFzd29vM3FvL1RJbzNr?=
 =?utf-8?B?eVJudkY0MGVVOEczVno3TDc2VjN6TmhabG5Ma2Fnc2hjeVlIdGtXRUo0WHUw?=
 =?utf-8?B?VHJpWFoxZTI2dkUzZnZ2aWdwNkJPaEtTU0kydTFQbWdNZWFZdzFFLzRLVlJ1?=
 =?utf-8?B?dG12T255TjlUUU1zWnN1cjgrbXhVeXd3dm5Mc3JCcVdBazBaWVBFQXo1d2h6?=
 =?utf-8?B?dGhEVktTRUpPVGo1WVpNZjVYZzdhbUh0aFN2NjIyRDZRQzlXQUhzTkxYUlU4?=
 =?utf-8?B?OGV6d0ZpRDk1R3pvTDRUSTJuTmRtVlZKNGJNQmdxK1V6SkFibjExNlBzMG03?=
 =?utf-8?B?WnpsWkc5c2ZiTEZvMkE0cDJ0V25lUG9IUm9KUEk3K3UxYi9sODBaUTNLMW5u?=
 =?utf-8?B?eHNYUzVGRm4zRWl3WVNJanpkSkpyTnRuaVltQVRBNVNMQnJsYnpHdnhINXVN?=
 =?utf-8?B?WVJnSFdrRU15ck13K2dENDBoUC9ZNy9nVkRhZXJLOE56T1RGeVg0dUkwZG5n?=
 =?utf-8?B?MnM1ZmNXUWt2bWE5NTlsWkd1QWVEVUJLUWkrMmIzOHJSRHVJWlFGdXJXdjQv?=
 =?utf-8?B?Q0RWUDhyblB5Q3BOd1VmQUN2U0tTMWdxbldOQmVUUlg5OVVmdGUxQ05OaEov?=
 =?utf-8?B?UXAyem1lOU9yZFllcEZwcXFRUU5DWDFEb2RKbENtVnJIdDVpNlFDYW02Qzlz?=
 =?utf-8?B?VUhwMXJBVXBTN0cxUU9OeEV4NEdNanZPbU9zWW5FOHZ3VGIwR2phNU9rRWlG?=
 =?utf-8?B?bFNENTdkSlVvZkJvYmM4TWs4ZHczeVhUWllORnl1Y2hmdDM4NlpiTzFmWGRM?=
 =?utf-8?B?bTBwQlIzTTV3OXpTWFl5K2ZyVlR3NFZEVzhSUTA1bHdqUDRJTEtZRGdMUlNU?=
 =?utf-8?B?cnB0cVNkSURsR2NiT3JrODdBS2xNWDAxUDRYOGhSOUdNUWNhZWR5eW0yNTRB?=
 =?utf-8?B?azlFOXU1dkZ0K0xuK0xwMS9tNWtadEVDQXdqaDExSVUrWDdVVWM1OTBId2Nn?=
 =?utf-8?B?bVRBVnRNU0dWeFRsaWZtOWNIYjN1K3o4cnFPaWVvbVZBT3NLNDVOOTZ1WUVE?=
 =?utf-8?B?T3JpaUxwUTlJV1lIQzZkQnk1RjdibnhVTmRJNDgvbU9GWHEyZ0N6aGxXbEcy?=
 =?utf-8?B?K0picElrSXIxZnNsdStQUjJkb3hFSXBEbzlaZXZyT0Y2eGVBZ1BlbjNUWXhp?=
 =?utf-8?B?enBIOG9jeXJ6SVFtNURDdU1OWGxIZUZHby9NNlh6YmpCaU9xdkk1cXBhWDBW?=
 =?utf-8?B?bnF0ekJheUtkSG9acFY2SVoxd0NZKzFab2ZCYmliZzdTVXZUbm16SWJtR1lO?=
 =?utf-8?B?MlJwYnpIYmZzdTNSaDF6U1UyL2cyK3lMdVFpQTNVUU9HV3NGTFB0K1E3bThz?=
 =?utf-8?B?SUErRTh2ZHhpVWlPQyt4NTFoZ2NuYjYrU2orOHlMciswczd6cE1RUUxqbG1w?=
 =?utf-8?B?NlNLTnM1NWVidWtyb0tkZmV1aWc5T1dEN2greEhnUTB2bjVTWEU4a3FtN29h?=
 =?utf-8?B?aU1NRlN2cHdwRjY5WEdTaU9KbS9tbFdPSFh6bG52V1g0NDhNMjJIUFlzc3g4?=
 =?utf-8?B?L3FQN2p3RTZ4eFlQcTk4cDd2L0tYY1NLRHBOSldYTEVOdnI2OEd5R2thaVhB?=
 =?utf-8?B?N3gxTlFSc29RNlNZS3FML0d4SDBWZmsvTHZCVkZrSmlxaTJJQnNHVHlKYTN5?=
 =?utf-8?B?dHlZaFFkTzhHZERYZUNTTlFORkJXRXhyYmlUUnJYMHdUYU1Qb21iR2RPL3BI?=
 =?utf-8?B?T0IrdzNwS1lxdGdxVGF0akpnVDhWUC9hTmZLM3BiRFNYZXJFZ0tqUVVjNjV1?=
 =?utf-8?B?ZDIxK0JNdUxEYnFGTlcvTTRBU1Nkd2xVaGc0QmJ6Y3QxWlY1YVRKYlZYNkQ3?=
 =?utf-8?Q?QFioFVaEvvtyytow=3D?=
X-Exchange-RoutingPolicyChecked: lIiMQlITFlzqMNKZAJYPmlZ3GLqslreNN6i5f2Gfsk1TT4Axk9Pz5P1c2hAk3M6MKSS15vK9V/v2WMxMvbkCK+vvLGsThNISsyUAPLVIgCvwUJaEs7RhU7SS8zC2eP/ZxSgsFJEocGIthQPKDi9s2n0Mk65yrlqedTK2UKbk5+9ER/YJ9ksJ9Nx/hThDrFRN2bh/eHtcAZ7RZnv6hUen2O27tLMwSA0xv/w7ASDqENO38XnSFTnLSOORung/b9xh1zJ0ZTctt5KGfBYpNnNAhsFuF30lGw17A8c4gpf5eQoGpxVCdcBZtasbHlq9q9WpROrQoaJFdTL9pTdY6QqrbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54955b-5d5e-4678-9964-08deb63793f6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:18:16.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGRTlZqDfArGcMpq3bSfQFwVUsMPNtk4rYsuS3G65ijgtsUQCIJS1RMQdViPbzD9NtPoeM3bVPE+kld04KPGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8752
X-OriginatorOrg: intel.com

On 18/05/2026 14:00, Artem Shimko wrote:
> Replace common pattern of dev_err() + return with dev_err_probe() in
> probe functions and their callees. This macro provides standardized
> error message format with symbolic error names and adds deferred probe
> debugging information.
> 
> The conversion makes the code more compact and ensures consistent error
> logging across all initialization paths.
> 
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 31 +++++++++++------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 29bb46783ee5..ccd5f4d6fec0 100644
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
> @@ -2408,10 +2402,9 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	u32 extra, caps;
>  
>  	pltfm_data = device_get_match_data(&pdev->dev);
> -	if (!pltfm_data) {
> -		dev_err(&pdev->dev, "Error: No device match data found\n");
> -		return -ENODEV;
> -	}
> +	if (!pltfm_data)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Error: No device match data found\n");

"Error: " is especially redundant with dev_err_probe(), and it can all
be on 1 line e.g.

		return dev_err_probe(&pdev->dev, -ENODEV, "No device match data found\n");

>  
>  	host = sdhci_pltfm_init(pdev, &pltfm_data->pdata,
>  				sizeof(struct dwcmshc_priv));

