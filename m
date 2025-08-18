Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECC31B127;
	Mon, 18 Aug 2025 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516592; cv=fail; b=UCprg3p9YrhbYW8QgPT1K3oV39Ew3cn6iMiwpCXOA00/rqss35wn5JG57sqH4bsud6sqRCOnMyQIrTVdBBe8ZWY7BwVkUwOyDAsPGhoOUISUmJTiIoJyMrSRTbMbhGTy+jLSOD+TYBZBOWNIonfpssArRlkIzabU5N5F0dUrdZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516592; c=relaxed/simple;
	bh=SiKandwMco6zjqwdTuZ59RFK7pxQ+VajPWK6AGs/wU4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BHh1snz398A5mkrwGoU3MGPYCd+LPkW6WPXhc/rSOuZluEx06Qnon9a9D73gGNVWSPy4r0zYOEMiB3+BUcXbwV7Q+6hUPbGV3nAA2pYwrSYzvu5dlyLSb4UuKQfe+l7Zog4JtqWGfr/z99CawnPqXfeY+nK+fA9ylIHwkC/Jmn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVm9tVbr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVm9tVbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755516592; x=1787052592;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SiKandwMco6zjqwdTuZ59RFK7pxQ+VajPWK6AGs/wU4=;
  b=JVm9tVbrCkNHwcRcm7Pakt8a7A/dRo1BRSpLPvaE2QQV+155/KZeY96o
   nVoAMGwo+J7QrjJI/Yyorjx6WjSOl+Ng2yUn1AVD7CDp2UvvzUoDR2YS6
   GFxAWkt/r6/cXS7bxcVgr/TEXVC5VnB9fCxwedzJvMDyIGIE5FLS43N3U
   mP3thMOt3egnV1oEVDJSFF1DVLN1vTo/H7seAcRdl6hj+4VK/kOP03BhW
   o4b3ikR3Z2eSZbvbTjN3w8IMAEuYV9eJ/5C/54vf9uDEaHDJikUScxGDN
   dHY4htAbBpbCpv+qd2FF9f0impKkzFt05/0mtU9SysT64/QhxdvQcHEEH
   w==;
X-CSE-ConnectionGUID: veC2TaUcSI6+0Rz5rg0FCg==
X-CSE-MsgGUID: 7MPciqFnQD6rk9054Tmyzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="60360914"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="60360914"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 04:29:50 -0700
X-CSE-ConnectionGUID: 3n3Nj3iuQ/SDzZEe08Y6Fw==
X-CSE-MsgGUID: lceCXayDT/W5IenksZfNrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="171978348"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 04:29:49 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 04:29:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 04:29:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 04:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoLw225cVimXKOdSnjC01YJD5s4dt5aMYv+VAnTTjpZ8SJwmnVv8SyyR8fRVWbYeElMBZhigeCNrrU7p0oBIZT2n66Qz2m/DqZkxbcrhnRXgaRXQ73Ct3sBycManU7hi0aSKMp1eeLYJyIj8qMUyuO7hreDAzX31FMTST9Q5+lzoYbx/xGymK5buS/Ch/XnwlOhNH5DWcNEnkDrdjPTYvA1sE7vP4bc3RK/5hNU5plHyVb8zCbh2XW/8xE1yxjnSmIFRYiMnv90vYQYbkU9Y6sdO973a2im9WV6s+Tg9GHEqgMhWVHOmlpGvnNIZXDTTu5XNcuuIUytljhMRLALXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNcFfPYT4aboCmfi3kNthApXOlhYhB5e2fXfU7oz7x8=;
 b=jRIdeXU2zR45tPO7Pe/8Hs/dGNVsync3C1JAnPsfYcx1cJtB6Z4mVPFqI0y/+B9nPVPCdneErRJ2ulxq81oCEwcYknRhi4GcJf5UDOrwReeLWKFcffiuk7B+FMuebnamfQhHpHZmihKEFKOkMllv64WnqenLDTWbMmrWHI/V6qI7UxpUf7GmIAFGSMI4lfGnZ9cmhJ70T3SpNWNvzg8vv1xJB211/G8MBwo+gSgBRSDSGZ5TO3IJKfFtdWs5rwOus1a1DAJULn0fmzSKE/d1yGZvkMrvlkEuy93WoR6WLYgXWn5U7Ui/7xrqeVjeOONoE8nkwQNR39q+I+hID7z0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by IA3PR11MB9205.namprd11.prod.outlook.com (2603:10b6:208:573::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:29:46 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:29:46 +0000
Message-ID: <3a6b2ebe-d8b0-4199-b068-67d257aa9548@intel.com>
Date: Mon, 18 Aug 2025 14:29:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/38] sdhci: add some simple inline functions for
 !CONFIG_PM
