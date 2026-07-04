Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616234389C;
	Sat,  4 Jul 2026 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783163866; cv=fail; b=bAb+8KYfXW1RXygNHyO8xS9CYjwAYmFNxfr3MF+aLEPWx7Ug9yZgKxa3F889iURMqoEpee0JdMoss0+FFz6K6oFXdZVDUbYVUFciUqiiRVLtUUQIpVcfGIQFHYYpWXgBBQCjtQ/mX5wdlBSOUZd3Vb3M41WdQlvUvrF/C7R7hSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783163866; c=relaxed/simple;
	bh=BRHgrhsrS3Tki/DrL5GiYFhhDLU1xsd3XMZEWL7NzJs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VhvPAMaxtwLaE5UFxg9b44jNZ5IdGgHSBeOG6w7FL7nqmQoqG6kMOFPQhoe29W4lLZJQesj4iTzNZ4t2Qzzq160WMBmb7bF5MgvIlIYucPN2jMGsg0JQPFZp4KmOQdf/OHHTLEWrbyZUIetmiRaWrrc7SXsOjpgKJKh0s/XLRb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YHcZWjik; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YHcZWjik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783163865; x=1814699865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BRHgrhsrS3Tki/DrL5GiYFhhDLU1xsd3XMZEWL7NzJs=;
  b=YHcZWjikvJj2M9O3HCPhHNJDysgGhUXyWix3ntWqaLNMeR4n/Gm9IMQF
   bP9fvj0a1H6xpggL1S4Ozr/I0PvBaXqKY9WVvw+IIkjivV/w1qC53Cx/7
   CQ49j0z8hLYXWhf8sf+7Ej0TEzcLp0x6E6/G1dKcJ+UepEn9Ft8iZjAXG
   J3eAXhSAumMCUSMMYVpj9c22ov2V7Z3+d+AexeIDRuYQgvHOINDGSqO7U
   CmrJ2mHvnjye2Lfq4jW++5xODczKtWVx0Tp+Dd6U8GE0lQzthcpZ6iIJw
   4zL4YfaI5XTXfJIpqlH1pQQ5u4Us75JEMHDS+bqwN3gDOZVnEVrwpbgsZ
   A==;
