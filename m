Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306E31E82B;
	Tue,  5 May 2026 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974725; cv=fail; b=cI8O7wkrtCtrqZuwJ4u5sEu+SVqEr6aPNsWnW5zk0XCN/RcJe1BgsRu+A2EbVLzurYIGrlpPRXh1n17OkEccqQ2z8oun4gpuZDUeaT0dqEky/TQhDeqO4qq1pLBfm1GXWHktBhaBz7BVeZOH0GAjGeudBlQk0uRY8ofzfyltvcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974725; c=relaxed/simple;
	bh=Jtycb4tBJVJe04Hws/JVpH6ZLvTYw2/Kr+gUKVlwGS0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kYykJknF61BOJeYhzlu6bz1ZqhhmLZ0nmFl//ZLqyqgboGph58v8epDa0CedslIYlycCPeGr6CuR+4nNpG7Bzt18+uu5ut9iETVxJoagsfsT1qEzkLh/dmVi23twfmNmhYpKZ9bAsE/YAOsWZgyQTiT327XAQj3QwY1OwhHatDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXgzkrMB; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXgzkrMB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777974725; x=1809510725;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jtycb4tBJVJe04Hws/JVpH6ZLvTYw2/Kr+gUKVlwGS0=;
  b=OXgzkrMBfEQ2FK3+Hfd15ACJDsdtS6q9EhA3ohIWSTsQxxnXHDHSFlh0
   n95c1bSWfYO9glr4QB3T6vQWz24fSLwEz9MESnbQYAFYXvpGS0yr/E6TT
   qyzINAeInbIfk50WKHtGsEVcF3rYu1WKY1OdmQAjsCGxLbpzSur6LsyoW
   mpDebd3utdle3p1K4ztYkYhEMN6z0Bj01o3hQancbWaift+aX4S42UUib
   5faGJIVCAuPNZ7DgrH/alcGPrVzONFp4S55TehqZyb2be2VwECTAibhrH
   Gerix2rVTq6obQ5P9Pb3B71hWyJjaRr7jFu2QVW0jAu1EzanYp0OkUQVb
   g==;
