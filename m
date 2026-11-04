Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793793332;
	b=shFvafoJT8s9ahpCS6oCZ2OpEEAPZCkFS8YxC/MF1E1jhiGMa62nrHSt5TsxJn2F+veq
	 GB/o/zZAANqS9iZjSNX1DkSWlBcVyIsXyEoJkZitVsxzQwhHZCE/tYRRULY+VRiB4UzDp
	 QynehSWirzipfilcOBhxBuFHn9517U/755Ao4xhGrgQA1YkX1B42qHvCYN9v1XT40EX7U
	 FN/SvVZFZegx+/wGye/NzU6yxAQKsnugNSojbzqzRa6Z4yVv6Bt+HOxajkF5H7N5lue8t
	 SetRO0mm5YqnlvKQhLfv4OJtm/zzFdzeiHnA9lBzjYJMonaDiN3KLanE9bfvgXmmcSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793332;
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
	bh=Au7xWnr11aLp+AqFJCgd1SVfAHLSdBG2su+FXLK3Pr8=;
	b=oXiAUn4EfBLrToF4zq7nk8uSoFl68z8jkMTgMmoB9+NWXUcVXzbb2YGAlC2sxhzpLe24
	 O+gzXe8TEl2DVF+527KofxZOuKlELcsXHYlOHyfcr7WtkL1VHfOLgbsJwUzlW6Me2NuJG
	 f2RqQiMApxT35Fd8/ebjKejOsCSnGLpcZxp3MkX2QamkzxPan78NwDf9eJEe5bN4akHRU
	 noV/wF7IFzRSX7MWftZvXo4eavwgykBbs2n151S6u3b7MvPxfj+oHwdL9VQR9k85zM96b
	 GjMkqfSI+yPyWwY4jc4lJ4gUdWJ0+XKupTSFQeD2r8Ybz2kX7UXCCeJBixnQMDZlsFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="OQka8r/m";
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716B606A326;
	Wed,  4 Nov 2026 11:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A716B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OQka8r/m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793793330; x=1825329330;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qNcO95K7m48XYrCCkTNhVdbScPZbElA3kmgKqcWC5Yg=;
  b=OQka8r/mb1lqQTkDig2QrOEV6jSd0uvGwkYlotwOJ09rUahzxu3bb+45
   6mvwi4YfgHliR9yYt9UvDczrBze8e9ilTVOK+XoA8wC6QaMivb4TBZPtC
   rf6jjKkzbYjg2zb8QjiqnRMGesvUa1rfdwuMZcXvrCq4WcBWCwnSZko8i
   GRRbhZ8CwkxaamBdZ+oWcUqJPJvObelv+V9NZ2T9YFhB4n8IDk/2MBgPC
   3shjSWqua+cMGI2AxJyiWl9MiIylLe3dc2FwEPXyVCrtolmjsBBiYab3s
   mJFIMaQkgJmIojK4uydDedD2hdgf6gBQtWfoF/KYW4F/GSHuOMbq1giZ4
   A==;
X-CSE-ConnectionGUID: qkGvk3yNS+eDeyGyhSpFBQ==
X-CSE-MsgGUID: RvEUuUnzTfO72Oi9PNJo3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2430829"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2430829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:55:29 -0800
X-CSE-ConnectionGUID: LnEY4PyeTmCuZIVgCCp0Ow==
X-CSE-MsgGUID: wNdDFEFARkm6/BB7VPqzuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6720350"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 03:55:28 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:55:26 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:55:26 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:55:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blfvMAtPKVoCoqWWJzsij0vKL43zeAlbgpF+azoj01QOGGAjyn/NyvQZOeL3j4+YBmaxheqMrg5718Q8b5PX41OeargNzT+5ew3lMaat+KyGYXCUDkXWz5VEuh9kR2D2MbCRH3XZKLhgyqghqXDQJ0gQ/d/U50xpjpuud1I0jHeEjSOCZ7QO8cwm37JEOuZxohLI1rRb6eMMzWJB94ykHsAOYKW3clnHK2GJpvHPG9ZbaXE5F34Kx3Ng2B4CpOqtzFuux2w14p8J6h0o55FeOnODp0uYkjirG/sw4XA6NQCLbFF4BBd+j2CGWY3OmWsmKi5k5mciiBaWqHycLxwdag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au7xWnr11aLp+AqFJCgd1SVfAHLSdBG2su+FXLK3Pr8=;
 b=dQ8eUsYbwBEfHLNwi0sc8ZzRMZDLMWnl2zNUJwPkPPEwLBgDygfOvGWY4XCLb1Gbk+y9m5k/dH3040KOc9n3STznDX64whQW4xIuQg5RpniO54v7915N69T0LVOmZsJLIow3jv4V2NddoWB2OKpC+lLELNClFs7Qgmww3RTTydZmao33CDQUdstsjwRjz8+IlmbaPdj5UrsAA98EHGckszq98dq5RTx+A4Iyuftnkpkda8Rd/weBBm4xfsx8+YulQLmPVPJeQFubLyPtUWBhsijxkPxVX/aXPsYvzPzKC/fM6WkvZ62FsVXCO6f9+Ir+lhFgMUBhqmjjB9G7GWFDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:55:24 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 11:55:23 +0000
