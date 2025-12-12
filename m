Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6E5225762;
	Fri, 12 Dec 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765540752; cv=fail; b=bz3M5Cn5Sa5wLix6PT7J6XJ0aBE+IHyKZRsFEcA696HmJOJrBLFWUjby9pVb1SjHZ+yNWuWvLcuNbnxUfXPPYlPRL1mU0HYRfkGORkCHbvGmp4/1p7B5afudzD6xMAdBB0c+Nx1kN+c6TJJ3x4DcWsxeA84uD6GeGwEPQ9lBVj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765540752; c=relaxed/simple;
	bh=UjxLDS7ZKQMsnJKY18Ix4KIcst/hVKg9ciLKiS026Rc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fbN83uCF2yXg9MwbYKLlgUD5A7WRaq6rWhiAaOy+CgUO/LZR+MwcIYWbPinP27JSGc5gtJX3FQ+76bjPbURr3m5KXleb4qfb8AVMCM8UrvacP8UKM5T0T/aLtbb7MfD8F8xX8Y2QQyiJFWNMDqZh5x7UblrpQGS3/A6k3USvc5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbG865Mp; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbG865Mp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765540751; x=1797076751;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UjxLDS7ZKQMsnJKY18Ix4KIcst/hVKg9ciLKiS026Rc=;
  b=PbG865Mp7X2kXr2Rp5BTH/Cdg1csxQvxVa5b84LVQ4F1mb2CibjHlt/8
   c2YLA3mEx4GrMpN9z3amtrZC1ZgC5ohsHlVS8bEZ1zDAp2yidXWAY//Du
   /FfmFYmS26ykntG8+BzbJ3BMhUoOte4AXRctBNXJWhYvieymeXm3P+s5O
   JDfJxq+2xVapZXOD+fAkHXgUkD+YpzRVWaqyZPvxaxhpLzU885yTTU5lm
   jwuTRmZTmNYePMFIGpVQQDWsyYqeizSIrTBWJIawNyYrcoGzLw5dU5JKf
   53OXTaAjFARtsMgp7E9omsLw0zEFV/g4mFydTW+H0f8cusg6c2OODhtum
   Q==;
X-CSE-ConnectionGUID: Brg2VRyRSauI4R7iIHDRDQ==
X-CSE-MsgGUID: O2bYb/boRweGvTUtQaBAkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78657259"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="78657259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:59:09 -0800
X-CSE-ConnectionGUID: tQqo0/GqRuWvIjE/zUM9aw==
X-CSE-MsgGUID: jXDrlg37Qy+AsHBcyTcJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="196357222"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:58:54 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 03:58:53 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 12 Dec 2025 03:58:53 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Dec 2025 03:58:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzV3F/Gi2cJMEglUQhf74QnAfcPaZfVqLFE5uEVmzR/dzFWpbrBVc5Mk+FztWUqPFwTQGh6Iv0G9uF2OI7BMmX37uvjaoJvwJgTzCBIn1M+dcWEoTbf9JQajM+bulqlzLIjP+62ussmtYRbJktsgLrnfwRIU3gdl0g7Vr7MLFCieXVZMGxfXtX4S0jUrGLf6oGZzr3NyMk0ILK6UeZ89z+UdcmqyJ6I2EPr2o7rr1FmFM4X9zzW6KkSDrxsB2UwUpjsqHC0LXy41sbeq6wQrtYxVgMGbVD5ise0rz8iqotbUZC4JuITEAzBy2Ti64k82adZ4c2ostGJVtjt1DtWUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPT7halNaaYVJT07aYlPKbl1d/nIijxvAAcdKZhDMng=;
 b=ET0t3gSVBCwnDFhM5Q6E932MBL2wWgCANUF3bJeJOVZKQs1bLVE5XSmQFbeuHN26mb9jZT7SQniiU86MeWtdbzJEm8Mv8Rk73emucfvFLsX+zfbdIjGqk7Pa39QqVrwjGU3EkNWRdH/WjPpw1STy8DRl9IbSEo2MyTMn3G+OGQkWg6ydzqgLCHFnEvmfY7dCpp61G7nDPv5BAZbCuWzPfkQhi0xmfRBEfcpmGGMuiiPIwlzxZ1+FAo5drjlqzDxvnTdv45K71M5pH4QCnSEnN3ailVCUVkxmNmJQu+14qykHv+MFln04OrBNjYKJ+GaePWpHqWkLeDM8N+Bz7rnzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Fri, 12 Dec
 2025 11:58:46 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%6]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 11:58:46 +0000