X-CSE-ConnectionGUID: yspD2aBeQV6HGOEzcKdABw==
X-CSE-MsgGUID: TaTfMd4pSBi0jOJPzU5uIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="95383125"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="95383125"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 04:17:44 -0700
X-CSE-ConnectionGUID: AWr+xAgPS2C9wt9BVN6u6w==
X-CSE-MsgGUID: uhGf6vU8QKWJIjq8RnCGjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="257177118"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 04:17:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 4 Jul 2026 04:17:43 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sat, 4 Jul 2026 04:17:43 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sat, 4 Jul 2026 04:17:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7Z1lGbyaupd9IGWI3iaP3ot5uZboO04HjrWjDRAH02nTfvmpxKBDLQJK0oGbnVee9BqxnnCAKAt4CElz1VKfgxp7BhmRklVT/NZM246PcyCMNkc/Lv24yPFWkWo/+WpBKzYYABfmgI3jx74fighMOrDZS6jUmOwV/Jbk+dnG23l/PqKy+xRurUTpDdazcEvGugSeF+VPbN22lZymybY4PqnFN1bco2dXS3dcHKRm20aFUx0yRMi/rIuhz2pZS4rw94VzX1GIf3lWWaEGFrX7PQqR7ewahT7URSVCUSq3dLQ2bVdlEuuEHpb5bTB7btyT3ycDDlGvwVPSwH5EjmlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF+po4gtEOxaF7SNx8629zsz1NTTKfR4BOYMXqaVRuA=;
 b=AqTO9l1yNoTmCYf2fdueXXMUhAyuIq7MUYE8Dup0bRA7clqBvSiEDURx+Po6Eek8CNBb9WOfQ9vyhSIn0NTjQlJNHXmp0vlrlP5dzXH15HxWtH0Sol5c96cTJrsBCGgOncfFb6W/fL6TgbCgsfU3c6tDTMc1NEYJd+3Y5/d8MSDWAjHef4vmXyRfxpeiODY93+p+vv6GXLQPCOZ+O3aVEtRJ1Ww115/CejOl1wzcX5lrjEDaNP3sfm+Ta23S8UpS01Xp8T7t8EbqUC6TD/Lo7nKuAzYq8AxgE63HPtYHbte2vul2E9RAIBaxo7oMB6vQpBubGKATI8iYUnc31NxUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB9207.namprd11.prod.outlook.com (2603:10b6:208:578::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sat, 4 Jul
 2026 11:17:41 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0181.010; Sat, 4 Jul 2026
 11:17:41 +0000
Message-ID: <a2002144-5600-4af3-9fb1-03677fb61866@intel.com>
Date: Sat, 4 Jul 2026 14:17:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] mmc: sdhci-cadence: rename V4 functions for V6
 controller groundwork
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, Ulf Hansson <ulfh@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260627201457.12318-1-tanmay.kathpalia@altera.com>
 <20260627201457.12318-7-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260627201457.12318-7-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::26) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 995a217f-5b3a-4fb8-812f-08ded9bddcc0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wuVHJylsd7YG0i93+96MgFDPqF5EHML+e6OLJaS4+tLnOMbzdWZGb0OsNEHw++EyT2WkWToovTMQsJ3jbiBnRrkEeBw8uMdbRMigsWKs5VjHPjIPy1bXsE1mZBN0xJtFlRdTstn5tiwnHlarnwdWjvLAWlezcORLPZ+d+b3Akan2BDZGZxHhqxcepUNLuMNDAacLLn2a7lY9xdkqpt+wDDZVqS+GjzyYg5ZEdtMjNIuuNWxzMrJ3Hte/XUzV8GKaLh4/VCdl+XavmfCkHr7OWcn96QnQi7ivBoAzEbbCNJ3iArdvWkNylXHYJT5qEjMYvBMmaMeyvrkD1t3VPkkQB+hatpMCLpPfGRzWFlZz3xIHjLey+wgvRRWhdFxdjjESK4/VCUH8dPHuKQACVnS7jWJfTMdAgvH2yEUItrDsVn1iZnhqs+XQYfS10aHfycL6dh0YLB/GeZYK8Ny3GRdZ7+2l29pZ+U7goC9S6HPGrbucAMh4fpF+wPiq3+eOdSbADZ/2pOJ9aerx17MInr1XM655DievzQffcIEjnePC4sHtO+iaaleggjwkowE5PzOidb7uh+JRE5Gc8L6YhWqaXeiFVOODHIIkMmPRNLz9G4oOzkPx1RX5C+UEkBDDHjyo9MU4CiFlxiLX2PhhTEeEq1XAikndo4a99fBXZj2Mtq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STRNMWxsM0xYSTlUc21lVmV6UmFJRUhLV2dLWjRGdnJDcGxtcDdoSXRMaVFi?=
 =?utf-8?B?ZjFpcFNmaWtDSkhNMk5iL0pSblF2SlpRUkhycnJqckI0eDZxSjhxdldvcDJm?=
 =?utf-8?B?U3kyUlNjTm5iNEFNcU9OSEl2eGlLbEM0RlFCVDIzUmFmQjFYZEtEOWZpUnFs?=
 =?utf-8?B?bHpEQ0N5bTczamVkZUtNSTNFUXhHVkR1VUlyUFQ4QUlGRFplK25rU09VYW45?=
 =?utf-8?B?WVlrMy9wSnZheGZNYm5WUjRPdzRPa1VWaW1QSmhHTEhyUWt6WXRlUU9lZFV5?=
 =?utf-8?B?S2c1YkdTU3FjS2w4QWRDUU8rdzFFTW13bUVQWGRaV1NVODUvTkhzRnNTdjg1?=
 =?utf-8?B?N3grS2k5YWdGWWlROTJLNU1ob2tMTWhoeitKQjA4Qm4wRTJUZ0hDVXFia3h3?=
 =?utf-8?B?ajNUa09Xek95MWF5MDBRY0pZM3BsdTZ6cWxIQTZ4c0R1bDd6aUg1dnlaSnFW?=
 =?utf-8?B?bGxxd0ZBYzJWQ2FOOGlDZmVKSFpEM09wSEx6YVlJRElCRmlmVWJTeDJiNHJm?=
 =?utf-8?B?enV4LzIxU3FrdVl2TFBLTll2Q28yNVRHZlZ6c2dFRzZNaXVVZ2JROVRJYklt?=
 =?utf-8?B?WTJkdnExK2xzS1orU2pPcjJqcWZrME1RaC9vT3paakU2aCthQlFTZEhoTy9D?=
 =?utf-8?B?bkc0TDkyRmk4RGFvUHJFcDgvN0g1Yi9qTEVNbDg1RlNTcnZzRE1Ndkc3ZkFK?=
 =?utf-8?B?aGdPaTdLbHhIVkNMNzFOay83cVNaOU1SZzdiRERPUTFhUnFOMGptb1dMU0N2?=
 =?utf-8?B?UFovSTVVb0dpQmdseE11aTExL0RIdzRLQlpUMkF1Tzh1V0E2bWYydjhuY3dR?=
 =?utf-8?B?SDlOejZOQjdFbHRIejBsREZheXJBYXZudnFJWGpFeHJvR0o2OVhZNm1mMWJM?=
 =?utf-8?B?aVFMUGhHRmZ4Qm1QNXIxVFRqZm9qUzFPL1NHcDFXWmFyVkpQL1VwN2V2QUI3?=
 =?utf-8?B?cTJzYUp0aTdBaDd0c2JKK2pHTlpqUkdNenM1QllJSWtiMHk5dzdDNmo2YkVz?=
 =?utf-8?B?ZUwyZ2h1TE1tS0ltNkRYK0RKUUpBR3NhMUF5VGlCaG5YM1BHNnNSSmt5MXZB?=
 =?utf-8?B?enhhMS9uMlR0ZGpYT0tmUy9neXBIM2o5MDEyWnlEaXhUOEZTYys0M3d0dEND?=
 =?utf-8?B?MjRBRVFjeWV1YlR3TUs5d3ZwK1p6MlpyYzMwSzNyeXZTeEpzTmJDTzVrUW5E?=
 =?utf-8?B?Sm9rWkdsRUV2SFdGd0g3WHh5Wk5zdlpxSFJ5K0QxbEVSOWs0RjlPNnBzUklu?=
 =?utf-8?B?TlhkNmh3bTVsdFY3QndyUHdHSFNPVi9wdjFpQlp6ZDdQWjcxMXBRK05kUXZH?=
 =?utf-8?B?SDFSVVJWZVRlSHVZRFNld3daWURzS1Vmd2xqZjVmN1VqRXBZVXZrWndXVEdy?=
 =?utf-8?B?SnVOemNjNDFpQklQaVZhNHhoaytnMFBDdGdNVWRkSlJSWUIwMDZ1a2VWMWJ4?=
 =?utf-8?B?M2xXdms1WjR5TkZXbkJTaEF2VzBtc0NXc0xqVUZvYmNmaHVqY2xMRUJ3MFpT?=
 =?utf-8?B?dllUUFYxRWRXYzh2dklNR3k1dHlodnRiUGZ3d3lmU2NucmJjcHZuSUs1NkZj?=
 =?utf-8?B?U1VNVUtYQUp1cWZBbkxPbEZHZXpRZWZrN25JOVliOE1rMTJOdW55ZmRHb2Zy?=
 =?utf-8?B?QUNxUE9BQkhFaTF1S3FDcWpzVXpJRzJGRHpzWkJLUi8xcG14N25TN2M4TnRS?=
 =?utf-8?B?VFJLQTI2VDFNcDlKb3BVTTRtVU9DN1ljSDV0bitKWXRmWnM0V1pqdktMSmxv?=
 =?utf-8?B?ZXJLQ3RwaTdxMmkyRzVTMTdMb3JHKzhERFJyajdXOWNkb1JnQk9HcnNhSmp2?=
 =?utf-8?B?bngrRUhQZXdqa1Z5NWxoVWp3bWtGUzJuV3BLZFhhMm5lZ3VIclRMR3pmRjRX?=
 =?utf-8?B?UUQ5bjk2K2FYK2hmVnRyWGFVWTE1RmNnSG4waGM3UmJraW5Oc2RYZndaNHZT?=
 =?utf-8?B?bHlWblRBcWxhb2swUnlQcnhKOFBmUTV1WHZhbjArWHNDRTZ3UTBsd2N2SmtX?=
 =?utf-8?B?SzNvSEN1UlVGazlqVnJPR0VaMW52WHgzYVRmdjNqRG5VTTVKejRESGY3Q3Vr?=
 =?utf-8?B?LzUzZExJaW41bzVoUi9wYnhIL2tMOWZ1R2dLa0RPRU15K2FsNFFJbGhDTExG?=
 =?utf-8?B?WTFOdk5EZmJEellwV3B3U3N4NnNpUDR5Y1BlaE9KSXZ1NXFJQkU0THVrcGQr?=
 =?utf-8?B?YldlbTVRSy9ySnFjMFNsSTJaVTkwUVVZT0FJS1pERy8zMUU1U0R2VVhoUGly?=
 =?utf-8?B?SXNvYks1R3hYOSt4UEZzRmZ2U2hCMHlTVXEwb1hiWWd2d0l3WGs0WnNVbHc0?=
 =?utf-8?B?Y09Rb0VwYzR2cTV1Sys2TThnN0pVcWoxZFMvWDRrSW5uMjdmdU9WVFVZTitq?=
 =?utf-8?Q?olS2EowuNw8c8NkE=3D?=