Message-ID: <027e79aa-1634-4389-a04d-25d4b5f229f7@intel.com>
Date: Wed, 4 Nov 2026 13:55:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mmc: use dmaengine_desc_set_callback()
To: <Frank.Li@oss.nxp.com>, Aubin Constans <aubin.constans@microchip.com>,
	"Ulf Hansson" <ulfh@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
	"Jaehoon Chung" <jh80.chung@samsung.com>, Shawn Lin
	<shawn.lin@rock-chips.com>, "Frank Li" <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, "Pengutronix Kernel Team" <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "Aaro Koskinen" <aaro.koskinen@iki.fi>,
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam
	<mani@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kunihiko
 Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson
	<lars.persson@axis.com>, John Garry <john.garry@linux.dev>, Hemanth Selam
	<hemanth.selam@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Rosen Penev
	<rosenp@gmail.com>, Fan Wu <fanwu01@zju.edu.cn>, Marco Crivellari
	<marco.crivellari@suse.com>, Pan Chuang <panchuang@vivo.com>, Zhan Xusheng
	<zhanxusheng1024@gmail.com>, Rakuram Eswaran <rakuram.e96@gmail.com>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Ethan
 Nelson-Moore" <enelsonmoore@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>, "open list:MULTIMEDIA CARD (MMC), SECURE
 DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "moderated
 list:ARM/Microchip (AT91) SoC support"
	<linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, "moderated list:BROADCOM BCM2711/BCM2835 ARM
 ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, "open
 list:ARM/FREESCALE IMX / MXC / LAYERSCAPE ARM ARCHIT..."
	<imx@lists.linux.dev>, "open list:OMAP MMC SUPPORT"
	<linux-omap@vger.kernel.org>, "moderated list:ARM/ACTIONS SEMI ARCHITECTURE"
	<linux-actions@lists.infradead.org>, "open list:TMIO/SDHI MMC DRIVER"
	<linux-renesas-soc@vger.kernel.org>, "open list:ARM/ARTPEC MACHINE SUPPORT"
	<linux-arm-kernel@axis.com>