To: Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
	<mirq-linux@rere.qmqm.pl>, Jaehoon Chung <jh80.chung@samsung.com>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, "Heiko
 Stuebner" <heiko@sntech.de>, Russell King <linux@armlinux.org.uk>, "Chaotian
 Jing" <chaotian.jing@mediatek.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "Shawn Guo" <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Kamal Dasu
	<kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Haibo Chen <haibo.chen@nxp.com>, Michal
 Simek <michal.simek@amd.com>, Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>, Ben Dooks <ben-linux@fluff.org>,
	Viresh Kumar <vireshk@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, "Chunyan Zhang" <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu
 Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, "Alexey Charkov" <alchark@gmail.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-2-jszhang@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250815013413.28641-2-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0209.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::34) To CH3PR11MB7202.namprd11.prod.outlook.com
 (2603:10b6:610:142::18)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|IA3PR11MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 79cd0596-cbaf-4740-2946-08ddde4a8891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnFHcmpuS1paRXZjRHFVeXlVRVk3a1pFY0dhUlRwYmJYNEZBY2lCd3ZLOGZN?=
 =?utf-8?B?WEgvTnpoKzgzSVNPcXFCTWxjQVdnZS9RUWc1WFdra3R3alVTb3pSK1oxeElR?=
 =?utf-8?B?dkpKM05PaktOaENsVmxGTEowbnBvaHpQeGtQczBUSVdKMnV2QTNLVXJaVFRO?=
 =?utf-8?B?Tm42ZUxmTnVwMnBJS1pZSFVWOWhmc3VzV0J1NWpVT01jY1kvNUc2OEUxUzA0?=
 =?utf-8?B?MG1TbUZZVG9WV0twVzdtVHAyU0pSM2JDcmNrNTNUY3pTenBidDdhbFZzbnN4?=
 =?utf-8?B?bmVzOFVhY09reEhhZVUrYzQraGgvQXZVTDA2SXRGRnE3Z1MvUnZFTGpyYXB3?=
 =?utf-8?B?SGdVZTV5TzVHSElHRHJ3djJraVNCK1lPc1ppR2NWekh1UHJGdXFpR25QWWtl?=
 =?utf-8?B?cEpvRitScHQyWVVNVWtYTnQ1Vzl4a3duRU9yc0VaeW15TnJjQlFtdXZPMGZi?=
 =?utf-8?B?V1pPQjZFYjBhc1RJZzBHZEY2L2Z4TlEwSnVEU0gxZGFoeDYxbkQ3NkMxTmNq?=
 =?utf-8?B?RmlPMG1vM2dmMHNFZ2lyQVVsTy9rYjlwTktWNkh1U1JnaU0xRUwwbGdxSkFr?=
 =?utf-8?B?MzBqVWlXbEhDbVJVbUwwSHA4bGhXTFlkREZlMVpLSC84K0FaNUR1REtoT2VQ?=
 =?utf-8?B?SlVTajcxQzJNVFNHSWVJdm12Y3RUQ0lJQkpSTi8vMUZOMUwwQWRaNitOL2F5?=
 =?utf-8?B?eVlLbm1GUVdZS2JKQnNmWHNGRzZveGluUXAvMEF0Y3EwMHRGMmJ5M0NCZGFF?=
 =?utf-8?B?d01NL0JkR3VRR1MwcVhLSjduMmtwSkdvNVRXOS81bTRrb2grLzV3MHpCektS?=
 =?utf-8?B?ayt1SGl5Ylp5SW90elhLUTh5c3BCZXdWTUcxTmpHYmZ2SnA3dFZMdDdCQll5?=
 =?utf-8?B?RGgrclJRUjBCbURGWHdKMy9EZlkwQUUxVVAxc3BEeGdqTUpCSWowSU9kT1Az?=
 =?utf-8?B?YXpvU0RvVk80UEl6UE9vaHNIeUZ3VDZIdHhVNkIzMitXNnBIeUszQUdWZHUw?=
 =?utf-8?B?OWg2ZTJxT0lYQ0JSSFUwQXFPK05MOERpN1lNa2lIS3BTZGkvZXFVa1VOcTBp?=
 =?utf-8?B?cmo5UEt6UUg1QjlzNm10VTlQTHVmVGJaOWdRcndSSFFLNkZiU1dmVXdzVlIw?=
 =?utf-8?B?QVg2VFlrOUpFbU8xNFJteTEzVVYwVDl0L3IvazdJdlhyWmpUbTVxaGpQN2RX?=
 =?utf-8?B?dmJpbHhQZHNHeTJjOHRVZlQxcG9lTjIwQjJoRVV3cS9oR0FRcmxUTytZdUFL?=
 =?utf-8?B?ZG56OXZjUGYvdmN5czRaZW5BUzhNNlFldXNqdDZTZUhRb21ETlpHQ3NJQ25S?=
 =?utf-8?B?UVRZbmcrZko4RkNseHAwMlVaSDFZdlhaWGtyMG0xeGpNS3QraXZSZ252c2tu?=
 =?utf-8?B?NHZmenNXcXdxWXl1ZUpZWFlzR1FRK2FTUFZZN1ZJaU9heTBaSWZ6bytPMXRW?=
 =?utf-8?B?a2xRM1N6SmxXUWt3YkVqa3VsRTBuZnRjR0J2Nkplb2U0VTNkbjRNMzBxK1do?=
 =?utf-8?B?MzZ6RTFHZktneWJlZ1BuZVUrUmJKNnd2dFZwS3dRcjFGYnJVMGhyMitHU2Vi?=
 =?utf-8?B?OFV0RHlJZzlNLzNWbFdSdGxkOWltTTBhWVpjZFFxR3pqbWhIcFJrYU15N3hB?=
 =?utf-8?B?UFJQUXBiV2NJWTZMNjVJZUtTUmR3MkJHQld4Y0JiT1VlblJRczgrelBEbWVj?=
 =?utf-8?B?ODhhamlNVWVuV2EyZE9DSDhrcVJyYXcrVWU0eldObU54ajZXVThscGtRZjhP?=
 =?utf-8?B?K2ZUN2Z4amFZSWNwTjZoQm1RYzB5elIzZzAxOWluRmJ5bnl1di95Nmo2M3ZE?=
 =?utf-8?B?cGFrZi9ZY0xnRGpVZW9NUEQ4VjZPbmVZWU1qMTdud0gxL3JlUVhya3BsK2U3?=
 =?utf-8?B?TFc1Qml3MDUrUG9TN1pEYmltS2JzUlkzenJKR3ZLSExTK0FZYWZRUHVpVVVa?=
 =?utf-8?B?OVM3UEs0RDRuc0ZvMXEyTDNibEQzL1RCc0FLQnNvM2I5dDFndGtLQVZmSURx?=
 =?utf-8?B?bThveUVYbFNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1hHYzhmclFkbHFuc3FWYlp4bW9iSXJ4Si9yN0ErT3FYQmdvQThSVDJSdEdR?=
 =?utf-8?B?RXhIb01xRXczWXpGYzNRWHRRRmpMdVFDeSt3bFNDTnl2YkNEaU12Y3pBYllj?=
 =?utf-8?B?WXI1L09FaWFjaXF0ZldaaWZHNnF0VnluUmdLajdQMzVNNURnYlhGNzF2bXYy?=
 =?utf-8?B?cmZkTkFFRTJSVWMrbVdHUWZZQjBqRVVuWlMyUTNiWGwwNkR0NXNOcm9FSzJa?=
 =?utf-8?B?OWZxbWJVZ2J3ZGlrend6TTFrM1B1M1IxajJZWEJWOG9uMHBva2hocnlSQW5j?=
 =?utf-8?B?STFhbWFjbzczMkU1dzRmQzJwWmhnODhNZUw1b0FjcFdxV0dxRDlUeFZrTkxo?=
 =?utf-8?B?QjY3VzBnTFNINDQzYVlmcVJvMFdWc28yYUFtV3Rsdjd6VkhJM0lTNWRKV3JB?=
 =?utf-8?B?RjQ2aytEODdEN0VxNldlU3VJbUlJY2F1dno1SVI1RjMyS2RMNEJQdGEwSDBE?=
 =?utf-8?B?U3Y4OG40Q2loejZHZHQweVpCNzhhenV3NGJmaTZPZ2V6dkhkZ0xwK3FVSHhL?=
 =?utf-8?B?ejV6ZjljcFN0SnBKb1lRdS91Wk5rR2NUNWQ1dk9pU0JDMGVXMEUvYmVYTkVi?=
 =?utf-8?B?N0NkanlXZjFqeVI5R1hhMXlIUXVvVnNYK2RlU2NVK1hkTzl3WDBZanU3Lytz?=
 =?utf-8?B?T2RwRE1FTUNCRms0YThpbDVHdTYyak85SnFnVldnL3dLVHBUZXNTaHFISXhL?=
 =?utf-8?B?N0Vya0FmNlVEV0pMazFja0FnNktCOUZRSUxuRGVWbmtjYnhoaHdVYjJkb3dO?=
 =?utf-8?B?NDlvMHcrOHRjRTFqVWtGc3U5U2I4M2wxQlVDcDFNZEY2UDRVdHQ5cnNhOW5I?=
 =?utf-8?B?RUlFM0c4UTlobEFLcFh2OHViaEpvYTRuSW94T05ZdER6QVczalVmNDJWYWFM?=
 =?utf-8?B?MHorTkp0VlBwdGpIK3dyQjR3VzB4em11eXc1OHJLRUZVWGZzVHhUbEtGamJH?=
 =?utf-8?B?eEo1R3hQN1V2YVEzUEd6Q0JuRnd0cGIwMUxKd0dTWEF0TUpFVGlMZVBsMHd2?=
 =?utf-8?B?dVY4dkJTdkk1eWVhOUJ4a2hzR1NlWTNxcGphYmxvZk5CUlZoM1lZRWFncmhE?=
 =?utf-8?B?YXRsaVpkVVdHSGJJQUxFR1VJZjJZWGZUcU52RTY3MjRxUjJUYWNBWDN3NS90?=
 =?utf-8?B?czNSL3ZvRk80blhKQ3FrYTdwa1F2VnozWjNabjQrZWhSalFGbEpLc05SZFVY?=
 =?utf-8?B?d2c2VUpFa2VlZU1VdENiOTNwaW5TcmVBV0RyemVvSDJseFMzeEs1MnlvV1gw?=
 =?utf-8?B?S3FYWjBpR2xPakM5TDVnRmI2VTM5aUxFS0xhNXJPRkFuc3NQalhWV3lzTFc2?=
 =?utf-8?B?Z0dYT29JeVAyOWZtN3dYR3BXU2h2MWpkSkl2Q04zSlU5dHhFTGhySjU0QTFz?=
 =?utf-8?B?Y09ISEMxKytpRDJ5Ri8xQTRCRUVjUnJTSlB3Rk5VWkpKbUVyUWdCdmFOWG85?=
 =?utf-8?B?SEh0S3pNempCQ0duNCticCsycDBrRHVWcDFtZHpkUjA3b21EME4xQzFGcHQz?=
 =?utf-8?B?RUticklQVU1mb082bkdPemVNYkhrVnJBenhHck1HVkZpN2JSODhoTjAxZzVJ?=
 =?utf-8?B?QldzZkQ5dnpyeUJrQlpyMVBlL09pOHJ1NVlRUThQaC80U3ZKWXd6azVydHB6?=
 =?utf-8?B?QkhRU0VGRjdsZE03d3RTSHRDaFN0YjVTcmVaNVNTWCtUVkpZL2h6VEZjbVZl?=
 =?utf-8?B?bm84UmdZMFNBVjEwbUNGTFU5UTRjRlk0TmxOaHczazd1WmxneUhKTXF2K0lz?=
 =?utf-8?B?VTNRVENPUzN5RW9DL1d6ek5YTHVXMDhnMEZqdlVuOXBsVlhBZEZnR2g2OUtm?=
 =?utf-8?B?OWEvYWNrazdHQXVRdmJFcHBSYjduQTMyYzF2Wk5QRVFNcXdLMFdQc0tXeGpq?=
 =?utf-8?B?RFVCSXRPSGR4cCtSVS8vZmRkL3hpOXRWU2tua0UzRFpOWUt2VDFXMlpBOGtU?=
 =?utf-8?B?SDFXR0FUNXNmTzZtdXZ2ZXowa05TQVZMT0xuL1lGbDJqenFvNmpIczFURWdN?=
 =?utf-8?B?NGI0Q1A5NTlyOG5pc25sdUsrSmpYL2ZtOWZCSk9NNW5KcnQ3N2JvdzJzQ3ow?=
 =?utf-8?B?aW9KNitrcjZMUmZGQWppcjZPdVFrOHBEU2lKZXZHL1Y2cjl4cVYzcHhpVkh1?=
 =?utf-8?B?N2ErMDlpYVg3bkhlTHNKM05MSFM4QVRlMmRmQlBXVnZHTm4wUnpzUVBmcW01?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cd0596-cbaf-4740-2946-08ddde4a8891
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:29:46.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05EdbFwOvu10elUyyK9QxRUiukqRSEzOSSdWkdGUF9hjkvwQuEZAf2XW0ELdTpQ76fk0g0e6VXCENwZwzPrgqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9205
X-OriginatorOrg: intel.com

On 15/08/2025 04:33, Jisheng Zhang wrote:
> In next commits, we will switch to the modern PM macros.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Subject would normally begin: "mmc: sdhci: ", otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 58fcbeaf281e..5b699af04bfe 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -880,6 +880,13 @@ int sdhci_suspend_host(struct sdhci_host *host);
>  int sdhci_resume_host(struct sdhci_host *host);
>  void sdhci_runtime_suspend_host(struct sdhci_host *host);
>  void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
> +#else
> +static inline bool sdhci_enable_irq_wakeups(struct sdhci_host *host) { return false; }
> +static inline void sdhci_disable_irq_wakeups(struct sdhci_host *host) {}
> +static inline int sdhci_suspend_host(struct sdhci_host *host) { return -EOPNOTSUPP; }
> +static inline int sdhci_resume_host(struct sdhci_host *host) { return -EOPNOTSUPP; }
> +static inline void sdhci_runtime_suspend_host(struct sdhci_host *host) {}
> +static inline void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset) {}
>  #endif
>  
>  void sdhci_cqe_enable(struct mmc_host *mmc);