X-Exchange-RoutingPolicyChecked: QN9y4i42uScBp9j7urEJ7or20T23wYKJjN7BjMmNGvZTIsM7Mw2rjGCcQUk9kAwjdgZIX8+vpoWRMb78PQZbj8prnM3Ep1T3dPH7nJHO3pR2ruvDGQCQY7Z4lR2mX4mE6yQG7Cu6IavnJCUlc8nxvlMheGBc6HmkHUHdreCbK3JlrgcbX28BzpI+DuaM/8ay+0dEXHQqu1pDOsRrPOEVJeGGPRaRtTqaObBOycxy1DytvO4q4CFJD6R1jIa5meTbMNtMRlnv8acKH9sfke4KVJptSBKL50ElRLiHeewlQE5r7nA2NmbunomBBPSi7hnzNsQcMLF5r1ohxbKkYblDUQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a217f-5b3a-4fb8-812f-08ded9bddcc0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2026 11:17:41.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDcAlFuzTWFBOYjqO/EVDDz+p1qNTctf+GUBWSvu4QuVhYlRQdPY6s8iIk8PULHFGTd3WG+DFRKuOR//rTnpEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9207
X-OriginatorOrg: intel.com

On 27/06/2026 23:14, Tanmay Kathpalia wrote:
> PHY-related functions and data structures in the driver are not
> explicitly scoped to the SD4HC (V4) controller, making it unclear
> which code is shared and which is version-specific.
> 
> Rename them with a "cdns4" prefix to distinguish SD4HC-specific
> implementation from the shared driver core, and to avoid naming
> conflicts when SD6HC (V6) support is introduced.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 56 ++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 435603c8c00b..b00dc2eec922 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -78,7 +78,7 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> -struct sdhci_cdns_phy_param {
> +struct sdhci_cdns4_phy_param {
>  	u8 addr;
>  	u8 data;
>  };
> @@ -91,10 +91,10 @@ struct sdhci_cdns_priv {
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
> -	struct sdhci_cdns_phy_param phy_params[];
> +	struct sdhci_cdns4_phy_param phy_params[];
>  };
>  
> -struct sdhci_cdns_phy_cfg {
> +struct sdhci_cdns4_phy_cfg {
>  	const char *property;
>  	u8 addr;
>  };
> @@ -104,7 +104,7 @@ struct sdhci_cdns_drv_data {
>  	const struct sdhci_pltfm_data pltfm_data;
>  };
>  
> -static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
> +static const struct sdhci_cdns4_phy_cfg sdhci_cdns4_phy_cfgs[] = {
>  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
>  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
>  	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
> @@ -124,8 +124,8 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
>  	writel(val, reg);
>  }
>  
> -static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> -				    u8 addr, u8 data)
> +static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv,
> +				     u8 addr, u8 data)

