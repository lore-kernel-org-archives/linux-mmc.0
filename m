Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793280314;
	b=io+UC8DQzBgkzH+hHidkh+K/0DHeeH/4B21ZvneAQFtS0xliwV2zCCVY+mCsQexA0/aa
	 pVbPVkUMwTKGR2Lq/8WKVQp3m9QXOul7SO+2p6o5hH7CmISApHjRiPh43a+U3/KCyKvim
	 lL63NJ/sRg27ey0YE1P739jQgZAupwi6ot2Yv1yUuPGQAyhti6DSEo6YCdecXHopFNLrU
	 GY8RAjRKCGurmesD54FBZYU4X5F+Cfpkr2yTJC/BQChRPxniQq/hYpsNeaIi3cWqg6Oyu
	 fs7iF4BcxdXrd3BOi2Ey3RzLxkHkzh0uruZuzvS1rdpcUTWHvUeNQTZdJxCISefslPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280314;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:
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
	bh=htuj56gqd+oZdr3rbWMV3CoQfrFVMo9vSUu/WYm0EzI=;
	b=PKtZ8p7COfqaMWbB3DCNcWVG80UZR9oaumq93qWhSEY031x6oX3b9hX1Tn3tKBAJEUtd
	 0UkFL1yz/sjhXBIlfjlMpaiVLaIfNeQchmmx1DpFuF1sVfswIIVd8xA41QpgWp3FBImCu
	 InS0dCIcIc9EUCdtQH53mK1dPacsiyIe/nwgZ4CPXkVjdtGsq+YXy0kfO3Rmt3WkVZTdZ
	 0OMl9/dF+i04hQ0HZo3V4y54uubKIw54V3e2MqwxU5UQPPuShOas6s7XDyxUOmtXBRDSH
	 D7VicW66WogRZDKXih0JfXkovgN3bgKzdST8wwQ+5ztsaL6hJs8XJMIWXCfIpR9mwwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EoknjCm8;
	arc=fail smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF0606A31A;
	Thu, 29 Oct 2026 13:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DAF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EoknjCm8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793280314; x=1824816314;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=3pm/nZcTdlsoleYL9Bqbs+LpAySeIck8gE7IhHEpAJ8=;
  b=EoknjCm8kA2ek5WJy+PNc1Ga/nEubqBUGILAycf+9+C8EF68ShqbzSNN
   WGugWYtorYgl83OUpHUnABLPyCIrx0e0gMMO4MWEJMaXCd6QOIEoDd+1M
   lFE8yX3M2bdTHY9S8g0ulfB9t10CT+NFcwIvFfslKLgaaNsAfgZE8PZ3/
   TZDsKmHXpAEzes8cB2wDAa2jFe/WNnbJV7ZS3nyFggjTwM0kenBzUkilf
   PPUNfsD9PvfpVaZrQLYMpre89PhcXQuFltMDy2wK8bEDUX79WAyiJzc/n
   d7gcqj8SvAhRt5tsB5dTEoK2M7IZO7f+zQ+6wh/Dr11G27HcrP9s8lluD
   g==;
X-CSE-ConnectionGUID: 5Uk3o6b+RzGEbJ4j1QFqYg==
X-CSE-MsgGUID: ecG/sqJHQZKY765GkVE03A==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1905506"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1905506"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:25:13 -0700
X-CSE-ConnectionGUID: hfbBv2CISIKl9z5mrSJJGQ==
X-CSE-MsgGUID: E0uhXu7JR+6BqoR1EhtP7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5156628"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:25:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 06:25:12 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 06:25:12 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 06:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1uuHAIXl2C/YeGTmAE1LzEItWg2BsQ48vqHQgmalD1Zw6aWliLhd81HPqPbTVyoVq6uMylPLETUkFLd5ympQBgbMMw7sa9as6MRhBZlL8z8mfKA2v2TDdfguIl6vV7M6C4FaD6BY5g3yYt8ybrS+AtgAv3YOQmWap5fZnoa5aJoBhPjFrXzv0yV+aUvNZaU7vHT5IM81S9ZaIpQu0pYDHbPm1PJ0Bqpt0Ow+doumO+fvmTdYSE1dZS+u3YPp8eEeWxQ5VdSBwmTHCH0hXxtnx/VcOeCOru9j6/urmhhkg/+EF3WrL3n6S8Ya7DX1fwZ+pvsnO4M9nTcimWkUV50EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htuj56gqd+oZdr3rbWMV3CoQfrFVMo9vSUu/WYm0EzI=;
 b=P9bnCXAuu+Pe6w0PuO63u7a9mbDFFVa2PxP8/uR5WKbs6abpwGe4EsYHCsOUqGXBOccfX9KE2podaFjySpkQpRKInPwZgHE/8m4C2rvmw5o40iZibu0esmsJh5wksQjo2rfYYVAN6yvXuV+QYl/6w8jrDvA7rXDT5hyVrmUI0XbCryEpgvRmIWJJDWTK2IMClSPc4rqDTt/Nz08y9RVVRh0bDYb8mnObdJQWXytb6pSCzkNaSoT9ul5SD/wXSSH98aNR8TxnhJeH0pawn76ZiUt8ebHnrkM0TJjjS2d+o2zfwigbmDthyKROuWwUioryMUjooSSoOI8arc8FO6YFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 13:25:07 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 13:25:07 +0000
