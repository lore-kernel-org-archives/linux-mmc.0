Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751C33062;
	Tue, 22 Apr 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319315; cv=fail; b=Elz5ZzScXdUgECrBxOSKmQfq/D40dF2QtDlRXuovix5Lxue5IAFCtYglRz5/sptHO+gkfmTuUCxlO6wGGVtgsXLAbXt+BMMFL2CtfRV73dVzn7Egvx9R/kPJdAdV82xL0I0M5UEA4AEDkrY+BaUKgFT6Sc0tHXg1ltvSU16EFsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319315; c=relaxed/simple;
	bh=0Bhj1gk4rRMgiqq7vxOsVyrgNQ1OfleYDMKBc1NjX9o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sLFpmDZ6UpTiXsjUWEgkS4erZtcEcsqvGJga0FZimO22W0/Wtd8UHrl+pvw5mv1OUaS5py4e7RkGrGc+qZuzT2Te3FxKNTvp5Zyf7u6le5p8tpqLbi2Vhek4v0WHVNGCDWwG0krtg9HLLjm8ujNKTPkYq8aD0AKK48+yHyo4KfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkVAHq4B; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkVAHq4B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745319314; x=1776855314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0Bhj1gk4rRMgiqq7vxOsVyrgNQ1OfleYDMKBc1NjX9o=;
  b=EkVAHq4Boj1PN51YsYUtsTyZUYXwEharULC0QseGXF1oK1iPAuCpMP5g
   +cZJJbzE8xLBpI4VITPMaV7545vo7vH06Lo/Ll0kfvmWHq7yf+egix1PZ
   4LNUfgoEbp38mBXkBXoYbSbmZODCrfPil37J/Au3GlNHq12nNFHZk78qU
   TQuupuAgbTcUglRXiDtkB/5awB11fSmXo7bN/mwMZb6dFV+XswZKS0+9s
   hKhcirN26dH7XjLv95T0sxQsIW1P5e3N/ZfbTxuuyQcAGHDl5oIUu/5es
   lWLrkyHB+IwRH9e2Q6ueUNFwcIxa5ESWwvJ7jh1KczsvcvX+90mVctAX0
   g==;
X-CSE-ConnectionGUID: vNedg7d2QcCtp9ATTRIgrA==
X-CSE-MsgGUID: uEyT4qYbTySEt/TXRCgb9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46578319"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="46578319"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:55:13 -0700
X-CSE-ConnectionGUID: NLFyDUz5SY+gr2p38Yp3aA==
X-CSE-MsgGUID: 69vuHt7MTtiHUAiCU8zK+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="137073116"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 03:55:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 03:55:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 03:55:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 03:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uG3DkI6LC43FITx2lMlxXfH8my2CWbOztP7ek7VdMcX9/5HUxl6m/0dHnjQU4QpSbtsukWYYS+cOa1pBfzrq8+bUtz4W2Oul1jHPaTt6nHrALMzffzp1e/HGWj3k8QFPXMW/RuESY8jWL6/shhK/OwG0Var0N3KNNLZ9enh5ql0vGjFyh3rPSu5rajtTo4T049bFU5edOMDJDWSmwicEv7eYm5MMEHyMTRb5MJiNoJsdMGjU04axmUbL53sEEEeZtNd1DivwO+zc+AfcHhkz8iZnsFpRualeON9GBHsniwVzD8p8oqnCd9bHq3pWNLSASkrw4+8xs9i46IAruh3OPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2/fTvTe3Zps+5EUzOXXvyxp7uUv0O1Mthw5VNvqb98=;
 b=gkb9ZyaBI6RNOLY7zlLU6bf+xIuQpDHeH5570hO/OXSO/mz9CFJOexdmVl0qdeE21zsfzVvxc6fX6ve8u1HH9T84TGTKEikSGTilE2AUX6xN6m99JXsHirju3mvJSvrz9Cw0nyGcVfBPtLQsX9wd1XOi3YtJRgJVJcC8XbJVWkcjLdK7PtIFwjLQzFqc+UfWoUgNLKGhDHrP0r4vGxIxYOR3WyGkBkAWSfAJqPEftUVtp1GhZkDfPPxYEDKy42vWiFn09j6MZ9KW0J87VS/BfIzb5e2zAxhvLOEs7AqAwOBmCWRhrGF2tOo/+W0nSxJlKj8A3qBInrDqIN5qE8LkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by SA2PR11MB5193.namprd11.prod.outlook.com (2603:10b6:806:fa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 10:54:29 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%2]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 10:54:29 +0000
Message-ID: <d0f0719f-9fa2-4145-9144-7955ac7f357e@intel.com>
Date: Tue, 22 Apr 2025 13:54:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] enhance the tuning process reliability for i.MX uSDHC
 controller
