Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED32F531F
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765518; cv=fail; b=hswyBFLGkIfb/PU3k6kgnj1CRWhHGkKjxENSZVULTM40S/eaHXqJPjQZcJSv3b3jQ7pZhpSuxO+G43n4uYoJuUbu1iLpeeS3JX0zFQSkYgi9FfIhYoMFuLz1uIIzghppXpIG/sceBr/ukyOOub/TAOl9QDZ5rjYrJWeEmd3TqJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765518; c=relaxed/simple;
	bh=+ZGlsuFWuYD+qA0ToOGdlqpo1bWhuV+HOjGBoXyAuHA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dw8ojx25DTQaiNNFNqdOg9A1AI/OgTMdF1/goC7+BGCrUDy3J8xuF3Tdda8X8mYFqr1IxrEAnB4XnMhjibbumQs3GT2gN/NTryntr0NTm+rs2q8eLa0o6GS6IgppZ3z8LuRCB4XcLJkK2Vvmo7duRMoYLgyRMAvbQfcs6pNZx5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKUtJBq4; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKUtJBq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762765517; x=1794301517;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+ZGlsuFWuYD+qA0ToOGdlqpo1bWhuV+HOjGBoXyAuHA=;
  b=nKUtJBq4OK9eLzPKR2p4mixgIfZ9BnWoCrJbmsWiONzjbeDsQEJai5rF
   kVwEx4KHADXbJVyk8bl+tyjdQw5nWo47nxIZwC70PEhFR309m0Nh+5Qpl
   GdRXZL140PC0YkswtIl+xzM435y1Ai7dU6k3UyV4YwKw1Zq/Hzk4fwltb
   O/240kbGIAAnlBo0bvpG8eO+/VJT1cMkA7w7qKvJpfIQhXePOsEewFDFQ
   AmdzxRlHme37ckRV6o4bBwJ9pG8HQ7drhZvdwEQFF4O/jh1WOwTmDhFPy
   NYaw079uRhJFszjBG0dIJ+WMsni+KhvZ7tBRFWlwandZiL7gAk/P/S2rx
   Q==;
