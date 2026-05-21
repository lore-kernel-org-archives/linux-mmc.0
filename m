Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131C377EA2;
	Thu, 21 May 2026 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380196; cv=fail; b=TSzVN11Ke5Tv8FMf8ZBKVRGP01mD7y115fKyyxh0QyMj9aho9keoosKPvlBHmlyAtw8kAPVfe18DDkt7YHNn6hMhH27nxvwBqVW4t3/JlcCq2aBatFv8DsFIM4TLM2QD/UeuRJLBKz3JPpHLRzKYkrcDar4UgTl6Xad4CAhflYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380196; c=relaxed/simple;
	bh=8F3Oh3pmrSOL+6miXz7Du4BDq0a1ds8MClRGPTlHWFA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rpAiFSq3WTTrBiJxvKykMzzswLdY+brSLcIvya45jlxe+awMOFcNv8rK53WaxC6BPUJvPz7Q2ZjDrNoP7QygQ7rlPtWP6qvSpHXpPEw4TwK2R9kFnmnHG3lwHwYLCffHyhg/IU/suqGDIj4WUkDDWaA294cYp3uWuoMjs8V3+hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wx3p1Ufy; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wx3p1Ufy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779380195; x=1810916195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8F3Oh3pmrSOL+6miXz7Du4BDq0a1ds8MClRGPTlHWFA=;
  b=Wx3p1UfyFG7vIuaEPvzfaTGpq4Okrzx1lWxrJK66lI7bveBX1ynjgSP5
   PxsyeJqAOn5Vd4wPPFBuaEDUHyisPKbUL0Wsl0EdvxdWb6YSEzckimAKR
   S3IKSMejKtWyslsY8hfjyziRgqDq2Mj4KEKtScBevkHW6KVXowVtvVtNV
   PcQld0VWe94F1EzvV7fwFqG8IqRO1NLtHpTrboWoeTmiVTyP64e+A0DY5
   6ujSwHW30aY4a4w49SaAxCeheNVbFre6K9O0/Sds3Z0qgKEHL7ytbAI7G
   Ffx5ojuxRPX1rnYyOS/8OirjQnVQh4PEyqrdPAlHqAIS3yP2mr0HWpjNx
   g==;
