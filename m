Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7F13B2A4;
	Fri, 29 Aug 2025 04:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756443334; cv=fail; b=nL/jrNFkx5VYyWLeyvrlyxn2BFNO3lntR5AjR35lRJPkjbtPLVBu3tKSikfkQIpfqZ40PRDJP1pjRw/vdOBzIecvwcit256RfZguXUHUlNffPbyXrmZNPLKzwBWrMW+aRz5nBJdTcK5IuOIGqCOIVTMYheTerQ627gMjEZp8aHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756443334; c=relaxed/simple;
	bh=UF50B6UxmVpqEw6K1Lo2/NMIY2gGBKK7vq5iRbaX7KQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLMDX9B05QGjW3YP/a5E5ZXlrL/29T0GkjgbFRHvymZKPXT6dCFiDyDjOgLx+hrtt0ze2F7bwKF4yQs24LFKSpDFcplWvQ1leFP8N4yWsBmp5RzlvQ5ME9fpv5XE28LGU//fy8acBN5SuCHA9/SqqTvErQvAN8s5vTUuq5OybkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxBrMfZA; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxBrMfZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756443333; x=1787979333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UF50B6UxmVpqEw6K1Lo2/NMIY2gGBKK7vq5iRbaX7KQ=;
  b=hxBrMfZA/DY4wFnY5fdAPpoRhJJkcyXCVvkLq2cglNfIJ8pjMFPaF+G5
   tkeYXGNBoEVVZ+synN5b8dJxpTOi18CMH/R1+4Tisj++5LyQhIwbOs9ae
   CZUmhmAYXm/+eqKeBEHX5Jkx50V3dvue9xr47NAhlQaKp7ltzlsvWprbT
   R3yk/UW2w+EZxpf8GiGHIga0meBSz2g0ufb1GfWJRVNmWX7T9Jf0C8NCp
   D/+mkx0bjrQvOrhiJU3YKAfTAxkoZrIl6fV6Bbcx7UryRBUorxoTak2Pk
   Y/DHqhzzbryLJAOp3KrLjEqKJtep06h+u05B3zdmumjhUJgDcJKPFbZRP
   A==;
