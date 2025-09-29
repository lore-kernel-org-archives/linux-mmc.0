Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBF2FBDFE;
	Mon, 29 Sep 2025 13:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152367; cv=fail; b=R66XgEDRb2srKPcq0nA3uQewNNSZBXKSB1pFJCroq+ARDlx201C810MDkoBFPMyxSoaVoUTjKKWcl9l7o4GSec5caAP0RChUBN76XQG/pfmlmXItO+oABIJ65dzRgHjpC1NdsW3nUrboKUkfXGSoqt2mzIaRXB4p/zNIZDnUoqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152367; c=relaxed/simple;
	bh=vHB3fZ7lfQ6n6/ozYeTJY/XXXl1ajw2g+egvngCwaMQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ska/tRcniIBGz3+XgTAUFtDN0PhLtrA5ufhycuT36sCppjjxQxHdGH9Y0uKqJOuWdRnJuq4eibqoZu/62rLpLdnCx4VfXi9bbw2DHKDZWyxKQ2Np6UaFmYFC0UGk5LuToQM6JAIoElMZQRhoEYBWf7TfFLS0X7a7n1bQUIOascU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnn+wtwt; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnn+wtwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759152363; x=1790688363;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vHB3fZ7lfQ6n6/ozYeTJY/XXXl1ajw2g+egvngCwaMQ=;
  b=dnn+wtwtvN1AYZVS6Yc4unTQnHn52HgchRj6uZG7p54opUDZS9x/dNg+
   sunFhe0lhLRZg6pfU8x26lLXK6G640bK6Qp0yfstN5ReQ/j1Px0oqNP7X
   Xk+uSQ7u1QsPDs3rCG3t2GialCPwA1ZiVIEW7DsqmtiRhz27/n6oldxwD
   YmLpitgcxHHYGmTXs/321xzPz2r/rGI0ed/3cohTmkAKUygxY0yp54rQf
   DrYiR1Je0hbzgmd8+4Ed4Wk3IpQYqeZ91E2gWZ7CGqYUZ2aVAkomWU3Ne
   2Au0oSK69dOD+YRihCMC1M/RFIaVY+F7J9Vi7JD/TvW7XavImW162UjY8
   w==;
X-CSE-ConnectionGUID: P3YF73FmQGK6ceN2U/yjYA==
X-CSE-MsgGUID: wii2Jb8iRG+6P7Ec/cB5VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65027507"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="65027507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:26:03 -0700
X-CSE-ConnectionGUID: ZknXnwDCSxCHo0PZN6UobA==
X-CSE-MsgGUID: NYgH4JXlSZC24FHCvyW5OQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 06:26:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:26:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 06:26:01 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 06:26:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+aPBWGJWyAp7NdoircAqoB/+NHKp88pbzCd0cTX1v5GYK7yRjfQS/ljxXpeFMMrsqxzyep1+TB+kzrK2QZTyOrMLUZsiMpeYrAfSXbnYArcVZoEbm5q8cvYJKUSvrqE9ma7Y0OQbJEXlSjLggkcEjN7/TNGyftdNpfjAx9/v57uKJIooPuCWcbjs0Ly8nKXWDSZ+pZntBqf4xEweyq68RRVduin4VTccHEjENRf/cCsDMZG4fkJuib7fJwfNU/2HkW5zcfHt44tMs5JvhN1NkHgjfWU310Ckp9gj2UQJFrFUMwf/pmogc5Kixicu951nS+DQNr6p5JOPYynk8vr1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvkSmnsbjWgCRk7WoYGPZ2rCFT7QBrcPm9Gt+BRzlj0=;
 b=TDCxeumQGMWQCSY+rgVPS1M8YW8oIdRUqMaxGoD9cQowymlz9ggafkrxlmo1kIs9fez0Asli7MDOFNgMvBVhRpY1mLUMxXghHHu2250IE0A63Lk/zf4tAsC8fFSevm0Tm4Zzva7B2CerS6een9UhGUrBnjfezZTBaiT97uxSh1eMXksU+o6AoELG+CBA1y+BmHNkC+UC5As45MP9/EDFFuqBKN6lB/0NpK+bpRqH6ek971eRBGX+acI++IuBoP0ykgk3UIoXndT04Khhx2NdmoSkyZU/6KipAzPfn8kTSWKOxEirFqZQgPUrN7ZtuI1Uj+Gn0N14ERLXzMkT+tV3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ1PR11MB6131.namprd11.prod.outlook.com (2603:10b6:a03:45e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:25:57 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:25:57 +0000
Message-ID: <72c6b6cd-943b-465e-9281-5ad7fb195433@intel.com>
Date: Mon, 29 Sep 2025 16:25:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] mmc: sdhci: add Black Sesame Technologies BST C1200
 controller driver