X-CSE-ConnectionGUID: nWSXFar8S3agO31e2rO0zA==
X-CSE-MsgGUID: a+5wPsyNQyK3zORN+zeWCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105764929"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="105764929"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:16:34 -0700
X-CSE-ConnectionGUID: 3F9hUCmyQ36QtBY0E0Mizg==
X-CSE-MsgGUID: 9ydmyxFrR/6wjrE31jxgFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="244842379"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 09:16:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:16:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 09:16:32 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 09:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyTlAPZj/hDQyKRS/wknOjIFul7gX/ilKdeAAJlqv4QJ2okEYfVp+DOLQL9AMBiiV4+fyEl/Qb++hsWBu0+S9gPNuEW4mf34vSCC0EzuOBRpfbMjzT/Vtnkov6of8HFZQVIVz8Pagg2Dg5EmQFHtqKrxANE5unMJhf5qSY8aL75te0j4hnHW2QjcnNikOHRP85vmv/ZULpIzZF6NE3QiGIIdNSRfUpqpQNXHHauJuOzP0tkblAsbVd/y2iRHuMzZ233H8H8DGxeA++sCXkr0ej841MOWBptmhlVlLkc9S/JRbdu6NQ17W0JgD1G2WZIADpcoK/YUs1Ybl4Ln8UGsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1WEF+nPzGnbb9zHDTnMzkjuGj0riwTHzUgjdslZHHE=;
 b=EhRW8qds/jeCGhsOfN2VE7dInX28U6UOWsCK3ejs6VlZMO6nJWwT89TKA25vBJi/TRCfn4qXA1GJbuZSAnHEVninImwDMTz9M4At5w6x+LebSWfqS4gUnyuNa3Bqb4ELYU3V1g4oef3250GwYqXHU08Ux8dcb4hUPjhxd35xm6lx3hSWQR0A8Y6YYplT14F5bPd/H5Bi8r/ecH6lsypbcm+T1ZgIGvU5pF69X/o8VyqFDOYoBKWMLm1qxiAO50BdeZ58pQgxXOv64M3qm3CH46tIG5BCH8q5f2/g3taNIhn6eMKbtxLJEd0Cj7L4ihXOhO/9MytaY9cFvOGAQvtYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CY5PR11MB6365.namprd11.prod.outlook.com (2603:10b6:930:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 16:16:29 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 16:16:29 +0000
Message-ID: <1acfe3e0-bd2e-4cf6-93fa-02b42bca14c3@intel.com>
Date: Thu, 21 May 2026 19:16:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] mmc: sdhci-cadence: rename V4 functions for V6
 controller groundwork
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulfh@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-7-tanmay.kathpalia@altera.com>
 <7e4300b6-c54c-4161-8af6-8fa1ce172dd1@intel.com>
 <9f8fc7a6-11ee-4b09-83e2-449f24a26b99@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <9f8fc7a6-11ee-4b09-83e2-449f24a26b99@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0165.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::6) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CY5PR11MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c18ca7-69ce-42cb-f52d-08deb75450ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: yoVV0jr9nsAcC3byVEv2waYZd14uB8/X6iFNheWYEKh6u7P3kvVeZOWD2QPOw/6l7gX2hJJoGkt6iE7LsXPoa/d3vPYCuw3g46bYGukMdAZ1fZaMLO+85bX9stMOndSxvNtzhrwGHgp1RraGkq4t70lgaTq69ql9NjXaOUnFEECHIVmMkur9WzTrAzsJt1ZaHljSDksroWysTz62zK6XALPOXlyzKdcdeBMPETaXvICG0Q2GZNJ72UbLnvwldBsOS8yXbsp8lcLMILuZozzuGKvugYP4u0ncpk4b1TbecHK2tRyiKyxoasvXdLpCTg6YRtGQzCe4obhYk5UXi92W9JY/evkJiea357k5hOmT7tNkvdQAIyxZK65YWekWS9dTszE+CpY7Iw4yOBAJx6jFB7A0tsnhzT5kx0Bu2ft294J1elNJifx35ZgxJUOLvOTdL/WmsKf3LrhFJoiFX8kHFrgS/vFgA87/RPKz2sedjPNCbfS4hZvosaMVrg2I0JfS9R7Pw1JvjkDXBDLgTKlawlNdctOpAk+EyLcXG2HRdF9t2etP2mmaSwNuifwE057R/ZoHqv/+sgFaEx9l89kx/OSpVcws9KHABjH/XZwturnwFTIVFKVwAJO26qoVIn2CkS73puV+iO2+OssgFG+WJiA+4krow6/kGHpgFQe5J0A7PNbolzXntvpeLxP6YcAR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHlDN2pJRHJ2eHhVd2ZEdWswd1lxT1BnTnZFNEl3a2hHbVpid0d4TERuQmlC?=
 =?utf-8?B?VFhUNGFmMExYT3k1YTg2V1lyelg0WFhNa2JZeCtlZ3FLM0IzdEMrSndzSjNp?=
 =?utf-8?B?Zi9NT2tkdmZiL0Nmbm9sWGtrUHZvSHc0OGpyK0lwa3plR0FiSldYWFJQUFRO?=
 =?utf-8?B?VFdtbWNNSFAzdEwrTzZXWFZTUGFoMkEzUm5BdzV0aWlHUDBOeDR6OTliQWhU?=
 =?utf-8?B?MDQvZmFtTXlqL3RBWkxWOE9NVGdodldoTW4rV0xNaU1zdnE2QWdhb2JhVlZh?=
 =?utf-8?B?Lzh6MlNucUxLR0N2enJTM2FxWWlpNnFIQ2o4bnZtZUFKcEphQWhPMk1RTGk5?=
 =?utf-8?B?L1JoZ3BQaE5XeUx3cXlNYlBVR0dVUWpTTGpheEVSUVNCSEkydGJqQVZpSENI?=
 =?utf-8?B?dFZPdzVoUjdoajROd0hMVkRPcWdRdVV5WXBZdXZJbG1jUUlqa0l6cUVwL1ln?=
 =?utf-8?B?ZUw3VzNRc0FseUVsQ2dHQWJsOHJ3T0FyL1hHUmxFOVg0ZnNTS3R3dnRuRFBS?=
 =?utf-8?B?YjRkZmpXWFI3NWFOSDFzVG1zRFpETi8zblZ2MmVXRUQ3b1J3Z010TFV3WEdM?=
 =?utf-8?B?OS8wMlRQdkVSSW1xQkJEMGdsKzIrSmNScUlBZUlhWjhTemNXNU5qbXZKdUw0?=
 =?utf-8?B?VmM3dElIdWxPYlZnZjhwWWdHb1l3NDdZMmNwZDRuY29veGNXMFNIaFM5OXdI?=
 =?utf-8?B?dmMrSVVjaFZhTG1saVYyNkQwcXFFSjUwMzRrbmluK0poaUdLYytaaFRPMUhK?=
 =?utf-8?B?NVd5YUQ1Y1lMa2F3ZmdGdlZXQzdCUmRSNVFzM3grRWpoUmN2UHhlTGo1dUtr?=
 =?utf-8?B?SDZCRGVVQjFSeWNDWkdFam5jaVZHYUhQMTIrMFFSbnlpUW4rQ2lSTUJSVS81?=
 =?utf-8?B?MTRHRHlXSVBrK2Y5SXhzVllld28yVVBGUWY0ZGRRUTU4cHAyVjZQeGoxU2xz?=
 =?utf-8?B?N3EwRm1LUnBKR2ZuSUdRS1hlblpMNnh5d1lWZWU4ZndsZHMvd3RCdEphQnRW?=
 =?utf-8?B?RWhjUHVHckpiaDZwdVAzU21La21tQVRmRUVnWEgwMGphTFZnNE9oamNLbGF0?=
 =?utf-8?B?cG44OWlVNloyek5tclJwZDEydzV2alNnZ3JDcUtYR0c5SnMwVG1GWHIva3BI?=
 =?utf-8?B?aU5PQ3NDdm9ETTUzWWh3ckt6aWhsRG5pMS9zWk9QZ0w0Q3VmYng0VlJ1eTlC?=
 =?utf-8?B?V2xxVlRtNUJ5S2hwK0hDNzdydlhucHVYankyREUrMi9aWVgvOGJ1QjNkN3Vt?=
 =?utf-8?B?UHRLb05Wc0tqMlVyZTB5ekxweWp0bHEvc1JCSTJFYytlbTNybXAxNjVaVDRy?=
 =?utf-8?B?K2Z0V1ZQa2MwWFlTWnJsWHQ1d3VxVVdpNmNYeDhrOHJrQVNoYVdkUzNjc2lE?=
 =?utf-8?B?MVhvdkNkZ2piN0lPME9heDJrd0ptQnExVGhBR2pkNnUrTWlmaGVWYU1ibHBn?=
 =?utf-8?B?bHlzZVFEZnRhT2szVURuNGpwNG1YU2sxaHBmWE1TUTRCUGgrY3Q3d3ZqR3lv?=
 =?utf-8?B?L3k5VktiRSs3M2d3SnI5Y2VjZVJyVlM0SVR3RHRWZ2lZblRPdittd2pCK3Zy?=
 =?utf-8?B?a0pHWkFiZmN2bDhLN0xDVjhXNzBoVnAzWlR2dVpURDhsdk9WMWZZYy9kWEMv?=
 =?utf-8?B?TCtjY0pTeWRxVGtNamMvQ3hEM09hQzIzbkEyK1IwM21HU2E1UFZCYkFqMDdh?=
 =?utf-8?B?cTNqTnJmek5BbEpvZ0wyTkhZOGpScVRIL3Y1NHJMTEVLeHl5aUtBSU90RmZP?=
 =?utf-8?B?VlZmL29ueW10cnF3VnJVaFZnNVNmSHdkZzIvQUFSMkxVNW4vS2FSTVhrWitn?=
 =?utf-8?B?Yk1sTlpvZ3hGTFBqS1Z6V2wwamFaeWFIb0Iwcnc2Q21vVzJlbkVSZlNiZWNQ?=
 =?utf-8?B?Q2R4NmlPVmZlK2NETUY5Szl3ZUtxcm5XQnRNNUF0Tk5uaVNkUlAwY011UGlj?=
 =?utf-8?B?RG0xcjE3QXdDaWN4UUpFa0pOdTRJS1N2UVdsQnFZUHo5U3RaYnQxeG1hM0hV?=
 =?utf-8?B?ZG5FVDdydFJtUUFZK3RxdTBoeFpzSlA0UER2NXcybXlacnBGVldaWU5vQXhL?=
 =?utf-8?B?b2FvZUw1NVFpYnROZGQzWStjdnpxNTN2akpETFAwV2Zia3QwMUNFcVhySG1J?=
 =?utf-8?B?UG1JWHNwOU1aUnpBY3FqbmxPeUdRQUpCN0R0UEEvUHBwdDQ0SjBNTXNpQkVm?=
 =?utf-8?B?WWJTVGJsVmJWR3piVlNwVml3TUFycmRrdWtzQnRyeUdLWWRrNnpOdW9wWGVn?=
 =?utf-8?B?Vm5CUDdKUkpHRjNMdzhCalpiSStPSWp2MmdxS3luMm5jQ3JGRk1vQ2NiNFor?=
 =?utf-8?B?VWgvQzBZc3ZuNEdST0N4aE5POTY3TmZiNVpWa29zY0FRSWlKaWdDMmg1SEdr?=
 =?utf-8?Q?v+Ix8gLlyZTK7PFk=3D?=
