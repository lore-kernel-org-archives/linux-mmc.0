Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793802654;
	b=l+/IzItM35tUAmQoDmXA+fuLF6G+zVLa0gdnIZiD7+cpe2j0ed0yZYX7JvYEucb1OQmA
	 5WPvTFra4iDZcOhazxsCmNEIoIUnVNp4uo5+NOHHRxZ5tCIQH5zxUIlxIGFzqYicUCkqt
	 UzuntTesq9dVv7HpSCIrW46JEY0bITMklZnsNjEVEzVNSeKcVwrY0tLjiCRcS3swNfnoX
	 sctl+us0f/1N0JtZNSBMgndIrlebE9h4tcSlM//15+bqVMKZbbgNyCAJf/KE6PKc74QdX
	 FOuVezs00Am1icgcM3is7U8a9mE8vVUDY3NrGRD49JSOmN3sa6dgsvgyvO+yr81VGBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802654;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=fe41hgN9+pCge4PBjGCXJBjUEcKc4CB2yGrW2bWA+YE=;
	b=l8MANpd0x7kkgUgP4b94pD/FhQ0RHvRquvj7hc7TafgkNkJv+YGnmloL7eJSTAWMhkPH
	 6J9h0bX6qcjP29L7Uq4Qqd2J9KTtGydqAVPoL6nY/2teVVnQZn5N1/SWfhcQqjh9Vfcdv
	 RXq0VM+CaHWc17naSk7WHvCAkfwr2XXm708H7rhJSb3Nh8kKZEIvJ8eeuKcWCudKvRSKR
	 9BcQYoCZvsOVZlUI2QPlwWN9KDRWQiCLdiXNC5OY/SRtShBGytVtzsgz9teR0s/1flC+q
	 2YKDb8XFJsMxyRJD+05IjpPrGqlLduTAiJlQPrXJJdi7hAkDadiuoX3STlHpZjS0kog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JZCsIHtf;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44C606A326;
	Wed,  4 Nov 2026 14:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA44C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JZCsIHtf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793802654; x=1825338654;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JLpsNU4D/LMKQSTAOR4NRFIaVdnDA8Mfw0CcU2zjfKU=;
  b=JZCsIHtfPTGTEExV7xl/0cdGvRtSX5d1bLBkroJx/lKCQTsnauOto3ST
   VgLR8+W7YW+SThlUCprWxUQW1r+OekfJKBHdZX3wGHVgzuAklqGJvDOZN
   CWe0h6ecZ3kidesT3LAZzRa6j3hf2QsP1lcPq72TdY/khjh4M4ihUX3bd
   c7Vj5xqcezwjvRD+hXrqe/0VGqZh6lKA5dpxKe97s/EF4/X2NMtF8yq6I
   hindCL1grx9Q1WcJpGZPiU/Mrwd9rBYnMN2W+fMhBH7TXp/ELyAO444G/
   jOr4h+n22z82XcvCzoB47faVISWcDUECkJGRi9qfSnuhkDyIaWTHiIc5Q
   Q==;
