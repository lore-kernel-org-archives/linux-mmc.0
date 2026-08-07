Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3D41F5D9;
	Fri,  7 Aug 2026 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104930; cv=fail; b=q+l1wb0ohT8YCbHXyaLOVzmMnfaZG7oVYlHDSuE/bHUyxncOWf6dw6JizpxnXeF43O2H6do78H6/PVX9mLMyXdI6PLJjixDWiihvq9HBzWtn3q1K2/5u/98VhiSH4gwW3vImw/SpMVKMukU/e39+6yBWduTk2NcBeLYtTV8gqj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104930; c=relaxed/simple;
	bh=XZDlE/B6azKqQ2XJxeQwZ5UOkPwCU/GHC9MqFegiaE0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RCdoq2j3hhSUmEvbj86JQtFNae2u7YTY+dQdJsq5rcvz/AToV9fAczLEp5VlsVxtNEm3LJlK3RzUyNm+tLIfWtRW7ydpsljdvdmiRQ6mQhXmprkDf0cCCdXZQWURl9jHt5Un2sASsh+u4iemaduTOK3raeN6LYyUqUcAhI3RX+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNfHf0YS; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNfHf0YS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786104910; x=1817640910;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XZDlE/B6azKqQ2XJxeQwZ5UOkPwCU/GHC9MqFegiaE0=;
  b=SNfHf0YSvRCfPaf4IMJcp2PXCRFeLwpZ7gDyTUgnlRSWDvktGoRRrUz4
   o4e4FpgwI/PHVcMN7XfwlxXkExjYw//Jv8oLTYeQnyUcUqcMmfiYgpjKx
   54XHIXhPOsD3dQ0f5z0cYb5GxC39oD6h5E9x/qpBytmz6jEfv9itZZ3um
   boKyw6pO8RtU7K7QEl3/hRu8tS9UFSfAxJYolvD2+s9X3pkbiaPR9f2gS
   0YUhXA1UD4vp4s6pgwFEQ7NbOqaQok96SkSy/PaZgxNV6UGrRqSV5u3uX
   ATmmyr4UTW4PlbMZI9U9dPw+W5U6zxwqzsPbHh23xrP7bRv74PglnU8/E
   A==;