To: Albert Yang <yangzh0906@thundersoft.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>, BST Linux Kernel Upstream Group
	<bst-upstream@bstai.top>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
	<soc@lists.linux.dev>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
 <20250923-v4-patch-final-v1-5-2283ad7cbf88@thundersoft.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250923-v4-patch-final-v1-5-2283ad7cbf88@thundersoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0410.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::14) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ1PR11MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 74722f8c-5fbd-4ef4-f322-08ddff5bb8f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnBFWnlMdnh3WGFiMDRYTHBSaFBtSWROcUZtc0Q3M3M2MW16UDEwWFJ6Y0Na?=
 =?utf-8?B?ZGZaa0JuQk9oTnM2eTQ0WEFjQThkdmVsc3haa1JvWDRvU1ZqVUpwWS82ZlBF?=
 =?utf-8?B?VlYyNkZ1aXZVSGprK3JyVXVPVmFTZGJEVFRoV2tneXNRN0VKdmJzNnJsc0Ur?=
 =?utf-8?B?M0pFdWZrVThMVzZmQjNvTjNuSGhvRHprMFlkYlNacjZ6aFo0WFBpVXlNM1NB?=
 =?utf-8?B?QlpQZDVGbzYwckZVWnBvREg5bC95N3V3VlRZL00vZnlFaGZLcDB6eE55MmUw?=
 =?utf-8?B?Z0xVWWVYQ01odlNDZXNQeHM2UWdKaTNxWlg1UVJ2YlRqSHNIMU9qMEkyUm8x?=
 =?utf-8?B?TGhLQXhRR0pVU29tb1ZYNlNLcFhJdCt6K2lxQ0tzNHR6bmtRR0UxakJNYlRo?=
 =?utf-8?B?emU3T3p5Qm5tb3FMQzRYbVJBTDQrVy9maDRKV0ZWc3pxeDlvMjVRdlpkc2d0?=
 =?utf-8?B?bCtTVG5lNHNDWXoyK1BBdStobHRXc0haVitEcUFaU0E5Y1ZpOTRiejhhbmRG?=
 =?utf-8?B?WmFyWk5TNFV1ajZPWGFZUE1hRHRuNng2V09nTkJYc2xBaVBsM2g3cUtDbElu?=
 =?utf-8?B?R01GbTNpUm9HQ0lGKzVrNTgyMlVKZXlhektwa0NQVi91MEZCOEl5TVpjVWxz?=
 =?utf-8?B?bklvMGtlOENORDZqWnhFN2pkejR6d0lvUHRiNDk3T0dtcjRoalRmSkRLYzFi?=
 =?utf-8?B?cHNWbFJyVVg2R2djUG91Nm5xL0VxYU9JUDR4VUR3eWRtMmhqVEV4VEpLNDNm?=
 =?utf-8?B?VEhhYzgvWmtNcmZCMEdxQktMQ1RYN3E3bUlGN0F3TWh0bTUzV0FyNVJUdk9K?=
 =?utf-8?B?cC9MSFdFRC9SL0kzaVN5Vmo3M1BNN0JTTHVqOXVwTE5MUTNRRERFdU5JY2JV?=
 =?utf-8?B?dmdBZGNSZGpJRnVOWCszSjJ1UUoxaVg4ZFJwbDNBNEZLVjFiYUF0ZCswVG9m?=
 =?utf-8?B?Q3NuMUNYN0FNUmdXMWkvU3RQU3lKdEpCa0Z6VzE3WnZzSU90Zkx6SjU0OCtD?=
 =?utf-8?B?WXdPaDJoQnFSMmZLWnQ1Q2FhOWNYT3ExV1hlK1pqS1FaT2Uxc1MyRW0rYW5F?=
 =?utf-8?B?UTNCbjlaV0dtNzdaU2FhQmFyelhqalIzbUlXWDFtN3JmY3E3N2dsQkgwNWJV?=
 =?utf-8?B?SGUrQkNQSXhFUG9CUnZweVFSd3lRYm5RL3Q3TnhNKzNMY1B1eUVDaGtzZWhq?=
 =?utf-8?B?amVmYTl4TDh3blhpRG41SkFvNzBaOWlyRjFwS0EyanVBbzN4YmZ4RzRSZW1V?=
 =?utf-8?B?ZnJMb2ZJd21kSTFCR0FzcGtBTUtJcitNbjdKcWhEdFNPSzk5aEh6VmhZYzZJ?=
 =?utf-8?B?ZFdGalZ1cXBPTUpNUU9NZnNrdUNKZjhBU3FkZS9lak5aL0xmUERQWUpzN2Uv?=
 =?utf-8?B?eFFzQzFxKzBNaVMxeUhFMCs3cVRvc2FyanE1YlJJOEpGYis1Sm1XTE1zNVRJ?=
 =?utf-8?B?RXJIZ2lOVUh0bE0zTklRWUFnTjhpLzVyK09OaC94NTBHb0ZRbW9SOWtkNTRo?=
 =?utf-8?B?V2NYa2x0dlJ1anhhQ0dTdDRNZm9MSHYxdS9tWm1OcUlrT3VqRmo1RDEwb0RS?=
 =?utf-8?B?ZElmM2dOSVBjazQzTTZ2dVFDTmd1c3R2ODg0bjRqSjYyVGs2SVYyUjd1YzZQ?=
 =?utf-8?B?UWVOT0I4d0VJNWZoNk0xRnRLT09vaEtUVW9jNTBDRnRFZzZxYnhHTnhwMDZx?=
 =?utf-8?B?WDVoR2JIeGoxbzVhOVB6OWg4dkVSSWhWclRQc0Q3YWJCd0IvamhwZitvNkFX?=
 =?utf-8?B?aU1HTU8wNWhCZ3VuU295SGQ5cHozblVlWUtKeDdJbGZLcVNBZk9FVTJvaXc3?=
 =?utf-8?B?UVUrK2ErejYyckxja3lHQ0FFT3RXdWxjdTlGTG9sWnNlaURieWhSZ0pmeW1t?=
 =?utf-8?B?NDl3Y2hEeUVkRTZ5RWUyamtIcWo5dUNTWFJtNDNVRFZHbXIyYnI2SlIrWTVZ?=
 =?utf-8?B?S0VTb3Qvb1FhcG56RUYzUVZZaXk0U1A2ZmtKR01KcWlDZkFtUlRUbHZ2OHFH?=
 =?utf-8?Q?AAwHDl9ATqmwh1u6TjUiNzSclEf8IM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFXR1BPZjM4S21NcU5KQzdsT0lzVTVvc0dXaU1td2I4NVhvV2dNeXBJU1Rt?=
 =?utf-8?B?bUZRTnlWanpLVmtoc0pqclppZHM2WWt6WDRMRHZBdDBlZTFRWS9uSGV6dnJr?=
 =?utf-8?B?VlRGUngxNmZhaGZCd2drbDBTbzR4MEYvbE9LS2Z2VGhUY1RGK05odjF6OVhl?=
 =?utf-8?B?MCtGb3hUMGVkZ01jT0lYaEJVN1RrQXBHeE1KTm91K3dISnlPZjBvNHhXRUVJ?=
 =?utf-8?B?Tjh0Slk2eUVvZUlpa3JhRVhSUldXTGFTSTZVZjdGeFZEN1IwckFRWFc5U1Zz?=
 =?utf-8?B?UDduRlJPbVZ0SE9RQ3U0aGZoU0ZUWVNEdEFtdXNlRm9QaURrbzY3ZUJJVGtr?=
 =?utf-8?B?ZElqeHBMaUl5eGR6R1RLeUFiNURuL2RoKzNLMnpJQnIrVFNwMkF4L1ljTjRJ?=
 =?utf-8?B?L1V0bW93dS9YbWNtLzMxUFc5YjI3cnJTSWNIVTFMcSs5WXkwZXNEM2ZGT09W?=
 =?utf-8?B?TnpELzVlT1Y5M1pGTldDWld6cUc1VHh0RldRWHpPUVhueGxmZjR3WjZiQjJO?=
 =?utf-8?B?UWptdEkzbFdteUEwU0U3TmU3aFQxMXBLYzNabVgrSk9BdENIV3c2UzRyL0ty?=
 =?utf-8?B?VmgyZlZpMVk2K2YyS2VuVVNzVlZ6YUtib2w2ZEthejRJK09IRDUwc1ZPYWp0?=
 =?utf-8?B?TXUyNUhlQ05OL0V1ZVNJQTR1TFJ4d3MvUXNPUXBwUzA0Wm03ald1WXlvbTdP?=
 =?utf-8?B?anhrcWRCTXJtWEdjamk1V2c1amwxc1FUYzFlVGgwbWhLWmZWL2hxNDRhZHMx?=
 =?utf-8?B?Qk9vNVlSUlV3MWdlMm9NcUpnbkxCS0VxK3RUVEdiNGVHaEhJWGhYbUZuS29y?=
 =?utf-8?B?NEVyTU9vZ29wV0c2MVJOOFZTUjZoSUkyQ3FhbURjSmlYMU9vd0VTdER0dmdZ?=
 =?utf-8?B?ZXl3QURPaDYwTjF5Y210Q0lXUTFOVFB0TWpGM3cwb251cDJEd29YeUZRMFpi?=
 =?utf-8?B?MmJGb1dwY1VKTlRjWXNEZWRFYW1ISTJKSktQa00yVmpzMVo3bU1xYUFJQkxD?=
 =?utf-8?B?Wm9kV09hOXQ5eTQ0SEpjVEdUWS9WWFk0aXgwNUdNZWh5QXB2am1qWS92ZEp1?=
 =?utf-8?B?ZXlYN1NwMUk2STRkbHJDSWZkN3lXU3FJTFprVTd1UG1uQTJ2cEUvWGJ1TTU3?=
 =?utf-8?B?NlN4Uml3dTRyUkJRSDR1eVdlMThYUUpFTVJiWk9KYUo3WElMcmhKUWdwRExV?=
 =?utf-8?B?RzNwOGUrMVVHZlN4SDB5OHZJaGZpblBnWi9vS2QzcG9qOWZuOWhubEEwZ3FZ?=
 =?utf-8?B?WjhhcnQ3WTdpdENLTW1jcERQVTcvUHM4aSt6TVM1TUFQbzNHMDBHa3RtMHFl?=
 =?utf-8?B?elZqbGxzd0FkOWhNenp2MjUvZ25oYndmVW9XV0h0Vkt3dEE2blQzcVFUWjds?=
 =?utf-8?B?OWI3S2dFV3VYOEhQeXhFcDZ6Q2RUNG1ZVTdwQnNxWFAvKzVROVNiY3RLWTA3?=
 =?utf-8?B?WGcvNXhnSHFGdEhZSTk2TGdQUTZRTWR2RzUxLy9SeHlXcU4zcEtXZ29iTUJ1?=
 =?utf-8?B?RnZSZ0wvM29ZMU9aWGNjazJFS3o4enJJZGg3K2FYRTNMREdzQjY4emtDVjFH?=
 =?utf-8?B?c01aUWx2RDFWMFNybTBHbFhrbk9ubFNDaWo3T2NTT1pSSzZOTEN3WGVzcVlT?=
 =?utf-8?B?SFdydk8zVExTTjZtTXVEcW5mMzA5U2dzZjJ2bWZ1Slp6SGs3SjhaNUdwVnZQ?=
 =?utf-8?B?Q0I4elYvQXdrRjRCVE0zcGl1NGoxcWI0QjMwZGhzdHh4bDRBdExQdVplOTdr?=
 =?utf-8?B?elpTUVhVRDRncWR6cCtNWHI1SmZsZUF4ZDNZVGozTHpyWUFrTjNOTXo5bEl4?=
 =?utf-8?B?cEp1QTVTU2ZMa2pYY2NZdzRkVzJDSFgwMGFBbzRPd1pzMFdSU3ZhSW1Kbnl3?=
 =?utf-8?B?cDRBZG1wWlhOREdMYnU1dytiNDAxdjVGS0RhQ05MNGhMS0EzeUM1YUxVMW5I?=
 =?utf-8?B?TGc0WVBuNHVjazdOR2hSZ2NoTDF6YTZ0R01scUhxcEFwSUoxd1VaZVlCaUph?=
 =?utf-8?B?VTlxUmh2d24wYTRrTE1RNWlMWCthbE1FTzJiNWJJRThLVTdXSmRmTjRTYkhy?=
 =?utf-8?B?TE1tMGxiNE9veEVhaDJSRVN3MnN3MkhZclJpVnFIajAxYVZ5QlpydmJIbklo?=
 =?utf-8?B?VVQxeHdzR1U3blQvenhQaGNFNVF6QmduamJWVElRRzR2dW1JdmRTSit0Vngx?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74722f8c-5fbd-4ef4-f322-08ddff5bb8f0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:25:57.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkpEqHvKUv8/gTNOt9PHKXia0BJn7oqJnW+EuYnR1+f6d74R8bHzy0ghwx1vLfOfAtEZ2ZM4Yhr4heJ3BBdlxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6131
