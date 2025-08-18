Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E82C236B;
	Mon, 18 Aug 2025 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513655; cv=fail; b=iyeko9rQMXf+MVECsNCo6wDSVXxNSOUuLPdFXsU1hAzIqxSw+cwq+xopRbQIPkNoMhLSiOYzSq3iHfcjF45A3hW9D9XjfBHCcNtpqTv50rekWuvQDVIQsAVAm9T01J9uD3ycBlb0ipkJMv2KdyMrbu4D5DRZ7KTiOH9ALC7l8Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513655; c=relaxed/simple;
	bh=ZGW4Uae6X7/vP9/noC4hjHrXG12H+VM/gNoRAwboPx4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=snKiLRmrxAZ+LE+PnVqPf/ZL3sxwbTfZM5uq1XWzkEW5L+AWpKjQa7sJ1qtoCzEn1aR6AmesIW4AESJxQQdYNf/o8TLlRg3/XyG+Rm7cWCm/Te4itruCPnQ/djCClS1s+uOxCgmcVHp7hw0YI7YpqMpXMeoFMWXjvdXDlUIl4xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0iRn7N+; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0iRn7N+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755513654; x=1787049654;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZGW4Uae6X7/vP9/noC4hjHrXG12H+VM/gNoRAwboPx4=;
  b=f0iRn7N+YBymB6qP6Om7YdhMeho72OB2C+sC/8r/8X4IWpyhukAW7T+x
   dysHD+FQM86eMy+rtG0ICcLNlM3ocBEoIyQrWc/ioCDRQjcnh9CljWM7R
   EvPJFmiXnS9gmaPoZInXBBobChTwNQF7f5osl/nu/sKVnTq5wJWG972Kn
   eQtIL+ZdW03r8m0pwATxYI2bjkMuoFcYt8wvJlMVY27OU8hX/F/mSgCRn
   l3VL4E7l9krzxjJWgkkEoKJuycu5HMc4/k8l1SfQr+bMS9DCsmUvpbbIC
   Q5zWBDAJTy9Ha0NdEFd/Jqpa5x/Q+0ufgj3vO7Lz9giLpggWnPi8rnuKp
   w==;
