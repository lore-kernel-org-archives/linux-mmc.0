Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20AA3921D8;
	Fri, 13 Mar 2026 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407092; cv=fail; b=Rc5PHIon0JKJcdrhfXk/WyCtDOqQTqMxBNe0iCuAGVVDxiQUEIG7qGnH0a/MejBuClNd/VeHhrilyRrFvbpQELDKrjB+8rDsHaegHbPd12IuYfu1iMGnTahDXOsP+RhUcwD3x2kAupswpzU+lWZHJyldW5rxkBTMTwlU0Q+sE1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407092; c=relaxed/simple;
	bh=zV6qHPHDbvr21TiL0aECWSLmvmqGr2AKYHSJ2kN7lsU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EicgeKvgENxivvDzecLYO/35KC5ckeSBHR5HsDBUSYipn5RvcdsJUGqzWRrUVNQ3DVkanLAhwu1xDNiAi5dgEh7VK92ZVIxBxedaJEzedKTZ0DRP47TfCoujW/zVr6Dqz7tSkhfzwNMx6WzcaammJRVUo0yEttykBVx/k5kfwMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZE5mv6s8; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZE5mv6s8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773407091; x=1804943091;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zV6qHPHDbvr21TiL0aECWSLmvmqGr2AKYHSJ2kN7lsU=;
  b=ZE5mv6s84Q/lFZPq1GMgjRIULArRoH7QCj4OH4EaiwPgHXvoudsiCsj4
   6p1mBhBoT9+pkIoyVJnnhei82qnmbCwNPctwrprpCPQVIx6FR/fNN6scu
   WFd8JnKdy87aB18UbV4693oKLh9ur6bIS32ji/LHI+TbgBdy5bOmansJy
   Mbh5l7VYHb+idY+A1/erMA2bnFWOD6+wwb1JywRJVZF7vB+QQlZCvDrkU
   6PGyu5ngiZ7bDJ0UYZ7V8TDbrzjEo8RYrwPlCpE7b0AryycZIJuMhOK20
   LXjoSzl6988cv7ib29BWtL4jW5xbSquSgAQ/MFPvnmYH+ZrRkJWTmWhqR
   Q==;
