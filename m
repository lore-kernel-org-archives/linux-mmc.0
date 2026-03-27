Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B3F15C14F
	for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2026 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622437; cv=fail; b=MzIu5ZoMWO+bmaP3US0kBbe3t1+ugydGCHrgNys1w8jdEQiSeFg3091ivGrppZoSVfVZXQb3WbKyQKiaeYJeAOBw/Yq+wFZzvt/GhkAdsrsfaILZcf0TEyaiiPoHHMIk4LJpGTSA0DzFTGpmS7nH1/MtT6GWpfgCARK8X4uNRKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622437; c=relaxed/simple;
	bh=zcVgIMu4uIwSwhqUhxD+P/CKCkjCDtq97wxqQ6q36CA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QrjvXGhAvClkXc8bFcT6QZ1eFdE6OG79YgAoZN4OdP4dT1Q5jbSHxaeQN+VVXNBM8gzol0LC6/lWw5Io3+Wf5EP1dySXIZGSdmt2jbZQdMwsbg1EgEHi6DFoN3NE/yB8MDR6BxndBqPUZXarunPSyzmsAv8yQlYGLzIkbMkCrHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5NiFjVb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5NiFjVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774622435; x=1806158435;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zcVgIMu4uIwSwhqUhxD+P/CKCkjCDtq97wxqQ6q36CA=;
  b=n5NiFjVblrMVarpTxpRMQzDo3vLQN+g8n3uA87e0eV8NZ5A9Rva87DWl
   flarR0qUVl+r6G2k4e1FWX844DpPyhUDmQnJj+/suWp1uEbf1KtSXZSjq
   ASE/pUGblMv2wNANvINUpwN372iC1DbNWVsiw+OeC+ysH5OTnvCiA+Ns/
   kyNswCADGu5NwjAPATSiaOMcRy90DLDqkMiAcHY0VoS3CpvBNmscuCcTf
   zJWSjwYI8Qv5QSJtkUMK5V8f3Br6mf3awLSAgySziKfG6OEJYgjbp7MBw
   CSw3Qfu2Cu5br9V/7D3oO+0BIRTVcOmEsuYAc5FG4KlIXOSp1D9eJOvVY
   g==;
