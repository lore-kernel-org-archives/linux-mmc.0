Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB088BA36;
	Fri, 25 Jul 2025 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431337; cv=fail; b=gbUcSIsHroP1rQNxZ25hIQD77RddaMBwAdfFLlBiRdoF3FD6etI9tGem6U6gArEn72Zmja9ivjY/mg4P6ic0IIvV8XmAKlGgl2QF3BBQxLzx5Do+7v6/aqyPtVhIIyEdb1Ky90sRHBCL5red+UBUskkOk7cRl9QctYA0icQ0ncs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431337; c=relaxed/simple;
	bh=qpl1yn2/r9yabjRUeM0q21vocTlahv4x8iShM3kQwiM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxJ2GuW7q/cN6dQvs3a1Z6CJhNfJCMlounN4sKbG2/pTIMRuZ7W8SzYmsgnqoS2LNNVwD5Nsx/mLGA8NDrqOsfjRGnP59FMfMb5p3KrCbLTLaoc9lRtfCUeOQxW/YDLen1eriTJVSrcurY4VGXxmTNDd4yTDWRnL94ohHxokShE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hot63Vmd; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hot63Vmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753431336; x=1784967336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qpl1yn2/r9yabjRUeM0q21vocTlahv4x8iShM3kQwiM=;
  b=Hot63VmdmRdU01INJ/CtYn4bxlRXXVx6EkiCsIXOysYzryh6n92piq8F
   547OKKInKjHgid+VQud9QsupNbY/fb2NTVJ4Lu3AbXlvKTLveR6vKpHKG
   k27vlOJ5tvZNdMU9eumVO9kd7otqxAw+lWlrEnwcwpuUIjY7ty/1i5uJq
   imHB+hMwQ8uefe4bkwAUbtK4+OvU3pW2d6gr6NNruT8gpbqvRLS/6nx5o
   yoI10B4gE5711z2s7mFSPKW9gXc1vrQAVJ9WRGTlY0VA94WpApSM07qbT
   lB8ZIbFNBz/92uebCDLSdX07WW3tQKBlfPFrOwYBtSkd/GCODD7HEdErZ
   w==;
X-CSE-ConnectionGUID: uikdFpPySdaGkz7z66tg8A==
X-CSE-MsgGUID: /ZWR+JGyTY+XckpoTji2bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55618155"
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="55618155"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 01:15:35 -0700
X-CSE-ConnectionGUID: oVnmCC+hThibZQlyew39GA==
X-CSE-MsgGUID: sd85YVvaRdS3p0yBpfyxmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,338,1744095600"; 
   d="scan'208";a="160397600"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 01:15:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 01:15:34 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 01:15:34 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 01:15:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vhkPqX/oqPo7haWgjm5jTvdLN6ikYo47gcoD/nlkrIW3YLnVf9itHSJuoMWOEOJx0u3NsRhiR27nfoUgKYWkGGsimNQrdToiiDjHbpL8vqhZ/XYzK7HkRy/9FLoNxEx4Vn8eCXhv1RODFhGzrtqA7W+h41i68UjXlAVfgVQ6PfEOKm0x4JPwc17x/NOMgGNH8iMxBp+nCB7mIC+/Ir4AX3HfUIu1OzDJROsbbxuZwToFjA8rtYUMenL7K0yUhPMu6Z8IcrwPmC8rQS7uXjvC6l4awJKg3o23vq4h8Ihqh5uMdl28XTt2nEg7079+KGQsePTau7Q9Sn5PhLeknS/29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jt/jL7wLrZrTqxRl8LiDUcjY3wzifMuET6yRRzUwqKA=;
 b=rbYUw8I3UEhCHw+tlFgS8OWrKxLj+EQpYbnMpm/2bIUvL83Q7rUmJZcnRkSwoR2JPUZnk6rpk36o7ihkynQhsRk/5Ag9sse8suSonhWjRUpvqhCpCmwWf/PGtKcYk4IbHgfbTzBwthPdD/AQNoWhWagNO2/EUoVKxZiMJt+Bq9pQle/90uINB6Zxatkf5yXjPXz1RrQy56zGGtv3FOHuCc697Ej74pFkllz0EsmyTGvuTI0TZVxjBuX9QOId7oP6Nn5QYccq8dOW37vlbCOX7wGx7GnCNqA///AOCbPTADgSQDNgvbUHlwimuJjQObiU2ZAQJ3eN+2A2RPh5PMizdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 08:15:04 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 08:15:04 +0000
