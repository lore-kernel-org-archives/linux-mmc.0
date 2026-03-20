Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAA38A72C;
	Fri, 20 Mar 2026 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006314; cv=fail; b=nrE3F5nCdF3op/WmsV7BdW7pgU52+/AnGFHJw3iG7R9qBmxr/wzUZzOCIx+5eUCSq1vn1Cf9mzqhi6SGVOM1RtDF7n9Q+8oCm9PBn8cPuS0ur6zosNM6yVK8gFy8mpKZUewZzqtkpdCEohTPQL08vjtF4L0BDFkH/6Culx2oybU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006314; c=relaxed/simple;
	bh=ndgGIqAH84ZXr/mq/UypJkNxl8ubE0sX5c74iO0DsK8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J5wIxr64CajEv1KdvrjG0ibz4BEjlWXSovVBGZ5IqduqjA6zPYdx5jTvqdPKojReU4CyAd0d8v7y1nz111UdZI7OH8qZAg1FCp3ecVnIyagHi22pql/faMDVJC6BjWthF5mncjbCAA1hTCEdHPz2ZHZkxFW4H/E4827mGQcGbhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UauRbZ6G; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UauRbZ6G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774006311; x=1805542311;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ndgGIqAH84ZXr/mq/UypJkNxl8ubE0sX5c74iO0DsK8=;
  b=UauRbZ6G08GVB+WCa66EHAfqgJEFK/Say907uUvRK0e9mf0Rg7mUNv1x
   WB3ddVL0TvRHh+SbDYW2EJ9cXnn2ReHpOw6Q+Q+zvQirNHTsQ8uWlUMCZ
   vkhGdA2ehC0QVf49JnLannYLogPZVQXypyTRn+yNRJvE3sRkbTeP0akW1
   MSu359bQoiAgSYqSLLKKFcVl3TQwOcz5soEqKPms3htORMFB+mmnV5TEW
   iCbp202Qj5Ad/gjg1/IRWrBgKvo0EdLRYYpkDBb4CEwRKWjBgoMaYZmBU
   UL873mTnHdwLHdjnyag16Y0uYOeFpVmS7cqmOaUlfc/92rl7QNkByqDM0
   g==;
X-CSE-ConnectionGUID: WDdy7g/pRuGcIyDX1VTyjA==
X-CSE-MsgGUID: PuuTBy6OSd2etBMpob0o0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100544191"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100544191"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 04:31:50 -0700
X-CSE-ConnectionGUID: APToZZz8QyqUltB7Gd0c8A==
X-CSE-MsgGUID: OgdToWsJTv6B1ZVsePRD+g==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 04:31:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 04:31:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 04:31:48 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 04:31:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPSLyeccWvkADe38U/Cl4ZB/ldPYwtTvyQFRFqMiDpjnpyth+ig1SyZR4xrLUT+lMeBkf4k60APvpUJp2v5Kt+6rnzaZ07yrqclnV3dy/RHDMATL2pjlTGh25svpLqLweJK2vd2IKL/xU/V3HtA5Jj7jqxHX/hZ74+qr2mGx4Tpt+bRWNHviga7zDy09OGla1/rel6xlPv0GnbPxrZ2Zmhd97Kg0BA3M+jZV53Ex0tsFXM4lDjN7ooR4B8DuZxAbOuqfGqcO/TZUBnrLRXVe/8Dk6ACKJSGkyR1ZpdkBXxGkMmknxyXt0bu+omA2OVxlqYbRQyFryaPMpDuSf5kxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTOks4Ib7foLu1ZFwpthfHLnMJHNKh2PhDSf7HWbgEU=;
 b=YkuxoPzxDwekZwEC1HIlwtdeV+Jk36A9o8j3SfYvlXoIlDLa+7AAu2Mu8EuXExMhBbnQalmNHwjymI2+lcz2Fam9uwAmorB8P0QM5P0PO1m6VRjyZDPAmK03uIzEUR4gUi7lpwkaU4adP8xrELdwwOcHmbA/o2WmxyHOsCzrDOPbNNlkaDgNjc9VXIKfY5necxs/nWiYWRYsFh6d8Zn1cSGsdIPZIdxqCVog0DjzYZGnKvSH+S7FeZRL8a0Anobd8TjFWD6XlqlG+bmpbgsj7OHMX6msODPQ7fxP/kLRJLfQSF5Emrd/EGCGhK/l0py47q1rK94aXXXCab4Glyuf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 11:31:40 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 11:31:40 +0000