X-CSE-ConnectionGUID: Dlfu9zoRRZCO5WggqbAKqw==
X-CSE-MsgGUID: Cgy5VXFFT5anvMMWUgmvXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75894603"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75894603"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 07:40:34 -0700
X-CSE-ConnectionGUID: Fxee4UMzTNeXAfVVvu6GCA==
X-CSE-MsgGUID: ugHDNrROTP6jVy5Z4ak0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="229821084"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 07:40:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 07:40:33 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 07:40:33 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 07:40:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jffM9cMPHeThsO00w8WY6fOtfdcU9u84Nt2K+idwaFnZrqzO4toorH55+YV7O0EwNqv5/bCXXKtMZD1AjluVN5ltomouFpRJzpX+2Up4RKYB9WsU9MDFpMqYRuHGNCY7QrW8Z2B+t8nVjm4hM4C1q/b6I7Ao+vtQNyDomGvtao7WqBS8i0Z53KcRiYQNwITA3OE3nLVWF/XUe1OmuvYYq62fB4+QDPk6geN86cPKX6/UM4hBjGVhk1pAaWXFaLUZR9GmFKl7sxjyApNctHCjZd6+BHR17XkDsbR65nlYg5i0wCQPNaZ86pRL5crJG/ghmLsGh3Mkgp8n9CS3fCLg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPYNDiw8zHmNWwIMXmrWc9V+OHF1mU9t1XPPACcRXUk=;
 b=KQPW4e3bbDkJsbbodVdhjR3abV/c2kT5B6kHfhVM95lCT/d5aIE3tmeHm7Sp3OZkw4PaYQxNt1NPGQfZPC8ycSJyYjaVcemP5qg4rW+R+SydL2jWxt9tXeDMbmhcj+OaPBe9o+U8opldTvwwDk8Xb+Uth0Z2l4+3fXDvSHbt0AijrT2VerW8YzW/Qm16qiAMOE0be1i+WMaI2pAOV/VZ0eGpj2P2zatcd9ECuYbQ1rLInEruuaMoIhMOkiguVQpFg392purzxG5/IGjMX9KE3CDRUWUpfcLCyQ0qRjU+VtaLNyWLlwDVz4ao+FcrsLzhasc4ooc+YsJerFR5iYpjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by IA1PR11MB6369.namprd11.prod.outlook.com (2603:10b6:208:3af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 14:40:30 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 14:40:30 +0000
Message-ID: <42f2174d-14d1-4c1a-8e9b-96c8ab9912a8@intel.com>
Date: Fri, 27 Mar 2026 16:40:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-dwcmshc: Refactor Rockchip platform data
 for controller revisions
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
References: <1774620875-18258-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <1774620875-18258-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0050.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4fa::23) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|IA1PR11MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2e414d-c8ff-481c-c96a-08de8c0ecb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Jqc5L+LS100zaJHCgEnZtIbXM+Z3L1Yz9EZSsIQCx3RcPSc26+wZx1hVCA6EqCJ95pPg85OcKxoF5piKI3IU/CAPtIx8sCO7CVVhgpeMH4FQTjBYr+RvSIQ62OEupeB3zvEmImU5H+dGmcrjSxX8yeSOZM7eFdAEtQYKW12j4O3aaIvtEXKnq+xn6D0HxybwcU4JullrEuewWsL1RllPaVIL2AO7BXbYpcOeiRm54GtcDD0RZJyRA2B9AmkaVkyUnCqe9EefbEkp6Cec6hN8Zr5buIgxqVV09d5VunFwcD/fd0BhceXKFAsw81AH3r7fGQFy+RfFK+amsD4ubWcPKzVWBolh0h9v56Z9BxFUlwACXcoKmJkMlGMrwNteaGHiAgv9Hs9jutU2Amm7cVt8xtNHbDbHxtFH2VEO4mZHYcQV2OqxoILHiEBmQ42X7An6KqxK+mtmWu1NxF2i9xOc5kUVx2/ag6z99+rp/GeC2TzcXSdKG/8DvUG3+lphWJptaP5/Bh87HowpNk3wiwhdRKQDP9kt5ag/vSQdp0j8ltniAW+1+UKMzxjDf6iIXtlnCm9qDfMBaR8jX+8xbwJt6zmod74bYkIJb8QgZnIZqvy91UDvnYN801NpteAC5LVMN40ZiHnBYAEZuRJ8dj3UchpNRfrpU9MPdABu9wrWUeOYfI3Ddbl1nYP1LO3m5KVEzjwbKNXkQj6G7QcmeMilg1dYLR4vZ1v656KPxp71GNc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmMwZWFoMm5pUlR5VjZaVjVFQ1ZYWjBqWTZVRzhtMUNqTVV4b0VrdUJXeEZT?=
 =?utf-8?B?VU5MSFlKV2xJUU16ZnRWV1pMR1RuaGN6ZFBYSjZYcDloa1Q0eHI5NDVpQjFF?=
 =?utf-8?B?TVJRTGprV2wvNHdhMWtGZTJydHhyY1NVWk15dEJ0Y0RrMWZEb1VFcnRHNDVT?=
 =?utf-8?B?aGNpcjA3V2JVdHRqcjg4KzA1ekpobkZQZnJwLzcrNXlKS1pQd0VQc1d0Kytj?=
 =?utf-8?B?ZTBRZjBHdGhnWE1vLzZhWllVVTFpeU1jRjVhRXUyNC81R01zcGs0UHllMlVr?=
 =?utf-8?B?eVVoYmNYK29wTk00Z3BLL0l3MnZmQXRxVUtML05BdWZBN2VTSVkrandSSlhp?=
 =?utf-8?B?RjNuSUdGWG9OMlFEbXphUGNhSGJSNjBxc2I1Q0w4YXY4YVBRNmwxNTY5WFNO?=
 =?utf-8?B?YWZkWmpZOUJmeXlMY1Btb1k1VWU2dUF5c25vNmNkZVMxVzZqcHgvNDczMGxG?=
 =?utf-8?B?NEJEZXl2NExJbUw0QVQ4QllTaFhHOGprL3ZSRlRWVFF3RVZkbHBVK2FnS3lF?=
 =?utf-8?B?ZDJ6WHNiUDZYMFdpdEY1ZTBRempWMWxqYTJPLzI0S3lDZWVFeDEwRTI1RWc5?=
 =?utf-8?B?b3NvYXJuUXhkbmF1L3d0Um1zMUVaUmJjQ2pZVWxOQjQxMFVaZEhSQllCaG5I?=
 =?utf-8?B?dUlNRDhNcmhNREJZcHZ6QzVFQ0pnYjRKbko1RUtEOWcwSFVrRGkyNzVVYk9W?=
 =?utf-8?B?SVdGdDNIOElCaGNpbjNtNTd6TlZUcU9mWkRwcUFtM2JISndseGdHdkRNb0I5?=
 =?utf-8?B?cVVqdDFQMXNzaFArZWM1ZHAwWnVPNTRXL3J1YWl5SGQwNDNRenh4ZnF6UWlv?=
 =?utf-8?B?TWpmVGpob1VoMXNPb3JocFNSUCtvamtLNmFjN2ZWVndjVXBHSnd1MkcrYVBP?=
 =?utf-8?B?Y3BqYXBJM3ZWNTk4UWs2bm9UMGp1TTZmeWY0c1pxalAwMEIrU25aOUsxeXYr?=
 =?utf-8?B?ZlNVZkx0ak51MXdXUmN4aDJjSmpxNStiR3BCM1QvUCtGaTlraWoyNlRsM0Iw?=
 =?utf-8?B?VWlYdjFhcStTRnVwMGVRbk12WTlES3J6QXFCK283WWRIWVByM1RsSlVYNGh3?=
 =?utf-8?B?MXJEU0E1czVINkl2VSszeFlxRXdaczN2cE43QmtqcWVHUFdXNVFYSWpIV0ZE?=
 =?utf-8?B?cFo3OXZ6SlpIMWIyMXhaVTI1ZWcrTjUwNCtNK0g4dTU5Zy9TTFRqOHFZN2JG?=
 =?utf-8?B?d3VNYko3QXRBZytXd0FsL0NuWUJOOEdUd080Z00vQXkxWFFjWXJ0U3VuZTNp?=
 =?utf-8?B?L1Zsby9WKzhnZU9Pd1BUaHlTTmZOT0NBVHRkN0o5eVJtb09USEpIaXpJTWlu?=
 =?utf-8?B?TEVCTUNqV2ZTR1Y1ZTdUbWZPYjdKUnE0OUVVRE1kWElTWTJTQ1JmMzZpbzND?=
 =?utf-8?B?elNIenVFMUZhdUFzL0VXWnk2VG5OUys3TFpCaVppNWRsM0tXQjBKNyswWDl4?=
 =?utf-8?B?bTR5d2IxOHg2TU0wd0Z2T2gvUGxvSTNyWm1wQkM1L1JGTlFOcHB0aTRPWUVL?=
 =?utf-8?B?SUIvMDZLOHB6b0t2SHpKT2YrWGVIUmNCeEMySjQwYkZIN2hieU1lWDh6dmo4?=
 =?utf-8?B?ejRiRDhZdU5vb014S1FsWmp6dmI4OHNZcmtDMXRNNXVROUtyRnBSRWdiU2pV?=
 =?utf-8?B?WnhyQ1ozZDdPT0E5aFlEREdKYkJlSVh0U2FBcHdjSjhNRFFCUEtSOEU3bUho?=
 =?utf-8?B?TWhJaXlNZWpQSzlkbjMzbVVYVlBDRmIvbkNHdWI5UlN4UjBvaEQzUUJHWFY5?=
 =?utf-8?B?Yi9ML25sKzNGajJudVkzNXRaS1E3Yy9MQkdBekdSMjYvRVkrUjZMWVUxdG54?=
 =?utf-8?B?dHRQQ2pzRlczbEY1QXp0ZHYxcXBCWThTVm1PbDZrb1Y0M2xFSCtlenJZRmJs?=
 =?utf-8?B?am9ObDBIb2RxSTNQTXlZZFZOVDg1RXZOTFhaZXp4S2hnVlJnZmhyeUgzOGJL?=
 =?utf-8?B?N3pUQmRLNThxR3Y5WGtwQWpJWFNqMzROZms3OVc3aHRCeG5Xb21uQTNxMUFo?=
 =?utf-8?B?Zk5zWGgzSGFEaDMrM2xjNzRRUWdLWnAyZVNKMFBwUTR1NHl6V1VjWjZsM0Vl?=
 =?utf-8?B?cjhqc1BjM0k4QkYwZktReGFBZ1ZBVnl1c25lWGx2a3gzN1dwTytJUVBpRGs5?=
 =?utf-8?B?Z1BjT1JQeTR2MW9wWmVMcnZQK0JzUGUzZjBVTnNMYytuKzRMWlBNMENjeTVO?=
 =?utf-8?B?Y2I1ZldteVRzWU5aUjZNRnJ3RmZmYVVBd2hsVWg2L0lzWVlDczBpL3hBRzgz?=
 =?utf-8?B?SHlsQWFOQkxQY3FDMEJ4cWJUUEd3amQ3azRPM2dJdDBaa1JBUXdNRU9nSDRl?=
 =?utf-8?B?cFpKVU83OGVaQkdEMFBhUFQvd0tTaHF6K1gxcVJWL0wrWU9DWEtScUMwNXNU?=
 =?utf-8?Q?Hr+xagBKWJ9NGBLg=3D?=