Message-ID: <b2e94588-96e4-4afa-b767-e7f05a81dcfa@intel.com>
Date: Fri, 25 Jul 2025 11:14:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Ensure CD logic stabilization
 before power-up
To: "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
References: <20250721095357.3783222-1-sai.krishna.potthuri@amd.com>
 <cf04326b-4de4-4637-aa3b-fa1c358b9ae4@intel.com>
 <BY5PR12MB425804611D4B29ADDCC82906DB59A@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <BY5PR12MB425804611D4B29ADDCC82906DB59A@BY5PR12MB4258.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0037.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53f::16) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|MW5PR11MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c141786-2477-45f6-7551-08ddcb535bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjJjeHRjL1dIbjJwQjJHZlNvTE1xT0l5UmVBWjRIS0hBSTg1UXNiVEptMXQ4?=
 =?utf-8?B?N0JmT1M0QnBOMDhNQU4yZVdzZU5aaHlnUTRDdUxzUDJkM2JObjZRc1N6UnVI?=
 =?utf-8?B?NGNJZGRGN2xIN2VhWnhSVGk5dDlFYk9LbjJSSzVMb1FjelE5QjlJcWFPeEt0?=
 =?utf-8?B?dEZNSWZxYnp4aytSZHRuQ2pYcVhCU0Q0K2liTmdGNThlNlZsVllHVnpHZTFj?=
 =?utf-8?B?aTJJcnI3SVc0Vm5sWm9WWlMyQlQ0TFV4UmUwbkRPNjB4NmRtbHBtZXhwbkhw?=
 =?utf-8?B?VkpLbFU4TFZoRWZEdFVQWHBtajhmQTZkRnhKeE1obklTejVYc1IzcTA2VHlr?=
 =?utf-8?B?OG5oU011WFJzZldXRnNVQ0J1Y0R4VHpWYmxtbm5tWGROUmllWjJUYklIMkJE?=
 =?utf-8?B?V2FFYU9tVDZhWGswcjZmYm5od1ZQWXZIWnN6c2l4WlRXWUdaODQxakljU3Bs?=
 =?utf-8?B?UWFZK2dkdCs5eUs5ZzlaWWg5cGhwUkdXcFVaN2s1NFI2emQwNlIzQ3c0Zncv?=
 =?utf-8?B?dTVaOEQ5S1ZuQ3BQQTdmQTBFdk91aXhVNmRua3NyMHVqN25obmdEeVZtdWRG?=
 =?utf-8?B?WlZSNGJDckZLKzRCbnFSU24xS2E1cUVoMWNNSFgrOUw2ai84eVhlbm5pYyth?=
 =?utf-8?B?SllqZVpyQ3pLMWFzdHdCL3hKQjAxSGgvKzBrZGw0S3BXVEZKTDFhZlJHQXJt?=
 =?utf-8?B?b3pUS3JiWTViWThIcWNXOTliS0VZYS9pK1lxbGRvelpSN0tta2Z4ek1qYVh0?=
 =?utf-8?B?OXBuQ0lLVjYza3Fxa0o2WFh2Nll5WVdCRWJzUlBjNUxEdStpSWFtRWJmZU8w?=
 =?utf-8?B?YllBQ2llbFFoQUIwKzNSNnRteURXVE5uNWYzcURrblNMN21UbjRlRk5aaHFu?=
 =?utf-8?B?d3dDVWRxaE1JRW1JbDNFSVBFajhzTGZaU0JCbXprcGRtOWdic2tFdXlVNHpL?=
 =?utf-8?B?aHp3Mkh6SlprZnpjLzJRM0NzUm80ZmU4TTdqQmpmZ1lmZkl4Y1JiRERmL2Qw?=
 =?utf-8?B?R1NyVDRObDJyK1hHSXhWNklNUW02NnpjS0lnc3BFYzlqR0NsRTRxY1VOVWFu?=
 =?utf-8?B?RWRrRWdDWXpEMU1LWm9HK2dycWJwbjQ1TXVnK2pudzhrWko0czZpU3BhVXcz?=
 =?utf-8?B?M2kvREpJQW5mNkJLcXdwM01sVXUzMWhWdWRFZ1dPNExKSER6WjVqeUdEU1dE?=
 =?utf-8?B?Q05oV01YQXE3a2xKUDYrbkNmNFd3ay85VEFXVjlyOUJURTMzc1BGYVJzYnBV?=
 =?utf-8?B?ZENYWkJVNUxXT3piQVNHTVVDeGpXakpiNms5ZXNIdmcxRFlVUTducHVVT3B1?=
 =?utf-8?B?OHdVYTZqeWYxeERmbDZ3Um5ycUh6cjdMNHdNR1pieENJc05hb05JSHpWZGdx?=
 =?utf-8?B?QlJ2b3BNdG04WENpS3RqYVEwV2dNeE4zSTdHVFdnbFpCTDEzbnM4Rm5hSVJB?=
 =?utf-8?B?akQyUGphRzQ0QW15L1JpbFJ1YkdvTDU5L1YvYkR5eU83OXRzSGhGNkhWM1cr?=
 =?utf-8?B?ZmE1ZnU4UXovSWtrVEJMNmZIR0trQUxUbUs1SkRSUENlR3c2WFhIbXJkd1Js?=
 =?utf-8?B?L0NqeFdPS2Iza3B3YTQrWTdUcWo5TzZwbWVidE1tREtIaHZTT2tEMUpTSmky?=
 =?utf-8?B?NkZuTnZ0ckpWNlVocFMwZ0lYQjk3dDk3TjdieVRxQzR3bVlSTXVwYWV3cXVv?=
 =?utf-8?B?U0NiVld0MW9JTkpMZHdGeDE4NWVaL2Rkb1M2VStGb0N5WlZRMlJrNno0bmR0?=
 =?utf-8?B?RVkyTjFtVlE1UTRiT1UxK0dxbE5RVUZIeGtneDhUVUhteXJCcUhUS1M2RGNM?=
 =?utf-8?B?YkRqdnRSSHQ0TzRPZzZEL3FoS3RvU2N2dGd0WlhOWTZCQ0p4UlloNHJEeENQ?=
 =?utf-8?B?MDEzTC8xRERnYUNLc0k1Q0ZtMjZVZFdoYzIxaE96ZW5pbmx2bTNuUHB5ZXVp?=
 =?utf-8?Q?+Np/oqN0Dgg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG5nZzNHNWlma29oRWdoaDByT3daOWtjZmsxTlpNZXlaUVdGMFUzNFR5Q2Zz?=
 =?utf-8?B?VEttT2pndTZKM21pb1JqRCtVMXBqYTJLNEljZk4yQWx0dkpUclhBRHhSTnhq?=
 =?utf-8?B?OTArN3M2Y2FsbjBzWlBXV2M2TXF2WHc1L2hsSGJqRFFESFdQNVNwNFA1czBW?=
 =?utf-8?B?dDB3WDFNL1ZQbGNhbmtaUUgrVzdPMklrdkdtcDVoN2lMWmVkSWhlbDZNelVz?=
 =?utf-8?B?T3BQc2Ftd0RYSDZjTVcvQXBsNEhpMVRSSGhER0pYbFMvZE1VSGliRUk1Qjdp?=
 =?utf-8?B?NHkzUWI0d2JUS2t5eG5hSEZ0RE9lY3JzdWpRNzI4Z1JJMzFtMTA2dTNCSVo1?=
 =?utf-8?B?SjRkbkFGVml5TXVrWEdmRWc4WVBVUy9hemR6K29qeUJDMTdWRjkzd2JIeGxa?=
 =?utf-8?B?bVl3Um50UVNycnp6N1lLZVdPMWJzZ2VaVTBjc2Rnd0lUS3JCbzZBYUd2aEwx?=
 =?utf-8?B?dzlsenkyc1VBOGFlU3JWL2tvS0NNRzd4RW5kRkFaYWxmK3NUY0NtZkNOY0or?=
 =?utf-8?B?bU9ncHRMd1IwOEpiWkFmMmJsQmNodk9tMXVHUnEzMnBsN0JncVZXSEVYZlM5?=
 =?utf-8?B?bVhTSHZFdjZKWDEyNTQzWGVkRnhpZjJpWE5KaXVjbm42Y0FZYVlFOER5eTlj?=
 =?utf-8?B?U3lFenVsVytQU3QxYnV3Z1Ava1d3LzZlUUFkQnNzdlU3azNGN0p6eGROU0JS?=
 =?utf-8?B?c0gvSU12dGRZdWp6YWo2TGVxekNlMEV2UEVISWllRG5heUorNU1NYTk2WjRZ?=
 =?utf-8?B?eEpLZ0FMdVQrWU53RTFGYWlQSzlIKzhubUZYWVlWU3ZLaE1mSmE0VlNNQ3pN?=
 =?utf-8?B?bEZ1NEJrc0NrUkd6ZjQ5WGF1V2JhZHVzUnJxL3pDbzdNcFh4amk1Sk5EUGhq?=
 =?utf-8?B?a014UE14QlY1ZjlINS9EeVpYcG5za3hDeDh5dmFZQ2FON25DM1UyOUQzbk5J?=
 =?utf-8?B?OFpyWVNiNWpkalJxMHdxa0tGU1dCY1Y3SVBhSGRUMTNuQ0kvR1A2YkRTVUxy?=
 =?utf-8?B?WTZNeVlESjBsTVBhSm5FVWJOSjQrNWc5WEpkWTUrWk9VWWM2Z29VQ1dtandN?=
 =?utf-8?B?ejZ3bWVydHljb0dPVDNXVEJHOEc0WlNLenpJdjBHVFpMOUE5MUdkYy9xMDhk?=
 =?utf-8?B?dkRjbkZtYlB1M1Y1TUZtelRPREszMFBJM3h0WEdmS3MrMlp3T3dubnh4Qmx2?=
 =?utf-8?B?VCtWNjk1MHdiU3pUK1hheWUwNVdueWFOZG1lbVhnWXVqN3lYbTlnbWZ2RStm?=
 =?utf-8?B?UGVzdWg3WFo4aURTYVhBY1dJb1BXMTFPMElIUDQ2U0djS05zUmRZN1pQSkZ4?=
 =?utf-8?B?UWFuakMwdVFkK0ZNamlacnlBa2VXWHR5ZVk1dTJ5SnRMaFJvT09hZGUralcx?=
 =?utf-8?B?ejRNRkZhTFU1L2MvcE9WQlhHSUhUSStGamlLbWxOQ1RxNE9ncHJoQTh5clBa?=
 =?utf-8?B?MEh5OCszSDFQdUJjaE12VTdXaExVdFdyOFNvd2QzU2ZoelJpN2lYS0hDYXhK?=
 =?utf-8?B?R1VnU0JKaTdMWmRJUUJmNkNVUlU2L2Vnd3RrWXdDWDgvNmtsTXhaNVliZWtl?=
 =?utf-8?B?aVBOcW91a0RhVkRFNHU5amxEZ1BUeEVvY3ozbC9qQ2gvT0thMXdlanNvck1j?=
 =?utf-8?B?OVpYYjNudVliTGVxK2h5SVhnK051ajd0a01TV1ZlUENweEk2a0pWK1lwK3Vw?=
 =?utf-8?B?d08zOFJ0cEljbWtKa0wrYU92bGpTQ2hlTXhvdmxPYTFkU3NDWUJMN0QxR3gx?=
 =?utf-8?B?MEg0T01sRXVOYTZERXdHTER3VkNPWWNFZnNaMWI1MWFNMmlHYnRsdi9TbnJh?=
 =?utf-8?B?KzN3d2lnb3M5d1d1UGtsRi9xRzkwek9aeTJWblZQbnNyZ29XQnNyK3M1TEFL?=
 =?utf-8?B?NjhYV0dPTzlYQ09PcHlnTWpxT0lyczUzYnVUMHhBYndWSklQcWFOQ0NhcDlX?=
 =?utf-8?B?QVRodHZiQ1d4WUhobW5manVQakpUZUxkd0s3ZFVyN3ozK3lXNjNpNFRlSm1t?=
 =?utf-8?B?QTZMMFpPSFV6ald0QUpZZjVCMXJtQWdMclBTMDRnZ2lZenV0dTlBZWh2bUF4?=
 =?utf-8?B?bXNoRUc0cnpoazdWaG45emt5R2VhSmdsRVA3a0NZVVVscWJaM0poZ2dxS1FG?=
 =?utf-8?B?Wjh6OFBySzg0cy9vTzR2QnJQaFoxd2poU05PZmZnSzV6Tm11TGJrNmUwVEt6?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c141786-2477-45f6-7551-08ddcb535bcc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 08:15:04.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S17C0oOtSOnfon50ALt/vWx/ano0IxmnzfKKMWv6BLMXuYDUzJuuuNpI1v1biXfUPoRxr+eF/seRogPtAftOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-OriginatorOrg: intel.com

