Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CF3F1ABB;
	Tue, 14 Jul 2026 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015518; cv=fail; b=eicQ7g9tXGhLRBOT8hypre8is19jvsXxg10hm+QmAISKw0Eg5ex1sSIr3E1BhnXuDQfhqFDTvMvzN83NTf7wswj6RpxWgNrWchzafobWykFNNiDT/I9PEf2MSCv/dSVKUjcmHD9r2XJGSXs+SHptQYffi09CdZ+uX1+GGRBMQYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015518; c=relaxed/simple;
	bh=HQxSHmKOHVoAGe7uHcDZ29n9Fp8OBo6+QHrfYLS1bwM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JcmtrZ3WAGJLdZyoMevwOX9ohHCQM51/djhiD3j5hk+8nEN5tTfP4JXpYquqQXAcv3kQPYgmpyNeE0pRd6akpR96f+13eCrIbdBK6PrPLYvJw/xLiIy/GqcdG2e2gjwAbCtC/itd+bLOhhaMcijvnHdzJD84evABNv4ibYg4hg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUloaPQX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUloaPQX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784015516; x=1815551516;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HQxSHmKOHVoAGe7uHcDZ29n9Fp8OBo6+QHrfYLS1bwM=;
  b=TUloaPQXWvM5OEjj9cSBYaPG+7HkizD5bPivmzPcdvp+/HKVCb/sPE29
   pIu8JIr2DDqCZHrpcRAuij2SRv8WounhoEOgTlu1xiz8wSJUp+fX2Jk+p
   O9jwpqcdWRiJlXopNXx6YrR3YYEmzdlDTnV4Aue3e8oLftHvqKix+M84p
   KuomaDsMsVgf+362KBdXxa4vkqkRDRreyqdN3RFA+xhFlTQ8fe39DBwa/
   STQUbspsP546+ZETaLtE1c5G+6XzRXAkHE55YUD/hXskJEdeRvnFY5thY
   BSVLJiFxjojx0zuaqCXtND2PRpBYMPFMDMNNKlm9q3627z67tOVXKtpXS
   w==;
X-CSE-ConnectionGUID: Ti4LUuHeQlSs7NHUyUw1Fg==
X-CSE-MsgGUID: 36UwPr6ZS1KAgKZBZ2ClJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="72155599"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="72155599"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 00:51:54 -0700
X-CSE-ConnectionGUID: P6DbmK8mQIu6YxG1d5MEWA==
X-CSE-MsgGUID: CO3HNxncSf+u8/cP6Du72g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="256432737"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 00:51:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 00:51:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 00:51:53 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 00:51:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6D2AYzrBYsY2alwGvOMCRjN4izX45RVVDeRDLge4PFEj3HXKDMCli/qXecbXfFbVigBY+RdPxWrxve5hhD6buiyCCYEoBPdhVZ8RWDHNChkzIlJVSzLJPFMxDS04NfOqOpjhuNKrS1Xrs4fT7OOpBpvjzicRYNb9mThfWAmQxPczMWoTWvA8rIi+2yd6/VIwHOM6qc8eH7TGObrwW68TSgqt+q4SJVKjU7QbkaUJLN5l2TD63lat+8BMCP4b4nfTFZycn2iUcnDygIjlmDgFQPlkINlZm0kaxc8ts7eZsYGnQTyfmx9BoTOkATCNJsT7FvCvPrsdLVKjrU0JYYRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol6P4ncjkkvSfbGsjuu6c0EyidPL6nXwTeLsmKOlGTI=;
 b=tmaXWkVDRiaXTuK62PTZ5s9axoRJ7Ed6+duR158djylWztiyDDJNXedzIaImickpK1AqCk3ZqvKAiudpuDHnfJoeqyfEBOVz/oqCwfEGDo4Z+9XaGmvYElKXcJqpGaQBQCpvlrVnfWRJpmBKB41pL8XzIGAO4xsw9Qxw8XBg6ebzzNg/uw6h0cMd+ufOFQmHxKiiQWarJb7lAk8tc7TJdgq+7XEZaMbOQ+F3vkl1xWzKeI//0kJhbaBUHWcPcqOvcBxSgy8Nxh9suovkAXeKkQL4CR5t1onCREtjF3GlhrPLtqmBqxyWBkQ/il3M0S5BNWTsrwqSKBwcwF6xoRdDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB5171.namprd11.prod.outlook.com (2603:10b6:303:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Tue, 14 Jul
 2026 07:51:50 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.019; Tue, 14 Jul 2026
 07:51:50 +0000
