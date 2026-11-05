Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793858684;
	b=K0wredIq4Z+eXaBwhfNJJFFtRPwuWjOjF4wIc9+ALa0NQD7JHS47Y9uw0lpqTM2h8jNG
	 JzR/IpE2Om4ohTsP8CleSCft+Z3zMqQRXr+JbCfRvy+ULTDGgsSI2pm9LPA2M54GK52Z4
	 5ifw75UHPhpjT3bce9YcQhV+n/KtsnjVz/i9tZcr6zDJm7dBNUZJ1qH39IoGObAo34LLZ
	 9T3gG9ASkIID53JM6tZsJZ0WKiCVGMx+IU54DLnLCJQEpuCUIZOiH3aloL6VnHn5vYXIa
	 vssQ9ovAlyTC0WEJ0o3lPxSTHXhwBWB0lzpdJ5O7o36qTKYz4HfbuhADfi5dat0NgZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793858684;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=is1tbQQ7c7hkK9s2rj1CIXvpaYKGLPpYElqPYsurweU=;
	b=muePJpXb0YY+IpOdVMtlL75VnK2yurudMMoNHrZhwtiHf66RDo2gqVhgg3DMYJ+NIsAT
	 zUhMGwpgS/KupZGCDVET04YxndxlFYqQ7bCMp2q6aHZnwo1Qur3ecb8ZFpIksASqOU685
	 KW67q3uhwOVK7L9BtwTDt25mvG/anE87aZRrFUHv3d+tejLxz1nkKhTlPFUoN5reNwWKQ
	 pNUq2bDtndc7ZutSgg293p3Gb0db1+RughhEE/hpogTPobCJstwPCzdtx6iwbAWx7R1DP
	 a+f4RPC9QkT2RxMb69zvWCtCMxR2sAFgGGft4UCARj0urSwZKoA1UjmhO+9nJrUlYtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gODpJwpn;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20A606A31B;
	Thu,  5 Nov 2026 06:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD20A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gODpJwpn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793858680; x=1825394680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ra/HP0wh0djEYFBwf1MNdX/BtLLS2nHK0s9k+GgesGs=;
  b=gODpJwpnvFfgRsnCQ8TB5t4N6hJDzl7kjZyOu2jih86MBftMyMVKZKZI
   0asfQWR0S7uqp9WiyPMRe8OPKd5cu1gxxW49ULjtPvGI81AstDLECsCoT
   X+exhXjGiyLupWq3RVJQwIGdUH/mWFYORPDp3GngUGwEZdlM4x1QtIQa2
   my1szjuoZbGOcXrXs67v1g9H8FyA1bXRD9DXrHCXLlk4EGVAY5jz14khN
   UnlTNOfNk/jNb9qeVMXrZyicfUE9Yu6c0+mtQd0E7nF/vOKKMsKwIx6GI
   JOBtDz0D0yM+Og0XcvysrPfSp8XlfLzHKhzduXfu2XTwY8c6sYP5JxZpn
   A==;
