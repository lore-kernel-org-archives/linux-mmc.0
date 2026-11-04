Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793793734;
	b=2TtCW/tw/OPgjL/Aeu78+5at251YHix6bL+s81r7WdUS7kqVEtRd3Oi72S69Kn8rAXX9
	 rsA5fdHnNtMYopNALhD0fpGfb6Tzi98ff91wQvVwWnpOnIxxNu/naiUuGSQEOcEG6y8Ue
	 Fe8k3fTtbN3UvA11YGYpyHW7b3fwcDXNwIbGLQU5JrUZHCT9kCGMtb8X0IRpPeQJ+ih8i
	 BcxV7h3eT6oj3aI7C0bExuEGXX6SZ8PosXs4ls9gBgjvGgWYHtPDK2fnoqLY/VV/3vDrv
	 c30qKrI5TkLDj4xN94kUi957Drq4SoKF9H3dKymrdAY8TVKQ0J5U+CM/8hnAMxmnHlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793734;
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
	bh=cdMeccl10V+/EZhrB7nz3PXtnqPFNKQGFZm4hOwi3J0=;
	b=ZG9ghg5bx/X5yBWryjGbno+J5eQQPkQOWheQIw8wVvzerWZhz4ofuqNDhYaoOGRXTk2c
	 kyG6Q8PLrUdOmbexyBEuEM3DQR54dmhhg66qVWGVLC7QAXJxLRCd2kdcgJRkAwT/Oo+V3
	 HEVgcmFAKbfGSQGzDW9Njgs5XVFAtX6v/1NFTbs3PefCfLsIW5Yv4Y2p+nAU/H45H82Tf
	 MEAIdcnTLDUg8qC9R/8YvSi4qGwmNvKspekWqB+IUmGq2PmyGUEmmjydtHtJBzr0Xuqw9
	 86PkVSsmNSFVlWz1+l1FXmJUkb5rCMo7SBQpmwtlgaksqyCXvpLanO6sHD8reNIW69g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CoCZ9cCm;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB32606A31B;
	Wed,  4 Nov 2026 12:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB32606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CoCZ9cCm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793793734; x=1825329734;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Li5U8oZJrdaDBUerlnmdFL9wtKaCeXHPpaBV0opou4s=;
  b=CoCZ9cCmnSiaEcrBX7IZbe90Oewp9k0DnbF6NtgyANUxc9HVtXU1QyUD
   steibAnJZnIU9Iyo22vN2CmUoaz15Ya94O77DVSnghplHtqWwmxFFruDz
   qt3EEaAwcm3w/ESl7yeLMp//bc8rEMkI8dWAeG8A9i42lv6RvskFDpq0M
   caiTqXWnuEJS2QFXQ3ZY7a5aj1pS1kWHmbx2g9YxCaQD9feQlCfF7SWoj
   rCZp2mrcHtTXO1Iqox/jPx7LeKnxJ2fkP9itSx0JYbsEjGdfWVm23wlMb
   cyJhi9/N0UUDxU6smogTamBc1T/YTJSj8wANlIeLaItl8SCClmgp80U+D
   w==;