Message-ID: <74c00cf4-f4d3-434e-981b-0de47ba2ba2f@intel.com>
Date: Tue, 14 Jul 2026 10:51:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] mmc: sdhci-esdhc-imx: fix SDIO suspend/resume
 issues
To: <ziniu.wang_1@oss.nxp.com>, <ulfh@kernel.org>, <haibo.chen@nxp.com>,
	<Frank.Li@nxp.com>
CC: <s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260713043904.4144172-1-ziniu.wang_1@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::17) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c098541-8572-430d-5c7f-08dee17cc320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: pXDT4uIsQHx2qkUltxhvewq0j7rJ/WcQWWd39sjM9kQLJ2sRoQl4ED0TvxpDWRzkuVLygCYUPp0hKgxAmdOep8NriBIjEybv0EO+fNLhxsTbvz6ey/vVUBnjHhgRDBfxp/9ol6MmpXfqn0Cp5WQyn4Kqzrst8cHcNfnjcjUUtXX1UsSlsaMpdfGPFJ02thLGUKFOTC1zKxzFtsA5k66tJScc6eTZKqpPcloTODH1A2bW8FzfYTU1PuG2vTV4LADT5HPjIoIawHragiVuioKhZiMlR4xDOxZmViBy8Khpd3vvFrN+vq8Tkeu1B0k2Tn2U7HKj/wwTOfPPNURAqkJB2bG9nazBKKIzPDrxh57pOaBFw755AZW5FBufH0m3ibREbiODGuJom5HdtDfJw2YPCyXTCVsmeUZC++dEDNGtTuWpHVGx7BF+sD5IfLeAgBhJ8Vep92XjlVxxkGV9z6b7ZweVGpt0EoWk52kods54rpeRAwxrI8tIfj1xM0Ve+yPLzb7socOzdHDGcI0eGN5vbPn8ydC3QbksMES7K/vq9rg4puNdZ3Yw1Kd874BIFiwGuruuwsndyKfwDn53yIzvBCmLqZX+pXkkekZkaWWHOg02h67nKs8zgloBhTtoKgYsaT057e1ahs8VBWY0XKE2omvjRNHYUMYtjr+07Wo5W4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBIeXRHSHZKak5Od1BvVGdwWWZoVm41eHFxMFBXUGoydWE2SkdSVi82bzgx?=
 =?utf-8?B?aUk4Qmh5RXpvQWQzeGsyL0crSnRXdnMweU1keUUxdGVOQkZOS1Q4bXo3K2pS?=
 =?utf-8?B?dktjLzZSRlNYQURjTHpYWWY2OXlnUFhRK3JTRWhCS2IzcmsvZmxXR1pieUdw?=
 =?utf-8?B?eEdqaWJQd1R1Yk1leWVPbnY0eXhhVFVJVFpqUTRVNXNQYnQzSE0vT1p0RnFs?=
 =?utf-8?B?TzlZOHV0a24zZHFPMGZ6eVJRUCsvWDJmTGxtendkUFJkbng1cFpSUDB4Y3cz?=
 =?utf-8?B?NzNPY1VlQlIyT2U5MytsbldBSVk3YlI2MmRDVnBmaXlTZDdiRXhBcFVnRjNP?=
 =?utf-8?B?Y3VVUXB0VDlSRVZSQW0yRi9BNUxTM0E0V1lKcytBRmtBUjIwejFJWTg0aHVK?=
 =?utf-8?B?RXMzc21Rb2lJcm9lRitabDREb3dackxQYmxXUkU5cEdBdW55SmFxSVY1bzVq?=
 =?utf-8?B?ZlRkVW9lZURuQkJVSE15MERFelZEbGVoRitZd0hOTWl4WUx4Q0F3QlJkL3E0?=
 =?utf-8?B?UGZxWE5rWlgxcjM4VFVLakFyUjJvVVhsaEZXQ3hseFVXWjFVVEJEWFZ3K1ZB?=
 =?utf-8?B?NXlRTGk3Wk9PeGdKQm91UWU4TDRwOEUyQ3BvWm44RSs2a2krSXN0cy9JWndo?=
 =?utf-8?B?ZWkySE9MYXVBNkZET2Y3cXBjNi9iREREYWtKWXdYbW9MdlJFS0crelZOYjZv?=
 =?utf-8?B?aTBWTDg5UVRNdE5CNGtTTlNwdU81dWdadFVrU0ZpbVllUU96cmV0QUdOVFpI?=
 =?utf-8?B?elI2U3RnRlBwTDJWSFV3WjFpUXpiYkFBWjZvRVdMQ2RFRnNkS1BkTUhHOHM5?=
 =?utf-8?B?U3g1TVYyK3A5NDR1VVRTT2kyaVVTS2lnOGc1L096Y0pmeGV0d1JyMEtERnlW?=
 =?utf-8?B?Skl5VkRtVzlGVjFOK2p0Rnh0RFRYNGIxdHB1RlREN0lITk1BZHJ3SjUySXYy?=
 =?utf-8?B?ZGhNVTdwL1pjblJ0NVhaUTZ0ancyeXB2T3o5Vkl1ZEhZS0tRN1hXanpZcWZ5?=
 =?utf-8?B?OVhFdnJ3V1JqQnQrNFprNUtRRGRMV1pqS2xKSkJRSVlUeHRXNVhuMmF0UlV4?=
 =?utf-8?B?Z3MrazdJY0tCL3Zpejg2cUlncXQ5eTZoU2xZczJ4WVNGaHBzYW5la2FqcEZ3?=
 =?utf-8?B?cU52ZndYbmtSNWhubEtuUXRvM1lZSFpPZnQ5Yy9HMTJscjZZOGxoZkxiYjMx?=
 =?utf-8?B?MGFqb0JyNHlSRUlwSzE3d01GNE93NVg5cFVBUEpHRnNwOEw1Y3Rsbzd0ekVZ?=
 =?utf-8?B?Ti96MzErTk8xWDArdkk1dEV1Rzl3SysrQStLZElpUGROM1MyM0JkVHIrYmZH?=
 =?utf-8?B?MDdnejNLVFFPSnVEVGNVUUQyMzdMZCtWcjdiK1dCSEJjTmlhYm0xQklaZU1m?=
 =?utf-8?B?VmgranVyK0orWnlFRW9aU2k1cXhoOXk4dGF1SWt2RzBkRWFlR3ZUamQ1NkVw?=
 =?utf-8?B?ZjdabHpQTUI1MnZ2K3NnREIwTWNaZ3lQZmFZcmR1Z0R0NS80THI2Y1pGTUw5?=
 =?utf-8?B?UGgrNDNXdUhmWXZzdllFeGs4OUZ4YlpEdjdkSkJqSXJaM2prazJnWlREaHVa?=
 =?utf-8?B?cW8rbkdnell5djl2Z3g0cW1Hb3J5NU5VcWJFNGc4NmdBVDV2Y1MzZE1VQ1dn?=
 =?utf-8?B?YkRZYmJ2NlZQT3dlTlhJaTRXVFpOZUE0eFlQdUE5KzV5NTVQVUlwcGRON0pq?=
 =?utf-8?B?dGMwQzZYM25HL0J5am1XaWhLN2VnK1lZMDRWMVdhTW05RDJMejJYNkhJalZt?=
 =?utf-8?B?cmUxcGxqYlQxNHdZZWJEUjdRRG9lNFE3QUJkdk1QZWtlcDFFb3NMYjM4THpq?=
 =?utf-8?B?TUFBS1kyNVZJemJiZ2JPSktkRm1FWS9EdUtaUG9hUFBvWFhXSExxK0lVWHJJ?=
 =?utf-8?B?bGN2Z1B1dnBXaGowUFhQU0lSUkRyRHBvSDAzRU96cUVyb3IwSXZTZTkxdHV5?=
 =?utf-8?B?d1ZiL2IwazF0ME9QUnRZV1Q0WlBQdi9NTzNzb2FOa1V3Z0tBUHQ4cGsyWXZD?=
 =?utf-8?B?VHg4MjNUKzhKaUMwV3ZMVjFBOUJ5K3R2dHdDM0NmZkNVTkFhdDg1bnZTL05G?=
 =?utf-8?B?bk5NckRjUGJUSDg3N2VlVHpPbDNTMW5RWURnOExhN0xnRVRoVENaam40YmhI?=
 =?utf-8?B?ZEZJWFVrL0JVR1E0clkrYktNK3dCWDRkVkNuWHBhY2c0eGQrSVNmR00xQWFj?=
 =?utf-8?B?c2V3V1ovUUJFYnNEZnZneTNJeWd1azJCZHdZNmU1aFUzckozVWU4QmdwUlhC?=
 =?utf-8?B?NERBdnhjclR4dGV4bHBBNHZ2VmZxdlRkcnFUbzJLMDZKZld5R1Y3WFJFL0My?=
 =?utf-8?B?NGwxcnBiZHhvVjlHZEFMcHlQU1pLeXNaNUxjSjhWNmo5bUJabHJCNGRZZlBP?=
 =?utf-8?Q?uQhooPmn6GsF0sUw=3D?=
