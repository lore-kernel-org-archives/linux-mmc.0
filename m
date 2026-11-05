Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793859522;
	b=IYtmE7oTgBXjjY8V3h7lm+XQiaz1Bh5gc1sdLQEO94eooc5+Z4L8bdbmvmi88lFzffkx
	 PAvmvoJov7jTU8XlE+uW9sz9L9IKr0SemeBcRYlGdLB7sDAexAS+YQ4sUVGXZHXjU+RF5
	 dsQBQKyPZ8acQbEk/IV0x0ngI2F8ugzW23eDpwER8slQ6gsE4uPawfN8owIyyjsyh10zb
	 VEQihVAiJK/IUOWDeACE1DH357PSDc/6xaUXnya9Vr1t1r12erO4gIV0plosvnN5KKADj
	 N5PlKK76aC9EmxZfM1Fu2BW96T7b7zk2VhAPMtJWeE14wXQck5fWarPQTPMric6+Hrg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859522;
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
	bh=3eyNJ/AkOWzyl1nH1W2UxU+wVXiUi+JC0CGMG3ETNVU=;
	b=DVUuml/z3iVz6puCDgsq8zV37p9K6UUufli3jr9ptWI7h8EW/tnhPQZfeutcDVJXZPQ7
	 cAGqDnecshpLEPmbNX91G25b2FTy5722hk1FHs+3V/paQj6MoALCv1u1XYbD5YCxsNRzs
	 RmrEkpJ5SCJLSxN8SkKMbM3g4nzDz1s9iTT2Dk0JyI3WbQpDKrldCzZt2L1ydRFlmQYce
	 J54WNxFxdSyGyfckv7wpGhVyghEdWOeYP/p76zhM4Otx2UAYEEkoLR3hrPuiacJ8pr7N1
	 yPsTDJqlVIaaC8SCA2x7R+yoMdXogDA9Ub/KLzQH8nX0Dvwyw9hlzl2HCRzoM69XwMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ALKsTji7;
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65298606A31B;
	Thu,  5 Nov 2026 06:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65298606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ALKsTji7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793859522; x=1825395522;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KaRt2+fPLwXhiF/d02efAoKSI9fpOSDOuep6LKTqWUg=;
  b=ALKsTji7EladF5kaaVcsg6gOCC30N6yaFpTdmd3AYLsToOnMo12dC5cP
   bvHMfErc6vAEeFQeDXpFI0uPgfgB21P79SzUgb4jhOtV1/BeS4y+hxfTC
   NH+j0H7uPfgE3YKzzahQ648EY8HiQl3Nk3tsr9LkbviTnk7BYb4ZlKJq0
   h3HgvUUOeootdsEZthLCDr6fdkydF4X+MfNMYVhkOg+4u3xHJ9nCbZ6W1
   tMRVKjFeWAxvfWAaCWR67+pUvomx/9/L0tqxIWcCC6ypIQMLIhVlV26PW
   /G7Z+88Bg203MND5d+h3CiOegPSV9EyBS+fBZlCBWbB8mg5c5Yzu5Vr8J
   w==;