X-OriginatorOrg: intel.com

On 23/09/2025 09:10, Albert Yang wrote:
> Add SDHCI controller driver for Black Sesame Technologies C1200 SoC.
> 
> This driver supports the DWCMSHC SDHCI controller with BST-specific
> enhancements including:
> - Custom clock management and tuning
> - Power management support
> - BST-specific register configurations
> - Support for eMMC and SD card interfaces
> - Hardware limitation workaround for 32-bit DMA addressing
> 
> The driver addresses specific hardware constraints where:
> - System memory uses 64-bit bus, eMMC controller uses 32-bit bus
> - eMMC controller cannot access memory through SMMU due to hardware bug
> - All system DRAM is configured outside 4GB boundary (ZONE_DMA32)
> - Uses SRAM-based bounce buffer within 32-bit address space
> 
> Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
> Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> ---
> Changes for v4:
> - Rename all functions from bst_* to sdhci_bst_* for better namespace consistency
> - Rename driver file from sdhci-of-bst-c1200.c to sdhci-of-bst.c
> - Rename dwcmshc_priv structure to sdhci_bst_priv for clarity
> - Update driver name from "sdhci-dwcmshc" to "sdhci-bst" throughout
> - Add comprehensive register bit mask definitions and named constants
> - Replace manual polling loops with read_poll_timeout() for clock stability
> - Add dedicated sdhci_bst_wait_int_clk() function for internal clock management
> - Completely rewrite power management with proper power-off handling
> - Enhance clock control with read-modify-write operations to avoid clobbering
> - Add MBIU burst mode configuration based on power state
> - Improve error handling and cleanup in probe/remove functions
> - Simplify bounce buffer allocation and remove redundant MMC parameter adjustments
> - Add SDHCI_QUIRK_BROKEN_ADMA quirk for hardware limitation
> - Replace ioread32/iowrite32 with readl/writel for consistency
> - Update copyright year and simplify license text
> - Improve tuning algorithm with clearer variable naming
> - Enhance register access patterns with proper bit field manipulation
> - Add power-off clock management to reduce idle power consumption
> - Add Acked-by: Arnd Bergmann