X-Exchange-RoutingPolicyChecked: YzTN2IFSr+kVemUJH42wRZSWzGBwbkTxXINULQMK7xoqWzKY/9Gq69GP8AGX0cgHNlSnsIrCatXKymqd7lOQEPCveZsvfqGAXr+wLnGCD4i8nydLltSHqyOhknpQWJ8E5sOOWRHu15+MLQ423ECNEeQr9eRWjAlcPMtHnff0D0f4W1cI2BVad7/XbE7wCDu8C5Iit5/HCGiOZUGnOSa8AHfqq44qav5AgsWfVwfJcACPZmuwdRZe1XiNSk0luLVxJjK9ClCHkz4LW8/pS6Fr8F764WRWwgPk0lshIpN6hnM4Cwlb9tXh+4GP59aMVqDnX835iEkxblD+kCZ1uyeRRw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2e414d-c8ff-481c-c96a-08de8c0ecb20
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 14:40:30.1186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/uuhiPTzqZrUw3MnY4yYEbaAWPDvnbgDDHSEVu08ZAV+KtrtOebE9GHoq+zC7/WxEru3VD54Ku7aUwMkwwX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6369
X-OriginatorOrg: intel.com

On 27/03/2026 16:14, Shawn Lin wrote:
> The driver previously used an enum (dwcmshc_rk_type) to distinguish
> platforms like the RK3568 and RK3588 based on DT compatible names.
> This approach is inflexible, scales poorly for future revisions or
> mixed-revision platforms, and conflates SoC names with controller
> revisions. One example is RK3576 which lists "rockchip,rk3588-dwcmshc"
> as a secondary compatible string just in order to claim it uses the
> same controller revision as RK3588. This is confusing and makes it
> error-prone to add new SoC support.
> 
> Introduces a new struct rockchip_pltfm_data containing a dedicated
> revision field. The old enum is removed, and all code paths are
> updated to use the revision-based data.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

