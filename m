Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B672417D4;
	Wed, 12 Mar 2025 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783462; cv=fail; b=IRU2EWA9kuTDmPlZRJSD5w/4tLgEZIXm1R1HqwHPmn/uihMIRxeLet1NS5jRyDprf6ahjDVV6Vj9cuqZoq9G3lZXzHk2Y5UT55rNnlFC/k4Bw7bWGeru4rF3zvFaqr/FhPvy9q+xpcNu/8vva4j7Nxp+eIXO8SauEiUXnqVFuKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783462; c=relaxed/simple;
	bh=CKIN/lH85gQx2JV3oHBgx4ZZ2nZBEgFaMrCyNAzgYCs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oaVUW5/NsZS4y8FEEPEQPy2161xge9S3n709l+L4Nx9M3t6lgiTE/jGn1Iiqm4w1DoqeF2MUqIQgGusoeFNSuH8Is6LRgobj897wvV98dKJip/T3khamSlxdhoe/2qwRmLEXePNsLe6Ntw1uk6a98VFpJTKXcMAGOKl2clqoo2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lB5Ft+Uy; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lB5Ft+Uy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741783461; x=1773319461;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CKIN/lH85gQx2JV3oHBgx4ZZ2nZBEgFaMrCyNAzgYCs=;
  b=lB5Ft+UyQgJ4OFCbFJPswCXJO0T9WzG5LAH6uY2/ZnRRkhy7xOHLe5hU
   7PtfRLGkGO56pP1X1w0gLI3e0fN5k72CjiTu9xI9+dfRZVRPAVHyxTKR0
   2Ta/fINwCCfAhiTYQwGdwYb+pj+BDCcH37CUGvefrwJchOUJaJlM56o6o
   F6a9F+sYAakLgH5xMR3prmuropFL0qhoRaUbYI2SSVAapwssOTfE2vyfA
   ZjMrwzFF7ImDunWLLcRhjy+pqT2LBa9nK82I4+OM9HpTR9TaS4hfB8jN6
   iL3Lmv5As+4ZmHOQHUXGniJBWxlMKCclmi1/VemVNVx5MBAhW18b6eceq
   g==;
