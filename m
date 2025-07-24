Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2272BE63A;
	Thu, 24 Jul 2025 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358360; cv=fail; b=qiGtHqyRd4HDWFse8Ob1aO8u6sLbTR0ZQXxMvEWrU4BOCkLOLYwv8pOop7eg2ZP+f36xkcqEMt5P1gq49a6e6Q8ztIKnEA4F7zZWuN5f2sIsyB8f3Bj21EzsG3lWWMnyDsg97C5Lppc0DhSkcQ5BUTWGV0CinDfI5eKA0Y5jD88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358360; c=relaxed/simple;
	bh=BZPggAebTRLrIYj7nS1YvsY07MwKzef1Y9K7MNh/78k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iQY+NA21AbRikC29aK8ZyHshkw3l74HkZFdBhE5tTdPrD5KTRoCZIrKTPqZbptriu4V/t4xf5vQjyrCGWH1evktNbnUXcwcThw6DxgEvcHQBWZcx8+fzqgH0JB3dX4O+VgOPm3dVj9hi/WPC8stJ6guARtZyXwc7/yCHJ8Orys4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UinV9ebF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UinV9ebF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753358359; x=1784894359;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZPggAebTRLrIYj7nS1YvsY07MwKzef1Y9K7MNh/78k=;
  b=UinV9ebF//6e/PzOVmHf3YR1seAI8bT3CqrmgJ2z4/T8UvDjNLUIevxe
   Cb7R8z820yjmVmsArU8sQf2PTNo0sJXaTb7FDItXv4UWYG7rGOzQstMEt
   5vCO7aOCXm6mKhZUIzOGFNGfmOhG5hnsT8Mu/V/kM7gxmxL0PbU5BVJ/y
   4TBLkhTct+z4O+vWwHtVQzd6jn0M0byzIlPhwpvbrRLiEoHoaUDHeuEbs
   SJogcTaG7Dy7nnKXA2GDmS03bDTofnZq88TiJW0dhpFCSOMko6KwaitYB
   3A+WOFvb3+ZL+tWIQpJ7HWtACDtW8azDsGG6gsJzNhoEG7AdPhA+E86XB
   w==;
X-CSE-ConnectionGUID: ddu0MBqeR5ubiviRAKoSiQ==
X-CSE-MsgGUID: P7Cy+d0MSb+rmfUy8UED0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66234368"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66234368"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:59:18 -0700
X-CSE-ConnectionGUID: f7j2Mui5TdKa3Lln3kMfLg==
X-CSE-MsgGUID: +bTe1FSSRXOMRACkc4Gahg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="164396601"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:59:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:59:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 24 Jul 2025 04:59:17 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 24 Jul 2025 04:59:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbNMO8goBW/qhjGov2U6AQmhHe2zHZrAovmKIkwSK0JPiXktoWC86t06/BtcXBw8CtGwnB5caB7Ep4GEAtYFrkkZUAU890QcDxrhfA4+xLtSPKAdG8b6cc0Hs5NpRfhND7FjLjgZlb9eODYfq4U+pIBnN7oKn/ldPa4cQvsdosXewxj7H2gMJcg4/3zlsVO7Nm/8UGcWZh2DGyNhn2bjtsNEBxFK07V4f3GniLU2e39IFmKktC/SNjmjVBgXD5I3QezXbcNHw1DvRj9kBANus+Dh27XjVTXpNXbuu3VsSR/QdsXziD+bvJLu731aNtS5a08pktt1riEcJxFFj/179g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YNafr6Txg4qJYsvvPX2PJNNVXzJcvEOrFTHb6RybPQ=;
 b=Pv7HSGyiDLQA69dEJIDRs+6uLBPsBNOCE+qXcEbGZwoIy6Dwi5tjuAhzhpRjrFJZNLXgiluEmbDaFDt7qB4LG3YXTu+sltATsWjgV26uqqJoMYXDyaNogqxyC1FMZxkYylmaFrBsKCI2/nbU1O4SY5SclQs6BPzDOOkJ/V/rdEAH2xbDyl59OA85cXuUFkV5fyZag55izjRVaXk9V0i1jnG09oFnNEeLW3pd0PhB/CRJQZtT34/1dJIQp6VoS+B1Z+t+tl54OYaJxa0GUb1sOIbmwEK3pmvMK73kdwieTjNtq6R4DSK0G+A66hBqE49Qc9ntZZA91Iw/a5m1KaWK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Thu, 24 Jul
 2025 11:59:14 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::9201:63e9:3175:5392%2]) with mapi id 15.20.8943.028; Thu, 24 Jul 2025
 11:59:14 +0000
