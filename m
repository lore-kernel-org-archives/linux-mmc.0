Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD333D4FD;
	Mon, 25 May 2026 05:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779686770; cv=fail; b=RgursCHynT6uIIWber+Gg8OtcOzFCmd4UGuZH0pAU3dGZCCsulzQVYyetVIMu+dAthq+x5CLM37XUUa9HlBg/1HD1MdSlxC+AgdSR26K/LiM1MMX/iE878zCz27SheSi7SqfuQopyTQqoDOlZZzviqQfK+AnIFL3OfBBeXLKf8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779686770; c=relaxed/simple;
	bh=N069pFRzSwpbd2mlPvlkOIi737ca6pQF6Eou5cTpZV8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gLaz6fBjo9+2sqNx3TU0MlRfF4cn4gdo9Gpsi9iZLT82U0dTJgZ9bdl8Aph0CL2dS+Fo6khlnI6MLu6Hr4xurtVUfXd2y6L/dfU/ng3XdtbptnvyXtM5f5C2sFif/Q6KgE83YF4O55bl3eQcjt4hHDbeh1xJ91cs11EZBsgk704=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQ0DZTpA; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQ0DZTpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779686768; x=1811222768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N069pFRzSwpbd2mlPvlkOIi737ca6pQF6Eou5cTpZV8=;
  b=TQ0DZTpAPcae5FeYaaiJo0d/ya2TthcCSdZQakyElZMXRumsb6/tEiV9
   TdkUDKZkdckX0iOfiN0K0qHtMGv9E9xX35TU7qzEDHecix05V8CUiRV7e
   j8uGq3lV8TZYBekRUFnpj+hfduJB/R1Y6Ovnd0NLWFPPVDnh83HVHRTDA
   RS4JQvR7BrnzgFEcM4oSuAhmiEWl6LIwkHzP/jLtBEo7shSGqWqn63q4M
   iWmTuO6tt70xE6x/bO0ZtrbFs5y2ujQuxnonNee/Lznt6OF5/gbx12R9b
   40pKtBiAleZQEcfgkH50dNOoN2p5MRe8Fh7ZPbrFV3Ww8fBrrHmVHro2P
   g==;