To: <ziniu.wang_1@nxp.com>, <ulf.hansson@linaro.org>, <haibo.chen@nxp.com>
CC: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <linux-mmc@vger.kernel.org>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250409075550.3413032-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0050.eurprd04.prod.outlook.com
 (2603:10a6:802:2::21) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|SA2PR11MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbb337b-76ac-493d-dac6-08dd818c0e62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjRBZGRiNTNucVNRcktpUE5adkh5VWFra21NNXFNWEM3WjFrWCtnczU0Z3RQ?=
 =?utf-8?B?NjRzKzEvaENJby80NC9TRFJ4akI1Ulg1MkZaV2hid1hFZnN0OGwvYURYZGUv?=
 =?utf-8?B?UnFwRHc2OEtBbnRBVFBMVnFvaXZsbnBzbWhoVFpid3hiV2ZMQzJ4SG5vK3Jz?=
 =?utf-8?B?Ym1DbENSeTZxNGs5NlZUc0ZFaVlRTVYyTkppWllZNTJONHFabzR5bGM1bjlI?=
 =?utf-8?B?RUdCRGhYY3JKWGhTdHRuUkd1VGpoRlJCL1JNa3ZncnRPSXlXTlh5T3p1Yjhs?=
 =?utf-8?B?dkh5K1hqQkZ3YlZhUGY5cGkzTm9KUldjY3o0b1N2VENDdExBUGVKdy9HVHR5?=
 =?utf-8?B?clhlb214TENGdVZWSEd1RG9KNnJhUjEwWWtGUFN5UjMwcXVlMzZXTHZEM2RM?=
 =?utf-8?B?R2FKSnFKRWpQdnZBM1B2SVBRVFFTTTluRU5UVDdNQ1JiZHM4T3E2QnBWM2hw?=
 =?utf-8?B?ZFpTdmU1QWVLTTZNcDRYNDBCaThHNnVZKzE2ZE8xM2x1RmVRdGJVUk9iMTQr?=
 =?utf-8?B?UmRRd1BUY3RORFdVbThEYmFaS1NhZUdySzVmeFZkMlh2RHlIS3lYaGVoUG5s?=
 =?utf-8?B?WGNYR3ZUZW5nemNHUGRscTdvcUMvYTcvYUlydklQWGIvdGdkcndacVRkTU45?=
 =?utf-8?B?UEJmOXRyM2VlTHFIcUtEaDVDV3V6bC9pV084WXhvL2hwVU9EMFVwZzBuejNZ?=
 =?utf-8?B?enJsY00xc01iWndDdjZ4VDBlektNbnp2ZXZ6Z2RVWnRzU3h3b3lHNUJZRi9N?=
 =?utf-8?B?R1pZRGZ1ZjVNeUlwbksweGdqNkcrOHN5cjZhNUt2NENLZk1aRVdIL1g3TmNv?=
 =?utf-8?B?dFNJZmM1SEJHMVJWbXd2ZWd1NVIwYmR0Rm45T2V6ZE84Zlo3VUNjdjR3WGFH?=
 =?utf-8?B?Mk5md1dUUzVpeXI1RG5HY3Z1RU1PODcrVG96SmNNTnZCWW9jZ1BPZ0ZqK3FS?=
 =?utf-8?B?Z0VIdkczc2g2S3ZqVFVlN09zcTdtMjFaVkdkQ3BFNHJDQlE2Rjh1VDA4WUpz?=
 =?utf-8?B?ZjlZbm9Ld0RLYm1FZXk0UTlJQUh5S3g3ckRVMXJNaTRwY1hGRkQ2NDFlR2h0?=
 =?utf-8?B?VnlvQkNKd29TTzZwZUYwNFpQYWlseTc2ZDYzLzRyQVU1b1M1RkZncEZsdGZM?=
 =?utf-8?B?UTd4bnY3UW9rUGVDSGxISXRRR1gra29naCtDSCtUazAydlpNZnNGM21VWDdB?=
 =?utf-8?B?NFdjTmgzdWRIT3B6WlNRYTFCY0w1YzhhVjY3QXQ1S1FqbVZUODhDUEZkSWZQ?=
 =?utf-8?B?T3NLYStyS2dWYmhxRDN0czZDV2QwdUdCT1dNOW5oaG9Xc2FYTzNBQVIzNXQ1?=
 =?utf-8?B?cmI0b2ZmRHB5MUFvK1NRdFh3UnROeHRBdWJPdmhJZEZGK3V0VjlyTjFnZitE?=
 =?utf-8?B?U3k2MU04WnV0NzBnaXBkaExGcFJXcFVxN2NSVjR0MkFLL0J6QTU1K3RmTmJ6?=
 =?utf-8?B?UVB3VG80N1h0YnlpQXlUN05ycUkvd1g1OVkvTWtjeW9URVlUM0M4cGVRQzBv?=
 =?utf-8?B?VzdTTjIvOVA4Rm12ZTVKQ3NpTVB4WWREcVJxaE9qZTU4eHVvQW1mRWlid0xv?=
 =?utf-8?B?Njg5aGxSbk4vZU5Bb1RqUGp2VHRUTTRRWnJ5R3ozelFSRkVCazVUaUltTXNv?=
 =?utf-8?B?RUxMRWpIc2gxQ1Q5RjBDcVRuSFRIVmNWNVBHREhBZWwwWWZWMVl4VTEwMkhD?=
 =?utf-8?B?T2l1bERLR3VyVmxTdFJzbnNwdDJOc1QvT0t1N0QzYXUxVG03RSsyVnQ0R0FV?=
 =?utf-8?B?RFlRVkFITEFqbW8yS3F0WjNzRXRrSnF4dytyVmZYZ0tzbFFQaE1aRFZwbG5i?=
 =?utf-8?B?THF6Y1FoZG1UU283bzdmU2dvYkYxV1NteFlXK3diMzR4dlZDTVlwOWxaUnda?=
 =?utf-8?B?aG5QYi9wdThyWWUrb0dxYityb1dXRmMvYnVPUnhLTDdENmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2RYd1ByL2EzajJFKzRPT0lNS1BnanNxTTdaNE5ueFRQOWo0a1hObmxILzhW?=
 =?utf-8?B?amN4VW93U09ac0xmUFlpTFkrOVVHUlRraUtpS0RacXhueVd1NzNoaDJGaWVz?=
 =?utf-8?B?NmlLbWI5amFtNGk2a3UveEQrZEJlMVRaSHBFeUxjM3NvcWxIV0FXYU13RzRP?=
 =?utf-8?B?azlMVHVybnlKaldLem81akY0Ny82cDlPZEhabFdaSWtJNzRuMjY1UTNVeER1?=
 =?utf-8?B?eDd6c1k3NDNOQ2VDNG51VDdNYWRUam56ZXNONjRRTit6ZFlCM1gycEQycHlZ?=
 =?utf-8?B?ODdTRjBaN2hPNnhWam5Yb0ZiVys4cVVnNzlNSVpOWnJvdG50UkhIVFRvNy9S?=
 =?utf-8?B?T0NpNG5HRitCc2tPQ1RsUTBaUFZwcEhvQkY3WTIwR1NkMTRXNnZPcG83UW9i?=
 =?utf-8?B?ZEhOTmlOb3VrVStOZGlKNzdlY3doR3RTQkVxVVBFWnpjYmlneXYvTm1qMjYy?=
 =?utf-8?B?TDdjMDF2VVFhckEzcU1nUk9ZUlovSjkvZ2lNY0F2SlgxMjdsN3JrelYvaTlN?=
 =?utf-8?B?Rlg4TWJHYTBpbVRjTVVaOEVhRjRXNzRiRFBHbnlBSWFrYjNHaDY1eDdPMVZF?=
 =?utf-8?B?RU5WdjRlY1dLdndlelVXbmRzeFlaUUk2MUJaVkhiWjVsc1IxOTRmNkh5bng0?=
 =?utf-8?B?aWl6RktNTW5Xc0pVYkNPSnh3V1Q2YmFIZWdHbDQxOEkxZEtFTmtSMjRtRXRQ?=
 =?utf-8?B?cFIrbXR5aDROemd3SnNyOVZuT2pJWlhBd0tDTHgxWTRtb1RKNlA0ZlZTK3E5?=
 =?utf-8?B?UERvcjd0OXNRSkY2M1ZCclU4WWs0a0NBclNEQWpjdENSRGhKUnpKeHhpY09y?=
 =?utf-8?B?dUFiY0FzNm9IRXlkL3FGeDhmZENCZ2F3MW9ydjVtazAzUXV6V0h6a3FlUU9N?=
 =?utf-8?B?UFcrL0NGU3pITzc0Nk02aUNTTTROUTFwVjlqTXk3KzRIazJQNG1wVlVvUkdZ?=
 =?utf-8?B?RmpEeHEzd1BNSHUwNTNnLy83YjJiS01jOEV6Yk1ZUmtHYWJuN21IMndoWDAw?=
 =?utf-8?B?aUdDMUFFa0RlblBFclVwVm1FV2VVZTNOMERuZXluVWx0TG5DRCtMZ2hWR1c0?=
 =?utf-8?B?ZS9wNjBudjdvRmdpL29oc3VkWWJ1QU5ZT1pqNHVKcURsMnZWVk5kcGhpV014?=
 =?utf-8?B?VW5iTUNKc1c3KzF4YkhieWVoRkpxbmFDdU1lWXhDSTlUdkJBUU54NkhnWG9w?=
 =?utf-8?B?b0RpWndoSGJkckVqbHhiUzVGaC80b1lCVmg4eW93VS8ycU82bkVsRXhhTHJ5?=
 =?utf-8?B?S1pvWjhiRkU1VHRKU28rdmpUWEtIbzlNeVFuTThPTXNta0pzQ2JZSmNhSnJu?=
 =?utf-8?B?cit3SFhwa09uQTd5MzBqMGNIVXo1ZVhpNzBtbVlGVTFJcEE0bDlJNzJQaHBs?=
 =?utf-8?B?YzVZeTZGTXU4TmlIcFd4cVB1KzFyR0lIdWZRNW0vRGNiQ0tqa0hVYW9xM08y?=
 =?utf-8?B?Y3h3YWw5dC8vZElJVnE5aTlGZlM2Z3JXT2wyV05nL0VwZFdWUkNIYkFpNEVn?=
 =?utf-8?B?MzQ3Mmc1eGhPSVVaRWk3NWYzWU5qVDhpZ0VldEREZkVneWZqZlcxZGplbEtK?=
 =?utf-8?B?MTNDV1FSMnF1UjBTNTdONTZDOVRPMU94M1FjTkU2eStnSXpGMTRrWWE2dHo4?=
 =?utf-8?B?UThGdHQ2amhweXdXN2hnSHJ0L29rNzlVVkZOdE8wUVY5V0U0NDN6Z2pKZUEv?=
 =?utf-8?B?dzdTY1dXSy9WZUwvaUFzSkhlM0xLT0NKR2RkcW9LejcyallLWG5qWlZiZWNm?=
 =?utf-8?B?Vms0NmZSdjhxc3JnSWdEY0xNUDBkYzNkUmdWTWJEaVFnaFNWeEFTbTIwaGFU?=
 =?utf-8?B?WFdUVUgvZzUxQTJNeHI4d3N3K2xGOS9MZkg5NWx2UHFmWU9MK1hJK2ZoUi93?=
 =?utf-8?B?NnJBTURaOG9oNDYzdG4vUHA1eWcrRm5VVnlaSFhFSHFUeTNyWWFuZ29tRnVN?=
 =?utf-8?B?UGlEdmM2ejB0ZDl0OE84ZXFSbXRNZUgyMlBzTG5MemhSMzFlZXhzcFBzWFEw?=
 =?utf-8?B?UW5Zd0IvMjFTTnhxRzlyemsyd2x4OU8wcHM4eS9lZmlnNU90NzFwNFBrK1FS?=
 =?utf-8?B?ZHFMYkRuZ1EvWE1lYy83dEx0bkNuc1B3R3pvQkJwcXNBVFdBWU5pb0tjTlhM?=
 =?utf-8?B?QkFZMWRvcWQ4eVpsT2hJcmUzdDNRaVVzbEVSdTBnbTR2TEZ6MzR1VE4yQUll?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbb337b-76ac-493d-dac6-08dd818c0e62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 10:54:29.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Sif7CRY/C1zTG0aKpV/LonhL1x/zquywy8mmgVQs7Bkm/xL0jUQV0m9JzvB9a1GnFyMoFirz2CRpapAfUfb1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5193
X-OriginatorOrg: intel.com

On 9/04/25 10:55, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> This patch series enhances the tuning process reliability for the i.MX
> uSDHC controller by addressing several hardware-specific requirements and
> improving alignment with the i.MX Reference Manual recommendations.
> 
> Haibo Chen (4):
>   mmc: sdhci-esdhc-imx: explicitly reset tuning circuit via RSTT bit
>   mmc: sdhci-esdhc-imx: reset async FIFO before sending manual tuning
>     command
>   mmc: sdhci-esdhc-imx: widen auto-tuning window for standard tuning
>   mmc: sdhci-esdhc-imx: widen auto-tuning window for manual tuning
> 
> Luke Wang (2):
>   mmc: sdhci-esdhc-imx: verify tuning control status after configuration
>   mmc: sdhci-esdhc-imx: switch standard tuning to manual tuning
> ---
> This series depends on:
> [PATCH v2] mmc: host: sdhci-esdhc-imx: save tuning value for the card which keep power in suspend
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 86 +++++++++++++++++++++++++-----
>  1 file changed, 74 insertions(+), 12 deletions(-)
> 

I had one question about patch 6 but otherwise, for
all 6 patches:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

