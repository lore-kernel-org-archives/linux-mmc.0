Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D448A8D0;
	Wed,  9 Sep 2026 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949889; cv=fail; b=Ffk03o34frnTu/BLkGn71iaw0aMPrleG57Ror/q0VdBiW+sUg0vRmO7Af7K137oCS/XGMLkgBav1RJBhDcTXDbsr7Y6s3w9mqWB2MraioZNamwTjW5vVfOQXslD8v3LO9VTGnNoAdCuxUpYQ+x6E/vm0bGylnBIpWBGMUCXJeXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949889; c=relaxed/simple;
	bh=En7edzTeLyqYAGHvBzmEBh3YBwqwnwhfgNWUWr7xps4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MhmjKxiiGG0k9+qYo7cjANgl4ubXtmvLYlBxnpDwwjrvIQYGv57gWXjDfr4qND98f70SdyOFWRCpaoEsN2/YAO6C6JHytLr0N1r+9Km3jfhucP1Pru8T6xbVqb1el+2uje4sY/RNGXasC07MhvkLT0xTr+sIpmgnkzN50n7Gcug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jocp6w3t; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jocp6w3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788949885; x=1820485885;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=En7edzTeLyqYAGHvBzmEBh3YBwqwnwhfgNWUWr7xps4=;
  b=Jocp6w3tT0x+Gumit+wkHN18EpNxLZ07SLMfwamhv6NViWiaMwqGwj85
   g4wtStHmBYh1/+MSos8DxN4Yt0wspIDbhMMYcyL7Qg3EIPzHrb2EN814F
   5zuRiSU01tj9/Azh2ULwqVbGLfXrqb6E7QXS7w9rSFfW4UXLZe0L9tU6q
   n3/LUVcMzSUfCktLzfN5o+PDGNlKzlke1NsbUUbNZjLLiTNpgdLUtKuFg
   cUowoY4z/knjAkUZHoCguMVpdOxBcIH223rWYXCs5+IRq+m4OZNU2mRP3
   k25gOp5jaReszsIxbOD8gw/TzyejzjOs+QB/r6yh29lfEiXMJ3pETcg8q
   g==;