X-CSE-ConnectionGUID: PTHdL9QkQRenSY2YSwR9Gw==
X-CSE-MsgGUID: GB1eQvGjRdWrufgrkegrOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74550105"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74550105"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:50 -0700
X-CSE-ConnectionGUID: DdbSOAm+TsOJUVCHEG0svw==
X-CSE-MsgGUID: QJ681MuaTFC82XPzWH7Ipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="259051409"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 06:04:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 06:04:48 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 06:04:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzU7XQJEbvmYxgX7fniFgx10p2P5McCpAfLLUgxbtq0U1n9BebWag9NCU+1mqWggHiJ4g4hjcV9qxlJgGIu92aQXN8wg79uaQHNMDgHqxOLnfrK/WSupbjwnvEvRFeni6HsgoJaqKyGoEkJXCQwHwjLTckrbOVojvamF4XlTbTFQSfvSpgHoxJuLLqOia+wBLKwjTT5wAnRMDamu9AHMujJd0G7dVbo2IHlAh/4al5Ey2kHOJIjvoz+xXI9wSdcfcHSlrfQCfN8Atnl2zc+AmlX4hpzxvQoXG5QnYKrD8H/SK57NtFyvzYtiDMgplZk0ZcspDYRhB1BnDXJWuPzYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UBacpjQLhe5Msn5kE7OKP7h5CacmgaFjTLM7Z99jzg=;
 b=mis76+UkP/AfFfwjEerzVKMsnSMb0JjZofhnEjwlkDP1ImcT9KGO+r0AhHVsQCCLvJw81jMGJZ7YXBz8qrmzy7df9jE3kbK83zbztHC9ONbND+mFErKbDauNMNcuvN9d0XjtbO6R+zvOQISyZfKXGd5d5xthGYgIFCbens/OijdkuwUxps5E/NHWRCcVzRmMm+SOcLx5u5FbuV4aTo8WV22W7/nhduKAvl+7RVeWp2+7kbNX2TXvCRn/ifTj/cRXlFBW17UrYhK1pqkvbxa3bLyBMV1JYTOapIHSqMNceTsfKleHU+HNHBU11Mi49ByXtzliuGrZ0eoI9M6FCcChsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB8988.namprd11.prod.outlook.com (2603:10b6:208:57d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:04:43 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 13:04:43 +0000
Message-ID: <069e9027-653d-4bb6-ad94-e3d751b0dd2f@intel.com>
Date: Fri, 13 Mar 2026 15:04:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] mmc: sdhci-of-k1: add regulator and pinctrl
 voltage switching support
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-2-5bb2b574df5d@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-2-5bb2b574df5d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::20) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: a05d3b49-48af-4948-02dd-08de81011817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: dLZUC2KqJO0vV73CpbZUMLomyxbeJ4koFXxRTIVz+IqumWhiaCpk7elV+y74w/acWv08W9ItkuFCwL/rfgvo/BPHtFdbiX9ouKhpeyYVH0m5l4llR7J90g74oBtQz6SY989bhiho3cvZYJe0OzQHejPSc+MAdwk5j64foMYkfg3oosR+gtZ0312X/KuMocb6bZly/tsKhET3FLm7zfnE9ube/kNYxUaQr5d3QRmmYHGicOTNcq8BPSU3d9xQFZojFEW4MeO1OYW7vQxESbrc0rC+fT+2anT/w5V+oU/EBVa0ycnmovytowylGJIlT9npqdvlbF9rKy7DGOUb6YBNirYmSRY/nG+7rx20CfJB650F1URf228LiIPxGOMOel0nXWOteUv5PNi4TgXVIx2XByoa9AjSIBXCx5LlJIMNQ2diuo5oLNVt2RLI3MoKffhYYYCamV2H1XwthL2X4X+Zoi43xUTlW8qmWxKc3zpWIVWUt/g2sFswP+KmtnHPP432b/M70Fd3UUv2sJWfkclXSnwwoGWBNDBNPCdDx3VbjZ6MfTVhalkmIju62qXaGYw7Pr5FSa150Un+c6lndfIMrR0lBk0LjRR4vO5nPdjND6kxFOEIit2jNWqBtJnbw7murx/ipzq6+vIElqZgBQNPMz7OxNvFS4gawpXQcf14SwAAOen9jrVt6b1ORp8soS3N6wkEmFuTh6Q7NEKOySGzl1OjXgK2tpq1NPfXS/XgntoC1ZzrlVsvwhaBcvK9dlynuo+Qs/7YE2uBxhpKHtsU/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU52WnMxTlNQdERWb1dqb3cxVXNockNpdzhlZmV2WElrMUVmTGUzS2tOd2lx?=
 =?utf-8?B?djZJZWZCek51a1dYWDRqcDZFbjhZNUFaTFNJL1V0TnJFUDJ1SGszMmtzTkpq?=
 =?utf-8?B?V1h1VEt6QWF4c3dkbElnTldtTFdhR1dTUXhBQStXVFFCQ1VqOWw1bVFUVVNa?=
 =?utf-8?B?ejhMK01QZjYvRTJrNWxVdk1iUzR3QU16MGcxRmk2OHRneU56YTFZTW9EQ3Q3?=
 =?utf-8?B?bnI5YVFWWmhTWDBRSjN1TzQvam9nbWFycXlyQnYwaEJiaEhRZndEaVlnZkpR?=
 =?utf-8?B?Q1RhQ1RmV0FCUUMrTlRERE9kekNoV2V6aThLUFEyeDhNQUliam1tWnRTUFdl?=
 =?utf-8?B?UUtyckl5aGFRRUwxWXVQOUkrNkVrc0RGejAya2lSNG9DTEw2T1AyTUlpZmxo?=
 =?utf-8?B?UTF6anRTZEFQZXd6ZSthWmcyazJWcVpwdXFXNllIbndwWXhJSXQzdDlHUXU2?=
 =?utf-8?B?ZitGdUxmbmxiK2xvb2orU3ZvcThYQVhFTHpCU0U4SDFzREdMNXduUkRLak9Q?=
 =?utf-8?B?SmdsMmVlUkJoN0FDYjUyZ3MwQ3RmbGNuQjh3eWcrM2JVYjZWYy81aWZRV3pE?=
 =?utf-8?B?RnJva1NMT0xMOEJ3OUpsY0IzeXQvRVZlcEp1Q3FLczA5clFDcTlDSVhlQk9Q?=
 =?utf-8?B?Q3NlbDllRmhmbjZZNzJTQnlKeCthSlJsR2tONExDVDVvcWh5cUVsUE1PVmpl?=
 =?utf-8?B?blRCTGU2Q2syaENncFNSd0JRa0FlaDlNcTdWVU9jVEl0K25FSUY0QnFrY0hN?=
 =?utf-8?B?VXE1K1pudzE5WVR3OEtyb2pXd1cxOGN5SWtkbjR4VmZEd212QTFtSGIrWmd3?=
 =?utf-8?B?LzBPSEovNVl5SWQ1b0dLNTA5ZCtvMGlTVkE2THh0NDVlUnBFVmJjZGQ0RzVC?=
 =?utf-8?B?ZFF2b3N5YlI0U1Z2UnF1b3MrTFJxWWxaR0drREVUVUgrK1VjaXhkcFIwVDJz?=
 =?utf-8?B?b1VsYkxDcFJ6TWgrSHQzdjZxOHhqVlVmM0hyNEVTTFdmNE9HTVhRS01ZMU9K?=
 =?utf-8?B?YnZaVUNnT1lkL0lIb092WTRXZFNUTjVWeXBvbUtWK1JHRW5QZEhPMjIwTjkr?=
 =?utf-8?B?Z0JUQ0Zld2RTOXdmZVU1NEZmMUp3OE9rUFUwKzBQbWc5WC9qcW1GQ0E1N3Ba?=
 =?utf-8?B?NW02c0JYQTBISWlLRGo2c2VqN295NGFVbkRoVG5keVVibm1hamNlL1RJdHkw?=
 =?utf-8?B?MThiV01ZaG5DMU5PSFY4Q0gxUTIrN1NwRFZsR0k1Q3ZiYVZJdW1IMVQvcith?=
 =?utf-8?B?Qlc0QWE1SzVkQlRHT002SXNWSHMxTzJIcUNnNjVTME9HUmhsS3FNbjlZZ0Y3?=
 =?utf-8?B?UEkvTDhzaGFGR2xMTlp4c3JDMkM2YWhJOG0xUFJaNDFEWXBON0I3L2Z0OFhw?=
 =?utf-8?B?VHJUWmNDZ2VPamQrVXMxcWY3UytpRzgrTnFyVmZTUmZqWVloRjdhRGV4TW4y?=
 =?utf-8?B?ckw1ZXA1cHF5Y0NPUjlMMVRnWmdSNXNiZmZZSjFJRkpJUnpTQjhCR0s1UzRJ?=
 =?utf-8?B?dlJtSUZ5cHBnU05zWlZwR1NiNFhQWVpXditmV1RYNVhHYzJ1S3FyZVprQzlF?=
 =?utf-8?B?TFZmTzVhTHo4OGowd1hidHNKRXdEOFhiTkJjYzUvVE44WGpEVEgvdnJGcXky?=
 =?utf-8?B?cWMrQWlPMG9BVGsrZmVUcWtUQ3U4OVB6eThCanNRMzlvbW55R2l1SDlXVm9B?=
 =?utf-8?B?TmdrSlJCTGg5ZVYwOFJzRkpRazU4MkpvUlk5QzJSbU9tOE1PcExoOVBvQ01Q?=
 =?utf-8?B?S2F4RkZqSHd6cFZVckFDK2JSWElPR0lUNk1tR3V5NkRHR3dEeWxwRGZwMitP?=
 =?utf-8?B?bUZ1Y2tiYjByZ2RISG0zcytDVW94S3htZmlDb2M5SGVHNnpTVmY1TXhiM3M2?=
 =?utf-8?B?K1lpMmFDZUtZRGtTb25VNDRLeWhaMmxldGU3T2NVdE1WQzRZVUFkY1RFN2V3?=
 =?utf-8?B?RjhGYW9oTUJLRzEvVjkyWCtzTHNPQlp4MnY1QXh0SVFUaG9zL0cxMVFuZ1k0?=
 =?utf-8?B?dFI1N2R2SCsxT0dQMnFiYnU2NmhwcVN0SS9ta3RtTGFxUGJlcm5jOXhzb3JW?=
 =?utf-8?B?ODY2ZE5HRHU0MUloNzZSa1oxTVBUR2l6bmM3Qmg0YmU0QmU0WVk1K3graUVD?=
 =?utf-8?B?T2xNQVVjWDJWUXBBMlYxL0YxRjVjc0g3V3lkVlJsaXdNbFRHZHhJQmRMcUhM?=
 =?utf-8?B?ZG1yNGF1OGtaRmVaQlA2M3VsclVSalAxcS80eWlLRk02NlZneXpZZ25yZXFF?=
 =?utf-8?B?dFZBa3pFcVJpcWRWbUxCbkVkWnpjVzA0ZlBCbTFwekFWc0FNeXRpaUNqUytV?=
 =?utf-8?B?eldCUDczWjFzMjg1cVF5Wi8rVTVsMnV1YmRpOWxrU3RBcTBINDJ5ZWNJS1hp?=
 =?utf-8?Q?Q/BkEo8vi4KoCHNs=3D?=
