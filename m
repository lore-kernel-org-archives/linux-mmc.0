Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF4265CB2;
	Fri, 24 Oct 2025 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761287813; cv=fail; b=KMhMs+mFj0bqErF8a2j2en5Pf2HXzpAF8bPINwMgO+u9+iIDBuYxxw+w8mqiW9RPXa5ioJQbE3xpdH6Tel9DOR7u8nOBFfIurK2JEBVv64wKglf7BJGt21pbgITrkLtXpfF84JmExE04WKT/3DKGuyaSjYjO9C9kuiG638+O1f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761287813; c=relaxed/simple;
	bh=cIKDMWckaJIsoR9wptYG+I6svAYFOxLPACcUzVmZmDk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E41rdGwFFU768/2vm4NkUzcY5CoffUrNognX4rIb7PAy97k1Z5odvvOsm8ZKZznAZ7kdZiuZcTmHfBzzxodcXaIHpJlw4AQZk7aAhS9ERi3KKNJX8ZoNLYcQG9LWXRiZH7IP0e8Om6kKBpdoDk/1s3yCPx4gl+HF052ZVBqqSt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dANSxK64; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dANSxK64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761287812; x=1792823812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cIKDMWckaJIsoR9wptYG+I6svAYFOxLPACcUzVmZmDk=;
  b=dANSxK64eifi+TTbA7TsabExOlFEQOM5H0aJMzWHMshDY2DCGEU5+7Hh
   I6akTJhYQNHKg4VU7E0oN6tppn1yO924oKpWu9kS4VHEttf67+L+LinUn
   a/+iBDTKx31+idN0DprMpaCO5c8I15VT3bQ72TupN8qsrEmeEY3iBdEH1
   pF1STxA1hEKHVCGOHTh7cLtOsHyMkNpR8P4NmJ7szgPo15lQOeCvjS17H
   L0H2f0EFjXd1qlcauaGgkibv8t0PnGAnryuEq0FtYiNpsUDfNwWJo1FLI
   xWK363ox6UwrIPhtcH9gh4aN/L0zaMA6Vk2Zet5d0sgpbMK3E2bjVECki
   A==;
X-CSE-ConnectionGUID: ekj5YKTJReWqCfbv2Lx1Mg==
X-CSE-MsgGUID: YhlpRisIQiSdQDFTwzWlWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74812116"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="74812116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:36:51 -0700
X-CSE-ConnectionGUID: OiEyC+uiTseF+PYXbqhBfw==
X-CSE-MsgGUID: li2fVNKyS8OasoKNvrONiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="188648481"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 23:36:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:36:50 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 23:36:50 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:36:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZvNOzkix3aRnvb+PQYVSDHtWzOwg8RSkgIXUDF0ZFDU3qOGabw55udQV8ElX098X8SvdlO0ikaZkZdt3m7EZxoyWa6hR7xe/lfy+bm4Ax8qY5MFAVigRaP8CqkLrqEv5Z6YmF2D7GQ8IzvWYdrZTtm2FleuMZ+Rigr8bNFBMfK2+nPs6NEQpOHwdarmeg6/nzZhc5r1QHOcMEaWvKMbLaPnMgZpmdby1XsOELtSbs7qee7GpMj2xfjYF8wC1ok/6qibKysYR7+Do4WwJ+BXJu3Jq1AvKKGHG+8wZu4qp+VremEKxuA08sArB646cS28JLbMRki2JNu03m7M/2yw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6t6uO0BmyTBMSaYMrnkdZPubvIFR5zYXpC1dlu4ruk=;
 b=m/pQa0M5M7tQ0plGhdRs9BLdYYweK3cdBGdnkI+1xD+kX3HZlyrwyMdpjMQ4ibq3M8/S2ElqSAyfDFHNQctTPZkKY/dTNWDoyMkpS3XacfFh+QLAi75R1WWt6XlfWApDdo8ZPpIOW6o8iL+ijt/KOVK80FYWpB9A0xvfbqKZKt1/owpC10aW3VSjKyjftBlNz5zqcJ3xjnoFdZvxuFKjBTkZZ/P4gXuaHjmt9It3DKgJSeByCWWNSYOAL0fiNlTPnvICUVTPJbNYmGRWQhc0w8z4Gz8/EE/uDV/6bUB4EZYTqGdTWtBdohl567ctzUrJoaJ24QmuT7KCkmlTghHRxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Fri, 24 Oct
 2025 06:36:42 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:36:36 +0000