X-CSE-ConnectionGUID: /2iSUhe7RvGDQ5SkrM3fkw==
X-CSE-MsgGUID: r1yQaBmtS/mREWhRogPkXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="112259141"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="112259141"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:15:05 -0700
X-CSE-ConnectionGUID: 6+Ir0K5yRVir7xpaRZo+jQ==
X-CSE-MsgGUID: nuIPKRReTXSMM49rB/vkMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="265853870"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 05:15:05 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 05:15:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 7 Aug 2026 05:15:04 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.61) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 05:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkvF1vwid/iiMRcNXO+49SdX6T0KweE/ezhxHhrxkwCluNbbGui7cdsEzQCtA5OmNEhiEbnmMvvRcAqHQd+P9JiGoVpCEU6Y+bhrkMLBD1D+pKPwXkLVO6V/6bHUMcerKXgctZMzE9XCOzXkZ2sfXp0mT/pQgGDUhDHYOKmeKXZnEcwEANCwm+9tsPKMuWsD8XaBv0cza8DBkvXqj1gujFXxDklecRB11YPvKDirBOtcbZvLGh5DBc/UVTR/sdteT4tFgJtC4Vcfp0AbkcJSX5fwFIGP4W8cAbfNGq9RKCKWZDGQIEHq11GCM02m3UjSEUxPlrr2YvFUcRGRgXI9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93cenNaXe/8eaw9I6C5kooC0bo36pN6EONvNlmFNw90=;
 b=HsHKJKU8dUZUUjlO+ZXm99uHS5XffZCDXY0eZ2GYJDQ1ZrRihjANuX+1NHggX5YXzwagWKl3GZjJ+uxhQbeOlEo03jIt/mAO4Xf4OqPaFRyvpgAxltYH56/nKXlxfQ+nG6zmWkJqCVyF9YTYcedWt6ZhdSPP8BNmM2ob029HgcfYzbN9SIJhOeZntn8fgQnYsRAbEDHxKxs6FSVNU386S9162sWp2AarHqbTQp4KtzVNHalbVYLovi5T4FPvDqiMslLB5m0Eq0wMQTXKwP1fnagh0SS+dvjNo4nrEGKOKPWwEiQyIj4DtTnrjg8GplbjuXYC8KfV4bExIzKgSAqVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS3PR11MB9793.namprd11.prod.outlook.com (2603:10b6:8:363::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.24; Fri, 7 Aug
 2026 12:15:01 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 12:15:01 +0000
Message-ID: <fc5d734a-c02e-4e4a-ad32-a4d75b417f70@intel.com>
Date: Fri, 7 Aug 2026 15:14:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] mmc: sdhci-cadence: rename SD4HC symbols for SD6HC
 groundwork
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	<linux-mmc@vger.kernel.org>
CC: <ulfh@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <dinguyen@kernel.org>, <p.zabel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260724145009.7456-1-tanmay.kathpalia@altera.com>
 <20260724145009.7456-5-tanmay.kathpalia@altera.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260724145009.7456-5-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0027.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::7) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS3PR11MB9793:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f6b62f-8e8b-4df6-3055-08def47d7798
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: MV1X7RjgwmPJi5nxqX+3V/uGVYVHHG3jfsPpUT9f7WXkTG3aG1aimLXpmN8TDNN7SXnGdsGZPXwVyXOwbXHXpiigLz9hd1js9LYiH58/72pNG3nl+3p0igDsvNaM+v6HTwI+1v/Ps15WOt5IklJBs6K4yCXhqarH5nHevbNJcqEIwupUvVyD6PWoRKaMzS2Pn2dr3bK00VWAvO+2rtB6BhhmBgPDBdHKj/KMXR8iRBonAaHE5/pXdwUULPDm/8BOwlSP82wzCag52T5lt0qqGPSGj4g2AdAedQ/Z8Z8MCa3IDgHmzpwh2BO0z6DGYCTAinYYBsJo+AOG78j4aoVJSb3gvTcJTrQHN73ZRAM6RkO0aQFmZj/thab5mN8WrVsAzpUj5fe9CQwy/xt7gxcitvVTLLkMLywazBYZUcs+pfwkmnt4SGRS4nq9/tg4W7N9g5LvJC3wVPQriCBntfco2j/IS/V9IOFDfJPDP4waOoJrS0XIUyONx4+Mk2lQnRLUrLDknO8Jl/a76fNgIQy3SokWrG/RaDMwbkrzy1Y9hdXK7cHFyK+9daIJygoWPHz5kWWOFiv+ncPgsvA73Lnrks4ZWGHxymoyI3cNhLIGipzxaHtPndptFe9odUcqSVUUHNbTVkQNxMY4fDvxJfsM/zbao11ER4KdV2sugd0R0O4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZEOUZWbmE0NE5SY1huUHA1dGY2QkRaYWVNZ0lBUUtmYXQwSnZCMHpoMkt1?=
 =?utf-8?B?azBqejdhRmNLOVFOa2RkMnhwRGMyYWl3VS9mcDJHN0J0Ym82dkoxZUhMSUls?=
 =?utf-8?B?N1lPbjg5MFlZSENVWURERkswSHNYRUY1N01Wbzd6NlB1OE55WkZCSjF6bldz?=
 =?utf-8?B?ZFVXeHlDOW5ENXlUK2E2RFczRllOUmxGMjBWSGtNVEhuMHlVL2o0emtiaTdW?=
 =?utf-8?B?WFBvRzhWZkZtUWVESmlTWFZvNWdPQ1ZxNkx6TjZST1FIVXlpRnJxelpDL3lW?=
 =?utf-8?B?ZG5UWHJCQTlTa1FIeHFnK3FveXpLVjlQWFcwTkVSUDZPQkZTQSs4THd3NGV1?=
 =?utf-8?B?d2F6SFo2YmlOVkVrdzZ2L25JTGIyQ3dCakFrblZnMkxaWWw0TU5ZOGwwd2tF?=
 =?utf-8?B?MGM2SURZV2FYWWFMTmFGWHUzaFpBZzVOSlNyZ21NL2JqK3lSVFJHbW5WRldJ?=
 =?utf-8?B?MnNLRlZkRmxvS3MxSnZPZjNCRWxQdERTci9TRTNoMmZhV1BCTFJNUEZ2RG0r?=
 =?utf-8?B?ejJFV0hjbmdWaFBsRUZtcDFBTDBlS3dCektNdGR3SzNzR3pMbGszbDBSSjlW?=
 =?utf-8?B?anlCOEhuaVVxdHV4OW1HaFhmUU13bGVOclpuZUZDTjZtVnNxZmVmZVhRRTNm?=
 =?utf-8?B?ajVIM1B0MmMwUE5DL1pTUzBRdFdhQW9Vb2N5VkwzNE5PTUhLYmRTU245bmZQ?=
 =?utf-8?B?a29mOHV1TXlIcGZlL0Zla1QrMDBVUVd1VERsMmU1SWNTdjZLYitja1RBbW1B?=
 =?utf-8?B?R3hFb2dEQ1lsY1ZWMmZrK3FJeG5wZkl0K2NjRFhPcUs2WDUzY2x0c2tIcVdy?=
 =?utf-8?B?UFF1NFoxWVpkTWFNbThiZEZpcUh3NFlOUUNCYXVreW1lMStRVEM0TjNGTDR3?=
 =?utf-8?B?SkQ4TU1ZdXp3YmlqT24wN3VCSFJJZmU0d2ZJcEw5L0xyVmpCQmU0cmltMHRh?=
 =?utf-8?B?STQ1ejEyQkRXaHZkNGx2a0xmZTJ6TVNWemN3dTBiL1c5bmd2cGc3UHB6MStY?=
 =?utf-8?B?dDVWa2FQRXNXdUFMREs1U3ZuOE12WnpCdWd2Q1VkTElRa3FIR3drWDgvY1Rl?=
 =?utf-8?B?M2dXOUF1U2F3QTljdU9PeW9TTXVKaXBWb0xTcHJMbEpYeXkvZmJIbkxZUm8w?=
 =?utf-8?B?bTFHdXU3TlJaT0VJcHpySWFoMDVGeFliWEZSQnRUOVhmWGlNSm1XalZwbnJa?=
 =?utf-8?B?eXEvMFdlbk5MYk11ckxiQW41SnVtNkFxekRzVmhIU3FSSkJzdGsxUTFyT2p2?=
 =?utf-8?B?bjZQdklQa2tUS0tIWGVpTTB2T0JzQ1AvVTZmSUl0bksxR1VodW1XaSs1aTFh?=
 =?utf-8?B?M3FNTVFBV2RTdHVHNGJHY2NYeFB1SzdPelN1SU9tK0t2RTcrdkZyT1dPY0tp?=
 =?utf-8?B?ZW1qMlAzWWdsRHljNTNaV0kzWXFTWHo1NCtxdkU0UEo0a0RhR1lFYjVPNk5X?=
 =?utf-8?B?MUpYVkZqazdCL0lQTThaNDRaMUNMZzk3TEFoVnhWbm1EaXpML0wyNnpMQ2x4?=
 =?utf-8?B?dUx2WTNmcCtsd0dNYVZjd3I5Wkx0N0tNUHdUOGxsMUs2L0ZMRWpQaWpscWF6?=
 =?utf-8?B?QjhuT25ySkc4NkFObUthWUJ2cEMxU3JWVGpnRGhkVXNhZkZxYXRlcEhpZWgr?=
 =?utf-8?B?R1A4VXloanBzWGtEbW1OTnB1eWNrelV2a0dJNThkYzdOelZINFlJcmhycDlw?=
 =?utf-8?B?TEFyMEtjaUhCNzQ4RkExYzRlaWNDSzl5NUpCbFlETmkyRjR3Y1BWK0l4R01a?=
 =?utf-8?B?TWNLbEFQQy80M1UvYVNRN2djRUdxYWtoalBSMEpiQzJIMHlXT3R2Sll6cDcx?=
 =?utf-8?B?QWRHaWFOMyt2NXRrR2E2VVhQMitTY0tpRFdKcFdNZ1VmQkx2QU1MR2FiNzhX?=
 =?utf-8?B?RmZCQlY4aW4xMHJheGhFS1VmcFBNcklaUEdZdXk0THc2UkNobERza2toVHgz?=
 =?utf-8?B?WFIwSlBLY2Q3elZ0M1d3L2dHTmx2VCtzRUdVSXJHYWNZd05TcXAxODhTaWVN?=
 =?utf-8?B?TDJUUCtSV292bUFySmNrcGx6SGJhVXY1MStaVVZaQWRIOS9oYzZ3UWJGQk5v?=
 =?utf-8?B?SHIyOVlITTJheFNGcVkxeHBIeTdFS2g4a1N4c0dUTkZYdGFEc0ZOMTR0ZzlW?=
 =?utf-8?B?YjVmZUJleWk5cTVlTThKbHVxWkNqNTJTNkdKdEFmU1VoY2R4RTJvUWg3WW5t?=
 =?utf-8?B?c0hiVmZZMHZ3YW9zMGI3REVPVXIwYURXTEhmb3N3dnlkMTF1LzlXUDR3NmNy?=
 =?utf-8?B?UE5OeWxsdW96dDN3dmpqblg4ankxZ2g5OFJKTWw2MkVoYklXeE0xVndZYWtl?=
 =?utf-8?B?a1E1YTZoY24wZjVwSFBMc2FJVkw2T3dBUTQ1eG0wWVlDbnBDeUVMNUF6UkNt?=
 =?utf-8?Q?KROSwD2VEguE0MC0=3D?=
