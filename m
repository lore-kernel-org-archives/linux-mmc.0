Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758434F486;
	Tue, 17 Mar 2026 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747148; cv=fail; b=CpABuxMha/2fZt6ws9uibz1JAuupGiV6P9vpaIhBQGoYfiRi1ZsXxxvZrW5EEBCrtIktoMabi184tb18QToNSxFomBdi1jQwd4S2/U89vjToAOtJ3++32s1kOUTbybCfxZ0EByQ2Acti8QkI3uvEbf1slcEgHG9qLXW0XCNUXZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747148; c=relaxed/simple;
	bh=EzxDz84Q5/Tx9bw751VUtI63+k1KCVDLM54vClSXLDA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lZ4EwEfM3823Z2QOhOCUQHV4VuEAjcIqKmB21UwT+Qj4uEH3gRwLVJu/IfzJ788oZtr1oP4hjkHaTqH5A16oP5C7BWT4dcALV5dl+NFBGPuLPCnESQAtieL7Hv60/e3MyjslTyMr32WOyFt/FQj4jO7x15Fq9N0P0QmiNub5URc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzl9CL8k; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzl9CL8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773747147; x=1805283147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EzxDz84Q5/Tx9bw751VUtI63+k1KCVDLM54vClSXLDA=;
  b=kzl9CL8kVtL1N1dSbL91o0oZjXvTRVIk+4UfhrwSUI3cMh22VQe9yaoW
   EEyY2lugJSUFviFC+juN7Be8LwjnoOl12UDQvjGRMaKLlkDF4rSDc6EnY
   V+P6pCMp4nt1mYb5GilmbFwcvtV+OUh9nocPwEYNS6UfV4ZV4NcPO5tiu
   8QjzSAhD7SguGp2pfGpSDMaBTmTT7SzhBa+nIVJuLpOcVX4qpu6iDdNOc
   xDJH4tyBhmIaOBVWKJMezk0oGk/b3NS//UUBRcPRtF8NDAe+4pxRpXtn9
   cQcLY1b3Xs5Dgi+n8dEjI/1oauJq1EawJ3JCn4Wny8VEUXryp7/yPlIK6
   w==;