Message-ID: <add11b65-c525-4fb7-a70d-9a1f2e18272f@intel.com>
Date: Fri, 24 Oct 2025 09:36:30 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin
 EIC7700
To: =?UTF-8?B?5L2V5qyi?= <hehuan1@eswincomputing.com>,
	<ulf.hansson@linaro.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<jszhang@kernel.org>, <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>,
	<luyulin@eswincomputing.com>, <dongxuyang@eswincomputing.com>,
	<zhangsenchuan@eswincomputing.com>, <weishangjuan@eswincomputing.com>,
	<lizhi2@eswincomputing.com>, <caohang@eswincomputing.com>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
 <20251019115316.337-1-hehuan1@eswincomputing.com>
 <9b744e60-a0d7-48c7-b1fb-66df91b839e5@intel.com>
 <4dddefe2.63d.19a143ad883.Coremail.hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <4dddefe2.63d.19a143ad883.Coremail.hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW4PR11MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: f935cf2a-51d7-4b8f-e0a4-08de12c7add2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFUyWkxORWN1OEVTWkVWYXd6Ri9CVi9QUDJzdjBHM3ZxTGJzRWJRZ2VPaVZo?=
 =?utf-8?B?eVhVRTdGZkI5bkZ1N3FRODRsNEMyZE1DY2s5UFpreC9FN2REUWloTEQ2NmFX?=
 =?utf-8?B?UWc2ZEl5T1lIUk5OcjFQVGlnTm1HVEJSUjhUNjcrZ0FrSVlJcmNYekZaRFhV?=
 =?utf-8?B?bStWQVJhcXI1SzdFdDJIM1cwN2lrd28rUDZqUGZoZEdCeHNGVk53NnFLWGhh?=
 =?utf-8?B?NE9aUlovemo0RDEwd3ZwdFNSaFF3YW9IbXpjd3hpeWRiMkQwQWg1VTdaOEdL?=
 =?utf-8?B?VTMzVW1PQ0RuL1Fvckh5OFRhRGN3aisrbnYyRGlqMWNPSjM2MS9RMjNhTlVK?=
 =?utf-8?B?T1NHM1gySnlRZjlqVE84RFZieVRCaHJOeTZ4QWFxdDFiNmlCZThnTWZOZk9V?=
 =?utf-8?B?aWtQazhBSW81OEhyYUtLMTNwV0J2dHl0OSt6aytqT3NJalBEME4vQzNJNFk0?=
 =?utf-8?B?YjVOcjA4S3N5S2pHZS9OSWxvMkh4MXdzREFJNHJiVHRtRFFCeFpZbVdIL1Q2?=
 =?utf-8?B?elJReVJOSklUUmZrbW50Sk9rclVyRDVWL2YzY1R4eDI5M1VCWkJOYmUwTWRU?=
 =?utf-8?B?ZFc5ZEtyWll4RUdBRjM0ZnZoU0VXNkh1a0xuRlpqb2xLK2U3TGEyVlhjNEF3?=
 =?utf-8?B?cmh2Snh3QjAwZW9wVDZKZTNzcGlST1FOTlVLbDJyNzdVVnhrWHBMNHcwTEpw?=
 =?utf-8?B?Z1FuZ0xKc1dtQWRmV1djb241RWJXVHBmY1dwcncyYlNSdTFZUmpNK05jZVJa?=
 =?utf-8?B?S01qUjdJc2c0M0JpbGJ2RU5YekowbC9iN1VNUVp2VUsxUG00NkN0L0cvSmNQ?=
 =?utf-8?B?dFI0bzhQdTA0MVZyaDVockVnRkhLeEFMMXY4dGw3L2dpaFBOSUtLOEpsQVJW?=
 =?utf-8?B?eGZYM0t0cklyQ1c4RGVuT0NiZnkxK2ttbnNrVUswNzA3TUltOStrZkpoRnE3?=
 =?utf-8?B?bS8xd2pLY1FXYTZiT1lMdXJobDE5V0hvWUZvM01FcVN4Q2ZIeThPUlN5ZTh1?=
 =?utf-8?B?Y0NrZkd0OVJzN2g0NnVqZ2EzU0x5aEZJeGgzcnZQSEdEa00vQmd2WkcwL3FY?=
 =?utf-8?B?ZHoxNVpSVFhtRjRMYkNFWGNTSHMzbG1XaUo2NXVOczZNUmFDdENLN3RpN2lo?=
 =?utf-8?B?RHRRS014amY3UEdTVjNYUVNWVUU2RXFXNlNBNFRwMkZPNUluYXJBTjU3ZFdm?=
 =?utf-8?B?Mkw3QklnZ2hhOVFjVlAyd05rU2t4MWwrMXNVQlUrYm0wd25ta0hkWG5qbTZ6?=
 =?utf-8?B?TzhFKzI3Mk52bGNvZG4ycHFhWjBpSDVnYXpCd01Jem9jMW9KN3VIWTlqVldN?=
 =?utf-8?B?NWY5Y3FZVmkwZEh2dTFVZzVHV0c0K0pOTEJqZ0NsSEh1ZmU2MEVrMmJCbjNB?=
 =?utf-8?B?R3NDRG9OcGYvQWI3L25raDhvWDZtNkVadnJwTlVHRjlIcGptbk1KNG52N3dO?=
 =?utf-8?B?L2IwaUdqZGRyMk0yTTBzV1hkR2VTa0ZVNnJVcVpnYXZ0VlpMWHF3ZnY4RHJL?=
 =?utf-8?B?SXY2THZNQWtuSzUwZDl4aTRQWTVleHpHQmpabzk4ZWpqREZVTnF6alA2a2sv?=
 =?utf-8?B?MDEyR2c5cHBYTCtkTnFqTzh4VTNLZXViMHpENTlITExQUUhZWWdTVzgwWXhU?=
 =?utf-8?B?MHBoS2VKZUFTelY4cFAzSnFFc2c1RmVmWG9vUGtZbi9mMHNkRHkxMVVQS2gy?=
 =?utf-8?B?WkxqSzhXaGdDYzdWTVN2WWJnQXpkajJYMjM3NFhVYjU2bUh6RGxHZEJNQ2hY?=
 =?utf-8?B?TFFCV29tNzYxNnNoZG5vYngrTlJsK2UrRkJRbG9nUDQ0QVlsQW8yMzM4SG9X?=
 =?utf-8?B?aXliQ2ZKbXJmNUd0VHRvMEh2TUVmMlNTYnFNdlJFYVVaUzA1WTZ4b21QTzdX?=
 =?utf-8?B?VGRoVWMxdy9JTUdYSGp4ZE9NbTN2UVhZZjc0VngrUWZYYkpoUUJCMG9KeUll?=
 =?utf-8?B?cjZsQXVDOC94bzBxVFpDR3RvemRqTis2am9Oei9oL2N3RExKVUxwa1ZTdWFu?=
 =?utf-8?B?TjNuTHdlcXJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVZudHlCQVd4bE9LYm1nbTF6NmJ2QWZvVFo2UzhKRlBkZVp1MFBIVEtFdTFK?=
 =?utf-8?B?cEVNMHgzUnk1ay9nb0ZNbFE3MHlDQ0hUZUsybTd2cGk2NCt6d3VsaVFFRnJn?=
 =?utf-8?B?TFBOTy9EQTBWMjRUbnk1RGYwZi82eis5Zi9nUGZUdzRxcU55SWIxbTNiUlZH?=
 =?utf-8?B?dnljWHVWTFZlYzhTeXpsb01mcFMxcjJheDJWeHpBS1pvSGJOMVk4NmR1MGV0?=
 =?utf-8?B?MEN6VGJQaGpVZlZIQVlzdnZiUWpuU2g5SzZlam9hMS9lTHVVai9lazZiTmR1?=
 =?utf-8?B?SDNTZVE3Qy9OdXkrejYzUGhMajJBZWtlbkt1TkM3R0lnUnVBU2YydjJiSUd3?=
 =?utf-8?B?NUhUQkhhTk9GdG80ZTM2d050T0lvYlhuaTlrbWNPdDB6UXhnYUpDRUpEMzRE?=
 =?utf-8?B?TGhBdGc2WmZSY1RYaENrV1dNNEJkYStRbS93U0lDMXhwK1RETkdEbkt6T1Vq?=
 =?utf-8?B?K3dXSy9xSnZsdjlYQ1M0Tm9yd25Rb2tEbzFnMXJxZFdXRHZJYk8ycSt0TCtC?=
 =?utf-8?B?eG1IeTVjQnBlNlpiV3Z5N0R5Q2JzYVFzMVRONDRWdzhML0ljM1BBRlBSTC83?=
 =?utf-8?B?ejVTTEgyakdKamNDeSszMDA4VFE5bkJKZnlnMWNhN2w5bmNieXBKNTQ3dWQr?=
 =?utf-8?B?NUJFbTNpbU1OQTJ6ZW1qTGhDVUFsT0RTUkd3amZONUxEdVhBbTZzQnlRTWU4?=
 =?utf-8?B?RjVDYWh3QnZjSnczN2VFOURBREVqMjlWTlpmeEpUdC9GbTloVVB0T2lnVG82?=
 =?utf-8?B?V3ZuRGU1S2ZSL2xBMFVrcldYMHMyOEdxUzN4Q2RGT25SS1ZPNzV4Rkw2VmE1?=
 =?utf-8?B?elYzc3VmY3V5SS9qYm9HOHBhS2N0TjYwUStZemFIakNRRE9xdUhZMkNDdVUv?=
 =?utf-8?B?Z0NVRTh5bjlhTE5vdkEzN25LendRVkdxWlB5MlZwUGJiSkk0cnRaSmQycHlR?=
 =?utf-8?B?Qm1xTHhxLzUwaUhsK0RXTE80NktSWWJ3bnNIWUl0T21WSlEyYXdnYkVSMDAr?=
 =?utf-8?B?Y01tWFBoRVlLZkV3NlJ5UkJPOEJ4bFU4NWdwQTBjcUVicGtaMmdqYTlhTVc0?=
 =?utf-8?B?dWQ1OHRtUjJHMm0xWHJOTStxVzJvL3ExRDFxN04yZDR1aWU5UnI2ekI3bVIy?=
 =?utf-8?B?RUM5aWxUaUtkOUxUWDJSZU5mVkN3TVBkdjJ1SlRuRWN0b0RvK0ovNkhxOEFJ?=
 =?utf-8?B?REpxOC9qNWkwQ0pWUUxqQWF0WnI4cHorR0hCQmU1T2UrdGcyZHNsY3E5R25S?=
 =?utf-8?B?Zmt4WVlEZVg2WXNzL2Y5VCtwTlZ1VHlUR1pTczZnM2xiZzgzOE1wdWRVcEtu?=
 =?utf-8?B?aDN2VXU3UHRJbEc4MHBKZ3dKV2xha0prZ2ZvSzJmV0tBVzc5cnNmK0xVcHFm?=
 =?utf-8?B?SVJOMVh3cmpyL0hVNmRmWXl3N3BGalcxVUxyaGxVcjA0STMvWE5MNGp1eGxr?=
 =?utf-8?B?RERqaThNdE40YWYvNTk4R21TTm9aOWtyU3lERVZhK3JyeVZTZWl1Tnluem9H?=
 =?utf-8?B?SDRydkFYYWpWNWlZS1hWTHNIWmJ3dU5VTVc3dmpVaWgya3liTXZyKy8vZjRQ?=
 =?utf-8?B?a2w0aGViaGE5R1BlekxkNDllU1BDa2wzSEZZYnJzYVc3aUxNdUpSVW5RZS8y?=
 =?utf-8?B?cUJaQW1VNm13WGRKY2Z6Ym5yK3dwYXN2MDNybjVBakpXQ0NXL0FLSHVOOVl2?=
 =?utf-8?B?NldWL0FxRVVRSHNaUXpzdndNazBHanNNSmlJMXFQdXZkbmQ0d0dXcEVMM3Vz?=
 =?utf-8?B?a1E4bDM3UlNEVmdyZ3JjcERQYnlFNEdiVXk1TUt2N3FKUkF6cGpSU1dsVUhk?=
 =?utf-8?B?K1N3N1lXc2VrdlR5T2VGSmJZS3d1bldNSE5ubWgrb1AwQ1JzSXdFUUpZTDlw?=
 =?utf-8?B?UDM4T1VIWER4TjNTNXhHM2x5QzJpcmZHZDhlV0xMMm83bXFSTDdLTDh1MDl5?=
 =?utf-8?B?Tm1kSnVnYlpOL0NCUVU3d0hzNTU4V09GSUxtYVNrcktYaVU1ejNJSXUwM2t4?=
 =?utf-8?B?YnJhNlB6eGU5YlkzS0VhUUdFZDV5MWZrczdLU09mRnBlblhVMVB4TDFweGxD?=
 =?utf-8?B?Qk9aeEk5SjRWenNCSG9RL0QrQzBuNWNTcS9TVi9weXVyQXVqdGtYcGhpQVQ5?=
 =?utf-8?B?SnQ2eVFJZHlDazVxSEhUVnE1L0FWZGxCK3RJNFFFN1RiUi9HNVRCazJmdXpv?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f935cf2a-51d7-4b8f-e0a4-08de12c7add2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:36:36.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fBHv4Fi6Ot7p9zBkf9xb5uJmDQlUEo43Ymns5bmefrKViubTTGgAr2V7Jz6AjVpHdieGsHGWykAOKYJBA7NlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5824