X-CSE-ConnectionGUID: El/2azRXT366eAYc30PjZg==
X-CSE-MsgGUID: ay32wLrdRHKmS5Wv+qPZqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2465244"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2465244"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 06:30:53 -0800
X-CSE-ConnectionGUID: Mej4lmjDS1uCZkjGC2bS/A==
X-CSE-MsgGUID: mun8tR4LRG+CaLhBl1/g1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7079585"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 06:30:52 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 06:30:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 06:30:51 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 06:30:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASYaBwXqGQBOxeDkvFp6chmcbvwB8nus8Ar7OtYJcLAS5YRiQnHnbDDhNtL6nnIraHSgsq4+sUphoG5dmV3YUJe8Hj667aU7A25I4oUm+i5nPYIHzUmc2XUsSDfaW8uBr6eP5M8XMdWTTDH3AkeHaBPTQOgk13n7SvxKlnAF2jtxHGQO+SvaOzZPXN1nh30OKBW0xBWHGQa+nCCVN5mZsE8d+CrSWxtoujejFam/BBhry0wqH026SiWgd1RE4GduIFRJxe+7TxXxCU4y/6VGmKgCv5qSO5PYnB1RCoaWHrN/NVz1kFiGdUWIZW/92xXWTsiTuOVtfFEHRJma0U+2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe41hgN9+pCge4PBjGCXJBjUEcKc4CB2yGrW2bWA+YE=;
 b=FLcd2qpcVoxOYPepsAfSBziy1MUWEh7YtyTBlOjWGNkugQCdZ1lcXAZT5FITEKgfTvQqC7krWdAfoqwaw+k/kCboLQ3+2oMJY/KWoLaJb4wCEfDRsWpYy3+/Qf2b27mlvc+SSzJDuH0naKE2Vu16FS91Dl2OpQ3jYOF/+aEJjQ5ykYkgaozVWjRbGWeO3WkynA1goIanXpajseg3SwTlgzJ/TUy94LBfLmJb6h3Zv/kPi+PJqJP3000MBnVwJaZzpOaDKrwFijKDeduPuBpPidBCffuaE9cM7sBVOjVzpxhrU8KIm06EZnmWD6tJfCMt0PdfWrAvZAZGO1hFHUkqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SN4PR11MB9944.namprd11.prod.outlook.com (2603:10b6:806:4ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 14:30:50 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 14:30:49 +0000
Message-ID: <c8dc0612-7ba2-45f0-9aa9-5e312fc8aab4@intel.com>
Date: Wed, 4 Nov 2026 16:30:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-cadence: enable probing from ACPI
To: Paul Cercueil <paul.cercueil@bootlin.com>, Tanmay Kathpalia
	<tanmay.kathpalia@altera.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
References: <20261103093501.218232-1-paul.cercueil@bootlin.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261103093501.218232-1-paul.cercueil@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0273.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::14) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SN4PR11MB9944:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a943371-34d0-4a13-f6c2-08df3a8038f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|261022113327099003|261026121527099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: pGTQvVyKr0JyMnpXxgIrc434ysrrckg4aqBbl+MqaNTbOoTup7VjgC3catzj494/VJSwzvvDIodR7RVo0OF1vfxcPeGQ7f1jxObqH67ZIONLwhGd1kXt6PqArfBavN1oSuz4M5GHxx7CxCvmQy0cdjK5XETkNg14dbOJCMxyr4FruS3KL6qRfIS5F2WMyagmn231X1gdaXchKUTDqjWWkl28VDJn4ee8p7pRMYmFoGTtQr/R/5MiVw8PzhG+bUSmunu4fmj6wjJILhB1xrMHslu3e3AOpBLjypTxqXoQbXFeI9oWXrIcfU7Jw/Nc30AA0p9WNLZpHuKrnMX60wo7yS0oUQ7zERQiuBQ0PPY3CzvQBU4ovV/+yvRcnPR7n4fk7ix2RRBiVnHCXjr0xlxojZ2BiYzmlYh73jKqr+Wj0GBtR6K0KLre6pQGT+JGFlcLEFko25Ge3ZEZGNWRAONMrXUTkbLfF+sQny3DutMY253RzWhWAQg4vV2nCyzM2I60wiXISdnvl5C3sUTXSMVrS6+PBIJqMo//Dpdu14/afRuUbQYz/YI/XQi97Kb+LAq8PKdnXGt8gIVmEsMk+yCh5q/fWxOOo29F/0Vgykb37vYB7Qy8uEBoZ+SUmPGlX5mldPnizQRLZlrTHj385EH93Im+mePsjCPXifUYxR3nO6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022113327099003)(261026121527099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3dhK1lrUzhhRXVaVTJRV2tYS2JCdkpFb1FQZTQwQXVXWlpaUmRxb0hYakRk?=
 =?utf-8?B?dXRGZi94TElpRXpTTkJINFNlYWJPWXJqeHhHSmR4elBaeTRQOEtQNDlpWUpU?=
 =?utf-8?B?bmovQ1FVbnhtMXQvK0w4UlkyaFphb1d2a0NYL3lhTFd3Q0dCanlQRHlENmVJ?=
 =?utf-8?B?QndnZXVOUEZoLzh0cmZabU9uVytnQ2IxSER5bTdxcnlZb3g3TUxRbHNMTDY1?=
 =?utf-8?B?SGlqajg3NnQ3ZlhRNG16cGV6WitQN3Vlc1hhVzg2ZnJMZXdXVUttbXE0MDBW?=
 =?utf-8?B?Q0FIMFpQMXhyMzlTS3JXNGhPQnpDWEJqWktNQ2JMYTJSZ2NZMXlqUm5KMCtX?=
 =?utf-8?B?QjRHVDI5ZWsxY2xCZWxSSmovSVpwOHRIN3Z0TGNVbUNDYzgyQmtJYk5kM0dH?=
 =?utf-8?B?dVFXT3JNTWM2OUtia2k2TE15WGxZNFp2SlFUUXNPQXo3b3pWcHQ5MzJjOFMw?=
 =?utf-8?B?WmFWNVh0S0NNaHlXUmQ0YnJYNFFYUGhTZGx3dVJHcjVwaXZjMGc3RjJ0Q1Bu?=
 =?utf-8?B?QVhyeW9ITzc4dFZXdnlsSGFjV0l2azlwNnhRaDRjQkhiT05kVElJMjR4cE9n?=
 =?utf-8?B?ODFVNHdqWjRPU20xczR5R0JBMGd1MS8yM24xOU1JWEZrQUlOUm5XaktwK2RZ?=
 =?utf-8?B?MW5tUDF2RVpkejJUUDZpZFJudk9ORnZuZE9Pd0QrMUd2VlBib05oMzJISTd6?=
 =?utf-8?B?d1dBc0dGODNLTzVVc1RaV2hnbEhtS2NoWklYWlVheU80VU1hcVpPRVhSRVNB?=
 =?utf-8?B?NDFzbjZEUkhlTFd4cS94dXlWWkNBYSs3OXR6WklQSHhwMTMvYnpxRXhON0xu?=
 =?utf-8?B?OXhqR2k3eVI0TTFicjNHbEZrK3FYK0srSVlYSG8zbkwrTm1aZEw3SUR1RFVR?=
 =?utf-8?B?em4venp1WTNWTWFmK040bTJDaFNzSTV3TUNmcUhVREVuV2N4ZHY1RkNCSms3?=
 =?utf-8?B?ejdqdlR4KzFXdUozQUlDNmpEdVhscnAxQXN6TVJwQndhNXZDM21EbjNRT082?=
 =?utf-8?B?bFVxMFAvaE5pRGQrdTdzRnZ0NVlhampSeUdEaVZ6MndHdDNFMkVoQlJBRHEw?=
 =?utf-8?B?S0FJTGphUTFyT0plaTh0VC9mSHh4RzFUb0t5OXplQ1F2bFNhVHlFTzFsaHRy?=
 =?utf-8?B?MDBHOXY5K3dwdkdLZUFNY1FwOE5UTUM4QlQwN2E3R2lCaFFTZmVPVHdDdDBn?=
 =?utf-8?B?Ly9sQnova3locUdCY0xoQ3pwNlJnOGR4Umx1SGw0bmpYRGJteDd0bk03YWxQ?=
 =?utf-8?B?aDhaY2xKUU5xazhtZmRXbGFGSjhKOUdmOVNNdlN2Y1JBVGxrS3hlajRLbk1v?=
 =?utf-8?B?RU5mdldJaDNKQVRnVjRXZWpNaXJQRHErWFFna2R4cXNpZ0RTdW1KWEVCZUZs?=
 =?utf-8?B?ang1TElGaGhTaXBBdlJacXVsTnZudXhzcjhCaFdYd3RRcmN2U1BLbkN2dnps?=
 =?utf-8?B?ME5xdWQwc0ExQVdrZ0xlTGpiQm5heGJ1V1lBdnprTGZpbWJBNWs1cFlrVFh6?=
 =?utf-8?B?aXViV0ZXUTFUc2dsM3RzZVlyMldid0ZqMXN5TGRUVUF0cmNzTFhrc3pBZ01X?=
 =?utf-8?B?Q0QrOTJQWkFHWEJPZmp5RGVJVzJCUkcyVm9zMENqb21VT3VZbzAvdG5QM2NI?=
 =?utf-8?B?YUgwYVRydk5OaTQyL2JIK05pYm1CRTdwaHQyTjUrbm54RW9mVVlZbnVub0Yw?=
 =?utf-8?B?Nk82alVBYVNRU1R3WnJZWURpZFpQOTdGdWtoeVloMFI3Q0xJSVgzd3dKY1l0?=
 =?utf-8?B?Q2h4NWk1WTVuSDB5eWZVUVVWNG14TUNaZ3J2TmdZKzBPY2c2OGRqaCtLd0dr?=
 =?utf-8?B?eGNaVlVZY1QrRXVCRzA1SHR6YnU2TFZrNlZ3R1hjYy93d1lzVFdVTk5tMXVV?=
 =?utf-8?B?RW9lSVp1cExEZndLV25udmdRQVRrSUdoK1NTR2V0ZW05bWZMN1Q3eHVtUDNN?=
 =?utf-8?B?a3g5ZnBsL2pOeFE0T1ZQV3N1U0pFaDM4bnRVZWp2cGF3OW15akNmOXYzNE0v?=
 =?utf-8?B?eGwvRUtralRRanJ6VXRzYUFLaVk3TlRyYWpOaFpXci9lc0syYVo3eUhjakF1?=
 =?utf-8?B?M29TZFoyRkpTaHFHMTQ3a21DVVo2MGFFejlqOHJGenIzdDZlaWZNRmJRdjJF?=
 =?utf-8?B?aWkyT1lPeDExTFl4Z2ZjM25YMEVhLzJQSEZ1SG9CTG9CMzNHSVMxdjB0K2pr?=
 =?utf-8?B?eDNVSXY3RkkzVFpIMTdzdWc2NnhvS05Ea2pSWHBvdnBKTUR6OURvQUJLaXhR?=
 =?utf-8?B?RXluN1ZCTzd1RkdMcjRRdlhUUi91WmowNjQ2cFNnUlQzWTdBYVpDSWZPOTZs?=
 =?utf-8?B?QVpobmRRMzd3VWhGQkRhdmt0Q3lPenJtVXl4QTlxQkFBcjI2UThqcW1tK1R3?=
 =?utf-8?Q?Q2eSzbYTKVWyU1qU=3D?=
