Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD426B747;
	Mon,  4 Aug 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754314782; cv=fail; b=THqmy2YPYVR4b5AMrTWinCalS5yBYUvsIyIAWyGYc4Ql8md5E6EzRFECCfsyFSljPlRuzMrORXLjV6ejJZcptYk2huBu2HTmMobej2NbdO8hGOK53Q1FsusjtkvO1WyxsiOAuITAXfRhoqg7yiG8MEbZrsDl9NtJqEOoBS8uX4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754314782; c=relaxed/simple;
	bh=R0/zIVCpiEvMWM28UgpNlt4bt+czQIi6xgvuDC3q3gY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DfkmhpB3sZ0poxwu/xaRY2XWEkPAYh9Nl39/6JfgE78Q2Z1stsGh+60uEBTQIvNwifuCqVoQb3Uvlznvq3Dp2wPgzoXmx89ms6eZRctz6NEF06oXty+BjfVvhRp5iPVyGwkmrONHXQWNtVHfHk8ETOWoD1nmkgjexf1rwLmLKl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDQTkz2K; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDQTkz2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754314779; x=1785850779;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R0/zIVCpiEvMWM28UgpNlt4bt+czQIi6xgvuDC3q3gY=;
  b=cDQTkz2KvWnqfcg8lEUT0T9ZoEt06kgNLclZFFEFBmG3e9XY4n2CsFl5
   cO155On51iAEXf7t+ic+s8dkg96A4YM/QM69wR6TzrxlLLceZn2CHs4Np
   PxtsTg3ReR3WCV7NPM1SJtwkeD+csaEOIzFDvLAG3ROwSCfskFi7JBRgY
   jKDp1VeXm/33Gyhd/KW906cyUo1/dp5CLP9Tb/WSEPFDBp8hucmrSCA+z
   j/ZKxzMxKyn4lR2R72AIB/UXoAC8ATHzuocF2+fLQcS3cYuWZzXlUy/Ff
   qwrIdoX31PMAPWh+kMoWJ5x52GzqaofThAhar/l9yxgVQV0aF0iVisZgW
   g==;
X-CSE-ConnectionGUID: fZ476WUyQr+pzbmHsrZM9Q==
X-CSE-MsgGUID: m5/jj27xQOST6mH2HKPm1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="60387888"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="60387888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 06:39:38 -0700
X-CSE-ConnectionGUID: pZ47YZD7SDSf2KGab4zh3w==
X-CSE-MsgGUID: l+BKQdegQw+7f16QJq17fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="163427300"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 06:39:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 06:39:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 4 Aug 2025 06:39:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.84)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 4 Aug 2025 06:39:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQEDx0+hAvF7pL2j02BVdtUoQnmlGLTLPWzzClcl9LxfpnRKtz6rsf4RkF1oSR/a+ZhlZMUy6c0lcRF72q7dfOSnA7cvPUquh9EE3HOfCZ/42xIepyW3VS5GqM7J7It18OXdN6HVRXEuPWLA7KtoPSwYFb0Aduw4ZKyLlJ/Oe79shDFK4RhJHeg/d7sdYA3kn46i/nDkWbeUa+BYWyV1hKokGIo1+NriYz7TpjRRZvamCOmVpdzmJL7JaNKs0aknOzOi5x8oRl0NqlOCPqW2jT0m0iGXmy/7M6HoGFG3+vIUco2G2z2FIFOP5owxEhPGfddhVttTpEfqbUuVHZsMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPz7k4+R3hiBi1jE6bTqtsxUYChRekOYe3+xMUUP+9M=;
 b=rXfRfJO9jJHk7h7BWdzjZFwqaGOZX4nRmpJe0QICVkdZGfs5BiHZEJF6Q3DaUy0Sg7wsS9Li6Nt/Bxp7qUA0Sxsb+r5uzreaqpl//kmrAtBUqOSjdFc06x2aK9zFDAzFGS7xVF1/MsCRh69RUMXo8HbCeOQmmh4WEuJ6we+9D7iUgrd7egYC3UlJvcapvc43hyOUhvsJZifSdy+FC3Jc4wrQnAteHFG+TAEL7E1vZJ/SvzXAj83jnra+mEGuzIdNlYpTQG8xoBCa0c3ckQ3FyJHfZQV6mWF+Bra4lwTzIMZLhhLbVwaBZcGq7rONWO9e5JmCGMvbdzaSeKxxrAOgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB6991.namprd11.prod.outlook.com (2603:10b6:806:2b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 13:39:35 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::eeac:69b0:1990:4905%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 13:39:35 +0000