CC: <vkoul@kernel.org>
References: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20261102172126.3890568-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR06CA0047.eurprd06.prod.outlook.com
 (2603:10a6:10:120::21) To IA1PR11MB7198.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: f7390fd0-1b71-4830-4583-08df3a6a8222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|921020|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yDrvOnAvuFnHYkcIoTrLWxx6+Z1KIkDOGVNHX/Cb8DQY7RyLw5Gf2qlD02UEzE24MZVBCx3d7tJf4tyCI7td4Yex5mwaksuLGHkZ+G9emRsyLEWlFYmTD417/GCT8AjGdKjCpbai+eZGMAw8iqGGyiwcI0EJeticmHPLV1Jz3SKTto+QpJ6YpoSa4P1RXiQtF4wLGwUols/eh8bni1nv5N7e7r8oKfMTFBk92Iz8PVAaVlaEgj+XApveRLBUkMs5rM3TwfGyqI0mXnYQmFkyj/nDjQX5aiIvvXfxeCIL+XAJ3luH5LqlJzt/WyeNlILSZRakyhP7PmbbvW3lIZveyPfUzOT0fvOfS6ppz+CzmOllp5RiNyRWGkoHq4IW9RXWWvdF8TkFXAIzaeBMK5ayomUadiDlJ1a9XxaWOvOiNKgp8PUftyKlgWEZQ8eCaBZeCWLXHGNAo3MFpljh2tFlDWVYTv4f4npfSLIjhk+BVLd/DwAjH5iskQI1UfNXnAkqyZEQqo041Svb5ebWq8+NmSDrII9CjF6lAYSe0W4bqpJB2PYUJ6Na8VL/rLjCsP1qt1k/wFYa8osh8Cj+FJG3zIQZQpsRNQ2nUO9A7hcIL3e4vhYs6cFrXS4rHsHzCzgqZ8HyPQsUCYlU8rIir6DScyIJHLqThw5bWYGyXXAeuFFzjhpuBjYMLXRNmqEX/HjtrQbx3XutBTth2dKRjLep2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEJEcFN5Mm1lUU9kT0t0ampiM2x6OURTR2VMckc5UytwdXh6elFsQW9EdlAw?=
 =?utf-8?B?d2RBZ0V2SDc5b2NHOEhZWVVJNzR2V1dOcGl4RGY1bWg2TklaTk9ENHBTcjJ6?=
 =?utf-8?B?a3drZzNCd0dYZUlhZ3JuNElSc0MxYVpBeHV5VDJuNXZJMkZ6cSsrNElVYjdH?=
 =?utf-8?B?VzlMemk3Rm8xQ3c0cXZ3TkM5STdST1lqNG1lUFhDcU9Mb3RTeEQxYXI4ckxC?=
 =?utf-8?B?Y2NtYkNpSmh1bm1mWEdQSlowcVYrRkFqRi9TN2xXNitST1ViN0NCK21xSGtk?=
 =?utf-8?B?bDdMVWY0S0lYdnlwdGRaSnN5SEx6ZVNVWDVBZG1NT3FCaW9Ta2hYNFpqVEJj?=
 =?utf-8?B?dnVYRHFrcmcvK2lMS0s5ODZXY1FGWnUrNnVoVDhxdkdvSW1PaVByT1RFUUN6?=
 =?utf-8?B?MlNMeFNlaVdPWncrYWQrbENmclEwRTRXUmJ3SzVLaTY4V0kyUlNRWTRiOEdI?=
 =?utf-8?B?dW54RFJMaFc0eEJRS21Qeko0b2lzOC9BbWYvcXA4dXBENVNMNnF2NFQ3bVlQ?=
 =?utf-8?B?NW1VV1lGZkhFWC9vcjdqTWhIU05tWTlMSVc1MHZoNTI4L3hWSjlBS2xCK0xY?=
 =?utf-8?B?enlHeTlSb0xlRXBYMytMcjJicjBoYXk3ZWczUzNRTjBtc1V1UlpHMDkvbUZB?=
 =?utf-8?B?c1FUTmlHTnI5ZkJQTlJKTTllQzRteFVibk42blRHYW00UnlhWGZIcVg3ZUpD?=
 =?utf-8?B?Z0tjRHV6ZjVJT2tqbndSV3JmMlhnOGgvRTQzV040aEY5SzAwbXFWcmVPZW5Q?=
 =?utf-8?B?UWw2WVJRd0NBVkpqSjVWdkNERFN1cUgrQ1d3V25vQk44VHlraG16K3JKQ244?=
 =?utf-8?B?S3JiZGZVRzIvQUNiZS9YeXpKSlBKUUR5WFdXanVLNjdkNngybmt0SmtxZVJs?=
 =?utf-8?B?RWdMNGpzbGZYejZaYlltM2Q0bkdzTnJLR1Z3SDJDQTRkNlZ1YlcyWWdYRGI5?=
 =?utf-8?B?VTh3ZDZmaUF5T3RoRmJSR3NOV3JhbU1GY1VveGRET1U5dFRIU21heVlGOFZ4?=
 =?utf-8?B?WXdBVnZ1dkFWbnl2ZXhlR0x6WjNyeWpYT2l3dkdiem11WkUvd0NLVUsydnd3?=
 =?utf-8?B?WUo5Mk5iRlN0RXdBcTU5REhkMnNVVjl6ZXhpOWd2TlBMd2w1WGhpUS9vUnph?=
 =?utf-8?B?cFVMSkNKQUVocEZUa1BXVUg0cURzcDJRUk1pUWRaUndjaFljaUd5a2oxRGxD?=
 =?utf-8?B?SnAzWDMvVXcvTmYzMUFVM0ozY29NQXQ0c3phZlBjZHVFMXNFdnAwd3ViRndO?=
 =?utf-8?B?SkJPK3BVQWlrU0RuNjQ2ZUVXdC95aThNNitKMDZrcWxLUUIreGlXZjBsaEFX?=
 =?utf-8?B?dUlxaW9FMHF1MHRQTUtuOExVVk5xanhHM2g5U2diVkMvaDFBdDVVQ0FQSE5X?=
 =?utf-8?B?WVhieHhlaEcvZmhKUWZoVGZ3RjkzSndRbmFwSVBHTGlQK3NhUXBhQi9Va0k5?=
 =?utf-8?B?cFhrMWFCTFBvbWFsTHI4elQxTUtyQk9pTlhxM1F6SlpwMWRQVkgvQXhuNGdo?=
 =?utf-8?B?YnVEQzl3cFZIaWc1SUdSZWFuWTZ5YWs4dFBaYjNnTkVZZm9yNGQ1ZWpoNmhL?=
 =?utf-8?B?aFdGTkpsQnBTazhHRUxSWnlNWTBhQVhDTVU1cEl6UkwxODFWYVBGQnZnTEtY?=
 =?utf-8?B?M3VKMWpxK0xVTmt2Z3N1RnVuR2xxclVaOXdTVFhiSEVOaVlZRG9oRVI0bXVM?=
 =?utf-8?B?YThOM0tPczBDa1lZalNBZTBvUHhOSTI2Q0FXY3ZleWtBaU1qL2d4dFNhVFBL?=
 =?utf-8?B?TDdyd1pjcHE0N2JpTDh0L1hwOGVtalRVSXZTZnpHN3BkMUkxMGVFaGs4dFJJ?=
 =?utf-8?B?R29IWDlpSzJZc0MwWldOR1VicytoOFJpV2RrOHZXRmEyYkxKekVSNjNPbTQ4?=
 =?utf-8?B?VEx5QUtSUmdHeG9wVy8xRHRZNVBXb2Y1ajZvZmMvNjYrVHB5N0o2L2dmcXox?=
 =?utf-8?B?ZG5HT2ZDczZrRHM5WldLY3RBbzRXZ1hOY3Zhd1N5b3UyalJybHdiRlpwRFpX?=
 =?utf-8?B?MWtlYUZlQVM0aU9ITnF5TnhWWWJzNWFJbnAzVTg1ekUzSTBma2djRVpjQm5F?=
 =?utf-8?B?VVJOSnR6Q0l0TXJUM3VwdEJvcWtBcUNUK1BLUHF1a2pjUERyNHdRN3NzRUNL?=
 =?utf-8?B?RnFnbmh5QUlaQWV2dU81N1hoL20vNk5paXlYVVJzMGdIemtFcnpKTVBuMDVI?=
 =?utf-8?B?VGxFNlozNy9UZ1RLZzJScDA2MXUrNDNpbm1FL1RFRldmK0U0MUc0Vm13dWNN?=
 =?utf-8?B?SGxKS1R3Z1FLNE1FSUlkZEo2V2xKZXdraGJJK1RPbWlBcnNCM3JWK3Z1eFRy?=
 =?utf-8?B?YzRrbUNzS28xMGI3c05hb3RuTk5kVlJaVXlzUGExMlpubEtnVmw1QT09?=