X-Exchange-RoutingPolicyChecked: RXs+jy3a765xZahDL2tS6d8ImS9X5uXjVE9H3kvtSa3hxX1qHEF7m4SjuBuZ7mS0QYmUDIihSuf83gIrE3wwHz/1Gp529YUsyAwvzMj1X5wN2k2CjWZslzBF+GIgSCCIkXStIXrzkAq6D2VhS8z5ifsfz+F5JN2mFCj29OdKMEdIFnyYmSrZZSSkw6NxEBz/D7h4BdZxTGWLoES3QKcFl/ThYajg8ITm3mpfA4nnEUkg5arr+A+SDO3SEK6gakupVlP8NvSAMJPIZSUUb3QRLkwosVcpqvrB6SsNg+Bo0HurRRb1DoNNzhaKERplYciGop93Z88ZxlBmcTY2d+WN5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a943371-34d0-4a13-f6c2-08df3a8038f9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:30:49.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE6lpgVX6msGaD+SqfyCcJc/DHYfzrwOIKjD8ILERup9XhtxKvh4qC3oMmn8Kigvuo+UbMgaluANgP8jLb0BzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR11MB9944
X-OriginatorOrg: intel.com

On 03/11/2026 11:35, Paul Cercueil wrote:
> Use the device property API instead of the OF-specific property API.
> This way, the driver will also probe from ACPI.
> 
> Note the change in the core's probe function for SD6HC. We can't have
> named clocks in ACPI.