Thanks for making all these changes.  There are a few minor comments
below.

> 
> Changes for v3:
> - Simplify dwcmshc_priv structure by removing unused fields
> - Improve helper functions with better encapsulation
> - Use devm_platform_ioremap_resource() for resource management
> - Update Kconfig description and alphabetical ordering
> - Clarify documentation on hardware limitations and bounce buffer approach
> - Remove duplicate sdhci_writew SDHCI_CLOCK_CONTROL
> 
> Changes for v2:
> - Remove COMMON_CLK dependency from Kconfig (MMC_SDHCI_BST)
> - Add ARCH_BST || COMPILE_TEST dependency from Kconfig (MMC_SDHCI_BST)
> - Replace temporary ioremap with persistent mapping
> - Map CRM registers once during probe instead of per-access
> - Add proper cleanup in remove callback
> - Refactor bounce buffer allocation with simplified error handling
> - Remove unnecessary DMA configuration layers
> - Prune unused headers and legacy vendor debug code
> - Remove deprecated sdhci_bst_print_vendor() export
> - Convert internal functions to static scope
> - Standardize naming conventions (DRIVER_NAME, DEFAULT_MAX_FREQ)
> - Optimize clock configuration routines
> - Fix register access macros for EMMC_CTRL with proper offset calculation
> - Correct device tree compatibility string to "bst,c1200-dwcmshc-sdhci"
> - Add robust ioremap error checking
> - Improve bounce buffer allocation failure handling
> - Update MODULE_DESCRIPTION and AUTHOR fields
> - Add explanatory comments for hardware limitations
> - Remove redundant multi-host setup infrastructure
> - Fix build warnings from lkp (kernel test robot)
> ---
>  drivers/mmc/host/Kconfig        |  14 ++
>  drivers/mmc/host/Makefile       |   1 +
>  drivers/mmc/host/sdhci-of-bst.c | 544 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 559 insertions(+)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7232de1c068873d9bccec0b3b43ece939cb84894..75c37be559d23bff773bbe3f018b76c34ad710ca 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -429,6 +429,20 @@ config MMC_SDHCI_BCM_KONA
>  
>  	  If you have a controller with this interface, say Y or M here.
>  
> +config MMC_SDHCI_BST
> +	tristate "SDHCI support for Black Sesame Technologies BST C1200 controller"
> +	depends on ARCH_BST || COMPILE_TEST
> +	depends on MMC_SDHCI_PLTFM
> +	depends on OF
> +	help
> +	  This selects the Secure Digital Host Controller Interface (SDHCI)
> +	  for Black Sesame Technologies BST C1200 SoC. The controller is
> +	  based on Synopsys DesignWare Cores Mobile Storage Controller but
> +	  requires platform-specific workarounds for hardware limitations.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +	  If unsure, say N.
> +
>  config MMC_SDHCI_F_SDH30
>  	tristate "SDHCI support for Fujitsu Semiconductor F_SDH30"
>  	depends on MMC_SDHCI_PLTFM
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 5057fea8afb696e210e465a6a2aafc68adad7854..ee412e6b84d6c91f80654e53d0a05b549d4b6171 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_UHS2)	+= sdhci-uhs2.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
> +obj-$(CONFIG_MMC_SDHCI_BST)	        += sdhci-of-bst.o