Message-ID: <b863c8f0-1a2f-43b7-a89e-5e0801ef7815@intel.com>
Date: Mon, 4 Aug 2025 16:39:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] mmc: sdhci-pxav3: add state_uhs pinctrl
 setting
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <phone-devel@vger.kernel.org>,
	<~postmarketos/upstreaming@lists.sr.ht>
References: <20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz>
 <20250801-pxav3-uhs-v2-2-afc1c428c776@dujemihanovic.xyz>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20250801-pxav3-uhs-v2-2-afc1c428c776@dujemihanovic.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU7P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::12) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: a4017822-5881-4a8e-a484-08ddd35c5960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THVOMDdYN1JWeEJodm9uWDFkUXMrYmFvTG9VcFoxeU9pdjM1V2lSelZCTU9T?=
 =?utf-8?B?dWt4R2FmUVRheXBEaGYwUGxGc2RuRlQ4b004ckJMbEMzR2JGcXNuRTUrVUNq?=
 =?utf-8?B?M1BSUnIxUXpjeWsrTzdjTVRIOS9kajB4RlhDck5lRWJLd2dBR1o2dlcrZWRn?=
 =?utf-8?B?SlZmcEgxMUUwV0FpMmJ6Vi94N0FBTGFQNXQwKzA5eEVKODZwcEdCc2VsRzdQ?=
 =?utf-8?B?ZEZzNThmY1Z3ZWhwY3VrQlZwQ0JDbENwZXYvWHVFRHNQQTBjN29TQjFHZlFk?=
 =?utf-8?B?QVU5a013eFRKQlFXK1RpWXlTV0NUK050Mnk4MHpNK05zNE02RjZLVFNKei9E?=
 =?utf-8?B?RmtOcEcyQmFQZ1pQRmNHUEZsYUcwaWxrdnVNWm45RkhHUG9GWmpVVUZqUWJi?=
 =?utf-8?B?WFZLMlJzWjMzL04rWkd2KzN3dlIxVDRzcUhyMXd5MWs5eFY1MFl2U1MxbSty?=
 =?utf-8?B?Szc0aXRZM3AwVWU3K3NMbVJBUnVIbVpJUnk3YWFjR0k2UW1BeWNLQ0lTRWoz?=
 =?utf-8?B?YVMrQVp5QkN4Tkp3TlZJNUFla0dTOTJJTmxLU2ZDalpldWc2M0pWUnRKbnJE?=
 =?utf-8?B?SlpsV0FNSm90UDhISTRRR1lzUzViMkFPY29tc3B4UlBvSGtlTUI2Rk9JKzFS?=
 =?utf-8?B?N3pWTHEwRFh6eDE3YS9vaVcrbDhkTGNPczMzTlpUcm5ZdG5US3RjSllFUkdy?=
 =?utf-8?B?cm5OL3RadGRBbUgwbjNLVUgzTTl5ODB6aFJIMFl3Rnd0MUJNN3o3bytXYy9y?=
 =?utf-8?B?UFJkOTQ4MVhhWmh5QUlWeDI5azdkSGtVeitLdFg3dm9EcWxqTzZVY2dGTzB4?=
 =?utf-8?B?dzNqVlV0ZU9DOGdjcktVcEVPNGhObGpIMnFPZUNQT3crS2xDTGREbnVvNWEy?=
 =?utf-8?B?aHdNRVNPSXp6dVVIUjUvaGkwOTVseVN4ZElyRE1wcW1ERjFyRVhGRUVEVUZY?=
 =?utf-8?B?QVVxQml5RC9kOEs0NUtzSlJlWXdIM0IvOTYxTGVUTTF4K3MrZmtGZTAvUVA5?=
 =?utf-8?B?TTcwNVl2WFB3QjRiRGlrM1dRek1YMkZ3a2p2WGNmaGNseEs1WXk3SWxYdGpT?=
 =?utf-8?B?RW1HOUlNREJydjNlR2pGY21Jamxtc1hJeEZoNFVKWElZdlAwdmxOSzhSaXY1?=
 =?utf-8?B?ZEZQWVROeG1zbGhNN3d0R1NVa3JRTEVSbzFmSTVJTFMxdXZiQkJkcTIvVzRn?=
 =?utf-8?B?L2R0OFRxS3JUeVk2SExwcmlHVGExcC9UNDRoQ3lCd1FieEUxYlN5UUZ6TzhK?=
 =?utf-8?B?eXJqRzYzeDVMWmFpSFA3SHNDU2YvL3RVTWNwU3dQbnZkZGIrKy9hWGp5dVVo?=
 =?utf-8?B?cXZ2WHIwOXAwcGplMFVtN1Y0ZUM2U0k1SVV4TUhhN0FIZnZFdSs3NnY1NXZO?=
 =?utf-8?B?V1Jid3FTRStTM0lWcG9lSlpVRzhVNTZVNkRDZGkyMWtOenJWbGlGaGpYYXQz?=
 =?utf-8?B?NHl2ekdDdG44dXFXcmRiVXkvSXZSanh0QkxiMFBCa1NmVE1pdzIvRnB2djRw?=
 =?utf-8?B?SjRwa3RQRXFIdzBnZkx1eVQvODNlMUhnNHB0ZFE3KzJJYjF5M3lKckNGTGth?=
 =?utf-8?B?OEg2VTJmbENMSUlPaEFRUlEvSzQybHBUYjBVV1pmUkMvdjFFYUltYTE4SkZO?=
 =?utf-8?B?MU5mZld0RzVRa0FDK1hWbDJmcDlmUC9KdzBFY0JhS0psb1BkWFFPTE5Sc3dm?=
 =?utf-8?B?MG1TZXA4SzZ6Nlpjc0tzdm4zb3pPWTJhdEJpejkxTCtoZWgrYmd2ZkJFczNv?=
 =?utf-8?B?VzZabXNUVURtRnBZYU9KMVNzaVlMWU5RcjEvRTBVZllRZ1lVRnk0TmsvL2ZV?=
 =?utf-8?B?NHVFcUtITXJ1eDVoMmxqMGt3S3ErVmlneGlYQmxCZjUyM1h3aTJ4ZVMwcHg2?=
 =?utf-8?B?NkhPSVhQeVEraTBMZnNpcWhEOU9yMWJnbWlLRW1kRUlGZW5UTGxSUExoRUta?=
 =?utf-8?Q?HmIKsPBsBQU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RONEpUa0FwRjcxOHpEYkkvRXNaYi9jOHlrclpQZXpVREZYa1pzOEI3bkZQ?=
 =?utf-8?B?azFQOHVjMm1ZZGNVNE9vZWhCV3lncEJ6T1ZDdEhYSERmVHBhcXo2Sk5HbVZV?=
 =?utf-8?B?Z3JHL2RVTDBmK3Eyc0VEUUdYOVFCYTRtRVpBY3BSUVZ5YStOeXNUUHNnZmZU?=
 =?utf-8?B?Y3lmTWR5elV4MDMzUzdMdlZKWmhUNlU3eFNFQlFOR0lqRG1CMm9oaXh3dHdS?=
 =?utf-8?B?Z0lRUjZxeS95Y3JnNVp6aGloOUh6SUNkbkZJelM2TlNMVUR4WkFxUHRtWmln?=
 =?utf-8?B?YlZhbUJOQS9rcy8wcU54SE84Zk9FR2dPUFY5Q2lSVjBNaEZrZHJXejkzMTU4?=
 =?utf-8?B?K3dWbENjWXpjRG9XUlFlSDFnZmloVEdFOEExM2xINFcxa1hOV2pQTFhKUlNq?=
 =?utf-8?B?MDhzVWZ3bGRySGE3K1ozcHdwK0NoY2ZhNVU3cVBzeFdObEhPQmVJSFVuSmp5?=
 =?utf-8?B?c0Z0c21aQ0JFSE5wWHo1MzdmSnVSL1hrZVNpRndBSFZOVmdFWXZ2ZHpkZGtl?=
 =?utf-8?B?N2ZqUGUySTE4THpZL2haUXBBZ0JUMXdHRS9BVENIZWlkVGhITXl6c01MSXNw?=
 =?utf-8?B?NnpteTVZMlVySVpKeEIwN3JXRTdtNFhneG9VUFFRQ1M3a1BnVTZMRWp2YlhY?=
 =?utf-8?B?YlM4ZndNMkxtWGhtWnZzVTU1enBKcERTeW5BWmROQTUwTVpiYTZIVUFxOUVn?=
 =?utf-8?B?MzErcDdjTkNUYWpBaEd5cy9tdm9RMytqMXRqY2pXKzZvS2MxcWxjOFVNYlhp?=
 =?utf-8?B?M3JyVXA0bjVqR2h4WGh1a1lHb0cwb1ZYV01jNW13VHFETWpFcmNUVTNsK0k4?=
 =?utf-8?B?czNBSVVFMWRlYmRFRi9vYXl4bThiWVJqTGpTazlFRmlXOUxZcFNuckYzbWtX?=
 =?utf-8?B?MkpjMWhJZ2JkUHFLZlUvb0VpejZGRnJMOGxQdzloenVrSTN6Vk9LUVNWR3Fo?=
 =?utf-8?B?QUxQeTAyUzlBTUZDY3NVeTcvN1ZsSUZ6bENMcHdXVzZrdVVhTDhESTFRT3ZF?=
 =?utf-8?B?Sm5mY1lsY1NLQlRGbDF5OTBILzhZQVhHOFU3L1NuWWFDODMyZFdublF5MGM3?=
 =?utf-8?B?RVR3blVQcWd5YlBPQzFsWS81TW5SK1pTMHFrZzI2SnQ2M3l5NFhZZ0RtWWxZ?=
 =?utf-8?B?bFBBc3BaZ1RBT01BRWtDdkpqZUppNjhha2ExaHZkaXhJTDB2MnYraGlDT3R1?=
 =?utf-8?B?OUJVc2xWb3NVVVdVRXJqSkVwVXNYQ1VWSzZBaXZyVzR2MnRETTBnbFd0WkZJ?=
 =?utf-8?B?dG9sUmZuU2w4ZnJKWDVBQ1BOc0NIc1ZQSDdJOVhBRURLYzZDMU1WeVcrYk44?=
 =?utf-8?B?WjVVLy9hMFpNUmd2d2hhSnFZMmU1SENqbm9MeEQzNEc1Y2ZwRXp1N2VqbFhr?=
 =?utf-8?B?eEt1SE1NdnVoRjlXQmx4OEFlV3NlTCs3SkhLK1dVTlZvTVI4Zi9MeHB1bEhr?=
 =?utf-8?B?WklXZXRhaDJmM0dBdnRkVC9TT0pWdGZRcDlLdWp4WnFSQWpzSUVVRW9NTy9h?=
 =?utf-8?B?amZad3JIU3RsZFo5NzBtM2xaTkQ1aUJiaHVISnpCTVBkNVRnZzF1V2xiMGIx?=
 =?utf-8?B?VDBhc05xRGNDQllCTWtRZ0doMHp6Q1MzZVBKOGhOd1drWVRqSlpESVcvZ0xt?=
 =?utf-8?B?SXBzSHBxdkxrTE8rMDdUdk1HRzQyWi9rcWtxeGx4aUw3MENMM3dKTXYxN05B?=
 =?utf-8?B?WjdCcGVoYlAwQUpCMFFHZ3FvSFlHZ0pXcUFKdERlbUlZZ0VhN0lrK0NRYVNz?=
 =?utf-8?B?bzFuWnlVRWFSaDNpQ0h3WXRjSWpOZ3RRUEQ5aldlY3ZnQllSY0c4MTJUQTJS?=
 =?utf-8?B?ditxV2xHVHdmbWtoc2pNbkt1dDFrd0lpWExYTHV4dDlNNndJanhSdEdpK0pk?=
 =?utf-8?B?M1BmVjNxMHBlV2UvQ1pDbjE1dGo1TUpOci9vWUoySWdaZ1daS3NHM3kwUXBN?=
 =?utf-8?B?V1V5QWZzYUhNYjY5TkY4c1dOU2Fwbjd1RUhoRjczT0JwZit2TXFTL0xkSGRo?=
 =?utf-8?B?SlZYSHFNZE1yVVJqV2FJRm9FOVFMQWd2ZVZJcG8zV2Y5dkFYaFhHQWJOWkxK?=
 =?utf-8?B?WS9uVVZCOFJtdWU4cGx5RFEyOEtuYWdqbTY0dkZRL2ZIODZsbDFmOHA5TEIy?=
 =?utf-8?B?NENNRnZlQnB5TytSdmFrMC9odCs2R2tJQzNhTU4vUUdQcUxyUllpNjlOenpx?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4017822-5881-4a8e-a484-08ddd35c5960
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 13:39:34.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWzreIjNxDdyeCJblNm+S+kNP9hPfADht8iA9uu9qTjvxAwUHg3Sx9v3NDIXbXlTRyw/p3/ba5gWYXPuT2V0jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6991
X-OriginatorOrg: intel.com