X-CSE-ConnectionGUID: Ea/owfUjTRy0OuV7QBAOfA==
X-CSE-MsgGUID: +LH4Jdg7Tsq9EkpTt7GOFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69000476"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69000476"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 21:55:32 -0700
X-CSE-ConnectionGUID: acThNcaFRUyMVADDVyrrAw==
X-CSE-MsgGUID: 9vh12F6ISjulIj0cbAYQRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175569648"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 21:55:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 21:55:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 21:55:26 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 21:55:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=is2jIPVyOsYeRetLCw2LSFQmqODOFq9x9YrbxxiQPkqjsuOnzm1GsFFO39RwzqFWo4PEa+6G7UmxKdtp3BBTldqu71GGPHt660VPcf4j6Ha/5YfPbCY/cE1DnTV0R07v435Bx2NLd9gj9h0HdfuoQz4PFvSp/sSXTMD9qB4Brk1RZ1hsb9YjORUZTvhTs43SoLpIoJYvromssllwEcBEFmdztl8dYFzPj6j4q25Cf3qcsCReem0REDHnCLOLHXKUDOHzk0ovfB6os4kgzM4MBTMie9moRL/19LqcBJrtxOnz1/SifxBhyjZUlgziyN62ft7mtGyBD40YCNyohjsbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVijDHpCeri5Fsi07kV3SFZrZO2z3RuAmR36GRm+NkA=;
 b=pEbou9m4eRxWAoyf3qIMtO0M3qzT4jkQaLoxfieHC3gHHPbaMAZVkwnaCReD36tejM2CkwMT9+nnn8WSMHSEY8YhU9FbxzLJ2855x+O1FEVKURjhAeCWH9OaFZQ+evIUP8sRJ3JmFv0KXYJX5YfLX75c8DNZ7Es7lC0SzDvS6iA8jKghas9Azoe49SvUqEVTWBVpMChJUKRlasutn9kHqvZLE6aWdJcDcK1c2tsZThLaYU4+vBj2GJdNstC4JqQP+71Inf9yiiHJcZ2YvQ9HGduRA+tiUTSOOyIPpB1DoqQSRpP85ZaF6gpFR/dIsmGlDc9+uOX+PjaucmSu5TZCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by LV8PR11MB8536.namprd11.prod.outlook.com (2603:10b6:408:1ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 04:55:19 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 04:55:19 +0000
Message-ID: <dba29577-c685-40bb-8bed-482aad351edc@intel.com>
Date: Fri, 29 Aug 2025 07:55:14 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mmc: sdhci-omap: properly check
 regulator_is_supported_voltage() return
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Tony Lindgren
	<tony@atomide.com>
CC: Matthias Schiffer <matthias.schiffer@tq-group.com>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250825122149.2169502-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250825122149.2169502-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0272.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|LV8PR11MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 4755a5a2-9579-45d6-0775-08dde6b8408b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlNvNm9jUVFEQmpobkJZZ04yNGlXUTk1VTNmdWZ4aFBMWWl6SUt3VkFMNGx2?=
 =?utf-8?B?eEdTUldrd0FwR3RxdFNOcU5OZ1N5WXpid0RHOHU4Skx0c0cveE5DNktWeFE2?=
 =?utf-8?B?V1Y2dzY4cDQ4ZDkrMld6RlU1Zy9DRzJXb3lmQVZ2bzNnVGJsdm9WdzJTV3Zm?=
 =?utf-8?B?NTQzNWxIdHhFa0JQWHgyMEo0NUV1Mkw0aWxWNW53N3RFRHZzT0NTYXR0VS8v?=
 =?utf-8?B?Q0h3c05GS3lDOXc5VGxoR2ZNdlQ0VmNWc21oODZkZG1BWmJsVXRFcCtmdTM3?=
 =?utf-8?B?VWM1cThMei9VQnNXOXp3ZkNPZ1ZpdXdSR3Q2SXFJZ0NucEx3VnVRUlUzNHdo?=
 =?utf-8?B?aHM4aTA2SzRlVUg4WCtWYjFRUC9ZcGx1dlRkWTNDa2NuQ2JGU1JxbjJiYlJE?=
 =?utf-8?B?L1g4WmVWNk44VmRQem1kaDNOWUFXTmcrV3hzQmdIWmd3bWxEYWRpN1JxOTBy?=
 =?utf-8?B?WEVzaXltcUxTWUI2ZVFXdWc0aWRLSmxVVDBpWGtZd1ZjV2YxMGhyQlBaTk9y?=
 =?utf-8?B?Ymh4c1dlMU01TWZDRGZqL2NyZnVCalp2OGlrakhMa0EyeEdBdTZUWlRac1VZ?=
 =?utf-8?B?K0xQckJBcTB4eXd2YURSNzVnV2NFaW5CN29KMmRZZWNtVHgySjVobmtpY1J1?=
 =?utf-8?B?a203Zi9aMDNSZWV4Sml6c1Z5eEdHdkErTG9CWjF2UnJ1Tk1mMzZvaGRlZFlP?=
 =?utf-8?B?KzJYbnRCNHdjWXVXM1A0N0pqSkE2RjZ4MUJCRTRXZHFkTjlGb2srSWxxdHR1?=
 =?utf-8?B?ODNzMDlJSVlOMzVEOFBaRDhEK1NMdlBwWkNBWmNKVU4yTGxIN1BPSDF0c095?=
 =?utf-8?B?eWxmTHJJRWpkTzZ4RVBYRWlZQmpzNU43VGczMFo1bTJmdGc2MlJuV1JxU1Uv?=
 =?utf-8?B?T2llSFIvblNta0g5cDdzOUVYZUZ2bEZibEJQa1V0MjFCZEFBYW90S0tQUXBF?=
 =?utf-8?B?dk5nbDdJbnRBNUFRT1hYOStsTkdDT2NLcWZkYkR5SS9QazdDVkp3cEcyZ2Jv?=
 =?utf-8?B?VWpVRHpaai9RK0lpSzByN0Q3ZUdmSE1oRTI0Z1dqOGxhSVhHL21XaEx6SUxp?=
 =?utf-8?B?V0Z0T1J4N0ZPVTYza3UxWTZPQ1pNUG5CQlFkcGRQN1VMZ2w3bVBoVkV5Y0c0?=
 =?utf-8?B?YU5hMjEvY01XK1ZSaDFHUWErdlNqcDBPd1E1YkVkNjBMWldPWndoN0k1VEQy?=
 =?utf-8?B?Y2JBQm1tclI0VFBIcW5YNVQ3MlM3RkZudk9ORlRIYUlia1E4cGtMQjlXNDMw?=
 =?utf-8?B?TGRoM1BFVkYrVERkN3M2eTdWRDVjQWkzUTdDNnlHL2lGbTAwT2RsVFVaN3pr?=
 =?utf-8?B?T2JOZ2xEYno0WjV3LzJOMEl3MlN4c0RqUEtkbGZWSS9KbmZoMjYwSy9SNjB1?=
 =?utf-8?B?Sk9WUVJiQVhFQlpoWlVyaEFaYnN2bVlxYVlLTnJWQVJFTE1hc0Vub0c4NVBj?=
 =?utf-8?B?NUpqQWFaWXNXeXpEVjZPR3lhZWtWSkNzS3ZqR0t6OTZpbUQwWVdONjFrU2Q3?=
 =?utf-8?B?UWlXZnQ0N3MrYitJcFVsWFl4WExsdW1LcXliZG9wVHgxeGhQL2NNYTRaTllr?=
 =?utf-8?B?eDBzMVJHanpOaHpzRXNHNk1tMHFPTnE1UitCSmJSWHVmL3JVeThjNFBpcUJl?=
 =?utf-8?B?NWF4cG5ELzNPWnlxUjI2YVpQN2d3ZGJGaHdiYlhMemNobUpxTnRJN1ZjS1JH?=
 =?utf-8?B?cXFYbnpuS3hUMUhhM08yOFhNSEFjWi8vRVZxVUJ5bExoWUNHaDFsa20zN0ZU?=
 =?utf-8?B?eFVuUWtpSVNjcHBERkFmWDA2bVJxRndUdWl3b1JsU2RpZk9uTE1USnJFeGJQ?=
 =?utf-8?B?ejFIKzZlaTVmdE8rb1FvVm5VdWlYV1JuUGZHZncyWDNGc0hIMkV0SmdzaGlj?=
 =?utf-8?B?WmtaanZmMHMwSjhWSldRMGRGNDVHUXR2NE13L0g5Mmh5b2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1Z5VHMraG1yRURhNkNsNjZpUUFEZlJxMG9oVy9rbDZVQjFjYS9yT2R4aVhG?=
 =?utf-8?B?dVBvckN5dHBORnYrT01keTdwK244WWp2RzM4TmhZMkp6YjY5THVrd0N4OWFt?=
 =?utf-8?B?YnpvdnRBVkczYmYvb3UwN0FhQzI1QjVseUlPL3JHQ3JYQzkwMlJmM0E5cUlJ?=
 =?utf-8?B?Yyt0R3pnMkxFZHc4bWVUMFNyRjZUM1QwRnFpc0xFM0FSMzhBd1JnWEFuNHpZ?=
 =?utf-8?B?VVI5WVNUN2tCM1N5bTdmVG16M25HQ0hZbEk3OVc1Vkl3ZmVFZDlKSlNhVS9a?=
 =?utf-8?B?SGh6TUR0MW50MlRuWHdoemE5YXptQ2FsVFJnd084NS9vN0x5bVcvTStJS01U?=
 =?utf-8?B?OE5Xek9jeHp2Q3FzUVo1VGdTVWJ4WHdnTnZ4NU14K1FqeVd3RUlqN3k2SW42?=
 =?utf-8?B?NzBTUXkyMFFsemFUN0xZUU52Qm5rU2xVUisvUWdDNENtOE9oU08yRlVuaE9k?=
 =?utf-8?B?VDZTZjkrcEN2bW0vYkpYMktkd0t4dy91bWk4ekx1TS80TXEwQ2pnSnRuS2tr?=
 =?utf-8?B?UnJob0VLY20zWUdiUEFjSlJyVG4yaFEvZnR1YWQxK2xXT3ZybVBITlR5ZFJl?=
 =?utf-8?B?M2E3Mk9xVTk5TlRVWFVFYWNRaFRGQS9wazR3dTQ4NlBOSzVkNzZQSWpFQW9Q?=
 =?utf-8?B?Y0IyYkQ2UlZ6Y2lsU3RyTWRVRy9Tb2FsbVpERmhDdDUxY3RlVkR4dGtDb1RR?=
 =?utf-8?B?QnAxOFJqVEhFdG05aExnTFFsQnU0L0dMNHBRZnlvbEFYbElPRmdOZmpRV0I4?=
 =?utf-8?B?TWRIY0Z4aUhTcFU1YWhkK0xQMExFazFqTDJDbWdURjJaTTlSbkZWVWsydzBN?=
 =?utf-8?B?TmM2c1hKYXBjbHcvN1hDUEFJc2lnaFNVQVllVi9vTmJHdm5mRE5Qdjg1ODFE?=
 =?utf-8?B?WHFoWE1mNVZ2ZFV1N2lieTRpZzdZVnM1c1Q2R0k3WlJrc1Z0N0UzL2Nwci9M?=
 =?utf-8?B?dm05ejdPNFZwRFJYYWZZc3l2aEZYVzhPWmxsZndlQ3dhd04vbDJJckd1MFlm?=
 =?utf-8?B?M2Q2K1I3bHk0ZTRrbi9MZnR3QkZrKzhQeDQ2WnZJWGI0bVNlZ3B0VXlhNDFW?=
 =?utf-8?B?VzBqSlFLZFE1YWlBN3dvTTlZR2F1VDVuQnN6WWJEVG1SbkRBazdnVE81TUt2?=
 =?utf-8?B?ajNQQ2JhTWNIcUIwQVAvb21yZEhpTkF0ZjFNaThLZkt5c3BncjdWQzRBTFFI?=
 =?utf-8?B?bndncXJGN0lqOEYzZTV0UkV2MzdITjVzcnpjc2JpVnJpWWJoZDFBVENkTHlq?=
 =?utf-8?B?YVNLRmtLek9WOG1na3FKWVlIeTdYU3lSZ04zZ1pLSlAyejgzdUF6clFla1hX?=
 =?utf-8?B?S3RqTnhSNGY0eDErQ2hNOHZpUThQRGVBd2NWOW41MUFaRC9SRTlZbTNOdCtj?=
 =?utf-8?B?eTljWjhLdlRvcll3b1VVaGx3dzRNRzUvTmJYeGo4d0toRnNqNG1MUkIzYlBs?=
 =?utf-8?B?cDNEMHd1T1gzU1RtYWI5cVFvNTFFTU1lNlJLMU53MlZYM0daajNPc3ArRXlm?=
 =?utf-8?B?VkFPb3B3K0ltRU5tcmtBYnlZM2dkdjFOOC8rbEVjMThmWGR4NWNkakxTZjhl?=
 =?utf-8?B?UlZQdW1QczhtWjg5TGh5NDRzM1NMcXNyUEZxZ29FNTdzYmFNbmVKeVI5dVNP?=
 =?utf-8?B?bmhBU3ZydHZsSFZmZnpHVkk5d2ptMVpYZThUYSs1NDg4ay9CN0VKRmJQL000?=
 =?utf-8?B?QUNrbjJGZEswbDBnZitQeTVRbW5teXBmNnU2Q2VzVG45aDNOUjVWZlJVRENN?=
 =?utf-8?B?ZEw2YnJWcWo3Zlg0Rjl5S0l6Ny9jMGl2TFY1S1J1ei85NjRZS2kwS1IyRmRr?=
 =?utf-8?B?MXlUK2JxdjM4Wm1xLzRzOXhhbDlqcGczT1ltUjM3V05wRE1PK3dqSHNlV0to?=
 =?utf-8?B?M0QrNU16WXc5VU9TaUFHNDIxQnJyc3JYNlMrQnE3RDg1aC9TVXpMbWc1UU1R?=
 =?utf-8?B?WGt1VlZxUnZhdm1pbHdqNEsrN2V3UnhJNXU3dTFHNzB1eGNNUEp2dzhnN1hL?=
 =?utf-8?B?YTE1N2FPUGJHYmp3d2RFS1c5VkJYS3N6MkpBaWNTeDlzc1NnWmNucW9DdEVl?=
 =?utf-8?B?T3dwdkUxOEFLWDM2aFhPSGVxekp0NVM1cDFTN0hkdXVHUXVUWjhJT2QrMjd5?=
 =?utf-8?B?WTk1M2l1VlVsSWt0c2p3ZStCblIyUEVpclpOQlhzU1duM3hhK3NYNlVXTHZj?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4755a5a2-9579-45d6-0775-08dde6b8408b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 04:55:19.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VT3aG2SzfzlG710VkIULtgyAxb/gr+xu89KRUCzgfixrGapwcfhsyOEhWbf+HMuFVD2eQzF1gVg+kzSobx0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8536
X-OriginatorOrg: intel.com

On 25/08/2025 15:21, Alexander Stein wrote:
> From: Matthias Schiffer <matthias.schiffer@tq-group.com>
> 
> regulator_is_supported_voltage() returns negative values on errors.
> 
> Note that this patch might result in regressions on existing boards that
> should support voltage switching, but don't have their regulators set up
> correctly.
> 
> Fixes: de5ccd2af71f ("mmc: sdhci-omap: Handle voltages to add support omap4")

It is not very clear what is being fixed nor why.

It changes from "setting a capability if there is an error" to
"not setting a capability if there is an error".  Both seem less
than ideal.

Also "might result in regressions" is really not suitable for
stable, which is probably where it will end up if it has a Fixes tag.

> Signed-off-by: Matthias Schiffer <matthias.schiffer@tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> New in v2
> 
>  drivers/mmc/host/sdhci-omap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index b5d7c1a80a92f..08d5a82b7d01b 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -949,11 +949,11 @@ static unsigned int sdhci_omap_regulator_get_caps(struct device *dev,
>  	if (IS_ERR(reg))
>  		return ~0U;
>  
> -	if (regulator_is_supported_voltage(reg, 1700000, 1950000))
> +	if (regulator_is_supported_voltage(reg, 1700000, 1950000) > 0)

Why is the error ignored?

>  		caps |= SDHCI_CAN_VDD_180;
> -	if (regulator_is_supported_voltage(reg, 2700000, 3150000))
> +	if (regulator_is_supported_voltage(reg, 2700000, 3150000) > 0)
>  		caps |= SDHCI_CAN_VDD_300;
> -	if (regulator_is_supported_voltage(reg, 3150000, 3600000))
> +	if (regulator_is_supported_voltage(reg, 3150000, 3600000) > 0)
>  		caps |= SDHCI_CAN_VDD_330;
>  
>  	regulator_put(reg);