This would be better positioned so that it is not between
	obj-$(CONFIG_MMC_SDHCI_PCI) and sdhci-pci-y

>  sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
>  				   sdhci-pci-dwc-mshc.o sdhci-pci-gli.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
> diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b19b763f216a25f58d37c8e288a8aa791f1e20f7
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-bst.c
> @@ -0,0 +1,544 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SDHCI driver for Black Sesame Technologies C1200 controller
> + *
> + * Copyright (c) 2025 Black Sesame Technologies
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/ioport.h>

Is linux/ioport.h needed?

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/iopoll.h>

Also:

#include <linux/bits.h>

And if you use FIELD_PREP():

#include <linux/bitfield.h>


> +#include "sdhci.h"
> +#include "sdhci-pltfm.h"
> +
> +/* SDHCI standard register extensions */
> +#define SDHCI_CLOCK_PLL_EN		0x0008

Already defined in sdhci.h

> +#define SDHCI_TUNING_COUNT		0x20

For SD cards the limit is 40.  This number seems to be
driver-specific so should be named accordingly e.g.

#define SDHCI_BST_TUNING_COUNT		0x20

> +#define SDHCI_VENDOR_PTR_R		0xE8
> +
> +/* Synopsys vendor specific registers */
> +#define SDHC_EMMC_CTRL_R_OFFSET		0x2C
> +#define MBIU_CTRL			0x510
> +
> +/* MBIU burst control bits */
> +#define BURST_INCR16_EN			BIT(3)
> +#define BURST_INCR8_EN			BIT(2)
> +#define BURST_INCR4_EN			BIT(1)
> +#define BURST_EN			(BURST_INCR16_EN | BURST_INCR8_EN | BURST_INCR4_EN)
> +#define MBIU_BURST_MASK			GENMASK(3, 0)
> +
> +/* CRM (Clock/Reset/Management) register offsets */
> +#define SDEMMC_CRM_BCLK_DIV_CTRL	0x08
> +#define SDEMMC_CRM_TIMER_DIV_CTRL	0x0C
> +#define SDEMMC_CRM_RX_CLK_CTRL		0x14
> +#define SDEMMC_CRM_VOL_CTRL		0x1C
> +#define REG_WR_PROTECT			0x88
> +#define DELAY_CHAIN_SEL			0x94
> +
> +/* CRM register values and bit definitions */
> +#define REG_WR_PROTECT_KEY		0x1234abcd
> +#define BST_VOL_STABLE_ON		BIT(7)
> +#define BST_TIMER_DIV_MASK		GENMASK(7, 0)
> +#define BST_TIMER_DIV_VAL		0x20
> +#define BST_TIMER_LOAD_BIT		BIT(8)
> +#define BST_BCLK_EN_BIT			BIT(10)
> +#define BST_RX_UPDATE_BIT		BIT(11)
> +#define BST_EMMC_CTRL_BIT2		BIT(2)

BST_EMMC_CTRL_BIT2 is not a very descriptive name

> +
> +/* Clock frequency limits */
> +#define BST_DEFAULT_MAX_FREQ		2000000UL

2 MHz looks too low?

> +#define BST_DEFAULT_MIN_FREQ		400000UL
> +
> +/* Clock control bit definitions */
> +#define BST_CLOCK_DIV_MASK		GENMASK(7, 0)
> +#define BST_CLOCK_DIV_SHIFT		8

Can use just:

#define BST_CLOCK_DIV_MASK		GENMASK(15, 8)

and FIELD_PREP() so that BST_CLOCK_DIV_SHIFT is not needed

