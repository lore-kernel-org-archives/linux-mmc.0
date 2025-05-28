Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC81FFC41;
	Wed, 28 May 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428483; cv=fail; b=toN0VNyYhrkPqz5PyTTqjL/b2u7ijj/P/sNvPe0D4C1nC6qTwW7y7XemTqEpSXAxZ4PKV5yFUbFl5IwcRRjRihqIJBVyqxtVMOrNIIfN+W8aRNwXVsshnnVMoMerIf37UHnyjUQ2KEVn8v8eqnmJwML7DLk1w20uwVeZLvwJI+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428483; c=relaxed/simple;
	bh=0cJiCFRxAp12QhQQ7buvBJiYWLviyldY9uXGEaiqQpo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AZtkhVEzERIrebYMshh4aZDIaXB53Zv+lXPUBpCdutbe0JQR05eISBEAzbbmxSmaC40Yph2MZhDgCZ+BrSwCB6wwnGkgQz1apM21kIJ5AZzJp3L1CLHW9987VoN0D9eW0RqFTbMq+EBRNjiha5rErJTwrWpPi6/z60MbVJWgVcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKBAKRFR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKBAKRFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748428481; x=1779964481;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0cJiCFRxAp12QhQQ7buvBJiYWLviyldY9uXGEaiqQpo=;
  b=MKBAKRFRklxLzSWLhYWYnTzQQT8+SrY5PJxZwQaII/oEIsZOesa8j4E+
   cHPqS5yMUjMRtu73+GD5Njt1VnNzvZVjw98yvWjcT3tqcnTzoAD21F87I
   OcP9dWYBuctdbXgfnfj0lLTTwnC87QzKX9uD+qbG5cu64OptGLOZIrk6D
   x+o2TUC6QptQOfJqyBUwQhSAFowCM0MsNS0J+hl68xlAtUA7SqH/h13Ii
   l+rIVOq1G3r8BrhnvN4hWlawh4dRw4FvliP9LvA3usfhKNwXznfO6Fqck
   a7vKWVtgSjTZzZXC4TqgX+20g7zLqaf3OuPM+Js1LFhRU/av6cfxKJEQR
   Q==;
X-CSE-ConnectionGUID: uPZetwdKRDymhuofWl3q7Q==
X-CSE-MsgGUID: S54k8TNxQ3CVh4t/deuXEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="49695900"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="49695900"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 03:34:40 -0700
X-CSE-ConnectionGUID: BD7w/KQTTlyDIDe4PAN6yQ==
X-CSE-MsgGUID: IJ8PDw5PTw6ub/VqusjwMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143235281"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 03:34:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 03:34:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 03:34:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.74)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 03:34:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3WR2mXk6bnKq1eLdOBJ/bRcOaEaa+lwd1e0VYEgFPRv2zwPlIYBf6P+sD1RZB9SYRjvLLI+Y0tBGRF2eEOcHNDegpAdwiJgaU+EkLG6h11WCPMEOu03xcSTLPZOdtRsgmlNPaA5tcIlay/CUbTS3IIeg70OHj41MCG8riE+A7tArzcknHhljrwWsvpr2LxGNcvVFtaXBAngCuwpAaBWLJqhDErZwmFzowualoHWKfkLJTUB4OMlY/AgFCnSQ3tKEmnZtT6RewVyxQNkmHGPtXtvsH9nBumeCH1RMP1xjVGsbDS9N2A9OlH47g37rrC2pWmD60BFtWc5JN0hO77yRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ufb0Ngp376V6g+y/3nGpJCJaYdkATRB/Oe1Dh76cZqU=;
 b=hM265kaH3K5fC8KmXmekHGo47K3FwJkx1FCXadNvoNlwwlfv9Ljp1FF0Jb2W8SP80KsJEUdrKHMdx5UN+FDMptW2ik5lddk8SU9/H0cbDwPob+73QmjHL5Z73Og0NCdavj3+u3MilE8xVgy3MzwB44qXM2EuPRyueGu1edMJg1xgGZ0DGv/ckpAJ5New1NlZrg/8OZZ5DFDmepa1CQaohje4UcrzqmojDZAuN90dz8eBeAADROUxthsKBGb+JBig3hG6A1GgAsJo4HPwjv2GfvkotYotlCRU1dCbZznfDCGEcnX+VavF+0p2lpwQWIKVssWsW3P/vlBOkA5j45vvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8)
 by DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 28 May
 2025 10:34:37 +0000