X-CSE-ConnectionGUID: YQvZf0ntSmm1jLhMuDNA5A==
X-CSE-MsgGUID: 70pe0o9jTWWTg92eWpnF1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="68659129"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="68659129"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 01:05:17 -0800
X-CSE-ConnectionGUID: rNCzv2YiTwuXtzgGk8rHtQ==
X-CSE-MsgGUID: qSUu5+izRSq2EI7HuYTXlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188460670"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 01:05:16 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 01:05:16 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 01:05:16 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 01:05:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsZ6riTuLMq1PTkcH0HP7NWXgdEUZvovtBH2ElIPZhYbOX21aIJA1rfTsI15pFcoSf4ilfG0mLVXBF76AAwok0JdHnIu68ZY0C3MxlxztpDb03ewDV93MnrMZkwsnrfhd2ZLiPa96bdZDzyy3hFlJ0iPvp6VhKpM6c5NSezL/t3gghkdpi1HuSO/fT0CljTrMqZPc/KE4ZWOO6WTEueKjyfSZq6EA80Y4JBQL4nUIhC96uSj3CaTDfECe+C5kG5ZKeoqgG4g7WlX0ta6tBpTulDYRYrWqk2zK67VGIzGAzweMmLkDgFwP9QZ6qgU/zNF0O7N420HlbofSWl6jvKLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBtjvRlGnsBotMWxQbNLOWwD29MXddERp1o4pQr8XXE=;
 b=pminEUSVrvfWFLDFK0dChxnuNDotjyGYDg8zPEZGRupQ4uRqj8syQtTjdrTaqtKFAy9Mk1DR8YvJ1iBvQDwq9pmcUJLnFWPsLP4toYCC47SDXoU2lCDCXvbn69sCsy0gqH/n2s1SnqhMIFGBju3vZv8o5NU3toKOYkSR6V6L406RE2sT0tzWYARqK7gJADS1Bh+QAxesV27Rg/lInnutX5MMzALfN+rNQtHCVMdQn7OUPsxHhaV1WsxLoSCDJOewZ8SWwc6Omf9dDNrkCygQiT3ZGccBX3A4ldzmf31BXYEvFb/Xhsq295s9CY4IUhK2fcSY/DmgKTV03UdQVswuoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by PH8PR11MB6802.namprd11.prod.outlook.com (2603:10b6:510:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:04:55 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 09:04:55 +0000
Message-ID: <f8c83229-b45e-4b62-a67f-c44d703a563d@intel.com>
Date: Mon, 10 Nov 2025 11:04:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SDHCI generic controller in Linux
To: Steffen Pervold <spersvold@gmail.com>
CC: <linux-mmc@vger.kernel.org>
References: <CAGw3uGD=jqdppGzQ9k8K6qu1znpWMrgMdcxYvtEXWi2Qwn01uw@mail.gmail.com>
 <dd3be1f2-02fd-40ef-8f52-ff5dbea3da90@intel.com>
 <CAGw3uGBwz3dwuxpmgUHpwk0OD6-mhiJeYQU20N3hmkOwVC_XUw@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <CAGw3uGBwz3dwuxpmgUHpwk0OD6-mhiJeYQU20N3hmkOwVC_XUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR06CA0002.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::7) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|PH8PR11MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8c4e6f-8629-4cd7-6e51-08de20383777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXlRUFRBTzZ2RTRsNUxlcks3OFRoc1ZLVXpTSHdoOS95dW9aS0tjUDFORGNF?=
 =?utf-8?B?VE81UGh3alZROGg4d1M0RmJEN0RwaHVyd1hHakJyamF2T3EyWVlnWnV2WEZi?=
 =?utf-8?B?VHhEMzZYdGcrUEdmQVQ3NVlMR3Jtcm5VUmdJQytQQ29ucDFpS0tGOUFwcWpi?=
 =?utf-8?B?a2Y3WHE5VU9JUXpzeENic0lVQW9vZlFvMG02U3MyamNhTXlXSTVreWdKcWtS?=
 =?utf-8?B?Mk1BellLbTVaUUlnRlQzbDhMWEh6cSs3ZkorMmxYZlZLVHlZMDZ3TWRSODV1?=
 =?utf-8?B?dmpKUDhBRWRvN1NUYXp6eFpkVHJtbER0RUNCcHNadUdXenBjSUFYR3Fzd3ov?=
 =?utf-8?B?dDk1cWN5SjErUGF0K094NkhNdzArbmU0eldxVnJadFRaNk55SGx4Vi9reEhN?=
 =?utf-8?B?N3B0aTlHZmpSNEpVZFFNNFVEY0g5aEFpdWJzcExOZDNUYndGeUJuMVQzWTNP?=
 =?utf-8?B?REdzUmh5enlXQnZQZ0xWeGw5RmNoUytwZURBcEFkdzQ0VS9ZYXZaWDZPTDVR?=
 =?utf-8?B?V0p2RmxnVDNobVcrRzA1cUFvZllTVVp4QW1peElqNFdNVFBpaEFuMGlQa2NG?=
 =?utf-8?B?b2xyY1Nnb1d6SkhEUlNsTWpLYTZ5WnFSbVdNVkErVzJMUXRLK0didERNd1Uz?=
 =?utf-8?B?VWh6VWlsTlFCa1pTZk9zRWVUS200UkhOdm9jcDM4U2RqNDZoaFhZdW1YbXlx?=
 =?utf-8?B?Ujl2elBTYUN3VXB3dW12UVRFRVBXanJCdklmSkV4L1FkZTgrdGtaL2p5bjZN?=
 =?utf-8?B?ckRybzFUZHhKZ2pvcjZnSG5IZDE4SzlYTkpQV01nSlJDMTVzeTZ1S21waTFC?=
 =?utf-8?B?c0djcEhRLzB1OWxIMUVZUGdJcnhDa0hBTzRBbjZxZGNlMENQbkRtVXFkNzNB?=
 =?utf-8?B?eG1zOG9vU3JBTUdLdGVEMzlDN1ZBRGZ0V0hjUHB2bTlTQVoxbis0WlNTSStv?=
 =?utf-8?B?YkxNdkVTbkVNcUxSTjVPbjVuWlgzKzVFUlh3NE1rNy9FWHpmV0NkMXoxbXhY?=
 =?utf-8?B?SU82bFRva3dhKzFRbW1QaDROYytFTUxpQlFYL0J3MGlaUENHTHdiQitDMTQ5?=
 =?utf-8?B?S3liV013ZXIyNW12ZWFZaDdyZW1wMFZ4Q1lwdE8wU1JXSGIxbzdXU0JqbEF4?=
 =?utf-8?B?Y0JhQ3pkQUl6Y2Q3ZlRNYVpuRkNHbWlhVnlQbk9MSU5iTkc5QXcxend6eEV2?=
 =?utf-8?B?UDczZ0dGNUtFQWFiVXFtS3QwWFlsMlJzNXV6ekE4a0dtSitjeTN4c1dPZjJO?=
 =?utf-8?B?ZGlSOUtxRFBsU0d2ajNjT3dJcjdYZlRUOU1GTC9vYS9seXcwbmU4OURJdnhP?=
 =?utf-8?B?c1RJa2IxU3ZRbkdaNXFxbEk4S1VaMTR2MFdtZXk5V0FDd250Wm9tSnE4VUtz?=
 =?utf-8?B?cHFZY2pFL2NiWXd5eTFGNzFrMnN0Z2lwSWdHK1QwN3l1eEYvc3RnSnV5eVFI?=
 =?utf-8?B?Y0pXNGpDeThVMTZiMGg4OG9nZ3lCUnowTU5lbW5MY043OGJyWGw2WkY4T3Jr?=
 =?utf-8?B?aWkxWTJIejdLYjdoOGUxSE95dmk0c1Z3cGFEZThkbU84Y0d0T1VrNXNtMkRp?=
 =?utf-8?B?MjFsK1NrNy9EZnZDdzZ3K05kb1VINkhkbFFoU1dtMTFSYnpJa1VhUmlYRDJP?=
 =?utf-8?B?em40VmhlYUhBZlQ0Qm1tdGwwc3dLdnRFZUtXMGdHVVhzT0R3cHRIK0FYZmh6?=
 =?utf-8?B?cFJlQm85eVRHMUI4MGxrU0RLVENhdGZMcllKSnh0YzUrZXVZcWl3SzdZZWRL?=
 =?utf-8?B?Mk05a3FXNEdZNDRFcHFFclNhWU5vVXVoK2hZdURjMGpNUjNsRWNWTm1nK1Fk?=
 =?utf-8?B?bVpqc2gzY3ZOaTJBUUdxVGdqb1FkZDZ1Y1puUlcwNGNrcnFHWXc1UlFtYlFx?=
 =?utf-8?B?ZVFXVWM1SEQ4bStRbWplRTNyY2Z2V09MZ1hxTmptWUZ3VXV3VGcvRjNPMld3?=
 =?utf-8?B?M0hIdEdsWDFOdEdYcUR5MTJDVDBBaXdWWDVaTVU2UjgyVG43SlF1aW1uTlFv?=
 =?utf-8?B?YmpBK01yYmZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWNwdXlZNUZ1Q29wRE5VRmdYQm9Hcmc0ZkpqNU9iOThxckFxL01QZjBmZFJj?=
 =?utf-8?B?ZmZ0RElFRGk0K3JJWDlwQW1BQlV4TTlYb2NPRzZKTjF5Wncwdm5XRDlQYVg2?=
 =?utf-8?B?bEw1ZmVxbkdRcVFEbUZHcVpzcDJDcUc2ZjJPOXhCRERiTXVYVzZ6NW5XbzR2?=
 =?utf-8?B?Q1VPU2pnOVNKbUp0enRQZjBuWjQxZFFVdndDejA0M0V6R202cnJDN3dPczlN?=
 =?utf-8?B?UG0zb3Ntd3VCaC9DT05mcWNsRGsrWENtZFd5TnhFSk5oZlNwL3BPMk50SnYr?=
 =?utf-8?B?WnlNUVliYm5TNGdDUUhraUlKRzM5REdXSER0WWIzS2VKVXhmV0JkWmRHMEcv?=
 =?utf-8?B?blMyc28ybWtlVHVmcHZxMzk0UlNOU2hQYUVmNmdwZkJNLzZhdzBCVHBsczNR?=
 =?utf-8?B?eVJEZ3pWVWk2Vnk3eDV1NW9OL1pKUFh4ckNkZjlUU3ZKbUhyN2djZ3pUMkUz?=
 =?utf-8?B?TDIrNlM2bm9UODhGZkt0cktrRE1OOVVXcFZ0OE4xVVdNY1A4SFJONGNKUVkz?=
 =?utf-8?B?SEdPWk5wWityQTR1bkFvM0g2aDB2azByQURTVmd0U0l2blNDdDEwZ0Uva3ND?=
 =?utf-8?B?UDlDbU10TmhhVmxoVFc1b0xaVzBydFBrbXJWb0tWT0c1ZWlsOVRkU05zZkVP?=
 =?utf-8?B?NFQ5V08rTWZNbng2TW01Z2xad0poYk8rRU1Zdlhqczc3c3Z3eVBUQ0xRWFZJ?=
 =?utf-8?B?a0diTDZsRWpRLy9mNCs4aVFvQ1A2V3orTm0vZUQvdVJHVTJPaDZjMzhycGwy?=
 =?utf-8?B?eGF4STFnWkxxb1VsTngwUWZoQUVxUXArZ1U5a3VES2M3MkdUZ01hOXFHeHht?=
 =?utf-8?B?YXNZek15bEdTQjkyZUZkTTdmcnRidGQvY2kyS0luVktVazhrSytETk1rT2g5?=
 =?utf-8?B?VUtzMHpnRlp0eGdGM0xIdG1GaFdwN2I3ZEZQSFBFNUxEQkpmZDVKcFE4Q0JM?=
 =?utf-8?B?c3NENFJaWEVtZWFlNzRkTjVIa0JCdDN1d0tzZmpVRVl1SUdiRFNtaVc2VGhU?=
 =?utf-8?B?RFFhL3BlckR0UmZUSm1TQ0kwTFdJaGE4M3VUbVFGYnBmbnI1THRJa1JMOFFs?=
 =?utf-8?B?RmNpYlJjRUJFRnJBR2dWd3JnU1d6bGVjNG5kZm16Y1UzSEQ3bkNSbjg1WUMw?=
 =?utf-8?B?N2RxTko1V01Ra21tL3NrVkUxeDZLY0lMNDdDRlBKYXpkYytLVXhHbmV5SkFq?=
 =?utf-8?B?V1pxUDRYYXlpaHNuaG0wRG9XWTk1U1FYWkh6MmRtR1N3RnZtSm5tK29NcjA0?=
 =?utf-8?B?NCtGOFVNUWJldzFNSTgrQWs5NlBIT0hOUDZtbUtQUEdYOThDUUJKL1I1UG02?=
 =?utf-8?B?Z1lqTUJ1M1VqS2lYYWVZRkdZRElBL2dtVmdMeW5qK2REV0t5SndIY2Eyazcr?=
 =?utf-8?B?VUFtZTdiUWUyVTlubXB2dlBCQ0lmZGpjMTY2NjRFcTVTQzlYSFVGRFpPSDkr?=
 =?utf-8?B?UW1HQW4wVnFYazMzV2REQjlCUFgzTVlsbEZqM29FUmpMQjQ0RDdyK29neUdL?=
 =?utf-8?B?a29CUVZIR2xna1FCbjlnMTcvYTRBV2pHcUN4L2IvVmwzMUlVMHo5bllrclBn?=
 =?utf-8?B?b05pK3pIV3FhOG5BOWRXaXV3eERrbm10dWRTaU5GanVDdTZUQTFMSkZiNVNG?=
 =?utf-8?B?a3M1RlhjN2RFbkN2M2JGUXlkWStoSWtsQkNKc1NpWjRhZGN6d0xvUlZPTGFN?=
 =?utf-8?B?U2loZVBzUXhyOFdRV29DYlMxbFcwSVRFNzdvbS9xVDJFSzV6Um53b0JiTFJP?=
 =?utf-8?B?b252NnhXd0lzdHdzemc3Zm5rQWhNN3BEeWtxbWV0SzBwL2lMdXcwZC9vRE0y?=
 =?utf-8?B?RXRJZ1dneXNCUEFLakxtYkV2ajNydzMxRHZJNTF5RXUwWXBLa3hJeUdkWnFw?=
 =?utf-8?B?Q05ZYWhHVnpEdDE1eEd3anJlbEM2Z1A1U1lmQjl5Rkw3OFA2YWZ5R2d5bU5H?=
 =?utf-8?B?eWFIdm42NlJzRWpRZlk1OUUvK1Zkb1FjdFl2Vm5xemlYQ3ZKZ21yaWQ4R0lZ?=
 =?utf-8?B?eWN5cG5vOENWWjJtVlg1S3Faalg2SUI2U2lNM3pQUWRtNUFqV1l6VzkyRnZv?=
 =?utf-8?B?Z0lDWVpGTUpmalFpc2d2anJIVmNGMUxHY3lac1p1UFdNWk01aXVGY3g0ekZG?=
 =?utf-8?B?Mk5IRjljNG5PLytGeG5YRlFPT3U5SlpiUGRsbFozZVlBU1YrdXBtUHJ6cHN5?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8c4e6f-8629-4cd7-6e51-08de20383777
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:04:55.5911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9+L4tWUuoMhmmttV1KH8THgRXieGOCbOhrS+w5KBxaH/O/aW1KoMRJvKohTLgRe7WQkLRRq0v1VcxdpdMkEaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6802
X-OriginatorOrg: intel.com