Message-ID: <d3e54adc-46b4-4ece-ad75-fc184f0b111d@intel.com>
Date: Fri, 20 Mar 2026 13:31:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] mmc: sdhci-of-k1: add regulator and pinctrl
 voltage switching support
To: Iker Pedrosa <ikerpedrosam@gmail.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Albert
 Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>, Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Anand Moon
	<linux.amoon@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-2-aefd3b7832df@gmail.com>
 <182321ef-f01e-4bc8-8f23-aa85b4c70860@intel.com>
 <CABdCQ=ODJyeC4Lb_XFxHaxQpem0F3v=tw+5CipCHFU8T5zr8Ww@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CABdCQ=ODJyeC4Lb_XFxHaxQpem0F3v=tw+5CipCHFU8T5zr8Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::18) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA3PR11MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0dcfaf-25d9-4e11-a83c-08de8674412b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: ylxGBb6sbFxYkPnVnwoCt1yf//bqiQmEbl9CA8qT7lCT2MxRxSn1Cri+XgOIgPDQom5hpQCk29t8hcWG9/ckV66rpC0JqlAPdxLp1iF1W9bCE+0Y0zS1GeV08TTglMqAbtO//kKaOV6QDMIIHVPLJDFHVzUfqlv+6R4btokYqxwTSrumXz9HvRRktFKYrlm2Ajmq6s62eeoq62PuLRlQEy3Xuhfr3kyZJk27k2VQaZjbDiA2lNsQRFHSv7mTa4iPsQGh9ELJA9mHPLHJLYWlM79lMMcFAI8qbq/Mcqx2zBhL8iFibA/aw8p//Qv1bBdh89jLGujEkZI19TWN5mfcYiWyaj3kCzDQ1AQ+WrVb1IOnt+ZYyg2wEz9hcX4OPO/NZfNIBfXvH5Ay0h5LGoCnnSBF/TOuZ+BEd3n9FxfFLBdqbGTYKtax1h/fI1oHokGvtxevUzGwRH1nJuuQh8s5WXUubCr3HcZNG9DT48Dk3CPBsPmT5eKeQQXYOEvwhxWkZrgJ6goVkIleNW188UDfyaURsmQAw3lRK5GY9UP7Ks2lPimfuhoUlWLcbcvkS78aS+1fa/0f4ZAJXLqOvIijy/5AvmwY0wd8zZ1ZSySBcyPPbS+AsYi6L47jIncrinZqqKn4mtM99HRtf1eVxfk7ECG0++Ei8MSfOkryOQPOxU6KaNOKUr/p0FNzvK2NqMyXgTrSrQ2iTNjKLs/sqkq7tXCwOBdpcqcMbK4Vyc8SphE0SDF08/Mff/UZhNa/kvGN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkRrb242WG1oTVNpUmttanFyVWxYY2Zpc05EOFV4dEV4VnhsYkZNbk1zN0Uv?=
 =?utf-8?B?WXlxOHBIQUh3cm56RnNaWEp5dUtObnNtazNTSzAzS3RYeDZMaVNRUVZZMC8y?=
 =?utf-8?B?c0tXYktXUkg2OXYyR2dJekFoS1U2eHdBMlVvTTJoZzRWOFVBZnNoQlZjTExk?=
 =?utf-8?B?bWRSNTJuLzRKSW5YMVd0cHpINlhCNGVlbUVscWNNVXkxelplanYyYTNOS3NF?=
 =?utf-8?B?UVBVNURpdDlNUGtMWlEweFhHSHlzUWNES1N6TUtuNDlNRWhobmwvamtoQVBB?=
 =?utf-8?B?alpERUZCSHVLS28zSVhzUU5jdWdlZUd4ZTJqMWg1Y2xmTzRVVE5ZeVNPYkFH?=
 =?utf-8?B?ZzlXazBxOFhzeld1S3RPSU1WMDRNWkFxS3dNemtiU2xrYTkrNk10VDl0eUtC?=
 =?utf-8?B?YXUycXgyRVRnOTdrMkg0NlloSFdscWpreGVZcitDQ01vSzRzbW9QdUlCc3ZM?=
 =?utf-8?B?cDI0TTMwcDBmZ0svUlNCY0ZKR3VMemt0aG9yT1R1TTNNdFQ3WkdEUlAwaGRu?=
 =?utf-8?B?cmwvTnVvM0Jqa2FFT3hzUGxBNnZidTdRaDdQclEzS2IreFNLOTBXUUhkVkdl?=
 =?utf-8?B?RXpvelRxdG94WEIxYWdzeUdMOXhTSm9WellaZzVIVzYxOUFyT1NkS1pHeHJw?=
 =?utf-8?B?Z1RNVFJjbW9rc2Q0UFJkb3dxcEhwUFJTMVJCbmNZdmtwcFhoeGZjYXNoUjFl?=
 =?utf-8?B?YzkyZEltbnlld3NqTFpkanZ4Rk9vRkdxeW9UWi9UQTZiajhZYVFNaXM4dUtK?=
 =?utf-8?B?ekFuV2NxL3Y1eUlKSTQ1Y0lnVFRrWm84eXdFeXdRYTBqRElGaVFQaitqVE9V?=
 =?utf-8?B?OHNEemFQRlVGcUMrS1pBM2VyTTFwaDVLYm02VWk3a2Ryb3RRSVZQeUNlVHVz?=
 =?utf-8?B?SUFONEZXdTY2K3hwZS91WGx0MlVjWmVka2EyWVAvVXdiQUdIdlVKK1l4Wk9l?=
 =?utf-8?B?RHFHYXEwZmJiRkdoUFFyazJSRnR0akZtRXZHeVRZY2xiUU9rVzJjQndnZW1C?=
 =?utf-8?B?dGNxOVNkMUZWWDlTTEM1aWppd1dNdGhHd1lsWnRCNUJqQVRRNUg1ZmJvL0Ja?=
 =?utf-8?B?blNIczZQR0ZQRDB1R0lsLzBDeXY5T28wK210WTFTRis3ZkU2WWhMbzUyd1Nl?=
 =?utf-8?B?V21FdXdUUmtPQ2NzVkJ2eGZjSjRxbE5rdWNsdG1xVGFaS20wR3NxT0oyS1hM?=
 =?utf-8?B?RXg5VGNvRVVqNjVIU3lYVE9meTZ6dEcvWjFtUHpMNy82djM3aXFSSkJTZEls?=
 =?utf-8?B?WGZmVzhBOG5HNVJQTEJXakdSckxZYXZXU2VYZ1RCSWZQVDVuamNPK2xtK01h?=
 =?utf-8?B?L3dXUFB1M0hHQkV5bTJvZjZ1SGpKdmVoaDU3c0FsbmVFVUx0cGVwZVpWRjla?=
 =?utf-8?B?Ukc4L3M2RUF6eDVwU29NV2YzRDVJVmZwQmNWWm9lakpLRzhXOEdKUHU1VCsv?=
 =?utf-8?B?OTFVTmFLc2ZweFgyL3ZZZ1htUUJDTVF6L3JSL1Zmbno3ZTQraWU3djhNVnN1?=
 =?utf-8?B?VGt4aXl3dmlUMU83Z1RWWHAxNUd2UUp3aXpKYWRuNVNnSkpGdDNEZWJickhX?=
 =?utf-8?B?Q2xnRk9rTjQwRnFKU3JtOFRBa1ROWVptV0h1SUdlSVpMQldtY01ocXowdjlM?=
 =?utf-8?B?R1orekpNZVlMcTRhNHVCTzM0OHB6djhmYlVmVzlFTmRxbmVhZUZrSHNzajBF?=
 =?utf-8?B?bXBMNXRod2tPRUh3LzZNMk4zQVFyN3VLL25XZDJUdTMvTWdsZHh0cEQ3VExM?=
 =?utf-8?B?bHVkNTZsbnJwanVadVF2cWx2bE4zek1XdmhwOWpqU3JRVlo3Z2lCWVk1T3hs?=
 =?utf-8?B?Y3RETTk2ZkRLNXNnWjRLeUcxWWhsRXRUdkVWZ2k4UkJGM0xHaVhxdHZrcmxy?=
 =?utf-8?B?b1FmdmpVNUxRWU1JSG95L3VtNkVWNm5yZTFqL0tuck95eHR2NFhKbVM3WDYr?=
 =?utf-8?B?dXJ4b0NGdjRTdkVkNnVxNGxlcnlQaDA1L3ErVjAweWE5cm5iQWhuamdjVTJn?=
 =?utf-8?B?TnNSQnprNmczTkpsS2RnTHVGdTdjRkx3ZHI0cGxDK2Qrd1dsbUxRRnhPMDFr?=
 =?utf-8?B?YXZoL0NWcXk0cDkwT1lwdHFxQ0RNcnJoYUFPNk9pUFdtTllQOUcramhCWjlt?=
 =?utf-8?B?ZUN3aFpRWlFzWVRaL0FmWjcyemFrVkp3UXNyS0d6OFNaMkgyRXhMT0NqcW5I?=
 =?utf-8?B?TWxDYVpkVkpHankyWStPU3U3YmRFOXdMM29WNlRLMzNxQXhlcG5zTFAyVTJm?=
 =?utf-8?B?RGNOa1p3OUFXb2lyRVhxeWh6SmhQTzZyb0ZMNktvVVZ0WVdlWm1NRnUxc0Zu?=
 =?utf-8?B?Z3EvcFF5S1lmTlVhYmVuQXJla1NDaVlPYVRYM2NybG5HK3ZEYmh4bHh4Q2JR?=
 =?utf-8?Q?tkSesuhZWunFBt1g=3D?=