On 25/07/2025 08:49, Potthuri, Sai Krishna wrote:
> [Public]
> 
> Hi Adrian,
> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Thursday, July 24, 2025 9:50 PM
>> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Simek, Michal
>> <michal.simek@amd.com>; Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
>> saikrishna12468@gmail.com
>> Subject: Re: [PATCH] mmc: sdhci-of-arasan: Ensure CD logic stabilization before
>> power-up
>>
>> On 21/07/2025 12:53, Sai Krishna Potthuri wrote:
>>> During SD suspend/resume without a full card rescan (when using
>>> non-removable SD cards for rootfs), the SD card initialization may
>>> fail after resume. This occurs because, after a host controller reset,
>>> the card detect logic may take time to stabilize due to debounce logic.
>>> Without waiting for stabilization, the host may attempt powering up
>>> the card prematurely, leading to command timeouts during resume flow.
>>> Add sdhci_arasan_set_power_and_bus_voltage() to wait for the card
>>> detect stable bit before power up the card. Since the stabilization
>>> time is not fixed, a maximum timeout of one second is used to ensure
>>> sufficient wait time for the card detect signal to stabilize.
>>>
>>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>>> ---
>>>  drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++--
>>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>>> b/drivers/mmc/host/sdhci-of-arasan.c
>>> index 42878474e56e..3ce55009ba4a 100644
>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>> @@ -99,6 +99,9 @@
>>>  #define HIWORD_UPDATE(val, mask, shift) \
>>>             ((val) << (shift) | (mask) << ((shift) + 16))
>>>
>>> +#define CD_STABLE_TIMEOUT_US               1000000
>>> +#define CD_STABLE_MAX_SLEEP_US             10
>>> +
>>>  /**
>>>   * struct sdhci_arasan_soc_ctl_field - Field used in sdhci_arasan_soc_ctl_map
>>>   *
>>> @@ -514,6 +517,23 @@ static int sdhci_arasan_voltage_switch(struct
>> mmc_host *mmc,
>>>     return -EINVAL;
>>>  }
>>>
>>> +static void sdhci_arasan_set_power_and_bus_voltage(struct sdhci_host *host,
>> unsigned char mode,
>>> +                                              unsigned short vdd)
>>> +{
>>> +   u32 reg;
>>> +
>>> +   /*
>>> +    * Ensure that the card detect logic has stabilized before powering up, this
>> is
>>> +    * necessary after a host controller reset.
>>> +    */
>>> +   if (mode == MMC_POWER_UP) {
>>> +           readl_poll_timeout(host->ioaddr + SDHCI_PRESENT_STATE, reg,
>> reg & SDHCI_CD_STABLE,
>>> +                              CD_STABLE_MAX_SLEEP_US,
>> CD_STABLE_TIMEOUT_US);
>>> +   }
>>
>> Doesn't need {}
> Will remove in v2.