X-CSE-ConnectionGUID: 6nmTOBjpT/yXbTIuXZ+VbA==
X-CSE-MsgGUID: 3tU4seyQSVG3Uh6VX8jFIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="100232388"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="100232388"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:32:26 -0700
X-CSE-ConnectionGUID: 4KM8h3bzRwuzQu03BSWFPQ==
X-CSE-MsgGUID: 6PgockPRRS2NcS1qOxjUbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="245253872"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 04:32:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:32:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 04:32:25 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 04:32:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeJMl6KsmJWSySp7Je6JhGecAKOtgaqa5pz//JrDm5CArf96R2lECl8sLX+Pba2EikgZTpjbW06Pd/4oe0TKpU+JItA/Lzx2BdkkQrfFAP/agu1W9tgoHp/KZrTPbvT7m0COlDfUqOOFobPOlAoApl4Q6ZvrjzZZkhToZhz0wVeKhhfIvXJIlVqmmKhrJ4DsCLjnjOJu0aB7zCesl0sx1IXOqclAJSy9Ps8v9xlTRaKNWu/KxH2UuidxGUtVnnpRbUUrP33Ual1W7lcV10Ml0PrxZ55rpVuihepMi5lYUM6V0cOnXOdVTPM2zKRI8m5Bunv3P7L7dzRq1JuNBcPJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2SdNzViMwjY6yAG/yKgICSzCKygfo1OKyYO/A67XdY=;
 b=kDQpzZat4rkBvs+4oItu7q5ItUgSV/yRgkKYP4+k+rd/UET+/5JhM5ndViN8hXGqfFxolZXEcI/2N162H/1u2F93/+E6UEkHZw2quQgQExXDV9yUNVQbOsjIYe+004glpVqqDSVuV4qcRPp+xTdhHKhD+MURqzxegy9PcyA3xmMy7xAwog5bVLx9JDPvwvAuq6y8mh9fHWISOHfh706EndD2N6pWkiwliFQ+L/T5HiXztlAd46gCP1KS/PW9zZc19IQ2BB3F+ETMtTr5Lmv93svdmwuEYc9Un9TfHGEG/UUiAp2UV6L6L8c6lVKEdovcoGjBrdO16Xr0SQuOlc+20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by IA3PR11MB9160.namprd11.prod.outlook.com (2603:10b6:208:57a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 11:32:23 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 11:32:23 +0000
Message-ID: <5750cb4d-af37-43fb-a439-7275576d1636@intel.com>
Date: Tue, 17 Mar 2026 13:32:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan
	<dlan@kernel.org>
CC: Michael Opdenacker <michael.opdenacker@rootcommit.com>, "Javier Martinez
 Canillas" <javierm@redhat.com>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<spacemit@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Anand Moon
	<linux.amoon@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-1-aefd3b7832df@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-1-aefd3b7832df@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P194CA0004.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:10:553::35) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|IA3PR11MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: b543c194-ae8a-42ed-8387-08de8418db0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wLU6o6jr8qoaPMzkZe/sIonz5Z5sn9sPTIDZ9zcfMKslv5UDCav219MFbbKwiafwXL0hykSA5Ujoe5wgJeD6lHzWDqlzaLjK3mCOvnPyIwrVSofLg49uxsuGcXj7xM7zAsnu4nd7mqBfdZcLh8i5twEf6wGAUk1l5HfECUynqelUMNfbi8TD7ZAEU1OxsmhnipDvwgM0KaM/Z8iwvYRh2NIj52yZ+3XRqUVR0q7EV3YSst5I+LwoxEyS/694a4m/wJW4oMIsqRbEidwxQMASrx5Zu7wSn6SttNjRqSpQwmIpHrTqe6svumcJlJp42SSSYAxDU9+k4EsZj9N0PDIzRZSPdyQa2zR93nvU2TTxtzlEGQeJCwP2HtDdjyo847ohEN7pNQBh94+Jra59q58j92LeFAzC1rmwiQkku7OImZHKkhG88rvDNJJ9Fj9fORSPq1hee2YRpgAMDkuVtDKR+XyoGKv89qPdceBF55xMJLDe5kje2bph+lTxDfZmB4xvMz+GfXCyFKHanZ0sYn04EVG6hRfyYvJma4ZMeMJcGhCGIRFSF/qwYme5HVgDhSbe+NYn/UEZPcfWDOIVHJLwtfj8Ayymdm6X7OGqjFWJWnYs4rEkaq/1kdUi7fkUWcn/MdPEYd+sge/B+bgUFst+pay0rDuMpwJNvpn/IR0AFeaQvvLgDHy/g/xujARcxdApqeLthlWcBMB62wMgb+0+18Zwk2GC8kzm8o5nWd4810p6FcCG8WTkM49jWqO8qItk6VP3rMrUO0KoW7qGNyQfvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZ2T24wK0JUNEgvbVZwbUF1c1g0RmpaOXpaVVNKVzEzUDBUekZHako5TXNr?=
 =?utf-8?B?UUxQSDBGZVB4NkpVSUtrVlo1SkJCdXZVYWFWOVp2WldEeGhKQktHS0NSeEJ2?=
 =?utf-8?B?Mzd3dk1LeUdqUUQxdHA2WXpsbzNvcnRvYXhPTlRoUzFLMEJ0YWN0MkQ3Y1Jy?=
 =?utf-8?B?a0FXeEV6a3VoTTZrNGtCM3JFc0NNZ1NaM0hYVlFSWHplMDd0STZtQksxWGdR?=
 =?utf-8?B?MlNJdE95eWFkSXo3WWhneHlwTnlsRGx3NWpBN256N1JXZU5OMnhHb1FEQkhp?=
 =?utf-8?B?L2J4OGpSMnR6aTF3WWdWYjJzcHRuK3A1OGVBdldTaHlEKysyd1BTV0c5RVV3?=
 =?utf-8?B?UURiRTJENDVVV0R2NmJIdmF5ZHk0cVlxQ3NOdUl3YVR0aVFVRUJ5bnZWdTdl?=
 =?utf-8?B?ZWkzY3NyL2dhWVRnZ1BPMkl6aGtFaWRqNXJEOFZhZm9GQjNrVzhtcXloU202?=
 =?utf-8?B?V0FOaEFaKzNDenprbTdjc20zTFRqeXJPNkk1OWZWMS8yUERVQVhJTGxZR2tJ?=
 =?utf-8?B?WGJTbGx0WE5IcnJLcndCS0l5Z0Jyd2R3SEphTkFMQWxIMnVwaDdjV2JTOHhR?=
 =?utf-8?B?V0syYzRCRW5TaHFVSlVOUmJrbVF3SG02R2pCaDZGS005eWhrcFZJbEVkVFFw?=
 =?utf-8?B?NithWU9YLzVSRzZTd2g1KzVxTDdLdFE4eGVXMGJYNWRMemUwWm5Jbnd5TVdL?=
 =?utf-8?B?U1ZTWjBEOFl6Vis5eCsyU3Z6RXJTblcwZG8yTkpOWmRaZTJuWkFzeWNaQlVQ?=
 =?utf-8?B?U0xiL3ExTi9JS29mNzJQNTh0b21JbVFSQUpuQ0x2UGlXYTYwcjBGUFBDK0dO?=
 =?utf-8?B?SmErN2I3Q0VYWVBPUHgxY0hsQWpiK2U4bWk0Ti8wcGNxdVNBYS9lcmswd2RQ?=
 =?utf-8?B?VEU5Q2xxRGRtS3duampVMENOaCszK0tRS3VZcDdHdnJMa2dKQmd5eDBwNUVQ?=
 =?utf-8?B?SkdJVlZaN21FTXFJclpJbDY3RmE0UUY2VTZqcmNqZm8wQXIwWGMxQ25OSHJY?=
 =?utf-8?B?cUlVVHROQjVQQWFNRHhjMFU3eHdzeEQwSkZ5V0J5N2MwYWxLVm1LVXFNMVRN?=
 =?utf-8?B?SmJRbEFSTGl0UGtWd2hDd0xTbnNIbXBJbDJtaXdMZk9adWZFeDRmVjJiYWZU?=
 =?utf-8?B?dmZJS2dPeXVPMUNXM0U0WXZaV2FOSm10cTFuMEJQQXVzWkYvcmVoL2V1NUpD?=
 =?utf-8?B?b29oUHo4QUYwTm4zUzF1OEpGbFRkdWFoMWdlRVJGODlZSFdpbUZiVytjWjZr?=
 =?utf-8?B?ODhMakNzR3VqamtxT1d5YTZSZDF2MWJKQWdhVG5Qak5yK1dIbllUY1pUODFz?=
 =?utf-8?B?d3NDNGZwTm9JMG5yamcrbStPSG5PTmZ3bkdscXVxakpLdXg5eHB3WGNobHBT?=
 =?utf-8?B?Vk00YXIzVkZFS281eEpWM0I1Ly9UL3A2R1FLQktzVytXWHJuVE1JL0FzeHg1?=
 =?utf-8?B?MVNFemtmZXRTZzZTSkxvRzd0VXVDelFDSnNrZnJZdjJmK1pkTWVSQk1jRytx?=
 =?utf-8?B?U09rV2c0UTUydjYrcFBvd0lPOFB4S0Z5aHNmZUY3SVllQUJoZkpPWUhoZFZj?=
 =?utf-8?B?SitLRURXaUxmcmptYjcwaWxCSXQzUW1XUlJLR1p4dmRiZEtRS2lYa3d2OEt6?=
 =?utf-8?B?eEdrRUpQQy9sbDE4WmJMNGtNZ3JwWEdXTXMxbzB1aldhM3ZadE5leE5oUnk4?=
 =?utf-8?B?cW1KRWt5aTBzOEpuZkRKcCtERERmVk1MNGNhdjRseEN6L1ZLaWRTQ3pJdWNJ?=
 =?utf-8?B?Y3l6RklkUW9iTmhkTzFRSCtyZ0lMbkMwYjlFaDhlVTJpMEJOR0FwcFZ3cWVN?=
 =?utf-8?B?Sm1QaHQvWWJVcU1MUFhNVnB2YzlmdVpNditxOGRqRjEwTnVvT0tCSFExOVlF?=
 =?utf-8?B?OGlhRjhZdXpKclNlQ1hWOUJIV3haL096aXhsUUQ0YmVRTWdWQ05yZDNxT3Er?=
 =?utf-8?B?TmFuRWZLVHBDRE1aWVZzbXpjUzVtU0F1Tkx2dTdEQ2N5cVA5TlRsWXdWdDVz?=
 =?utf-8?B?ekRnN2pJcENhRmtBSnZjdW42Q1JlYmZrcEU2WjRrUk9WM0t2Sy9qQjBQMFJF?=
 =?utf-8?B?bGpVNW8xSXZIbUtzRHYzOWJKVE9jUTdLTys5TUpUS2pxUE5TS0ZaUVRNZW02?=
 =?utf-8?B?TSthdVFyTjdLaTRHQWRQME9MT2k4Rzk3Uitaa1JER0hQMmprclR5STg2Q0hE?=
 =?utf-8?B?bkZQTmFrMmtmNDYxZytYd2dpUmtFT21jbTV1ZmpIZFZ5Z3V2UCthYklqcVRz?=
 =?utf-8?B?UDZUYVo0ZVEwLzVRTnZDK3g5K0RIRENVZ3gySG91OU5JWEF1VWtTTmpWSmEz?=
 =?utf-8?B?STh2V25odllIaTFPUUVZYjRHZUdHS2p0RURFTExmOTFoNHEzN3ZvQ2wzUm96?=
 =?utf-8?Q?ebK/tNfGco1fp0UE=3D?=