X-Exchange-RoutingPolicyChecked: oXr8VZ+QYzEz69aS2FHKEteWeilo3Okh4jJPo0QiSD4EzixNUPJwBB58HDLHAUueNTAnuzbdXJenxYAKja8FvjFLCb0zleaQifEAOd02v895H7qgTihSxWe/+nSwynJthz/Ml9j5jnciAjE8V/zxvM78CLg+tf3oJXzp/dlaMzNIiI2oFVD6YxhgXJAdXrniUYniZeBZz6RKTQDjxDI/3EFMtbEiUExQW8pXsRCU82lCGvaJIygrbeKnf7vYBCJbedSXl2NldiR4f2T+MwJ5tNUfcNu+Suij6ahFQ+6Xc0zcDxnbY9bRFXLuqXuDkEt5tsjnPu4Yfw+K5tETn6VYxg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c098541-8572-430d-5c7f-08dee17cc320
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 07:51:50.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1G+i25Cn4YnnEqosSCSczXx1a2ktI444i7L1aYHdUXUAjilJXnjjGwcSEq8ssmKOfYbikL/6U2XbT17SGEW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5171
X-OriginatorOrg: intel.com

On 13/07/2026 07:38, ziniu.wang_1@oss.nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> This series fixes several suspend/resume issues in the sdhci-esdhc-imx
> driver, primarily affecting SDIO devices (e.g., WiFi).
> 
> Issues fixed:
> - Tuning delay values not saved/restored for out-of-band wakeup devices
> - DLL override lost after resume for DDR modes
> - Pinctrl not restored before DDR_EN is set, causing CRC errors
> - Unhandled interrupt during resume causing "nobody cared" warning
> - Various error handling issues in suspend/resume paths
> 
> All patches now carry a Fixes tag pointing at v6.16. Patches 2-8 fix
> regressions introduced by commit 676a83855614 ("mmc: host:
> sdhci-esdhc-imx: refactor the system PM logic") in v6.16; patch 1 fixes
> commit c63d25cdc59a ("mmc: sdhci-esdhc-imx: Save tuning value when card
> stays powered in suspend"), also in v6.16.
> 
> Changes since v5:
> - Added Fixes tags to all remaining patches (patch 3, 6, 7, 8) so the
>   whole series is properly tagged for stable, as requested by Ulf.
>   No functional changes.
> 
> Changes since v4:
> - New patch 3: Fix esdhc_change_pinstate() to move IS_ERR checks for
>   pins_100mhz/pins_200mhz into their respective switch cases, so that
>   legacy timing modes can still reach pinctrl_select_default_state().
>   This avoids log spam on resume for devices without UHS pin states (Sashiko)
> 
> Changes since v3:
> - Patch 2: Remove unused 'boarddata' variable in esdhc_set_uhs_signaling()
> - Patch 7: Expand commit message to document intentional skip of enable_irq()
>   and sdhci_disable_irq_wakeups() on early return, and explain why the
>   PM runtime usage counter leak is acceptable (Sashiko)
> 
> Changes since v2:
> - Patch 3: Updated commit message to explain the SoC IP integration
>   detail about internal loopback path change when switching pinctrl
>   from GPIO to USDHC function (per Bough Chen suggestion)
> - Patch 5 (v2): Split into three separate patches (5/6/7) so each
>   patch fixes one problem (per Frank Li suggestion)
> 
> Changes since v1:
> - Added patch 5 to fix error handling issues identified during review
> - Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()
> - Make pinctrl and cd-wake failures non-fatal (dev_warn only)
> - Use esdhc_change_pinstate() instead of pinctrl_pm_select_default_state()
>   in resume to restore correct pin state based on timing mode
> - Skip pinctrl restore for wakeup devices to avoid SD bus glitch
> - Check pm_runtime_force_resume() return value in resume
> 
> Luke Wang (8):
>   mmc: sdhci-esdhc-imx: remove unnecessary mmc_card_wake_sdio_irq check
>     for tuning save/restore
>   mmc: sdhci-esdhc-imx: restore DLL override for DDR modes on resume
>   mmc: sdhci-esdhc-imx: fix esdhc_change_pinstate() to allow default
>     state restore
>   mmc: sdhci-esdhc-imx: restore pinctrl before restoring ios timing on
>     resume
>   mmc: sdhci-esdhc-imx: disable irq during suspend to fix unhandled
>     interrupt
>   mmc: sdhci-esdhc-imx: use pm_runtime_resume_and_get() in suspend
>   mmc: sdhci-esdhc-imx: make non-fatal errors non-blocking in suspend
>   mmc: sdhci-esdhc-imx: fix resume error handling
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c | 84 ++++++++++++++++++++----------
>  1 file changed, 56 insertions(+), 28 deletions(-)
> 

Already acked patches 1 and 2, but now for all the rest:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