Do you mean in the future?  ACPI does not provide clocks at all
at the moment does it?  Otherwise, clocks registered directly by
clk_register_clkdev() can have names.  Maybe I misunderstand,
but perhaps clarify the commit message.

> 
> Signed-off-by: Paul Cercueil <paul.cercueil@bootlin.com>

Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence-core.c   | 22 ++++++++++++----------
>  drivers/mmc/host/sdhci-cadence-phy-v6.c | 10 +++++-----
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence-core.c b/drivers/mmc/host/sdhci-cadence-core.c
> index 745455743b01..c5a4fa8e2fc6 100644
> --- a/drivers/mmc/host/sdhci-cadence-core.c
> +++ b/drivers/mmc/host/sdhci-cadence-core.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2026 Altera Corporation
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/dma-mapping.h>
> @@ -145,26 +146,26 @@ static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv, u8 addr, u8 d
>  	return ret;
>  }
>  
> -static unsigned int sdhci_cdns4_phy_param_count(struct device_node *np)
> +static unsigned int sdhci_cdns4_phy_param_count(struct device *dev)
>  {
>  	unsigned int count = 0;
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++)
> -		if (of_property_present(np, sdhci_cdns4_phy_cfgs[i].property))
> +		if (device_property_present(dev, sdhci_cdns4_phy_cfgs[i].property))
>  			count++;
>  
>  	return count;
>  }
>  
> -static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns4_phy *phy)
> +static void sdhci_cdns4_phy_param_parse(struct device *dev, struct sdhci_cdns4_phy *phy)
>  {
>  	struct sdhci_cdns4_phy_param *p = phy->phy_params;
>  	u32 val;
>  	int ret, i;
>  
>  	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
> -		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property, &val);
> +		ret = device_property_read_u32(dev, sdhci_cdns4_phy_cfgs[i].property, &val);
>  		if (ret)
>  			continue;
>  
> @@ -204,7 +205,7 @@ static int sdhci_cdns_set_dma_mask(struct sdhci_host *host)
>  	struct device *dev = mmc_dev(host->mmc);
>  	int ret;
>  
> -	data = of_device_get_match_data(dev);
> +	data = device_get_match_data(dev);
>  	if (!data || !data->dma_mask)
>  		return 0;
>  
> @@ -649,13 +650,13 @@ static int sdhci_cdns4_phy_probe(struct platform_device *pdev, struct sdhci_cdns
>  	struct sdhci_cdns4_phy *phy;
>  	unsigned int nr_phy_params;
>  
> -	nr_phy_params = sdhci_cdns4_phy_param_count(dev->of_node);
> +	nr_phy_params = sdhci_cdns4_phy_param_count(dev);
>  	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params), GFP_KERNEL);
>  	if (!phy)
>  		return -ENOMEM;
>  
>  	phy->nr_phy_params = nr_phy_params;
> -	sdhci_cdns4_phy_param_parse(dev->of_node, phy);
> +	sdhci_cdns4_phy_param_parse(dev, phy);
>  	priv->phy = phy;
>  
>  	return sdhci_cdns4_phy_init(priv);
> @@ -673,7 +674,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
>  
> -	if (of_device_is_compatible(dev->of_node, "cdns,sd6hc")) {
> +	/* Note: ACPI only provides one unnamed clock */
> +	if (!has_acpi_companion(dev) && device_is_compatible(dev, "cdns,sd6hc")) {
>  		clk = devm_clk_get_enabled(dev, "ciu");
>  		if (IS_ERR(clk))
>  			return dev_err_probe(dev, PTR_ERR(clk), "failed to enable ciu clock\n");
> @@ -687,7 +689,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  			return PTR_ERR(clk);
>  	}
>  
> -	data = of_device_get_match_data(dev);
> +	data = device_get_match_data(dev);
>  	if (!data)
>  		return dev_err_probe(dev, -EINVAL, "missing platform driver data\n");
>  
> @@ -723,7 +725,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	 * For SD6HC, sdhci_add_host() will automatically read capabilities
>  	 * and version from the host controller registers.
>  	 */
> -	if (of_device_is_compatible(dev->of_node, "cdns,sd4hc")) {
> +	if (device_is_compatible(dev, "cdns,sd4hc")) {
>  		__sdhci_read_caps(host, &version, NULL, NULL);
>  		ret = sdhci_cdns4_phy_probe(pdev, priv);
>  		if (ret)
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 22d56bb46d75..551a0e3b58ad 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -880,17 +880,17 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>  	 * Cadence-recommended defaults (2500 ps IO-cell delays, 24 ps DLL
>  	 * delay element) that are valid for typical SoC packaging.
>  	 */
> -	ret = of_property_read_u32(dev->of_node, "cdns,iocell-input-delay-ps",
> -				   &phy->iocell_input_delay);
> +	ret = device_property_read_u32(dev, "cdns,iocell-input-delay-ps",
> +				       &phy->iocell_input_delay);
>  	if (ret)
>  		phy->iocell_input_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
>  
> -	ret = of_property_read_u32(dev->of_node, "cdns,iocell-output-delay-ps",
> -				   &phy->iocell_output_delay);
> +	ret = device_property_read_u32(dev, "cdns,iocell-output-delay-ps",
> +				       &phy->iocell_output_delay);
>  	if (ret)
>  		phy->iocell_output_delay = SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY;
>  
> -	ret = of_property_read_u32(dev->of_node, "cdns,delay-element-ps", &phy->delay_element);
> +	ret = device_property_read_u32(dev, "cdns,delay-element-ps", &phy->delay_element);
>  	if (ret) {
>  		phy->delay_element = SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT;
>  	} else if (!phy->delay_element) {