X-OriginatorOrg: intel.com

On 24/10/2025 06:19, 何欢 wrote:
> Hi Adrian,
> 
> Thank you very much for your Acked-by and the review!
> 
>> On 19/10/2025 14:53, hehuan1@eswincomputing.com wrote:
>>> From: Huan He <hehuan1@eswincomputing.com>
>>>
>>> Add support for the mmc controller in the Eswin EIC7700 with the new
>>> compatible "eswin,eic7700-dwcmshc". Implement custom sdhci_ops for
>>> set_clock, reset, set_uhs_signaling, platform_execute_tuning.
>>>
>>> Signed-off-by: Huan He <hehuan1@eswincomputing.com>
>>
>> Noting that the dt-bindings patch still seems to have issues,
>> for this patch, anyway:
>>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> I recieved an dt_binding_check error report:
> https://lore.kernel.org/all/176096011380.22917.1988679321096076522.robh@kernel.org/
> 
> It seems the error has nothing to do with MMC, but is related to the
> Ethernet binding (eswin,eic7700-eth.yaml), that was pushed by us and
> applied recently, link:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=888bd0eca93c
> 
> We're fixing this issue for the Ethernet. The Ethernet patch with
> this bug fix will be sent out later.
That seems OK, but it is up to Ulf now.