X-CSE-ConnectionGUID: GmNGeE+rR9SCK7U/h5FnFQ==
X-CSE-MsgGUID: DdeDMDjwQbO1MI8nk2q7Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89401779"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89401779"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:31:22 -0700
X-CSE-ConnectionGUID: Bh6VwGv5QryiaHzkZTvUBg==
X-CSE-MsgGUID: OvnFHwSpRI6kI85oLcupqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301162335"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 03:31:23 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 03:31:22 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 03:31:22 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 03:31:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTkFQpppgqxBDMDMTRHC6OOr3Y2UdfZBCkBiCutQIQSzRcEMfQiXDTpsrBB+oHFidL9Gl3eSlOrHi4w4FOjvSEsPPvv1uXdt9ecngQVFL2Ps0RtwuqmVetZFzytNVCS85xN+Rf+q+JZT5N6W5JcdtwVLxw+ssq5UhlDRhOwzTADi/X4JBC44/reUwU8Dt9Lc/EhGg1inX+ij3Y4sNgyYrGeQ83X26qOuaT5+ig3+7hCFRVrVh3POtoK+3dRmGXWBKwUDDD1JkKtnGHoQjbgATcLh92ibWOk8B/fZyxEQuTNTZ1YqVgcMiNrkTv4VKs89/n9auYO/qEuHR7dYudeDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5Z3ULXJUkAGDj4FH1SKKjocr4tKwE8MEAD/9xF1Dq0=;
 b=LxMnjgF2KHn4SaR/SUf8hAcYjAWgNLcKdOOBgR8jaZIIMJrOLvoEowA4xfEBQsBQlxlA9HdyHKhOldgyDTitkEwjODzEw5HLMzKUtX2wmgxqWMs8AluudE+lBpA75pLfpBcmWPK7rQ3tO1MEwPEUDl5pDS1M3PF9vjJ2wIK64o7zVE5mTs5QW0seJLldpgCUvXI4R6+ZLdEzVniWSn0BHDv7/Jc9oF/LI6fAPIW2R8UQdzYtHJtkc2MY+uZseQFxlATXxMu9OY9Rwlirp6nZiJhxJ1Omage/vb/rNF4ZVhKHxJRoCoz0bfXN3sxSBowZ0akSZSDUPMZuBw6Py21Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MN2PR11MB4632.namprd11.prod.outlook.com (2603:10b6:208:24f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 10:31:20 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 10:31:20 +0000
Message-ID: <75a49f8d-eced-4b47-8184-0d1a0d0f1a01@intel.com>
Date: Wed, 9 Sep 2026 13:31:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mmc: sdhci-of-at91: add option to keep clocks
 enabled
To: Robert Marko <robert.marko@sartura.hr>, <ulfh@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <aubin.constans@microchip.com>,
	<ehristev@kernel.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <luka.perkov@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-3-robert.marko@sartura.hr>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260907132617.1198548-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0023.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::28) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MN2PR11MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: 425375a0-44aa-43f8-4982-08df0e5d7cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|56012099006|11063799006|10067099003|921020|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oMRs1gdbHB1yXCwz7YpZsC9v/HUEI3zq6qaOuYkPrQyuoIlYOp2ycGG/iIj8oDir9RXf87cSDfaCkTeJThlyePMaMrHN20v8VgPTVEaOt0v/feKZit1jA8E3CpDdHBIexOAZIx/9BgqbRG9AQSExt+6z3Z+qz0PmW7k2bKHWt4izB3IpMZc4iie4pUBl3e/h4OzB+ZwybU+cwujw77i837obdOaQFC9T/t2NO3vpC4xhN4bL0+wqu1LPj/2qcIT54TR5b1OQvizfX1AKxR6ZuVaHptH7OHmDyZ2sY+Urs/dkxY9oUvD3a1QEXSXKwBnqXmVT/3mm5dfnkAwgvmVZi6kaYXuCJNb1gcabCfqOMpnt7w6maOXIdckSq4Q0KncGym0DjYz6x/Tv8+1Sd5IuKjH1xfr9eKhapQLbKVj4LlZ3xg3Z7X+TpY5iQxiiihxK7mIEIFTzZ6Bsd9Z/Ud/QwKx/ZJsYzB157nuWDkxf99u0HMvVeHw/Z762ksG1JedWKttHfINL5Pydnk7jxSlvP4u//LQgvQxR6grGMsdLVy5LfRThMcOA7WviEjlRXmG7i/1qRU88exJ3f/ruY0U/Blmf0d1Jfr7MvljNGr2j3jx1wfyrj0CzK3jWc3M5gEUU0THlaj4WKqRmVgbg52vd0LvpJE7+hBDUM77Chlv+xX+FmIcjB7bT3jfr/4jkWyDMkHRTRaaQNVc5c3m0vuOjow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(56012099006)(11063799006)(10067099003)(921020)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkQ4K3VSYnpsZmNVN2hldW9heXdhd0hJT1BrdTBFNlZRNlB0WXU5SWpVbFpF?=
 =?utf-8?B?bmd3K1hudkZjQzdtenVGZVlnOGRraTFLd29CaDhQeDI5OFArQkVqRUcydEZB?=
 =?utf-8?B?Y2lTTjNoRFczU3hYUTA0RDQ1cmFPMVpOZkRMMFErTExZdDVqOUo2SlRpWVBG?=
 =?utf-8?B?OVZVTUVOR1RnTWJ0a2FsVjVpTkJ3bGtLaFYxSjkwVVJhcFBIWjAwMk82a1hF?=
 =?utf-8?B?UkZtNnl2RW8vc0p1QjVCZExrM0ZScThiV3VxeDlzZjZXYjI4WUFDWEJSbCtB?=
 =?utf-8?B?V294T0RjSEh6ZzhrYlY3eGJKdFdGT2JDQzBKcjFMVElQRS9EVkIvMUdSN2Jm?=
 =?utf-8?B?TEJBQjhjNkI5Z1g0U3Z4eGRmai9XSDg0T0xzWU1QRWZJcEZYTHRJVkJNVFVx?=
 =?utf-8?B?eDI0c1htQmx1UyttcDJJcXNqM0xIamdIVzg0ODNmSGduTVF5NEZKcjNDc3ZC?=
 =?utf-8?B?MzZ4ZCsrU1NCUmN3WkdLc09jKzlDbDdHRCs2aDRxQjRqeU8xcWlhSk9NZGdO?=
 =?utf-8?B?c1BlWVYrNlZLcWY2SGlET1RpaFVoSTk4NDRQS0MrZm1lNDFrSGNHRHU0cUJi?=
 =?utf-8?B?a1FzdDdtMzEyTlBybHQ2OEFGcTBkbk1iOS95cmFNS05WK0tuQktZTlltKzFr?=
 =?utf-8?B?WGxsL0ZQTVZGRlFhSWVHN1pxdVR4dEtlbCthVUlubzI5U1huSzAwcGIwTXNI?=
 =?utf-8?B?dGZaMVlOQXJpUExITkdnSGloWGF1eXRNbXRKd3Y2S21OdzlNUlRNMURUSmpY?=
 =?utf-8?B?clkxMmg1UCt2WHFab2Y4a3VTOUlRekt3WFp1MkFmWWlVR09mdWNjaEx5c1FW?=
 =?utf-8?B?aGIwbXhFcWFadzBxam1FNVBoUUJZaVQzdVk2SVJWUnh2bGs3WEo5anFyMUhG?=
 =?utf-8?B?RzIyTGRQOGNOa3VMZGdlUDlXUUpsb1VTRGF0VW9yWFNPZUJBS1lvT0xzd3NY?=
 =?utf-8?B?dWtMRWY1Q0FRWEZrRXREdjFqeTBaSUxZVTVxKzN2RnJ6R1FjR1hyTk1iKys1?=
 =?utf-8?B?dkx2QkkwZlFjSDZtenlFSHVFYURJZ2hSQjZOU2MwaXc4SkhMU3NOaVVxQlF3?=
 =?utf-8?B?c2tQL0lPYjFRUld6UVdEcDBUREREOE85TTlZMEg1RndGOUQwNWVqSGxLaTkv?=
 =?utf-8?B?MG5kcW0yV0RqUFk1SW92bW9pR1Q1UXNFdlJncFZ4QUlqNVpVQysvU3JwcE1L?=
 =?utf-8?B?N0Qzak43U3REWUR6cVdSaXpSSEpkQ0pWdUNuQ3FVUkJiTmxNYkl6UHRnM1pY?=
 =?utf-8?B?bUlaaUUyWGNQaXJLcW1tYSt1QmUwaGdmVktXQlg1SEZ2MzhESFJjb2htU2hq?=
 =?utf-8?B?L0NhN3BsYnlIN293N2JwNndmbHdBTVJlTnljRDdRZHRIVWo0WHBDbGxhdkln?=
 =?utf-8?B?RjZZd0xQRWxrcGVmckJiM2VrdmlwRW1iSmJzV1lDUTdWYTNnUGFSNHRsMUpy?=
 =?utf-8?B?dkxRNndCcFpqT0dmbjRXVW16NmxobVdWTkRKRXR4akx1bG9lUVRUN1dvNmNQ?=
 =?utf-8?B?YTNvTk5NZzRZSVQzdmt0S3M4cU5Mbk13THlnK0lxR2dkbUw4M3h2MHhnVWFD?=
 =?utf-8?B?OTVYL3hTcFBMa21lazRLajg4WFpvY0tzWFFzUDlOMzd2dVZya2RpOWdLelZ0?=
 =?utf-8?B?enhGZFl1Q3F2L3NxbFUxRmtTbGE4UjROUUVRWUZDdDhMUjNpdHowSHFxRGYz?=
 =?utf-8?B?cVFtb2k1d0lGQjJBb2lGV2w5YVprVUdPL2wzZGk3RkltSGp1WXBySzkzUUFp?=
 =?utf-8?B?b0VYd3J1eDZhOHNneDdIdmhobGtBOUF2cTFhM3orQ1QxcitUSFN5VFVCNGtT?=
 =?utf-8?B?aktrZjdZU0s5K3BDNEtXdTI2a2ltclEzVWdKUzlmTEdiKzdxSGxvTlE0K0Nz?=
 =?utf-8?B?c0Y3YitVT0RtUFRhdFNVQU1QYVBHcWdaWjRqS3BvMkNxSHNjVUlHSGY5NTdH?=
 =?utf-8?B?VFJncjlQYkh6ZUxseDhFVVpvVlVrRzFOeGtjUU4rRzRNZXlvaTV5ZkM2cGFM?=
 =?utf-8?B?TkFnbmFDSE1LR3gzaHl6S1BTLzQxblZRNkR1TEI5azhlbE1UYnhLVGp3cXky?=
 =?utf-8?B?djE5eW9EWjMzUWZiQXhCWUtCejdidm1CRlJEWnR2eHQ2czhudnlIcUhlRS9u?=
 =?utf-8?B?ZjZxaTNseHNRWHZNLzJwYjkzNzVjR1dRYlhUdzFSMDlsVCtrb1NzY3hvd3U4?=
 =?utf-8?B?bFd5OGx6QXdqY0NRdE9MVitoS0lHR3A3TUdhQ2JUck9uT2psRXhCbG1mRnNh?=
 =?utf-8?B?NTcwOWtka21hNlRUMGpRc1FNMWlkWVhPVWdsSHVVSHM0NjVFK1diK2gwV0hX?=
 =?utf-8?B?TmlBRDgyQUwzT2svNzhRYWVHZkhscXA3TVl3dUMwQUJBSkluWGNXTno4TFF1?=
 =?utf-8?Q?qa3fegb7XlX/gces=3D?=