X-Exchange-RoutingPolicyChecked: mcb0/angYaPirLtz+dROTSa8O8J/wvWOUKDa1D3Zn6X3YtfePh1gfMm4DHP7JrephYDKZz/3xwLiZuSUDwoAHy1tpz3kU2OoHYUd2YVFHVcmzZ98QhQQBc2yblJXqFrVticnfiFpLAe6/ZFwjR+ZZomgIu8Gy4ul0ziyiA5ZZ/PBAy5LPDoWtD2X22KM6cUI0PXUyw/8yxCWkrVdgz4YdLzSHicPb7hLV3qrYG9hlV0mdCg48X0iPYazzQlAMFTG+VCvRcdQ9x4JQ0o8ChEfmzDmkYfOUMuhwh01NrxT5TvXb3FYgQh0JMe3978wrFRKj9n7H3XVnf3fZhSGiyjS8w==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0dcfaf-25d9-4e11-a83c-08de8674412b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 11:31:40.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erVSyPFZaZccr0OTUtKnqkLx8P+1+16Ar93BrFHM/2IK6wnjTKZavZzItM2Pr+8q2T4i1T++Y7rQQeu+ykPZxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
X-OriginatorOrg: intel.com

On 20/03/2026 11:17, Iker Pedrosa wrote:
> El mar, 17 mar 2026 a las 12:28, Adrian Hunter
> (<adrian.hunter@intel.com>) escribió:
>>
>> On 16/03/2026 16:03, Iker Pedrosa wrote:
>>> Add voltage switching infrastructure for UHS-I modes by integrating both
>>> regulator framework (for supply voltage control) and pinctrl state
>>> switching (for pin drive strength optimization).
>>>
>>> - Add regulator supply parsing and voltage switching callback
>>> - Add optional pinctrl state switching between "default" (3.3V) and
>>>   "state_uhs" (1.8V) configurations
>>> - Enable coordinated voltage and pin configuration changes for UHS modes
>>>
>>> This provides complete voltage switching support while maintaining
>>> backward compatibility when pinctrl states are not defined.
>>>
>>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>>> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
>>> ---
>>>  drivers/mmc/host/sdhci-of-k1.c | 58 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 58 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
>>> index 0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770..01afdadcf70796704b272ee5a31543afd5e01188 100644
>>> --- a/drivers/mmc/host/sdhci-of-k1.c
>>> +++ b/drivers/mmc/host/sdhci-of-k1.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/of.h>
>>>  #include <linux/of_device.h>
>>>  #include <linux/reset.h>
>>> +#include <linux/pinctrl/consumer.h>
>>>  #include <linux/platform_device.h>
>>>
>>>  #include "sdhci.h"
>>> @@ -71,6 +72,9 @@
>>>  struct spacemit_sdhci_host {
>>>       struct clk *clk_core;
>>>       struct clk *clk_io;
>>> +     struct pinctrl *pinctrl;
>>> +     struct pinctrl_state *pinctrl_default;
>>> +     struct pinctrl_state *pinctrl_uhs;
>>>  };
>>>
>>>  /* All helper functions will update clr/set while preserve rest bits */
>>> @@ -219,6 +223,33 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
>>>                              SPACEMIT_SDHC_PHY_CTRL_REG);
>>>  }
>>>
>>> +static void spacemit_sdhci_voltage_switch(struct sdhci_host *host)
>>> +{
>>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +     struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
>>> +     struct mmc_ios *ios = &host->mmc->ios;
>>> +     int ret;
>>> +
>>> +     if (!sdhst->pinctrl)
>>> +             return;
>>> +
>>> +     if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
>>> +             dev_warn(mmc_dev(host->mmc), "unsupported voltage %d\n",
>>> +                      ios->signal_voltage);
>>> +             return;
>>> +     }
>>
>> In V2, I put "->voltage_switch() is called only for
>> ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180" by
>> which I meant that it does not allow the driver to
>> switch pin state back for 3.3V.
>>
>> So you probably need an approach similar to the original
>> spacemit_sdhci_start_signal_voltage_switch() in:
>>
>>         https://lore.kernel.org/linux-mmc/20260302-orangepi-sd-card-uhs-v1-4-89c219973c0c@gmail.com/
> 
> Thank you for the feedback. I want to make sure I understand this
> point correctly to avoid going in circles.
> 
> In the v2 feedback , you mentioned that "->voltage_switch() is called
> only for ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180", which I
> understood to mean that this callback only needs to handle switching
> to 1.8V. This meant that the changes I introduced for v3 don't manage
> the switching to 3.3V.
> 
> Can you clarify if I should I revert to implementing
> "->start_signal_voltage_switch()" instead, which would handle both
> 1.8V and 3.3V cases? 