Also probably better to access the register in a consistent manner
i.e. use read_poll_timeout(sdhci_readl,...,host, SDHCI_PRESENT_STATE)

> 
>>
>> Will this work with all Arasan variants?
> Yes, this is expected to work across all Arasan variants that comply with the standard
> SDHCI register definitions. The SDHCI_CD_STABLE bit is defined in both the
> standard SDHCI specification and Arasan's user guide.
> On Xilinx/AMD Versal and ZynqMP platforms, the CD stable bit is typically set within
> a few milliseconds. However, to be on the safer side and ensure compatibility across
> all Arasan variants, a timeout of 1 second is added.

A lower timeout would have less issue if there were devices that did
not have standard CD stable bit behaviour.

> Please let me know if you prefer to increase the timeout or if this logic should be
> enabled by a platform specific quirk.

If you are 100% confident it won't negatively affect other
devices, then it is OK.  Otherwise it is better as a quirk.

> 
> Regards
> Sai Krishna
> 
>>
>>> +
>>> +   sdhci_set_power_and_bus_voltage(host, mode, vdd); }
>>> +
>>>  static const struct sdhci_ops sdhci_arasan_ops = {
>>>     .set_clock = sdhci_arasan_set_clock,
>>>     .get_max_clock = sdhci_pltfm_clk_get_max_clock, @@ -521,7 +541,7
>> @@
>>> static const struct sdhci_ops sdhci_arasan_ops = {
>>>     .set_bus_width = sdhci_set_bus_width,
>>>     .reset = sdhci_arasan_reset,
>>>     .set_uhs_signaling = sdhci_set_uhs_signaling,
>>> -   .set_power = sdhci_set_power_and_bus_voltage,
>>> +   .set_power = sdhci_arasan_set_power_and_bus_voltage,
>>>     .hw_reset = sdhci_arasan_hw_reset,
>>>  };
>>>
>>> @@ -570,7 +590,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
>>>     .set_bus_width = sdhci_set_bus_width,
>>>     .reset = sdhci_arasan_reset,
>>>     .set_uhs_signaling = sdhci_set_uhs_signaling,
>>> -   .set_power = sdhci_set_power_and_bus_voltage,
>>> +   .set_power = sdhci_arasan_set_power_and_bus_voltage,
>>>     .irq = sdhci_arasan_cqhci_irq,
>>>  };
>>>
> 