X-Exchange-RoutingPolicyChecked: so4tITgPhduRC5CgqEDsJOhLBWLVDvGZpLhm+PUs5+WO5lichjAcZ8z6EIrPHGXdGXIcMFCq1cPECuMR+NEzglQMqGOUtpTxrf0+uhPa1TW6Fsiq+GyUNB1RiSLWE+9evHpib4abVAdtKMrmLO5LZbGuWgxM3T/K5ascz3pT4PfP2i76v/rpZifRlIz3FELV8Us8xP5rzoujeR4K993wKVG4FQ/YYDRfxgXHyoT0Nz+UMJNCt1nLhaD1IjakMnBLatXrr8An8K1ksjwVcPEVW5YK4WxhJWqJlwn2zRKGw3xy1/sPmkLfIrcsJ+0Oblb7OkM5u2MQXcGQl2aOZS1ygg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f7390fd0-1b71-4830-4583-08df3a6a8222
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:55:23.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tUVpSj7X6VRJrUcHY1GGoO+rSQQS5S2VndXcE0zS6c+YFV0nKyS0OaLxim+eMDovuW1F2/QUVup/4NhhiApvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com

On 02/11/2026 19:21, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across MMC host drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/mmc/host/atmel-mci.c             | 3 +--
>  drivers/mmc/host/bcm2835.c               | 3 +--
>  drivers/mmc/host/dw_mmc.c                | 3 +--
>  drivers/mmc/host/moxart-mmc.c            | 3 +--
>  drivers/mmc/host/mxcmmc.c                | 3 +--
>  drivers/mmc/host/mxs-mmc.c               | 3 +--
>  drivers/mmc/host/omap.c                  | 3 +--
>  drivers/mmc/host/omap_hsmmc.c            | 3 +--
>  drivers/mmc/host/owl-mmc.c               | 3 +--
>  drivers/mmc/host/pxamci.c                | 3 +--
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 6 ++----
>  drivers/mmc/host/sdhci.c                 | 3 +--
>  drivers/mmc/host/sh_mmcif.c              | 6 ++----
>  drivers/mmc/host/uniphier-sd.c           | 3 +--
>  drivers/mmc/host/usdhi6rol0.c            | 3 +--
>  15 files changed, 17 insertions(+), 34 deletions(-)
> 

[ ... ]

> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index efb4c7742fe21..18aca84834fb6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1298,8 +1298,7 @@ static int sdhci_external_dma_setup(struct sdhci_host *host,
>  	if (!desc)
>  		return -EINVAL;
>  
> -	desc->callback = NULL;
> -	desc->callback_param = NULL;
> +	dmaengine_desc_set_callback(desc, NULL, NULL, NULL);
>  
>  	cookie = dmaengine_submit(desc);
>  	if (dma_submit_error(cookie))

For sdhci:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