X-CSE-ConnectionGUID: Nh/uh1ERTgedurpgJc1HMQ==
X-CSE-MsgGUID: tCJ4pa9mSKKtacnYnK0vtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="101510159"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="101510159"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:52:04 -0700
X-CSE-ConnectionGUID: md78QKZmSZ6I5v2sfH/K/w==
X-CSE-MsgGUID: 8tRN9Xa0TyO3/2foh7LXkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="233108621"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 02:52:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 02:52:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 5 May 2026 02:52:03 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 5 May 2026 02:52:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duKSClLd/IRewKoN9h61cTYed70pYadbmJPatzN8xzTdY+UKM9IJ/fe1W6Owc/+Y3Vaaq0Trz4jOKByY5YCQI8C7jIRd9UjlnmZwoZqvtmgZZVp6DxVcnR6xvsDqkAKCCNrk03jXhHQmaUafNAp0kyLW4JrKtFiTre9PyAjrvSLXSYsCtyYmTPu9w/WOTbq8beWUI24A/DDAK3251KFIhrNUf7CACq3gTv3rSdUb7x/0KpM3/77+zORIzsj3d8uA687i0yOBIATZSgOs0RKhYtGbQ16bNJYDjEVvmnBmE7vx5afOaJieA/XvneKRZ5FHp/BvoStd5fKBWjireRyWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7UC1ku8fNkCWx7R1ylI0FVzo35YES7uznEecI10hMU=;
 b=I8aQMP5JSrl8nJxiLlfHO86I3N8XChJpPUudPXvGoFLfs9XwCeV90NZnJ30TSktKCunX4gNJWlE68rUmnpiO/3mhQ0UuhHvikwWEMWjQvpQFyR7JsWEcTpgo5r10JVDGdElB+NL1w1SZtHt3yJ3Cv+6yVADx9ECDB83o8DTgtFlEHPlVx8bTp8XdsXls26k84pHODpfWkaCiATONddj9P4an8TeiobFA9HUQ1kqVeyrGaEn79JHy0EF+rxkquffoS2ugpxQaxFZTZK+JqFEzVwuT4Q3OWUKtuMdIekH5hRo3mLof9yTR2zkkGfi2BOiRDHTC3dMAtx1tCNaZ7qKU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA0PR11MB4559.namprd11.prod.outlook.com (2603:10b6:806:9a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:51:55 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:51:54 +0000
Message-ID: <5002f40e-9b8e-4454-81c8-986dbb0768b6@intel.com>
Date: Tue, 5 May 2026 12:51:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: cqe: Add CQE support for cadence mmc driver
To: <rohan1sj@cadence.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Milind Parab <mparab@cadence.com>, "Swapnil
 Jakhade" <sjakhade@cadence.com>, Manikandan Pillai <mpillai@cadence.com>
References: <20260407-cdns_sdhci_cqe-support-v1-0-13efc0810631@cadence.com>
 <20260407-cdns_sdhci_cqe-support-v1-2-13efc0810631@cadence.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260407-cdns_sdhci_cqe-support-v1-2-13efc0810631@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA0PR11MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ab3e5f9-0988-41d4-6654-08deaa8bf091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OkR6FnifWVYIwdvngQ8XDgKz46sx1Pmg+E8uVAOevw6UcAvGDj12QTOPf4EJjz43GaCpOYdSyE3eIPEW4Db4qtNvRV6N9is/Yur68yvib42sBEJweYZ2HBxtC2C433awevL4Y45IHioM2oZWytPpy2Sl5uizUAU2OqOuq9cWeMj53sEUfLqH+t/x23OPgGcxVQrEQQuObMnLvEoo+2TVK7c8Vt4KkpqqlKihQkIDxOI3Cq8oBm9bUbIUo19pzDRjgBSCHYEUyJRoFQeDqsqBwzZvY1ud4b5POZQ80sUabBEPVYUqhe8Bn6zHvm9QfmaP+wa9rgOhUeMeqfAysWCxXsSLORO7b7lNXS5x7vhkrGT0bZrO9K8Kg4F4nPf8mFwncKxq+Ac4i0FxdvTXHdghJPPZvlV0kiPhd3smxOwRq/fuBT5Cy/4a5V3jK3kPQF0RwLIL73FSVmYvhuSH/hTI+Sjszwk0z1cDrNeDIs2/yjNgfH1CgRhGxd7xOQZzeH7cEHnDQS795NPLuTXiJhASOsVt5Nz1E+MtDCuV38QmvuuTEG8S8Ir2YgsVSgfkh5VlVUhVT6aJwEhwSLbsQmUXscKIYCI4+IUFjHx9SdL3ooD+7VXZW7qth8197LkLPmlprWRzFvhqVck/ParkvZX8WHmUnU8kClhx1jSADuueHxBlVAtcMyexW/KtGWJ0Aopc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1R0UkFta2l5SUFsME15RDM5NUxJNmk3clNqbnhNMm1TaFRLUmV2SDdlZTFi?=
 =?utf-8?B?QUZ6ZGRjbXhtSmtLTWNoamNpTmc0WFgxdEsrS2hKOGtaMVJPV1hERlc1KzJ6?=
 =?utf-8?B?eFV2Z21BTWREd24xZVc5WU1ucTN2U0tpOS9yM0hHY0dvNVAyUnpMTzJqVDZD?=
 =?utf-8?B?QWZTRUhyQTVzaEdRUUJRa2QybU11Vlo3RnQvSDdOdDV0dVJKVWZ1dFF0V01l?=
 =?utf-8?B?MnJLdzlFcWVmNmFBQXNmNFhHNjlGdHBDcDU1K3QwRXVLejluWSs3aEppSDRs?=
 =?utf-8?B?SGduTDcwQ1gxS2RENkprQ1lMWk95RmlhaXVPbzg4cVhjUXdjVWx3T3d0UFdm?=
 =?utf-8?B?US9IN0lqc2VYaEVNZ0k2YnA4NjdFd1VSazVxRWVNL3A1emtUU3hJVU0wYlhu?=
 =?utf-8?B?MmJaRUFFeG1aSXlFYlRUSC9WSWdaYmUyWHFCYllWcXJaR3VobHpyd28wUEc4?=
 =?utf-8?B?eVRwUTMzRW42VnpuTkJyYjRsZWFxVXRkWnpSNVN0SVZ6VmV5d0pWM0M3cDBH?=
 =?utf-8?B?ZHUzTnJkL2wxeEk5UFBZTzhoR3FrVHVadTV6WEdrRVUxc1owWFVDcklNTjUz?=
 =?utf-8?B?OC9qSXZFSENWT2dXek5iTGwzcUxiTWJUcXErdTVDckFTYkNSTnFhTFRWRkl5?=
 =?utf-8?B?UHlnTVVkSFExektmSkpoNXZKOGJPVWc1UXEvYjc4U0FXbWNFMmpaSVNkcElF?=
 =?utf-8?B?aTBPV1VzTHU2cEV2Ti9WWVRQUEhYdUx5dEdvY1MxZ0thRFdtMHkzaFBpa2lT?=
 =?utf-8?B?RVBuT2dyckcyRUpVVzdSRllNM1ZnWWdud0lNczhKMWRDV3lWY2l1MU1FaXF1?=
 =?utf-8?B?ZmtDd2lEQmNXckVBSTU5bU5GUkFFWmRadkdlVm5iejQzZVYzQXVrVm10ZWV5?=
 =?utf-8?B?UUJTa3FyZlFabFE0UVRLaS92NGZoTzVGRjVQOGtKR1o1OW8yVHBZQ3d2aTZ6?=
 =?utf-8?B?eDR4UkhkYjFQOUFlY2NUeCtJd29pVTQ5VmI0N0Vkemk3R0JXTXBxUXIwTVJx?=
 =?utf-8?B?VDdmY0JndDRzQm5kdE85NTFYNUhTSmhwOUNJb3ZveG9HN3UvNDB4UmUzc2d0?=
 =?utf-8?B?ZExZUGw2K3hUdW1GclhWUjRGT2dvbngveFl6c0pSMnRTdnBhczNhVHkxM00r?=
 =?utf-8?B?MU1JWTlFSWJka1c4aXJJTDZqZDVlOXZPZDZoaDZhcVk4WkxRd1YrellxZGtS?=
 =?utf-8?B?WFlkWU5mdjdaVCtQaEFFWmN6MlFUMCtEdEY5R1ljaGlQYTF2QkZiUzdlMGdq?=
 =?utf-8?B?aTdJaFBoWm40NVJBdURhU3JSaW1RdnUrQndFWlNVUExNTmtCc01FSUVzVlRp?=
 =?utf-8?B?TWZPdXNqaWZ3NFFPV2dhditHc1hOa29PN2VodjhITkJTb2xWZXM0eXNhVU56?=
 =?utf-8?B?eFA2OVdtTDdvTnBaRE96cHdHa2d0eTR2ZlVjQ0xDZ1NWSG9hMGNjeVRiOTNq?=
 =?utf-8?B?enB2dkNrQXI3OWJselowaGJTK1pScU52eFNrUkFhU3FSRjg2azZBdFpDbm5K?=
 =?utf-8?B?eThjSGlmL29NKzcrYm95bmtsVkpqemxYL2NrTFFzc2V6V1pIZE4yMGNiL2w3?=
 =?utf-8?B?YTFJWTZ3WnhNSURPcmFOQW93SlJja2xFbUI0MXRZQU5QVzFxWnVBS0tuaXB0?=
 =?utf-8?B?bERSemdCUEROZWN3cC9Kd01Udjl0NTNPZGdRbHNjTzJqakV6VU9EbXQ0Q2Qy?=
 =?utf-8?B?YXJkNnZ0WGtCQzJJQlg3bnNPemM3TnJCRlJ0TnVsRE9CTkNMOFFMZERPN1Uv?=
 =?utf-8?B?SlZ4Skg3TUg3S3piRlNhblJ6YVgraVg4ZDdET2UwR3hFN3d4VXc4N3dDZjgv?=
 =?utf-8?B?MUJEZGZ4c2pIRnJNOVNZeTR1UEtOM0RlTzd2ZW9GQnA3ZEJqaGFzWXRHRGJC?=
 =?utf-8?B?UUlvQTBlbWMrT0xuOXdZVkZtUkVLTU5wYlhtdm5CR29PYkx0aUM2VmlxYk1a?=
 =?utf-8?B?SlpmU3FCd1FrWlJSNHJFWk1uK3lQakM1ZWw5ajZBaW1pYWRSNEhLSXd5TlVl?=
 =?utf-8?B?cXEwaGtBakNUcEMyYVRKWkZxQk1Jenh0TmlLdGhNWEZDczJrWTZkeS9jbktW?=
 =?utf-8?B?NjU1SEVEUU92ekhZcmxvUUoyVWFGbzZlZWIraDVCc2IrMCtHcnBxWlVzK2Y0?=
 =?utf-8?B?RFNySHpEUkVzNVlWcjg2UHhRUVlnUzhYNE5kbklNM3dHOG13aFEwN3VHdktm?=
 =?utf-8?B?dG02V3lObGxnZzNXSUphd0VTMzZ2aTI1OWlNYktEQ0t5R212L3RKb2t2cENi?=
 =?utf-8?B?UDBFek1yTjNldVQvYWw3S1NSV3BtS09qTVFPTmJOVTdaS2x3VTdGOFRFeUNB?=
 =?utf-8?B?bUZ1UHFBQVJwV3pla3FVWHhNMEVVWFdPSkJMN3pHaythTzlvV0hCWW0xNGd3?=
 =?utf-8?Q?OCdKSYjDLz/9HZQo=3D?=
X-Exchange-RoutingPolicyChecked: V4hHeqC8FFDMWVq+uR6jdYjUJbsQXFPBJsgffqoOFsxVRibqoSbnjnPTpRfaxTs0RNEJwI6yQpJKi7i0Mqlr3yW10gmcZoAmlhL8yBmyp3AA3MjzobeAWKNTwe5LxTXcm9FBT9fmmqLrQLrkw1GFesXcHAhDl+zG6ntwm4NNraPQmwJXVjgMvm4+iuxjwVmUkDRTmWrtcJW1xiGdKaB60aGy5e4P4Nik1QF+YTrzIsR3ixRVjvlR85uiTJ6bPVrrG1Hz4zXHsfTwCiaRVqAqOUxeGEFP9GYmbUH0uXU6EqxfDQjPbg/dhJgWSiNsdEN/NQYuHPlguy8hWLXP0oy9Xw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab3e5f9-0988-41d4-6654-08deaa8bf091
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:51:54.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTchYZiJ5qIG4aORKDlia//yEwOwXcUJZY5Ylr2KjwoYw4u5XF3U3nGQywM+Q8iSvPGm7XK9+qcjiM5xPOa4HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4559
X-OriginatorOrg: intel.com

On 07/04/2026 14:18, rohan1sj via B4 Relay wrote:
> From: rohan1sj <rohan1sj@cadence.com>
> 
> Add Command Queuing Engine (CQE) support for cadence driver
> 
> Signed-off-by: rohan1sj <rohan1sj@cadence.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 118 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 435603c8c00b..14b12272dae9 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,6 +15,8 @@
>  #include <linux/reset.h>
>  
>  #include "sdhci-pltfm.h"
> +#include "sdhci-cqhci.h"
> +#include "cqhci.h"

Also need to select MMC_CQHCI in Kconfig for MMC_SDHCI_CADENCE

>  
>  /* HRS - Host Register Set (specific to Cadence) */
>  #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> @@ -36,6 +38,10 @@
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
>  #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
>  
> +/* Host capabilities not covered by the standard capability registers (SRS16-SRS18) */
> +#define SDHCI_CDNS_HRS30		0x78	/* Host capabilities */
> +#define   SDHCI_CDNS_HRS30_CQE_SUPPORTED	BIT(0)
> +
>  /* Read block gap */
>  #define SDHCI_CDNS_HRS37		0x94	/* interface mode select */
>  #define   SDHCI_CDNS_HRS37_MODE_DS		0x0
> @@ -88,6 +94,7 @@ struct sdhci_cdns_priv {
>  	void __iomem *ctl_addr;	/* write control */
>  	spinlock_t wrlock;	/* write lock */
>  	bool enhanced_strobe;
> +	bool cqe_support;   /* Command Queuing Engine support */
>  	void (*priv_writel)(struct sdhci_cdns_priv *priv, u32 val, void __iomem *reg);
>  	struct reset_control *rst_hw;
>  	unsigned int nr_phy_params;
> @@ -385,6 +392,73 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
>  		sdhci_set_uhs_signaling(host, timing);
>  }
>  
> +static u32 sdhci_cdns_cqhci_irq(struct sdhci_host *host, u32 intmask)
> +{
> +	int cmd_err = 0;
> +	int data_err = 0;
> +
> +	/* return original intmask to be handled by other handlers if it's not a CQE interrupt */
> +	if (!sdhci_cqe_irq(host, intmask, &cmd_err, &data_err))
> +		return intmask;
> +
> +	cqhci_irq(host->mmc, intmask, cmd_err, data_err);
> +
> +	return 0;
> +}
> +
> +static const struct cqhci_host_ops sdhci_cdns_cqhci_ops = {
> +	.enable		= sdhci_cqe_enable,
> +	.disable	= sdhci_cqe_disable,
> +};
> +
> +static int sdhci_cdns_cqe_add_host(struct sdhci_host *host, struct platform_device *pdev)
> +{
> +	struct cqhci_host *cq_host;
> +	bool dma64;
> +	int ret;
> +
> +	/* setup SDHCI host first */
> +	ret = sdhci_setup_host(host);
> +

Unnecessary blank line

> +	if (ret)
> +		return ret;
> +
> +	/* Init CQE */
> +	cq_host = cqhci_pltfm_init(pdev);
> +	if (IS_ERR(cq_host)) {
> +		ret = PTR_ERR(cq_host);
> +		goto cleanup;
> +	}
> +
> +	dma64 = host->flags & SDHCI_USE_64_BIT_DMA;
> +	if (dma64)
> +		cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
> +
> +	cq_host->ops = &sdhci_cdns_cqhci_ops;
> +
> +	host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
> +
> +	/* Finally initialize CQHCI */
> +	ret = cqhci_init(cq_host, host->mmc, dma64);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc), "Failed to initialize CQHCI: %d\n", ret);
> +		goto cleanup;
> +	}
> +
> +	/* add host to MMC subsystem */
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	dev_info(mmc_dev(host->mmc), "CQE init: success\n");
> +	return 0;
> +
> +cleanup:
> +	dev_err(mmc_dev(host->mmc), "CQE init: failed for %s\n", mmc_hostname(host->mmc));
> +	sdhci_cleanup_host(host);
> +	return ret;
> +}
> +
>  /* Elba control register bits [6:3] are byte-lane enables */
>  #define ELBA_BYTE_ENABLE_MASK(x)	((x) << 3)
>  
> @@ -474,9 +548,10 @@ static const struct sdhci_ops sdhci_cdns_ops = {
>  	.set_clock = sdhci_set_clock,
>  	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
>  	.set_bus_width = sdhci_set_bus_width,
> -	.reset = sdhci_reset,
> +	.reset = sdhci_and_cqhci_reset,
>  	.platform_execute_tuning = sdhci_cdns_execute_tuning,
>  	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.irq = sdhci_cdns_cqhci_irq,
>  };