> +#define BST_BCLK_DIV_MASK		GENMASK(9, 0)
> +
> +/* Clock frequency thresholds */
> +#define BST_CLOCK_THRESHOLD_LOW		1500
> +
> +/* Clock stability polling parameters */
> +#define BST_CLK_STABLE_POLL_US		1000	/* Poll interval in microseconds */
> +#define BST_CLK_STABLE_TIMEOUT_US	20000	/* Timeout for internal clock stabilization (us) */
> +
> +struct sdhci_bst_priv {
> +	void __iomem *crm_reg_base;
> +};
> +
> +union sdhci_bst_rx_ctrl {
> +	struct {
> +		u32 rx_revert:1,
> +		    rx_clk_sel_sec:1,
> +		    rx_clk_div:4,
> +		    rx_clk_phase_inner:2,
> +		    rx_clk_sel_first:1,
> +		    rx_clk_phase_out:2,
> +		    rx_clk_en:1,
> +		    res0:20;
> +	};
> +	u32 reg;
> +};
> +
> +static u32 sdhci_bst_crm_read(struct sdhci_pltfm_host *pltfm_host, u32 offset)
> +{
> +	struct sdhci_bst_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	return readl(priv->crm_reg_base + offset);
> +}
> +
> +static void sdhci_bst_crm_write(struct sdhci_pltfm_host *pltfm_host, u32 offset, u32 value)
> +{
> +	struct sdhci_bst_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +
> +	writel(value, priv->crm_reg_base + offset);
> +}
> +
> +static int sdhci_bst_wait_int_clk(struct sdhci_host *host)
> +{
> +	u16 clk;
> +
> +	if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
> +			      BST_CLK_STABLE_POLL_US, BST_CLK_STABLE_TIMEOUT_US, false,
> +			      host, SDHCI_CLOCK_CONTROL))
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static unsigned int sdhci_bst_get_max_clock(struct sdhci_host *host)
> +{
> +	return BST_DEFAULT_MAX_FREQ;
> +}
> +
> +static unsigned int sdhci_bst_get_min_clock(struct sdhci_host *host)
> +{
> +	return BST_DEFAULT_MIN_FREQ;
> +}
> +
> +static void sdhci_bst_enable_clk(struct sdhci_host *host, unsigned int clk)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	unsigned int div;
> +	u32 val;
> +	union sdhci_bst_rx_ctrl rx_reg;
> +
> +	pltfm_host = sdhci_priv(host);
> +	if (clk == 0) {
> +		div = clk;
> +	} else if (clk > BST_DEFAULT_MAX_FREQ) {
> +		div = clk / 1000;
> +		div = BST_DEFAULT_MAX_FREQ / div;
> +	} else if (clk < BST_CLOCK_THRESHOLD_LOW) {
> +		div = clk;
> +	} else {
> +		div = BST_DEFAULT_MAX_FREQ * 100;
> +		div = div / clk;
> +		div /= 100;
> +	}
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk &= ~SDHCI_CLOCK_PLL_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val &= ~BST_TIMER_LOAD_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val &= ~BST_TIMER_DIV_MASK;
> +	val |= BST_TIMER_DIV_VAL;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> +	val |= BST_TIMER_LOAD_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +	val &= ~BST_RX_UPDATE_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +	rx_reg.reg = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +
> +	rx_reg.rx_revert = 0;
> +	rx_reg.rx_clk_sel_sec = 1;
> +	rx_reg.rx_clk_div = 4;
> +	rx_reg.rx_clk_phase_inner = 2;
> +	rx_reg.rx_clk_sel_first = 0;
> +	rx_reg.rx_clk_phase_out = 2;
> +
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, rx_reg.reg);
> +
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +	val |= BST_RX_UPDATE_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +	/* Disable clock first */
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val &= ~BST_BCLK_EN_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* Setup clock divider */
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val &= ~BST_BCLK_DIV_MASK;
> +	val |= div;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* Enable clock */
> +	val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +	val |= BST_BCLK_EN_BIT;
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +	/* RMW the clock divider bits to avoid clobbering other fields */
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &= ~(BST_CLOCK_DIV_MASK << BST_CLOCK_DIV_SHIFT);
> +	clk |= (div & BST_CLOCK_DIV_MASK) << BST_CLOCK_DIV_SHIFT;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_CLOCK_PLL_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +}
> +
> +static void sdhci_bst_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	/* Turn off card/internal/PLL clocks when clock==0 to avoid idle power */
> +	u32 clk_reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

Could be inside the 'if (!clock) {' block e.g.

	if (!clock) {
		u32 clk_reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

> +
> +	if (!clock) {
> +		clk_reg &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN | SDHCI_CLOCK_PLL_EN);
> +		sdhci_writew(host, clk_reg, SDHCI_CLOCK_CONTROL);
> +		return;
> +	}
> +	sdhci_bst_enable_clk(host, clock);
> +}
> +
> +/**
> + * sdhci_bst_reset - Reset the SDHCI host controller
> + * @host: SDHCI host controller
> + * @mask: Reset mask
> + *
> + * Performs a reset of the SDHCI host controller with special handling for eMMC.
> + */

Kernel style is not to put kernel-doc comments on call-back function
implementations.

> +static void sdhci_bst_reset(struct sdhci_host *host, u8 mask)
> +{
> +	u16 vendor_ptr, emmc_ctrl_reg;
> +	u32 reg;
> +
> +	if (host->mmc->caps2 & MMC_CAP2_NO_SD) {
> +		vendor_ptr = sdhci_readw(host, SDHCI_VENDOR_PTR_R);
> +		emmc_ctrl_reg = vendor_ptr + SDHC_EMMC_CTRL_R_OFFSET;
> +
> +		reg = sdhci_readw(host, emmc_ctrl_reg);
> +		reg &= ~BST_EMMC_CTRL_BIT2;
> +		sdhci_writew(host, reg, emmc_ctrl_reg);
> +		sdhci_reset(host, mask);
> +		usleep_range(10, 20);
> +		reg = sdhci_readw(host, emmc_ctrl_reg);
> +		reg |= BST_EMMC_CTRL_BIT2;
> +		sdhci_writew(host, reg, emmc_ctrl_reg);
> +	} else {
> +		sdhci_reset(host, mask);
> +	}
> +}
> +
> +/**
> + * sdhci_bst_set_timeout - Set timeout value for commands
> + * @host: SDHCI host controller
> + * @cmd: MMC command
> + *
> + * Sets the timeout control register to maximum value (0xE).
> + */