X-CSE-ConnectionGUID: 1Na6fc46SDGgtSv0ITADjg==
X-CSE-MsgGUID: 3NbV9uaEQZu5nLkJQhX3Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2523534"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2523534"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:18:41 -0800
X-CSE-ConnectionGUID: 3NBMNaY8R5+MuNu40YNjSg==
X-CSE-MsgGUID: Mn8jhSFFQHWI/1/1WZoFaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7252239"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:18:41 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 22:18:40 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 22:18:40 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 22:18:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmDGm7As3Gj9fbNOtsFsoeBmWRgx0l9c78aTqPwnZsY4wc5aNXbK6cIZX9BKIXT/Soe4JKKKFS8WxPdaJOUAJSGWgbC4WYLu+16bNIH+tCi559AUByvyFyAiVS2FlNa75y8N5pO1BASPHke8wmBUBf6wlU9pMSPR7rFuYAmCiYUrHB0xfJkiFvCjab9mywDhD8dC/4Oe4VLG57B6c0FxKJShe6jtYkpn5z1UOVarv0IPAd1mM4o/h97Ar968CPhLMMdH9KxkZCtNC4v40qf2bJMb6al4XQP4BzbVLCu3U6YXT6zfjAhK8KinC/1D/9YiBay0ZcaeFhuSNUEHzSMUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eyNJ/AkOWzyl1nH1W2UxU+wVXiUi+JC0CGMG3ETNVU=;
 b=n1fqQFJvFl/EF1U18bcY+i+kAVWKJIri7t7AVPrH+jQtXS3e8WHeDTmwMHlZX7MZvI8diGaYr0TymoNbLiBLiNV6chAljh8H0iCsdvd0+2eMFHS8Uum8ajCGq0mFGdNZt0zKO/to2qWUJJqJdcqCvuhI8VQ7Mr10Dz+C4BSB9IutXVf5wsel85glYVoPrQL+3c9OdERshj3UY+7ehhIXYxdAHqKcuU6x92TPEqHUNB8yCgqVGpydWkSO1YngZVID54afTVXYbO2QarbU8r2lc5KUgNXLZvqp8NVrmMvurgrs3ctNGhON481tHfEwWwMDu3m5aqIH0Swlra2MpuFQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH7PR11MB7962.namprd11.prod.outlook.com (2603:10b6:510:245::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 06:18:37 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 06:18:37 +0000
Message-ID: <9915e470-4a36-4ff4-8240-12308e7ac7b8@intel.com>
Date: Thu, 5 Nov 2026 08:18:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Add Genesys Logic GL9768 support
To: Ben Chuang <benchuanggli@gmail.com>, <ulfh@kernel.org>
CC: <SeanHY.Chen@genesyslogic.com.tw>, <boris.chen@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, <ben.chuang@genesyslogic.com.tw>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261103101622.213425-1-benchuanggli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261103101622.213425-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::9) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH7PR11MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c3752a-0d5d-4968-ecd7-08df3b04a0b7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|10067099003|18002099003|56012099006|11063799006|261009223027099003|261102123227099003|261021121427099003|261022075727099003|260925021911599003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: M0XkNzE3HKwWcFWzLKT9/wtm2gm4xUx57hwH8dzZHu6p5iBOuJRu/8F6bVMd6ROtedEBEOMFsmQdvAXe+QWMn83op4aYALvCIYdT6Yr04GeLHOW5u0sacUO7kP6KRn7NVh5qnsL31m24L/qO7tat6f+ajMnCaUlPO7gHUfqw3wgfFryyxaTNyd3q34KT44RTj+zGvlsjfpodT6Rpg6vjjQoEhrIu7MCb/Wks/aqJlPmpwSjMiEfKclqtAXDVFjuIFy409lowssZwZn92yOtpxBIAV9Z8FM+l5aV9hAj+CgAA8XTBGyGx/5OHzti3iaNl6CkkTwy/ScO7m98wdC37baoLM40e4b40ZmgeXdL7i8+DybTbTvU9ufJx0OqpZRh6BvtfeuUEHNAQoYG0h37ECK3SyFGrXN5d0MJ5COV/WDJCxGKE8GRlnrp9hKRaIFn/UXV4xqzA3GEnl8vKT/SCjpGBmSew1Bnzjp9m5TFiNnp85A9ZJpnxXnw/9rRWUfDBvEpQLizxlH2NyHj21/++GwSHB+Fjtl+0axo7aBSos1FwR4o2qwQaS2JJ+rXsyY4qpMtW/BDT9IweDbQ9jBJ+RRkLNMWWJlsMfSATQyBBatOIDk7e+U7Tm2EBgiFGaFXMdT9G3eYrvRrVkB38YULy/daw9rvCWj3os5LYbnQygwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(10067099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261102123227099003)(261021121427099003)(261022075727099003)(260925021911599003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yms2K1g5NWpISVJzVHZ4RlRmWkxQWmt1WUZsOElMb1Vhb3ZkV3I3Q1l2Q3JM?=
 =?utf-8?B?NjFML0sraUNZQUo1TGlMYlY0bVczVlJrZUpRbyt4cTUrQThPSllULys5aW1r?=
 =?utf-8?B?VFVsY053U055UkNRTi9NaUFTTmI3MFc3aW1iNGdqZ2pYRGVBNStTZUJub3gx?=
 =?utf-8?B?Z2Z3ejRxaTNQb1FVUHB4Y2dtbzJ2bVBDSjZ0WWhQRldhTCtIMjNFMjlSVkZH?=
 =?utf-8?B?TVUzbjA2cUJEaWpzL001UTdkOGV1QVcwR2hHeGJFTU5jOUUwOUV1WmJlbHhO?=
 =?utf-8?B?d25nOWZQN3RCRjFZSkpYaHNydDhYRGp2NmlYbm1MNDVxOXdRc3RBRkhIazlG?=
 =?utf-8?B?ckdlVkxheklYWlZNRVNzNE5CdTB3WS9UejR0YmEvTk1JVTU0cEhxRzl1YXBS?=
 =?utf-8?B?SGlrcU1NK29qaFJoNTFCYXNzNEFJbWRQNzRjUFlvSExxV0tqWlpENkk1UG9V?=
 =?utf-8?B?Z2tWYk1KcEg5VjRQVU1XOVhBKzNmZTQ5UkZrdFd6dVZzdk8wQUcrVTBCcFMv?=
 =?utf-8?B?cWFFcGxWYk9LRGV6QUx3QlNEUVcwWjNzZUtyZ0lUK0FDNFkxVi9JV296bXAx?=
 =?utf-8?B?RDVuV3hCRW1jUDdhU25NYXB2Z29TK3VxK3FYdk51S091R2R0TENKcXlncEh3?=
 =?utf-8?B?WkYwd1ptWkhRckE4cVI1bVhJbVd2UjdaMVhBc2NVb24vMjNzTEMwVjhPbnVh?=
 =?utf-8?B?cDlKUWV6LzNLZVZhditvUll5RDluc0w3YklQSnJQbDZpODJPZkFXNUhRa1hu?=
 =?utf-8?B?TEZ6NGhOTDRHeERaNk9YSXQ5OHZ0YUNDYzFXdlBFSmlMZWVxZ1lCZDlnM2Nz?=
 =?utf-8?B?R0dVbDlUMTZxWksvRHpHek1DZzBZOTdtZ2hJekRuRHdHRmxhQVZLQlc3KzZC?=
 =?utf-8?B?czRjR0t5RFlqYkh3andnQ3VLUVliWFNXU1N1eTYvT24wT0IzdmNDaS90Ymt3?=
 =?utf-8?B?UXFIbk8vNVdqaXpEdUNwejZ5QkdaVkwwTDQ3ek83V1U0aXVWbVFZZ1l0U0t5?=
 =?utf-8?B?cDByRTBPeUVZQytKZWJRMWNXdHNoSG9UUS9XZEtYcjl2dExVU1NTS1BTMEtF?=
 =?utf-8?B?dTNiQUc3dzIrK2J6bTNvMWZIQ3pyT2lGTHFnckZFckVTVktXbEdhZ2FMNE9U?=
 =?utf-8?B?UVJjNWZmaVQzZHNGK3NnSVpQUDVMWU9kUUdjRTdpUUFWUkJWSzRqZ1FNMXJK?=
 =?utf-8?B?cURqYXR4VlNSOTNpQkRCNXMrR0M3V3VvOVhaeTVSZjVMWFN2MENGbjU5N2w3?=
 =?utf-8?B?cmN3TThPNFZGdEVSS2lVTVNIdWNMWk52VU9PdnVyUzM5VGZ0RWpFN0o5aHdm?=
 =?utf-8?B?eUdxT1cyRjhCNVdBZFk2cGxOY0k1UitWNjZUZGZuVkMyVXg5VlZOeFlhVDNl?=
 =?utf-8?B?NDhmZ2ovSGl6aG5oZk1IZ1JMNStNTkcvZTlucjc5c2RUWCtoT1ZzSVJIbTJS?=
 =?utf-8?B?TFNhdzJCN0oveUJramJXODNFTGNDWU9FSlBuUDJjR2oxSXRKVEdENmhseTV4?=
 =?utf-8?B?VGdodW5zMmozWXl0WkRJZEpZemU2cER4VEtYRWwweWNXY1hOOXI4VnU3SkZZ?=
 =?utf-8?B?M0xVMlk4bk9ESHdoSGJNZkdvbkQ4ZFh0b2VrUGNLbEFWdVExa29oWXVhSXFO?=
 =?utf-8?B?MGNVVXJXMDk2SE5rN0EyUDFPYTg1dTkwTVpqUExkeVp1WmovTmFGanNjYnRx?=
 =?utf-8?B?OElJL2d6TGxNUnlkM0xqNFRuTzhsWnV5QzdWcHl6SGJRUk13Mng0SFhIZWdV?=
 =?utf-8?B?SFMyUjk4NExtRzhjb1ZaWjIrSHFsaVYxMEhGZjE3YnN5YjZqdUNyV3NRT3E1?=
 =?utf-8?B?cVdMTU5MSHpYV1JBWEMyYXlxakhXUnpVZHNuQU1HS1kwTkJQUTFsUGlrd1NY?=
 =?utf-8?B?cDZ5dzRLbFd4c0dYTGNSMHFlblc3MHpTUFVaR2hBeHRGWFJuMHVHbW5XSVZn?=
 =?utf-8?B?MFNvNW9ibGppSVVRK1hrdGtXdFZBSVNoR3hhTkV3Wm5rcWZCejRIeHJwQ3hO?=
 =?utf-8?B?YmJ1Z2p6VE5GUVMzRi9ubGQ1YUhjeVdMSllJZ2pqeElYeHhLb2Y0QjlIOEd5?=
 =?utf-8?B?eUhqbjNlNG1mbGNBd1pXbHBDTFdrTVhKY0lhUmx2aGxIVitUaWdXd3RlYTVs?=
 =?utf-8?B?emEzbGVWYWRoL1JxeGp0OEFDZTNvaVRXenhqWWUyOWRvRU13ZzB2dHNpYzVU?=
 =?utf-8?B?eFJqemppWE56VGpCZ1lNRTN0SzJ0SzFZenNIbWVUYytCbmJhbFJuTHRmTDRP?=
 =?utf-8?B?eWVEYys4M1QzMElaMEpXRGVTOFQyd0RSdkFWNjd1YlhLa3ZoZ0pjYUZnQTU2?=
 =?utf-8?B?NVFUUGJWNlJWZGJEV3NXbEVFM0Z2QkdVSTc0U2lQZ25hUGo3SWFJT1V0NUVt?=
 =?utf-8?Q?q5aCY/rIoRYVx7VI=3D?=
X-Exchange-RoutingPolicyChecked: Uj4NtDKDZzcfG8lHo7MhGEHxUYy6gRrBGtRZR2MLifzqxK4BoavpDOGizBnVrH3WPzFbusVFOL6AG3L++t9C6p96Xy10zcKTLMyEiTUTDUlkGvaxzngFtQQE3OkLGlqKY+B3SmBBsHMP3Ng01+5bSUB8PPMuBuAJXo4HlsRnF0XI8OmV2SNq8f99EGVKBoZmgAWOBfX05Kej/duzvHI/qurOkGWA+jeWl3YMEkrLAViC0zTFMezpjt0tR74fVevw88MYVpg8UFXjeiyGd+B4e4tz9LlZeEsvAMR9tcqx505ZQDnrb7sFmQpTeNCz+IYGFtSdkwlH3oE+nSdSGxfjzQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c3752a-0d5d-4968-ecd7-08df3b04a0b7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:18:37.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEokOFXEsZb10qfi5vZ8qPAJVoypbICCFyFOuY8Q7I9kAdSilqM1FPVZJevvQBHk6Y+SNaDbc6eAcwtJmGlCLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7962
X-OriginatorOrg: intel.com

On 03/11/2026 12:16, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> The GL9768 is the successor to the GL9767 and uses a compatible
> register layout. Reuse the GL9767 driver for the GL9768 by adding
> the GL9768 PCI device ID to the device ID table.
> 
> Clear bits 2 and 3 in the SD Express control register at offset
> 0x940 when the driver initializes the device. This clears both
> bits to zero, matching the GL9767 default configuration.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 1 +
>  drivers/mmc/host/sdhci-pci-gli.c  | 7 +++++++
>  drivers/mmc/host/sdhci-pci.h      | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index a9000f3bd419..db0417238131 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1959,6 +1959,7 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
>  	SDHCI_PCI_DEVICE(GLI, 9763E, gl9763e),
>  	SDHCI_PCI_DEVICE(GLI, 9767, gl9767),
> +	SDHCI_PCI_DEVICE(GLI, 9768, gl9767),
>  	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>  	/* Generic SD host controller */
>  	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index b55618566d65..66452ed8cd8a 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -245,6 +245,8 @@
>  #define PCIE_GLI_9767_SD_EXPRESS_CTL			0x940
>  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE		  BIT(0)
>  #define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_1		  BIT(2)
> +#define   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_2		  BIT(3)
>  
>  #define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
>  #define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_SELECT_UHS2		  BIT(5)
> @@ -1354,6 +1356,11 @@ static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
>  		 PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF;
>  	pci_write_config_dword(pdev, PCIE_GLI_9767_SCR, value);
>  
> +	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
> +	value &= ~(PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_1 |
> +		   PCIE_GLI_9767_SD_EXPRESS_CTL_DETECT_2);
> +	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
> +
>  	gl9767_vhs_read(pdev);
>  }
>  
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index f38f0bd4165c..bcae29f8d8da 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -81,6 +81,7 @@
>  #define PCI_DEVICE_ID_GLI_9750		0x9750
>  #define PCI_DEVICE_ID_GLI_9763E		0xe763
>  #define PCI_DEVICE_ID_GLI_9767		0x9767
> +#define PCI_DEVICE_ID_GLI_9768		0x9768
>  
>  /*
>   * PCI device class and mask
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