X-CSE-ConnectionGUID: Y9kgCX2ASte8YtovJPF/UQ==
X-CSE-MsgGUID: lj151p87S/OEFK9DlvkJXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2419646"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2419646"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:02:12 -0800
X-CSE-ConnectionGUID: YM4d2tGCTuiSlAzG4xrcdQ==
X-CSE-MsgGUID: XSs22+W+Q465GJIJuuSSyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="8490949"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:02:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 04:02:10 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 04:02:10 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 04:02:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtsAMe0SLJVH857skxtv+vhWr+3tqUqn4++U6qx1UdqOva1Y2iTM5Jvo+tHs/YeGYh+M3IVy7ofoU/4P25zKAgLVoL6mJOYvDYMpKBJ0GM8ekkB4OoZsDXdfgF1+JW5BrXPt643V3fO3r3OUYLZrWiditJHC1kiDDyU/hF0I85w/P+GSkHL57xrNRljcST6LvnSoMm2gBBMqAB+Bb2Ht+W4cXCrWkxbBn6b3aCCH6ii/DK1pVgRAos8cBsqtrVtdhrtSM4A34Vpp8bCXcxk+dLk2A44aqbDIOKxoPIuqdCqM5gL/niE7t8j511vDjgsJJmbiE52NKNOR0fSmJ5OdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdMeccl10V+/EZhrB7nz3PXtnqPFNKQGFZm4hOwi3J0=;
 b=DHEsZ/w/u8gffCsTAch4pWAs5Zt42zeXFgfK4v7SGHmkwvS30oodQ3ckK7sAmHhSIGj8Pajc8vAcf5APG1/uOiu0JgsuZDVFL+ro1WiqBguzckHwf3hUWEL4WAgwD7X1zFObTJVpoS68tpF/zoRRIyeK/tIOGZTMI1h6jLH6A0O2y5wWkPAy+Dg9WJAqrbcPF0SGLlGkQ+YvmTt04/SAb3xuMYvMBHKdKDYgQcL4Lgye8bPIbeMGCUbbGSu26Ai7uUsEPn4i8JW/L6VO26dezgV37exrLzar9JxISt9O2HWaFjyjMkoIUsScvZpKosvMo4BKSVITakmGpuosSpnk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS0PR11MB7311.namprd11.prod.outlook.com (2603:10b6:8:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 12:02:08 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 12:02:08 +0000
Message-ID: <afa7f2f6-17f3-468a-a7c8-4b1b7840bde8@intel.com>
Date: Wed, 4 Nov 2026 14:02:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-msm: Add support for firmware-managed
 resource platforms
To: Anjana Hari <anjana.hari@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shazad Hussain
	<shazad.hussain@oss.qualcomm.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@oss.qualcomm.com>, Nitin Rawat
	<nitin.rawat@oss.qualcomm.com>, Ram Gupta <ram.gupta@oss.qualcomm.com>
References: <20261102-sdcc_scmi-v1-0-244dbd893051@oss.qualcomm.com>
 <20261102-sdcc_scmi-v1-2-244dbd893051@oss.qualcomm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102-sdcc_scmi-v1-2-244dbd893051@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::32) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS0PR11MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: f6f7af5c-0e81-4b0a-bc42-08df3a6b7308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|10067099003|22082099003|18002099003|3023799007|11063799006|56012099006|4143699003|261022075727099003|261102123227099003|261026140227099003|261022105027099003|261028144727099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: C7sL8xHW075L6ZqPoZrVXJeWZtDwXsT3dEjWKUVe2hp1tbWxTUY753+tIBJwKhdyEpQC7XRYnUOBnJcAzOUUoDPildXejB9aZyybPM7c6hzE2OEzItIlMtSxXO9lmQQ5NkvRn4hKAcDIU3rO17Z8ZtT3DrUAEuInhe885Ndfio4hAV1Gcywu2l6+wzRUOuFUDimrZbXF7hb0UANckbLU2qhipMdv6JGI9r6gGopogl4gwRo9WD7RtjntquklVafKM9hwZc7Ge7D03JCGzoIHQV0PJ2QIwJKlMu7Bjjni/pe33CosZpmJ8NJFxnY8m3/hXx9mH9eXNgRl9zqLpzg4TR6/RssTJzWy9++jkjm2AI2ccVn7Pme6ccaL7wVotRaAdQ1ND39GTD9k0QquO7yXFInTYVqWdM+hUGrGIbtN5meMospxjSqemSsz5kbNApX3G6JhrQUGiOc5rPNWu/NWGdiMtaN2/GtlPVmWnbFeLQAiZ1oei6LYkHESMQu3bOoRda0S6WbN6ottUW7J3rOmsY9GnTumFQxGwiya/Bfy+xv2aWUIKYm62RjW7AmC3eV7hlFsdhUFtZ9jGwzaYYBiq+4X+kPHki64wmwFzFKTUmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(4143699003)(261022075727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhFakJlc0ZxMW51TFgzTUN3elVWNVdldWI0bS90V2x3SVdSdERCb2NHZHhS?=
 =?utf-8?B?eitwVUdWeHVjdmxiNCtIMWdwQTNOamg0a040VFpwUzd3Y2hQc1NhUmV5dnlp?=
 =?utf-8?B?NVhnTWhZc29ZTGM0UjhrWUh2SDBRMzc4a2p3aWxFZjE2TmpEby9MMmVOaTRp?=
 =?utf-8?B?V21oU2sreWhLbVpxNDFzQVRYdDdaM3FGZUNYbUxIVWVBendtOHkwb3AwM1d3?=
 =?utf-8?B?enJMVkg0RDVkYlIyd0IySXl0VmJjaCs2ODd2SEh5dk11Z3ZkaXFVVmlwK1c2?=
 =?utf-8?B?MTFzNTdkZm5hNGJpVmJHdjdHMHpSekRtYjRLbmNNS2VIQmtvNkFMUmtWQjFB?=
 =?utf-8?B?RngxbjQwQ0RkVlZSQjFyQW8xOWlIdmhHL3U3bEZON2ZzdHQzUHIrMGZrcS9K?=
 =?utf-8?B?QVZUcDZQV1RXRmRYaXg0dkhyakJQdUhxSlM1Zkkva3A5dlVDSHBweHVsOVlS?=
 =?utf-8?B?SWtiTWkvYTRQYTdPOXhXUkFFNTZ0clFvUXBPcnJqckIwY1Z4K2kvMTJqR1hk?=
 =?utf-8?B?S2lJVGFkdGVZUjRYWHZldG5FaWd6VnVvOFlLTHVwTlpnWjJNTWVmN3VNcmhZ?=
 =?utf-8?B?T1VVSFhteEZ4bHhzend2ZnhMZi9lVmltZ3NYYmhuKzh1aERkQkh1Q2tPZ0lK?=
 =?utf-8?B?Z1orNytsajJSVW1ZYmZsRUF4SnFrd2pweXh5RTlEMnNOM0ZoazF1czZvR241?=
 =?utf-8?B?WkplRllCL1kyWXkxZEQ4aTFEdDJ4V3kwMHBObkZCbHY0cHRpZjFQSnowNjZQ?=
 =?utf-8?B?ZTlTbUR0M0RUTW1CYldKRFFpOGphWUdqdHZlZmptMGxJUUl6dWdQWVdWOUFv?=
 =?utf-8?B?aEpsM1Z3M1BjdTFPNytHa1RiSTFWUjdlTmFUMHlraFFjMWswT2FQOHVScTly?=
 =?utf-8?B?NFNqTVZzN2QrMEF0RC9Lb3FRd1Z2WVRUR01QaHBISlptUXI5dXpNeTI4eGFa?=
 =?utf-8?B?SXczb0NpTjN2ODcrZ0EvNTJsaEpmbXRlNENDN21NdThqQXNSVDZSMVN2anJV?=
 =?utf-8?B?eHo2NVFpWDZsVHpwYkRyMEQ4QjVxWVd5ZnE5bzFzR3V1c21oWnFoeEJoMGNE?=
 =?utf-8?B?UEx6NXNLQTljb2lJUWdaQThpbFpHMzB5NGxSWnNSYkhUNm9pbkhBVEpESm9L?=
 =?utf-8?B?VGthcnNqQVRLUUJmY2RiZ1hxN1dwNWpDRmtMUXRnNnltM3RrK1pFbFoyOWgx?=
 =?utf-8?B?aTdoVDZ5b2FtZUo1aEpqZFNWaVNCV1ExZHl4S2ZRVlc5YnRSdElmM1M5Wmpp?=
 =?utf-8?B?S2pkUVBKbmxjdm9KdW5YbjkxZHBLRFFYbGZvMEdOem9VM1JraEJyZnFHN0pm?=
 =?utf-8?B?cVk0b3FMRlgvaDhoeHRIRUhSWDM4Q0E0cDRzVjFsVmlPWE9GOU0zbGg0MjAr?=
 =?utf-8?B?dCtzT2h3WVlRQW1lTUlWa24rd3p4MVlSQ2JXUWpwem1xWEhNMHp3T0ZCVFIv?=
 =?utf-8?B?SzNBMjhqV3hFcVJsV25RdlMzdWxNMWNxZi9DSXphaGIyMEJ6ZUgwbDZjK1Vr?=
 =?utf-8?B?OGRkbW5XS1hlYkhBdENoSTlSR0NZUHpvT2kweXZWZ2NvNHhXWEt1bHNId3V3?=
 =?utf-8?B?OUlSTlROU0VLdlRNVy9veUJLLzZQU010bHZFVWVDSE9TbnNFakpmRWUwZmJG?=
 =?utf-8?B?Q0RLdk01Y3haekhLQVhZUzhrbFBuM0NGRFRkNFJwR3c2eVJpZGNxNEtIT2lS?=
 =?utf-8?B?aDYxRHVxcjJjeHUyQkxhbDVHbVpaSkJMR2pPa1RLZVgrcXBxZ1dxeGZPQXl2?=
 =?utf-8?B?UEg1RlRLRnRia3pvSzBpazlkK09BemtvbDNzZlJkaEZJN1kyVE1TdVAva3Ny?=
 =?utf-8?B?cVVtSUxHUFlueWR3dDFsWS80aytHRUJtNjhzb0JEbTNIbXRBVnhCdlhSSXBK?=
 =?utf-8?B?WEg0VGJoZ3VwYVgxbG1lRTJoaERCcmU4RnR3bHpLMlNwYzQxS2JFa0p6R1Nq?=
 =?utf-8?B?ODVkczlvbVVXZUMxWFNzMGYwbE16OXlCYTFTUUtoR1RzZVVBMit6K3QrcGZK?=
 =?utf-8?B?ZWFoS2Y1Q0Q4eG1ISk42aXRHWVdKdlJnc1ZzZGVTbUxJU1Y5ZDJHREpRM1JE?=
 =?utf-8?B?V2lkVkdtMWJTOEd0YUtLZENYblZNQnErbFhHeURSUUNQUUt4c2JUdW90MUp3?=
 =?utf-8?B?QU5LcTVGU1VOWEJmR0xOeWFDa1NZOU9uYUNualhUaHViWmFNSTljWklWK3Va?=
 =?utf-8?B?QTNjckduZThUQ3pkZWNoQ25pZGVxNVZrY256SGNqeUZiVTVYRFhTSTUremZP?=
 =?utf-8?B?RVZPVWVRVmwrcDBrWU43cWZOdlZFcXZJdGtuOGFUYkUwQ3krMXl2KysrUlEr?=
 =?utf-8?B?NWNXRGx6aEpkNUM3cjBjcXMvMU9QRXQ2LzREYmZ0WGFZQVdNUWVvZz09?=
X-Exchange-RoutingPolicyChecked: 1oiyeBME1vtv8bPfOjt81U2W5LcFk3enYPEeiAU441n4GKs6CoVguX9t4fJkL21gSIU6lmzyPAi9BGwiWCdfyGPNciLmj8kVSsixgtkoCd+CTOQyk8xuaLvAkbAUIsCdxkfeMdVMjroMVIdkM0aonkqG1zsnYkeruegJw04OJEU8VaM8l223Yuy43aSQf/u9Bpt0mwcfh1laK5WKKE3DbN1HPr2aonf5W2Jqy9G5YyEWJr8cTLp30hJdwlrfYVGMV0TwPIjST5uC07hYAQB7tvtHRzSmsGENL12oLBbtUdeccflAcG62o6UfQ+XycoPA/sqwld4k6svW1Wx57BoGWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f7af5c-0e81-4b0a-bc42-08df3a6b7308
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:02:07.8848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0w8y1gfSSJFZqVejOfLf7hfWinLswDPSzlrmbgmdlW7jaClI5VAopNPCv+dcrtt9G8jIOsexVdztfZS07xQZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7311
X-OriginatorOrg: intel.com

On 02/11/2026 16:03, Anjana Hari wrote:
> On certain Qualcomm automotive SoCs such as Nord, platform resources
> including clocks, interconnect bandwidth, resets, and regulators are
> owned and managed by firmware rather than directly by Linux. The
> firmware abstracts these resources behind logical power domains and
> exposes control through the SCMI power protocol.
> 
> Introduce a firmware-managed variant of the sdhci-msm driver that
> operates through this abstraction instead of directly programming GCC
> clocks and PMIC regulators.
> 
> The firmware-managed model uses two logical power domains, attached at
> probe time via dev_pm_domain_attach_list():
> 
>   - "power" domain: governs SDCC rail power state. It is activated at
>     probe and released at remove via pm_runtime_resume_and_get() and
>     pm_runtime_put_sync() on the domain device. These calls are
>     translated by the SCMI power protocol into firmware power-state
>     requests.
> 
>   - "perf" domain: the SCMI perf domain driver populates OPPs at probe
>     time by querying the firmware-reported performance levels via
>     perf_ops->device_opps_add(). Clock rate selection uses
>     dev_pm_opp_find_freq_floor() to locate the nearest OPP at or below
>     the requested frequency, then dev_pm_opp_set_opp() to apply it,
>     rather than directly programming the GCC clock tree.
> 
> A new variant sdhci_msm_fw_v5_var is introduced with the compatible
> string "qcom,nord-sdhci". Detection is automatic at probe: a non-NULL
> pd_data.pd_names in the variant descriptor marks the platform as
> firmware-managed, causing probe to select firmware-specific platform
> data (sdhci_msm_fw_pdata) and ops (sdhci_msm_fw_ops).
> 
> The firmware-managed ops provide:
>   - sdhci_msm_fw_get_max_clock: queries the perf domain OPP table
>     using dev_pm_opp_find_freq_floor() at ULONG_MAX to discover the
>     maximum supported frequency, replacing the direct GCC readout.
>   - sdhci_msm_fw_set_clock: routes clock rate programming through the
>     perf domain OPP path, reusing the existing bus-mode multiplier
>     logic to derive the target rate.
> 
> Suspend and resume sequences bypass local clock and regulator management
> for firmware-managed platforms, as firmware handles those transitions
> autonomously in response to SCMI power-state transitions from the
> runtime PM framework.
> 
> Co-developed by: Shazad Hussain <shazad.hussain@oss.qualcomm.com>
> Signed-off-by: Shazad Hussain <shazad.hussain@oss.qualcomm.com>
> Signed-off-by: Anjana Hari <anjana.hari@oss.qualcomm.com>

Doesn't compile:

drivers/mmc/host/sdhci-msm.c: In function ‘sdhci_msm_probe’:
drivers/mmc/host/sdhci-msm.c:3105:1: error: label ‘fw_detach’ defined but not used [-Werror=unused-label]
 3105 | fw_detach:
      | ^~~~~~~~~
cc1: all warnings being treated as errors

Please check other Sashiko issues also:

	https://sashiko.dev/#/patchset/20261102-sdcc_scmi-v1-0-244dbd893051%40oss.qualcomm.com?part=2

> ---
>  drivers/mmc/host/sdhci-msm.c | 213 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 208 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index aecd425bf095..da52a45203a5 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -8,8 +8,9 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/mmc/mmc.h>
> -#include <linux/pm_runtime.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
> @@ -168,6 +169,9 @@
>  #define ICE_HCI_PARAM_CCI	GENMASK(7, 0)
>  #define ICE_HCI_PARAM_CE	GENMASK(8, 8)
>  
> +#define DOMAIN_IDX_POWER	0
> +#define DOMAIN_IDX_PERF		1
> +
>  struct sdhci_msm_offset {
>  	u32 core_hc_mode;
>  	u32 core_mci_data_cnt;
> @@ -275,6 +279,11 @@ struct sdhci_msm_variant_info {
>  	bool restore_dll_config;
>  	const struct sdhci_msm_variant_ops *var_ops;
>  	const struct sdhci_msm_offset *offset;
> +	/*
> +	 * pd_names != NULL marks this variant as firmware managed;
> +	 * see fw_managed detection in sdhci_msm_probe().
> +	 */
> +	const struct dev_pm_domain_attach_data pd_data;
>  };
>  
>  struct sdhci_msm_host {
> @@ -285,6 +294,7 @@ struct sdhci_msm_host {
>  	struct clk *xo_clk;	/* TCXO clk needed for FLL feature of cm_dll*/
>  	/* core, iface, cal and sleep clocks */
>  	struct clk_bulk_data bulk_clks[4];
> +	struct dev_pm_domain_list *pd_list;
>  #ifdef CONFIG_MMC_CRYPTO
>  	struct qcom_ice *ice;
>  #endif
> @@ -302,6 +312,7 @@ struct sdhci_msm_host {
>  	u32 caps_0;
>  	bool mci_removed;
>  	bool restore_dll_config;
> +	bool fw_managed;
>  	const struct sdhci_msm_variant_ops *var_ops;
>  	const struct sdhci_msm_offset *offset;
>  	bool use_cdr;
> @@ -414,6 +425,45 @@ static void msm_set_clock_rate_for_bus_mode(struct sdhci_host *host,
>  		 mmc_hostname(host->mmc), achieved_rate, timing);
>  }
>  
> +static int msm_fw_set_clock_rate_for_bus_mode(struct sdhci_host *host,
> +					      unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct device *dev = mmc_dev(host->mmc);
> +	struct dev_pm_opp *opp;
> +	struct device *perf_dev;
> +	struct mmc_ios ios = host->mmc->ios;
> +	unsigned long clock_long = (unsigned long)clock;
> +	unsigned long desired_rate;
> +	unsigned int mult;
> +	int ret;
> +
> +	perf_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	mult = msm_get_clock_mult_for_bus_mode(host, clock, ios.timing);
> +	desired_rate = clock_long * mult;
> +
> +	/* Find the nearest OPP at or below the requested frequency. */
> +	opp = dev_pm_opp_find_freq_floor(perf_dev, &desired_rate);
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "Failed to find OPP for freq %lu: %pe\n", clock_long, opp);
> +		return PTR_ERR(opp);
> +	}
> +
> +	ret = dev_pm_opp_set_opp(perf_dev, opp);
> +	dev_pm_opp_put(opp);
> +	if (ret) {
> +		dev_err(dev, "Failed to set OPP for freq %lu: %d\n", clock_long, ret);
> +		return ret;
> +	}
> +
> +	/* desired_rate was rounded down by find_freq_floor to the actual OPP rate. */
> +	host->mmc->actual_clock = mult ? desired_rate / mult : desired_rate;
> +	msm_host->clk_rate = desired_rate;
> +	return 0;
> +}
> +
>  /* Platform specific tuning */
>  static inline int msm_dll_poll_ck_out_en(struct sdhci_host *host, u8 poll)
>  {
> @@ -1253,7 +1303,10 @@ static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  	 */
>  	if (host->flags & SDHCI_HS400_TUNING) {
>  		sdhci_msm_hc_select_mode(host);
> -		msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
> +		if (msm_host->fw_managed)
> +			msm_fw_set_clock_rate_for_bus_mode(host, ios.clock);
> +		else
> +			msm_set_clock_rate_for_bus_mode(host, ios.clock, ios.timing);
>  		host->flags &= ~SDHCI_HS400_TUNING;
>  	}
>  
> @@ -1847,6 +1900,28 @@ static unsigned int sdhci_msm_get_min_clock(struct sdhci_host *host)
>  	return SDHCI_MSM_MIN_CLOCK;
>  }
>  
> +static unsigned int sdhci_msm_fw_get_max_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	unsigned long max_freq = ULONG_MAX;
> +	struct dev_pm_opp *opp;
> +	struct device *perf_dev;
> +	struct device *dev = mmc_dev(host->mmc);
> +
> +	perf_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	opp = dev_pm_opp_find_freq_floor(perf_dev, &max_freq);
> +	if (IS_ERR(opp)) {
> +		dev_err(dev, "Failed to find opp for freq %lu\n", max_freq);
> +		return SDHCI_MSM_MIN_CLOCK;
> +	}
> +
> +	dev_pm_opp_put(opp);
> +
> +	return max_freq;
> +}
> +
>  /*
>   * __sdhci_msm_set_clock - sdhci_msm clock control.
>   *
> @@ -1892,6 +1967,40 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	__sdhci_msm_set_clock(host, clock);
>  }
>  
> +static void sdhci_msm_fw_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +
> +	if (!clock) {
> +		host->mmc->actual_clock = 0;
> +		msm_host->clk_rate = 0;
> +		goto out;
> +	}
> +
> +	sdhci_msm_hc_select_mode(host);
> +
> +	if (msm_fw_set_clock_rate_for_bus_mode(host, clock))
> +		return;
> +out:
> +	__sdhci_msm_set_clock(host, clock);
> +}
> +
> +static int sdhci_msm_fw_power_state(struct device *dev, bool power_on)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct device *pwr_dev;
> +
> +	pwr_dev = msm_host->pd_list->pd_devs[DOMAIN_IDX_POWER];
> +
> +	if (power_on)
> +		return pm_runtime_resume_and_get(pwr_dev);
> +	else
> +		return pm_runtime_put_sync(pwr_dev);
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Inline Crypto Engine (ICE) support                                        *
> @@ -2550,6 +2659,17 @@ static const struct sdhci_msm_variant_info sdhci_msm_v5_var = {
>  	.offset = &sdhci_msm_v5_offset,
>  };
>  
> +static const struct sdhci_msm_variant_info sdhci_msm_fw_v5_var = {
> +	.mci_removed = true,
> +	.var_ops = &v5_var_ops,
> +	.offset = &sdhci_msm_v5_offset,
> +	.pd_data = {
> +		.pd_flags = PD_FLAG_DEV_LINK_ON,
> +		.pd_names = (const char * []) { "power", "perf" },
> +		.num_pd_names = 2,
> +	},
> +};
> +
>  static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
>  	.mci_removed = true,
>  	.restore_dll_config = true,
> @@ -2566,6 +2686,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>  	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
>  	{.compatible = "qcom,sdm670-sdhci", .data = &sdm845_sdhci_var},
>  	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
> +	{.compatible = "qcom,nord-sdhci", .data = &sdhci_msm_fw_v5_var},
>  	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
>  	{},
>  };
> @@ -2587,6 +2708,21 @@ static const struct sdhci_ops sdhci_msm_ops = {
>  	.set_timeout = sdhci_msm_set_timeout,
>  };
>  
> +static const struct sdhci_ops sdhci_msm_fw_ops = {
> +	.reset = sdhci_and_cqhci_reset,
> +	.set_clock = sdhci_msm_fw_set_clock,
> +	.get_min_clock = sdhci_msm_get_min_clock,
> +	.get_max_clock = sdhci_msm_fw_get_max_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.set_uhs_signaling = sdhci_msm_set_uhs_signaling,
> +	.write_w = sdhci_msm_writew,
> +	.write_b = sdhci_msm_writeb,
> +	.irq	= sdhci_msm_cqe_irq,
> +	.dump_vendor_regs = sdhci_msm_dump_vendor_regs,
> +	.set_power = sdhci_set_power_noreg,
> +	.set_timeout = sdhci_msm_set_timeout,
> +};
> +
>  static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>  	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
>  		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> @@ -2597,6 +2733,16 @@ static const struct sdhci_pltfm_data sdhci_msm_pdata = {
>  	.ops = &sdhci_msm_ops,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_msm_fw_pdata = {
> +	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
> +		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.ops = &sdhci_msm_fw_ops,
> +};
> +
>  static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
>  		struct sdhci_host *host)
>  {
> @@ -2665,8 +2811,21 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	const struct sdhci_msm_offset *msm_offset;
>  	const struct sdhci_msm_variant_info *var_info;
>  	struct device_node *node = pdev->dev.of_node;
> +	bool fw_managed;
>  
> -	host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
> +	var_info = of_device_get_match_data(&pdev->dev);
> +	if (!var_info)
> +		return -ENODEV;
> +	fw_managed = !!var_info->pd_data.pd_names;
> +
> +	/*
> +	 * Based on variant info, differentiate platform initialization
> +	 * for local and remote managed resource platforms.
> +	 */
> +	if (fw_managed)
> +		host = sdhci_pltfm_init(pdev, &sdhci_msm_fw_pdata, sizeof(*msm_host));
> +	else
> +		host = sdhci_pltfm_init(pdev, &sdhci_msm_pdata, sizeof(*msm_host));
>  	if (IS_ERR(host))
>  		return PTR_ERR(host);
>  
> @@ -2684,12 +2843,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	 * Based on the compatible string, load the required msm host info from
>  	 * the data associated with the version info.
>  	 */
> -	var_info = of_device_get_match_data(&pdev->dev);
> -
>  	msm_host->mci_removed = var_info->mci_removed;
>  	msm_host->restore_dll_config = var_info->restore_dll_config;
>  	msm_host->var_ops = var_info->var_ops;
>  	msm_host->offset = var_info->offset;
> +	msm_host->fw_managed = fw_managed;
>  
>  	msm_offset = msm_host->offset;
>  
> @@ -2698,6 +2856,32 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  
>  	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
>  
> +	if (msm_host->fw_managed) {
> +		ret = dev_pm_domain_attach_list(&pdev->dev, &var_info->pd_data,
> +						&msm_host->pd_list);
> +		if (ret < 0)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to attach power domains\n");
> +
> +		if (ret != var_info->pd_data.num_pd_names)
> +			return dev_err_probe(&pdev->dev, -ENODEV,
> +					     "Expected %d power domains, got %d\n",
> +					     var_info->pd_data.num_pd_names, ret);
> +
> +		ret = sdhci_msm_fw_power_state(&pdev->dev, true);
> +		if (ret) {
> +			dev_pm_domain_detach_list(msm_host->pd_list);
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to power on domain\n");
> +		}
> +
> +		/*
> +		 * Skip initializing clocks, regulators and reset in kernel
> +		 * for firmware managed platforms.
> +		 */
> +		goto skip_resource_init;
> +	}
> +
>  	ret = sdhci_msm_gcc_reset(&pdev->dev, host);
>  	if (ret)
>  		return ret;
> @@ -2786,6 +2970,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +skip_resource_init:
>  	/* Reset the vendor spec register to power on reset state */
>  	writel_relaxed(CORE_VENDOR_SPEC_POR_VAL,
>  			host->ioaddr + msm_offset->core_vendor_spec);
> @@ -2917,6 +3102,12 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  bus_clk_disable:
>  	if (!IS_ERR(msm_host->bus_clk))
>  		clk_disable_unprepare(msm_host->bus_clk);
> +fw_detach:
> +	if (msm_host->fw_managed) {
> +		sdhci_msm_fw_power_state(&pdev->dev, false);
> +		dev_pm_domain_detach_list(msm_host->pd_list);
> +		msm_host->pd_list = NULL;
> +	}
>  	return ret;
>  }
>  
> @@ -2930,6 +3121,12 @@ static void sdhci_msm_remove(struct platform_device *pdev)
>  
>  	sdhci_remove_host(host, dead);
>  
> +	if (msm_host->fw_managed) {
> +		sdhci_msm_fw_power_state(&pdev->dev, false);
> +		dev_pm_domain_detach_list(msm_host->pd_list);
> +		msm_host->pd_list = NULL;
> +	}
> +
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	pm_runtime_put_noidle(&pdev->dev);
> @@ -2947,6 +3144,9 @@ static int sdhci_msm_runtime_suspend(struct device *dev)
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  	unsigned long flags;
>  
> +	if (msm_host->fw_managed)
> +		return sdhci_msm_fw_power_state(dev, false);
> +
>  	spin_lock_irqsave(&host->lock, flags);
>  	host->runtime_suspended = true;
>  	spin_unlock_irqrestore(&host->lock, flags);
> @@ -2967,6 +3167,9 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  	unsigned long flags;
>  	int ret;
>  
> +	if (msm_host->fw_managed)
> +		return sdhci_msm_fw_power_state(dev, true);
> +
>  	ret = clk_bulk_prepare_enable(ARRAY_SIZE(msm_host->bulk_clks),
>  				       msm_host->bulk_clks);
>  	if (ret)
> 