sdhci_elba_ops is unchanged, so presumably doesn't support CQE.
However, the commit message should say something about that so
that it is clear that it is deliberate.

>  
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
> @@ -553,6 +628,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  	int ret;
>  	struct device *dev = &pdev->dev;
>  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> +	bool cqe_enabled;
> +	u32 host_caps;
>  
>  	clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(clk))
> @@ -608,7 +685,35 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>  			host->mmc_host_ops.card_hw_reset = sdhci_cdns_mmc_hw_reset;
>  	}
>  
> -	return sdhci_add_host(host);
> +	host_caps = readl(priv->hrs_addr + SDHCI_CDNS_HRS30);
> +	cqe_enabled = host_caps & SDHCI_CDNS_HRS30_CQE_SUPPORTED;
> +
> +	if (cqe_enabled) {
> +		priv->cqe_support = true;
> +		ret = sdhci_cdns_cqe_add_host(host, pdev);
> +	} else {
> +		ret = sdhci_add_host(host);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sdhci_cdns_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int ret;
> +
> +	if (priv->cqe_support) {
> +		ret = cqhci_suspend(host->mmc);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = sdhci_pltfm_suspend(dev);
> +
> +	return ret;
>  }
>  
>  static int sdhci_cdns_resume(struct device *dev)
> @@ -630,6 +735,13 @@ static int sdhci_cdns_resume(struct device *dev)
>  	if (ret)
>  		goto disable_clk;
>  
> +	/* Resume CQE if enabled */
> +	if (priv->cqe_support) {
> +		ret = cqhci_resume(host->mmc);
> +		if (ret)
> +			goto disable_clk;
> +	}
> +
>  	return 0;
>  
>  disable_clk:
> @@ -638,7 +750,7 @@ static int sdhci_cdns_resume(struct device *dev)
>  	return ret;
>  }
>  
> -static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_cdns_pm_ops, sdhci_pltfm_suspend, sdhci_cdns_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_cdns_pm_ops, sdhci_cdns_suspend, sdhci_cdns_resume);
>  
>  static const struct of_device_id sdhci_cdns_match[] = {
>  	{
> 

