Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B528C00C;
	Thu, 23 Oct 2025 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217719; cv=fail; b=ZgPGy+659hW0N+t2lf7DSE1oj1D1k06LpptsOztOOEIQclZAm53vh2Z61++BTXZcb0t5eDG8QSZg+V087Mm1kHmIY2m6Go7Jrz5qaKULXlZFwVBJ377PYhjvbmr/gLcixI2Mz7xKgbYDbKpiEFmK7i3stjQItxKLwwxmf83nH6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217719; c=relaxed/simple;
	bh=SL3cttM8MtqF0GQekikn8wfMheX0ZDmQRSz4MYZgnQ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DwcP0KBaGYkmJhkTRDvsdHiT4PXQILVbelJ4FIMC7ixLKQbnrEmQPrA0tYK0i6E0BXSu5yFh9pwUMzh3jaIo0f4RjKzi1Jk+cw0HVEvMiEiJMyVsjdzYR8MwZsRhv68qUrHpwzRs++sHFXYVsrgHurFEy2qvzbjrlCVoZ0LJ3KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVhq1Rgl; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVhq1Rgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761217718; x=1792753718;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SL3cttM8MtqF0GQekikn8wfMheX0ZDmQRSz4MYZgnQ0=;
  b=fVhq1RglGUU2014PXJCTxOpE9rl3U453ILVuNu+IPucMP5abk1eKfECh
   Ge3MJ6hF9pqQFz8r6e3bmpC/EH3bMLqfkM9guEi5tCA+cME/G2+mxLzQG
   O45ef+Ndj7f3poZiubL8JX9MjJSylDAj0JHmt+aU3Y/r81UxJIAAdz/LI
   1UmMyvvaCfrlX4fegneB7OQwMO78+dYLYJBKB020vT1CwPqUPZIP2wMIT
   aKdYNJ8Rx3sSstuH/XnKZGpN6i2RKXiiSi5CmGv37da2sK2ZxTlQ2y8b8
   AfZtzEt8sUK7EfG6qI17P7dietWx1qx3rXrZXgmUB4ctqbr8aY2uqJAsW
   w==;