X-Exchange-RoutingPolicyChecked: a4fmjqUboJc9IXQYtTmDmwH2JSsZnSB6vPIeBH7ZOH/leCBvNR/rHoD11d0qn8I6Bl6i0rG4KreZ76D6ozaB4LaNI5xxWJxILC71ABdG+pkNd/BjMjsS/zu3ZjwFzGOPyBKqXzAygovp4iOiMRmtw2HT3Oj/1ODYcvCN3Ojvp5pnSUU7u2MJ0mhJlyk8TdWMiQ+P5dya6lStaLSduE5ysRNI/jbp+S9E/n0b2TIPd9G9gGI++zpSDB0DCAVjOq8noYfAiEMkI7pOUp/+Mu1aMnA1JgxAr2hCvyLSzMf89x6Rt54yn7En8ffy/5MMTd8NYr6pJOavm9xz7tqDpXvVBA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c18ca7-69ce-42cb-f52d-08deb75450ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 16:16:29.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wtFDpe1nU6EfrcqROlpfq0r5vJgKx7kjwJd3uvNFWr5AnvpCBS3sBNH2n2k+j/Zygz3tW/mqvSoDAd9+V9fPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6365
X-OriginatorOrg: intel.com

On 21/05/2026 18:53, Kathpalia, Tanmay wrote:
> Hi Adrian,
> 
> On 5/19/2026 8:59 PM, Adrian Hunter wrote:
>> On 11/05/2026 23:21, Tanmay Kathpalia wrote:
>>> PHY-related functions and data structures in the driver are not
>>> explicitly scoped to the SD4HC (V4) controller, making it unclear
>>> which code is shared and which is version-specific.
>>>
>>> Rename them with a "cdns4" prefix to distinguish SD4HC-specific
>>> implementation from the shared driver core, and to avoid naming
>>> conflicts when SD6HC (V6) support is introduced.
>>>
>>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> One minor comment below
> 
> Thanks for reviewing.
> 
>>
>>> ---
>>>   drivers/mmc/host/sdhci-cadence.c | 74 ++++++++++++++++----------------
>>>   1 file changed, 37 insertions(+), 37 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
>>> index 435603c8c00b..47690a52a221 100644
>>> --- a/drivers/mmc/host/sdhci-cadence.c
>>> +++ b/drivers/mmc/host/sdhci-cadence.c
>>> @@ -78,7 +78,7 @@
>>>    */
>>>   #define SDHCI_CDNS_MAX_TUNING_LOOP    40
>>>   -struct sdhci_cdns_phy_param {
>>> +struct sdhci_cdns4_phy_param {
>>>       u8 addr;
>>>       u8 data;
>>>   };
>>> @@ -91,10 +91,10 @@ struct sdhci_cdns_priv {
>>>       void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>>>       struct reset_control *rst_hw;
>>>       unsigned int nr_phy_params;
>>> -    struct sdhci_cdns_phy_param phy_params[];
>>> +    struct sdhci_cdns4_phy_param phy_params[];
>>>   };
>>>   -struct sdhci_cdns_phy_cfg {
>>> +struct sdhci_cdns4_phy_cfg {
>>>       const char *property;
>>>       u8 addr;
>>>   };
>>> @@ -104,7 +104,7 @@ struct sdhci_cdns_drv_data {
>>>       const struct sdhci_pltfm_data pltfm_data;
>>>   };
>>>   -static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
>>> +static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
>>>       { "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>>>       { "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
>>>       { "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
>>> @@ -124,8 +124,8 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
>>>       writel(val, reg);
>>>   }
>>>   -static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>>> -                    u8 addr, u8 data)
>>> +static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv,
>>> +                     u8 addr, u8 data)
>>>   {
>>>       void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>>>       u32 tmp;
>>> @@ -156,44 +156,44 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>>>       return ret;
>>>   }
>>>   -static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
>>> +static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
>>>   {
>>>       unsigned int count = 0;
>>>       int i;
>>>   -    for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
>>> -        if (of_property_present(np, sdhci_cdns_phy_cfgs[i].property))
>>> +    for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
>>> +        if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].property))
>>>               count++;
>>>         return count;
>>>   }
>>>   -static void sdhci_cdns_phy_param_parse(struct device_node *np,
>>> -                       struct sdhci_cdns_priv *priv)
>>> +static void sdhci_cdns4_phy_param_parse(struct device_node *np,
>>> +                    struct sdhci_cdns_priv *priv)
>>>   {
>>> -    struct sdhci_cdns_phy_param *p = priv->phy_params;
>>> +    struct sdhci_cdns4_phy_param *p = priv->phy_params;
>>>       u32 val;
>>>       int ret, i;
>>>   -    for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
>>> -        ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
>>> +    for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
>>> +        ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property,
>>>                          &val);
>>>           if (ret)
>>>               continue;
>>>   -        p->addr = sdhci_cdns_phy_cfgs[i].addr;
>>> +        p->addr = sdhci_cdns4_phy_cfgs[i].addr;
>>>           p->data = val;
>>>           p++;
>>>       }
>>>   }
>>>   -static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
>>> +static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>>>   {
>>>       int ret, i;
>>>         for (i = 0; i < priv->nr_phy_params; i++) {
>>> -        ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
>>> -                           priv->phy_params[i].data);
>>> +        ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
>>> +                        priv->phy_params[i].data);
>>>           if (ret)
>>>               return ret;
>>>       }
>>> @@ -201,7 +201,7 @@ static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
>>>       return 0;
>>>   }
>>>   -static void *sdhci_cdns_priv(struct sdhci_host *host)
>>> +static void *sdhci_cdns_get_priv(struct sdhci_host *host)
>> Why rename this?  It seems to just create churn.
> 
> The reason was to resolve a name collision: in the original code
> both the data structure and the accessor function were named
> sdhci_cdns_priv, which can reduce readability. Renaming the
> accessor to sdhci_cdns_get_priv() makes the intent clearer and
> avoids this ambiguity.
> If you would prefer to keep the original name and avoid the churn,
> I will revert this rename in v2.