On 07/11/2025 23:27, Steffen Pervold wrote:
> On Fri, Nov 7, 2025 at 7:59 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 07/11/2025 19:54, Steffen Pervold wrote:
>>> Hi Adrian,
>>>
>>> I hope this email finds you well.
>>>
>>> Recently I have developed a SDHCI compliant host controller in System Verilog (for a hobby project), but I could not find any existing drivers in the Linux kernel (as per 6.18) that is using just the standard functions as provided by sdhci.c. All the existing ones have either some vendor specific quirks or function handlers (specific to a SoC platform for example).
>>>
>>> So I made a "generic" SDHCI driver that should work for any SDHCI compliant controller that doesn't need any special quirks or handling (other than what you can override in the device tree attributes).
>>>
>>> Before I post the patch to the kernel community I thought I'd ask you as I see you're listed as the maintainer of the SDHCI subsystem.
>>>
>>> I've attached the patch for your convenience.
>>>
>>> Any feedback is highly appreciated.
>>
>> First, it is preferred to keep the development process in public.  In other words, cc the appropriate mailing list with this kind of question. For SDHCI it is linux-mmc@vger.kernel.org , see the archive at https://lore.kernel.org/linux-mmc/
>>
>> If you reply to this, I would prefer you cc linux-mmc@vger.kernel.org
> 
> My apologies, Cc added.
> 
>>
>> Secondly, it sounds like you would be the only user of the driver.  You would need to make a case for why it needs to be in the mainline kernel.  Even Linus Torvalds has said he has code that he doesn't submit to the kernel because he doesn't think it would benefit anyone else.
> 
> Yes, this is true as far as I know (for now). However I was slightly
> surprised that since SDHCI is a well defined standard specification
> that there was no "generic" platform driver like there is for USB
> OHCI/EHCI/XHCI/UHCI.

sdhci-acpi will drive any ACPI-enumerated device with ID PNP0D40
"SDA Standard Compliant SD Host Controller".  sdhci-pci will drive
any PCI device with the SDHCI class code 0x0805 "SD Host controller".

> 
>>
>> Note you can post a patch as an RFC (Request for comment) that is better for getting feedback on whether it is a good idea.  Even if the patch is not accepted, having the patch and the discussion on the mailing list may help others.  And of course others may have had a similar requirement to the one you have, and have solved it another way, so there are plenty of reasons for using the mailing list.
> 
> I will do that. Thanks for the tip.
> 
>>
>> And please be sure to have a look at Kernel documentation like:
>>         Submitting patches
>>                 https://docs.kernel.org/process/submitting-patches.html
>>         Development Process
>>                 https://docs.kernel.org/process/development-process.html
>>
> 
> Yes, thanks!
> 
> Cheers,
> Steffen