If you roll anoher version, one minor cosmetic thing I forgot
to mention below.

In any case:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Changes in v2:
> - update commit msg
> - document the revision field
> - re-order the Rockchip plftm data
> 
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 92 +++++++++++++++++++++++--------------
>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index a91b3e7..aae7656 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -278,14 +278,8 @@
>  #define PHY_DELAY_CODE_EMMC		0x17
>  #define PHY_DELAY_CODE_SD		0x55
>  
> -enum dwcmshc_rk_type {
> -	DWCMSHC_RK3568,
> -	DWCMSHC_RK3588,
> -};
> -
>  struct rk35xx_priv {
>  	struct reset_control *reset;
> -	enum dwcmshc_rk_type devtype;
>  	u8 txclk_tapnum;
>  };
>  
> @@ -330,6 +324,16 @@ struct k230_pltfm_data {
>  	u32 write_prot_bit;
>  };
>  
> +struct rockchip_pltfm_data {
> +	struct dwcmshc_pltfm_data dwcmshc_pdata;
> +	/*
> +	 * The controller hardware has two known revisions documented internally:
> +	 * - Revision 0: Exclusively used by RK3566 and RK3568 SoCs.
> +	 * - Revision 1: Implemented in all other Rockchip SoCs, including RK3576, RK3588, etc.
> +	 */
> +	int revision;
> +};
> +
>  static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>  {
>  	u16 ctrl;
> @@ -749,6 +753,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
>  	struct rk35xx_priv *priv = dwc_priv->priv;
> +	const struct rockchip_pltfm_data *rockchip_pdata = to_pltfm_data(dwc_priv, rockchip);
>  	u8 txclk_tapnum = DLL_TXCLK_TAPNUM_DEFAULT;
>  	u32 extra, reg;
>  	int err;
> @@ -816,7 +821,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	 * we must set it in higher speed mode.
>  	 */
>  	extra = DWCMSHC_EMMC_DLL_DLYENA;
> -	if (priv->devtype == DWCMSHC_RK3568)
> +	if (rockchip_pdata->revision == 0)
>  		extra |= DLL_RXCLK_NO_INVERTER << DWCMSHC_EMMC_DLL_RXCLK_SRCSEL;
>  	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_RXCLK);
>  
> @@ -842,7 +847,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>  	    host->mmc->ios.timing == MMC_TIMING_MMC_HS400)
>  		txclk_tapnum = priv->txclk_tapnum;
>  
> -	if ((priv->devtype == DWCMSHC_RK3588) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +	if ((rockchip_pdata->revision == 1) && host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {

Forgot to mention, unnecesary parentheses around "rockchip_pdata->revision == 1"

>  		txclk_tapnum = DLL_TXCLK_TAPNUM_90_DEGREES;
>  
>  		extra = DLL_CMDOUT_SRC_CLK_NEG |
> @@ -898,11 +903,6 @@ static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	if (of_device_is_compatible(dev->of_node, "rockchip,rk3588-dwcmshc"))
> -		priv->devtype = DWCMSHC_RK3588;
> -	else
> -		priv->devtype = DWCMSHC_RK3568;
> -
>  	priv->reset = devm_reset_control_array_get_optional_exclusive(mmc_dev(host->mmc));
>  	if (IS_ERR(priv->reset)) {
>  		err = PTR_ERR(priv->reset);
> @@ -2115,30 +2115,52 @@ static const struct cqhci_host_ops rk35xx_cqhci_ops = {
>  	.set_tran_desc	= dwcmshc_set_tran_desc,
>  };
>  
> -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> -	.pdata = {
> -		.ops = &sdhci_dwcmshc_rk35xx_ops,
> -		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_rk35xx_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +		},
> +		.cqhci_host_ops = &rk35xx_cqhci_ops,
> +		.init = dwcmshc_rk35xx_init,
> +		.postinit = dwcmshc_rk35xx_postinit,
>  	},
> -	.cqhci_host_ops = &rk35xx_cqhci_ops,
> -	.init = dwcmshc_rk35xx_init,
> -	.postinit = dwcmshc_rk35xx_postinit,
> +	.revision = 0,
>  };
>  
> -static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> -	.pdata = {
> -		.ops = &sdhci_dwcmshc_rk35xx_ops,
> -		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> -			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> -		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_rk35xx_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +		},
> +		.cqhci_host_ops = &rk35xx_cqhci_ops,
> +		.init = dwcmshc_rk35xx_init,
> +		.postinit = dwcmshc_rk3576_postinit,
> +	},
> +	.revision = 1,
> +};
> +
> +static const struct rockchip_pltfm_data sdhci_dwcmshc_rk3588_pdata = {
> +	.dwcmshc_pdata = {
> +		.pdata = {
> +			.ops = &sdhci_dwcmshc_rk35xx_ops,
> +			.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +				  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +			.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +				   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +		},
> +		.cqhci_host_ops = &rk35xx_cqhci_ops,
> +		.init = dwcmshc_rk35xx_init,
> +		.postinit = dwcmshc_rk35xx_postinit,
>  	},
> -	.cqhci_host_ops = &rk35xx_cqhci_ops,
> -	.init = dwcmshc_rk35xx_init,
> -	.postinit = dwcmshc_rk3576_postinit,
> +	.revision = 1,
>  };
>  
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> @@ -2309,7 +2331,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	},
>  	{
>  		.compatible = "rockchip,rk3588-dwcmshc",
> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
> +		.data = &sdhci_dwcmshc_rk3588_pdata,
>  	},
>  	{
>  		.compatible = "rockchip,rk3576-dwcmshc",
> @@ -2317,7 +2339,7 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  	},
>  	{
>  		.compatible = "rockchip,rk3568-dwcmshc",
> -		.data = &sdhci_dwcmshc_rk35xx_pdata,
> +		.data = &sdhci_dwcmshc_rk3568_pdata,
>  	},
>  	{
>  		.compatible = "snps,dwcmshc-sdhci",