Message-ID: <fc3ffb7b-d2f4-4337-8086-8dcb146bfa07@intel.com>
Date: Fri, 12 Dec 2025 13:58:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: sdhci-esdhc-imx: wait for data transfer
 completion before reset
To: <ziniu.wang_1@nxp.com>, <haibo.chen@nxp.com>, <ulf.hansson@linaro.org>
CC: <shawnguo@kernel.org>, <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
	<festevam@gmail.com>, <linux-mmc@vger.kernel.org>, <imx@lists.linux.dev>,
	<s32@nxp.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20251211075603.533033-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20251211075603.533033-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0257.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::10) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|SA1PR11MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 793b715c-4eed-4a16-cb13-08de3975cdd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2ptNzM4N0hoaGRmSFBQZ2g3Y255aTdDYnE2a2dOZUtwK05JeVBvampDMWsx?=
 =?utf-8?B?WUYrQ2U0dmFROEZCQjJaekVuMDZyNlpPNll4TVpDYmdQMWgvajFnNUlFV3RQ?=
 =?utf-8?B?eURMaGZJeVhkbDdIcGJNK0h1THF6WmF6RzEyUGxMWm5uYnE1cXZZRGMwNWRZ?=
 =?utf-8?B?NWtuVGF6TVFvQUhTcWVVMUM4ME5JNyt3b0ZEb01tbGdZWTJodWZTdnZYYWVN?=
 =?utf-8?B?Y0xXR1gvK3hPQmlZL3YzbVliQ0NjMUp1dXlxMG85ZWM5dVBYL0p1bDV3c01N?=
 =?utf-8?B?cGFqYTRDUjV1VkcxZ0tESG0yYzhGc29rb3JlYUlObVlHZ0JObmFqbmRnSG9U?=
 =?utf-8?B?V3JDTzZMTVh6bGtINlZnaXU1OUJsWC84QlNiM3k2dThZaDVhNE0rSzRnQlpt?=
 =?utf-8?B?NHExTEFoRGU1T1BUZ05EY2VtNGd3MnBIYmtWWndxcUd5VzAvN2ttejRqODFi?=
 =?utf-8?B?ZWlQbDlVZGhLWW5SSzREaGtEQ0Y1RWV1QXBlS285a21uVk51YStUd0xlK3hP?=
 =?utf-8?B?MXRrNHpsSTRlb2hLcTJPbmU4R011NmVNZkxPQ1lxV2pGcjllY2Y2d1RKckFU?=
 =?utf-8?B?eUZQeU94alRnamVUNlJpZHliZWpQd2h6bkhaeVhKWGNyL1JGckcvb1BBK3Rr?=
 =?utf-8?B?YXBXRDIwWDFYQ2FJN2VEVHdWVXlYYVM2SU02dlA4ZVh5MlpGa2xvTWw2VFlI?=
 =?utf-8?B?M2MyK0V5OGZUL0pidDdaLytIK0ozUjFhYjNzY3d6ckUya2xTWktjbjdNRjFZ?=
 =?utf-8?B?VUsxWkNQNHJ1ZWhZeGV6ZktNenlOekxTazBFK3R0QVFobytGalFPMUVHMVdX?=
 =?utf-8?B?dnQ3ZWRFbjMyRkxlMlRLcldKQXlPeXRLdUtacWR6UldZK3d1ZDZOK1VFOVdi?=
 =?utf-8?B?QjJtdzVYcHlmU0M0L1JVajR0YWlIejFLN0ZWSDZ6dW5VVjRHOWFETFRCUEJP?=
 =?utf-8?B?TkRXMlBEOXkzWVZpUTJPS2N4eW4wTE1KNE5YQ0VLcUFOTlY0WWMxWElyUkJM?=
 =?utf-8?B?Z2dkTDRlZkJJTDREemNwWXZWZlJ6eXRNRTQ3UDI4YmNTWTVBa0s1MWNIQ0dL?=
 =?utf-8?B?WFVFdnFYcUpIVWQxY3BoNlFxazBTdGxIVDhaakVZd0JOZWhvc1RJdmdLQTNy?=
 =?utf-8?B?MXNBZ1U3Y2FYSHRUSjB1M09EYXVtTTFWZFlGVGViWFVCZ2lFWCtDVGg2WElT?=
 =?utf-8?B?N2VSWm9oS2tmVkVhY3pSbzBZOFhSWDI0ZWV6RG01SjFwVnA2VS9yM0pZR3VO?=
 =?utf-8?B?UGJjbjJXZlRxRnUvUERlQ0d1cDhkL3U2ZFAwaUJjR2RmbGVkY0tTM1pyeDh1?=
 =?utf-8?B?T0s0VlJtbnhidldxMFVQbjBlbzhyKzNuLzJWaytNSjBWcXZtODZJcUJtclBU?=
 =?utf-8?B?ME1HQWVNT1FTV3RhemNrV0t6cTU5VEVQZmpoR0JNN0hKVVArRnQxMG5tem0v?=
 =?utf-8?B?Qy9vQkhiSVAvaWlaZEk2Nk4zT0VHR0cyMzRQMUhIeVlQWnZpTWV3NzVZV0hH?=
 =?utf-8?B?N1E3dWl6NTlrbHhRejNyaXRITlZTRE1UalhSSjVQRHhZUnltMXZmeWZyeS92?=
 =?utf-8?B?VXZUZ0pUd05NWnFJcTFZbjJjMmpvTG1zLzI0aGk1eHFkdUIxWUlLQU96VnVR?=
 =?utf-8?B?dmdtNmxDR0pIMW1zb0RLWjVpZGNrYlQvSWRnWFBvc2tOMStaVmQzVnVHYlgw?=
 =?utf-8?B?ZnBrdmcrMU1aQXdMdHRKN3dvN0VHeEVaQzJlY0RCTG5vSFl0bVFYTElvQ011?=
 =?utf-8?B?ZzZjTG9kdGV5UFJoOE1zKzhtUXZEWWFYdnQ4Q2NQRVRLTXZRUXR3eFQ3NWMy?=
 =?utf-8?B?bmgyMEFPbDNrRE1XcFFLcldSUjVkQUhlZEZDd2d3M1pkclBUK2VCK3luOWdy?=
 =?utf-8?B?emc3TUNXU1NTREZjd2hZWi9EanZaM2ZwNHRUUm9xdWltTlZYSTFkZmJ4TjFM?=
 =?utf-8?Q?XT1bjxrbRKFJuF8C1iWEQBNb7t2+QXnu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTR6RkJwZkJBVVNJd3pBTFNnTm9sUG1YM252WWxlTkNNWmJFR0tqTmJRdE51?=
 =?utf-8?B?SDRRYzh1d21oTFBab3pha3NQVk1zVVRHYzU4bnFXeE15RFJ0NFVFTTVFd24v?=
 =?utf-8?B?Ri9wdjAxN3M4bXJiaHlaWEo0NE5XK2RFSjdwMCt3R2tIMDNZYmhGcmJ4R0dj?=
 =?utf-8?B?ZHh1WGN6Z1QxZ2tLU3NWdS82c25pUW56QWxWRkJ4WWlPM2VhN2RmZjB6bDBj?=
 =?utf-8?B?dGthekV3MWQxUE0xTVgvRWV5dE9LVUlyS3lzR1lneFZSZzZqZjNVTVJ4NTBI?=
 =?utf-8?B?SXR5SnNsRCtncGJWTEprMDdlUW9pUDBBWEU0bmx6NVRqbGdDd2M4OWprakpG?=
 =?utf-8?B?enZKajY4cUdRUWd6ZDEyUHdUQnNWaGZpY0pWRGxYbStIVlRKVDBQWFJKOG4v?=
 =?utf-8?B?U1JPbFJBaEJ1aGl0M1J0TFowdnRSb3Z2T1BMMDNOVnVuNFFoWDdLaFFnS3h1?=
 =?utf-8?B?SzhydDBzWVppSDRhbEVEa0xoejVodWlpSlhEZHlja1NIWWdXTkRPYVB6TUtv?=
 =?utf-8?B?Q0pXb1RnSW9QM0ZNWUJxWUFubFdxcTBXZ2V3Z1ZrdjNVZ2x4cVVnMjRsdzR0?=
 =?utf-8?B?RjR0SWpUNUVMQkM4bHNyelBSZzBraFhaM3RtZ0lJWm5LU0svMWlsS25URmp5?=
 =?utf-8?B?RzM5dUppcUFwb0pIOXRZQmpEc3I2K1F1M3NISTFRT1V0S1NiODlNbXJqUE1C?=
 =?utf-8?B?a09sdFQ2RS9BcGkxZ3I4WmpXM3ZJNXNYem5MK25LM2NJZ3hlZmZJN1l1RThx?=
 =?utf-8?B?NnFWSkhscnlsVFZDdSswY2tSU0cyNkczWnMyME5wOXBVTTE1cXczVzRPSkti?=
 =?utf-8?B?TFE1YWF1ZmpwNytTeHRSenhvQisyY05HdGNvTGNpNWxtZXY0cmFHMW5ZZWJl?=
 =?utf-8?B?WWlKcURZWG8ybDJibHVabXo0eVJiYXhTZ2IyS1Y2bDBXK1dNTmNsbkxKS3U5?=
 =?utf-8?B?cTJtRjduZWhYSnd3ck5GcjN0U2phOXl2NmxrdTRROTdLVVNWM2YxNk5IN2dM?=
 =?utf-8?B?U0dod0Ztemk2cFlEWlNDSWFCSDhraXhNSVJXaW1ZWnhqNElPY0lRT2M0N2p5?=
 =?utf-8?B?eDZRUVN2d0pxaXNjRDM3UFM3L3BScmM4N0RZZTl2VEtJNHpuZUlTUExzY0pZ?=
 =?utf-8?B?b2VDeEdpM2pCcll0SEZRQmd5aWtycXNXU2ZPTk9wUjdmNm1MOFRKUkFyREd0?=
 =?utf-8?B?eXhNLzZ6NVY5TVZXMHA4dmRuNkJ0cm1vWW9HTzE3c1pYR0NQT0RNeUI3OG9K?=
 =?utf-8?B?d3ZQdi9Sa0VvQldNeTN5aGNZclYxUXZnWGVJMWNVUlV6QituLzI1b2kxdmY4?=
 =?utf-8?B?Z2tRWmcvUk92ZHFEbzJsaEZ1YkhjaW1aM2gySXlPNGZJRXJmekRaS1B3REI5?=
 =?utf-8?B?K2NwNmhzNjdPZFNRRDQ2dkpWZmExUlBGeGg3MHRkMU9DTkd2Y0YyVXkwcVVX?=
 =?utf-8?B?Nmkyb3ZxdXlGTG90MVZ6SWlPRGN6UFhVdW91UFdja25RNTI3K3dhcDNKdTIx?=
 =?utf-8?B?eTNzbjdudFJaMzBUSjF4c2FSbDNUenRHRjk1L2Y4a0FWZ2hXWWNZT3AzZ2tG?=
 =?utf-8?B?RFNFVWwvWmFtaE0xSVY3OENJSlhpTVMxdU9IVEhSalpuZWtmc3A4VDd2V25l?=
 =?utf-8?B?YUs0OHpuQ21rcFhHb0pJaDVGcWRvS1hGcVkxUi82Y0MveVdRZUdNUDNWWk85?=
 =?utf-8?B?TXlHOXpWa1ptTG1ncDVuSWdLZ2U4NWowSTNUK0hHRjNXTUU3SVNGQTB2RHpO?=
 =?utf-8?B?NVFnUEx3cUgyODRwSXdXNjkwNmNiNDBkN1hXaWpUSEdwR3p5NFQvQlpEQThY?=
 =?utf-8?B?UWFmUFpEU2lETm1FcDVnL3daYzIvV2RrTURHdjMrcmhrZjY2TXdoVzN2eUQy?=
 =?utf-8?B?M2Fwd1FtZUw4Y1UraEorclVXcVFhRFR2VkZlK1Iyc1VId3NwWjVEYmYyMDhw?=
 =?utf-8?B?ZkJUNTVCeGRwbUQxREZDcXhDTEV4OXpBamJPZ1l3endWaFNpdk95WTZ5Q1VR?=
 =?utf-8?B?RFRrK1prOFU5ZlhQMjhpbnplQXAvVDhvTjZicmlhT0h5VXlsamU3K2RNZnNz?=
 =?utf-8?B?a05sNlJnS0pFdWY0UE9ablFzcUZkaFZteHNUT0dzV01qR2I1cVdMbUZlaDJ6?=
 =?utf-8?B?aTlCdTBWOUF5Ykc4MTZkQXR3NlRxekdzWVhNZWtTVlZCMWtreVJBZEQyRlh3?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 793b715c-4eed-4a16-cb13-08de3975cdd8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 11:58:46.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3te0rUjSpaujf8uTNmEtnvzZgT8v2DEUcgIyogWAazGfa6np0frFYFxoRCoMtXhRo+zu2jbAcBys31aIIbjxUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com

