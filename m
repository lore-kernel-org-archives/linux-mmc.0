Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5324E4B3;
	Wed,  5 Mar 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199946; cv=fail; b=rn+o8RNqR+bRxewlnNpPB8Lv0wrzk9Pww0ipTmsHWsq0QfYGY9nNBOC3aigoPKweorogw3U2+Ge4GqpLryoGOM1012xUQrqOnBjdPUekyKWEGL6tZeWo/0WY++hSvSog0vVlwCL2abZScSxidO4BThcGlAqOXZzhPHc4tJd6TyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199946; c=relaxed/simple;
	bh=vBtSU+jFxq8jELpIxAmwg/MMe0WyyfcHXpB7KwczXcA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VfI3rugTqImFjxDXUFt7Gt59ax3IY2NbrYoBnYzWBqyUwHJ7jszA2l83X7jbmFmOlFpItvtTD3xQfKBwOLTO10qlbRy2U/DJ+yz7Vc1Oe/jzMTvYqZUEm6hLP1QFQ56MHhBHLfszfVcgPBWhOpdWw0AUUg9wD1JIz82WxW1lfKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfb+GK8f; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfb+GK8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741199945; x=1772735945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vBtSU+jFxq8jELpIxAmwg/MMe0WyyfcHXpB7KwczXcA=;
  b=Vfb+GK8fs67uKzWYOpzkN/EM2s9/6Q8zMVH/Cv+YVVXD8Hwi6pU27k72
   0+doFvmDCUowBniHD/t1QBjPBIPpS2ZEBfk2yozhl4kd6i5RF6mrKu/3B
   +Yuf2IYPKzgv7wIhCOlrgTq+ypBF5ooZGluzOjefPqPlcPX5kV+m0Z3dS
   ok8pvwft0gWe+eR0DP8FyNKrYFAroZPoZ0C488zBJi9RMl2xGOR+M66bT
   F2bV51a2u9Lye8SKh8BlxYzyLVuOk238x/Bd8zEWz31QgEipoWzMkcTkM
   Efw0rqzAWDwVznE6oefg++dldT1aCJxs8EkjvgTXBAt4uvibAyI5ZzBAv
   A==;
X-CSE-ConnectionGUID: TMl7YhLeR/u/u1pMy2mSyQ==
X-CSE-MsgGUID: dfQe0CQMTf6XFVMfHiYnbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42042937"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42042937"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 10:39:04 -0800
X-CSE-ConnectionGUID: xeazDgfHRoas6I/7FtwIMg==
X-CSE-MsgGUID: 0dEbJXslS066gycMu49aiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123691100"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2025 10:39:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Mar 2025 10:39:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Mar 2025 10:39:03 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 10:39:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izpetfpj+qiaO5saOCGMvt6RcGG6hZE/1vjFCO1evTDZqWB1WwXK2hZ49DcZtZ4Iwhvl54GkMxj25kvzYN5eVx1z2ivuWPMD5Xc1OY5T8NHWQz+l7ZY+zCKcqYNuiioe4kjX9QMCi58hMMeAMhHE3FwQpIakLZ4VlL9tkVYTqwH+Ll+FrLrC3fwXmF68XNBq/r8IfROUsNtrLLcbvsYDMe0+KxzdJerg6Ozb8bDl4tGpLqhDflk23rIROVEThsCF6vFwpfF0Av0AgE0/sCmvYRYXJoGfBacFe5iQZD+SQjqmaJ5DXsL2OI5ynWm5KiDVYGD1MTVlJMkVOy5dLzyNpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFm4LMbjCVeaQ0ZAw8MV6uo0Cy/G0SkNL7raKaZGt90=;
 b=MdZZkTZVA06N3Qyli59pn3R0WarMkzUx4INcC24QQR3+ZuhqRj/xRN6+RUO9Lc5UA3uMEQIAcK9JQprVKzh31Y5d42keal9QEzJy/wSUgplrIecEzILbcg2xfXLis5209wNe2g3bmetFnjBZHWXRsNTH33m5UABKQOYMsU+nKalEE1q7yrjUoMSYy+68wiNDTaLShuZxgKKSRGL0rjOsiAx8L/NmcfzEnXrhs8dnK1CvKUmS4HhBpYJBs6W530qjZrGGXQzrNrBcdlUiqRA5g/Byt0Nldnfn1tXHry0sfPrzZBqRpqiySCBi6oRmXdkiguZYmoBW9GrU2UegUlaEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3605.namprd11.prod.outlook.com (2603:10b6:a03:f5::33)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 18:38:52 +0000