X-Exchange-RoutingPolicyChecked: Zyh5prQA22sVmxxY10FSvEzUlTiQUVNSCEOm0HFdkRCLtoV4VNmuEbY/oEXAUNJV3xfod/35FJjmR1Kx7NRl4tzifeRN1H/4PTjvHq5tNaHtlCvEaBsrqiIeFY4KNtrONpKpXtz1do0ngGZqxw4MVbTkLRH2a2Ec1Et/NTNEfYgdtszkqV5d8cSmBoZnvxDW62V1HK9JtV6F/JjGbper/3TjzN+0cedMgdCXeIW1U3e/Blb05/GCFnLUFTB4gqN8vJXxjL7jxaiQXz0xXDLlXJowL4GaQxANwfSpVFLsxIYZ1Hs0ZbInLUtxlW5nOW8TeLSNODcOI2PHysGoHVsdsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f6b62f-8e8b-4df6-3055-08def47d7798
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 12:15:01.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q7uqdgiDPtgkFYYiFwMgnjtP+vDBjXsuO5NkKTsJVGAIN69t5a+BcA3RmY4VtXJkCOzt4Ek5ozBbAefukPNpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9793
X-OriginatorOrg: intel.com

On 24/07/2026 17:50, Tanmay Kathpalia wrote:
> SD4HC PHY helpers and the default ops/drv_data are not marked as
> version-specific, so it is unclear what is shared versus SD4HC-only
> ahead of SD6HC support.
> 
> Rename those symbols with a cdns4 prefix to separate the SD4HC paths
> from the shared driver core and avoid clashes when SD6HC is added.
> 
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-cadence.c | 55 +++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 435603c8c00b..8a6ef6d9d1dd 100644
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
> @@ -124,8 +124,7 @@ static inline void cdns_writel(struct sdhci_cdns_priv *priv, u32 val,
>  	writel(val, reg);
>  }
>  
> -static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
> -				    u8 addr, u8 data)
> +static int sdhci_cdns4_write_phy_reg(struct sdhci_cdns_priv *priv, u8 addr, u8 data)
>  {
>  	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
>  	u32 tmp;
> @@ -156,44 +155,42 @@ static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
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
> +static void sdhci_cdns4_phy_param_parse(struct device_node *np, struct sdhci_cdns_priv *priv)
>  {
> -	struct sdhci_cdns_phy_param *p = priv->phy_params;
> +	struct sdhci_cdns4_phy_param *p = priv->phy_params;
>  	u32 val;
>  	int ret, i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
> -		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
> -					   &val);
> +	for (i = 0; i < ARRAY_SIZE(sdhci_cdns4_phy_cfgs); i++) {
> +		ret = of_property_read_u32(np, sdhci_cdns4_phy_cfgs[i].property, &val);
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
> @@ -470,7 +467,7 @@ static int elba_drv_init(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct sdhci_ops sdhci_cdns_ops = {
> +static const struct sdhci_ops sdhci_cdns4_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> @@ -481,7 +478,7 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
> -		.ops = &sdhci_cdns_ops,
> +		.ops = &sdhci_cdns4_ops,
>  		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  	},
>  };
> @@ -495,14 +492,14 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
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
> @@ -560,9 +557,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
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
> @@ -593,9 +590,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
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
> @@ -622,7 +619,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	ret = sdhci_cdns_phy_init(priv);
> +	ret = sdhci_cdns4_phy_init(priv);
>  	if (ret)
>  		goto disable_clk;
>  