On 11/12/2025 09:56, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> On IMX7ULP platforms, certain SD cards (e.g. Kingston Canvas Go! Plus)
> cause system hangs and reboots during manual tuning. These cards exhibit
> large gaps (~16us) between tuning command response and data transmission.
> When cmd CRC errors occur during tuning, the code assumes data errors even
> tuning data hasn't been fully received and then reset host data circuit.
> 
> Per IMX7ULP reference manual, reset operations (RESET_DATA/ALL) need to
> make sure no active data transfers. Previously, resetting while data was
> in-flight would clear data circuit, including ADMA/SDMA address, causing
> data to be transmitted to incorrect memory address. This patch adds
> polling for data transfer completion before executing resets.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> Reviewed-by: Bough Chen <haibo.chen@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v3: add define for timeout value
> v2: amend commit message
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index a7a5df673b0f..97461e20425d 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -216,6 +216,8 @@
>  #define ESDHC_FLAG_DUMMY_PAD		BIT(19)
>  
>  #define ESDHC_AUTO_TUNING_WINDOW	3
> +/* 100ms timeout for data inhibit */
> +#define ESDHC_DATA_INHIBIT_WAIT_US	100000
>  
>  enum wp_types {
>  	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
> @@ -1453,6 +1455,22 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>  
>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>  {
> +	u32 present_state;
> +	int ret;
> +
> +	/*
> +	 * For data or full reset, ensure any active data transfer completes
> +	 * before resetting to avoid system hang.
> +	 */
> +	if (mask & (SDHCI_RESET_DATA | SDHCI_RESET_ALL)) {
> +		ret = readl_poll_timeout_atomic(host->ioaddr + ESDHC_PRSSTAT, present_state,
> +						!(present_state & SDHCI_DATA_INHIBIT), 2,
> +						ESDHC_DATA_INHIBIT_WAIT_US);
> +		if (ret == -ETIMEDOUT)
> +			dev_warn(mmc_dev(host->mmc),
> +				 "timeout waiting for data transfer completion\n");
> +	}
> +
>  	sdhci_and_cqhci_reset(host, mask);
>  
>  	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);