Kernel style is not to put kernel-doc comments on call-back function
implementations.

> +static void sdhci_bst_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
> +{
> +	sdhci_writeb(host, 0xE, SDHCI_TIMEOUT_CONTROL);
> +}
> +
> +/**
> + * sdhci_bst_set_power - Set power mode and voltage
> + * @host: SDHCI host controller
> + * @mode: Power mode to set
> + * @vdd: Voltage to set
> + *
> + * Sets power mode and voltage, also configures MBIU control register.
> + */

Kernel style is not to put kernel-doc comments on call-back function
implementations.

> +static void sdhci_bst_set_power(struct sdhci_host *host, unsigned char mode,
> +				unsigned short vdd)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	u32 reg;
> +	u32 val;
> +
> +	sdhci_set_power(host, mode, vdd);
> +
> +	if (mode == MMC_POWER_OFF) {
> +		/* Disable MBIU burst mode */
> +		reg = sdhci_readw(host, MBIU_CTRL);
> +		reg &= ~BURST_EN; /* Clear all burst enable bits */
> +		sdhci_writew(host, reg, MBIU_CTRL);
> +
> +		/* Disable CRM BCLK */
> +		val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL);
> +		val &= ~BST_BCLK_EN_BIT;
> +		sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_BCLK_DIV_CTRL, val);
> +
> +		/* Disable RX clock */
> +		val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL);
> +		val &= ~BST_RX_UPDATE_BIT;
> +		sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_RX_CLK_CTRL, val);
> +
> +		/* Turn off voltage stable power */
> +		val = sdhci_bst_crm_read(pltfm_host, SDEMMC_CRM_VOL_CTRL);
> +		val &= ~BST_VOL_STABLE_ON;
> +		sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_VOL_CTRL, val);
> +	} else {
> +		/* Configure burst mode only when powered on */
> +		reg = sdhci_readw(host, MBIU_CTRL);
> +		reg &= ~MBIU_BURST_MASK; /* Clear burst related bits */
> +		reg |= BURST_EN; /* Enable burst mode for better bandwidth */
> +		sdhci_writew(host, reg, MBIU_CTRL);
> +	}
> +}
> +
> +/**
> + * sdhci_bst_execute_tuning - Execute tuning procedure
> + * @host: SDHCI host controller
> + * @opcode: Opcode to use for tuning
> + *
> + * Performs tuning procedure by trying different values and selecting the best one.
> + *
> + * Return: 0 on success, negative errno on failure
> + */

Kernel style is not to put kernel-doc comments on call-back function
implementations.