X-CSE-ConnectionGUID: FZBMFgTXTduEIwxSXrwH/A==
X-CSE-MsgGUID: 7QeNV0J6S3y8AFS3JQgHvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="98080102"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="98080102"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 22:26:07 -0700
X-CSE-ConnectionGUID: e6Ic3CqVSz+8TwAM5rx6yw==
X-CSE-MsgGUID: wX7FTW6mR22qc35pmOroZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="245539102"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 22:26:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 22:26:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 22:26:06 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.50)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 22:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TigHR3Q7LdAYSi3OFJsJoQNiLvp2Ry77jeivWXFOOWUN3r+ia3jl7VGVCdFGpMCcIaN6DDvoja22qj0Q3khXVNT34k5lzku5qTNjLu+YJev3zczhHkl1HlghKs/lHztd7tW/tqEE6H4oT46RpoquihXrzcoTS++b8mWzio+0zGdY0821EVZAT3LqZU/n/f5009m1TjIEuWQ5j/kOEYs40spkBdHj25Wb3RT7eEj3Syb1mpup33n+zzjpinXy0z851aojuvOxotgR25LAkAqlLw6TornwOseeSpAuksdSHb1Xj3bBSki4ib6cTECx24iwIdmC18QvBWCgezwJ1NN+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2RXTTKFrP1UVjnjjF22zaukWfnagtyEqQOCUWg6eSc=;
 b=GT9bMyBvFfdTDlUeUy+N4c8pMWs8rgf8KG7GbxMvoRGEsuScirct6y/qjJ2JAZYSVgLKmgcgTYt4BEHqfrYQmCh2Eh+OZ2P/RGbCm/5w1F/qw6Uop3O1UOBDBM8T41tYS4gnIgk2TSKfhoKuNiqLhZYkAWuzdfe4vrj/wkfYD1vvas+5VvN6fEUxa9jmqANmVPiAnvSvtm4yL3pyvkCKnwOHKWl6Q7QqNvxOC7LUTb/VIIoxq9SEfUyz0sn79mgpP16+P6OsJ7j1QEtlhSI7E/wqSdEitvghmmo7PdfVUDY1yBupR5hg6l3HKLX6arkk2ZsBwUlf09K+jv4e1VcQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH8PR11MB9745.namprd11.prod.outlook.com (2603:10b6:510:3a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 05:26:04 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 05:26:04 +0000
Message-ID: <e3ed4446-ffcd-4b05-86af-2db763419bf4@intel.com>
Date: Mon, 25 May 2026 08:26:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fix GL9767 s0ix sleep blocking
To: Ashwin Gundarapu <linuxuser509@zohomail.in>, Ben Chuang
	<ben.chuang@genesyslogic.com.tw>, Victor Shih
	<victor.shih@genesyslogic.com.tw>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc
	<linux-mmc@vger.kernel.org>
References: <19e5009d987.8379fb8938306.7573506608157081813@zohomail.in>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <19e5009d987.8379fb8938306.7573506608157081813@zohomail.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH8PR11MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 00194604-b319-463b-235d-08deba1e1dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info: WsW9A4iiAwSeSlc20ECzqU5UpLeAFWwW4+I3xb1kIzk4vXgnjKOMJZ43WC8sINMI+eKDx8JobvvxwiS86M2kGaSaEwv2dDUJV7O2OjD245Z1aDSA4TW2C7FvO0uwrU/f/yBEStJtRDt88EVqlpNfe19mfFFKjspXDKUtHJpNWeD5JwCMRQ0YKLSOzl0JPs4fPbUeeCDqAouYblk29hvMN9YZC0dYw2YkVGbrmBZsNPmCIzisXCsB8ku9LEcTTFcY52P2wwSPPiW3VAFtlNXu0X8vFSsObHdd0Jk/yd1tnhn5fAs/vIf6lTQydU7/aqjvqX15/5bEjowvw04R5LB6uHWZLkyIuDGwquUyG5mm+gBDFOi1F7D1l9HVOYWyWQ/f+2g688DaGlsacSscesw0FZRSbs0DiXZMRD0j/oZUjfQWSLrddO+USzqpFJmBa4runHdO6whyO5MfOeeqnVKskyO+vuIRXEh+sDVkqOnYCeLB6kbrz4ngxaMGj6eq18moBNBdavTVQtZpkeWxzCBARQYNfu81eGKkTOcyzt/woUzOyVpuEM8AAAdnUQTHAbd1W+EnuHEPELX8/M55j8j8pvJJ/PfU4ikHLRWmVb91IsMq/oCraUVJkWG3hrbtD41Of48YTeOhe0bSSHaDL2Am55QiXzqVpnbfU15/v6eQAohPKKS1KwCvjtcwMmVf85VTY6p3sk/XUQTJsImEPLDaag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjJjUmp5NHhFa0ZBeU1OaGpmeHcwamZ4SDJPSHFuVnVwcWJJNWZETm0vUnJr?=
 =?utf-8?B?MGtDMXlOZVlZaVluejRTZmljL2JoRnN3R0Y5N2d2YUk3TzViK2o5SWxaazdO?=
 =?utf-8?B?bVBlN0pKRGZGYVNuNnpxWEp0MlVaeGVLOUZ6K3dBVkVvSU5uUENuSHV4NWRQ?=
 =?utf-8?B?MzdqaGEvbjduR3VVZk5DOXgxVGo5cjMwTlcyMnFpVER5Um1yb0JENUJvRTN6?=
 =?utf-8?B?bHZYNXFLSGFUR09GK0NIVEIwa0xEQ1ZaU0tSVUVob1RPYythQithMVZqWkM5?=
 =?utf-8?B?NDkvblBzbjgyc0hzeEk5a0s3MWJDdnp5WGJjMnYzQUdjbzdWWUR4VjdiYXQ4?=
 =?utf-8?B?QVdFcW9QMUtGbHExYzBxUVRReTJsaWZoOEZLUVRJQWx0ZGhhR3kzZHQwaXFY?=
 =?utf-8?B?NUduZEdEeG1IblkzQ2R3QjhCalo2K3RnK2dReFA0RDZnMW9oRFBTN29QbjNG?=
 =?utf-8?B?dFJjNlNVa1ZhdjVOQm5FODJMZWtWSVhWYzZ2a0xNR3dtbDNBWVVvZVlFNWlp?=
 =?utf-8?B?cXRWSlU1aDlsME05bWZuZUFJaDRtL05PaE9HVFZoaVRQSGdYR3lwQWFKQUJ3?=
 =?utf-8?B?N3JaNjhOSmZBRUpqbEl6eVlEbzg5VnE0c3FqVEVuWE5uVlZCOVhkQXJVZUZR?=
 =?utf-8?B?Ukd4aEM5cmxnZXd1YjFobWtRMjlQbm9tNktjbm1qazl0Y2NHZWhKOGt5b3NO?=
 =?utf-8?B?MTZ4NXNDR0l6eHQ1bFF2RE8vYUQrWmJpQU1oRW80M3A2T3pRRDd1VVlONXcw?=
 =?utf-8?B?eTVMNWZXUG43MnM5UEN5UTltNnlZOW5XUVBBQXA4S21HVGg2QzdJN3Y4Nmtt?=
 =?utf-8?B?eXhVTTNMQktsOG5jdGgrdlhuM3RUMk53Q0RBaVQvZUVvdGh5MllpYy95ak9v?=
 =?utf-8?B?MzRLSWlzWDFFc2xvUU1Sc1Z3N2FKRWdNakF5VmFJN0VCbTIyOGxYa0NqSjlp?=
 =?utf-8?B?UWpCeU9RT01hMDBXeGVPSm9pcnVzckg4Vkd5ZlM1ZGFNbGc2U29kSFV1eXh4?=
 =?utf-8?B?eDFaWHVCMHJsWTF4MnczRlV2NitoNVdnT1lVRWVZRTFXTVN5Q3F0aW1BYWh3?=
 =?utf-8?B?ZjVFb3FraWJIZzJsZ2cyaHBaOXFjQllaT253Y3M4bU1HZ3BzTW1McDRxREU3?=
 =?utf-8?B?NU1Rc2cxL1BiclRnYmIrd2FkaVZ6dDB5SVRUMzB2SFhCR1JqUzAyNldzejVN?=
 =?utf-8?B?NTJWSXd2azJyc1pQRWxyYzNsYXEvVHJBa3RJYTJaeDFIMVhEZnJsbDlsVWFh?=
 =?utf-8?B?dHNBb1VGeUtNWWFBNXpIYzVmVnI2MWloandhLzZMcmZadUg3OURjR2RLV1BK?=
 =?utf-8?B?dFNmSm1TMmExNW1RMGJZSkRRNkE1elFnMjlqdklnZXlzNzQvMVlBQ3lpTE5x?=
 =?utf-8?B?c2NyaThCQmpuMWxuSTdyUWt2Wk8zZGVBZUJmaEdnVmsyWnpxM2c5TVFuZERk?=
 =?utf-8?B?UzlhQnV5OTRFQTZFWXNOU2J0aXpERmFBMmFwL2JuWVJJdTNlM3VDS3R0Z3RG?=
 =?utf-8?B?VXNscnRZZlJIQm9kUHpoVWU1MFNBQS9tdFIwYU5JR0Z5cGliNVBRbDhqRWRx?=
 =?utf-8?B?dVRkZVJKQ2JFQ0hwemZsTkd0eG1yU21MRmJJMjhxbmZrSTJjRGEzeTFDaWVB?=
 =?utf-8?B?TVYwclpTUm9rWVdWN2UwSSs3Z09LWEU3YVNWWWFJVy8yNjRIMWV3WERpUjhq?=
 =?utf-8?B?VzRzZ3hQQmFUZjdqcjI3MHlVRTRaYmRVeFhBdnVqNFh3NWlHLzBIL3pOVDcv?=
 =?utf-8?B?djh4U0lzbGRGSHZ5d3Z6RW1XdUtGQzF0TmZaVkZ4NnVBbXplb3V2aWlTbWVx?=
 =?utf-8?B?dzA4U1ZoMUZ2b3Q2QmUxTHk3UEtYUmorZGpTS0hGd1hSb3drWHcxT21CMmdZ?=
 =?utf-8?B?SjcrWUJxUk1rcGtTNm43VGMzbFZvSXpDcEplU2NUSWIxZTMrREV3dGNUWHd3?=
 =?utf-8?B?ZEtLSjB5VDgzSEMzdkJ1RWZNYVc2L0N4N2R2TkRERHg3aXh6b2plOU5xNTkv?=
 =?utf-8?B?alJBNmNIM1A3M2dRbFR2SFd0amxydEJteno5bS82OU9TUC9CZTRPRk84WWNz?=
 =?utf-8?B?VkNHcW9IWlBKT1NkKzVOZkpBaWUxNzJLc2dJQzBxMDl2SENjcUxnSXhZcEZS?=
 =?utf-8?B?VS81aFBRbEJxbldkYVlIenZoS2QyNE03NmZHTzFSeTBKR1lOeXJSdUdQUFJD?=
 =?utf-8?B?MVpnNkNnMjlkVVIvTHhrb3dIUHo3bC9lWUdmeUVPZVJ4N1BBL1RZWU44VFph?=
 =?utf-8?B?TkYyRzdHL3hrZUNjVG1kK3lGdzI2SHhwZFJyb0k1Ukw5dGVGZlI1RlpUZk00?=
 =?utf-8?B?b2FsdzZXdkxkUnJFd1Q2ZC9JNTdSaFVWWkpKVmNWZFA3L3NSWXdoL1JFWG40?=
 =?utf-8?Q?JP9YMCAozSFGQVo8=3D?=
X-Exchange-RoutingPolicyChecked: a2FxYB8+8MGJ+Hk7SQPNxdrOPkb0o8iGkfpuOg88OsBlxYK6knb359EImRYv+APapsXFl9djFS+8PzH7TLBKkxNT729+gx1K22QyxZXwm6NDbLcqsvlu6gxuHn8w/un/qoLS6XFmUI+NhQ74xhumTM3PhQIX9WLLM61h5bBZ3rNCt2/uvCzvcOIkOaRhUsJwHDRf/Q3DdmbXwOrCgPcEPcsoQk+fYQKqdCt/VC5zE5TKtziUgXjFt9QqzUZRIvPAmeLpeU0zX2nD+3/ui/I22RpZWzM6WHt3r58GcfAuLm6+Ssh5xiyxrWSPfv33ly6hF4J5qT1W4tJNmHS0rWqe7w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00194604-b319-463b-235d-08deba1e1dbf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 05:26:04.7033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKR9xKtBh6qfnn76GxIDUsFNDiDru1Ta+MhgUkIYrp0NZRC4wyn1vLCZrKjP02V0ixf1ooar6iFs8rkpVWWyyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9745
X-OriginatorOrg: intel.com

+ Ben and Victor

On 22/05/2026 17:14, Ashwin Gundarapu wrote:
> From 42b314da9b13f5aad38c7a58bc4191b08d6b2156 Mon Sep 17 00:00:00 2001
> From: Ashwin Gundarapu <linuxuser509@zohomail.in>
> Date: Fri, 22 May 2026 19:39:12 +0530
> Subject: [PATCH] mmc: sdhci-pci-gli: Fix GL9767 s0ix sleep blocking
> 
> Add missing suspend callback for GL9767 chip. Without this, the
> SD card reader remains active during system suspend, preventing
> the CPU from entering low-power s0ix states.
> 
> Use the same suspend function as GL9763e, which properly powers
> down the device during suspend.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219284
> Signed-off-by: Ashwin Gundarapu <linuxuser509@zohomail.in>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 6e4084407662..b6251cdde228 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -2121,13 +2121,14 @@ static const struct sdhci_ops sdhci_gl9767_ops = {
>  };
> 
>  const struct sdhci_pci_fixes sdhci_gl9767 = {
> -	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> -	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
> -	.probe_slot	= gli_probe_slot_gl9767,
> -	.add_host	= sdhci_pci_uhs2_add_host,
> -	.remove_host	= sdhci_pci_uhs2_remove_host,
> -	.ops		= &sdhci_gl9767_ops,
> +        .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> +        .quirks2        = SDHCI_QUIRK2_BROKEN_DDR50,
> +        .probe_slot     = gli_probe_slot_gl9767,
> +        .add_host       = sdhci_pci_uhs2_add_host,
> +        .remove_host    = sdhci_pci_uhs2_remove_host,
> +        .ops            = &sdhci_gl9767_ops,
>  #ifdef CONFIG_PM_SLEEP
> -	.resume		= sdhci_pci_gli_resume,
> +        .suspend        = gl9763e_suspend,
> +        .resume         = sdhci_pci_gli_resume,
>  #endif
> -};
> +};
> \ No newline at end of file
> --
> 2.43.0
> 
> 