Message-ID: <d5a0fcf9-4ae0-4d0a-842e-d9475997cdb5@intel.com>
Date: Thu, 24 Jul 2025 14:59:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer
 timeout of AER
To: Victor Shih <victorshihgli@gmail.com>, <ulf.hansson@linaro.org>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<benchuanggli@gmail.com>, <ben.chuang@genesyslogic.com.tw>,
	<HL.Liu@genesyslogic.com.tw>, Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20250716104334.44020-1-victorshihgli@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250716104334.44020-1-victorshihgli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::15) To CH3PR11MB7202.namprd11.prod.outlook.com
 (2603:10b6:610:142::18)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 242687f0-5950-40eb-0899-08ddcaa981fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnp4S0JjRFhtVmo4WjJZNjc5RWo2WjVEY09FbElkeXd1OGg0Z1hvTW5Bb2p4?=
 =?utf-8?B?YkpTQUJsYVIrMlVtd0lLZWoxRGp2ckJHZVllbHBBYklTcXdhTFI5REJlQjhn?=
 =?utf-8?B?Z3Fzd1ZBNGNpelFnRURzYnFyTkNEL2FDT2VNemF5d1dXcHdQRDJheFVtaGMy?=
 =?utf-8?B?T0tOV05ha1VCcUFiNTk0YytEd2lmZ2EvRFB3ZElhUDE3N0YxQ2Q0eHMyb0wz?=
 =?utf-8?B?dTR4cU4zL29uUzRocUYyR0FSbjBxaVFMUU5kWHZtUFJ3ck0zQ01iMVNWc0t3?=
 =?utf-8?B?MWF0S1NaT0doN3RmdkhvdzRGMTBOTGhEWGxObitqMk94NXNaQ2NlOUFOTEZ0?=
 =?utf-8?B?dzgzQ295VnJkL1J5SXJqMFZMS3ltUUtseSsvT0htQjQwM2lSZHdlR2MyZFpK?=
 =?utf-8?B?ME9JcW1nb2R5WWFsVHBEY2ZsMXVSdHRNWTZ4cGw2bmxDTHZzUjg1Rm1VbXlo?=
 =?utf-8?B?QVVJZnhEMXBhVGx3dUNFbFBCQzZSaWpUNFpOWmhQY3FGSzZ2Vkh3S1hGRVJk?=
 =?utf-8?B?UmJyQWJ5bnNLQzY5Q0ZLTWFOMkw5M0JoVUdyVkFydVN1UXRQNHlmT0Raa2tI?=
 =?utf-8?B?OS9PNzNWVFZrTUp0WVVQc0Z1eUhCUktBam9pNzlOUjVRMy9ybFdhNjRsR2pF?=
 =?utf-8?B?cjI4MVV0dWV6bkwvaHl2ZzBvZTVXc2dqbExFYzhWdFpZcGQzcUFYNHd3bGZk?=
 =?utf-8?B?akUvNHRnYUFycFNOMmU2WjI1bkNoVkRnYXAvamRKck5xUS94a0tQYWFXUlpz?=
 =?utf-8?B?WU9nQ2pXS2Z5cUZnOVFIQmNpYzBxZ1ZXNnZoUURFSlhCN0ZkVnY1cldDdWlW?=
 =?utf-8?B?aVc5ZndaQlBQSC8wNS9nRGR4bzBwck9QUjVid3pML09oWk9pMFVhbTNWbU9j?=
 =?utf-8?B?Qy85K012V21md3NUSlJHRnYyQWJia2VJWEVSREVsQkV1NzJNUGpxSlRieE1K?=
 =?utf-8?B?UUYvYS9ua2pZbWxrVXJ4blY0NFNvZ0Y0UjN5UUsvV283RDBqeGxqUzJabGxZ?=
 =?utf-8?B?anhTYXBsOWdia3lyTmREVlRkYmc5elBYMkU5YlU2YmxvY3VqSVh3RVlVamZU?=
 =?utf-8?B?c0JHYW9PQVFsVnpGUThRNDJ1bjUvVUNrM25qcTA1TVY2MUwxWXc0OEhOcGNj?=
 =?utf-8?B?a05DWlBrc3d3em1zK1dZZUl2MSt3OFE4Z2dOR3UvUUJuNFVFQnQ3NDYrY1Y1?=
 =?utf-8?B?MDN3YytPd2plTExGa1RVS3RBbUlrLzQ2S0lsV05MQkRpT3dTSHpQKzRxamdH?=
 =?utf-8?B?KzBrd3RaUTE3a0pVaVJxUERVWW4rTTRJMVN1NkN6dUp0VGtCNmd1QkZYMXJH?=
 =?utf-8?B?WWxJZDA5MUlxZzk1MUFCR1BIRlhxUmJtQnpMQ1RkK0d5RDZkeXJ0TWo4eDFY?=
 =?utf-8?B?d1N3SHRLVFppZWE0SkFZam14dTQyVmxlV3JyaDFybHhjOS9vMG1JNko0VWlm?=
 =?utf-8?B?L1RaS3RnWWViU29FRk05OERmdkNNeldpUHY5U3AvbHN4WXRnMnVVcHZsMnAr?=
 =?utf-8?B?dHR4NUZLNFFSemF4YW5rSnRUNHE5U2N1S2xZYnhnRUZWSnc0NVBWN1ZsUzhH?=
 =?utf-8?B?SFFoSU1KVUNHOUpuMTVPWVZTdFV2bmdLTXNMY1g0ZDkyUzJlQUFmSHl6Wm90?=
 =?utf-8?B?ZnVla29qcnArdHJtZWNxTnA2aWdmSW1CbkdzTnpqMEIrM3ppRHFQWWpGU0No?=
 =?utf-8?B?c1lmSXhzc0F4ZDFXdEQ4bDRHYWdvS014WC9LQXIyckorTDQ0Z3Z0U1RaMldv?=
 =?utf-8?B?dlhudmU5ditWSDU2OC9CY25NYTU1VTFTVFh0UGlNSFQxaTJVNW91OUt4anFl?=
 =?utf-8?B?Rm9HVnZRNlJBK0pWN2ZvdXVqQTZQanVNOGVQemtXdVVxd2cxeG9WUWNab3NS?=
 =?utf-8?B?dG9MQk1semNHeXhkQTJmSTJlQmQrRkhrOWVZUVNiemlBWDdIWnhDTXNXVHRE?=
 =?utf-8?Q?FU6qPSVMVMg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXlmNVVtSjZWN1pEdWxwSHErZ3BuSTNwdzRCeWN4bVl6K3p5ZHV4MCt2eDFv?=
 =?utf-8?B?bk5PVHhFb09wMEg4THhFM0k2amtRNGVxdmkwNTZKdWVGaFdXVlFCeFRyVDg3?=
 =?utf-8?B?eEQ4Z3F3Si9WdTNBSGdxcWxiZVp1MFA5Rjc2Q0pFbWcyQW9PV3VoZ3lHY3A4?=
 =?utf-8?B?Vll5R0JFZTBoaG90V0NZUmpkUzBZT3N0Q0d3MWNkN3ZRTEZyQzdWcGp0Sm8y?=
 =?utf-8?B?UGp4bEh6czdrWWNFRDZoNTQzdXd6RHJWSzFkUkFRQkVUaHBiUzAwR21wZGRO?=
 =?utf-8?B?NmQwK0ZuaXhHNHlSZzFBb2VibEpVTFFrZkpLMHJBQWcvazdSckRWNDFCclox?=
 =?utf-8?B?dUxYbHY4WXZkakkxekRxdUI0a29nQ3pEdEhtMVRJMzJvYWpYWjBJUjErQjJK?=
 =?utf-8?B?U3JwdmVxRjVqYVFuRWUxNjl1cGxGUFloOHk2OW9CWHVuKzE3NkFyS3FuYzha?=
 =?utf-8?B?bU9hczV2K0tmUk13Nk9ES0J6aXg2ME1QVUJUL0Q5SmJWYjZHcTMyTnlobzdk?=
 =?utf-8?B?UjI2SEMrKzM2cjF4TXRSWVFZZkZPaUYvQW5ZZUNjZXQzSm1OdGhmN0lrMXZ3?=
 =?utf-8?B?aFFMblY0K1JhZ2V1RFpVTi9SUEkvaFBET1hpQmZlM3A0dHExSkttOVpBVzBp?=
 =?utf-8?B?L1JwRkdQcjdRUGdQMUxjdGxEcTJRVEcvZmtXb2J6dEMrQjdGa3RnVGZEOEJs?=
 =?utf-8?B?eFZIbDM4WlUzSk9IZ3l5V0IxNlF1R1gvbEFFcVdtM3FLYlFHZVJYUjZxVmN4?=
 =?utf-8?B?cG5vWHMvWHNmcUx3ZFczU1ZPTXVzRkNEakxaRVd4TjY0bEU0MWdsUzBJNnNX?=
 =?utf-8?B?aXQ5THZXcmlhOFRnZDJQcG1kOHUrQ0tPZEdQbXZFRUM5b3IvbVdwb01zajBq?=
 =?utf-8?B?K1o3enVoaWZDclBVakVTUDdndDFmY1pXb24vTlF3Y0ZLVnRkdHBWME9oQ0d2?=
 =?utf-8?B?bTI2YStUcFhoenluNTVWZmhVRHhsS3ErQmNvaWVuSWdqTWdDWWxjTlZlM1E0?=
 =?utf-8?B?ZzJ6VFlHaHpCMVRnSU9Ua096Qm9PMnBpTURHSjdrdnFjSkovL2htMjFtVTRB?=
 =?utf-8?B?Z0drNDRWRnEra0dCM1E5V3V0TkVIaWZYRXovNzJEdk9KZVZzcUl0Wk4yeGxZ?=
 =?utf-8?B?Z3ZUUElMd3RnUDFGSWRZMVBoZzV5M0QzNFZib085UGY0ZmhzTlc0SGs5REsx?=
 =?utf-8?B?YkZlRWRRc1k3S0NsZmlvdVlBZzJmbGw0ajVOY3lyelVhYy8zRENibU5NYU5H?=
 =?utf-8?B?VjBOcFF0d1hvdG1NTWlEcHh6WUJwNE0zUXJVZU9kQXN1RTc0dlUzdWFwY1dX?=
 =?utf-8?B?YVhZb3JodDVXK0JHakFJSzVlTU5QbUF3N3NmWHNQT2Rja3RmdEJ6ZENNR1Y0?=
 =?utf-8?B?THFTaEU4MDFZdXdRRmlKd2VDb3liZDQ1Q0hSWWhMWXBBMkVzWklxaVpnM3RW?=
 =?utf-8?B?ZGNwd3pCOEdRMWxkTXhRNml6ZFdPd0VvK1FZTFMvVEtoWFFJaFBiSHlscFNJ?=
 =?utf-8?B?NTB4Y3BHeTMva2psMWM2WElyN0xqL3VvTGNwNUNLT3luNm1CTVVrMlJ2RVh2?=
 =?utf-8?B?YlJUdkUvb25iQytLVC9kR01kUzJTZENoYnFUQTBqdFdsYzN0cFB3SHdwQVJS?=
 =?utf-8?B?NjBnRkgzdXFMaVh5dGVhbXNCd0VKbXZDY0lWYVJVQ1ZPOEUzaCtDckpVRGJV?=
 =?utf-8?B?emRNclZaZnNzS2gyNjYvbnU5T3d1NGhCRHczOHBvdy9WdjFoUDZ2enp0TlZN?=
 =?utf-8?B?akkzWWdzNEhIalJVblJRNEt6a1lNK29YVC9iVThHVzEvaXVMZ3ROaGhuUTVz?=
 =?utf-8?B?RXFGM2I1R2hYSjNlZkpISkR2akxSZTU3SS9COUx1Q3FKNkpTMUdnMmtCaENB?=
 =?utf-8?B?blNubGVvRVA3d0FrNGxrVk14RmdLWkZwM1pQNS84RmhrOTVLblBwdWg2WUMr?=
 =?utf-8?B?WmFTM1o2RmtDZHczanRWZFZGd2xSR2RNSDlPRXBlUHVwY2JXWkN0ajdYOXQy?=
 =?utf-8?B?bnQ3cjdZNGJ2d3FLNDNmQStoTnZNNW5ZUjZJUCtRVUhGWW84OU00ZjlrTW9Z?=
 =?utf-8?B?bGlVUmpjR0ZTWEVqRWptUEVQUGQyVnF5N1JsQjB0Z0Voa1dpUDl2ZXp3TDNL?=
 =?utf-8?B?ZTFHbEFxY3FoNmZTdTU4MGQyQ0h2ays4OElMQ0pSWTFXL1VuWHdrZ215TDdE?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 242687f0-5950-40eb-0899-08ddcaa981fe
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 11:59:14.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8fJ9xQS189RXUI/0iF61+0gY2GeFCifG/X5Z5Q+XfwR+yV7JVLF6Uz5AyQSIKN+/PhP30dwCeBSTTFteXCkYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-OriginatorOrg: intel.com

On 16/07/2025 13:43, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Due to a flaw in the hardware design, the GL9763e replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages will
> often appear in the system log when the system accesses the GL9763e
> PCI config. Therefore, the replay timer timeout must be masked.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 4c2ae71770f7..eb3954729a3c 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1754,6 +1754,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>  static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
> +	int aer;
>  	u32 value;
>  
>  	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> @@ -1780,6 +1781,14 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
>  	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
>  
> +	/* mask the replay timer timeout of AER */
> +	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> +	if (aer) {
> +		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
> +		value |= PCI_ERR_COR_REP_TIMER;
> +		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
> +	}

The same code is in gl9750_hw_setting() and gl9755_hw_setting()
so it could be a separate little function.

Also should gli_set_gl9763e() be renamed gl9763e_hw_setting() for
consistency?

Also should this have a fixes tag?

> +
>  	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>  	value &= ~GLI_9763E_VHS_REV;
>  	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);