Could be all one line

>  {
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>  	u32 tmp;
> @@ -156,44 +156,44 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
>  	return ret;
>  }
>  
> -static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
> +static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
>  {
>  	unsigned int count = 0;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
> -		if (of_property_present(np, sdhci_cdns_phy_cfgs[i].property))
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
> +		if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].property))
>  			count++;
>  
>  	return count;
>  }
>  
> -static void sdhci_cdns_phy_param_parse(struct device_node *np,
> -				       struct sdhci_cdns_priv *priv)
> +static void sdhci_cdns4_phy_param_parse(struct device_node *np,
> +					struct sdhci_cdns_priv *priv)

Could be all one line

>  {
> -	struct sdhci_cdns_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns4_phy_param *p = priv->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
> -		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
> +		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property,
>  					   &val);

Could be all one line

>  		if (ret)
>  			continue;
>  
> -		p->addr = sdhci_cdns_phy_cfgs[i].addr;
> +		p->addr = sdhci_cdns4_phy_cfgs[i].addr;
>  		p->data = val;
>  		p++;
>  	}
>  }
>  
> -static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
> +static int sdhci_cdns4_phy_init(struct sdhci_cdns_priv *priv)
>  {
>  	int ret, i;
>  
>  	for (i = 0; i < priv->nr_phy_params; i++) {
> -		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
> -					       priv->phy_params[i].data);
> +		ret = sdhci_cdns4_write_phy_reg(priv, priv->phy_params[i].addr,
> +						priv->phy_params[i].data);
>  		if (ret)
>  			return ret;
>  	}
> @@ -470,7 +470,7 @@ static int elba_drv_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct sdhci_ops sdhci_cdns_ops = {
> +static const struct sdhci_ops sdhci_cdns4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -481,7 +481,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns4_ops,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	},
>  };
> @@ -495,14 +495,14 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
>  
>  static const struct sdhci_cdns_drv_data sdhci_eyeq_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns4_ops,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	},
>  };
>  
> -static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
> +static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns4_ops,
>  	},
>  };
>  
> @@ -560,9 +560,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  
>  	data = of_device_get_match_data(dev);
>  	if (!data)
> -		data = &sdhci_cdns_drv_data;
> +		data = &sdhci_cdns4_drv_data;
>  
> -	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
> +	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
>  	host = sdhci_pltfm_init(pdev, &data->pltfm_data,
>  				struct_size(priv, phy_params, nr_phy_params));
>  	if (IS_ERR(host))
> @@ -593,9 +593,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	sdhci_cdns_phy_param_parse(dev->of_node, priv);
> +	sdhci_cdns4_phy_param_parse(dev->of_node, priv);
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = sdhci_cdns4_phy_init(priv);
>  	if (ret)
>  		return ret;
>  
> @@ -622,7 +622,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = sdhci_cdns4_phy_init(priv);
>  	if (ret)
>  		goto disable_clk;
>  