X-CSE-ConnectionGUID: lgvelmRDQbGvFP/Xbgynvw==
X-CSE-MsgGUID: bQxLxE3LR/Kn1Wsl3YRO3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81009560"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="81009560"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 04:08:37 -0700
X-CSE-ConnectionGUID: DywP/SiJTrCNboo+Pb5FDQ==
X-CSE-MsgGUID: 36mOH16+TWKr9LJVZeWrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="214785215"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 04:08:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 04:08:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 04:08:35 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.20) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 04:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3Me7Dg1o8af8ENkrqnK4ofGPUqj1fWkRAG+3mxB2KDyz3wJ4kOET1HLpASinY0dDYRd8cYq65Arc9qjgUBz5pusU88BAg25Z/1YyzHX7uPqjH/6mXqFyOIoKSpJDbR9o7FiO/0CCAN1zVpAj+ICZIjF4202EWbm5n2rg5uCt4X0reYjGZkz93UEQO9Lv80i5EFFXfRxAuZnqMJ+W1KxWQCOSnefDppYai4tcPFK35fQCHCVkroybMcOyL87B1JlVnDdU0C+OXduxxhBITqw7cU5WisSN8MUS3F/42gSQV6ufkClDJA5/XAIz2sGzOAIUUEiJoN77LxvHqwi9HTaVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L+82e8V1jbMv9KIzPtiuzPPwTiv7YTrkviNRuIcRcsQ=;
 b=qjFRYV7Pf27A8hUrB58DeG+iN2W0Vj89jrbV0GNYmg9ZmxIG+uFQ9Evo3iwV2Y+CbJ3XFN41UuKv2veRemdfR58DpvChyPWnf12x85uWmW+O8tMAs9ZgfEP4gk8yC4gRCSX6Ee+3NuMlNqJ5mAFXiHt15hqqmklFpIFfNUcvt1fniIgGLS5ShbP8NiLkCz6DhRE0IS7deE8PaHf5UU5/I4fw8cpDLP5AXyEZfZihZtmv0/Obw/NJZMeW7tWaVEaPGa+fKF1SS3XuBgbcQ1NkVnSDGhjWypMz678MwhWOvjSzMxv6DRuu1i9yiOQHZjp7OQ7LACU7WISLfjAH1kTXYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by DS7PR11MB6152.namprd11.prod.outlook.com (2603:10b6:8:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 23 Oct 2025 11:08:33 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9228.016; Thu, 23 Oct 2025
 11:08:33 +0000
Message-ID: <9b744e60-a0d7-48c7-b1fb-66df91b839e5@intel.com>
Date: Thu, 23 Oct 2025 14:08:27 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mmc: sdhci-of-dwcmshc: Add support for Eswin
 EIC7700
To: <hehuan1@eswincomputing.com>, <ulf.hansson@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jszhang@kernel.org>,
	<p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ningyu@eswincomputing.com>, <linmin@eswincomputing.com>,
	<pinkesh.vaghela@einfochips.com>, <xuxiang@eswincomputing.com>,
	<luyulin@eswincomputing.com>, <dongxuyang@eswincomputing.com>,
	<zhangsenchuan@eswincomputing.com>, <weishangjuan@eswincomputing.com>,
	<lizhi2@eswincomputing.com>, <caohang@eswincomputing.com>
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
 <20251019115316.337-1-hehuan1@eswincomputing.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251019115316.337-1-hehuan1@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|DS7PR11MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d57042-2ed4-4837-664f-08de1224817a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejl6d2Y3eHBwOFl5S2dJeVJocTVnYUdIcm5NWWE0NXRYOTVoM2RYQ0dqSE5q?=
 =?utf-8?B?RncwWWVBQmlhRmROOEd3YS9QdkcrNHIrUEdlWDJHWU5JaUZaQ3p3Ni9Zbnlh?=
 =?utf-8?B?eFB4VDJiNnJoVVo5SnBWb0traUNxeXNIK3FYTE16dC9KOFI0NmRXZzdKRlJE?=
 =?utf-8?B?ZWsxR0VYVTdkdURWRVp1SEtYM2tnSkZPejd1emh4QlJVak9QbGFDV1VQYXlj?=
 =?utf-8?B?THBKc1FQYzdXcm5qdWlRYlRkcldOcUJjOEc2MVA1UllGS1RYbjFZUXpUSStI?=
 =?utf-8?B?d25NMjlrM21mQytFVmpCbTZHNllXdDlqYVdhRFV4cjZkaXZsVldWejdXZ0Z0?=
 =?utf-8?B?cUVLbUkwTWdzejVCOVVlWEhRL1h6ZDZybkdJVXkwNnpTOUVUUktHYVovNDNZ?=
 =?utf-8?B?NG9tcldWSEVzZWNRWW5CZG1LRmtKbFZCVmhHeFhDN0lWcldkdGdUUVBBMlVp?=
 =?utf-8?B?UEpnWFpUbEFCeUxLcVBTUWZMNmRXZjBoUVhNUStyRjBZV1lhYmVPYUVMRENl?=
 =?utf-8?B?bzdLSEJqcGkwVkRncWxvY3dEZGR1YTBkWm05c0swVEFaVWVIQjVLUlVOMG9O?=
 =?utf-8?B?RUdyaXZkMXdGanJtalRoSS9sK3ltQnBZb3krdHlUMWwwK2U1OWdpQzlHdVhX?=
 =?utf-8?B?bGkvckdvQmplZU9PL0ttbXFVWXJzV1JkOTFsTDZwVnVMeWpUOERxTFNXcjlJ?=
 =?utf-8?B?M3hWcGtsZWVjQlZRZWo2NFNOaEFPcWhKc1JTY1hZanZyR3NZSWc2b1NpSlhV?=
 =?utf-8?B?WmVybU5wbWdJRGp1eWRIZE4zWEt0VDVuZTRzc3ZQQTNPYktlTkhoeWtLYkw5?=
 =?utf-8?B?SGNNQXR3QkkwN3RTcUloZEc5dnRrZUNRN1dkbEtvc2s0VHp4eGFPVUFSd2dM?=
 =?utf-8?B?Ny9TcjJtMG1ZQTNEaE5Rb2l0bXdoUzltem9pb1JwRUViYjlhZnkvRmhyOExS?=
 =?utf-8?B?aE1za2pGT0hWdHFwRUdqemQzM2ZyM0w1VDNNd0M5aC9Jcm05NWU5dTFTREVO?=
 =?utf-8?B?NWxjeWJGUTlvQXJUcW1zL2ZvTlVEczlKNDFjR0lNZFloM0JRekZ1bS9vK3Nj?=
 =?utf-8?B?cU96NzE4TGYvc0hjcXZFUTRrMWZFdnlKNlNXbXVzSVdyL2N1TldBSENZWUo4?=
 =?utf-8?B?UlpPTUgxRjJQQ2J2TUp1QWE4L1pjUk41aVlsT1h4Y0ZrZit4bVBjTEZkblUr?=
 =?utf-8?B?aDJ1czRnUFhVV2xmOHFkcG16R0svWUxrM0hiVkhXNCtEajN1ZUxGd0Fsa0Ni?=
 =?utf-8?B?KzFaZVRrMXNtSlJCRFV3NForM04xWjZSYlRUazd2VFRYdkUxTmNmMGRsQ2ts?=
 =?utf-8?B?c2tBV3ZRMTY0NkpQOG5Jbk9NdS9HR1BYVXpmcjV2bjdHY2VselpIcDAxb0Rs?=
 =?utf-8?B?Y2FHbm9KNVc3b0gzdjRma2IrQkQyZHQva1FONE43YUlLWnRhMCsrR0ZKOXhS?=
 =?utf-8?B?MEQ3bHpsYWg3Ym9TZVNFR3RXN0pnOHV1anhDVGk0WXl5bTNCR2N3ZHkvM0Nn?=
 =?utf-8?B?WW5BbEptSmorUWpiaHhOOUlaQ1pmZlA0dklvS2VjYzcwc00ydlVPWnVnS2ll?=
 =?utf-8?B?VGp2V25GdEJ5MlRSY3lTM1A1VlFJWnE2OE90ejgvUm04VkJiNkFkamZxUEVB?=
 =?utf-8?B?M3JWY1VOSUVkbU5tclVpaStpRTBkRkxhcUQ5alJ1ZWxVVU5qRVBVbkFzMHQ1?=
 =?utf-8?B?djA5MzVmczNtcHBHaEdTQ25zbzQ5dGZSdGl2NDBISFp2VXp2SVdSM1JGQjBE?=
 =?utf-8?B?ZUtQTkV6WHdoZk5ZS3RXaGtBZXpkeHlhSGFFYVgvVzh4WGorTW1GT21YaUZS?=
 =?utf-8?B?RS9NUElrZ3V5eDljdGtwK2dOak5NWStOQ3pqS3p4eUZjZzlMNXdrdHpnY3NT?=
 =?utf-8?B?MTBkNzFUNmVET2JLS0RVUmVaZE5NQzZDc3c0d0F4UlBLQVpON3RmRU82STcx?=
 =?utf-8?B?TjBXMzM2YWlqQjZsUWs5d0g5V2grM25PSzlFZTZrVzkwbENaM3JNS1BxSlpV?=
 =?utf-8?Q?xupE2XHf+yBhGt2uA/n4XLeOSBLPzU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUNnaC96SnpOMDJrZXN6UW9aNVZKQ3ZWQWtLMkRuQkxlcUUvaFp4YSthK1Ew?=
 =?utf-8?B?K2JIZGt3NkNqNXpPdkhBSWZhZ0dxM1BQZklzWERMYkZBdXgrMGkyVkVOR0RU?=
 =?utf-8?B?RElHbG9DdDk3TWtKSDJRRXJPbUM1QysxSVlHYUpvV2ljRnlFTjliNnF5dmxI?=
 =?utf-8?B?Wkt4YXJKTnVML3JBdUN3OGhMTFFtOWljTnZPWElHWVhIMXNCbjFTMWlJZERO?=
 =?utf-8?B?RnR1bG5tZ0F1Qndvb25QN2xoSm1POFJJRDY2aHk2Vk5aQVVXZFhaWjBKZFd2?=
 =?utf-8?B?bUVnMW8xd3hiY0NKZThvVXo1VWZWQ2czc3ljUU1Nek9kLysvR2tWbHF0emRG?=
 =?utf-8?B?ak1XUWlZSU9PUkhLT0xJV3dPbTVEV2Q2R1c4aU5FeDk1dWxoN0pKNlVPMmIx?=
 =?utf-8?B?SmxwVUNNZk80R0tmVjRBZFBxcktFQThJenFJMWNjK3duSFZqRXpNUGxPLzVh?=
 =?utf-8?B?YTNYdHdDQ3BGWG9sNVVJdGI3Y2xreUw4aW8xWTVXeHlMVUgraUV5aVVkbnBM?=
 =?utf-8?B?TTlLOTZmMkl2cWdZTERkdmlaQ3FYUFZyVHpmODI5aDNpdnhqYldpaVZaVkxW?=
 =?utf-8?B?bVVnQm5MR0RZRHA1bkFoQTFTYWU0c01HcnNXNDRlK3RIUjRUL1BXcE1vY3p6?=
 =?utf-8?B?eXc5YTZVb0wwdENVK1VNcjdvUzVMUmNyNnVjMjFIWDE1eHRUelBkczZ5R1pq?=
 =?utf-8?B?WVlta3hXc2NIME5yQnAzejJFa3RJdVAxdjJUNTFTWDZJdTVHZ3B3ckFrbHQ4?=
 =?utf-8?B?WXk3b2s1NXNIQ2djek01RG52ekI3YWErMjlOdW9UNnFucGV6VkdsZDJmZlFj?=
 =?utf-8?B?WWlQTFZlMnVRNWZXSFJEcHY2U3NIS01tM3Y0b3ZOWGowWTRZVll3U2RLektj?=
 =?utf-8?B?YjIzZFR5K0RYVDZxZUNEaU9ERCt6WWE5eTFTMnlUSnZXWHpzOXRia3g2bEpK?=
 =?utf-8?B?TjBuZ2YzUG1lVVNOWlo0QUNrUnBVODB3ZC8zVndVYW1wbnhCOUh5enR6MXNu?=
 =?utf-8?B?cHFVSEFEdjhZajBMK1FlVXVwS0lqN2lCQ1JlbWhYOUJoY2N2NVdGVmxOeEVU?=
 =?utf-8?B?M2l2ZHVYNVpEMGYvRi9pUE42WDdFZGt2NERiSm04MVRhNDlVZDYzSXR4SVBs?=
 =?utf-8?B?UnMvdUhJZzJDQk15dzgvbW42d1ZJdWgrQ0U4SGhsVStXVDM3MTU2UVpvdnV4?=
 =?utf-8?B?TmFTTWJQOC9ZcU5VTzNuem83MUFudEZubEpEaEJKMEpVVlRNS1ZleFBucm5N?=
 =?utf-8?B?ZklWaDlFS1FPK01obkFWQnE2ckJ4angyQ3E4M3UvOVBHdUNTdksxeFJYUmJE?=
 =?utf-8?B?WWRNNjU0L2NYVzRlVUZ3ajNZcmY0SmNlaXpRMUhIaG1PbGR1QkVITUtsOHN4?=
 =?utf-8?B?QUcxYWJHSGZxMXR0NUNUTGhwMVBmbTJ2dkpUOXovK2lmdjZGbzh5SVFZc0ZN?=
 =?utf-8?B?R2Vqek11d1hjRk1aUlRJTElWSmFPUFJXd2Z6QjQwanZRTFU0L0xSUkdCWW9y?=
 =?utf-8?B?UFN0aEtWSnhaeW9kbnQxaU5tQUNqR0J6SzBJc0Fvd2NINVlzY3RFUXVZL29n?=
 =?utf-8?B?WkNZZWlORlhsZHhHYVVCQ0pKaldvK3VIZlVJemlRLzR1QlYyYm10YUt1dWlP?=
 =?utf-8?B?d2dTMXBZMHZlKzhUQm5PN2NJRDFnblFRODlSMjdOSE1YcmI5Q0daR0V5eUNR?=
 =?utf-8?B?by9MY1NkRGxod1NVRmJDRlI0aEpMdjVjN3lUeWtsMHhpUjQxM0ZGUDROMkg2?=
 =?utf-8?B?TEVqMitxNXdFR3ByR0pTRGM3K0gyd2pPQk5aWmRxbUwzR3FNazlpQkZ3UkRV?=
 =?utf-8?B?L1pLMEQ2R2xjQlhNR0RkSVBsVmp4VmJwZkFRUGxpOW12elZpSzhzV1BDa1RX?=
 =?utf-8?B?ajRRRkV1UWJPVHFQQ2xUOXlNcE5ZMFVSVHM3ODRLYURmNC8vTUpROHBXU0dI?=
 =?utf-8?B?b25nMG9wYVZqVHJYZDJENHI4NkI2T0FJdGI1aFJWNWpvK203Nk9hZkl1MWxI?=
 =?utf-8?B?U3ZWN0U1KzMrVG8zLyt5VVdsY1dZeHgrYTBGY3NtOWZMWVlEV0ZhSjlOSVpS?=
 =?utf-8?B?b3hLUkM4UTRKZExJN0Z0aERLV1FPeHJ0OVdiWVJOU2U1M1IwSCs2dkJQcTd0?=
 =?utf-8?B?T3FrdDFDQXRJODNFU3dUT2UxbWRXWFVlVy81M21QcFNQcXdmUUkwNUJYZWw2?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d57042-2ed4-4837-664f-08de1224817a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 11:08:33.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeXHqiVoMM6wyGmxN9odTq79XFyVxiPB9dm5HhGDcOz1hU8eYzbIdvJMUCMAJpgbwZ/G14z7pmzD/dyH2Rl/tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6152
X-OriginatorOrg: intel.com

On 19/10/2025 14:53, hehuan1@eswincomputing.com wrote:
> From: Huan He <hehuan1@eswincomputing.com>
> 
> Add support for the mmc controller in the Eswin EIC7700 with the new
> compatible "eswin,eic7700-dwcmshc". Implement custom sdhci_ops for
> set_clock, reset, set_uhs_signaling, platform_execute_tuning.
> 
> Signed-off-by: Huan He <hehuan1@eswincomputing.com>

Noting that the dt-bindings patch still seems to have issues,
for this patch, anyway:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 502 +++++++++++++++++++++++++++-
>  1 file changed, 491 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd45389956..c8726e6e0905 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -11,6 +11,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> @@ -19,8 +20,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/units.h>
>  
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -39,6 +43,7 @@
>  #define DWCMSHC_CARD_IS_EMMC		BIT(0)
>  #define DWCMSHC_ENHANCED_STROBE		BIT(8)
>  #define DWCMSHC_EMMC_ATCTRL		0x40
> +#define DWCMSHC_AT_STAT			0x44
>  /* Tuning and auto-tuning fields in AT_CTRL_R control register */
>  #define AT_CTRL_AT_EN			BIT(0) /* autotuning is enabled */
>  #define AT_CTRL_CI_SEL			BIT(1) /* interval to drive center phase select */
> @@ -194,6 +199,19 @@
>  #define PHY_DLLDL_CNFG_SLV_INPSEL_MASK	GENMASK(6, 5) /* bits [6:5] */
>  #define PHY_DLLDL_CNFG_SLV_INPSEL	0x3 /* clock source select for slave DL */
>  
> +/* PHY DLL offset setting register */
> +#define PHY_DLL_OFFST_R			(DWC_MSHC_PTR_PHY_R + 0x29)
> +/* DLL LBT setting register */
> +#define PHY_DLLBT_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x2c)
> +/* DLL Status register */
> +#define PHY_DLL_STATUS_R		(DWC_MSHC_PTR_PHY_R + 0x2e)
> +#define DLL_LOCK_STS			BIT(0)/* DLL is locked and ready */
> +/*
> + * Captures the value of DLL's lock error status information. Value is valid
> + * only when LOCK_STS is set.
> + */
> +#define DLL_ERROR_STS			BIT(1)
> +
>  #define FLAG_IO_FIXED_1V8	BIT(0)
>  
>  #define BOUNDARY_OK(addr, len) \
> @@ -206,6 +224,31 @@
>  /* SMC call for BlueField-3 eMMC RST_N */
>  #define BLUEFIELD_SMC_SET_EMMC_RST_N	0x82000007
>  
> +/* Eswin specific Registers */
> +#define EIC7700_CARD_CLK_STABLE		BIT(28)
> +#define EIC7700_INT_BCLK_STABLE		BIT(16)
> +#define EIC7700_INT_ACLK_STABLE		BIT(8)
> +#define EIC7700_INT_TMCLK_STABLE	BIT(0)
> +#define EIC7700_INT_CLK_STABLE		(EIC7700_CARD_CLK_STABLE | \
> +					 EIC7700_INT_ACLK_STABLE | \
> +					 EIC7700_INT_BCLK_STABLE | \
> +					 EIC7700_INT_TMCLK_STABLE)
> +#define EIC7700_HOST_VAL_STABLE		BIT(0)
> +
> +/* strength definition */
> +#define PHYCTRL_DR_33OHM		0xee
> +#define PHYCTRL_DR_40OHM		0xcc
> +#define PHYCTRL_DR_50OHM		0x88
> +#define PHYCTRL_DR_66OHM		0x44
> +#define PHYCTRL_DR_100OHM		0x00
> +
> +#define MAX_PHASE_CODE			0xff
> +#define TUNING_RANGE_THRESHOLD		40
> +#define PHY_CLK_MAX_DELAY_MASK		0x7f
> +#define PHY_DELAY_CODE_MAX		0x7f
> +#define PHY_DELAY_CODE_EMMC		0x17
> +#define PHY_DELAY_CODE_SD		0x55
> +
>  enum dwcmshc_rk_type {
>  	DWCMSHC_RK3568,
>  	DWCMSHC_RK3588,
> @@ -217,6 +260,11 @@ struct rk35xx_priv {
>  	u8 txclk_tapnum;
>  };
>  
> +struct eic7700_priv {
> +	struct reset_control *reset;
> +	unsigned int drive_impedance;
> +};
> +
>  #define DWCMSHC_MAX_OTHER_CLKS 3
>  
>  struct dwcmshc_priv {
> @@ -238,6 +286,17 @@ struct dwcmshc_pltfm_data {
>  	void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>  };
>  
> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> +		ctrl |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
>  static int dwcmshc_get_enable_other_clks(struct device *dev,
>  					 struct dwcmshc_priv *priv,
>  					 int num_clks,
> @@ -1095,6 +1154,411 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
>  					     ARRAY_SIZE(clk_ids), clk_ids);
>  }
>  
> +static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	u16 clk;
> +
> +	host->mmc->actual_clock = clock;
> +
> +	if (clock == 0) {
> +		sdhci_set_clock(host, clock);
> +		return;
> +	}
> +
> +	clk_set_rate(pltfm_host->clk, clock);
> +
> +	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk |= SDHCI_CLOCK_INT_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	dwcmshc_enable_card_clk(host);
> +}
> +
> +static void sdhci_eic7700_config_phy_delay(struct sdhci_host *host, int delay)
> +{
> +	delay &= PHY_CLK_MAX_DELAY_MASK;
> +
> +	/* phy clk delay line config */
> +	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
> +	sdhci_writeb(host, delay, PHY_SDCLKDL_DC_R);
> +	sdhci_writeb(host, 0x0, PHY_SDCLKDL_CNFG_R);
> +}
> +
> +static void sdhci_eic7700_config_phy(struct sdhci_host *host)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	struct eic7700_priv *priv = dwc_priv->priv;
> +	unsigned int val, drv;
> +
> +	drv = FIELD_PREP(PHY_CNFG_PAD_SP_MASK, priv->drive_impedance & 0xF);
> +	drv |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, (priv->drive_impedance >> 4) & 0xF);
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		val = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +		val |= DWCMSHC_CARD_IS_EMMC;
> +		sdhci_writew(host, val, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
> +	}
> +
> +	/* reset phy, config phy's pad */
> +	sdhci_writel(host, drv | ~PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
> +
> +	/* configure phy pads */
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
> +	val |= PHY_PAD_RXSEL_1V8;
> +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> +
> +	/* Clock PAD Setting */
> +	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> +
> +	/* PHY strobe PAD setting (EMMC only) */
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +		val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N_SG2042);
> +		val |= PHY_PAD_RXSEL_1V8;
> +		sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> +	}
> +	usleep_range(2000, 3000);
> +	sdhci_writel(host, drv | PHY_CNFG_RSTN_DEASSERT, PHY_CNFG_R);
> +	sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
> +}
> +
> +static void sdhci_eic7700_reset(struct sdhci_host *host, u8 mask)
> +{
> +	sdhci_reset(host, mask);
> +
> +	/* after reset all, the phy's config will be clear */
> +	if (mask == SDHCI_RESET_ALL)
> +		sdhci_eic7700_config_phy(host);
> +}
> +
> +static int sdhci_eic7700_reset_init(struct device *dev, struct eic7700_priv *priv)
> +{
> +	int ret;
> +
> +	priv->reset = devm_reset_control_array_get_optional_exclusive(dev);
> +	if (IS_ERR(priv->reset)) {
> +		ret = PTR_ERR(priv->reset);
> +		dev_err(dev, "failed to get reset control %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = reset_control_assert(priv->reset);
> +	if (ret) {
> +		dev_err(dev, "Failed to assert reset signals: %d\n", ret);
> +		return ret;
> +	}
> +	usleep_range(2000, 2100);
> +	ret = reset_control_deassert(priv->reset);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert reset signals: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static unsigned int eic7700_convert_drive_impedance_ohm(struct device *dev, unsigned int dr_ohm)
> +{
> +	switch (dr_ohm) {
> +	case 100:
> +		return PHYCTRL_DR_100OHM;
> +	case 66:
> +		return PHYCTRL_DR_66OHM;
> +	case 50:
> +		return PHYCTRL_DR_50OHM;
> +	case 40:
> +		return PHYCTRL_DR_40OHM;
> +	case 33:
> +		return PHYCTRL_DR_33OHM;
> +	}
> +
> +	dev_warn(dev, "Invalid value %u for drive-impedance-ohms.\n", dr_ohm);
> +	return PHYCTRL_DR_50OHM;
> +}
> +
> +static int sdhci_eic7700_delay_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
> +	int delay_min = -1;
> +	int delay_max = -1;
> +	int cmd_error = 0;
> +	int delay = 0;
> +	int i = 0;
> +	int ret;
> +
> +	for (i = 0; i <= PHY_DELAY_CODE_MAX; i++) {
> +		sdhci_eic7700_config_phy_delay(host, i);
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		if (ret) {
> +			host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +			usleep_range(200, 210);
> +			if (delay_min != -1 && delay_max != -1)
> +				break;
> +		} else {
> +			if (delay_min == -1) {
> +				delay_min = i;
> +				continue;
> +			} else {
> +				delay_max = i;
> +				continue;
> +			}
> +		}
> +	}
> +	if (delay_min == -1 && delay_max == -1) {
> +		pr_err("%s: delay code tuning failed!\n", mmc_hostname(host->mmc));
> +		sdhci_eic7700_config_phy_delay(host, dwc_priv->delay_line);
> +		return ret;
> +	}
> +
> +	delay = (delay_min + delay_max) / 2;
> +	sdhci_eic7700_config_phy_delay(host, delay);
> +
> +	return 0;
> +}
> +
> +static int sdhci_eic7700_phase_code_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +	int phase_code = -1;
> +	int code_range = -1;
> +	bool is_sd = false;
> +	int code_min = -1;
> +	int code_max = -1;
> +	int cmd_error = 0;
> +	int ret = 0;
> +	int i = 0;
> +
> +	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> +		is_sd = true;
> +
> +	for (i = 0; i <= MAX_PHASE_CODE; i++) {
> +		/* Centered Phase code */
> +		sdhci_writew(host, i, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +
> +		if (ret) {
> +			/* SD specific range tracking */
> +			if (is_sd && code_min != -1 && code_max != -1) {
> +				if (code_max - code_min > code_range) {
> +					code_range = code_max - code_min;
> +					phase_code = (code_min + code_max) / 2;
> +					if (code_range > TUNING_RANGE_THRESHOLD)
> +						break;
> +				}
> +				code_min = -1;
> +				code_max = -1;
> +			}
> +			/* EMMC breaks after first valid range */
> +			if (!is_sd && code_min != -1 && code_max != -1)
> +				break;
> +		} else {
> +			/* Track valid phase code range */
> +			if (code_min == -1) {
> +				code_min = i;
> +				if (!is_sd)
> +					continue;
> +			}
> +			code_max = i;
> +			if (is_sd && i == MAX_PHASE_CODE) {
> +				if (code_max - code_min > code_range) {
> +					code_range = code_max - code_min;
> +					phase_code = (code_min + code_max) / 2;
> +				}
> +			}
> +		}
> +	}
> +
> +	/* Handle tuning failure case */
> +	if ((is_sd && phase_code == -1) ||
> +	    (!is_sd && code_min == -1 && code_max == -1)) {
> +		pr_err("%s: phase code tuning failed!\n", mmc_hostname(host->mmc));
> +		sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +		return -EIO;
> +	}
> +	if (!is_sd)
> +		phase_code = (code_min + code_max) / 2;
> +
> +	sdhci_writew(host, phase_code, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +
> +	/* SD specific final verification */
> +	if (is_sd) {
> +		ret = mmc_send_tuning(host->mmc, opcode, &cmd_error);
> +		host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +		if (ret) {
> +			pr_err("%s: Final phase code 0x%x verification failed!\n",
> +			       mmc_hostname(host->mmc), phase_code);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_eic7700_executing_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	int ret = 0;
> +	u16 ctrl;
> +	u32 val;
> +
> +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> +
> +	val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +	val |= AT_CTRL_SW_TUNE_EN;
> +	sdhci_writew(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +
> +	sdhci_writew(host, 0, priv->vendor_specific_area1 + DWCMSHC_AT_STAT);
> +	sdhci_writew(host, 0x0, SDHCI_CMD_DATA);
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> +		ret = sdhci_eic7700_delay_tuning(host, opcode);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = sdhci_eic7700_phase_code_tuning(host, opcode);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void sdhci_eic7700_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	u8 status;
> +	u32 val;
> +	int ret;
> +
> +	dwcmshc_set_uhs_signaling(host, timing);
> +
> +	/* here need make dll locked when in hs400 at 200MHz */
> +	if (timing == MMC_TIMING_MMC_HS400 && host->clock == 200000000) {
> +		val = sdhci_readl(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +		val &= ~(FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY));
> +		/* 2-cycle latency */
> +		val |= FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, 0x2);
> +		sdhci_writew(host, val, priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
> +
> +		sdhci_writeb(host, FIELD_PREP(PHY_DLL_CNFG1_SLVDLY_MASK, PHY_DLL_CNFG1_SLVDLY) |
> +			     0x3, PHY_DLL_CNFG1_R);/* DLL wait cycle input */
> +		/* DLL jump step input */
> +		sdhci_writeb(host, 0x02, PHY_DLL_CNFG2_R);
> +		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
> +					      PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);
> +		/* Sets the value of DLL's offset input */
> +		sdhci_writeb(host, 0x00, PHY_DLL_OFFST_R);
> +		/*
> +		 * Sets the value of DLL's olbt loadval input. Controls the Ibt
> +		 * timer's timeout value at which DLL runs a revalidation cycle.
> +		 */
> +		sdhci_writew(host, 0xffff, PHY_DLLBT_CNFG_R);
> +		sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +		usleep_range(100, 110);
> +
> +		ret = read_poll_timeout(sdhci_readb, status, status & DLL_LOCK_STS, 100, 1000000,
> +					false, host, PHY_DLL_STATUS_R);
> +		if (ret) {
> +			pr_err("%s: DLL lock timeout! status: 0x%x\n",
> +			       mmc_hostname(host->mmc), status);
> +			return;
> +		}
> +
> +		status = sdhci_readb(host, PHY_DLL_STATUS_R);
> +		if (status & DLL_ERROR_STS) {
> +			pr_err("%s: DLL lock failed!err_status:0x%x\n",
> +			       mmc_hostname(host->mmc), status);
> +		}
> +	}
> +}
> +
> +static void sdhci_eic7700_set_uhs_wrapper(struct sdhci_host *host, unsigned int timing)
> +{
> +	u32 sd_caps = MMC_CAP2_NO_MMC | MMC_CAP2_NO_SDIO;
> +
> +	if ((host->mmc->caps2 & sd_caps) == sd_caps)
> +		sdhci_set_uhs_signaling(host, timing);
> +	else
> +		sdhci_eic7700_set_uhs_signaling(host, timing);
> +}
> +
> +static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> +{
> +	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> +	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
> +	struct of_phandle_args args;
> +	struct eic7700_priv *priv;
> +	struct regmap *hsp_regmap;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct eic7700_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	dwc_priv->priv = priv;
> +
> +	ret = sdhci_eic7700_reset_init(dev, dwc_priv->priv);
> +	if (ret) {
> +		dev_err(dev, "failed to reset\n");
> +		return ret;
> +	}
> +
> +	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
> +	if (ret) {
> +		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	hsp_regmap = syscon_node_to_regmap(args.np);
> +	if (IS_ERR(hsp_regmap)) {
> +		dev_err(dev, "Failed to get regmap for 'eswin,hsp-sp-csr'\n");
> +		of_node_put(args.np);
> +		return PTR_ERR(hsp_regmap);
> +	}
> +	hsp_int_status = args.args[0];
> +	hsp_pwr_ctrl = args.args[1];
> +	of_node_put(args.np);
> +	/*
> +	 * Assert clock stability: write EIC7700_INT_CLK_STABLE to hsp_int_status.
> +	 * This signals to the eMMC controller that platform clocks (card, ACLK,
> +	 * BCLK, TMCLK) are enabled and stable.
> +	 */
> +	regmap_write(hsp_regmap, hsp_int_status, EIC7700_INT_CLK_STABLE);
> +	/*
> +	 * Assert voltage stability: write EIC7700_HOST_VAL_STABLE to hsp_pwr_ctrl.
> +	 * This signals that VDD is stable and permits transition to high-speed
> +	 * modes (e.g., UHS-I).
> +	 */
> +	regmap_write(hsp_regmap, hsp_pwr_ctrl, EIC7700_HOST_VAL_STABLE);
> +
> +	if ((host->mmc->caps2 & emmc_caps) == emmc_caps)
> +		dwc_priv->delay_line = PHY_DELAY_CODE_EMMC;
> +	else
> +		dwc_priv->delay_line = PHY_DELAY_CODE_SD;
> +
> +	if (!of_property_read_u32(dev->of_node, "eswin,drive-impedance-ohms", &val))
> +		priv->drive_impedance = eic7700_convert_drive_impedance_ohm(dev, val);
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  	.set_clock		= sdhci_set_clock,
>  	.set_bus_width		= sdhci_set_bus_width,
> @@ -1169,6 +1633,18 @@ static const struct sdhci_ops sdhci_dwcmshc_sg2042_ops = {
>  	.platform_execute_tuning = th1520_execute_tuning,
>  };
>  
> +static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
> +	.set_clock = sdhci_eic7700_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_eic7700_reset,
> +	.set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
> +	.set_power = sdhci_set_power_and_bus_voltage,
> +	.irq = dwcmshc_cqe_irq_handler,
> +	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
> +};
> +
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
>  	.pdata = {
>  		.ops = &sdhci_dwcmshc_ops,
> @@ -1238,6 +1714,17 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_sg2042_pdata = {
>  	.init = sg2042_init,
>  };
>  
> +static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
> +	.pdata = {
> +		.ops = &sdhci_dwcmshc_eic7700_ops,
> +		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +			  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	},
> +	.init = eic7700_init,
> +};
> +
>  static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
>  	.enable		= dwcmshc_sdhci_cqe_enable,
>  	.disable	= sdhci_cqe_disable,
> @@ -1338,6 +1825,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>  		.compatible = "sophgo,sg2042-dwcmshc",
>  		.data = &sdhci_dwcmshc_sg2042_pdata,
>  	},
> +	{
> +		.compatible = "eswin,eic7700-dwcmshc",
> +		.data = &sdhci_dwcmshc_eic7700_pdata,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
> @@ -1570,17 +2061,6 @@ static int dwcmshc_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> -{
> -	u16 ctrl;
> -
> -	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> -	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> -		ctrl |= SDHCI_CLOCK_CARD_EN;
> -		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> -	}
> -}
> -
>  static int dwcmshc_runtime_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);