Yes please

> 
>>
>>>   {
>>>       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>   @@ -238,7 +238,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
>>>     static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
>>>   {
>>> -    struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>>> +    struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>>       void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
>>>       u32 tmp;
>>>       int i, ret;
>>> @@ -354,7 +354,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
>>>   static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>>>                        unsigned int timing)
>>>   {
>>> -    struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>>> +    struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>>       u32 mode;
>>>         switch (timing) {
>>> @@ -407,12 +407,12 @@ static void elba_priv_writel(struct sdhci_cdns_priv *priv, u32 val,
>>>     static void elba_write_l(struct sdhci_host *host, u32 val, int reg)
>>>   {
>>> -    elba_priv_writel(sdhci_cdns_priv(host), val, host->ioaddr + reg);
>>> +    elba_priv_writel(sdhci_cdns_get_priv(host), val, host->ioaddr + reg);
>>>   }
>>>     static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
>>>   {
>>> -    struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>>> +    struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>>       u32 shift = reg & GENMASK(1, 0);
>>>       unsigned long flags;
>>>       u32 byte_enables;
>>> @@ -426,7 +426,7 @@ static void elba_write_w(struct sdhci_host *host, u16 val, int reg)
>>>     static void elba_write_b(struct sdhci_host *host, u8 val, int reg)
>>>   {
>>> -    struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>>> +    struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>>       u32 shift = reg & GENMASK(1, 0);
>>>       unsigned long flags;
>>>       u32 byte_enables;
>>> @@ -452,7 +452,7 @@ static const struct sdhci_ops sdhci_elba_ops = {
>>>   static int elba_drv_init(struct platform_device *pdev)
>>>   {
>>>       struct sdhci_host *host = platform_get_drvdata(pdev);
>>> -    struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>>> +    struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>>       void __iomem *ioaddr;
>>>         host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA;
>>> @@ -470,7 +470,7 @@ static int elba_drv_init(struct platform_device *pdev)
>>>       return 0;
>>>   }
>>>   -static const struct sdhci_ops sdhci_cdns_ops = {
>>> +static const struct sdhci_ops sdhci_cdns4_ops = {
>>>       .set_clock = sdhci_set_clock,
>>>       .get_timeout_clock = sdhci_cdns_get_timeout_clock,
>>>       .set_bus_width = sdhci_set_bus_width,
>>> @@ -481,7 +481,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>>>     static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>>>       .pltfm_data = {
>>> -        .ops = &sdhci_cdns_ops,
>>> +        .ops = &sdhci_cdns4_ops,
>>>           .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>>       },
>>>   };
>>> @@ -495,14 +495,14 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
>>>     static const struct sdhci_cdns_drv_data sdhci_eyeq_drv_data = {
>>>       .pltfm_data = {
>>> -        .ops = &sdhci_cdns_ops,
>>> +        .ops = &sdhci_cdns4_ops,
>>>           .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>>       },
>>>   };
>>>   -static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
>>> +static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>>>       .pltfm_data = {
>>> -        .ops = &sdhci_cdns_ops,
>>> +        .ops = &sdhci_cdns4_ops,
>>>       },
>>>   };
>>>   @@ -510,7 +510,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>>>                            struct mmc_ios *ios)
>>>   {
>>>       struct sdhci_host *host = mmc_priv(mmc);
>>> -    struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>>> +    struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>>       u32 mode;
>>>         priv->enhanced_strobe = ios->enhanced_strobe;
>>> @@ -529,7 +529,7 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
>>>   static void sdhci_cdns_mmc_hw_reset(struct mmc_host *mmc)
>>>   {
>>>       struct sdhci_host *host = mmc_priv(mmc);
>>> -    struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
>>> +    struct sdhci_cdns_priv *priv = sdhci_cdns_get_priv(host);
>>>         dev_dbg(mmc_dev(host->mmc), "emmc hardware reset\n");
>>>   @@ -560,9 +560,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>>         data = of_device_get_match_data(dev);
>>>       if (!data)
>>> -        data = &sdhci_cdns_drv_data;
>>> +        data = &sdhci_cdns4_drv_data;
>>>   -    nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
>>> +    nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
>>>       host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>>>                   struct_size(priv, phy_params, nr_phy_params));
>>>       if (IS_ERR(host))
>>> @@ -593,9 +593,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>>>       if (ret)
>>>           return ret;
>>>   -    sdhci_cdns_phy_param_parse(dev->of_node, priv);
>>> +    sdhci_cdns4_phy_param_parse(dev->of_node, priv);
>>>   -    ret = sdhci_cdns_phy_init(priv);
>>> +    ret = sdhci_cdns4_phy_init(priv);
>>>       if (ret)
>>>           return ret;
>>>   @@ -622,7 +622,7 @@ static int sdhci_cdns_resume(struct device *dev)
>>>       if (ret)
>>>           return ret;
>>>   -    ret = sdhci_cdns_phy_init(priv);
>>> +    ret = sdhci_cdns4_phy_init(priv);
>>>       if (ret)
>>>           goto disable_clk;
>>>   