X-CSE-ConnectionGUID: HDYkGIG6QHqD9nJHcn4K5w==
X-CSE-MsgGUID: qXUh3xAmQM+WZz/CMDcbhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="67999002"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="67999002"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 03:40:49 -0700
X-CSE-ConnectionGUID: roYte6DfSx6cSOD5mT+KJQ==
X-CSE-MsgGUID: 3yQHSLiTQTmAy6dY3stKaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="191234769"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 03:40:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 03:40:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 18 Aug 2025 03:40:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 Aug 2025 03:40:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB2IrMHyPm7o1Dzs15QDPSRt/VC/bMKIstr0oSOPSWhAmmvt1/cbgnyM4sFUP/cObw/XGP7HnVqIKuqDTuTp30u5WPnfgQqpY4WZH+5BJaArndmd5Fleu2/MuvI2/LScPq5fuWPxOtvf4NdknZIFIhvk4JkZuQSuWEQ7cfRGEphgMis8vP4t+qctH6EyFR/tHR1mzdompyUnH2Ra6hFCIBmeVRDaM00rb/hmNJSiU7eGtj3DaDp2/xk8xZx6QF+kzpRk2Ncx/N6fSfol6gCMNO6abI5+/8/isBVheaHSzKVQVvAfLKXmk2ZI3Lzrxap8WdLMImJFAf6duAIAtuQkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXpQfUnE9n8oocq4gHhhwPiZC1mPCwZqrU7RNx9mOvA=;
 b=viDTRoXf5gDx32f4QBlLZ0vw8doYQAsdpD5bfmBkY6jc20k6kNZKt9VCcPadZ2ujonzWI5Ntwel59jZZtfpWgGa2yWzYeSBTKUvPVgW073Wgh1WPGYavjhfHB2ZfF1HrlqAR73jlJmgkIuhLtT82UwL/F1paJHZKTKecWteVrO4KYY+B+FWew3/Hh7stHn3v8pKbO3g8PubSE/mVYsT6zch2ONEd+D1T0y+aj3LDU9qmK2ZvMxUkuMxxlN9Th5821EM0BSI+TTqHjFwp+oM3NcXOcha0Pwnxv+T/oD7TKckTbrf8/TJpy8J2GBc8jHWnDJNb65YW/lxXRCJAUCx6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SJ2PR11MB7428.namprd11.prod.outlook.com (2603:10b6:a03:4cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Mon, 18 Aug
 2025 10:40:45 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 10:40:45 +0000
Message-ID: <b1babdf9-84a7-45de-96b9-7168e39990ba@intel.com>
Date: Mon, 18 Aug 2025 13:40:37 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/38] mmc: sdhci-acpi: use modern PM macros
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
 <20250815013413.28641-16-jszhang@kernel.org>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250815013413.28641-16-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::6) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SJ2PR11MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8e64da-3bda-4d00-ecbb-08ddde43b000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU9rR2tGakM0Z3pqVkRUckhKM3ZJRytoQUlEWkxaQ1ZrMDFmQXdST2hWSEE1?=
 =?utf-8?B?U1h3MlpFbzRTRjBwZGJneVlLaEh4Zm15ZExSSHFYQ1NQcmVLQ21hdlorWUhN?=
 =?utf-8?B?Z0pjM3lzT3NTZ1ZBNVYxaS94ckhEenlsb2dVVkkzMlMyZXdWZDdnVUR3UzFX?=
 =?utf-8?B?TmFuVGovNDlCQjJHNmZscC9sb0NNSGJFZWVPeGZGRktublJwbm8yU1pxN0po?=
 =?utf-8?B?aDNGMzFtbXdEdEpuaUxxQWlFd2ZIcGhrYTdEMTFvaDJRWjZBaU1wVDlsa0p1?=
 =?utf-8?B?WXBRZ1ZxNGVsRjFGbWxHc3FGVG0xalNaYmNzU1V3bzFyZk8rU3FUZy9wb1lq?=
 =?utf-8?B?ZmhlWWlOcHBma3FXSGNWVDNEdWkzRjBkK014ejBoQkpBMGFtM0plV3lrSHNL?=
 =?utf-8?B?TkgyWGVCaWNBWjc3TmhRNkdQcjNBSmxQaVFYRWNoZGxGUmUvYjRUY2k1Vjh3?=
 =?utf-8?B?UjdZR3ZLNHJkNm1GcEdZN0h0bndsRVBkVTRNUWkxSldFN1ZuNlplQzJ0c054?=
 =?utf-8?B?OGVjZ3ZpSmlKZ0EybVJoWmMvT2RLZVVpUWJocUlFR2xwZFVBcG1wbDVmTkdE?=
 =?utf-8?B?SnRvN01hcFhCUjBKV0ZRclVvNXBTTGJpaVJJTjB5MDdmYWlwaCswRElLcm9I?=
 =?utf-8?B?aGZnaVJJNW85aVV1bWp2Ky9SalFOUjNKNjdJMnBwdnpSWCtvZG8rcTJZMDkz?=
 =?utf-8?B?NmdZR1pYekl3RlpKMDZSWGdlTzFXdzJRMWJ1eFp4WmlESnFyakpOYmt3MEdM?=
 =?utf-8?B?TkVranVNTllCUXhoNVpwM0JFODRuVXFUS205OHV5VmwzbDdCTGFrOWhHTkhw?=
 =?utf-8?B?bEl2QW4vOUtTbDdXY0RwbGJEODF6elhmYklOWlc1cDVBVHRPV0JuaHFLeTJu?=
 =?utf-8?B?SWpuTUNlQlZxSHR2ZUxTTlVTa3lnZmVDOVZELzZqZnlTaHozelE5NGwvVE4z?=
 =?utf-8?B?Y253Ly9RUnNKUHhMYVZjSXFEcmpYODJWcXV2RmdZeUI2WEtsd3p4WGZnaFB2?=
 =?utf-8?B?Z1NFbXBPUFpqVU4yOTJrdUdRMHJNZ0dWdnFMYXpvdEhqeTdIeWZxN0NHWjQx?=
 =?utf-8?B?V1U3cFgrUXVkTkNJdWMybWVPVlVFc1prdVlTM0U3R0t5ZmVTd3hVbU1YNE1n?=
 =?utf-8?B?YlhLNlNvdittNmI1NUNCU0Zob2tsdjBMd0hYMHhsRytpZXRFWnlHeURyU3hY?=
 =?utf-8?B?cm1SK1pVdmMwKy8ya1ZGV3N5UjFQVG5jR3NwV1NXV1dVOTJ3MEtoemtFSHBp?=
 =?utf-8?B?akFzQU5sUktYcEhTTkhJVU5ET0x6YVgwblMvYlJMb3pUSk9RdnRMZWZHZzlo?=
 =?utf-8?B?ejRpTkRxdlo5NTByNUt0bnNGNzE2N0puRGNOTlVqZTdZZ3IrblFNQ1Vablp3?=
 =?utf-8?B?V3NJUTdqN3FPVjhiekwyVUQ4K2VSaHNjSmo5U0ZNanFpY2U0Ti9BY0htMGV6?=
 =?utf-8?B?bXFXckNPNjRVMTU0NU02ZHFUVXdMN3RqeHNOSFpPU3EzeWd1eXNyb2FqZmpZ?=
 =?utf-8?B?OFpNbHBjdTFrK0ZBZnJwTUhiZ1Fha0JvaTlWV3hWWTRHWG1KbE8zZEVYQmdi?=
 =?utf-8?B?OE4vK2lpUEhsTitHUVdwR0paY3dUbGR2YUhqNWlvNnM5MjJwdmlGdDFwdkxF?=
 =?utf-8?B?UnhudzVIRkdnOFc4dmhERVZmVWt4RVdvWG1WRVk5bjcvUWpMZTVEWGxDQkl4?=
 =?utf-8?B?YmZ4VHJNMmtkSU9qZ21Jakp4V2lsdjdVTnhDRjhTYkFYd0VCQ09OQmFEN1hx?=
 =?utf-8?B?bjFNbmRiblhiaVhIT2J3QW5keXMwaUZHRFZmTVRVQlhuQzdWcnV0YVNiV1h3?=
 =?utf-8?B?dSt1K0RwZUgvZlgvY2tQYmhFNkhsSzBkU21NTjNCbGhXaG9XOVBuVElRTTlF?=
 =?utf-8?B?dU5HZ3RqNkVKM1VHKy9UVFhPQW5ybHF4NVA0YlYrMWU3aERtbFlCb0JQaFhC?=
 =?utf-8?B?d3dlb2kwR2dyNWN3SUFuWENWU0RieEtwVzdoS3JEKy9rdThibnh5SFpYWjMw?=
 =?utf-8?B?b2hzcEY1dTVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2x3Z2hPd0k2eEVBSzVWR2VDMk9TMXFtcnhML0EyV1JOMzZGYmUwckUyZ2pL?=
 =?utf-8?B?VFFwMXhVRWR2K3dNa3NFeGg0a3h6MGFLcm1vSFh4Zm5hREdjZVVtejhCSlJv?=
 =?utf-8?B?a1l2MndyUjE4ZVN3eVN6VUI4S2l3QW94Rzd2SytlY0NTUTZFaWJEMWswTmd4?=
 =?utf-8?B?UzVrS0JGK1R6a1IxNytsYm9iTDk5U0t4OUlaYU9KOEd1dzlzVFBhZFQ0TXdJ?=
 =?utf-8?B?ZGN4aWhpRVJKcHQySkhGQ050S3BaYUpkc1YzbzBOVE81V2Y4SFRmY0FiVmQr?=
 =?utf-8?B?WlZnN1ROS1IrRTFMUk9jZ05nSWxxdGhvQXZHVXExWlNhWDFVbXE3Mm9yRjU2?=
 =?utf-8?B?U2ttMGhQdFBaMEt6V3VMZkI2UDV1NThmZVd4cldGeTNkQy9BcW1jZmlmTXJs?=
 =?utf-8?B?TTc2M2RGd0VYS3B3UitFSGowNU13R3BJL2JsQWxLWFkyQ2NTcVo2Z0ZKWWFT?=
 =?utf-8?B?QXloMjkxM0VsSmkyQWFiWDdncW5vSGhyZDNGeGZ3b2Y5Si9qcmhnWk4zaEFD?=
 =?utf-8?B?MURYY2tCVWduY29KdHdzSndIdkg1UVdRUEZ2UTVzT2t6cG00S0hlZG0xZ2ND?=
 =?utf-8?B?c0VCZkhvaTRUdHBwbWVvS1NtZnlSWGhxb0lyUWwvZjV4N3FZTEtsN1pEU3VG?=
 =?utf-8?B?ZkZoRXJrd1hSUWp5NlpheG9idEJTdUFoVE5CelJNTEsvT1VGMlB2YUVLM0ly?=
 =?utf-8?B?L1V6dGh3cE1Mbk5hbnlZczVnd0JweXhWVDhGZDFsaU9iQjBMeVpRQjBqak13?=
 =?utf-8?B?SlBERUlmV3VJM0pwZU1nMTZ6NzFEZExpbm5SQ1R5Rk9ZZ3NBZW5rdDZTNVg5?=
 =?utf-8?B?cVk3VTQ5YnhKZ0pLOTR2aFZheitUL09rc1M4ZE9kYXFaNXR3U3IwaG91Ymk4?=
 =?utf-8?B?RlhRNmFzSzNid3RFSGJiQmQ0NWREdmYrZVFwVE5naGphUTlpdGxsWjRWTC9v?=
 =?utf-8?B?ODJWaFFZN2ZQcDc4K2xidm14N3NqNW1sQmNYeElSb1ZUR0dqSHd4K3d0QS9m?=
 =?utf-8?B?NWQ2SG1VM0RzMnZvZnRjNlQ5YXpvREQxamhRTW16VTVQK2RxNHA4R0FoOWVB?=
 =?utf-8?B?V3U3L0RZeDcrNGxqaXphU1AzUWsyeWpmZXVnNHpjMnIxeGZjejhXQkQ3NFdq?=
 =?utf-8?B?VmNQcWVQZGdJbExpN0VqeEkrZUpiZnN4Q0I1K1BNNWpOTXZObjNSZHB3cUor?=
 =?utf-8?B?K1Vrb0ZkUmRWTFhyYldNK3VQTDhzTHVrUFkzSkZISmhzSUt4aHp2YjdaWHhy?=
 =?utf-8?B?Z0Jpck5IZEFxdVRBeVJieGxDQVc1MlYxOGJQa0VJZ25jSSsydG00ci9xa2g3?=
 =?utf-8?B?VUZleXRBekJ0UWJxWEVsb1A1V1d5eEtJU3h6RU5PZ29hNUxmNDZ4ZDVFL3Rj?=
 =?utf-8?B?WXdUOEg3UzFDeHI5QysvYXllN1pKcVFjQXNBWW1mMmp5MUNpaWxpejAvaE1W?=
 =?utf-8?B?MVdDbmVadWhtSHdSSUVyZzVVV3V1a0x4RnZpZlhQZFQ5S1BQaFIycVlUNUlo?=
 =?utf-8?B?Z3Raano4NTBrTU5KQVlzRVc4Y1VSdmlyNWlWQUttK1BZU2ZFOWFLZno2TWcv?=
 =?utf-8?B?SFJRY2d3OWJ2WWE1TVBoNXdJSWYzYm5icENKQXl5SldYUmZvYnE1bnl2OEU2?=
 =?utf-8?B?WFVPZUlMSmVZZG1QcHJPVWxuUUtYcHBiMVpMeERjT1g4MFdTVDJlMXpUT1Jn?=
 =?utf-8?B?TFNnZHMrVzlVU1ZhdHcyZkQ4QUh5azZmeVp3TXdDN0UyWms1aG1hUTRjNmNt?=
 =?utf-8?B?cjVCbElsY2MzcVU5OFY3cUZQc3RQV1ozeU1xUno3NmFFVSsweVlVTzBqaUQ3?=
 =?utf-8?B?NmdyemlaRndOQysxMkhyL3BKdWlPK3h3bzRaLzVoODliN01WenRPMEpuOUJV?=
 =?utf-8?B?U3hhT201UU45V0g0bG1xY09IVjFnaTc2aVRYUHhnRWMrS2pJYVdmUXRYQVJL?=
 =?utf-8?B?Q2pQZGMyNzgwekpVU1JkV0pOMGxUVm8vT0xyYkJ5QXlJblQrWkt6Njg0dnVm?=
 =?utf-8?B?d1gzSDBnTDVyRVRmV2NUcEg5WEZBM3ZLZDVESTU4Q2k4Q3JjclVwWjZhS3F2?=
 =?utf-8?B?QnliMDM1Z1BqRHhaVGp5clduZkVudm5PR0dZMEQ1Qk5CbUdZcUh4RHVPb3Yx?=
 =?utf-8?B?bXVjbTd4d09YLy85UCt0NTArL3lPamhqUmx4aHAvSlpydVJkdGxqTFdMSFd3?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8e64da-3bda-4d00-ecbb-08ddde43b000
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:40:45.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx8SkpUqZm4OaSJ6FPCbdURLnFaE041QmlDjYe5CQ4BwC6VfB5ZHRp7w6Ip47tKe46QCxDE8G2SQs7qgAcLLqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7428
X-OriginatorOrg: intel.com