> +static int sdhci_bst_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	int ret = 0, error;
> +	int first_start = -1, first_end = -1, best = 0;
> +	int second_start = -1, second_end = -1, has_failure = 0;
> +	int i;
> +
> +	pltfm_host = sdhci_priv(host);
> +
> +	for (i = 0; i < SDHCI_TUNING_COUNT; i++) {
> +		/* Protected write */
> +		sdhci_bst_crm_write(pltfm_host, REG_WR_PROTECT, REG_WR_PROTECT_KEY);
> +		/* Write tuning value */
> +		sdhci_bst_crm_write(pltfm_host, DELAY_CHAIN_SEL, (1ul << i) - 1);
> +
> +		/* Wait for internal clock stable before tuning */
> +		if (sdhci_bst_wait_int_clk(host)) {
> +			dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> +			return -EBUSY;
> +		}
> +
> +		ret = mmc_send_tuning(host->mmc, opcode, &error);
> +		if (ret != 0) {
> +			has_failure = 1;
> +		} else {
> +			if (has_failure == 0) {
> +				if (first_start == -1)
> +					first_start = i;
> +				first_end = i;
> +			} else {
> +				if (second_start == -1)
> +					second_start = i;
> +				second_end = i;
> +			}
> +		}
> +	}
> +
> +	/* Calculate best tuning value */
> +	if (first_end - first_start >= second_end - second_start)
> +		best = ((first_end - first_start) >> 1) + first_start;
> +	else
> +		best = ((second_end - second_start) >> 1) + second_start;
> +
> +	if (best < 0)
> +		best = 0;
> +
> +	sdhci_bst_crm_write(pltfm_host, DELAY_CHAIN_SEL, (1ul << best) - 1);
> +	/* Confirm internal clock stable after setting best tuning value */
> +	if (sdhci_bst_wait_int_clk(host)) {
> +		dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * sdhci_bst_voltage_switch - Perform voltage switch
> + * @host: SDHCI host controller
> + *
> + * Enables voltage stable power.
> + */

Kernel style is not to put kernel-doc comments on call-back function
implementations.

> +static void sdhci_bst_voltage_switch(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +	/* Enable voltage stable power */
> +	sdhci_bst_crm_write(pltfm_host, SDEMMC_CRM_VOL_CTRL, BST_VOL_STABLE_ON);
> +}
> +
> +static const struct sdhci_ops sdhci_bst_ops = {
> +	.set_clock		= sdhci_bst_set_clock,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +	.get_min_clock		= sdhci_bst_get_min_clock,
> +	.get_max_clock		= sdhci_bst_get_max_clock,
> +	.reset			= sdhci_bst_reset,
> +	.set_power		= sdhci_bst_set_power,
> +	.set_timeout		= sdhci_bst_set_timeout,
> +	.platform_execute_tuning = sdhci_bst_execute_tuning,
> +	.voltage_switch		= sdhci_bst_voltage_switch,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_bst_pdata = {
> +	.ops = &sdhci_bst_ops,
> +	.quirks = SDHCI_QUIRK_BROKEN_ADMA |
> +		  SDHCI_QUIRK_DELAY_AFTER_POWER |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT,
> +	.quirks2 = SDHCI_QUIRK2_BROKEN_DDR50 |
> +		   SDHCI_QUIRK2_TUNING_WORK_AROUND |
> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
> +};
> +
> +static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	unsigned int bounce_size;
> +	int ret;
> +
> +	/* Fixed SRAM bounce size to 32KB: verified config under 32-bit DMA addressing limit */
> +	bounce_size = SZ_32K;
> +
> +	ret = of_reserved_mem_device_init_by_idx(mmc_dev(mmc), mmc_dev(mmc)->of_node, 0);
> +	if (ret) {
> +		dev_err(mmc_dev(mmc), "Failed to initialize reserved memory\n");
> +		return ret;
> +	}
> +
> +	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
> +						 &host->bounce_addr, GFP_KERNEL);
> +	if (!host->bounce_buffer)
> +		return -ENOMEM;
> +
> +	host->bounce_buffer_size = bounce_size;
> +
> +	return 0;
> +}
> +
> +static int sdhci_bst_probe(struct platform_device *pdev)
> +{
> +	struct sdhci_pltfm_host *pltfm_host;
> +	struct sdhci_host *host;
> +	struct sdhci_bst_priv *priv;
> +	int err;
> +
> +	host = sdhci_pltfm_init(pdev, &sdhci_bst_pdata, sizeof(struct sdhci_bst_priv));
> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host = sdhci_priv(host);
> +	priv = sdhci_pltfm_priv(pltfm_host); /* Get platform private data */
> +
> +	err = mmc_of_parse(host->mmc);
> +	if (err)
> +		return err;
> +
> +	sdhci_get_of_property(pdev);
> +
> +	/* Get CRM registers from the second reg entry */
> +	priv->crm_reg_base = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(priv->crm_reg_base)) {
> +		err = PTR_ERR(priv->crm_reg_base);
> +		return err;
> +	}
> +
> +	/*
> +	 * Silicon constraints for BST C1200:
> +	 * - System RAM base is 0x800000000 (above 32-bit addressable range)
> +	 * - The eMMC controller DMA engine is limited to 32-bit addressing
> +	 * - SMMU cannot be used on this path due to hardware design flaws
> +	 * - These are fixed in silicon and cannot be changed in software
> +	 *
> +	 * Bus/controller mapping:
> +	 * - No registers are available to reprogram the address mapping
> +	 * - The 32-bit DMA limit is a hard constraint of the controller IP
> +	 *
> +	 * Given these constraints, an SRAM-based bounce buffer in the 32-bit
> +	 * address space is required to enable eMMC DMA on this platform.
> +	 */
> +	err = sdhci_bst_alloc_bounce_buffer(host);
> +	if (err) {
> +		dev_err(&pdev->dev, "Failed to allocate bounce buffer: %d\n", err);
> +		return err;
> +	}
> +
> +	err = sdhci_add_host(host);
> +	if (err)
> +		goto err_free_bounce_buffer;
> +
> +	return 0;
> +
> +err_free_bounce_buffer:
> +	if (host->bounce_buffer) {
> +		dma_free_coherent(mmc_dev(host->mmc), host->bounce_buffer_size,
> +				  host->bounce_buffer, host->bounce_addr);
> +		host->bounce_buffer = NULL;
> +	}
> +	of_reserved_mem_device_release(mmc_dev(host->mmc));
> +
> +	return err;
> +}
> +
> +static void sdhci_bst_remove(struct platform_device *pdev)
> +{
> +	struct sdhci_host *host = platform_get_drvdata(pdev);
> +
> +	/* Free bounce buffer if allocated */
> +	if (host->bounce_buffer) {
> +		dma_free_coherent(mmc_dev(host->mmc), host->bounce_buffer_size,
> +				  host->bounce_buffer, host->bounce_addr);
> +		host->bounce_buffer = NULL;
> +	}

Same 5 lines of code further above.  Could be a separate little helper function.

> +
> +	/* Release reserved memory */
> +	of_reserved_mem_device_release(mmc_dev(host->mmc));
> +
> +	/* Use platform helper for remove */
> +	sdhci_pltfm_remove(pdev);
> +}
> +
> +static const struct of_device_id sdhci_bst_ids[] = {
> +	{ .compatible = "bst,c1200-dwcmshc-sdhci" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sdhci_bst_ids);
> +
> +static struct platform_driver sdhci_bst_driver = {
> +	.driver = {
> +		.name = "sdhci-bst",
> +		.of_match_table = sdhci_bst_ids,
> +	},
> +	.probe = sdhci_bst_probe,
> +	.remove = sdhci_bst_remove,
> +};
> +module_platform_driver(sdhci_bst_driver);
> +
> +MODULE_DESCRIPTION("Black Sesame Technologies SDHCI driver (BST)");
> +MODULE_AUTHOR("Black Sesame Technologies Co., Ltd.");
> +MODULE_LICENSE("GPL");
> 