On 01/08/2025 17:14, Duje Mihanović wrote:
> Different bus clocks require different pinctrl states to remain stable.
> Add support for selecting between a default and UHS state according to
> the bus clock.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
> Changes in v2:
> - Don't attempt to lookup pinstates if getting pinctrl fails
> - Only select pinstates if both of them are valid
> - dev_warn() -> dev_dbg()
> ---
>  drivers/mmc/host/sdhci-pxav3.c          | 31 ++++++++++++++++++++++++++++++-
>  include/linux/platform_data/pxa_sdhci.h |  7 +++++++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3fb56face3d81259b693c8569682d05c95be2880..fc6018de92fb19f028b776df0f87937846621e95 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -20,9 +20,11 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/mbus.h>
> +#include <linux/units.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> @@ -313,8 +315,23 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
>  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  }
>  
> +static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> +	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> +
> +	if (!(IS_ERR(pdata->pinctrl) || IS_ERR(pdata->pins_default) || !IS_ERR(pdata->pins_uhs))) {
> +		if (clock < 100 * HZ_PER_MHZ)
> +			pinctrl_select_state(pdata->pinctrl, pdata->pins_default);
> +		else
> +			pinctrl_select_state(pdata->pinctrl, pdata->pins_uhs);
> +	}
> +
> +	sdhci_set_clock(host, clock);
> +}