X-Exchange-RoutingPolicyChecked: 00Sdg7oeeSR2ui955nqhhGW5sB+ks+6bUcpcz84VgA/C7FMBID4GO345QUGGc8ym37vNsC2xtkZH5T4lrxVrq5YaIz5YWqJawC1a06GkBRlnJMqfAaGO+GvZTaOewW5Ss9/gjay1s/m9X/eGiYM1voQQx6bEg3TzXBpwhNi33YvZBq7MWiRflecNVXScKFmC2G4WUR5BmD/9u1E5mLlC2EcHiZtsMvkzvhNBdfDeh6a6choRtsZs4U6yIPRrH8FEti0nA66V4KzWxJG0KRAMS89OrZFpJ+pD1mPtApZrrioquvTmyTC4KySmodmffT3v/8lIy7ztqZWoba8hSswOYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 425375a0-44aa-43f8-4982-08df0e5d7cee
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:31:20.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKSz7MbHJO2cmdsXjzClo8DJ9EJxa5KEHWdAdMVH8Rf8VPVeNBkdtz+qIVdplRx1WzFd+sgCHJ8V5fVPOO56iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4632
X-OriginatorOrg: intel.com

On 07/09/2026 16:25, Robert Marko wrote:
> sdhci_at91_set_clks_presets() both enables the controller clocks and
> programs its capabilities and preset registers. This prevents callers from
> restoring the registers without changing the clock enable counts.
> 
> Move clock enablement to callers and add a SoC data flag for controllers
> that must keep their clocks enabled. Use it in the runtime PM paths while
> keeping register restoration separate from clock enablement.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
>  drivers/mmc/host/sdhci-of-at91.c | 39 +++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 7c4ac65f247d..b7e2a89da348 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -38,6 +38,7 @@
>  struct sdhci_at91_soc_data {
>  	const struct sdhci_pltfm_data *pdata;
>  	bool baseclk_is_generated_internally;
> +	bool keep_clks_on;

It can be a bit easier to read when conditions do not have to be
inverted, like

	if (priv->soc_data->suspend_clks)

instead of:
	
	if (!priv->soc_data->keep_clks_on)


>  	unsigned int divider_for_baseclk;
>  };
>  
> @@ -164,7 +165,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>  
> -static int sdhci_at91_set_clks_presets(struct device *dev)
> +static void sdhci_at91_set_clks_presets(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -174,7 +175,6 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	unsigned int			gck_rate, clk_base_rate;
>  	unsigned int			preset_div;
>  
> -	clk_prepare_enable(priv->hclock);

Might just as well pass in a parameter and:

	if (prepare_clks)
		clk_prepare_enable(priv->hclock);

>  	caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>  	caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>  
> @@ -222,11 +222,6 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	preset_div = DIV_ROUND_UP(gck_rate, 50000000) - 1;
>  	writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>  	       host->ioaddr + SDHCI_PRESET_FOR_DDR50);
> -
> -	clk_prepare_enable(priv->mainck);
> -	clk_prepare_enable(priv->gck);