On 15/08/2025 04:33, Jisheng Zhang wrote:
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 2d46d4854fa1..84c7054607fc 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -973,8 +973,7 @@ static void sdhci_acpi_remove(struct platform_device *pdev)
>  		c->slot->free_slot(pdev);
>  }
>  
> -static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
> -	struct device *dev)
> +static void sdhci_acpi_reset_signal_voltage_if_needed(struct device *dev)
>  {
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>  	struct sdhci_host *host = c->host;
> @@ -989,8 +988,6 @@ static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
>  	}
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -
>  static int sdhci_acpi_suspend(struct device *dev)
>  {
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> @@ -1017,10 +1014,6 @@ static int sdhci_acpi_resume(struct device *dev)
>  	return sdhci_resume_host(c->host);
>  }
>  
> -#endif
> -
> -#ifdef CONFIG_PM
> -
>  static int sdhci_acpi_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
> @@ -1045,12 +1038,9 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
>  	return 0;
>  }
>  
> -#endif
> -
>  static const struct dev_pm_ops sdhci_acpi_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
> -	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
> -			sdhci_acpi_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
> +	RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend, sdhci_acpi_runtime_resume, NULL)
>  };
>  
>  static struct platform_driver sdhci_acpi_driver = {
> @@ -1058,7 +1048,7 @@ static struct platform_driver sdhci_acpi_driver = {
>  		.name			= "sdhci-acpi",
>  		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
>  		.acpi_match_table	= sdhci_acpi_ids,
> -		.pm			= &sdhci_acpi_pm_ops,
> +		.pm			= pm_ptr(&sdhci_acpi_pm_ops),
>  	},
>  	.probe	= sdhci_acpi_probe,
>  	.remove = sdhci_acpi_remove,