Really pinctrl et al should be in struct sdhci_pxa not pdata.  Also
it is neater to set pinctrl_state pointers to NULL when there is no
valid value, so this could become:

static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
{
	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
	struct pinctrl_state *pins = clock < 100 * HZ_PER_MHZ ? pxa->pins_default : pxa->pins_uhs;

	if (pins)
		pinctrl_select_state(pxa->pinctrl, pins);

	sdhci_set_clock(host, clock);
}

> +
>  static const struct sdhci_ops pxav3_sdhci_ops = {
> -	.set_clock = sdhci_set_clock,
> +	.set_clock = pxav3_set_clock,
>  	.set_power = pxav3_set_power,
>  	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -441,6 +458,18 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  			host->mmc->pm_caps |= pdata->pm_caps;
>  	}
>  
> +	pdata->pinctrl = devm_pinctrl_get(dev);
> +	if (!IS_ERR(pdata->pinctrl)) {
> +		pdata->pins_default = pinctrl_lookup_state(pdata->pinctrl, "default");
> +		if (IS_ERR(pdata->pins_default))
> +			dev_dbg(dev, "could not get default state: %ld\n",
> +					PTR_ERR(pdata->pins_default));
> +		pdata->pins_uhs = pinctrl_lookup_state(pdata->pinctrl, "state_uhs");
> +		if (IS_ERR(pdata->pins_uhs))
> +			dev_dbg(dev, "could not get uhs state: %ld\n", PTR_ERR(pdata->pins_uhs));
> +	} else
> +		dev_dbg(dev, "could not get pinctrl handle: %ld\n", PTR_ERR(pdata->pinctrl));
> +