X-CSE-ConnectionGUID: MLO6mi0GSuymjMEVY3GB8A==
X-CSE-MsgGUID: ATFBGGcVQty+T+SWwaDD1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53483179"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="53483179"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 05:44:18 -0700
X-CSE-ConnectionGUID: +f8aurtlS/e+S+/BgMLOFQ==
X-CSE-MsgGUID: MgzRU6FfSMKwf2MzCfLJwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124789391"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 05:44:17 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 12 Mar 2025 05:44:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 12 Mar 2025 05:44:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Mar 2025 05:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuYvpyjOmX5Mu1sqju6+HFKCB5Gz8gctakqwHrJynhTgXds+c4Awwkz4kQ5IzVW/z0EjbSBRWmh3/nl4MVw59mgvV6RKX1rOzRKGLxPsd2h9cg/dbst0qP5zVc8ZOe75NaqqfDk2A+Ba0TVn2ehXolp4FpinwDRq1Xe8hRQC2N5dvjOBGOdsbg4ZIsjC+ags5pw5r+XL+qcJBMGmdo2LeWlYnkNXZbARfW33ij6/2seyXsEclevLHNP3EBvvhkRc060REWFSulEGD1Szu5vRvx7FUqEN9PaL3kvBJvOpiSdKsvH7hLUlt+Puedc/I5VwQr/967oo+1VypYuaK7/T5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDTH8b4pTjTSHUrnMInKdIZii819fefunB8SxGcR9u8=;
 b=qUdGMMwJl/N7Swj3kOpAcIyxEkXuFUrd857f/EABnvo6LAJFMYI0ryTIl3RHL1CSQmHE69EShMiJgL3bro0ZskjS68Gw/5SeNONX31sL9H8EHJOY4pff3KgmW45RhBZ1tyDw8LK1o73+iI0frWcykuoPkyGFUqOO4P39v0F1F08ugKbE94/8No9Mhh+VnyhyzRhDeNtkkL6BDoeiU7bK0No2RobVM321Aao4dNCVB3LbOfe6jUz2Scdfc7b6TaDvoOIWPpZGAE/Kbyvb4qVqKKj7YUTPjnoqlUVeXICwuJNd6OtJZP4PgIa6tAMWMGs5ezddRAlZuNsJZrxYtHrMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by PH7PR11MB6378.namprd11.prod.outlook.com (2603:10b6:510:1fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 12:44:13 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 12:44:13 +0000
Message-ID: <a7d1bf5d-6101-4282-92a8-11f9f3569d8b@intel.com>
Date: Wed, 12 Mar 2025 14:44:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Wait for Vdd to settle on card power off
To: Erick Shepherd <erick.shepherd@ni.com>
CC: <brad.mouring@ni.com>, <gratian.crisan@emerson.com>,
	<kyle.roeschley@ni.com>, <linux-kernel@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
References: <440723b0-a1fa-4f9f-90f4-50dc831c68e5@intel.com>
 <20250307211648.1289714-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250307211648.1289714-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0269.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::36) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|PH7PR11MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a8de2d-3725-4d1c-90e8-08dd61639773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TFJpODZyeG4zQ2hKeitMbzJydTNEZ3IxZUNlR0MwZmRrT3VKK01WcFVHZmNh?=
 =?utf-8?B?dnFmRGhRZWNFRkg3ZkhkcmhBVk45d0Z5Q1pITEc5VU50eUJLYXhIUHk0OW9Y?=
 =?utf-8?B?SGtlMFpHYUw4YTc2enlUTzNTcWUvc2Y1UmxuaENFR040ZGk3MXQzcXFlcG5Y?=
 =?utf-8?B?ZWZuM2M1Um9rczArdXdubm5QanR2VXhQRC96RmtHQU5kOWtnMk5RQjlBNzJ6?=
 =?utf-8?B?RENwczVnQ2R5S3ZJakJnRmNzK05vRjUzN3RvcERSSEY3N2NYVXptYitic3B0?=
 =?utf-8?B?MGEzbndnSmJlMmVtdmEwQi84MDViK3B0MFR3RXBtMTl5WmgvNGdYTnVVb2lI?=
 =?utf-8?B?ZU5ITzd2bHphM3pSQ3did3NNdjhWa2N0RTlteENSNzh2M3QxMm1oV3FoT2FS?=
 =?utf-8?B?eEhoYnVVdlJTTTdGS1ZkVjNBRlh3TTZOTWI5L25wK1hUaHpwa1dldWpLdGRs?=
 =?utf-8?B?ZWdnM2VZT3g1TjRPRGJTY1JmeGhVK1F4YWk4aEZ1L3NCa1JyVE0rOExhV2lL?=
 =?utf-8?B?ek5NTXVBcEwrYUhVWlNSS2Q0dXd2aWxBVEtQQ0RGRWxvNlVWay8zOThEaUxI?=
 =?utf-8?B?RGp5SHVFcUgzeDIvRkt0N29WaU5WY0IwZTFJdnBpMXozNXdUcE9uMTc0RnFH?=
 =?utf-8?B?SVNqUWtqUjcvQzdBc002K1hIY2FrSlJLSWhTcER0NUhxLzdMbGJaOGptcEg4?=
 =?utf-8?B?dE5xY2U4QnE1Y1RXNDlPOHVTVWl2K1k0UjkwOVBvWTJXY3k2S0ZyeWxGNjU5?=
 =?utf-8?B?OWNMSU93WCtidlZqR1dWQjI2QzNvbVBrRVNqdVVwN3NEblA0aWplT3dGUWl2?=
 =?utf-8?B?TU14d2dPQkZzUGNUSkhzbGU3V3VpOU1ialpxT3lSMWJjS3ovem1jWkdHcDVO?=
 =?utf-8?B?N2VLLzJnWTRkWGgwYm55YTByR0o1SGRES0taRUp6MS9XYUpmMXhsMlllRWJK?=
 =?utf-8?B?VEJlR3BRN2EyOUsvOEpRUlNKQU9vNFI3ZEo0Q0JzZk9nY0xydlJYVjIrclRK?=
 =?utf-8?B?YTFTL2FmRW42QnU1L050R3RkeEdFZTBaaTRaVVA5TXlaME5RU3dFVTdhbGJC?=
 =?utf-8?B?a1pGTUFvK2JPTnRrdk93R24xVk85anpMeXNtL2xsQmREVy80aGNRczl0UnhR?=
 =?utf-8?B?dkxvbkIvYmVGMUZwTkFJNXBHZWpxYkk0NHIrcVExcFhEeWNudHBVVVFqemN5?=
 =?utf-8?B?cVNwSE5hVHpjbzRnZDJrTFBSWklWemF0NG83bkJtbnpQNnVzWm12eFBPUXh2?=
 =?utf-8?B?WTZnckpoWHI4bjMwV004cWdmc2o1cDAzOWFCQXI3ZVVsNXRKcW8yQUl4U1R4?=
 =?utf-8?B?N2dhMzhNWWRtU0ZPOXlIak1GMU1KK3BqcmdlT1AwZnR4UTlQbGxvZGI3UHJp?=
 =?utf-8?B?T3I2T2pYUkxSNytXdEtNeXlPa2pZSWJJN28vU2E3c1RSekVaUXlCeC9WVndI?=
 =?utf-8?B?Z1FBalFiUHEyVWJpMUVkdDJzTFpjS2Z6QWR3NzY0RS9lTlNGTG03bzI1a25a?=
 =?utf-8?B?R1BZUkFrWjlZS0s3RkRYU3hNREViT0p4OHloYTQ2TnlDRDczVC9naXRhZ1pk?=
 =?utf-8?B?N0NoR3VDS1NrZmYxMFl6em9WVExaRWJhbmN0MmpJeWUxK21uMWVOdTFRZjJ6?=
 =?utf-8?B?cjNiSjFzT0xwbUU3c3dqYnFBdE16a3RGOWRvN3dGTS9GYTg3Ti9RMTAwOGps?=
 =?utf-8?B?ZEFnMlI5VmNWODArcThGMFRQVFlYc0tPZkRqRnpVa011LzRSUUpQeSsyTGd5?=
 =?utf-8?B?b0RjSnNPNkJsTytUa29VaGNXY0xEVEhWTmxKQjloa0JMNStZLzNYbVJEclEx?=
 =?utf-8?B?UzBIQm1aYlNtV0VYTGtlMFZHUlFOSEVXeVVhY3pxdzd1ME5mM3lQYkR4eGY4?=
 =?utf-8?Q?H+IGzpN08eLty?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjIzSmY2UG9oZ2wzNjh2Z3FLdDd3a1J0QVFnVFBwMjdUeEtZWHdraHpGM203?=
 =?utf-8?B?QTRaNzJoYXR3R0dUN0g3YUJIZlE4SXVLRit6UUpKSnZXRDRvMHpUYVl0M1VG?=
 =?utf-8?B?ZW1IZ0pLTWlwYnNxYk9OMmlQelQ3bEcyM3ZjZ3FkbGhDU1VUWEkxK1RsQ0Rz?=
 =?utf-8?B?QkpteDhlTjZPNU5OWDFLTUZWdzFNbkhPd1ZXMEI3UlVBM20wbHN2NHp2NTAw?=
 =?utf-8?B?SFVwSEhYT2tPYnRJWmJDMnoreEN1SWtKaCt1Nm1tc2lDSUdlU0VvZW1wQzVL?=
 =?utf-8?B?OXJLQjVFZDh0MEIyYnU5ZkRVMUJjZ2NpamM3NWtBdE93Z1haR3FraVlzcStz?=
 =?utf-8?B?N3c2dndQSVREWENqSXptZUd4TDBtM25QRXJjeU5aN3FuTWpHa2ZJVjh0NnNt?=
 =?utf-8?B?a3Y2eTBYc041c0NOTm9rcTVwbjd3MDJ3UjNKTWFSOFV4MlRxeS9TbXVKQU52?=
 =?utf-8?B?R1pJSXVXTlZoa2JSVGpxVWRvc0YrSVRYeHdIOTZqZnlxSkF6Vmd2WllERHho?=
 =?utf-8?B?WmxhNERVUmxKbEUvc0dzdmFsZks4ZVBsSCtmT1RTN1c3K211VGhLMXhOZlp1?=
 =?utf-8?B?bEpQN01hT2FvL01xS3crRWwwQzRxYlBaWklnTDVDQkNTc0lwQktIazBnNFE2?=
 =?utf-8?B?RVBMZjVJbHJwU1Q0TXhKeE0zZlJzY1EySEdtemZHcHhrdU5OZTQ0ZjlkN0ls?=
 =?utf-8?B?K2NVQi9DNFV1NEtrTlFjamZNUG1xSEVyN3JtRGhyUHpuWmZYWGVsS1ZpdFQw?=
 =?utf-8?B?VDNZWVo4YnBwU29ENm9kQ2dWSDJUR09wZ1B1SkwvU1dJaXpkelV0YndKZU5j?=
 =?utf-8?B?ejVBTGl4ZWhOeUJTM1VNZjlPM1Y0MXpZdkFwODh3OHJNTkYwVnJiaEdVZ1Zq?=
 =?utf-8?B?cWtrdVo2QVNqNTBnSmlZci91VEhEZHljNk1QN0doYzBQVVkzTDZCSk92LytG?=
 =?utf-8?B?N0lPTVhTdi83NS9icjlvcFd6YWxNd2Z2QURRaWh3RnFNYW54WDkrZVVZeWN2?=
 =?utf-8?B?SlQxMkF6NHRYVkpyN1BlOGpTWE1LQjdPUlRGdGxWMWZieHVMVDhqUTY2MDR5?=
 =?utf-8?B?Ynl4dEhyMzFxYzhEdXVhcGtLZXRrcFNFRGUxdmM5MGJCSHljd3gwU2JBSGNG?=
 =?utf-8?B?MndBZ2hpWkZkdFdQaFJhRlh4MWZOU0lLYWZqT1lRaTdzV1NZTHl3MWYwYkJ0?=
 =?utf-8?B?WHFLQVI1aDFRVTBFSGJLblA0YXZKVG1scnVFN0FtMGxSaVl2aFlHMXFMZWcx?=
 =?utf-8?B?L1JqNUd6OWZVWnFaMDd4QXQwZnhWa0M5V0JYbFhKKzBuL2daZi9GY3IxM1RX?=
 =?utf-8?B?aTU0Zy94TVM2Ym5GQVVVNkxnZEtZUzZ1RXhmUlB4M2lzb1duR3ZmTktEV1Zi?=
 =?utf-8?B?dWhnU0JkeWFSdXFacGFQN052U1Zyc0FFVzREanJSS2NaenVhWXF2WTRmK0lU?=
 =?utf-8?B?dDFRWTl6L1loUVQ5SU9aMktaVEdEa0xQZUI5L241eEYva3c3N1YycGVMTGl0?=
 =?utf-8?B?MTk5bXd2eEwyR0VLaTVrTjRqQWE2Lzhibk1iQllDUG5haERyLy92bEhERDdi?=
 =?utf-8?B?T29XRTM5cXUwbDdJWmhmTUNSdklRbGVmaWNLdFJIN0ZpcGxuUHVlcS9rU2V4?=
 =?utf-8?B?TWxCTGFxVyt2TGR2MHpYdFJLcllUZG5mWStERW1RMUtEd2VVVktmQnltdnht?=
 =?utf-8?B?dkpJdU90RVZIS25UQWU4c1dOTXAxUnozOFRFY3pFbzAwclh5bWpxOFRtdTZ1?=
 =?utf-8?B?OXd4c1h2ekVnaldWLytJVksveDNtaDRDL3p4ckRhMWsrbTRLZGhwRUpSNjJx?=
 =?utf-8?B?WlFPMXRNc0VzYXJOczg2QlVpN2xWZHJhdnplN2hRYzA2WWQzQndZaFN3ZU5U?=
 =?utf-8?B?ZHBGNUJDNVN6NmRTZHNIb3JRZFNhWWYxVmpsdk9aQ1FkMGJYVDQ5bjZSSW5X?=
 =?utf-8?B?bUdyaDZsckpQUm91RTRJTDZzNTYydzdQdWo1TVBSdnlYZ0Zqa1d3TjcxSE5v?=
 =?utf-8?B?K0lhQzJpYmQ1dVJtbFJIQTFSUUZReStVRTRyRitrZUN2OWZpbFIwOHJZWVQr?=
 =?utf-8?B?Q29QcVVCL3BoSmN2VjlVUGxtQVlSR1Mwb21PRUxNSW9leEwzL2RyN1liVFZL?=
 =?utf-8?B?cEExSzliNEFtOGU4YXcrdEt2cllhcG96VGlHZ1JnalJCRHQrSWNjYzJJWmpm?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a8de2d-3725-4d1c-90e8-08dd61639773
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 12:44:13.0296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUGnWCoHttSLZhxNzDhl1p1X+zPYqOVJFGS3qQfNfzuGxxuq25V6l0zjNpOpc3/vL5ODce2m3nmpFRL9dpVvLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6378
X-OriginatorOrg: intel.com

On 7/03/25 23:16, Erick Shepherd wrote:
>> It probably should be dealt with in the ->set_power() callback.
>> Is it one of the PCI devices in sdhci-pci-core.c?
> 
> Sure, I can move the delay to sdhci_set_power(). It looks like that
> gets called right before the if-statement in the change I proposed
> so the behavior should be the same, unless host->ops->set_power is set.
> 
> I believe we saw this failure on devices using the Intel Atom E3930
> and E3940, which are Apollo Lake. It looks like there is an entry in
> sdhci-pci-core.c. Does that change what we should do?

What about something like this?

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 1f0bd723f011..0789df732e93 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -610,8 +610,11 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
 	sdhci_set_power(host, mode, vdd);
 
-	if (mode == MMC_POWER_OFF)
+	if (mode == MMC_POWER_OFF) {
+		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD)
+			usleep_range(15000, 17500);
 		return;
+	}
 
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the