X-Exchange-RoutingPolicyChecked: DwCdc/Cu46hjIvtwM3q/xh4XDNoOibZPb56I73DDJ36b8Pu3pz/KI3UQrID7qz1DG49TG5Uy5ORPNgyTdo6bBEuXM1bc3B7foDHkFtXtx31Y8dHthu7N43134TUkUDrzqjFCbcar4fAxLGzUIncEF0Ll6OxM2t4UoFGZ+1incZILY4FcPbVQaE3MFv62/XsksWXfM/8rHOG3/idK9g3ysyBBNTfPgxZL0SODA9TAtt0phbsoD9eeJBt3Lco/ejHwN3lPkrpTBjhITVbMd7+Y9nxVaTqlQ8Mb/j2LluOc+tHYwCfdkeAS8d8qTr2bhlQIQt61oJQjPbycaVSxbR7g/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a05d3b49-48af-4948-02dd-08de81011817
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:04:43.4902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hMgqi+az8YE6Sl6ZHj9T8C1APE3V8QCSrv0TTaoCtw95x5PlPKCS3YW6U98Lg3rFCiLqAiNMPbffPEMO4j4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8988
X-OriginatorOrg: intel.com

On 09/03/2026 13:40, Iker Pedrosa wrote:
> Add voltage switching infrastructure for UHS-I modes by integrating both
> regulator framework (for supply voltage control) and pinctrl state
> switching (for pin drive strength optimization).
> 
> - Add regulator supply parsing and voltage switching callback
> - Add optional pinctrl state switching between "default" (3.3V) and
>   "state_uhs" (1.8V) configurations
> - Enable coordinated voltage and pin configuration changes for UHS modes
> 
> This provides complete voltage switching support while maintaining
> backward compatibility when pinctrl states are not defined.
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-k1.c | 59 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 585c7eca6ebf253aac466dd37cef029deb63f692..8af117a8e271c04a80d8dc7bb5ce12075652dd7a 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>