To make the code neater, perhaps add a helper like:

static struct pinctrl_state *pxav3_pinctrl_state(struct device *dev, struct pinctrl *pinctrl,
						 const char *name)
{
	struct pinctrl_state *pins = pinctrl_lookup_state(pinctrl, name);

	if (IS_ERR(pins)) {
		dev_dbg(dev, "could not get pinctrl state '%s', error %ld\n", name, PTR_ERR(pins));
		return NULL;
	}

	return pins;
}

Then it could be like:

	pxa->pinctrl = devm_pinctrl_get(dev);
	if (IS_ERR(pxa->pinctrl)) {
		dev_dbg(dev, "could not get pinctrl handle: %ld\n", PTR_ERR(pxa->pinctrl));
	} else {
		pxa->pins_default = pxav3_pinctrl_state(dev, pxa->pinctrl, "default");
		if (pxa->pins_default)
			pxa->pins_uhs = pxav3_pinctrl_state(dev, pxa->pinctrl, "state_uhs");
	}

>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, PXAV3_RPM_DELAY_MS);
> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/platform_data/pxa_sdhci.h
> index 899457cee425d33f82606f0b8c280003bc73d48d..540aa36db11243719707bdf22db23a8e2035674d 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -35,6 +35,9 @@
>   * @quirks: quirks of platfrom
>   * @quirks2: quirks2 of platfrom
>   * @pm_caps: pm_caps of platfrom
> + * @pinctrl: pinctrl handle
> + * @pins_default: default pinctrl state
> + * @pins_uhs: pinctrl state for fast (>100 MHz) bus clocks
>   */
>  struct sdhci_pxa_platdata {
>  	unsigned int	flags;
> @@ -47,5 +50,9 @@ struct sdhci_pxa_platdata {
>  	unsigned int	quirks;
>  	unsigned int	quirks2;
>  	unsigned int	pm_caps;
> +
> +	struct pinctrl	     *pinctrl;
> +	struct pinctrl_state *pins_default;
> +	struct pinctrl_state *pins_uhs;

Move to struct sdhci_pxa

>  };
>  #endif /* _PXA_SDHCI_H_ */
> 