X-Exchange-RoutingPolicyChecked: q467b/UovQdSSPB3A/jnvc3xpT0IT1JLSkMglbXziSKp2umHnqHYD/BeUg3sUCK55CqONvfoj/6Bn0BWcM6Y69SdGkRJZlIFECBm3DDwKs8ifKzHo1g7KkipGawVe+TyfqH4El6jQHZaBhSimX4w7vow7hYPHvcKUzvVfwYjWjSlGi1QLTfSlYvIx/Zc3SEL7HqRIvPPm52IT0/Hn2kkckQ5kQMAaPAzbs7Vb4k50vuivd4uUovQcXlE2sLnn29hCZmVenvxXVyhCIKzEr2O/VKH/IbPXEalPxYazps7B0XdVq09C4K6Y6KxKvjd/1BaGP1CnpLOswipYJbUnbm0hA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b543c194-ae8a-42ed-8387-08de8418db0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:32:22.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQGDn8OSKoyowZC/zls9KfnQc3lxhz6CuhMIGsi3aTNihtGiy8bGiPkwHd78JnZd3cLVVBDQ9r5V5BCPGjpOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9160
X-OriginatorOrg: intel.com

On 16/03/2026 16:03, Iker Pedrosa wrote:
> Ensure SD card pins receive clock signals by enabling pad clock
> generation and overriding automatic clock gating. Required for all SD
> operation modes.
> 
> The SDHC_GEN_PAD_CLK_ON setting in LEGACY_CTRL_REG is safe for both SD
> and eMMC operation as both protocols use the same physical MMC interface
> pins and require proper clock signal generation at the hardware level
> for signal integrity and timing.
> 
> Additional SD-specific clock overrides (SDHC_OVRRD_CLK_OEN and
> SDHC_FORCE_CLK_ON) are conditionally applied only for SD-only
> controllers to handle removable card scenarios.
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-k1.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 455656f9842df90c7a94a290aeec22157b378fc1..0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -21,6 +21,13 @@
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
>  
> +#define SPACEMIT_SDHC_OP_EXT_REG	0x108
> +#define  SDHC_OVRRD_CLK_OEN		BIT(11)
> +#define  SDHC_FORCE_CLK_ON		BIT(12)
> +
> +#define SPACEMIT_SDHC_LEGACY_CTRL_REG	0x10C
> +#define  SDHC_GEN_PAD_CLK_ON		BIT(6)
> +
>  #define SPACEMIT_SDHC_MMC_CTRL_REG	0x114
>  #define  SDHC_MISC_INT_EN		BIT(1)
>  #define  SDHC_MISC_INT			BIT(2)
> @@ -101,6 +108,12 @@ static void spacemit_sdhci_reset(struct sdhci_host *host, u8 mask)
>  
>  	if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
>  		spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT_SDHC_MMC_CTRL_REG);
> +
> +	spacemit_sdhci_setbits(host, SDHC_GEN_PAD_CLK_ON, SPACEMIT_SDHC_LEGACY_CTRL_REG);
> +
> +	if (host->mmc->caps2 & MMC_CAP2_NO_MMC)
> +		spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON,
> +				       SPACEMIT_SDHC_OP_EXT_REG);
>  }
>  
>  static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
> 