Received: from PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301]) by PH7PR11MB6054.namprd11.prod.outlook.com
 ([fe80::a255:8692:8575:1301%6]) with mapi id 15.20.8769.029; Wed, 28 May 2025
 10:34:35 +0000
Message-ID: <6be8a114-7775-415d-a48f-751466cce44d@intel.com>
Date: Wed, 28 May 2025 13:34:29 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: refactor clock loopback
 selection logic
To: <ziniu.wang_1@nxp.com>, <haibo.chen@nxp.com>, <ulf.hansson@linaro.org>,
	<linux-mmc@vger.kernel.org>
CC: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <imx@lists.linux.dev>, <s32@nxp.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20250521025502.112030-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0267.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::32) To PH7PR11MB6054.namprd11.prod.outlook.com
 (2603:10b6:510:1d2::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6054:EE_|DM4PR11MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: a29c96c7-7048-4f6e-cfaa-08dd9dd33d93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0RoRGZEWjFraUxrcFh3bjZBODdaYzdWWUhHRFRoME9vV3JxM09qTnVjNVBY?=
 =?utf-8?B?Y09HVk9nS1I0cEJMQ1JCOGR6TVl5TjFjdTg5aGhNaXdYb0xVR2V6V081NGhs?=
 =?utf-8?B?dTdjMWRkVnd0eGZycUIwODRhTWQrOC9tSFloNDl6OXJNdkVtckpzdGRNLzFx?=
 =?utf-8?B?ZU9JNjZMUmxYYWZXUXJxUkZMU3NwOVc4cm1GQ3BPM3RmcHdKOW00eWpwYll4?=
 =?utf-8?B?ZWhhSEcrUEIyUFh2TUwxaE42Z2wzTmVEalZ5aWJDdzE2c1pqRm13YzRrL1pD?=
 =?utf-8?B?SktLMVNhWUlDcUFpcDhtWGp6TWsySzNDRmxUb3hHVFRSYkRYcDNEWTZES3JU?=
 =?utf-8?B?YUlrUkNpOXZNODk5SzFYUVpaZkxhMC9KVDhOUndmYzZTaEVFVzU4STNXbzBJ?=
 =?utf-8?B?Y0k4N1lpUTMxU3NhUkwyR1lnUnJPNHBzTWFpekxDZDFDMkFhRHhiY3RRWTNP?=
 =?utf-8?B?V0p6RjZROS9OUVJkdEJSUTNPbzg3R1VIUWpqTEtEZ3hMbTNjZFE2NmtQNVdU?=
 =?utf-8?B?SDY4VHVjWkpjRCtDcy9ueEdSbmdab2RBcG9WMTdsZDJGbnpVT21oMmxKaVUx?=
 =?utf-8?B?MGo0Y2M3cDBnZDUrbEEwc1pKNTFXNjhJZEI2OFB1SWtRT2cvRWg4bHZvNTV1?=
 =?utf-8?B?MXJaMXZDbnQ2SnhRalJra0dBbks0VnY3S0hKRlo4TXlMdGl5dzFJM2habGsx?=
 =?utf-8?B?TXJ6bzljQUQ1dFpjelFqTktzMHlrUkYrRGx6ZXRNWlhNNUtsSW5KdjNiK1Rp?=
 =?utf-8?B?TnZCKzF4R0JtbTVZS0t5Rms2SWpqY0FEckJ6L0JyZ2lwSWFHYkNMV29JRzd5?=
 =?utf-8?B?akkxVzVEWk5RT0p2enU5ek8wU2ZhYU5hQno4WVRJejJEZE5rVkQ4cjEyVjFV?=
 =?utf-8?B?UVpGaUlYL1dCT0VNbXVGeFVHVTZDajd4Q1pQdmk3RG40YWdyZ1JmR1lCbVQx?=
 =?utf-8?B?K0x0V0UxczRCK0orOFNRQTJXZDhXaHdYd1JmNlAvS1RtNUwvUnFWTVkxU2lz?=
 =?utf-8?B?R0RpS3FlcFNoYWJnY2N2QlJJWERHMC9wYjhJV2E0MlJoaytRY0VOMDRoV2lq?=
 =?utf-8?B?RTAycnBMT0RIN3BpRUxONHdMN1VIVy9rYnFHN3hmTWlKZHpqaDl4RjloMDlY?=
 =?utf-8?B?WmppUjJkQkhjOVgyb1pnaXh2aEE0eEhiejJIZXFjR2dRSm0rdksxdmY4NWJa?=
 =?utf-8?B?NmZ3Zm5PZ1V1VmdZekZvV29EUHJycGNRUnJHcTZiejFpSTc4L2xGbG10ODFw?=
 =?utf-8?B?aklSVUFTYy9KVXpuYm9zb0xFK3FKVlRwTlRWQWZhWm90SVVkTzlVR2VKN0or?=
 =?utf-8?B?bHVxQzM5WDZCOGdhNHhPM3NXQXdyc3F4bHlOU0EyN2QyMHNxTTJUVlBzY0Nv?=
 =?utf-8?B?Nm1meWFFQi8vSHNZS3h6Q3FLRjFUMUR6bmpLOFdnTG9lZEx3ZHVZOEZXb2VX?=
 =?utf-8?B?WnJkcm1NUjNlUnJsMytFclVnQzduVDE5OG4ySllrTXI2RDMvS0tRU2R2MWpN?=
 =?utf-8?B?eDVnekh1RVhmanUvQnMzaUpaeGxvdnNua080ZXpsY0Y0MkVpTUdndE5tMURm?=
 =?utf-8?B?WXZ6OWhjenNwS2l4UTF6Y0Z4eE1Ga1dUejlxdjNJZUo5NFZOMTRrZEtDN3BE?=
 =?utf-8?B?TWhteXZDZ3pEK2trdXBpZzZHdkxTTHZDMENOUEc3QTBYSWF4SVcyZG83R1NP?=
 =?utf-8?B?aU5DK29IVGY0QlNHcmxnZm10dDZzNDJ6QUpxTFM1THVyVEVBOUExWWRCSHdP?=
 =?utf-8?B?VlBEV1RUTkUyQkpBU0pBbmp1M0EzSDBMTy8vS0I5aGFHcktmZjhXcDl3eUxm?=
 =?utf-8?B?US9CaDhIMXhwdFhzZXJwR2V6RU9scXVRRjZ0Q25oWFVkUzQxa1JyREZqYU1S?=
 =?utf-8?B?U3BReHZWM29ETEhSUGZHdEVza1hueEhIeEM2Q1Y0UkpuMjc5T0pDT29jNlIz?=
 =?utf-8?Q?FYAkYFlpy8E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6054.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDYxZkcvNW1ZcUlLOFIwTHl3cHMwRkJjQWNwMmtJS2liUjd5YlMrd1UrbU03?=
 =?utf-8?B?amdNYXZrV2dXa1I4dFp1QWdIMnpIcSs1WHhLMEdqT0Zac1FlMkMycmIxemxG?=
 =?utf-8?B?S1ZDc3NoeFdmN0I0NzhqZ0svVmJVSjVqSHd2Z1lIOVBIaXhPTi9IU1FITkNv?=
 =?utf-8?B?VWcxOXNiQldnQ3pyK2docjVkVWg0ZjhsV1luSUIxSFRaS2pYZmFuWURzVllT?=
 =?utf-8?B?cW1JcDdqNEhNb3B2Sng4UW9QN2RyMkNpTDlUaGxpdzRaNU04V2ZZaUg1eXl4?=
 =?utf-8?B?T3pxcW5vTHNoM3JBSjNZZUtEcTBZOW9zUlpkN1FEeXlSVTRycER4a2pCTHpk?=
 =?utf-8?B?eDRYYWtySysvQXM5VVNFNnliYjRlbEtiZ053SWlaUFcyRHlSbG0vanQrSEM0?=
 =?utf-8?B?dkRpdkNUVHZFSXpWYmM1RXpOcWh1Tm9yRGk4NUI2dW9YS0FVWXAxNktsSmdI?=
 =?utf-8?B?MGx2Y1BMOHd6ZVF6NklGcjdUT3g4WjlqbTk5Q0tYdEh0eEFTb2lSNG1hbE5k?=
 =?utf-8?B?enN1Wk94bGdRdUk0b3A5L093SHh3bEhPeFBqYXdQSTVwajRlZmk4QjlKeHFq?=
 =?utf-8?B?K293ak1JZWZWRGdKMXZWZW1qRzFtWWVGaHc3WDlQZkNiaEN5ZkpyNkNDSW1J?=
 =?utf-8?B?K3N5UVdWVDV5MGxiVnVleGJLL3pkbWZxbTRPTndJY04wbjZ0NUFnS05hT1dP?=
 =?utf-8?B?K2N5aG5GSHFCcllxNXBiUXROeG1nMUlVa003dUNtTHVuakp5SklJbUdrcFV0?=
 =?utf-8?B?Vkl6ektaSGxmOTJlb040VE9kcW1scloyNUMrVko2QndNUDFsdy9zbnU5cTZ6?=
 =?utf-8?B?SFRNN25XZWtSL2h0MEJtckhoTFBTMmRmQzlnK2RZOGJuOTAwTWVoWnQzTFFS?=
 =?utf-8?B?TkhaSTFGdXFzV1hwYjdlV2JLVzd0bmprSVBoWHhLSXFlRVZrMmZDUGQrWnlk?=
 =?utf-8?B?azNZSUpvcXVUSFg4eGpSbndsQ3ZZNkt2dE5OWUlkL3Z1citUWHp5RHZnbVcz?=
 =?utf-8?B?Q2Y5Nks3cWZteVBPM3kzdE90QUtaeVg2b1c1UDRIRlAvM1JkYk52cE9DVHAz?=
 =?utf-8?B?bVVXbDc3T1NTaHA0a2tOTXlOaHFnNlJ0K3V4NldjMEF0SG93M1cyT3NqdExy?=
 =?utf-8?B?bW9GTlh3L1VXRWEza2dLdnQ4N0JBTlZ0WG4zQ1VGbHFHeGV2MEx0elkxOGYv?=
 =?utf-8?B?WkVhd3lPWmlSY2o1d3dRQjc3Q2pzcmdiWjl3aEhIQWovWjc1d0pESEhGVDJU?=
 =?utf-8?B?L3NUTTdOTUYrU2UvWkRlb1djRngwN3NKKzhqM3RJODRuNXRvQzlwNVhXVWp4?=
 =?utf-8?B?eFpwR2NpcDAvemduMmV1V1U2R2QvVkQ4a2NGcE14Z1lYMlZXbVlwS2NhZVJl?=
 =?utf-8?B?UHF5K1BDNkErbjBLdnE4alFWR1JaYVg5OHgyQUdLejJMaEpjbmVydW5wOEdn?=
 =?utf-8?B?NFRra1hrVkpyQTVpaHZZOVkxdmRtS2FsRE5vQ2JDY1o5bGZ2WmNlekkrbEZD?=
 =?utf-8?B?Zks1cDNHU0tWZ2VJYjVNVnlWNGxoZ3NuUG80NjFkOURDQmExY2hrMVpxWWQx?=
 =?utf-8?B?L1FMaTRRQVh3SHkvejFEN0N2SXgwczJuZU5lRDJqOEJ0dGVSOUdaM0xmVVZT?=
 =?utf-8?B?ZzRnMlNRZzA1UFJJd2lSU0c1SGh4UGJKaDZ6V3I3ekJ4OVdVZWIxcWdnUU1Z?=
 =?utf-8?B?Vm1pSlhGU1VqcWlkU3g3aHM5ZFA0RVlzWWZta0xkNDljWTArSG1hK2JoZitz?=
 =?utf-8?B?SUk3aUFUQm80aTRoV2dhSlh1UkdxckE1c1h1c29JTTgyN014ZG11Qmg4VEd4?=
 =?utf-8?B?cW4vRk1pMnFla0RDUUlvbFBOTnJrTWtNWVZ3ZXI0dEcvQWVQaFAvNENlZDV3?=
 =?utf-8?B?NnkrUEFPblJhY1NsSDBnNUExblhwc21OOHJCV1VWVndzbmtBaXRUNFA3dFRZ?=
 =?utf-8?B?UUdZZ0RFblJTR0czcnY4SXpaWTFrYzR6QzNQTmF3MVdyQjlPY3JWczFVUU1V?=
 =?utf-8?B?YldTK3JyU1UvYzlzVXdPYk5xRlBWWW95SWRDOGcxN0JtcFlLMlcrMi84bHN1?=
 =?utf-8?B?SFRDYnlaWXd2RTlJZHRjU3ZjalNvVHVrS2tGT1UwT2JvNEJDMTNQVEVqZTB4?=
 =?utf-8?B?OEFTY0U5M1llaFRHanJRd1c4a1pON3BWWVlpZkMrZ01hblVOVGw1MWk0ckZX?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a29c96c7-7048-4f6e-cfaa-08dd9dd33d93
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6054.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 10:34:35.5593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnBIU3FHixVXa80BE490V+nwfO1aca5Hclnoh50oRQ3lg3/ksE11zJgMBKgfBkOZRBxwP7nCRMAv8pqQ9N9ucg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6191
X-OriginatorOrg: intel.com

On 21/05/2025 05:55, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> i.MX reference manual specifies that internal clock loopback should be
> used for SDR104/HS200/HS400 modes. Move ESDHC_MIX_CTRL_FBCLK_SEL
> configuration into the timing selection function to:
> 
> 1. Explicitly set internal loopback path for SDR104/HS200/HS400 modes
> 2. Avoid redundant bit manipulation across multiple functions
> 
> Preserve ESDHC_MIX_CTRL_FBCLK_SEL during system resume for SDIO devices
> with MMC_PM_KEEP_POWER and MMC_PM_WAKE_SDIO_IRQ flag, as the controller
> might lose register state during suspend while skipping card
> re-initialization.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 7611682f10c3..c448a53530a5 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -728,23 +728,17 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>  		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
>  		if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>  			u32 v = readl(host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -			u32 m = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -			if (val & SDHCI_CTRL_TUNED_CLK) {
> +			if (val & SDHCI_CTRL_TUNED_CLK)
>  				v |= ESDHC_MIX_CTRL_SMPCLK_SEL;
> -			} else {
> +			else
>  				v &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -				m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> -			}
>  
> -			if (val & SDHCI_CTRL_EXEC_TUNING) {
> +			if (val & SDHCI_CTRL_EXEC_TUNING)
>  				v |= ESDHC_MIX_CTRL_EXE_TUNE;
> -				m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> -			} else {
> +			else
>  				v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
> -			}
>  
>  			writel(v, host->ioaddr + SDHCI_AUTO_CMD_STATUS);
> -			writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>  		}
>  		return;
>  	case SDHCI_TRANSFER_MODE:
> @@ -1082,7 +1076,6 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
>  		ctrl &= ~ESDHC_MIX_CTRL_AUTO_TUNE_EN;
>  		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>  			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
> -			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
>  			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
>  			writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>  		} else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
> @@ -1177,8 +1170,7 @@ static void esdhc_prepare_tuning(struct sdhci_host *host, u32 val)
>  		"warning! RESET_ALL never complete before sending tuning command\n");
>  
>  	reg = readl(host->ioaddr + ESDHC_MIX_CTRL);
> -	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL |
> -			ESDHC_MIX_CTRL_FBCLK_SEL;
> +	reg |= ESDHC_MIX_CTRL_EXE_TUNE | ESDHC_MIX_CTRL_SMPCLK_SEL;
>  	writel(reg, host->ioaddr + ESDHC_MIX_CTRL);
>  	writel(FIELD_PREP(ESDHC_TUNE_CTRL_STATUS_DLY_CELL_SET_PRE_MASK, val),
>  	       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> @@ -1432,6 +1424,15 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  		break;
>  	}
>  
> +	if (timing == MMC_TIMING_UHS_SDR104 ||
> +	    timing == MMC_TIMING_MMC_HS200 ||
> +	    timing == MMC_TIMING_MMC_HS400)
> +		m |= ESDHC_MIX_CTRL_FBCLK_SEL;
> +	else
> +		m &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
> +
> +	writel(m, host->ioaddr + ESDHC_MIX_CTRL);
> +
>  	esdhc_change_pinstate(host, timing);
>  }
>  