Yes

Or is there a way to make the
> "->voltage_switch()" approach work properly for both directions?
> 
>>
>>> +
>>> +     if (sdhst->pinctrl_uhs) {
>>> +             ret = pinctrl_select_state(sdhst->pinctrl, sdhst->pinctrl_uhs);
>>> +             if (ret) {
>>> +                     dev_warn(mmc_dev(host->mmc),
>>> +                              "failed to select UHS pinctrl state: %d\n", ret);
>>> +                     return;
>>> +             }
>>> +             dev_dbg(mmc_dev(host->mmc), "switched to UHS pinctrl state\n");
>>> +     }
>>> +}
>>> +
>>>  static inline int spacemit_sdhci_get_clocks(struct device *dev,
>>>                                           struct sdhci_pltfm_host *pltfm_host)
>>>  {
>>> @@ -252,12 +283,37 @@ static inline int spacemit_sdhci_get_resets(struct device *dev)
>>>       return 0;
>>>  }
>>>
>>> +static inline void spacemit_sdhci_get_pins(struct device *dev,
>>> +                                         struct sdhci_pltfm_host *pltfm_host)
>>> +{
>>> +     struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
>>> +
>>> +     sdhst->pinctrl = devm_pinctrl_get(dev);
>>> +     if (IS_ERR(sdhst->pinctrl)) {
>>> +             sdhst->pinctrl = NULL;
>>> +             dev_dbg(dev, "pinctrl not available, voltage switching will work without it\n");
>>> +             return;
>>> +     }
>>> +
>>> +     sdhst->pinctrl_default = pinctrl_lookup_state(sdhst->pinctrl, "default");
>>> +     if (IS_ERR(sdhst->pinctrl_default))
>>> +             sdhst->pinctrl_default = NULL;
>>> +
>>> +     sdhst->pinctrl_uhs = pinctrl_lookup_state(sdhst->pinctrl, "state_uhs");
>>> +     if (IS_ERR(sdhst->pinctrl_uhs))
>>> +             sdhst->pinctrl_uhs = NULL;
>>> +
>>> +     dev_dbg(dev, "pinctrl setup: default=%p, uhs=%p\n",
>>> +             sdhst->pinctrl_default, sdhst->pinctrl_uhs);
>>> +}
>>> +
>>>  static const struct sdhci_ops spacemit_sdhci_ops = {
>>>       .get_max_clock          = spacemit_sdhci_clk_get_max_clock,
>>>       .reset                  = spacemit_sdhci_reset,
>>>       .set_bus_width          = sdhci_set_bus_width,
>>>       .set_clock              = spacemit_sdhci_set_clock,
>>>       .set_uhs_signaling      = spacemit_sdhci_set_uhs_signaling,
>>> +     .voltage_switch         = spacemit_sdhci_voltage_switch,
>>>  };
>>>
>>>  static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
>>> @@ -324,6 +380,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>>>
>>>       host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>>>
>>> +     spacemit_sdhci_get_pins(dev, pltfm_host);
>>> +
>>>       ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
>>>       if (ret)
>>>               goto err_pltfm;
>>>
>>