Message-ID: <16c32323-0869-40b2-aabe-81727c87bf35@intel.com>
Date: Thu, 29 Oct 2026 15:25:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mmc: sdhci-cadence6: read SD6HC DDR50 tuning from
 device tree
To: <tze.yee.ng@altera.com>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <cover.1791459448.git.tze.yee.ng@altera.com>
 <295b570ed26d727c4bd4ce943b723c6cc959ca71.1791459448.git.tze.yee.ng@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <295b570ed26d727c4bd4ce943b723c6cc959ca71.1791459448.git.tze.yee.ng@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0008.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::25) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ1PR11MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3e43c8-ff86-455a-6fb4-08df35c00cc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|4143699003|56012099006|261009223027099003|261021123027099003|261026121527099003|261021121427099003|10067099003|261022075727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: UkCnrqvO8iglJv7ZFf29EdxTjNJ2HB3R/n3y4frzkMD7L+aVXp8sOjKY/Ca15aYteVN0ddvjL13zBlVX1lVmBV6/HfVsRk2sZafzZuwQ7Y6eMniQIWadp00jEVOUjfXjTuf2dkHWZOFdVOdp5pP1HokHnyVE6W89wviPSVQWE75NM8Defq6zqozXY+YcPxdP5XOPu+mkcr1o1sPX9YVUo0gbZ264tOxiXLGA7L+Cvq6kO2cHMTuYfukMdpEdgR4FzQ5YSfHFdrOi4WhKkXE8Ov2znujEP9hrPDEJyYulRwytD75Zh5gYfwhGOISpVA2cYj2d6GHBarAZX7mlzHZ84eAKpEJfV5cULB1kdigimeri33LDZofCx+yEoN4kcmWfi2YwxKWzJU2tnsYKyz9cAESlHCyEHOqGIuqbeGdcy4ORPvMHaI3zybh0ds/tlz7oOJGGIhbHmQq2bp1mNOtB7wF0AoOiWZ/CpWHiMmr+9FzHMpOa2MySn1bqdL7l42TW7ticXfJz+30IKwwaHlkvS5yswfFoPfYz0fEXLOXZEUOlDcZjx400obUWZI3kZ68YjlQTgld8Bu8nU3MLMaNBQSKT0VTkNEBh33fUIOT6xQon56MJLDZO1hL/QfSiqKNRZTxtzplQRYMKXC9Y/i78DOMnt52pH8mFikqRjGnfjZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021123027099003)(261026121527099003)(261021121427099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUozMmVZRHJDSmZrNUd6cEpDNERkYW9sQlJtR2Nrbmh5MVZhWGJKOTBZUWF2?=
 =?utf-8?B?NXI1bXlxSDJ4VlhWSHJzYk5KcW5RNWtERld5UG55L1VnODQ4RThQYTdtT0FE?=
 =?utf-8?B?QjlHVndPdW5pRi9iREdYWHFNeGh5R3c1QUp1U0thbkh5cVNvV3M5K1I5L2hW?=
 =?utf-8?B?SStBWkFFdlZNTElmMS9KVGJwN2NKU0ZKOWlXV3B1cm5YVy9ZU2NYNDRlcUI0?=
 =?utf-8?B?MHFYNWxGNG5IUDJWMTloTk4ycnpOZjVKSjU2THZocUVlNjN3Y3RZZmJCaU1x?=
 =?utf-8?B?ZTJZNk9KMkVCQmplQU94RVdaSHU5WDArUHo4bGV1ZitpUkRDVTdsalFkaGZ5?=
 =?utf-8?B?OWRLYmdzakQ0L3grQjd2SUdydHg2eWp0bkM3aG1nRDVSQWgwWWxmR0xYREFy?=
 =?utf-8?B?OE4vamFyTjlkMm5Ec1FTWHhFanhLc0RWMEcvRklRTXZieTJGNklrK1hNd2N3?=
 =?utf-8?B?S0hlU3JRSFdZeUpOcDlpMHBqNktuUnF0NlJBcUEreTNESnVXWXdxNmVNRmlr?=
 =?utf-8?B?WEU1alhxcTJ5a09Hb0hYQW0rNEx1SDBwbXZTTkw2M1pWV2JFQU9NR3oxN3Qx?=
 =?utf-8?B?OVNNL1IvVHUreUt4eCtILzd2VUV2YmUzOFBQc3prSTVjZmdWSytDc1doeVBQ?=
 =?utf-8?B?SFg0RHVDQTVjaWVKTmRIaDM4NHp0WVNxQUsrbE5ySC94a2pyam5ZSkM5bXdB?=
 =?utf-8?B?Z2ZaN2FscEFYWEJyblFGc2U3dDNBT0dzSzQ4K3F4Ym41L1BoZVN5MzJVb3hs?=
 =?utf-8?B?M0FpSCtuSDhRUWhIbXN3eGwxcG5veG5FSUkweGZMODVuVFNXRTZkWHVpaTA2?=
 =?utf-8?B?NTZQM01xbmJSMlBKVExHOG10RC94UDQyZGY2R0VvM0NFOWgySVRzZWVJRUJh?=
 =?utf-8?B?cmNLKy9lLzY0SE1ZMWJGR01DMG84bGF3R3B6MHlnQnFXcHUzazNUSzVwbzJE?=
 =?utf-8?B?dWJpZUNXa0Eya0gwcy8wNE1UTW11QlJCSHZmU2d1c3JWZnhIOTJ6NW9aR25D?=
 =?utf-8?B?MzdKcEVHV08zcSt3THVuQWkvamFCOS9xTTZVNlA3UGNjYWcyMVpnRmtBYjky?=
 =?utf-8?B?Z2JRaUtBa0hkUzU4cDZPQ1ZCNlhBWWRMeng4MWgwMnlmMGsrY1NFSjJ2WUZV?=
 =?utf-8?B?bUd6eGI3OHhhOUoyaTlkaFF3VTVWdERxZVYzYmhwMWtjVCtWSDFSRHJvMEZt?=
 =?utf-8?B?clpwcUV3Q1g1QytHK1A3TC9RMWRCU3RtSGp5TGM3RU15VDNsUm1CUmwxcHlz?=
 =?utf-8?B?L2todWdKZUE3ejdDYTg5bGZNNmVHSmRsVUxzNjhzRjhmOHZSZlFtY01saVdE?=
 =?utf-8?B?d09scG5Ucys5eVpmMEdKWG9DdEVjcU5JZEM2bHBmdThjeEJpYWpYS2JncWYv?=
 =?utf-8?B?SUZldXd5ZGVvN25FRDRCSG9vRVRIckptSnNucDNvSGdDVXpzdWU3TWM1R3BQ?=
 =?utf-8?B?SXVmdUVweit4TmVHQ3ExMmFzYlBqKzJMNjdDb0dpY3NsRDE4TmR6TE5aU2ZX?=
 =?utf-8?B?VFZyQzhYNTZMN2duOTYyWGFpTG9VbXRJeGxMSnhVcGhJbXA4dDFsNzdVUkpv?=
 =?utf-8?B?YStPanlBNUZQSmFEVC9VSkpSeUluWmhaWTREV3VDREZpRk5jK3I5WWNEUWIx?=
 =?utf-8?B?dXM4bnQ5b1g0OUhlemNPUXdFbk1OWTFNdUttWmZYQmVFZEZVS1ZRRE5FZ21T?=
 =?utf-8?B?bHgxWXhrM0J0UDNnbmpXbXlZak1PcGc3NThFLzhMUVRaRmlTNWsrMlFwbjk0?=
 =?utf-8?B?c2N3V3VySURGS0ErMEx6T2h5Kys4M2ZwcXRFSC9JWEZQdDhDc2w1RzNoUlcr?=
 =?utf-8?B?cFVQWmF0UkNhS2pOckFtRXlqSmFFM25hM1pNZEZjTkQxVGVjeHJYOUxsR1Yw?=
 =?utf-8?B?TTBWdFgrSnNibXdDRGI2UU5qTDErSTlvQ29HUFl4OUJsSU1FWFlnaXo3RjRQ?=
 =?utf-8?B?RjgzeDJMNFNpc1pnMm13dVV2VWJPYWlCcXdoUmVCSEpQV3E4MzlYb1hMcTdR?=
 =?utf-8?B?RWp1RGFxZnczWmNFNENwSmlQdk4vM2RVSnoxci9UeGhrUytyZGIrSEdLVjZx?=
 =?utf-8?B?bklMQ3FRc2Zid2pZZm0wbXNsM1hNNWNZM3kyeXpEcWE0alhzRXNRckUyMzBE?=
 =?utf-8?B?RUJyTUFBeE1hTS9idWk3VDRLVEhObG94MzBTVk1CRWo0bGZFelBhVXNURzRS?=
 =?utf-8?B?bElvUUFoY0VlWTZ4MDZWNy90N1VvWGUvb2xKM3FmenhUQ09hcHc4Y05MYnRY?=
 =?utf-8?B?MnExUGxtaWlWUTRnQWUrSXowME5qRXN4ZlY4SjZyaFhhQnFyWTBaUzROTXUy?=
 =?utf-8?B?ZXpTRHNPQnhzR3JZajkvem9PVnBqWGxpKzJiL2x6emw0QWx1aVhBR1I4TGkr?=
 =?utf-8?Q?U5QInrwFrX95GOh4=3D?=
X-Exchange-RoutingPolicyChecked: SWc9TcUTTZ1IX3EBHp7qNtl/kkexXrE2G6s7PigZeR09aiyIM4d99iLJWDoctEWwyKHihVFEIbNZS9+W52XKmMFADCzVLyGqjU75R8L9en50Dr0IPYt97dmvclwK2mYK9imp7Hp4kd6dAZuSkCslknj2SO1QLxqs/J4Nj3dUTCWydBSNJ7Xc9HW4vxLoH1WEAaoynsN7IwAUwr28z5v1s7EDqXEiMz4kxEo8NgLmMWK2204sXe6KwDad3lFLFatUCogZst70zGZYMS/CvbJFt027otV3gJ1x0r+EiZ5+G527NVDAg5Mon/7b+73cqD0L9MYVw653nLzsGw9MfSXPgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3e43c8-ff86-455a-6fb4-08df35c00cc7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:25:07.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHHWEULwLwy/E5+TsmWtVyA16sWZ4C2l5KQqmNH8mhPZsAEc6D/dhWtpSqGOKph3BU3Vv6Ppygvn9bqWhihWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
X-OriginatorOrg: intel.com

On 09/10/2026 05:14, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> DDR50 has no CMD19 tuning, so the SD6HC read path relies on static PHY
> settings that need board/SoC characterisation. Read the read-DQS delay,
> read-DQS source and phony DQS assertion timing from the new
> cdns,ddr-read-dqs-delay-ps, cdns,ddr-no-lpbk-dqs and
> cdns,ddr-phony-dqs-timing DT properties at PHY probe and apply them in
> the extended-read DDR modes (DDR50 and DDR52). The read-DQS delay is
> given in picoseconds and converted to delay elements with
> cdns,delay-element-ps; since that quotient depends on the element size,
> it is clamped to the 8-bit PHY field maximum (255) to avoid wrap-around.
> 
> Loopback DQS is the recommended read-capture path and stays the default;
> cdns,ddr-no-lpbk-dqs lets a board fall back to the fabricated phony DQS.
> When a property is absent the driver-computed value is kept - for the
> phony DQS timing, the value derived from the RE# pulse width
> (REBAR_PULSE_CYCLES-1).
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v2:
> - Updated patch title to "mmc: sdhci-cadence6:" since it touches only the
>   v6 PHY.
> - Renamed the properties to cdns,ddr-*.
> - Read cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements 
>   (dividing by cdns,delay-element-ps), clamping that quotient to the 8-bit
>   PHY field. (Krzysztof Kozlowski)
> - Read cdns,ddr-no-lpbk-dqs via of_property_read_bool(). (Krzysztof Kozlowski)
> - Dropped the v1 per-property range checks and redundant FIELD_MAX() write
>   masks. (Adrian Hunter)
> - Apply the overrides in both DDR50 and DDR52.
> ---
>  drivers/mmc/host/sdhci-cadence-phy-v6.c | 59 ++++++++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> index 8d6a9c26c139..2b1b7256731a 100644
> --- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
> +++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
> @@ -129,6 +129,11 @@ struct sdhci_cdns6_phy {
>  	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
>  	u32 delay_element;
>  
> +	/* DDR read-path overrides (SoC-specific) */
> +	u32 ddr_read_dqs_delay_ps;
> +	bool ddr_no_lpbk_dqs;
> +	s32 ddr_phony_dqs_timing;
> +
>  	/* PHY_DLL_SLAVE_CTRL register fields */
>  	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
>  	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
> @@ -145,6 +150,7 @@ struct sdhci_cdns6_phy {
>  	/* PHY_DQS_TIMING register fields */
>  	bool cp_use_phony_dqs;		/* bit [20] */
>  	bool cp_use_phony_dqs_cmd;	/* bit [19] */
> +	bool cp_use_lpbk_dqs;		/* bit [21] */
>  
>  	/* PHY_CTRL register fields */
>  	u32 cp_phony_dqs_timing;
> @@ -523,6 +529,16 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>  	if (phy->mode == MMC_TIMING_MMC_HS200)
>  		phy->cp_read_dqs_delay = phy->hs200_tune_val;
>  
> +	if ((phy->mode == MMC_TIMING_UHS_DDR50 ||
> +	     phy->mode == MMC_TIMING_MMC_DDR52) && phy->ddr_read_dqs_delay_ps) {

The same (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == MMC_TIMING_MMC_DDR52)
appears 4 times.  Might be neater to assign it to a local variable.

> +		u32 steps = phy->ddr_read_dqs_delay_ps / phy->delay_element_org;
> +		u32 max_steps = FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY);
> +
> +		phy->cp_read_dqs_delay = min_t(u32, steps, max_steps);
> +	}
> +
> +	phy->cp_use_lpbk_dqs = 1;
> +
>  	if (phy->sdhc_extended_rd_mode &&
>  	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
>  	     phy->mode == MMC_TIMING_MMC_DDR52))
> @@ -530,6 +546,23 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
>  	else
>  		phy->cp_phony_dqs_timing = 0;
>  
> +	/*
> +	 * Loopback DQS is the recommended read-capture path; allow boards that
> +	 * need the fabricated phony DQS instead to opt out in the DDR modes.
> +	 */
> +	if ((phy->mode == MMC_TIMING_UHS_DDR50 ||
> +	     phy->mode == MMC_TIMING_MMC_DDR52) && phy->ddr_no_lpbk_dqs)
> +		phy->cp_use_lpbk_dqs = 0;
> +
> +	/*
> +	 * The computed phony DQS timing above is derived from the RE# pulse
> +	 * width. Allow a DT override for boards whose flight time shifts the
> +	 * returning DDR data relative to the fabricated strobe.
> +	 */
> +	if ((phy->mode == MMC_TIMING_UHS_DDR50 ||
> +	     phy->mode == MMC_TIMING_MMC_DDR52) && phy->ddr_phony_dqs_timing >= 0)
> +		phy->cp_phony_dqs_timing = phy->ddr_phony_dqs_timing;
> +
>  	if (strobe_dat) {
>  		/* dqs loopback input via IO cell */
>  		hcsdclkadj += phy->iocell_input_delay;
> @@ -693,10 +726,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
>  	sdhci_cdns6_dll_reset(priv, true);
>  
>  	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
> +	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
>  	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
>  	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
>  	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
> -	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
> +	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy->cp_use_lpbk_dqs);
>  	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
>  	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
>  	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
> @@ -878,6 +912,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_cdns6_phy *phy;
>  	unsigned long val;
> +	u32 prop;
>  	int ret;
>  
>  	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> @@ -916,6 +951,28 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
>  
>  	phy->delay_element_org = phy->delay_element;
>  
> +	/*
> +	 * Optional read-path tuning for the extended-read DDR modes (SD DDR50,
> +	 * eMMC DDR52).
> +	 */
> +	phy->ddr_read_dqs_delay_ps = 0;
> +	of_property_read_u32(dev->of_node, "cdns,ddr-read-dqs-delay-ps",
> +			     &phy->ddr_read_dqs_delay_ps);
> +	if (phy->ddr_read_dqs_delay_ps / phy->delay_element_org >
> +	    FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY))

This is still effectively validating the firmware values

> +		dev_warn(dev,
> +			 "cdns,ddr-read-dqs-delay-ps %u too large, clamping to %lu elements\n",
> +			 phy->ddr_read_dqs_delay_ps,
> +			 (unsigned long)FIELD_MAX(SDHCI_CDNS6_PHY_DLL_SLAVE_CTRL_READ_DQS_DELAY));
> +
> +	phy->ddr_no_lpbk_dqs = of_property_read_bool(dev->of_node,
> +						     "cdns,ddr-no-lpbk-dqs");

Unneeded line wrapping - can use 100 cols

> +
> +	phy->ddr_phony_dqs_timing = -1;
> +	if (!of_property_read_u32(dev->of_node, "cdns,ddr-phony-dqs-timing",
> +				  &prop))

Unneeded line wrapping - can use 100 cols

> +		phy->ddr_phony_dqs_timing = prop;
> +
>  	priv->phy = phy;
>  
>  	return 0;