Ditto

> -
> -	return 0;
>  }
>  
>  static int sdhci_at91_suspend(struct device *dev)
> @@ -254,9 +249,11 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>  	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>  		mmc_retune_needed(host->mmc);
>  
> -	clk_disable_unprepare(priv->gck);
> -	clk_disable_unprepare(priv->hclock);
> -	clk_disable_unprepare(priv->mainck);
> +	if (!priv->soc_data->keep_clks_on) {
> +		clk_disable_unprepare(priv->gck);
> +		clk_disable_unprepare(priv->hclock);
> +		clk_disable_unprepare(priv->mainck);
> +	}
>  
>  	return 0;
>  }
> @@ -269,14 +266,23 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>  	int ret;
>  
>  	if (priv->restore_needed) {
> -		ret = sdhci_at91_set_clks_presets(dev);
> -		if (ret)
> -			return ret;
> +		if (!priv->soc_data->keep_clks_on)
> +			clk_prepare_enable(priv->hclock);
> +
> +		sdhci_at91_set_clks_presets(dev);
> +
> +		if (!priv->soc_data->keep_clks_on) {
> +			clk_prepare_enable(priv->mainck);
> +			clk_prepare_enable(priv->gck);
> +		}

Then that all becomes just:

		sdhci_at91_set_clks_presets(dev, !priv->soc_data->keep_clks_on);

>  
>  		priv->restore_needed = false;
>  		goto out;
>  	}
>  
> +	if (priv->soc_data->keep_clks_on)
> +		goto out;
> +
>  	ret = clk_prepare_enable(priv->mainck);
>  	if (ret) {
>  		dev_err(dev, "can't enable mainck\n");
> @@ -344,9 +350,10 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
>  				     "failed to get multclk\n");
>  
> -	ret = sdhci_at91_set_clks_presets(&pdev->dev);
> -	if (ret)
> -		return ret;
> +	clk_prepare_enable(priv->hclock);
> +	sdhci_at91_set_clks_presets(&pdev->dev);
> +	clk_prepare_enable(priv->mainck);
> +	clk_prepare_enable(priv->gck);

And that all becomes just:

	sdhci_at91_set_clks_presets(&pdev->dev, true);

>  
>  	priv->restore_needed = false;
>  