Received: from BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89]) by BYAPR11MB3605.namprd11.prod.outlook.com
 ([fe80::1c0:cc01:1bf0:fb89%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 18:38:52 +0000
Message-ID: <35aebb39-ae2e-4186-8de4-6830ec661f4d@intel.com>
Date: Wed, 5 Mar 2025 20:38:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Wait for Vdd to settle on card power off
To: Erick Shepherd <erick.shepherd@ni.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>,
	<gratian.crisan@emerson.com>, Kyle Roeschley <kyle.roeschley@ni.com>, "Brad
 Mouring" <brad.mouring@ni.com>
References: <20250211214611.469260-1-erick.shepherd@ni.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250211214611.469260-1-erick.shepherd@ni.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::24) To BYAPR11MB3605.namprd11.prod.outlook.com
 (2603:10b6:a03:f5::33)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3605:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 3313719e-42ff-48e9-5771-08dd5c14fa2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTczM1JNV3l6QWc0d3ZwSHFBRTNIY3doanVKeFFkNTJkK3dOUU0wRkdsanI0?=
 =?utf-8?B?WE5NNHJlNG42bHZuWmpTUU9ZK29vdXFOZVkyRHE1NFZLc0JTTzlWZG5NYUJJ?=
 =?utf-8?B?RVVXT3p6ZDdZS3VBTDgrV1hZL0k0SldWcTlBZ1QzR0pEZTNQMTkxWFVDaUxv?=
 =?utf-8?B?WmtQeTAwK2syczZmdUVMYnpPZDBLeHpyVXJDODYvMEtGQ1FVQ2wwLzJPRlh2?=
 =?utf-8?B?aU1EYm1CdmQ5TEhkamk1Mm56TU42Y3prNXZxREN4dThGM0Vqd0xJM2NwRldr?=
 =?utf-8?B?NUtwaFNsaFBrd0tJVS9XMmVvNmJqUHdlcmJ3Z3hQbDVZSHBzMjJyUU0zU2pK?=
 =?utf-8?B?Rk42UGRwT2xEY2FoOWlVSC8rcXFKdGl2cWVXenBZT0FqZnRnR3VLOW91RFc3?=
 =?utf-8?B?SloyMENsUkMrbCtlMWRtTzh0bDFYaEJOVkJzZUVHcHl5QytWT1Jhd1kyTTRO?=
 =?utf-8?B?aEhvU1R6L05wc1pjVUFwZzU2Q2svdXJ4ekVIMmhkT0JhRTdjK1dzNkpPbXBR?=
 =?utf-8?B?RHBxNS9scHlRUXBack05L2JwRFVSeWZWdHJJdTdMMExHMWJqRExZeE9VcEJB?=
 =?utf-8?B?UkhscjVHL2JQb1Z6eUhNLy9MNFFrMkord2lXUlhqTTlMcnZlVk45a3NmQkxa?=
 =?utf-8?B?M2htQXN5TEhMcFNrVHFxYk5LbExyZEJLd3EwYmJnb2ZjNjJuZHdEcmNDR0hK?=
 =?utf-8?B?eFh5dHRpVnozYXEyNlJ4aitQMXBVTDJ6VFNDWkVUNGN1Zlk1cGNhYzdtZTJK?=
 =?utf-8?B?ajhOMFVKcnJ2UGdWMCtNV1BiZUdlL1JOUm9pYzZ4ZkY0SVFTQkRPU0tMSU42?=
 =?utf-8?B?QlJ1VC9reE5nOTZJZExWMVlKVjJpSkU4VFlaU09Va0h5SGkwU3VXa3piTzdQ?=
 =?utf-8?B?TFlZZFVDU0E2NWlxc200dTVlNi9IUW55TXlGZXJrTTB0VGE3SldFU255VVds?=
 =?utf-8?B?bVNEOXFZMlkxVmNCWTVzMmRWS2dVYVZXQlBTbE05RTVMM0tRYUF4MnVSSlhQ?=
 =?utf-8?B?aXZ0WWlZNXAyeVJ0MHdlQUxqNGdVeXlVRjczcStoREFSOWlrMXNqSDFsaUZu?=
 =?utf-8?B?V0hsNjlXbDAzQ0pwa3J2RVE2RnpYdWtvVkJVRGZtOTdsY2pwWnZFTGxYQnZy?=
 =?utf-8?B?S1lFZDY3YlNOUFZzTUhYbWNoZ0thMEVDNWNGTnBBdTBXVFRGVUIyZVRZejBy?=
 =?utf-8?B?bDVzeHlkQlBwTjdwWENPTEV3SHNQclhaQXQyeG1Yc3hpLzNXMVIxM0JUeFRp?=
 =?utf-8?B?aGZXdCtZMWZBUnIrZzdYQXlTZHc0SHhVNE4zdDA1bDJkejBOZ3oramdGbS85?=
 =?utf-8?B?Q2NNc2FyQ2tHSmN4NjdUSjdzbGlyR1B1UDBmNnBxa3RNendZems0RGpjcXRs?=
 =?utf-8?B?aHM2UnVBZjNPSUpzbEU2dGtnT1FZZkJxc01URnh0UHZTZUdnUzJITTBlaWlu?=
 =?utf-8?B?ZjJwN1p0MkV0WlI4US96Ym9kSHRlUVdGaEs3V1gxVnZiSStSU1BDSWR2L3VQ?=
 =?utf-8?B?WktjN0JRNnEreHJXK3YwcFNYRGRJa2pRKzAvS2xwUm9ralFiL0dtVE1ZVkR5?=
 =?utf-8?B?cHZ5bGRFd0F1ZXkyK2lMSFgzUzhoR2Rub09CSGlvSitlYmh1MkxCNXcyajhG?=
 =?utf-8?B?bldnRDZ3Mi9GU0ZPZmVwNGVkc09pMnVPTjBTMUpFS0NHWlNFNnc5MTQvWkNT?=
 =?utf-8?B?YmpSOTNQdDd0U0lGTVpGSG43c0VaZXFLd0tEUGNEWEpoVkV5cnM2dE1Mb043?=
 =?utf-8?B?bmkwMWxYZzRocndVbEkyZnN0SVo1MGt2VklTd1F5M0NBNTZvUDV6eG5ncEo5?=
 =?utf-8?B?TW1PT2FQMG1FTTNHc0R3ME1qUTI3V0V1M082M0FhQmZWYTEwLytta3pQOW1R?=
 =?utf-8?Q?8APvKl+gXQwaZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUNXQzdXMzBIN056LzdWVXM3eng0SEM3a0R4UUF5SVlQckFQN0UxMVhsYnc4?=
 =?utf-8?B?NGFBVVhHNU1IOW12Znh2SlY1T1hvSlZPL3IxZTg5SmZrOVBqRjcrdmtucjY2?=
 =?utf-8?B?VS9qeUVZZ1NhUVQ1eGJGdUdvUlpNUVp3cy9DMDFtSU5kNzAvMU95NGxxZXg3?=
 =?utf-8?B?d0FrcjJiU2pXeGhmeWd6SWxXeDdmdGQ3bnZsV1JCdi81cjBYNGFkeHAxVWcw?=
 =?utf-8?B?TkEzZ29ERFlBcHdWK2FaL2MvUUJMOHJLQ293bmpJK1Z4ZU03WDdrY3Vpd1hv?=
 =?utf-8?B?bmdPcXBsajRmaWF1S0d0VjB5NHdUejlHTlpqZUZ1b09pTENvM3A3cjhKemNj?=
 =?utf-8?B?Zlk2c0d1TGVNT2E5emd0amdQM2NPdGo1cUpRNVd6aGVXcmUzaFdjcncrUFlz?=
 =?utf-8?B?b2xyT3YxMVF3Rm95azNoRDRVeXVmVFhrajhhZC9oRUNFaFBZOFhBM1BZMjNP?=
 =?utf-8?B?ZFZBTldwQXlqZWdNcklCemY3bGp2OUZQd3poa2x4dnFYVy90aFFMTWpRVkFV?=
 =?utf-8?B?T2E2UityRU5TWmtTVVljblptRzlzb0JvUktYYVBaZFZKT25HMFlCRXdGUm9n?=
 =?utf-8?B?RisvdkdrNTh5TzJualNBS3VqYUxWbXVuVHJxdEFUeGdiTEVoMStVTTFsUzIy?=
 =?utf-8?B?UjdncTMwZXJ5LytHM1UxZklVRU9qSllqajdidW1VWG1LaFJsKzZ2aGY3OEVP?=
 =?utf-8?B?bFo2MU4rWmdrOVBjUmI1YlFQQS9hWmo4cTEzNTBiRTE0WFM1R1hhSTVYcmtk?=
 =?utf-8?B?UFFpbm50L0ZFajFEbGNMbzlRUnAwZUoyNnB2WlRiRjN3eTdEK0FMRVZyQ2ZE?=
 =?utf-8?B?amNLbHNKdHN0T0dNdjBqdjVYQ3J1V3RNSTJKQm1reitoRmUvVWR4aDAyV0Fl?=
 =?utf-8?B?aHZwUUk4b0hYQ1htM3Zib2czUXRZYTNKWCs2bGJQZTZhT3RjUUpqT2VyeWZ4?=
 =?utf-8?B?OFFHNDFPa0JhL1NIdEcrRWJJdlRaaVVJVUMvS1ppN3pCZTF2RFBud0lJR253?=
 =?utf-8?B?SW9GWE1hUG03SzUyaDFjUlJiYWIwQ2M3bjVlL2o2Q2hpUHpiVkF1cXRIdmRv?=
 =?utf-8?B?ajc2Y1JtZ1Jza0JNT0pQU1R5ZWJVU0hTQWpxRkxZWmJOMXN3M2VVTFRQVjVy?=
 =?utf-8?B?TVpwdk11Z093cUpMT3laR1VLZkpRRld3Y0hNYzNkOWZvTzZBS0orVWI3dElu?=
 =?utf-8?B?bVpmWlUrS2d3OWZ0Y0xWWkNxeXRXTXpuUTlpY05RdnZMS2doVnNsMGdZekpZ?=
 =?utf-8?B?N3duMXhxdGRUQldvSVZaY2JwVnN0M2Z2UEpyajNuVnRLZWFNQ254a3ZtcG56?=
 =?utf-8?B?QVJtQlZKa21YVXpjdXoyYmNCaFBJOGptd0lrOXB1UnlyT0VoUEN2RFBuMndO?=
 =?utf-8?B?V1NuNm5pTEozYkpRR0xNTnhqU2NhL3lqejk0Y1FLZXFGVHRTWUlEN3NWdnYv?=
 =?utf-8?B?NkV2Ni9XaWlGRkNHNUprQ1RuQ28rdkRzNmdrVHN4RUV0S1k0aEpoUjJkYXQz?=
 =?utf-8?B?akJkbXBLa3BVbWNmOStZVzM0N1hzUDBGNjR0cFVESTJjRVk2TlNwUktvWm9u?=
 =?utf-8?B?UWk0N1oyOVFuOXJIeEkzRVBZd1M4MTBzdGZsOWZ3NXhqay9EK3g4cDlZZ291?=
 =?utf-8?B?K3pGQ1R1Ung3bytvVmZRbW5PYWNBc3haZTJLMXpqNURUNlg1ZWIrTkxsdksv?=
 =?utf-8?B?QWxnTUtMeTVveUQ5bU05NDdxU2ZVcmI1UGRFSXdlaEdyTHM3TmxtU282ZnRZ?=
 =?utf-8?B?ZTdybGN1bFRDR09ZVHdEVURTODAyTFJJRjhmWmtaOEN3czZzMjU1K2NGWlUy?=
 =?utf-8?B?c0R3Zi85RVBUcWNMNUo1S1h1Ly80dHR2Wjk1SlFkU2p0NHFydWp6di9LZE5h?=
 =?utf-8?B?SXU1ZWp5VzZ6UXI3RVVVOGhqY1ZCMjhGWm5HT1pqOW54UHAvenJXT1pvdWhI?=
 =?utf-8?B?U1pTWDZDTEFERUdadnFaVmhQcEhqSmt4bjJEcWpUeW1jMTZGT3ZaVldZWThp?=
 =?utf-8?B?ZmFKWTZ2Ty9nYUcvQ0ZUOUxKenA3N25DZjlqeEY2UnhTMHpEUDJuZ2F0MWJk?=
 =?utf-8?B?NjVxNmtjQjFrZzJMODlxR0lBZHZoMkp3YUY1MHJSdXpOcnhvem5rTWcvaGdo?=
 =?utf-8?B?dXZDaWNGL2llQk1yRWNIWFR3NjBURldOdUFtRUcvbVFCQUNWWlYxMmNLUFZN?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3313719e-42ff-48e9-5771-08dd5c14fa2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:38:52.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQPNGFt/8aEjtKAS5JZihiSqAT2LBOH0RsFSoWqM1CJnb6mNa0KazMOfLhfsSKIoUIjQiEUhgJvOAni94N2qOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com

On 11/02/25 23:46, Erick Shepherd wrote:
> The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
> lowered to less than 0.5V for a minimum of 1 ms when powering off a
> card. Increase our wait to 15 ms so that voltage has time to drain down
> to 0.5V.

mmc_power_off() has a delay.  So does mmc_power_cycle()

Why does this need to be in sdhci?  Are you experiencing an
issue?

> 
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4a7733a8ad2..b15a1f107549 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2415,6 +2415,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		sdhci_set_power(host, ios->power_mode, ios->vdd);
>  
> +	if (ios->power_mode == MMC_POWER_OFF)
> +		mdelay(15);
> +
>  	if (host->ops->platform_send_init_74_clocks)
>  		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
>  