Conflicts with "mmc: sdhci-of-k1: add reset support"

Ensure patch applies to 'next' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

>  #include <linux/platform_device.h>
>  
>  #include "sdhci.h"
> @@ -70,6 +71,9 @@
>  struct spacemit_sdhci_host {
>  	struct clk *clk_core;
>  	struct clk *clk_io;
> +	struct pinctrl *pinctrl;
> +	struct pinctrl_state *pinctrl_default;
> +	struct pinctrl_state *pinctrl_uhs;
>  };
>  
>  /* All helper functions will update clr/set while preserve rest bits */
> @@ -218,6 +222,42 @@ static void spacemit_sdhci_pre_hs400_to_hs200(struct mmc_host *mmc)
>  			       SPACEMIT_SDHC_PHY_CTRL_REG);
>  }
>  
> +static void spacemit_sdhci_voltage_switch(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_ios *ios = &host->mmc->ios;
> +	struct pinctrl_state *state;
> +	int ret;
> +
> +	/* Select appropriate pinctrl state based on signal voltage */
> +	if (sdhst->pinctrl) {
> +		switch (ios->signal_voltage) {

->voltage_switch() is called only for ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180

> +		case MMC_SIGNAL_VOLTAGE_330:
> +			state = sdhst->pinctrl_default;
> +			break;
> +		case MMC_SIGNAL_VOLTAGE_180:
> +			state = sdhst->pinctrl_uhs;
> +			break;
> +		default:
> +			dev_warn(mmc_dev(host->mmc), "unsupported voltage %d\n",
> +				 ios->signal_voltage);
> +			return;
> +		}
> +
> +		if (state) {
> +			ret = pinctrl_select_state(sdhst->pinctrl, state);
> +			if (ret) {
> +				dev_warn(mmc_dev(host->mmc),
> +					 "failed to select pinctrl state: %d\n", ret);
> +				return;
> +			}
> +			dev_dbg(mmc_dev(host->mmc), "switched to %s pinctrl state\n",
> +				ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 ? "UHS" : "default");
> +		}
> +	}
> +}
> +
>  static inline int spacemit_sdhci_get_clocks(struct device *dev,
>  					    struct sdhci_pltfm_host *pltfm_host)
>  {
> @@ -242,6 +282,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
>  	.set_bus_width		= sdhci_set_bus_width,
>  	.set_clock		= spacemit_sdhci_set_clock,
>  	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
> +	.voltage_switch         = spacemit_sdhci_voltage_switch,
>  };
>  
>  static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata = {
> @@ -293,6 +334,24 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
>  
> +	sdhst = sdhci_pltfm_priv(pltfm_host);
> +	sdhst->pinctrl = devm_pinctrl_get(dev);
> +	if (!IS_ERR(sdhst->pinctrl)) {
> +		sdhst->pinctrl_default = pinctrl_lookup_state(sdhst->pinctrl, "default");
> +		if (IS_ERR(sdhst->pinctrl_default))
> +			sdhst->pinctrl_default = NULL;
> +
> +		sdhst->pinctrl_uhs = pinctrl_lookup_state(sdhst->pinctrl, "state_uhs");
> +		if (IS_ERR(sdhst->pinctrl_uhs))
> +			sdhst->pinctrl_uhs = NULL;
> +
> +		dev_dbg(dev, "pinctrl setup: default=%p, uhs=%p\n",
> +			sdhst->pinctrl_default, sdhst->pinctrl_uhs);
> +	} else {
> +		sdhst->pinctrl = NULL;
> +		dev_dbg(dev, "pinctrl not available, voltage switching will work without it\n");
> +	}
> +
>  	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);
>  	if (ret)
>  		goto err_pltfm;
> 