X-CSE-ConnectionGUID: JIf8wnlxSxiCNSlamTF/Cw==
X-CSE-MsgGUID: fns6d/8ZRuarqAK1xUd3KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2533439"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2533439"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:04:39 -0800
X-CSE-ConnectionGUID: 8r26UNpJSgaqdkV1y+/Kig==
X-CSE-MsgGUID: YIFAYCX/SaKtEhYNfdx00Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6943037"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 22:04:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 22:04:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 22:04:37 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 22:04:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGWuxD00uQawazrt4yr2H0aq+lk6gr1R4oerMgJErQ7uPpT4bKJ3yXPkTdt/gUSesc3qHoB42kmihAek/15wd+mfx/dWS0r7LZdpb8E6HJcHluviUJuG1i3yPOFfmAIzQqy+4GaEeCQEqKagUcu3cK8fCYkWF5Fzb8KGppDIMxeDnO671nfkqP5lk+DORjKbzf09JRuwgQ0VRoud5djZ5pBYnQ4wJjjhhCJe2bSuxti43mT2Aufjb2MpGcO6t4TqS0r2pnOxdsly2vW3NYNwvB1PfDJz7beNtqnhIZhQE29JQwkhGUBQvZrmv6et62J7GpgHIh5YBFEa8Sbma2M5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is1tbQQ7c7hkK9s2rj1CIXvpaYKGLPpYElqPYsurweU=;
 b=IDnnh5GeJI57kjf+Qk4b+Gmnk81FAc+Rr/jlCBF5tuU6HoJ5J2ADp+vFvvDGuw6kkhKd5bxp/wcxXEX18IF2hob87BNJSQ4FUBRR2YzlIGC8gOvS27CTadt6GzrcRXhjUBFdfEnxSa9kb4EVmfrNsfQdep+TT4QU/5PrMycggZtfQZ9hwir+xZu/jiy9D4X/kypLkm1V3RLA4YZoUtFMb1Ac1yg2NtEDeorHgM9AA5kJL/nlqBaZhvKKz/wDANauu8aiN3qejOUtQBg37+I15fqAdpCRUau9OGFvR/q5tG5rbVGAfuJIYD4fKpUNoOCxNm5kd5ipzhME6zHY9x9MyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DSWPR11MB9558.namprd11.prod.outlook.com (2603:10b6:8:36c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 06:04:29 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 06:04:29 +0000
Message-ID: <c6080d32-49d0-413b-8c37-74709dadd6f6@intel.com>
Date: Thu, 5 Nov 2026 08:04:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Genesys GL9750 (17a0:9750) does not respond after its PCIe
 slot is powered back on from D3cold, on s2idle resume and at runtime (ASUS
 Vivobook 14 Flip TP3407SA, kernel 7.3.1)
To: Ben Chuang <ben.chuang@genesyslogic.com.tw>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kyle Baedke
	<kylebaedke@protonmail.com>, =?UTF-8?B?VmljdG9yU2hpaFvmlr3li53mlodd?=
	<victor.shih@genesyslogic.com.tw>
References: <x4G_0cgWnHWJtmgP4iX3hFfwwbWDyVuO9Ps8Pv_Rnq4VguufBRLzZex1IxGuTtaYfU7tS7U8RbKjB2I54HxfEmPk3gzKWvYDAyuZXrtWbDU=@protonmail.com>
 <vqOfI4cXijz1Ft480-_mX3XkrTT_-oQ78Xy6CPrXD_r5R06i7H03y3szJFA7JAVs9YsW93_hUQ0hz5bTYItb7RUml3cGwxPmW9gPFIcNY-8=@protonmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <vqOfI4cXijz1Ft480-_mX3XkrTT_-oQ78Xy6CPrXD_r5R06i7H03y3szJFA7JAVs9YsW93_hUQ0hz5bTYItb7RUml3cGwxPmW9gPFIcNY-8=@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2PR04CA0061.eurprd04.prod.outlook.com
 (2603:10a6:10:232::6) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DSWPR11MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: acb14df5-c328-4ad3-2797-08df3b02a70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: BR+jCh3n5lRWwToM01Wgh5c7xBbbxd0SiyXBGIeoHMkVF3W3mRWDRuk8lneBuBJKt4PRBROW0lQtkGSfum6rxHlH2DuScMubq9/n99UW08g49g7MH7tPQDibfi3VvCfvlqrDNMVTQUlUMtliQEuTzwelTkffonMFvMg1L0yG57hnD8XVE8TGeAs23djsqQpWfHEZmIhK0yHwxRnDms5QnuYh59W8F9jpZYijkcb4QVA5PxyZ5MnXbcN6sRoEHcmgLsKA/TBVRrRlBq5ZMEqJnnWijnmopuC80hwls1d1FHzzqPbC3Lkk3lqydx7zQIz7v89d1RXimZtlFSqYD1RBU0n8iKquEUddNnCMnB2e6G4+islJhOC/qOj13q9amZSCasOVr681b1G/K6SE+9QmBQdtu5/1irveNNzMdLan+Dcw9nr09Ae/QApPs890EEZ4pixwKvvZ8R0yfwyCHAPNCsvuUyrX/nSKkwU3p8yUCySQKDD+ozjT1eMTng/8+qg5S18Kr76aEG2MrYxaaqsWZXfsYXqXONlP0TPeBtas9movVZHf7JgXEJ67V7dpsuEQ/twxnNAgSUB18/XrSTu3FSlPUmP+EQi53KsWHiVxmKSHQ6pjRoRlgL77+rXfp+lu8mMDfDbSTcFkT0IDUJGL9ILKVEmQGA/ltUHaXiN0DDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFvKzhxZy9IV1RteG8zc2lCY2NRaGsyOUI3TkYxdGUxUjZnSnRndStUZGk4?=
 =?utf-8?B?SDE1RW0zRVNqZlJJVlBSVktSRmY0SE0vaXQ2SVdlOGdMMVJvNzF3VEpJR1V3?=
 =?utf-8?B?b0JsSklwTTBKbGJZN0VpVExZbHFleTkyMGQzWFZvOFFIVTZQeC80bkFTWFU0?=
 =?utf-8?B?bXpVOFNSZ2JRdWZkTUtXaWxIRVpiSkdPSWZ4ZUVnUTVHYm1uTEJEWXNYRHAx?=
 =?utf-8?B?bXVLbU1Obkp5b3dJRHZCdk9ReW13SkhNZjhoeEhjY0NIb3k3WWpaR2UwM3h3?=
 =?utf-8?B?cVhLU3lxbTYybm5EMzdQM2cwQWZLSzFZYnJaSFFFUUVyY2Ric09CZGJIcUpy?=
 =?utf-8?B?SDZoSTBIS04yWHdrUCt1L01CSC9RWUFJd28vODd3V3RIVnk5K1NkdE1pdXRp?=
 =?utf-8?B?UU90Rk4zRUlkMkFpL3IxU2ZPMzJJOER3aWlTdWJ6RnlQOGpRaVJ4RXpQOU1X?=
 =?utf-8?B?STFIcXhmUDZGWVVqUXJzT21nMHVjeVR6OWIwcTVteGY1WU1hb01vRmJWMjBS?=
 =?utf-8?B?ZWpaMXhPbGoxT2VBWDU0clgxT1piSFd5b2UrOHkzRXBUMlFqd2lrSVJ6cjln?=
 =?utf-8?B?OHZkalhLck9LTGFUaGN0Mmh4eE4xSHNPQTZIdS92dzV2S1Zad3F0aWtDY0d1?=
 =?utf-8?B?TU1CKytMMndYbE0yUEp2em1WU0ZXN1VnQW5TYVNoMGdhNVQvRWg0bzlySGFp?=
 =?utf-8?B?VEdkdUdzOFNjOU55dEc5MWdueDBtNUM0WkgvU3ZmaVkyM0dab0gySXRrT0Rt?=
 =?utf-8?B?N1ZjYndrNjJ6TG1xUS9rVnlWRUMzejBlWTRGUVRmTUUwUGZaUWdxNDZqRzRk?=
 =?utf-8?B?cEVhc2hyM3FESjhvbzRsNkw5WVZsRUtPd0dpMlZCeE0weTB4aGlVTzdJRGUw?=
 =?utf-8?B?b2s2TWMxMnhXWFJNVkxnZU52ek1CaVprWWFPT3NaVXc1eWxRTUpjV2J1TE4r?=
 =?utf-8?B?MzlMakY5dnBUSlRQTHlCenpzcVY5ejJYTWhVTzhTMVEzUU9OWDh5OGRsQk9Q?=
 =?utf-8?B?RFpRWCtXak9wM1BDYW5ycm54SkNRbmh1MlllTmNXZUZtcjZJZXh3N3A4R1Nv?=
 =?utf-8?B?NG8wWDBndkN3VzNnV2JwbVpjcHFDOThBMjF3Q3pKbHBpV2cwSHRjZytDWWdz?=
 =?utf-8?B?aUF2QXRzcGp2Y1dSak5VSHpZWnJXSEpERXVEdkRNMmpDTkNUbEZVR29GMkN1?=
 =?utf-8?B?S1lIVnp0Skw4d2c5WGlwRUw1bTVpRjExa3FuU1lFclR0Tmo4SndQZHpwSzE0?=
 =?utf-8?B?RTljNDloQWd2S3N3WkpRYjJxeWlOK0xSS3hUbG9KQmJSL1JvZEVKYVI2angy?=
 =?utf-8?B?SWxZYm1UZUl1dmlCZysvN2ZrcVRNOVFaVHdVU0pXS3hzUkhIOUJBU0krNi9y?=
 =?utf-8?B?SlBlWHVRVEZNM0tLM285MzI3NVhkRTlMZ2toRlRicCtBd1BZYW9oS0cvNjRY?=
 =?utf-8?B?djBmdGJBR3h3MTdycTk5bmtCSDVteC9SN3YvL3ViSlpXUEt3N0xiK3duekZH?=
 =?utf-8?B?RUdTNEY3WFU1c0FMUUdCVGdHQ1NQdHJILzI0c3VTQ1lIS09JeVlmaVZURERv?=
 =?utf-8?B?ODlQazU3V05iS3o2dEprZ29wTzlKTU9YM2VWenYrUjVKZk9pOEd4dkY1bit0?=
 =?utf-8?B?ZncrVGk1cUViTlI5dTZCNjRJdFVjQzR3bkNWck5IVnE2ZERhdW5UTzhFMHAv?=
 =?utf-8?B?WkVSempwQUQ1THJoNWtPMGhJTW5peTNROHVSMHJNanZUcEhZaGNsdkFqRHcy?=
 =?utf-8?B?d1BJMlorL1htSVUrZjRsSWI5MDZ0YWl1QzlodW5wYjdmSkdxYS95S1lCQnlT?=
 =?utf-8?B?Uks3Q29SSjFOQm5DSGNnQXJqV25OMmVyZUtSVnZNWUUwUDg5MUFnUjBnMHZR?=
 =?utf-8?B?Uk1CZkpLMS8xbGdwK0JjY0xHMEtOeGVnRDdJZFdYMGg3RHlvNCtWakkvSmZC?=
 =?utf-8?B?Yk0xNWo2VURUeDNGcUpGd2FZcG1aOWxCTGpERTdKTVc3R3RTK1lKWWdnMkEz?=
 =?utf-8?B?NlhhZlRHWmU1N2ZLK3RCNzNSaVRlYys3aHZmTWZpdWFjSkF4WnRyN3VkNnpJ?=
 =?utf-8?B?UWxRSTJuNS9rSXFUTStLYW9GSFZIb2QycytCdnJHdHQ4T1NiVVZTcXNlenJx?=
 =?utf-8?B?ZDNYZUNXRVpTb0J4YlJpdHpDWXROMWJZWlZ5TEZ0OE80d3pDL2tSVVd5V1lj?=
 =?utf-8?B?RmlpOVFIQUxBTG9aOUN3MmNUQUp1TkpMRzJDTFI5UEZxV0RVMlZoUTVqWW1Z?=
 =?utf-8?B?SDJ4alhrRW00c203WnFMMExLQ3FJRngxL1FOSTl2VEd5Q3E1NVNSREw3T3Aw?=
 =?utf-8?B?RWVqd3AxT0MyV0pRN3NDVFUwRkpzRGtZYlNOdkVDRXdCbmxrY0lmNE5qWXVN?=
 =?utf-8?Q?taty2+Et4mpaVeeY=3D?=
X-Exchange-RoutingPolicyChecked: lysHfC4lhpxmWfKY1VjVJ6FaFsiVVbEEa3Kda2UGL4mJCiol4wh6TBovCIZ4fyj5CWWR/DLunG3TZk2r8Un9sLdBsksq6oxTK5axPOPHp94Hfi7N3FNKHkxxWvOXKKp1eVh1pZ+XAugi9aIAhKdMGyx7lvc0D3Oc1mkLZfZ+2n9vscivZzxlMQ8WwfzLNzbicsFY9RWh11FMb+g92fdxH9UMM+KEP2kuf3/SBJfOKWMwgxbaxVTk4SdLhpUQsiWaGKYHu+BQwdPK1vty/SYUTomMUOBX+Jg9sRAGhEqws9p3m5aZ1wElqJ8ZGpoYv5eE3NtLrTOUNCBIOsP5k90TKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: acb14df5-c328-4ad3-2797-08df3b02a70c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 06:04:29.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESORVAlHXlsd908iw3Wn189BYPJg1+sqjt9Kz7fKxsYs7HAXCXALRbi+S7RnedZ1GLRiiyS1PMPx2Z6O7oXwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9558
X-OriginatorOrg: intel.com

+ Ben Chuang

On 05/11/2026 05:32, Kyle Baedke wrote:
> 
> 
> On Wednesday, November 4th, 2026 at 2:52 PM, Kyle Baedke <kylebaedke@protonmail.com> wrote:
> First copy was in html mode this should be in plaintext
>> The GL9750 SD host controller in my laptop is dead after its PCIe slot has
>> been powered off and back on through the root port's ACPI power resource.
>> This happens on resume from s2idle, and I can also reproduce it at runtime
>> with no sleep involved. In both cases the link below the root port never
>> comes up, so the device reads as all-ones. The sdhci errors are a
>> consequence of that. I'm writing to the sdhci maintainers because the
>> device is driven by sdhci-pci-gli, but the failure occurs before the
>> driver can talk to the device.
>>
>> == System ==
>>
>>   Laptop:    ASUS Vivobook 14 Flip TP3407SA
>>   BIOS:      TP3407SA.308, 03/05/2026 (the latest available)
>>   Kernel:    7.3.1 (NixOS 26.11), x86_64
>>   Device:    0000:2c:00.0  Genesys Logic GL9750 [17a0:9750] rev 1,
>>              subsystem 1043:202f
>>   Upstream:  root port 0000:00:1c.4 (ACPI \_SB.PC00.RP05), link 2.5GT/s x1
>>   Cmdline:   intel_iommu=on iommu=pt pcie_aspm.policy=powersave
>>              (the relevant parameters)
>>   Sleep:     /sys/power/mem_sleep = [s2idle] deep. Selecting "deep" (S3)
>>              hangs the machine and needs power to be cut to recover, so
>>              s2idle is the only usable sleep mode.
>>
>> The root port's ACPI node has power resources (power_resources_D0 and
>> power_resources_D3hot in sysfs). The endpoint's ACPI node has none.
>>
>> Other firmware/kernel messages seen at boot:
>>
>>   ACPI: \_SB_.PEPD: Duplicate LPS0 _DSM functions (mask: 0x1)
>>   pci 0000:00:1c.4: mask Replay Timer Timeout Correctable Errors due to
>>       0000:2c:00.0 hardware defect
>>
>> == Symptom ==
>>
>> After the slot is powered back on, config space reads of the device return
>> ffff, the port's Link Status stays 0x1011 (Data Link Layer Link Active = 0,
>> not training), and sdhci reports:
>>
>>   mmc0: sdhci: Version: 0x0000ffff   (register dump is all 0xff)
>>   mmc0: enable PCI MSI failed, error=-22
>>   mmc0: Reset 0x1 never completed.
>>   mmc0: 3.3V regulator output did not become stable
>>   mmc0: Controller never released inhibit bit(s).
>>
>> On a healthy boot the port's Link Status is 0x3011.
>>
>> == Resume trace ==
>>
>> Captured with rtcwake -m mem -s 15 (s2idle), pm_debug_messages=1 and
>> dynamic debug enabled for drivers/pci/*, drivers/acpi/power.c and
>> drivers/acpi/device_pm.c:
>>
>>   [  145.370215] sdhci-pci 0000:2c:00.0: PCI PM: Suspend power state: D3hot
>>   [  145.406917] ACPI: \_SB_.PC00.RP05.PXP_: ACPI: PM: Power resource turned off
>>   [  145.406948] pcieport 0000:00:1c.4: PCI PM: Suspend power state: D3cold
>>   ...
>>   [  159.865842] ACPI: \_SB_.PC00.RP05: PM: Power state change: D3cold -> D0
>>   [  160.263869] ACPI: \_SB_.PC00.RP05.PXP_: ACPI: PM: Power resource turned on
>>   [  160.264234] ACPI: \_SB_.PC00.RP05: PM: Power state changed to D0
>>   [  160.264241] pcieport 0000:00:1c.4: power state changed by ACPI to D0
>>   [  160.276459] pcieport 0000:00:1c.4: ready 0ms after power up D3hot->D0uninitialized
>>   [  160.276866] pcieport 0000:00:1c.4: waiting 100 ms for downstream link, after activation
>>   [  161.297053] pcieport 0000:00:1c.4: Data Link Layer Link Active not set in 100 msec
>>   [  161.303943] sdhci-pci 0000:2c:00.0: restore config 0x3c: 0xffffffff -> 0x000001ff
>>   [  161.321478] mmc0: enable PCI MSI failed, error=-22
>>   [  161.421611] mmc0: Reset 0x1 never completed.
>>   [  161.741170] mmc0: 3.3V regulator output did not become stable
>>
>> The slot was off for about 15 s (145.407 to 160.264), so this is not a
>> short-off-time problem.
>>
>> == Reproduction without suspend ==
>>
>> From a healthy boot (device alive, no SD card inserted):
>>
>>   echo 1    > /sys/bus/pci/devices/0000:2c:00.0/remove
>>   echo 1    > /sys/bus/pci/devices/0000:00:1c.4/d3cold_allowed
>>   echo auto > /sys/bus/pci/devices/0000:00:1c.4/power/control
>>   # the root port's power_state reached D3cold after about 2 s
>>   sleep 1
>>   echo on   > /sys/bus/pci/devices/0000:00:1c.4/power/control
>>   # port is D0 again, but its Link Status is 0x1011 (DLActive = 0)
>>   echo 1    > /sys/bus/pci/rescan     # repeated once per second for 15 s
>>
>> The device never reappears, and Link Status stays 0x1011 for the whole
>> 15 s. This uses only a 1 s off time.
>>
>> == What I tried ==
>>
>> Suspend variants, each run with rtcwake -m mem -s 15 (s2idle), no SD card
>> inserted. All of these failed on the first cycle:
>>
>>   - no changes
>>   - endpoint power/control=on
>>   - root port power/control=on
>>   - endpoint link/l1_2_aspm and link/l1_2_pcipm set to 0
>>   - endpoint link/l1_aspm, l1_1_aspm, l1_2_aspm, l1_1_pcipm, l1_2_pcipm
>>     all set to 0
>>   - endpoint removed before suspend, rescanned after resume
>>
>> This one passed 10/10 cycles (device alive 2 s and 8 s after resume, port
>> Link Status 0x3011 each time):
>>
>>   - d3cold_allowed=0 on both the endpoint and the root port, set just
>>     before suspend and restored to 1 right after resume
>>
>> Recovery attempted after a failed resume, with the root port held in D0
>> (power/control=on) and the rescan polled for 15 s per stage. None brought
>> the device back, and Link Status stayed 0x1011 throughout:
>>
>>   - remove + rescan
>>   - secondary bus reset on the root port, then rescan
>>   - Link Disable / enable on the root port, then rescan
>>
>> == Questions ==
>>
>> 1. Is this a known issue with this device or this platform's slot power-on
>>    method?
>> 2. What additional tracing would help (ACPI AML debugging, GPIO/pinctrl
>>    state before and after the power resource turns on, anything else)?
>>
>> I can build and test patches on this machine.
>>
>> Thanks,
>> Kyle
>>
>> Sent with Proton Mail secure email.

